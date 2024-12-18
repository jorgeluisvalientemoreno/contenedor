BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_PROCESS_100559_',
'CREATE OR REPLACE PACKAGE EXP_PROCESS_100559_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyWF_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPERowId tyWF_UNIT_TYPERowId;type tyWF_UNIT_CATEGORYRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_CATEGORYRowId tyWF_UNIT_CATEGORYRowId;type tyWF_ATTRIBUTES_EQUIVRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_ATTRIBUTES_EQUIVRowId tyWF_ATTRIBUTES_EQUIVRowId;type tyGE_COMMENT_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_COMMENT_CLASSRowId tyGE_COMMENT_CLASSRowId;type tyGR_CONFIGURA_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIGURA_TYPERowId tyGR_CONFIGURA_TYPERowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type tyGE_ATTRIBUTE_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTE_CLASSRowId tyGE_ATTRIBUTE_CLASSRowId;type tyGE_ATTRIBUTES_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTES_TYPERowId tyGE_ATTRIBUTES_TYPERowId;type tyGE_ATTRIBUTESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTESRowId tyGE_ATTRIBUTESRowId;type tyGE_STATEMENTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_STATEMENTRowId tyGE_STATEMENTRowId;type tyWF_UNIT_ATTRIBUTERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_ATTRIBUTERowId tyWF_UNIT_ATTRIBUTERowId;type tyGE_MODULERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_MODULERowId tyGE_MODULERowId;type tyWF_NODE_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_NODE_TYPERowId tyWF_NODE_TYPERowId;type tyWF_UNITRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNITRowId tyWF_UNITRowId;type tyWF_UNIT_DATA_MAPRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_DATA_MAPRowId tyWF_UNIT_DATA_MAPRowId;type tyWF_TRANSITIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_TRANSITIONRowId tyWF_TRANSITIONRowId;type ty0_0 is table of WF_UNIT_CATEGORY.CATEGORY_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty1_0 is table of GE_MODULE.MODULE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_0 ty1_0; ' || chr(10) ||
'tb1_0 ty1_0;type ty2_0 is table of WF_UNIT_TYPE.UNIT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;type ty2_1 is table of WF_UNIT_TYPE.CATEGORY_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_1 ty2_1; ' || chr(10) ||
'tb2_1 ty2_1;type ty2_2 is table of WF_UNIT_TYPE.MODULE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_2 ty2_2; ' || chr(10) ||
'tb2_2 ty2_2;type ty2_5 is table of WF_UNIT_TYPE.INIT_AREA_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_5 ty2_5; ' || chr(10) ||
'tb2_5 ty2_5;type ty2_6 is table of WF_UNIT_TYPE.ASSIGN_COMMENT_CLASS%type index by binary_integer; ' || chr(10) ||
'old_tb2_6 ty2_6; ' || chr(10) ||
'tb2_6 ty2_6;type ty2_7 is table of WF_UNIT_TYPE.ATTEND_COMMENT_CLASS%type index by binary_integer; ' || chr(10) ||
'old_tb2_7 ty2_7; ' || chr(10) ||
'tb2_7 ty2_7;type ty2_8 is table of WF_UNIT_TYPE.UNASSIGN_COMMENT_CLASS%type index by binary_integer; ' || chr(10) ||
'old_tb2_8 ty2_8; ' || chr(10) ||
'tb2_8 ty2_8;type ty3_0 is table of WF_ATTRIBUTES_EQUIV.ATTRIBUTES_EQUIV_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_0 ty3_0; ' || chr(10) ||
'tb3_0 ty3_0;type ty3_1 is table of WF_ATTRIBUTES_EQUIV.UNIT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_1 ty3_1; ' || chr(10) ||
'tb3_1 ty3_1;type ty4_0 is table of WF_NODE_TYPE.NODE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_0 ty4_0; ' || chr(10) ||
'tb4_0 ty4_0;type ty5_0 is table of WF_UNIT.UNIT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_0 ty5_0; ' || chr(10) ||
'tb5_0 ty5_0;type ty5_1 is table of WF_UNIT.PROCESS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_1 ty5_1; ' || chr(10) ||
'tb5_1 ty5_1;type ty5_2 is table of WF_UNIT.UNIT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_2 ty5_2; ' || chr(10) ||
'tb5_2 ty5_2;type ty5_3 is table of WF_UNIT.NODE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_3 ty5_3; ' || chr(10) ||
'tb5_3 ty5_3;type ty5_4 is table of WF_UNIT.MODULE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_4 ty5_4; ' || chr(10) ||
'tb5_4 ty5_4;type ty5_6 is table of WF_UNIT.PRE_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_6 ty5_6; ' || chr(10) ||
'tb5_6 ty5_6;type ty5_7 is table of WF_UNIT.POS_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_7 ty5_7; ' || chr(10) ||
'tb5_7 ty5_7;type ty6_0 is table of GR_CONFIGURA_TYPE.CONFIGURA_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_0 ty6_0; ' || chr(10) ||
'tb6_0 ty6_0;type ty7_0 is table of GR_CONFIG_EXPRESSION.CONFIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_0 ty7_0; ' || chr(10) ||
'tb7_0 ty7_0;type ty7_1 is table of GR_CONFIG_EXPRESSION.OBJECT_NAME%type index by binary_integer; ' || chr(10) ||
'old_tb7_1 ty7_1; ' || chr(10) ||
'tb7_1 ty7_1;type ty7_2 is table of GR_CONFIG_EXPRESSION.CONFIGURA_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_2 ty7_2; ' || chr(10) ||
'tb7_2 ty7_2;type ty8_0 is table of WF_TRANSITION.TRANS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_0 ty8_0; ' || chr(10) ||
'tb8_0 ty8_0;type ty8_1 is table of WF_TRANSITION.ORIGIN_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_1 ty8_1; ' || chr(10) ||
'tb8_1 ty8_1;type ty8_2 is table of WF_TRANSITION.TARGET_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_2 ty8_2; ' || chr(10) ||
'tb8_2 ty8_2;type ty9_0 is table of GE_ATTRIBUTE_CLASS.ATTRIBUTE_CLASS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb9_0 ty9_0; ' || chr(10) ||
'tb9_0 ty9_0;type ty10_0 is table of GE_ATTRIBUTES_TYPE.ATTRIBUTE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb10_0 ty10_0; ' || chr(10) ||
'tb10_0 ty10_0;type ty11_0 is table of GE_ATTRIBUTES.ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb11_0 ty11_0; ' || chr(10) ||
'tb11_0 ty11_0;type ty11_1 is table of GE_ATTRIBUTES.ATTRIBUTE_CLASS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb11_1 ty11_1; ' || chr(10) ||
'tb11_1 ty11_1;type ty11_2 is table of GE_ATTRIBUTES.ATTRIBUTE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb11_2 ty11_2; ' || chr(10) ||
'tb11_2 ty11_2;type ty12_0 is table of WF_UNIT_ATTRIBUTE.UNIT_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb12_0 ty12_0; ' || chr(10) ||
'tb12_0 ty12_0;type ty12_1 is table of WF_UNIT_ATTRIBUTE.UNIT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb12_1 ty12_1; ' || chr(10) ||
'tb12_1 ty12_1;type ty12_2 is table of WF_UNIT_ATTRIBUTE.ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb12_2 ty12_2; ' || chr(10) ||
'tb12_2 ty12_2;type ty12_3 is table of WF_UNIT_ATTRIBUTE.STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb12_3 ty12_3; ' || chr(10) ||
'tb12_3 ty12_3;type ty13_0 is table of GE_STATEMENT.STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb13_0 ty13_0; ' || chr(10) ||
'tb13_0 ty13_0; ' || chr(10) ||
'CURSOR cuExpression is ' || chr(10) ||
'SELECT PRE_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_TYPE_ID = 100559 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID IN  ' || chr(10) ||
'           (SELECT UNIT_ID ' || chr(10) ||
'           FROM WF_UNIT ' || chr(10) ||
'           WHERE UNIT_TYPE_ID = 100559 ' || chr(10) ||
'       )) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_TYPE_ID = 100559 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID IN  ' || chr(10) ||
'           (SELECT UNIT_ID ' || chr(10) ||
'           FROM WF_UNIT ' || chr(10) ||
'           WHERE UNIT_TYPE_ID = 100559 ' || chr(10) ||
'       )) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_PROCESS_100559_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_PROCESS_100559_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open EXP_PROCESS_100559_.cuExpression;
   fetch EXP_PROCESS_100559_.cuExpression bulk collect INTO EXP_PROCESS_100559_.tbGR_CONFIG_EXPRESSIONId;
   close EXP_PROCESS_100559_.cuExpression;
END;
/ 
BEGIN
ut_trace.trace('Actualizar o Insertar Tabla WF_UNIT_TYPE (Carpeta)',1);
    UPDATE wf_unit_type
    SET
       description = 'Flujos Gen¿ricos por Producto', display = 'Flujos Gen¿ricos de Producto', parent_id = 2277, category_id = 0, icon = '', tag_name = 'UNIT_TYPE2277', is_stage_process = 'N', usable_in_flow_stage = 'N', entity_id = null, multi_instance = 'R', module_id = 9, is_countable = 'N', notification_id = null, viewable = 'N', action_id = null, default_priority_id = null, init_area_expression_id = null, initial_notify_time = null, is_admin_process = 'N', assign_comment_class = null, attend_comment_class = null
    WHERE 
      unit_type_id = 2277;
 if not (sql%found) then 
    INSERT INTO wf_unit_type
    ( unit_type_id, description, display, parent_id, category_id, icon, tag_name, is_stage_process, usable_in_flow_stage, entity_id, multi_instance, module_id, is_countable, notification_id, viewable, action_id, default_priority_id, init_area_expression_id, initial_notify_time, is_admin_process, assign_comment_class, attend_comment_class )
    VALUES
    (2277, 'Flujos Gen¿ricos por Producto', 'Flujos Gen¿ricos de Producto', 2277, 0, '', 'UNIT_TYPE2277', 'N', 'N', null, 'R', 9, 'N', null, 'N', null, null, null, null, 'N', null, null); 
end if;
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('DEL_ROOT_102697_',
'CREATE OR REPLACE PACKAGE DEL_ROOT_102697_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyWF_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPERowId tyWF_UNIT_TYPERowId;type tyWF_UNIT_CATEGORYRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_CATEGORYRowId tyWF_UNIT_CATEGORYRowId;type tyWF_ATTRIBUTES_EQUIVRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_ATTRIBUTES_EQUIVRowId tyWF_ATTRIBUTES_EQUIVRowId;type tyGE_COMMENT_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_COMMENT_CLASSRowId tyGE_COMMENT_CLASSRowId;type tyGR_CONFIGURA_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIGURA_TYPERowId tyGR_CONFIGURA_TYPERowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type tyGE_ATTRIBUTE_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTE_CLASSRowId tyGE_ATTRIBUTE_CLASSRowId;type tyGE_ATTRIBUTES_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTES_TYPERowId tyGE_ATTRIBUTES_TYPERowId;type tyGE_ATTRIBUTESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTESRowId tyGE_ATTRIBUTESRowId;type tyGE_STATEMENTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_STATEMENTRowId tyGE_STATEMENTRowId;type tyWF_UNIT_ATTRIBUTERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_ATTRIBUTERowId tyWF_UNIT_ATTRIBUTERowId;type tyGE_MODULERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_MODULERowId tyGE_MODULERowId;type tyWF_NODE_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_NODE_TYPERowId tyWF_NODE_TYPERowId;type tyWF_UNITRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNITRowId tyWF_UNITRowId;type tyWF_UNIT_DATA_MAPRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_DATA_MAPRowId tyWF_UNIT_DATA_MAPRowId;type tyWF_TRANSITIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_TRANSITIONRowId tyWF_TRANSITIONRowId;type ty0_0 is table of GR_CONFIG_EXPRESSION.CONFIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_1 is table of GR_CONFIG_EXPRESSION.OBJECT_NAME%type index by binary_integer; ' || chr(10) ||
'old_tb0_1 ty0_1; ' || chr(10) ||
'tb0_1 ty0_1;type ty1_0 is table of WF_UNIT.UNIT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_0 ty1_0; ' || chr(10) ||
'tb1_0 ty1_0;type ty1_6 is table of WF_UNIT.PRE_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_6 ty1_6; ' || chr(10) ||
'tb1_6 ty1_6;type ty1_7 is table of WF_UNIT.POS_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_7 ty1_7; ' || chr(10) ||
'tb1_7 ty1_7;type ty2_0 is table of WF_TRANSITION.TRANS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;type ty2_1 is table of WF_TRANSITION.ORIGIN_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_1 ty2_1; ' || chr(10) ||
'tb2_1 ty2_1;type ty2_2 is table of WF_TRANSITION.TARGET_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_2 ty2_2; ' || chr(10) ||
'tb2_2 ty2_2;type ty3_0 is table of WF_UNIT_ATTRIBUTE.UNIT_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_0 ty3_0; ' || chr(10) ||
'tb3_0 ty3_0;type ty3_1 is table of WF_UNIT_ATTRIBUTE.UNIT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_1 ty3_1; ' || chr(10) ||
'tb3_1 ty3_1; ' || chr(10) ||
'CURSOR cuExpression is ' || chr(10) ||
'SELECT PRE_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_ID = 102697 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 102697  ' || chr(10) ||
'       ) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_ID = 102697 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 102697  ' || chr(10) ||
'       ) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END DEL_ROOT_102697_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:DEL_ROOT_102697_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open DEL_ROOT_102697_.cuExpression;
   fetch DEL_ROOT_102697_.cuExpression bulk collect INTO DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONId;
   close DEL_ROOT_102697_.cuExpression;
END;
/ 

DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  SELECT  B.object_name
FROM    WF_UNIT A, GR_CONFIG_EXPRESSION B
WHERE   (A.PRE_EXPRESSION_ID = b.CONFIG_EXPRESSION_ID
OR   A.POS_EXPRESSION_ID = b.CONFIG_EXPRESSION_ID)
AND     A.UNIT_ID IN (
        SELECT UNIT_ID         FROM WF_UNIT 
        WHERE UNIT_ID = 102697
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID = 102697 
       )
;
BEGIN

if (not DEL_ROOT_102697_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  DEL_ROOT_102697_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
  nuIndex := nuIndex + 1;
 END LOOP;
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
END;
/

DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE PROCESS_ID = 102697);
BEGIN 

if (not DEL_ROOT_102697_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102697_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE PROCESS_ID = 102697);
BEGIN 

if (not DEL_ROOT_102697_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102697_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 102697)));
BEGIN 

if (not DEL_ROOT_102697_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102697_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 102697)));
BEGIN 

if (not DEL_ROOT_102697_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102697_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 102697));
BEGIN 

if (not DEL_ROOT_102697_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla WF_UNIT',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102697_.tbWF_UNITRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102697_.blProcessStatus := false;
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
FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 102697);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102697_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_TRANSITION',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_TRANSITION WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
DEL_ROOT_102697_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102697_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102697_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102697_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102697_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102697_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria WF_UNIT',1);
nuVarcharIndex:=DEL_ROOT_102697_.tbWF_UNITRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from WF_UNIT where rowid = DEL_ROOT_102697_.tbWF_UNITRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102697_.tbWF_UNITRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102697_.tbWF_UNITRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102697_.blProcessStatus := false;
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
FROM WF_UNIT_DATA_MAP WHERE (SOURCE_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 102697));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102697_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_DATA_MAP',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_DATA_MAP WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
DEL_ROOT_102697_.blProcessStatus := false;
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
FROM WF_UNIT_DATA_MAP WHERE (TARGET_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 102697));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102697_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_DATA_MAP',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_DATA_MAP WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
DEL_ROOT_102697_.blProcessStatus := false;
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
FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 102697);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102697_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_ATTRIBUTE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_ATTRIBUTE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
DEL_ROOT_102697_.blProcessStatus := false;
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
FROM WF_UNIT WHERE PROCESS_ID = 102697;
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102697_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
DEL_ROOT_102697_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102697_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102697_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102697_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102697_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/

BEGIN
    ut_trace.trace('Actualizar WF_UNIT a ProcessId NULL ',1);
   UPDATE WF_UNIT 
     SET PROCESS_ID = -1, POS_EXPRESSION_ID = null, PRE_EXPRESSION_ID = null, ACTION_ID = null 
     WHERE PROCESS_ID = 102697;
   exception
         when others then 
            rollback;
            ut_trace.trace('**ERROR:'||sqlerrm,1);
            raise;
END;
  
/

DECLARE 
    nuBinaryIndex Binary_Integer;
BEGIN 
    nuBinaryIndex := DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       DEL_ROOT_102697_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100559',1);
EXP_PROCESS_100559_.blProcessStatus := DEL_ROOT_102697_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
COMMIT
/

DECLARE
PRAGMA AUTONOMOUS_TRANSACTION;
nuRowProcess number;
BEGIN 

if (not DEL_ROOT_102697_.blProcessStatus) then
 return;
end if;
nuRowProcess:=DEL_ROOT_102697_.tb0_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| DEL_ROOT_102697_.tb0_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(DEL_ROOT_102697_.tb0_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| DEL_ROOT_102697_.tb0_0(nuRowProcess),1);
end;
nuRowProcess := DEL_ROOT_102697_.tb0_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
DEL_ROOT_102697_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

DECLARE
 nuIndex         binary_integer;
 blObjectDeleted boolean;

 FUNCTION fblIsObjectUseByRule
 (
  isbObjectName   IN gr_config_expression.object_name%type
 ) return BOOLEAN
 IS
  nuCounter    NUMBER := 0;
  blReturn     BOOLEAN := FALSE;
 BEGIN
  SELECT count('x') INTO nuCounter
  FROM gr_config_expression
  WHERE object_name = isbObjectName;
  IF (nuCounter > 0) THEN
    BEGIN
      DELETE FROM gr_config_expression
      WHERE object_name = isbObjectName;
      blReturn := FALSE;
    EXCEPTION
      when ex.RECORD_HAVE_CHILDREN then
         ut_trace.trace('Objeto ' || isbObjectName || ' usado en ' || nuCounter ||' reglas, no se borra',2);
         blReturn := TRUE;
    END;
  END IF;
  RETURN blReturn;
 END;

BEGIN
 ut_trace.trace('Inicia borrado de objetos de reglas',1);
 nuIndex := DEL_ROOT_102697_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || DEL_ROOT_102697_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(DEL_ROOT_102697_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(DEL_ROOT_102697_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(DEL_ROOT_102697_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || DEL_ROOT_102697_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || DEL_ROOT_102697_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := DEL_ROOT_102697_.tbObjectToDelete.next(nuIndex);
 END loop;
 ut_trace.trace('Finaliza borrado de objetos de reglas',1);
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
END;
/


begin
SA_BOCreatePackages.DropPackage('DEL_ROOT_102697_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:DEL_ROOT_102697_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('DEL_ROOT_102697_',
'CREATE OR REPLACE PACKAGE DEL_ROOT_102697_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyWF_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPERowId tyWF_UNIT_TYPERowId;type tyWF_UNIT_CATEGORYRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_CATEGORYRowId tyWF_UNIT_CATEGORYRowId;type tyWF_ATTRIBUTES_EQUIVRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_ATTRIBUTES_EQUIVRowId tyWF_ATTRIBUTES_EQUIVRowId;type tyGE_COMMENT_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_COMMENT_CLASSRowId tyGE_COMMENT_CLASSRowId;type tyGR_CONFIGURA_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIGURA_TYPERowId tyGR_CONFIGURA_TYPERowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type tyGE_ATTRIBUTE_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTE_CLASSRowId tyGE_ATTRIBUTE_CLASSRowId;type tyGE_ATTRIBUTES_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTES_TYPERowId tyGE_ATTRIBUTES_TYPERowId;type tyGE_ATTRIBUTESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTESRowId tyGE_ATTRIBUTESRowId;type tyGE_STATEMENTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_STATEMENTRowId tyGE_STATEMENTRowId;type tyWF_UNIT_ATTRIBUTERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_ATTRIBUTERowId tyWF_UNIT_ATTRIBUTERowId;type tyGE_MODULERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_MODULERowId tyGE_MODULERowId;type tyWF_NODE_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_NODE_TYPERowId tyWF_NODE_TYPERowId;type tyWF_UNITRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNITRowId tyWF_UNITRowId;type tyWF_UNIT_DATA_MAPRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_DATA_MAPRowId tyWF_UNIT_DATA_MAPRowId;type tyWF_TRANSITIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_TRANSITIONRowId tyWF_TRANSITIONRowId;type ty0_0 is table of WF_UNIT.UNIT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_6 is table of WF_UNIT.PRE_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_6 ty0_6; ' || chr(10) ||
'tb0_6 ty0_6;type ty0_7 is table of WF_UNIT.POS_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_7 ty0_7; ' || chr(10) ||
'tb0_7 ty0_7;type ty1_0 is table of WF_UNIT_ATTRIBUTE.UNIT_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_0 ty1_0; ' || chr(10) ||
'tb1_0 ty1_0;type ty1_1 is table of WF_UNIT_ATTRIBUTE.UNIT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_1 ty1_1; ' || chr(10) ||
'tb1_1 ty1_1; ' || chr(10) ||
'CURSOR cuExpression is ' || chr(10) ||
'SELECT PRE_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_ID = 102697 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 102697  ' || chr(10) ||
'       ) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_ID = 102697 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 102697  ' || chr(10) ||
'       ) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END DEL_ROOT_102697_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:DEL_ROOT_102697_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open DEL_ROOT_102697_.cuExpression;
   fetch DEL_ROOT_102697_.cuExpression bulk collect INTO DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONId;
   close DEL_ROOT_102697_.cuExpression;
END;
/ 

DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  SELECT  B.object_name
FROM    WF_UNIT A, GR_CONFIG_EXPRESSION B
WHERE   (A.PRE_EXPRESSION_ID = b.CONFIG_EXPRESSION_ID
OR   A.POS_EXPRESSION_ID = b.CONFIG_EXPRESSION_ID)
AND     A.UNIT_ID IN (
        SELECT UNIT_ID         FROM WF_UNIT 
        WHERE UNIT_ID = 102697
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID = 102697 
       )
;
BEGIN

if (not DEL_ROOT_102697_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  DEL_ROOT_102697_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
  nuIndex := nuIndex + 1;
 END LOOP;
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
END;
/

DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE UNIT_ID = 102697);
BEGIN 

if (not DEL_ROOT_102697_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102697_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE UNIT_ID = 102697);
BEGIN 

if (not DEL_ROOT_102697_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102697_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 102697)));
BEGIN 

if (not DEL_ROOT_102697_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102697_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 102697)));
BEGIN 

if (not DEL_ROOT_102697_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102697_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 102697));
BEGIN 

if (not DEL_ROOT_102697_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla WF_UNIT',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102697_.tbWF_UNITRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102697_.blProcessStatus := false;
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
FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 102697);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102697_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_TRANSITION',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_TRANSITION WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
DEL_ROOT_102697_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102697_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102697_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102697_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102697_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102697_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria WF_UNIT',1);
nuVarcharIndex:=DEL_ROOT_102697_.tbWF_UNITRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from WF_UNIT where rowid = DEL_ROOT_102697_.tbWF_UNITRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102697_.tbWF_UNITRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102697_.tbWF_UNITRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102697_.blProcessStatus := false;
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
FROM WF_UNIT_DATA_MAP WHERE (SOURCE_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 102697));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102697_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_DATA_MAP',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_DATA_MAP WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
DEL_ROOT_102697_.blProcessStatus := false;
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
FROM WF_UNIT_DATA_MAP WHERE (TARGET_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 102697));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102697_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_DATA_MAP',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_DATA_MAP WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
DEL_ROOT_102697_.blProcessStatus := false;
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
FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 102697);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102697_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_ATTRIBUTE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_ATTRIBUTE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
DEL_ROOT_102697_.blProcessStatus := false;
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
FROM WF_UNIT WHERE UNIT_ID = 102697;
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102697_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
DEL_ROOT_102697_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102697_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102697_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102697_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102697_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/

BEGIN
    ut_trace.trace('Actualizar WF_UNIT a ProcessId NULL ',1);
   UPDATE WF_UNIT 
     SET PROCESS_ID = -1, POS_EXPRESSION_ID = null, PRE_EXPRESSION_ID = null, ACTION_ID = null 
     WHERE PROCESS_ID = 102697;
   exception
         when others then 
            rollback;
            ut_trace.trace('**ERROR:'||sqlerrm,1);
            raise;
END;
  
/

DECLARE 
    nuBinaryIndex Binary_Integer;
BEGIN 
    nuBinaryIndex := DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := DEL_ROOT_102697_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       DEL_ROOT_102697_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100559',1);
EXP_PROCESS_100559_.blProcessStatus := DEL_ROOT_102697_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/

DECLARE
 nuIndex         binary_integer;
 blObjectDeleted boolean;

 FUNCTION fblIsObjectUseByRule
 (
  isbObjectName   IN gr_config_expression.object_name%type
 ) return BOOLEAN
 IS
  nuCounter    NUMBER := 0;
  blReturn     BOOLEAN := FALSE;
 BEGIN
  SELECT count('x') INTO nuCounter
  FROM gr_config_expression
  WHERE object_name = isbObjectName;
  IF (nuCounter > 0) THEN
    BEGIN
      DELETE FROM gr_config_expression
      WHERE object_name = isbObjectName;
      blReturn := FALSE;
    EXCEPTION
      when ex.RECORD_HAVE_CHILDREN then
         ut_trace.trace('Objeto ' || isbObjectName || ' usado en ' || nuCounter ||' reglas, no se borra',2);
         blReturn := TRUE;
    END;
  END IF;
  RETURN blReturn;
 END;

BEGIN
 ut_trace.trace('Inicia borrado de objetos de reglas',1);
 nuIndex := DEL_ROOT_102697_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || DEL_ROOT_102697_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(DEL_ROOT_102697_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(DEL_ROOT_102697_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(DEL_ROOT_102697_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || DEL_ROOT_102697_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || DEL_ROOT_102697_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := DEL_ROOT_102697_.tbObjectToDelete.next(nuIndex);
 END loop;
 ut_trace.trace('Finaliza borrado de objetos de reglas',1);
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('DEL_ROOT_102697_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:DEL_ROOT_102697_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_ACTION_100_',
'CREATE OR REPLACE PACKAGE EXP_ACTION_100_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyGR_CONFIGURA_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIGURA_TYPERowId tyGR_CONFIGURA_TYPERowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type tyGE_ACTION_MODULERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ACTION_MODULERowId tyGE_ACTION_MODULERowId;type tyGE_VALID_ACTION_MODURowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_VALID_ACTION_MODURowId tyGE_VALID_ACTION_MODURowId;type ty0_0 is table of GE_ACTION_MODULE.ACTION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_2 is table of GE_ACTION_MODULE.CONFIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_2 ty0_2; ' || chr(10) ||
'tb0_2 ty0_2; ' || chr(10) ||
'CURSOR cuExpression is ' || chr(10) ||
'SELECT CONFIG_EXPRESSION_ID ' || chr(10) ||
'FROM   GE_ACTION_MODULE ' || chr(10) ||
'WHERE  ACTION_ID =100; ' || chr(10) ||
'type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_ACTION_100_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_ACTION_100_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open EXP_ACTION_100_.cuExpression;
   fetch EXP_ACTION_100_.cuExpression bulk collect INTO EXP_ACTION_100_.tbGR_CONFIG_EXPRESSIONId;
   close EXP_ACTION_100_.cuExpression;
END;
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_ACTION_100',1);
EXP_ACTION_100_.blProcessStatus := EXP_PROCESS_100559_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  SELECT  B.object_name
FROM    GE_ACTION_MODULE A, GR_CONFIG_EXPRESSION B
WHERE   A.CONFIG_EXPRESSION_ID = b.CONFIG_EXPRESSION_ID
AND     A.ACTION_ID =100
;
BEGIN

if (not EXP_ACTION_100_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_ACTION_100_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
  nuIndex := nuIndex + 1;
 END LOOP;
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
END;
/

DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE ACTION_ID=100);
BEGIN 

if (not EXP_ACTION_100_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_ACTION_100_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_ACTION_100_.blProcessStatus := false;
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
FROM GE_ACTION_MODULE WHERE ACTION_ID=100;
nuIndex binary_integer;
BEGIN

if (not EXP_ACTION_100_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_ACTION_MODULE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM GE_ACTION_MODULE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_ACTION_100_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_ACTION_100_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_ACTION_100_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_ACTION_100_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_ACTION_100_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_ACTION_100_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_ACTION_100_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_ACTION_100_.blProcessStatus) then
 return;
end if;

EXP_ACTION_100_.tb0_0(0):=100;
ut_trace.trace('Actualizar o insertar tabla: GE_ACTION_MODULE fila (0)',1);
UPDATE GE_ACTION_MODULE SET ACTION_ID=EXP_ACTION_100_.tb0_0(0),
MODULE_ID=4,
CONFIG_EXPRESSION_ID=null,
DESCRIPTION='Registro de Orden '
,
EXE_AT_STATUS_CHANGE='N'
,
EXE_TRANSITION_STATE='N'

 WHERE ACTION_ID = EXP_ACTION_100_.tb0_0(0);
if not (sql%found) then
INSERT INTO GE_ACTION_MODULE(ACTION_ID,MODULE_ID,CONFIG_EXPRESSION_ID,DESCRIPTION,EXE_AT_STATUS_CHANGE,EXE_TRANSITION_STATE) 
VALUES (EXP_ACTION_100_.tb0_0(0),
4,
null,
'Registro de Orden '
,
'N'
,
'N'
);
end if;

exception when others then
EXP_ACTION_100_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
DECLARE 
    nuBinaryIndex Binary_Integer;
BEGIN 
    nuBinaryIndex := EXP_ACTION_100_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = EXP_ACTION_100_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||EXP_ACTION_100_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||EXP_ACTION_100_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := EXP_ACTION_100_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       EXP_ACTION_100_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100559',1);
EXP_PROCESS_100559_.blProcessStatus := EXP_ACTION_100_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/

DECLARE
 nuIndex         binary_integer;
 blObjectDeleted boolean;

 FUNCTION fblIsObjectUseByRule
 (
  isbObjectName   IN gr_config_expression.object_name%type
 ) return BOOLEAN
 IS
  nuCounter    NUMBER := 0;
  blReturn     BOOLEAN := FALSE;
 BEGIN
  SELECT count('x') INTO nuCounter
  FROM gr_config_expression
  WHERE object_name = isbObjectName;
  IF (nuCounter > 0) THEN
    BEGIN
      DELETE FROM gr_config_expression
      WHERE object_name = isbObjectName;
      blReturn := FALSE;
    EXCEPTION
      when ex.RECORD_HAVE_CHILDREN then
         ut_trace.trace('Objeto ' || isbObjectName || ' usado en ' || nuCounter ||' reglas, no se borra',2);
         blReturn := TRUE;
    END;
  END IF;
  RETURN blReturn;
 END;

BEGIN
 ut_trace.trace('Inicia borrado de objetos de reglas',1);
 nuIndex := EXP_ACTION_100_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_ACTION_100_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_ACTION_100_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_ACTION_100_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_ACTION_100_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_ACTION_100_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_ACTION_100_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_ACTION_100_.tbObjectToDelete.next(nuIndex);
 END loop;
 ut_trace.trace('Finaliza borrado de objetos de reglas',1);
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('EXP_ACTION_100_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_ACTION_100_******************************'); end;
/

BEGIN
ut_trace.trace('Actualizar o Insertar Tabla WF_UNIT_TYPE (Carpeta)',1);
    UPDATE wf_unit_type
    SET
       description = ' Actividades y Procesos Comunes', display = ' Actividades y Procesos Comunes', parent_id = 983, category_id = 0, icon = '', tag_name = 'UNIT_TYPE_983', is_stage_process = '', usable_in_flow_stage = '', entity_id = null, multi_instance = '', module_id = 9, is_countable = '', notification_id = null, viewable = '', action_id = null, default_priority_id = null, init_area_expression_id = null, initial_notify_time = null, is_admin_process = 'N', assign_comment_class = null, attend_comment_class = null
    WHERE 
      unit_type_id = 983;
 if not (sql%found) then 
    INSERT INTO wf_unit_type
    ( unit_type_id, description, display, parent_id, category_id, icon, tag_name, is_stage_process, usable_in_flow_stage, entity_id, multi_instance, module_id, is_countable, notification_id, viewable, action_id, default_priority_id, init_area_expression_id, initial_notify_time, is_admin_process, assign_comment_class, attend_comment_class )
    VALUES
    (983, ' Actividades y Procesos Comunes', ' Actividades y Procesos Comunes', 983, 0, '', 'UNIT_TYPE_983', '', '', null, '', 9, '', null, '', null, null, null, null, 'N', null, null); 
end if;
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_ACTION_8237_',
'CREATE OR REPLACE PACKAGE EXP_ACTION_8237_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyGR_CONFIGURA_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIGURA_TYPERowId tyGR_CONFIGURA_TYPERowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type tyGE_ACTION_MODULERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ACTION_MODULERowId tyGE_ACTION_MODULERowId;type tyGE_VALID_ACTION_MODURowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_VALID_ACTION_MODURowId tyGE_VALID_ACTION_MODURowId;type ty0_0 is table of GR_CONFIGURA_TYPE.CONFIGURA_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty1_0 is table of GR_CONFIG_EXPRESSION.CONFIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_0 ty1_0; ' || chr(10) ||
'tb1_0 ty1_0;type ty1_1 is table of GR_CONFIG_EXPRESSION.OBJECT_NAME%type index by binary_integer; ' || chr(10) ||
'old_tb1_1 ty1_1; ' || chr(10) ||
'tb1_1 ty1_1;type ty1_2 is table of GR_CONFIG_EXPRESSION.CONFIGURA_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_2 ty1_2; ' || chr(10) ||
'tb1_2 ty1_2;type ty2_0 is table of GE_ACTION_MODULE.ACTION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;type ty2_2 is table of GE_ACTION_MODULE.CONFIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_2 ty2_2; ' || chr(10) ||
'tb2_2 ty2_2;type ty3_0 is table of GE_VALID_ACTION_MODU.ACTION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_0 ty3_0; ' || chr(10) ||
'tb3_0 ty3_0;type ty3_1 is table of GE_VALID_ACTION_MODU.VALID_MODULE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_1 ty3_1; ' || chr(10) ||
'tb3_1 ty3_1; ' || chr(10) ||
'CURSOR cuExpression is ' || chr(10) ||
'SELECT CONFIG_EXPRESSION_ID ' || chr(10) ||
'FROM   GE_ACTION_MODULE ' || chr(10) ||
'WHERE  ACTION_ID =8237; ' || chr(10) ||
'type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_ACTION_8237_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_ACTION_8237_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open EXP_ACTION_8237_.cuExpression;
   fetch EXP_ACTION_8237_.cuExpression bulk collect INTO EXP_ACTION_8237_.tbGR_CONFIG_EXPRESSIONId;
   close EXP_ACTION_8237_.cuExpression;
END;
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_ACTION_8237',1);
EXP_ACTION_8237_.blProcessStatus := EXP_PROCESS_100559_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  SELECT  B.object_name
FROM    GE_ACTION_MODULE A, GR_CONFIG_EXPRESSION B
WHERE   A.CONFIG_EXPRESSION_ID = b.CONFIG_EXPRESSION_ID
AND     A.ACTION_ID =8237
;
BEGIN

if (not EXP_ACTION_8237_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_ACTION_8237_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
  nuIndex := nuIndex + 1;
 END LOOP;
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
END;
/

DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE ACTION_ID=8237);
BEGIN 

if (not EXP_ACTION_8237_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_ACTION_8237_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_ACTION_8237_.blProcessStatus := false;
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
FROM GE_ACTION_MODULE WHERE ACTION_ID=8237;
nuIndex binary_integer;
BEGIN

if (not EXP_ACTION_8237_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_ACTION_MODULE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM GE_ACTION_MODULE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_ACTION_8237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_ACTION_8237_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_ACTION_8237_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_ACTION_8237_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_ACTION_8237_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_ACTION_8237_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_ACTION_8237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_ACTION_8237_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8237_.tb0_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=EXP_ACTION_8237_.tb0_0(0),
MODULE_ID=1,
DESCRIPTION='Ejecuci¿n Acciones de todos los m¿dulos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_EXEACTION_'

 WHERE CONFIGURA_TYPE_ID = EXP_ACTION_8237_.tb0_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (EXP_ACTION_8237_.tb0_0(0),
1,
'Ejecuci¿n Acciones de todos los m¿dulos'
,
'PL'
,
'FD'
,
'DS'
,
'_EXEACTION_'
);
end if;

exception when others then
EXP_ACTION_8237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_8237_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8237_.old_tb1_0(0):=121397099;
EXP_ACTION_8237_.tb1_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
EXP_ACTION_8237_.tb1_0(0):=EXP_ACTION_8237_.tb1_0(0);
EXP_ACTION_8237_.old_tb1_1(0):='GE_EXEACTION_CT1E121397099'
;
EXP_ACTION_8237_.tb1_1(0):=TO_CHAR(EXP_ACTION_8237_.tb1_0(0));
EXP_ACTION_8237_.tb1_2(0):=EXP_ACTION_8237_.tb0_0(0);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (EXP_ACTION_8237_.tb1_0(0),
EXP_ACTION_8237_.tb1_1(0),
EXP_ACTION_8237_.tb1_2(0),
'nuPaquete = MO_BOINSTANCE_DB.FNUGETPACKIDINSTANCE();LDC_BORECONECION.REVESTADOPRODUCTO(nuPaquete)'
,
'OPEN'
,
to_date('19-11-2014 16:49:50','DD-MM-YYYY HH24:MI:SS'),
to_date('29-03-2023 09:34:03','DD-MM-YYYY HH24:MI:SS'),
to_date('29-03-2023 09:34:03','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC - Atender reverso de cambio Estado'
,
'PP'
,
null);

exception when others then
EXP_ACTION_8237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_8237_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8237_.tb2_0(0):=8237;
EXP_ACTION_8237_.tb2_2(0):=EXP_ACTION_8237_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ACTION_MODULE fila (0)',1);
UPDATE GE_ACTION_MODULE SET ACTION_ID=EXP_ACTION_8237_.tb2_0(0),
MODULE_ID=5,
CONFIG_EXPRESSION_ID=EXP_ACTION_8237_.tb2_2(0),
DESCRIPTION='LDC - Atender reverso de cambio Estado en Reconexion'
,
EXE_AT_STATUS_CHANGE='N'
,
EXE_TRANSITION_STATE='N'

 WHERE ACTION_ID = EXP_ACTION_8237_.tb2_0(0);
if not (sql%found) then
INSERT INTO GE_ACTION_MODULE(ACTION_ID,MODULE_ID,CONFIG_EXPRESSION_ID,DESCRIPTION,EXE_AT_STATUS_CHANGE,EXE_TRANSITION_STATE) 
VALUES (EXP_ACTION_8237_.tb2_0(0),
5,
EXP_ACTION_8237_.tb2_2(0),
'LDC - Atender reverso de cambio Estado en Reconexion'
,
'N'
,
'N'
);
end if;

exception when others then
EXP_ACTION_8237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_8237_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8237_.tb3_0(0):=EXP_ACTION_8237_.tb2_0(0);
EXP_ACTION_8237_.tb3_1(0):=9;
ut_trace.trace('insertando tabla sin fallo: GE_VALID_ACTION_MODU fila (0)',1);
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (EXP_ACTION_8237_.tb3_0(0),
EXP_ACTION_8237_.tb3_1(0));

exception 
when dup_val_on_index then 
 return;
when others then
EXP_ACTION_8237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_8237_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8237_.tb3_0(1):=EXP_ACTION_8237_.tb2_0(0);
EXP_ACTION_8237_.tb3_1(1):=16;
ut_trace.trace('insertando tabla sin fallo: GE_VALID_ACTION_MODU fila (1)',1);
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (EXP_ACTION_8237_.tb3_0(1),
EXP_ACTION_8237_.tb3_1(1));

exception 
when dup_val_on_index then 
 return;
when others then
EXP_ACTION_8237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
DECLARE 
    nuBinaryIndex Binary_Integer;
BEGIN 
    nuBinaryIndex := EXP_ACTION_8237_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = EXP_ACTION_8237_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||EXP_ACTION_8237_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||EXP_ACTION_8237_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := EXP_ACTION_8237_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       EXP_ACTION_8237_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100559',1);
EXP_PROCESS_100559_.blProcessStatus := EXP_ACTION_8237_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
COMMIT
/

DECLARE
PRAGMA AUTONOMOUS_TRANSACTION;
nuRowProcess number;
BEGIN 

if (not EXP_ACTION_8237_.blProcessStatus) then
 return;
end if;
nuRowProcess:=EXP_ACTION_8237_.tb1_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| EXP_ACTION_8237_.tb1_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(EXP_ACTION_8237_.tb1_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| EXP_ACTION_8237_.tb1_0(nuRowProcess),1);
end;
nuRowProcess := EXP_ACTION_8237_.tb1_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
EXP_ACTION_8237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

DECLARE
 nuIndex         binary_integer;
 blObjectDeleted boolean;

 FUNCTION fblIsObjectUseByRule
 (
  isbObjectName   IN gr_config_expression.object_name%type
 ) return BOOLEAN
 IS
  nuCounter    NUMBER := 0;
  blReturn     BOOLEAN := FALSE;
 BEGIN
  SELECT count('x') INTO nuCounter
  FROM gr_config_expression
  WHERE object_name = isbObjectName;
  IF (nuCounter > 0) THEN
    BEGIN
      DELETE FROM gr_config_expression
      WHERE object_name = isbObjectName;
      blReturn := FALSE;
    EXCEPTION
      when ex.RECORD_HAVE_CHILDREN then
         ut_trace.trace('Objeto ' || isbObjectName || ' usado en ' || nuCounter ||' reglas, no se borra',2);
         blReturn := TRUE;
    END;
  END IF;
  RETURN blReturn;
 END;

BEGIN
 ut_trace.trace('Inicia borrado de objetos de reglas',1);
 nuIndex := EXP_ACTION_8237_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_ACTION_8237_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_ACTION_8237_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_ACTION_8237_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_ACTION_8237_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_ACTION_8237_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_ACTION_8237_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_ACTION_8237_.tbObjectToDelete.next(nuIndex);
 END loop;
 ut_trace.trace('Finaliza borrado de objetos de reglas',1);
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
END;
/


begin
SA_BOCreatePackages.DropPackage('EXP_ACTION_8237_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_ACTION_8237_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_ACTION_88_',
'CREATE OR REPLACE PACKAGE EXP_ACTION_88_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyGR_CONFIGURA_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIGURA_TYPERowId tyGR_CONFIGURA_TYPERowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type tyGE_ACTION_MODULERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ACTION_MODULERowId tyGE_ACTION_MODULERowId;type tyGE_VALID_ACTION_MODURowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_VALID_ACTION_MODURowId tyGE_VALID_ACTION_MODURowId;type ty0_0 is table of GR_CONFIGURA_TYPE.CONFIGURA_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty1_0 is table of GR_CONFIG_EXPRESSION.CONFIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_0 ty1_0; ' || chr(10) ||
'tb1_0 ty1_0;type ty1_1 is table of GR_CONFIG_EXPRESSION.OBJECT_NAME%type index by binary_integer; ' || chr(10) ||
'old_tb1_1 ty1_1; ' || chr(10) ||
'tb1_1 ty1_1;type ty1_2 is table of GR_CONFIG_EXPRESSION.CONFIGURA_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_2 ty1_2; ' || chr(10) ||
'tb1_2 ty1_2;type ty2_0 is table of GE_ACTION_MODULE.ACTION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;type ty2_2 is table of GE_ACTION_MODULE.CONFIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_2 ty2_2; ' || chr(10) ||
'tb2_2 ty2_2;type ty3_0 is table of GE_VALID_ACTION_MODU.ACTION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_0 ty3_0; ' || chr(10) ||
'tb3_0 ty3_0;type ty3_1 is table of GE_VALID_ACTION_MODU.VALID_MODULE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_1 ty3_1; ' || chr(10) ||
'tb3_1 ty3_1; ' || chr(10) ||
'CURSOR cuExpression is ' || chr(10) ||
'SELECT CONFIG_EXPRESSION_ID ' || chr(10) ||
'FROM   GE_ACTION_MODULE ' || chr(10) ||
'WHERE  ACTION_ID =88; ' || chr(10) ||
'type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_ACTION_88_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_ACTION_88_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open EXP_ACTION_88_.cuExpression;
   fetch EXP_ACTION_88_.cuExpression bulk collect INTO EXP_ACTION_88_.tbGR_CONFIG_EXPRESSIONId;
   close EXP_ACTION_88_.cuExpression;
END;
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_ACTION_88',1);
EXP_ACTION_88_.blProcessStatus := EXP_PROCESS_100559_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  SELECT  B.object_name
FROM    GE_ACTION_MODULE A, GR_CONFIG_EXPRESSION B
WHERE   A.CONFIG_EXPRESSION_ID = b.CONFIG_EXPRESSION_ID
AND     A.ACTION_ID =88
;
BEGIN

if (not EXP_ACTION_88_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_ACTION_88_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
  nuIndex := nuIndex + 1;
 END LOOP;
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
END;
/

DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE ACTION_ID=88);
BEGIN 

if (not EXP_ACTION_88_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_ACTION_88_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_ACTION_88_.blProcessStatus := false;
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
FROM GE_ACTION_MODULE WHERE ACTION_ID=88;
nuIndex binary_integer;
BEGIN

if (not EXP_ACTION_88_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_ACTION_MODULE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM GE_ACTION_MODULE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_ACTION_88_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_ACTION_88_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_ACTION_88_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_ACTION_88_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_ACTION_88_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_ACTION_88_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_ACTION_88_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_ACTION_88_.blProcessStatus) then
 return;
end if;

EXP_ACTION_88_.tb0_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=EXP_ACTION_88_.tb0_0(0),
MODULE_ID=1,
DESCRIPTION='Ejecuci¿n Acciones de todos los m¿dulos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_EXEACTION_'

 WHERE CONFIGURA_TYPE_ID = EXP_ACTION_88_.tb0_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (EXP_ACTION_88_.tb0_0(0),
1,
'Ejecuci¿n Acciones de todos los m¿dulos'
,
'PL'
,
'FD'
,
'DS'
,
'_EXEACTION_'
);
end if;

exception when others then
EXP_ACTION_88_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_88_.blProcessStatus) then
 return;
end if;

EXP_ACTION_88_.old_tb1_0(0):=121397098;
EXP_ACTION_88_.tb1_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
EXP_ACTION_88_.tb1_0(0):=EXP_ACTION_88_.tb1_0(0);
EXP_ACTION_88_.old_tb1_1(0):='GE_EXEACTION_CT1E121397098'
;
EXP_ACTION_88_.tb1_1(0):=TO_CHAR(EXP_ACTION_88_.tb1_0(0));
EXP_ACTION_88_.tb1_2(0):=EXP_ACTION_88_.tb0_0(0);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (EXP_ACTION_88_.tb1_0(0),
EXP_ACTION_88_.tb1_1(0),
EXP_ACTION_88_.tb1_2(0),
'nuPackageId = MO_BOINSTANCE_DB.FNUGETPACKIDINSTANCE();nuActionId = GE_BOPARAMETER.FNUGET("ACTION_ATTEND", "N");MO_BOMOTIVEACTIONUTIL.EXECTRANSTATUSFORREQU(nuPackageId,nuActionId)'
,
'LBTEST'
,
to_date('09-07-2012 15:57:39','DD-MM-YYYY HH24:MI:SS'),
to_date('29-03-2023 09:33:55','DD-MM-YYYY HH24:MI:SS'),
to_date('29-03-2023 09:33:55','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Atender paquete y motivo'
,
'PP'
,
null);

exception when others then
EXP_ACTION_88_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_88_.blProcessStatus) then
 return;
end if;

EXP_ACTION_88_.tb2_0(0):=88;
EXP_ACTION_88_.tb2_2(0):=EXP_ACTION_88_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ACTION_MODULE fila (0)',1);
UPDATE GE_ACTION_MODULE SET ACTION_ID=EXP_ACTION_88_.tb2_0(0),
MODULE_ID=5,
CONFIG_EXPRESSION_ID=EXP_ACTION_88_.tb2_2(0),
DESCRIPTION='Atender paquete y motivo'
,
EXE_AT_STATUS_CHANGE='N'
,
EXE_TRANSITION_STATE='N'

 WHERE ACTION_ID = EXP_ACTION_88_.tb2_0(0);
if not (sql%found) then
INSERT INTO GE_ACTION_MODULE(ACTION_ID,MODULE_ID,CONFIG_EXPRESSION_ID,DESCRIPTION,EXE_AT_STATUS_CHANGE,EXE_TRANSITION_STATE) 
VALUES (EXP_ACTION_88_.tb2_0(0),
5,
EXP_ACTION_88_.tb2_2(0),
'Atender paquete y motivo'
,
'N'
,
'N'
);
end if;

exception when others then
EXP_ACTION_88_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_88_.blProcessStatus) then
 return;
end if;

EXP_ACTION_88_.tb3_0(0):=EXP_ACTION_88_.tb2_0(0);
EXP_ACTION_88_.tb3_1(0):=9;
ut_trace.trace('insertando tabla sin fallo: GE_VALID_ACTION_MODU fila (0)',1);
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (EXP_ACTION_88_.tb3_0(0),
EXP_ACTION_88_.tb3_1(0));

exception 
when dup_val_on_index then 
 return;
when others then
EXP_ACTION_88_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_88_.blProcessStatus) then
 return;
end if;

EXP_ACTION_88_.tb3_0(1):=EXP_ACTION_88_.tb2_0(0);
EXP_ACTION_88_.tb3_1(1):=16;
ut_trace.trace('insertando tabla sin fallo: GE_VALID_ACTION_MODU fila (1)',1);
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (EXP_ACTION_88_.tb3_0(1),
EXP_ACTION_88_.tb3_1(1));

exception 
when dup_val_on_index then 
 return;
when others then
EXP_ACTION_88_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
DECLARE 
    nuBinaryIndex Binary_Integer;
BEGIN 
    nuBinaryIndex := EXP_ACTION_88_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = EXP_ACTION_88_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||EXP_ACTION_88_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||EXP_ACTION_88_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := EXP_ACTION_88_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       EXP_ACTION_88_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100559',1);
EXP_PROCESS_100559_.blProcessStatus := EXP_ACTION_88_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
COMMIT
/

DECLARE
PRAGMA AUTONOMOUS_TRANSACTION;
nuRowProcess number;
BEGIN 

if (not EXP_ACTION_88_.blProcessStatus) then
 return;
end if;
nuRowProcess:=EXP_ACTION_88_.tb1_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| EXP_ACTION_88_.tb1_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(EXP_ACTION_88_.tb1_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| EXP_ACTION_88_.tb1_0(nuRowProcess),1);
end;
nuRowProcess := EXP_ACTION_88_.tb1_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
EXP_ACTION_88_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

DECLARE
 nuIndex         binary_integer;
 blObjectDeleted boolean;

 FUNCTION fblIsObjectUseByRule
 (
  isbObjectName   IN gr_config_expression.object_name%type
 ) return BOOLEAN
 IS
  nuCounter    NUMBER := 0;
  blReturn     BOOLEAN := FALSE;
 BEGIN
  SELECT count('x') INTO nuCounter
  FROM gr_config_expression
  WHERE object_name = isbObjectName;
  IF (nuCounter > 0) THEN
    BEGIN
      DELETE FROM gr_config_expression
      WHERE object_name = isbObjectName;
      blReturn := FALSE;
    EXCEPTION
      when ex.RECORD_HAVE_CHILDREN then
         ut_trace.trace('Objeto ' || isbObjectName || ' usado en ' || nuCounter ||' reglas, no se borra',2);
         blReturn := TRUE;
    END;
  END IF;
  RETURN blReturn;
 END;

BEGIN
 ut_trace.trace('Inicia borrado de objetos de reglas',1);
 nuIndex := EXP_ACTION_88_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_ACTION_88_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_ACTION_88_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_ACTION_88_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_ACTION_88_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_ACTION_88_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_ACTION_88_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_ACTION_88_.tbObjectToDelete.next(nuIndex);
 END loop;
 ut_trace.trace('Finaliza borrado de objetos de reglas',1);
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
END;
/


begin
SA_BOCreatePackages.DropPackage('EXP_ACTION_88_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_ACTION_88_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_ACTION_8216_',
'CREATE OR REPLACE PACKAGE EXP_ACTION_8216_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyGR_CONFIGURA_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIGURA_TYPERowId tyGR_CONFIGURA_TYPERowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type tyGE_ACTION_MODULERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ACTION_MODULERowId tyGE_ACTION_MODULERowId;type tyGE_VALID_ACTION_MODURowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_VALID_ACTION_MODURowId tyGE_VALID_ACTION_MODURowId;type ty0_0 is table of GR_CONFIGURA_TYPE.CONFIGURA_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty1_0 is table of GR_CONFIG_EXPRESSION.CONFIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_0 ty1_0; ' || chr(10) ||
'tb1_0 ty1_0;type ty1_1 is table of GR_CONFIG_EXPRESSION.OBJECT_NAME%type index by binary_integer; ' || chr(10) ||
'old_tb1_1 ty1_1; ' || chr(10) ||
'tb1_1 ty1_1;type ty1_2 is table of GR_CONFIG_EXPRESSION.CONFIGURA_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_2 ty1_2; ' || chr(10) ||
'tb1_2 ty1_2;type ty2_0 is table of GE_ACTION_MODULE.ACTION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;type ty2_2 is table of GE_ACTION_MODULE.CONFIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_2 ty2_2; ' || chr(10) ||
'tb2_2 ty2_2;type ty3_0 is table of GE_VALID_ACTION_MODU.ACTION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_0 ty3_0; ' || chr(10) ||
'tb3_0 ty3_0;type ty3_1 is table of GE_VALID_ACTION_MODU.VALID_MODULE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_1 ty3_1; ' || chr(10) ||
'tb3_1 ty3_1; ' || chr(10) ||
'CURSOR cuExpression is ' || chr(10) ||
'SELECT CONFIG_EXPRESSION_ID ' || chr(10) ||
'FROM   GE_ACTION_MODULE ' || chr(10) ||
'WHERE  ACTION_ID =8216; ' || chr(10) ||
'type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_ACTION_8216_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_ACTION_8216_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open EXP_ACTION_8216_.cuExpression;
   fetch EXP_ACTION_8216_.cuExpression bulk collect INTO EXP_ACTION_8216_.tbGR_CONFIG_EXPRESSIONId;
   close EXP_ACTION_8216_.cuExpression;
END;
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_ACTION_8216',1);
EXP_ACTION_8216_.blProcessStatus := EXP_PROCESS_100559_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  SELECT  B.object_name
FROM    GE_ACTION_MODULE A, GR_CONFIG_EXPRESSION B
WHERE   A.CONFIG_EXPRESSION_ID = b.CONFIG_EXPRESSION_ID
AND     A.ACTION_ID =8216
;
BEGIN

if (not EXP_ACTION_8216_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_ACTION_8216_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
  nuIndex := nuIndex + 1;
 END LOOP;
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
END;
/

DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE ACTION_ID=8216);
BEGIN 

if (not EXP_ACTION_8216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_ACTION_8216_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_ACTION_8216_.blProcessStatus := false;
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
FROM GE_ACTION_MODULE WHERE ACTION_ID=8216;
nuIndex binary_integer;
BEGIN

if (not EXP_ACTION_8216_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_ACTION_MODULE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM GE_ACTION_MODULE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_ACTION_8216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_ACTION_8216_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_ACTION_8216_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_ACTION_8216_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_ACTION_8216_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_ACTION_8216_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_ACTION_8216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_ACTION_8216_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8216_.tb0_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=EXP_ACTION_8216_.tb0_0(0),
MODULE_ID=1,
DESCRIPTION='Ejecuci¿n Acciones de todos los m¿dulos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_EXEACTION_'

 WHERE CONFIGURA_TYPE_ID = EXP_ACTION_8216_.tb0_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (EXP_ACTION_8216_.tb0_0(0),
1,
'Ejecuci¿n Acciones de todos los m¿dulos'
,
'PL'
,
'FD'
,
'DS'
,
'_EXEACTION_'
);
end if;

exception when others then
EXP_ACTION_8216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_8216_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8216_.old_tb1_0(0):=121397097;
EXP_ACTION_8216_.tb1_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
EXP_ACTION_8216_.tb1_0(0):=EXP_ACTION_8216_.tb1_0(0);
EXP_ACTION_8216_.old_tb1_1(0):='GE_EXEACTION_CT1E121397097'
;
EXP_ACTION_8216_.tb1_1(0):=TO_CHAR(EXP_ACTION_8216_.tb1_0(0));
EXP_ACTION_8216_.tb1_2(0):=EXP_ACTION_8216_.tb0_0(0);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (EXP_ACTION_8216_.tb1_0(0),
EXP_ACTION_8216_.tb1_1(0),
EXP_ACTION_8216_.tb1_2(0),
'nuPackageId = MO_BOINSTANCE_DB.FNUGETPACKIDINSTANCE();LDC_BORECONECION.RECONEXIONPORPAGO(nuPackageId)'
,
'AGORDILLO'
,
to_date('02-10-2013 07:46:15','DD-MM-YYYY HH24:MI:SS'),
to_date('29-03-2023 09:33:50','DD-MM-YYYY HH24:MI:SS'),
to_date('29-03-2023 09:33:50','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC - Atiende la reconexi¿n de un producto'
,
'PP'
,
null);

exception when others then
EXP_ACTION_8216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_8216_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8216_.tb2_0(0):=8216;
EXP_ACTION_8216_.tb2_2(0):=EXP_ACTION_8216_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ACTION_MODULE fila (0)',1);
UPDATE GE_ACTION_MODULE SET ACTION_ID=EXP_ACTION_8216_.tb2_0(0),
MODULE_ID=5,
CONFIG_EXPRESSION_ID=EXP_ACTION_8216_.tb2_2(0),
DESCRIPTION='LDC - Atender reconexi¿n del producto'
,
EXE_AT_STATUS_CHANGE='N'
,
EXE_TRANSITION_STATE='N'

 WHERE ACTION_ID = EXP_ACTION_8216_.tb2_0(0);
if not (sql%found) then
INSERT INTO GE_ACTION_MODULE(ACTION_ID,MODULE_ID,CONFIG_EXPRESSION_ID,DESCRIPTION,EXE_AT_STATUS_CHANGE,EXE_TRANSITION_STATE) 
VALUES (EXP_ACTION_8216_.tb2_0(0),
5,
EXP_ACTION_8216_.tb2_2(0),
'LDC - Atender reconexi¿n del producto'
,
'N'
,
'N'
);
end if;

exception when others then
EXP_ACTION_8216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_8216_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8216_.tb3_0(0):=EXP_ACTION_8216_.tb2_0(0);
EXP_ACTION_8216_.tb3_1(0):=9;
ut_trace.trace('insertando tabla sin fallo: GE_VALID_ACTION_MODU fila (0)',1);
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (EXP_ACTION_8216_.tb3_0(0),
EXP_ACTION_8216_.tb3_1(0));

exception 
when dup_val_on_index then 
 return;
when others then
EXP_ACTION_8216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_8216_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8216_.tb3_0(1):=EXP_ACTION_8216_.tb2_0(0);
EXP_ACTION_8216_.tb3_1(1):=16;
ut_trace.trace('insertando tabla sin fallo: GE_VALID_ACTION_MODU fila (1)',1);
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (EXP_ACTION_8216_.tb3_0(1),
EXP_ACTION_8216_.tb3_1(1));

exception 
when dup_val_on_index then 
 return;
when others then
EXP_ACTION_8216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
DECLARE 
    nuBinaryIndex Binary_Integer;
BEGIN 
    nuBinaryIndex := EXP_ACTION_8216_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = EXP_ACTION_8216_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||EXP_ACTION_8216_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||EXP_ACTION_8216_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := EXP_ACTION_8216_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       EXP_ACTION_8216_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100559',1);
EXP_PROCESS_100559_.blProcessStatus := EXP_ACTION_8216_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
COMMIT
/

DECLARE
PRAGMA AUTONOMOUS_TRANSACTION;
nuRowProcess number;
BEGIN 

if (not EXP_ACTION_8216_.blProcessStatus) then
 return;
end if;
nuRowProcess:=EXP_ACTION_8216_.tb1_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| EXP_ACTION_8216_.tb1_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(EXP_ACTION_8216_.tb1_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| EXP_ACTION_8216_.tb1_0(nuRowProcess),1);
end;
nuRowProcess := EXP_ACTION_8216_.tb1_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
EXP_ACTION_8216_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

DECLARE
 nuIndex         binary_integer;
 blObjectDeleted boolean;

 FUNCTION fblIsObjectUseByRule
 (
  isbObjectName   IN gr_config_expression.object_name%type
 ) return BOOLEAN
 IS
  nuCounter    NUMBER := 0;
  blReturn     BOOLEAN := FALSE;
 BEGIN
  SELECT count('x') INTO nuCounter
  FROM gr_config_expression
  WHERE object_name = isbObjectName;
  IF (nuCounter > 0) THEN
    BEGIN
      DELETE FROM gr_config_expression
      WHERE object_name = isbObjectName;
      blReturn := FALSE;
    EXCEPTION
      when ex.RECORD_HAVE_CHILDREN then
         ut_trace.trace('Objeto ' || isbObjectName || ' usado en ' || nuCounter ||' reglas, no se borra',2);
         blReturn := TRUE;
    END;
  END IF;
  RETURN blReturn;
 END;

BEGIN
 ut_trace.trace('Inicia borrado de objetos de reglas',1);
 nuIndex := EXP_ACTION_8216_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_ACTION_8216_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_ACTION_8216_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_ACTION_8216_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_ACTION_8216_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_ACTION_8216_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_ACTION_8216_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_ACTION_8216_.tbObjectToDelete.next(nuIndex);
 END loop;
 ut_trace.trace('Finaliza borrado de objetos de reglas',1);
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
END;
/


begin
SA_BOCreatePackages.DropPackage('EXP_ACTION_8216_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_ACTION_8216_******************************'); end;
/


DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  SELECT  B.object_name
FROM    WF_UNIT A, GR_CONFIG_EXPRESSION B
WHERE   (A.PRE_EXPRESSION_ID = b.CONFIG_EXPRESSION_ID
OR   A.POS_EXPRESSION_ID = b.CONFIG_EXPRESSION_ID)
AND     A.UNIT_ID IN (
        SELECT UNIT_ID         FROM WF_UNIT 
        WHERE UNIT_TYPE_ID = 100559
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID IN 
           (SELECT UNIT_ID
           FROM WF_UNIT
           WHERE UNIT_TYPE_ID = 100559
       ))
;
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_PROCESS_100559_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
  nuIndex := nuIndex + 1;
 END LOOP;
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
END;
/

DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100559) AND NODE_TYPE_ID=0);
BEGIN 

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_PROCESS_100559_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100559) AND NODE_TYPE_ID=0);
BEGIN 

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_PROCESS_100559_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
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
FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100559) AND NODE_TYPE_ID=0;
nuIndex binary_integer;
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_PROCESS_100559_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_PROCESS_100559_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_PROCESS_100559_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_PROCESS_100559_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_PROCESS_100559_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_PROCESS_100559_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_PROCESS_100559_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_PROCESS_100559_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
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
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100559;
nuIndex binary_integer;
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_TYPE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_TYPE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb0_0(0):=3;
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_CATEGORY fila (0)',1);
UPDATE WF_UNIT_CATEGORY SET CATEGORY_ID=EXP_PROCESS_100559_.tb0_0(0),
DISPLAY_NUMBER='Proceso Principal'

 WHERE CATEGORY_ID = EXP_PROCESS_100559_.tb0_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_CATEGORY(CATEGORY_ID,DISPLAY_NUMBER) 
VALUES (EXP_PROCESS_100559_.tb0_0(0),
'Proceso Principal'
);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb1_0(0):=9;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (0)',1);
UPDATE GE_MODULE SET MODULE_ID=EXP_PROCESS_100559_.tb1_0(0),
DESCRIPTION='WorkFlow'
,
MNEMONIC='WF'
,
LAST_MESSAGE=66,
PATH_MODULE='Workflow'
,
ICON_NAME='mod_admcnf'
,
LOCALIZATION='IN'

 WHERE MODULE_ID = EXP_PROCESS_100559_.tb1_0(0);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (EXP_PROCESS_100559_.tb1_0(0),
'WorkFlow'
,
'WF'
,
66,
'Workflow'
,
'mod_admcnf'
,
'IN'
);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb2_0(0):=100559;
EXP_PROCESS_100559_.tb2_1(0):=EXP_PROCESS_100559_.tb0_0(0);
EXP_PROCESS_100559_.tb2_2(0):=EXP_PROCESS_100559_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (0)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100559_.tb2_0(0),
CATEGORY_ID=EXP_PROCESS_100559_.tb2_1(0),
MODULE_ID=EXP_PROCESS_100559_.tb2_2(0),
ACTION_ID=null,
PARENT_ID=2277,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_100559'
,
DESCRIPTION='LDC - Solicitud Reconexi¿n'
,
DISPLAY='LDC - Solicitud de Reconexi¿n'
,
ICON=null,
IS_STAGE_PROCESS='N'
,
USABLE_IN_FLOW_STAGE='N'
,
ENTITY_ID=null,
MULTI_INSTANCE='R'
,
IS_COUNTABLE='N'
,
NOTIFICATION_ID=null,
VIEWABLE='N'
,
DEFAULT_PRIORITY_ID=null,
INITIAL_NOTIFY_TIME=null,
IS_ADMIN_PROCESS='N'
,
ASSIGN_NOTIFICATION_ID=null,
ASSIGNED_USER_ONLY=null
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100559_.tb2_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100559_.tb2_0(0),
EXP_PROCESS_100559_.tb2_1(0),
EXP_PROCESS_100559_.tb2_2(0),
null,
2277,
null,
null,
null,
null,
'UNIT_TYPE_100559'
,
'LDC - Solicitud Reconexi¿n'
,
'LDC - Solicitud de Reconexi¿n'
,
null,
'N'
,
'N'
,
null,
'R'
,
'N'
,
null,
'N'
,
null,
null,
'N'
,
null,
null);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb3_0(0):=100310;
EXP_PROCESS_100559_.tb3_1(0):=EXP_PROCESS_100559_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_ATTRIBUTES_EQUIV fila (0)',1);
UPDATE WF_ATTRIBUTES_EQUIV SET ATTRIBUTES_EQUIV_ID=EXP_PROCESS_100559_.tb3_0(0),
UNIT_TYPE_ID=EXP_PROCESS_100559_.tb3_1(0),
INTERFACE_CONFIG_ID=21,
STD_TIME=0,
MAX_TIME=31536000,
AVG_TIME=0,
DESCRIPTION='Val1 [100240] Val2 []'
,
VALUE_1='0'
,
VALUE_2='0'
,
VALUE_3=null,
VALUE_4=null,
VALUE_5=null,
VALUE_6=null,
VALUE_7=null,
VALUE_8=null,
VALUE_9=null,
VALUE_10=null,
VALUE_11=null,
VALUE_12=null,
VALUE_13=null,
VALUE_14=null,
VALUE_15=null,
VALUE_16=null,
VALUE_17=null,
VALUE_18=null,
VALUE_19=null,
VALUE_20=null
 WHERE ATTRIBUTES_EQUIV_ID = EXP_PROCESS_100559_.tb3_0(0);
if not (sql%found) then
INSERT INTO WF_ATTRIBUTES_EQUIV(ATTRIBUTES_EQUIV_ID,UNIT_TYPE_ID,INTERFACE_CONFIG_ID,STD_TIME,MAX_TIME,AVG_TIME,DESCRIPTION,VALUE_1,VALUE_2,VALUE_3,VALUE_4,VALUE_5,VALUE_6,VALUE_7,VALUE_8,VALUE_9,VALUE_10,VALUE_11,VALUE_12,VALUE_13,VALUE_14,VALUE_15,VALUE_16,VALUE_17,VALUE_18,VALUE_19,VALUE_20) 
VALUES (EXP_PROCESS_100559_.tb3_0(0),
EXP_PROCESS_100559_.tb3_1(0),
21,
0,
31536000,
0,
'Val1 [100240] Val2 []'
,
'0'
,
'0'
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
null,
null,
null,
null,
null,
null,
null);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb3_0(1):=100314;
EXP_PROCESS_100559_.tb3_1(1):=EXP_PROCESS_100559_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_ATTRIBUTES_EQUIV fila (1)',1);
UPDATE WF_ATTRIBUTES_EQUIV SET ATTRIBUTES_EQUIV_ID=EXP_PROCESS_100559_.tb3_0(1),
UNIT_TYPE_ID=EXP_PROCESS_100559_.tb3_1(1),
INTERFACE_CONFIG_ID=21,
STD_TIME=0,
MAX_TIME=31536000,
AVG_TIME=0,
DESCRIPTION='LDC - Solicitud de Reconexi¿n'
,
VALUE_1='100240'
,
VALUE_2=null,
VALUE_3=null,
VALUE_4=null,
VALUE_5=null,
VALUE_6=null,
VALUE_7=null,
VALUE_8=null,
VALUE_9=null,
VALUE_10=null,
VALUE_11=null,
VALUE_12=null,
VALUE_13=null,
VALUE_14=null,
VALUE_15=null,
VALUE_16=null,
VALUE_17=null,
VALUE_18=null,
VALUE_19=null,
VALUE_20=null
 WHERE ATTRIBUTES_EQUIV_ID = EXP_PROCESS_100559_.tb3_0(1);
if not (sql%found) then
INSERT INTO WF_ATTRIBUTES_EQUIV(ATTRIBUTES_EQUIV_ID,UNIT_TYPE_ID,INTERFACE_CONFIG_ID,STD_TIME,MAX_TIME,AVG_TIME,DESCRIPTION,VALUE_1,VALUE_2,VALUE_3,VALUE_4,VALUE_5,VALUE_6,VALUE_7,VALUE_8,VALUE_9,VALUE_10,VALUE_11,VALUE_12,VALUE_13,VALUE_14,VALUE_15,VALUE_16,VALUE_17,VALUE_18,VALUE_19,VALUE_20) 
VALUES (EXP_PROCESS_100559_.tb3_0(1),
EXP_PROCESS_100559_.tb3_1(1),
21,
0,
31536000,
0,
'LDC - Solicitud de Reconexi¿n'
,
'100240'
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
null,
null,
null,
null,
null,
null,
null,
null);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb4_0(0):=0;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (0)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100559_.tb4_0(0),
DESCRIPTION='Ra¿z'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100559_.tb4_0(0);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100559_.tb4_0(0),
'Ra¿z'
);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb5_0(0):=102697;
EXP_PROCESS_100559_.tb5_2(0):=EXP_PROCESS_100559_.tb2_0(0);
EXP_PROCESS_100559_.tb5_3(0):=EXP_PROCESS_100559_.tb4_0(0);
EXP_PROCESS_100559_.tb5_4(0):=EXP_PROCESS_100559_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (0)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100559_.tb5_0(0),
PROCESS_ID=null,
UNIT_TYPE_ID=EXP_PROCESS_100559_.tb5_2(0),
NODE_TYPE_ID=EXP_PROCESS_100559_.tb5_3(0),
MODULE_ID=EXP_PROCESS_100559_.tb5_4(0),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='20
20'
,
DESCRIPTION='T¿tulo'
,
ONLINE_EXEC_ID=null,
MULTI_INSTANCE='R'
,
SINCRONIC_TIMEOUT=null,
ASINCRONIC_TIMEOUT=null,
FUNCTION_TYPE=null,
IS_COUNTABLE='N'
,
MIN_GROUP_SIZE=null,
EXECUTION_ORDER='A'
,
ANNULATION_ORDER='N'
,
ENTITY_ID=null,
VIEWABLE='N'

 WHERE UNIT_ID = EXP_PROCESS_100559_.tb5_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100559_.tb5_0(0),
null,
EXP_PROCESS_100559_.tb5_2(0),
EXP_PROCESS_100559_.tb5_3(0),
EXP_PROCESS_100559_.tb5_4(0),
null,
null,
null,
null,
'20
20'
,
'T¿tulo'
,
null,
'R'
,
null,
null,
null,
'N'
,
null,
'A'
,
'N'
,
null,
'N'
);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb0_0(1):=2;
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_CATEGORY fila (1)',1);
UPDATE WF_UNIT_CATEGORY SET CATEGORY_ID=EXP_PROCESS_100559_.tb0_0(1),
DISPLAY_NUMBER='Actividad'

 WHERE CATEGORY_ID = EXP_PROCESS_100559_.tb0_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_CATEGORY(CATEGORY_ID,DISPLAY_NUMBER) 
VALUES (EXP_PROCESS_100559_.tb0_0(1),
'Actividad'
);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb1_0(1):=4;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (1)',1);
UPDATE GE_MODULE SET MODULE_ID=EXP_PROCESS_100559_.tb1_0(1),
DESCRIPTION='¿rdenes'
,
MNEMONIC='OR'
,
LAST_MESSAGE=404,
PATH_MODULE='Orders'
,
ICON_NAME='mod_ordenes'
,
LOCALIZATION='IN'

 WHERE MODULE_ID = EXP_PROCESS_100559_.tb1_0(1);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (EXP_PROCESS_100559_.tb1_0(1),
'¿rdenes'
,
'OR'
,
404,
'Orders'
,
'mod_ordenes'
,
'IN'
);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb2_0(1):=100561;
EXP_PROCESS_100559_.tb2_1(1):=EXP_PROCESS_100559_.tb0_0(1);
EXP_PROCESS_100559_.tb2_2(1):=EXP_PROCESS_100559_.tb1_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (1)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100559_.tb2_0(1),
CATEGORY_ID=EXP_PROCESS_100559_.tb2_1(1),
MODULE_ID=EXP_PROCESS_100559_.tb2_2(1),
ACTION_ID=100,
PARENT_ID=983,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_100561'
,
DESCRIPTION='Genera orden Reconexion'
,
DISPLAY='Genera orden Reconexion'
,
ICON=null,
IS_STAGE_PROCESS='N'
,
USABLE_IN_FLOW_STAGE='N'
,
ENTITY_ID=null,
MULTI_INSTANCE='N'
,
IS_COUNTABLE='N'
,
NOTIFICATION_ID=9011,
VIEWABLE='N'
,
DEFAULT_PRIORITY_ID=null,
INITIAL_NOTIFY_TIME=null,
IS_ADMIN_PROCESS='N'
,
ASSIGN_NOTIFICATION_ID=null,
ASSIGNED_USER_ONLY=null
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100559_.tb2_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100559_.tb2_0(1),
EXP_PROCESS_100559_.tb2_1(1),
EXP_PROCESS_100559_.tb2_2(1),
100,
983,
null,
null,
null,
null,
'UNIT_TYPE_100561'
,
'Genera orden Reconexion'
,
'Genera orden Reconexion'
,
null,
'N'
,
'N'
,
null,
'N'
,
'N'
,
9011,
'N'
,
null,
null,
'N'
,
null,
null);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb4_0(1):=2;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (1)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100559_.tb4_0(1),
DESCRIPTION='Normal'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100559_.tb4_0(1);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100559_.tb4_0(1),
'Normal'
);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb6_0(0):=7;
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=EXP_PROCESS_100559_.tb6_0(0),
MODULE_ID=9,
DESCRIPTION='Reglas Pre'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='WF_PRE_RULE'

 WHERE CONFIGURA_TYPE_ID = EXP_PROCESS_100559_.tb6_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (EXP_PROCESS_100559_.tb6_0(0),
9,
'Reglas Pre'
,
'PL'
,
'FD'
,
'DS'
,
'WF_PRE_RULE'
);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.old_tb7_0(0):=121397089;
EXP_PROCESS_100559_.tb7_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
EXP_PROCESS_100559_.tb7_0(0):=EXP_PROCESS_100559_.tb7_0(0);
EXP_PROCESS_100559_.old_tb7_1(0):='WFWF_PRE_RULECT7E121397089'
;
EXP_PROCESS_100559_.tb7_1(0):=TO_CHAR(EXP_PROCESS_100559_.tb7_0(0));
EXP_PROCESS_100559_.tb7_2(0):=EXP_PROCESS_100559_.tb6_0(0);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (EXP_PROCESS_100559_.tb7_0(0),
EXP_PROCESS_100559_.tb7_1(0),
EXP_PROCESS_100559_.tb7_2(0),
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance,null,"WF_INSTANCE","EXTERNAL_ID",nuPackageId);LDC_BORECONECION.UDTESTADOPRODUCTO(nuPackageId)'
,
'SERMEJIA'
,
to_date('31-10-2013 16:08:41','DD-MM-YYYY HH24:MI:SS'),
to_date('29-03-2023 09:29:41','DD-MM-YYYY HH24:MI:SS'),
to_date('29-03-2023 09:29:41','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC - Actualizar el estado de corte del producto'
,
'PP'
,
null);

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb5_0(1):=102791;
EXP_PROCESS_100559_.tb5_1(1):=EXP_PROCESS_100559_.tb5_0(0);
EXP_PROCESS_100559_.tb5_2(1):=EXP_PROCESS_100559_.tb2_0(1);
EXP_PROCESS_100559_.tb5_3(1):=EXP_PROCESS_100559_.tb4_0(1);
EXP_PROCESS_100559_.tb5_4(1):=EXP_PROCESS_100559_.tb1_0(1);
EXP_PROCESS_100559_.tb5_6(1):=EXP_PROCESS_100559_.tb7_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (1)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100559_.tb5_0(1),
PROCESS_ID=EXP_PROCESS_100559_.tb5_1(1),
UNIT_TYPE_ID=EXP_PROCESS_100559_.tb5_2(1),
NODE_TYPE_ID=EXP_PROCESS_100559_.tb5_3(1),
MODULE_ID=EXP_PROCESS_100559_.tb5_4(1),
ACTION_ID=100,
PRE_EXPRESSION_ID=EXP_PROCESS_100559_.tb5_6(1),
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=9011,
GEOMETRY='177
105'
,
DESCRIPTION='Genera orden Reconexion'
,
ONLINE_EXEC_ID=null,
MULTI_INSTANCE='R'
,
SINCRONIC_TIMEOUT=null,
ASINCRONIC_TIMEOUT=null,
FUNCTION_TYPE=null,
IS_COUNTABLE='Y'
,
MIN_GROUP_SIZE=null,
EXECUTION_ORDER='A'
,
ANNULATION_ORDER='N'
,
ENTITY_ID=17,
VIEWABLE='N'

 WHERE UNIT_ID = EXP_PROCESS_100559_.tb5_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100559_.tb5_0(1),
EXP_PROCESS_100559_.tb5_1(1),
EXP_PROCESS_100559_.tb5_2(1),
EXP_PROCESS_100559_.tb5_3(1),
EXP_PROCESS_100559_.tb5_4(1),
100,
EXP_PROCESS_100559_.tb5_6(1),
null,
9011,
'177
105'
,
'Genera orden Reconexion'
,
null,
'R'
,
null,
null,
null,
'Y'
,
null,
'A'
,
'N'
,
17,
'N'
);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb0_0(2):=1;
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_CATEGORY fila (2)',1);
UPDATE WF_UNIT_CATEGORY SET CATEGORY_ID=EXP_PROCESS_100559_.tb0_0(2),
DISPLAY_NUMBER='Proceso B¿sico'

 WHERE CATEGORY_ID = EXP_PROCESS_100559_.tb0_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT_CATEGORY(CATEGORY_ID,DISPLAY_NUMBER) 
VALUES (EXP_PROCESS_100559_.tb0_0(2),
'Proceso B¿sico'
);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb2_0(2):=100588;
EXP_PROCESS_100559_.tb2_1(2):=EXP_PROCESS_100559_.tb0_0(2);
EXP_PROCESS_100559_.tb2_2(2):=EXP_PROCESS_100559_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (2)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100559_.tb2_0(2),
CATEGORY_ID=EXP_PROCESS_100559_.tb2_1(2),
MODULE_ID=EXP_PROCESS_100559_.tb2_2(2),
ACTION_ID=null,
PARENT_ID=983,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_100588'
,
DESCRIPTION='Generaci¿n de Cobros'
,
DISPLAY='Generaci¿n de Cobros'
,
ICON=null,
IS_STAGE_PROCESS='N'
,
USABLE_IN_FLOW_STAGE='N'
,
ENTITY_ID=17,
MULTI_INSTANCE='R'
,
IS_COUNTABLE='N'
,
NOTIFICATION_ID=null,
VIEWABLE='N'
,
DEFAULT_PRIORITY_ID=null,
INITIAL_NOTIFY_TIME=null,
IS_ADMIN_PROCESS='N'
,
ASSIGN_NOTIFICATION_ID=null,
ASSIGNED_USER_ONLY=null
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100559_.tb2_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100559_.tb2_0(2),
EXP_PROCESS_100559_.tb2_1(2),
EXP_PROCESS_100559_.tb2_2(2),
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_100588'
,
'Generaci¿n de Cobros'
,
'Generaci¿n de Cobros'
,
null,
'N'
,
'N'
,
17,
'R'
,
'N'
,
null,
'N'
,
null,
null,
'N'
,
null,
null);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb5_0(2):=102788;
EXP_PROCESS_100559_.tb5_1(2):=EXP_PROCESS_100559_.tb5_0(0);
EXP_PROCESS_100559_.tb5_2(2):=EXP_PROCESS_100559_.tb2_0(2);
EXP_PROCESS_100559_.tb5_3(2):=EXP_PROCESS_100559_.tb4_0(1);
EXP_PROCESS_100559_.tb5_4(2):=EXP_PROCESS_100559_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (2)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100559_.tb5_0(2),
PROCESS_ID=EXP_PROCESS_100559_.tb5_1(2),
UNIT_TYPE_ID=EXP_PROCESS_100559_.tb5_2(2),
NODE_TYPE_ID=EXP_PROCESS_100559_.tb5_3(2),
MODULE_ID=EXP_PROCESS_100559_.tb5_4(2),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='178
307'
,
DESCRIPTION='Generaci¿n de Cobros'
,
ONLINE_EXEC_ID=null,
MULTI_INSTANCE='R'
,
SINCRONIC_TIMEOUT=null,
ASINCRONIC_TIMEOUT=null,
FUNCTION_TYPE=null,
IS_COUNTABLE='N'
,
MIN_GROUP_SIZE=null,
EXECUTION_ORDER='A'
,
ANNULATION_ORDER='N'
,
ENTITY_ID=null,
VIEWABLE='N'

 WHERE UNIT_ID = EXP_PROCESS_100559_.tb5_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100559_.tb5_0(2),
EXP_PROCESS_100559_.tb5_1(2),
EXP_PROCESS_100559_.tb5_2(2),
EXP_PROCESS_100559_.tb5_3(2),
EXP_PROCESS_100559_.tb5_4(2),
null,
null,
null,
null,
'178
307'
,
'Generaci¿n de Cobros'
,
null,
'R'
,
null,
null,
null,
'N'
,
null,
'A'
,
'N'
,
null,
'N'
);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb8_0(0):=100000847;
EXP_PROCESS_100559_.tb8_1(0):=EXP_PROCESS_100559_.tb5_0(1);
EXP_PROCESS_100559_.tb8_2(0):=EXP_PROCESS_100559_.tb5_0(2);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (0)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100559_.tb8_0(0),
ORIGIN_ID=EXP_PROCESS_100559_.tb8_1(0),
TARGET_ID=EXP_PROCESS_100559_.tb8_2(0),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION='CAUSAL == 1'
,
EXPRESSION_TYPE=0,
DESCRIPTION='Causal de Exito'
,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100559_.tb8_0(0);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100559_.tb8_0(0),
EXP_PROCESS_100559_.tb8_1(0),
EXP_PROCESS_100559_.tb8_2(0),
null,
0,
'CAUSAL == 1'
,
0,
'Causal de Exito'
,
1);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb2_0(3):=100614;
EXP_PROCESS_100559_.tb2_1(3):=EXP_PROCESS_100559_.tb0_0(1);
EXP_PROCESS_100559_.tb2_2(3):=EXP_PROCESS_100559_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (3)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100559_.tb2_0(3),
CATEGORY_ID=EXP_PROCESS_100559_.tb2_1(3),
MODULE_ID=EXP_PROCESS_100559_.tb2_2(3),
ACTION_ID=null,
PARENT_ID=983,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_100614'
,
DESCRIPTION='Reversar Estado Producto'
,
DISPLAY='Reversar Estado Producto'
,
ICON=null,
IS_STAGE_PROCESS='N'
,
USABLE_IN_FLOW_STAGE='N'
,
ENTITY_ID=null,
MULTI_INSTANCE='R'
,
IS_COUNTABLE='N'
,
NOTIFICATION_ID=null,
VIEWABLE='Y'
,
DEFAULT_PRIORITY_ID=null,
INITIAL_NOTIFY_TIME=null,
IS_ADMIN_PROCESS='N'
,
ASSIGN_NOTIFICATION_ID=null,
ASSIGNED_USER_ONLY=null
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100559_.tb2_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100559_.tb2_0(3),
EXP_PROCESS_100559_.tb2_1(3),
EXP_PROCESS_100559_.tb2_2(3),
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_100614'
,
'Reversar Estado Producto'
,
'Reversar Estado Producto'
,
null,
'N'
,
'N'
,
null,
'R'
,
'N'
,
null,
'Y'
,
null,
null,
'N'
,
null,
null);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb1_0(2):=5;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (2)',1);
UPDATE GE_MODULE SET MODULE_ID=EXP_PROCESS_100559_.tb1_0(2),
DESCRIPTION='GESTI¿N DE MOTIVOS'
,
MNEMONIC='MO'
,
LAST_MESSAGE=136,
PATH_MODULE='Motives_Management'
,
ICON_NAME='mod_motivos'
,
LOCALIZATION='IN'

 WHERE MODULE_ID = EXP_PROCESS_100559_.tb1_0(2);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (EXP_PROCESS_100559_.tb1_0(2),
'GESTI¿N DE MOTIVOS'
,
'MO'
,
136,
'Motives_Management'
,
'mod_motivos'
,
'IN'
);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb5_0(3):=102794;
EXP_PROCESS_100559_.tb5_1(3):=EXP_PROCESS_100559_.tb5_0(0);
EXP_PROCESS_100559_.tb5_2(3):=EXP_PROCESS_100559_.tb2_0(3);
EXP_PROCESS_100559_.tb5_3(3):=EXP_PROCESS_100559_.tb4_0(1);
EXP_PROCESS_100559_.tb5_4(3):=EXP_PROCESS_100559_.tb1_0(2);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (3)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100559_.tb5_0(3),
PROCESS_ID=EXP_PROCESS_100559_.tb5_1(3),
UNIT_TYPE_ID=EXP_PROCESS_100559_.tb5_2(3),
NODE_TYPE_ID=EXP_PROCESS_100559_.tb5_3(3),
MODULE_ID=EXP_PROCESS_100559_.tb5_4(3),
ACTION_ID=8237,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='565
98'
,
DESCRIPTION='Reversar Estado Producto'
,
ONLINE_EXEC_ID=null,
MULTI_INSTANCE='R'
,
SINCRONIC_TIMEOUT=null,
ASINCRONIC_TIMEOUT=null,
FUNCTION_TYPE=null,
IS_COUNTABLE='N'
,
MIN_GROUP_SIZE=null,
EXECUTION_ORDER='A'
,
ANNULATION_ORDER='N'
,
ENTITY_ID=null,
VIEWABLE='N'

 WHERE UNIT_ID = EXP_PROCESS_100559_.tb5_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100559_.tb5_0(3),
EXP_PROCESS_100559_.tb5_1(3),
EXP_PROCESS_100559_.tb5_2(3),
EXP_PROCESS_100559_.tb5_3(3),
EXP_PROCESS_100559_.tb5_4(3),
8237,
null,
null,
null,
'565
98'
,
'Reversar Estado Producto'
,
null,
'R'
,
null,
null,
null,
'N'
,
null,
'A'
,
'N'
,
null,
'N'
);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb8_0(1):=100000854;
EXP_PROCESS_100559_.tb8_1(1):=EXP_PROCESS_100559_.tb5_0(1);
EXP_PROCESS_100559_.tb8_2(1):=EXP_PROCESS_100559_.tb5_0(3);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (1)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100559_.tb8_0(1),
ORIGIN_ID=EXP_PROCESS_100559_.tb8_1(1),
TARGET_ID=EXP_PROCESS_100559_.tb8_2(1),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION='CAUSAL == 0'
,
EXPRESSION_TYPE=0,
DESCRIPTION='Causal de Fallo'
,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100559_.tb8_0(1);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100559_.tb8_0(1),
EXP_PROCESS_100559_.tb8_1(1),
EXP_PROCESS_100559_.tb8_2(1),
null,
0,
'CAUSAL == 0'
,
0,
'Causal de Fallo'
,
1);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb2_0(4):=283;
EXP_PROCESS_100559_.tb2_1(4):=EXP_PROCESS_100559_.tb0_0(1);
EXP_PROCESS_100559_.tb2_2(4):=EXP_PROCESS_100559_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (4)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100559_.tb2_0(4),
CATEGORY_ID=EXP_PROCESS_100559_.tb2_1(4),
MODULE_ID=EXP_PROCESS_100559_.tb2_2(4),
ACTION_ID=null,
PARENT_ID=983,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_283'
,
DESCRIPTION='Inicio'
,
DISPLAY='Inicio'
,
ICON='GO.BMP'
,
IS_STAGE_PROCESS='N'
,
USABLE_IN_FLOW_STAGE='N'
,
ENTITY_ID=null,
MULTI_INSTANCE='R'
,
IS_COUNTABLE='N'
,
NOTIFICATION_ID=null,
VIEWABLE='N'
,
DEFAULT_PRIORITY_ID=null,
INITIAL_NOTIFY_TIME=null,
IS_ADMIN_PROCESS='N'
,
ASSIGN_NOTIFICATION_ID=null,
ASSIGNED_USER_ONLY=null
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100559_.tb2_0(4);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100559_.tb2_0(4),
EXP_PROCESS_100559_.tb2_1(4),
EXP_PROCESS_100559_.tb2_2(4),
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_283'
,
'Inicio'
,
'Inicio'
,
'GO.BMP'
,
'N'
,
'N'
,
null,
'R'
,
'N'
,
null,
'N'
,
null,
null,
'N'
,
null,
null);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb4_0(2):=1;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (2)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100559_.tb4_0(2),
DESCRIPTION='Arranque'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100559_.tb4_0(2);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100559_.tb4_0(2),
'Arranque'
);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb5_0(4):=102698;
EXP_PROCESS_100559_.tb5_1(4):=EXP_PROCESS_100559_.tb5_0(0);
EXP_PROCESS_100559_.tb5_2(4):=EXP_PROCESS_100559_.tb2_0(4);
EXP_PROCESS_100559_.tb5_3(4):=EXP_PROCESS_100559_.tb4_0(2);
EXP_PROCESS_100559_.tb5_4(4):=EXP_PROCESS_100559_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (4)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100559_.tb5_0(4),
PROCESS_ID=EXP_PROCESS_100559_.tb5_1(4),
UNIT_TYPE_ID=EXP_PROCESS_100559_.tb5_2(4),
NODE_TYPE_ID=EXP_PROCESS_100559_.tb5_3(4),
MODULE_ID=EXP_PROCESS_100559_.tb5_4(4),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='13
109'
,
DESCRIPTION='Inicio'
,
ONLINE_EXEC_ID=null,
MULTI_INSTANCE='R'
,
SINCRONIC_TIMEOUT=null,
ASINCRONIC_TIMEOUT=null,
FUNCTION_TYPE=null,
IS_COUNTABLE='N'
,
MIN_GROUP_SIZE=null,
EXECUTION_ORDER='A'
,
ANNULATION_ORDER='N'
,
ENTITY_ID=null,
VIEWABLE='N'

 WHERE UNIT_ID = EXP_PROCESS_100559_.tb5_0(4);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100559_.tb5_0(4),
EXP_PROCESS_100559_.tb5_1(4),
EXP_PROCESS_100559_.tb5_2(4),
EXP_PROCESS_100559_.tb5_3(4),
EXP_PROCESS_100559_.tb5_4(4),
null,
null,
null,
null,
'13
109'
,
'Inicio'
,
null,
'R'
,
null,
null,
null,
'N'
,
null,
'A'
,
'N'
,
null,
'N'
);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb8_0(2):=100000848;
EXP_PROCESS_100559_.tb8_1(2):=EXP_PROCESS_100559_.tb5_0(4);
EXP_PROCESS_100559_.tb8_2(2):=EXP_PROCESS_100559_.tb5_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (2)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100559_.tb8_0(2),
ORIGIN_ID=EXP_PROCESS_100559_.tb8_1(2),
TARGET_ID=EXP_PROCESS_100559_.tb8_2(2),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION=null,
EXPRESSION_TYPE=0,
DESCRIPTION=null,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100559_.tb8_0(2);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100559_.tb8_0(2),
EXP_PROCESS_100559_.tb8_1(2),
EXP_PROCESS_100559_.tb8_2(2),
null,
0,
null,
0,
null,
1);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb9_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTE_CLASS fila (0)',1);
UPDATE GE_ATTRIBUTE_CLASS SET ATTRIBUTE_CLASS_ID=EXP_PROCESS_100559_.tb9_0(0),
NAME='De Entitdad'
,
DESCRIPTION='Valores que ser¿n tra¿dos de la tabla base usando old record'

 WHERE ATTRIBUTE_CLASS_ID = EXP_PROCESS_100559_.tb9_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTE_CLASS(ATTRIBUTE_CLASS_ID,NAME,DESCRIPTION) 
VALUES (EXP_PROCESS_100559_.tb9_0(0),
'De Entitdad'
,
'Valores que ser¿n tra¿dos de la tabla base usando old record'
);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb10_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES_TYPE fila (0)',1);
UPDATE GE_ATTRIBUTES_TYPE SET ATTRIBUTE_TYPE_ID=EXP_PROCESS_100559_.tb10_0(0),
DESCRIPTION='NUMBER'
,
INTERNAL_TYPE=2,
INTERNAL_JAVA_TYPE=2
 WHERE ATTRIBUTE_TYPE_ID = EXP_PROCESS_100559_.tb10_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES_TYPE(ATTRIBUTE_TYPE_ID,DESCRIPTION,INTERNAL_TYPE,INTERNAL_JAVA_TYPE) 
VALUES (EXP_PROCESS_100559_.tb10_0(0),
'NUMBER'
,
2,
2);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb11_0(0):=400;
EXP_PROCESS_100559_.tb11_1(0):=EXP_PROCESS_100559_.tb9_0(0);
EXP_PROCESS_100559_.tb11_2(0):=EXP_PROCESS_100559_.tb10_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (0)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=EXP_PROCESS_100559_.tb11_0(0),
ATTRIBUTE_CLASS_ID=EXP_PROCESS_100559_.tb11_1(0),
ATTRIBUTE_TYPE_ID=EXP_PROCESS_100559_.tb11_2(0),
VALID_EXPRESSION=null,
FATHER_ID=null,
MODULE_ID=9,
NAME_ATTRIBUTE='CAUSAL'
,
LENGTH=4,
PRECISION=null,
SCALE=null,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE='T'
,
COMMENT_='Causal'
,
DISPLAY_NAME='Causal'

 WHERE ATTRIBUTE_ID = EXP_PROCESS_100559_.tb11_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,ATTRIBUTE_CLASS_ID,ATTRIBUTE_TYPE_ID,VALID_EXPRESSION,FATHER_ID,MODULE_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (EXP_PROCESS_100559_.tb11_0(0),
EXP_PROCESS_100559_.tb11_1(0),
EXP_PROCESS_100559_.tb11_2(0),
null,
null,
9,
'CAUSAL'
,
4,
null,
null,
null,
'T'
,
'Causal'
,
'Causal'
);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb12_0(0):=100000882;
EXP_PROCESS_100559_.tb12_1(0):=EXP_PROCESS_100559_.tb5_0(1);
EXP_PROCESS_100559_.tb12_2(0):=EXP_PROCESS_100559_.tb11_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (0)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100559_.tb12_0(0),
UNIT_ID=EXP_PROCESS_100559_.tb12_1(0),
ATTRIBUTE_ID=EXP_PROCESS_100559_.tb12_2(0),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='Y'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100559_.tb12_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100559_.tb12_0(0),
EXP_PROCESS_100559_.tb12_1(0),
EXP_PROCESS_100559_.tb12_2(0),
null,
null,
'N'
,
2,
'Y'
);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb2_0(6):=100567;
EXP_PROCESS_100559_.tb2_1(6):=EXP_PROCESS_100559_.tb0_0(1);
EXP_PROCESS_100559_.tb2_2(6):=EXP_PROCESS_100559_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (6)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100559_.tb2_0(6),
CATEGORY_ID=EXP_PROCESS_100559_.tb2_1(6),
MODULE_ID=EXP_PROCESS_100559_.tb2_2(6),
ACTION_ID=null,
PARENT_ID=983,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_100567'
,
DESCRIPTION='Espera que el pago ingrese'
,
DISPLAY='Espera que el pago ingrese'
,
ICON=null,
IS_STAGE_PROCESS='N'
,
USABLE_IN_FLOW_STAGE='N'
,
ENTITY_ID=null,
MULTI_INSTANCE='R'
,
IS_COUNTABLE='N'
,
NOTIFICATION_ID=null,
VIEWABLE='N'
,
DEFAULT_PRIORITY_ID=null,
INITIAL_NOTIFY_TIME=null,
IS_ADMIN_PROCESS='N'
,
ASSIGN_NOTIFICATION_ID=null,
ASSIGNED_USER_ONLY=null
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100559_.tb2_0(6);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100559_.tb2_0(6),
EXP_PROCESS_100559_.tb2_1(6),
EXP_PROCESS_100559_.tb2_2(6),
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_100567'
,
'Espera que el pago ingrese'
,
'Espera que el pago ingrese'
,
null,
'N'
,
'N'
,
null,
'R'
,
'N'
,
null,
'N'
,
null,
null,
'N'
,
null,
null);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb5_0(6):=102768;
EXP_PROCESS_100559_.tb5_1(6):=EXP_PROCESS_100559_.tb5_0(0);
EXP_PROCESS_100559_.tb5_2(6):=EXP_PROCESS_100559_.tb2_0(6);
EXP_PROCESS_100559_.tb5_3(6):=EXP_PROCESS_100559_.tb4_0(1);
EXP_PROCESS_100559_.tb5_4(6):=EXP_PROCESS_100559_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (6)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100559_.tb5_0(6),
PROCESS_ID=EXP_PROCESS_100559_.tb5_1(6),
UNIT_TYPE_ID=EXP_PROCESS_100559_.tb5_2(6),
NODE_TYPE_ID=EXP_PROCESS_100559_.tb5_3(6),
MODULE_ID=EXP_PROCESS_100559_.tb5_4(6),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='183
477'
,
DESCRIPTION='Espera que el pago ingrese'
,
ONLINE_EXEC_ID=null,
MULTI_INSTANCE='R'
,
SINCRONIC_TIMEOUT=null,
ASINCRONIC_TIMEOUT=null,
FUNCTION_TYPE=null,
IS_COUNTABLE='N'
,
MIN_GROUP_SIZE=null,
EXECUTION_ORDER='A'
,
ANNULATION_ORDER='N'
,
ENTITY_ID=null,
VIEWABLE='N'

 WHERE UNIT_ID = EXP_PROCESS_100559_.tb5_0(6);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100559_.tb5_0(6),
EXP_PROCESS_100559_.tb5_1(6),
EXP_PROCESS_100559_.tb5_2(6),
EXP_PROCESS_100559_.tb5_3(6),
EXP_PROCESS_100559_.tb5_4(6),
null,
null,
null,
null,
'183
477'
,
'Espera que el pago ingrese'
,
null,
'R'
,
null,
null,
null,
'N'
,
null,
'A'
,
'N'
,
null,
'N'
);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb8_0(4):=100000864;
EXP_PROCESS_100559_.tb8_1(4):=EXP_PROCESS_100559_.tb5_0(2);
EXP_PROCESS_100559_.tb8_2(4):=EXP_PROCESS_100559_.tb5_0(6);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (4)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100559_.tb8_0(4),
ORIGIN_ID=EXP_PROCESS_100559_.tb8_1(4),
TARGET_ID=EXP_PROCESS_100559_.tb8_2(4),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION=null,
EXPRESSION_TYPE=0,
DESCRIPTION=null,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100559_.tb8_0(4);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100559_.tb8_0(4),
EXP_PROCESS_100559_.tb8_1(4),
EXP_PROCESS_100559_.tb8_2(4),
null,
0,
null,
0,
null,
1);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb2_0(5):=100612;
EXP_PROCESS_100559_.tb2_1(5):=EXP_PROCESS_100559_.tb0_0(1);
EXP_PROCESS_100559_.tb2_2(5):=EXP_PROCESS_100559_.tb1_0(2);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (5)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100559_.tb2_0(5),
CATEGORY_ID=EXP_PROCESS_100559_.tb2_1(5),
MODULE_ID=EXP_PROCESS_100559_.tb2_2(5),
ACTION_ID=null,
PARENT_ID=983,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_100612'
,
DESCRIPTION='Atender Solicitud Reconexion'
,
DISPLAY='Atender Solicitud Reconexion'
,
ICON=null,
IS_STAGE_PROCESS='N'
,
USABLE_IN_FLOW_STAGE='N'
,
ENTITY_ID=null,
MULTI_INSTANCE='R'
,
IS_COUNTABLE='N'
,
NOTIFICATION_ID=null,
VIEWABLE='Y'
,
DEFAULT_PRIORITY_ID=null,
INITIAL_NOTIFY_TIME=null,
IS_ADMIN_PROCESS='N'
,
ASSIGN_NOTIFICATION_ID=null,
ASSIGNED_USER_ONLY=null
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100559_.tb2_0(5);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100559_.tb2_0(5),
EXP_PROCESS_100559_.tb2_1(5),
EXP_PROCESS_100559_.tb2_2(5),
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_100612'
,
'Atender Solicitud Reconexion'
,
'Atender Solicitud Reconexion'
,
null,
'N'
,
'N'
,
null,
'R'
,
'N'
,
null,
'Y'
,
null,
null,
'N'
,
null,
null);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb5_0(5):=102792;
EXP_PROCESS_100559_.tb5_1(5):=EXP_PROCESS_100559_.tb5_0(0);
EXP_PROCESS_100559_.tb5_2(5):=EXP_PROCESS_100559_.tb2_0(5);
EXP_PROCESS_100559_.tb5_3(5):=EXP_PROCESS_100559_.tb4_0(1);
EXP_PROCESS_100559_.tb5_4(5):=EXP_PROCESS_100559_.tb1_0(2);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (5)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100559_.tb5_0(5),
PROCESS_ID=EXP_PROCESS_100559_.tb5_1(5),
UNIT_TYPE_ID=EXP_PROCESS_100559_.tb5_2(5),
NODE_TYPE_ID=EXP_PROCESS_100559_.tb5_3(5),
MODULE_ID=EXP_PROCESS_100559_.tb5_4(5),
ACTION_ID=88,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=9003,
GEOMETRY='791
319'
,
DESCRIPTION='Atender Solicitud Reconexion'
,
ONLINE_EXEC_ID=null,
MULTI_INSTANCE='R'
,
SINCRONIC_TIMEOUT=null,
ASINCRONIC_TIMEOUT=null,
FUNCTION_TYPE=null,
IS_COUNTABLE='N'
,
MIN_GROUP_SIZE=null,
EXECUTION_ORDER='A'
,
ANNULATION_ORDER='N'
,
ENTITY_ID=17,
VIEWABLE='N'

 WHERE UNIT_ID = EXP_PROCESS_100559_.tb5_0(5);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100559_.tb5_0(5),
EXP_PROCESS_100559_.tb5_1(5),
EXP_PROCESS_100559_.tb5_2(5),
EXP_PROCESS_100559_.tb5_3(5),
EXP_PROCESS_100559_.tb5_4(5),
88,
null,
null,
9003,
'791
319'
,
'Atender Solicitud Reconexion'
,
null,
'R'
,
null,
null,
null,
'N'
,
null,
'A'
,
'N'
,
17,
'N'
);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb8_0(3):=100000855;
EXP_PROCESS_100559_.tb8_1(3):=EXP_PROCESS_100559_.tb5_0(3);
EXP_PROCESS_100559_.tb8_2(3):=EXP_PROCESS_100559_.tb5_0(5);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (3)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100559_.tb8_0(3),
ORIGIN_ID=EXP_PROCESS_100559_.tb8_1(3),
TARGET_ID=EXP_PROCESS_100559_.tb8_2(3),
GEOMETRY='855
143'
,
GROUP_ID=0,
EXPRESSION=null,
EXPRESSION_TYPE=0,
DESCRIPTION=null,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100559_.tb8_0(3);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100559_.tb8_0(3),
EXP_PROCESS_100559_.tb8_1(3),
EXP_PROCESS_100559_.tb8_2(3),
'855
143'
,
0,
null,
0,
null,
1);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb12_0(1):=100000883;
EXP_PROCESS_100559_.tb12_1(1):=EXP_PROCESS_100559_.tb5_0(3);
EXP_PROCESS_100559_.tb12_2(1):=EXP_PROCESS_100559_.tb11_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (1)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100559_.tb12_0(1),
UNIT_ID=EXP_PROCESS_100559_.tb12_1(1),
ATTRIBUTE_ID=EXP_PROCESS_100559_.tb12_2(1),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=3,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100559_.tb12_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100559_.tb12_0(1),
EXP_PROCESS_100559_.tb12_1(1),
EXP_PROCESS_100559_.tb12_2(1),
null,
null,
'N'
,
3,
'N'
);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb12_0(2):=100000657;
EXP_PROCESS_100559_.tb12_1(2):=EXP_PROCESS_100559_.tb5_0(4);
EXP_PROCESS_100559_.tb12_2(2):=EXP_PROCESS_100559_.tb11_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (2)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100559_.tb12_0(2),
UNIT_ID=EXP_PROCESS_100559_.tb12_1(2),
ATTRIBUTE_ID=EXP_PROCESS_100559_.tb12_2(2),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100559_.tb12_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100559_.tb12_0(2),
EXP_PROCESS_100559_.tb12_1(2),
EXP_PROCESS_100559_.tb12_2(2),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb2_0(7):=252;
EXP_PROCESS_100559_.tb2_1(7):=EXP_PROCESS_100559_.tb0_0(1);
EXP_PROCESS_100559_.tb2_2(7):=EXP_PROCESS_100559_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (7)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100559_.tb2_0(7),
CATEGORY_ID=EXP_PROCESS_100559_.tb2_1(7),
MODULE_ID=EXP_PROCESS_100559_.tb2_2(7),
ACTION_ID=null,
PARENT_ID=983,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_252'
,
DESCRIPTION='Fin'
,
DISPLAY='Fin'
,
ICON='STOP.BMP'
,
IS_STAGE_PROCESS='N'
,
USABLE_IN_FLOW_STAGE='N'
,
ENTITY_ID=null,
MULTI_INSTANCE='N'
,
IS_COUNTABLE='N'
,
NOTIFICATION_ID=null,
VIEWABLE='N'
,
DEFAULT_PRIORITY_ID=null,
INITIAL_NOTIFY_TIME=null,
IS_ADMIN_PROCESS='N'
,
ASSIGN_NOTIFICATION_ID=null,
ASSIGNED_USER_ONLY=null
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100559_.tb2_0(7);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100559_.tb2_0(7),
EXP_PROCESS_100559_.tb2_1(7),
EXP_PROCESS_100559_.tb2_2(7),
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_252'
,
'Fin'
,
'Fin'
,
'STOP.BMP'
,
'N'
,
'N'
,
null,
'N'
,
'N'
,
null,
'N'
,
null,
null,
'N'
,
null,
null);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb4_0(3):=3;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (3)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100559_.tb4_0(3),
DESCRIPTION='Final'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100559_.tb4_0(3);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100559_.tb4_0(3),
'Final'
);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb5_0(7):=102699;
EXP_PROCESS_100559_.tb5_1(7):=EXP_PROCESS_100559_.tb5_0(0);
EXP_PROCESS_100559_.tb5_2(7):=EXP_PROCESS_100559_.tb2_0(7);
EXP_PROCESS_100559_.tb5_3(7):=EXP_PROCESS_100559_.tb4_0(3);
EXP_PROCESS_100559_.tb5_4(7):=EXP_PROCESS_100559_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (7)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100559_.tb5_0(7),
PROCESS_ID=EXP_PROCESS_100559_.tb5_1(7),
UNIT_TYPE_ID=EXP_PROCESS_100559_.tb5_2(7),
NODE_TYPE_ID=EXP_PROCESS_100559_.tb5_3(7),
MODULE_ID=EXP_PROCESS_100559_.tb5_4(7),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='976
328'
,
DESCRIPTION='Fin'
,
ONLINE_EXEC_ID=null,
MULTI_INSTANCE='R'
,
SINCRONIC_TIMEOUT=null,
ASINCRONIC_TIMEOUT=null,
FUNCTION_TYPE=null,
IS_COUNTABLE='N'
,
MIN_GROUP_SIZE=null,
EXECUTION_ORDER='A'
,
ANNULATION_ORDER='N'
,
ENTITY_ID=null,
VIEWABLE='N'

 WHERE UNIT_ID = EXP_PROCESS_100559_.tb5_0(7);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100559_.tb5_0(7),
EXP_PROCESS_100559_.tb5_1(7),
EXP_PROCESS_100559_.tb5_2(7),
EXP_PROCESS_100559_.tb5_3(7),
EXP_PROCESS_100559_.tb5_4(7),
null,
null,
null,
null,
'976
328'
,
'Fin'
,
null,
'R'
,
null,
null,
null,
'N'
,
null,
'A'
,
'N'
,
null,
'N'
);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb8_0(5):=100000856;
EXP_PROCESS_100559_.tb8_1(5):=EXP_PROCESS_100559_.tb5_0(5);
EXP_PROCESS_100559_.tb8_2(5):=EXP_PROCESS_100559_.tb5_0(7);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (5)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100559_.tb8_0(5),
ORIGIN_ID=EXP_PROCESS_100559_.tb8_1(5),
TARGET_ID=EXP_PROCESS_100559_.tb8_2(5),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION=null,
EXPRESSION_TYPE=0,
DESCRIPTION=null,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100559_.tb8_0(5);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100559_.tb8_0(5),
EXP_PROCESS_100559_.tb8_1(5),
EXP_PROCESS_100559_.tb8_2(5),
null,
0,
null,
0,
null,
1);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb2_0(8):=238;
EXP_PROCESS_100559_.tb2_1(8):=EXP_PROCESS_100559_.tb0_0(1);
EXP_PROCESS_100559_.tb2_2(8):=EXP_PROCESS_100559_.tb1_0(2);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (8)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100559_.tb2_0(8),
CATEGORY_ID=EXP_PROCESS_100559_.tb2_1(8),
MODULE_ID=EXP_PROCESS_100559_.tb2_2(8),
ACTION_ID=null,
PARENT_ID=2277,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_238'
,
DESCRIPTION='Reconectar en Sistema'
,
DISPLAY='Reconectar en Sistema'
,
ICON=null,
IS_STAGE_PROCESS='N'
,
USABLE_IN_FLOW_STAGE='N'
,
ENTITY_ID=null,
MULTI_INSTANCE='R'
,
IS_COUNTABLE='N'
,
NOTIFICATION_ID=null,
VIEWABLE='N'
,
DEFAULT_PRIORITY_ID=null,
INITIAL_NOTIFY_TIME=null,
IS_ADMIN_PROCESS='N'
,
ASSIGN_NOTIFICATION_ID=null,
ASSIGNED_USER_ONLY=null
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100559_.tb2_0(8);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100559_.tb2_0(8),
EXP_PROCESS_100559_.tb2_1(8),
EXP_PROCESS_100559_.tb2_2(8),
null,
2277,
null,
null,
null,
null,
'UNIT_TYPE_238'
,
'Reconectar en Sistema'
,
'Reconectar en Sistema'
,
null,
'N'
,
'N'
,
null,
'R'
,
'N'
,
null,
'N'
,
null,
null,
'N'
,
null,
null);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb5_0(8):=102051;
EXP_PROCESS_100559_.tb5_1(8):=EXP_PROCESS_100559_.tb5_0(0);
EXP_PROCESS_100559_.tb5_2(8):=EXP_PROCESS_100559_.tb2_0(8);
EXP_PROCESS_100559_.tb5_3(8):=EXP_PROCESS_100559_.tb4_0(1);
EXP_PROCESS_100559_.tb5_4(8):=EXP_PROCESS_100559_.tb1_0(2);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (8)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100559_.tb5_0(8),
PROCESS_ID=EXP_PROCESS_100559_.tb5_1(8),
UNIT_TYPE_ID=EXP_PROCESS_100559_.tb5_2(8),
NODE_TYPE_ID=EXP_PROCESS_100559_.tb5_3(8),
MODULE_ID=EXP_PROCESS_100559_.tb5_4(8),
ACTION_ID=8216,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=9000,
GEOMETRY='584
321'
,
DESCRIPTION='Atender Reconexi¿n'
,
ONLINE_EXEC_ID=null,
MULTI_INSTANCE='R'
,
SINCRONIC_TIMEOUT=null,
ASINCRONIC_TIMEOUT=null,
FUNCTION_TYPE=null,
IS_COUNTABLE='N'
,
MIN_GROUP_SIZE=null,
EXECUTION_ORDER='A'
,
ANNULATION_ORDER='N'
,
ENTITY_ID=null,
VIEWABLE='N'

 WHERE UNIT_ID = EXP_PROCESS_100559_.tb5_0(8);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100559_.tb5_0(8),
EXP_PROCESS_100559_.tb5_1(8),
EXP_PROCESS_100559_.tb5_2(8),
EXP_PROCESS_100559_.tb5_3(8),
EXP_PROCESS_100559_.tb5_4(8),
8216,
null,
null,
9000,
'584
321'
,
'Atender Reconexi¿n'
,
null,
'R'
,
null,
null,
null,
'N'
,
null,
'A'
,
'N'
,
null,
'N'
);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb8_0(6):=100000850;
EXP_PROCESS_100559_.tb8_1(6):=EXP_PROCESS_100559_.tb5_0(8);
EXP_PROCESS_100559_.tb8_2(6):=EXP_PROCESS_100559_.tb5_0(5);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (6)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100559_.tb8_0(6),
ORIGIN_ID=EXP_PROCESS_100559_.tb8_1(6),
TARGET_ID=EXP_PROCESS_100559_.tb8_2(6),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION=null,
EXPRESSION_TYPE=0,
DESCRIPTION=null,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100559_.tb8_0(6);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100559_.tb8_0(6),
EXP_PROCESS_100559_.tb8_1(6),
EXP_PROCESS_100559_.tb8_2(6),
null,
0,
null,
0,
null,
1);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb12_0(3):=100000884;
EXP_PROCESS_100559_.tb12_1(3):=EXP_PROCESS_100559_.tb5_0(5);
EXP_PROCESS_100559_.tb12_2(3):=EXP_PROCESS_100559_.tb11_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (3)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100559_.tb12_0(3),
UNIT_ID=EXP_PROCESS_100559_.tb12_1(3),
ATTRIBUTE_ID=EXP_PROCESS_100559_.tb12_2(3),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=3,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100559_.tb12_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100559_.tb12_0(3),
EXP_PROCESS_100559_.tb12_1(3),
EXP_PROCESS_100559_.tb12_2(3),
null,
null,
'N'
,
3,
'N'
);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb2_0(9):=100478;
EXP_PROCESS_100559_.tb2_1(9):=EXP_PROCESS_100559_.tb0_0(1);
EXP_PROCESS_100559_.tb2_2(9):=EXP_PROCESS_100559_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (9)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100559_.tb2_0(9),
CATEGORY_ID=EXP_PROCESS_100559_.tb2_1(9),
MODULE_ID=EXP_PROCESS_100559_.tb2_2(9),
ACTION_ID=null,
PARENT_ID=2277,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_100478'
,
DESCRIPTION='Validar Ingreso de Pago'
,
DISPLAY='Validar Ingreso de Pago'
,
ICON=null,
IS_STAGE_PROCESS='N'
,
USABLE_IN_FLOW_STAGE='N'
,
ENTITY_ID=null,
MULTI_INSTANCE='R'
,
IS_COUNTABLE='N'
,
NOTIFICATION_ID=null,
VIEWABLE='N'
,
DEFAULT_PRIORITY_ID=null,
INITIAL_NOTIFY_TIME=null,
IS_ADMIN_PROCESS='N'
,
ASSIGN_NOTIFICATION_ID=null,
ASSIGNED_USER_ONLY=null
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100559_.tb2_0(9);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100559_.tb2_0(9),
EXP_PROCESS_100559_.tb2_1(9),
EXP_PROCESS_100559_.tb2_2(9),
null,
2277,
null,
null,
null,
null,
'UNIT_TYPE_100478'
,
'Validar Ingreso de Pago'
,
'Validar Ingreso de Pago'
,
null,
'N'
,
'N'
,
null,
'R'
,
'N'
,
null,
'N'
,
null,
null,
'N'
,
null,
null);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb5_0(9):=102175;
EXP_PROCESS_100559_.tb5_1(9):=EXP_PROCESS_100559_.tb5_0(0);
EXP_PROCESS_100559_.tb5_2(9):=EXP_PROCESS_100559_.tb2_0(9);
EXP_PROCESS_100559_.tb5_3(9):=EXP_PROCESS_100559_.tb4_0(1);
EXP_PROCESS_100559_.tb5_4(9):=EXP_PROCESS_100559_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (9)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100559_.tb5_0(9),
PROCESS_ID=EXP_PROCESS_100559_.tb5_1(9),
UNIT_TYPE_ID=EXP_PROCESS_100559_.tb5_2(9),
NODE_TYPE_ID=EXP_PROCESS_100559_.tb5_3(9),
MODULE_ID=EXP_PROCESS_100559_.tb5_4(9),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='395
470'
,
DESCRIPTION='Validar Ingreso de Pago'
,
ONLINE_EXEC_ID=null,
MULTI_INSTANCE='R'
,
SINCRONIC_TIMEOUT=null,
ASINCRONIC_TIMEOUT=null,
FUNCTION_TYPE=null,
IS_COUNTABLE='N'
,
MIN_GROUP_SIZE=null,
EXECUTION_ORDER='A'
,
ANNULATION_ORDER='N'
,
ENTITY_ID=null,
VIEWABLE='N'

 WHERE UNIT_ID = EXP_PROCESS_100559_.tb5_0(9);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100559_.tb5_0(9),
EXP_PROCESS_100559_.tb5_1(9),
EXP_PROCESS_100559_.tb5_2(9),
EXP_PROCESS_100559_.tb5_3(9),
EXP_PROCESS_100559_.tb5_4(9),
null,
null,
null,
null,
'395
470'
,
'Validar Ingreso de Pago'
,
null,
'R'
,
null,
null,
null,
'N'
,
null,
'A'
,
'N'
,
null,
'N'
);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb8_0(7):=100000036;
EXP_PROCESS_100559_.tb8_1(7):=EXP_PROCESS_100559_.tb5_0(6);
EXP_PROCESS_100559_.tb8_2(7):=EXP_PROCESS_100559_.tb5_0(9);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (7)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100559_.tb8_0(7),
ORIGIN_ID=EXP_PROCESS_100559_.tb8_1(7),
TARGET_ID=EXP_PROCESS_100559_.tb8_2(7),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION=null,
EXPRESSION_TYPE=0,
DESCRIPTION=null,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100559_.tb8_0(7);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100559_.tb8_0(7),
EXP_PROCESS_100559_.tb8_1(7),
EXP_PROCESS_100559_.tb8_2(7),
null,
0,
null,
0,
null,
1);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb9_0(1):=8;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTE_CLASS fila (1)',1);
UPDATE GE_ATTRIBUTE_CLASS SET ATTRIBUTE_CLASS_ID=EXP_PROCESS_100559_.tb9_0(1),
NAME='Por Defecto General'
,
DESCRIPTION='Valores que ser¿n utilizados para clasificaci¿n gen¿rica'

 WHERE ATTRIBUTE_CLASS_ID = EXP_PROCESS_100559_.tb9_0(1);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTE_CLASS(ATTRIBUTE_CLASS_ID,NAME,DESCRIPTION) 
VALUES (EXP_PROCESS_100559_.tb9_0(1),
'Por Defecto General'
,
'Valores que ser¿n utilizados para clasificaci¿n gen¿rica'
);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb10_0(1):=3;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES_TYPE fila (1)',1);
UPDATE GE_ATTRIBUTES_TYPE SET ATTRIBUTE_TYPE_ID=EXP_PROCESS_100559_.tb10_0(1),
DESCRIPTION='DATE'
,
INTERNAL_TYPE=12,
INTERNAL_JAVA_TYPE=91
 WHERE ATTRIBUTE_TYPE_ID = EXP_PROCESS_100559_.tb10_0(1);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES_TYPE(ATTRIBUTE_TYPE_ID,DESCRIPTION,INTERNAL_TYPE,INTERNAL_JAVA_TYPE) 
VALUES (EXP_PROCESS_100559_.tb10_0(1),
'DATE'
,
12,
91);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb11_0(1):=406;
EXP_PROCESS_100559_.tb11_1(1):=EXP_PROCESS_100559_.tb9_0(1);
EXP_PROCESS_100559_.tb11_2(1):=EXP_PROCESS_100559_.tb10_0(1);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (1)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=EXP_PROCESS_100559_.tb11_0(1),
ATTRIBUTE_CLASS_ID=EXP_PROCESS_100559_.tb11_1(1),
ATTRIBUTE_TYPE_ID=EXP_PROCESS_100559_.tb11_2(1),
VALID_EXPRESSION=null,
FATHER_ID=null,
MODULE_ID=9,
NAME_ATTRIBUTE='$INITIAL_DATE'
,
LENGTH=null,
PRECISION=null,
SCALE=null,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE='Y'
,
COMMENT_='Fecha a Iniciar'
,
DISPLAY_NAME='Fecha a Iniciar'

 WHERE ATTRIBUTE_ID = EXP_PROCESS_100559_.tb11_0(1);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,ATTRIBUTE_CLASS_ID,ATTRIBUTE_TYPE_ID,VALID_EXPRESSION,FATHER_ID,MODULE_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (EXP_PROCESS_100559_.tb11_0(1),
EXP_PROCESS_100559_.tb11_1(1),
EXP_PROCESS_100559_.tb11_2(1),
null,
null,
9,
'$INITIAL_DATE'
,
null,
null,
null,
null,
'Y'
,
'Fecha a Iniciar'
,
'Fecha a Iniciar'
);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.old_tb13_0(0):=120195442;
EXP_PROCESS_100559_.tb13_0(0):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
EXP_PROCESS_100559_.tb13_0(0):=EXP_PROCESS_100559_.tb13_0(0);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (0)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (EXP_PROCESS_100559_.tb13_0(0),
5,
'Obtiene la fecha Max para que ingrese el pago en el sistema'
,
'SELECT ut_date.fsbstr_date(SYSDATE + ut_convert.fnuchartonumber(
       dald_parameter.fnuGetNumeric_Value('|| chr(39) ||'NUM_DIAS_PENDIENTE_PAGO'|| chr(39) ||'))) INITIAL_DATE FROM DUAL'
,
'Obtiene la fecha Max para que ingrese el pago en el sistema'
);

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb12_0(4):=100000823;
EXP_PROCESS_100559_.tb12_1(4):=EXP_PROCESS_100559_.tb5_0(6);
EXP_PROCESS_100559_.tb12_2(4):=EXP_PROCESS_100559_.tb11_0(1);
EXP_PROCESS_100559_.tb12_3(4):=EXP_PROCESS_100559_.tb13_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (4)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100559_.tb12_0(4),
UNIT_ID=EXP_PROCESS_100559_.tb12_1(4),
ATTRIBUTE_ID=EXP_PROCESS_100559_.tb12_2(4),
STATEMENT_ID=EXP_PROCESS_100559_.tb12_3(4),
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=1,
MANDATORY='Y'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100559_.tb12_0(4);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100559_.tb12_0(4),
EXP_PROCESS_100559_.tb12_1(4),
EXP_PROCESS_100559_.tb12_2(4),
EXP_PROCESS_100559_.tb12_3(4),
null,
'N'
,
1,
'Y'
);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb12_0(8):=100000658;
EXP_PROCESS_100559_.tb12_1(8):=EXP_PROCESS_100559_.tb5_0(7);
EXP_PROCESS_100559_.tb12_2(8):=EXP_PROCESS_100559_.tb11_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (8)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100559_.tb12_0(8),
UNIT_ID=EXP_PROCESS_100559_.tb12_1(8),
ATTRIBUTE_ID=EXP_PROCESS_100559_.tb12_2(8),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100559_.tb12_0(8);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100559_.tb12_0(8),
EXP_PROCESS_100559_.tb12_1(8),
EXP_PROCESS_100559_.tb12_2(8),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb12_0(9):=100000659;
EXP_PROCESS_100559_.tb12_1(9):=EXP_PROCESS_100559_.tb5_0(7);
EXP_PROCESS_100559_.tb12_2(9):=EXP_PROCESS_100559_.tb11_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (9)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100559_.tb12_0(9),
UNIT_ID=EXP_PROCESS_100559_.tb12_1(9),
ATTRIBUTE_ID=EXP_PROCESS_100559_.tb12_2(9),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100559_.tb12_0(9);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100559_.tb12_0(9),
EXP_PROCESS_100559_.tb12_1(9),
EXP_PROCESS_100559_.tb12_2(9),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb8_0(8):=100000031;
EXP_PROCESS_100559_.tb8_1(8):=EXP_PROCESS_100559_.tb5_0(9);
EXP_PROCESS_100559_.tb8_2(8):=EXP_PROCESS_100559_.tb5_0(8);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (8)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100559_.tb8_0(8),
ORIGIN_ID=EXP_PROCESS_100559_.tb8_1(8),
TARGET_ID=EXP_PROCESS_100559_.tb8_2(8),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION='FLAG_VALIDATE == 1'
,
EXPRESSION_TYPE=0,
DESCRIPTION='Ingres¿ pago'
,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100559_.tb8_0(8);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100559_.tb8_0(8),
EXP_PROCESS_100559_.tb8_1(8),
EXP_PROCESS_100559_.tb8_2(8),
null,
0,
'FLAG_VALIDATE == 1'
,
0,
'Ingres¿ pago'
,
1);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb2_0(11):=100379;
EXP_PROCESS_100559_.tb2_1(11):=EXP_PROCESS_100559_.tb0_0(1);
EXP_PROCESS_100559_.tb2_2(11):=EXP_PROCESS_100559_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (11)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100559_.tb2_0(11),
CATEGORY_ID=EXP_PROCESS_100559_.tb2_1(11),
MODULE_ID=EXP_PROCESS_100559_.tb2_2(11),
ACTION_ID=null,
PARENT_ID=2277,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_100379'
,
DESCRIPTION='Espera que el pago ingrese'
,
DISPLAY='Espera que el pago ingrese'
,
ICON=null,
IS_STAGE_PROCESS='N'
,
USABLE_IN_FLOW_STAGE='N'
,
ENTITY_ID=null,
MULTI_INSTANCE='R'
,
IS_COUNTABLE='N'
,
NOTIFICATION_ID=null,
VIEWABLE='N'
,
DEFAULT_PRIORITY_ID=null,
INITIAL_NOTIFY_TIME=null,
IS_ADMIN_PROCESS='N'
,
ASSIGN_NOTIFICATION_ID=null,
ASSIGNED_USER_ONLY=null
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100559_.tb2_0(11);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100559_.tb2_0(11),
EXP_PROCESS_100559_.tb2_1(11),
EXP_PROCESS_100559_.tb2_2(11),
null,
2277,
null,
null,
null,
null,
'UNIT_TYPE_100379'
,
'Espera que el pago ingrese'
,
'Espera que el pago ingrese'
,
null,
'N'
,
'N'
,
null,
'R'
,
'N'
,
null,
'N'
,
null,
null,
'N'
,
null,
null);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb5_0(11):=102085;
EXP_PROCESS_100559_.tb5_1(11):=EXP_PROCESS_100559_.tb5_0(0);
EXP_PROCESS_100559_.tb5_2(11):=EXP_PROCESS_100559_.tb2_0(11);
EXP_PROCESS_100559_.tb5_3(11):=EXP_PROCESS_100559_.tb4_0(1);
EXP_PROCESS_100559_.tb5_4(11):=EXP_PROCESS_100559_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (11)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100559_.tb5_0(11),
PROCESS_ID=EXP_PROCESS_100559_.tb5_1(11),
UNIT_TYPE_ID=EXP_PROCESS_100559_.tb5_2(11),
NODE_TYPE_ID=EXP_PROCESS_100559_.tb5_3(11),
MODULE_ID=EXP_PROCESS_100559_.tb5_4(11),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='385
203'
,
DESCRIPTION='Espera que el pago ingrese'
,
ONLINE_EXEC_ID=null,
MULTI_INSTANCE='R'
,
SINCRONIC_TIMEOUT=null,
ASINCRONIC_TIMEOUT=null,
FUNCTION_TYPE=null,
IS_COUNTABLE='N'
,
MIN_GROUP_SIZE=null,
EXECUTION_ORDER='A'
,
ANNULATION_ORDER='N'
,
ENTITY_ID=null,
VIEWABLE='N'

 WHERE UNIT_ID = EXP_PROCESS_100559_.tb5_0(11);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100559_.tb5_0(11),
EXP_PROCESS_100559_.tb5_1(11),
EXP_PROCESS_100559_.tb5_2(11),
EXP_PROCESS_100559_.tb5_3(11),
EXP_PROCESS_100559_.tb5_4(11),
null,
null,
null,
null,
'385
203'
,
'Espera que el pago ingrese'
,
null,
'R'
,
null,
null,
null,
'N'
,
null,
'A'
,
'N'
,
null,
'N'
);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb8_0(10):=100000030;
EXP_PROCESS_100559_.tb8_1(10):=EXP_PROCESS_100559_.tb5_0(11);
EXP_PROCESS_100559_.tb8_2(10):=EXP_PROCESS_100559_.tb5_0(8);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (10)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100559_.tb8_0(10),
ORIGIN_ID=EXP_PROCESS_100559_.tb8_1(10),
TARGET_ID=EXP_PROCESS_100559_.tb8_2(10),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION=null,
EXPRESSION_TYPE=0,
DESCRIPTION=null,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100559_.tb8_0(10);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100559_.tb8_0(10),
EXP_PROCESS_100559_.tb8_1(10),
EXP_PROCESS_100559_.tb8_2(10),
null,
0,
null,
0,
null,
1);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb12_0(6):=100000885;
EXP_PROCESS_100559_.tb12_1(6):=EXP_PROCESS_100559_.tb5_0(8);
EXP_PROCESS_100559_.tb12_2(6):=EXP_PROCESS_100559_.tb11_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (6)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100559_.tb12_0(6),
UNIT_ID=EXP_PROCESS_100559_.tb12_1(6),
ATTRIBUTE_ID=EXP_PROCESS_100559_.tb12_2(6),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=3,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100559_.tb12_0(6);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100559_.tb12_0(6),
EXP_PROCESS_100559_.tb12_1(6),
EXP_PROCESS_100559_.tb12_2(6),
null,
null,
'N'
,
3,
'N'
);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb2_0(10):=100563;
EXP_PROCESS_100559_.tb2_1(10):=EXP_PROCESS_100559_.tb0_0(2);
EXP_PROCESS_100559_.tb2_2(10):=EXP_PROCESS_100559_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (10)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100559_.tb2_0(10),
CATEGORY_ID=EXP_PROCESS_100559_.tb2_1(10),
MODULE_ID=EXP_PROCESS_100559_.tb2_2(10),
ACTION_ID=null,
PARENT_ID=983,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_100563'
,
DESCRIPTION='Generar Orden a Recaudo'
,
DISPLAY='Generar Orden a Recaudo'
,
ICON=null,
IS_STAGE_PROCESS='N'
,
USABLE_IN_FLOW_STAGE='N'
,
ENTITY_ID=null,
MULTI_INSTANCE='R'
,
IS_COUNTABLE='N'
,
NOTIFICATION_ID=null,
VIEWABLE='N'
,
DEFAULT_PRIORITY_ID=null,
INITIAL_NOTIFY_TIME=null,
IS_ADMIN_PROCESS='N'
,
ASSIGN_NOTIFICATION_ID=null,
ASSIGNED_USER_ONLY=null
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100559_.tb2_0(10);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100559_.tb2_0(10),
EXP_PROCESS_100559_.tb2_1(10),
EXP_PROCESS_100559_.tb2_2(10),
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_100563'
,
'Generar Orden a Recaudo'
,
'Generar Orden a Recaudo'
,
null,
'N'
,
'N'
,
null,
'R'
,
'N'
,
null,
'N'
,
null,
null,
'N'
,
null,
null);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb5_0(10):=102719;
EXP_PROCESS_100559_.tb5_1(10):=EXP_PROCESS_100559_.tb5_0(0);
EXP_PROCESS_100559_.tb5_2(10):=EXP_PROCESS_100559_.tb2_0(10);
EXP_PROCESS_100559_.tb5_3(10):=EXP_PROCESS_100559_.tb4_0(1);
EXP_PROCESS_100559_.tb5_4(10):=EXP_PROCESS_100559_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (10)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100559_.tb5_0(10),
PROCESS_ID=EXP_PROCESS_100559_.tb5_1(10),
UNIT_TYPE_ID=EXP_PROCESS_100559_.tb5_2(10),
NODE_TYPE_ID=EXP_PROCESS_100559_.tb5_3(10),
MODULE_ID=EXP_PROCESS_100559_.tb5_4(10),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='384
339'
,
DESCRIPTION='Generar Orden a Cartera'
,
ONLINE_EXEC_ID=null,
MULTI_INSTANCE='R'
,
SINCRONIC_TIMEOUT=null,
ASINCRONIC_TIMEOUT=null,
FUNCTION_TYPE=null,
IS_COUNTABLE='N'
,
MIN_GROUP_SIZE=null,
EXECUTION_ORDER='A'
,
ANNULATION_ORDER='N'
,
ENTITY_ID=null,
VIEWABLE='N'

 WHERE UNIT_ID = EXP_PROCESS_100559_.tb5_0(10);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100559_.tb5_0(10),
EXP_PROCESS_100559_.tb5_1(10),
EXP_PROCESS_100559_.tb5_2(10),
EXP_PROCESS_100559_.tb5_3(10),
EXP_PROCESS_100559_.tb5_4(10),
null,
null,
null,
null,
'384
339'
,
'Generar Orden a Cartera'
,
null,
'R'
,
null,
null,
null,
'N'
,
null,
'A'
,
'N'
,
null,
'N'
);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb8_0(9):=100000032;
EXP_PROCESS_100559_.tb8_1(9):=EXP_PROCESS_100559_.tb5_0(9);
EXP_PROCESS_100559_.tb8_2(9):=EXP_PROCESS_100559_.tb5_0(10);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (9)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100559_.tb8_0(9),
ORIGIN_ID=EXP_PROCESS_100559_.tb8_1(9),
TARGET_ID=EXP_PROCESS_100559_.tb8_2(9),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION='FLAG_VALIDATE == 0'
,
EXPRESSION_TYPE=0,
DESCRIPTION='No ingres¿ el pago'
,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100559_.tb8_0(9);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100559_.tb8_0(9),
EXP_PROCESS_100559_.tb8_1(9),
EXP_PROCESS_100559_.tb8_2(9),
null,
0,
'FLAG_VALIDATE == 0'
,
0,
'No ingres¿ el pago'
,
1);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb11_0(2):=442;
EXP_PROCESS_100559_.tb11_1(2):=EXP_PROCESS_100559_.tb9_0(1);
EXP_PROCESS_100559_.tb11_2(2):=EXP_PROCESS_100559_.tb10_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (2)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=EXP_PROCESS_100559_.tb11_0(2),
ATTRIBUTE_CLASS_ID=EXP_PROCESS_100559_.tb11_1(2),
ATTRIBUTE_TYPE_ID=EXP_PROCESS_100559_.tb11_2(2),
VALID_EXPRESSION=null,
FATHER_ID=null,
MODULE_ID=9,
NAME_ATTRIBUTE='FLAG_VALIDATE'
,
LENGTH=null,
PRECISION=null,
SCALE=null,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE=null,
COMMENT_='Bandera de validaci¿n'
,
DISPLAY_NAME='Bandera de validaci¿n para la ejecuci¿n de transicciones'

 WHERE ATTRIBUTE_ID = EXP_PROCESS_100559_.tb11_0(2);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,ATTRIBUTE_CLASS_ID,ATTRIBUTE_TYPE_ID,VALID_EXPRESSION,FATHER_ID,MODULE_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (EXP_PROCESS_100559_.tb11_0(2),
EXP_PROCESS_100559_.tb11_1(2),
EXP_PROCESS_100559_.tb11_2(2),
null,
null,
9,
'FLAG_VALIDATE'
,
null,
null,
null,
null,
null,
'Bandera de validaci¿n'
,
'Bandera de validaci¿n para la ejecuci¿n de transicciones'
);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.old_tb13_0(1):=120195443;
EXP_PROCESS_100559_.tb13_0(1):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
EXP_PROCESS_100559_.tb13_0(1):=EXP_PROCESS_100559_.tb13_0(1);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (1)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (EXP_PROCESS_100559_.tb13_0(1),
16,
'LDC - Valida pago cuenta'
,
'SELECT LDC_BORECONECION.fsbValidaPago(:INST.EXTERNAL_ID:) FLAG_VALIDATE FROM DUAL'
,
'LDC - Valida pago de cuenta'
);

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb12_0(5):=100000113;
EXP_PROCESS_100559_.tb12_1(5):=EXP_PROCESS_100559_.tb5_0(9);
EXP_PROCESS_100559_.tb12_2(5):=EXP_PROCESS_100559_.tb11_0(2);
EXP_PROCESS_100559_.tb12_3(5):=EXP_PROCESS_100559_.tb13_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (5)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100559_.tb12_0(5),
UNIT_ID=EXP_PROCESS_100559_.tb12_1(5),
ATTRIBUTE_ID=EXP_PROCESS_100559_.tb12_2(5),
STATEMENT_ID=EXP_PROCESS_100559_.tb12_3(5),
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='Y'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100559_.tb12_0(5);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100559_.tb12_0(5),
EXP_PROCESS_100559_.tb12_1(5),
EXP_PROCESS_100559_.tb12_2(5),
EXP_PROCESS_100559_.tb12_3(5),
null,
'N'
,
2,
'Y'
);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb8_0(11):=100000029;
EXP_PROCESS_100559_.tb8_1(11):=EXP_PROCESS_100559_.tb5_0(10);
EXP_PROCESS_100559_.tb8_2(11):=EXP_PROCESS_100559_.tb5_0(11);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (11)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100559_.tb8_0(11),
ORIGIN_ID=EXP_PROCESS_100559_.tb8_1(11),
TARGET_ID=EXP_PROCESS_100559_.tb8_2(11),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION=null,
EXPRESSION_TYPE=0,
DESCRIPTION=null,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100559_.tb8_0(11);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100559_.tb8_0(11),
EXP_PROCESS_100559_.tb8_1(11),
EXP_PROCESS_100559_.tb8_2(11),
null,
0,
null,
0,
null,
1);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.old_tb13_0(2):=120195444;
EXP_PROCESS_100559_.tb13_0(2):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
EXP_PROCESS_100559_.tb13_0(2):=EXP_PROCESS_100559_.tb13_0(2);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (2)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (EXP_PROCESS_100559_.tb13_0(2),
5,
'Obtiene la fecha Max para que ingrese el pago en el sistema'
,
'SELECT ut_date.fsbstr_date(SYSDATE + ut_convert.fnuchartonumber(
       dald_parameter.fnuGetNumeric_Value('|| chr(39) ||'NUM_DIAS_PENDIENTE_RECAUDO'|| chr(39) ||'))) INITIAL_DATE FROM DUAL'
,
'Obtiene la fecha Max para que ingrese el pago en el sistema'
);

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb12_0(7):=100000105;
EXP_PROCESS_100559_.tb12_1(7):=EXP_PROCESS_100559_.tb5_0(11);
EXP_PROCESS_100559_.tb12_2(7):=EXP_PROCESS_100559_.tb11_0(1);
EXP_PROCESS_100559_.tb12_3(7):=EXP_PROCESS_100559_.tb13_0(2);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (7)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100559_.tb12_0(7),
UNIT_ID=EXP_PROCESS_100559_.tb12_1(7),
ATTRIBUTE_ID=EXP_PROCESS_100559_.tb12_2(7),
STATEMENT_ID=EXP_PROCESS_100559_.tb12_3(7),
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=1,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100559_.tb12_0(7);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100559_.tb12_0(7),
EXP_PROCESS_100559_.tb12_1(7),
EXP_PROCESS_100559_.tb12_2(7),
EXP_PROCESS_100559_.tb12_3(7),
null,
'N'
,
1,
'N'
);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.old_tb13_0(3):=120195445;
EXP_PROCESS_100559_.tb13_0(3):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
EXP_PROCESS_100559_.tb13_0(3):=EXP_PROCESS_100559_.tb13_0(3);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (3)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (EXP_PROCESS_100559_.tb13_0(3),
16,
'LDC - Valida pago cuenta'
,
'SELECT LDC_BORECONECION.fsbValidaPago(:INST.EXTERNAL_ID) FLAG_VALIDATE FROM DUAL'
,
'LDC - Valida pago de cuenta'
);

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb12_0(10):=100000820;
EXP_PROCESS_100559_.tb12_1(10):=EXP_PROCESS_100559_.tb5_0(0);
EXP_PROCESS_100559_.tb12_2(10):=EXP_PROCESS_100559_.tb11_0(2);
EXP_PROCESS_100559_.tb12_3(10):=EXP_PROCESS_100559_.tb13_0(3);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (10)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100559_.tb12_0(10),
UNIT_ID=EXP_PROCESS_100559_.tb12_1(10),
ATTRIBUTE_ID=EXP_PROCESS_100559_.tb12_2(10),
STATEMENT_ID=EXP_PROCESS_100559_.tb12_3(10),
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=1,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100559_.tb12_0(10);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100559_.tb12_0(10),
EXP_PROCESS_100559_.tb12_1(10),
EXP_PROCESS_100559_.tb12_2(10),
EXP_PROCESS_100559_.tb12_3(10),
null,
'N'
,
1,
'N'
);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100559_.tb12_0(11):=100000821;
EXP_PROCESS_100559_.tb12_1(11):=EXP_PROCESS_100559_.tb5_0(0);
EXP_PROCESS_100559_.tb12_2(11):=EXP_PROCESS_100559_.tb11_0(1);
EXP_PROCESS_100559_.tb12_3(11):=EXP_PROCESS_100559_.tb13_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (11)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100559_.tb12_0(11),
UNIT_ID=EXP_PROCESS_100559_.tb12_1(11),
ATTRIBUTE_ID=EXP_PROCESS_100559_.tb12_2(11),
STATEMENT_ID=EXP_PROCESS_100559_.tb12_3(11),
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=1,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100559_.tb12_0(11);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100559_.tb12_0(11),
EXP_PROCESS_100559_.tb12_1(11),
EXP_PROCESS_100559_.tb12_2(11),
EXP_PROCESS_100559_.tb12_3(11),
null,
'N'
,
1,
'N'
);
end if;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_UNITTYPE_100559_',
'CREATE OR REPLACE PACKAGE EXP_UNITTYPE_100559_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyWF_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPERowId tyWF_UNIT_TYPERowId;type tyWF_CAUSAL_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_CAUSAL_UNIT_TYPERowId tyWF_CAUSAL_UNIT_TYPERowId;type tyGR_CONFIGURA_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIGURA_TYPERowId tyGR_CONFIGURA_TYPERowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type tyGE_ATTRIBUTE_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTE_CLASSRowId tyGE_ATTRIBUTE_CLASSRowId;type tyGE_ATTRIBUTES_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTES_TYPERowId tyGE_ATTRIBUTES_TYPERowId;type tyGE_ATTRIBUTESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTESRowId tyGE_ATTRIBUTESRowId;type tyGE_STATEMENTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_STATEMENTRowId tyGE_STATEMENTRowId;type tyWF_UNIT_TYPE_ATTRIBRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPE_ATTRIBRowId tyWF_UNIT_TYPE_ATTRIBRowId;type tyMO_TIME_UNI_TYP_PRIORowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbMO_TIME_UNI_TYP_PRIORowId tyMO_TIME_UNI_TYP_PRIORowId;type tyOR_ACT_BY_TASK_MODRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbOR_ACT_BY_TASK_MODRowId tyOR_ACT_BY_TASK_MODRowId;type ty0_0 is table of WF_UNIT_TYPE.UNIT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_5 is table of WF_UNIT_TYPE.INIT_AREA_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_5 ty0_5; ' || chr(10) ||
'tb0_5 ty0_5; ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_UNITTYPE_100559_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_UNITTYPE_100559_******************************'); END;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_UNITTYPE_100559',1);
EXP_UNITTYPE_100559_.blProcessStatus := EXP_PROCESS_100559_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  SELECT  B.object_name
FROM    OR_ACT_BY_TASK_MOD A, GR_CONFIG_EXPRESSION B 
WHERE   A.CONFIG_EXPRESSION_ID = B.CONFIG_EXPRESSION_ID
AND     A.TASK_CODE = 100559
 
;
BEGIN

if (not EXP_UNITTYPE_100559_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_UNITTYPE_100559_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
  nuIndex := nuIndex + 1;
 END LOOP;
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
END;
/

declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_TYPE_ATTRIB WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100559);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100559_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_TYPE_ATTRIB',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_TYPE_ATTRIB WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100559_.blProcessStatus := false;
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
FROM WF_CAUSAL_UNIT_TYPE WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100559);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100559_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_CAUSAL_UNIT_TYPE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_CAUSAL_UNIT_TYPE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100559_.blProcessStatus := false;
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
FROM MO_TIME_UNI_TYP_PRIO WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100559);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100559_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla MO_TIME_UNI_TYP_PRIO',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM MO_TIME_UNI_TYP_PRIO WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100559_.blProcessStatus := false;
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
FROM OR_ACT_BY_TASK_MOD WHERE (TASK_CODE) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100559);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100559_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla OR_ACT_BY_TASK_MOD',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM OR_ACT_BY_TASK_MOD WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100559_.blProcessStatus := false;
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
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100559;
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100559_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_TYPE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_TYPE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_UNITTYPE_100559_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100559_.tb0_0(0):=100559;
ut_trace.trace('insertando tabla sin fallo: WF_UNIT_TYPE fila (0)',1);
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_UNITTYPE_100559_.tb0_0(0),
3,
9,
null,
2277,
null,
null,
null,
null,
'UNIT_TYPE_100559'
,
'LDC - Solicitud Reconexi¿n'
,
'LDC - Solicitud de Reconexi¿n'
,
null,
'N'
,
'N'
,
null,
'R'
,
'N'
,
null,
'N'
,
null,
null,
'N'
,
null,
null);

exception 
when dup_val_on_index then 
 return;
when others then
EXP_UNITTYPE_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100559',1);
EXP_PROCESS_100559_.blProcessStatus := EXP_UNITTYPE_100559_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/

DECLARE
 nuIndex         binary_integer;
 blObjectDeleted boolean;

 FUNCTION fblIsObjectUseByRule
 (
  isbObjectName   IN gr_config_expression.object_name%type
 ) return BOOLEAN
 IS
  nuCounter    NUMBER := 0;
  blReturn     BOOLEAN := FALSE;
 BEGIN
  SELECT count('x') INTO nuCounter
  FROM gr_config_expression
  WHERE object_name = isbObjectName;
  IF (nuCounter > 0) THEN
    BEGIN
      DELETE FROM gr_config_expression
      WHERE object_name = isbObjectName;
      blReturn := FALSE;
    EXCEPTION
      when ex.RECORD_HAVE_CHILDREN then
         ut_trace.trace('Objeto ' || isbObjectName || ' usado en ' || nuCounter ||' reglas, no se borra',2);
         blReturn := TRUE;
    END;
  END IF;
  RETURN blReturn;
 END;

BEGIN
 ut_trace.trace('Inicia borrado de objetos de reglas',1);
 nuIndex := EXP_UNITTYPE_100559_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_UNITTYPE_100559_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_UNITTYPE_100559_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_UNITTYPE_100559_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_UNITTYPE_100559_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_UNITTYPE_100559_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_UNITTYPE_100559_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_UNITTYPE_100559_.tbObjectToDelete.next(nuIndex);
 END loop;
 ut_trace.trace('Finaliza borrado de objetos de reglas',1);
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('EXP_UNITTYPE_100559_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_UNITTYPE_100559_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_UNITTYPE_100561_',
'CREATE OR REPLACE PACKAGE EXP_UNITTYPE_100561_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyWF_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPERowId tyWF_UNIT_TYPERowId;type tyWF_CAUSAL_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_CAUSAL_UNIT_TYPERowId tyWF_CAUSAL_UNIT_TYPERowId;type tyGR_CONFIGURA_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIGURA_TYPERowId tyGR_CONFIGURA_TYPERowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type tyGE_ATTRIBUTE_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTE_CLASSRowId tyGE_ATTRIBUTE_CLASSRowId;type tyGE_ATTRIBUTES_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTES_TYPERowId tyGE_ATTRIBUTES_TYPERowId;type tyGE_ATTRIBUTESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTESRowId tyGE_ATTRIBUTESRowId;type tyGE_STATEMENTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_STATEMENTRowId tyGE_STATEMENTRowId;type tyWF_UNIT_TYPE_ATTRIBRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPE_ATTRIBRowId tyWF_UNIT_TYPE_ATTRIBRowId;type tyMO_TIME_UNI_TYP_PRIORowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbMO_TIME_UNI_TYP_PRIORowId tyMO_TIME_UNI_TYP_PRIORowId;type tyOR_ACT_BY_TASK_MODRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbOR_ACT_BY_TASK_MODRowId tyOR_ACT_BY_TASK_MODRowId;type ty0_0 is table of WF_UNIT_TYPE.UNIT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_5 is table of WF_UNIT_TYPE.INIT_AREA_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_5 ty0_5; ' || chr(10) ||
'tb0_5 ty0_5;type ty1_0 is table of GE_ATTRIBUTE_CLASS.ATTRIBUTE_CLASS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_0 ty1_0; ' || chr(10) ||
'tb1_0 ty1_0;type ty2_0 is table of GE_ATTRIBUTES_TYPE.ATTRIBUTE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;type ty3_0 is table of GE_ATTRIBUTES.ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_0 ty3_0; ' || chr(10) ||
'tb3_0 ty3_0;type ty3_1 is table of GE_ATTRIBUTES.ATTRIBUTE_CLASS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_1 ty3_1; ' || chr(10) ||
'tb3_1 ty3_1;type ty3_2 is table of GE_ATTRIBUTES.ATTRIBUTE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_2 ty3_2; ' || chr(10) ||
'tb3_2 ty3_2;type ty3_3 is table of GE_ATTRIBUTES.VALID_EXPRESSION%type index by binary_integer; ' || chr(10) ||
'old_tb3_3 ty3_3; ' || chr(10) ||
'tb3_3 ty3_3;type ty4_0 is table of WF_UNIT_TYPE_ATTRIB.UNIT_TYPE_ATTRIB_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_0 ty4_0; ' || chr(10) ||
'tb4_0 ty4_0;type ty4_1 is table of WF_UNIT_TYPE_ATTRIB.UNIT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_1 ty4_1; ' || chr(10) ||
'tb4_1 ty4_1;type ty4_2 is table of WF_UNIT_TYPE_ATTRIB.ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_2 ty4_2; ' || chr(10) ||
'tb4_2 ty4_2;type ty4_3 is table of WF_UNIT_TYPE_ATTRIB.STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_3 ty4_3; ' || chr(10) ||
'tb4_3 ty4_3;type ty5_0 is table of WF_CAUSAL_UNIT_TYPE.CAUSAL_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_0 ty5_0; ' || chr(10) ||
'tb5_0 ty5_0;type ty5_1 is table of WF_CAUSAL_UNIT_TYPE.UNIT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_1 ty5_1; ' || chr(10) ||
'tb5_1 ty5_1;type ty6_0 is table of GR_CONFIGURA_TYPE.CONFIGURA_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_0 ty6_0; ' || chr(10) ||
'tb6_0 ty6_0;type ty7_0 is table of GR_CONFIG_EXPRESSION.CONFIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_0 ty7_0; ' || chr(10) ||
'tb7_0 ty7_0;type ty7_1 is table of GR_CONFIG_EXPRESSION.OBJECT_NAME%type index by binary_integer; ' || chr(10) ||
'old_tb7_1 ty7_1; ' || chr(10) ||
'tb7_1 ty7_1;type ty7_2 is table of GR_CONFIG_EXPRESSION.CONFIGURA_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_2 ty7_2; ' || chr(10) ||
'tb7_2 ty7_2;type ty8_0 is table of OR_ACT_BY_TASK_MOD.ACT_BY_TASK_MOD_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_0 ty8_0; ' || chr(10) ||
'tb8_0 ty8_0;type ty8_1 is table of OR_ACT_BY_TASK_MOD.TASK_CODE%type index by binary_integer; ' || chr(10) ||
'old_tb8_1 ty8_1; ' || chr(10) ||
'tb8_1 ty8_1;type ty8_2 is table of OR_ACT_BY_TASK_MOD.CONFIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_2 ty8_2; ' || chr(10) ||
'tb8_2 ty8_2; ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_UNITTYPE_100561_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_UNITTYPE_100561_******************************'); END;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_UNITTYPE_100561',1);
EXP_UNITTYPE_100561_.blProcessStatus := EXP_PROCESS_100559_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  SELECT  B.object_name
FROM    OR_ACT_BY_TASK_MOD A, GR_CONFIG_EXPRESSION B 
WHERE   A.CONFIG_EXPRESSION_ID = B.CONFIG_EXPRESSION_ID
AND     A.TASK_CODE = 100561
 
;
BEGIN

if (not EXP_UNITTYPE_100561_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_UNITTYPE_100561_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
  nuIndex := nuIndex + 1;
 END LOOP;
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
END;
/

declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_TYPE_ATTRIB WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100561);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100561_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_TYPE_ATTRIB',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_TYPE_ATTRIB WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100561_.blProcessStatus := false;
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
FROM WF_CAUSAL_UNIT_TYPE WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100561);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100561_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_CAUSAL_UNIT_TYPE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_CAUSAL_UNIT_TYPE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100561_.blProcessStatus := false;
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
FROM MO_TIME_UNI_TYP_PRIO WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100561);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100561_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla MO_TIME_UNI_TYP_PRIO',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM MO_TIME_UNI_TYP_PRIO WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100561_.blProcessStatus := false;
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
FROM OR_ACT_BY_TASK_MOD WHERE (TASK_CODE) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100561);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100561_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla OR_ACT_BY_TASK_MOD',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM OR_ACT_BY_TASK_MOD WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100561_.blProcessStatus := false;
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
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100561;
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100561_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_TYPE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_TYPE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100561_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_UNITTYPE_100561_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100561_.tb0_0(0):=100561;
ut_trace.trace('insertando tabla sin fallo: WF_UNIT_TYPE fila (0)',1);
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_UNITTYPE_100561_.tb0_0(0),
2,
4,
100,
983,
null,
null,
null,
null,
'UNIT_TYPE_100561'
,
'Genera orden Reconexion'
,
'Genera orden Reconexion'
,
null,
'N'
,
'N'
,
null,
'N'
,
'N'
,
9011,
'N'
,
null,
null,
'N'
,
null,
null);

exception 
when dup_val_on_index then 
 return;
when others then
EXP_UNITTYPE_100561_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_100561_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100561_.tb1_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTE_CLASS fila (0)',1);
UPDATE GE_ATTRIBUTE_CLASS SET ATTRIBUTE_CLASS_ID=EXP_UNITTYPE_100561_.tb1_0(0),
NAME='De Entitdad'
,
DESCRIPTION='Valores que ser¿n tra¿dos de la tabla base usando old record'

 WHERE ATTRIBUTE_CLASS_ID = EXP_UNITTYPE_100561_.tb1_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTE_CLASS(ATTRIBUTE_CLASS_ID,NAME,DESCRIPTION) 
VALUES (EXP_UNITTYPE_100561_.tb1_0(0),
'De Entitdad'
,
'Valores que ser¿n tra¿dos de la tabla base usando old record'
);
end if;

exception when others then
EXP_UNITTYPE_100561_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_100561_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100561_.tb2_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES_TYPE fila (0)',1);
UPDATE GE_ATTRIBUTES_TYPE SET ATTRIBUTE_TYPE_ID=EXP_UNITTYPE_100561_.tb2_0(0),
DESCRIPTION='NUMBER'
,
INTERNAL_TYPE=2,
INTERNAL_JAVA_TYPE=2
 WHERE ATTRIBUTE_TYPE_ID = EXP_UNITTYPE_100561_.tb2_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES_TYPE(ATTRIBUTE_TYPE_ID,DESCRIPTION,INTERNAL_TYPE,INTERNAL_JAVA_TYPE) 
VALUES (EXP_UNITTYPE_100561_.tb2_0(0),
'NUMBER'
,
2,
2);
end if;

exception when others then
EXP_UNITTYPE_100561_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_100561_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100561_.tb3_0(0):=400;
EXP_UNITTYPE_100561_.tb3_1(0):=EXP_UNITTYPE_100561_.tb1_0(0);
EXP_UNITTYPE_100561_.tb3_2(0):=EXP_UNITTYPE_100561_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (0)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=EXP_UNITTYPE_100561_.tb3_0(0),
ATTRIBUTE_CLASS_ID=EXP_UNITTYPE_100561_.tb3_1(0),
ATTRIBUTE_TYPE_ID=EXP_UNITTYPE_100561_.tb3_2(0),
VALID_EXPRESSION=null,
FATHER_ID=null,
MODULE_ID=9,
NAME_ATTRIBUTE='CAUSAL'
,
LENGTH=4,
PRECISION=null,
SCALE=null,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE='T'
,
COMMENT_='Causal'
,
DISPLAY_NAME='Causal'

 WHERE ATTRIBUTE_ID = EXP_UNITTYPE_100561_.tb3_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,ATTRIBUTE_CLASS_ID,ATTRIBUTE_TYPE_ID,VALID_EXPRESSION,FATHER_ID,MODULE_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (EXP_UNITTYPE_100561_.tb3_0(0),
EXP_UNITTYPE_100561_.tb3_1(0),
EXP_UNITTYPE_100561_.tb3_2(0),
null,
null,
9,
'CAUSAL'
,
4,
null,
null,
null,
'T'
,
'Causal'
,
'Causal'
);
end if;

exception when others then
EXP_UNITTYPE_100561_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_100561_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100561_.tb4_0(0):=100000044;
EXP_UNITTYPE_100561_.tb4_1(0):=EXP_UNITTYPE_100561_.tb0_0(0);
EXP_UNITTYPE_100561_.tb4_2(0):=EXP_UNITTYPE_100561_.tb3_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE_ATTRIB fila (0)',1);
UPDATE WF_UNIT_TYPE_ATTRIB SET UNIT_TYPE_ATTRIB_ID=EXP_UNITTYPE_100561_.tb4_0(0),
UNIT_TYPE_ID=EXP_UNITTYPE_100561_.tb4_1(0),
ATTRIBUTE_ID=EXP_UNITTYPE_100561_.tb4_2(0),
STATEMENT_ID=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='Y'

 WHERE UNIT_TYPE_ATTRIB_ID = EXP_UNITTYPE_100561_.tb4_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE_ATTRIB(UNIT_TYPE_ATTRIB_ID,UNIT_TYPE_ID,ATTRIBUTE_ID,STATEMENT_ID,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_UNITTYPE_100561_.tb4_0(0),
EXP_UNITTYPE_100561_.tb4_1(0),
EXP_UNITTYPE_100561_.tb4_2(0),
null,
'N'
,
2,
'Y'
);
end if;

exception when others then
EXP_UNITTYPE_100561_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_100561_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100561_.tb5_0(0):=930;
EXP_UNITTYPE_100561_.tb5_1(0):=EXP_UNITTYPE_100561_.tb0_0(0);
ut_trace.trace('insertando tabla sin fallo: WF_CAUSAL_UNIT_TYPE fila (0)',1);
INSERT INTO WF_CAUSAL_UNIT_TYPE(CAUSAL_ID,UNIT_TYPE_ID,ALIAS) 
VALUES (EXP_UNITTYPE_100561_.tb5_0(0),
EXP_UNITTYPE_100561_.tb5_1(0),
'FALLO'
);

exception 
when dup_val_on_index then 
 return;
when others then
EXP_UNITTYPE_100561_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_100561_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100561_.tb5_0(1):=1;
EXP_UNITTYPE_100561_.tb5_1(1):=EXP_UNITTYPE_100561_.tb0_0(0);
ut_trace.trace('insertando tabla sin fallo: WF_CAUSAL_UNIT_TYPE fila (1)',1);
INSERT INTO WF_CAUSAL_UNIT_TYPE(CAUSAL_ID,UNIT_TYPE_ID,ALIAS) 
VALUES (EXP_UNITTYPE_100561_.tb5_0(1),
EXP_UNITTYPE_100561_.tb5_1(1),
'EXITO'
);

exception 
when dup_val_on_index then 
 return;
when others then
EXP_UNITTYPE_100561_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_100561_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100561_.tb6_0(0):=404;
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=EXP_UNITTYPE_100561_.tb6_0(0),
MODULE_ID=4,
DESCRIPTION='Reglas selecci¿n Tipo de Trabajo'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_SEL_TASTYP_'

 WHERE CONFIGURA_TYPE_ID = EXP_UNITTYPE_100561_.tb6_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (EXP_UNITTYPE_100561_.tb6_0(0),
4,
'Reglas selecci¿n Tipo de Trabajo'
,
'PL'
,
'FD'
,
'DS'
,
'_SEL_TASTYP_'
);
end if;

exception when others then
EXP_UNITTYPE_100561_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_100561_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100561_.old_tb7_0(0):=121397101;
EXP_UNITTYPE_100561_.tb7_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
EXP_UNITTYPE_100561_.tb7_0(0):=EXP_UNITTYPE_100561_.tb7_0(0);
EXP_UNITTYPE_100561_.old_tb7_1(0):='OR_SEL_TASTYP_CT404E121397101'
;
EXP_UNITTYPE_100561_.tb7_1(0):=TO_CHAR(EXP_UNITTYPE_100561_.tb7_0(0));
EXP_UNITTYPE_100561_.tb7_2(0):=EXP_UNITTYPE_100561_.tb6_0(0);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (EXP_UNITTYPE_100561_.tb7_0(0),
EXP_UNITTYPE_100561_.tb7_1(0),
EXP_UNITTYPE_100561_.tb7_2(0),
'nuPackageId = OR_BOINSTANCE.FNUGETFATHEXTSYSIDFROMINSTANCE();nuProductId = MO_BOPACKAGES.FNUFINDPRODUCTID(nuPackageId);sbValidaCM = LDC_PKOSSSUPENCMXVALVULA.FSBVALIDANIVELSUPENCIONCM(nuProductId);if (sbValidaCM = "Y",OR_BOINSTANCE.SETSUCCESSININSTANCE();,OR_BOINSTANCE.SETUN_SUCCESSININSTANCE();)'
,
'OPEN'
,
to_date('12-04-2018 18:57:35','DD-MM-YYYY HH24:MI:SS'),
to_date('29-03-2023 09:35:12','DD-MM-YYYY HH24:MI:SS'),
to_date('29-03-2023 09:35:12','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC - Valida si genera actividad segun datos registrados'
,
'PP'
,
null);

exception when others then
EXP_UNITTYPE_100561_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_100561_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100561_.tb8_0(0):=11197;
EXP_UNITTYPE_100561_.tb8_1(0):=EXP_UNITTYPE_100561_.tb0_0(0);
EXP_UNITTYPE_100561_.tb8_2(0):=EXP_UNITTYPE_100561_.tb7_0(0);
ut_trace.trace('Actualizar o insertar tabla: OR_ACT_BY_TASK_MOD fila (0)',1);
UPDATE OR_ACT_BY_TASK_MOD SET ACT_BY_TASK_MOD_ID=EXP_UNITTYPE_100561_.tb8_0(0),
TASK_CODE=EXP_UNITTYPE_100561_.tb8_1(0),
CONFIG_EXPRESSION_ID=EXP_UNITTYPE_100561_.tb8_2(0),
MODULE_ID=9,
ITEMS_ID=4000814
 WHERE ACT_BY_TASK_MOD_ID = EXP_UNITTYPE_100561_.tb8_0(0);
if not (sql%found) then
INSERT INTO OR_ACT_BY_TASK_MOD(ACT_BY_TASK_MOD_ID,TASK_CODE,CONFIG_EXPRESSION_ID,MODULE_ID,ITEMS_ID) 
VALUES (EXP_UNITTYPE_100561_.tb8_0(0),
EXP_UNITTYPE_100561_.tb8_1(0),
EXP_UNITTYPE_100561_.tb8_2(0),
9,
4000814);
end if;

exception when others then
EXP_UNITTYPE_100561_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_100561_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100561_.old_tb7_0(1):=121397102;
EXP_UNITTYPE_100561_.tb7_0(1):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
EXP_UNITTYPE_100561_.tb7_0(1):=EXP_UNITTYPE_100561_.tb7_0(1);
EXP_UNITTYPE_100561_.old_tb7_1(1):='OR_SEL_TASTYP_CT404E121397102'
;
EXP_UNITTYPE_100561_.tb7_1(1):=TO_CHAR(EXP_UNITTYPE_100561_.tb7_0(1));
EXP_UNITTYPE_100561_.tb7_2(1):=EXP_UNITTYPE_100561_.tb6_0(0);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (1)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (EXP_UNITTYPE_100561_.tb7_0(1),
EXP_UNITTYPE_100561_.tb7_1(1),
EXP_UNITTYPE_100561_.tb7_2(1),
'nuPackageId = OR_BOINSTANCE.FNUGETFATHEXTSYSIDFROMINSTANCE();nuProductId = MO_BOPACKAGES.FNUFINDPRODUCTID(nuPackageId);sbValidaAcometida = LDC_PKOSSSUPENCMXVALVULA.FSBVALIDANIVELSUPENCIONACOM(nuProductId);nuSuspEsp = LDC_FNUVALIACTSUSPESP(nuProductId);if (sbValidaAcometida = "Y" '||chr(38)||''||chr(38)||' nuSuspEsp = 0,OR_BOINSTANCE.SETSUCCESSININSTANCE();,OR_BOINSTANCE.SETUN_SUCCESSININSTANCE();)'
,
'OPEN'
,
to_date('12-04-2018 18:58:19','DD-MM-YYYY HH24:MI:SS'),
to_date('29-03-2023 09:35:12','DD-MM-YYYY HH24:MI:SS'),
to_date('29-03-2023 09:35:12','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC - Valida si genera actividad segun datos registrados'
,
'PP'
,
null);

exception when others then
EXP_UNITTYPE_100561_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_100561_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100561_.tb8_0(1):=11200;
EXP_UNITTYPE_100561_.tb8_1(1):=EXP_UNITTYPE_100561_.tb0_0(0);
EXP_UNITTYPE_100561_.tb8_2(1):=EXP_UNITTYPE_100561_.tb7_0(1);
ut_trace.trace('Actualizar o insertar tabla: OR_ACT_BY_TASK_MOD fila (1)',1);
UPDATE OR_ACT_BY_TASK_MOD SET ACT_BY_TASK_MOD_ID=EXP_UNITTYPE_100561_.tb8_0(1),
TASK_CODE=EXP_UNITTYPE_100561_.tb8_1(1),
CONFIG_EXPRESSION_ID=EXP_UNITTYPE_100561_.tb8_2(1),
MODULE_ID=9,
ITEMS_ID=4000816
 WHERE ACT_BY_TASK_MOD_ID = EXP_UNITTYPE_100561_.tb8_0(1);
if not (sql%found) then
INSERT INTO OR_ACT_BY_TASK_MOD(ACT_BY_TASK_MOD_ID,TASK_CODE,CONFIG_EXPRESSION_ID,MODULE_ID,ITEMS_ID) 
VALUES (EXP_UNITTYPE_100561_.tb8_0(1),
EXP_UNITTYPE_100561_.tb8_1(1),
EXP_UNITTYPE_100561_.tb8_2(1),
9,
4000816);
end if;

exception when others then
EXP_UNITTYPE_100561_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_100561_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100561_.old_tb7_0(2):=121397103;
EXP_UNITTYPE_100561_.tb7_0(2):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
EXP_UNITTYPE_100561_.tb7_0(2):=EXP_UNITTYPE_100561_.tb7_0(2);
EXP_UNITTYPE_100561_.old_tb7_1(2):='OR_SEL_TASTYP_CT404E121397103'
;
EXP_UNITTYPE_100561_.tb7_1(2):=TO_CHAR(EXP_UNITTYPE_100561_.tb7_0(2));
EXP_UNITTYPE_100561_.tb7_2(2):=EXP_UNITTYPE_100561_.tb6_0(0);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (2)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (EXP_UNITTYPE_100561_.tb7_0(2),
EXP_UNITTYPE_100561_.tb7_1(2),
EXP_UNITTYPE_100561_.tb7_2(2),
'
nuPackageId = OR_BOINSTANCE.FNUGETFATHEXTSYSIDFROMINSTANCE();nuProductId = MO_BOPACKAGES.FNUFINDPRODUCTID(nuPackageId);nuActivity = PR_BOSUSPENSION.FNUGETLASTPRODSUSPORDERACTI(nuProductId);nuTipoAct = OR_BOACTIVITIESRULES.FNUGETACTIFROMORDERACT(nuActivity);if (nuTipoAct = 4000849 || nuTipoAct = 100002401,OR_BOINSTANCE.SETSUCCESSININSTANCE();,OR_BOINSTANCE.SETUN_SUCCESSININSTANCE();)'
,
'LUIGAR'
,
to_date('12-02-2015 20:18:24','DD-MM-YYYY HH24:MI:SS'),
to_date('29-03-2023 09:35:12','DD-MM-YYYY HH24:MI:SS'),
to_date('29-03-2023 09:35:12','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC - Genera Reconexi¿n con Cepo'
,
'PP'
,
null);

exception when others then
EXP_UNITTYPE_100561_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_100561_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100561_.tb8_0(2):=11281;
EXP_UNITTYPE_100561_.tb8_1(2):=EXP_UNITTYPE_100561_.tb0_0(0);
EXP_UNITTYPE_100561_.tb8_2(2):=EXP_UNITTYPE_100561_.tb7_0(2);
ut_trace.trace('Actualizar o insertar tabla: OR_ACT_BY_TASK_MOD fila (2)',1);
UPDATE OR_ACT_BY_TASK_MOD SET ACT_BY_TASK_MOD_ID=EXP_UNITTYPE_100561_.tb8_0(2),
TASK_CODE=EXP_UNITTYPE_100561_.tb8_1(2),
CONFIG_EXPRESSION_ID=EXP_UNITTYPE_100561_.tb8_2(2),
MODULE_ID=9,
ITEMS_ID=100002456
 WHERE ACT_BY_TASK_MOD_ID = EXP_UNITTYPE_100561_.tb8_0(2);
if not (sql%found) then
INSERT INTO OR_ACT_BY_TASK_MOD(ACT_BY_TASK_MOD_ID,TASK_CODE,CONFIG_EXPRESSION_ID,MODULE_ID,ITEMS_ID) 
VALUES (EXP_UNITTYPE_100561_.tb8_0(2),
EXP_UNITTYPE_100561_.tb8_1(2),
EXP_UNITTYPE_100561_.tb8_2(2),
9,
100002456);
end if;

exception when others then
EXP_UNITTYPE_100561_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_100561_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100561_.old_tb7_0(3):=121397104;
EXP_UNITTYPE_100561_.tb7_0(3):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
EXP_UNITTYPE_100561_.tb7_0(3):=EXP_UNITTYPE_100561_.tb7_0(3);
EXP_UNITTYPE_100561_.old_tb7_1(3):='OR_SEL_TASTYP_CT404E121397104'
;
EXP_UNITTYPE_100561_.tb7_1(3):=TO_CHAR(EXP_UNITTYPE_100561_.tb7_0(3));
EXP_UNITTYPE_100561_.tb7_2(3):=EXP_UNITTYPE_100561_.tb6_0(0);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (3)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (EXP_UNITTYPE_100561_.tb7_0(3),
EXP_UNITTYPE_100561_.tb7_1(3),
EXP_UNITTYPE_100561_.tb7_2(3),
'nuPackageId = OR_BOINSTANCE.FNUGETFATHEXTSYSIDFROMINSTANCE();nuProductId = MO_BOPACKAGES.FNUFINDPRODUCTID(nuPackageId);sbValidaAcometida = LDC_PKOSSSUPENCMXVALVULA.FSBVALIDANIVELSUPENCIONACOM(nuProductId);nuSuspEsp = LDC_FNUVALIACTSUSPESP(nuProductId);if (sbValidaAcometida = "Y" '||chr(38)||''||chr(38)||' nuSuspEsp = 1,OR_BOINSTANCE.SETSUCCESSININSTANCE();,OR_BOINSTANCE.SETUN_SUCCESSININSTANCE();)'
,
'OPEN'
,
to_date('16-05-2021 16:17:42','DD-MM-YYYY HH24:MI:SS'),
to_date('29-03-2023 09:35:12','DD-MM-YYYY HH24:MI:SS'),
to_date('29-03-2023 09:35:12','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC - genera reconexion especial'
,
'PP'
,
null);

exception when others then
EXP_UNITTYPE_100561_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_100561_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100561_.tb8_0(3):=11349;
EXP_UNITTYPE_100561_.tb8_1(3):=EXP_UNITTYPE_100561_.tb0_0(0);
EXP_UNITTYPE_100561_.tb8_2(3):=EXP_UNITTYPE_100561_.tb7_0(3);
ut_trace.trace('Actualizar o insertar tabla: OR_ACT_BY_TASK_MOD fila (3)',1);
UPDATE OR_ACT_BY_TASK_MOD SET ACT_BY_TASK_MOD_ID=EXP_UNITTYPE_100561_.tb8_0(3),
TASK_CODE=EXP_UNITTYPE_100561_.tb8_1(3),
CONFIG_EXPRESSION_ID=EXP_UNITTYPE_100561_.tb8_2(3),
MODULE_ID=9,
ITEMS_ID=100006274
 WHERE ACT_BY_TASK_MOD_ID = EXP_UNITTYPE_100561_.tb8_0(3);
if not (sql%found) then
INSERT INTO OR_ACT_BY_TASK_MOD(ACT_BY_TASK_MOD_ID,TASK_CODE,CONFIG_EXPRESSION_ID,MODULE_ID,ITEMS_ID) 
VALUES (EXP_UNITTYPE_100561_.tb8_0(3),
EXP_UNITTYPE_100561_.tb8_1(3),
EXP_UNITTYPE_100561_.tb8_2(3),
9,
100006274);
end if;

exception when others then
EXP_UNITTYPE_100561_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_100561_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100561_.old_tb7_0(4):=121397108;
EXP_UNITTYPE_100561_.tb7_0(4):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
EXP_UNITTYPE_100561_.tb7_0(4):=EXP_UNITTYPE_100561_.tb7_0(4);
EXP_UNITTYPE_100561_.old_tb7_1(4):='OR_SEL_TASTYP_CT404E121397108'
;
EXP_UNITTYPE_100561_.tb7_1(4):=TO_CHAR(EXP_UNITTYPE_100561_.tb7_0(4));
EXP_UNITTYPE_100561_.tb7_2(4):=EXP_UNITTYPE_100561_.tb6_0(0);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (4)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (EXP_UNITTYPE_100561_.tb7_0(4),
EXP_UNITTYPE_100561_.tb7_1(4),
EXP_UNITTYPE_100561_.tb7_2(4),
'nuPackage = OR_BOINSTANCE.FNUGETFATHEXTSYSIDFROMINSTANCE();nuProductId = MO_BOPACKAGES.FNUFINDPRODUCTID(nuPackage);nuActivity = PR_BOSUSPENSION.FNUGETLASTPRODSUSPORDERACTI(nuProductId);nuTipoAct = OR_BOACTIVITIESRULES.FNUGETACTIFROMORDERACT(nuActivity);if (nuTipoAct = 100009978,OR_BOINSTANCE.SETSUCCESSININSTANCE();,OR_BOINSTANCE.SETUN_SUCCESSININSTANCE();)'
,
'OPEN'
,
to_date('29-03-2023 10:01:09','DD-MM-YYYY HH24:MI:SS'),
to_date('29-03-2023 10:01:09','DD-MM-YYYY HH24:MI:SS'),
to_date('29-03-2023 10:01:09','DD-MM-YYYY HH24:MI:SS'),
'R'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC - Genera Reconexion CM Comercial'
,
'PP'
,
null);

exception when others then
EXP_UNITTYPE_100561_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_100561_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100561_.tb8_0(4):=11335;
EXP_UNITTYPE_100561_.tb8_1(4):=EXP_UNITTYPE_100561_.tb0_0(0);
EXP_UNITTYPE_100561_.tb8_2(4):=EXP_UNITTYPE_100561_.tb7_0(4);
ut_trace.trace('Actualizar o insertar tabla: OR_ACT_BY_TASK_MOD fila (4)',1);
UPDATE OR_ACT_BY_TASK_MOD SET ACT_BY_TASK_MOD_ID=EXP_UNITTYPE_100561_.tb8_0(4),
TASK_CODE=EXP_UNITTYPE_100561_.tb8_1(4),
CONFIG_EXPRESSION_ID=EXP_UNITTYPE_100561_.tb8_2(4),
MODULE_ID=9,
ITEMS_ID=100009983
 WHERE ACT_BY_TASK_MOD_ID = EXP_UNITTYPE_100561_.tb8_0(4);
if not (sql%found) then
INSERT INTO OR_ACT_BY_TASK_MOD(ACT_BY_TASK_MOD_ID,TASK_CODE,CONFIG_EXPRESSION_ID,MODULE_ID,ITEMS_ID) 
VALUES (EXP_UNITTYPE_100561_.tb8_0(4),
EXP_UNITTYPE_100561_.tb8_1(4),
EXP_UNITTYPE_100561_.tb8_2(4),
9,
100009983);
end if;

exception when others then
EXP_UNITTYPE_100561_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100559',1);
EXP_PROCESS_100559_.blProcessStatus := EXP_UNITTYPE_100561_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
COMMIT
/

DECLARE
PRAGMA AUTONOMOUS_TRANSACTION;
nuRowProcess number;
BEGIN 

if (not EXP_UNITTYPE_100561_.blProcessStatus) then
 return;
end if;
nuRowProcess:=EXP_UNITTYPE_100561_.tb7_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| EXP_UNITTYPE_100561_.tb7_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(EXP_UNITTYPE_100561_.tb7_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| EXP_UNITTYPE_100561_.tb7_0(nuRowProcess),1);
end;
nuRowProcess := EXP_UNITTYPE_100561_.tb7_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
EXP_UNITTYPE_100561_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

DECLARE
 nuIndex         binary_integer;
 blObjectDeleted boolean;

 FUNCTION fblIsObjectUseByRule
 (
  isbObjectName   IN gr_config_expression.object_name%type
 ) return BOOLEAN
 IS
  nuCounter    NUMBER := 0;
  blReturn     BOOLEAN := FALSE;
 BEGIN
  SELECT count('x') INTO nuCounter
  FROM gr_config_expression
  WHERE object_name = isbObjectName;
  IF (nuCounter > 0) THEN
    BEGIN
      DELETE FROM gr_config_expression
      WHERE object_name = isbObjectName;
      blReturn := FALSE;
    EXCEPTION
      when ex.RECORD_HAVE_CHILDREN then
         ut_trace.trace('Objeto ' || isbObjectName || ' usado en ' || nuCounter ||' reglas, no se borra',2);
         blReturn := TRUE;
    END;
  END IF;
  RETURN blReturn;
 END;

BEGIN
 ut_trace.trace('Inicia borrado de objetos de reglas',1);
 nuIndex := EXP_UNITTYPE_100561_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_UNITTYPE_100561_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_UNITTYPE_100561_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_UNITTYPE_100561_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_UNITTYPE_100561_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_UNITTYPE_100561_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_UNITTYPE_100561_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_UNITTYPE_100561_.tbObjectToDelete.next(nuIndex);
 END loop;
 ut_trace.trace('Finaliza borrado de objetos de reglas',1);
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
END;
/


begin
SA_BOCreatePackages.DropPackage('EXP_UNITTYPE_100561_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_UNITTYPE_100561_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_UNITTYPE_100614_',
'CREATE OR REPLACE PACKAGE EXP_UNITTYPE_100614_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyWF_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPERowId tyWF_UNIT_TYPERowId;type tyWF_CAUSAL_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_CAUSAL_UNIT_TYPERowId tyWF_CAUSAL_UNIT_TYPERowId;type tyGR_CONFIGURA_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIGURA_TYPERowId tyGR_CONFIGURA_TYPERowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type tyGE_ATTRIBUTE_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTE_CLASSRowId tyGE_ATTRIBUTE_CLASSRowId;type tyGE_ATTRIBUTES_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTES_TYPERowId tyGE_ATTRIBUTES_TYPERowId;type tyGE_ATTRIBUTESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTESRowId tyGE_ATTRIBUTESRowId;type tyGE_STATEMENTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_STATEMENTRowId tyGE_STATEMENTRowId;type tyWF_UNIT_TYPE_ATTRIBRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPE_ATTRIBRowId tyWF_UNIT_TYPE_ATTRIBRowId;type tyMO_TIME_UNI_TYP_PRIORowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbMO_TIME_UNI_TYP_PRIORowId tyMO_TIME_UNI_TYP_PRIORowId;type tyOR_ACT_BY_TASK_MODRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbOR_ACT_BY_TASK_MODRowId tyOR_ACT_BY_TASK_MODRowId;type ty0_0 is table of WF_UNIT_TYPE.UNIT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_5 is table of WF_UNIT_TYPE.INIT_AREA_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_5 ty0_5; ' || chr(10) ||
'tb0_5 ty0_5; ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_UNITTYPE_100614_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_UNITTYPE_100614_******************************'); END;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_UNITTYPE_100614',1);
EXP_UNITTYPE_100614_.blProcessStatus := EXP_PROCESS_100559_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  SELECT  B.object_name
FROM    OR_ACT_BY_TASK_MOD A, GR_CONFIG_EXPRESSION B 
WHERE   A.CONFIG_EXPRESSION_ID = B.CONFIG_EXPRESSION_ID
AND     A.TASK_CODE = 100614
 
;
BEGIN

if (not EXP_UNITTYPE_100614_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_UNITTYPE_100614_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
  nuIndex := nuIndex + 1;
 END LOOP;
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
END;
/

declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_TYPE_ATTRIB WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100614);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100614_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_TYPE_ATTRIB',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_TYPE_ATTRIB WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100614_.blProcessStatus := false;
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
FROM WF_CAUSAL_UNIT_TYPE WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100614);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100614_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_CAUSAL_UNIT_TYPE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_CAUSAL_UNIT_TYPE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100614_.blProcessStatus := false;
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
FROM MO_TIME_UNI_TYP_PRIO WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100614);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100614_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla MO_TIME_UNI_TYP_PRIO',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM MO_TIME_UNI_TYP_PRIO WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100614_.blProcessStatus := false;
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
FROM OR_ACT_BY_TASK_MOD WHERE (TASK_CODE) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100614);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100614_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla OR_ACT_BY_TASK_MOD',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM OR_ACT_BY_TASK_MOD WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100614_.blProcessStatus := false;
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
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100614;
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100614_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_TYPE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_TYPE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100614_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_UNITTYPE_100614_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100614_.tb0_0(0):=100614;
ut_trace.trace('insertando tabla sin fallo: WF_UNIT_TYPE fila (0)',1);
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_UNITTYPE_100614_.tb0_0(0),
2,
9,
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_100614'
,
'Reversar Estado Producto'
,
'Reversar Estado Producto'
,
null,
'N'
,
'N'
,
null,
'R'
,
'N'
,
null,
'Y'
,
null,
null,
'N'
,
null,
null);

exception 
when dup_val_on_index then 
 return;
when others then
EXP_UNITTYPE_100614_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100559',1);
EXP_PROCESS_100559_.blProcessStatus := EXP_UNITTYPE_100614_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/

DECLARE
 nuIndex         binary_integer;
 blObjectDeleted boolean;

 FUNCTION fblIsObjectUseByRule
 (
  isbObjectName   IN gr_config_expression.object_name%type
 ) return BOOLEAN
 IS
  nuCounter    NUMBER := 0;
  blReturn     BOOLEAN := FALSE;
 BEGIN
  SELECT count('x') INTO nuCounter
  FROM gr_config_expression
  WHERE object_name = isbObjectName;
  IF (nuCounter > 0) THEN
    BEGIN
      DELETE FROM gr_config_expression
      WHERE object_name = isbObjectName;
      blReturn := FALSE;
    EXCEPTION
      when ex.RECORD_HAVE_CHILDREN then
         ut_trace.trace('Objeto ' || isbObjectName || ' usado en ' || nuCounter ||' reglas, no se borra',2);
         blReturn := TRUE;
    END;
  END IF;
  RETURN blReturn;
 END;

BEGIN
 ut_trace.trace('Inicia borrado de objetos de reglas',1);
 nuIndex := EXP_UNITTYPE_100614_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_UNITTYPE_100614_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_UNITTYPE_100614_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_UNITTYPE_100614_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_UNITTYPE_100614_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_UNITTYPE_100614_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_UNITTYPE_100614_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_UNITTYPE_100614_.tbObjectToDelete.next(nuIndex);
 END loop;
 ut_trace.trace('Finaliza borrado de objetos de reglas',1);
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('EXP_UNITTYPE_100614_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_UNITTYPE_100614_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_UNITTYPE_283_',
'CREATE OR REPLACE PACKAGE EXP_UNITTYPE_283_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyWF_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPERowId tyWF_UNIT_TYPERowId;type tyWF_CAUSAL_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_CAUSAL_UNIT_TYPERowId tyWF_CAUSAL_UNIT_TYPERowId;type tyGR_CONFIGURA_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIGURA_TYPERowId tyGR_CONFIGURA_TYPERowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type tyGE_ATTRIBUTE_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTE_CLASSRowId tyGE_ATTRIBUTE_CLASSRowId;type tyGE_ATTRIBUTES_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTES_TYPERowId tyGE_ATTRIBUTES_TYPERowId;type tyGE_ATTRIBUTESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTESRowId tyGE_ATTRIBUTESRowId;type tyGE_STATEMENTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_STATEMENTRowId tyGE_STATEMENTRowId;type tyWF_UNIT_TYPE_ATTRIBRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPE_ATTRIBRowId tyWF_UNIT_TYPE_ATTRIBRowId;type tyMO_TIME_UNI_TYP_PRIORowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbMO_TIME_UNI_TYP_PRIORowId tyMO_TIME_UNI_TYP_PRIORowId;type tyOR_ACT_BY_TASK_MODRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbOR_ACT_BY_TASK_MODRowId tyOR_ACT_BY_TASK_MODRowId;type ty0_0 is table of WF_UNIT_TYPE.UNIT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_5 is table of WF_UNIT_TYPE.INIT_AREA_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_5 ty0_5; ' || chr(10) ||
'tb0_5 ty0_5;type ty1_0 is table of GE_ATTRIBUTE_CLASS.ATTRIBUTE_CLASS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_0 ty1_0; ' || chr(10) ||
'tb1_0 ty1_0;type ty2_0 is table of GE_ATTRIBUTES_TYPE.ATTRIBUTE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;type ty3_0 is table of GE_ATTRIBUTES.ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_0 ty3_0; ' || chr(10) ||
'tb3_0 ty3_0;type ty3_1 is table of GE_ATTRIBUTES.ATTRIBUTE_CLASS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_1 ty3_1; ' || chr(10) ||
'tb3_1 ty3_1;type ty3_2 is table of GE_ATTRIBUTES.ATTRIBUTE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_2 ty3_2; ' || chr(10) ||
'tb3_2 ty3_2;type ty3_3 is table of GE_ATTRIBUTES.VALID_EXPRESSION%type index by binary_integer; ' || chr(10) ||
'old_tb3_3 ty3_3; ' || chr(10) ||
'tb3_3 ty3_3;type ty4_0 is table of WF_UNIT_TYPE_ATTRIB.UNIT_TYPE_ATTRIB_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_0 ty4_0; ' || chr(10) ||
'tb4_0 ty4_0;type ty4_1 is table of WF_UNIT_TYPE_ATTRIB.UNIT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_1 ty4_1; ' || chr(10) ||
'tb4_1 ty4_1;type ty4_2 is table of WF_UNIT_TYPE_ATTRIB.ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_2 ty4_2; ' || chr(10) ||
'tb4_2 ty4_2;type ty4_3 is table of WF_UNIT_TYPE_ATTRIB.STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_3 ty4_3; ' || chr(10) ||
'tb4_3 ty4_3; ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_UNITTYPE_283_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_UNITTYPE_283_******************************'); END;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_UNITTYPE_283',1);
EXP_UNITTYPE_283_.blProcessStatus := EXP_PROCESS_100559_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  SELECT  B.object_name
FROM    OR_ACT_BY_TASK_MOD A, GR_CONFIG_EXPRESSION B 
WHERE   A.CONFIG_EXPRESSION_ID = B.CONFIG_EXPRESSION_ID
AND     A.TASK_CODE = 283
 
;
BEGIN

if (not EXP_UNITTYPE_283_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_UNITTYPE_283_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
  nuIndex := nuIndex + 1;
 END LOOP;
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
END;
/

declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_TYPE_ATTRIB WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=283);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_283_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_TYPE_ATTRIB',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_TYPE_ATTRIB WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_283_.blProcessStatus := false;
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
FROM WF_CAUSAL_UNIT_TYPE WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=283);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_283_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_CAUSAL_UNIT_TYPE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_CAUSAL_UNIT_TYPE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_283_.blProcessStatus := false;
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
FROM MO_TIME_UNI_TYP_PRIO WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=283);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_283_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla MO_TIME_UNI_TYP_PRIO',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM MO_TIME_UNI_TYP_PRIO WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_283_.blProcessStatus := false;
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
FROM OR_ACT_BY_TASK_MOD WHERE (TASK_CODE) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=283);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_283_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla OR_ACT_BY_TASK_MOD',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM OR_ACT_BY_TASK_MOD WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_283_.blProcessStatus := false;
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
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=283;
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_283_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_TYPE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_TYPE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_283_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_UNITTYPE_283_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_283_.tb0_0(0):=283;
ut_trace.trace('insertando tabla sin fallo: WF_UNIT_TYPE fila (0)',1);
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_UNITTYPE_283_.tb0_0(0),
2,
9,
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_283'
,
'Inicio'
,
'Inicio'
,
'GO.BMP'
,
'N'
,
'N'
,
null,
'R'
,
'N'
,
null,
'N'
,
null,
null,
'N'
,
null,
null);

exception 
when dup_val_on_index then 
 return;
when others then
EXP_UNITTYPE_283_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_283_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_283_.tb1_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTE_CLASS fila (0)',1);
UPDATE GE_ATTRIBUTE_CLASS SET ATTRIBUTE_CLASS_ID=EXP_UNITTYPE_283_.tb1_0(0),
NAME='De Entitdad'
,
DESCRIPTION='Valores que ser¿n tra¿dos de la tabla base usando old record'

 WHERE ATTRIBUTE_CLASS_ID = EXP_UNITTYPE_283_.tb1_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTE_CLASS(ATTRIBUTE_CLASS_ID,NAME,DESCRIPTION) 
VALUES (EXP_UNITTYPE_283_.tb1_0(0),
'De Entitdad'
,
'Valores que ser¿n tra¿dos de la tabla base usando old record'
);
end if;

exception when others then
EXP_UNITTYPE_283_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_283_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_283_.tb2_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES_TYPE fila (0)',1);
UPDATE GE_ATTRIBUTES_TYPE SET ATTRIBUTE_TYPE_ID=EXP_UNITTYPE_283_.tb2_0(0),
DESCRIPTION='NUMBER'
,
INTERNAL_TYPE=2,
INTERNAL_JAVA_TYPE=2
 WHERE ATTRIBUTE_TYPE_ID = EXP_UNITTYPE_283_.tb2_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES_TYPE(ATTRIBUTE_TYPE_ID,DESCRIPTION,INTERNAL_TYPE,INTERNAL_JAVA_TYPE) 
VALUES (EXP_UNITTYPE_283_.tb2_0(0),
'NUMBER'
,
2,
2);
end if;

exception when others then
EXP_UNITTYPE_283_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_283_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_283_.tb3_0(0):=400;
EXP_UNITTYPE_283_.tb3_1(0):=EXP_UNITTYPE_283_.tb1_0(0);
EXP_UNITTYPE_283_.tb3_2(0):=EXP_UNITTYPE_283_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (0)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=EXP_UNITTYPE_283_.tb3_0(0),
ATTRIBUTE_CLASS_ID=EXP_UNITTYPE_283_.tb3_1(0),
ATTRIBUTE_TYPE_ID=EXP_UNITTYPE_283_.tb3_2(0),
VALID_EXPRESSION=null,
FATHER_ID=null,
MODULE_ID=9,
NAME_ATTRIBUTE='CAUSAL'
,
LENGTH=4,
PRECISION=null,
SCALE=null,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE='T'
,
COMMENT_='Causal'
,
DISPLAY_NAME='Causal'

 WHERE ATTRIBUTE_ID = EXP_UNITTYPE_283_.tb3_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,ATTRIBUTE_CLASS_ID,ATTRIBUTE_TYPE_ID,VALID_EXPRESSION,FATHER_ID,MODULE_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (EXP_UNITTYPE_283_.tb3_0(0),
EXP_UNITTYPE_283_.tb3_1(0),
EXP_UNITTYPE_283_.tb3_2(0),
null,
null,
9,
'CAUSAL'
,
4,
null,
null,
null,
'T'
,
'Causal'
,
'Causal'
);
end if;

exception when others then
EXP_UNITTYPE_283_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_283_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_283_.tb4_0(0):=109050;
EXP_UNITTYPE_283_.tb4_1(0):=EXP_UNITTYPE_283_.tb0_0(0);
EXP_UNITTYPE_283_.tb4_2(0):=EXP_UNITTYPE_283_.tb3_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE_ATTRIB fila (0)',1);
UPDATE WF_UNIT_TYPE_ATTRIB SET UNIT_TYPE_ATTRIB_ID=EXP_UNITTYPE_283_.tb4_0(0),
UNIT_TYPE_ID=EXP_UNITTYPE_283_.tb4_1(0),
ATTRIBUTE_ID=EXP_UNITTYPE_283_.tb4_2(0),
STATEMENT_ID=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_TYPE_ATTRIB_ID = EXP_UNITTYPE_283_.tb4_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE_ATTRIB(UNIT_TYPE_ATTRIB_ID,UNIT_TYPE_ID,ATTRIBUTE_ID,STATEMENT_ID,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_UNITTYPE_283_.tb4_0(0),
EXP_UNITTYPE_283_.tb4_1(0),
EXP_UNITTYPE_283_.tb4_2(0),
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_UNITTYPE_283_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_283_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_283_.tb4_0(1):=100000062;
EXP_UNITTYPE_283_.tb4_1(1):=EXP_UNITTYPE_283_.tb0_0(0);
EXP_UNITTYPE_283_.tb4_2(1):=EXP_UNITTYPE_283_.tb3_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE_ATTRIB fila (1)',1);
UPDATE WF_UNIT_TYPE_ATTRIB SET UNIT_TYPE_ATTRIB_ID=EXP_UNITTYPE_283_.tb4_0(1),
UNIT_TYPE_ID=EXP_UNITTYPE_283_.tb4_1(1),
ATTRIBUTE_ID=EXP_UNITTYPE_283_.tb4_2(1),
STATEMENT_ID=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_TYPE_ATTRIB_ID = EXP_UNITTYPE_283_.tb4_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE_ATTRIB(UNIT_TYPE_ATTRIB_ID,UNIT_TYPE_ID,ATTRIBUTE_ID,STATEMENT_ID,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_UNITTYPE_283_.tb4_0(1),
EXP_UNITTYPE_283_.tb4_1(1),
EXP_UNITTYPE_283_.tb4_2(1),
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_UNITTYPE_283_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100559',1);
EXP_PROCESS_100559_.blProcessStatus := EXP_UNITTYPE_283_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/

DECLARE
 nuIndex         binary_integer;
 blObjectDeleted boolean;

 FUNCTION fblIsObjectUseByRule
 (
  isbObjectName   IN gr_config_expression.object_name%type
 ) return BOOLEAN
 IS
  nuCounter    NUMBER := 0;
  blReturn     BOOLEAN := FALSE;
 BEGIN
  SELECT count('x') INTO nuCounter
  FROM gr_config_expression
  WHERE object_name = isbObjectName;
  IF (nuCounter > 0) THEN
    BEGIN
      DELETE FROM gr_config_expression
      WHERE object_name = isbObjectName;
      blReturn := FALSE;
    EXCEPTION
      when ex.RECORD_HAVE_CHILDREN then
         ut_trace.trace('Objeto ' || isbObjectName || ' usado en ' || nuCounter ||' reglas, no se borra',2);
         blReturn := TRUE;
    END;
  END IF;
  RETURN blReturn;
 END;

BEGIN
 ut_trace.trace('Inicia borrado de objetos de reglas',1);
 nuIndex := EXP_UNITTYPE_283_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_UNITTYPE_283_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_UNITTYPE_283_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_UNITTYPE_283_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_UNITTYPE_283_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_UNITTYPE_283_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_UNITTYPE_283_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_UNITTYPE_283_.tbObjectToDelete.next(nuIndex);
 END loop;
 ut_trace.trace('Finaliza borrado de objetos de reglas',1);
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('EXP_UNITTYPE_283_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_UNITTYPE_283_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_UNITTYPE_100612_',
'CREATE OR REPLACE PACKAGE EXP_UNITTYPE_100612_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyWF_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPERowId tyWF_UNIT_TYPERowId;type tyWF_CAUSAL_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_CAUSAL_UNIT_TYPERowId tyWF_CAUSAL_UNIT_TYPERowId;type tyGR_CONFIGURA_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIGURA_TYPERowId tyGR_CONFIGURA_TYPERowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type tyGE_ATTRIBUTE_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTE_CLASSRowId tyGE_ATTRIBUTE_CLASSRowId;type tyGE_ATTRIBUTES_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTES_TYPERowId tyGE_ATTRIBUTES_TYPERowId;type tyGE_ATTRIBUTESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTESRowId tyGE_ATTRIBUTESRowId;type tyGE_STATEMENTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_STATEMENTRowId tyGE_STATEMENTRowId;type tyWF_UNIT_TYPE_ATTRIBRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPE_ATTRIBRowId tyWF_UNIT_TYPE_ATTRIBRowId;type tyMO_TIME_UNI_TYP_PRIORowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbMO_TIME_UNI_TYP_PRIORowId tyMO_TIME_UNI_TYP_PRIORowId;type tyOR_ACT_BY_TASK_MODRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbOR_ACT_BY_TASK_MODRowId tyOR_ACT_BY_TASK_MODRowId;type ty0_0 is table of WF_UNIT_TYPE.UNIT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_5 is table of WF_UNIT_TYPE.INIT_AREA_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_5 ty0_5; ' || chr(10) ||
'tb0_5 ty0_5; ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_UNITTYPE_100612_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_UNITTYPE_100612_******************************'); END;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_UNITTYPE_100612',1);
EXP_UNITTYPE_100612_.blProcessStatus := EXP_PROCESS_100559_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  SELECT  B.object_name
FROM    OR_ACT_BY_TASK_MOD A, GR_CONFIG_EXPRESSION B 
WHERE   A.CONFIG_EXPRESSION_ID = B.CONFIG_EXPRESSION_ID
AND     A.TASK_CODE = 100612
 
;
BEGIN

if (not EXP_UNITTYPE_100612_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_UNITTYPE_100612_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
  nuIndex := nuIndex + 1;
 END LOOP;
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
END;
/

declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_TYPE_ATTRIB WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100612);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100612_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_TYPE_ATTRIB',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_TYPE_ATTRIB WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100612_.blProcessStatus := false;
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
FROM WF_CAUSAL_UNIT_TYPE WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100612);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100612_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_CAUSAL_UNIT_TYPE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_CAUSAL_UNIT_TYPE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100612_.blProcessStatus := false;
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
FROM MO_TIME_UNI_TYP_PRIO WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100612);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100612_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla MO_TIME_UNI_TYP_PRIO',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM MO_TIME_UNI_TYP_PRIO WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100612_.blProcessStatus := false;
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
FROM OR_ACT_BY_TASK_MOD WHERE (TASK_CODE) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100612);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100612_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla OR_ACT_BY_TASK_MOD',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM OR_ACT_BY_TASK_MOD WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100612_.blProcessStatus := false;
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
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100612;
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100612_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_TYPE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_TYPE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100612_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_UNITTYPE_100612_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100612_.tb0_0(0):=100612;
ut_trace.trace('insertando tabla sin fallo: WF_UNIT_TYPE fila (0)',1);
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_UNITTYPE_100612_.tb0_0(0),
2,
5,
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_100612'
,
'Atender Solicitud Reconexion'
,
'Atender Solicitud Reconexion'
,
null,
'N'
,
'N'
,
null,
'R'
,
'N'
,
null,
'Y'
,
null,
null,
'N'
,
null,
null);

exception 
when dup_val_on_index then 
 return;
when others then
EXP_UNITTYPE_100612_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100559',1);
EXP_PROCESS_100559_.blProcessStatus := EXP_UNITTYPE_100612_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/

DECLARE
 nuIndex         binary_integer;
 blObjectDeleted boolean;

 FUNCTION fblIsObjectUseByRule
 (
  isbObjectName   IN gr_config_expression.object_name%type
 ) return BOOLEAN
 IS
  nuCounter    NUMBER := 0;
  blReturn     BOOLEAN := FALSE;
 BEGIN
  SELECT count('x') INTO nuCounter
  FROM gr_config_expression
  WHERE object_name = isbObjectName;
  IF (nuCounter > 0) THEN
    BEGIN
      DELETE FROM gr_config_expression
      WHERE object_name = isbObjectName;
      blReturn := FALSE;
    EXCEPTION
      when ex.RECORD_HAVE_CHILDREN then
         ut_trace.trace('Objeto ' || isbObjectName || ' usado en ' || nuCounter ||' reglas, no se borra',2);
         blReturn := TRUE;
    END;
  END IF;
  RETURN blReturn;
 END;

BEGIN
 ut_trace.trace('Inicia borrado de objetos de reglas',1);
 nuIndex := EXP_UNITTYPE_100612_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_UNITTYPE_100612_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_UNITTYPE_100612_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_UNITTYPE_100612_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_UNITTYPE_100612_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_UNITTYPE_100612_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_UNITTYPE_100612_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_UNITTYPE_100612_.tbObjectToDelete.next(nuIndex);
 END loop;
 ut_trace.trace('Finaliza borrado de objetos de reglas',1);
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('EXP_UNITTYPE_100612_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_UNITTYPE_100612_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_UNITTYPE_100567_',
'CREATE OR REPLACE PACKAGE EXP_UNITTYPE_100567_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyWF_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPERowId tyWF_UNIT_TYPERowId;type tyWF_CAUSAL_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_CAUSAL_UNIT_TYPERowId tyWF_CAUSAL_UNIT_TYPERowId;type tyGR_CONFIGURA_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIGURA_TYPERowId tyGR_CONFIGURA_TYPERowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type tyGE_ATTRIBUTE_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTE_CLASSRowId tyGE_ATTRIBUTE_CLASSRowId;type tyGE_ATTRIBUTES_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTES_TYPERowId tyGE_ATTRIBUTES_TYPERowId;type tyGE_ATTRIBUTESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTESRowId tyGE_ATTRIBUTESRowId;type tyGE_STATEMENTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_STATEMENTRowId tyGE_STATEMENTRowId;type tyWF_UNIT_TYPE_ATTRIBRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPE_ATTRIBRowId tyWF_UNIT_TYPE_ATTRIBRowId;type tyMO_TIME_UNI_TYP_PRIORowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbMO_TIME_UNI_TYP_PRIORowId tyMO_TIME_UNI_TYP_PRIORowId;type tyOR_ACT_BY_TASK_MODRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbOR_ACT_BY_TASK_MODRowId tyOR_ACT_BY_TASK_MODRowId;type ty0_0 is table of WF_UNIT_TYPE.UNIT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_5 is table of WF_UNIT_TYPE.INIT_AREA_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_5 ty0_5; ' || chr(10) ||
'tb0_5 ty0_5; ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_UNITTYPE_100567_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_UNITTYPE_100567_******************************'); END;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_UNITTYPE_100567',1);
EXP_UNITTYPE_100567_.blProcessStatus := EXP_PROCESS_100559_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  SELECT  B.object_name
FROM    OR_ACT_BY_TASK_MOD A, GR_CONFIG_EXPRESSION B 
WHERE   A.CONFIG_EXPRESSION_ID = B.CONFIG_EXPRESSION_ID
AND     A.TASK_CODE = 100567
 
;
BEGIN

if (not EXP_UNITTYPE_100567_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_UNITTYPE_100567_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
  nuIndex := nuIndex + 1;
 END LOOP;
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
END;
/

declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_TYPE_ATTRIB WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100567);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100567_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_TYPE_ATTRIB',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_TYPE_ATTRIB WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100567_.blProcessStatus := false;
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
FROM WF_CAUSAL_UNIT_TYPE WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100567);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100567_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_CAUSAL_UNIT_TYPE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_CAUSAL_UNIT_TYPE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100567_.blProcessStatus := false;
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
FROM MO_TIME_UNI_TYP_PRIO WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100567);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100567_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla MO_TIME_UNI_TYP_PRIO',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM MO_TIME_UNI_TYP_PRIO WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100567_.blProcessStatus := false;
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
FROM OR_ACT_BY_TASK_MOD WHERE (TASK_CODE) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100567);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100567_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla OR_ACT_BY_TASK_MOD',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM OR_ACT_BY_TASK_MOD WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100567_.blProcessStatus := false;
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
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100567;
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100567_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_TYPE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_TYPE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100567_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_UNITTYPE_100567_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100567_.tb0_0(0):=100567;
ut_trace.trace('insertando tabla sin fallo: WF_UNIT_TYPE fila (0)',1);
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_UNITTYPE_100567_.tb0_0(0),
2,
9,
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_100567'
,
'Espera que el pago ingrese'
,
'Espera que el pago ingrese'
,
null,
'N'
,
'N'
,
null,
'R'
,
'N'
,
null,
'N'
,
null,
null,
'N'
,
null,
null);

exception 
when dup_val_on_index then 
 return;
when others then
EXP_UNITTYPE_100567_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100559',1);
EXP_PROCESS_100559_.blProcessStatus := EXP_UNITTYPE_100567_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/

DECLARE
 nuIndex         binary_integer;
 blObjectDeleted boolean;

 FUNCTION fblIsObjectUseByRule
 (
  isbObjectName   IN gr_config_expression.object_name%type
 ) return BOOLEAN
 IS
  nuCounter    NUMBER := 0;
  blReturn     BOOLEAN := FALSE;
 BEGIN
  SELECT count('x') INTO nuCounter
  FROM gr_config_expression
  WHERE object_name = isbObjectName;
  IF (nuCounter > 0) THEN
    BEGIN
      DELETE FROM gr_config_expression
      WHERE object_name = isbObjectName;
      blReturn := FALSE;
    EXCEPTION
      when ex.RECORD_HAVE_CHILDREN then
         ut_trace.trace('Objeto ' || isbObjectName || ' usado en ' || nuCounter ||' reglas, no se borra',2);
         blReturn := TRUE;
    END;
  END IF;
  RETURN blReturn;
 END;

BEGIN
 ut_trace.trace('Inicia borrado de objetos de reglas',1);
 nuIndex := EXP_UNITTYPE_100567_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_UNITTYPE_100567_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_UNITTYPE_100567_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_UNITTYPE_100567_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_UNITTYPE_100567_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_UNITTYPE_100567_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_UNITTYPE_100567_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_UNITTYPE_100567_.tbObjectToDelete.next(nuIndex);
 END loop;
 ut_trace.trace('Finaliza borrado de objetos de reglas',1);
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('EXP_UNITTYPE_100567_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_UNITTYPE_100567_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_UNITTYPE_100478_',
'CREATE OR REPLACE PACKAGE EXP_UNITTYPE_100478_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyWF_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPERowId tyWF_UNIT_TYPERowId;type tyWF_CAUSAL_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_CAUSAL_UNIT_TYPERowId tyWF_CAUSAL_UNIT_TYPERowId;type tyGR_CONFIGURA_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIGURA_TYPERowId tyGR_CONFIGURA_TYPERowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type tyGE_ATTRIBUTE_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTE_CLASSRowId tyGE_ATTRIBUTE_CLASSRowId;type tyGE_ATTRIBUTES_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTES_TYPERowId tyGE_ATTRIBUTES_TYPERowId;type tyGE_ATTRIBUTESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTESRowId tyGE_ATTRIBUTESRowId;type tyGE_STATEMENTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_STATEMENTRowId tyGE_STATEMENTRowId;type tyWF_UNIT_TYPE_ATTRIBRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPE_ATTRIBRowId tyWF_UNIT_TYPE_ATTRIBRowId;type tyMO_TIME_UNI_TYP_PRIORowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbMO_TIME_UNI_TYP_PRIORowId tyMO_TIME_UNI_TYP_PRIORowId;type tyOR_ACT_BY_TASK_MODRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbOR_ACT_BY_TASK_MODRowId tyOR_ACT_BY_TASK_MODRowId;type ty0_0 is table of WF_UNIT_TYPE.UNIT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_5 is table of WF_UNIT_TYPE.INIT_AREA_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_5 ty0_5; ' || chr(10) ||
'tb0_5 ty0_5; ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_UNITTYPE_100478_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_UNITTYPE_100478_******************************'); END;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_UNITTYPE_100478',1);
EXP_UNITTYPE_100478_.blProcessStatus := EXP_PROCESS_100559_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  SELECT  B.object_name
FROM    OR_ACT_BY_TASK_MOD A, GR_CONFIG_EXPRESSION B 
WHERE   A.CONFIG_EXPRESSION_ID = B.CONFIG_EXPRESSION_ID
AND     A.TASK_CODE = 100478
 
;
BEGIN

if (not EXP_UNITTYPE_100478_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_UNITTYPE_100478_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
  nuIndex := nuIndex + 1;
 END LOOP;
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
END;
/

declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_TYPE_ATTRIB WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100478);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100478_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_TYPE_ATTRIB',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_TYPE_ATTRIB WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100478_.blProcessStatus := false;
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
FROM WF_CAUSAL_UNIT_TYPE WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100478);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100478_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_CAUSAL_UNIT_TYPE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_CAUSAL_UNIT_TYPE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100478_.blProcessStatus := false;
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
FROM MO_TIME_UNI_TYP_PRIO WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100478);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100478_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla MO_TIME_UNI_TYP_PRIO',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM MO_TIME_UNI_TYP_PRIO WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100478_.blProcessStatus := false;
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
FROM OR_ACT_BY_TASK_MOD WHERE (TASK_CODE) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100478);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100478_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla OR_ACT_BY_TASK_MOD',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM OR_ACT_BY_TASK_MOD WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100478_.blProcessStatus := false;
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
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100478;
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100478_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_TYPE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_TYPE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100478_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_UNITTYPE_100478_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100478_.tb0_0(0):=100478;
ut_trace.trace('insertando tabla sin fallo: WF_UNIT_TYPE fila (0)',1);
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_UNITTYPE_100478_.tb0_0(0),
2,
9,
null,
2277,
null,
null,
null,
null,
'UNIT_TYPE_100478'
,
'Validar Ingreso de Pago'
,
'Validar Ingreso de Pago'
,
null,
'N'
,
'N'
,
null,
'R'
,
'N'
,
null,
'N'
,
null,
null,
'N'
,
null,
null);

exception 
when dup_val_on_index then 
 return;
when others then
EXP_UNITTYPE_100478_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100559',1);
EXP_PROCESS_100559_.blProcessStatus := EXP_UNITTYPE_100478_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/

DECLARE
 nuIndex         binary_integer;
 blObjectDeleted boolean;

 FUNCTION fblIsObjectUseByRule
 (
  isbObjectName   IN gr_config_expression.object_name%type
 ) return BOOLEAN
 IS
  nuCounter    NUMBER := 0;
  blReturn     BOOLEAN := FALSE;
 BEGIN
  SELECT count('x') INTO nuCounter
  FROM gr_config_expression
  WHERE object_name = isbObjectName;
  IF (nuCounter > 0) THEN
    BEGIN
      DELETE FROM gr_config_expression
      WHERE object_name = isbObjectName;
      blReturn := FALSE;
    EXCEPTION
      when ex.RECORD_HAVE_CHILDREN then
         ut_trace.trace('Objeto ' || isbObjectName || ' usado en ' || nuCounter ||' reglas, no se borra',2);
         blReturn := TRUE;
    END;
  END IF;
  RETURN blReturn;
 END;

BEGIN
 ut_trace.trace('Inicia borrado de objetos de reglas',1);
 nuIndex := EXP_UNITTYPE_100478_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_UNITTYPE_100478_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_UNITTYPE_100478_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_UNITTYPE_100478_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_UNITTYPE_100478_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_UNITTYPE_100478_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_UNITTYPE_100478_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_UNITTYPE_100478_.tbObjectToDelete.next(nuIndex);
 END loop;
 ut_trace.trace('Finaliza borrado de objetos de reglas',1);
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('EXP_UNITTYPE_100478_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_UNITTYPE_100478_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_UNITTYPE_238_',
'CREATE OR REPLACE PACKAGE EXP_UNITTYPE_238_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyWF_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPERowId tyWF_UNIT_TYPERowId;type tyWF_CAUSAL_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_CAUSAL_UNIT_TYPERowId tyWF_CAUSAL_UNIT_TYPERowId;type tyGR_CONFIGURA_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIGURA_TYPERowId tyGR_CONFIGURA_TYPERowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type tyGE_ATTRIBUTE_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTE_CLASSRowId tyGE_ATTRIBUTE_CLASSRowId;type tyGE_ATTRIBUTES_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTES_TYPERowId tyGE_ATTRIBUTES_TYPERowId;type tyGE_ATTRIBUTESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTESRowId tyGE_ATTRIBUTESRowId;type tyGE_STATEMENTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_STATEMENTRowId tyGE_STATEMENTRowId;type tyWF_UNIT_TYPE_ATTRIBRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPE_ATTRIBRowId tyWF_UNIT_TYPE_ATTRIBRowId;type tyMO_TIME_UNI_TYP_PRIORowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbMO_TIME_UNI_TYP_PRIORowId tyMO_TIME_UNI_TYP_PRIORowId;type tyOR_ACT_BY_TASK_MODRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbOR_ACT_BY_TASK_MODRowId tyOR_ACT_BY_TASK_MODRowId;type ty0_0 is table of WF_UNIT_TYPE.UNIT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_5 is table of WF_UNIT_TYPE.INIT_AREA_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_5 ty0_5; ' || chr(10) ||
'tb0_5 ty0_5; ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_UNITTYPE_238_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_UNITTYPE_238_******************************'); END;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_UNITTYPE_238',1);
EXP_UNITTYPE_238_.blProcessStatus := EXP_PROCESS_100559_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  SELECT  B.object_name
FROM    OR_ACT_BY_TASK_MOD A, GR_CONFIG_EXPRESSION B 
WHERE   A.CONFIG_EXPRESSION_ID = B.CONFIG_EXPRESSION_ID
AND     A.TASK_CODE = 238
 
;
BEGIN

if (not EXP_UNITTYPE_238_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_UNITTYPE_238_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
  nuIndex := nuIndex + 1;
 END LOOP;
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
END;
/

declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_TYPE_ATTRIB WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=238);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_238_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_TYPE_ATTRIB',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_TYPE_ATTRIB WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_238_.blProcessStatus := false;
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
FROM WF_CAUSAL_UNIT_TYPE WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=238);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_238_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_CAUSAL_UNIT_TYPE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_CAUSAL_UNIT_TYPE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_238_.blProcessStatus := false;
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
FROM MO_TIME_UNI_TYP_PRIO WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=238);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_238_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla MO_TIME_UNI_TYP_PRIO',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM MO_TIME_UNI_TYP_PRIO WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_238_.blProcessStatus := false;
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
FROM OR_ACT_BY_TASK_MOD WHERE (TASK_CODE) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=238);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_238_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla OR_ACT_BY_TASK_MOD',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM OR_ACT_BY_TASK_MOD WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_238_.blProcessStatus := false;
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
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=238;
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_238_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_TYPE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_TYPE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_238_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_UNITTYPE_238_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_238_.tb0_0(0):=238;
ut_trace.trace('insertando tabla sin fallo: WF_UNIT_TYPE fila (0)',1);
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_UNITTYPE_238_.tb0_0(0),
2,
5,
null,
2277,
null,
null,
null,
null,
'UNIT_TYPE_238'
,
'Reconectar en Sistema'
,
'Reconectar en Sistema'
,
null,
'N'
,
'N'
,
null,
'R'
,
'N'
,
null,
'N'
,
null,
null,
'N'
,
null,
null);

exception 
when dup_val_on_index then 
 return;
when others then
EXP_UNITTYPE_238_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100559',1);
EXP_PROCESS_100559_.blProcessStatus := EXP_UNITTYPE_238_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/

DECLARE
 nuIndex         binary_integer;
 blObjectDeleted boolean;

 FUNCTION fblIsObjectUseByRule
 (
  isbObjectName   IN gr_config_expression.object_name%type
 ) return BOOLEAN
 IS
  nuCounter    NUMBER := 0;
  blReturn     BOOLEAN := FALSE;
 BEGIN
  SELECT count('x') INTO nuCounter
  FROM gr_config_expression
  WHERE object_name = isbObjectName;
  IF (nuCounter > 0) THEN
    BEGIN
      DELETE FROM gr_config_expression
      WHERE object_name = isbObjectName;
      blReturn := FALSE;
    EXCEPTION
      when ex.RECORD_HAVE_CHILDREN then
         ut_trace.trace('Objeto ' || isbObjectName || ' usado en ' || nuCounter ||' reglas, no se borra',2);
         blReturn := TRUE;
    END;
  END IF;
  RETURN blReturn;
 END;

BEGIN
 ut_trace.trace('Inicia borrado de objetos de reglas',1);
 nuIndex := EXP_UNITTYPE_238_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_UNITTYPE_238_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_UNITTYPE_238_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_UNITTYPE_238_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_UNITTYPE_238_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_UNITTYPE_238_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_UNITTYPE_238_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_UNITTYPE_238_.tbObjectToDelete.next(nuIndex);
 END loop;
 ut_trace.trace('Finaliza borrado de objetos de reglas',1);
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('EXP_UNITTYPE_238_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_UNITTYPE_238_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_UNITTYPE_100379_',
'CREATE OR REPLACE PACKAGE EXP_UNITTYPE_100379_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyWF_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPERowId tyWF_UNIT_TYPERowId;type tyWF_CAUSAL_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_CAUSAL_UNIT_TYPERowId tyWF_CAUSAL_UNIT_TYPERowId;type tyGR_CONFIGURA_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIGURA_TYPERowId tyGR_CONFIGURA_TYPERowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type tyGE_ATTRIBUTE_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTE_CLASSRowId tyGE_ATTRIBUTE_CLASSRowId;type tyGE_ATTRIBUTES_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTES_TYPERowId tyGE_ATTRIBUTES_TYPERowId;type tyGE_ATTRIBUTESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTESRowId tyGE_ATTRIBUTESRowId;type tyGE_STATEMENTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_STATEMENTRowId tyGE_STATEMENTRowId;type tyWF_UNIT_TYPE_ATTRIBRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPE_ATTRIBRowId tyWF_UNIT_TYPE_ATTRIBRowId;type tyMO_TIME_UNI_TYP_PRIORowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbMO_TIME_UNI_TYP_PRIORowId tyMO_TIME_UNI_TYP_PRIORowId;type tyOR_ACT_BY_TASK_MODRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbOR_ACT_BY_TASK_MODRowId tyOR_ACT_BY_TASK_MODRowId;type ty0_0 is table of WF_UNIT_TYPE.UNIT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_5 is table of WF_UNIT_TYPE.INIT_AREA_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_5 ty0_5; ' || chr(10) ||
'tb0_5 ty0_5; ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_UNITTYPE_100379_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_UNITTYPE_100379_******************************'); END;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_UNITTYPE_100379',1);
EXP_UNITTYPE_100379_.blProcessStatus := EXP_PROCESS_100559_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  SELECT  B.object_name
FROM    OR_ACT_BY_TASK_MOD A, GR_CONFIG_EXPRESSION B 
WHERE   A.CONFIG_EXPRESSION_ID = B.CONFIG_EXPRESSION_ID
AND     A.TASK_CODE = 100379
 
;
BEGIN

if (not EXP_UNITTYPE_100379_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_UNITTYPE_100379_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
  nuIndex := nuIndex + 1;
 END LOOP;
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
END;
/

declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_TYPE_ATTRIB WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100379);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100379_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_TYPE_ATTRIB',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_TYPE_ATTRIB WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100379_.blProcessStatus := false;
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
FROM WF_CAUSAL_UNIT_TYPE WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100379);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100379_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_CAUSAL_UNIT_TYPE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_CAUSAL_UNIT_TYPE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100379_.blProcessStatus := false;
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
FROM MO_TIME_UNI_TYP_PRIO WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100379);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100379_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla MO_TIME_UNI_TYP_PRIO',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM MO_TIME_UNI_TYP_PRIO WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100379_.blProcessStatus := false;
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
FROM OR_ACT_BY_TASK_MOD WHERE (TASK_CODE) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100379);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100379_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla OR_ACT_BY_TASK_MOD',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM OR_ACT_BY_TASK_MOD WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100379_.blProcessStatus := false;
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
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100379;
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100379_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_TYPE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_TYPE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100379_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_UNITTYPE_100379_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100379_.tb0_0(0):=100379;
ut_trace.trace('insertando tabla sin fallo: WF_UNIT_TYPE fila (0)',1);
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_UNITTYPE_100379_.tb0_0(0),
2,
9,
null,
2277,
null,
null,
null,
null,
'UNIT_TYPE_100379'
,
'Espera que el pago ingrese'
,
'Espera que el pago ingrese'
,
null,
'N'
,
'N'
,
null,
'R'
,
'N'
,
null,
'N'
,
null,
null,
'N'
,
null,
null);

exception 
when dup_val_on_index then 
 return;
when others then
EXP_UNITTYPE_100379_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100559',1);
EXP_PROCESS_100559_.blProcessStatus := EXP_UNITTYPE_100379_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/

DECLARE
 nuIndex         binary_integer;
 blObjectDeleted boolean;

 FUNCTION fblIsObjectUseByRule
 (
  isbObjectName   IN gr_config_expression.object_name%type
 ) return BOOLEAN
 IS
  nuCounter    NUMBER := 0;
  blReturn     BOOLEAN := FALSE;
 BEGIN
  SELECT count('x') INTO nuCounter
  FROM gr_config_expression
  WHERE object_name = isbObjectName;
  IF (nuCounter > 0) THEN
    BEGIN
      DELETE FROM gr_config_expression
      WHERE object_name = isbObjectName;
      blReturn := FALSE;
    EXCEPTION
      when ex.RECORD_HAVE_CHILDREN then
         ut_trace.trace('Objeto ' || isbObjectName || ' usado en ' || nuCounter ||' reglas, no se borra',2);
         blReturn := TRUE;
    END;
  END IF;
  RETURN blReturn;
 END;

BEGIN
 ut_trace.trace('Inicia borrado de objetos de reglas',1);
 nuIndex := EXP_UNITTYPE_100379_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_UNITTYPE_100379_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_UNITTYPE_100379_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_UNITTYPE_100379_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_UNITTYPE_100379_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_UNITTYPE_100379_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_UNITTYPE_100379_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_UNITTYPE_100379_.tbObjectToDelete.next(nuIndex);
 END loop;
 ut_trace.trace('Finaliza borrado de objetos de reglas',1);
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('EXP_UNITTYPE_100379_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_UNITTYPE_100379_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_UNITTYPE_252_',
'CREATE OR REPLACE PACKAGE EXP_UNITTYPE_252_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyWF_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPERowId tyWF_UNIT_TYPERowId;type tyWF_CAUSAL_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_CAUSAL_UNIT_TYPERowId tyWF_CAUSAL_UNIT_TYPERowId;type tyGR_CONFIGURA_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIGURA_TYPERowId tyGR_CONFIGURA_TYPERowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type tyGE_ATTRIBUTE_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTE_CLASSRowId tyGE_ATTRIBUTE_CLASSRowId;type tyGE_ATTRIBUTES_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTES_TYPERowId tyGE_ATTRIBUTES_TYPERowId;type tyGE_ATTRIBUTESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTESRowId tyGE_ATTRIBUTESRowId;type tyGE_STATEMENTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_STATEMENTRowId tyGE_STATEMENTRowId;type tyWF_UNIT_TYPE_ATTRIBRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPE_ATTRIBRowId tyWF_UNIT_TYPE_ATTRIBRowId;type tyMO_TIME_UNI_TYP_PRIORowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbMO_TIME_UNI_TYP_PRIORowId tyMO_TIME_UNI_TYP_PRIORowId;type tyOR_ACT_BY_TASK_MODRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbOR_ACT_BY_TASK_MODRowId tyOR_ACT_BY_TASK_MODRowId;type ty0_0 is table of WF_UNIT_TYPE.UNIT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_5 is table of WF_UNIT_TYPE.INIT_AREA_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_5 ty0_5; ' || chr(10) ||
'tb0_5 ty0_5;type ty1_0 is table of GE_ATTRIBUTE_CLASS.ATTRIBUTE_CLASS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_0 ty1_0; ' || chr(10) ||
'tb1_0 ty1_0;type ty2_0 is table of GE_ATTRIBUTES_TYPE.ATTRIBUTE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;type ty3_0 is table of GE_ATTRIBUTES.ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_0 ty3_0; ' || chr(10) ||
'tb3_0 ty3_0;type ty3_1 is table of GE_ATTRIBUTES.ATTRIBUTE_CLASS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_1 ty3_1; ' || chr(10) ||
'tb3_1 ty3_1;type ty3_2 is table of GE_ATTRIBUTES.ATTRIBUTE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_2 ty3_2; ' || chr(10) ||
'tb3_2 ty3_2;type ty3_3 is table of GE_ATTRIBUTES.VALID_EXPRESSION%type index by binary_integer; ' || chr(10) ||
'old_tb3_3 ty3_3; ' || chr(10) ||
'tb3_3 ty3_3;type ty4_0 is table of WF_UNIT_TYPE_ATTRIB.UNIT_TYPE_ATTRIB_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_0 ty4_0; ' || chr(10) ||
'tb4_0 ty4_0;type ty4_1 is table of WF_UNIT_TYPE_ATTRIB.UNIT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_1 ty4_1; ' || chr(10) ||
'tb4_1 ty4_1;type ty4_2 is table of WF_UNIT_TYPE_ATTRIB.ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_2 ty4_2; ' || chr(10) ||
'tb4_2 ty4_2;type ty4_3 is table of WF_UNIT_TYPE_ATTRIB.STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_3 ty4_3; ' || chr(10) ||
'tb4_3 ty4_3; ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_UNITTYPE_252_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_UNITTYPE_252_******************************'); END;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_UNITTYPE_252',1);
EXP_UNITTYPE_252_.blProcessStatus := EXP_PROCESS_100559_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  SELECT  B.object_name
FROM    OR_ACT_BY_TASK_MOD A, GR_CONFIG_EXPRESSION B 
WHERE   A.CONFIG_EXPRESSION_ID = B.CONFIG_EXPRESSION_ID
AND     A.TASK_CODE = 252
 
;
BEGIN

if (not EXP_UNITTYPE_252_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_UNITTYPE_252_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
  nuIndex := nuIndex + 1;
 END LOOP;
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
END;
/

declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_TYPE_ATTRIB WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=252);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_252_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_TYPE_ATTRIB',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_TYPE_ATTRIB WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_252_.blProcessStatus := false;
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
FROM WF_CAUSAL_UNIT_TYPE WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=252);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_252_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_CAUSAL_UNIT_TYPE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_CAUSAL_UNIT_TYPE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_252_.blProcessStatus := false;
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
FROM MO_TIME_UNI_TYP_PRIO WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=252);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_252_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla MO_TIME_UNI_TYP_PRIO',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM MO_TIME_UNI_TYP_PRIO WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_252_.blProcessStatus := false;
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
FROM OR_ACT_BY_TASK_MOD WHERE (TASK_CODE) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=252);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_252_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla OR_ACT_BY_TASK_MOD',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM OR_ACT_BY_TASK_MOD WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_252_.blProcessStatus := false;
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
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=252;
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_252_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_TYPE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_TYPE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_252_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_UNITTYPE_252_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_252_.tb0_0(0):=252;
ut_trace.trace('insertando tabla sin fallo: WF_UNIT_TYPE fila (0)',1);
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_UNITTYPE_252_.tb0_0(0),
2,
9,
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_252'
,
'Fin'
,
'Fin'
,
'STOP.BMP'
,
'N'
,
'N'
,
null,
'N'
,
'N'
,
null,
'N'
,
null,
null,
'N'
,
null,
null);

exception 
when dup_val_on_index then 
 return;
when others then
EXP_UNITTYPE_252_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_252_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_252_.tb1_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTE_CLASS fila (0)',1);
UPDATE GE_ATTRIBUTE_CLASS SET ATTRIBUTE_CLASS_ID=EXP_UNITTYPE_252_.tb1_0(0),
NAME='De Entitdad'
,
DESCRIPTION='Valores que ser¿n tra¿dos de la tabla base usando old record'

 WHERE ATTRIBUTE_CLASS_ID = EXP_UNITTYPE_252_.tb1_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTE_CLASS(ATTRIBUTE_CLASS_ID,NAME,DESCRIPTION) 
VALUES (EXP_UNITTYPE_252_.tb1_0(0),
'De Entitdad'
,
'Valores que ser¿n tra¿dos de la tabla base usando old record'
);
end if;

exception when others then
EXP_UNITTYPE_252_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_252_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_252_.tb2_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES_TYPE fila (0)',1);
UPDATE GE_ATTRIBUTES_TYPE SET ATTRIBUTE_TYPE_ID=EXP_UNITTYPE_252_.tb2_0(0),
DESCRIPTION='NUMBER'
,
INTERNAL_TYPE=2,
INTERNAL_JAVA_TYPE=2
 WHERE ATTRIBUTE_TYPE_ID = EXP_UNITTYPE_252_.tb2_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES_TYPE(ATTRIBUTE_TYPE_ID,DESCRIPTION,INTERNAL_TYPE,INTERNAL_JAVA_TYPE) 
VALUES (EXP_UNITTYPE_252_.tb2_0(0),
'NUMBER'
,
2,
2);
end if;

exception when others then
EXP_UNITTYPE_252_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_252_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_252_.tb3_0(0):=400;
EXP_UNITTYPE_252_.tb3_1(0):=EXP_UNITTYPE_252_.tb1_0(0);
EXP_UNITTYPE_252_.tb3_2(0):=EXP_UNITTYPE_252_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (0)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=EXP_UNITTYPE_252_.tb3_0(0),
ATTRIBUTE_CLASS_ID=EXP_UNITTYPE_252_.tb3_1(0),
ATTRIBUTE_TYPE_ID=EXP_UNITTYPE_252_.tb3_2(0),
VALID_EXPRESSION=null,
FATHER_ID=null,
MODULE_ID=9,
NAME_ATTRIBUTE='CAUSAL'
,
LENGTH=4,
PRECISION=null,
SCALE=null,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE='T'
,
COMMENT_='Causal'
,
DISPLAY_NAME='Causal'

 WHERE ATTRIBUTE_ID = EXP_UNITTYPE_252_.tb3_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,ATTRIBUTE_CLASS_ID,ATTRIBUTE_TYPE_ID,VALID_EXPRESSION,FATHER_ID,MODULE_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (EXP_UNITTYPE_252_.tb3_0(0),
EXP_UNITTYPE_252_.tb3_1(0),
EXP_UNITTYPE_252_.tb3_2(0),
null,
null,
9,
'CAUSAL'
,
4,
null,
null,
null,
'T'
,
'Causal'
,
'Causal'
);
end if;

exception when others then
EXP_UNITTYPE_252_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_252_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_252_.tb4_0(0):=109049;
EXP_UNITTYPE_252_.tb4_1(0):=EXP_UNITTYPE_252_.tb0_0(0);
EXP_UNITTYPE_252_.tb4_2(0):=EXP_UNITTYPE_252_.tb3_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE_ATTRIB fila (0)',1);
UPDATE WF_UNIT_TYPE_ATTRIB SET UNIT_TYPE_ATTRIB_ID=EXP_UNITTYPE_252_.tb4_0(0),
UNIT_TYPE_ID=EXP_UNITTYPE_252_.tb4_1(0),
ATTRIBUTE_ID=EXP_UNITTYPE_252_.tb4_2(0),
STATEMENT_ID=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_TYPE_ATTRIB_ID = EXP_UNITTYPE_252_.tb4_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE_ATTRIB(UNIT_TYPE_ATTRIB_ID,UNIT_TYPE_ID,ATTRIBUTE_ID,STATEMENT_ID,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_UNITTYPE_252_.tb4_0(0),
EXP_UNITTYPE_252_.tb4_1(0),
EXP_UNITTYPE_252_.tb4_2(0),
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_UNITTYPE_252_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_252_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_252_.tb4_0(1):=100000063;
EXP_UNITTYPE_252_.tb4_1(1):=EXP_UNITTYPE_252_.tb0_0(0);
EXP_UNITTYPE_252_.tb4_2(1):=EXP_UNITTYPE_252_.tb3_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE_ATTRIB fila (1)',1);
UPDATE WF_UNIT_TYPE_ATTRIB SET UNIT_TYPE_ATTRIB_ID=EXP_UNITTYPE_252_.tb4_0(1),
UNIT_TYPE_ID=EXP_UNITTYPE_252_.tb4_1(1),
ATTRIBUTE_ID=EXP_UNITTYPE_252_.tb4_2(1),
STATEMENT_ID=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_TYPE_ATTRIB_ID = EXP_UNITTYPE_252_.tb4_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE_ATTRIB(UNIT_TYPE_ATTRIB_ID,UNIT_TYPE_ID,ATTRIBUTE_ID,STATEMENT_ID,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_UNITTYPE_252_.tb4_0(1),
EXP_UNITTYPE_252_.tb4_1(1),
EXP_UNITTYPE_252_.tb4_2(1),
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_UNITTYPE_252_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_252_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_252_.tb4_0(2):=109053;
EXP_UNITTYPE_252_.tb4_1(2):=EXP_UNITTYPE_252_.tb0_0(0);
EXP_UNITTYPE_252_.tb4_2(2):=EXP_UNITTYPE_252_.tb3_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE_ATTRIB fila (2)',1);
UPDATE WF_UNIT_TYPE_ATTRIB SET UNIT_TYPE_ATTRIB_ID=EXP_UNITTYPE_252_.tb4_0(2),
UNIT_TYPE_ID=EXP_UNITTYPE_252_.tb4_1(2),
ATTRIBUTE_ID=EXP_UNITTYPE_252_.tb4_2(2),
STATEMENT_ID=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_TYPE_ATTRIB_ID = EXP_UNITTYPE_252_.tb4_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE_ATTRIB(UNIT_TYPE_ATTRIB_ID,UNIT_TYPE_ID,ATTRIBUTE_ID,STATEMENT_ID,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_UNITTYPE_252_.tb4_0(2),
EXP_UNITTYPE_252_.tb4_1(2),
EXP_UNITTYPE_252_.tb4_2(2),
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_UNITTYPE_252_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100559',1);
EXP_PROCESS_100559_.blProcessStatus := EXP_UNITTYPE_252_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/

DECLARE
 nuIndex         binary_integer;
 blObjectDeleted boolean;

 FUNCTION fblIsObjectUseByRule
 (
  isbObjectName   IN gr_config_expression.object_name%type
 ) return BOOLEAN
 IS
  nuCounter    NUMBER := 0;
  blReturn     BOOLEAN := FALSE;
 BEGIN
  SELECT count('x') INTO nuCounter
  FROM gr_config_expression
  WHERE object_name = isbObjectName;
  IF (nuCounter > 0) THEN
    BEGIN
      DELETE FROM gr_config_expression
      WHERE object_name = isbObjectName;
      blReturn := FALSE;
    EXCEPTION
      when ex.RECORD_HAVE_CHILDREN then
         ut_trace.trace('Objeto ' || isbObjectName || ' usado en ' || nuCounter ||' reglas, no se borra',2);
         blReturn := TRUE;
    END;
  END IF;
  RETURN blReturn;
 END;

BEGIN
 ut_trace.trace('Inicia borrado de objetos de reglas',1);
 nuIndex := EXP_UNITTYPE_252_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_UNITTYPE_252_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_UNITTYPE_252_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_UNITTYPE_252_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_UNITTYPE_252_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_UNITTYPE_252_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_UNITTYPE_252_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_UNITTYPE_252_.tbObjectToDelete.next(nuIndex);
 END loop;
 ut_trace.trace('Finaliza borrado de objetos de reglas',1);
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('EXP_UNITTYPE_252_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_UNITTYPE_252_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_UNITTYPE_100588_',
'CREATE OR REPLACE PACKAGE EXP_UNITTYPE_100588_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyWF_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPERowId tyWF_UNIT_TYPERowId;type tyWF_CAUSAL_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_CAUSAL_UNIT_TYPERowId tyWF_CAUSAL_UNIT_TYPERowId;type tyGR_CONFIGURA_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIGURA_TYPERowId tyGR_CONFIGURA_TYPERowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type tyGE_ATTRIBUTE_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTE_CLASSRowId tyGE_ATTRIBUTE_CLASSRowId;type tyGE_ATTRIBUTES_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTES_TYPERowId tyGE_ATTRIBUTES_TYPERowId;type tyGE_ATTRIBUTESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTESRowId tyGE_ATTRIBUTESRowId;type tyGE_STATEMENTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_STATEMENTRowId tyGE_STATEMENTRowId;type tyWF_UNIT_TYPE_ATTRIBRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPE_ATTRIBRowId tyWF_UNIT_TYPE_ATTRIBRowId;type tyMO_TIME_UNI_TYP_PRIORowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbMO_TIME_UNI_TYP_PRIORowId tyMO_TIME_UNI_TYP_PRIORowId;type tyOR_ACT_BY_TASK_MODRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbOR_ACT_BY_TASK_MODRowId tyOR_ACT_BY_TASK_MODRowId;type ty0_0 is table of WF_UNIT_TYPE.UNIT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_5 is table of WF_UNIT_TYPE.INIT_AREA_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_5 ty0_5; ' || chr(10) ||
'tb0_5 ty0_5; ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_UNITTYPE_100588_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_UNITTYPE_100588_******************************'); END;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_UNITTYPE_100588',1);
EXP_UNITTYPE_100588_.blProcessStatus := EXP_PROCESS_100559_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  SELECT  B.object_name
FROM    OR_ACT_BY_TASK_MOD A, GR_CONFIG_EXPRESSION B 
WHERE   A.CONFIG_EXPRESSION_ID = B.CONFIG_EXPRESSION_ID
AND     A.TASK_CODE = 100588
 
;
BEGIN

if (not EXP_UNITTYPE_100588_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_UNITTYPE_100588_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
  nuIndex := nuIndex + 1;
 END LOOP;
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
END;
/

declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_TYPE_ATTRIB WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100588);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100588_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_TYPE_ATTRIB',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_TYPE_ATTRIB WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100588_.blProcessStatus := false;
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
FROM WF_CAUSAL_UNIT_TYPE WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100588);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100588_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_CAUSAL_UNIT_TYPE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_CAUSAL_UNIT_TYPE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100588_.blProcessStatus := false;
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
FROM MO_TIME_UNI_TYP_PRIO WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100588);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100588_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla MO_TIME_UNI_TYP_PRIO',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM MO_TIME_UNI_TYP_PRIO WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100588_.blProcessStatus := false;
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
FROM OR_ACT_BY_TASK_MOD WHERE (TASK_CODE) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100588);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100588_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla OR_ACT_BY_TASK_MOD',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM OR_ACT_BY_TASK_MOD WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100588_.blProcessStatus := false;
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
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100588;
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100588_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_TYPE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_TYPE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_UNITTYPE_100588_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100588_.tb0_0(0):=100588;
ut_trace.trace('insertando tabla sin fallo: WF_UNIT_TYPE fila (0)',1);
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_UNITTYPE_100588_.tb0_0(0),
1,
9,
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_100588'
,
'Generaci¿n de Cobros'
,
'Generaci¿n de Cobros'
,
null,
'N'
,
'N'
,
17,
'R'
,
'N'
,
null,
'N'
,
null,
null,
'N'
,
null,
null);

exception 
when dup_val_on_index then 
 return;
when others then
EXP_UNITTYPE_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100559',1);
EXP_PROCESS_100559_.blProcessStatus := EXP_UNITTYPE_100588_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/

DECLARE
 nuIndex         binary_integer;
 blObjectDeleted boolean;

 FUNCTION fblIsObjectUseByRule
 (
  isbObjectName   IN gr_config_expression.object_name%type
 ) return BOOLEAN
 IS
  nuCounter    NUMBER := 0;
  blReturn     BOOLEAN := FALSE;
 BEGIN
  SELECT count('x') INTO nuCounter
  FROM gr_config_expression
  WHERE object_name = isbObjectName;
  IF (nuCounter > 0) THEN
    BEGIN
      DELETE FROM gr_config_expression
      WHERE object_name = isbObjectName;
      blReturn := FALSE;
    EXCEPTION
      when ex.RECORD_HAVE_CHILDREN then
         ut_trace.trace('Objeto ' || isbObjectName || ' usado en ' || nuCounter ||' reglas, no se borra',2);
         blReturn := TRUE;
    END;
  END IF;
  RETURN blReturn;
 END;

BEGIN
 ut_trace.trace('Inicia borrado de objetos de reglas',1);
 nuIndex := EXP_UNITTYPE_100588_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_UNITTYPE_100588_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_UNITTYPE_100588_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_UNITTYPE_100588_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_UNITTYPE_100588_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_UNITTYPE_100588_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_UNITTYPE_100588_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_UNITTYPE_100588_.tbObjectToDelete.next(nuIndex);
 END loop;
 ut_trace.trace('Finaliza borrado de objetos de reglas',1);
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('EXP_UNITTYPE_100588_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_UNITTYPE_100588_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_UNITTYPE_100563_',
'CREATE OR REPLACE PACKAGE EXP_UNITTYPE_100563_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyWF_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPERowId tyWF_UNIT_TYPERowId;type tyWF_CAUSAL_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_CAUSAL_UNIT_TYPERowId tyWF_CAUSAL_UNIT_TYPERowId;type tyGR_CONFIGURA_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIGURA_TYPERowId tyGR_CONFIGURA_TYPERowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type tyGE_ATTRIBUTE_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTE_CLASSRowId tyGE_ATTRIBUTE_CLASSRowId;type tyGE_ATTRIBUTES_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTES_TYPERowId tyGE_ATTRIBUTES_TYPERowId;type tyGE_ATTRIBUTESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTESRowId tyGE_ATTRIBUTESRowId;type tyGE_STATEMENTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_STATEMENTRowId tyGE_STATEMENTRowId;type tyWF_UNIT_TYPE_ATTRIBRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPE_ATTRIBRowId tyWF_UNIT_TYPE_ATTRIBRowId;type tyMO_TIME_UNI_TYP_PRIORowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbMO_TIME_UNI_TYP_PRIORowId tyMO_TIME_UNI_TYP_PRIORowId;type tyOR_ACT_BY_TASK_MODRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbOR_ACT_BY_TASK_MODRowId tyOR_ACT_BY_TASK_MODRowId;type ty0_0 is table of WF_UNIT_TYPE.UNIT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_5 is table of WF_UNIT_TYPE.INIT_AREA_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_5 ty0_5; ' || chr(10) ||
'tb0_5 ty0_5; ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_UNITTYPE_100563_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_UNITTYPE_100563_******************************'); END;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_UNITTYPE_100563',1);
EXP_UNITTYPE_100563_.blProcessStatus := EXP_PROCESS_100559_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  SELECT  B.object_name
FROM    OR_ACT_BY_TASK_MOD A, GR_CONFIG_EXPRESSION B 
WHERE   A.CONFIG_EXPRESSION_ID = B.CONFIG_EXPRESSION_ID
AND     A.TASK_CODE = 100563
 
;
BEGIN

if (not EXP_UNITTYPE_100563_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_UNITTYPE_100563_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
  nuIndex := nuIndex + 1;
 END LOOP;
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
END;
/

declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_TYPE_ATTRIB WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100563);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100563_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_TYPE_ATTRIB',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_TYPE_ATTRIB WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100563_.blProcessStatus := false;
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
FROM WF_CAUSAL_UNIT_TYPE WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100563);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100563_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_CAUSAL_UNIT_TYPE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_CAUSAL_UNIT_TYPE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100563_.blProcessStatus := false;
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
FROM MO_TIME_UNI_TYP_PRIO WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100563);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100563_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla MO_TIME_UNI_TYP_PRIO',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM MO_TIME_UNI_TYP_PRIO WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100563_.blProcessStatus := false;
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
FROM OR_ACT_BY_TASK_MOD WHERE (TASK_CODE) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100563);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100563_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla OR_ACT_BY_TASK_MOD',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM OR_ACT_BY_TASK_MOD WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100563_.blProcessStatus := false;
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
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100563;
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100563_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_TYPE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_TYPE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100563_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_UNITTYPE_100563_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100563_.tb0_0(0):=100563;
ut_trace.trace('insertando tabla sin fallo: WF_UNIT_TYPE fila (0)',1);
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_UNITTYPE_100563_.tb0_0(0),
1,
9,
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_100563'
,
'Generar Orden a Recaudo'
,
'Generar Orden a Recaudo'
,
null,
'N'
,
'N'
,
null,
'R'
,
'N'
,
null,
'N'
,
null,
null,
'N'
,
null,
null);

exception 
when dup_val_on_index then 
 return;
when others then
EXP_UNITTYPE_100563_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100559',1);
EXP_PROCESS_100559_.blProcessStatus := EXP_UNITTYPE_100563_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/

DECLARE
 nuIndex         binary_integer;
 blObjectDeleted boolean;

 FUNCTION fblIsObjectUseByRule
 (
  isbObjectName   IN gr_config_expression.object_name%type
 ) return BOOLEAN
 IS
  nuCounter    NUMBER := 0;
  blReturn     BOOLEAN := FALSE;
 BEGIN
  SELECT count('x') INTO nuCounter
  FROM gr_config_expression
  WHERE object_name = isbObjectName;
  IF (nuCounter > 0) THEN
    BEGIN
      DELETE FROM gr_config_expression
      WHERE object_name = isbObjectName;
      blReturn := FALSE;
    EXCEPTION
      when ex.RECORD_HAVE_CHILDREN then
         ut_trace.trace('Objeto ' || isbObjectName || ' usado en ' || nuCounter ||' reglas, no se borra',2);
         blReturn := TRUE;
    END;
  END IF;
  RETURN blReturn;
 END;

BEGIN
 ut_trace.trace('Inicia borrado de objetos de reglas',1);
 nuIndex := EXP_UNITTYPE_100563_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_UNITTYPE_100563_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_UNITTYPE_100563_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_UNITTYPE_100563_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_UNITTYPE_100563_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_UNITTYPE_100563_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_UNITTYPE_100563_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_UNITTYPE_100563_.tbObjectToDelete.next(nuIndex);
 END loop;
 ut_trace.trace('Finaliza borrado de objetos de reglas',1);
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('EXP_UNITTYPE_100563_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_UNITTYPE_100563_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_PROCESS_100588_',
'CREATE OR REPLACE PACKAGE EXP_PROCESS_100588_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyWF_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPERowId tyWF_UNIT_TYPERowId;type tyWF_UNIT_CATEGORYRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_CATEGORYRowId tyWF_UNIT_CATEGORYRowId;type tyWF_ATTRIBUTES_EQUIVRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_ATTRIBUTES_EQUIVRowId tyWF_ATTRIBUTES_EQUIVRowId;type tyGE_COMMENT_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_COMMENT_CLASSRowId tyGE_COMMENT_CLASSRowId;type tyGR_CONFIGURA_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIGURA_TYPERowId tyGR_CONFIGURA_TYPERowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type tyGE_ATTRIBUTE_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTE_CLASSRowId tyGE_ATTRIBUTE_CLASSRowId;type tyGE_ATTRIBUTES_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTES_TYPERowId tyGE_ATTRIBUTES_TYPERowId;type tyGE_ATTRIBUTESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTESRowId tyGE_ATTRIBUTESRowId;type tyGE_STATEMENTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_STATEMENTRowId tyGE_STATEMENTRowId;type tyWF_UNIT_ATTRIBUTERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_ATTRIBUTERowId tyWF_UNIT_ATTRIBUTERowId;type tyGE_MODULERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_MODULERowId tyGE_MODULERowId;type tyWF_NODE_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_NODE_TYPERowId tyWF_NODE_TYPERowId;type tyWF_UNITRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNITRowId tyWF_UNITRowId;type tyWF_UNIT_DATA_MAPRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_DATA_MAPRowId tyWF_UNIT_DATA_MAPRowId;type tyWF_TRANSITIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_TRANSITIONRowId tyWF_TRANSITIONRowId;type ty0_0 is table of WF_UNIT_CATEGORY.CATEGORY_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty1_0 is table of GE_MODULE.MODULE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_0 ty1_0; ' || chr(10) ||
'tb1_0 ty1_0;type ty2_0 is table of WF_UNIT_TYPE.UNIT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;type ty2_1 is table of WF_UNIT_TYPE.CATEGORY_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_1 ty2_1; ' || chr(10) ||
'tb2_1 ty2_1;type ty2_2 is table of WF_UNIT_TYPE.MODULE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_2 ty2_2; ' || chr(10) ||
'tb2_2 ty2_2;type ty2_5 is table of WF_UNIT_TYPE.INIT_AREA_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_5 ty2_5; ' || chr(10) ||
'tb2_5 ty2_5;type ty2_6 is table of WF_UNIT_TYPE.ASSIGN_COMMENT_CLASS%type index by binary_integer; ' || chr(10) ||
'old_tb2_6 ty2_6; ' || chr(10) ||
'tb2_6 ty2_6;type ty2_7 is table of WF_UNIT_TYPE.ATTEND_COMMENT_CLASS%type index by binary_integer; ' || chr(10) ||
'old_tb2_7 ty2_7; ' || chr(10) ||
'tb2_7 ty2_7;type ty2_8 is table of WF_UNIT_TYPE.UNASSIGN_COMMENT_CLASS%type index by binary_integer; ' || chr(10) ||
'old_tb2_8 ty2_8; ' || chr(10) ||
'tb2_8 ty2_8;type ty3_0 is table of WF_NODE_TYPE.NODE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_0 ty3_0; ' || chr(10) ||
'tb3_0 ty3_0;type ty4_0 is table of WF_UNIT.UNIT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_0 ty4_0; ' || chr(10) ||
'tb4_0 ty4_0;type ty4_1 is table of WF_UNIT.PROCESS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_1 ty4_1; ' || chr(10) ||
'tb4_1 ty4_1;type ty4_2 is table of WF_UNIT.UNIT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_2 ty4_2; ' || chr(10) ||
'tb4_2 ty4_2;type ty4_3 is table of WF_UNIT.NODE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_3 ty4_3; ' || chr(10) ||
'tb4_3 ty4_3;type ty4_4 is table of WF_UNIT.MODULE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_4 ty4_4; ' || chr(10) ||
'tb4_4 ty4_4;type ty4_6 is table of WF_UNIT.PRE_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_6 ty4_6; ' || chr(10) ||
'tb4_6 ty4_6;type ty4_7 is table of WF_UNIT.POS_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_7 ty4_7; ' || chr(10) ||
'tb4_7 ty4_7;type ty5_0 is table of WF_TRANSITION.TRANS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_0 ty5_0; ' || chr(10) ||
'tb5_0 ty5_0;type ty5_1 is table of WF_TRANSITION.ORIGIN_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_1 ty5_1; ' || chr(10) ||
'tb5_1 ty5_1;type ty5_2 is table of WF_TRANSITION.TARGET_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_2 ty5_2; ' || chr(10) ||
'tb5_2 ty5_2;type ty6_0 is table of GE_ATTRIBUTE_CLASS.ATTRIBUTE_CLASS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_0 ty6_0; ' || chr(10) ||
'tb6_0 ty6_0;type ty7_0 is table of GE_ATTRIBUTES_TYPE.ATTRIBUTE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_0 ty7_0; ' || chr(10) ||
'tb7_0 ty7_0;type ty8_0 is table of GE_ATTRIBUTES.ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_0 ty8_0; ' || chr(10) ||
'tb8_0 ty8_0;type ty8_1 is table of GE_ATTRIBUTES.ATTRIBUTE_CLASS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_1 ty8_1; ' || chr(10) ||
'tb8_1 ty8_1;type ty8_2 is table of GE_ATTRIBUTES.ATTRIBUTE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_2 ty8_2; ' || chr(10) ||
'tb8_2 ty8_2;type ty9_0 is table of WF_UNIT_ATTRIBUTE.UNIT_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb9_0 ty9_0; ' || chr(10) ||
'tb9_0 ty9_0;type ty9_1 is table of WF_UNIT_ATTRIBUTE.UNIT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb9_1 ty9_1; ' || chr(10) ||
'tb9_1 ty9_1;type ty9_2 is table of WF_UNIT_ATTRIBUTE.ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb9_2 ty9_2; ' || chr(10) ||
'tb9_2 ty9_2;type ty9_3 is table of WF_UNIT_ATTRIBUTE.STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb9_3 ty9_3; ' || chr(10) ||
'tb9_3 ty9_3;type ty10_0 is table of GE_STATEMENT.STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb10_0 ty10_0; ' || chr(10) ||
'tb10_0 ty10_0; ' || chr(10) ||
'CURSOR cuExpression is ' || chr(10) ||
'SELECT PRE_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_TYPE_ID = 100588 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID IN  ' || chr(10) ||
'           (SELECT UNIT_ID ' || chr(10) ||
'           FROM WF_UNIT ' || chr(10) ||
'           WHERE UNIT_TYPE_ID = 100588 ' || chr(10) ||
'       )) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_TYPE_ID = 100588 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID IN  ' || chr(10) ||
'           (SELECT UNIT_ID ' || chr(10) ||
'           FROM WF_UNIT ' || chr(10) ||
'           WHERE UNIT_TYPE_ID = 100588 ' || chr(10) ||
'       )) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_PROCESS_100588_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_PROCESS_100588_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open EXP_PROCESS_100588_.cuExpression;
   fetch EXP_PROCESS_100588_.cuExpression bulk collect INTO EXP_PROCESS_100588_.tbGR_CONFIG_EXPRESSIONId;
   close EXP_PROCESS_100588_.cuExpression;
END;
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100588',1);
EXP_PROCESS_100588_.blProcessStatus := EXP_PROCESS_100559_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('DEL_ROOT_102782_',
'CREATE OR REPLACE PACKAGE DEL_ROOT_102782_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyWF_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPERowId tyWF_UNIT_TYPERowId;type tyWF_UNIT_CATEGORYRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_CATEGORYRowId tyWF_UNIT_CATEGORYRowId;type tyWF_ATTRIBUTES_EQUIVRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_ATTRIBUTES_EQUIVRowId tyWF_ATTRIBUTES_EQUIVRowId;type tyGE_COMMENT_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_COMMENT_CLASSRowId tyGE_COMMENT_CLASSRowId;type tyGR_CONFIGURA_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIGURA_TYPERowId tyGR_CONFIGURA_TYPERowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type tyGE_ATTRIBUTE_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTE_CLASSRowId tyGE_ATTRIBUTE_CLASSRowId;type tyGE_ATTRIBUTES_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTES_TYPERowId tyGE_ATTRIBUTES_TYPERowId;type tyGE_ATTRIBUTESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTESRowId tyGE_ATTRIBUTESRowId;type tyGE_STATEMENTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_STATEMENTRowId tyGE_STATEMENTRowId;type tyWF_UNIT_ATTRIBUTERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_ATTRIBUTERowId tyWF_UNIT_ATTRIBUTERowId;type tyGE_MODULERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_MODULERowId tyGE_MODULERowId;type tyWF_NODE_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_NODE_TYPERowId tyWF_NODE_TYPERowId;type tyWF_UNITRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNITRowId tyWF_UNITRowId;type tyWF_UNIT_DATA_MAPRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_DATA_MAPRowId tyWF_UNIT_DATA_MAPRowId;type tyWF_TRANSITIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_TRANSITIONRowId tyWF_TRANSITIONRowId;type ty0_0 is table of WF_UNIT.UNIT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_6 is table of WF_UNIT.PRE_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_6 ty0_6; ' || chr(10) ||
'tb0_6 ty0_6;type ty0_7 is table of WF_UNIT.POS_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_7 ty0_7; ' || chr(10) ||
'tb0_7 ty0_7;type ty1_0 is table of WF_TRANSITION.TRANS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_0 ty1_0; ' || chr(10) ||
'tb1_0 ty1_0;type ty1_1 is table of WF_TRANSITION.ORIGIN_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_1 ty1_1; ' || chr(10) ||
'tb1_1 ty1_1;type ty1_2 is table of WF_TRANSITION.TARGET_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_2 ty1_2; ' || chr(10) ||
'tb1_2 ty1_2;type ty2_0 is table of WF_UNIT_ATTRIBUTE.UNIT_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;type ty2_1 is table of WF_UNIT_ATTRIBUTE.UNIT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_1 ty2_1; ' || chr(10) ||
'tb2_1 ty2_1; ' || chr(10) ||
'CURSOR cuExpression is ' || chr(10) ||
'SELECT PRE_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_ID = 102782 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 102782  ' || chr(10) ||
'       ) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_ID = 102782 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 102782  ' || chr(10) ||
'       ) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END DEL_ROOT_102782_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:DEL_ROOT_102782_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open DEL_ROOT_102782_.cuExpression;
   fetch DEL_ROOT_102782_.cuExpression bulk collect INTO DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONId;
   close DEL_ROOT_102782_.cuExpression;
END;
/ 

DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  SELECT  B.object_name
FROM    WF_UNIT A, GR_CONFIG_EXPRESSION B
WHERE   (A.PRE_EXPRESSION_ID = b.CONFIG_EXPRESSION_ID
OR   A.POS_EXPRESSION_ID = b.CONFIG_EXPRESSION_ID)
AND     A.UNIT_ID IN (
        SELECT UNIT_ID         FROM WF_UNIT 
        WHERE UNIT_ID = 102782
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID = 102782 
       )
;
BEGIN

if (not DEL_ROOT_102782_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  DEL_ROOT_102782_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
  nuIndex := nuIndex + 1;
 END LOOP;
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
END;
/

DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE PROCESS_ID = 102782);
BEGIN 

if (not DEL_ROOT_102782_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102782_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE PROCESS_ID = 102782);
BEGIN 

if (not DEL_ROOT_102782_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102782_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 102782)));
BEGIN 

if (not DEL_ROOT_102782_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102782_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 102782)));
BEGIN 

if (not DEL_ROOT_102782_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102782_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 102782));
BEGIN 

if (not DEL_ROOT_102782_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla WF_UNIT',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102782_.tbWF_UNITRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102782_.blProcessStatus := false;
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
FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 102782);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102782_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_TRANSITION',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_TRANSITION WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
DEL_ROOT_102782_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102782_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102782_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102782_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102782_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102782_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria WF_UNIT',1);
nuVarcharIndex:=DEL_ROOT_102782_.tbWF_UNITRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from WF_UNIT where rowid = DEL_ROOT_102782_.tbWF_UNITRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102782_.tbWF_UNITRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102782_.tbWF_UNITRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102782_.blProcessStatus := false;
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
FROM WF_UNIT_DATA_MAP WHERE (SOURCE_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 102782));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102782_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_DATA_MAP',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_DATA_MAP WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
DEL_ROOT_102782_.blProcessStatus := false;
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
FROM WF_UNIT_DATA_MAP WHERE (TARGET_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 102782));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102782_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_DATA_MAP',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_DATA_MAP WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
DEL_ROOT_102782_.blProcessStatus := false;
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
FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 102782);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102782_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_ATTRIBUTE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_ATTRIBUTE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
DEL_ROOT_102782_.blProcessStatus := false;
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
FROM WF_UNIT WHERE PROCESS_ID = 102782;
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102782_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
DEL_ROOT_102782_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102782_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102782_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102782_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102782_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/

BEGIN
    ut_trace.trace('Actualizar WF_UNIT a ProcessId NULL ',1);
   UPDATE WF_UNIT 
     SET PROCESS_ID = -1, POS_EXPRESSION_ID = null, PRE_EXPRESSION_ID = null, ACTION_ID = null 
     WHERE PROCESS_ID = 102782;
   exception
         when others then 
            rollback;
            ut_trace.trace('**ERROR:'||sqlerrm,1);
            raise;
END;
  
/

DECLARE 
    nuBinaryIndex Binary_Integer;
BEGIN 
    nuBinaryIndex := DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       DEL_ROOT_102782_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100588',1);
EXP_PROCESS_100588_.blProcessStatus := DEL_ROOT_102782_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/

DECLARE
 nuIndex         binary_integer;
 blObjectDeleted boolean;

 FUNCTION fblIsObjectUseByRule
 (
  isbObjectName   IN gr_config_expression.object_name%type
 ) return BOOLEAN
 IS
  nuCounter    NUMBER := 0;
  blReturn     BOOLEAN := FALSE;
 BEGIN
  SELECT count('x') INTO nuCounter
  FROM gr_config_expression
  WHERE object_name = isbObjectName;
  IF (nuCounter > 0) THEN
    BEGIN
      DELETE FROM gr_config_expression
      WHERE object_name = isbObjectName;
      blReturn := FALSE;
    EXCEPTION
      when ex.RECORD_HAVE_CHILDREN then
         ut_trace.trace('Objeto ' || isbObjectName || ' usado en ' || nuCounter ||' reglas, no se borra',2);
         blReturn := TRUE;
    END;
  END IF;
  RETURN blReturn;
 END;

BEGIN
 ut_trace.trace('Inicia borrado de objetos de reglas',1);
 nuIndex := DEL_ROOT_102782_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || DEL_ROOT_102782_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(DEL_ROOT_102782_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(DEL_ROOT_102782_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(DEL_ROOT_102782_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || DEL_ROOT_102782_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || DEL_ROOT_102782_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := DEL_ROOT_102782_.tbObjectToDelete.next(nuIndex);
 END loop;
 ut_trace.trace('Finaliza borrado de objetos de reglas',1);
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('DEL_ROOT_102782_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:DEL_ROOT_102782_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('DEL_ROOT_102782_',
'CREATE OR REPLACE PACKAGE DEL_ROOT_102782_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyWF_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPERowId tyWF_UNIT_TYPERowId;type tyWF_UNIT_CATEGORYRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_CATEGORYRowId tyWF_UNIT_CATEGORYRowId;type tyWF_ATTRIBUTES_EQUIVRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_ATTRIBUTES_EQUIVRowId tyWF_ATTRIBUTES_EQUIVRowId;type tyGE_COMMENT_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_COMMENT_CLASSRowId tyGE_COMMENT_CLASSRowId;type tyGR_CONFIGURA_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIGURA_TYPERowId tyGR_CONFIGURA_TYPERowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type tyGE_ATTRIBUTE_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTE_CLASSRowId tyGE_ATTRIBUTE_CLASSRowId;type tyGE_ATTRIBUTES_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTES_TYPERowId tyGE_ATTRIBUTES_TYPERowId;type tyGE_ATTRIBUTESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTESRowId tyGE_ATTRIBUTESRowId;type tyGE_STATEMENTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_STATEMENTRowId tyGE_STATEMENTRowId;type tyWF_UNIT_ATTRIBUTERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_ATTRIBUTERowId tyWF_UNIT_ATTRIBUTERowId;type tyGE_MODULERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_MODULERowId tyGE_MODULERowId;type tyWF_NODE_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_NODE_TYPERowId tyWF_NODE_TYPERowId;type tyWF_UNITRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNITRowId tyWF_UNITRowId;type tyWF_UNIT_DATA_MAPRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_DATA_MAPRowId tyWF_UNIT_DATA_MAPRowId;type tyWF_TRANSITIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_TRANSITIONRowId tyWF_TRANSITIONRowId;type ty0_0 is table of WF_UNIT.UNIT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_6 is table of WF_UNIT.PRE_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_6 ty0_6; ' || chr(10) ||
'tb0_6 ty0_6;type ty0_7 is table of WF_UNIT.POS_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_7 ty0_7; ' || chr(10) ||
'tb0_7 ty0_7; ' || chr(10) ||
'CURSOR cuExpression is ' || chr(10) ||
'SELECT PRE_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_ID = 102782 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 102782  ' || chr(10) ||
'       ) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_ID = 102782 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 102782  ' || chr(10) ||
'       ) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END DEL_ROOT_102782_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:DEL_ROOT_102782_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open DEL_ROOT_102782_.cuExpression;
   fetch DEL_ROOT_102782_.cuExpression bulk collect INTO DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONId;
   close DEL_ROOT_102782_.cuExpression;
END;
/ 

DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  SELECT  B.object_name
FROM    WF_UNIT A, GR_CONFIG_EXPRESSION B
WHERE   (A.PRE_EXPRESSION_ID = b.CONFIG_EXPRESSION_ID
OR   A.POS_EXPRESSION_ID = b.CONFIG_EXPRESSION_ID)
AND     A.UNIT_ID IN (
        SELECT UNIT_ID         FROM WF_UNIT 
        WHERE UNIT_ID = 102782
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID = 102782 
       )
;
BEGIN

if (not DEL_ROOT_102782_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  DEL_ROOT_102782_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
  nuIndex := nuIndex + 1;
 END LOOP;
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
END;
/

DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE UNIT_ID = 102782);
BEGIN 

if (not DEL_ROOT_102782_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102782_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE UNIT_ID = 102782);
BEGIN 

if (not DEL_ROOT_102782_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102782_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 102782)));
BEGIN 

if (not DEL_ROOT_102782_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102782_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 102782)));
BEGIN 

if (not DEL_ROOT_102782_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102782_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 102782));
BEGIN 

if (not DEL_ROOT_102782_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla WF_UNIT',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102782_.tbWF_UNITRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102782_.blProcessStatus := false;
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
FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 102782);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102782_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_TRANSITION',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_TRANSITION WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
DEL_ROOT_102782_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102782_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102782_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102782_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102782_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102782_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria WF_UNIT',1);
nuVarcharIndex:=DEL_ROOT_102782_.tbWF_UNITRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from WF_UNIT where rowid = DEL_ROOT_102782_.tbWF_UNITRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102782_.tbWF_UNITRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102782_.tbWF_UNITRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102782_.blProcessStatus := false;
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
FROM WF_UNIT_DATA_MAP WHERE (SOURCE_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 102782));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102782_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_DATA_MAP',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_DATA_MAP WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
DEL_ROOT_102782_.blProcessStatus := false;
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
FROM WF_UNIT_DATA_MAP WHERE (TARGET_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 102782));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102782_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_DATA_MAP',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_DATA_MAP WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
DEL_ROOT_102782_.blProcessStatus := false;
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
FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 102782);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102782_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_ATTRIBUTE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_ATTRIBUTE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
DEL_ROOT_102782_.blProcessStatus := false;
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
FROM WF_UNIT WHERE UNIT_ID = 102782;
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102782_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
DEL_ROOT_102782_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102782_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102782_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102782_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102782_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/

BEGIN
    ut_trace.trace('Actualizar WF_UNIT a ProcessId NULL ',1);
   UPDATE WF_UNIT 
     SET PROCESS_ID = -1, POS_EXPRESSION_ID = null, PRE_EXPRESSION_ID = null, ACTION_ID = null 
     WHERE PROCESS_ID = 102782;
   exception
         when others then 
            rollback;
            ut_trace.trace('**ERROR:'||sqlerrm,1);
            raise;
END;
  
/

DECLARE 
    nuBinaryIndex Binary_Integer;
BEGIN 
    nuBinaryIndex := DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := DEL_ROOT_102782_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       DEL_ROOT_102782_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100588',1);
EXP_PROCESS_100588_.blProcessStatus := DEL_ROOT_102782_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/

DECLARE
 nuIndex         binary_integer;
 blObjectDeleted boolean;

 FUNCTION fblIsObjectUseByRule
 (
  isbObjectName   IN gr_config_expression.object_name%type
 ) return BOOLEAN
 IS
  nuCounter    NUMBER := 0;
  blReturn     BOOLEAN := FALSE;
 BEGIN
  SELECT count('x') INTO nuCounter
  FROM gr_config_expression
  WHERE object_name = isbObjectName;
  IF (nuCounter > 0) THEN
    BEGIN
      DELETE FROM gr_config_expression
      WHERE object_name = isbObjectName;
      blReturn := FALSE;
    EXCEPTION
      when ex.RECORD_HAVE_CHILDREN then
         ut_trace.trace('Objeto ' || isbObjectName || ' usado en ' || nuCounter ||' reglas, no se borra',2);
         blReturn := TRUE;
    END;
  END IF;
  RETURN blReturn;
 END;

BEGIN
 ut_trace.trace('Inicia borrado de objetos de reglas',1);
 nuIndex := DEL_ROOT_102782_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || DEL_ROOT_102782_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(DEL_ROOT_102782_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(DEL_ROOT_102782_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(DEL_ROOT_102782_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || DEL_ROOT_102782_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || DEL_ROOT_102782_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := DEL_ROOT_102782_.tbObjectToDelete.next(nuIndex);
 END loop;
 ut_trace.trace('Finaliza borrado de objetos de reglas',1);
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('DEL_ROOT_102782_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:DEL_ROOT_102782_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_ACTION_8133_',
'CREATE OR REPLACE PACKAGE EXP_ACTION_8133_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyGR_CONFIGURA_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIGURA_TYPERowId tyGR_CONFIGURA_TYPERowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type tyGE_ACTION_MODULERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ACTION_MODULERowId tyGE_ACTION_MODULERowId;type tyGE_VALID_ACTION_MODURowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_VALID_ACTION_MODURowId tyGE_VALID_ACTION_MODURowId;type ty0_0 is table of GR_CONFIGURA_TYPE.CONFIGURA_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty1_0 is table of GR_CONFIG_EXPRESSION.CONFIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_0 ty1_0; ' || chr(10) ||
'tb1_0 ty1_0;type ty1_1 is table of GR_CONFIG_EXPRESSION.OBJECT_NAME%type index by binary_integer; ' || chr(10) ||
'old_tb1_1 ty1_1; ' || chr(10) ||
'tb1_1 ty1_1;type ty1_2 is table of GR_CONFIG_EXPRESSION.CONFIGURA_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_2 ty1_2; ' || chr(10) ||
'tb1_2 ty1_2;type ty2_0 is table of GE_ACTION_MODULE.ACTION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;type ty2_2 is table of GE_ACTION_MODULE.CONFIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_2 ty2_2; ' || chr(10) ||
'tb2_2 ty2_2;type ty3_0 is table of GE_VALID_ACTION_MODU.ACTION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_0 ty3_0; ' || chr(10) ||
'tb3_0 ty3_0;type ty3_1 is table of GE_VALID_ACTION_MODU.VALID_MODULE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_1 ty3_1; ' || chr(10) ||
'tb3_1 ty3_1; ' || chr(10) ||
'CURSOR cuExpression is ' || chr(10) ||
'SELECT CONFIG_EXPRESSION_ID ' || chr(10) ||
'FROM   GE_ACTION_MODULE ' || chr(10) ||
'WHERE  ACTION_ID =8133; ' || chr(10) ||
'type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_ACTION_8133_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_ACTION_8133_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open EXP_ACTION_8133_.cuExpression;
   fetch EXP_ACTION_8133_.cuExpression bulk collect INTO EXP_ACTION_8133_.tbGR_CONFIG_EXPRESSIONId;
   close EXP_ACTION_8133_.cuExpression;
END;
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_ACTION_8133',1);
EXP_ACTION_8133_.blProcessStatus := EXP_PROCESS_100588_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  SELECT  B.object_name
FROM    GE_ACTION_MODULE A, GR_CONFIG_EXPRESSION B
WHERE   A.CONFIG_EXPRESSION_ID = b.CONFIG_EXPRESSION_ID
AND     A.ACTION_ID =8133
;
BEGIN

if (not EXP_ACTION_8133_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_ACTION_8133_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
  nuIndex := nuIndex + 1;
 END LOOP;
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
END;
/

DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE ACTION_ID=8133);
BEGIN 

if (not EXP_ACTION_8133_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_ACTION_8133_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_ACTION_8133_.blProcessStatus := false;
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
FROM GE_ACTION_MODULE WHERE ACTION_ID=8133;
nuIndex binary_integer;
BEGIN

if (not EXP_ACTION_8133_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_ACTION_MODULE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM GE_ACTION_MODULE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_ACTION_8133_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_ACTION_8133_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_ACTION_8133_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_ACTION_8133_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_ACTION_8133_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_ACTION_8133_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_ACTION_8133_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_ACTION_8133_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8133_.tb0_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=EXP_ACTION_8133_.tb0_0(0),
MODULE_ID=1,
DESCRIPTION='Ejecuci¿n Acciones de todos los m¿dulos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_EXEACTION_'

 WHERE CONFIGURA_TYPE_ID = EXP_ACTION_8133_.tb0_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (EXP_ACTION_8133_.tb0_0(0),
1,
'Ejecuci¿n Acciones de todos los m¿dulos'
,
'PL'
,
'FD'
,
'DS'
,
'_EXEACTION_'
);
end if;

exception when others then
EXP_ACTION_8133_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_8133_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8133_.old_tb1_0(0):=121397105;
EXP_ACTION_8133_.tb1_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
EXP_ACTION_8133_.tb1_0(0):=EXP_ACTION_8133_.tb1_0(0);
EXP_ACTION_8133_.old_tb1_1(0):='GE_EXEACTION_CT1E121397105'
;
EXP_ACTION_8133_.tb1_1(0):=TO_CHAR(EXP_ACTION_8133_.tb1_0(0));
EXP_ACTION_8133_.tb1_2(0):=EXP_ACTION_8133_.tb0_0(0);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (EXP_ACTION_8133_.tb1_0(0),
EXP_ACTION_8133_.tb1_1(0),
EXP_ACTION_8133_.tb1_2(0),
'nuPackageId = MO_BOINSTANCE_DB.FNUGETPACKIDINSTANCE();CC_BOREQUESTRATING.REQUESTRATINGBYFGCA(nuPackageId)'
,
'LBTEST'
,
to_date('07-06-2012 16:10:39','DD-MM-YYYY HH24:MI:SS'),
to_date('29-03-2023 09:35:50','DD-MM-YYYY HH24:MI:SS'),
to_date('29-03-2023 09:35:50','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'ACCI¿N COBRO DEL TR¿MITE - Suspensi¿n y Reconexi¿n Voluntaria'
,
'PP'
,
null);

exception when others then
EXP_ACTION_8133_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_8133_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8133_.tb2_0(0):=8133;
EXP_ACTION_8133_.tb2_2(0):=EXP_ACTION_8133_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ACTION_MODULE fila (0)',1);
UPDATE GE_ACTION_MODULE SET ACTION_ID=EXP_ACTION_8133_.tb2_0(0),
MODULE_ID=5,
CONFIG_EXPRESSION_ID=EXP_ACTION_8133_.tb2_2(0),
DESCRIPTION='ACCI¿N COBRO DEL TR¿MITE - Flujo de suspensi¿n y de reconexi¿n voluntaria'
,
EXE_AT_STATUS_CHANGE='N'
,
EXE_TRANSITION_STATE='N'

 WHERE ACTION_ID = EXP_ACTION_8133_.tb2_0(0);
if not (sql%found) then
INSERT INTO GE_ACTION_MODULE(ACTION_ID,MODULE_ID,CONFIG_EXPRESSION_ID,DESCRIPTION,EXE_AT_STATUS_CHANGE,EXE_TRANSITION_STATE) 
VALUES (EXP_ACTION_8133_.tb2_0(0),
5,
EXP_ACTION_8133_.tb2_2(0),
'ACCI¿N COBRO DEL TR¿MITE - Flujo de suspensi¿n y de reconexi¿n voluntaria'
,
'N'
,
'N'
);
end if;

exception when others then
EXP_ACTION_8133_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_8133_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8133_.tb3_0(0):=EXP_ACTION_8133_.tb2_0(0);
EXP_ACTION_8133_.tb3_1(0):=9;
ut_trace.trace('insertando tabla sin fallo: GE_VALID_ACTION_MODU fila (0)',1);
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (EXP_ACTION_8133_.tb3_0(0),
EXP_ACTION_8133_.tb3_1(0));

exception 
when dup_val_on_index then 
 return;
when others then
EXP_ACTION_8133_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
DECLARE 
    nuBinaryIndex Binary_Integer;
BEGIN 
    nuBinaryIndex := EXP_ACTION_8133_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = EXP_ACTION_8133_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||EXP_ACTION_8133_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||EXP_ACTION_8133_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := EXP_ACTION_8133_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       EXP_ACTION_8133_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100588',1);
EXP_PROCESS_100588_.blProcessStatus := EXP_ACTION_8133_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
COMMIT
/

DECLARE
PRAGMA AUTONOMOUS_TRANSACTION;
nuRowProcess number;
BEGIN 

if (not EXP_ACTION_8133_.blProcessStatus) then
 return;
end if;
nuRowProcess:=EXP_ACTION_8133_.tb1_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| EXP_ACTION_8133_.tb1_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(EXP_ACTION_8133_.tb1_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| EXP_ACTION_8133_.tb1_0(nuRowProcess),1);
end;
nuRowProcess := EXP_ACTION_8133_.tb1_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
EXP_ACTION_8133_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

DECLARE
 nuIndex         binary_integer;
 blObjectDeleted boolean;

 FUNCTION fblIsObjectUseByRule
 (
  isbObjectName   IN gr_config_expression.object_name%type
 ) return BOOLEAN
 IS
  nuCounter    NUMBER := 0;
  blReturn     BOOLEAN := FALSE;
 BEGIN
  SELECT count('x') INTO nuCounter
  FROM gr_config_expression
  WHERE object_name = isbObjectName;
  IF (nuCounter > 0) THEN
    BEGIN
      DELETE FROM gr_config_expression
      WHERE object_name = isbObjectName;
      blReturn := FALSE;
    EXCEPTION
      when ex.RECORD_HAVE_CHILDREN then
         ut_trace.trace('Objeto ' || isbObjectName || ' usado en ' || nuCounter ||' reglas, no se borra',2);
         blReturn := TRUE;
    END;
  END IF;
  RETURN blReturn;
 END;

BEGIN
 ut_trace.trace('Inicia borrado de objetos de reglas',1);
 nuIndex := EXP_ACTION_8133_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_ACTION_8133_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_ACTION_8133_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_ACTION_8133_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_ACTION_8133_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_ACTION_8133_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_ACTION_8133_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_ACTION_8133_.tbObjectToDelete.next(nuIndex);
 END loop;
 ut_trace.trace('Finaliza borrado de objetos de reglas',1);
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
END;
/


begin
SA_BOCreatePackages.DropPackage('EXP_ACTION_8133_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_ACTION_8133_******************************'); end;
/

BEGIN
ut_trace.trace('Actualizar o Insertar Tabla WF_UNIT_TYPE (Carpeta)',1);
    UPDATE wf_unit_type
    SET
       description = 'Gas', display = 'Flujos de GAS', parent_id = 100302, category_id = 0, icon = '', tag_name = 'UNIT_TYPE_100302', is_stage_process = 'N', usable_in_flow_stage = 'N', entity_id = null, multi_instance = 'R', module_id = 9, is_countable = 'N', notification_id = null, viewable = 'N', action_id = null, default_priority_id = null, init_area_expression_id = null, initial_notify_time = null, is_admin_process = 'N', assign_comment_class = null, attend_comment_class = null
    WHERE 
      unit_type_id = 100302;
 if not (sql%found) then 
    INSERT INTO wf_unit_type
    ( unit_type_id, description, display, parent_id, category_id, icon, tag_name, is_stage_process, usable_in_flow_stage, entity_id, multi_instance, module_id, is_countable, notification_id, viewable, action_id, default_priority_id, init_area_expression_id, initial_notify_time, is_admin_process, assign_comment_class, attend_comment_class )
    VALUES
    (100302, 'Gas', 'Flujos de GAS', 100302, 0, '', 'UNIT_TYPE_100302', 'N', 'N', null, 'R', 9, 'N', null, 'N', null, null, null, null, 'N', null, null); 
end if;
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_ACTION_222_',
'CREATE OR REPLACE PACKAGE EXP_ACTION_222_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyGR_CONFIGURA_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIGURA_TYPERowId tyGR_CONFIGURA_TYPERowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type tyGE_ACTION_MODULERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ACTION_MODULERowId tyGE_ACTION_MODULERowId;type tyGE_VALID_ACTION_MODURowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_VALID_ACTION_MODURowId tyGE_VALID_ACTION_MODURowId;type ty0_0 is table of GR_CONFIGURA_TYPE.CONFIGURA_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty1_0 is table of GR_CONFIG_EXPRESSION.CONFIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_0 ty1_0; ' || chr(10) ||
'tb1_0 ty1_0;type ty1_1 is table of GR_CONFIG_EXPRESSION.OBJECT_NAME%type index by binary_integer; ' || chr(10) ||
'old_tb1_1 ty1_1; ' || chr(10) ||
'tb1_1 ty1_1;type ty1_2 is table of GR_CONFIG_EXPRESSION.CONFIGURA_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_2 ty1_2; ' || chr(10) ||
'tb1_2 ty1_2;type ty2_0 is table of GE_ACTION_MODULE.ACTION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;type ty2_2 is table of GE_ACTION_MODULE.CONFIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_2 ty2_2; ' || chr(10) ||
'tb2_2 ty2_2;type ty3_0 is table of GE_VALID_ACTION_MODU.ACTION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_0 ty3_0; ' || chr(10) ||
'tb3_0 ty3_0;type ty3_1 is table of GE_VALID_ACTION_MODU.VALID_MODULE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_1 ty3_1; ' || chr(10) ||
'tb3_1 ty3_1; ' || chr(10) ||
'CURSOR cuExpression is ' || chr(10) ||
'SELECT CONFIG_EXPRESSION_ID ' || chr(10) ||
'FROM   GE_ACTION_MODULE ' || chr(10) ||
'WHERE  ACTION_ID =222; ' || chr(10) ||
'type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_ACTION_222_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_ACTION_222_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open EXP_ACTION_222_.cuExpression;
   fetch EXP_ACTION_222_.cuExpression bulk collect INTO EXP_ACTION_222_.tbGR_CONFIG_EXPRESSIONId;
   close EXP_ACTION_222_.cuExpression;
END;
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_ACTION_222',1);
EXP_ACTION_222_.blProcessStatus := EXP_PROCESS_100588_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  SELECT  B.object_name
FROM    GE_ACTION_MODULE A, GR_CONFIG_EXPRESSION B
WHERE   A.CONFIG_EXPRESSION_ID = b.CONFIG_EXPRESSION_ID
AND     A.ACTION_ID =222
;
BEGIN

if (not EXP_ACTION_222_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_ACTION_222_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
  nuIndex := nuIndex + 1;
 END LOOP;
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
END;
/

DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE ACTION_ID=222);
BEGIN 

if (not EXP_ACTION_222_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_ACTION_222_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_ACTION_222_.blProcessStatus := false;
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
FROM GE_ACTION_MODULE WHERE ACTION_ID=222;
nuIndex binary_integer;
BEGIN

if (not EXP_ACTION_222_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_ACTION_MODULE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM GE_ACTION_MODULE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_ACTION_222_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_ACTION_222_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_ACTION_222_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_ACTION_222_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_ACTION_222_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_ACTION_222_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_ACTION_222_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_ACTION_222_.blProcessStatus) then
 return;
end if;

EXP_ACTION_222_.tb0_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=EXP_ACTION_222_.tb0_0(0),
MODULE_ID=1,
DESCRIPTION='Ejecuci¿n Acciones de todos los m¿dulos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_EXEACTION_'

 WHERE CONFIGURA_TYPE_ID = EXP_ACTION_222_.tb0_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (EXP_ACTION_222_.tb0_0(0),
1,
'Ejecuci¿n Acciones de todos los m¿dulos'
,
'PL'
,
'FD'
,
'DS'
,
'_EXEACTION_'
);
end if;

exception when others then
EXP_ACTION_222_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_222_.blProcessStatus) then
 return;
end if;

EXP_ACTION_222_.old_tb1_0(0):=121397106;
EXP_ACTION_222_.tb1_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
EXP_ACTION_222_.tb1_0(0):=EXP_ACTION_222_.tb1_0(0);
EXP_ACTION_222_.old_tb1_1(0):='GE_EXEACTION_CT1E121397106'
;
EXP_ACTION_222_.tb1_1(0):=TO_CHAR(EXP_ACTION_222_.tb1_0(0));
EXP_ACTION_222_.tb1_2(0):=EXP_ACTION_222_.tb0_0(0);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (EXP_ACTION_222_.tb1_0(0),
EXP_ACTION_222_.tb1_1(0),
EXP_ACTION_222_.tb1_2(0),
'nuPackageId = MO_BOINSTANCE_DB.FNUGETPACKIDINSTANCE();nuValidaActividad = FNUGETIDACTIVIDAD(nuPackageId);if (nuValidaActividad = 0,GENERATENACCOUNTSBYPACK(nuPackageId);CC_BOFINANCING.FINANCINGORDER(nuPackageId);,)'
,
'LBTEST'
,
to_date('30-07-2012 11:24:32','DD-MM-YYYY HH24:MI:SS'),
to_date('29-03-2023 09:35:55','DD-MM-YYYY HH24:MI:SS'),
to_date('29-03-2023 09:35:55','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Generar/Financiar Factura de la Solicitud'
,
'PP'
,
null);

exception when others then
EXP_ACTION_222_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_222_.blProcessStatus) then
 return;
end if;

EXP_ACTION_222_.tb2_0(0):=222;
EXP_ACTION_222_.tb2_2(0):=EXP_ACTION_222_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ACTION_MODULE fila (0)',1);
UPDATE GE_ACTION_MODULE SET ACTION_ID=EXP_ACTION_222_.tb2_0(0),
MODULE_ID=5,
CONFIG_EXPRESSION_ID=EXP_ACTION_222_.tb2_2(0),
DESCRIPTION='Generar/Financiar Factura de la Solicitud'
,
EXE_AT_STATUS_CHANGE='N'
,
EXE_TRANSITION_STATE='N'

 WHERE ACTION_ID = EXP_ACTION_222_.tb2_0(0);
if not (sql%found) then
INSERT INTO GE_ACTION_MODULE(ACTION_ID,MODULE_ID,CONFIG_EXPRESSION_ID,DESCRIPTION,EXE_AT_STATUS_CHANGE,EXE_TRANSITION_STATE) 
VALUES (EXP_ACTION_222_.tb2_0(0),
5,
EXP_ACTION_222_.tb2_2(0),
'Generar/Financiar Factura de la Solicitud'
,
'N'
,
'N'
);
end if;

exception when others then
EXP_ACTION_222_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_222_.blProcessStatus) then
 return;
end if;

EXP_ACTION_222_.tb3_0(0):=EXP_ACTION_222_.tb2_0(0);
EXP_ACTION_222_.tb3_1(0):=9;
ut_trace.trace('insertando tabla sin fallo: GE_VALID_ACTION_MODU fila (0)',1);
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (EXP_ACTION_222_.tb3_0(0),
EXP_ACTION_222_.tb3_1(0));

exception 
when dup_val_on_index then 
 return;
when others then
EXP_ACTION_222_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
DECLARE 
    nuBinaryIndex Binary_Integer;
BEGIN 
    nuBinaryIndex := EXP_ACTION_222_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = EXP_ACTION_222_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||EXP_ACTION_222_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||EXP_ACTION_222_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := EXP_ACTION_222_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       EXP_ACTION_222_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100588',1);
EXP_PROCESS_100588_.blProcessStatus := EXP_ACTION_222_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
COMMIT
/

DECLARE
PRAGMA AUTONOMOUS_TRANSACTION;
nuRowProcess number;
BEGIN 

if (not EXP_ACTION_222_.blProcessStatus) then
 return;
end if;
nuRowProcess:=EXP_ACTION_222_.tb1_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| EXP_ACTION_222_.tb1_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(EXP_ACTION_222_.tb1_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| EXP_ACTION_222_.tb1_0(nuRowProcess),1);
end;
nuRowProcess := EXP_ACTION_222_.tb1_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
EXP_ACTION_222_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

DECLARE
 nuIndex         binary_integer;
 blObjectDeleted boolean;

 FUNCTION fblIsObjectUseByRule
 (
  isbObjectName   IN gr_config_expression.object_name%type
 ) return BOOLEAN
 IS
  nuCounter    NUMBER := 0;
  blReturn     BOOLEAN := FALSE;
 BEGIN
  SELECT count('x') INTO nuCounter
  FROM gr_config_expression
  WHERE object_name = isbObjectName;
  IF (nuCounter > 0) THEN
    BEGIN
      DELETE FROM gr_config_expression
      WHERE object_name = isbObjectName;
      blReturn := FALSE;
    EXCEPTION
      when ex.RECORD_HAVE_CHILDREN then
         ut_trace.trace('Objeto ' || isbObjectName || ' usado en ' || nuCounter ||' reglas, no se borra',2);
         blReturn := TRUE;
    END;
  END IF;
  RETURN blReturn;
 END;

BEGIN
 ut_trace.trace('Inicia borrado de objetos de reglas',1);
 nuIndex := EXP_ACTION_222_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_ACTION_222_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_ACTION_222_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_ACTION_222_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_ACTION_222_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_ACTION_222_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_ACTION_222_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_ACTION_222_.tbObjectToDelete.next(nuIndex);
 END loop;
 ut_trace.trace('Finaliza borrado de objetos de reglas',1);
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
END;
/


begin
SA_BOCreatePackages.DropPackage('EXP_ACTION_222_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_ACTION_222_******************************'); end;
/


DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  SELECT  B.object_name
FROM    WF_UNIT A, GR_CONFIG_EXPRESSION B
WHERE   (A.PRE_EXPRESSION_ID = b.CONFIG_EXPRESSION_ID
OR   A.POS_EXPRESSION_ID = b.CONFIG_EXPRESSION_ID)
AND     A.UNIT_ID IN (
        SELECT UNIT_ID         FROM WF_UNIT 
        WHERE UNIT_TYPE_ID = 100588
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID IN 
           (SELECT UNIT_ID
           FROM WF_UNIT
           WHERE UNIT_TYPE_ID = 100588
       ))
;
BEGIN

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_PROCESS_100588_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
  nuIndex := nuIndex + 1;
 END LOOP;
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
END;
/

DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100588) AND NODE_TYPE_ID=0);
BEGIN 

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_PROCESS_100588_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100588) AND NODE_TYPE_ID=0);
BEGIN 

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_PROCESS_100588_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
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
FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100588) AND NODE_TYPE_ID=0;
nuIndex binary_integer;
BEGIN

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_PROCESS_100588_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_PROCESS_100588_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_PROCESS_100588_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_PROCESS_100588_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_PROCESS_100588_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_PROCESS_100588_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_PROCESS_100588_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_PROCESS_100588_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
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
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100588;
nuIndex binary_integer;
BEGIN

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_TYPE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_TYPE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100588_.tb0_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_CATEGORY fila (0)',1);
UPDATE WF_UNIT_CATEGORY SET CATEGORY_ID=EXP_PROCESS_100588_.tb0_0(0),
DISPLAY_NUMBER='Proceso B¿sico'

 WHERE CATEGORY_ID = EXP_PROCESS_100588_.tb0_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_CATEGORY(CATEGORY_ID,DISPLAY_NUMBER) 
VALUES (EXP_PROCESS_100588_.tb0_0(0),
'Proceso B¿sico'
);
end if;

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100588_.tb1_0(0):=9;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (0)',1);
UPDATE GE_MODULE SET MODULE_ID=EXP_PROCESS_100588_.tb1_0(0),
DESCRIPTION='WorkFlow'
,
MNEMONIC='WF'
,
LAST_MESSAGE=66,
PATH_MODULE='Workflow'
,
ICON_NAME='mod_admcnf'
,
LOCALIZATION='IN'

 WHERE MODULE_ID = EXP_PROCESS_100588_.tb1_0(0);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (EXP_PROCESS_100588_.tb1_0(0),
'WorkFlow'
,
'WF'
,
66,
'Workflow'
,
'mod_admcnf'
,
'IN'
);
end if;

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100588_.tb2_0(0):=100588;
EXP_PROCESS_100588_.tb2_1(0):=EXP_PROCESS_100588_.tb0_0(0);
EXP_PROCESS_100588_.tb2_2(0):=EXP_PROCESS_100588_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (0)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100588_.tb2_0(0),
CATEGORY_ID=EXP_PROCESS_100588_.tb2_1(0),
MODULE_ID=EXP_PROCESS_100588_.tb2_2(0),
ACTION_ID=null,
PARENT_ID=983,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_100588'
,
DESCRIPTION='Generaci¿n de Cobros'
,
DISPLAY='Generaci¿n de Cobros'
,
ICON=null,
IS_STAGE_PROCESS='N'
,
USABLE_IN_FLOW_STAGE='N'
,
ENTITY_ID=17,
MULTI_INSTANCE='R'
,
IS_COUNTABLE='N'
,
NOTIFICATION_ID=null,
VIEWABLE='N'
,
DEFAULT_PRIORITY_ID=null,
INITIAL_NOTIFY_TIME=null,
IS_ADMIN_PROCESS='N'
,
ASSIGN_NOTIFICATION_ID=null,
ASSIGNED_USER_ONLY=null
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100588_.tb2_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100588_.tb2_0(0),
EXP_PROCESS_100588_.tb2_1(0),
EXP_PROCESS_100588_.tb2_2(0),
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_100588'
,
'Generaci¿n de Cobros'
,
'Generaci¿n de Cobros'
,
null,
'N'
,
'N'
,
17,
'R'
,
'N'
,
null,
'N'
,
null,
null,
'N'
,
null,
null);
end if;

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100588_.tb3_0(0):=0;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (0)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100588_.tb3_0(0),
DESCRIPTION='Ra¿z'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100588_.tb3_0(0);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100588_.tb3_0(0),
'Ra¿z'
);
end if;

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100588_.tb4_0(0):=102782;
EXP_PROCESS_100588_.tb4_2(0):=EXP_PROCESS_100588_.tb2_0(0);
EXP_PROCESS_100588_.tb4_3(0):=EXP_PROCESS_100588_.tb3_0(0);
EXP_PROCESS_100588_.tb4_4(0):=EXP_PROCESS_100588_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (0)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100588_.tb4_0(0),
PROCESS_ID=null,
UNIT_TYPE_ID=EXP_PROCESS_100588_.tb4_2(0),
NODE_TYPE_ID=EXP_PROCESS_100588_.tb4_3(0),
MODULE_ID=EXP_PROCESS_100588_.tb4_4(0),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='20
20'
,
DESCRIPTION='T¿tulo'
,
ONLINE_EXEC_ID=null,
MULTI_INSTANCE='R'
,
SINCRONIC_TIMEOUT=null,
ASINCRONIC_TIMEOUT=null,
FUNCTION_TYPE=null,
IS_COUNTABLE='N'
,
MIN_GROUP_SIZE=null,
EXECUTION_ORDER='A'
,
ANNULATION_ORDER='N'
,
ENTITY_ID=null,
VIEWABLE='N'

 WHERE UNIT_ID = EXP_PROCESS_100588_.tb4_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100588_.tb4_0(0),
null,
EXP_PROCESS_100588_.tb4_2(0),
EXP_PROCESS_100588_.tb4_3(0),
EXP_PROCESS_100588_.tb4_4(0),
null,
null,
null,
null,
'20
20'
,
'T¿tulo'
,
null,
'R'
,
null,
null,
null,
'N'
,
null,
'A'
,
'N'
,
null,
'N'
);
end if;

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100588_.tb0_0(1):=2;
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_CATEGORY fila (1)',1);
UPDATE WF_UNIT_CATEGORY SET CATEGORY_ID=EXP_PROCESS_100588_.tb0_0(1),
DISPLAY_NUMBER='Actividad'

 WHERE CATEGORY_ID = EXP_PROCESS_100588_.tb0_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_CATEGORY(CATEGORY_ID,DISPLAY_NUMBER) 
VALUES (EXP_PROCESS_100588_.tb0_0(1),
'Actividad'
);
end if;

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100588_.tb2_0(1):=283;
EXP_PROCESS_100588_.tb2_1(1):=EXP_PROCESS_100588_.tb0_0(1);
EXP_PROCESS_100588_.tb2_2(1):=EXP_PROCESS_100588_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (1)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100588_.tb2_0(1),
CATEGORY_ID=EXP_PROCESS_100588_.tb2_1(1),
MODULE_ID=EXP_PROCESS_100588_.tb2_2(1),
ACTION_ID=null,
PARENT_ID=983,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_283'
,
DESCRIPTION='Inicio'
,
DISPLAY='Inicio'
,
ICON='GO.BMP'
,
IS_STAGE_PROCESS='N'
,
USABLE_IN_FLOW_STAGE='N'
,
ENTITY_ID=null,
MULTI_INSTANCE='R'
,
IS_COUNTABLE='N'
,
NOTIFICATION_ID=null,
VIEWABLE='N'
,
DEFAULT_PRIORITY_ID=null,
INITIAL_NOTIFY_TIME=null,
IS_ADMIN_PROCESS='N'
,
ASSIGN_NOTIFICATION_ID=null,
ASSIGNED_USER_ONLY=null
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100588_.tb2_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100588_.tb2_0(1),
EXP_PROCESS_100588_.tb2_1(1),
EXP_PROCESS_100588_.tb2_2(1),
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_283'
,
'Inicio'
,
'Inicio'
,
'GO.BMP'
,
'N'
,
'N'
,
null,
'R'
,
'N'
,
null,
'N'
,
null,
null,
'N'
,
null,
null);
end if;

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100588_.tb3_0(1):=1;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (1)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100588_.tb3_0(1),
DESCRIPTION='Arranque'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100588_.tb3_0(1);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100588_.tb3_0(1),
'Arranque'
);
end if;

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100588_.tb4_0(1):=102783;
EXP_PROCESS_100588_.tb4_1(1):=EXP_PROCESS_100588_.tb4_0(0);
EXP_PROCESS_100588_.tb4_2(1):=EXP_PROCESS_100588_.tb2_0(1);
EXP_PROCESS_100588_.tb4_3(1):=EXP_PROCESS_100588_.tb3_0(1);
EXP_PROCESS_100588_.tb4_4(1):=EXP_PROCESS_100588_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (1)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100588_.tb4_0(1),
PROCESS_ID=EXP_PROCESS_100588_.tb4_1(1),
UNIT_TYPE_ID=EXP_PROCESS_100588_.tb4_2(1),
NODE_TYPE_ID=EXP_PROCESS_100588_.tb4_3(1),
MODULE_ID=EXP_PROCESS_100588_.tb4_4(1),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='20
184'
,
DESCRIPTION='Inicio'
,
ONLINE_EXEC_ID=null,
MULTI_INSTANCE='R'
,
SINCRONIC_TIMEOUT=null,
ASINCRONIC_TIMEOUT=null,
FUNCTION_TYPE=null,
IS_COUNTABLE='N'
,
MIN_GROUP_SIZE=null,
EXECUTION_ORDER='A'
,
ANNULATION_ORDER='N'
,
ENTITY_ID=null,
VIEWABLE='N'

 WHERE UNIT_ID = EXP_PROCESS_100588_.tb4_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100588_.tb4_0(1),
EXP_PROCESS_100588_.tb4_1(1),
EXP_PROCESS_100588_.tb4_2(1),
EXP_PROCESS_100588_.tb4_3(1),
EXP_PROCESS_100588_.tb4_4(1),
null,
null,
null,
null,
'20
184'
,
'Inicio'
,
null,
'R'
,
null,
null,
null,
'N'
,
null,
'A'
,
'N'
,
null,
'N'
);
end if;

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100588_.tb1_0(1):=5;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (1)',1);
UPDATE GE_MODULE SET MODULE_ID=EXP_PROCESS_100588_.tb1_0(1),
DESCRIPTION='GESTI¿N DE MOTIVOS'
,
MNEMONIC='MO'
,
LAST_MESSAGE=136,
PATH_MODULE='Motives_Management'
,
ICON_NAME='mod_motivos'
,
LOCALIZATION='IN'

 WHERE MODULE_ID = EXP_PROCESS_100588_.tb1_0(1);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (EXP_PROCESS_100588_.tb1_0(1),
'GESTI¿N DE MOTIVOS'
,
'MO'
,
136,
'Motives_Management'
,
'mod_motivos'
,
'IN'
);
end if;

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100588_.tb2_0(2):=100367;
EXP_PROCESS_100588_.tb2_1(2):=EXP_PROCESS_100588_.tb0_0(1);
EXP_PROCESS_100588_.tb2_2(2):=EXP_PROCESS_100588_.tb1_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (2)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100588_.tb2_0(2),
CATEGORY_ID=EXP_PROCESS_100588_.tb2_1(2),
MODULE_ID=EXP_PROCESS_100588_.tb2_2(2),
ACTION_ID=null,
PARENT_ID=100302,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_100367'
,
DESCRIPTION='Cobro de Tr¿mite'
,
DISPLAY='Cobro de Tr¿mite'
,
ICON=null,
IS_STAGE_PROCESS='N'
,
USABLE_IN_FLOW_STAGE='N'
,
ENTITY_ID=null,
MULTI_INSTANCE='R'
,
IS_COUNTABLE='N'
,
NOTIFICATION_ID=9000,
VIEWABLE='N'
,
DEFAULT_PRIORITY_ID=null,
INITIAL_NOTIFY_TIME=null,
IS_ADMIN_PROCESS='N'
,
ASSIGN_NOTIFICATION_ID=null,
ASSIGNED_USER_ONLY=null
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100588_.tb2_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100588_.tb2_0(2),
EXP_PROCESS_100588_.tb2_1(2),
EXP_PROCESS_100588_.tb2_2(2),
null,
100302,
null,
null,
null,
null,
'UNIT_TYPE_100367'
,
'Cobro de Tr¿mite'
,
'Cobro de Tr¿mite'
,
null,
'N'
,
'N'
,
null,
'R'
,
'N'
,
9000,
'N'
,
null,
null,
'N'
,
null,
null);
end if;

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100588_.tb3_0(2):=2;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (2)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100588_.tb3_0(2),
DESCRIPTION='Normal'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100588_.tb3_0(2);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100588_.tb3_0(2),
'Normal'
);
end if;

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100588_.tb4_0(2):=102785;
EXP_PROCESS_100588_.tb4_1(2):=EXP_PROCESS_100588_.tb4_0(0);
EXP_PROCESS_100588_.tb4_2(2):=EXP_PROCESS_100588_.tb2_0(2);
EXP_PROCESS_100588_.tb4_3(2):=EXP_PROCESS_100588_.tb3_0(2);
EXP_PROCESS_100588_.tb4_4(2):=EXP_PROCESS_100588_.tb1_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (2)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100588_.tb4_0(2),
PROCESS_ID=EXP_PROCESS_100588_.tb4_1(2),
UNIT_TYPE_ID=EXP_PROCESS_100588_.tb4_2(2),
NODE_TYPE_ID=EXP_PROCESS_100588_.tb4_3(2),
MODULE_ID=EXP_PROCESS_100588_.tb4_4(2),
ACTION_ID=8133,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=9000,
GEOMETRY='199
174'
,
DESCRIPTION='Cobro de Tr¿mite'
,
ONLINE_EXEC_ID=null,
MULTI_INSTANCE='R'
,
SINCRONIC_TIMEOUT=null,
ASINCRONIC_TIMEOUT=null,
FUNCTION_TYPE=null,
IS_COUNTABLE='N'
,
MIN_GROUP_SIZE=null,
EXECUTION_ORDER='A'
,
ANNULATION_ORDER='N'
,
ENTITY_ID=null,
VIEWABLE='N'

 WHERE UNIT_ID = EXP_PROCESS_100588_.tb4_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100588_.tb4_0(2),
EXP_PROCESS_100588_.tb4_1(2),
EXP_PROCESS_100588_.tb4_2(2),
EXP_PROCESS_100588_.tb4_3(2),
EXP_PROCESS_100588_.tb4_4(2),
8133,
null,
null,
9000,
'199
174'
,
'Cobro de Tr¿mite'
,
null,
'R'
,
null,
null,
null,
'N'
,
null,
'A'
,
'N'
,
null,
'N'
);
end if;

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100588_.tb5_0(0):=100000858;
EXP_PROCESS_100588_.tb5_1(0):=EXP_PROCESS_100588_.tb4_0(1);
EXP_PROCESS_100588_.tb5_2(0):=EXP_PROCESS_100588_.tb4_0(2);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (0)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100588_.tb5_0(0),
ORIGIN_ID=EXP_PROCESS_100588_.tb5_1(0),
TARGET_ID=EXP_PROCESS_100588_.tb5_2(0),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION=null,
EXPRESSION_TYPE=0,
DESCRIPTION=null,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100588_.tb5_0(0);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100588_.tb5_0(0),
EXP_PROCESS_100588_.tb5_1(0),
EXP_PROCESS_100588_.tb5_2(0),
null,
0,
null,
0,
null,
1);
end if;

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100588_.tb6_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTE_CLASS fila (0)',1);
UPDATE GE_ATTRIBUTE_CLASS SET ATTRIBUTE_CLASS_ID=EXP_PROCESS_100588_.tb6_0(0),
NAME='De Entitdad'
,
DESCRIPTION='Valores que ser¿n tra¿dos de la tabla base usando old record'

 WHERE ATTRIBUTE_CLASS_ID = EXP_PROCESS_100588_.tb6_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTE_CLASS(ATTRIBUTE_CLASS_ID,NAME,DESCRIPTION) 
VALUES (EXP_PROCESS_100588_.tb6_0(0),
'De Entitdad'
,
'Valores que ser¿n tra¿dos de la tabla base usando old record'
);
end if;

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100588_.tb7_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES_TYPE fila (0)',1);
UPDATE GE_ATTRIBUTES_TYPE SET ATTRIBUTE_TYPE_ID=EXP_PROCESS_100588_.tb7_0(0),
DESCRIPTION='NUMBER'
,
INTERNAL_TYPE=2,
INTERNAL_JAVA_TYPE=2
 WHERE ATTRIBUTE_TYPE_ID = EXP_PROCESS_100588_.tb7_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES_TYPE(ATTRIBUTE_TYPE_ID,DESCRIPTION,INTERNAL_TYPE,INTERNAL_JAVA_TYPE) 
VALUES (EXP_PROCESS_100588_.tb7_0(0),
'NUMBER'
,
2,
2);
end if;

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100588_.tb8_0(0):=400;
EXP_PROCESS_100588_.tb8_1(0):=EXP_PROCESS_100588_.tb6_0(0);
EXP_PROCESS_100588_.tb8_2(0):=EXP_PROCESS_100588_.tb7_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (0)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=EXP_PROCESS_100588_.tb8_0(0),
ATTRIBUTE_CLASS_ID=EXP_PROCESS_100588_.tb8_1(0),
ATTRIBUTE_TYPE_ID=EXP_PROCESS_100588_.tb8_2(0),
VALID_EXPRESSION=null,
FATHER_ID=null,
MODULE_ID=9,
NAME_ATTRIBUTE='CAUSAL'
,
LENGTH=4,
PRECISION=null,
SCALE=null,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE='T'
,
COMMENT_='Causal'
,
DISPLAY_NAME='Causal'

 WHERE ATTRIBUTE_ID = EXP_PROCESS_100588_.tb8_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,ATTRIBUTE_CLASS_ID,ATTRIBUTE_TYPE_ID,VALID_EXPRESSION,FATHER_ID,MODULE_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (EXP_PROCESS_100588_.tb8_0(0),
EXP_PROCESS_100588_.tb8_1(0),
EXP_PROCESS_100588_.tb8_2(0),
null,
null,
9,
'CAUSAL'
,
4,
null,
null,
null,
'T'
,
'Causal'
,
'Causal'
);
end if;

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100588_.tb9_0(0):=100000846;
EXP_PROCESS_100588_.tb9_1(0):=EXP_PROCESS_100588_.tb4_0(1);
EXP_PROCESS_100588_.tb9_2(0):=EXP_PROCESS_100588_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (0)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100588_.tb9_0(0),
UNIT_ID=EXP_PROCESS_100588_.tb9_1(0),
ATTRIBUTE_ID=EXP_PROCESS_100588_.tb9_2(0),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100588_.tb9_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100588_.tb9_0(0),
EXP_PROCESS_100588_.tb9_1(0),
EXP_PROCESS_100588_.tb9_2(0),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100588_.tb2_0(3):=100427;
EXP_PROCESS_100588_.tb2_1(3):=EXP_PROCESS_100588_.tb0_0(0);
EXP_PROCESS_100588_.tb2_2(3):=EXP_PROCESS_100588_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (3)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100588_.tb2_0(3),
CATEGORY_ID=EXP_PROCESS_100588_.tb2_1(3),
MODULE_ID=EXP_PROCESS_100588_.tb2_2(3),
ACTION_ID=null,
PARENT_ID=983,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_100427'
,
DESCRIPTION='Proceso de Distribuci¿n de Cargos'
,
DISPLAY='Proceso de Distribuci¿n de Cargos'
,
ICON=null,
IS_STAGE_PROCESS='N'
,
USABLE_IN_FLOW_STAGE='N'
,
ENTITY_ID=null,
MULTI_INSTANCE='R'
,
IS_COUNTABLE='N'
,
NOTIFICATION_ID=null,
VIEWABLE='N'
,
DEFAULT_PRIORITY_ID=null,
INITIAL_NOTIFY_TIME=null,
IS_ADMIN_PROCESS='N'
,
ASSIGN_NOTIFICATION_ID=null,
ASSIGNED_USER_ONLY=null
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100588_.tb2_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100588_.tb2_0(3),
EXP_PROCESS_100588_.tb2_1(3),
EXP_PROCESS_100588_.tb2_2(3),
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_100427'
,
'Proceso de Distribuci¿n de Cargos'
,
'Proceso de Distribuci¿n de Cargos'
,
null,
'N'
,
'N'
,
null,
'R'
,
'N'
,
null,
'N'
,
null,
null,
'N'
,
null,
null);
end if;

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100588_.tb4_0(3):=102787;
EXP_PROCESS_100588_.tb4_1(3):=EXP_PROCESS_100588_.tb4_0(0);
EXP_PROCESS_100588_.tb4_2(3):=EXP_PROCESS_100588_.tb2_0(3);
EXP_PROCESS_100588_.tb4_3(3):=EXP_PROCESS_100588_.tb3_0(2);
EXP_PROCESS_100588_.tb4_4(3):=EXP_PROCESS_100588_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (3)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100588_.tb4_0(3),
PROCESS_ID=EXP_PROCESS_100588_.tb4_1(3),
UNIT_TYPE_ID=EXP_PROCESS_100588_.tb4_2(3),
NODE_TYPE_ID=EXP_PROCESS_100588_.tb4_3(3),
MODULE_ID=EXP_PROCESS_100588_.tb4_4(3),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='344
166'
,
DESCRIPTION='Proceso de Distribuci¿n de Cargos'
,
ONLINE_EXEC_ID=null,
MULTI_INSTANCE='R'
,
SINCRONIC_TIMEOUT=null,
ASINCRONIC_TIMEOUT=null,
FUNCTION_TYPE=null,
IS_COUNTABLE='N'
,
MIN_GROUP_SIZE=null,
EXECUTION_ORDER='A'
,
ANNULATION_ORDER='N'
,
ENTITY_ID=8,
VIEWABLE='N'

 WHERE UNIT_ID = EXP_PROCESS_100588_.tb4_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100588_.tb4_0(3),
EXP_PROCESS_100588_.tb4_1(3),
EXP_PROCESS_100588_.tb4_2(3),
EXP_PROCESS_100588_.tb4_3(3),
EXP_PROCESS_100588_.tb4_4(3),
null,
null,
null,
null,
'344
166'
,
'Proceso de Distribuci¿n de Cargos'
,
null,
'R'
,
null,
null,
null,
'N'
,
null,
'A'
,
'N'
,
8,
'N'
);
end if;

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100588_.tb5_0(1):=100000859;
EXP_PROCESS_100588_.tb5_1(1):=EXP_PROCESS_100588_.tb4_0(2);
EXP_PROCESS_100588_.tb5_2(1):=EXP_PROCESS_100588_.tb4_0(3);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (1)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100588_.tb5_0(1),
ORIGIN_ID=EXP_PROCESS_100588_.tb5_1(1),
TARGET_ID=EXP_PROCESS_100588_.tb5_2(1),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION=null,
EXPRESSION_TYPE=0,
DESCRIPTION=null,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100588_.tb5_0(1);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100588_.tb5_0(1),
EXP_PROCESS_100588_.tb5_1(1),
EXP_PROCESS_100588_.tb5_2(1),
null,
0,
null,
0,
null,
1);
end if;

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100588_.tb9_0(1):=100000849;
EXP_PROCESS_100588_.tb9_1(1):=EXP_PROCESS_100588_.tb4_0(2);
EXP_PROCESS_100588_.tb9_2(1):=EXP_PROCESS_100588_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (1)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100588_.tb9_0(1),
UNIT_ID=EXP_PROCESS_100588_.tb9_1(1),
ATTRIBUTE_ID=EXP_PROCESS_100588_.tb9_2(1),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=1,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100588_.tb9_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100588_.tb9_0(1),
EXP_PROCESS_100588_.tb9_1(1),
EXP_PROCESS_100588_.tb9_2(1),
null,
null,
'N'
,
1,
'N'
);
end if;

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100588_.tb2_0(4):=252;
EXP_PROCESS_100588_.tb2_1(4):=EXP_PROCESS_100588_.tb0_0(1);
EXP_PROCESS_100588_.tb2_2(4):=EXP_PROCESS_100588_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (4)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100588_.tb2_0(4),
CATEGORY_ID=EXP_PROCESS_100588_.tb2_1(4),
MODULE_ID=EXP_PROCESS_100588_.tb2_2(4),
ACTION_ID=null,
PARENT_ID=983,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_252'
,
DESCRIPTION='Fin'
,
DISPLAY='Fin'
,
ICON='STOP.BMP'
,
IS_STAGE_PROCESS='N'
,
USABLE_IN_FLOW_STAGE='N'
,
ENTITY_ID=null,
MULTI_INSTANCE='N'
,
IS_COUNTABLE='N'
,
NOTIFICATION_ID=null,
VIEWABLE='N'
,
DEFAULT_PRIORITY_ID=null,
INITIAL_NOTIFY_TIME=null,
IS_ADMIN_PROCESS='N'
,
ASSIGN_NOTIFICATION_ID=null,
ASSIGNED_USER_ONLY=null
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100588_.tb2_0(4);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100588_.tb2_0(4),
EXP_PROCESS_100588_.tb2_1(4),
EXP_PROCESS_100588_.tb2_2(4),
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_252'
,
'Fin'
,
'Fin'
,
'STOP.BMP'
,
'N'
,
'N'
,
null,
'N'
,
'N'
,
null,
'N'
,
null,
null,
'N'
,
null,
null);
end if;

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100588_.tb3_0(3):=3;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (3)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100588_.tb3_0(3),
DESCRIPTION='Final'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100588_.tb3_0(3);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100588_.tb3_0(3),
'Final'
);
end if;

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100588_.tb4_0(4):=102784;
EXP_PROCESS_100588_.tb4_1(4):=EXP_PROCESS_100588_.tb4_0(0);
EXP_PROCESS_100588_.tb4_2(4):=EXP_PROCESS_100588_.tb2_0(4);
EXP_PROCESS_100588_.tb4_3(4):=EXP_PROCESS_100588_.tb3_0(3);
EXP_PROCESS_100588_.tb4_4(4):=EXP_PROCESS_100588_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (4)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100588_.tb4_0(4),
PROCESS_ID=EXP_PROCESS_100588_.tb4_1(4),
UNIT_TYPE_ID=EXP_PROCESS_100588_.tb4_2(4),
NODE_TYPE_ID=EXP_PROCESS_100588_.tb4_3(4),
MODULE_ID=EXP_PROCESS_100588_.tb4_4(4),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='620
181'
,
DESCRIPTION='Fin'
,
ONLINE_EXEC_ID=null,
MULTI_INSTANCE='R'
,
SINCRONIC_TIMEOUT=null,
ASINCRONIC_TIMEOUT=null,
FUNCTION_TYPE=null,
IS_COUNTABLE='N'
,
MIN_GROUP_SIZE=null,
EXECUTION_ORDER='A'
,
ANNULATION_ORDER='N'
,
ENTITY_ID=null,
VIEWABLE='N'

 WHERE UNIT_ID = EXP_PROCESS_100588_.tb4_0(4);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100588_.tb4_0(4),
EXP_PROCESS_100588_.tb4_1(4),
EXP_PROCESS_100588_.tb4_2(4),
EXP_PROCESS_100588_.tb4_3(4),
EXP_PROCESS_100588_.tb4_4(4),
null,
null,
null,
null,
'620
181'
,
'Fin'
,
null,
'R'
,
null,
null,
null,
'N'
,
null,
'A'
,
'N'
,
null,
'N'
);
end if;

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100588_.tb5_0(2):=100000860;
EXP_PROCESS_100588_.tb5_1(2):=EXP_PROCESS_100588_.tb4_0(3);
EXP_PROCESS_100588_.tb5_2(2):=EXP_PROCESS_100588_.tb4_0(4);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (2)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100588_.tb5_0(2),
ORIGIN_ID=EXP_PROCESS_100588_.tb5_1(2),
TARGET_ID=EXP_PROCESS_100588_.tb5_2(2),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION='FLAG_VALIDATE == NO'
,
EXPRESSION_TYPE=0,
DESCRIPTION='Solicitud No Tiene Condiciones de Financiaci¿n'
,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100588_.tb5_0(2);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100588_.tb5_0(2),
EXP_PROCESS_100588_.tb5_1(2),
EXP_PROCESS_100588_.tb5_2(2),
null,
0,
'FLAG_VALIDATE == NO'
,
0,
'Solicitud No Tiene Condiciones de Financiaci¿n'
,
1);
end if;

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100588_.tb2_0(5):=254;
EXP_PROCESS_100588_.tb2_1(5):=EXP_PROCESS_100588_.tb0_0(1);
EXP_PROCESS_100588_.tb2_2(5):=EXP_PROCESS_100588_.tb1_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (5)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100588_.tb2_0(5),
CATEGORY_ID=EXP_PROCESS_100588_.tb2_1(5),
MODULE_ID=EXP_PROCESS_100588_.tb2_2(5),
ACTION_ID=null,
PARENT_ID=983,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_254'
,
DESCRIPTION='Generar/Financiar Factura'
,
DISPLAY='Generar/Financiar Factura'
,
ICON=null,
IS_STAGE_PROCESS='N'
,
USABLE_IN_FLOW_STAGE='N'
,
ENTITY_ID=null,
MULTI_INSTANCE='R'
,
IS_COUNTABLE='N'
,
NOTIFICATION_ID=null,
VIEWABLE='N'
,
DEFAULT_PRIORITY_ID=null,
INITIAL_NOTIFY_TIME=null,
IS_ADMIN_PROCESS='N'
,
ASSIGN_NOTIFICATION_ID=null,
ASSIGNED_USER_ONLY=null
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100588_.tb2_0(5);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100588_.tb2_0(5),
EXP_PROCESS_100588_.tb2_1(5),
EXP_PROCESS_100588_.tb2_2(5),
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_254'
,
'Generar/Financiar Factura'
,
'Generar/Financiar Factura'
,
null,
'N'
,
'N'
,
null,
'R'
,
'N'
,
null,
'N'
,
null,
null,
'N'
,
null,
null);
end if;

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100588_.tb4_0(5):=102786;
EXP_PROCESS_100588_.tb4_1(5):=EXP_PROCESS_100588_.tb4_0(0);
EXP_PROCESS_100588_.tb4_2(5):=EXP_PROCESS_100588_.tb2_0(5);
EXP_PROCESS_100588_.tb4_3(5):=EXP_PROCESS_100588_.tb3_0(2);
EXP_PROCESS_100588_.tb4_4(5):=EXP_PROCESS_100588_.tb1_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (5)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100588_.tb4_0(5),
PROCESS_ID=EXP_PROCESS_100588_.tb4_1(5),
UNIT_TYPE_ID=EXP_PROCESS_100588_.tb4_2(5),
NODE_TYPE_ID=EXP_PROCESS_100588_.tb4_3(5),
MODULE_ID=EXP_PROCESS_100588_.tb4_4(5),
ACTION_ID=222,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='433
326'
,
DESCRIPTION='Generar/Financiar Factura'
,
ONLINE_EXEC_ID=null,
MULTI_INSTANCE='R'
,
SINCRONIC_TIMEOUT=null,
ASINCRONIC_TIMEOUT=null,
FUNCTION_TYPE=null,
IS_COUNTABLE='N'
,
MIN_GROUP_SIZE=null,
EXECUTION_ORDER='A'
,
ANNULATION_ORDER='N'
,
ENTITY_ID=17,
VIEWABLE='N'

 WHERE UNIT_ID = EXP_PROCESS_100588_.tb4_0(5);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100588_.tb4_0(5),
EXP_PROCESS_100588_.tb4_1(5),
EXP_PROCESS_100588_.tb4_2(5),
EXP_PROCESS_100588_.tb4_3(5),
EXP_PROCESS_100588_.tb4_4(5),
222,
null,
null,
null,
'433
326'
,
'Generar/Financiar Factura'
,
null,
'R'
,
null,
null,
null,
'N'
,
null,
'A'
,
'N'
,
17,
'N'
);
end if;

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100588_.tb5_0(3):=100000862;
EXP_PROCESS_100588_.tb5_1(3):=EXP_PROCESS_100588_.tb4_0(3);
EXP_PROCESS_100588_.tb5_2(3):=EXP_PROCESS_100588_.tb4_0(5);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (3)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100588_.tb5_0(3),
ORIGIN_ID=EXP_PROCESS_100588_.tb5_1(3),
TARGET_ID=EXP_PROCESS_100588_.tb5_2(3),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION='FLAG_VALIDATE == SI'
,
EXPRESSION_TYPE=0,
DESCRIPTION='Solicitud Si Tiene Condiciones'
,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100588_.tb5_0(3);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100588_.tb5_0(3),
EXP_PROCESS_100588_.tb5_1(3),
EXP_PROCESS_100588_.tb5_2(3),
null,
0,
'FLAG_VALIDATE == SI'
,
0,
'Solicitud Si Tiene Condiciones'
,
1);
end if;

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100588_.tb9_0(2):=100000851;
EXP_PROCESS_100588_.tb9_1(2):=EXP_PROCESS_100588_.tb4_0(3);
EXP_PROCESS_100588_.tb9_2(2):=EXP_PROCESS_100588_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (2)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100588_.tb9_0(2),
UNIT_ID=EXP_PROCESS_100588_.tb9_1(2),
ATTRIBUTE_ID=EXP_PROCESS_100588_.tb9_2(2),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=1,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100588_.tb9_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100588_.tb9_0(2),
EXP_PROCESS_100588_.tb9_1(2),
EXP_PROCESS_100588_.tb9_2(2),
null,
null,
'N'
,
1,
'N'
);
end if;

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100588_.tb6_0(1):=8;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTE_CLASS fila (1)',1);
UPDATE GE_ATTRIBUTE_CLASS SET ATTRIBUTE_CLASS_ID=EXP_PROCESS_100588_.tb6_0(1),
NAME='Por Defecto General'
,
DESCRIPTION='Valores que ser¿n utilizados para clasificaci¿n gen¿rica'

 WHERE ATTRIBUTE_CLASS_ID = EXP_PROCESS_100588_.tb6_0(1);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTE_CLASS(ATTRIBUTE_CLASS_ID,NAME,DESCRIPTION) 
VALUES (EXP_PROCESS_100588_.tb6_0(1),
'Por Defecto General'
,
'Valores que ser¿n utilizados para clasificaci¿n gen¿rica'
);
end if;

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100588_.tb8_0(1):=442;
EXP_PROCESS_100588_.tb8_1(1):=EXP_PROCESS_100588_.tb6_0(1);
EXP_PROCESS_100588_.tb8_2(1):=EXP_PROCESS_100588_.tb7_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (1)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=EXP_PROCESS_100588_.tb8_0(1),
ATTRIBUTE_CLASS_ID=EXP_PROCESS_100588_.tb8_1(1),
ATTRIBUTE_TYPE_ID=EXP_PROCESS_100588_.tb8_2(1),
VALID_EXPRESSION=null,
FATHER_ID=null,
MODULE_ID=9,
NAME_ATTRIBUTE='FLAG_VALIDATE'
,
LENGTH=null,
PRECISION=null,
SCALE=null,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE=null,
COMMENT_='Bandera de validaci¿n'
,
DISPLAY_NAME='Bandera de validaci¿n para la ejecuci¿n de transicciones'

 WHERE ATTRIBUTE_ID = EXP_PROCESS_100588_.tb8_0(1);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,ATTRIBUTE_CLASS_ID,ATTRIBUTE_TYPE_ID,VALID_EXPRESSION,FATHER_ID,MODULE_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (EXP_PROCESS_100588_.tb8_0(1),
EXP_PROCESS_100588_.tb8_1(1),
EXP_PROCESS_100588_.tb8_2(1),
null,
null,
9,
'FLAG_VALIDATE'
,
null,
null,
null,
null,
null,
'Bandera de validaci¿n'
,
'Bandera de validaci¿n para la ejecuci¿n de transicciones'
);
end if;

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100588_.old_tb10_0(0):=120195452;
EXP_PROCESS_100588_.tb10_0(0):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
EXP_PROCESS_100588_.tb10_0(0):=EXP_PROCESS_100588_.tb10_0(0);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (0)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (EXP_PROCESS_100588_.tb10_0(0),
5,
'Valida si la solicitud tiene condiciones de financiaci¿n asociadas'
,
'SELECT CC_BOFinancing.fnuValPkgFinanCond(damo_motive.fnugetpackage_id(:INST.EXTERNAL_ID:)) FLAG_VALIDATE FROM DUAL'
,
'Valida si la solicitud tiene condiciones de financiaci¿n asociadas'
);

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100588_.tb9_0(3):=100000852;
EXP_PROCESS_100588_.tb9_1(3):=EXP_PROCESS_100588_.tb4_0(3);
EXP_PROCESS_100588_.tb9_2(3):=EXP_PROCESS_100588_.tb8_0(1);
EXP_PROCESS_100588_.tb9_3(3):=EXP_PROCESS_100588_.tb10_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (3)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100588_.tb9_0(3),
UNIT_ID=EXP_PROCESS_100588_.tb9_1(3),
ATTRIBUTE_ID=EXP_PROCESS_100588_.tb9_2(3),
STATEMENT_ID=EXP_PROCESS_100588_.tb9_3(3),
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='Y'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100588_.tb9_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100588_.tb9_0(3),
EXP_PROCESS_100588_.tb9_1(3),
EXP_PROCESS_100588_.tb9_2(3),
EXP_PROCESS_100588_.tb9_3(3),
null,
'N'
,
2,
'Y'
);
end if;

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100588_.tb8_0(2):=401;
EXP_PROCESS_100588_.tb8_1(2):=EXP_PROCESS_100588_.tb6_0(1);
EXP_PROCESS_100588_.tb8_2(2):=EXP_PROCESS_100588_.tb7_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (2)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=EXP_PROCESS_100588_.tb8_0(2),
ATTRIBUTE_CLASS_ID=EXP_PROCESS_100588_.tb8_1(2),
ATTRIBUTE_TYPE_ID=EXP_PROCESS_100588_.tb8_2(2),
VALID_EXPRESSION=null,
FATHER_ID=null,
MODULE_ID=9,
NAME_ATTRIBUTE='$EXTERNAL_ID'
,
LENGTH=3,
PRECISION=null,
SCALE=null,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE='T'
,
COMMENT_='Identificador del Componente'
,
DISPLAY_NAME='Identificador del Componente'

 WHERE ATTRIBUTE_ID = EXP_PROCESS_100588_.tb8_0(2);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,ATTRIBUTE_CLASS_ID,ATTRIBUTE_TYPE_ID,VALID_EXPRESSION,FATHER_ID,MODULE_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (EXP_PROCESS_100588_.tb8_0(2),
EXP_PROCESS_100588_.tb8_1(2),
EXP_PROCESS_100588_.tb8_2(2),
null,
null,
9,
'$EXTERNAL_ID'
,
3,
null,
null,
null,
'T'
,
'Identificador del Componente'
,
'Identificador del Componente'
);
end if;

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100588_.old_tb10_0(1):=120195453;
EXP_PROCESS_100588_.tb10_0(1):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
EXP_PROCESS_100588_.tb10_0(1):=EXP_PROCESS_100588_.tb10_0(1);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (1)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (EXP_PROCESS_100588_.tb10_0(1),
9,
'Obtiene el primer motivo del paquete'
,
'SELECT motive_id EXTERNAL_ID
FROM (
    SELECT motive_id
    FROM mo_motive
    WHERE PACKAGE_id = WF_BOCNF_GeneralExpressions.fnuGetPlanPackageId(:INST.PLAN_ID:,:INST.ROOT_EXTERNAL_ID:)
    ORDER BY motiv_recording_date asc)
where rownum = 1'
,
'Obtiene el primer motivo del paquete'
);

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100588_.tb9_0(4):=100000853;
EXP_PROCESS_100588_.tb9_1(4):=EXP_PROCESS_100588_.tb4_0(3);
EXP_PROCESS_100588_.tb9_2(4):=EXP_PROCESS_100588_.tb8_0(2);
EXP_PROCESS_100588_.tb9_3(4):=EXP_PROCESS_100588_.tb10_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (4)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100588_.tb9_0(4),
UNIT_ID=EXP_PROCESS_100588_.tb9_1(4),
ATTRIBUTE_ID=EXP_PROCESS_100588_.tb9_2(4),
STATEMENT_ID=EXP_PROCESS_100588_.tb9_3(4),
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=1,
MANDATORY='Y'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100588_.tb9_0(4);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100588_.tb9_0(4),
EXP_PROCESS_100588_.tb9_1(4),
EXP_PROCESS_100588_.tb9_2(4),
EXP_PROCESS_100588_.tb9_3(4),
null,
'N'
,
1,
'Y'
);
end if;

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100588_.tb5_0(4):=100000861;
EXP_PROCESS_100588_.tb5_1(4):=EXP_PROCESS_100588_.tb4_0(5);
EXP_PROCESS_100588_.tb5_2(4):=EXP_PROCESS_100588_.tb4_0(4);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (4)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100588_.tb5_0(4),
ORIGIN_ID=EXP_PROCESS_100588_.tb5_1(4),
TARGET_ID=EXP_PROCESS_100588_.tb5_2(4),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION=null,
EXPRESSION_TYPE=0,
DESCRIPTION=null,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100588_.tb5_0(4);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100588_.tb5_0(4),
EXP_PROCESS_100588_.tb5_1(4),
EXP_PROCESS_100588_.tb5_2(4),
null,
0,
null,
0,
null,
1);
end if;

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100588_.tb9_0(5):=100000847;
EXP_PROCESS_100588_.tb9_1(5):=EXP_PROCESS_100588_.tb4_0(4);
EXP_PROCESS_100588_.tb9_2(5):=EXP_PROCESS_100588_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (5)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100588_.tb9_0(5),
UNIT_ID=EXP_PROCESS_100588_.tb9_1(5),
ATTRIBUTE_ID=EXP_PROCESS_100588_.tb9_2(5),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100588_.tb9_0(5);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100588_.tb9_0(5),
EXP_PROCESS_100588_.tb9_1(5),
EXP_PROCESS_100588_.tb9_2(5),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100588_.tb9_0(6):=100000848;
EXP_PROCESS_100588_.tb9_1(6):=EXP_PROCESS_100588_.tb4_0(4);
EXP_PROCESS_100588_.tb9_2(6):=EXP_PROCESS_100588_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (6)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100588_.tb9_0(6),
UNIT_ID=EXP_PROCESS_100588_.tb9_1(6),
ATTRIBUTE_ID=EXP_PROCESS_100588_.tb9_2(6),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100588_.tb9_0(6);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100588_.tb9_0(6),
EXP_PROCESS_100588_.tb9_1(6),
EXP_PROCESS_100588_.tb9_2(6),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100588_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100588_.tb9_0(7):=100000850;
EXP_PROCESS_100588_.tb9_1(7):=EXP_PROCESS_100588_.tb4_0(5);
EXP_PROCESS_100588_.tb9_2(7):=EXP_PROCESS_100588_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (7)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100588_.tb9_0(7),
UNIT_ID=EXP_PROCESS_100588_.tb9_1(7),
ATTRIBUTE_ID=EXP_PROCESS_100588_.tb9_2(7),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100588_.tb9_0(7);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100588_.tb9_0(7),
EXP_PROCESS_100588_.tb9_1(7),
EXP_PROCESS_100588_.tb9_2(7),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_100588_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_UNITTYPE_100367_',
'CREATE OR REPLACE PACKAGE EXP_UNITTYPE_100367_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyWF_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPERowId tyWF_UNIT_TYPERowId;type tyWF_CAUSAL_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_CAUSAL_UNIT_TYPERowId tyWF_CAUSAL_UNIT_TYPERowId;type tyGR_CONFIGURA_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIGURA_TYPERowId tyGR_CONFIGURA_TYPERowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type tyGE_ATTRIBUTE_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTE_CLASSRowId tyGE_ATTRIBUTE_CLASSRowId;type tyGE_ATTRIBUTES_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTES_TYPERowId tyGE_ATTRIBUTES_TYPERowId;type tyGE_ATTRIBUTESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTESRowId tyGE_ATTRIBUTESRowId;type tyGE_STATEMENTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_STATEMENTRowId tyGE_STATEMENTRowId;type tyWF_UNIT_TYPE_ATTRIBRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPE_ATTRIBRowId tyWF_UNIT_TYPE_ATTRIBRowId;type tyMO_TIME_UNI_TYP_PRIORowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbMO_TIME_UNI_TYP_PRIORowId tyMO_TIME_UNI_TYP_PRIORowId;type tyOR_ACT_BY_TASK_MODRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbOR_ACT_BY_TASK_MODRowId tyOR_ACT_BY_TASK_MODRowId;type ty0_0 is table of WF_UNIT_TYPE.UNIT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_5 is table of WF_UNIT_TYPE.INIT_AREA_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_5 ty0_5; ' || chr(10) ||
'tb0_5 ty0_5; ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_UNITTYPE_100367_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_UNITTYPE_100367_******************************'); END;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_UNITTYPE_100367',1);
EXP_UNITTYPE_100367_.blProcessStatus := EXP_PROCESS_100588_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  SELECT  B.object_name
FROM    OR_ACT_BY_TASK_MOD A, GR_CONFIG_EXPRESSION B 
WHERE   A.CONFIG_EXPRESSION_ID = B.CONFIG_EXPRESSION_ID
AND     A.TASK_CODE = 100367
 
;
BEGIN

if (not EXP_UNITTYPE_100367_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_UNITTYPE_100367_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
  nuIndex := nuIndex + 1;
 END LOOP;
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
END;
/

declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_TYPE_ATTRIB WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100367);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100367_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_TYPE_ATTRIB',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_TYPE_ATTRIB WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100367_.blProcessStatus := false;
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
FROM WF_CAUSAL_UNIT_TYPE WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100367);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100367_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_CAUSAL_UNIT_TYPE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_CAUSAL_UNIT_TYPE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100367_.blProcessStatus := false;
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
FROM MO_TIME_UNI_TYP_PRIO WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100367);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100367_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla MO_TIME_UNI_TYP_PRIO',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM MO_TIME_UNI_TYP_PRIO WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100367_.blProcessStatus := false;
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
FROM OR_ACT_BY_TASK_MOD WHERE (TASK_CODE) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100367);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100367_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla OR_ACT_BY_TASK_MOD',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM OR_ACT_BY_TASK_MOD WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100367_.blProcessStatus := false;
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
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100367;
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100367_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_TYPE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_TYPE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100367_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_UNITTYPE_100367_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100367_.tb0_0(0):=100367;
ut_trace.trace('insertando tabla sin fallo: WF_UNIT_TYPE fila (0)',1);
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_UNITTYPE_100367_.tb0_0(0),
2,
5,
null,
100302,
null,
null,
null,
null,
'UNIT_TYPE_100367'
,
'Cobro de Tr¿mite'
,
'Cobro de Tr¿mite'
,
null,
'N'
,
'N'
,
null,
'R'
,
'N'
,
9000,
'N'
,
null,
null,
'N'
,
null,
null);

exception 
when dup_val_on_index then 
 return;
when others then
EXP_UNITTYPE_100367_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100588',1);
EXP_PROCESS_100588_.blProcessStatus := EXP_UNITTYPE_100367_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/

DECLARE
 nuIndex         binary_integer;
 blObjectDeleted boolean;

 FUNCTION fblIsObjectUseByRule
 (
  isbObjectName   IN gr_config_expression.object_name%type
 ) return BOOLEAN
 IS
  nuCounter    NUMBER := 0;
  blReturn     BOOLEAN := FALSE;
 BEGIN
  SELECT count('x') INTO nuCounter
  FROM gr_config_expression
  WHERE object_name = isbObjectName;
  IF (nuCounter > 0) THEN
    BEGIN
      DELETE FROM gr_config_expression
      WHERE object_name = isbObjectName;
      blReturn := FALSE;
    EXCEPTION
      when ex.RECORD_HAVE_CHILDREN then
         ut_trace.trace('Objeto ' || isbObjectName || ' usado en ' || nuCounter ||' reglas, no se borra',2);
         blReturn := TRUE;
    END;
  END IF;
  RETURN blReturn;
 END;

BEGIN
 ut_trace.trace('Inicia borrado de objetos de reglas',1);
 nuIndex := EXP_UNITTYPE_100367_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_UNITTYPE_100367_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_UNITTYPE_100367_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_UNITTYPE_100367_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_UNITTYPE_100367_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_UNITTYPE_100367_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_UNITTYPE_100367_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_UNITTYPE_100367_.tbObjectToDelete.next(nuIndex);
 END loop;
 ut_trace.trace('Finaliza borrado de objetos de reglas',1);
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('EXP_UNITTYPE_100367_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_UNITTYPE_100367_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_UNITTYPE_254_',
'CREATE OR REPLACE PACKAGE EXP_UNITTYPE_254_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyWF_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPERowId tyWF_UNIT_TYPERowId;type tyWF_CAUSAL_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_CAUSAL_UNIT_TYPERowId tyWF_CAUSAL_UNIT_TYPERowId;type tyGR_CONFIGURA_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIGURA_TYPERowId tyGR_CONFIGURA_TYPERowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type tyGE_ATTRIBUTE_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTE_CLASSRowId tyGE_ATTRIBUTE_CLASSRowId;type tyGE_ATTRIBUTES_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTES_TYPERowId tyGE_ATTRIBUTES_TYPERowId;type tyGE_ATTRIBUTESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTESRowId tyGE_ATTRIBUTESRowId;type tyGE_STATEMENTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_STATEMENTRowId tyGE_STATEMENTRowId;type tyWF_UNIT_TYPE_ATTRIBRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPE_ATTRIBRowId tyWF_UNIT_TYPE_ATTRIBRowId;type tyMO_TIME_UNI_TYP_PRIORowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbMO_TIME_UNI_TYP_PRIORowId tyMO_TIME_UNI_TYP_PRIORowId;type tyOR_ACT_BY_TASK_MODRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbOR_ACT_BY_TASK_MODRowId tyOR_ACT_BY_TASK_MODRowId;type ty0_0 is table of WF_UNIT_TYPE.UNIT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_5 is table of WF_UNIT_TYPE.INIT_AREA_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_5 ty0_5; ' || chr(10) ||
'tb0_5 ty0_5;type ty1_0 is table of GE_ATTRIBUTE_CLASS.ATTRIBUTE_CLASS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_0 ty1_0; ' || chr(10) ||
'tb1_0 ty1_0;type ty2_0 is table of GE_ATTRIBUTES_TYPE.ATTRIBUTE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;type ty3_0 is table of GE_ATTRIBUTES.ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_0 ty3_0; ' || chr(10) ||
'tb3_0 ty3_0;type ty3_1 is table of GE_ATTRIBUTES.ATTRIBUTE_CLASS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_1 ty3_1; ' || chr(10) ||
'tb3_1 ty3_1;type ty3_2 is table of GE_ATTRIBUTES.ATTRIBUTE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_2 ty3_2; ' || chr(10) ||
'tb3_2 ty3_2;type ty3_3 is table of GE_ATTRIBUTES.VALID_EXPRESSION%type index by binary_integer; ' || chr(10) ||
'old_tb3_3 ty3_3; ' || chr(10) ||
'tb3_3 ty3_3;type ty4_0 is table of WF_UNIT_TYPE_ATTRIB.UNIT_TYPE_ATTRIB_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_0 ty4_0; ' || chr(10) ||
'tb4_0 ty4_0;type ty4_1 is table of WF_UNIT_TYPE_ATTRIB.UNIT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_1 ty4_1; ' || chr(10) ||
'tb4_1 ty4_1;type ty4_2 is table of WF_UNIT_TYPE_ATTRIB.ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_2 ty4_2; ' || chr(10) ||
'tb4_2 ty4_2;type ty4_3 is table of WF_UNIT_TYPE_ATTRIB.STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_3 ty4_3; ' || chr(10) ||
'tb4_3 ty4_3; ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_UNITTYPE_254_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_UNITTYPE_254_******************************'); END;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_UNITTYPE_254',1);
EXP_UNITTYPE_254_.blProcessStatus := EXP_PROCESS_100588_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  SELECT  B.object_name
FROM    OR_ACT_BY_TASK_MOD A, GR_CONFIG_EXPRESSION B 
WHERE   A.CONFIG_EXPRESSION_ID = B.CONFIG_EXPRESSION_ID
AND     A.TASK_CODE = 254
 
;
BEGIN

if (not EXP_UNITTYPE_254_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_UNITTYPE_254_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
  nuIndex := nuIndex + 1;
 END LOOP;
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
END;
/

declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_TYPE_ATTRIB WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=254);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_254_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_TYPE_ATTRIB',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_TYPE_ATTRIB WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_254_.blProcessStatus := false;
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
FROM WF_CAUSAL_UNIT_TYPE WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=254);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_254_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_CAUSAL_UNIT_TYPE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_CAUSAL_UNIT_TYPE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_254_.blProcessStatus := false;
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
FROM MO_TIME_UNI_TYP_PRIO WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=254);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_254_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla MO_TIME_UNI_TYP_PRIO',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM MO_TIME_UNI_TYP_PRIO WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_254_.blProcessStatus := false;
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
FROM OR_ACT_BY_TASK_MOD WHERE (TASK_CODE) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=254);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_254_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla OR_ACT_BY_TASK_MOD',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM OR_ACT_BY_TASK_MOD WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_254_.blProcessStatus := false;
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
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=254;
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_254_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_TYPE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_TYPE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_254_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_UNITTYPE_254_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_254_.tb0_0(0):=254;
ut_trace.trace('insertando tabla sin fallo: WF_UNIT_TYPE fila (0)',1);
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_UNITTYPE_254_.tb0_0(0),
2,
5,
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_254'
,
'Generar/Financiar Factura'
,
'Generar/Financiar Factura'
,
null,
'N'
,
'N'
,
null,
'R'
,
'N'
,
null,
'N'
,
null,
null,
'N'
,
null,
null);

exception 
when dup_val_on_index then 
 return;
when others then
EXP_UNITTYPE_254_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_254_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_254_.tb1_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTE_CLASS fila (0)',1);
UPDATE GE_ATTRIBUTE_CLASS SET ATTRIBUTE_CLASS_ID=EXP_UNITTYPE_254_.tb1_0(0),
NAME='De Entitdad'
,
DESCRIPTION='Valores que ser¿n tra¿dos de la tabla base usando old record'

 WHERE ATTRIBUTE_CLASS_ID = EXP_UNITTYPE_254_.tb1_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTE_CLASS(ATTRIBUTE_CLASS_ID,NAME,DESCRIPTION) 
VALUES (EXP_UNITTYPE_254_.tb1_0(0),
'De Entitdad'
,
'Valores que ser¿n tra¿dos de la tabla base usando old record'
);
end if;

exception when others then
EXP_UNITTYPE_254_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_254_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_254_.tb2_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES_TYPE fila (0)',1);
UPDATE GE_ATTRIBUTES_TYPE SET ATTRIBUTE_TYPE_ID=EXP_UNITTYPE_254_.tb2_0(0),
DESCRIPTION='NUMBER'
,
INTERNAL_TYPE=2,
INTERNAL_JAVA_TYPE=2
 WHERE ATTRIBUTE_TYPE_ID = EXP_UNITTYPE_254_.tb2_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES_TYPE(ATTRIBUTE_TYPE_ID,DESCRIPTION,INTERNAL_TYPE,INTERNAL_JAVA_TYPE) 
VALUES (EXP_UNITTYPE_254_.tb2_0(0),
'NUMBER'
,
2,
2);
end if;

exception when others then
EXP_UNITTYPE_254_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_254_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_254_.tb3_0(0):=400;
EXP_UNITTYPE_254_.tb3_1(0):=EXP_UNITTYPE_254_.tb1_0(0);
EXP_UNITTYPE_254_.tb3_2(0):=EXP_UNITTYPE_254_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (0)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=EXP_UNITTYPE_254_.tb3_0(0),
ATTRIBUTE_CLASS_ID=EXP_UNITTYPE_254_.tb3_1(0),
ATTRIBUTE_TYPE_ID=EXP_UNITTYPE_254_.tb3_2(0),
VALID_EXPRESSION=null,
FATHER_ID=null,
MODULE_ID=9,
NAME_ATTRIBUTE='CAUSAL'
,
LENGTH=4,
PRECISION=null,
SCALE=null,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE='T'
,
COMMENT_='Causal'
,
DISPLAY_NAME='Causal'

 WHERE ATTRIBUTE_ID = EXP_UNITTYPE_254_.tb3_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,ATTRIBUTE_CLASS_ID,ATTRIBUTE_TYPE_ID,VALID_EXPRESSION,FATHER_ID,MODULE_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (EXP_UNITTYPE_254_.tb3_0(0),
EXP_UNITTYPE_254_.tb3_1(0),
EXP_UNITTYPE_254_.tb3_2(0),
null,
null,
9,
'CAUSAL'
,
4,
null,
null,
null,
'T'
,
'Causal'
,
'Causal'
);
end if;

exception when others then
EXP_UNITTYPE_254_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_254_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_254_.tb4_0(0):=109072;
EXP_UNITTYPE_254_.tb4_1(0):=EXP_UNITTYPE_254_.tb0_0(0);
EXP_UNITTYPE_254_.tb4_2(0):=EXP_UNITTYPE_254_.tb3_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE_ATTRIB fila (0)',1);
UPDATE WF_UNIT_TYPE_ATTRIB SET UNIT_TYPE_ATTRIB_ID=EXP_UNITTYPE_254_.tb4_0(0),
UNIT_TYPE_ID=EXP_UNITTYPE_254_.tb4_1(0),
ATTRIBUTE_ID=EXP_UNITTYPE_254_.tb4_2(0),
STATEMENT_ID=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_TYPE_ATTRIB_ID = EXP_UNITTYPE_254_.tb4_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE_ATTRIB(UNIT_TYPE_ATTRIB_ID,UNIT_TYPE_ID,ATTRIBUTE_ID,STATEMENT_ID,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_UNITTYPE_254_.tb4_0(0),
EXP_UNITTYPE_254_.tb4_1(0),
EXP_UNITTYPE_254_.tb4_2(0),
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_UNITTYPE_254_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100588',1);
EXP_PROCESS_100588_.blProcessStatus := EXP_UNITTYPE_254_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/

DECLARE
 nuIndex         binary_integer;
 blObjectDeleted boolean;

 FUNCTION fblIsObjectUseByRule
 (
  isbObjectName   IN gr_config_expression.object_name%type
 ) return BOOLEAN
 IS
  nuCounter    NUMBER := 0;
  blReturn     BOOLEAN := FALSE;
 BEGIN
  SELECT count('x') INTO nuCounter
  FROM gr_config_expression
  WHERE object_name = isbObjectName;
  IF (nuCounter > 0) THEN
    BEGIN
      DELETE FROM gr_config_expression
      WHERE object_name = isbObjectName;
      blReturn := FALSE;
    EXCEPTION
      when ex.RECORD_HAVE_CHILDREN then
         ut_trace.trace('Objeto ' || isbObjectName || ' usado en ' || nuCounter ||' reglas, no se borra',2);
         blReturn := TRUE;
    END;
  END IF;
  RETURN blReturn;
 END;

BEGIN
 ut_trace.trace('Inicia borrado de objetos de reglas',1);
 nuIndex := EXP_UNITTYPE_254_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_UNITTYPE_254_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_UNITTYPE_254_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_UNITTYPE_254_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_UNITTYPE_254_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_UNITTYPE_254_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_UNITTYPE_254_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_UNITTYPE_254_.tbObjectToDelete.next(nuIndex);
 END loop;
 ut_trace.trace('Finaliza borrado de objetos de reglas',1);
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('EXP_UNITTYPE_254_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_UNITTYPE_254_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_UNITTYPE_100427_',
'CREATE OR REPLACE PACKAGE EXP_UNITTYPE_100427_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyWF_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPERowId tyWF_UNIT_TYPERowId;type tyWF_CAUSAL_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_CAUSAL_UNIT_TYPERowId tyWF_CAUSAL_UNIT_TYPERowId;type tyGR_CONFIGURA_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIGURA_TYPERowId tyGR_CONFIGURA_TYPERowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type tyGE_ATTRIBUTE_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTE_CLASSRowId tyGE_ATTRIBUTE_CLASSRowId;type tyGE_ATTRIBUTES_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTES_TYPERowId tyGE_ATTRIBUTES_TYPERowId;type tyGE_ATTRIBUTESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTESRowId tyGE_ATTRIBUTESRowId;type tyGE_STATEMENTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_STATEMENTRowId tyGE_STATEMENTRowId;type tyWF_UNIT_TYPE_ATTRIBRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPE_ATTRIBRowId tyWF_UNIT_TYPE_ATTRIBRowId;type tyMO_TIME_UNI_TYP_PRIORowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbMO_TIME_UNI_TYP_PRIORowId tyMO_TIME_UNI_TYP_PRIORowId;type tyOR_ACT_BY_TASK_MODRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbOR_ACT_BY_TASK_MODRowId tyOR_ACT_BY_TASK_MODRowId;type ty0_0 is table of WF_UNIT_TYPE.UNIT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_5 is table of WF_UNIT_TYPE.INIT_AREA_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_5 ty0_5; ' || chr(10) ||
'tb0_5 ty0_5; ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_UNITTYPE_100427_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_UNITTYPE_100427_******************************'); END;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_UNITTYPE_100427',1);
EXP_UNITTYPE_100427_.blProcessStatus := EXP_PROCESS_100588_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  SELECT  B.object_name
FROM    OR_ACT_BY_TASK_MOD A, GR_CONFIG_EXPRESSION B 
WHERE   A.CONFIG_EXPRESSION_ID = B.CONFIG_EXPRESSION_ID
AND     A.TASK_CODE = 100427
 
;
BEGIN

if (not EXP_UNITTYPE_100427_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_UNITTYPE_100427_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
  nuIndex := nuIndex + 1;
 END LOOP;
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
END;
/

declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_TYPE_ATTRIB WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100427);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100427_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_TYPE_ATTRIB',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_TYPE_ATTRIB WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100427_.blProcessStatus := false;
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
FROM WF_CAUSAL_UNIT_TYPE WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100427);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100427_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_CAUSAL_UNIT_TYPE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_CAUSAL_UNIT_TYPE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100427_.blProcessStatus := false;
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
FROM MO_TIME_UNI_TYP_PRIO WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100427);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100427_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla MO_TIME_UNI_TYP_PRIO',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM MO_TIME_UNI_TYP_PRIO WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100427_.blProcessStatus := false;
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
FROM OR_ACT_BY_TASK_MOD WHERE (TASK_CODE) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100427);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100427_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla OR_ACT_BY_TASK_MOD',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM OR_ACT_BY_TASK_MOD WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100427_.blProcessStatus := false;
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
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100427;
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100427_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_TYPE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_TYPE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100427_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_UNITTYPE_100427_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100427_.tb0_0(0):=100427;
ut_trace.trace('insertando tabla sin fallo: WF_UNIT_TYPE fila (0)',1);
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_UNITTYPE_100427_.tb0_0(0),
1,
9,
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_100427'
,
'Proceso de Distribuci¿n de Cargos'
,
'Proceso de Distribuci¿n de Cargos'
,
null,
'N'
,
'N'
,
null,
'R'
,
'N'
,
null,
'N'
,
null,
null,
'N'
,
null,
null);

exception 
when dup_val_on_index then 
 return;
when others then
EXP_UNITTYPE_100427_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100588',1);
EXP_PROCESS_100588_.blProcessStatus := EXP_UNITTYPE_100427_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/

DECLARE
 nuIndex         binary_integer;
 blObjectDeleted boolean;

 FUNCTION fblIsObjectUseByRule
 (
  isbObjectName   IN gr_config_expression.object_name%type
 ) return BOOLEAN
 IS
  nuCounter    NUMBER := 0;
  blReturn     BOOLEAN := FALSE;
 BEGIN
  SELECT count('x') INTO nuCounter
  FROM gr_config_expression
  WHERE object_name = isbObjectName;
  IF (nuCounter > 0) THEN
    BEGIN
      DELETE FROM gr_config_expression
      WHERE object_name = isbObjectName;
      blReturn := FALSE;
    EXCEPTION
      when ex.RECORD_HAVE_CHILDREN then
         ut_trace.trace('Objeto ' || isbObjectName || ' usado en ' || nuCounter ||' reglas, no se borra',2);
         blReturn := TRUE;
    END;
  END IF;
  RETURN blReturn;
 END;

BEGIN
 ut_trace.trace('Inicia borrado de objetos de reglas',1);
 nuIndex := EXP_UNITTYPE_100427_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_UNITTYPE_100427_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_UNITTYPE_100427_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_UNITTYPE_100427_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_UNITTYPE_100427_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_UNITTYPE_100427_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_UNITTYPE_100427_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_UNITTYPE_100427_.tbObjectToDelete.next(nuIndex);
 END loop;
 ut_trace.trace('Finaliza borrado de objetos de reglas',1);
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('EXP_UNITTYPE_100427_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_UNITTYPE_100427_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_PROCESS_100427_',
'CREATE OR REPLACE PACKAGE EXP_PROCESS_100427_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyWF_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPERowId tyWF_UNIT_TYPERowId;type tyWF_UNIT_CATEGORYRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_CATEGORYRowId tyWF_UNIT_CATEGORYRowId;type tyWF_ATTRIBUTES_EQUIVRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_ATTRIBUTES_EQUIVRowId tyWF_ATTRIBUTES_EQUIVRowId;type tyGE_COMMENT_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_COMMENT_CLASSRowId tyGE_COMMENT_CLASSRowId;type tyGR_CONFIGURA_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIGURA_TYPERowId tyGR_CONFIGURA_TYPERowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type tyGE_ATTRIBUTE_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTE_CLASSRowId tyGE_ATTRIBUTE_CLASSRowId;type tyGE_ATTRIBUTES_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTES_TYPERowId tyGE_ATTRIBUTES_TYPERowId;type tyGE_ATTRIBUTESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTESRowId tyGE_ATTRIBUTESRowId;type tyGE_STATEMENTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_STATEMENTRowId tyGE_STATEMENTRowId;type tyWF_UNIT_ATTRIBUTERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_ATTRIBUTERowId tyWF_UNIT_ATTRIBUTERowId;type tyGE_MODULERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_MODULERowId tyGE_MODULERowId;type tyWF_NODE_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_NODE_TYPERowId tyWF_NODE_TYPERowId;type tyWF_UNITRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNITRowId tyWF_UNITRowId;type tyWF_UNIT_DATA_MAPRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_DATA_MAPRowId tyWF_UNIT_DATA_MAPRowId;type tyWF_TRANSITIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_TRANSITIONRowId tyWF_TRANSITIONRowId;type ty0_0 is table of WF_UNIT_CATEGORY.CATEGORY_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty1_0 is table of GE_MODULE.MODULE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_0 ty1_0; ' || chr(10) ||
'tb1_0 ty1_0;type ty2_0 is table of WF_UNIT_TYPE.UNIT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;type ty2_1 is table of WF_UNIT_TYPE.CATEGORY_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_1 ty2_1; ' || chr(10) ||
'tb2_1 ty2_1;type ty2_2 is table of WF_UNIT_TYPE.MODULE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_2 ty2_2; ' || chr(10) ||
'tb2_2 ty2_2;type ty2_5 is table of WF_UNIT_TYPE.INIT_AREA_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_5 ty2_5; ' || chr(10) ||
'tb2_5 ty2_5;type ty2_6 is table of WF_UNIT_TYPE.ASSIGN_COMMENT_CLASS%type index by binary_integer; ' || chr(10) ||
'old_tb2_6 ty2_6; ' || chr(10) ||
'tb2_6 ty2_6;type ty2_7 is table of WF_UNIT_TYPE.ATTEND_COMMENT_CLASS%type index by binary_integer; ' || chr(10) ||
'old_tb2_7 ty2_7; ' || chr(10) ||
'tb2_7 ty2_7;type ty2_8 is table of WF_UNIT_TYPE.UNASSIGN_COMMENT_CLASS%type index by binary_integer; ' || chr(10) ||
'old_tb2_8 ty2_8; ' || chr(10) ||
'tb2_8 ty2_8;type ty3_0 is table of WF_NODE_TYPE.NODE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_0 ty3_0; ' || chr(10) ||
'tb3_0 ty3_0;type ty4_0 is table of WF_UNIT.UNIT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_0 ty4_0; ' || chr(10) ||
'tb4_0 ty4_0;type ty4_1 is table of WF_UNIT.PROCESS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_1 ty4_1; ' || chr(10) ||
'tb4_1 ty4_1;type ty4_2 is table of WF_UNIT.UNIT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_2 ty4_2; ' || chr(10) ||
'tb4_2 ty4_2;type ty4_3 is table of WF_UNIT.NODE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_3 ty4_3; ' || chr(10) ||
'tb4_3 ty4_3;type ty4_4 is table of WF_UNIT.MODULE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_4 ty4_4; ' || chr(10) ||
'tb4_4 ty4_4;type ty4_6 is table of WF_UNIT.PRE_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_6 ty4_6; ' || chr(10) ||
'tb4_6 ty4_6;type ty4_7 is table of WF_UNIT.POS_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_7 ty4_7; ' || chr(10) ||
'tb4_7 ty4_7;type ty5_0 is table of WF_TRANSITION.TRANS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_0 ty5_0; ' || chr(10) ||
'tb5_0 ty5_0;type ty5_1 is table of WF_TRANSITION.ORIGIN_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_1 ty5_1; ' || chr(10) ||
'tb5_1 ty5_1;type ty5_2 is table of WF_TRANSITION.TARGET_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_2 ty5_2; ' || chr(10) ||
'tb5_2 ty5_2;type ty6_0 is table of GE_ATTRIBUTE_CLASS.ATTRIBUTE_CLASS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_0 ty6_0; ' || chr(10) ||
'tb6_0 ty6_0;type ty7_0 is table of GE_ATTRIBUTES_TYPE.ATTRIBUTE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_0 ty7_0; ' || chr(10) ||
'tb7_0 ty7_0;type ty8_0 is table of GE_ATTRIBUTES.ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_0 ty8_0; ' || chr(10) ||
'tb8_0 ty8_0;type ty8_1 is table of GE_ATTRIBUTES.ATTRIBUTE_CLASS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_1 ty8_1; ' || chr(10) ||
'tb8_1 ty8_1;type ty8_2 is table of GE_ATTRIBUTES.ATTRIBUTE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_2 ty8_2; ' || chr(10) ||
'tb8_2 ty8_2;type ty9_0 is table of WF_UNIT_ATTRIBUTE.UNIT_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb9_0 ty9_0; ' || chr(10) ||
'tb9_0 ty9_0;type ty9_1 is table of WF_UNIT_ATTRIBUTE.UNIT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb9_1 ty9_1; ' || chr(10) ||
'tb9_1 ty9_1;type ty9_2 is table of WF_UNIT_ATTRIBUTE.ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb9_2 ty9_2; ' || chr(10) ||
'tb9_2 ty9_2;type ty9_3 is table of WF_UNIT_ATTRIBUTE.STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb9_3 ty9_3; ' || chr(10) ||
'tb9_3 ty9_3;type ty10_0 is table of GE_STATEMENT.STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb10_0 ty10_0; ' || chr(10) ||
'tb10_0 ty10_0; ' || chr(10) ||
'CURSOR cuExpression is ' || chr(10) ||
'SELECT PRE_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_TYPE_ID = 100427 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID IN  ' || chr(10) ||
'           (SELECT UNIT_ID ' || chr(10) ||
'           FROM WF_UNIT ' || chr(10) ||
'           WHERE UNIT_TYPE_ID = 100427 ' || chr(10) ||
'       )) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_TYPE_ID = 100427 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID IN  ' || chr(10) ||
'           (SELECT UNIT_ID ' || chr(10) ||
'           FROM WF_UNIT ' || chr(10) ||
'           WHERE UNIT_TYPE_ID = 100427 ' || chr(10) ||
'       )) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_PROCESS_100427_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_PROCESS_100427_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open EXP_PROCESS_100427_.cuExpression;
   fetch EXP_PROCESS_100427_.cuExpression bulk collect INTO EXP_PROCESS_100427_.tbGR_CONFIG_EXPRESSIONId;
   close EXP_PROCESS_100427_.cuExpression;
END;
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100427',1);
EXP_PROCESS_100427_.blProcessStatus := EXP_PROCESS_100588_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('DEL_ROOT_102301_',
'CREATE OR REPLACE PACKAGE DEL_ROOT_102301_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyWF_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPERowId tyWF_UNIT_TYPERowId;type tyWF_UNIT_CATEGORYRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_CATEGORYRowId tyWF_UNIT_CATEGORYRowId;type tyWF_ATTRIBUTES_EQUIVRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_ATTRIBUTES_EQUIVRowId tyWF_ATTRIBUTES_EQUIVRowId;type tyGE_COMMENT_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_COMMENT_CLASSRowId tyGE_COMMENT_CLASSRowId;type tyGR_CONFIGURA_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIGURA_TYPERowId tyGR_CONFIGURA_TYPERowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type tyGE_ATTRIBUTE_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTE_CLASSRowId tyGE_ATTRIBUTE_CLASSRowId;type tyGE_ATTRIBUTES_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTES_TYPERowId tyGE_ATTRIBUTES_TYPERowId;type tyGE_ATTRIBUTESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTESRowId tyGE_ATTRIBUTESRowId;type tyGE_STATEMENTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_STATEMENTRowId tyGE_STATEMENTRowId;type tyWF_UNIT_ATTRIBUTERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_ATTRIBUTERowId tyWF_UNIT_ATTRIBUTERowId;type tyGE_MODULERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_MODULERowId tyGE_MODULERowId;type tyWF_NODE_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_NODE_TYPERowId tyWF_NODE_TYPERowId;type tyWF_UNITRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNITRowId tyWF_UNITRowId;type tyWF_UNIT_DATA_MAPRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_DATA_MAPRowId tyWF_UNIT_DATA_MAPRowId;type tyWF_TRANSITIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_TRANSITIONRowId tyWF_TRANSITIONRowId;type ty0_0 is table of WF_UNIT.UNIT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_6 is table of WF_UNIT.PRE_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_6 ty0_6; ' || chr(10) ||
'tb0_6 ty0_6;type ty0_7 is table of WF_UNIT.POS_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_7 ty0_7; ' || chr(10) ||
'tb0_7 ty0_7;type ty1_0 is table of WF_TRANSITION.TRANS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_0 ty1_0; ' || chr(10) ||
'tb1_0 ty1_0;type ty1_1 is table of WF_TRANSITION.ORIGIN_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_1 ty1_1; ' || chr(10) ||
'tb1_1 ty1_1;type ty1_2 is table of WF_TRANSITION.TARGET_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_2 ty1_2; ' || chr(10) ||
'tb1_2 ty1_2;type ty2_0 is table of WF_UNIT_ATTRIBUTE.UNIT_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;type ty2_1 is table of WF_UNIT_ATTRIBUTE.UNIT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_1 ty2_1; ' || chr(10) ||
'tb2_1 ty2_1; ' || chr(10) ||
'CURSOR cuExpression is ' || chr(10) ||
'SELECT PRE_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_ID = 102301 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 102301  ' || chr(10) ||
'       ) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_ID = 102301 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 102301  ' || chr(10) ||
'       ) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END DEL_ROOT_102301_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:DEL_ROOT_102301_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open DEL_ROOT_102301_.cuExpression;
   fetch DEL_ROOT_102301_.cuExpression bulk collect INTO DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONId;
   close DEL_ROOT_102301_.cuExpression;
END;
/ 

DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  SELECT  B.object_name
FROM    WF_UNIT A, GR_CONFIG_EXPRESSION B
WHERE   (A.PRE_EXPRESSION_ID = b.CONFIG_EXPRESSION_ID
OR   A.POS_EXPRESSION_ID = b.CONFIG_EXPRESSION_ID)
AND     A.UNIT_ID IN (
        SELECT UNIT_ID         FROM WF_UNIT 
        WHERE UNIT_ID = 102301
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID = 102301 
       )
;
BEGIN

if (not DEL_ROOT_102301_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  DEL_ROOT_102301_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
  nuIndex := nuIndex + 1;
 END LOOP;
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
END;
/

DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE PROCESS_ID = 102301);
BEGIN 

if (not DEL_ROOT_102301_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102301_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE PROCESS_ID = 102301);
BEGIN 

if (not DEL_ROOT_102301_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102301_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 102301)));
BEGIN 

if (not DEL_ROOT_102301_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102301_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 102301)));
BEGIN 

if (not DEL_ROOT_102301_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102301_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 102301));
BEGIN 

if (not DEL_ROOT_102301_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla WF_UNIT',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102301_.tbWF_UNITRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102301_.blProcessStatus := false;
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
FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 102301);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102301_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_TRANSITION',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_TRANSITION WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
DEL_ROOT_102301_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102301_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102301_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102301_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102301_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102301_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria WF_UNIT',1);
nuVarcharIndex:=DEL_ROOT_102301_.tbWF_UNITRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from WF_UNIT where rowid = DEL_ROOT_102301_.tbWF_UNITRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102301_.tbWF_UNITRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102301_.tbWF_UNITRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102301_.blProcessStatus := false;
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
FROM WF_UNIT_DATA_MAP WHERE (SOURCE_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 102301));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102301_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_DATA_MAP',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_DATA_MAP WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
DEL_ROOT_102301_.blProcessStatus := false;
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
FROM WF_UNIT_DATA_MAP WHERE (TARGET_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 102301));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102301_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_DATA_MAP',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_DATA_MAP WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
DEL_ROOT_102301_.blProcessStatus := false;
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
FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 102301);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102301_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_ATTRIBUTE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_ATTRIBUTE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
DEL_ROOT_102301_.blProcessStatus := false;
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
FROM WF_UNIT WHERE PROCESS_ID = 102301;
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102301_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
DEL_ROOT_102301_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102301_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102301_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102301_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102301_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/

BEGIN
    ut_trace.trace('Actualizar WF_UNIT a ProcessId NULL ',1);
   UPDATE WF_UNIT 
     SET PROCESS_ID = -1, POS_EXPRESSION_ID = null, PRE_EXPRESSION_ID = null, ACTION_ID = null 
     WHERE PROCESS_ID = 102301;
   exception
         when others then 
            rollback;
            ut_trace.trace('**ERROR:'||sqlerrm,1);
            raise;
END;
  
/

DECLARE 
    nuBinaryIndex Binary_Integer;
BEGIN 
    nuBinaryIndex := DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       DEL_ROOT_102301_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100427',1);
EXP_PROCESS_100427_.blProcessStatus := DEL_ROOT_102301_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/

DECLARE
 nuIndex         binary_integer;
 blObjectDeleted boolean;

 FUNCTION fblIsObjectUseByRule
 (
  isbObjectName   IN gr_config_expression.object_name%type
 ) return BOOLEAN
 IS
  nuCounter    NUMBER := 0;
  blReturn     BOOLEAN := FALSE;
 BEGIN
  SELECT count('x') INTO nuCounter
  FROM gr_config_expression
  WHERE object_name = isbObjectName;
  IF (nuCounter > 0) THEN
    BEGIN
      DELETE FROM gr_config_expression
      WHERE object_name = isbObjectName;
      blReturn := FALSE;
    EXCEPTION
      when ex.RECORD_HAVE_CHILDREN then
         ut_trace.trace('Objeto ' || isbObjectName || ' usado en ' || nuCounter ||' reglas, no se borra',2);
         blReturn := TRUE;
    END;
  END IF;
  RETURN blReturn;
 END;

BEGIN
 ut_trace.trace('Inicia borrado de objetos de reglas',1);
 nuIndex := DEL_ROOT_102301_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || DEL_ROOT_102301_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(DEL_ROOT_102301_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(DEL_ROOT_102301_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(DEL_ROOT_102301_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || DEL_ROOT_102301_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || DEL_ROOT_102301_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := DEL_ROOT_102301_.tbObjectToDelete.next(nuIndex);
 END loop;
 ut_trace.trace('Finaliza borrado de objetos de reglas',1);
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('DEL_ROOT_102301_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:DEL_ROOT_102301_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('DEL_ROOT_102301_',
'CREATE OR REPLACE PACKAGE DEL_ROOT_102301_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyWF_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPERowId tyWF_UNIT_TYPERowId;type tyWF_UNIT_CATEGORYRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_CATEGORYRowId tyWF_UNIT_CATEGORYRowId;type tyWF_ATTRIBUTES_EQUIVRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_ATTRIBUTES_EQUIVRowId tyWF_ATTRIBUTES_EQUIVRowId;type tyGE_COMMENT_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_COMMENT_CLASSRowId tyGE_COMMENT_CLASSRowId;type tyGR_CONFIGURA_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIGURA_TYPERowId tyGR_CONFIGURA_TYPERowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type tyGE_ATTRIBUTE_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTE_CLASSRowId tyGE_ATTRIBUTE_CLASSRowId;type tyGE_ATTRIBUTES_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTES_TYPERowId tyGE_ATTRIBUTES_TYPERowId;type tyGE_ATTRIBUTESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTESRowId tyGE_ATTRIBUTESRowId;type tyGE_STATEMENTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_STATEMENTRowId tyGE_STATEMENTRowId;type tyWF_UNIT_ATTRIBUTERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_ATTRIBUTERowId tyWF_UNIT_ATTRIBUTERowId;type tyGE_MODULERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_MODULERowId tyGE_MODULERowId;type tyWF_NODE_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_NODE_TYPERowId tyWF_NODE_TYPERowId;type tyWF_UNITRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNITRowId tyWF_UNITRowId;type tyWF_UNIT_DATA_MAPRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_DATA_MAPRowId tyWF_UNIT_DATA_MAPRowId;type tyWF_TRANSITIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_TRANSITIONRowId tyWF_TRANSITIONRowId;type ty0_0 is table of WF_UNIT.UNIT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_6 is table of WF_UNIT.PRE_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_6 ty0_6; ' || chr(10) ||
'tb0_6 ty0_6;type ty0_7 is table of WF_UNIT.POS_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_7 ty0_7; ' || chr(10) ||
'tb0_7 ty0_7; ' || chr(10) ||
'CURSOR cuExpression is ' || chr(10) ||
'SELECT PRE_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_ID = 102301 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 102301  ' || chr(10) ||
'       ) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_ID = 102301 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 102301  ' || chr(10) ||
'       ) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END DEL_ROOT_102301_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:DEL_ROOT_102301_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open DEL_ROOT_102301_.cuExpression;
   fetch DEL_ROOT_102301_.cuExpression bulk collect INTO DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONId;
   close DEL_ROOT_102301_.cuExpression;
END;
/ 

DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  SELECT  B.object_name
FROM    WF_UNIT A, GR_CONFIG_EXPRESSION B
WHERE   (A.PRE_EXPRESSION_ID = b.CONFIG_EXPRESSION_ID
OR   A.POS_EXPRESSION_ID = b.CONFIG_EXPRESSION_ID)
AND     A.UNIT_ID IN (
        SELECT UNIT_ID         FROM WF_UNIT 
        WHERE UNIT_ID = 102301
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID = 102301 
       )
;
BEGIN

if (not DEL_ROOT_102301_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  DEL_ROOT_102301_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
  nuIndex := nuIndex + 1;
 END LOOP;
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
END;
/

DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE UNIT_ID = 102301);
BEGIN 

if (not DEL_ROOT_102301_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102301_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE UNIT_ID = 102301);
BEGIN 

if (not DEL_ROOT_102301_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102301_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 102301)));
BEGIN 

if (not DEL_ROOT_102301_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102301_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 102301)));
BEGIN 

if (not DEL_ROOT_102301_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102301_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 102301));
BEGIN 

if (not DEL_ROOT_102301_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla WF_UNIT',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102301_.tbWF_UNITRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102301_.blProcessStatus := false;
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
FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 102301);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102301_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_TRANSITION',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_TRANSITION WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
DEL_ROOT_102301_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102301_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102301_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102301_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102301_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102301_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria WF_UNIT',1);
nuVarcharIndex:=DEL_ROOT_102301_.tbWF_UNITRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from WF_UNIT where rowid = DEL_ROOT_102301_.tbWF_UNITRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102301_.tbWF_UNITRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102301_.tbWF_UNITRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102301_.blProcessStatus := false;
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
FROM WF_UNIT_DATA_MAP WHERE (SOURCE_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 102301));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102301_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_DATA_MAP',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_DATA_MAP WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
DEL_ROOT_102301_.blProcessStatus := false;
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
FROM WF_UNIT_DATA_MAP WHERE (TARGET_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 102301));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102301_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_DATA_MAP',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_DATA_MAP WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
DEL_ROOT_102301_.blProcessStatus := false;
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
FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 102301);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102301_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_ATTRIBUTE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_ATTRIBUTE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
DEL_ROOT_102301_.blProcessStatus := false;
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
FROM WF_UNIT WHERE UNIT_ID = 102301;
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102301_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
DEL_ROOT_102301_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102301_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102301_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102301_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102301_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/

BEGIN
    ut_trace.trace('Actualizar WF_UNIT a ProcessId NULL ',1);
   UPDATE WF_UNIT 
     SET PROCESS_ID = -1, POS_EXPRESSION_ID = null, PRE_EXPRESSION_ID = null, ACTION_ID = null 
     WHERE PROCESS_ID = 102301;
   exception
         when others then 
            rollback;
            ut_trace.trace('**ERROR:'||sqlerrm,1);
            raise;
END;
  
/

DECLARE 
    nuBinaryIndex Binary_Integer;
BEGIN 
    nuBinaryIndex := DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := DEL_ROOT_102301_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       DEL_ROOT_102301_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100427',1);
EXP_PROCESS_100427_.blProcessStatus := DEL_ROOT_102301_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/

DECLARE
 nuIndex         binary_integer;
 blObjectDeleted boolean;

 FUNCTION fblIsObjectUseByRule
 (
  isbObjectName   IN gr_config_expression.object_name%type
 ) return BOOLEAN
 IS
  nuCounter    NUMBER := 0;
  blReturn     BOOLEAN := FALSE;
 BEGIN
  SELECT count('x') INTO nuCounter
  FROM gr_config_expression
  WHERE object_name = isbObjectName;
  IF (nuCounter > 0) THEN
    BEGIN
      DELETE FROM gr_config_expression
      WHERE object_name = isbObjectName;
      blReturn := FALSE;
    EXCEPTION
      when ex.RECORD_HAVE_CHILDREN then
         ut_trace.trace('Objeto ' || isbObjectName || ' usado en ' || nuCounter ||' reglas, no se borra',2);
         blReturn := TRUE;
    END;
  END IF;
  RETURN blReturn;
 END;

BEGIN
 ut_trace.trace('Inicia borrado de objetos de reglas',1);
 nuIndex := DEL_ROOT_102301_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || DEL_ROOT_102301_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(DEL_ROOT_102301_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(DEL_ROOT_102301_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(DEL_ROOT_102301_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || DEL_ROOT_102301_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || DEL_ROOT_102301_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := DEL_ROOT_102301_.tbObjectToDelete.next(nuIndex);
 END loop;
 ut_trace.trace('Finaliza borrado de objetos de reglas',1);
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('DEL_ROOT_102301_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:DEL_ROOT_102301_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_ACTION_257_',
'CREATE OR REPLACE PACKAGE EXP_ACTION_257_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyGR_CONFIGURA_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIGURA_TYPERowId tyGR_CONFIGURA_TYPERowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type tyGE_ACTION_MODULERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ACTION_MODULERowId tyGE_ACTION_MODULERowId;type tyGE_VALID_ACTION_MODURowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_VALID_ACTION_MODURowId tyGE_VALID_ACTION_MODURowId;type ty0_0 is table of GR_CONFIGURA_TYPE.CONFIGURA_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty1_0 is table of GR_CONFIG_EXPRESSION.CONFIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_0 ty1_0; ' || chr(10) ||
'tb1_0 ty1_0;type ty1_1 is table of GR_CONFIG_EXPRESSION.OBJECT_NAME%type index by binary_integer; ' || chr(10) ||
'old_tb1_1 ty1_1; ' || chr(10) ||
'tb1_1 ty1_1;type ty1_2 is table of GR_CONFIG_EXPRESSION.CONFIGURA_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_2 ty1_2; ' || chr(10) ||
'tb1_2 ty1_2;type ty2_0 is table of GE_ACTION_MODULE.ACTION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;type ty2_2 is table of GE_ACTION_MODULE.CONFIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_2 ty2_2; ' || chr(10) ||
'tb2_2 ty2_2;type ty3_0 is table of GE_VALID_ACTION_MODU.ACTION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_0 ty3_0; ' || chr(10) ||
'tb3_0 ty3_0;type ty3_1 is table of GE_VALID_ACTION_MODU.VALID_MODULE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_1 ty3_1; ' || chr(10) ||
'tb3_1 ty3_1; ' || chr(10) ||
'CURSOR cuExpression is ' || chr(10) ||
'SELECT CONFIG_EXPRESSION_ID ' || chr(10) ||
'FROM   GE_ACTION_MODULE ' || chr(10) ||
'WHERE  ACTION_ID =257; ' || chr(10) ||
'type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_ACTION_257_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_ACTION_257_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open EXP_ACTION_257_.cuExpression;
   fetch EXP_ACTION_257_.cuExpression bulk collect INTO EXP_ACTION_257_.tbGR_CONFIG_EXPRESSIONId;
   close EXP_ACTION_257_.cuExpression;
END;
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_ACTION_257',1);
EXP_ACTION_257_.blProcessStatus := EXP_PROCESS_100427_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  SELECT  B.object_name
FROM    GE_ACTION_MODULE A, GR_CONFIG_EXPRESSION B
WHERE   A.CONFIG_EXPRESSION_ID = b.CONFIG_EXPRESSION_ID
AND     A.ACTION_ID =257
;
BEGIN

if (not EXP_ACTION_257_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_ACTION_257_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
  nuIndex := nuIndex + 1;
 END LOOP;
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
END;
/

DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE ACTION_ID=257);
BEGIN 

if (not EXP_ACTION_257_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_ACTION_257_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_ACTION_257_.blProcessStatus := false;
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
FROM GE_ACTION_MODULE WHERE ACTION_ID=257;
nuIndex binary_integer;
BEGIN

if (not EXP_ACTION_257_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_ACTION_MODULE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM GE_ACTION_MODULE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_ACTION_257_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_ACTION_257_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_ACTION_257_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_ACTION_257_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_ACTION_257_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_ACTION_257_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_ACTION_257_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_ACTION_257_.blProcessStatus) then
 return;
end if;

EXP_ACTION_257_.tb0_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=EXP_ACTION_257_.tb0_0(0),
MODULE_ID=1,
DESCRIPTION='Ejecuci¿n Acciones de todos los m¿dulos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_EXEACTION_'

 WHERE CONFIGURA_TYPE_ID = EXP_ACTION_257_.tb0_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (EXP_ACTION_257_.tb0_0(0),
1,
'Ejecuci¿n Acciones de todos los m¿dulos'
,
'PL'
,
'FD'
,
'DS'
,
'_EXEACTION_'
);
end if;

exception when others then
EXP_ACTION_257_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_257_.blProcessStatus) then
 return;
end if;

EXP_ACTION_257_.old_tb1_0(0):=121397107;
EXP_ACTION_257_.tb1_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
EXP_ACTION_257_.tb1_0(0):=EXP_ACTION_257_.tb1_0(0);
EXP_ACTION_257_.old_tb1_1(0):='GE_EXEACTION_CT1E121397107'
;
EXP_ACTION_257_.tb1_1(0):=TO_CHAR(EXP_ACTION_257_.tb1_0(0));
EXP_ACTION_257_.tb1_2(0):=EXP_ACTION_257_.tb0_0(0);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (EXP_ACTION_257_.tb1_0(0),
EXP_ACTION_257_.tb1_1(0),
EXP_ACTION_257_.tb1_2(0),
'nuMotiveId = MO_BOINSTANCE_DB.FNUGETMOTIDINSTANCE();nuPackageId = MO_BODATA.FNUGETVALUE("MO_MOTIVE", "PACKAGE_ID", nuMotiveId);nuProductId = MO_BODATA.FNUGETVALUE("MO_MOTIVE", "PRODUCT_ID", nuMotiveId);nuValidaActividad = FNUGETIDACTIVIDAD(nuPackageId);if (nuValidaActividad = 0,DISTRIBUTEDCHARGES(nuProductId,nuPackageId);,)'
,
'LBTEST'
,
to_date('22-08-2012 14:49:00','DD-MM-YYYY HH24:MI:SS'),
to_date('29-03-2023 09:36:41','DD-MM-YYYY HH24:MI:SS'),
to_date('29-03-2023 09:36:41','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Distribuir Cargos'
,
'PP'
,
null);

exception when others then
EXP_ACTION_257_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_257_.blProcessStatus) then
 return;
end if;

EXP_ACTION_257_.tb2_0(0):=257;
EXP_ACTION_257_.tb2_2(0):=EXP_ACTION_257_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ACTION_MODULE fila (0)',1);
UPDATE GE_ACTION_MODULE SET ACTION_ID=EXP_ACTION_257_.tb2_0(0),
MODULE_ID=5,
CONFIG_EXPRESSION_ID=EXP_ACTION_257_.tb2_2(0),
DESCRIPTION='Distribuir Cargos'
,
EXE_AT_STATUS_CHANGE='N'
,
EXE_TRANSITION_STATE='N'

 WHERE ACTION_ID = EXP_ACTION_257_.tb2_0(0);
if not (sql%found) then
INSERT INTO GE_ACTION_MODULE(ACTION_ID,MODULE_ID,CONFIG_EXPRESSION_ID,DESCRIPTION,EXE_AT_STATUS_CHANGE,EXE_TRANSITION_STATE) 
VALUES (EXP_ACTION_257_.tb2_0(0),
5,
EXP_ACTION_257_.tb2_2(0),
'Distribuir Cargos'
,
'N'
,
'N'
);
end if;

exception when others then
EXP_ACTION_257_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_257_.blProcessStatus) then
 return;
end if;

EXP_ACTION_257_.tb3_0(0):=EXP_ACTION_257_.tb2_0(0);
EXP_ACTION_257_.tb3_1(0):=5;
ut_trace.trace('insertando tabla sin fallo: GE_VALID_ACTION_MODU fila (0)',1);
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (EXP_ACTION_257_.tb3_0(0),
EXP_ACTION_257_.tb3_1(0));

exception 
when dup_val_on_index then 
 return;
when others then
EXP_ACTION_257_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_257_.blProcessStatus) then
 return;
end if;

EXP_ACTION_257_.tb3_0(1):=EXP_ACTION_257_.tb2_0(0);
EXP_ACTION_257_.tb3_1(1):=9;
ut_trace.trace('insertando tabla sin fallo: GE_VALID_ACTION_MODU fila (1)',1);
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (EXP_ACTION_257_.tb3_0(1),
EXP_ACTION_257_.tb3_1(1));

exception 
when dup_val_on_index then 
 return;
when others then
EXP_ACTION_257_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
DECLARE 
    nuBinaryIndex Binary_Integer;
BEGIN 
    nuBinaryIndex := EXP_ACTION_257_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = EXP_ACTION_257_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||EXP_ACTION_257_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||EXP_ACTION_257_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := EXP_ACTION_257_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       EXP_ACTION_257_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100427',1);
EXP_PROCESS_100427_.blProcessStatus := EXP_ACTION_257_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
COMMIT
/

DECLARE
PRAGMA AUTONOMOUS_TRANSACTION;
nuRowProcess number;
BEGIN 

if (not EXP_ACTION_257_.blProcessStatus) then
 return;
end if;
nuRowProcess:=EXP_ACTION_257_.tb1_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| EXP_ACTION_257_.tb1_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(EXP_ACTION_257_.tb1_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| EXP_ACTION_257_.tb1_0(nuRowProcess),1);
end;
nuRowProcess := EXP_ACTION_257_.tb1_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
EXP_ACTION_257_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

DECLARE
 nuIndex         binary_integer;
 blObjectDeleted boolean;

 FUNCTION fblIsObjectUseByRule
 (
  isbObjectName   IN gr_config_expression.object_name%type
 ) return BOOLEAN
 IS
  nuCounter    NUMBER := 0;
  blReturn     BOOLEAN := FALSE;
 BEGIN
  SELECT count('x') INTO nuCounter
  FROM gr_config_expression
  WHERE object_name = isbObjectName;
  IF (nuCounter > 0) THEN
    BEGIN
      DELETE FROM gr_config_expression
      WHERE object_name = isbObjectName;
      blReturn := FALSE;
    EXCEPTION
      when ex.RECORD_HAVE_CHILDREN then
         ut_trace.trace('Objeto ' || isbObjectName || ' usado en ' || nuCounter ||' reglas, no se borra',2);
         blReturn := TRUE;
    END;
  END IF;
  RETURN blReturn;
 END;

BEGIN
 ut_trace.trace('Inicia borrado de objetos de reglas',1);
 nuIndex := EXP_ACTION_257_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_ACTION_257_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_ACTION_257_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_ACTION_257_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_ACTION_257_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_ACTION_257_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_ACTION_257_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_ACTION_257_.tbObjectToDelete.next(nuIndex);
 END loop;
 ut_trace.trace('Finaliza borrado de objetos de reglas',1);
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
END;
/


begin
SA_BOCreatePackages.DropPackage('EXP_ACTION_257_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_ACTION_257_******************************'); end;
/


DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  SELECT  B.object_name
FROM    WF_UNIT A, GR_CONFIG_EXPRESSION B
WHERE   (A.PRE_EXPRESSION_ID = b.CONFIG_EXPRESSION_ID
OR   A.POS_EXPRESSION_ID = b.CONFIG_EXPRESSION_ID)
AND     A.UNIT_ID IN (
        SELECT UNIT_ID         FROM WF_UNIT 
        WHERE UNIT_TYPE_ID = 100427
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID IN 
           (SELECT UNIT_ID
           FROM WF_UNIT
           WHERE UNIT_TYPE_ID = 100427
       ))
;
BEGIN

if (not EXP_PROCESS_100427_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_PROCESS_100427_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
  nuIndex := nuIndex + 1;
 END LOOP;
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
END;
/

DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100427) AND NODE_TYPE_ID=0);
BEGIN 

if (not EXP_PROCESS_100427_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_PROCESS_100427_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_PROCESS_100427_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100427) AND NODE_TYPE_ID=0);
BEGIN 

if (not EXP_PROCESS_100427_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_PROCESS_100427_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_PROCESS_100427_.blProcessStatus := false;
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
FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100427) AND NODE_TYPE_ID=0;
nuIndex binary_integer;
BEGIN

if (not EXP_PROCESS_100427_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_PROCESS_100427_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_PROCESS_100427_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_PROCESS_100427_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_PROCESS_100427_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_PROCESS_100427_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_PROCESS_100427_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_PROCESS_100427_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_PROCESS_100427_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_PROCESS_100427_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_PROCESS_100427_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_PROCESS_100427_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_PROCESS_100427_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_PROCESS_100427_.blProcessStatus := false;
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
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100427;
nuIndex binary_integer;
BEGIN

if (not EXP_PROCESS_100427_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_TYPE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_TYPE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_PROCESS_100427_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_PROCESS_100427_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100427_.tb0_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_CATEGORY fila (0)',1);
UPDATE WF_UNIT_CATEGORY SET CATEGORY_ID=EXP_PROCESS_100427_.tb0_0(0),
DISPLAY_NUMBER='Proceso B¿sico'

 WHERE CATEGORY_ID = EXP_PROCESS_100427_.tb0_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_CATEGORY(CATEGORY_ID,DISPLAY_NUMBER) 
VALUES (EXP_PROCESS_100427_.tb0_0(0),
'Proceso B¿sico'
);
end if;

exception when others then
EXP_PROCESS_100427_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100427_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100427_.tb1_0(0):=9;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (0)',1);
UPDATE GE_MODULE SET MODULE_ID=EXP_PROCESS_100427_.tb1_0(0),
DESCRIPTION='WorkFlow'
,
MNEMONIC='WF'
,
LAST_MESSAGE=66,
PATH_MODULE='Workflow'
,
ICON_NAME='mod_admcnf'
,
LOCALIZATION='IN'

 WHERE MODULE_ID = EXP_PROCESS_100427_.tb1_0(0);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (EXP_PROCESS_100427_.tb1_0(0),
'WorkFlow'
,
'WF'
,
66,
'Workflow'
,
'mod_admcnf'
,
'IN'
);
end if;

exception when others then
EXP_PROCESS_100427_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100427_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100427_.tb2_0(0):=100427;
EXP_PROCESS_100427_.tb2_1(0):=EXP_PROCESS_100427_.tb0_0(0);
EXP_PROCESS_100427_.tb2_2(0):=EXP_PROCESS_100427_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (0)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100427_.tb2_0(0),
CATEGORY_ID=EXP_PROCESS_100427_.tb2_1(0),
MODULE_ID=EXP_PROCESS_100427_.tb2_2(0),
ACTION_ID=null,
PARENT_ID=983,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_100427'
,
DESCRIPTION='Proceso de Distribuci¿n de Cargos'
,
DISPLAY='Proceso de Distribuci¿n de Cargos'
,
ICON=null,
IS_STAGE_PROCESS='N'
,
USABLE_IN_FLOW_STAGE='N'
,
ENTITY_ID=null,
MULTI_INSTANCE='R'
,
IS_COUNTABLE='N'
,
NOTIFICATION_ID=null,
VIEWABLE='N'
,
DEFAULT_PRIORITY_ID=null,
INITIAL_NOTIFY_TIME=null,
IS_ADMIN_PROCESS='N'
,
ASSIGN_NOTIFICATION_ID=null,
ASSIGNED_USER_ONLY=null
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100427_.tb2_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100427_.tb2_0(0),
EXP_PROCESS_100427_.tb2_1(0),
EXP_PROCESS_100427_.tb2_2(0),
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_100427'
,
'Proceso de Distribuci¿n de Cargos'
,
'Proceso de Distribuci¿n de Cargos'
,
null,
'N'
,
'N'
,
null,
'R'
,
'N'
,
null,
'N'
,
null,
null,
'N'
,
null,
null);
end if;

exception when others then
EXP_PROCESS_100427_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100427_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100427_.tb3_0(0):=0;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (0)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100427_.tb3_0(0),
DESCRIPTION='Ra¿z'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100427_.tb3_0(0);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100427_.tb3_0(0),
'Ra¿z'
);
end if;

exception when others then
EXP_PROCESS_100427_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100427_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100427_.tb4_0(0):=102301;
EXP_PROCESS_100427_.tb4_2(0):=EXP_PROCESS_100427_.tb2_0(0);
EXP_PROCESS_100427_.tb4_3(0):=EXP_PROCESS_100427_.tb3_0(0);
EXP_PROCESS_100427_.tb4_4(0):=EXP_PROCESS_100427_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (0)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100427_.tb4_0(0),
PROCESS_ID=null,
UNIT_TYPE_ID=EXP_PROCESS_100427_.tb4_2(0),
NODE_TYPE_ID=EXP_PROCESS_100427_.tb4_3(0),
MODULE_ID=EXP_PROCESS_100427_.tb4_4(0),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='20
20'
,
DESCRIPTION='T¿tulo'
,
ONLINE_EXEC_ID=null,
MULTI_INSTANCE='R'
,
SINCRONIC_TIMEOUT=null,
ASINCRONIC_TIMEOUT=null,
FUNCTION_TYPE=null,
IS_COUNTABLE='N'
,
MIN_GROUP_SIZE=null,
EXECUTION_ORDER='A'
,
ANNULATION_ORDER='N'
,
ENTITY_ID=null,
VIEWABLE='N'

 WHERE UNIT_ID = EXP_PROCESS_100427_.tb4_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100427_.tb4_0(0),
null,
EXP_PROCESS_100427_.tb4_2(0),
EXP_PROCESS_100427_.tb4_3(0),
EXP_PROCESS_100427_.tb4_4(0),
null,
null,
null,
null,
'20
20'
,
'T¿tulo'
,
null,
'R'
,
null,
null,
null,
'N'
,
null,
'A'
,
'N'
,
null,
'N'
);
end if;

exception when others then
EXP_PROCESS_100427_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100427_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100427_.tb0_0(1):=2;
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_CATEGORY fila (1)',1);
UPDATE WF_UNIT_CATEGORY SET CATEGORY_ID=EXP_PROCESS_100427_.tb0_0(1),
DISPLAY_NUMBER='Actividad'

 WHERE CATEGORY_ID = EXP_PROCESS_100427_.tb0_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_CATEGORY(CATEGORY_ID,DISPLAY_NUMBER) 
VALUES (EXP_PROCESS_100427_.tb0_0(1),
'Actividad'
);
end if;

exception when others then
EXP_PROCESS_100427_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100427_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100427_.tb2_0(1):=283;
EXP_PROCESS_100427_.tb2_1(1):=EXP_PROCESS_100427_.tb0_0(1);
EXP_PROCESS_100427_.tb2_2(1):=EXP_PROCESS_100427_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (1)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100427_.tb2_0(1),
CATEGORY_ID=EXP_PROCESS_100427_.tb2_1(1),
MODULE_ID=EXP_PROCESS_100427_.tb2_2(1),
ACTION_ID=null,
PARENT_ID=983,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_283'
,
DESCRIPTION='Inicio'
,
DISPLAY='Inicio'
,
ICON='GO.BMP'
,
IS_STAGE_PROCESS='N'
,
USABLE_IN_FLOW_STAGE='N'
,
ENTITY_ID=null,
MULTI_INSTANCE='R'
,
IS_COUNTABLE='N'
,
NOTIFICATION_ID=null,
VIEWABLE='N'
,
DEFAULT_PRIORITY_ID=null,
INITIAL_NOTIFY_TIME=null,
IS_ADMIN_PROCESS='N'
,
ASSIGN_NOTIFICATION_ID=null,
ASSIGNED_USER_ONLY=null
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100427_.tb2_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100427_.tb2_0(1),
EXP_PROCESS_100427_.tb2_1(1),
EXP_PROCESS_100427_.tb2_2(1),
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_283'
,
'Inicio'
,
'Inicio'
,
'GO.BMP'
,
'N'
,
'N'
,
null,
'R'
,
'N'
,
null,
'N'
,
null,
null,
'N'
,
null,
null);
end if;

exception when others then
EXP_PROCESS_100427_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100427_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100427_.tb3_0(1):=1;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (1)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100427_.tb3_0(1),
DESCRIPTION='Arranque'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100427_.tb3_0(1);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100427_.tb3_0(1),
'Arranque'
);
end if;

exception when others then
EXP_PROCESS_100427_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100427_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100427_.tb4_0(1):=102302;
EXP_PROCESS_100427_.tb4_1(1):=EXP_PROCESS_100427_.tb4_0(0);
EXP_PROCESS_100427_.tb4_2(1):=EXP_PROCESS_100427_.tb2_0(1);
EXP_PROCESS_100427_.tb4_3(1):=EXP_PROCESS_100427_.tb3_0(1);
EXP_PROCESS_100427_.tb4_4(1):=EXP_PROCESS_100427_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (1)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100427_.tb4_0(1),
PROCESS_ID=EXP_PROCESS_100427_.tb4_1(1),
UNIT_TYPE_ID=EXP_PROCESS_100427_.tb4_2(1),
NODE_TYPE_ID=EXP_PROCESS_100427_.tb4_3(1),
MODULE_ID=EXP_PROCESS_100427_.tb4_4(1),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='20
184'
,
DESCRIPTION='Inicio'
,
ONLINE_EXEC_ID=null,
MULTI_INSTANCE='R'
,
SINCRONIC_TIMEOUT=null,
ASINCRONIC_TIMEOUT=null,
FUNCTION_TYPE=null,
IS_COUNTABLE='N'
,
MIN_GROUP_SIZE=null,
EXECUTION_ORDER='A'
,
ANNULATION_ORDER='N'
,
ENTITY_ID=8,
VIEWABLE='Y'

 WHERE UNIT_ID = EXP_PROCESS_100427_.tb4_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100427_.tb4_0(1),
EXP_PROCESS_100427_.tb4_1(1),
EXP_PROCESS_100427_.tb4_2(1),
EXP_PROCESS_100427_.tb4_3(1),
EXP_PROCESS_100427_.tb4_4(1),
null,
null,
null,
null,
'20
184'
,
'Inicio'
,
null,
'R'
,
null,
null,
null,
'N'
,
null,
'A'
,
'N'
,
8,
'Y'
);
end if;

exception when others then
EXP_PROCESS_100427_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100427_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100427_.tb2_0(2):=252;
EXP_PROCESS_100427_.tb2_1(2):=EXP_PROCESS_100427_.tb0_0(1);
EXP_PROCESS_100427_.tb2_2(2):=EXP_PROCESS_100427_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (2)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100427_.tb2_0(2),
CATEGORY_ID=EXP_PROCESS_100427_.tb2_1(2),
MODULE_ID=EXP_PROCESS_100427_.tb2_2(2),
ACTION_ID=null,
PARENT_ID=983,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_252'
,
DESCRIPTION='Fin'
,
DISPLAY='Fin'
,
ICON='STOP.BMP'
,
IS_STAGE_PROCESS='N'
,
USABLE_IN_FLOW_STAGE='N'
,
ENTITY_ID=null,
MULTI_INSTANCE='N'
,
IS_COUNTABLE='N'
,
NOTIFICATION_ID=null,
VIEWABLE='N'
,
DEFAULT_PRIORITY_ID=null,
INITIAL_NOTIFY_TIME=null,
IS_ADMIN_PROCESS='N'
,
ASSIGN_NOTIFICATION_ID=null,
ASSIGNED_USER_ONLY=null
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100427_.tb2_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100427_.tb2_0(2),
EXP_PROCESS_100427_.tb2_1(2),
EXP_PROCESS_100427_.tb2_2(2),
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_252'
,
'Fin'
,
'Fin'
,
'STOP.BMP'
,
'N'
,
'N'
,
null,
'N'
,
'N'
,
null,
'N'
,
null,
null,
'N'
,
null,
null);
end if;

exception when others then
EXP_PROCESS_100427_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100427_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100427_.tb3_0(2):=3;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (2)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100427_.tb3_0(2),
DESCRIPTION='Final'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100427_.tb3_0(2);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100427_.tb3_0(2),
'Final'
);
end if;

exception when others then
EXP_PROCESS_100427_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100427_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100427_.tb4_0(2):=102303;
EXP_PROCESS_100427_.tb4_1(2):=EXP_PROCESS_100427_.tb4_0(0);
EXP_PROCESS_100427_.tb4_2(2):=EXP_PROCESS_100427_.tb2_0(2);
EXP_PROCESS_100427_.tb4_3(2):=EXP_PROCESS_100427_.tb3_0(2);
EXP_PROCESS_100427_.tb4_4(2):=EXP_PROCESS_100427_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (2)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100427_.tb4_0(2),
PROCESS_ID=EXP_PROCESS_100427_.tb4_1(2),
UNIT_TYPE_ID=EXP_PROCESS_100427_.tb4_2(2),
NODE_TYPE_ID=EXP_PROCESS_100427_.tb4_3(2),
MODULE_ID=EXP_PROCESS_100427_.tb4_4(2),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='527
184'
,
DESCRIPTION='Fin'
,
ONLINE_EXEC_ID=null,
MULTI_INSTANCE='R'
,
SINCRONIC_TIMEOUT=null,
ASINCRONIC_TIMEOUT=null,
FUNCTION_TYPE=null,
IS_COUNTABLE='N'
,
MIN_GROUP_SIZE=null,
EXECUTION_ORDER='A'
,
ANNULATION_ORDER='N'
,
ENTITY_ID=null,
VIEWABLE='N'

 WHERE UNIT_ID = EXP_PROCESS_100427_.tb4_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100427_.tb4_0(2),
EXP_PROCESS_100427_.tb4_1(2),
EXP_PROCESS_100427_.tb4_2(2),
EXP_PROCESS_100427_.tb4_3(2),
EXP_PROCESS_100427_.tb4_4(2),
null,
null,
null,
null,
'527
184'
,
'Fin'
,
null,
'R'
,
null,
null,
null,
'N'
,
null,
'A'
,
'N'
,
null,
'N'
);
end if;

exception when others then
EXP_PROCESS_100427_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100427_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100427_.tb5_0(0):=100000248;
EXP_PROCESS_100427_.tb5_1(0):=EXP_PROCESS_100427_.tb4_0(1);
EXP_PROCESS_100427_.tb5_2(0):=EXP_PROCESS_100427_.tb4_0(2);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (0)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100427_.tb5_0(0),
ORIGIN_ID=EXP_PROCESS_100427_.tb5_1(0),
TARGET_ID=EXP_PROCESS_100427_.tb5_2(0),
GEOMETRY='65
303
564
302'
,
GROUP_ID=0,
EXPRESSION='FLAG_VALIDATE == NO'
,
EXPRESSION_TYPE=0,
DESCRIPTION='No Distribuye Cargos'
,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100427_.tb5_0(0);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100427_.tb5_0(0),
EXP_PROCESS_100427_.tb5_1(0),
EXP_PROCESS_100427_.tb5_2(0),
'65
303
564
302'
,
0,
'FLAG_VALIDATE == NO'
,
0,
'No Distribuye Cargos'
,
1);
end if;

exception when others then
EXP_PROCESS_100427_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100427_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100427_.tb1_0(1):=5;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (1)',1);
UPDATE GE_MODULE SET MODULE_ID=EXP_PROCESS_100427_.tb1_0(1),
DESCRIPTION='GESTI¿N DE MOTIVOS'
,
MNEMONIC='MO'
,
LAST_MESSAGE=136,
PATH_MODULE='Motives_Management'
,
ICON_NAME='mod_motivos'
,
LOCALIZATION='IN'

 WHERE MODULE_ID = EXP_PROCESS_100427_.tb1_0(1);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (EXP_PROCESS_100427_.tb1_0(1),
'GESTI¿N DE MOTIVOS'
,
'MO'
,
136,
'Motives_Management'
,
'mod_motivos'
,
'IN'
);
end if;

exception when others then
EXP_PROCESS_100427_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100427_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100427_.tb2_0(3):=313;
EXP_PROCESS_100427_.tb2_1(3):=EXP_PROCESS_100427_.tb0_0(1);
EXP_PROCESS_100427_.tb2_2(3):=EXP_PROCESS_100427_.tb1_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (3)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100427_.tb2_0(3),
CATEGORY_ID=EXP_PROCESS_100427_.tb2_1(3),
MODULE_ID=EXP_PROCESS_100427_.tb2_2(3),
ACTION_ID=null,
PARENT_ID=983,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_313'
,
DESCRIPTION='Distribuir Cargos'
,
DISPLAY='Distribuir Cargos'
,
ICON=null,
IS_STAGE_PROCESS='N'
,
USABLE_IN_FLOW_STAGE='N'
,
ENTITY_ID=8,
MULTI_INSTANCE='R'
,
IS_COUNTABLE='Y'
,
NOTIFICATION_ID=9000,
VIEWABLE='Y'
,
DEFAULT_PRIORITY_ID=null,
INITIAL_NOTIFY_TIME=null,
IS_ADMIN_PROCESS='N'
,
ASSIGN_NOTIFICATION_ID=null,
ASSIGNED_USER_ONLY=null
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100427_.tb2_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100427_.tb2_0(3),
EXP_PROCESS_100427_.tb2_1(3),
EXP_PROCESS_100427_.tb2_2(3),
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_313'
,
'Distribuir Cargos'
,
'Distribuir Cargos'
,
null,
'N'
,
'N'
,
8,
'R'
,
'Y'
,
9000,
'Y'
,
null,
null,
'N'
,
null,
null);
end if;

exception when others then
EXP_PROCESS_100427_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100427_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100427_.tb3_0(3):=2;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (3)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100427_.tb3_0(3),
DESCRIPTION='Normal'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100427_.tb3_0(3);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100427_.tb3_0(3),
'Normal'
);
end if;

exception when others then
EXP_PROCESS_100427_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100427_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100427_.tb4_0(3):=102304;
EXP_PROCESS_100427_.tb4_1(3):=EXP_PROCESS_100427_.tb4_0(0);
EXP_PROCESS_100427_.tb4_2(3):=EXP_PROCESS_100427_.tb2_0(3);
EXP_PROCESS_100427_.tb4_3(3):=EXP_PROCESS_100427_.tb3_0(3);
EXP_PROCESS_100427_.tb4_4(3):=EXP_PROCESS_100427_.tb1_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (3)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100427_.tb4_0(3),
PROCESS_ID=EXP_PROCESS_100427_.tb4_1(3),
UNIT_TYPE_ID=EXP_PROCESS_100427_.tb4_2(3),
NODE_TYPE_ID=EXP_PROCESS_100427_.tb4_3(3),
MODULE_ID=EXP_PROCESS_100427_.tb4_4(3),
ACTION_ID=257,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=9000,
GEOMETRY='253
177'
,
DESCRIPTION='Distribuir Cargos'
,
ONLINE_EXEC_ID=null,
MULTI_INSTANCE='R'
,
SINCRONIC_TIMEOUT=null,
ASINCRONIC_TIMEOUT=null,
FUNCTION_TYPE=null,
IS_COUNTABLE='N'
,
MIN_GROUP_SIZE=null,
EXECUTION_ORDER='A'
,
ANNULATION_ORDER='N'
,
ENTITY_ID=8,
VIEWABLE='N'

 WHERE UNIT_ID = EXP_PROCESS_100427_.tb4_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100427_.tb4_0(3),
EXP_PROCESS_100427_.tb4_1(3),
EXP_PROCESS_100427_.tb4_2(3),
EXP_PROCESS_100427_.tb4_3(3),
EXP_PROCESS_100427_.tb4_4(3),
257,
null,
null,
9000,
'253
177'
,
'Distribuir Cargos'
,
null,
'R'
,
null,
null,
null,
'N'
,
null,
'A'
,
'N'
,
8,
'N'
);
end if;

exception when others then
EXP_PROCESS_100427_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100427_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100427_.tb5_0(1):=100000247;
EXP_PROCESS_100427_.tb5_1(1):=EXP_PROCESS_100427_.tb4_0(1);
EXP_PROCESS_100427_.tb5_2(1):=EXP_PROCESS_100427_.tb4_0(3);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (1)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100427_.tb5_0(1),
ORIGIN_ID=EXP_PROCESS_100427_.tb5_1(1),
TARGET_ID=EXP_PROCESS_100427_.tb5_2(1),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION='FLAG_VALIDATE == SI'
,
EXPRESSION_TYPE=0,
DESCRIPTION='Distribuye Cargos'
,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100427_.tb5_0(1);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100427_.tb5_0(1),
EXP_PROCESS_100427_.tb5_1(1),
EXP_PROCESS_100427_.tb5_2(1),
null,
0,
'FLAG_VALIDATE == SI'
,
0,
'Distribuye Cargos'
,
1);
end if;

exception when others then
EXP_PROCESS_100427_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100427_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100427_.tb6_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTE_CLASS fila (0)',1);
UPDATE GE_ATTRIBUTE_CLASS SET ATTRIBUTE_CLASS_ID=EXP_PROCESS_100427_.tb6_0(0),
NAME='De Entitdad'
,
DESCRIPTION='Valores que ser¿n tra¿dos de la tabla base usando old record'

 WHERE ATTRIBUTE_CLASS_ID = EXP_PROCESS_100427_.tb6_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTE_CLASS(ATTRIBUTE_CLASS_ID,NAME,DESCRIPTION) 
VALUES (EXP_PROCESS_100427_.tb6_0(0),
'De Entitdad'
,
'Valores que ser¿n tra¿dos de la tabla base usando old record'
);
end if;

exception when others then
EXP_PROCESS_100427_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100427_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100427_.tb7_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES_TYPE fila (0)',1);
UPDATE GE_ATTRIBUTES_TYPE SET ATTRIBUTE_TYPE_ID=EXP_PROCESS_100427_.tb7_0(0),
DESCRIPTION='NUMBER'
,
INTERNAL_TYPE=2,
INTERNAL_JAVA_TYPE=2
 WHERE ATTRIBUTE_TYPE_ID = EXP_PROCESS_100427_.tb7_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES_TYPE(ATTRIBUTE_TYPE_ID,DESCRIPTION,INTERNAL_TYPE,INTERNAL_JAVA_TYPE) 
VALUES (EXP_PROCESS_100427_.tb7_0(0),
'NUMBER'
,
2,
2);
end if;

exception when others then
EXP_PROCESS_100427_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100427_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100427_.tb8_0(0):=400;
EXP_PROCESS_100427_.tb8_1(0):=EXP_PROCESS_100427_.tb6_0(0);
EXP_PROCESS_100427_.tb8_2(0):=EXP_PROCESS_100427_.tb7_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (0)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=EXP_PROCESS_100427_.tb8_0(0),
ATTRIBUTE_CLASS_ID=EXP_PROCESS_100427_.tb8_1(0),
ATTRIBUTE_TYPE_ID=EXP_PROCESS_100427_.tb8_2(0),
VALID_EXPRESSION=null,
FATHER_ID=null,
MODULE_ID=9,
NAME_ATTRIBUTE='CAUSAL'
,
LENGTH=4,
PRECISION=null,
SCALE=null,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE='T'
,
COMMENT_='Causal'
,
DISPLAY_NAME='Causal'

 WHERE ATTRIBUTE_ID = EXP_PROCESS_100427_.tb8_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,ATTRIBUTE_CLASS_ID,ATTRIBUTE_TYPE_ID,VALID_EXPRESSION,FATHER_ID,MODULE_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (EXP_PROCESS_100427_.tb8_0(0),
EXP_PROCESS_100427_.tb8_1(0),
EXP_PROCESS_100427_.tb8_2(0),
null,
null,
9,
'CAUSAL'
,
4,
null,
null,
null,
'T'
,
'Causal'
,
'Causal'
);
end if;

exception when others then
EXP_PROCESS_100427_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100427_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100427_.tb9_0(0):=100000270;
EXP_PROCESS_100427_.tb9_1(0):=EXP_PROCESS_100427_.tb4_0(1);
EXP_PROCESS_100427_.tb9_2(0):=EXP_PROCESS_100427_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (0)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100427_.tb9_0(0),
UNIT_ID=EXP_PROCESS_100427_.tb9_1(0),
ATTRIBUTE_ID=EXP_PROCESS_100427_.tb9_2(0),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100427_.tb9_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100427_.tb9_0(0),
EXP_PROCESS_100427_.tb9_1(0),
EXP_PROCESS_100427_.tb9_2(0),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_100427_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100427_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100427_.tb6_0(1):=8;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTE_CLASS fila (1)',1);
UPDATE GE_ATTRIBUTE_CLASS SET ATTRIBUTE_CLASS_ID=EXP_PROCESS_100427_.tb6_0(1),
NAME='Por Defecto General'
,
DESCRIPTION='Valores que ser¿n utilizados para clasificaci¿n gen¿rica'

 WHERE ATTRIBUTE_CLASS_ID = EXP_PROCESS_100427_.tb6_0(1);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTE_CLASS(ATTRIBUTE_CLASS_ID,NAME,DESCRIPTION) 
VALUES (EXP_PROCESS_100427_.tb6_0(1),
'Por Defecto General'
,
'Valores que ser¿n utilizados para clasificaci¿n gen¿rica'
);
end if;

exception when others then
EXP_PROCESS_100427_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100427_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100427_.tb8_0(1):=442;
EXP_PROCESS_100427_.tb8_1(1):=EXP_PROCESS_100427_.tb6_0(1);
EXP_PROCESS_100427_.tb8_2(1):=EXP_PROCESS_100427_.tb7_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (1)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=EXP_PROCESS_100427_.tb8_0(1),
ATTRIBUTE_CLASS_ID=EXP_PROCESS_100427_.tb8_1(1),
ATTRIBUTE_TYPE_ID=EXP_PROCESS_100427_.tb8_2(1),
VALID_EXPRESSION=null,
FATHER_ID=null,
MODULE_ID=9,
NAME_ATTRIBUTE='FLAG_VALIDATE'
,
LENGTH=null,
PRECISION=null,
SCALE=null,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE=null,
COMMENT_='Bandera de validaci¿n'
,
DISPLAY_NAME='Bandera de validaci¿n para la ejecuci¿n de transicciones'

 WHERE ATTRIBUTE_ID = EXP_PROCESS_100427_.tb8_0(1);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,ATTRIBUTE_CLASS_ID,ATTRIBUTE_TYPE_ID,VALID_EXPRESSION,FATHER_ID,MODULE_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (EXP_PROCESS_100427_.tb8_0(1),
EXP_PROCESS_100427_.tb8_1(1),
EXP_PROCESS_100427_.tb8_2(1),
null,
null,
9,
'FLAG_VALIDATE'
,
null,
null,
null,
null,
null,
'Bandera de validaci¿n'
,
'Bandera de validaci¿n para la ejecuci¿n de transicciones'
);
end if;

exception when others then
EXP_PROCESS_100427_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100427_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100427_.old_tb10_0(0):=120195454;
EXP_PROCESS_100427_.tb10_0(0):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
EXP_PROCESS_100427_.tb10_0(0):=EXP_PROCESS_100427_.tb10_0(0);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (0)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (EXP_PROCESS_100427_.tb10_0(0),
16,
'Distribuci¿n de Cargos'
,
'SELECT decode((case when AB_BOAddress.fsbIsbaseAddress(d.address_id) = '|| chr(39) ||'Y'|| chr(39) ||' then nvl(c.COLLECT_DISTRIBUTE,'|| chr(39) ||'N'|| chr(39) ||') else '|| chr(39) ||'N'|| chr(39) ||' end),'|| chr(39) ||'N'|| chr(39) ||',0,1) FLAG_VALIDATE
FROM mo_packages A, mo_motive B, pr_product C, ab_address D
WHERE b.motive_id = :INST.EXTERNAL_ID:
AND A.package_id = b.package_id
AND b.product_id = c.product_id
AND c.address_id = d.address_id'
,
'Distribuci¿n de Cargos'
);

exception when others then
EXP_PROCESS_100427_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100427_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100427_.tb9_0(1):=100000271;
EXP_PROCESS_100427_.tb9_1(1):=EXP_PROCESS_100427_.tb4_0(1);
EXP_PROCESS_100427_.tb9_2(1):=EXP_PROCESS_100427_.tb8_0(1);
EXP_PROCESS_100427_.tb9_3(1):=EXP_PROCESS_100427_.tb10_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (1)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100427_.tb9_0(1),
UNIT_ID=EXP_PROCESS_100427_.tb9_1(1),
ATTRIBUTE_ID=EXP_PROCESS_100427_.tb9_2(1),
STATEMENT_ID=EXP_PROCESS_100427_.tb9_3(1),
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='Y'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100427_.tb9_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100427_.tb9_0(1),
EXP_PROCESS_100427_.tb9_1(1),
EXP_PROCESS_100427_.tb9_2(1),
EXP_PROCESS_100427_.tb9_3(1),
null,
'N'
,
2,
'Y'
);
end if;

exception when others then
EXP_PROCESS_100427_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100427_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100427_.tb5_0(2):=100000249;
EXP_PROCESS_100427_.tb5_1(2):=EXP_PROCESS_100427_.tb4_0(3);
EXP_PROCESS_100427_.tb5_2(2):=EXP_PROCESS_100427_.tb4_0(2);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (2)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100427_.tb5_0(2),
ORIGIN_ID=EXP_PROCESS_100427_.tb5_1(2),
TARGET_ID=EXP_PROCESS_100427_.tb5_2(2),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION=null,
EXPRESSION_TYPE=0,
DESCRIPTION=null,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100427_.tb5_0(2);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100427_.tb5_0(2),
EXP_PROCESS_100427_.tb5_1(2),
EXP_PROCESS_100427_.tb5_2(2),
null,
0,
null,
0,
null,
1);
end if;

exception when others then
EXP_PROCESS_100427_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100427_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100427_.tb9_0(3):=100000272;
EXP_PROCESS_100427_.tb9_1(3):=EXP_PROCESS_100427_.tb4_0(2);
EXP_PROCESS_100427_.tb9_2(3):=EXP_PROCESS_100427_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (3)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100427_.tb9_0(3),
UNIT_ID=EXP_PROCESS_100427_.tb9_1(3),
ATTRIBUTE_ID=EXP_PROCESS_100427_.tb9_2(3),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100427_.tb9_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100427_.tb9_0(3),
EXP_PROCESS_100427_.tb9_1(3),
EXP_PROCESS_100427_.tb9_2(3),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_100427_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100427_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100427_.tb9_0(4):=100000273;
EXP_PROCESS_100427_.tb9_1(4):=EXP_PROCESS_100427_.tb4_0(2);
EXP_PROCESS_100427_.tb9_2(4):=EXP_PROCESS_100427_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (4)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100427_.tb9_0(4),
UNIT_ID=EXP_PROCESS_100427_.tb9_1(4),
ATTRIBUTE_ID=EXP_PROCESS_100427_.tb9_2(4),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100427_.tb9_0(4);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100427_.tb9_0(4),
EXP_PROCESS_100427_.tb9_1(4),
EXP_PROCESS_100427_.tb9_2(4),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_100427_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100427_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100427_.tb9_0(2):=100000279;
EXP_PROCESS_100427_.tb9_1(2):=EXP_PROCESS_100427_.tb4_0(3);
EXP_PROCESS_100427_.tb9_2(2):=EXP_PROCESS_100427_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (2)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100427_.tb9_0(2),
UNIT_ID=EXP_PROCESS_100427_.tb9_1(2),
ATTRIBUTE_ID=EXP_PROCESS_100427_.tb9_2(2),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=1,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100427_.tb9_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100427_.tb9_0(2),
EXP_PROCESS_100427_.tb9_1(2),
EXP_PROCESS_100427_.tb9_2(2),
null,
null,
'N'
,
1,
'N'
);
end if;

exception when others then
EXP_PROCESS_100427_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_UNITTYPE_313_',
'CREATE OR REPLACE PACKAGE EXP_UNITTYPE_313_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyWF_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPERowId tyWF_UNIT_TYPERowId;type tyWF_CAUSAL_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_CAUSAL_UNIT_TYPERowId tyWF_CAUSAL_UNIT_TYPERowId;type tyGR_CONFIGURA_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIGURA_TYPERowId tyGR_CONFIGURA_TYPERowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type tyGE_ATTRIBUTE_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTE_CLASSRowId tyGE_ATTRIBUTE_CLASSRowId;type tyGE_ATTRIBUTES_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTES_TYPERowId tyGE_ATTRIBUTES_TYPERowId;type tyGE_ATTRIBUTESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTESRowId tyGE_ATTRIBUTESRowId;type tyGE_STATEMENTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_STATEMENTRowId tyGE_STATEMENTRowId;type tyWF_UNIT_TYPE_ATTRIBRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPE_ATTRIBRowId tyWF_UNIT_TYPE_ATTRIBRowId;type tyMO_TIME_UNI_TYP_PRIORowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbMO_TIME_UNI_TYP_PRIORowId tyMO_TIME_UNI_TYP_PRIORowId;type tyOR_ACT_BY_TASK_MODRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbOR_ACT_BY_TASK_MODRowId tyOR_ACT_BY_TASK_MODRowId;type ty0_0 is table of WF_UNIT_TYPE.UNIT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_5 is table of WF_UNIT_TYPE.INIT_AREA_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_5 ty0_5; ' || chr(10) ||
'tb0_5 ty0_5;type ty1_0 is table of GE_ATTRIBUTE_CLASS.ATTRIBUTE_CLASS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_0 ty1_0; ' || chr(10) ||
'tb1_0 ty1_0;type ty2_0 is table of GE_ATTRIBUTES_TYPE.ATTRIBUTE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;type ty3_0 is table of GE_ATTRIBUTES.ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_0 ty3_0; ' || chr(10) ||
'tb3_0 ty3_0;type ty3_1 is table of GE_ATTRIBUTES.ATTRIBUTE_CLASS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_1 ty3_1; ' || chr(10) ||
'tb3_1 ty3_1;type ty3_2 is table of GE_ATTRIBUTES.ATTRIBUTE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_2 ty3_2; ' || chr(10) ||
'tb3_2 ty3_2;type ty3_3 is table of GE_ATTRIBUTES.VALID_EXPRESSION%type index by binary_integer; ' || chr(10) ||
'old_tb3_3 ty3_3; ' || chr(10) ||
'tb3_3 ty3_3;type ty4_0 is table of WF_UNIT_TYPE_ATTRIB.UNIT_TYPE_ATTRIB_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_0 ty4_0; ' || chr(10) ||
'tb4_0 ty4_0;type ty4_1 is table of WF_UNIT_TYPE_ATTRIB.UNIT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_1 ty4_1; ' || chr(10) ||
'tb4_1 ty4_1;type ty4_2 is table of WF_UNIT_TYPE_ATTRIB.ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_2 ty4_2; ' || chr(10) ||
'tb4_2 ty4_2;type ty4_3 is table of WF_UNIT_TYPE_ATTRIB.STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_3 ty4_3; ' || chr(10) ||
'tb4_3 ty4_3; ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_UNITTYPE_313_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_UNITTYPE_313_******************************'); END;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_UNITTYPE_313',1);
EXP_UNITTYPE_313_.blProcessStatus := EXP_PROCESS_100427_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  SELECT  B.object_name
FROM    OR_ACT_BY_TASK_MOD A, GR_CONFIG_EXPRESSION B 
WHERE   A.CONFIG_EXPRESSION_ID = B.CONFIG_EXPRESSION_ID
AND     A.TASK_CODE = 313
 
;
BEGIN

if (not EXP_UNITTYPE_313_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_UNITTYPE_313_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
  nuIndex := nuIndex + 1;
 END LOOP;
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
END;
/

declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_TYPE_ATTRIB WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=313);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_313_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_TYPE_ATTRIB',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_TYPE_ATTRIB WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_313_.blProcessStatus := false;
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
FROM WF_CAUSAL_UNIT_TYPE WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=313);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_313_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_CAUSAL_UNIT_TYPE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_CAUSAL_UNIT_TYPE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_313_.blProcessStatus := false;
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
FROM MO_TIME_UNI_TYP_PRIO WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=313);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_313_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla MO_TIME_UNI_TYP_PRIO',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM MO_TIME_UNI_TYP_PRIO WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_313_.blProcessStatus := false;
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
FROM OR_ACT_BY_TASK_MOD WHERE (TASK_CODE) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=313);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_313_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla OR_ACT_BY_TASK_MOD',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM OR_ACT_BY_TASK_MOD WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_313_.blProcessStatus := false;
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
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=313;
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_313_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_TYPE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_TYPE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_313_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_UNITTYPE_313_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_313_.tb0_0(0):=313;
ut_trace.trace('insertando tabla sin fallo: WF_UNIT_TYPE fila (0)',1);
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_UNITTYPE_313_.tb0_0(0),
2,
5,
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_313'
,
'Distribuir Cargos'
,
'Distribuir Cargos'
,
null,
'N'
,
'N'
,
8,
'R'
,
'Y'
,
9000,
'Y'
,
null,
null,
'N'
,
null,
null);

exception 
when dup_val_on_index then 
 return;
when others then
EXP_UNITTYPE_313_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_313_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_313_.tb1_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTE_CLASS fila (0)',1);
UPDATE GE_ATTRIBUTE_CLASS SET ATTRIBUTE_CLASS_ID=EXP_UNITTYPE_313_.tb1_0(0),
NAME='De Entitdad'
,
DESCRIPTION='Valores que ser¿n tra¿dos de la tabla base usando old record'

 WHERE ATTRIBUTE_CLASS_ID = EXP_UNITTYPE_313_.tb1_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTE_CLASS(ATTRIBUTE_CLASS_ID,NAME,DESCRIPTION) 
VALUES (EXP_UNITTYPE_313_.tb1_0(0),
'De Entitdad'
,
'Valores que ser¿n tra¿dos de la tabla base usando old record'
);
end if;

exception when others then
EXP_UNITTYPE_313_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_313_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_313_.tb2_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES_TYPE fila (0)',1);
UPDATE GE_ATTRIBUTES_TYPE SET ATTRIBUTE_TYPE_ID=EXP_UNITTYPE_313_.tb2_0(0),
DESCRIPTION='NUMBER'
,
INTERNAL_TYPE=2,
INTERNAL_JAVA_TYPE=2
 WHERE ATTRIBUTE_TYPE_ID = EXP_UNITTYPE_313_.tb2_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES_TYPE(ATTRIBUTE_TYPE_ID,DESCRIPTION,INTERNAL_TYPE,INTERNAL_JAVA_TYPE) 
VALUES (EXP_UNITTYPE_313_.tb2_0(0),
'NUMBER'
,
2,
2);
end if;

exception when others then
EXP_UNITTYPE_313_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_313_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_313_.tb3_0(0):=400;
EXP_UNITTYPE_313_.tb3_1(0):=EXP_UNITTYPE_313_.tb1_0(0);
EXP_UNITTYPE_313_.tb3_2(0):=EXP_UNITTYPE_313_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (0)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=EXP_UNITTYPE_313_.tb3_0(0),
ATTRIBUTE_CLASS_ID=EXP_UNITTYPE_313_.tb3_1(0),
ATTRIBUTE_TYPE_ID=EXP_UNITTYPE_313_.tb3_2(0),
VALID_EXPRESSION=null,
FATHER_ID=null,
MODULE_ID=9,
NAME_ATTRIBUTE='CAUSAL'
,
LENGTH=4,
PRECISION=null,
SCALE=null,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE='T'
,
COMMENT_='Causal'
,
DISPLAY_NAME='Causal'

 WHERE ATTRIBUTE_ID = EXP_UNITTYPE_313_.tb3_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,ATTRIBUTE_CLASS_ID,ATTRIBUTE_TYPE_ID,VALID_EXPRESSION,FATHER_ID,MODULE_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (EXP_UNITTYPE_313_.tb3_0(0),
EXP_UNITTYPE_313_.tb3_1(0),
EXP_UNITTYPE_313_.tb3_2(0),
null,
null,
9,
'CAUSAL'
,
4,
null,
null,
null,
'T'
,
'Causal'
,
'Causal'
);
end if;

exception when others then
EXP_UNITTYPE_313_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_313_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_313_.tb4_0(0):=109102;
EXP_UNITTYPE_313_.tb4_1(0):=EXP_UNITTYPE_313_.tb0_0(0);
EXP_UNITTYPE_313_.tb4_2(0):=EXP_UNITTYPE_313_.tb3_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE_ATTRIB fila (0)',1);
UPDATE WF_UNIT_TYPE_ATTRIB SET UNIT_TYPE_ATTRIB_ID=EXP_UNITTYPE_313_.tb4_0(0),
UNIT_TYPE_ID=EXP_UNITTYPE_313_.tb4_1(0),
ATTRIBUTE_ID=EXP_UNITTYPE_313_.tb4_2(0),
STATEMENT_ID=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='Y'

 WHERE UNIT_TYPE_ATTRIB_ID = EXP_UNITTYPE_313_.tb4_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE_ATTRIB(UNIT_TYPE_ATTRIB_ID,UNIT_TYPE_ID,ATTRIBUTE_ID,STATEMENT_ID,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_UNITTYPE_313_.tb4_0(0),
EXP_UNITTYPE_313_.tb4_1(0),
EXP_UNITTYPE_313_.tb4_2(0),
null,
'N'
,
2,
'Y'
);
end if;

exception when others then
EXP_UNITTYPE_313_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100427',1);
EXP_PROCESS_100427_.blProcessStatus := EXP_UNITTYPE_313_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/

DECLARE
 nuIndex         binary_integer;
 blObjectDeleted boolean;

 FUNCTION fblIsObjectUseByRule
 (
  isbObjectName   IN gr_config_expression.object_name%type
 ) return BOOLEAN
 IS
  nuCounter    NUMBER := 0;
  blReturn     BOOLEAN := FALSE;
 BEGIN
  SELECT count('x') INTO nuCounter
  FROM gr_config_expression
  WHERE object_name = isbObjectName;
  IF (nuCounter > 0) THEN
    BEGIN
      DELETE FROM gr_config_expression
      WHERE object_name = isbObjectName;
      blReturn := FALSE;
    EXCEPTION
      when ex.RECORD_HAVE_CHILDREN then
         ut_trace.trace('Objeto ' || isbObjectName || ' usado en ' || nuCounter ||' reglas, no se borra',2);
         blReturn := TRUE;
    END;
  END IF;
  RETURN blReturn;
 END;

BEGIN
 ut_trace.trace('Inicia borrado de objetos de reglas',1);
 nuIndex := EXP_UNITTYPE_313_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_UNITTYPE_313_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_UNITTYPE_313_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_UNITTYPE_313_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_UNITTYPE_313_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_UNITTYPE_313_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_UNITTYPE_313_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_UNITTYPE_313_.tbObjectToDelete.next(nuIndex);
 END loop;
 ut_trace.trace('Finaliza borrado de objetos de reglas',1);
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('EXP_UNITTYPE_313_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_UNITTYPE_313_******************************'); end;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100588',1);
EXP_PROCESS_100588_.blProcessStatus := EXP_PROCESS_100427_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
DECLARE 
    nuBinaryIndex Binary_Integer;
BEGIN 
    nuBinaryIndex := EXP_PROCESS_100427_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = EXP_PROCESS_100427_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||EXP_PROCESS_100427_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||EXP_PROCESS_100427_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := EXP_PROCESS_100427_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       EXP_PROCESS_100427_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 


DECLARE
 nuIndex         binary_integer;
 blObjectDeleted boolean;

 FUNCTION fblIsObjectUseByRule
 (
  isbObjectName   IN gr_config_expression.object_name%type
 ) return BOOLEAN
 IS
  nuCounter    NUMBER := 0;
  blReturn     BOOLEAN := FALSE;
 BEGIN
  SELECT count('x') INTO nuCounter
  FROM gr_config_expression
  WHERE object_name = isbObjectName;
  IF (nuCounter > 0) THEN
    BEGIN
      DELETE FROM gr_config_expression
      WHERE object_name = isbObjectName;
      blReturn := FALSE;
    EXCEPTION
      when ex.RECORD_HAVE_CHILDREN then
         ut_trace.trace('Objeto ' || isbObjectName || ' usado en ' || nuCounter ||' reglas, no se borra',2);
         blReturn := TRUE;
    END;
  END IF;
  RETURN blReturn;
 END;

BEGIN
 ut_trace.trace('Inicia borrado de objetos de reglas',1);
 nuIndex := EXP_PROCESS_100427_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_PROCESS_100427_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_PROCESS_100427_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_PROCESS_100427_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_PROCESS_100427_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_PROCESS_100427_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_PROCESS_100427_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_PROCESS_100427_.tbObjectToDelete.next(nuIndex);
 END loop;
 ut_trace.trace('Finaliza borrado de objetos de reglas',1);
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('EXP_PROCESS_100427_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_PROCESS_100427_******************************'); end;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100559',1);
EXP_PROCESS_100559_.blProcessStatus := EXP_PROCESS_100588_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
DECLARE 
    nuBinaryIndex Binary_Integer;
BEGIN 
    nuBinaryIndex := EXP_PROCESS_100588_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = EXP_PROCESS_100588_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||EXP_PROCESS_100588_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||EXP_PROCESS_100588_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := EXP_PROCESS_100588_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       EXP_PROCESS_100588_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 


DECLARE
 nuIndex         binary_integer;
 blObjectDeleted boolean;

 FUNCTION fblIsObjectUseByRule
 (
  isbObjectName   IN gr_config_expression.object_name%type
 ) return BOOLEAN
 IS
  nuCounter    NUMBER := 0;
  blReturn     BOOLEAN := FALSE;
 BEGIN
  SELECT count('x') INTO nuCounter
  FROM gr_config_expression
  WHERE object_name = isbObjectName;
  IF (nuCounter > 0) THEN
    BEGIN
      DELETE FROM gr_config_expression
      WHERE object_name = isbObjectName;
      blReturn := FALSE;
    EXCEPTION
      when ex.RECORD_HAVE_CHILDREN then
         ut_trace.trace('Objeto ' || isbObjectName || ' usado en ' || nuCounter ||' reglas, no se borra',2);
         blReturn := TRUE;
    END;
  END IF;
  RETURN blReturn;
 END;

BEGIN
 ut_trace.trace('Inicia borrado de objetos de reglas',1);
 nuIndex := EXP_PROCESS_100588_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_PROCESS_100588_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_PROCESS_100588_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_PROCESS_100588_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_PROCESS_100588_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_PROCESS_100588_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_PROCESS_100588_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_PROCESS_100588_.tbObjectToDelete.next(nuIndex);
 END loop;
 ut_trace.trace('Finaliza borrado de objetos de reglas',1);
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('EXP_PROCESS_100588_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_PROCESS_100588_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_PROCESS_100563_',
'CREATE OR REPLACE PACKAGE EXP_PROCESS_100563_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyWF_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPERowId tyWF_UNIT_TYPERowId;type tyWF_UNIT_CATEGORYRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_CATEGORYRowId tyWF_UNIT_CATEGORYRowId;type tyWF_ATTRIBUTES_EQUIVRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_ATTRIBUTES_EQUIVRowId tyWF_ATTRIBUTES_EQUIVRowId;type tyGE_COMMENT_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_COMMENT_CLASSRowId tyGE_COMMENT_CLASSRowId;type tyGR_CONFIGURA_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIGURA_TYPERowId tyGR_CONFIGURA_TYPERowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type tyGE_ATTRIBUTE_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTE_CLASSRowId tyGE_ATTRIBUTE_CLASSRowId;type tyGE_ATTRIBUTES_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTES_TYPERowId tyGE_ATTRIBUTES_TYPERowId;type tyGE_ATTRIBUTESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTESRowId tyGE_ATTRIBUTESRowId;type tyGE_STATEMENTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_STATEMENTRowId tyGE_STATEMENTRowId;type tyWF_UNIT_ATTRIBUTERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_ATTRIBUTERowId tyWF_UNIT_ATTRIBUTERowId;type tyGE_MODULERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_MODULERowId tyGE_MODULERowId;type tyWF_NODE_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_NODE_TYPERowId tyWF_NODE_TYPERowId;type tyWF_UNITRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNITRowId tyWF_UNITRowId;type tyWF_UNIT_DATA_MAPRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_DATA_MAPRowId tyWF_UNIT_DATA_MAPRowId;type tyWF_TRANSITIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_TRANSITIONRowId tyWF_TRANSITIONRowId;type ty0_0 is table of WF_UNIT_CATEGORY.CATEGORY_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty1_0 is table of GE_MODULE.MODULE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_0 ty1_0; ' || chr(10) ||
'tb1_0 ty1_0;type ty2_0 is table of WF_UNIT_TYPE.UNIT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;type ty2_1 is table of WF_UNIT_TYPE.CATEGORY_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_1 ty2_1; ' || chr(10) ||
'tb2_1 ty2_1;type ty2_2 is table of WF_UNIT_TYPE.MODULE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_2 ty2_2; ' || chr(10) ||
'tb2_2 ty2_2;type ty2_5 is table of WF_UNIT_TYPE.INIT_AREA_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_5 ty2_5; ' || chr(10) ||
'tb2_5 ty2_5;type ty2_6 is table of WF_UNIT_TYPE.ASSIGN_COMMENT_CLASS%type index by binary_integer; ' || chr(10) ||
'old_tb2_6 ty2_6; ' || chr(10) ||
'tb2_6 ty2_6;type ty2_7 is table of WF_UNIT_TYPE.ATTEND_COMMENT_CLASS%type index by binary_integer; ' || chr(10) ||
'old_tb2_7 ty2_7; ' || chr(10) ||
'tb2_7 ty2_7;type ty2_8 is table of WF_UNIT_TYPE.UNASSIGN_COMMENT_CLASS%type index by binary_integer; ' || chr(10) ||
'old_tb2_8 ty2_8; ' || chr(10) ||
'tb2_8 ty2_8;type ty3_0 is table of WF_NODE_TYPE.NODE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_0 ty3_0; ' || chr(10) ||
'tb3_0 ty3_0;type ty4_0 is table of WF_UNIT.UNIT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_0 ty4_0; ' || chr(10) ||
'tb4_0 ty4_0;type ty4_1 is table of WF_UNIT.PROCESS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_1 ty4_1; ' || chr(10) ||
'tb4_1 ty4_1;type ty4_2 is table of WF_UNIT.UNIT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_2 ty4_2; ' || chr(10) ||
'tb4_2 ty4_2;type ty4_3 is table of WF_UNIT.NODE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_3 ty4_3; ' || chr(10) ||
'tb4_3 ty4_3;type ty4_4 is table of WF_UNIT.MODULE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_4 ty4_4; ' || chr(10) ||
'tb4_4 ty4_4;type ty4_6 is table of WF_UNIT.PRE_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_6 ty4_6; ' || chr(10) ||
'tb4_6 ty4_6;type ty4_7 is table of WF_UNIT.POS_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_7 ty4_7; ' || chr(10) ||
'tb4_7 ty4_7;type ty5_0 is table of WF_TRANSITION.TRANS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_0 ty5_0; ' || chr(10) ||
'tb5_0 ty5_0;type ty5_1 is table of WF_TRANSITION.ORIGIN_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_1 ty5_1; ' || chr(10) ||
'tb5_1 ty5_1;type ty5_2 is table of WF_TRANSITION.TARGET_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_2 ty5_2; ' || chr(10) ||
'tb5_2 ty5_2;type ty6_0 is table of GE_ATTRIBUTE_CLASS.ATTRIBUTE_CLASS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_0 ty6_0; ' || chr(10) ||
'tb6_0 ty6_0;type ty7_0 is table of GE_ATTRIBUTES_TYPE.ATTRIBUTE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_0 ty7_0; ' || chr(10) ||
'tb7_0 ty7_0;type ty8_0 is table of GE_ATTRIBUTES.ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_0 ty8_0; ' || chr(10) ||
'tb8_0 ty8_0;type ty8_1 is table of GE_ATTRIBUTES.ATTRIBUTE_CLASS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_1 ty8_1; ' || chr(10) ||
'tb8_1 ty8_1;type ty8_2 is table of GE_ATTRIBUTES.ATTRIBUTE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_2 ty8_2; ' || chr(10) ||
'tb8_2 ty8_2;type ty9_0 is table of WF_UNIT_ATTRIBUTE.UNIT_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb9_0 ty9_0; ' || chr(10) ||
'tb9_0 ty9_0;type ty9_1 is table of WF_UNIT_ATTRIBUTE.UNIT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb9_1 ty9_1; ' || chr(10) ||
'tb9_1 ty9_1;type ty9_2 is table of WF_UNIT_ATTRIBUTE.ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb9_2 ty9_2; ' || chr(10) ||
'tb9_2 ty9_2;type ty9_3 is table of WF_UNIT_ATTRIBUTE.STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb9_3 ty9_3; ' || chr(10) ||
'tb9_3 ty9_3;type ty10_0 is table of GE_STATEMENT.STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb10_0 ty10_0; ' || chr(10) ||
'tb10_0 ty10_0;type ty11_0 is table of WF_UNIT_DATA_MAP.UNIT_DATA_MAP_ID%type index by binary_integer; ' || chr(10) ||
'old_tb11_0 ty11_0; ' || chr(10) ||
'tb11_0 ty11_0;type ty11_1 is table of WF_UNIT_DATA_MAP.SOURCE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb11_1 ty11_1; ' || chr(10) ||
'tb11_1 ty11_1;type ty11_2 is table of WF_UNIT_DATA_MAP.TARGET_ID%type index by binary_integer; ' || chr(10) ||
'old_tb11_2 ty11_2; ' || chr(10) ||
'tb11_2 ty11_2; ' || chr(10) ||
'CURSOR cuExpression is ' || chr(10) ||
'SELECT PRE_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_TYPE_ID = 100563 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID IN  ' || chr(10) ||
'           (SELECT UNIT_ID ' || chr(10) ||
'           FROM WF_UNIT ' || chr(10) ||
'           WHERE UNIT_TYPE_ID = 100563 ' || chr(10) ||
'       )) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_TYPE_ID = 100563 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID IN  ' || chr(10) ||
'           (SELECT UNIT_ID ' || chr(10) ||
'           FROM WF_UNIT ' || chr(10) ||
'           WHERE UNIT_TYPE_ID = 100563 ' || chr(10) ||
'       )) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_PROCESS_100563_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_PROCESS_100563_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open EXP_PROCESS_100563_.cuExpression;
   fetch EXP_PROCESS_100563_.cuExpression bulk collect INTO EXP_PROCESS_100563_.tbGR_CONFIG_EXPRESSIONId;
   close EXP_PROCESS_100563_.cuExpression;
END;
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100563',1);
EXP_PROCESS_100563_.blProcessStatus := EXP_PROCESS_100559_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('DEL_ROOT_102718_',
'CREATE OR REPLACE PACKAGE DEL_ROOT_102718_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyWF_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPERowId tyWF_UNIT_TYPERowId;type tyWF_UNIT_CATEGORYRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_CATEGORYRowId tyWF_UNIT_CATEGORYRowId;type tyWF_ATTRIBUTES_EQUIVRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_ATTRIBUTES_EQUIVRowId tyWF_ATTRIBUTES_EQUIVRowId;type tyGE_COMMENT_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_COMMENT_CLASSRowId tyGE_COMMENT_CLASSRowId;type tyGR_CONFIGURA_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIGURA_TYPERowId tyGR_CONFIGURA_TYPERowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type tyGE_ATTRIBUTE_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTE_CLASSRowId tyGE_ATTRIBUTE_CLASSRowId;type tyGE_ATTRIBUTES_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTES_TYPERowId tyGE_ATTRIBUTES_TYPERowId;type tyGE_ATTRIBUTESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTESRowId tyGE_ATTRIBUTESRowId;type tyGE_STATEMENTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_STATEMENTRowId tyGE_STATEMENTRowId;type tyWF_UNIT_ATTRIBUTERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_ATTRIBUTERowId tyWF_UNIT_ATTRIBUTERowId;type tyGE_MODULERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_MODULERowId tyGE_MODULERowId;type tyWF_NODE_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_NODE_TYPERowId tyWF_NODE_TYPERowId;type tyWF_UNITRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNITRowId tyWF_UNITRowId;type tyWF_UNIT_DATA_MAPRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_DATA_MAPRowId tyWF_UNIT_DATA_MAPRowId;type tyWF_TRANSITIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_TRANSITIONRowId tyWF_TRANSITIONRowId;type ty0_0 is table of WF_UNIT.UNIT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_6 is table of WF_UNIT.PRE_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_6 ty0_6; ' || chr(10) ||
'tb0_6 ty0_6;type ty0_7 is table of WF_UNIT.POS_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_7 ty0_7; ' || chr(10) ||
'tb0_7 ty0_7;type ty1_0 is table of WF_TRANSITION.TRANS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_0 ty1_0; ' || chr(10) ||
'tb1_0 ty1_0;type ty1_1 is table of WF_TRANSITION.ORIGIN_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_1 ty1_1; ' || chr(10) ||
'tb1_1 ty1_1;type ty1_2 is table of WF_TRANSITION.TARGET_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_2 ty1_2; ' || chr(10) ||
'tb1_2 ty1_2;type ty2_0 is table of WF_UNIT_ATTRIBUTE.UNIT_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;type ty2_1 is table of WF_UNIT_ATTRIBUTE.UNIT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_1 ty2_1; ' || chr(10) ||
'tb2_1 ty2_1;type ty3_0 is table of WF_UNIT_DATA_MAP.UNIT_DATA_MAP_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_0 ty3_0; ' || chr(10) ||
'tb3_0 ty3_0;type ty3_1 is table of WF_UNIT_DATA_MAP.SOURCE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_1 ty3_1; ' || chr(10) ||
'tb3_1 ty3_1;type ty3_2 is table of WF_UNIT_DATA_MAP.TARGET_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_2 ty3_2; ' || chr(10) ||
'tb3_2 ty3_2; ' || chr(10) ||
'CURSOR cuExpression is ' || chr(10) ||
'SELECT PRE_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_ID = 102718 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 102718  ' || chr(10) ||
'       ) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_ID = 102718 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 102718  ' || chr(10) ||
'       ) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END DEL_ROOT_102718_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:DEL_ROOT_102718_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open DEL_ROOT_102718_.cuExpression;
   fetch DEL_ROOT_102718_.cuExpression bulk collect INTO DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONId;
   close DEL_ROOT_102718_.cuExpression;
END;
/ 

DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  SELECT  B.object_name
FROM    WF_UNIT A, GR_CONFIG_EXPRESSION B
WHERE   (A.PRE_EXPRESSION_ID = b.CONFIG_EXPRESSION_ID
OR   A.POS_EXPRESSION_ID = b.CONFIG_EXPRESSION_ID)
AND     A.UNIT_ID IN (
        SELECT UNIT_ID         FROM WF_UNIT 
        WHERE UNIT_ID = 102718
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID = 102718 
       )
;
BEGIN

if (not DEL_ROOT_102718_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  DEL_ROOT_102718_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
  nuIndex := nuIndex + 1;
 END LOOP;
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
END;
/

DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE PROCESS_ID = 102718);
BEGIN 

if (not DEL_ROOT_102718_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102718_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE PROCESS_ID = 102718);
BEGIN 

if (not DEL_ROOT_102718_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102718_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 102718)));
BEGIN 

if (not DEL_ROOT_102718_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102718_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 102718)));
BEGIN 

if (not DEL_ROOT_102718_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102718_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 102718));
BEGIN 

if (not DEL_ROOT_102718_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla WF_UNIT',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102718_.tbWF_UNITRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102718_.blProcessStatus := false;
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
FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 102718);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102718_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_TRANSITION',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_TRANSITION WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
DEL_ROOT_102718_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102718_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102718_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102718_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102718_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102718_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria WF_UNIT',1);
nuVarcharIndex:=DEL_ROOT_102718_.tbWF_UNITRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from WF_UNIT where rowid = DEL_ROOT_102718_.tbWF_UNITRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102718_.tbWF_UNITRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102718_.tbWF_UNITRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102718_.blProcessStatus := false;
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
FROM WF_UNIT_DATA_MAP WHERE (SOURCE_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 102718));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102718_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_DATA_MAP',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_DATA_MAP WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
DEL_ROOT_102718_.blProcessStatus := false;
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
FROM WF_UNIT_DATA_MAP WHERE (TARGET_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 102718));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102718_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_DATA_MAP',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_DATA_MAP WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
DEL_ROOT_102718_.blProcessStatus := false;
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
FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 102718);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102718_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_ATTRIBUTE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_ATTRIBUTE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
DEL_ROOT_102718_.blProcessStatus := false;
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
FROM WF_UNIT WHERE PROCESS_ID = 102718;
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102718_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
DEL_ROOT_102718_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102718_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102718_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102718_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102718_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/

BEGIN
    ut_trace.trace('Actualizar WF_UNIT a ProcessId NULL ',1);
   UPDATE WF_UNIT 
     SET PROCESS_ID = -1, POS_EXPRESSION_ID = null, PRE_EXPRESSION_ID = null, ACTION_ID = null 
     WHERE PROCESS_ID = 102718;
   exception
         when others then 
            rollback;
            ut_trace.trace('**ERROR:'||sqlerrm,1);
            raise;
END;
  
/

DECLARE 
    nuBinaryIndex Binary_Integer;
BEGIN 
    nuBinaryIndex := DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       DEL_ROOT_102718_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100563',1);
EXP_PROCESS_100563_.blProcessStatus := DEL_ROOT_102718_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/

DECLARE
 nuIndex         binary_integer;
 blObjectDeleted boolean;

 FUNCTION fblIsObjectUseByRule
 (
  isbObjectName   IN gr_config_expression.object_name%type
 ) return BOOLEAN
 IS
  nuCounter    NUMBER := 0;
  blReturn     BOOLEAN := FALSE;
 BEGIN
  SELECT count('x') INTO nuCounter
  FROM gr_config_expression
  WHERE object_name = isbObjectName;
  IF (nuCounter > 0) THEN
    BEGIN
      DELETE FROM gr_config_expression
      WHERE object_name = isbObjectName;
      blReturn := FALSE;
    EXCEPTION
      when ex.RECORD_HAVE_CHILDREN then
         ut_trace.trace('Objeto ' || isbObjectName || ' usado en ' || nuCounter ||' reglas, no se borra',2);
         blReturn := TRUE;
    END;
  END IF;
  RETURN blReturn;
 END;

BEGIN
 ut_trace.trace('Inicia borrado de objetos de reglas',1);
 nuIndex := DEL_ROOT_102718_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || DEL_ROOT_102718_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(DEL_ROOT_102718_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(DEL_ROOT_102718_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(DEL_ROOT_102718_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || DEL_ROOT_102718_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || DEL_ROOT_102718_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := DEL_ROOT_102718_.tbObjectToDelete.next(nuIndex);
 END loop;
 ut_trace.trace('Finaliza borrado de objetos de reglas',1);
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('DEL_ROOT_102718_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:DEL_ROOT_102718_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('DEL_ROOT_102718_',
'CREATE OR REPLACE PACKAGE DEL_ROOT_102718_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyWF_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPERowId tyWF_UNIT_TYPERowId;type tyWF_UNIT_CATEGORYRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_CATEGORYRowId tyWF_UNIT_CATEGORYRowId;type tyWF_ATTRIBUTES_EQUIVRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_ATTRIBUTES_EQUIVRowId tyWF_ATTRIBUTES_EQUIVRowId;type tyGE_COMMENT_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_COMMENT_CLASSRowId tyGE_COMMENT_CLASSRowId;type tyGR_CONFIGURA_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIGURA_TYPERowId tyGR_CONFIGURA_TYPERowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type tyGE_ATTRIBUTE_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTE_CLASSRowId tyGE_ATTRIBUTE_CLASSRowId;type tyGE_ATTRIBUTES_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTES_TYPERowId tyGE_ATTRIBUTES_TYPERowId;type tyGE_ATTRIBUTESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTESRowId tyGE_ATTRIBUTESRowId;type tyGE_STATEMENTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_STATEMENTRowId tyGE_STATEMENTRowId;type tyWF_UNIT_ATTRIBUTERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_ATTRIBUTERowId tyWF_UNIT_ATTRIBUTERowId;type tyGE_MODULERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_MODULERowId tyGE_MODULERowId;type tyWF_NODE_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_NODE_TYPERowId tyWF_NODE_TYPERowId;type tyWF_UNITRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNITRowId tyWF_UNITRowId;type tyWF_UNIT_DATA_MAPRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_DATA_MAPRowId tyWF_UNIT_DATA_MAPRowId;type tyWF_TRANSITIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_TRANSITIONRowId tyWF_TRANSITIONRowId;type ty0_0 is table of WF_UNIT.UNIT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_6 is table of WF_UNIT.PRE_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_6 ty0_6; ' || chr(10) ||
'tb0_6 ty0_6;type ty0_7 is table of WF_UNIT.POS_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_7 ty0_7; ' || chr(10) ||
'tb0_7 ty0_7; ' || chr(10) ||
'CURSOR cuExpression is ' || chr(10) ||
'SELECT PRE_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_ID = 102718 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 102718  ' || chr(10) ||
'       ) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_ID = 102718 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 102718  ' || chr(10) ||
'       ) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END DEL_ROOT_102718_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:DEL_ROOT_102718_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open DEL_ROOT_102718_.cuExpression;
   fetch DEL_ROOT_102718_.cuExpression bulk collect INTO DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONId;
   close DEL_ROOT_102718_.cuExpression;
END;
/ 

DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  SELECT  B.object_name
FROM    WF_UNIT A, GR_CONFIG_EXPRESSION B
WHERE   (A.PRE_EXPRESSION_ID = b.CONFIG_EXPRESSION_ID
OR   A.POS_EXPRESSION_ID = b.CONFIG_EXPRESSION_ID)
AND     A.UNIT_ID IN (
        SELECT UNIT_ID         FROM WF_UNIT 
        WHERE UNIT_ID = 102718
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID = 102718 
       )
;
BEGIN

if (not DEL_ROOT_102718_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  DEL_ROOT_102718_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
  nuIndex := nuIndex + 1;
 END LOOP;
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
END;
/

DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE UNIT_ID = 102718);
BEGIN 

if (not DEL_ROOT_102718_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102718_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE UNIT_ID = 102718);
BEGIN 

if (not DEL_ROOT_102718_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102718_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 102718)));
BEGIN 

if (not DEL_ROOT_102718_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102718_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 102718)));
BEGIN 

if (not DEL_ROOT_102718_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102718_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 102718));
BEGIN 

if (not DEL_ROOT_102718_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla WF_UNIT',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102718_.tbWF_UNITRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102718_.blProcessStatus := false;
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
FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 102718);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102718_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_TRANSITION',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_TRANSITION WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
DEL_ROOT_102718_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102718_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102718_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102718_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102718_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102718_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria WF_UNIT',1);
nuVarcharIndex:=DEL_ROOT_102718_.tbWF_UNITRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from WF_UNIT where rowid = DEL_ROOT_102718_.tbWF_UNITRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102718_.tbWF_UNITRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102718_.tbWF_UNITRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102718_.blProcessStatus := false;
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
FROM WF_UNIT_DATA_MAP WHERE (SOURCE_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 102718));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102718_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_DATA_MAP',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_DATA_MAP WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
DEL_ROOT_102718_.blProcessStatus := false;
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
FROM WF_UNIT_DATA_MAP WHERE (TARGET_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 102718));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102718_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_DATA_MAP',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_DATA_MAP WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
DEL_ROOT_102718_.blProcessStatus := false;
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
FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 102718);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102718_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_ATTRIBUTE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_ATTRIBUTE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
DEL_ROOT_102718_.blProcessStatus := false;
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
FROM WF_UNIT WHERE UNIT_ID = 102718;
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102718_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
DEL_ROOT_102718_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102718_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102718_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102718_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102718_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/

BEGIN
    ut_trace.trace('Actualizar WF_UNIT a ProcessId NULL ',1);
   UPDATE WF_UNIT 
     SET PROCESS_ID = -1, POS_EXPRESSION_ID = null, PRE_EXPRESSION_ID = null, ACTION_ID = null 
     WHERE PROCESS_ID = 102718;
   exception
         when others then 
            rollback;
            ut_trace.trace('**ERROR:'||sqlerrm,1);
            raise;
END;
  
/

DECLARE 
    nuBinaryIndex Binary_Integer;
BEGIN 
    nuBinaryIndex := DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := DEL_ROOT_102718_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       DEL_ROOT_102718_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100563',1);
EXP_PROCESS_100563_.blProcessStatus := DEL_ROOT_102718_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/

DECLARE
 nuIndex         binary_integer;
 blObjectDeleted boolean;

 FUNCTION fblIsObjectUseByRule
 (
  isbObjectName   IN gr_config_expression.object_name%type
 ) return BOOLEAN
 IS
  nuCounter    NUMBER := 0;
  blReturn     BOOLEAN := FALSE;
 BEGIN
  SELECT count('x') INTO nuCounter
  FROM gr_config_expression
  WHERE object_name = isbObjectName;
  IF (nuCounter > 0) THEN
    BEGIN
      DELETE FROM gr_config_expression
      WHERE object_name = isbObjectName;
      blReturn := FALSE;
    EXCEPTION
      when ex.RECORD_HAVE_CHILDREN then
         ut_trace.trace('Objeto ' || isbObjectName || ' usado en ' || nuCounter ||' reglas, no se borra',2);
         blReturn := TRUE;
    END;
  END IF;
  RETURN blReturn;
 END;

BEGIN
 ut_trace.trace('Inicia borrado de objetos de reglas',1);
 nuIndex := DEL_ROOT_102718_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || DEL_ROOT_102718_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(DEL_ROOT_102718_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(DEL_ROOT_102718_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(DEL_ROOT_102718_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || DEL_ROOT_102718_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || DEL_ROOT_102718_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := DEL_ROOT_102718_.tbObjectToDelete.next(nuIndex);
 END loop;
 ut_trace.trace('Finaliza borrado de objetos de reglas',1);
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('DEL_ROOT_102718_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:DEL_ROOT_102718_******************************'); end;
/


DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  SELECT  B.object_name
FROM    WF_UNIT A, GR_CONFIG_EXPRESSION B
WHERE   (A.PRE_EXPRESSION_ID = b.CONFIG_EXPRESSION_ID
OR   A.POS_EXPRESSION_ID = b.CONFIG_EXPRESSION_ID)
AND     A.UNIT_ID IN (
        SELECT UNIT_ID         FROM WF_UNIT 
        WHERE UNIT_TYPE_ID = 100563
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID IN 
           (SELECT UNIT_ID
           FROM WF_UNIT
           WHERE UNIT_TYPE_ID = 100563
       ))
;
BEGIN

if (not EXP_PROCESS_100563_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_PROCESS_100563_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
  nuIndex := nuIndex + 1;
 END LOOP;
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
END;
/

DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100563) AND NODE_TYPE_ID=0);
BEGIN 

if (not EXP_PROCESS_100563_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_PROCESS_100563_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_PROCESS_100563_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100563) AND NODE_TYPE_ID=0);
BEGIN 

if (not EXP_PROCESS_100563_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_PROCESS_100563_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_PROCESS_100563_.blProcessStatus := false;
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
FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100563) AND NODE_TYPE_ID=0;
nuIndex binary_integer;
BEGIN

if (not EXP_PROCESS_100563_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_PROCESS_100563_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_PROCESS_100563_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_PROCESS_100563_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_PROCESS_100563_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_PROCESS_100563_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_PROCESS_100563_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_PROCESS_100563_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_PROCESS_100563_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_PROCESS_100563_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_PROCESS_100563_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_PROCESS_100563_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_PROCESS_100563_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_PROCESS_100563_.blProcessStatus := false;
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
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100563;
nuIndex binary_integer;
BEGIN

if (not EXP_PROCESS_100563_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_TYPE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_TYPE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_PROCESS_100563_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_PROCESS_100563_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100563_.tb0_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_CATEGORY fila (0)',1);
UPDATE WF_UNIT_CATEGORY SET CATEGORY_ID=EXP_PROCESS_100563_.tb0_0(0),
DISPLAY_NUMBER='Proceso B¿sico'

 WHERE CATEGORY_ID = EXP_PROCESS_100563_.tb0_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_CATEGORY(CATEGORY_ID,DISPLAY_NUMBER) 
VALUES (EXP_PROCESS_100563_.tb0_0(0),
'Proceso B¿sico'
);
end if;

exception when others then
EXP_PROCESS_100563_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100563_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100563_.tb1_0(0):=9;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (0)',1);
UPDATE GE_MODULE SET MODULE_ID=EXP_PROCESS_100563_.tb1_0(0),
DESCRIPTION='WorkFlow'
,
MNEMONIC='WF'
,
LAST_MESSAGE=66,
PATH_MODULE='Workflow'
,
ICON_NAME='mod_admcnf'
,
LOCALIZATION='IN'

 WHERE MODULE_ID = EXP_PROCESS_100563_.tb1_0(0);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (EXP_PROCESS_100563_.tb1_0(0),
'WorkFlow'
,
'WF'
,
66,
'Workflow'
,
'mod_admcnf'
,
'IN'
);
end if;

exception when others then
EXP_PROCESS_100563_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100563_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100563_.tb2_0(0):=100563;
EXP_PROCESS_100563_.tb2_1(0):=EXP_PROCESS_100563_.tb0_0(0);
EXP_PROCESS_100563_.tb2_2(0):=EXP_PROCESS_100563_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (0)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100563_.tb2_0(0),
CATEGORY_ID=EXP_PROCESS_100563_.tb2_1(0),
MODULE_ID=EXP_PROCESS_100563_.tb2_2(0),
ACTION_ID=null,
PARENT_ID=983,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_100563'
,
DESCRIPTION='Generar Orden a Recaudo'
,
DISPLAY='Generar Orden a Recaudo'
,
ICON=null,
IS_STAGE_PROCESS='N'
,
USABLE_IN_FLOW_STAGE='N'
,
ENTITY_ID=null,
MULTI_INSTANCE='R'
,
IS_COUNTABLE='N'
,
NOTIFICATION_ID=null,
VIEWABLE='N'
,
DEFAULT_PRIORITY_ID=null,
INITIAL_NOTIFY_TIME=null,
IS_ADMIN_PROCESS='N'
,
ASSIGN_NOTIFICATION_ID=null,
ASSIGNED_USER_ONLY=null
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100563_.tb2_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100563_.tb2_0(0),
EXP_PROCESS_100563_.tb2_1(0),
EXP_PROCESS_100563_.tb2_2(0),
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_100563'
,
'Generar Orden a Recaudo'
,
'Generar Orden a Recaudo'
,
null,
'N'
,
'N'
,
null,
'R'
,
'N'
,
null,
'N'
,
null,
null,
'N'
,
null,
null);
end if;

exception when others then
EXP_PROCESS_100563_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100563_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100563_.tb3_0(0):=0;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (0)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100563_.tb3_0(0),
DESCRIPTION='Ra¿z'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100563_.tb3_0(0);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100563_.tb3_0(0),
'Ra¿z'
);
end if;

exception when others then
EXP_PROCESS_100563_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100563_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100563_.tb4_0(0):=102718;
EXP_PROCESS_100563_.tb4_2(0):=EXP_PROCESS_100563_.tb2_0(0);
EXP_PROCESS_100563_.tb4_3(0):=EXP_PROCESS_100563_.tb3_0(0);
EXP_PROCESS_100563_.tb4_4(0):=EXP_PROCESS_100563_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (0)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100563_.tb4_0(0),
PROCESS_ID=null,
UNIT_TYPE_ID=EXP_PROCESS_100563_.tb4_2(0),
NODE_TYPE_ID=EXP_PROCESS_100563_.tb4_3(0),
MODULE_ID=EXP_PROCESS_100563_.tb4_4(0),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='20
20'
,
DESCRIPTION='T¿tulo'
,
ONLINE_EXEC_ID=null,
MULTI_INSTANCE='R'
,
SINCRONIC_TIMEOUT=null,
ASINCRONIC_TIMEOUT=null,
FUNCTION_TYPE=null,
IS_COUNTABLE='N'
,
MIN_GROUP_SIZE=null,
EXECUTION_ORDER='A'
,
ANNULATION_ORDER='N'
,
ENTITY_ID=null,
VIEWABLE='N'

 WHERE UNIT_ID = EXP_PROCESS_100563_.tb4_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100563_.tb4_0(0),
null,
EXP_PROCESS_100563_.tb4_2(0),
EXP_PROCESS_100563_.tb4_3(0),
EXP_PROCESS_100563_.tb4_4(0),
null,
null,
null,
null,
'20
20'
,
'T¿tulo'
,
null,
'R'
,
null,
null,
null,
'N'
,
null,
'A'
,
'N'
,
null,
'N'
);
end if;

exception when others then
EXP_PROCESS_100563_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100563_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100563_.tb0_0(1):=2;
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_CATEGORY fila (1)',1);
UPDATE WF_UNIT_CATEGORY SET CATEGORY_ID=EXP_PROCESS_100563_.tb0_0(1),
DISPLAY_NUMBER='Actividad'

 WHERE CATEGORY_ID = EXP_PROCESS_100563_.tb0_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_CATEGORY(CATEGORY_ID,DISPLAY_NUMBER) 
VALUES (EXP_PROCESS_100563_.tb0_0(1),
'Actividad'
);
end if;

exception when others then
EXP_PROCESS_100563_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100563_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100563_.tb2_0(1):=283;
EXP_PROCESS_100563_.tb2_1(1):=EXP_PROCESS_100563_.tb0_0(1);
EXP_PROCESS_100563_.tb2_2(1):=EXP_PROCESS_100563_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (1)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100563_.tb2_0(1),
CATEGORY_ID=EXP_PROCESS_100563_.tb2_1(1),
MODULE_ID=EXP_PROCESS_100563_.tb2_2(1),
ACTION_ID=null,
PARENT_ID=983,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_283'
,
DESCRIPTION='Inicio'
,
DISPLAY='Inicio'
,
ICON='GO.BMP'
,
IS_STAGE_PROCESS='N'
,
USABLE_IN_FLOW_STAGE='N'
,
ENTITY_ID=null,
MULTI_INSTANCE='R'
,
IS_COUNTABLE='N'
,
NOTIFICATION_ID=null,
VIEWABLE='N'
,
DEFAULT_PRIORITY_ID=null,
INITIAL_NOTIFY_TIME=null,
IS_ADMIN_PROCESS='N'
,
ASSIGN_NOTIFICATION_ID=null,
ASSIGNED_USER_ONLY=null
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100563_.tb2_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100563_.tb2_0(1),
EXP_PROCESS_100563_.tb2_1(1),
EXP_PROCESS_100563_.tb2_2(1),
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_283'
,
'Inicio'
,
'Inicio'
,
'GO.BMP'
,
'N'
,
'N'
,
null,
'R'
,
'N'
,
null,
'N'
,
null,
null,
'N'
,
null,
null);
end if;

exception when others then
EXP_PROCESS_100563_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100563_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100563_.tb3_0(1):=1;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (1)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100563_.tb3_0(1),
DESCRIPTION='Arranque'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100563_.tb3_0(1);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100563_.tb3_0(1),
'Arranque'
);
end if;

exception when others then
EXP_PROCESS_100563_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100563_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100563_.tb4_0(1):=102720;
EXP_PROCESS_100563_.tb4_1(1):=EXP_PROCESS_100563_.tb4_0(0);
EXP_PROCESS_100563_.tb4_2(1):=EXP_PROCESS_100563_.tb2_0(1);
EXP_PROCESS_100563_.tb4_3(1):=EXP_PROCESS_100563_.tb3_0(1);
EXP_PROCESS_100563_.tb4_4(1):=EXP_PROCESS_100563_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (1)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100563_.tb4_0(1),
PROCESS_ID=EXP_PROCESS_100563_.tb4_1(1),
UNIT_TYPE_ID=EXP_PROCESS_100563_.tb4_2(1),
NODE_TYPE_ID=EXP_PROCESS_100563_.tb4_3(1),
MODULE_ID=EXP_PROCESS_100563_.tb4_4(1),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='0
185'
,
DESCRIPTION='Inicio'
,
ONLINE_EXEC_ID=null,
MULTI_INSTANCE='R'
,
SINCRONIC_TIMEOUT=null,
ASINCRONIC_TIMEOUT=null,
FUNCTION_TYPE=null,
IS_COUNTABLE='Y'
,
MIN_GROUP_SIZE=null,
EXECUTION_ORDER='A'
,
ANNULATION_ORDER='N'
,
ENTITY_ID=17,
VIEWABLE='N'

 WHERE UNIT_ID = EXP_PROCESS_100563_.tb4_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100563_.tb4_0(1),
EXP_PROCESS_100563_.tb4_1(1),
EXP_PROCESS_100563_.tb4_2(1),
EXP_PROCESS_100563_.tb4_3(1),
EXP_PROCESS_100563_.tb4_4(1),
null,
null,
null,
null,
'0
185'
,
'Inicio'
,
null,
'R'
,
null,
null,
null,
'Y'
,
null,
'A'
,
'N'
,
17,
'N'
);
end if;

exception when others then
EXP_PROCESS_100563_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100563_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100563_.tb1_0(1):=4;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (1)',1);
UPDATE GE_MODULE SET MODULE_ID=EXP_PROCESS_100563_.tb1_0(1),
DESCRIPTION='¿rdenes'
,
MNEMONIC='OR'
,
LAST_MESSAGE=404,
PATH_MODULE='Orders'
,
ICON_NAME='mod_ordenes'
,
LOCALIZATION='IN'

 WHERE MODULE_ID = EXP_PROCESS_100563_.tb1_0(1);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (EXP_PROCESS_100563_.tb1_0(1),
'¿rdenes'
,
'OR'
,
404,
'Orders'
,
'mod_ordenes'
,
'IN'
);
end if;

exception when others then
EXP_PROCESS_100563_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100563_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100563_.tb2_0(2):=100564;
EXP_PROCESS_100563_.tb2_1(2):=EXP_PROCESS_100563_.tb0_0(1);
EXP_PROCESS_100563_.tb2_2(2):=EXP_PROCESS_100563_.tb1_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (2)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100563_.tb2_0(2),
CATEGORY_ID=EXP_PROCESS_100563_.tb2_1(2),
MODULE_ID=EXP_PROCESS_100563_.tb2_2(2),
ACTION_ID=null,
PARENT_ID=983,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_100564'
,
DESCRIPTION='Generar Orden Recaudo'
,
DISPLAY='Generar Orden Recaudo'
,
ICON=null,
IS_STAGE_PROCESS='N'
,
USABLE_IN_FLOW_STAGE='N'
,
ENTITY_ID=null,
MULTI_INSTANCE='R'
,
IS_COUNTABLE='N'
,
NOTIFICATION_ID=null,
VIEWABLE='Y'
,
DEFAULT_PRIORITY_ID=null,
INITIAL_NOTIFY_TIME=null,
IS_ADMIN_PROCESS='N'
,
ASSIGN_NOTIFICATION_ID=null,
ASSIGNED_USER_ONLY=null
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100563_.tb2_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100563_.tb2_0(2),
EXP_PROCESS_100563_.tb2_1(2),
EXP_PROCESS_100563_.tb2_2(2),
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_100564'
,
'Generar Orden Recaudo'
,
'Generar Orden Recaudo'
,
null,
'N'
,
'N'
,
null,
'R'
,
'N'
,
null,
'Y'
,
null,
null,
'N'
,
null,
null);
end if;

exception when others then
EXP_PROCESS_100563_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100563_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100563_.tb3_0(2):=2;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (2)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100563_.tb3_0(2),
DESCRIPTION='Normal'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100563_.tb3_0(2);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100563_.tb3_0(2),
'Normal'
);
end if;

exception when others then
EXP_PROCESS_100563_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100563_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100563_.tb4_0(2):=102722;
EXP_PROCESS_100563_.tb4_1(2):=EXP_PROCESS_100563_.tb4_0(0);
EXP_PROCESS_100563_.tb4_2(2):=EXP_PROCESS_100563_.tb2_0(2);
EXP_PROCESS_100563_.tb4_3(2):=EXP_PROCESS_100563_.tb3_0(2);
EXP_PROCESS_100563_.tb4_4(2):=EXP_PROCESS_100563_.tb1_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (2)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100563_.tb4_0(2),
PROCESS_ID=EXP_PROCESS_100563_.tb4_1(2),
UNIT_TYPE_ID=EXP_PROCESS_100563_.tb4_2(2),
NODE_TYPE_ID=EXP_PROCESS_100563_.tb4_3(2),
MODULE_ID=EXP_PROCESS_100563_.tb4_4(2),
ACTION_ID=100,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=9011,
GEOMETRY='183
177'
,
DESCRIPTION='Generar Orden cartera'
,
ONLINE_EXEC_ID=null,
MULTI_INSTANCE='R'
,
SINCRONIC_TIMEOUT=null,
ASINCRONIC_TIMEOUT=null,
FUNCTION_TYPE=null,
IS_COUNTABLE='Y'
,
MIN_GROUP_SIZE=null,
EXECUTION_ORDER='A'
,
ANNULATION_ORDER='N'
,
ENTITY_ID=8,
VIEWABLE='N'

 WHERE UNIT_ID = EXP_PROCESS_100563_.tb4_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100563_.tb4_0(2),
EXP_PROCESS_100563_.tb4_1(2),
EXP_PROCESS_100563_.tb4_2(2),
EXP_PROCESS_100563_.tb4_3(2),
EXP_PROCESS_100563_.tb4_4(2),
100,
null,
null,
9011,
'183
177'
,
'Generar Orden cartera'
,
null,
'R'
,
null,
null,
null,
'Y'
,
null,
'A'
,
'N'
,
8,
'N'
);
end if;

exception when others then
EXP_PROCESS_100563_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100563_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100563_.tb5_0(0):=100000778;
EXP_PROCESS_100563_.tb5_1(0):=EXP_PROCESS_100563_.tb4_0(1);
EXP_PROCESS_100563_.tb5_2(0):=EXP_PROCESS_100563_.tb4_0(2);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (0)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100563_.tb5_0(0),
ORIGIN_ID=EXP_PROCESS_100563_.tb5_1(0),
TARGET_ID=EXP_PROCESS_100563_.tb5_2(0),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION=null,
EXPRESSION_TYPE=0,
DESCRIPTION='Inicio'
,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100563_.tb5_0(0);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100563_.tb5_0(0),
EXP_PROCESS_100563_.tb5_1(0),
EXP_PROCESS_100563_.tb5_2(0),
null,
0,
null,
0,
'Inicio'
,
1);
end if;

exception when others then
EXP_PROCESS_100563_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100563_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100563_.tb6_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTE_CLASS fila (0)',1);
UPDATE GE_ATTRIBUTE_CLASS SET ATTRIBUTE_CLASS_ID=EXP_PROCESS_100563_.tb6_0(0),
NAME='De Entitdad'
,
DESCRIPTION='Valores que ser¿n tra¿dos de la tabla base usando old record'

 WHERE ATTRIBUTE_CLASS_ID = EXP_PROCESS_100563_.tb6_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTE_CLASS(ATTRIBUTE_CLASS_ID,NAME,DESCRIPTION) 
VALUES (EXP_PROCESS_100563_.tb6_0(0),
'De Entitdad'
,
'Valores que ser¿n tra¿dos de la tabla base usando old record'
);
end if;

exception when others then
EXP_PROCESS_100563_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100563_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100563_.tb7_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES_TYPE fila (0)',1);
UPDATE GE_ATTRIBUTES_TYPE SET ATTRIBUTE_TYPE_ID=EXP_PROCESS_100563_.tb7_0(0),
DESCRIPTION='NUMBER'
,
INTERNAL_TYPE=2,
INTERNAL_JAVA_TYPE=2
 WHERE ATTRIBUTE_TYPE_ID = EXP_PROCESS_100563_.tb7_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES_TYPE(ATTRIBUTE_TYPE_ID,DESCRIPTION,INTERNAL_TYPE,INTERNAL_JAVA_TYPE) 
VALUES (EXP_PROCESS_100563_.tb7_0(0),
'NUMBER'
,
2,
2);
end if;

exception when others then
EXP_PROCESS_100563_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100563_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100563_.tb8_0(0):=400;
EXP_PROCESS_100563_.tb8_1(0):=EXP_PROCESS_100563_.tb6_0(0);
EXP_PROCESS_100563_.tb8_2(0):=EXP_PROCESS_100563_.tb7_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (0)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=EXP_PROCESS_100563_.tb8_0(0),
ATTRIBUTE_CLASS_ID=EXP_PROCESS_100563_.tb8_1(0),
ATTRIBUTE_TYPE_ID=EXP_PROCESS_100563_.tb8_2(0),
VALID_EXPRESSION=null,
FATHER_ID=null,
MODULE_ID=9,
NAME_ATTRIBUTE='CAUSAL'
,
LENGTH=4,
PRECISION=null,
SCALE=null,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE='T'
,
COMMENT_='Causal'
,
DISPLAY_NAME='Causal'

 WHERE ATTRIBUTE_ID = EXP_PROCESS_100563_.tb8_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,ATTRIBUTE_CLASS_ID,ATTRIBUTE_TYPE_ID,VALID_EXPRESSION,FATHER_ID,MODULE_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (EXP_PROCESS_100563_.tb8_0(0),
EXP_PROCESS_100563_.tb8_1(0),
EXP_PROCESS_100563_.tb8_2(0),
null,
null,
9,
'CAUSAL'
,
4,
null,
null,
null,
'T'
,
'Causal'
,
'Causal'
);
end if;

exception when others then
EXP_PROCESS_100563_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100563_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100563_.tb9_0(0):=100000704;
EXP_PROCESS_100563_.tb9_1(0):=EXP_PROCESS_100563_.tb4_0(1);
EXP_PROCESS_100563_.tb9_2(0):=EXP_PROCESS_100563_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (0)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100563_.tb9_0(0),
UNIT_ID=EXP_PROCESS_100563_.tb9_1(0),
ATTRIBUTE_ID=EXP_PROCESS_100563_.tb9_2(0),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100563_.tb9_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100563_.tb9_0(0),
EXP_PROCESS_100563_.tb9_1(0),
EXP_PROCESS_100563_.tb9_2(0),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_100563_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100563_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100563_.tb6_0(1):=8;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTE_CLASS fila (1)',1);
UPDATE GE_ATTRIBUTE_CLASS SET ATTRIBUTE_CLASS_ID=EXP_PROCESS_100563_.tb6_0(1),
NAME='Por Defecto General'
,
DESCRIPTION='Valores que ser¿n utilizados para clasificaci¿n gen¿rica'

 WHERE ATTRIBUTE_CLASS_ID = EXP_PROCESS_100563_.tb6_0(1);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTE_CLASS(ATTRIBUTE_CLASS_ID,NAME,DESCRIPTION) 
VALUES (EXP_PROCESS_100563_.tb6_0(1),
'Por Defecto General'
,
'Valores que ser¿n utilizados para clasificaci¿n gen¿rica'
);
end if;

exception when others then
EXP_PROCESS_100563_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100563_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100563_.tb8_0(1):=9218;
EXP_PROCESS_100563_.tb8_1(1):=EXP_PROCESS_100563_.tb6_0(1);
EXP_PROCESS_100563_.tb8_2(1):=EXP_PROCESS_100563_.tb7_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (1)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=EXP_PROCESS_100563_.tb8_0(1),
ATTRIBUTE_CLASS_ID=EXP_PROCESS_100563_.tb8_1(1),
ATTRIBUTE_TYPE_ID=EXP_PROCESS_100563_.tb8_2(1),
VALID_EXPRESSION=null,
FATHER_ID=null,
MODULE_ID=9,
NAME_ATTRIBUTE='EXTERNALID'
,
LENGTH=null,
PRECISION=null,
SCALE=null,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE='T'
,
COMMENT_='Identificador del Componente'
,
DISPLAY_NAME='Identificador del Componente'

 WHERE ATTRIBUTE_ID = EXP_PROCESS_100563_.tb8_0(1);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,ATTRIBUTE_CLASS_ID,ATTRIBUTE_TYPE_ID,VALID_EXPRESSION,FATHER_ID,MODULE_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (EXP_PROCESS_100563_.tb8_0(1),
EXP_PROCESS_100563_.tb8_1(1),
EXP_PROCESS_100563_.tb8_2(1),
null,
null,
9,
'EXTERNALID'
,
null,
null,
null,
null,
'T'
,
'Identificador del Componente'
,
'Identificador del Componente'
);
end if;

exception when others then
EXP_PROCESS_100563_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100563_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100563_.old_tb10_0(0):=120195449;
EXP_PROCESS_100563_.tb10_0(0):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
EXP_PROCESS_100563_.tb10_0(0):=EXP_PROCESS_100563_.tb10_0(0);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (0)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (EXP_PROCESS_100563_.tb10_0(0),
9,
'Obtiene el External Id de la actividad actual'
,
'SELECT EXTERNAL_ID EXTERNALID FROM WF_INSTANCE WHERE INSTANCE_ID = :INST.INSTANCE_ID:'
,
'wfc_ExternalId_Actual'
);

exception when others then
EXP_PROCESS_100563_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100563_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100563_.tb9_0(1):=100000749;
EXP_PROCESS_100563_.tb9_1(1):=EXP_PROCESS_100563_.tb4_0(1);
EXP_PROCESS_100563_.tb9_2(1):=EXP_PROCESS_100563_.tb8_0(1);
EXP_PROCESS_100563_.tb9_3(1):=EXP_PROCESS_100563_.tb10_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (1)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100563_.tb9_0(1),
UNIT_ID=EXP_PROCESS_100563_.tb9_1(1),
ATTRIBUTE_ID=EXP_PROCESS_100563_.tb9_2(1),
STATEMENT_ID=EXP_PROCESS_100563_.tb9_3(1),
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100563_.tb9_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100563_.tb9_0(1),
EXP_PROCESS_100563_.tb9_1(1),
EXP_PROCESS_100563_.tb9_2(1),
EXP_PROCESS_100563_.tb9_3(1),
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_100563_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100563_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100563_.tb2_0(3):=252;
EXP_PROCESS_100563_.tb2_1(3):=EXP_PROCESS_100563_.tb0_0(1);
EXP_PROCESS_100563_.tb2_2(3):=EXP_PROCESS_100563_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (3)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100563_.tb2_0(3),
CATEGORY_ID=EXP_PROCESS_100563_.tb2_1(3),
MODULE_ID=EXP_PROCESS_100563_.tb2_2(3),
ACTION_ID=null,
PARENT_ID=983,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_252'
,
DESCRIPTION='Fin'
,
DISPLAY='Fin'
,
ICON='STOP.BMP'
,
IS_STAGE_PROCESS='N'
,
USABLE_IN_FLOW_STAGE='N'
,
ENTITY_ID=null,
MULTI_INSTANCE='N'
,
IS_COUNTABLE='N'
,
NOTIFICATION_ID=null,
VIEWABLE='N'
,
DEFAULT_PRIORITY_ID=null,
INITIAL_NOTIFY_TIME=null,
IS_ADMIN_PROCESS='N'
,
ASSIGN_NOTIFICATION_ID=null,
ASSIGNED_USER_ONLY=null
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100563_.tb2_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100563_.tb2_0(3),
EXP_PROCESS_100563_.tb2_1(3),
EXP_PROCESS_100563_.tb2_2(3),
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_252'
,
'Fin'
,
'Fin'
,
'STOP.BMP'
,
'N'
,
'N'
,
null,
'N'
,
'N'
,
null,
'N'
,
null,
null,
'N'
,
null,
null);
end if;

exception when others then
EXP_PROCESS_100563_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100563_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100563_.tb3_0(3):=3;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (3)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100563_.tb3_0(3),
DESCRIPTION='Final'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100563_.tb3_0(3);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100563_.tb3_0(3),
'Final'
);
end if;

exception when others then
EXP_PROCESS_100563_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100563_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100563_.tb4_0(3):=102721;
EXP_PROCESS_100563_.tb4_1(3):=EXP_PROCESS_100563_.tb4_0(0);
EXP_PROCESS_100563_.tb4_2(3):=EXP_PROCESS_100563_.tb2_0(3);
EXP_PROCESS_100563_.tb4_3(3):=EXP_PROCESS_100563_.tb3_0(3);
EXP_PROCESS_100563_.tb4_4(3):=EXP_PROCESS_100563_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (3)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100563_.tb4_0(3),
PROCESS_ID=EXP_PROCESS_100563_.tb4_1(3),
UNIT_TYPE_ID=EXP_PROCESS_100563_.tb4_2(3),
NODE_TYPE_ID=EXP_PROCESS_100563_.tb4_3(3),
MODULE_ID=EXP_PROCESS_100563_.tb4_4(3),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='379
185'
,
DESCRIPTION='Fin'
,
ONLINE_EXEC_ID=null,
MULTI_INSTANCE='R'
,
SINCRONIC_TIMEOUT=null,
ASINCRONIC_TIMEOUT=null,
FUNCTION_TYPE=null,
IS_COUNTABLE='N'
,
MIN_GROUP_SIZE=null,
EXECUTION_ORDER='A'
,
ANNULATION_ORDER='N'
,
ENTITY_ID=17,
VIEWABLE='N'

 WHERE UNIT_ID = EXP_PROCESS_100563_.tb4_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100563_.tb4_0(3),
EXP_PROCESS_100563_.tb4_1(3),
EXP_PROCESS_100563_.tb4_2(3),
EXP_PROCESS_100563_.tb4_3(3),
EXP_PROCESS_100563_.tb4_4(3),
null,
null,
null,
null,
'379
185'
,
'Fin'
,
null,
'R'
,
null,
null,
null,
'N'
,
null,
'A'
,
'N'
,
17,
'N'
);
end if;

exception when others then
EXP_PROCESS_100563_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100563_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100563_.tb8_0(2):=401;
EXP_PROCESS_100563_.tb8_1(2):=EXP_PROCESS_100563_.tb6_0(1);
EXP_PROCESS_100563_.tb8_2(2):=EXP_PROCESS_100563_.tb7_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (2)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=EXP_PROCESS_100563_.tb8_0(2),
ATTRIBUTE_CLASS_ID=EXP_PROCESS_100563_.tb8_1(2),
ATTRIBUTE_TYPE_ID=EXP_PROCESS_100563_.tb8_2(2),
VALID_EXPRESSION=null,
FATHER_ID=null,
MODULE_ID=9,
NAME_ATTRIBUTE='$EXTERNAL_ID'
,
LENGTH=3,
PRECISION=null,
SCALE=null,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE='T'
,
COMMENT_='Identificador del Componente'
,
DISPLAY_NAME='Identificador del Componente'

 WHERE ATTRIBUTE_ID = EXP_PROCESS_100563_.tb8_0(2);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,ATTRIBUTE_CLASS_ID,ATTRIBUTE_TYPE_ID,VALID_EXPRESSION,FATHER_ID,MODULE_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (EXP_PROCESS_100563_.tb8_0(2),
EXP_PROCESS_100563_.tb8_1(2),
EXP_PROCESS_100563_.tb8_2(2),
null,
null,
9,
'$EXTERNAL_ID'
,
3,
null,
null,
null,
'T'
,
'Identificador del Componente'
,
'Identificador del Componente'
);
end if;

exception when others then
EXP_PROCESS_100563_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100563_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100563_.tb9_0(2):=100000750;
EXP_PROCESS_100563_.tb9_1(2):=EXP_PROCESS_100563_.tb4_0(3);
EXP_PROCESS_100563_.tb9_2(2):=EXP_PROCESS_100563_.tb8_0(2);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (2)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100563_.tb9_0(2),
UNIT_ID=EXP_PROCESS_100563_.tb9_1(2),
ATTRIBUTE_ID=EXP_PROCESS_100563_.tb9_2(2),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=1,
MANDATORY='Y'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100563_.tb9_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100563_.tb9_0(2),
EXP_PROCESS_100563_.tb9_1(2),
EXP_PROCESS_100563_.tb9_2(2),
null,
null,
'N'
,
1,
'Y'
);
end if;

exception when others then
EXP_PROCESS_100563_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100563_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100563_.tb11_0(0):=100000016;
EXP_PROCESS_100563_.tb11_1(0):=EXP_PROCESS_100563_.tb9_0(1);
EXP_PROCESS_100563_.tb11_2(0):=EXP_PROCESS_100563_.tb9_0(2);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_DATA_MAP fila (0)',1);
UPDATE WF_UNIT_DATA_MAP SET UNIT_DATA_MAP_ID=EXP_PROCESS_100563_.tb11_0(0),
SOURCE_ID=EXP_PROCESS_100563_.tb11_1(0),
TARGET_ID=EXP_PROCESS_100563_.tb11_2(0),
GEOMETRY=null
 WHERE UNIT_DATA_MAP_ID = EXP_PROCESS_100563_.tb11_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_DATA_MAP(UNIT_DATA_MAP_ID,SOURCE_ID,TARGET_ID,GEOMETRY) 
VALUES (EXP_PROCESS_100563_.tb11_0(0),
EXP_PROCESS_100563_.tb11_1(0),
EXP_PROCESS_100563_.tb11_2(0),
null);
end if;

exception when others then
EXP_PROCESS_100563_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100563_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100563_.tb5_0(1):=100000779;
EXP_PROCESS_100563_.tb5_1(1):=EXP_PROCESS_100563_.tb4_0(2);
EXP_PROCESS_100563_.tb5_2(1):=EXP_PROCESS_100563_.tb4_0(3);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (1)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100563_.tb5_0(1),
ORIGIN_ID=EXP_PROCESS_100563_.tb5_1(1),
TARGET_ID=EXP_PROCESS_100563_.tb5_2(1),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION=null,
EXPRESSION_TYPE=0,
DESCRIPTION='Exito'
,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100563_.tb5_0(1);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100563_.tb5_0(1),
EXP_PROCESS_100563_.tb5_1(1),
EXP_PROCESS_100563_.tb5_2(1),
null,
0,
null,
0,
'Exito'
,
1);
end if;

exception when others then
EXP_PROCESS_100563_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100563_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100563_.tb9_0(3):=100000712;
EXP_PROCESS_100563_.tb9_1(3):=EXP_PROCESS_100563_.tb4_0(2);
EXP_PROCESS_100563_.tb9_2(3):=EXP_PROCESS_100563_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (3)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100563_.tb9_0(3),
UNIT_ID=EXP_PROCESS_100563_.tb9_1(3),
ATTRIBUTE_ID=EXP_PROCESS_100563_.tb9_2(3),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100563_.tb9_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100563_.tb9_0(3),
EXP_PROCESS_100563_.tb9_1(3),
EXP_PROCESS_100563_.tb9_2(3),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_100563_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100563_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100563_.old_tb10_0(1):=120195450;
EXP_PROCESS_100563_.tb10_0(1):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
EXP_PROCESS_100563_.tb10_0(1):=EXP_PROCESS_100563_.tb10_0(1);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (1)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (EXP_PROCESS_100563_.tb10_0(1),
9,
'Obtiene el Motivo asociado al paquete del external anterior'
,
'SELECT motive_id EXTERNAL_ID FROM mo_motive,wf_instance
WHERE package_id = external_id
AND INSTANCE_ID = WF_BOINSTANCE_TRANS.FNUGETBEFORETASKS(:INST.INSTANCE_ID:, 283)'
,
'Obtiene el Motivo asociado al paquete del external anterior'
);

exception when others then
EXP_PROCESS_100563_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100563_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100563_.tb9_0(4):=100000751;
EXP_PROCESS_100563_.tb9_1(4):=EXP_PROCESS_100563_.tb4_0(2);
EXP_PROCESS_100563_.tb9_2(4):=EXP_PROCESS_100563_.tb8_0(2);
EXP_PROCESS_100563_.tb9_3(4):=EXP_PROCESS_100563_.tb10_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (4)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100563_.tb9_0(4),
UNIT_ID=EXP_PROCESS_100563_.tb9_1(4),
ATTRIBUTE_ID=EXP_PROCESS_100563_.tb9_2(4),
STATEMENT_ID=EXP_PROCESS_100563_.tb9_3(4),
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=1,
MANDATORY='Y'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100563_.tb9_0(4);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100563_.tb9_0(4),
EXP_PROCESS_100563_.tb9_1(4),
EXP_PROCESS_100563_.tb9_2(4),
EXP_PROCESS_100563_.tb9_3(4),
null,
'N'
,
1,
'Y'
);
end if;

exception when others then
EXP_PROCESS_100563_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100563_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100563_.tb9_0(5):=100000705;
EXP_PROCESS_100563_.tb9_1(5):=EXP_PROCESS_100563_.tb4_0(3);
EXP_PROCESS_100563_.tb9_2(5):=EXP_PROCESS_100563_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (5)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100563_.tb9_0(5),
UNIT_ID=EXP_PROCESS_100563_.tb9_1(5),
ATTRIBUTE_ID=EXP_PROCESS_100563_.tb9_2(5),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100563_.tb9_0(5);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100563_.tb9_0(5),
EXP_PROCESS_100563_.tb9_1(5),
EXP_PROCESS_100563_.tb9_2(5),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_100563_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100563_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100563_.tb9_0(6):=100000706;
EXP_PROCESS_100563_.tb9_1(6):=EXP_PROCESS_100563_.tb4_0(3);
EXP_PROCESS_100563_.tb9_2(6):=EXP_PROCESS_100563_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (6)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100563_.tb9_0(6),
UNIT_ID=EXP_PROCESS_100563_.tb9_1(6),
ATTRIBUTE_ID=EXP_PROCESS_100563_.tb9_2(6),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100563_.tb9_0(6);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100563_.tb9_0(6),
EXP_PROCESS_100563_.tb9_1(6),
EXP_PROCESS_100563_.tb9_2(6),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_100563_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_UNITTYPE_100564_',
'CREATE OR REPLACE PACKAGE EXP_UNITTYPE_100564_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tyWF_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPERowId tyWF_UNIT_TYPERowId;type tyWF_CAUSAL_UNIT_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_CAUSAL_UNIT_TYPERowId tyWF_CAUSAL_UNIT_TYPERowId;type tyGR_CONFIGURA_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIGURA_TYPERowId tyGR_CONFIGURA_TYPERowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type tyGE_ATTRIBUTE_CLASSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTE_CLASSRowId tyGE_ATTRIBUTE_CLASSRowId;type tyGE_ATTRIBUTES_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTES_TYPERowId tyGE_ATTRIBUTES_TYPERowId;type tyGE_ATTRIBUTESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_ATTRIBUTESRowId tyGE_ATTRIBUTESRowId;type tyGE_STATEMENTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_STATEMENTRowId tyGE_STATEMENTRowId;type tyWF_UNIT_TYPE_ATTRIBRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbWF_UNIT_TYPE_ATTRIBRowId tyWF_UNIT_TYPE_ATTRIBRowId;type tyMO_TIME_UNI_TYP_PRIORowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbMO_TIME_UNI_TYP_PRIORowId tyMO_TIME_UNI_TYP_PRIORowId;type tyOR_ACT_BY_TASK_MODRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbOR_ACT_BY_TASK_MODRowId tyOR_ACT_BY_TASK_MODRowId;type ty0_0 is table of WF_UNIT_TYPE.UNIT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_5 is table of WF_UNIT_TYPE.INIT_AREA_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_5 ty0_5; ' || chr(10) ||
'tb0_5 ty0_5;type ty1_0 is table of WF_CAUSAL_UNIT_TYPE.CAUSAL_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_0 ty1_0; ' || chr(10) ||
'tb1_0 ty1_0;type ty1_1 is table of WF_CAUSAL_UNIT_TYPE.UNIT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_1 ty1_1; ' || chr(10) ||
'tb1_1 ty1_1;type ty2_0 is table of OR_ACT_BY_TASK_MOD.ACT_BY_TASK_MOD_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;type ty2_1 is table of OR_ACT_BY_TASK_MOD.TASK_CODE%type index by binary_integer; ' || chr(10) ||
'old_tb2_1 ty2_1; ' || chr(10) ||
'tb2_1 ty2_1;type ty2_2 is table of OR_ACT_BY_TASK_MOD.CONFIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_2 ty2_2; ' || chr(10) ||
'tb2_2 ty2_2; ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_UNITTYPE_100564_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_UNITTYPE_100564_******************************'); END;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_UNITTYPE_100564',1);
EXP_UNITTYPE_100564_.blProcessStatus := EXP_PROCESS_100563_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  SELECT  B.object_name
FROM    OR_ACT_BY_TASK_MOD A, GR_CONFIG_EXPRESSION B 
WHERE   A.CONFIG_EXPRESSION_ID = B.CONFIG_EXPRESSION_ID
AND     A.TASK_CODE = 100564
 
;
BEGIN

if (not EXP_UNITTYPE_100564_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_UNITTYPE_100564_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
  nuIndex := nuIndex + 1;
 END LOOP;
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
END;
/

declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_TYPE_ATTRIB WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100564);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100564_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_TYPE_ATTRIB',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_TYPE_ATTRIB WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100564_.blProcessStatus := false;
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
FROM WF_CAUSAL_UNIT_TYPE WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100564);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100564_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_CAUSAL_UNIT_TYPE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_CAUSAL_UNIT_TYPE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100564_.blProcessStatus := false;
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
FROM MO_TIME_UNI_TYP_PRIO WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100564);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100564_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla MO_TIME_UNI_TYP_PRIO',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM MO_TIME_UNI_TYP_PRIO WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100564_.blProcessStatus := false;
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
FROM OR_ACT_BY_TASK_MOD WHERE (TASK_CODE) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100564);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100564_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla OR_ACT_BY_TASK_MOD',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM OR_ACT_BY_TASK_MOD WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100564_.blProcessStatus := false;
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
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100564;
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100564_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla WF_UNIT_TYPE',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM WF_UNIT_TYPE WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
EXP_UNITTYPE_100564_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_UNITTYPE_100564_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100564_.tb0_0(0):=100564;
ut_trace.trace('insertando tabla sin fallo: WF_UNIT_TYPE fila (0)',1);
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_UNITTYPE_100564_.tb0_0(0),
2,
4,
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_100564'
,
'Generar Orden Recaudo'
,
'Generar Orden Recaudo'
,
null,
'N'
,
'N'
,
null,
'R'
,
'N'
,
null,
'Y'
,
null,
null,
'N'
,
null,
null);

exception 
when dup_val_on_index then 
 return;
when others then
EXP_UNITTYPE_100564_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_100564_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100564_.tb1_0(0):=1;
EXP_UNITTYPE_100564_.tb1_1(0):=EXP_UNITTYPE_100564_.tb0_0(0);
ut_trace.trace('insertando tabla sin fallo: WF_CAUSAL_UNIT_TYPE fila (0)',1);
INSERT INTO WF_CAUSAL_UNIT_TYPE(CAUSAL_ID,UNIT_TYPE_ID,ALIAS) 
VALUES (EXP_UNITTYPE_100564_.tb1_0(0),
EXP_UNITTYPE_100564_.tb1_1(0),
'EXITO'
);

exception 
when dup_val_on_index then 
 return;
when others then
EXP_UNITTYPE_100564_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_100564_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100564_.tb1_0(1):=930;
EXP_UNITTYPE_100564_.tb1_1(1):=EXP_UNITTYPE_100564_.tb0_0(0);
ut_trace.trace('insertando tabla sin fallo: WF_CAUSAL_UNIT_TYPE fila (1)',1);
INSERT INTO WF_CAUSAL_UNIT_TYPE(CAUSAL_ID,UNIT_TYPE_ID,ALIAS) 
VALUES (EXP_UNITTYPE_100564_.tb1_0(1),
EXP_UNITTYPE_100564_.tb1_1(1),
'FALLO'
);

exception 
when dup_val_on_index then 
 return;
when others then
EXP_UNITTYPE_100564_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_100564_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100564_.tb2_0(0):=11202;
EXP_UNITTYPE_100564_.tb2_1(0):=EXP_UNITTYPE_100564_.tb0_0(0);
ut_trace.trace('Actualizar o insertar tabla: OR_ACT_BY_TASK_MOD fila (0)',1);
UPDATE OR_ACT_BY_TASK_MOD SET ACT_BY_TASK_MOD_ID=EXP_UNITTYPE_100564_.tb2_0(0),
TASK_CODE=EXP_UNITTYPE_100564_.tb2_1(0),
CONFIG_EXPRESSION_ID=null,
MODULE_ID=9,
ITEMS_ID=4295217
 WHERE ACT_BY_TASK_MOD_ID = EXP_UNITTYPE_100564_.tb2_0(0);
if not (sql%found) then
INSERT INTO OR_ACT_BY_TASK_MOD(ACT_BY_TASK_MOD_ID,TASK_CODE,CONFIG_EXPRESSION_ID,MODULE_ID,ITEMS_ID) 
VALUES (EXP_UNITTYPE_100564_.tb2_0(0),
EXP_UNITTYPE_100564_.tb2_1(0),
null,
9,
4295217);
end if;

exception when others then
EXP_UNITTYPE_100564_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100563',1);
EXP_PROCESS_100563_.blProcessStatus := EXP_UNITTYPE_100564_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/

DECLARE
 nuIndex         binary_integer;
 blObjectDeleted boolean;

 FUNCTION fblIsObjectUseByRule
 (
  isbObjectName   IN gr_config_expression.object_name%type
 ) return BOOLEAN
 IS
  nuCounter    NUMBER := 0;
  blReturn     BOOLEAN := FALSE;
 BEGIN
  SELECT count('x') INTO nuCounter
  FROM gr_config_expression
  WHERE object_name = isbObjectName;
  IF (nuCounter > 0) THEN
    BEGIN
      DELETE FROM gr_config_expression
      WHERE object_name = isbObjectName;
      blReturn := FALSE;
    EXCEPTION
      when ex.RECORD_HAVE_CHILDREN then
         ut_trace.trace('Objeto ' || isbObjectName || ' usado en ' || nuCounter ||' reglas, no se borra',2);
         blReturn := TRUE;
    END;
  END IF;
  RETURN blReturn;
 END;

BEGIN
 ut_trace.trace('Inicia borrado de objetos de reglas',1);
 nuIndex := EXP_UNITTYPE_100564_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_UNITTYPE_100564_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_UNITTYPE_100564_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_UNITTYPE_100564_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_UNITTYPE_100564_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_UNITTYPE_100564_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_UNITTYPE_100564_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_UNITTYPE_100564_.tbObjectToDelete.next(nuIndex);
 END loop;
 ut_trace.trace('Finaliza borrado de objetos de reglas',1);
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('EXP_UNITTYPE_100564_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_UNITTYPE_100564_******************************'); end;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100559',1);
EXP_PROCESS_100559_.blProcessStatus := EXP_PROCESS_100563_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
DECLARE 
    nuBinaryIndex Binary_Integer;
BEGIN 
    nuBinaryIndex := EXP_PROCESS_100563_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = EXP_PROCESS_100563_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||EXP_PROCESS_100563_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||EXP_PROCESS_100563_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := EXP_PROCESS_100563_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       EXP_PROCESS_100563_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 


DECLARE
 nuIndex         binary_integer;
 blObjectDeleted boolean;

 FUNCTION fblIsObjectUseByRule
 (
  isbObjectName   IN gr_config_expression.object_name%type
 ) return BOOLEAN
 IS
  nuCounter    NUMBER := 0;
  blReturn     BOOLEAN := FALSE;
 BEGIN
  SELECT count('x') INTO nuCounter
  FROM gr_config_expression
  WHERE object_name = isbObjectName;
  IF (nuCounter > 0) THEN
    BEGIN
      DELETE FROM gr_config_expression
      WHERE object_name = isbObjectName;
      blReturn := FALSE;
    EXCEPTION
      when ex.RECORD_HAVE_CHILDREN then
         ut_trace.trace('Objeto ' || isbObjectName || ' usado en ' || nuCounter ||' reglas, no se borra',2);
         blReturn := TRUE;
    END;
  END IF;
  RETURN blReturn;
 END;

BEGIN
 ut_trace.trace('Inicia borrado de objetos de reglas',1);
 nuIndex := EXP_PROCESS_100563_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_PROCESS_100563_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_PROCESS_100563_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_PROCESS_100563_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_PROCESS_100563_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_PROCESS_100563_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_PROCESS_100563_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_PROCESS_100563_.tbObjectToDelete.next(nuIndex);
 END loop;
 ut_trace.trace('Finaliza borrado de objetos de reglas',1);
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
END;
/


COMMIT
/

begin
SA_BOCreatePackages.DropPackage('EXP_PROCESS_100563_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_PROCESS_100563_******************************'); end;
/

BEGIN
ut_trace.trace('Realizar Commit del Flujo',1);
if ( not EXP_PROCESS_100559_.blProcessStatus) then
 return;
 end if;
ut_trace.trace('Realizar Commit de EXP_PROCESS_100559 ',1);
COMMIT;
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
DECLARE 
    nuBinaryIndex Binary_Integer;
BEGIN 
    nuBinaryIndex := EXP_PROCESS_100559_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = EXP_PROCESS_100559_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||EXP_PROCESS_100559_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||EXP_PROCESS_100559_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := EXP_PROCESS_100559_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       EXP_PROCESS_100559_.blProcessStatus := FALSE;
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

if (not EXP_PROCESS_100559_.blProcessStatus) then
 return;
end if;
nuRowProcess:=EXP_PROCESS_100559_.tb7_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| EXP_PROCESS_100559_.tb7_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(EXP_PROCESS_100559_.tb7_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| EXP_PROCESS_100559_.tb7_0(nuRowProcess),1);
end;
nuRowProcess := EXP_PROCESS_100559_.tb7_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
EXP_PROCESS_100559_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

DECLARE
 nuIndex         binary_integer;
 blObjectDeleted boolean;

 FUNCTION fblIsObjectUseByRule
 (
  isbObjectName   IN gr_config_expression.object_name%type
 ) return BOOLEAN
 IS
  nuCounter    NUMBER := 0;
  blReturn     BOOLEAN := FALSE;
 BEGIN
  SELECT count('x') INTO nuCounter
  FROM gr_config_expression
  WHERE object_name = isbObjectName;
  IF (nuCounter > 0) THEN
    BEGIN
      DELETE FROM gr_config_expression
      WHERE object_name = isbObjectName;
      blReturn := FALSE;
    EXCEPTION
      when ex.RECORD_HAVE_CHILDREN then
         ut_trace.trace('Objeto ' || isbObjectName || ' usado en ' || nuCounter ||' reglas, no se borra',2);
         blReturn := TRUE;
    END;
  END IF;
  RETURN blReturn;
 END;

BEGIN
 ut_trace.trace('Inicia borrado de objetos de reglas',1);
 nuIndex := EXP_PROCESS_100559_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_PROCESS_100559_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_PROCESS_100559_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_PROCESS_100559_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_PROCESS_100559_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_PROCESS_100559_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_PROCESS_100559_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_PROCESS_100559_.tbObjectToDelete.next(nuIndex);
 END loop;
 ut_trace.trace('Finaliza borrado de objetos de reglas',1);
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza borrado de objetos: ' || sqlerrm);
END;
/


begin
SA_BOCreatePackages.DropPackage('EXP_PROCESS_100559_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_PROCESS_100559_******************************'); end;
/



