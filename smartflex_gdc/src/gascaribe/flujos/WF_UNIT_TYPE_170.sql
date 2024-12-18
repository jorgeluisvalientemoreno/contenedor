BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_PROCESS_170_',
'CREATE OR REPLACE PACKAGE EXP_PROCESS_170_ IS ' || chr(10) ||
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
'tb5_7 ty5_7;type ty6_0 is table of WF_TRANSITION.TRANS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_0 ty6_0; ' || chr(10) ||
'tb6_0 ty6_0;type ty6_1 is table of WF_TRANSITION.ORIGIN_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_1 ty6_1; ' || chr(10) ||
'tb6_1 ty6_1;type ty6_2 is table of WF_TRANSITION.TARGET_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_2 ty6_2; ' || chr(10) ||
'tb6_2 ty6_2;type ty7_0 is table of GE_ATTRIBUTE_CLASS.ATTRIBUTE_CLASS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_0 ty7_0; ' || chr(10) ||
'tb7_0 ty7_0;type ty8_0 is table of GE_ATTRIBUTES_TYPE.ATTRIBUTE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_0 ty8_0; ' || chr(10) ||
'tb8_0 ty8_0;type ty9_0 is table of GE_ATTRIBUTES.ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb9_0 ty9_0; ' || chr(10) ||
'tb9_0 ty9_0;type ty9_1 is table of GE_ATTRIBUTES.ATTRIBUTE_CLASS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb9_1 ty9_1; ' || chr(10) ||
'tb9_1 ty9_1;type ty9_2 is table of GE_ATTRIBUTES.ATTRIBUTE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb9_2 ty9_2; ' || chr(10) ||
'tb9_2 ty9_2;type ty10_0 is table of WF_UNIT_ATTRIBUTE.UNIT_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb10_0 ty10_0; ' || chr(10) ||
'tb10_0 ty10_0;type ty10_1 is table of WF_UNIT_ATTRIBUTE.UNIT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb10_1 ty10_1; ' || chr(10) ||
'tb10_1 ty10_1;type ty10_2 is table of WF_UNIT_ATTRIBUTE.ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb10_2 ty10_2; ' || chr(10) ||
'tb10_2 ty10_2;type ty10_3 is table of WF_UNIT_ATTRIBUTE.STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb10_3 ty10_3; ' || chr(10) ||
'tb10_3 ty10_3;type ty11_0 is table of GE_STATEMENT.STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb11_0 ty11_0; ' || chr(10) ||
'tb11_0 ty11_0; ' || chr(10) ||
'CURSOR cuExpression is ' || chr(10) ||
'SELECT PRE_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_TYPE_ID = 170 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID IN  ' || chr(10) ||
'           (SELECT UNIT_ID ' || chr(10) ||
'           FROM WF_UNIT ' || chr(10) ||
'           WHERE UNIT_TYPE_ID = 170 ' || chr(10) ||
'       )) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_TYPE_ID = 170 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID IN  ' || chr(10) ||
'           (SELECT UNIT_ID ' || chr(10) ||
'           FROM WF_UNIT ' || chr(10) ||
'           WHERE UNIT_TYPE_ID = 170 ' || chr(10) ||
'       )) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_PROCESS_170_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_PROCESS_170_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open EXP_PROCESS_170_.cuExpression;
   fetch EXP_PROCESS_170_.cuExpression bulk collect INTO EXP_PROCESS_170_.tbGR_CONFIG_EXPRESSIONId;
   close EXP_PROCESS_170_.cuExpression;
END;
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
sa_bocreatePackages.CreatePackage('DEL_ROOT_274_',
'CREATE OR REPLACE PACKAGE DEL_ROOT_274_ IS ' || chr(10) ||
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
'        WHERE UNIT_ID = 274 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 274  ' || chr(10) ||
'       ) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_ID = 274 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 274  ' || chr(10) ||
'       ) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END DEL_ROOT_274_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:DEL_ROOT_274_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open DEL_ROOT_274_.cuExpression;
   fetch DEL_ROOT_274_.cuExpression bulk collect INTO DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONId;
   close DEL_ROOT_274_.cuExpression;
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
        WHERE UNIT_ID = 274
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID = 274 
       )
;
BEGIN

if (not DEL_ROOT_274_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  DEL_ROOT_274_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE PROCESS_ID = 274);
BEGIN 

if (not DEL_ROOT_274_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_274_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE PROCESS_ID = 274);
BEGIN 

if (not DEL_ROOT_274_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_274_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 274)));
BEGIN 

if (not DEL_ROOT_274_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_274_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 274)));
BEGIN 

if (not DEL_ROOT_274_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_274_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 274));
BEGIN 

if (not DEL_ROOT_274_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla WF_UNIT',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_274_.tbWF_UNITRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_274_.blProcessStatus := false;
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
FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 274);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_274_.blProcessStatus) then
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
DEL_ROOT_274_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_274_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_274_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_274_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_274_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_274_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria WF_UNIT',1);
nuVarcharIndex:=DEL_ROOT_274_.tbWF_UNITRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from WF_UNIT where rowid = DEL_ROOT_274_.tbWF_UNITRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_274_.tbWF_UNITRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_274_.tbWF_UNITRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_274_.blProcessStatus := false;
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
FROM WF_UNIT_DATA_MAP WHERE (SOURCE_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 274));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_274_.blProcessStatus) then
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
DEL_ROOT_274_.blProcessStatus := false;
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
FROM WF_UNIT_DATA_MAP WHERE (TARGET_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 274));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_274_.blProcessStatus) then
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
DEL_ROOT_274_.blProcessStatus := false;
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
FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 274);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_274_.blProcessStatus) then
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
DEL_ROOT_274_.blProcessStatus := false;
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
FROM WF_UNIT WHERE PROCESS_ID = 274;
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_274_.blProcessStatus) then
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
DEL_ROOT_274_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_274_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_274_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_274_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_274_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/

BEGIN
    ut_trace.trace('Actualizar WF_UNIT a ProcessId NULL ',1);
   UPDATE WF_UNIT 
     SET PROCESS_ID = -1, POS_EXPRESSION_ID = null, PRE_EXPRESSION_ID = null, ACTION_ID = null 
     WHERE PROCESS_ID = 274;
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
    nuBinaryIndex := DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       DEL_ROOT_274_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_170',1);
EXP_PROCESS_170_.blProcessStatus := DEL_ROOT_274_.blProcessStatus ; 
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
 nuIndex := DEL_ROOT_274_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || DEL_ROOT_274_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(DEL_ROOT_274_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(DEL_ROOT_274_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(DEL_ROOT_274_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || DEL_ROOT_274_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || DEL_ROOT_274_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := DEL_ROOT_274_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('DEL_ROOT_274_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:DEL_ROOT_274_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('DEL_ROOT_274_',
'CREATE OR REPLACE PACKAGE DEL_ROOT_274_ IS ' || chr(10) ||
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
'        WHERE UNIT_ID = 274 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 274  ' || chr(10) ||
'       ) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_ID = 274 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 274  ' || chr(10) ||
'       ) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END DEL_ROOT_274_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:DEL_ROOT_274_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open DEL_ROOT_274_.cuExpression;
   fetch DEL_ROOT_274_.cuExpression bulk collect INTO DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONId;
   close DEL_ROOT_274_.cuExpression;
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
        WHERE UNIT_ID = 274
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID = 274 
       )
;
BEGIN

if (not DEL_ROOT_274_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  DEL_ROOT_274_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE UNIT_ID = 274);
BEGIN 

if (not DEL_ROOT_274_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_274_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE UNIT_ID = 274);
BEGIN 

if (not DEL_ROOT_274_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_274_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 274)));
BEGIN 

if (not DEL_ROOT_274_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_274_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 274)));
BEGIN 

if (not DEL_ROOT_274_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_274_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 274));
BEGIN 

if (not DEL_ROOT_274_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla WF_UNIT',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_274_.tbWF_UNITRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_274_.blProcessStatus := false;
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
FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 274);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_274_.blProcessStatus) then
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
DEL_ROOT_274_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_274_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_274_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_274_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_274_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_274_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria WF_UNIT',1);
nuVarcharIndex:=DEL_ROOT_274_.tbWF_UNITRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from WF_UNIT where rowid = DEL_ROOT_274_.tbWF_UNITRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_274_.tbWF_UNITRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_274_.tbWF_UNITRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_274_.blProcessStatus := false;
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
FROM WF_UNIT_DATA_MAP WHERE (SOURCE_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 274));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_274_.blProcessStatus) then
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
DEL_ROOT_274_.blProcessStatus := false;
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
FROM WF_UNIT_DATA_MAP WHERE (TARGET_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 274));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_274_.blProcessStatus) then
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
DEL_ROOT_274_.blProcessStatus := false;
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
FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 274);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_274_.blProcessStatus) then
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
DEL_ROOT_274_.blProcessStatus := false;
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
FROM WF_UNIT WHERE UNIT_ID = 274;
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_274_.blProcessStatus) then
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
DEL_ROOT_274_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_274_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_274_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_274_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_274_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/

BEGIN
    ut_trace.trace('Actualizar WF_UNIT a ProcessId NULL ',1);
   UPDATE WF_UNIT 
     SET PROCESS_ID = -1, POS_EXPRESSION_ID = null, PRE_EXPRESSION_ID = null, ACTION_ID = null 
     WHERE PROCESS_ID = 274;
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
    nuBinaryIndex := DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := DEL_ROOT_274_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       DEL_ROOT_274_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_170',1);
EXP_PROCESS_170_.blProcessStatus := DEL_ROOT_274_.blProcessStatus ; 
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
 nuIndex := DEL_ROOT_274_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || DEL_ROOT_274_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(DEL_ROOT_274_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(DEL_ROOT_274_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(DEL_ROOT_274_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || DEL_ROOT_274_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || DEL_ROOT_274_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := DEL_ROOT_274_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('DEL_ROOT_274_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:DEL_ROOT_274_******************************'); end;
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
        WHERE UNIT_TYPE_ID = 170
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID IN 
           (SELECT UNIT_ID
           FROM WF_UNIT
           WHERE UNIT_TYPE_ID = 170
       ))
;
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_PROCESS_170_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=170) AND NODE_TYPE_ID=0);
BEGIN 

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_PROCESS_170_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=170) AND NODE_TYPE_ID=0);
BEGIN 

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_PROCESS_170_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_PROCESS_170_.blProcessStatus := false;
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
FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=170) AND NODE_TYPE_ID=0;
nuIndex binary_integer;
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
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
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_PROCESS_170_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_PROCESS_170_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_PROCESS_170_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_PROCESS_170_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_PROCESS_170_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_PROCESS_170_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_PROCESS_170_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_PROCESS_170_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_PROCESS_170_.blProcessStatus := false;
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
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=170;
nuIndex binary_integer;
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
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
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.tb0_0(0):=3;
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_CATEGORY fila (0)',1);
UPDATE WF_UNIT_CATEGORY SET CATEGORY_ID=EXP_PROCESS_170_.tb0_0(0),
DISPLAY_NUMBER='Proceso Principal'

 WHERE CATEGORY_ID = EXP_PROCESS_170_.tb0_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_CATEGORY(CATEGORY_ID,DISPLAY_NUMBER) 
VALUES (EXP_PROCESS_170_.tb0_0(0),
'Proceso Principal'
);
end if;

exception when others then
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.tb1_0(0):=9;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (0)',1);
UPDATE GE_MODULE SET MODULE_ID=EXP_PROCESS_170_.tb1_0(0),
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

 WHERE MODULE_ID = EXP_PROCESS_170_.tb1_0(0);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (EXP_PROCESS_170_.tb1_0(0),
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
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.tb2_0(0):=170;
EXP_PROCESS_170_.tb2_1(0):=EXP_PROCESS_170_.tb0_0(0);
EXP_PROCESS_170_.tb2_2(0):=EXP_PROCESS_170_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (0)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_170_.tb2_0(0),
CATEGORY_ID=EXP_PROCESS_170_.tb2_1(0),
MODULE_ID=EXP_PROCESS_170_.tb2_2(0),
ACTION_ID=null,
PARENT_ID=983,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_170'
,
DESCRIPTION='Gestión de Daño a Producto'
,
DISPLAY='Gestión de Daño a Producto'
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_170_.tb2_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_170_.tb2_0(0),
EXP_PROCESS_170_.tb2_1(0),
EXP_PROCESS_170_.tb2_2(0),
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_170'
,
'Gestión de Daño a Producto'
,
'Gestión de Daño a Producto'
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
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.tb3_0(0):=21;
EXP_PROCESS_170_.tb3_1(0):=EXP_PROCESS_170_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_ATTRIBUTES_EQUIV fila (0)',1);
UPDATE WF_ATTRIBUTES_EQUIV SET ATTRIBUTES_EQUIV_ID=EXP_PROCESS_170_.tb3_0(0),
UNIT_TYPE_ID=EXP_PROCESS_170_.tb3_1(0),
INTERFACE_CONFIG_ID=21,
STD_TIME=0,
MAX_TIME=31536000,
AVG_TIME=0,
DESCRIPTION='Val1 [59] Val2 []'
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
 WHERE ATTRIBUTES_EQUIV_ID = EXP_PROCESS_170_.tb3_0(0);
if not (sql%found) then
INSERT INTO WF_ATTRIBUTES_EQUIV(ATTRIBUTES_EQUIV_ID,UNIT_TYPE_ID,INTERFACE_CONFIG_ID,STD_TIME,MAX_TIME,AVG_TIME,DESCRIPTION,VALUE_1,VALUE_2,VALUE_3,VALUE_4,VALUE_5,VALUE_6,VALUE_7,VALUE_8,VALUE_9,VALUE_10,VALUE_11,VALUE_12,VALUE_13,VALUE_14,VALUE_15,VALUE_16,VALUE_17,VALUE_18,VALUE_19,VALUE_20) 
VALUES (EXP_PROCESS_170_.tb3_0(0),
EXP_PROCESS_170_.tb3_1(0),
21,
0,
31536000,
0,
'Val1 [59] Val2 []'
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
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.tb3_0(1):=30;
EXP_PROCESS_170_.tb3_1(1):=EXP_PROCESS_170_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_ATTRIBUTES_EQUIV fila (1)',1);
UPDATE WF_ATTRIBUTES_EQUIV SET ATTRIBUTES_EQUIV_ID=EXP_PROCESS_170_.tb3_0(1),
UNIT_TYPE_ID=EXP_PROCESS_170_.tb3_1(1),
INTERFACE_CONFIG_ID=21,
STD_TIME=0,
MAX_TIME=31536000,
AVG_TIME=0,
DESCRIPTION='Registro de Daño a Producto'
,
VALUE_1='59'
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
 WHERE ATTRIBUTES_EQUIV_ID = EXP_PROCESS_170_.tb3_0(1);
if not (sql%found) then
INSERT INTO WF_ATTRIBUTES_EQUIV(ATTRIBUTES_EQUIV_ID,UNIT_TYPE_ID,INTERFACE_CONFIG_ID,STD_TIME,MAX_TIME,AVG_TIME,DESCRIPTION,VALUE_1,VALUE_2,VALUE_3,VALUE_4,VALUE_5,VALUE_6,VALUE_7,VALUE_8,VALUE_9,VALUE_10,VALUE_11,VALUE_12,VALUE_13,VALUE_14,VALUE_15,VALUE_16,VALUE_17,VALUE_18,VALUE_19,VALUE_20) 
VALUES (EXP_PROCESS_170_.tb3_0(1),
EXP_PROCESS_170_.tb3_1(1),
21,
0,
31536000,
0,
'Registro de Daño a Producto'
,
'59'
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
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.tb3_0(2):=100321;
EXP_PROCESS_170_.tb3_1(2):=EXP_PROCESS_170_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_ATTRIBUTES_EQUIV fila (2)',1);
UPDATE WF_ATTRIBUTES_EQUIV SET ATTRIBUTES_EQUIV_ID=EXP_PROCESS_170_.tb3_0(2),
UNIT_TYPE_ID=EXP_PROCESS_170_.tb3_1(2),
INTERFACE_CONFIG_ID=21,
STD_TIME=0,
MAX_TIME=31536000,
AVG_TIME=0,
DESCRIPTION='Registro de Daño a Producto por XML'
,
VALUE_1='100339'
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
 WHERE ATTRIBUTES_EQUIV_ID = EXP_PROCESS_170_.tb3_0(2);
if not (sql%found) then
INSERT INTO WF_ATTRIBUTES_EQUIV(ATTRIBUTES_EQUIV_ID,UNIT_TYPE_ID,INTERFACE_CONFIG_ID,STD_TIME,MAX_TIME,AVG_TIME,DESCRIPTION,VALUE_1,VALUE_2,VALUE_3,VALUE_4,VALUE_5,VALUE_6,VALUE_7,VALUE_8,VALUE_9,VALUE_10,VALUE_11,VALUE_12,VALUE_13,VALUE_14,VALUE_15,VALUE_16,VALUE_17,VALUE_18,VALUE_19,VALUE_20) 
VALUES (EXP_PROCESS_170_.tb3_0(2),
EXP_PROCESS_170_.tb3_1(2),
21,
0,
31536000,
0,
'Registro de Daño a Producto por XML'
,
'100339'
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
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.tb4_0(0):=0;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (0)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_170_.tb4_0(0),
DESCRIPTION='Ra¿z'

 WHERE NODE_TYPE_ID = EXP_PROCESS_170_.tb4_0(0);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_170_.tb4_0(0),
'Ra¿z'
);
end if;

exception when others then
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.tb5_0(0):=274;
EXP_PROCESS_170_.tb5_2(0):=EXP_PROCESS_170_.tb2_0(0);
EXP_PROCESS_170_.tb5_3(0):=EXP_PROCESS_170_.tb4_0(0);
EXP_PROCESS_170_.tb5_4(0):=EXP_PROCESS_170_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (0)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_170_.tb5_0(0),
PROCESS_ID=null,
UNIT_TYPE_ID=EXP_PROCESS_170_.tb5_2(0),
NODE_TYPE_ID=EXP_PROCESS_170_.tb5_3(0),
MODULE_ID=EXP_PROCESS_170_.tb5_4(0),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='20
20'
,
DESCRIPTION='Título'
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

 WHERE UNIT_ID = EXP_PROCESS_170_.tb5_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_170_.tb5_0(0),
null,
EXP_PROCESS_170_.tb5_2(0),
EXP_PROCESS_170_.tb5_3(0),
EXP_PROCESS_170_.tb5_4(0),
null,
null,
null,
null,
'20
20'
,
'Título'
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
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.tb0_0(1):=2;
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_CATEGORY fila (1)',1);
UPDATE WF_UNIT_CATEGORY SET CATEGORY_ID=EXP_PROCESS_170_.tb0_0(1),
DISPLAY_NUMBER='Actividad'

 WHERE CATEGORY_ID = EXP_PROCESS_170_.tb0_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_CATEGORY(CATEGORY_ID,DISPLAY_NUMBER) 
VALUES (EXP_PROCESS_170_.tb0_0(1),
'Actividad'
);
end if;

exception when others then
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.tb2_0(1):=283;
EXP_PROCESS_170_.tb2_1(1):=EXP_PROCESS_170_.tb0_0(1);
EXP_PROCESS_170_.tb2_2(1):=EXP_PROCESS_170_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (1)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_170_.tb2_0(1),
CATEGORY_ID=EXP_PROCESS_170_.tb2_1(1),
MODULE_ID=EXP_PROCESS_170_.tb2_2(1),
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_170_.tb2_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_170_.tb2_0(1),
EXP_PROCESS_170_.tb2_1(1),
EXP_PROCESS_170_.tb2_2(1),
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
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.tb4_0(1):=1;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (1)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_170_.tb4_0(1),
DESCRIPTION='Arranque'

 WHERE NODE_TYPE_ID = EXP_PROCESS_170_.tb4_0(1);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_170_.tb4_0(1),
'Arranque'
);
end if;

exception when others then
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.tb5_0(1):=275;
EXP_PROCESS_170_.tb5_1(1):=EXP_PROCESS_170_.tb5_0(0);
EXP_PROCESS_170_.tb5_2(1):=EXP_PROCESS_170_.tb2_0(1);
EXP_PROCESS_170_.tb5_3(1):=EXP_PROCESS_170_.tb4_0(1);
EXP_PROCESS_170_.tb5_4(1):=EXP_PROCESS_170_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (1)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_170_.tb5_0(1),
PROCESS_ID=EXP_PROCESS_170_.tb5_1(1),
UNIT_TYPE_ID=EXP_PROCESS_170_.tb5_2(1),
NODE_TYPE_ID=EXP_PROCESS_170_.tb5_3(1),
MODULE_ID=EXP_PROCESS_170_.tb5_4(1),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='20
186'
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

 WHERE UNIT_ID = EXP_PROCESS_170_.tb5_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_170_.tb5_0(1),
EXP_PROCESS_170_.tb5_1(1),
EXP_PROCESS_170_.tb5_2(1),
EXP_PROCESS_170_.tb5_3(1),
EXP_PROCESS_170_.tb5_4(1),
null,
null,
null,
null,
'20
186'
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
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.tb0_0(2):=1;
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_CATEGORY fila (2)',1);
UPDATE WF_UNIT_CATEGORY SET CATEGORY_ID=EXP_PROCESS_170_.tb0_0(2),
DISPLAY_NUMBER='Proceso B¿sico'

 WHERE CATEGORY_ID = EXP_PROCESS_170_.tb0_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT_CATEGORY(CATEGORY_ID,DISPLAY_NUMBER) 
VALUES (EXP_PROCESS_170_.tb0_0(2),
'Proceso B¿sico'
);
end if;

exception when others then
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.tb2_0(2):=100556;
EXP_PROCESS_170_.tb2_1(2):=EXP_PROCESS_170_.tb0_0(2);
EXP_PROCESS_170_.tb2_2(2):=EXP_PROCESS_170_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (2)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_170_.tb2_0(2),
CATEGORY_ID=EXP_PROCESS_170_.tb2_1(2),
MODULE_ID=EXP_PROCESS_170_.tb2_2(2),
ACTION_ID=null,
PARENT_ID=983,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_100556'
,
DESCRIPTION='Ordenes de Daño a Producto'
,
DISPLAY='Ordenes de Daño a Producto'
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_170_.tb2_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_170_.tb2_0(2),
EXP_PROCESS_170_.tb2_1(2),
EXP_PROCESS_170_.tb2_2(2),
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_100556'
,
'Ordenes de Daño a Producto'
,
'Ordenes de Daño a Producto'
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
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.tb4_0(2):=2;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (2)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_170_.tb4_0(2),
DESCRIPTION='Normal'

 WHERE NODE_TYPE_ID = EXP_PROCESS_170_.tb4_0(2);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_170_.tb4_0(2),
'Normal'
);
end if;

exception when others then
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.tb5_0(2):=102689;
EXP_PROCESS_170_.tb5_1(2):=EXP_PROCESS_170_.tb5_0(0);
EXP_PROCESS_170_.tb5_2(2):=EXP_PROCESS_170_.tb2_0(2);
EXP_PROCESS_170_.tb5_3(2):=EXP_PROCESS_170_.tb4_0(2);
EXP_PROCESS_170_.tb5_4(2):=EXP_PROCESS_170_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (2)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_170_.tb5_0(2),
PROCESS_ID=EXP_PROCESS_170_.tb5_1(2),
UNIT_TYPE_ID=EXP_PROCESS_170_.tb5_2(2),
NODE_TYPE_ID=EXP_PROCESS_170_.tb5_3(2),
MODULE_ID=EXP_PROCESS_170_.tb5_4(2),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='283
174'
,
DESCRIPTION='Ordenes de Daño a Producto'
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

 WHERE UNIT_ID = EXP_PROCESS_170_.tb5_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_170_.tb5_0(2),
EXP_PROCESS_170_.tb5_1(2),
EXP_PROCESS_170_.tb5_2(2),
EXP_PROCESS_170_.tb5_3(2),
EXP_PROCESS_170_.tb5_4(2),
null,
null,
null,
null,
'283
174'
,
'Ordenes de Daño a Producto'
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
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.tb6_0(0):=100000697;
EXP_PROCESS_170_.tb6_1(0):=EXP_PROCESS_170_.tb5_0(1);
EXP_PROCESS_170_.tb6_2(0):=EXP_PROCESS_170_.tb5_0(2);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (0)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_170_.tb6_0(0),
ORIGIN_ID=EXP_PROCESS_170_.tb6_1(0),
TARGET_ID=EXP_PROCESS_170_.tb6_2(0),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION='FLAG_VALIDATE == NO'
,
EXPRESSION_TYPE=0,
DESCRIPTION='NO se atiende inmediatamente'
,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_170_.tb6_0(0);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_170_.tb6_0(0),
EXP_PROCESS_170_.tb6_1(0),
EXP_PROCESS_170_.tb6_2(0),
null,
0,
'FLAG_VALIDATE == NO'
,
0,
'NO se atiende inmediatamente'
,
1);
end if;

exception when others then
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.tb2_0(3):=100540;
EXP_PROCESS_170_.tb2_1(3):=EXP_PROCESS_170_.tb0_0(2);
EXP_PROCESS_170_.tb2_2(3):=EXP_PROCESS_170_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (3)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_170_.tb2_0(3),
CATEGORY_ID=EXP_PROCESS_170_.tb2_1(3),
MODULE_ID=EXP_PROCESS_170_.tb2_2(3),
ACTION_ID=null,
PARENT_ID=983,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_100540'
,
DESCRIPTION='Atender Daño a Producto'
,
DISPLAY='Atender Daño a Producto'
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_170_.tb2_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_170_.tb2_0(3),
EXP_PROCESS_170_.tb2_1(3),
EXP_PROCESS_170_.tb2_2(3),
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_100540'
,
'Atender Daño a Producto'
,
'Atender Daño a Producto'
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
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.tb5_0(3):=102644;
EXP_PROCESS_170_.tb5_1(3):=EXP_PROCESS_170_.tb5_0(0);
EXP_PROCESS_170_.tb5_2(3):=EXP_PROCESS_170_.tb2_0(3);
EXP_PROCESS_170_.tb5_3(3):=EXP_PROCESS_170_.tb4_0(2);
EXP_PROCESS_170_.tb5_4(3):=EXP_PROCESS_170_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (3)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_170_.tb5_0(3),
PROCESS_ID=EXP_PROCESS_170_.tb5_1(3),
UNIT_TYPE_ID=EXP_PROCESS_170_.tb5_2(3),
NODE_TYPE_ID=EXP_PROCESS_170_.tb5_3(3),
MODULE_ID=EXP_PROCESS_170_.tb5_4(3),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='531
182'
,
DESCRIPTION='Atender Daño a Producto'
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

 WHERE UNIT_ID = EXP_PROCESS_170_.tb5_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_170_.tb5_0(3),
EXP_PROCESS_170_.tb5_1(3),
EXP_PROCESS_170_.tb5_2(3),
EXP_PROCESS_170_.tb5_3(3),
EXP_PROCESS_170_.tb5_4(3),
null,
null,
null,
null,
'531
182'
,
'Atender Daño a Producto'
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
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.tb6_0(1):=100000619;
EXP_PROCESS_170_.tb6_1(1):=EXP_PROCESS_170_.tb5_0(1);
EXP_PROCESS_170_.tb6_2(1):=EXP_PROCESS_170_.tb5_0(3);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (1)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_170_.tb6_0(1),
ORIGIN_ID=EXP_PROCESS_170_.tb6_1(1),
TARGET_ID=EXP_PROCESS_170_.tb6_2(1),
GEOMETRY='63
123
600
126'
,
GROUP_ID=0,
EXPRESSION='FLAG_VALIDATE == SI'
,
EXPRESSION_TYPE=0,
DESCRIPTION='La solicitud se atiende inmediatamente'
,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_170_.tb6_0(1);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_170_.tb6_0(1),
EXP_PROCESS_170_.tb6_1(1),
EXP_PROCESS_170_.tb6_2(1),
'63
123
600
126'
,
0,
'FLAG_VALIDATE == SI'
,
0,
'La solicitud se atiende inmediatamente'
,
1);
end if;

exception when others then
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.tb7_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTE_CLASS fila (0)',1);
UPDATE GE_ATTRIBUTE_CLASS SET ATTRIBUTE_CLASS_ID=EXP_PROCESS_170_.tb7_0(0),
NAME='De Entitdad'
,
DESCRIPTION='Valores que ser¿n tra¿dos de la tabla base usando old record'

 WHERE ATTRIBUTE_CLASS_ID = EXP_PROCESS_170_.tb7_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTE_CLASS(ATTRIBUTE_CLASS_ID,NAME,DESCRIPTION) 
VALUES (EXP_PROCESS_170_.tb7_0(0),
'De Entitdad'
,
'Valores que ser¿n tra¿dos de la tabla base usando old record'
);
end if;

exception when others then
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.tb8_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES_TYPE fila (0)',1);
UPDATE GE_ATTRIBUTES_TYPE SET ATTRIBUTE_TYPE_ID=EXP_PROCESS_170_.tb8_0(0),
DESCRIPTION='NUMBER'
,
INTERNAL_TYPE=2,
INTERNAL_JAVA_TYPE=2
 WHERE ATTRIBUTE_TYPE_ID = EXP_PROCESS_170_.tb8_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES_TYPE(ATTRIBUTE_TYPE_ID,DESCRIPTION,INTERNAL_TYPE,INTERNAL_JAVA_TYPE) 
VALUES (EXP_PROCESS_170_.tb8_0(0),
'NUMBER'
,
2,
2);
end if;

exception when others then
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.tb9_0(0):=400;
EXP_PROCESS_170_.tb9_1(0):=EXP_PROCESS_170_.tb7_0(0);
EXP_PROCESS_170_.tb9_2(0):=EXP_PROCESS_170_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (0)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=EXP_PROCESS_170_.tb9_0(0),
ATTRIBUTE_CLASS_ID=EXP_PROCESS_170_.tb9_1(0),
ATTRIBUTE_TYPE_ID=EXP_PROCESS_170_.tb9_2(0),
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

 WHERE ATTRIBUTE_ID = EXP_PROCESS_170_.tb9_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,ATTRIBUTE_CLASS_ID,ATTRIBUTE_TYPE_ID,VALID_EXPRESSION,FATHER_ID,MODULE_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (EXP_PROCESS_170_.tb9_0(0),
EXP_PROCESS_170_.tb9_1(0),
EXP_PROCESS_170_.tb9_2(0),
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
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.tb10_0(0):=133301;
EXP_PROCESS_170_.tb10_1(0):=EXP_PROCESS_170_.tb5_0(1);
EXP_PROCESS_170_.tb10_2(0):=EXP_PROCESS_170_.tb9_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (0)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_170_.tb10_0(0),
UNIT_ID=EXP_PROCESS_170_.tb10_1(0),
ATTRIBUTE_ID=EXP_PROCESS_170_.tb10_2(0),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_170_.tb10_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_170_.tb10_0(0),
EXP_PROCESS_170_.tb10_1(0),
EXP_PROCESS_170_.tb10_2(0),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.tb7_0(1):=8;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTE_CLASS fila (1)',1);
UPDATE GE_ATTRIBUTE_CLASS SET ATTRIBUTE_CLASS_ID=EXP_PROCESS_170_.tb7_0(1),
NAME='Por Defecto General'
,
DESCRIPTION='Valores que ser¿n utilizados para clasificaci¿n gen¿rica'

 WHERE ATTRIBUTE_CLASS_ID = EXP_PROCESS_170_.tb7_0(1);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTE_CLASS(ATTRIBUTE_CLASS_ID,NAME,DESCRIPTION) 
VALUES (EXP_PROCESS_170_.tb7_0(1),
'Por Defecto General'
,
'Valores que ser¿n utilizados para clasificaci¿n gen¿rica'
);
end if;

exception when others then
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.tb9_0(1):=442;
EXP_PROCESS_170_.tb9_1(1):=EXP_PROCESS_170_.tb7_0(1);
EXP_PROCESS_170_.tb9_2(1):=EXP_PROCESS_170_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (1)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=EXP_PROCESS_170_.tb9_0(1),
ATTRIBUTE_CLASS_ID=EXP_PROCESS_170_.tb9_1(1),
ATTRIBUTE_TYPE_ID=EXP_PROCESS_170_.tb9_2(1),
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

 WHERE ATTRIBUTE_ID = EXP_PROCESS_170_.tb9_0(1);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,ATTRIBUTE_CLASS_ID,ATTRIBUTE_TYPE_ID,VALID_EXPRESSION,FATHER_ID,MODULE_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (EXP_PROCESS_170_.tb9_0(1),
EXP_PROCESS_170_.tb9_1(1),
EXP_PROCESS_170_.tb9_2(1),
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
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.old_tb11_0(0):=120182709;
EXP_PROCESS_170_.tb11_0(0):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
EXP_PROCESS_170_.tb11_0(0):=EXP_PROCESS_170_.tb11_0(0);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (0)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (EXP_PROCESS_170_.tb11_0(0),
5,
'Valida si atiende la solicitud inmediatamente, si se ingreso respuesta en el registro'
,
'SELECT decode(answer_id,null,0,1) FLAG_VALIDATE FROM mo_motive
WHERE PACKAGE_id = :INST.EXTERNAL_ID:'
,
'Valida si atiende la solicitud inmediatamente'
);

exception when others then
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.tb10_0(1):=133386;
EXP_PROCESS_170_.tb10_1(1):=EXP_PROCESS_170_.tb5_0(1);
EXP_PROCESS_170_.tb10_2(1):=EXP_PROCESS_170_.tb9_0(1);
EXP_PROCESS_170_.tb10_3(1):=EXP_PROCESS_170_.tb11_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (1)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_170_.tb10_0(1),
UNIT_ID=EXP_PROCESS_170_.tb10_1(1),
ATTRIBUTE_ID=EXP_PROCESS_170_.tb10_2(1),
STATEMENT_ID=EXP_PROCESS_170_.tb10_3(1),
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='Y'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_170_.tb10_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_170_.tb10_0(1),
EXP_PROCESS_170_.tb10_1(1),
EXP_PROCESS_170_.tb10_2(1),
EXP_PROCESS_170_.tb10_3(1),
null,
'N'
,
2,
'Y'
);
end if;

exception when others then
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.tb2_0(4):=316;
EXP_PROCESS_170_.tb2_1(4):=EXP_PROCESS_170_.tb0_0(2);
EXP_PROCESS_170_.tb2_2(4):=EXP_PROCESS_170_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (4)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_170_.tb2_0(4),
CATEGORY_ID=EXP_PROCESS_170_.tb2_1(4),
MODULE_ID=EXP_PROCESS_170_.tb2_2(4),
ACTION_ID=null,
PARENT_ID=983,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_316'
,
DESCRIPTION='Proceso de Distribución de Cargos'
,
DISPLAY='Proceso de Distribución de Cargos'
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_170_.tb2_0(4);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_170_.tb2_0(4),
EXP_PROCESS_170_.tb2_1(4),
EXP_PROCESS_170_.tb2_2(4),
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_316'
,
'Proceso de Distribución de Cargos'
,
'Proceso de Distribución de Cargos'
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
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.tb5_0(4):=620;
EXP_PROCESS_170_.tb5_1(4):=EXP_PROCESS_170_.tb5_0(0);
EXP_PROCESS_170_.tb5_2(4):=EXP_PROCESS_170_.tb2_0(4);
EXP_PROCESS_170_.tb5_3(4):=EXP_PROCESS_170_.tb4_0(2);
EXP_PROCESS_170_.tb5_4(4):=EXP_PROCESS_170_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (4)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_170_.tb5_0(4),
PROCESS_ID=EXP_PROCESS_170_.tb5_1(4),
UNIT_TYPE_ID=EXP_PROCESS_170_.tb5_2(4),
NODE_TYPE_ID=EXP_PROCESS_170_.tb5_3(4),
MODULE_ID=EXP_PROCESS_170_.tb5_4(4),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='280
427'
,
DESCRIPTION='Proceso de Distribución de Cargos'
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

 WHERE UNIT_ID = EXP_PROCESS_170_.tb5_0(4);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_170_.tb5_0(4),
EXP_PROCESS_170_.tb5_1(4),
EXP_PROCESS_170_.tb5_2(4),
EXP_PROCESS_170_.tb5_3(4),
EXP_PROCESS_170_.tb5_4(4),
null,
null,
null,
null,
'280
427'
,
'Proceso de Distribución de Cargos'
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
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.tb6_0(2):=100000699;
EXP_PROCESS_170_.tb6_1(2):=EXP_PROCESS_170_.tb5_0(2);
EXP_PROCESS_170_.tb6_2(2):=EXP_PROCESS_170_.tb5_0(4);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (2)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_170_.tb6_0(2),
ORIGIN_ID=EXP_PROCESS_170_.tb6_1(2),
TARGET_ID=EXP_PROCESS_170_.tb6_2(2),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION='FLAG_VALIDATE == NO'
,
EXPRESSION_TYPE=0,
DESCRIPTION='Daño NO absorbido por otro'
,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_170_.tb6_0(2);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_170_.tb6_0(2),
EXP_PROCESS_170_.tb6_1(2),
EXP_PROCESS_170_.tb6_2(2),
null,
0,
'FLAG_VALIDATE == NO'
,
0,
'Daño NO absorbido por otro'
,
1);
end if;

exception when others then
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.tb6_0(3):=100000698;
EXP_PROCESS_170_.tb6_1(3):=EXP_PROCESS_170_.tb5_0(2);
EXP_PROCESS_170_.tb6_2(3):=EXP_PROCESS_170_.tb5_0(3);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (3)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_170_.tb6_0(3),
ORIGIN_ID=EXP_PROCESS_170_.tb6_1(3),
TARGET_ID=EXP_PROCESS_170_.tb6_2(3),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION='FLAG_VALIDATE == SI'
,
EXPRESSION_TYPE=0,
DESCRIPTION='Daño absorbido por otro'
,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_170_.tb6_0(3);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_170_.tb6_0(3),
EXP_PROCESS_170_.tb6_1(3),
EXP_PROCESS_170_.tb6_2(3),
null,
0,
'FLAG_VALIDATE == SI'
,
0,
'Daño absorbido por otro'
,
1);
end if;

exception when others then
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.old_tb11_0(1):=120182710;
EXP_PROCESS_170_.tb11_0(1):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
EXP_PROCESS_170_.tb11_0(1):=EXP_PROCESS_170_.tb11_0(1);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (1)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (EXP_PROCESS_170_.tb11_0(1),
5,
'Valida si el daño se encuentra'
,
'SELECT CC_BOProductDamage.fnuIsDamageAbsorbed(:INST.EXTERNAL_ID:) FLAG_VALIDATE FROM dual'
,
'Valida si el daño se encuentra'
);

exception when others then
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.tb10_0(2):=100000648;
EXP_PROCESS_170_.tb10_1(2):=EXP_PROCESS_170_.tb5_0(2);
EXP_PROCESS_170_.tb10_2(2):=EXP_PROCESS_170_.tb9_0(1);
EXP_PROCESS_170_.tb10_3(2):=EXP_PROCESS_170_.tb11_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (2)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_170_.tb10_0(2),
UNIT_ID=EXP_PROCESS_170_.tb10_1(2),
ATTRIBUTE_ID=EXP_PROCESS_170_.tb10_2(2),
STATEMENT_ID=EXP_PROCESS_170_.tb10_3(2),
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='Y'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_170_.tb10_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_170_.tb10_0(2),
EXP_PROCESS_170_.tb10_1(2),
EXP_PROCESS_170_.tb10_2(2),
EXP_PROCESS_170_.tb10_3(2),
null,
'N'
,
2,
'Y'
);
end if;

exception when others then
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.tb2_0(5):=252;
EXP_PROCESS_170_.tb2_1(5):=EXP_PROCESS_170_.tb0_0(1);
EXP_PROCESS_170_.tb2_2(5):=EXP_PROCESS_170_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (5)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_170_.tb2_0(5),
CATEGORY_ID=EXP_PROCESS_170_.tb2_1(5),
MODULE_ID=EXP_PROCESS_170_.tb2_2(5),
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_170_.tb2_0(5);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_170_.tb2_0(5),
EXP_PROCESS_170_.tb2_1(5),
EXP_PROCESS_170_.tb2_2(5),
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
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.tb4_0(3):=3;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (3)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_170_.tb4_0(3),
DESCRIPTION='Final'

 WHERE NODE_TYPE_ID = EXP_PROCESS_170_.tb4_0(3);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_170_.tb4_0(3),
'Final'
);
end if;

exception when others then
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.tb5_0(5):=276;
EXP_PROCESS_170_.tb5_1(5):=EXP_PROCESS_170_.tb5_0(0);
EXP_PROCESS_170_.tb5_2(5):=EXP_PROCESS_170_.tb2_0(5);
EXP_PROCESS_170_.tb5_3(5):=EXP_PROCESS_170_.tb4_0(3);
EXP_PROCESS_170_.tb5_4(5):=EXP_PROCESS_170_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (5)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_170_.tb5_0(5),
PROCESS_ID=EXP_PROCESS_170_.tb5_1(5),
UNIT_TYPE_ID=EXP_PROCESS_170_.tb5_2(5),
NODE_TYPE_ID=EXP_PROCESS_170_.tb5_3(5),
MODULE_ID=EXP_PROCESS_170_.tb5_4(5),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='699
191'
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

 WHERE UNIT_ID = EXP_PROCESS_170_.tb5_0(5);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_170_.tb5_0(5),
EXP_PROCESS_170_.tb5_1(5),
EXP_PROCESS_170_.tb5_2(5),
EXP_PROCESS_170_.tb5_3(5),
EXP_PROCESS_170_.tb5_4(5),
null,
null,
null,
null,
'699
191'
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
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.tb6_0(4):=100000621;
EXP_PROCESS_170_.tb6_1(4):=EXP_PROCESS_170_.tb5_0(3);
EXP_PROCESS_170_.tb6_2(4):=EXP_PROCESS_170_.tb5_0(5);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (4)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_170_.tb6_0(4),
ORIGIN_ID=EXP_PROCESS_170_.tb6_1(4),
TARGET_ID=EXP_PROCESS_170_.tb6_2(4),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION=null,
EXPRESSION_TYPE=0,
DESCRIPTION=null,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_170_.tb6_0(4);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_170_.tb6_0(4),
EXP_PROCESS_170_.tb6_1(4),
EXP_PROCESS_170_.tb6_2(4),
null,
0,
null,
0,
null,
1);
end if;

exception when others then
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.tb2_0(6):=251;
EXP_PROCESS_170_.tb2_1(6):=EXP_PROCESS_170_.tb0_0(2);
EXP_PROCESS_170_.tb2_2(6):=EXP_PROCESS_170_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (6)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_170_.tb2_0(6),
CATEGORY_ID=EXP_PROCESS_170_.tb2_1(6),
MODULE_ID=EXP_PROCESS_170_.tb2_2(6),
ACTION_ID=null,
PARENT_ID=983,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_251'
,
DESCRIPTION='Facturación/ Financiación'
,
DISPLAY='Facturación/ Financiación'
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_170_.tb2_0(6);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_170_.tb2_0(6),
EXP_PROCESS_170_.tb2_1(6),
EXP_PROCESS_170_.tb2_2(6),
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_251'
,
'Facturación/ Financiación'
,
'Facturación/ Financiación'
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
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.tb5_0(6):=468;
EXP_PROCESS_170_.tb5_1(6):=EXP_PROCESS_170_.tb5_0(0);
EXP_PROCESS_170_.tb5_2(6):=EXP_PROCESS_170_.tb2_0(6);
EXP_PROCESS_170_.tb5_3(6):=EXP_PROCESS_170_.tb4_0(2);
EXP_PROCESS_170_.tb5_4(6):=EXP_PROCESS_170_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (6)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_170_.tb5_0(6),
PROCESS_ID=EXP_PROCESS_170_.tb5_1(6),
UNIT_TYPE_ID=EXP_PROCESS_170_.tb5_2(6),
NODE_TYPE_ID=EXP_PROCESS_170_.tb5_3(6),
MODULE_ID=EXP_PROCESS_170_.tb5_4(6),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='536
434'
,
DESCRIPTION='Actualización de Condiciones de Financiación'
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

 WHERE UNIT_ID = EXP_PROCESS_170_.tb5_0(6);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_170_.tb5_0(6),
EXP_PROCESS_170_.tb5_1(6),
EXP_PROCESS_170_.tb5_2(6),
EXP_PROCESS_170_.tb5_3(6),
EXP_PROCESS_170_.tb5_4(6),
null,
null,
null,
null,
'536
434'
,
'Actualización de Condiciones de Financiación'
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
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.tb6_0(5):=100000620;
EXP_PROCESS_170_.tb6_1(5):=EXP_PROCESS_170_.tb5_0(6);
EXP_PROCESS_170_.tb6_2(5):=EXP_PROCESS_170_.tb5_0(3);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (5)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_170_.tb6_0(5),
ORIGIN_ID=EXP_PROCESS_170_.tb6_1(5),
TARGET_ID=EXP_PROCESS_170_.tb6_2(5),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION=null,
EXPRESSION_TYPE=0,
DESCRIPTION=null,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_170_.tb6_0(5);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_170_.tb6_0(5),
EXP_PROCESS_170_.tb6_1(5),
EXP_PROCESS_170_.tb6_2(5),
null,
0,
null,
0,
null,
1);
end if;

exception when others then
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.tb6_0(6):=123919;
EXP_PROCESS_170_.tb6_1(6):=EXP_PROCESS_170_.tb5_0(4);
EXP_PROCESS_170_.tb6_2(6):=EXP_PROCESS_170_.tb5_0(6);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (6)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_170_.tb6_0(6),
ORIGIN_ID=EXP_PROCESS_170_.tb6_1(6),
TARGET_ID=EXP_PROCESS_170_.tb6_2(6),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION=null,
EXPRESSION_TYPE=0,
DESCRIPTION=null,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_170_.tb6_0(6);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_170_.tb6_0(6),
EXP_PROCESS_170_.tb6_1(6),
EXP_PROCESS_170_.tb6_2(6),
null,
0,
null,
0,
null,
1);
end if;

exception when others then
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.tb9_0(2):=401;
EXP_PROCESS_170_.tb9_1(2):=EXP_PROCESS_170_.tb7_0(1);
EXP_PROCESS_170_.tb9_2(2):=EXP_PROCESS_170_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (2)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=EXP_PROCESS_170_.tb9_0(2),
ATTRIBUTE_CLASS_ID=EXP_PROCESS_170_.tb9_1(2),
ATTRIBUTE_TYPE_ID=EXP_PROCESS_170_.tb9_2(2),
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

 WHERE ATTRIBUTE_ID = EXP_PROCESS_170_.tb9_0(2);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,ATTRIBUTE_CLASS_ID,ATTRIBUTE_TYPE_ID,VALID_EXPRESSION,FATHER_ID,MODULE_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (EXP_PROCESS_170_.tb9_0(2),
EXP_PROCESS_170_.tb9_1(2),
EXP_PROCESS_170_.tb9_2(2),
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
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.old_tb11_0(2):=120182711;
EXP_PROCESS_170_.tb11_0(2):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
EXP_PROCESS_170_.tb11_0(2):=EXP_PROCESS_170_.tb11_0(2);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (2)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (EXP_PROCESS_170_.tb11_0(2),
9,
'Obtiene el id del motivo del paquete'
,
'SELECT motive_id EXTERNAL_ID
FROM (
    SELECT motive_id
    FROM mo_motive
    WHERE PACKAGE_id = WF_BOCNF_GeneralExpressions.fnuGetPlanPackageId(:INST.PLAN_ID:,:INST.ROOT_EXTERNAL_ID:)
    ORDER BY motiv_recording_date asc)
where rownum = 1'
,
'Obtiene el id del motivo del paquete'
);

exception when others then
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.tb10_0(3):=133674;
EXP_PROCESS_170_.tb10_1(3):=EXP_PROCESS_170_.tb5_0(4);
EXP_PROCESS_170_.tb10_2(3):=EXP_PROCESS_170_.tb9_0(2);
EXP_PROCESS_170_.tb10_3(3):=EXP_PROCESS_170_.tb11_0(2);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (3)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_170_.tb10_0(3),
UNIT_ID=EXP_PROCESS_170_.tb10_1(3),
ATTRIBUTE_ID=EXP_PROCESS_170_.tb10_2(3),
STATEMENT_ID=EXP_PROCESS_170_.tb10_3(3),
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=1,
MANDATORY='Y'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_170_.tb10_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_170_.tb10_0(3),
EXP_PROCESS_170_.tb10_1(3),
EXP_PROCESS_170_.tb10_2(3),
EXP_PROCESS_170_.tb10_3(3),
null,
'N'
,
1,
'Y'
);
end if;

exception when others then
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.tb10_0(4):=133302;
EXP_PROCESS_170_.tb10_1(4):=EXP_PROCESS_170_.tb5_0(5);
EXP_PROCESS_170_.tb10_2(4):=EXP_PROCESS_170_.tb9_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (4)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_170_.tb10_0(4),
UNIT_ID=EXP_PROCESS_170_.tb10_1(4),
ATTRIBUTE_ID=EXP_PROCESS_170_.tb10_2(4),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_170_.tb10_0(4);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_170_.tb10_0(4),
EXP_PROCESS_170_.tb10_1(4),
EXP_PROCESS_170_.tb10_2(4),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_170_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_170_.tb10_0(5):=133303;
EXP_PROCESS_170_.tb10_1(5):=EXP_PROCESS_170_.tb5_0(5);
EXP_PROCESS_170_.tb10_2(5):=EXP_PROCESS_170_.tb9_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (5)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_170_.tb10_0(5),
UNIT_ID=EXP_PROCESS_170_.tb10_1(5),
ATTRIBUTE_ID=EXP_PROCESS_170_.tb10_2(5),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_170_.tb10_0(5);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_170_.tb10_0(5),
EXP_PROCESS_170_.tb10_1(5),
EXP_PROCESS_170_.tb10_2(5),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_170_.blProcessStatus := false;
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
sa_bocreatePackages.CreatePackage('EXP_UNITTYPE_170_',
'CREATE OR REPLACE PACKAGE EXP_UNITTYPE_170_ IS ' || chr(10) ||
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
'END EXP_UNITTYPE_170_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_UNITTYPE_170_******************************'); END;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_UNITTYPE_170',1);
EXP_UNITTYPE_170_.blProcessStatus := EXP_PROCESS_170_.blProcessStatus ; 
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
AND     A.TASK_CODE = 170
 
;
BEGIN

if (not EXP_UNITTYPE_170_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_UNITTYPE_170_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
FROM WF_UNIT_TYPE_ATTRIB WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=170);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_170_.blProcessStatus) then
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
EXP_UNITTYPE_170_.blProcessStatus := false;
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
FROM WF_CAUSAL_UNIT_TYPE WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=170);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_170_.blProcessStatus) then
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
EXP_UNITTYPE_170_.blProcessStatus := false;
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
FROM MO_TIME_UNI_TYP_PRIO WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=170);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_170_.blProcessStatus) then
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
EXP_UNITTYPE_170_.blProcessStatus := false;
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
FROM OR_ACT_BY_TASK_MOD WHERE (TASK_CODE) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=170);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_170_.blProcessStatus) then
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
EXP_UNITTYPE_170_.blProcessStatus := false;
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
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=170;
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_170_.blProcessStatus) then
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
EXP_UNITTYPE_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_UNITTYPE_170_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_170_.tb0_0(0):=170;
ut_trace.trace('insertando tabla sin fallo: WF_UNIT_TYPE fila (0)',1);
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_UNITTYPE_170_.tb0_0(0),
3,
9,
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_170'
,
'Gestión de Daño a Producto'
,
'Gestión de Daño a Producto'
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
EXP_UNITTYPE_170_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_170',1);
EXP_PROCESS_170_.blProcessStatus := EXP_UNITTYPE_170_.blProcessStatus ; 
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
 nuIndex := EXP_UNITTYPE_170_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_UNITTYPE_170_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_UNITTYPE_170_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_UNITTYPE_170_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_UNITTYPE_170_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_UNITTYPE_170_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_UNITTYPE_170_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_UNITTYPE_170_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_UNITTYPE_170_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_UNITTYPE_170_******************************'); end;
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
EXP_UNITTYPE_283_.blProcessStatus := EXP_PROCESS_170_.blProcessStatus ; 
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
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_170',1);
EXP_PROCESS_170_.blProcessStatus := EXP_UNITTYPE_283_.blProcessStatus ; 
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
EXP_UNITTYPE_252_.blProcessStatus := EXP_PROCESS_170_.blProcessStatus ; 
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

EXP_UNITTYPE_252_.tb4_0(0):=100000063;
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

EXP_UNITTYPE_252_.tb4_0(1):=109049;
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
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_170',1);
EXP_PROCESS_170_.blProcessStatus := EXP_UNITTYPE_252_.blProcessStatus ; 
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
sa_bocreatePackages.CreatePackage('EXP_UNITTYPE_100556_',
'CREATE OR REPLACE PACKAGE EXP_UNITTYPE_100556_ IS ' || chr(10) ||
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
'END EXP_UNITTYPE_100556_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_UNITTYPE_100556_******************************'); END;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_UNITTYPE_100556',1);
EXP_UNITTYPE_100556_.blProcessStatus := EXP_PROCESS_170_.blProcessStatus ; 
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
AND     A.TASK_CODE = 100556
 
;
BEGIN

if (not EXP_UNITTYPE_100556_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_UNITTYPE_100556_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
FROM WF_UNIT_TYPE_ATTRIB WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100556);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100556_.blProcessStatus) then
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
EXP_UNITTYPE_100556_.blProcessStatus := false;
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
FROM WF_CAUSAL_UNIT_TYPE WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100556);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100556_.blProcessStatus) then
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
EXP_UNITTYPE_100556_.blProcessStatus := false;
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
FROM MO_TIME_UNI_TYP_PRIO WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100556);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100556_.blProcessStatus) then
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
EXP_UNITTYPE_100556_.blProcessStatus := false;
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
FROM OR_ACT_BY_TASK_MOD WHERE (TASK_CODE) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100556);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100556_.blProcessStatus) then
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
EXP_UNITTYPE_100556_.blProcessStatus := false;
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
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100556;
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100556_.blProcessStatus) then
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
EXP_UNITTYPE_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_UNITTYPE_100556_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100556_.tb0_0(0):=100556;
ut_trace.trace('insertando tabla sin fallo: WF_UNIT_TYPE fila (0)',1);
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_UNITTYPE_100556_.tb0_0(0),
1,
9,
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_100556'
,
'Ordenes de Daño a Producto'
,
'Ordenes de Daño a Producto'
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
EXP_UNITTYPE_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_170',1);
EXP_PROCESS_170_.blProcessStatus := EXP_UNITTYPE_100556_.blProcessStatus ; 
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
 nuIndex := EXP_UNITTYPE_100556_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_UNITTYPE_100556_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_UNITTYPE_100556_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_UNITTYPE_100556_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_UNITTYPE_100556_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_UNITTYPE_100556_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_UNITTYPE_100556_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_UNITTYPE_100556_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_UNITTYPE_100556_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_UNITTYPE_100556_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_UNITTYPE_100540_',
'CREATE OR REPLACE PACKAGE EXP_UNITTYPE_100540_ IS ' || chr(10) ||
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
'END EXP_UNITTYPE_100540_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_UNITTYPE_100540_******************************'); END;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_UNITTYPE_100540',1);
EXP_UNITTYPE_100540_.blProcessStatus := EXP_PROCESS_170_.blProcessStatus ; 
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
AND     A.TASK_CODE = 100540
 
;
BEGIN

if (not EXP_UNITTYPE_100540_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_UNITTYPE_100540_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
FROM WF_UNIT_TYPE_ATTRIB WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100540);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100540_.blProcessStatus) then
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
EXP_UNITTYPE_100540_.blProcessStatus := false;
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
FROM WF_CAUSAL_UNIT_TYPE WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100540);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100540_.blProcessStatus) then
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
EXP_UNITTYPE_100540_.blProcessStatus := false;
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
FROM MO_TIME_UNI_TYP_PRIO WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100540);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100540_.blProcessStatus) then
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
EXP_UNITTYPE_100540_.blProcessStatus := false;
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
FROM OR_ACT_BY_TASK_MOD WHERE (TASK_CODE) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100540);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100540_.blProcessStatus) then
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
EXP_UNITTYPE_100540_.blProcessStatus := false;
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
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100540;
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100540_.blProcessStatus) then
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
EXP_UNITTYPE_100540_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_UNITTYPE_100540_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100540_.tb0_0(0):=100540;
ut_trace.trace('insertando tabla sin fallo: WF_UNIT_TYPE fila (0)',1);
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_UNITTYPE_100540_.tb0_0(0),
1,
9,
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_100540'
,
'Atender Daño a Producto'
,
'Atender Daño a Producto'
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
EXP_UNITTYPE_100540_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_170',1);
EXP_PROCESS_170_.blProcessStatus := EXP_UNITTYPE_100540_.blProcessStatus ; 
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
 nuIndex := EXP_UNITTYPE_100540_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_UNITTYPE_100540_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_UNITTYPE_100540_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_UNITTYPE_100540_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_UNITTYPE_100540_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_UNITTYPE_100540_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_UNITTYPE_100540_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_UNITTYPE_100540_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_UNITTYPE_100540_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_UNITTYPE_100540_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_UNITTYPE_316_',
'CREATE OR REPLACE PACKAGE EXP_UNITTYPE_316_ IS ' || chr(10) ||
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
'END EXP_UNITTYPE_316_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_UNITTYPE_316_******************************'); END;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_UNITTYPE_316',1);
EXP_UNITTYPE_316_.blProcessStatus := EXP_PROCESS_170_.blProcessStatus ; 
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
AND     A.TASK_CODE = 316
 
;
BEGIN

if (not EXP_UNITTYPE_316_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_UNITTYPE_316_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
FROM WF_UNIT_TYPE_ATTRIB WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=316);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_316_.blProcessStatus) then
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
EXP_UNITTYPE_316_.blProcessStatus := false;
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
FROM WF_CAUSAL_UNIT_TYPE WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=316);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_316_.blProcessStatus) then
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
EXP_UNITTYPE_316_.blProcessStatus := false;
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
FROM MO_TIME_UNI_TYP_PRIO WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=316);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_316_.blProcessStatus) then
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
EXP_UNITTYPE_316_.blProcessStatus := false;
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
FROM OR_ACT_BY_TASK_MOD WHERE (TASK_CODE) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=316);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_316_.blProcessStatus) then
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
EXP_UNITTYPE_316_.blProcessStatus := false;
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
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=316;
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_316_.blProcessStatus) then
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
EXP_UNITTYPE_316_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_UNITTYPE_316_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_316_.tb0_0(0):=316;
ut_trace.trace('insertando tabla sin fallo: WF_UNIT_TYPE fila (0)',1);
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_UNITTYPE_316_.tb0_0(0),
1,
9,
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_316'
,
'Proceso de Distribución de Cargos'
,
'Proceso de Distribución de Cargos'
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
EXP_UNITTYPE_316_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_170',1);
EXP_PROCESS_170_.blProcessStatus := EXP_UNITTYPE_316_.blProcessStatus ; 
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
 nuIndex := EXP_UNITTYPE_316_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_UNITTYPE_316_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_UNITTYPE_316_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_UNITTYPE_316_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_UNITTYPE_316_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_UNITTYPE_316_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_UNITTYPE_316_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_UNITTYPE_316_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_UNITTYPE_316_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_UNITTYPE_316_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_UNITTYPE_251_',
'CREATE OR REPLACE PACKAGE EXP_UNITTYPE_251_ IS ' || chr(10) ||
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
'END EXP_UNITTYPE_251_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_UNITTYPE_251_******************************'); END;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_UNITTYPE_251',1);
EXP_UNITTYPE_251_.blProcessStatus := EXP_PROCESS_170_.blProcessStatus ; 
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
AND     A.TASK_CODE = 251
 
;
BEGIN

if (not EXP_UNITTYPE_251_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_UNITTYPE_251_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
FROM WF_UNIT_TYPE_ATTRIB WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=251);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_251_.blProcessStatus) then
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
EXP_UNITTYPE_251_.blProcessStatus := false;
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
FROM WF_CAUSAL_UNIT_TYPE WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=251);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_251_.blProcessStatus) then
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
EXP_UNITTYPE_251_.blProcessStatus := false;
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
FROM MO_TIME_UNI_TYP_PRIO WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=251);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_251_.blProcessStatus) then
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
EXP_UNITTYPE_251_.blProcessStatus := false;
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
FROM OR_ACT_BY_TASK_MOD WHERE (TASK_CODE) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=251);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_251_.blProcessStatus) then
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
EXP_UNITTYPE_251_.blProcessStatus := false;
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
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=251;
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_251_.blProcessStatus) then
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
EXP_UNITTYPE_251_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_UNITTYPE_251_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_251_.tb0_0(0):=251;
ut_trace.trace('insertando tabla sin fallo: WF_UNIT_TYPE fila (0)',1);
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_UNITTYPE_251_.tb0_0(0),
1,
9,
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_251'
,
'Facturación/ Financiación'
,
'Facturación/ Financiación'
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
EXP_UNITTYPE_251_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_170',1);
EXP_PROCESS_170_.blProcessStatus := EXP_UNITTYPE_251_.blProcessStatus ; 
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
 nuIndex := EXP_UNITTYPE_251_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_UNITTYPE_251_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_UNITTYPE_251_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_UNITTYPE_251_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_UNITTYPE_251_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_UNITTYPE_251_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_UNITTYPE_251_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_UNITTYPE_251_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_UNITTYPE_251_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_UNITTYPE_251_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_PROCESS_100556_',
'CREATE OR REPLACE PACKAGE EXP_PROCESS_100556_ IS ' || chr(10) ||
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
'        WHERE UNIT_TYPE_ID = 100556 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID IN  ' || chr(10) ||
'           (SELECT UNIT_ID ' || chr(10) ||
'           FROM WF_UNIT ' || chr(10) ||
'           WHERE UNIT_TYPE_ID = 100556 ' || chr(10) ||
'       )) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_TYPE_ID = 100556 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID IN  ' || chr(10) ||
'           (SELECT UNIT_ID ' || chr(10) ||
'           FROM WF_UNIT ' || chr(10) ||
'           WHERE UNIT_TYPE_ID = 100556 ' || chr(10) ||
'       )) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_PROCESS_100556_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_PROCESS_100556_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open EXP_PROCESS_100556_.cuExpression;
   fetch EXP_PROCESS_100556_.cuExpression bulk collect INTO EXP_PROCESS_100556_.tbGR_CONFIG_EXPRESSIONId;
   close EXP_PROCESS_100556_.cuExpression;
END;
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100556',1);
EXP_PROCESS_100556_.blProcessStatus := EXP_PROCESS_170_.blProcessStatus ; 
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
sa_bocreatePackages.CreatePackage('DEL_ROOT_102682_',
'CREATE OR REPLACE PACKAGE DEL_ROOT_102682_ IS ' || chr(10) ||
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
'        WHERE UNIT_ID = 102682 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 102682  ' || chr(10) ||
'       ) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_ID = 102682 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 102682  ' || chr(10) ||
'       ) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END DEL_ROOT_102682_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:DEL_ROOT_102682_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open DEL_ROOT_102682_.cuExpression;
   fetch DEL_ROOT_102682_.cuExpression bulk collect INTO DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONId;
   close DEL_ROOT_102682_.cuExpression;
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
        WHERE UNIT_ID = 102682
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID = 102682 
       )
;
BEGIN

if (not DEL_ROOT_102682_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  DEL_ROOT_102682_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE PROCESS_ID = 102682);
BEGIN 

if (not DEL_ROOT_102682_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102682_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE PROCESS_ID = 102682);
BEGIN 

if (not DEL_ROOT_102682_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102682_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 102682)));
BEGIN 

if (not DEL_ROOT_102682_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102682_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 102682)));
BEGIN 

if (not DEL_ROOT_102682_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102682_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 102682));
BEGIN 

if (not DEL_ROOT_102682_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla WF_UNIT',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102682_.tbWF_UNITRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102682_.blProcessStatus := false;
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
FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 102682);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102682_.blProcessStatus) then
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
DEL_ROOT_102682_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102682_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102682_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102682_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102682_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102682_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria WF_UNIT',1);
nuVarcharIndex:=DEL_ROOT_102682_.tbWF_UNITRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from WF_UNIT where rowid = DEL_ROOT_102682_.tbWF_UNITRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102682_.tbWF_UNITRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102682_.tbWF_UNITRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102682_.blProcessStatus := false;
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
FROM WF_UNIT_DATA_MAP WHERE (SOURCE_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 102682));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102682_.blProcessStatus) then
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
DEL_ROOT_102682_.blProcessStatus := false;
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
FROM WF_UNIT_DATA_MAP WHERE (TARGET_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 102682));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102682_.blProcessStatus) then
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
DEL_ROOT_102682_.blProcessStatus := false;
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
FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 102682);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102682_.blProcessStatus) then
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
DEL_ROOT_102682_.blProcessStatus := false;
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
FROM WF_UNIT WHERE PROCESS_ID = 102682;
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102682_.blProcessStatus) then
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
DEL_ROOT_102682_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102682_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102682_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102682_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102682_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/

BEGIN
    ut_trace.trace('Actualizar WF_UNIT a ProcessId NULL ',1);
   UPDATE WF_UNIT 
     SET PROCESS_ID = -1, POS_EXPRESSION_ID = null, PRE_EXPRESSION_ID = null, ACTION_ID = null 
     WHERE PROCESS_ID = 102682;
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
    nuBinaryIndex := DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       DEL_ROOT_102682_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100556',1);
EXP_PROCESS_100556_.blProcessStatus := DEL_ROOT_102682_.blProcessStatus ; 
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
 nuIndex := DEL_ROOT_102682_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || DEL_ROOT_102682_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(DEL_ROOT_102682_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(DEL_ROOT_102682_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(DEL_ROOT_102682_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || DEL_ROOT_102682_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || DEL_ROOT_102682_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := DEL_ROOT_102682_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('DEL_ROOT_102682_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:DEL_ROOT_102682_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('DEL_ROOT_102682_',
'CREATE OR REPLACE PACKAGE DEL_ROOT_102682_ IS ' || chr(10) ||
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
'        WHERE UNIT_ID = 102682 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 102682  ' || chr(10) ||
'       ) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_ID = 102682 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 102682  ' || chr(10) ||
'       ) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END DEL_ROOT_102682_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:DEL_ROOT_102682_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open DEL_ROOT_102682_.cuExpression;
   fetch DEL_ROOT_102682_.cuExpression bulk collect INTO DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONId;
   close DEL_ROOT_102682_.cuExpression;
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
        WHERE UNIT_ID = 102682
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID = 102682 
       )
;
BEGIN

if (not DEL_ROOT_102682_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  DEL_ROOT_102682_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE UNIT_ID = 102682);
BEGIN 

if (not DEL_ROOT_102682_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102682_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE UNIT_ID = 102682);
BEGIN 

if (not DEL_ROOT_102682_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102682_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 102682)));
BEGIN 

if (not DEL_ROOT_102682_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102682_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 102682)));
BEGIN 

if (not DEL_ROOT_102682_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102682_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 102682));
BEGIN 

if (not DEL_ROOT_102682_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla WF_UNIT',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102682_.tbWF_UNITRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102682_.blProcessStatus := false;
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
FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 102682);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102682_.blProcessStatus) then
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
DEL_ROOT_102682_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102682_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102682_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102682_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102682_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102682_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria WF_UNIT',1);
nuVarcharIndex:=DEL_ROOT_102682_.tbWF_UNITRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from WF_UNIT where rowid = DEL_ROOT_102682_.tbWF_UNITRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102682_.tbWF_UNITRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102682_.tbWF_UNITRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102682_.blProcessStatus := false;
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
FROM WF_UNIT_DATA_MAP WHERE (SOURCE_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 102682));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102682_.blProcessStatus) then
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
DEL_ROOT_102682_.blProcessStatus := false;
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
FROM WF_UNIT_DATA_MAP WHERE (TARGET_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 102682));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102682_.blProcessStatus) then
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
DEL_ROOT_102682_.blProcessStatus := false;
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
FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 102682);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102682_.blProcessStatus) then
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
DEL_ROOT_102682_.blProcessStatus := false;
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
FROM WF_UNIT WHERE UNIT_ID = 102682;
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102682_.blProcessStatus) then
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
DEL_ROOT_102682_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102682_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102682_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102682_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102682_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/

BEGIN
    ut_trace.trace('Actualizar WF_UNIT a ProcessId NULL ',1);
   UPDATE WF_UNIT 
     SET PROCESS_ID = -1, POS_EXPRESSION_ID = null, PRE_EXPRESSION_ID = null, ACTION_ID = null 
     WHERE PROCESS_ID = 102682;
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
    nuBinaryIndex := DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := DEL_ROOT_102682_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       DEL_ROOT_102682_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100556',1);
EXP_PROCESS_100556_.blProcessStatus := DEL_ROOT_102682_.blProcessStatus ; 
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
 nuIndex := DEL_ROOT_102682_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || DEL_ROOT_102682_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(DEL_ROOT_102682_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(DEL_ROOT_102682_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(DEL_ROOT_102682_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || DEL_ROOT_102682_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || DEL_ROOT_102682_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := DEL_ROOT_102682_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('DEL_ROOT_102682_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:DEL_ROOT_102682_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_ACTION_196_',
'CREATE OR REPLACE PACKAGE EXP_ACTION_196_ IS ' || chr(10) ||
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
'WHERE  ACTION_ID =196; ' || chr(10) ||
'type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_ACTION_196_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_ACTION_196_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open EXP_ACTION_196_.cuExpression;
   fetch EXP_ACTION_196_.cuExpression bulk collect INTO EXP_ACTION_196_.tbGR_CONFIG_EXPRESSIONId;
   close EXP_ACTION_196_.cuExpression;
END;
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_ACTION_196',1);
EXP_ACTION_196_.blProcessStatus := EXP_PROCESS_100556_.blProcessStatus ; 
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
AND     A.ACTION_ID =196
;
BEGIN

if (not EXP_ACTION_196_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_ACTION_196_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE ACTION_ID=196);
BEGIN 

if (not EXP_ACTION_196_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_ACTION_196_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_ACTION_196_.blProcessStatus := false;
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
FROM GE_ACTION_MODULE WHERE ACTION_ID=196;
nuIndex binary_integer;
BEGIN

if (not EXP_ACTION_196_.blProcessStatus) then
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
EXP_ACTION_196_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_ACTION_196_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_ACTION_196_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_ACTION_196_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_ACTION_196_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_ACTION_196_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_ACTION_196_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_ACTION_196_.blProcessStatus) then
 return;
end if;

EXP_ACTION_196_.tb0_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=EXP_ACTION_196_.tb0_0(0),
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

 WHERE CONFIGURA_TYPE_ID = EXP_ACTION_196_.tb0_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (EXP_ACTION_196_.tb0_0(0),
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
EXP_ACTION_196_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_196_.blProcessStatus) then
 return;
end if;

EXP_ACTION_196_.old_tb1_0(0):=121357856;
EXP_ACTION_196_.tb1_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
EXP_ACTION_196_.tb1_0(0):=EXP_ACTION_196_.tb1_0(0);
EXP_ACTION_196_.old_tb1_1(0):='GE_EXEACTION_CT1E121357856'
;
EXP_ACTION_196_.tb1_1(0):=TO_CHAR(EXP_ACTION_196_.tb1_0(0));
EXP_ACTION_196_.tb1_2(0):=EXP_ACTION_196_.tb0_0(0);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (EXP_ACTION_196_.tb1_0(0),
EXP_ACTION_196_.tb1_1(0),
EXP_ACTION_196_.tb1_2(0),
'nuIdSolicitud = MO_BOINSTANCE_DB.FNUGETPACKIDINSTANCE();GE_BOINSTANCE.GETVALUE("MO_WF_PACK_INTERFAC","ACTIVITY_ID",nuIdInstanciaFlujo);PS_BOPACKAGE_ACTIVITIES.UPDORDERINSTANCE(nuIdSolicitud,nuIdInstanciaFlujo);MO_BOACTIONUTIL.SETEXECACTIONINSTANDBY(GE_BOCONSTANTS.GETTRUE())'
,
'LBTEST'
,
to_date('16-07-2012 15:30:56','DD-MM-YYYY HH24:MI:SS'),
to_date('28-03-2020 19:47:23','DD-MM-YYYY HH24:MI:SS'),
to_date('28-03-2020 19:47:23','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Regla Esperar en Actividad en Reclamaciones'
,
'PP'
,
null);

exception when others then
EXP_ACTION_196_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_196_.blProcessStatus) then
 return;
end if;

EXP_ACTION_196_.tb2_0(0):=196;
EXP_ACTION_196_.tb2_2(0):=EXP_ACTION_196_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ACTION_MODULE fila (0)',1);
UPDATE GE_ACTION_MODULE SET ACTION_ID=EXP_ACTION_196_.tb2_0(0),
MODULE_ID=5,
CONFIG_EXPRESSION_ID=EXP_ACTION_196_.tb2_2(0),
DESCRIPTION='Esperar en Actividad en Reclamaciones'
,
EXE_AT_STATUS_CHANGE='N'
,
EXE_TRANSITION_STATE='N'

 WHERE ACTION_ID = EXP_ACTION_196_.tb2_0(0);
if not (sql%found) then
INSERT INTO GE_ACTION_MODULE(ACTION_ID,MODULE_ID,CONFIG_EXPRESSION_ID,DESCRIPTION,EXE_AT_STATUS_CHANGE,EXE_TRANSITION_STATE) 
VALUES (EXP_ACTION_196_.tb2_0(0),
5,
EXP_ACTION_196_.tb2_2(0),
'Esperar en Actividad en Reclamaciones'
,
'N'
,
'N'
);
end if;

exception when others then
EXP_ACTION_196_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_196_.blProcessStatus) then
 return;
end if;

EXP_ACTION_196_.tb3_0(0):=EXP_ACTION_196_.tb2_0(0);
EXP_ACTION_196_.tb3_1(0):=9;
ut_trace.trace('insertando tabla sin fallo: GE_VALID_ACTION_MODU fila (0)',1);
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (EXP_ACTION_196_.tb3_0(0),
EXP_ACTION_196_.tb3_1(0));

exception 
when dup_val_on_index then 
 return;
when others then
EXP_ACTION_196_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
DECLARE 
    nuBinaryIndex Binary_Integer;
BEGIN 
    nuBinaryIndex := EXP_ACTION_196_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = EXP_ACTION_196_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||EXP_ACTION_196_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||EXP_ACTION_196_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := EXP_ACTION_196_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       EXP_ACTION_196_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100556',1);
EXP_PROCESS_100556_.blProcessStatus := EXP_ACTION_196_.blProcessStatus ; 
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

if (not EXP_ACTION_196_.blProcessStatus) then
 return;
end if;
nuRowProcess:=EXP_ACTION_196_.tb1_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| EXP_ACTION_196_.tb1_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(EXP_ACTION_196_.tb1_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| EXP_ACTION_196_.tb1_0(nuRowProcess),1);
end;
nuRowProcess := EXP_ACTION_196_.tb1_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
EXP_ACTION_196_.blProcessStatus := false;
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
 nuIndex := EXP_ACTION_196_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_ACTION_196_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_ACTION_196_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_ACTION_196_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_ACTION_196_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_ACTION_196_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_ACTION_196_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_ACTION_196_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_ACTION_196_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_ACTION_196_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_ACTION_136_',
'CREATE OR REPLACE PACKAGE EXP_ACTION_136_ IS ' || chr(10) ||
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
'WHERE  ACTION_ID =136; ' || chr(10) ||
'type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_ACTION_136_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_ACTION_136_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open EXP_ACTION_136_.cuExpression;
   fetch EXP_ACTION_136_.cuExpression bulk collect INTO EXP_ACTION_136_.tbGR_CONFIG_EXPRESSIONId;
   close EXP_ACTION_136_.cuExpression;
END;
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_ACTION_136',1);
EXP_ACTION_136_.blProcessStatus := EXP_PROCESS_100556_.blProcessStatus ; 
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
AND     A.ACTION_ID =136
;
BEGIN

if (not EXP_ACTION_136_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_ACTION_136_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE ACTION_ID=136);
BEGIN 

if (not EXP_ACTION_136_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_ACTION_136_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_ACTION_136_.blProcessStatus := false;
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
FROM GE_ACTION_MODULE WHERE ACTION_ID=136;
nuIndex binary_integer;
BEGIN

if (not EXP_ACTION_136_.blProcessStatus) then
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
EXP_ACTION_136_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_ACTION_136_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_ACTION_136_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_ACTION_136_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_ACTION_136_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_ACTION_136_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_ACTION_136_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_ACTION_136_.blProcessStatus) then
 return;
end if;

EXP_ACTION_136_.tb0_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=EXP_ACTION_136_.tb0_0(0),
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

 WHERE CONFIGURA_TYPE_ID = EXP_ACTION_136_.tb0_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (EXP_ACTION_136_.tb0_0(0),
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
EXP_ACTION_136_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_136_.blProcessStatus) then
 return;
end if;

EXP_ACTION_136_.old_tb1_0(0):=121357857;
EXP_ACTION_136_.tb1_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
EXP_ACTION_136_.tb1_0(0):=EXP_ACTION_136_.tb1_0(0);
EXP_ACTION_136_.old_tb1_1(0):='GE_EXEACTION_CT1E121357857'
;
EXP_ACTION_136_.tb1_1(0):=TO_CHAR(EXP_ACTION_136_.tb1_0(0));
EXP_ACTION_136_.tb1_2(0):=EXP_ACTION_136_.tb0_0(0);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (EXP_ACTION_136_.tb1_0(0),
EXP_ACTION_136_.tb1_1(0),
EXP_ACTION_136_.tb1_2(0),
'nuIdSolicitud = MO_BOINSTANCE_DB.FNUGETPACKIDINSTANCE();PS_BOPACKAGE_ACTIVITIES.CREATEASSIGNWFORDER(nuIdSolicitud,null)'
,
'LBTEST'
,
to_date('13-07-2012 11:16:01','DD-MM-YYYY HH24:MI:SS'),
to_date('28-03-2020 19:47:40','DD-MM-YYYY HH24:MI:SS'),
to_date('28-03-2020 19:47:40','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Regla Generar Orden en Reclamaciones'
,
'PP'
,
null);

exception when others then
EXP_ACTION_136_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_136_.blProcessStatus) then
 return;
end if;

EXP_ACTION_136_.tb2_0(0):=136;
EXP_ACTION_136_.tb2_2(0):=EXP_ACTION_136_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ACTION_MODULE fila (0)',1);
UPDATE GE_ACTION_MODULE SET ACTION_ID=EXP_ACTION_136_.tb2_0(0),
MODULE_ID=5,
CONFIG_EXPRESSION_ID=EXP_ACTION_136_.tb2_2(0),
DESCRIPTION='Generar Orden en Reclamaciones'
,
EXE_AT_STATUS_CHANGE='N'
,
EXE_TRANSITION_STATE='N'

 WHERE ACTION_ID = EXP_ACTION_136_.tb2_0(0);
if not (sql%found) then
INSERT INTO GE_ACTION_MODULE(ACTION_ID,MODULE_ID,CONFIG_EXPRESSION_ID,DESCRIPTION,EXE_AT_STATUS_CHANGE,EXE_TRANSITION_STATE) 
VALUES (EXP_ACTION_136_.tb2_0(0),
5,
EXP_ACTION_136_.tb2_2(0),
'Generar Orden en Reclamaciones'
,
'N'
,
'N'
);
end if;

exception when others then
EXP_ACTION_136_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_136_.blProcessStatus) then
 return;
end if;

EXP_ACTION_136_.tb3_0(0):=EXP_ACTION_136_.tb2_0(0);
EXP_ACTION_136_.tb3_1(0):=4;
ut_trace.trace('insertando tabla sin fallo: GE_VALID_ACTION_MODU fila (0)',1);
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (EXP_ACTION_136_.tb3_0(0),
EXP_ACTION_136_.tb3_1(0));

exception 
when dup_val_on_index then 
 return;
when others then
EXP_ACTION_136_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_136_.blProcessStatus) then
 return;
end if;

EXP_ACTION_136_.tb3_0(1):=EXP_ACTION_136_.tb2_0(0);
EXP_ACTION_136_.tb3_1(1):=5;
ut_trace.trace('insertando tabla sin fallo: GE_VALID_ACTION_MODU fila (1)',1);
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (EXP_ACTION_136_.tb3_0(1),
EXP_ACTION_136_.tb3_1(1));

exception 
when dup_val_on_index then 
 return;
when others then
EXP_ACTION_136_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_136_.blProcessStatus) then
 return;
end if;

EXP_ACTION_136_.tb3_0(2):=EXP_ACTION_136_.tb2_0(0);
EXP_ACTION_136_.tb3_1(2):=9;
ut_trace.trace('insertando tabla sin fallo: GE_VALID_ACTION_MODU fila (2)',1);
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (EXP_ACTION_136_.tb3_0(2),
EXP_ACTION_136_.tb3_1(2));

exception 
when dup_val_on_index then 
 return;
when others then
EXP_ACTION_136_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_136_.blProcessStatus) then
 return;
end if;

EXP_ACTION_136_.tb3_0(3):=EXP_ACTION_136_.tb2_0(0);
EXP_ACTION_136_.tb3_1(3):=16;
ut_trace.trace('insertando tabla sin fallo: GE_VALID_ACTION_MODU fila (3)',1);
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (EXP_ACTION_136_.tb3_0(3),
EXP_ACTION_136_.tb3_1(3));

exception 
when dup_val_on_index then 
 return;
when others then
EXP_ACTION_136_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
DECLARE 
    nuBinaryIndex Binary_Integer;
BEGIN 
    nuBinaryIndex := EXP_ACTION_136_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = EXP_ACTION_136_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||EXP_ACTION_136_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||EXP_ACTION_136_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := EXP_ACTION_136_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       EXP_ACTION_136_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100556',1);
EXP_PROCESS_100556_.blProcessStatus := EXP_ACTION_136_.blProcessStatus ; 
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

if (not EXP_ACTION_136_.blProcessStatus) then
 return;
end if;
nuRowProcess:=EXP_ACTION_136_.tb1_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| EXP_ACTION_136_.tb1_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(EXP_ACTION_136_.tb1_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| EXP_ACTION_136_.tb1_0(nuRowProcess),1);
end;
nuRowProcess := EXP_ACTION_136_.tb1_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
EXP_ACTION_136_.blProcessStatus := false;
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
 nuIndex := EXP_ACTION_136_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_ACTION_136_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_ACTION_136_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_ACTION_136_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_ACTION_136_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_ACTION_136_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_ACTION_136_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_ACTION_136_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_ACTION_136_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_ACTION_136_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_ACTION_158_',
'CREATE OR REPLACE PACKAGE EXP_ACTION_158_ IS ' || chr(10) ||
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
'WHERE  ACTION_ID =158; ' || chr(10) ||
'type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_ACTION_158_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_ACTION_158_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open EXP_ACTION_158_.cuExpression;
   fetch EXP_ACTION_158_.cuExpression bulk collect INTO EXP_ACTION_158_.tbGR_CONFIG_EXPRESSIONId;
   close EXP_ACTION_158_.cuExpression;
END;
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_ACTION_158',1);
EXP_ACTION_158_.blProcessStatus := EXP_PROCESS_100556_.blProcessStatus ; 
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
AND     A.ACTION_ID =158
;
BEGIN

if (not EXP_ACTION_158_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_ACTION_158_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE ACTION_ID=158);
BEGIN 

if (not EXP_ACTION_158_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_ACTION_158_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_ACTION_158_.blProcessStatus := false;
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
FROM GE_ACTION_MODULE WHERE ACTION_ID=158;
nuIndex binary_integer;
BEGIN

if (not EXP_ACTION_158_.blProcessStatus) then
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
EXP_ACTION_158_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_ACTION_158_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_ACTION_158_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_ACTION_158_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_ACTION_158_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_ACTION_158_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_ACTION_158_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_ACTION_158_.blProcessStatus) then
 return;
end if;

EXP_ACTION_158_.tb0_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=EXP_ACTION_158_.tb0_0(0),
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

 WHERE CONFIGURA_TYPE_ID = EXP_ACTION_158_.tb0_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (EXP_ACTION_158_.tb0_0(0),
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
EXP_ACTION_158_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_158_.blProcessStatus) then
 return;
end if;

EXP_ACTION_158_.old_tb1_0(0):=121357858;
EXP_ACTION_158_.tb1_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
EXP_ACTION_158_.tb1_0(0):=EXP_ACTION_158_.tb1_0(0);
EXP_ACTION_158_.old_tb1_1(0):='GE_EXEACTION_CT1E121357858'
;
EXP_ACTION_158_.tb1_1(0):=TO_CHAR(EXP_ACTION_158_.tb1_0(0));
EXP_ACTION_158_.tb1_2(0):=EXP_ACTION_158_.tb0_0(0);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (EXP_ACTION_158_.tb1_0(0),
EXP_ACTION_158_.tb1_1(0),
EXP_ACTION_158_.tb1_2(0),
'nuIdSolicitud = MO_BOINSTANCE_DB.FNUGETPACKIDINSTANCE();TT_BOFAULT.PROCESSPACKABSORB(nuIdSolicitud)'
,
'LBTEST'
,
to_date('14-07-2012 14:29:27','DD-MM-YYYY HH24:MI:SS'),
to_date('28-03-2020 19:47:55','DD-MM-YYYY HH24:MI:SS'),
to_date('28-03-2020 19:47:55','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Regla Registrar Fallo'
,
'PP'
,
null);

exception when others then
EXP_ACTION_158_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_158_.blProcessStatus) then
 return;
end if;

EXP_ACTION_158_.tb2_0(0):=158;
EXP_ACTION_158_.tb2_2(0):=EXP_ACTION_158_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ACTION_MODULE fila (0)',1);
UPDATE GE_ACTION_MODULE SET ACTION_ID=EXP_ACTION_158_.tb2_0(0),
MODULE_ID=5,
CONFIG_EXPRESSION_ID=EXP_ACTION_158_.tb2_2(0),
DESCRIPTION='Registrar Fallo'
,
EXE_AT_STATUS_CHANGE='N'
,
EXE_TRANSITION_STATE='N'

 WHERE ACTION_ID = EXP_ACTION_158_.tb2_0(0);
if not (sql%found) then
INSERT INTO GE_ACTION_MODULE(ACTION_ID,MODULE_ID,CONFIG_EXPRESSION_ID,DESCRIPTION,EXE_AT_STATUS_CHANGE,EXE_TRANSITION_STATE) 
VALUES (EXP_ACTION_158_.tb2_0(0),
5,
EXP_ACTION_158_.tb2_2(0),
'Registrar Fallo'
,
'N'
,
'N'
);
end if;

exception when others then
EXP_ACTION_158_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_158_.blProcessStatus) then
 return;
end if;

EXP_ACTION_158_.tb3_0(0):=EXP_ACTION_158_.tb2_0(0);
EXP_ACTION_158_.tb3_1(0):=9;
ut_trace.trace('insertando tabla sin fallo: GE_VALID_ACTION_MODU fila (0)',1);
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (EXP_ACTION_158_.tb3_0(0),
EXP_ACTION_158_.tb3_1(0));

exception 
when dup_val_on_index then 
 return;
when others then
EXP_ACTION_158_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
DECLARE 
    nuBinaryIndex Binary_Integer;
BEGIN 
    nuBinaryIndex := EXP_ACTION_158_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = EXP_ACTION_158_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||EXP_ACTION_158_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||EXP_ACTION_158_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := EXP_ACTION_158_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       EXP_ACTION_158_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100556',1);
EXP_PROCESS_100556_.blProcessStatus := EXP_ACTION_158_.blProcessStatus ; 
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

if (not EXP_ACTION_158_.blProcessStatus) then
 return;
end if;
nuRowProcess:=EXP_ACTION_158_.tb1_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| EXP_ACTION_158_.tb1_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(EXP_ACTION_158_.tb1_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| EXP_ACTION_158_.tb1_0(nuRowProcess),1);
end;
nuRowProcess := EXP_ACTION_158_.tb1_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
EXP_ACTION_158_.blProcessStatus := false;
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
 nuIndex := EXP_ACTION_158_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_ACTION_158_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_ACTION_158_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_ACTION_158_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_ACTION_158_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_ACTION_158_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_ACTION_158_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_ACTION_158_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_ACTION_158_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_ACTION_158_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_ACTION_157_',
'CREATE OR REPLACE PACKAGE EXP_ACTION_157_ IS ' || chr(10) ||
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
'WHERE  ACTION_ID =157; ' || chr(10) ||
'type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_ACTION_157_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_ACTION_157_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open EXP_ACTION_157_.cuExpression;
   fetch EXP_ACTION_157_.cuExpression bulk collect INTO EXP_ACTION_157_.tbGR_CONFIG_EXPRESSIONId;
   close EXP_ACTION_157_.cuExpression;
END;
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_ACTION_157',1);
EXP_ACTION_157_.blProcessStatus := EXP_PROCESS_100556_.blProcessStatus ; 
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
AND     A.ACTION_ID =157
;
BEGIN

if (not EXP_ACTION_157_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_ACTION_157_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE ACTION_ID=157);
BEGIN 

if (not EXP_ACTION_157_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_ACTION_157_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_ACTION_157_.blProcessStatus := false;
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
FROM GE_ACTION_MODULE WHERE ACTION_ID=157;
nuIndex binary_integer;
BEGIN

if (not EXP_ACTION_157_.blProcessStatus) then
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
EXP_ACTION_157_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_ACTION_157_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_ACTION_157_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_ACTION_157_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_ACTION_157_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_ACTION_157_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_ACTION_157_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_ACTION_157_.blProcessStatus) then
 return;
end if;

EXP_ACTION_157_.tb0_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=EXP_ACTION_157_.tb0_0(0),
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

 WHERE CONFIGURA_TYPE_ID = EXP_ACTION_157_.tb0_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (EXP_ACTION_157_.tb0_0(0),
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
EXP_ACTION_157_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_157_.blProcessStatus) then
 return;
end if;

EXP_ACTION_157_.old_tb1_0(0):=121357859;
EXP_ACTION_157_.tb1_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
EXP_ACTION_157_.tb1_0(0):=EXP_ACTION_157_.tb1_0(0);
EXP_ACTION_157_.old_tb1_1(0):='GE_EXEACTION_CT1E121357859'
;
EXP_ACTION_157_.tb1_1(0):=TO_CHAR(EXP_ACTION_157_.tb1_0(0));
EXP_ACTION_157_.tb1_2(0):=EXP_ACTION_157_.tb0_0(0);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (EXP_ACTION_157_.tb1_0(0),
EXP_ACTION_157_.tb1_1(0),
EXP_ACTION_157_.tb1_2(0),
'GE_BOINSTANCE.GETVALUE("MO_WF_PACK_INTERFAC","ACTIVITY_ID",nuInstanceId);OR_BOCREATACTIVITFROMWF.ASSOACTTOINSTANCE(nuInstanceId)'
,
'LBTEST'
,
to_date('14-07-2012 13:27:59','DD-MM-YYYY HH24:MI:SS'),
to_date('28-03-2020 19:48:11','DD-MM-YYYY HH24:MI:SS'),
to_date('28-03-2020 19:48:11','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Esperar Legalizaci¿n'
,
'PP'
,
null);

exception when others then
EXP_ACTION_157_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_157_.blProcessStatus) then
 return;
end if;

EXP_ACTION_157_.tb2_0(0):=157;
EXP_ACTION_157_.tb2_2(0):=EXP_ACTION_157_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ACTION_MODULE fila (0)',1);
UPDATE GE_ACTION_MODULE SET ACTION_ID=EXP_ACTION_157_.tb2_0(0),
MODULE_ID=5,
CONFIG_EXPRESSION_ID=EXP_ACTION_157_.tb2_2(0),
DESCRIPTION='Esperar Legalizaci¿n'
,
EXE_AT_STATUS_CHANGE='N'
,
EXE_TRANSITION_STATE='N'

 WHERE ACTION_ID = EXP_ACTION_157_.tb2_0(0);
if not (sql%found) then
INSERT INTO GE_ACTION_MODULE(ACTION_ID,MODULE_ID,CONFIG_EXPRESSION_ID,DESCRIPTION,EXE_AT_STATUS_CHANGE,EXE_TRANSITION_STATE) 
VALUES (EXP_ACTION_157_.tb2_0(0),
5,
EXP_ACTION_157_.tb2_2(0),
'Esperar Legalizaci¿n'
,
'N'
,
'N'
);
end if;

exception when others then
EXP_ACTION_157_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_157_.blProcessStatus) then
 return;
end if;

EXP_ACTION_157_.tb3_0(0):=EXP_ACTION_157_.tb2_0(0);
EXP_ACTION_157_.tb3_1(0):=4;
ut_trace.trace('insertando tabla sin fallo: GE_VALID_ACTION_MODU fila (0)',1);
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (EXP_ACTION_157_.tb3_0(0),
EXP_ACTION_157_.tb3_1(0));

exception 
when dup_val_on_index then 
 return;
when others then
EXP_ACTION_157_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_157_.blProcessStatus) then
 return;
end if;

EXP_ACTION_157_.tb3_0(1):=EXP_ACTION_157_.tb2_0(0);
EXP_ACTION_157_.tb3_1(1):=9;
ut_trace.trace('insertando tabla sin fallo: GE_VALID_ACTION_MODU fila (1)',1);
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (EXP_ACTION_157_.tb3_0(1),
EXP_ACTION_157_.tb3_1(1));

exception 
when dup_val_on_index then 
 return;
when others then
EXP_ACTION_157_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
DECLARE 
    nuBinaryIndex Binary_Integer;
BEGIN 
    nuBinaryIndex := EXP_ACTION_157_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = EXP_ACTION_157_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||EXP_ACTION_157_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||EXP_ACTION_157_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := EXP_ACTION_157_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       EXP_ACTION_157_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100556',1);
EXP_PROCESS_100556_.blProcessStatus := EXP_ACTION_157_.blProcessStatus ; 
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

if (not EXP_ACTION_157_.blProcessStatus) then
 return;
end if;
nuRowProcess:=EXP_ACTION_157_.tb1_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| EXP_ACTION_157_.tb1_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(EXP_ACTION_157_.tb1_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| EXP_ACTION_157_.tb1_0(nuRowProcess),1);
end;
nuRowProcess := EXP_ACTION_157_.tb1_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
EXP_ACTION_157_.blProcessStatus := false;
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
 nuIndex := EXP_ACTION_157_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_ACTION_157_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_ACTION_157_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_ACTION_157_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_ACTION_157_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_ACTION_157_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_ACTION_157_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_ACTION_157_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_ACTION_157_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_ACTION_157_******************************'); end;
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
        WHERE UNIT_TYPE_ID = 100556
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID IN 
           (SELECT UNIT_ID
           FROM WF_UNIT
           WHERE UNIT_TYPE_ID = 100556
       ))
;
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_PROCESS_100556_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100556) AND NODE_TYPE_ID=0);
BEGIN 

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_PROCESS_100556_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100556) AND NODE_TYPE_ID=0);
BEGIN 

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_PROCESS_100556_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_PROCESS_100556_.blProcessStatus := false;
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
FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100556) AND NODE_TYPE_ID=0;
nuIndex binary_integer;
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
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
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_PROCESS_100556_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_PROCESS_100556_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_PROCESS_100556_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_PROCESS_100556_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_PROCESS_100556_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_PROCESS_100556_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_PROCESS_100556_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_PROCESS_100556_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_PROCESS_100556_.blProcessStatus := false;
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
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100556;
nuIndex binary_integer;
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
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
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100556_.tb0_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_CATEGORY fila (0)',1);
UPDATE WF_UNIT_CATEGORY SET CATEGORY_ID=EXP_PROCESS_100556_.tb0_0(0),
DISPLAY_NUMBER='Proceso B¿sico'

 WHERE CATEGORY_ID = EXP_PROCESS_100556_.tb0_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_CATEGORY(CATEGORY_ID,DISPLAY_NUMBER) 
VALUES (EXP_PROCESS_100556_.tb0_0(0),
'Proceso B¿sico'
);
end if;

exception when others then
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100556_.tb1_0(0):=9;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (0)',1);
UPDATE GE_MODULE SET MODULE_ID=EXP_PROCESS_100556_.tb1_0(0),
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

 WHERE MODULE_ID = EXP_PROCESS_100556_.tb1_0(0);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (EXP_PROCESS_100556_.tb1_0(0),
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
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100556_.tb2_0(0):=100556;
EXP_PROCESS_100556_.tb2_1(0):=EXP_PROCESS_100556_.tb0_0(0);
EXP_PROCESS_100556_.tb2_2(0):=EXP_PROCESS_100556_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (0)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100556_.tb2_0(0),
CATEGORY_ID=EXP_PROCESS_100556_.tb2_1(0),
MODULE_ID=EXP_PROCESS_100556_.tb2_2(0),
ACTION_ID=null,
PARENT_ID=983,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_100556'
,
DESCRIPTION='Ordenes de Daño a Producto'
,
DISPLAY='Ordenes de Daño a Producto'
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100556_.tb2_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100556_.tb2_0(0),
EXP_PROCESS_100556_.tb2_1(0),
EXP_PROCESS_100556_.tb2_2(0),
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_100556'
,
'Ordenes de Daño a Producto'
,
'Ordenes de Daño a Producto'
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
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100556_.tb3_0(0):=0;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (0)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100556_.tb3_0(0),
DESCRIPTION='Ra¿z'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100556_.tb3_0(0);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100556_.tb3_0(0),
'Ra¿z'
);
end if;

exception when others then
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100556_.tb1_0(1):=5;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (1)',1);
UPDATE GE_MODULE SET MODULE_ID=EXP_PROCESS_100556_.tb1_0(1),
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

 WHERE MODULE_ID = EXP_PROCESS_100556_.tb1_0(1);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (EXP_PROCESS_100556_.tb1_0(1),
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
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100556_.tb4_0(0):=102682;
EXP_PROCESS_100556_.tb4_2(0):=EXP_PROCESS_100556_.tb2_0(0);
EXP_PROCESS_100556_.tb4_3(0):=EXP_PROCESS_100556_.tb3_0(0);
EXP_PROCESS_100556_.tb4_4(0):=EXP_PROCESS_100556_.tb1_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (0)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100556_.tb4_0(0),
PROCESS_ID=null,
UNIT_TYPE_ID=EXP_PROCESS_100556_.tb4_2(0),
NODE_TYPE_ID=EXP_PROCESS_100556_.tb4_3(0),
MODULE_ID=EXP_PROCESS_100556_.tb4_4(0),
ACTION_ID=196,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=9000,
GEOMETRY='20
20'
,
DESCRIPTION='Espera Legalización Actividad'
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

 WHERE UNIT_ID = EXP_PROCESS_100556_.tb4_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100556_.tb4_0(0),
null,
EXP_PROCESS_100556_.tb4_2(0),
EXP_PROCESS_100556_.tb4_3(0),
EXP_PROCESS_100556_.tb4_4(0),
196,
null,
null,
9000,
'20
20'
,
'Espera Legalización Actividad'
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
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100556_.tb0_0(1):=2;
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_CATEGORY fila (1)',1);
UPDATE WF_UNIT_CATEGORY SET CATEGORY_ID=EXP_PROCESS_100556_.tb0_0(1),
DISPLAY_NUMBER='Actividad'

 WHERE CATEGORY_ID = EXP_PROCESS_100556_.tb0_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_CATEGORY(CATEGORY_ID,DISPLAY_NUMBER) 
VALUES (EXP_PROCESS_100556_.tb0_0(1),
'Actividad'
);
end if;

exception when others then
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100556_.tb2_0(1):=283;
EXP_PROCESS_100556_.tb2_1(1):=EXP_PROCESS_100556_.tb0_0(1);
EXP_PROCESS_100556_.tb2_2(1):=EXP_PROCESS_100556_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (1)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100556_.tb2_0(1),
CATEGORY_ID=EXP_PROCESS_100556_.tb2_1(1),
MODULE_ID=EXP_PROCESS_100556_.tb2_2(1),
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100556_.tb2_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100556_.tb2_0(1),
EXP_PROCESS_100556_.tb2_1(1),
EXP_PROCESS_100556_.tb2_2(1),
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
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100556_.tb3_0(1):=1;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (1)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100556_.tb3_0(1),
DESCRIPTION='Arranque'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100556_.tb3_0(1);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100556_.tb3_0(1),
'Arranque'
);
end if;

exception when others then
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100556_.tb4_0(1):=102683;
EXP_PROCESS_100556_.tb4_1(1):=EXP_PROCESS_100556_.tb4_0(0);
EXP_PROCESS_100556_.tb4_2(1):=EXP_PROCESS_100556_.tb2_0(1);
EXP_PROCESS_100556_.tb4_3(1):=EXP_PROCESS_100556_.tb3_0(1);
EXP_PROCESS_100556_.tb4_4(1):=EXP_PROCESS_100556_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (1)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100556_.tb4_0(1),
PROCESS_ID=EXP_PROCESS_100556_.tb4_1(1),
UNIT_TYPE_ID=EXP_PROCESS_100556_.tb4_2(1),
NODE_TYPE_ID=EXP_PROCESS_100556_.tb4_3(1),
MODULE_ID=EXP_PROCESS_100556_.tb4_4(1),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='29
189'
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

 WHERE UNIT_ID = EXP_PROCESS_100556_.tb4_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100556_.tb4_0(1),
EXP_PROCESS_100556_.tb4_1(1),
EXP_PROCESS_100556_.tb4_2(1),
EXP_PROCESS_100556_.tb4_3(1),
EXP_PROCESS_100556_.tb4_4(1),
null,
null,
null,
null,
'29
189'
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
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100556_.tb2_0(2):=172;
EXP_PROCESS_100556_.tb2_1(2):=EXP_PROCESS_100556_.tb0_0(1);
EXP_PROCESS_100556_.tb2_2(2):=EXP_PROCESS_100556_.tb1_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (2)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100556_.tb2_0(2),
CATEGORY_ID=EXP_PROCESS_100556_.tb2_1(2),
MODULE_ID=EXP_PROCESS_100556_.tb2_2(2),
ACTION_ID=null,
PARENT_ID=983,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_172'
,
DESCRIPTION='Reportar Fallo'
,
DISPLAY='Reportar Fallo'
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100556_.tb2_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100556_.tb2_0(2),
EXP_PROCESS_100556_.tb2_1(2),
EXP_PROCESS_100556_.tb2_2(2),
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_172'
,
'Reportar Fallo'
,
'Reportar Fallo'
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
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100556_.tb3_0(2):=2;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (2)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100556_.tb3_0(2),
DESCRIPTION='Normal'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100556_.tb3_0(2);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100556_.tb3_0(2),
'Normal'
);
end if;

exception when others then
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100556_.tb4_0(2):=102688;
EXP_PROCESS_100556_.tb4_1(2):=EXP_PROCESS_100556_.tb4_0(0);
EXP_PROCESS_100556_.tb4_2(2):=EXP_PROCESS_100556_.tb2_0(2);
EXP_PROCESS_100556_.tb4_3(2):=EXP_PROCESS_100556_.tb3_0(2);
EXP_PROCESS_100556_.tb4_4(2):=EXP_PROCESS_100556_.tb1_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (2)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100556_.tb4_0(2),
PROCESS_ID=EXP_PROCESS_100556_.tb4_1(2),
UNIT_TYPE_ID=EXP_PROCESS_100556_.tb4_2(2),
NODE_TYPE_ID=EXP_PROCESS_100556_.tb4_3(2),
MODULE_ID=EXP_PROCESS_100556_.tb4_4(2),
ACTION_ID=158,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=9000,
GEOMETRY='185
189'
,
DESCRIPTION='Reportar Fallo'
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

 WHERE UNIT_ID = EXP_PROCESS_100556_.tb4_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100556_.tb4_0(2),
EXP_PROCESS_100556_.tb4_1(2),
EXP_PROCESS_100556_.tb4_2(2),
EXP_PROCESS_100556_.tb4_3(2),
EXP_PROCESS_100556_.tb4_4(2),
158,
null,
null,
9000,
'185
189'
,
'Reportar Fallo'
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
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100556_.tb5_0(0):=100000024;
EXP_PROCESS_100556_.tb5_1(0):=EXP_PROCESS_100556_.tb4_0(1);
EXP_PROCESS_100556_.tb5_2(0):=EXP_PROCESS_100556_.tb4_0(2);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (0)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100556_.tb5_0(0),
ORIGIN_ID=EXP_PROCESS_100556_.tb5_1(0),
TARGET_ID=EXP_PROCESS_100556_.tb5_2(0),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION=null,
EXPRESSION_TYPE=0,
DESCRIPTION=null,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100556_.tb5_0(0);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100556_.tb5_0(0),
EXP_PROCESS_100556_.tb5_1(0),
EXP_PROCESS_100556_.tb5_2(0),
null,
0,
null,
0,
null,
1);
end if;

exception when others then
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100556_.tb6_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTE_CLASS fila (0)',1);
UPDATE GE_ATTRIBUTE_CLASS SET ATTRIBUTE_CLASS_ID=EXP_PROCESS_100556_.tb6_0(0),
NAME='De Entitdad'
,
DESCRIPTION='Valores que ser¿n tra¿dos de la tabla base usando old record'

 WHERE ATTRIBUTE_CLASS_ID = EXP_PROCESS_100556_.tb6_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTE_CLASS(ATTRIBUTE_CLASS_ID,NAME,DESCRIPTION) 
VALUES (EXP_PROCESS_100556_.tb6_0(0),
'De Entitdad'
,
'Valores que ser¿n tra¿dos de la tabla base usando old record'
);
end if;

exception when others then
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100556_.tb7_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES_TYPE fila (0)',1);
UPDATE GE_ATTRIBUTES_TYPE SET ATTRIBUTE_TYPE_ID=EXP_PROCESS_100556_.tb7_0(0),
DESCRIPTION='NUMBER'
,
INTERNAL_TYPE=2,
INTERNAL_JAVA_TYPE=2
 WHERE ATTRIBUTE_TYPE_ID = EXP_PROCESS_100556_.tb7_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES_TYPE(ATTRIBUTE_TYPE_ID,DESCRIPTION,INTERNAL_TYPE,INTERNAL_JAVA_TYPE) 
VALUES (EXP_PROCESS_100556_.tb7_0(0),
'NUMBER'
,
2,
2);
end if;

exception when others then
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100556_.tb8_0(0):=400;
EXP_PROCESS_100556_.tb8_1(0):=EXP_PROCESS_100556_.tb6_0(0);
EXP_PROCESS_100556_.tb8_2(0):=EXP_PROCESS_100556_.tb7_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (0)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=EXP_PROCESS_100556_.tb8_0(0),
ATTRIBUTE_CLASS_ID=EXP_PROCESS_100556_.tb8_1(0),
ATTRIBUTE_TYPE_ID=EXP_PROCESS_100556_.tb8_2(0),
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

 WHERE ATTRIBUTE_ID = EXP_PROCESS_100556_.tb8_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,ATTRIBUTE_CLASS_ID,ATTRIBUTE_TYPE_ID,VALID_EXPRESSION,FATHER_ID,MODULE_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (EXP_PROCESS_100556_.tb8_0(0),
EXP_PROCESS_100556_.tb8_1(0),
EXP_PROCESS_100556_.tb8_2(0),
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
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100556_.tb9_0(0):=100000640;
EXP_PROCESS_100556_.tb9_1(0):=EXP_PROCESS_100556_.tb4_0(1);
EXP_PROCESS_100556_.tb9_2(0):=EXP_PROCESS_100556_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (0)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100556_.tb9_0(0),
UNIT_ID=EXP_PROCESS_100556_.tb9_1(0),
ATTRIBUTE_ID=EXP_PROCESS_100556_.tb9_2(0),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100556_.tb9_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100556_.tb9_0(0),
EXP_PROCESS_100556_.tb9_1(0),
EXP_PROCESS_100556_.tb9_2(0),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100556_.tb2_0(5):=217;
EXP_PROCESS_100556_.tb2_1(5):=EXP_PROCESS_100556_.tb0_0(1);
EXP_PROCESS_100556_.tb2_2(5):=EXP_PROCESS_100556_.tb1_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (5)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100556_.tb2_0(5),
CATEGORY_ID=EXP_PROCESS_100556_.tb2_1(5),
MODULE_ID=EXP_PROCESS_100556_.tb2_2(5),
ACTION_ID=null,
PARENT_ID=983,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_217'
,
DESCRIPTION='Espera Legalización Actividad'
,
DISPLAY='Espera Legalización Actividad'
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100556_.tb2_0(5);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100556_.tb2_0(5),
EXP_PROCESS_100556_.tb2_1(5),
EXP_PROCESS_100556_.tb2_2(5),
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_217'
,
'Espera Legalización Actividad'
,
'Espera Legalización Actividad'
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
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100556_.tb4_0(5):=102686;
EXP_PROCESS_100556_.tb4_1(5):=EXP_PROCESS_100556_.tb4_0(0);
EXP_PROCESS_100556_.tb4_2(5):=EXP_PROCESS_100556_.tb2_0(5);
EXP_PROCESS_100556_.tb4_3(5):=EXP_PROCESS_100556_.tb3_0(2);
EXP_PROCESS_100556_.tb4_4(5):=EXP_PROCESS_100556_.tb1_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (5)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100556_.tb4_0(5),
PROCESS_ID=EXP_PROCESS_100556_.tb4_1(5),
UNIT_TYPE_ID=EXP_PROCESS_100556_.tb4_2(5),
NODE_TYPE_ID=EXP_PROCESS_100556_.tb4_3(5),
MODULE_ID=EXP_PROCESS_100556_.tb4_4(5),
ACTION_ID=157,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=9000,
GEOMETRY='392
176'
,
DESCRIPTION='Espera Legalización Actividad'
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

 WHERE UNIT_ID = EXP_PROCESS_100556_.tb4_0(5);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100556_.tb4_0(5),
EXP_PROCESS_100556_.tb4_1(5),
EXP_PROCESS_100556_.tb4_2(5),
EXP_PROCESS_100556_.tb4_3(5),
EXP_PROCESS_100556_.tb4_4(5),
157,
null,
null,
9000,
'392
176'
,
'Espera Legalización Actividad'
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
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100556_.tb5_0(3):=100000696;
EXP_PROCESS_100556_.tb5_1(3):=EXP_PROCESS_100556_.tb4_0(2);
EXP_PROCESS_100556_.tb5_2(3):=EXP_PROCESS_100556_.tb4_0(5);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (3)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100556_.tb5_0(3),
ORIGIN_ID=EXP_PROCESS_100556_.tb5_1(3),
TARGET_ID=EXP_PROCESS_100556_.tb5_2(3),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION=null,
EXPRESSION_TYPE=0,
DESCRIPTION=null,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100556_.tb5_0(3);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100556_.tb5_0(3),
EXP_PROCESS_100556_.tb5_1(3),
EXP_PROCESS_100556_.tb5_2(3),
null,
0,
null,
0,
null,
1);
end if;

exception when others then
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100556_.tb1_0(2):=4;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (2)',1);
UPDATE GE_MODULE SET MODULE_ID=EXP_PROCESS_100556_.tb1_0(2),
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

 WHERE MODULE_ID = EXP_PROCESS_100556_.tb1_0(2);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (EXP_PROCESS_100556_.tb1_0(2),
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
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100556_.tb2_0(3):=152;
EXP_PROCESS_100556_.tb2_1(3):=EXP_PROCESS_100556_.tb0_0(1);
EXP_PROCESS_100556_.tb2_2(3):=EXP_PROCESS_100556_.tb1_0(2);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (3)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100556_.tb2_0(3),
CATEGORY_ID=EXP_PROCESS_100556_.tb2_1(3),
MODULE_ID=EXP_PROCESS_100556_.tb2_2(3),
ACTION_ID=null,
PARENT_ID=983,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_152'
,
DESCRIPTION='Crea Actividad Ordenes'
,
DISPLAY='Crea Actividad Ordenes'
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100556_.tb2_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100556_.tb2_0(3),
EXP_PROCESS_100556_.tb2_1(3),
EXP_PROCESS_100556_.tb2_2(3),
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_152'
,
'Crea Actividad Ordenes'
,
'Crea Actividad Ordenes'
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
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100556_.tb4_0(3):=102685;
EXP_PROCESS_100556_.tb4_1(3):=EXP_PROCESS_100556_.tb4_0(0);
EXP_PROCESS_100556_.tb4_2(3):=EXP_PROCESS_100556_.tb2_0(3);
EXP_PROCESS_100556_.tb4_3(3):=EXP_PROCESS_100556_.tb3_0(2);
EXP_PROCESS_100556_.tb4_4(3):=EXP_PROCESS_100556_.tb1_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (3)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100556_.tb4_0(3),
PROCESS_ID=EXP_PROCESS_100556_.tb4_1(3),
UNIT_TYPE_ID=EXP_PROCESS_100556_.tb4_2(3),
NODE_TYPE_ID=EXP_PROCESS_100556_.tb4_3(3),
MODULE_ID=EXP_PROCESS_100556_.tb4_4(3),
ACTION_ID=136,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=9000,
GEOMETRY='382
318'
,
DESCRIPTION='Crea Actividad Ordenes'
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
VIEWABLE='Y'

 WHERE UNIT_ID = EXP_PROCESS_100556_.tb4_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100556_.tb4_0(3),
EXP_PROCESS_100556_.tb4_1(3),
EXP_PROCESS_100556_.tb4_2(3),
EXP_PROCESS_100556_.tb4_3(3),
EXP_PROCESS_100556_.tb4_4(3),
136,
null,
null,
9000,
'382
318'
,
'Crea Actividad Ordenes'
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
'Y'
);
end if;

exception when others then
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100556_.tb5_0(1):=100000695;
EXP_PROCESS_100556_.tb5_1(1):=EXP_PROCESS_100556_.tb4_0(3);
EXP_PROCESS_100556_.tb5_2(1):=EXP_PROCESS_100556_.tb4_0(2);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (1)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100556_.tb5_0(1),
ORIGIN_ID=EXP_PROCESS_100556_.tb5_1(1),
TARGET_ID=EXP_PROCESS_100556_.tb5_2(1),
GEOMETRY='255
356'
,
GROUP_ID=0,
EXPRESSION=null,
EXPRESSION_TYPE=0,
DESCRIPTION=null,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100556_.tb5_0(1);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100556_.tb5_0(1),
EXP_PROCESS_100556_.tb5_1(1),
EXP_PROCESS_100556_.tb5_2(1),
'255
356'
,
0,
null,
0,
null,
1);
end if;

exception when others then
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100556_.tb9_0(2):=100000647;
EXP_PROCESS_100556_.tb9_1(2):=EXP_PROCESS_100556_.tb4_0(2);
EXP_PROCESS_100556_.tb9_2(2):=EXP_PROCESS_100556_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (2)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100556_.tb9_0(2),
UNIT_ID=EXP_PROCESS_100556_.tb9_1(2),
ATTRIBUTE_ID=EXP_PROCESS_100556_.tb9_2(2),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=1,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100556_.tb9_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100556_.tb9_0(2),
EXP_PROCESS_100556_.tb9_1(2),
EXP_PROCESS_100556_.tb9_2(2),
null,
null,
'N'
,
1,
'N'
);
end if;

exception when others then
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100556_.tb2_0(4):=310;
EXP_PROCESS_100556_.tb2_1(4):=EXP_PROCESS_100556_.tb0_0(1);
EXP_PROCESS_100556_.tb2_2(4):=EXP_PROCESS_100556_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (4)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100556_.tb2_0(4),
CATEGORY_ID=EXP_PROCESS_100556_.tb2_1(4),
MODULE_ID=EXP_PROCESS_100556_.tb2_2(4),
ACTION_ID=null,
PARENT_ID=983,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_310'
,
DESCRIPTION='Valida Traslada Competencia'
,
DISPLAY='Valida Traslada Competencia'
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100556_.tb2_0(4);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100556_.tb2_0(4),
EXP_PROCESS_100556_.tb2_1(4),
EXP_PROCESS_100556_.tb2_2(4),
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_310'
,
'Valida Traslada Competencia'
,
'Valida Traslada Competencia'
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
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100556_.tb4_0(4):=102687;
EXP_PROCESS_100556_.tb4_1(4):=EXP_PROCESS_100556_.tb4_0(0);
EXP_PROCESS_100556_.tb4_2(4):=EXP_PROCESS_100556_.tb2_0(4);
EXP_PROCESS_100556_.tb4_3(4):=EXP_PROCESS_100556_.tb3_0(2);
EXP_PROCESS_100556_.tb4_4(4):=EXP_PROCESS_100556_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (4)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100556_.tb4_0(4),
PROCESS_ID=EXP_PROCESS_100556_.tb4_1(4),
UNIT_TYPE_ID=EXP_PROCESS_100556_.tb4_2(4),
NODE_TYPE_ID=EXP_PROCESS_100556_.tb4_3(4),
MODULE_ID=EXP_PROCESS_100556_.tb4_4(4),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='586
176'
,
DESCRIPTION='Valida Traslada Competencia'
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

 WHERE UNIT_ID = EXP_PROCESS_100556_.tb4_0(4);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100556_.tb4_0(4),
EXP_PROCESS_100556_.tb4_1(4),
EXP_PROCESS_100556_.tb4_2(4),
EXP_PROCESS_100556_.tb4_3(4),
EXP_PROCESS_100556_.tb4_4(4),
null,
null,
null,
null,
'586
176'
,
'Valida Traslada Competencia'
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
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100556_.tb5_0(2):=100000694;
EXP_PROCESS_100556_.tb5_1(2):=EXP_PROCESS_100556_.tb4_0(4);
EXP_PROCESS_100556_.tb5_2(2):=EXP_PROCESS_100556_.tb4_0(3);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (2)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100556_.tb5_0(2),
ORIGIN_ID=EXP_PROCESS_100556_.tb5_1(2),
TARGET_ID=EXP_PROCESS_100556_.tb5_2(2),
GEOMETRY='653
356'
,
GROUP_ID=0,
EXPRESSION='FLAG_VALIDATE == SI'
,
EXPRESSION_TYPE=0,
DESCRIPTION='Traslada Competencia'
,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100556_.tb5_0(2);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100556_.tb5_0(2),
EXP_PROCESS_100556_.tb5_1(2),
EXP_PROCESS_100556_.tb5_2(2),
'653
356'
,
0,
'FLAG_VALIDATE == SI'
,
0,
'Traslada Competencia'
,
1);
end if;

exception when others then
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100556_.tb9_0(1):=100000643;
EXP_PROCESS_100556_.tb9_1(1):=EXP_PROCESS_100556_.tb4_0(3);
EXP_PROCESS_100556_.tb9_2(1):=EXP_PROCESS_100556_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (1)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100556_.tb9_0(1),
UNIT_ID=EXP_PROCESS_100556_.tb9_1(1),
ATTRIBUTE_ID=EXP_PROCESS_100556_.tb9_2(1),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=1,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100556_.tb9_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100556_.tb9_0(1),
EXP_PROCESS_100556_.tb9_1(1),
EXP_PROCESS_100556_.tb9_2(1),
null,
null,
'N'
,
1,
'N'
);
end if;

exception when others then
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100556_.tb2_0(6):=252;
EXP_PROCESS_100556_.tb2_1(6):=EXP_PROCESS_100556_.tb0_0(1);
EXP_PROCESS_100556_.tb2_2(6):=EXP_PROCESS_100556_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (6)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100556_.tb2_0(6),
CATEGORY_ID=EXP_PROCESS_100556_.tb2_1(6),
MODULE_ID=EXP_PROCESS_100556_.tb2_2(6),
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100556_.tb2_0(6);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100556_.tb2_0(6),
EXP_PROCESS_100556_.tb2_1(6),
EXP_PROCESS_100556_.tb2_2(6),
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
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100556_.tb3_0(3):=3;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (3)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100556_.tb3_0(3),
DESCRIPTION='Final'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100556_.tb3_0(3);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100556_.tb3_0(3),
'Final'
);
end if;

exception when others then
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100556_.tb4_0(6):=102684;
EXP_PROCESS_100556_.tb4_1(6):=EXP_PROCESS_100556_.tb4_0(0);
EXP_PROCESS_100556_.tb4_2(6):=EXP_PROCESS_100556_.tb2_0(6);
EXP_PROCESS_100556_.tb4_3(6):=EXP_PROCESS_100556_.tb3_0(3);
EXP_PROCESS_100556_.tb4_4(6):=EXP_PROCESS_100556_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (6)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100556_.tb4_0(6),
PROCESS_ID=EXP_PROCESS_100556_.tb4_1(6),
UNIT_TYPE_ID=EXP_PROCESS_100556_.tb4_2(6),
NODE_TYPE_ID=EXP_PROCESS_100556_.tb4_3(6),
MODULE_ID=EXP_PROCESS_100556_.tb4_4(6),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='858
190'
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

 WHERE UNIT_ID = EXP_PROCESS_100556_.tb4_0(6);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100556_.tb4_0(6),
EXP_PROCESS_100556_.tb4_1(6),
EXP_PROCESS_100556_.tb4_2(6),
EXP_PROCESS_100556_.tb4_3(6),
EXP_PROCESS_100556_.tb4_4(6),
null,
null,
null,
null,
'858
190'
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
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100556_.tb5_0(4):=100000693;
EXP_PROCESS_100556_.tb5_1(4):=EXP_PROCESS_100556_.tb4_0(4);
EXP_PROCESS_100556_.tb5_2(4):=EXP_PROCESS_100556_.tb4_0(6);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (4)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100556_.tb5_0(4),
ORIGIN_ID=EXP_PROCESS_100556_.tb5_1(4),
TARGET_ID=EXP_PROCESS_100556_.tb5_2(4),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION='FLAG_VALIDATE == NO'
,
EXPRESSION_TYPE=0,
DESCRIPTION='NO Traslada Competencia'
,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100556_.tb5_0(4);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100556_.tb5_0(4),
EXP_PROCESS_100556_.tb5_1(4),
EXP_PROCESS_100556_.tb5_2(4),
null,
0,
'FLAG_VALIDATE == NO'
,
0,
'NO Traslada Competencia'
,
1);
end if;

exception when others then
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100556_.tb5_0(5):=100000692;
EXP_PROCESS_100556_.tb5_1(5):=EXP_PROCESS_100556_.tb4_0(5);
EXP_PROCESS_100556_.tb5_2(5):=EXP_PROCESS_100556_.tb4_0(4);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (5)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100556_.tb5_0(5),
ORIGIN_ID=EXP_PROCESS_100556_.tb5_1(5),
TARGET_ID=EXP_PROCESS_100556_.tb5_2(5),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION=null,
EXPRESSION_TYPE=0,
DESCRIPTION=null,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100556_.tb5_0(5);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100556_.tb5_0(5),
EXP_PROCESS_100556_.tb5_1(5),
EXP_PROCESS_100556_.tb5_2(5),
null,
0,
null,
0,
null,
1);
end if;

exception when others then
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100556_.tb9_0(3):=100000645;
EXP_PROCESS_100556_.tb9_1(3):=EXP_PROCESS_100556_.tb4_0(4);
EXP_PROCESS_100556_.tb9_2(3):=EXP_PROCESS_100556_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (3)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100556_.tb9_0(3),
UNIT_ID=EXP_PROCESS_100556_.tb9_1(3),
ATTRIBUTE_ID=EXP_PROCESS_100556_.tb9_2(3),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=1,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100556_.tb9_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100556_.tb9_0(3),
EXP_PROCESS_100556_.tb9_1(3),
EXP_PROCESS_100556_.tb9_2(3),
null,
null,
'N'
,
1,
'N'
);
end if;

exception when others then
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100556_.tb6_0(1):=8;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTE_CLASS fila (1)',1);
UPDATE GE_ATTRIBUTE_CLASS SET ATTRIBUTE_CLASS_ID=EXP_PROCESS_100556_.tb6_0(1),
NAME='Por Defecto General'
,
DESCRIPTION='Valores que ser¿n utilizados para clasificaci¿n gen¿rica'

 WHERE ATTRIBUTE_CLASS_ID = EXP_PROCESS_100556_.tb6_0(1);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTE_CLASS(ATTRIBUTE_CLASS_ID,NAME,DESCRIPTION) 
VALUES (EXP_PROCESS_100556_.tb6_0(1),
'Por Defecto General'
,
'Valores que ser¿n utilizados para clasificaci¿n gen¿rica'
);
end if;

exception when others then
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100556_.tb8_0(1):=442;
EXP_PROCESS_100556_.tb8_1(1):=EXP_PROCESS_100556_.tb6_0(1);
EXP_PROCESS_100556_.tb8_2(1):=EXP_PROCESS_100556_.tb7_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (1)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=EXP_PROCESS_100556_.tb8_0(1),
ATTRIBUTE_CLASS_ID=EXP_PROCESS_100556_.tb8_1(1),
ATTRIBUTE_TYPE_ID=EXP_PROCESS_100556_.tb8_2(1),
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

 WHERE ATTRIBUTE_ID = EXP_PROCESS_100556_.tb8_0(1);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,ATTRIBUTE_CLASS_ID,ATTRIBUTE_TYPE_ID,VALID_EXPRESSION,FATHER_ID,MODULE_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (EXP_PROCESS_100556_.tb8_0(1),
EXP_PROCESS_100556_.tb8_1(1),
EXP_PROCESS_100556_.tb8_2(1),
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
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100556_.old_tb10_0(0):=120182712;
EXP_PROCESS_100556_.tb10_0(0):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
EXP_PROCESS_100556_.tb10_0(0):=EXP_PROCESS_100556_.tb10_0(0);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (0)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (EXP_PROCESS_100556_.tb10_0(0),
5,
'Valida si Traslada por competencia'
,
'SELECT PS_BOPACKAGE_ACTIVITIES.FNUMOVEBYCOMPETENCE(:INST.EXTERNAL_ID:) FLAG_VALIDATE FROM dual'
,
'Valida si Traslada por competencia'
);

exception when others then
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100556_.tb9_0(4):=100000646;
EXP_PROCESS_100556_.tb9_1(4):=EXP_PROCESS_100556_.tb4_0(4);
EXP_PROCESS_100556_.tb9_2(4):=EXP_PROCESS_100556_.tb8_0(1);
EXP_PROCESS_100556_.tb9_3(4):=EXP_PROCESS_100556_.tb10_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (4)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100556_.tb9_0(4),
UNIT_ID=EXP_PROCESS_100556_.tb9_1(4),
ATTRIBUTE_ID=EXP_PROCESS_100556_.tb9_2(4),
STATEMENT_ID=EXP_PROCESS_100556_.tb9_3(4),
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='Y'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100556_.tb9_0(4);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100556_.tb9_0(4),
EXP_PROCESS_100556_.tb9_1(4),
EXP_PROCESS_100556_.tb9_2(4),
EXP_PROCESS_100556_.tb9_3(4),
null,
'N'
,
2,
'Y'
);
end if;

exception when others then
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100556_.tb9_0(7):=100000644;
EXP_PROCESS_100556_.tb9_1(7):=EXP_PROCESS_100556_.tb4_0(5);
EXP_PROCESS_100556_.tb9_2(7):=EXP_PROCESS_100556_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (7)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100556_.tb9_0(7),
UNIT_ID=EXP_PROCESS_100556_.tb9_1(7),
ATTRIBUTE_ID=EXP_PROCESS_100556_.tb9_2(7),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=1,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100556_.tb9_0(7);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100556_.tb9_0(7),
EXP_PROCESS_100556_.tb9_1(7),
EXP_PROCESS_100556_.tb9_2(7),
null,
null,
'N'
,
1,
'N'
);
end if;

exception when others then
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100556_.tb9_0(5):=100000641;
EXP_PROCESS_100556_.tb9_1(5):=EXP_PROCESS_100556_.tb4_0(6);
EXP_PROCESS_100556_.tb9_2(5):=EXP_PROCESS_100556_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (5)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100556_.tb9_0(5),
UNIT_ID=EXP_PROCESS_100556_.tb9_1(5),
ATTRIBUTE_ID=EXP_PROCESS_100556_.tb9_2(5),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100556_.tb9_0(5);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100556_.tb9_0(5),
EXP_PROCESS_100556_.tb9_1(5),
EXP_PROCESS_100556_.tb9_2(5),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_100556_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100556_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100556_.tb9_0(6):=100000642;
EXP_PROCESS_100556_.tb9_1(6):=EXP_PROCESS_100556_.tb4_0(6);
EXP_PROCESS_100556_.tb9_2(6):=EXP_PROCESS_100556_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (6)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100556_.tb9_0(6),
UNIT_ID=EXP_PROCESS_100556_.tb9_1(6),
ATTRIBUTE_ID=EXP_PROCESS_100556_.tb9_2(6),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100556_.tb9_0(6);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100556_.tb9_0(6),
EXP_PROCESS_100556_.tb9_1(6),
EXP_PROCESS_100556_.tb9_2(6),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_100556_.blProcessStatus := false;
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
sa_bocreatePackages.CreatePackage('EXP_UNITTYPE_152_',
'CREATE OR REPLACE PACKAGE EXP_UNITTYPE_152_ IS ' || chr(10) ||
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
'tb1_1 ty1_1;type ty2_0 is table of GR_CONFIGURA_TYPE.CONFIGURA_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;type ty3_0 is table of GR_CONFIG_EXPRESSION.CONFIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_0 ty3_0; ' || chr(10) ||
'tb3_0 ty3_0;type ty3_1 is table of GR_CONFIG_EXPRESSION.OBJECT_NAME%type index by binary_integer; ' || chr(10) ||
'old_tb3_1 ty3_1; ' || chr(10) ||
'tb3_1 ty3_1;type ty3_2 is table of GR_CONFIG_EXPRESSION.CONFIGURA_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_2 ty3_2; ' || chr(10) ||
'tb3_2 ty3_2;type ty4_0 is table of OR_ACT_BY_TASK_MOD.ACT_BY_TASK_MOD_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_0 ty4_0; ' || chr(10) ||
'tb4_0 ty4_0;type ty4_1 is table of OR_ACT_BY_TASK_MOD.TASK_CODE%type index by binary_integer; ' || chr(10) ||
'old_tb4_1 ty4_1; ' || chr(10) ||
'tb4_1 ty4_1;type ty4_2 is table of OR_ACT_BY_TASK_MOD.CONFIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_2 ty4_2; ' || chr(10) ||
'tb4_2 ty4_2; ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_UNITTYPE_152_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_UNITTYPE_152_******************************'); END;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_UNITTYPE_152',1);
EXP_UNITTYPE_152_.blProcessStatus := EXP_PROCESS_100556_.blProcessStatus ; 
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
AND     A.TASK_CODE = 152
 
;
BEGIN

if (not EXP_UNITTYPE_152_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_UNITTYPE_152_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
FROM WF_UNIT_TYPE_ATTRIB WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=152);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_152_.blProcessStatus) then
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
EXP_UNITTYPE_152_.blProcessStatus := false;
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
FROM WF_CAUSAL_UNIT_TYPE WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=152);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_152_.blProcessStatus) then
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
EXP_UNITTYPE_152_.blProcessStatus := false;
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
FROM MO_TIME_UNI_TYP_PRIO WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=152);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_152_.blProcessStatus) then
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
EXP_UNITTYPE_152_.blProcessStatus := false;
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
FROM OR_ACT_BY_TASK_MOD WHERE (TASK_CODE) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=152);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_152_.blProcessStatus) then
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
EXP_UNITTYPE_152_.blProcessStatus := false;
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
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=152;
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_152_.blProcessStatus) then
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
EXP_UNITTYPE_152_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_UNITTYPE_152_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_152_.tb0_0(0):=152;
ut_trace.trace('insertando tabla sin fallo: WF_UNIT_TYPE fila (0)',1);
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_UNITTYPE_152_.tb0_0(0),
2,
4,
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_152'
,
'Crea Actividad Ordenes'
,
'Crea Actividad Ordenes'
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
EXP_UNITTYPE_152_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_152_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_152_.tb1_0(0):=1;
EXP_UNITTYPE_152_.tb1_1(0):=EXP_UNITTYPE_152_.tb0_0(0);
ut_trace.trace('insertando tabla sin fallo: WF_CAUSAL_UNIT_TYPE fila (0)',1);
INSERT INTO WF_CAUSAL_UNIT_TYPE(CAUSAL_ID,UNIT_TYPE_ID,ALIAS) 
VALUES (EXP_UNITTYPE_152_.tb1_0(0),
EXP_UNITTYPE_152_.tb1_1(0),
'EXITO'
);

exception 
when dup_val_on_index then 
 return;
when others then
EXP_UNITTYPE_152_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_152_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_152_.tb2_0(0):=404;
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=EXP_UNITTYPE_152_.tb2_0(0),
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

 WHERE CONFIGURA_TYPE_ID = EXP_UNITTYPE_152_.tb2_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (EXP_UNITTYPE_152_.tb2_0(0),
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
EXP_UNITTYPE_152_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_152_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_152_.old_tb3_0(0):=121357860;
EXP_UNITTYPE_152_.tb3_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
EXP_UNITTYPE_152_.tb3_0(0):=EXP_UNITTYPE_152_.tb3_0(0);
EXP_UNITTYPE_152_.old_tb3_1(0):='OR_SEL_TASTYP_CT404E121357860'
;
EXP_UNITTYPE_152_.tb3_1(0):=TO_CHAR(EXP_UNITTYPE_152_.tb3_0(0));
EXP_UNITTYPE_152_.tb3_2(0):=EXP_UNITTYPE_152_.tb2_0(0);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (EXP_UNITTYPE_152_.tb3_0(0),
EXP_UNITTYPE_152_.tb3_1(0),
EXP_UNITTYPE_152_.tb3_2(0),
'
nuPackage = OR_BOINSTANCE.FNUGETFATHEXTSYSIDFROMINSTANCE();nuCategory = MO_BOPACKAGES.FNUGETCATEGORYID(nuPackage);nuPackType = LDC_BOUTILITIES.FNUGETTIPOPACK(nuPackage);if (nuPackType <> 323,if (nuCategory = 1,OR_BOINSTANCE.SETSUCCESSININSTANCE();,OR_BOINSTANCE.SETUN_SUCCESSININSTANCE(););,OR_BOINSTANCE.SETUN_SUCCESSININSTANCE();)'
,
'OPEN'
,
to_date('28-07-2016 17:02:55','DD-MM-YYYY HH24:MI:SS'),
to_date('28-03-2020 19:49:06','DD-MM-YYYY HH24:MI:SS'),
to_date('28-03-2020 19:49:06','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC_Verifica categoria OT Residencial'
,
'PP'
,
null);

exception when others then
EXP_UNITTYPE_152_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_152_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_152_.tb4_0(0):=15062;
EXP_UNITTYPE_152_.tb4_1(0):=EXP_UNITTYPE_152_.tb0_0(0);
EXP_UNITTYPE_152_.tb4_2(0):=EXP_UNITTYPE_152_.tb3_0(0);
ut_trace.trace('Actualizar o insertar tabla: OR_ACT_BY_TASK_MOD fila (0)',1);
UPDATE OR_ACT_BY_TASK_MOD SET ACT_BY_TASK_MOD_ID=EXP_UNITTYPE_152_.tb4_0(0),
TASK_CODE=EXP_UNITTYPE_152_.tb4_1(0),
CONFIG_EXPRESSION_ID=EXP_UNITTYPE_152_.tb4_2(0),
MODULE_ID=9,
ITEMS_ID=100003629
 WHERE ACT_BY_TASK_MOD_ID = EXP_UNITTYPE_152_.tb4_0(0);
if not (sql%found) then
INSERT INTO OR_ACT_BY_TASK_MOD(ACT_BY_TASK_MOD_ID,TASK_CODE,CONFIG_EXPRESSION_ID,MODULE_ID,ITEMS_ID) 
VALUES (EXP_UNITTYPE_152_.tb4_0(0),
EXP_UNITTYPE_152_.tb4_1(0),
EXP_UNITTYPE_152_.tb4_2(0),
9,
100003629);
end if;

exception when others then
EXP_UNITTYPE_152_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_152_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_152_.old_tb3_0(1):=121357861;
EXP_UNITTYPE_152_.tb3_0(1):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
EXP_UNITTYPE_152_.tb3_0(1):=EXP_UNITTYPE_152_.tb3_0(1);
EXP_UNITTYPE_152_.old_tb3_1(1):='OR_SEL_TASTYP_CT404E121357861'
;
EXP_UNITTYPE_152_.tb3_1(1):=TO_CHAR(EXP_UNITTYPE_152_.tb3_0(1));
EXP_UNITTYPE_152_.tb3_2(1):=EXP_UNITTYPE_152_.tb2_0(0);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (1)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (EXP_UNITTYPE_152_.tb3_0(1),
EXP_UNITTYPE_152_.tb3_1(1),
EXP_UNITTYPE_152_.tb3_2(1),
'
nuPackage = OR_BOINSTANCE.FNUGETFATHEXTSYSIDFROMINSTANCE();nuCategory = MO_BOPACKAGES.FNUGETCATEGORYID(nuPackage);nuPackType = LDC_BOUTILITIES.FNUGETTIPOPACK(nuPackage);if (nuPackType <> 323,if (nuCategory = 2,OR_BOINSTANCE.SETSUCCESSININSTANCE();,OR_BOINSTANCE.SETUN_SUCCESSININSTANCE(););,OR_BOINSTANCE.SETUN_SUCCESSININSTANCE();)'
,
'OPEN'
,
to_date('28-07-2016 17:03:42','DD-MM-YYYY HH24:MI:SS'),
to_date('28-03-2020 19:49:06','DD-MM-YYYY HH24:MI:SS'),
to_date('28-03-2020 19:49:06','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC_Verifica categoria OT Comercial'
,
'PP'
,
null);

exception when others then
EXP_UNITTYPE_152_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_152_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_152_.tb4_0(1):=15063;
EXP_UNITTYPE_152_.tb4_1(1):=EXP_UNITTYPE_152_.tb0_0(0);
EXP_UNITTYPE_152_.tb4_2(1):=EXP_UNITTYPE_152_.tb3_0(1);
ut_trace.trace('Actualizar o insertar tabla: OR_ACT_BY_TASK_MOD fila (1)',1);
UPDATE OR_ACT_BY_TASK_MOD SET ACT_BY_TASK_MOD_ID=EXP_UNITTYPE_152_.tb4_0(1),
TASK_CODE=EXP_UNITTYPE_152_.tb4_1(1),
CONFIG_EXPRESSION_ID=EXP_UNITTYPE_152_.tb4_2(1),
MODULE_ID=9,
ITEMS_ID=100003630
 WHERE ACT_BY_TASK_MOD_ID = EXP_UNITTYPE_152_.tb4_0(1);
if not (sql%found) then
INSERT INTO OR_ACT_BY_TASK_MOD(ACT_BY_TASK_MOD_ID,TASK_CODE,CONFIG_EXPRESSION_ID,MODULE_ID,ITEMS_ID) 
VALUES (EXP_UNITTYPE_152_.tb4_0(1),
EXP_UNITTYPE_152_.tb4_1(1),
EXP_UNITTYPE_152_.tb4_2(1),
9,
100003630);
end if;

exception when others then
EXP_UNITTYPE_152_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_152_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_152_.old_tb3_0(2):=121357862;
EXP_UNITTYPE_152_.tb3_0(2):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
EXP_UNITTYPE_152_.tb3_0(2):=EXP_UNITTYPE_152_.tb3_0(2);
EXP_UNITTYPE_152_.old_tb3_1(2):='OR_SEL_TASTYP_CT404E121357862'
;
EXP_UNITTYPE_152_.tb3_1(2):=TO_CHAR(EXP_UNITTYPE_152_.tb3_0(2));
EXP_UNITTYPE_152_.tb3_2(2):=EXP_UNITTYPE_152_.tb2_0(0);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (2)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (EXP_UNITTYPE_152_.tb3_0(2),
EXP_UNITTYPE_152_.tb3_1(2),
EXP_UNITTYPE_152_.tb3_2(2),
'nuPackage = OR_BOINSTANCE.FNUGETFATHEXTSYSIDFROMINSTANCE();nuCategory = MO_BOPACKAGES.FNUGETCATEGORYID(nuPackage);if (nuCategory = 3,OR_BOINSTANCE.SETSUCCESSININSTANCE();,OR_BOINSTANCE.SETUN_SUCCESSININSTANCE();)'
,
'OPEN'
,
to_date('28-07-2016 17:04:15','DD-MM-YYYY HH24:MI:SS'),
to_date('28-03-2020 19:49:07','DD-MM-YYYY HH24:MI:SS'),
to_date('28-03-2020 19:49:07','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC_Verifica categoria OT Industrial'
,
'PP'
,
null);

exception when others then
EXP_UNITTYPE_152_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_152_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_152_.tb4_0(2):=15064;
EXP_UNITTYPE_152_.tb4_1(2):=EXP_UNITTYPE_152_.tb0_0(0);
EXP_UNITTYPE_152_.tb4_2(2):=EXP_UNITTYPE_152_.tb3_0(2);
ut_trace.trace('Actualizar o insertar tabla: OR_ACT_BY_TASK_MOD fila (2)',1);
UPDATE OR_ACT_BY_TASK_MOD SET ACT_BY_TASK_MOD_ID=EXP_UNITTYPE_152_.tb4_0(2),
TASK_CODE=EXP_UNITTYPE_152_.tb4_1(2),
CONFIG_EXPRESSION_ID=EXP_UNITTYPE_152_.tb4_2(2),
MODULE_ID=9,
ITEMS_ID=100003631
 WHERE ACT_BY_TASK_MOD_ID = EXP_UNITTYPE_152_.tb4_0(2);
if not (sql%found) then
INSERT INTO OR_ACT_BY_TASK_MOD(ACT_BY_TASK_MOD_ID,TASK_CODE,CONFIG_EXPRESSION_ID,MODULE_ID,ITEMS_ID) 
VALUES (EXP_UNITTYPE_152_.tb4_0(2),
EXP_UNITTYPE_152_.tb4_1(2),
EXP_UNITTYPE_152_.tb4_2(2),
9,
100003631);
end if;

exception when others then
EXP_UNITTYPE_152_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100556',1);
EXP_PROCESS_100556_.blProcessStatus := EXP_UNITTYPE_152_.blProcessStatus ; 
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

if (not EXP_UNITTYPE_152_.blProcessStatus) then
 return;
end if;
nuRowProcess:=EXP_UNITTYPE_152_.tb3_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| EXP_UNITTYPE_152_.tb3_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(EXP_UNITTYPE_152_.tb3_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| EXP_UNITTYPE_152_.tb3_0(nuRowProcess),1);
end;
nuRowProcess := EXP_UNITTYPE_152_.tb3_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
EXP_UNITTYPE_152_.blProcessStatus := false;
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
 nuIndex := EXP_UNITTYPE_152_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_UNITTYPE_152_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_UNITTYPE_152_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_UNITTYPE_152_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_UNITTYPE_152_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_UNITTYPE_152_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_UNITTYPE_152_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_UNITTYPE_152_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_UNITTYPE_152_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_UNITTYPE_152_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_UNITTYPE_172_',
'CREATE OR REPLACE PACKAGE EXP_UNITTYPE_172_ IS ' || chr(10) ||
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
'END EXP_UNITTYPE_172_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_UNITTYPE_172_******************************'); END;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_UNITTYPE_172',1);
EXP_UNITTYPE_172_.blProcessStatus := EXP_PROCESS_100556_.blProcessStatus ; 
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
AND     A.TASK_CODE = 172
 
;
BEGIN

if (not EXP_UNITTYPE_172_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_UNITTYPE_172_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
FROM WF_UNIT_TYPE_ATTRIB WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=172);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_172_.blProcessStatus) then
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
EXP_UNITTYPE_172_.blProcessStatus := false;
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
FROM WF_CAUSAL_UNIT_TYPE WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=172);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_172_.blProcessStatus) then
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
EXP_UNITTYPE_172_.blProcessStatus := false;
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
FROM MO_TIME_UNI_TYP_PRIO WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=172);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_172_.blProcessStatus) then
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
EXP_UNITTYPE_172_.blProcessStatus := false;
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
FROM OR_ACT_BY_TASK_MOD WHERE (TASK_CODE) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=172);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_172_.blProcessStatus) then
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
EXP_UNITTYPE_172_.blProcessStatus := false;
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
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=172;
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_172_.blProcessStatus) then
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
EXP_UNITTYPE_172_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_UNITTYPE_172_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_172_.tb0_0(0):=172;
ut_trace.trace('insertando tabla sin fallo: WF_UNIT_TYPE fila (0)',1);
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_UNITTYPE_172_.tb0_0(0),
2,
5,
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_172'
,
'Reportar Fallo'
,
'Reportar Fallo'
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
EXP_UNITTYPE_172_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100556',1);
EXP_PROCESS_100556_.blProcessStatus := EXP_UNITTYPE_172_.blProcessStatus ; 
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
 nuIndex := EXP_UNITTYPE_172_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_UNITTYPE_172_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_UNITTYPE_172_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_UNITTYPE_172_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_UNITTYPE_172_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_UNITTYPE_172_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_UNITTYPE_172_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_UNITTYPE_172_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_UNITTYPE_172_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_UNITTYPE_172_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_UNITTYPE_310_',
'CREATE OR REPLACE PACKAGE EXP_UNITTYPE_310_ IS ' || chr(10) ||
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
'END EXP_UNITTYPE_310_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_UNITTYPE_310_******************************'); END;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_UNITTYPE_310',1);
EXP_UNITTYPE_310_.blProcessStatus := EXP_PROCESS_100556_.blProcessStatus ; 
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
AND     A.TASK_CODE = 310
 
;
BEGIN

if (not EXP_UNITTYPE_310_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_UNITTYPE_310_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
FROM WF_UNIT_TYPE_ATTRIB WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=310);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_310_.blProcessStatus) then
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
EXP_UNITTYPE_310_.blProcessStatus := false;
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
FROM WF_CAUSAL_UNIT_TYPE WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=310);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_310_.blProcessStatus) then
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
EXP_UNITTYPE_310_.blProcessStatus := false;
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
FROM MO_TIME_UNI_TYP_PRIO WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=310);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_310_.blProcessStatus) then
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
EXP_UNITTYPE_310_.blProcessStatus := false;
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
FROM OR_ACT_BY_TASK_MOD WHERE (TASK_CODE) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=310);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_310_.blProcessStatus) then
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
EXP_UNITTYPE_310_.blProcessStatus := false;
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
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=310;
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_310_.blProcessStatus) then
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
EXP_UNITTYPE_310_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_UNITTYPE_310_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_310_.tb0_0(0):=310;
ut_trace.trace('insertando tabla sin fallo: WF_UNIT_TYPE fila (0)',1);
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_UNITTYPE_310_.tb0_0(0),
2,
9,
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_310'
,
'Valida Traslada Competencia'
,
'Valida Traslada Competencia'
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
EXP_UNITTYPE_310_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100556',1);
EXP_PROCESS_100556_.blProcessStatus := EXP_UNITTYPE_310_.blProcessStatus ; 
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
 nuIndex := EXP_UNITTYPE_310_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_UNITTYPE_310_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_UNITTYPE_310_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_UNITTYPE_310_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_UNITTYPE_310_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_UNITTYPE_310_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_UNITTYPE_310_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_UNITTYPE_310_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_UNITTYPE_310_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_UNITTYPE_310_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_UNITTYPE_217_',
'CREATE OR REPLACE PACKAGE EXP_UNITTYPE_217_ IS ' || chr(10) ||
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
'END EXP_UNITTYPE_217_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_UNITTYPE_217_******************************'); END;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_UNITTYPE_217',1);
EXP_UNITTYPE_217_.blProcessStatus := EXP_PROCESS_100556_.blProcessStatus ; 
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
AND     A.TASK_CODE = 217
 
;
BEGIN

if (not EXP_UNITTYPE_217_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_UNITTYPE_217_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
FROM WF_UNIT_TYPE_ATTRIB WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=217);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_217_.blProcessStatus) then
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
EXP_UNITTYPE_217_.blProcessStatus := false;
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
FROM WF_CAUSAL_UNIT_TYPE WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=217);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_217_.blProcessStatus) then
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
EXP_UNITTYPE_217_.blProcessStatus := false;
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
FROM MO_TIME_UNI_TYP_PRIO WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=217);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_217_.blProcessStatus) then
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
EXP_UNITTYPE_217_.blProcessStatus := false;
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
FROM OR_ACT_BY_TASK_MOD WHERE (TASK_CODE) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=217);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_217_.blProcessStatus) then
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
EXP_UNITTYPE_217_.blProcessStatus := false;
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
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=217;
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_217_.blProcessStatus) then
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
EXP_UNITTYPE_217_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_UNITTYPE_217_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_217_.tb0_0(0):=217;
ut_trace.trace('insertando tabla sin fallo: WF_UNIT_TYPE fila (0)',1);
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_UNITTYPE_217_.tb0_0(0),
2,
5,
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_217'
,
'Espera Legalización Actividad'
,
'Espera Legalización Actividad'
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
EXP_UNITTYPE_217_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100556',1);
EXP_PROCESS_100556_.blProcessStatus := EXP_UNITTYPE_217_.blProcessStatus ; 
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
 nuIndex := EXP_UNITTYPE_217_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_UNITTYPE_217_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_UNITTYPE_217_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_UNITTYPE_217_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_UNITTYPE_217_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_UNITTYPE_217_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_UNITTYPE_217_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_UNITTYPE_217_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_UNITTYPE_217_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_UNITTYPE_217_******************************'); end;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_170',1);
EXP_PROCESS_170_.blProcessStatus := EXP_PROCESS_100556_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
DECLARE 
    nuBinaryIndex Binary_Integer;
BEGIN 
    nuBinaryIndex := EXP_PROCESS_100556_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = EXP_PROCESS_100556_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||EXP_PROCESS_100556_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||EXP_PROCESS_100556_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := EXP_PROCESS_100556_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       EXP_PROCESS_100556_.blProcessStatus := FALSE;
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
 nuIndex := EXP_PROCESS_100556_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_PROCESS_100556_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_PROCESS_100556_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_PROCESS_100556_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_PROCESS_100556_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_PROCESS_100556_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_PROCESS_100556_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_PROCESS_100556_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_PROCESS_100556_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_PROCESS_100556_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_PROCESS_100540_',
'CREATE OR REPLACE PACKAGE EXP_PROCESS_100540_ IS ' || chr(10) ||
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
'tb9_3 ty9_3; ' || chr(10) ||
'CURSOR cuExpression is ' || chr(10) ||
'SELECT PRE_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_TYPE_ID = 100540 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID IN  ' || chr(10) ||
'           (SELECT UNIT_ID ' || chr(10) ||
'           FROM WF_UNIT ' || chr(10) ||
'           WHERE UNIT_TYPE_ID = 100540 ' || chr(10) ||
'       )) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_TYPE_ID = 100540 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID IN  ' || chr(10) ||
'           (SELECT UNIT_ID ' || chr(10) ||
'           FROM WF_UNIT ' || chr(10) ||
'           WHERE UNIT_TYPE_ID = 100540 ' || chr(10) ||
'       )) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_PROCESS_100540_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_PROCESS_100540_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open EXP_PROCESS_100540_.cuExpression;
   fetch EXP_PROCESS_100540_.cuExpression bulk collect INTO EXP_PROCESS_100540_.tbGR_CONFIG_EXPRESSIONId;
   close EXP_PROCESS_100540_.cuExpression;
END;
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100540',1);
EXP_PROCESS_100540_.blProcessStatus := EXP_PROCESS_170_.blProcessStatus ; 
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
sa_bocreatePackages.CreatePackage('DEL_ROOT_102640_',
'CREATE OR REPLACE PACKAGE DEL_ROOT_102640_ IS ' || chr(10) ||
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
'        WHERE UNIT_ID = 102640 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 102640  ' || chr(10) ||
'       ) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_ID = 102640 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 102640  ' || chr(10) ||
'       ) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END DEL_ROOT_102640_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:DEL_ROOT_102640_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open DEL_ROOT_102640_.cuExpression;
   fetch DEL_ROOT_102640_.cuExpression bulk collect INTO DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONId;
   close DEL_ROOT_102640_.cuExpression;
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
        WHERE UNIT_ID = 102640
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID = 102640 
       )
;
BEGIN

if (not DEL_ROOT_102640_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  DEL_ROOT_102640_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE PROCESS_ID = 102640);
BEGIN 

if (not DEL_ROOT_102640_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102640_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE PROCESS_ID = 102640);
BEGIN 

if (not DEL_ROOT_102640_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102640_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 102640)));
BEGIN 

if (not DEL_ROOT_102640_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102640_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 102640)));
BEGIN 

if (not DEL_ROOT_102640_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102640_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 102640));
BEGIN 

if (not DEL_ROOT_102640_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla WF_UNIT',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102640_.tbWF_UNITRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102640_.blProcessStatus := false;
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
FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 102640);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102640_.blProcessStatus) then
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
DEL_ROOT_102640_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102640_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102640_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102640_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102640_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102640_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria WF_UNIT',1);
nuVarcharIndex:=DEL_ROOT_102640_.tbWF_UNITRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from WF_UNIT where rowid = DEL_ROOT_102640_.tbWF_UNITRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102640_.tbWF_UNITRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102640_.tbWF_UNITRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102640_.blProcessStatus := false;
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
FROM WF_UNIT_DATA_MAP WHERE (SOURCE_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 102640));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102640_.blProcessStatus) then
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
DEL_ROOT_102640_.blProcessStatus := false;
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
FROM WF_UNIT_DATA_MAP WHERE (TARGET_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 102640));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102640_.blProcessStatus) then
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
DEL_ROOT_102640_.blProcessStatus := false;
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
FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 102640);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102640_.blProcessStatus) then
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
DEL_ROOT_102640_.blProcessStatus := false;
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
FROM WF_UNIT WHERE PROCESS_ID = 102640;
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102640_.blProcessStatus) then
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
DEL_ROOT_102640_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102640_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102640_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102640_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102640_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/

BEGIN
    ut_trace.trace('Actualizar WF_UNIT a ProcessId NULL ',1);
   UPDATE WF_UNIT 
     SET PROCESS_ID = -1, POS_EXPRESSION_ID = null, PRE_EXPRESSION_ID = null, ACTION_ID = null 
     WHERE PROCESS_ID = 102640;
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
    nuBinaryIndex := DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       DEL_ROOT_102640_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100540',1);
EXP_PROCESS_100540_.blProcessStatus := DEL_ROOT_102640_.blProcessStatus ; 
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
 nuIndex := DEL_ROOT_102640_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || DEL_ROOT_102640_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(DEL_ROOT_102640_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(DEL_ROOT_102640_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(DEL_ROOT_102640_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || DEL_ROOT_102640_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || DEL_ROOT_102640_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := DEL_ROOT_102640_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('DEL_ROOT_102640_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:DEL_ROOT_102640_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('DEL_ROOT_102640_',
'CREATE OR REPLACE PACKAGE DEL_ROOT_102640_ IS ' || chr(10) ||
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
'        WHERE UNIT_ID = 102640 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 102640  ' || chr(10) ||
'       ) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_ID = 102640 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 102640  ' || chr(10) ||
'       ) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END DEL_ROOT_102640_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:DEL_ROOT_102640_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open DEL_ROOT_102640_.cuExpression;
   fetch DEL_ROOT_102640_.cuExpression bulk collect INTO DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONId;
   close DEL_ROOT_102640_.cuExpression;
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
        WHERE UNIT_ID = 102640
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID = 102640 
       )
;
BEGIN

if (not DEL_ROOT_102640_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  DEL_ROOT_102640_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE UNIT_ID = 102640);
BEGIN 

if (not DEL_ROOT_102640_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102640_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE UNIT_ID = 102640);
BEGIN 

if (not DEL_ROOT_102640_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102640_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 102640)));
BEGIN 

if (not DEL_ROOT_102640_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102640_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 102640)));
BEGIN 

if (not DEL_ROOT_102640_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102640_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 102640));
BEGIN 

if (not DEL_ROOT_102640_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla WF_UNIT',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_102640_.tbWF_UNITRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_102640_.blProcessStatus := false;
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
FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 102640);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102640_.blProcessStatus) then
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
DEL_ROOT_102640_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102640_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102640_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102640_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102640_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102640_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria WF_UNIT',1);
nuVarcharIndex:=DEL_ROOT_102640_.tbWF_UNITRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from WF_UNIT where rowid = DEL_ROOT_102640_.tbWF_UNITRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102640_.tbWF_UNITRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102640_.tbWF_UNITRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102640_.blProcessStatus := false;
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
FROM WF_UNIT_DATA_MAP WHERE (SOURCE_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 102640));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102640_.blProcessStatus) then
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
DEL_ROOT_102640_.blProcessStatus := false;
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
FROM WF_UNIT_DATA_MAP WHERE (TARGET_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 102640));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102640_.blProcessStatus) then
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
DEL_ROOT_102640_.blProcessStatus := false;
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
FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 102640);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102640_.blProcessStatus) then
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
DEL_ROOT_102640_.blProcessStatus := false;
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
FROM WF_UNIT WHERE UNIT_ID = 102640;
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_102640_.blProcessStatus) then
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
DEL_ROOT_102640_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102640_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102640_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_102640_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_102640_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/

BEGIN
    ut_trace.trace('Actualizar WF_UNIT a ProcessId NULL ',1);
   UPDATE WF_UNIT 
     SET PROCESS_ID = -1, POS_EXPRESSION_ID = null, PRE_EXPRESSION_ID = null, ACTION_ID = null 
     WHERE PROCESS_ID = 102640;
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
    nuBinaryIndex := DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := DEL_ROOT_102640_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       DEL_ROOT_102640_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100540',1);
EXP_PROCESS_100540_.blProcessStatus := DEL_ROOT_102640_.blProcessStatus ; 
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
 nuIndex := DEL_ROOT_102640_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || DEL_ROOT_102640_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(DEL_ROOT_102640_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(DEL_ROOT_102640_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(DEL_ROOT_102640_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || DEL_ROOT_102640_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || DEL_ROOT_102640_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := DEL_ROOT_102640_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('DEL_ROOT_102640_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:DEL_ROOT_102640_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_ACTION_8192_',
'CREATE OR REPLACE PACKAGE EXP_ACTION_8192_ IS ' || chr(10) ||
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
'WHERE  ACTION_ID =8192; ' || chr(10) ||
'type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_ACTION_8192_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_ACTION_8192_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open EXP_ACTION_8192_.cuExpression;
   fetch EXP_ACTION_8192_.cuExpression bulk collect INTO EXP_ACTION_8192_.tbGR_CONFIG_EXPRESSIONId;
   close EXP_ACTION_8192_.cuExpression;
END;
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_ACTION_8192',1);
EXP_ACTION_8192_.blProcessStatus := EXP_PROCESS_100540_.blProcessStatus ; 
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
AND     A.ACTION_ID =8192
;
BEGIN

if (not EXP_ACTION_8192_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_ACTION_8192_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE ACTION_ID=8192);
BEGIN 

if (not EXP_ACTION_8192_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_ACTION_8192_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_ACTION_8192_.blProcessStatus := false;
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
FROM GE_ACTION_MODULE WHERE ACTION_ID=8192;
nuIndex binary_integer;
BEGIN

if (not EXP_ACTION_8192_.blProcessStatus) then
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
EXP_ACTION_8192_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_ACTION_8192_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_ACTION_8192_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_ACTION_8192_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_ACTION_8192_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_ACTION_8192_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_ACTION_8192_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_ACTION_8192_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8192_.tb0_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=EXP_ACTION_8192_.tb0_0(0),
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

 WHERE CONFIGURA_TYPE_ID = EXP_ACTION_8192_.tb0_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (EXP_ACTION_8192_.tb0_0(0),
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
EXP_ACTION_8192_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_8192_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8192_.old_tb1_0(0):=121357863;
EXP_ACTION_8192_.tb1_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
EXP_ACTION_8192_.tb1_0(0):=EXP_ACTION_8192_.tb1_0(0);
EXP_ACTION_8192_.old_tb1_1(0):='GE_EXEACTION_CT1E121357863'
;
EXP_ACTION_8192_.tb1_1(0):=TO_CHAR(EXP_ACTION_8192_.tb1_0(0));
EXP_ACTION_8192_.tb1_2(0):=EXP_ACTION_8192_.tb0_0(0);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (EXP_ACTION_8192_.tb1_0(0),
EXP_ACTION_8192_.tb1_1(0),
EXP_ACTION_8192_.tb1_2(0),
'cnuAccAtenMot = 58;nuIdSolicitud = MO_BOINSTANCE_DB.FNUGETPACKIDINSTANCE();CC_BOLEGALCAUSALANSWER.UPDATECLAIMANSWER(nuIdSolicitud);CC_BOPRODUCTDAMAGE.VALPRODUCTTIMEOUT(nuIdSolicitud);MO_BOMOTIVEACTIONUTIL.EXECTRANSTATUSFORREQU(nuIdSolicitud,58)'
,
'EDGANINO'
,
to_date('02-05-2013 09:36:02','DD-MM-YYYY HH24:MI:SS'),
to_date('28-03-2020 19:50:59','DD-MM-YYYY HH24:MI:SS'),
to_date('28-03-2020 19:50:59','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Atender Daño a Producto'
,
'PP'
,
null);

exception when others then
EXP_ACTION_8192_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_8192_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8192_.tb2_0(0):=8192;
EXP_ACTION_8192_.tb2_2(0):=EXP_ACTION_8192_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ACTION_MODULE fila (0)',1);
UPDATE GE_ACTION_MODULE SET ACTION_ID=EXP_ACTION_8192_.tb2_0(0),
MODULE_ID=5,
CONFIG_EXPRESSION_ID=EXP_ACTION_8192_.tb2_2(0),
DESCRIPTION='Atender Daño a Producto'
,
EXE_AT_STATUS_CHANGE='N'
,
EXE_TRANSITION_STATE='N'

 WHERE ACTION_ID = EXP_ACTION_8192_.tb2_0(0);
if not (sql%found) then
INSERT INTO GE_ACTION_MODULE(ACTION_ID,MODULE_ID,CONFIG_EXPRESSION_ID,DESCRIPTION,EXE_AT_STATUS_CHANGE,EXE_TRANSITION_STATE) 
VALUES (EXP_ACTION_8192_.tb2_0(0),
5,
EXP_ACTION_8192_.tb2_2(0),
'Atender Daño a Producto'
,
'N'
,
'N'
);
end if;

exception when others then
EXP_ACTION_8192_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_8192_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8192_.tb3_0(0):=EXP_ACTION_8192_.tb2_0(0);
EXP_ACTION_8192_.tb3_1(0):=9;
ut_trace.trace('insertando tabla sin fallo: GE_VALID_ACTION_MODU fila (0)',1);
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (EXP_ACTION_8192_.tb3_0(0),
EXP_ACTION_8192_.tb3_1(0));

exception 
when dup_val_on_index then 
 return;
when others then
EXP_ACTION_8192_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
DECLARE 
    nuBinaryIndex Binary_Integer;
BEGIN 
    nuBinaryIndex := EXP_ACTION_8192_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = EXP_ACTION_8192_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||EXP_ACTION_8192_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||EXP_ACTION_8192_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := EXP_ACTION_8192_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       EXP_ACTION_8192_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100540',1);
EXP_PROCESS_100540_.blProcessStatus := EXP_ACTION_8192_.blProcessStatus ; 
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

if (not EXP_ACTION_8192_.blProcessStatus) then
 return;
end if;
nuRowProcess:=EXP_ACTION_8192_.tb1_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| EXP_ACTION_8192_.tb1_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(EXP_ACTION_8192_.tb1_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| EXP_ACTION_8192_.tb1_0(nuRowProcess),1);
end;
nuRowProcess := EXP_ACTION_8192_.tb1_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
EXP_ACTION_8192_.blProcessStatus := false;
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
 nuIndex := EXP_ACTION_8192_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_ACTION_8192_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_ACTION_8192_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_ACTION_8192_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_ACTION_8192_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_ACTION_8192_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_ACTION_8192_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_ACTION_8192_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_ACTION_8192_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_ACTION_8192_******************************'); end;
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
        WHERE UNIT_TYPE_ID = 100540
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID IN 
           (SELECT UNIT_ID
           FROM WF_UNIT
           WHERE UNIT_TYPE_ID = 100540
       ))
;
BEGIN

if (not EXP_PROCESS_100540_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_PROCESS_100540_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100540) AND NODE_TYPE_ID=0);
BEGIN 

if (not EXP_PROCESS_100540_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_PROCESS_100540_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_PROCESS_100540_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100540) AND NODE_TYPE_ID=0);
BEGIN 

if (not EXP_PROCESS_100540_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_PROCESS_100540_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_PROCESS_100540_.blProcessStatus := false;
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
FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100540) AND NODE_TYPE_ID=0;
nuIndex binary_integer;
BEGIN

if (not EXP_PROCESS_100540_.blProcessStatus) then
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
EXP_PROCESS_100540_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_PROCESS_100540_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_PROCESS_100540_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_PROCESS_100540_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_PROCESS_100540_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_PROCESS_100540_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_PROCESS_100540_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_PROCESS_100540_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_PROCESS_100540_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_PROCESS_100540_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_PROCESS_100540_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_PROCESS_100540_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_PROCESS_100540_.blProcessStatus := false;
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
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100540;
nuIndex binary_integer;
BEGIN

if (not EXP_PROCESS_100540_.blProcessStatus) then
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
EXP_PROCESS_100540_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_PROCESS_100540_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100540_.tb0_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_CATEGORY fila (0)',1);
UPDATE WF_UNIT_CATEGORY SET CATEGORY_ID=EXP_PROCESS_100540_.tb0_0(0),
DISPLAY_NUMBER='Proceso B¿sico'

 WHERE CATEGORY_ID = EXP_PROCESS_100540_.tb0_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_CATEGORY(CATEGORY_ID,DISPLAY_NUMBER) 
VALUES (EXP_PROCESS_100540_.tb0_0(0),
'Proceso B¿sico'
);
end if;

exception when others then
EXP_PROCESS_100540_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100540_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100540_.tb1_0(0):=9;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (0)',1);
UPDATE GE_MODULE SET MODULE_ID=EXP_PROCESS_100540_.tb1_0(0),
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

 WHERE MODULE_ID = EXP_PROCESS_100540_.tb1_0(0);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (EXP_PROCESS_100540_.tb1_0(0),
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
EXP_PROCESS_100540_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100540_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100540_.tb2_0(0):=100540;
EXP_PROCESS_100540_.tb2_1(0):=EXP_PROCESS_100540_.tb0_0(0);
EXP_PROCESS_100540_.tb2_2(0):=EXP_PROCESS_100540_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (0)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100540_.tb2_0(0),
CATEGORY_ID=EXP_PROCESS_100540_.tb2_1(0),
MODULE_ID=EXP_PROCESS_100540_.tb2_2(0),
ACTION_ID=null,
PARENT_ID=983,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_100540'
,
DESCRIPTION='Atender Daño a Producto'
,
DISPLAY='Atender Daño a Producto'
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100540_.tb2_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100540_.tb2_0(0),
EXP_PROCESS_100540_.tb2_1(0),
EXP_PROCESS_100540_.tb2_2(0),
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_100540'
,
'Atender Daño a Producto'
,
'Atender Daño a Producto'
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
EXP_PROCESS_100540_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100540_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100540_.tb3_0(0):=0;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (0)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100540_.tb3_0(0),
DESCRIPTION='Ra¿z'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100540_.tb3_0(0);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100540_.tb3_0(0),
'Ra¿z'
);
end if;

exception when others then
EXP_PROCESS_100540_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100540_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100540_.tb4_0(0):=102640;
EXP_PROCESS_100540_.tb4_2(0):=EXP_PROCESS_100540_.tb2_0(0);
EXP_PROCESS_100540_.tb4_3(0):=EXP_PROCESS_100540_.tb3_0(0);
EXP_PROCESS_100540_.tb4_4(0):=EXP_PROCESS_100540_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (0)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100540_.tb4_0(0),
PROCESS_ID=null,
UNIT_TYPE_ID=EXP_PROCESS_100540_.tb4_2(0),
NODE_TYPE_ID=EXP_PROCESS_100540_.tb4_3(0),
MODULE_ID=EXP_PROCESS_100540_.tb4_4(0),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='20
20'
,
DESCRIPTION='Título'
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

 WHERE UNIT_ID = EXP_PROCESS_100540_.tb4_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100540_.tb4_0(0),
null,
EXP_PROCESS_100540_.tb4_2(0),
EXP_PROCESS_100540_.tb4_3(0),
EXP_PROCESS_100540_.tb4_4(0),
null,
null,
null,
null,
'20
20'
,
'Título'
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
EXP_PROCESS_100540_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100540_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100540_.tb0_0(1):=2;
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_CATEGORY fila (1)',1);
UPDATE WF_UNIT_CATEGORY SET CATEGORY_ID=EXP_PROCESS_100540_.tb0_0(1),
DISPLAY_NUMBER='Actividad'

 WHERE CATEGORY_ID = EXP_PROCESS_100540_.tb0_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_CATEGORY(CATEGORY_ID,DISPLAY_NUMBER) 
VALUES (EXP_PROCESS_100540_.tb0_0(1),
'Actividad'
);
end if;

exception when others then
EXP_PROCESS_100540_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100540_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100540_.tb2_0(1):=283;
EXP_PROCESS_100540_.tb2_1(1):=EXP_PROCESS_100540_.tb0_0(1);
EXP_PROCESS_100540_.tb2_2(1):=EXP_PROCESS_100540_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (1)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100540_.tb2_0(1),
CATEGORY_ID=EXP_PROCESS_100540_.tb2_1(1),
MODULE_ID=EXP_PROCESS_100540_.tb2_2(1),
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100540_.tb2_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100540_.tb2_0(1),
EXP_PROCESS_100540_.tb2_1(1),
EXP_PROCESS_100540_.tb2_2(1),
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
EXP_PROCESS_100540_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100540_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100540_.tb3_0(1):=1;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (1)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100540_.tb3_0(1),
DESCRIPTION='Arranque'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100540_.tb3_0(1);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100540_.tb3_0(1),
'Arranque'
);
end if;

exception when others then
EXP_PROCESS_100540_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100540_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100540_.tb4_0(1):=102641;
EXP_PROCESS_100540_.tb4_1(1):=EXP_PROCESS_100540_.tb4_0(0);
EXP_PROCESS_100540_.tb4_2(1):=EXP_PROCESS_100540_.tb2_0(1);
EXP_PROCESS_100540_.tb4_3(1):=EXP_PROCESS_100540_.tb3_0(1);
EXP_PROCESS_100540_.tb4_4(1):=EXP_PROCESS_100540_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (1)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100540_.tb4_0(1),
PROCESS_ID=EXP_PROCESS_100540_.tb4_1(1),
UNIT_TYPE_ID=EXP_PROCESS_100540_.tb4_2(1),
NODE_TYPE_ID=EXP_PROCESS_100540_.tb4_3(1),
MODULE_ID=EXP_PROCESS_100540_.tb4_4(1),
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

 WHERE UNIT_ID = EXP_PROCESS_100540_.tb4_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100540_.tb4_0(1),
EXP_PROCESS_100540_.tb4_1(1),
EXP_PROCESS_100540_.tb4_2(1),
EXP_PROCESS_100540_.tb4_3(1),
EXP_PROCESS_100540_.tb4_4(1),
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
EXP_PROCESS_100540_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100540_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100540_.tb1_0(1):=5;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (1)',1);
UPDATE GE_MODULE SET MODULE_ID=EXP_PROCESS_100540_.tb1_0(1),
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

 WHERE MODULE_ID = EXP_PROCESS_100540_.tb1_0(1);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (EXP_PROCESS_100540_.tb1_0(1),
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
EXP_PROCESS_100540_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100540_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100540_.tb2_0(2):=100541;
EXP_PROCESS_100540_.tb2_1(2):=EXP_PROCESS_100540_.tb0_0(1);
EXP_PROCESS_100540_.tb2_2(2):=EXP_PROCESS_100540_.tb1_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (2)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100540_.tb2_0(2),
CATEGORY_ID=EXP_PROCESS_100540_.tb2_1(2),
MODULE_ID=EXP_PROCESS_100540_.tb2_2(2),
ACTION_ID=null,
PARENT_ID=983,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_100541'
,
DESCRIPTION='Atender Daño a Producto'
,
DISPLAY='Atender Daño a Producto'
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100540_.tb2_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100540_.tb2_0(2),
EXP_PROCESS_100540_.tb2_1(2),
EXP_PROCESS_100540_.tb2_2(2),
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_100541'
,
'Atender Daño a Producto'
,
'Atender Daño a Producto'
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
EXP_PROCESS_100540_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100540_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100540_.tb3_0(2):=2;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (2)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100540_.tb3_0(2),
DESCRIPTION='Normal'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100540_.tb3_0(2);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100540_.tb3_0(2),
'Normal'
);
end if;

exception when others then
EXP_PROCESS_100540_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100540_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100540_.tb4_0(2):=102643;
EXP_PROCESS_100540_.tb4_1(2):=EXP_PROCESS_100540_.tb4_0(0);
EXP_PROCESS_100540_.tb4_2(2):=EXP_PROCESS_100540_.tb2_0(2);
EXP_PROCESS_100540_.tb4_3(2):=EXP_PROCESS_100540_.tb3_0(2);
EXP_PROCESS_100540_.tb4_4(2):=EXP_PROCESS_100540_.tb1_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (2)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100540_.tb4_0(2),
PROCESS_ID=EXP_PROCESS_100540_.tb4_1(2),
UNIT_TYPE_ID=EXP_PROCESS_100540_.tb4_2(2),
NODE_TYPE_ID=EXP_PROCESS_100540_.tb4_3(2),
MODULE_ID=EXP_PROCESS_100540_.tb4_4(2),
ACTION_ID=8192,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=9000,
GEOMETRY='289
180'
,
DESCRIPTION='Atender Daño a Producto'
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

 WHERE UNIT_ID = EXP_PROCESS_100540_.tb4_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100540_.tb4_0(2),
EXP_PROCESS_100540_.tb4_1(2),
EXP_PROCESS_100540_.tb4_2(2),
EXP_PROCESS_100540_.tb4_3(2),
EXP_PROCESS_100540_.tb4_4(2),
8192,
null,
null,
9000,
'289
180'
,
'Atender Daño a Producto'
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
EXP_PROCESS_100540_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100540_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100540_.tb5_0(0):=100000617;
EXP_PROCESS_100540_.tb5_1(0):=EXP_PROCESS_100540_.tb4_0(1);
EXP_PROCESS_100540_.tb5_2(0):=EXP_PROCESS_100540_.tb4_0(2);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (0)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100540_.tb5_0(0),
ORIGIN_ID=EXP_PROCESS_100540_.tb5_1(0),
TARGET_ID=EXP_PROCESS_100540_.tb5_2(0),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION=null,
EXPRESSION_TYPE=0,
DESCRIPTION=null,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100540_.tb5_0(0);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100540_.tb5_0(0),
EXP_PROCESS_100540_.tb5_1(0),
EXP_PROCESS_100540_.tb5_2(0),
null,
0,
null,
0,
null,
1);
end if;

exception when others then
EXP_PROCESS_100540_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100540_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100540_.tb6_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTE_CLASS fila (0)',1);
UPDATE GE_ATTRIBUTE_CLASS SET ATTRIBUTE_CLASS_ID=EXP_PROCESS_100540_.tb6_0(0),
NAME='De Entitdad'
,
DESCRIPTION='Valores que ser¿n tra¿dos de la tabla base usando old record'

 WHERE ATTRIBUTE_CLASS_ID = EXP_PROCESS_100540_.tb6_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTE_CLASS(ATTRIBUTE_CLASS_ID,NAME,DESCRIPTION) 
VALUES (EXP_PROCESS_100540_.tb6_0(0),
'De Entitdad'
,
'Valores que ser¿n tra¿dos de la tabla base usando old record'
);
end if;

exception when others then
EXP_PROCESS_100540_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100540_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100540_.tb7_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES_TYPE fila (0)',1);
UPDATE GE_ATTRIBUTES_TYPE SET ATTRIBUTE_TYPE_ID=EXP_PROCESS_100540_.tb7_0(0),
DESCRIPTION='NUMBER'
,
INTERNAL_TYPE=2,
INTERNAL_JAVA_TYPE=2
 WHERE ATTRIBUTE_TYPE_ID = EXP_PROCESS_100540_.tb7_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES_TYPE(ATTRIBUTE_TYPE_ID,DESCRIPTION,INTERNAL_TYPE,INTERNAL_JAVA_TYPE) 
VALUES (EXP_PROCESS_100540_.tb7_0(0),
'NUMBER'
,
2,
2);
end if;

exception when others then
EXP_PROCESS_100540_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100540_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100540_.tb8_0(0):=400;
EXP_PROCESS_100540_.tb8_1(0):=EXP_PROCESS_100540_.tb6_0(0);
EXP_PROCESS_100540_.tb8_2(0):=EXP_PROCESS_100540_.tb7_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (0)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=EXP_PROCESS_100540_.tb8_0(0),
ATTRIBUTE_CLASS_ID=EXP_PROCESS_100540_.tb8_1(0),
ATTRIBUTE_TYPE_ID=EXP_PROCESS_100540_.tb8_2(0),
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

 WHERE ATTRIBUTE_ID = EXP_PROCESS_100540_.tb8_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,ATTRIBUTE_CLASS_ID,ATTRIBUTE_TYPE_ID,VALID_EXPRESSION,FATHER_ID,MODULE_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (EXP_PROCESS_100540_.tb8_0(0),
EXP_PROCESS_100540_.tb8_1(0),
EXP_PROCESS_100540_.tb8_2(0),
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
EXP_PROCESS_100540_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100540_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100540_.tb9_0(0):=100000567;
EXP_PROCESS_100540_.tb9_1(0):=EXP_PROCESS_100540_.tb4_0(1);
EXP_PROCESS_100540_.tb9_2(0):=EXP_PROCESS_100540_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (0)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100540_.tb9_0(0),
UNIT_ID=EXP_PROCESS_100540_.tb9_1(0),
ATTRIBUTE_ID=EXP_PROCESS_100540_.tb9_2(0),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100540_.tb9_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100540_.tb9_0(0),
EXP_PROCESS_100540_.tb9_1(0),
EXP_PROCESS_100540_.tb9_2(0),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_100540_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100540_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100540_.tb2_0(3):=252;
EXP_PROCESS_100540_.tb2_1(3):=EXP_PROCESS_100540_.tb0_0(1);
EXP_PROCESS_100540_.tb2_2(3):=EXP_PROCESS_100540_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (3)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100540_.tb2_0(3),
CATEGORY_ID=EXP_PROCESS_100540_.tb2_1(3),
MODULE_ID=EXP_PROCESS_100540_.tb2_2(3),
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100540_.tb2_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100540_.tb2_0(3),
EXP_PROCESS_100540_.tb2_1(3),
EXP_PROCESS_100540_.tb2_2(3),
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
EXP_PROCESS_100540_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100540_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100540_.tb3_0(3):=3;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (3)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100540_.tb3_0(3),
DESCRIPTION='Final'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100540_.tb3_0(3);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100540_.tb3_0(3),
'Final'
);
end if;

exception when others then
EXP_PROCESS_100540_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100540_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100540_.tb4_0(3):=102642;
EXP_PROCESS_100540_.tb4_1(3):=EXP_PROCESS_100540_.tb4_0(0);
EXP_PROCESS_100540_.tb4_2(3):=EXP_PROCESS_100540_.tb2_0(3);
EXP_PROCESS_100540_.tb4_3(3):=EXP_PROCESS_100540_.tb3_0(3);
EXP_PROCESS_100540_.tb4_4(3):=EXP_PROCESS_100540_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (3)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100540_.tb4_0(3),
PROCESS_ID=EXP_PROCESS_100540_.tb4_1(3),
UNIT_TYPE_ID=EXP_PROCESS_100540_.tb4_2(3),
NODE_TYPE_ID=EXP_PROCESS_100540_.tb4_3(3),
MODULE_ID=EXP_PROCESS_100540_.tb4_4(3),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='589
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

 WHERE UNIT_ID = EXP_PROCESS_100540_.tb4_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100540_.tb4_0(3),
EXP_PROCESS_100540_.tb4_1(3),
EXP_PROCESS_100540_.tb4_2(3),
EXP_PROCESS_100540_.tb4_3(3),
EXP_PROCESS_100540_.tb4_4(3),
null,
null,
null,
null,
'589
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
EXP_PROCESS_100540_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100540_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100540_.tb5_0(1):=100000618;
EXP_PROCESS_100540_.tb5_1(1):=EXP_PROCESS_100540_.tb4_0(2);
EXP_PROCESS_100540_.tb5_2(1):=EXP_PROCESS_100540_.tb4_0(3);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (1)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100540_.tb5_0(1),
ORIGIN_ID=EXP_PROCESS_100540_.tb5_1(1),
TARGET_ID=EXP_PROCESS_100540_.tb5_2(1),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION=null,
EXPRESSION_TYPE=0,
DESCRIPTION=null,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100540_.tb5_0(1);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100540_.tb5_0(1),
EXP_PROCESS_100540_.tb5_1(1),
EXP_PROCESS_100540_.tb5_2(1),
null,
0,
null,
0,
null,
1);
end if;

exception when others then
EXP_PROCESS_100540_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100540_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100540_.tb9_0(1):=100000570;
EXP_PROCESS_100540_.tb9_1(1):=EXP_PROCESS_100540_.tb4_0(2);
EXP_PROCESS_100540_.tb9_2(1):=EXP_PROCESS_100540_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (1)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100540_.tb9_0(1),
UNIT_ID=EXP_PROCESS_100540_.tb9_1(1),
ATTRIBUTE_ID=EXP_PROCESS_100540_.tb9_2(1),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=1,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100540_.tb9_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100540_.tb9_0(1),
EXP_PROCESS_100540_.tb9_1(1),
EXP_PROCESS_100540_.tb9_2(1),
null,
null,
'N'
,
1,
'N'
);
end if;

exception when others then
EXP_PROCESS_100540_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100540_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100540_.tb9_0(2):=100000568;
EXP_PROCESS_100540_.tb9_1(2):=EXP_PROCESS_100540_.tb4_0(3);
EXP_PROCESS_100540_.tb9_2(2):=EXP_PROCESS_100540_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (2)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100540_.tb9_0(2),
UNIT_ID=EXP_PROCESS_100540_.tb9_1(2),
ATTRIBUTE_ID=EXP_PROCESS_100540_.tb9_2(2),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100540_.tb9_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100540_.tb9_0(2),
EXP_PROCESS_100540_.tb9_1(2),
EXP_PROCESS_100540_.tb9_2(2),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_100540_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100540_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100540_.tb9_0(3):=100000569;
EXP_PROCESS_100540_.tb9_1(3):=EXP_PROCESS_100540_.tb4_0(3);
EXP_PROCESS_100540_.tb9_2(3):=EXP_PROCESS_100540_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (3)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100540_.tb9_0(3),
UNIT_ID=EXP_PROCESS_100540_.tb9_1(3),
ATTRIBUTE_ID=EXP_PROCESS_100540_.tb9_2(3),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100540_.tb9_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100540_.tb9_0(3),
EXP_PROCESS_100540_.tb9_1(3),
EXP_PROCESS_100540_.tb9_2(3),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_100540_.blProcessStatus := false;
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
sa_bocreatePackages.CreatePackage('EXP_UNITTYPE_100541_',
'CREATE OR REPLACE PACKAGE EXP_UNITTYPE_100541_ IS ' || chr(10) ||
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
'END EXP_UNITTYPE_100541_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_UNITTYPE_100541_******************************'); END;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_UNITTYPE_100541',1);
EXP_UNITTYPE_100541_.blProcessStatus := EXP_PROCESS_100540_.blProcessStatus ; 
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
AND     A.TASK_CODE = 100541
 
;
BEGIN

if (not EXP_UNITTYPE_100541_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_UNITTYPE_100541_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
FROM WF_UNIT_TYPE_ATTRIB WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100541);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100541_.blProcessStatus) then
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
EXP_UNITTYPE_100541_.blProcessStatus := false;
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
FROM WF_CAUSAL_UNIT_TYPE WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100541);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100541_.blProcessStatus) then
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
EXP_UNITTYPE_100541_.blProcessStatus := false;
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
FROM MO_TIME_UNI_TYP_PRIO WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100541);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100541_.blProcessStatus) then
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
EXP_UNITTYPE_100541_.blProcessStatus := false;
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
FROM OR_ACT_BY_TASK_MOD WHERE (TASK_CODE) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100541);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100541_.blProcessStatus) then
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
EXP_UNITTYPE_100541_.blProcessStatus := false;
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
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100541;
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100541_.blProcessStatus) then
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
EXP_UNITTYPE_100541_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_UNITTYPE_100541_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100541_.tb0_0(0):=100541;
ut_trace.trace('insertando tabla sin fallo: WF_UNIT_TYPE fila (0)',1);
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_UNITTYPE_100541_.tb0_0(0),
2,
5,
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_100541'
,
'Atender Daño a Producto'
,
'Atender Daño a Producto'
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
EXP_UNITTYPE_100541_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100540',1);
EXP_PROCESS_100540_.blProcessStatus := EXP_UNITTYPE_100541_.blProcessStatus ; 
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
 nuIndex := EXP_UNITTYPE_100541_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_UNITTYPE_100541_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_UNITTYPE_100541_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_UNITTYPE_100541_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_UNITTYPE_100541_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_UNITTYPE_100541_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_UNITTYPE_100541_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_UNITTYPE_100541_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_UNITTYPE_100541_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_UNITTYPE_100541_******************************'); end;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_170',1);
EXP_PROCESS_170_.blProcessStatus := EXP_PROCESS_100540_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
DECLARE 
    nuBinaryIndex Binary_Integer;
BEGIN 
    nuBinaryIndex := EXP_PROCESS_100540_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = EXP_PROCESS_100540_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||EXP_PROCESS_100540_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||EXP_PROCESS_100540_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := EXP_PROCESS_100540_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       EXP_PROCESS_100540_.blProcessStatus := FALSE;
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
 nuIndex := EXP_PROCESS_100540_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_PROCESS_100540_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_PROCESS_100540_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_PROCESS_100540_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_PROCESS_100540_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_PROCESS_100540_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_PROCESS_100540_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_PROCESS_100540_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_PROCESS_100540_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_PROCESS_100540_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_PROCESS_316_',
'CREATE OR REPLACE PACKAGE EXP_PROCESS_316_ IS ' || chr(10) ||
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
'        WHERE UNIT_TYPE_ID = 316 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID IN  ' || chr(10) ||
'           (SELECT UNIT_ID ' || chr(10) ||
'           FROM WF_UNIT ' || chr(10) ||
'           WHERE UNIT_TYPE_ID = 316 ' || chr(10) ||
'       )) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_TYPE_ID = 316 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID IN  ' || chr(10) ||
'           (SELECT UNIT_ID ' || chr(10) ||
'           FROM WF_UNIT ' || chr(10) ||
'           WHERE UNIT_TYPE_ID = 316 ' || chr(10) ||
'       )) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_PROCESS_316_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_PROCESS_316_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open EXP_PROCESS_316_.cuExpression;
   fetch EXP_PROCESS_316_.cuExpression bulk collect INTO EXP_PROCESS_316_.tbGR_CONFIG_EXPRESSIONId;
   close EXP_PROCESS_316_.cuExpression;
END;
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_316',1);
EXP_PROCESS_316_.blProcessStatus := EXP_PROCESS_170_.blProcessStatus ; 
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
sa_bocreatePackages.CreatePackage('DEL_ROOT_611_',
'CREATE OR REPLACE PACKAGE DEL_ROOT_611_ IS ' || chr(10) ||
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
'        WHERE UNIT_ID = 611 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 611  ' || chr(10) ||
'       ) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_ID = 611 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 611  ' || chr(10) ||
'       ) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END DEL_ROOT_611_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:DEL_ROOT_611_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open DEL_ROOT_611_.cuExpression;
   fetch DEL_ROOT_611_.cuExpression bulk collect INTO DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONId;
   close DEL_ROOT_611_.cuExpression;
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
        WHERE UNIT_ID = 611
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID = 611 
       )
;
BEGIN

if (not DEL_ROOT_611_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  DEL_ROOT_611_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE PROCESS_ID = 611);
BEGIN 

if (not DEL_ROOT_611_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_611_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE PROCESS_ID = 611);
BEGIN 

if (not DEL_ROOT_611_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_611_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 611)));
BEGIN 

if (not DEL_ROOT_611_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_611_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 611)));
BEGIN 

if (not DEL_ROOT_611_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_611_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 611));
BEGIN 

if (not DEL_ROOT_611_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla WF_UNIT',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_611_.tbWF_UNITRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_611_.blProcessStatus := false;
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
FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 611);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_611_.blProcessStatus) then
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
DEL_ROOT_611_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_611_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_611_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_611_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_611_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_611_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria WF_UNIT',1);
nuVarcharIndex:=DEL_ROOT_611_.tbWF_UNITRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from WF_UNIT where rowid = DEL_ROOT_611_.tbWF_UNITRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_611_.tbWF_UNITRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_611_.tbWF_UNITRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_611_.blProcessStatus := false;
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
FROM WF_UNIT_DATA_MAP WHERE (SOURCE_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 611));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_611_.blProcessStatus) then
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
DEL_ROOT_611_.blProcessStatus := false;
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
FROM WF_UNIT_DATA_MAP WHERE (TARGET_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 611));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_611_.blProcessStatus) then
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
DEL_ROOT_611_.blProcessStatus := false;
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
FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 611);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_611_.blProcessStatus) then
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
DEL_ROOT_611_.blProcessStatus := false;
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
FROM WF_UNIT WHERE PROCESS_ID = 611;
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_611_.blProcessStatus) then
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
DEL_ROOT_611_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_611_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_611_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_611_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_611_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/

BEGIN
    ut_trace.trace('Actualizar WF_UNIT a ProcessId NULL ',1);
   UPDATE WF_UNIT 
     SET PROCESS_ID = -1, POS_EXPRESSION_ID = null, PRE_EXPRESSION_ID = null, ACTION_ID = null 
     WHERE PROCESS_ID = 611;
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
    nuBinaryIndex := DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       DEL_ROOT_611_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_316',1);
EXP_PROCESS_316_.blProcessStatus := DEL_ROOT_611_.blProcessStatus ; 
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
 nuIndex := DEL_ROOT_611_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || DEL_ROOT_611_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(DEL_ROOT_611_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(DEL_ROOT_611_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(DEL_ROOT_611_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || DEL_ROOT_611_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || DEL_ROOT_611_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := DEL_ROOT_611_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('DEL_ROOT_611_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:DEL_ROOT_611_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('DEL_ROOT_611_',
'CREATE OR REPLACE PACKAGE DEL_ROOT_611_ IS ' || chr(10) ||
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
'        WHERE UNIT_ID = 611 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 611  ' || chr(10) ||
'       ) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_ID = 611 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 611  ' || chr(10) ||
'       ) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END DEL_ROOT_611_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:DEL_ROOT_611_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open DEL_ROOT_611_.cuExpression;
   fetch DEL_ROOT_611_.cuExpression bulk collect INTO DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONId;
   close DEL_ROOT_611_.cuExpression;
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
        WHERE UNIT_ID = 611
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID = 611 
       )
;
BEGIN

if (not DEL_ROOT_611_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  DEL_ROOT_611_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE UNIT_ID = 611);
BEGIN 

if (not DEL_ROOT_611_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_611_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE UNIT_ID = 611);
BEGIN 

if (not DEL_ROOT_611_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_611_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 611)));
BEGIN 

if (not DEL_ROOT_611_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_611_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 611)));
BEGIN 

if (not DEL_ROOT_611_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_611_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 611));
BEGIN 

if (not DEL_ROOT_611_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla WF_UNIT',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_611_.tbWF_UNITRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_611_.blProcessStatus := false;
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
FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 611);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_611_.blProcessStatus) then
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
DEL_ROOT_611_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_611_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_611_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_611_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_611_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_611_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria WF_UNIT',1);
nuVarcharIndex:=DEL_ROOT_611_.tbWF_UNITRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from WF_UNIT where rowid = DEL_ROOT_611_.tbWF_UNITRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_611_.tbWF_UNITRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_611_.tbWF_UNITRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_611_.blProcessStatus := false;
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
FROM WF_UNIT_DATA_MAP WHERE (SOURCE_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 611));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_611_.blProcessStatus) then
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
DEL_ROOT_611_.blProcessStatus := false;
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
FROM WF_UNIT_DATA_MAP WHERE (TARGET_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 611));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_611_.blProcessStatus) then
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
DEL_ROOT_611_.blProcessStatus := false;
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
FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 611);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_611_.blProcessStatus) then
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
DEL_ROOT_611_.blProcessStatus := false;
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
FROM WF_UNIT WHERE UNIT_ID = 611;
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_611_.blProcessStatus) then
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
DEL_ROOT_611_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_611_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_611_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_611_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_611_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/

BEGIN
    ut_trace.trace('Actualizar WF_UNIT a ProcessId NULL ',1);
   UPDATE WF_UNIT 
     SET PROCESS_ID = -1, POS_EXPRESSION_ID = null, PRE_EXPRESSION_ID = null, ACTION_ID = null 
     WHERE PROCESS_ID = 611;
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
    nuBinaryIndex := DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := DEL_ROOT_611_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       DEL_ROOT_611_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_316',1);
EXP_PROCESS_316_.blProcessStatus := DEL_ROOT_611_.blProcessStatus ; 
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
 nuIndex := DEL_ROOT_611_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || DEL_ROOT_611_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(DEL_ROOT_611_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(DEL_ROOT_611_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(DEL_ROOT_611_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || DEL_ROOT_611_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || DEL_ROOT_611_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := DEL_ROOT_611_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('DEL_ROOT_611_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:DEL_ROOT_611_******************************'); end;
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
EXP_ACTION_257_.blProcessStatus := EXP_PROCESS_316_.blProcessStatus ; 
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

EXP_ACTION_257_.old_tb1_0(0):=121357864;
EXP_ACTION_257_.tb1_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
EXP_ACTION_257_.tb1_0(0):=EXP_ACTION_257_.tb1_0(0);
EXP_ACTION_257_.old_tb1_1(0):='GE_EXEACTION_CT1E121357864'
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
to_date('28-03-2020 19:52:41','DD-MM-YYYY HH24:MI:SS'),
to_date('28-03-2020 19:52:41','DD-MM-YYYY HH24:MI:SS'),
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
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_316',1);
EXP_PROCESS_316_.blProcessStatus := EXP_ACTION_257_.blProcessStatus ; 
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
        WHERE UNIT_TYPE_ID = 316
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID IN 
           (SELECT UNIT_ID
           FROM WF_UNIT
           WHERE UNIT_TYPE_ID = 316
       ))
;
BEGIN

if (not EXP_PROCESS_316_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_PROCESS_316_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=316) AND NODE_TYPE_ID=0);
BEGIN 

if (not EXP_PROCESS_316_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_PROCESS_316_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_PROCESS_316_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=316) AND NODE_TYPE_ID=0);
BEGIN 

if (not EXP_PROCESS_316_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_PROCESS_316_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_PROCESS_316_.blProcessStatus := false;
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
FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=316) AND NODE_TYPE_ID=0;
nuIndex binary_integer;
BEGIN

if (not EXP_PROCESS_316_.blProcessStatus) then
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
EXP_PROCESS_316_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_PROCESS_316_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_PROCESS_316_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_PROCESS_316_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_PROCESS_316_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_PROCESS_316_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_PROCESS_316_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_PROCESS_316_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_PROCESS_316_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_PROCESS_316_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_PROCESS_316_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_PROCESS_316_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_PROCESS_316_.blProcessStatus := false;
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
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=316;
nuIndex binary_integer;
BEGIN

if (not EXP_PROCESS_316_.blProcessStatus) then
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
EXP_PROCESS_316_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_PROCESS_316_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_316_.tb0_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_CATEGORY fila (0)',1);
UPDATE WF_UNIT_CATEGORY SET CATEGORY_ID=EXP_PROCESS_316_.tb0_0(0),
DISPLAY_NUMBER='Proceso B¿sico'

 WHERE CATEGORY_ID = EXP_PROCESS_316_.tb0_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_CATEGORY(CATEGORY_ID,DISPLAY_NUMBER) 
VALUES (EXP_PROCESS_316_.tb0_0(0),
'Proceso B¿sico'
);
end if;

exception when others then
EXP_PROCESS_316_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_316_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_316_.tb1_0(0):=9;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (0)',1);
UPDATE GE_MODULE SET MODULE_ID=EXP_PROCESS_316_.tb1_0(0),
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

 WHERE MODULE_ID = EXP_PROCESS_316_.tb1_0(0);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (EXP_PROCESS_316_.tb1_0(0),
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
EXP_PROCESS_316_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_316_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_316_.tb2_0(0):=316;
EXP_PROCESS_316_.tb2_1(0):=EXP_PROCESS_316_.tb0_0(0);
EXP_PROCESS_316_.tb2_2(0):=EXP_PROCESS_316_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (0)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_316_.tb2_0(0),
CATEGORY_ID=EXP_PROCESS_316_.tb2_1(0),
MODULE_ID=EXP_PROCESS_316_.tb2_2(0),
ACTION_ID=null,
PARENT_ID=983,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_316'
,
DESCRIPTION='Proceso de Distribución de Cargos'
,
DISPLAY='Proceso de Distribución de Cargos'
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_316_.tb2_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_316_.tb2_0(0),
EXP_PROCESS_316_.tb2_1(0),
EXP_PROCESS_316_.tb2_2(0),
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_316'
,
'Proceso de Distribución de Cargos'
,
'Proceso de Distribución de Cargos'
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
EXP_PROCESS_316_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_316_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_316_.tb3_0(0):=0;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (0)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_316_.tb3_0(0),
DESCRIPTION='Ra¿z'

 WHERE NODE_TYPE_ID = EXP_PROCESS_316_.tb3_0(0);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_316_.tb3_0(0),
'Ra¿z'
);
end if;

exception when others then
EXP_PROCESS_316_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_316_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_316_.tb4_0(0):=611;
EXP_PROCESS_316_.tb4_2(0):=EXP_PROCESS_316_.tb2_0(0);
EXP_PROCESS_316_.tb4_3(0):=EXP_PROCESS_316_.tb3_0(0);
EXP_PROCESS_316_.tb4_4(0):=EXP_PROCESS_316_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (0)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_316_.tb4_0(0),
PROCESS_ID=null,
UNIT_TYPE_ID=EXP_PROCESS_316_.tb4_2(0),
NODE_TYPE_ID=EXP_PROCESS_316_.tb4_3(0),
MODULE_ID=EXP_PROCESS_316_.tb4_4(0),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='20
20'
,
DESCRIPTION='Título'
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

 WHERE UNIT_ID = EXP_PROCESS_316_.tb4_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_316_.tb4_0(0),
null,
EXP_PROCESS_316_.tb4_2(0),
EXP_PROCESS_316_.tb4_3(0),
EXP_PROCESS_316_.tb4_4(0),
null,
null,
null,
null,
'20
20'
,
'Título'
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
EXP_PROCESS_316_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_316_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_316_.tb0_0(1):=2;
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_CATEGORY fila (1)',1);
UPDATE WF_UNIT_CATEGORY SET CATEGORY_ID=EXP_PROCESS_316_.tb0_0(1),
DISPLAY_NUMBER='Actividad'

 WHERE CATEGORY_ID = EXP_PROCESS_316_.tb0_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_CATEGORY(CATEGORY_ID,DISPLAY_NUMBER) 
VALUES (EXP_PROCESS_316_.tb0_0(1),
'Actividad'
);
end if;

exception when others then
EXP_PROCESS_316_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_316_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_316_.tb1_0(1):=5;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (1)',1);
UPDATE GE_MODULE SET MODULE_ID=EXP_PROCESS_316_.tb1_0(1),
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

 WHERE MODULE_ID = EXP_PROCESS_316_.tb1_0(1);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (EXP_PROCESS_316_.tb1_0(1),
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
EXP_PROCESS_316_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_316_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_316_.tb2_0(1):=313;
EXP_PROCESS_316_.tb2_1(1):=EXP_PROCESS_316_.tb0_0(1);
EXP_PROCESS_316_.tb2_2(1):=EXP_PROCESS_316_.tb1_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (1)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_316_.tb2_0(1),
CATEGORY_ID=EXP_PROCESS_316_.tb2_1(1),
MODULE_ID=EXP_PROCESS_316_.tb2_2(1),
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_316_.tb2_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_316_.tb2_0(1),
EXP_PROCESS_316_.tb2_1(1),
EXP_PROCESS_316_.tb2_2(1),
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
EXP_PROCESS_316_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_316_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_316_.tb3_0(1):=2;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (1)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_316_.tb3_0(1),
DESCRIPTION='Normal'

 WHERE NODE_TYPE_ID = EXP_PROCESS_316_.tb3_0(1);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_316_.tb3_0(1),
'Normal'
);
end if;

exception when others then
EXP_PROCESS_316_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_316_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_316_.tb4_0(1):=617;
EXP_PROCESS_316_.tb4_1(1):=EXP_PROCESS_316_.tb4_0(0);
EXP_PROCESS_316_.tb4_2(1):=EXP_PROCESS_316_.tb2_0(1);
EXP_PROCESS_316_.tb4_3(1):=EXP_PROCESS_316_.tb3_0(1);
EXP_PROCESS_316_.tb4_4(1):=EXP_PROCESS_316_.tb1_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (1)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_316_.tb4_0(1),
PROCESS_ID=EXP_PROCESS_316_.tb4_1(1),
UNIT_TYPE_ID=EXP_PROCESS_316_.tb4_2(1),
NODE_TYPE_ID=EXP_PROCESS_316_.tb4_3(1),
MODULE_ID=EXP_PROCESS_316_.tb4_4(1),
ACTION_ID=257,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=9000,
GEOMETRY='331
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

 WHERE UNIT_ID = EXP_PROCESS_316_.tb4_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_316_.tb4_0(1),
EXP_PROCESS_316_.tb4_1(1),
EXP_PROCESS_316_.tb4_2(1),
EXP_PROCESS_316_.tb4_3(1),
EXP_PROCESS_316_.tb4_4(1),
257,
null,
null,
9000,
'331
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
EXP_PROCESS_316_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_316_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_316_.tb2_0(2):=252;
EXP_PROCESS_316_.tb2_1(2):=EXP_PROCESS_316_.tb0_0(1);
EXP_PROCESS_316_.tb2_2(2):=EXP_PROCESS_316_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (2)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_316_.tb2_0(2),
CATEGORY_ID=EXP_PROCESS_316_.tb2_1(2),
MODULE_ID=EXP_PROCESS_316_.tb2_2(2),
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_316_.tb2_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_316_.tb2_0(2),
EXP_PROCESS_316_.tb2_1(2),
EXP_PROCESS_316_.tb2_2(2),
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
EXP_PROCESS_316_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_316_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_316_.tb3_0(2):=3;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (2)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_316_.tb3_0(2),
DESCRIPTION='Final'

 WHERE NODE_TYPE_ID = EXP_PROCESS_316_.tb3_0(2);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_316_.tb3_0(2),
'Final'
);
end if;

exception when others then
EXP_PROCESS_316_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_316_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_316_.tb4_0(2):=615;
EXP_PROCESS_316_.tb4_1(2):=EXP_PROCESS_316_.tb4_0(0);
EXP_PROCESS_316_.tb4_2(2):=EXP_PROCESS_316_.tb2_0(2);
EXP_PROCESS_316_.tb4_3(2):=EXP_PROCESS_316_.tb3_0(2);
EXP_PROCESS_316_.tb4_4(2):=EXP_PROCESS_316_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (2)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_316_.tb4_0(2),
PROCESS_ID=EXP_PROCESS_316_.tb4_1(2),
UNIT_TYPE_ID=EXP_PROCESS_316_.tb4_2(2),
NODE_TYPE_ID=EXP_PROCESS_316_.tb4_3(2),
MODULE_ID=EXP_PROCESS_316_.tb4_4(2),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='589
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

 WHERE UNIT_ID = EXP_PROCESS_316_.tb4_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_316_.tb4_0(2),
EXP_PROCESS_316_.tb4_1(2),
EXP_PROCESS_316_.tb4_2(2),
EXP_PROCESS_316_.tb4_3(2),
EXP_PROCESS_316_.tb4_4(2),
null,
null,
null,
null,
'589
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
EXP_PROCESS_316_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_316_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_316_.tb5_0(0):=123913;
EXP_PROCESS_316_.tb5_1(0):=EXP_PROCESS_316_.tb4_0(1);
EXP_PROCESS_316_.tb5_2(0):=EXP_PROCESS_316_.tb4_0(2);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (0)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_316_.tb5_0(0),
ORIGIN_ID=EXP_PROCESS_316_.tb5_1(0),
TARGET_ID=EXP_PROCESS_316_.tb5_2(0),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION=null,
EXPRESSION_TYPE=0,
DESCRIPTION=null,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_316_.tb5_0(0);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_316_.tb5_0(0),
EXP_PROCESS_316_.tb5_1(0),
EXP_PROCESS_316_.tb5_2(0),
null,
0,
null,
0,
null,
1);
end if;

exception when others then
EXP_PROCESS_316_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_316_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_316_.tb2_0(3):=283;
EXP_PROCESS_316_.tb2_1(3):=EXP_PROCESS_316_.tb0_0(1);
EXP_PROCESS_316_.tb2_2(3):=EXP_PROCESS_316_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (3)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_316_.tb2_0(3),
CATEGORY_ID=EXP_PROCESS_316_.tb2_1(3),
MODULE_ID=EXP_PROCESS_316_.tb2_2(3),
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_316_.tb2_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_316_.tb2_0(3),
EXP_PROCESS_316_.tb2_1(3),
EXP_PROCESS_316_.tb2_2(3),
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
EXP_PROCESS_316_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_316_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_316_.tb3_0(3):=1;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (3)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_316_.tb3_0(3),
DESCRIPTION='Arranque'

 WHERE NODE_TYPE_ID = EXP_PROCESS_316_.tb3_0(3);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_316_.tb3_0(3),
'Arranque'
);
end if;

exception when others then
EXP_PROCESS_316_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_316_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_316_.tb4_0(3):=614;
EXP_PROCESS_316_.tb4_1(3):=EXP_PROCESS_316_.tb4_0(0);
EXP_PROCESS_316_.tb4_2(3):=EXP_PROCESS_316_.tb2_0(3);
EXP_PROCESS_316_.tb4_3(3):=EXP_PROCESS_316_.tb3_0(3);
EXP_PROCESS_316_.tb4_4(3):=EXP_PROCESS_316_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (3)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_316_.tb4_0(3),
PROCESS_ID=EXP_PROCESS_316_.tb4_1(3),
UNIT_TYPE_ID=EXP_PROCESS_316_.tb4_2(3),
NODE_TYPE_ID=EXP_PROCESS_316_.tb4_3(3),
MODULE_ID=EXP_PROCESS_316_.tb4_4(3),
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
IS_COUNTABLE='Y'
,
MIN_GROUP_SIZE=null,
EXECUTION_ORDER='A'
,
ANNULATION_ORDER='N'
,
ENTITY_ID=8,
VIEWABLE='Y'

 WHERE UNIT_ID = EXP_PROCESS_316_.tb4_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_316_.tb4_0(3),
EXP_PROCESS_316_.tb4_1(3),
EXP_PROCESS_316_.tb4_2(3),
EXP_PROCESS_316_.tb4_3(3),
EXP_PROCESS_316_.tb4_4(3),
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
'Y'
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
EXP_PROCESS_316_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_316_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_316_.tb5_0(1):=123911;
EXP_PROCESS_316_.tb5_1(1):=EXP_PROCESS_316_.tb4_0(3);
EXP_PROCESS_316_.tb5_2(1):=EXP_PROCESS_316_.tb4_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (1)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_316_.tb5_0(1),
ORIGIN_ID=EXP_PROCESS_316_.tb5_1(1),
TARGET_ID=EXP_PROCESS_316_.tb5_2(1),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION='FLAG_VALIDATE == SI'
,
EXPRESSION_TYPE=0,
DESCRIPTION='Distribuye Cargos'
,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_316_.tb5_0(1);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_316_.tb5_0(1),
EXP_PROCESS_316_.tb5_1(1),
EXP_PROCESS_316_.tb5_2(1),
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
EXP_PROCESS_316_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_316_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_316_.tb6_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTE_CLASS fila (0)',1);
UPDATE GE_ATTRIBUTE_CLASS SET ATTRIBUTE_CLASS_ID=EXP_PROCESS_316_.tb6_0(0),
NAME='De Entitdad'
,
DESCRIPTION='Valores que ser¿n tra¿dos de la tabla base usando old record'

 WHERE ATTRIBUTE_CLASS_ID = EXP_PROCESS_316_.tb6_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTE_CLASS(ATTRIBUTE_CLASS_ID,NAME,DESCRIPTION) 
VALUES (EXP_PROCESS_316_.tb6_0(0),
'De Entitdad'
,
'Valores que ser¿n tra¿dos de la tabla base usando old record'
);
end if;

exception when others then
EXP_PROCESS_316_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_316_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_316_.tb7_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES_TYPE fila (0)',1);
UPDATE GE_ATTRIBUTES_TYPE SET ATTRIBUTE_TYPE_ID=EXP_PROCESS_316_.tb7_0(0),
DESCRIPTION='NUMBER'
,
INTERNAL_TYPE=2,
INTERNAL_JAVA_TYPE=2
 WHERE ATTRIBUTE_TYPE_ID = EXP_PROCESS_316_.tb7_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES_TYPE(ATTRIBUTE_TYPE_ID,DESCRIPTION,INTERNAL_TYPE,INTERNAL_JAVA_TYPE) 
VALUES (EXP_PROCESS_316_.tb7_0(0),
'NUMBER'
,
2,
2);
end if;

exception when others then
EXP_PROCESS_316_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_316_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_316_.tb8_0(0):=400;
EXP_PROCESS_316_.tb8_1(0):=EXP_PROCESS_316_.tb6_0(0);
EXP_PROCESS_316_.tb8_2(0):=EXP_PROCESS_316_.tb7_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (0)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=EXP_PROCESS_316_.tb8_0(0),
ATTRIBUTE_CLASS_ID=EXP_PROCESS_316_.tb8_1(0),
ATTRIBUTE_TYPE_ID=EXP_PROCESS_316_.tb8_2(0),
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

 WHERE ATTRIBUTE_ID = EXP_PROCESS_316_.tb8_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,ATTRIBUTE_CLASS_ID,ATTRIBUTE_TYPE_ID,VALID_EXPRESSION,FATHER_ID,MODULE_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (EXP_PROCESS_316_.tb8_0(0),
EXP_PROCESS_316_.tb8_1(0),
EXP_PROCESS_316_.tb8_2(0),
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
EXP_PROCESS_316_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_316_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_316_.tb9_0(0):=133669;
EXP_PROCESS_316_.tb9_1(0):=EXP_PROCESS_316_.tb4_0(1);
EXP_PROCESS_316_.tb9_2(0):=EXP_PROCESS_316_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (0)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_316_.tb9_0(0),
UNIT_ID=EXP_PROCESS_316_.tb9_1(0),
ATTRIBUTE_ID=EXP_PROCESS_316_.tb9_2(0),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='Y'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_316_.tb9_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_316_.tb9_0(0),
EXP_PROCESS_316_.tb9_1(0),
EXP_PROCESS_316_.tb9_2(0),
null,
null,
'N'
,
2,
'Y'
);
end if;

exception when others then
EXP_PROCESS_316_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_316_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_316_.tb5_0(2):=123912;
EXP_PROCESS_316_.tb5_1(2):=EXP_PROCESS_316_.tb4_0(3);
EXP_PROCESS_316_.tb5_2(2):=EXP_PROCESS_316_.tb4_0(2);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (2)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_316_.tb5_0(2),
ORIGIN_ID=EXP_PROCESS_316_.tb5_1(2),
TARGET_ID=EXP_PROCESS_316_.tb5_2(2),
GEOMETRY='64
324
624
324'
,
GROUP_ID=0,
EXPRESSION='FLAG_VALIDATE == NO'
,
EXPRESSION_TYPE=0,
DESCRIPTION='No Distribuye Cargos'
,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_316_.tb5_0(2);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_316_.tb5_0(2),
EXP_PROCESS_316_.tb5_1(2),
EXP_PROCESS_316_.tb5_2(2),
'64
324
624
324'
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
EXP_PROCESS_316_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_316_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_316_.tb9_0(1):=133668;
EXP_PROCESS_316_.tb9_1(1):=EXP_PROCESS_316_.tb4_0(2);
EXP_PROCESS_316_.tb9_2(1):=EXP_PROCESS_316_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (1)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_316_.tb9_0(1),
UNIT_ID=EXP_PROCESS_316_.tb9_1(1),
ATTRIBUTE_ID=EXP_PROCESS_316_.tb9_2(1),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_316_.tb9_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_316_.tb9_0(1),
EXP_PROCESS_316_.tb9_1(1),
EXP_PROCESS_316_.tb9_2(1),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_316_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_316_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_316_.tb9_0(2):=133667;
EXP_PROCESS_316_.tb9_1(2):=EXP_PROCESS_316_.tb4_0(2);
EXP_PROCESS_316_.tb9_2(2):=EXP_PROCESS_316_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (2)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_316_.tb9_0(2),
UNIT_ID=EXP_PROCESS_316_.tb9_1(2),
ATTRIBUTE_ID=EXP_PROCESS_316_.tb9_2(2),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_316_.tb9_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_316_.tb9_0(2),
EXP_PROCESS_316_.tb9_1(2),
EXP_PROCESS_316_.tb9_2(2),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_316_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_316_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_316_.tb9_0(3):=133665;
EXP_PROCESS_316_.tb9_1(3):=EXP_PROCESS_316_.tb4_0(3);
EXP_PROCESS_316_.tb9_2(3):=EXP_PROCESS_316_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (3)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_316_.tb9_0(3),
UNIT_ID=EXP_PROCESS_316_.tb9_1(3),
ATTRIBUTE_ID=EXP_PROCESS_316_.tb9_2(3),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_316_.tb9_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_316_.tb9_0(3),
EXP_PROCESS_316_.tb9_1(3),
EXP_PROCESS_316_.tb9_2(3),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_316_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_316_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_316_.tb6_0(1):=8;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTE_CLASS fila (1)',1);
UPDATE GE_ATTRIBUTE_CLASS SET ATTRIBUTE_CLASS_ID=EXP_PROCESS_316_.tb6_0(1),
NAME='Por Defecto General'
,
DESCRIPTION='Valores que ser¿n utilizados para clasificaci¿n gen¿rica'

 WHERE ATTRIBUTE_CLASS_ID = EXP_PROCESS_316_.tb6_0(1);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTE_CLASS(ATTRIBUTE_CLASS_ID,NAME,DESCRIPTION) 
VALUES (EXP_PROCESS_316_.tb6_0(1),
'Por Defecto General'
,
'Valores que ser¿n utilizados para clasificaci¿n gen¿rica'
);
end if;

exception when others then
EXP_PROCESS_316_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_316_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_316_.tb8_0(1):=442;
EXP_PROCESS_316_.tb8_1(1):=EXP_PROCESS_316_.tb6_0(1);
EXP_PROCESS_316_.tb8_2(1):=EXP_PROCESS_316_.tb7_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (1)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=EXP_PROCESS_316_.tb8_0(1),
ATTRIBUTE_CLASS_ID=EXP_PROCESS_316_.tb8_1(1),
ATTRIBUTE_TYPE_ID=EXP_PROCESS_316_.tb8_2(1),
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

 WHERE ATTRIBUTE_ID = EXP_PROCESS_316_.tb8_0(1);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,ATTRIBUTE_CLASS_ID,ATTRIBUTE_TYPE_ID,VALID_EXPRESSION,FATHER_ID,MODULE_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (EXP_PROCESS_316_.tb8_0(1),
EXP_PROCESS_316_.tb8_1(1),
EXP_PROCESS_316_.tb8_2(1),
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
EXP_PROCESS_316_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_316_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_316_.old_tb10_0(0):=120182713;
EXP_PROCESS_316_.tb10_0(0):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
EXP_PROCESS_316_.tb10_0(0):=EXP_PROCESS_316_.tb10_0(0);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (0)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (EXP_PROCESS_316_.tb10_0(0),
9,
'Distribución de Cargos'
,
'SELECT decode((case when AB_BOAddress.fsbIsbaseAddress(d.address_id) = '|| chr(39) ||'Y'|| chr(39) ||' then nvl(c.COLLECT_DISTRIBUTE,'|| chr(39) ||'N'|| chr(39) ||') else '|| chr(39) ||'N'|| chr(39) ||' end),'|| chr(39) ||'N'|| chr(39) ||',0,1) FLAG_VALIDATE
FROM mo_packages A, mo_motive B, pr_product C, ab_address D
WHERE b.motive_id = :INST.EXTERNAL_ID:
AND A.package_id = b.package_id
AND b.product_id = c.product_id
AND c.address_id = d.address_id'
,
'Distribución de Cargos'
);

exception when others then
EXP_PROCESS_316_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_316_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_316_.tb9_0(4):=133666;
EXP_PROCESS_316_.tb9_1(4):=EXP_PROCESS_316_.tb4_0(3);
EXP_PROCESS_316_.tb9_2(4):=EXP_PROCESS_316_.tb8_0(1);
EXP_PROCESS_316_.tb9_3(4):=EXP_PROCESS_316_.tb10_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (4)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_316_.tb9_0(4),
UNIT_ID=EXP_PROCESS_316_.tb9_1(4),
ATTRIBUTE_ID=EXP_PROCESS_316_.tb9_2(4),
STATEMENT_ID=EXP_PROCESS_316_.tb9_3(4),
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='Y'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_316_.tb9_0(4);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_316_.tb9_0(4),
EXP_PROCESS_316_.tb9_1(4),
EXP_PROCESS_316_.tb9_2(4),
EXP_PROCESS_316_.tb9_3(4),
null,
'N'
,
2,
'Y'
);
end if;

exception when others then
EXP_PROCESS_316_.blProcessStatus := false;
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
EXP_UNITTYPE_313_.blProcessStatus := EXP_PROCESS_316_.blProcessStatus ; 
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
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_316',1);
EXP_PROCESS_316_.blProcessStatus := EXP_UNITTYPE_313_.blProcessStatus ; 
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
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_170',1);
EXP_PROCESS_170_.blProcessStatus := EXP_PROCESS_316_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
DECLARE 
    nuBinaryIndex Binary_Integer;
BEGIN 
    nuBinaryIndex := EXP_PROCESS_316_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = EXP_PROCESS_316_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||EXP_PROCESS_316_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||EXP_PROCESS_316_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := EXP_PROCESS_316_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       EXP_PROCESS_316_.blProcessStatus := FALSE;
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
 nuIndex := EXP_PROCESS_316_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_PROCESS_316_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_PROCESS_316_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_PROCESS_316_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_PROCESS_316_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_PROCESS_316_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_PROCESS_316_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_PROCESS_316_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_PROCESS_316_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_PROCESS_316_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_PROCESS_251_',
'CREATE OR REPLACE PACKAGE EXP_PROCESS_251_ IS ' || chr(10) ||
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
'tb9_3 ty9_3; ' || chr(10) ||
'CURSOR cuExpression is ' || chr(10) ||
'SELECT PRE_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_TYPE_ID = 251 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID IN  ' || chr(10) ||
'           (SELECT UNIT_ID ' || chr(10) ||
'           FROM WF_UNIT ' || chr(10) ||
'           WHERE UNIT_TYPE_ID = 251 ' || chr(10) ||
'       )) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_TYPE_ID = 251 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID IN  ' || chr(10) ||
'           (SELECT UNIT_ID ' || chr(10) ||
'           FROM WF_UNIT ' || chr(10) ||
'           WHERE UNIT_TYPE_ID = 251 ' || chr(10) ||
'       )) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_PROCESS_251_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_PROCESS_251_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open EXP_PROCESS_251_.cuExpression;
   fetch EXP_PROCESS_251_.cuExpression bulk collect INTO EXP_PROCESS_251_.tbGR_CONFIG_EXPRESSIONId;
   close EXP_PROCESS_251_.cuExpression;
END;
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_251',1);
EXP_PROCESS_251_.blProcessStatus := EXP_PROCESS_170_.blProcessStatus ; 
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
sa_bocreatePackages.CreatePackage('DEL_ROOT_460_',
'CREATE OR REPLACE PACKAGE DEL_ROOT_460_ IS ' || chr(10) ||
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
'        WHERE UNIT_ID = 460 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 460  ' || chr(10) ||
'       ) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_ID = 460 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 460  ' || chr(10) ||
'       ) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END DEL_ROOT_460_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:DEL_ROOT_460_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open DEL_ROOT_460_.cuExpression;
   fetch DEL_ROOT_460_.cuExpression bulk collect INTO DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONId;
   close DEL_ROOT_460_.cuExpression;
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
        WHERE UNIT_ID = 460
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID = 460 
       )
;
BEGIN

if (not DEL_ROOT_460_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  DEL_ROOT_460_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE PROCESS_ID = 460);
BEGIN 

if (not DEL_ROOT_460_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_460_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE PROCESS_ID = 460);
BEGIN 

if (not DEL_ROOT_460_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_460_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 460)));
BEGIN 

if (not DEL_ROOT_460_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_460_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 460)));
BEGIN 

if (not DEL_ROOT_460_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_460_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 460));
BEGIN 

if (not DEL_ROOT_460_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla WF_UNIT',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_460_.tbWF_UNITRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_460_.blProcessStatus := false;
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
FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 460);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_460_.blProcessStatus) then
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
DEL_ROOT_460_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_460_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_460_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_460_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_460_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_460_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria WF_UNIT',1);
nuVarcharIndex:=DEL_ROOT_460_.tbWF_UNITRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from WF_UNIT where rowid = DEL_ROOT_460_.tbWF_UNITRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_460_.tbWF_UNITRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_460_.tbWF_UNITRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_460_.blProcessStatus := false;
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
FROM WF_UNIT_DATA_MAP WHERE (SOURCE_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 460));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_460_.blProcessStatus) then
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
DEL_ROOT_460_.blProcessStatus := false;
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
FROM WF_UNIT_DATA_MAP WHERE (TARGET_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 460));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_460_.blProcessStatus) then
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
DEL_ROOT_460_.blProcessStatus := false;
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
FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 460);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_460_.blProcessStatus) then
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
DEL_ROOT_460_.blProcessStatus := false;
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
FROM WF_UNIT WHERE PROCESS_ID = 460;
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_460_.blProcessStatus) then
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
DEL_ROOT_460_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_460_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_460_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_460_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_460_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/

BEGIN
    ut_trace.trace('Actualizar WF_UNIT a ProcessId NULL ',1);
   UPDATE WF_UNIT 
     SET PROCESS_ID = -1, POS_EXPRESSION_ID = null, PRE_EXPRESSION_ID = null, ACTION_ID = null 
     WHERE PROCESS_ID = 460;
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
    nuBinaryIndex := DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       DEL_ROOT_460_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_251',1);
EXP_PROCESS_251_.blProcessStatus := DEL_ROOT_460_.blProcessStatus ; 
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
 nuIndex := DEL_ROOT_460_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || DEL_ROOT_460_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(DEL_ROOT_460_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(DEL_ROOT_460_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(DEL_ROOT_460_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || DEL_ROOT_460_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || DEL_ROOT_460_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := DEL_ROOT_460_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('DEL_ROOT_460_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:DEL_ROOT_460_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('DEL_ROOT_460_',
'CREATE OR REPLACE PACKAGE DEL_ROOT_460_ IS ' || chr(10) ||
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
'        WHERE UNIT_ID = 460 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 460  ' || chr(10) ||
'       ) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_ID = 460 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 460  ' || chr(10) ||
'       ) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END DEL_ROOT_460_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:DEL_ROOT_460_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open DEL_ROOT_460_.cuExpression;
   fetch DEL_ROOT_460_.cuExpression bulk collect INTO DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONId;
   close DEL_ROOT_460_.cuExpression;
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
        WHERE UNIT_ID = 460
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID = 460 
       )
;
BEGIN

if (not DEL_ROOT_460_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  DEL_ROOT_460_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE UNIT_ID = 460);
BEGIN 

if (not DEL_ROOT_460_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_460_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE UNIT_ID = 460);
BEGIN 

if (not DEL_ROOT_460_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_460_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 460)));
BEGIN 

if (not DEL_ROOT_460_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_460_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 460)));
BEGIN 

if (not DEL_ROOT_460_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_460_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 460));
BEGIN 

if (not DEL_ROOT_460_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla WF_UNIT',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_460_.tbWF_UNITRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_460_.blProcessStatus := false;
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
FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 460);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_460_.blProcessStatus) then
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
DEL_ROOT_460_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_460_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_460_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_460_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_460_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_460_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria WF_UNIT',1);
nuVarcharIndex:=DEL_ROOT_460_.tbWF_UNITRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from WF_UNIT where rowid = DEL_ROOT_460_.tbWF_UNITRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_460_.tbWF_UNITRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_460_.tbWF_UNITRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_460_.blProcessStatus := false;
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
FROM WF_UNIT_DATA_MAP WHERE (SOURCE_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 460));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_460_.blProcessStatus) then
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
DEL_ROOT_460_.blProcessStatus := false;
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
FROM WF_UNIT_DATA_MAP WHERE (TARGET_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 460));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_460_.blProcessStatus) then
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
DEL_ROOT_460_.blProcessStatus := false;
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
FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 460);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_460_.blProcessStatus) then
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
DEL_ROOT_460_.blProcessStatus := false;
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
FROM WF_UNIT WHERE UNIT_ID = 460;
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_460_.blProcessStatus) then
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
DEL_ROOT_460_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_460_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_460_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_460_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_460_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/

BEGIN
    ut_trace.trace('Actualizar WF_UNIT a ProcessId NULL ',1);
   UPDATE WF_UNIT 
     SET PROCESS_ID = -1, POS_EXPRESSION_ID = null, PRE_EXPRESSION_ID = null, ACTION_ID = null 
     WHERE PROCESS_ID = 460;
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
    nuBinaryIndex := DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := DEL_ROOT_460_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       DEL_ROOT_460_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_251',1);
EXP_PROCESS_251_.blProcessStatus := DEL_ROOT_460_.blProcessStatus ; 
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
 nuIndex := DEL_ROOT_460_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || DEL_ROOT_460_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(DEL_ROOT_460_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(DEL_ROOT_460_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(DEL_ROOT_460_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || DEL_ROOT_460_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || DEL_ROOT_460_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := DEL_ROOT_460_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('DEL_ROOT_460_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:DEL_ROOT_460_******************************'); end;
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
EXP_ACTION_222_.blProcessStatus := EXP_PROCESS_251_.blProcessStatus ; 
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

EXP_ACTION_222_.old_tb1_0(0):=121357865;
EXP_ACTION_222_.tb1_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
EXP_ACTION_222_.tb1_0(0):=EXP_ACTION_222_.tb1_0(0);
EXP_ACTION_222_.old_tb1_1(0):='GE_EXEACTION_CT1E121357865'
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
to_date('29-03-2020 00:01:05','DD-MM-YYYY HH24:MI:SS'),
to_date('29-03-2020 00:01:05','DD-MM-YYYY HH24:MI:SS'),
'R'
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
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_251',1);
EXP_PROCESS_251_.blProcessStatus := EXP_ACTION_222_.blProcessStatus ; 
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
        WHERE UNIT_TYPE_ID = 251
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID IN 
           (SELECT UNIT_ID
           FROM WF_UNIT
           WHERE UNIT_TYPE_ID = 251
       ))
;
BEGIN

if (not EXP_PROCESS_251_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_PROCESS_251_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=251) AND NODE_TYPE_ID=0);
BEGIN 

if (not EXP_PROCESS_251_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_PROCESS_251_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_PROCESS_251_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=251) AND NODE_TYPE_ID=0);
BEGIN 

if (not EXP_PROCESS_251_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_PROCESS_251_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_PROCESS_251_.blProcessStatus := false;
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
FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=251) AND NODE_TYPE_ID=0;
nuIndex binary_integer;
BEGIN

if (not EXP_PROCESS_251_.blProcessStatus) then
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
EXP_PROCESS_251_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_PROCESS_251_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_PROCESS_251_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_PROCESS_251_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_PROCESS_251_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_PROCESS_251_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_PROCESS_251_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_PROCESS_251_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_PROCESS_251_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_PROCESS_251_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_PROCESS_251_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_PROCESS_251_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_PROCESS_251_.blProcessStatus := false;
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
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=251;
nuIndex binary_integer;
BEGIN

if (not EXP_PROCESS_251_.blProcessStatus) then
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
EXP_PROCESS_251_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_PROCESS_251_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_251_.tb0_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_CATEGORY fila (0)',1);
UPDATE WF_UNIT_CATEGORY SET CATEGORY_ID=EXP_PROCESS_251_.tb0_0(0),
DISPLAY_NUMBER='Proceso B¿sico'

 WHERE CATEGORY_ID = EXP_PROCESS_251_.tb0_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_CATEGORY(CATEGORY_ID,DISPLAY_NUMBER) 
VALUES (EXP_PROCESS_251_.tb0_0(0),
'Proceso B¿sico'
);
end if;

exception when others then
EXP_PROCESS_251_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_251_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_251_.tb1_0(0):=9;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (0)',1);
UPDATE GE_MODULE SET MODULE_ID=EXP_PROCESS_251_.tb1_0(0),
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

 WHERE MODULE_ID = EXP_PROCESS_251_.tb1_0(0);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (EXP_PROCESS_251_.tb1_0(0),
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
EXP_PROCESS_251_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_251_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_251_.tb2_0(0):=251;
EXP_PROCESS_251_.tb2_1(0):=EXP_PROCESS_251_.tb0_0(0);
EXP_PROCESS_251_.tb2_2(0):=EXP_PROCESS_251_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (0)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_251_.tb2_0(0),
CATEGORY_ID=EXP_PROCESS_251_.tb2_1(0),
MODULE_ID=EXP_PROCESS_251_.tb2_2(0),
ACTION_ID=null,
PARENT_ID=983,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_251'
,
DESCRIPTION='Facturación/ Financiación'
,
DISPLAY='Facturación/ Financiación'
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_251_.tb2_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_251_.tb2_0(0),
EXP_PROCESS_251_.tb2_1(0),
EXP_PROCESS_251_.tb2_2(0),
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_251'
,
'Facturación/ Financiación'
,
'Facturación/ Financiación'
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
EXP_PROCESS_251_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_251_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_251_.tb3_0(0):=0;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (0)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_251_.tb3_0(0),
DESCRIPTION='Ra¿z'

 WHERE NODE_TYPE_ID = EXP_PROCESS_251_.tb3_0(0);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_251_.tb3_0(0),
'Ra¿z'
);
end if;

exception when others then
EXP_PROCESS_251_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_251_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_251_.tb4_0(0):=460;
EXP_PROCESS_251_.tb4_2(0):=EXP_PROCESS_251_.tb2_0(0);
EXP_PROCESS_251_.tb4_3(0):=EXP_PROCESS_251_.tb3_0(0);
EXP_PROCESS_251_.tb4_4(0):=EXP_PROCESS_251_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (0)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_251_.tb4_0(0),
PROCESS_ID=null,
UNIT_TYPE_ID=EXP_PROCESS_251_.tb4_2(0),
NODE_TYPE_ID=EXP_PROCESS_251_.tb4_3(0),
MODULE_ID=EXP_PROCESS_251_.tb4_4(0),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='20
20'
,
DESCRIPTION='Facturación/ Financiación'
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

 WHERE UNIT_ID = EXP_PROCESS_251_.tb4_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_251_.tb4_0(0),
null,
EXP_PROCESS_251_.tb4_2(0),
EXP_PROCESS_251_.tb4_3(0),
EXP_PROCESS_251_.tb4_4(0),
null,
null,
null,
null,
'20
20'
,
'Facturación/ Financiación'
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
EXP_PROCESS_251_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_251_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_251_.tb0_0(1):=2;
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_CATEGORY fila (1)',1);
UPDATE WF_UNIT_CATEGORY SET CATEGORY_ID=EXP_PROCESS_251_.tb0_0(1),
DISPLAY_NUMBER='Actividad'

 WHERE CATEGORY_ID = EXP_PROCESS_251_.tb0_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_CATEGORY(CATEGORY_ID,DISPLAY_NUMBER) 
VALUES (EXP_PROCESS_251_.tb0_0(1),
'Actividad'
);
end if;

exception when others then
EXP_PROCESS_251_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_251_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_251_.tb1_0(1):=5;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (1)',1);
UPDATE GE_MODULE SET MODULE_ID=EXP_PROCESS_251_.tb1_0(1),
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

 WHERE MODULE_ID = EXP_PROCESS_251_.tb1_0(1);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (EXP_PROCESS_251_.tb1_0(1),
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
EXP_PROCESS_251_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_251_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_251_.tb2_0(1):=254;
EXP_PROCESS_251_.tb2_1(1):=EXP_PROCESS_251_.tb0_0(1);
EXP_PROCESS_251_.tb2_2(1):=EXP_PROCESS_251_.tb1_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (1)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_251_.tb2_0(1),
CATEGORY_ID=EXP_PROCESS_251_.tb2_1(1),
MODULE_ID=EXP_PROCESS_251_.tb2_2(1),
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_251_.tb2_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_251_.tb2_0(1),
EXP_PROCESS_251_.tb2_1(1),
EXP_PROCESS_251_.tb2_2(1),
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
EXP_PROCESS_251_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_251_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_251_.tb3_0(1):=2;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (1)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_251_.tb3_0(1),
DESCRIPTION='Normal'

 WHERE NODE_TYPE_ID = EXP_PROCESS_251_.tb3_0(1);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_251_.tb3_0(1),
'Normal'
);
end if;

exception when others then
EXP_PROCESS_251_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_251_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_251_.tb4_0(1):=1051;
EXP_PROCESS_251_.tb4_1(1):=EXP_PROCESS_251_.tb4_0(0);
EXP_PROCESS_251_.tb4_2(1):=EXP_PROCESS_251_.tb2_0(1);
EXP_PROCESS_251_.tb4_3(1):=EXP_PROCESS_251_.tb3_0(1);
EXP_PROCESS_251_.tb4_4(1):=EXP_PROCESS_251_.tb1_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (1)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_251_.tb4_0(1),
PROCESS_ID=EXP_PROCESS_251_.tb4_1(1),
UNIT_TYPE_ID=EXP_PROCESS_251_.tb4_2(1),
NODE_TYPE_ID=EXP_PROCESS_251_.tb4_3(1),
MODULE_ID=EXP_PROCESS_251_.tb4_4(1),
ACTION_ID=222,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=9000,
GEOMETRY='205
172'
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
ENTITY_ID=null,
VIEWABLE='N'

 WHERE UNIT_ID = EXP_PROCESS_251_.tb4_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_251_.tb4_0(1),
EXP_PROCESS_251_.tb4_1(1),
EXP_PROCESS_251_.tb4_2(1),
EXP_PROCESS_251_.tb4_3(1),
EXP_PROCESS_251_.tb4_4(1),
222,
null,
null,
9000,
'205
172'
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
null,
'N'
);
end if;

exception when others then
EXP_PROCESS_251_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_251_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_251_.tb2_0(2):=252;
EXP_PROCESS_251_.tb2_1(2):=EXP_PROCESS_251_.tb0_0(1);
EXP_PROCESS_251_.tb2_2(2):=EXP_PROCESS_251_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (2)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_251_.tb2_0(2),
CATEGORY_ID=EXP_PROCESS_251_.tb2_1(2),
MODULE_ID=EXP_PROCESS_251_.tb2_2(2),
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_251_.tb2_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_251_.tb2_0(2),
EXP_PROCESS_251_.tb2_1(2),
EXP_PROCESS_251_.tb2_2(2),
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
EXP_PROCESS_251_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_251_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_251_.tb3_0(2):=3;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (2)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_251_.tb3_0(2),
DESCRIPTION='Final'

 WHERE NODE_TYPE_ID = EXP_PROCESS_251_.tb3_0(2);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_251_.tb3_0(2),
'Final'
);
end if;

exception when others then
EXP_PROCESS_251_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_251_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_251_.tb4_0(2):=462;
EXP_PROCESS_251_.tb4_1(2):=EXP_PROCESS_251_.tb4_0(0);
EXP_PROCESS_251_.tb4_2(2):=EXP_PROCESS_251_.tb2_0(2);
EXP_PROCESS_251_.tb4_3(2):=EXP_PROCESS_251_.tb3_0(2);
EXP_PROCESS_251_.tb4_4(2):=EXP_PROCESS_251_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (2)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_251_.tb4_0(2),
PROCESS_ID=EXP_PROCESS_251_.tb4_1(2),
UNIT_TYPE_ID=EXP_PROCESS_251_.tb4_2(2),
NODE_TYPE_ID=EXP_PROCESS_251_.tb4_3(2),
MODULE_ID=EXP_PROCESS_251_.tb4_4(2),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='431
179'
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

 WHERE UNIT_ID = EXP_PROCESS_251_.tb4_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_251_.tb4_0(2),
EXP_PROCESS_251_.tb4_1(2),
EXP_PROCESS_251_.tb4_2(2),
EXP_PROCESS_251_.tb4_3(2),
EXP_PROCESS_251_.tb4_4(2),
null,
null,
null,
null,
'431
179'
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
EXP_PROCESS_251_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_251_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_251_.tb5_0(0):=124259;
EXP_PROCESS_251_.tb5_1(0):=EXP_PROCESS_251_.tb4_0(1);
EXP_PROCESS_251_.tb5_2(0):=EXP_PROCESS_251_.tb4_0(2);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (0)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_251_.tb5_0(0),
ORIGIN_ID=EXP_PROCESS_251_.tb5_1(0),
TARGET_ID=EXP_PROCESS_251_.tb5_2(0),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION=null,
EXPRESSION_TYPE=0,
DESCRIPTION=null,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_251_.tb5_0(0);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_251_.tb5_0(0),
EXP_PROCESS_251_.tb5_1(0),
EXP_PROCESS_251_.tb5_2(0),
null,
0,
null,
0,
null,
1);
end if;

exception when others then
EXP_PROCESS_251_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_251_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_251_.tb2_0(3):=283;
EXP_PROCESS_251_.tb2_1(3):=EXP_PROCESS_251_.tb0_0(1);
EXP_PROCESS_251_.tb2_2(3):=EXP_PROCESS_251_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (3)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_251_.tb2_0(3),
CATEGORY_ID=EXP_PROCESS_251_.tb2_1(3),
MODULE_ID=EXP_PROCESS_251_.tb2_2(3),
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_251_.tb2_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_251_.tb2_0(3),
EXP_PROCESS_251_.tb2_1(3),
EXP_PROCESS_251_.tb2_2(3),
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
EXP_PROCESS_251_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_251_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_251_.tb3_0(3):=1;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (3)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_251_.tb3_0(3),
DESCRIPTION='Arranque'

 WHERE NODE_TYPE_ID = EXP_PROCESS_251_.tb3_0(3);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_251_.tb3_0(3),
'Arranque'
);
end if;

exception when others then
EXP_PROCESS_251_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_251_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_251_.tb4_0(3):=461;
EXP_PROCESS_251_.tb4_1(3):=EXP_PROCESS_251_.tb4_0(0);
EXP_PROCESS_251_.tb4_2(3):=EXP_PROCESS_251_.tb2_0(3);
EXP_PROCESS_251_.tb4_3(3):=EXP_PROCESS_251_.tb3_0(3);
EXP_PROCESS_251_.tb4_4(3):=EXP_PROCESS_251_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (3)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_251_.tb4_0(3),
PROCESS_ID=EXP_PROCESS_251_.tb4_1(3),
UNIT_TYPE_ID=EXP_PROCESS_251_.tb4_2(3),
NODE_TYPE_ID=EXP_PROCESS_251_.tb4_3(3),
MODULE_ID=EXP_PROCESS_251_.tb4_4(3),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='20
179'
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

 WHERE UNIT_ID = EXP_PROCESS_251_.tb4_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_251_.tb4_0(3),
EXP_PROCESS_251_.tb4_1(3),
EXP_PROCESS_251_.tb4_2(3),
EXP_PROCESS_251_.tb4_3(3),
EXP_PROCESS_251_.tb4_4(3),
null,
null,
null,
null,
'20
179'
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
EXP_PROCESS_251_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_251_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_251_.tb5_0(1):=100000064;
EXP_PROCESS_251_.tb5_1(1):=EXP_PROCESS_251_.tb4_0(3);
EXP_PROCESS_251_.tb5_2(1):=EXP_PROCESS_251_.tb4_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (1)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_251_.tb5_0(1),
ORIGIN_ID=EXP_PROCESS_251_.tb5_1(1),
TARGET_ID=EXP_PROCESS_251_.tb5_2(1),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION=null,
EXPRESSION_TYPE=0,
DESCRIPTION=null,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_251_.tb5_0(1);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_251_.tb5_0(1),
EXP_PROCESS_251_.tb5_1(1),
EXP_PROCESS_251_.tb5_2(1),
null,
0,
null,
0,
null,
1);
end if;

exception when others then
EXP_PROCESS_251_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_251_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_251_.tb6_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTE_CLASS fila (0)',1);
UPDATE GE_ATTRIBUTE_CLASS SET ATTRIBUTE_CLASS_ID=EXP_PROCESS_251_.tb6_0(0),
NAME='De Entitdad'
,
DESCRIPTION='Valores que ser¿n tra¿dos de la tabla base usando old record'

 WHERE ATTRIBUTE_CLASS_ID = EXP_PROCESS_251_.tb6_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTE_CLASS(ATTRIBUTE_CLASS_ID,NAME,DESCRIPTION) 
VALUES (EXP_PROCESS_251_.tb6_0(0),
'De Entitdad'
,
'Valores que ser¿n tra¿dos de la tabla base usando old record'
);
end if;

exception when others then
EXP_PROCESS_251_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_251_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_251_.tb7_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES_TYPE fila (0)',1);
UPDATE GE_ATTRIBUTES_TYPE SET ATTRIBUTE_TYPE_ID=EXP_PROCESS_251_.tb7_0(0),
DESCRIPTION='NUMBER'
,
INTERNAL_TYPE=2,
INTERNAL_JAVA_TYPE=2
 WHERE ATTRIBUTE_TYPE_ID = EXP_PROCESS_251_.tb7_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES_TYPE(ATTRIBUTE_TYPE_ID,DESCRIPTION,INTERNAL_TYPE,INTERNAL_JAVA_TYPE) 
VALUES (EXP_PROCESS_251_.tb7_0(0),
'NUMBER'
,
2,
2);
end if;

exception when others then
EXP_PROCESS_251_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_251_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_251_.tb8_0(0):=400;
EXP_PROCESS_251_.tb8_1(0):=EXP_PROCESS_251_.tb6_0(0);
EXP_PROCESS_251_.tb8_2(0):=EXP_PROCESS_251_.tb7_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (0)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=EXP_PROCESS_251_.tb8_0(0),
ATTRIBUTE_CLASS_ID=EXP_PROCESS_251_.tb8_1(0),
ATTRIBUTE_TYPE_ID=EXP_PROCESS_251_.tb8_2(0),
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

 WHERE ATTRIBUTE_ID = EXP_PROCESS_251_.tb8_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,ATTRIBUTE_CLASS_ID,ATTRIBUTE_TYPE_ID,VALID_EXPRESSION,FATHER_ID,MODULE_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (EXP_PROCESS_251_.tb8_0(0),
EXP_PROCESS_251_.tb8_1(0),
EXP_PROCESS_251_.tb8_2(0),
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
EXP_PROCESS_251_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_251_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_251_.tb9_0(0):=134088;
EXP_PROCESS_251_.tb9_1(0):=EXP_PROCESS_251_.tb4_0(1);
EXP_PROCESS_251_.tb9_2(0):=EXP_PROCESS_251_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (0)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_251_.tb9_0(0),
UNIT_ID=EXP_PROCESS_251_.tb9_1(0),
ATTRIBUTE_ID=EXP_PROCESS_251_.tb9_2(0),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_251_.tb9_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_251_.tb9_0(0),
EXP_PROCESS_251_.tb9_1(0),
EXP_PROCESS_251_.tb9_2(0),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_251_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_251_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_251_.tb9_0(1):=133495;
EXP_PROCESS_251_.tb9_1(1):=EXP_PROCESS_251_.tb4_0(2);
EXP_PROCESS_251_.tb9_2(1):=EXP_PROCESS_251_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (1)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_251_.tb9_0(1),
UNIT_ID=EXP_PROCESS_251_.tb9_1(1),
ATTRIBUTE_ID=EXP_PROCESS_251_.tb9_2(1),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_251_.tb9_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_251_.tb9_0(1),
EXP_PROCESS_251_.tb9_1(1),
EXP_PROCESS_251_.tb9_2(1),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_251_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_251_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_251_.tb9_0(2):=133496;
EXP_PROCESS_251_.tb9_1(2):=EXP_PROCESS_251_.tb4_0(2);
EXP_PROCESS_251_.tb9_2(2):=EXP_PROCESS_251_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (2)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_251_.tb9_0(2),
UNIT_ID=EXP_PROCESS_251_.tb9_1(2),
ATTRIBUTE_ID=EXP_PROCESS_251_.tb9_2(2),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_251_.tb9_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_251_.tb9_0(2),
EXP_PROCESS_251_.tb9_1(2),
EXP_PROCESS_251_.tb9_2(2),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_251_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_251_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_251_.tb9_0(3):=133494;
EXP_PROCESS_251_.tb9_1(3):=EXP_PROCESS_251_.tb4_0(3);
EXP_PROCESS_251_.tb9_2(3):=EXP_PROCESS_251_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (3)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_251_.tb9_0(3),
UNIT_ID=EXP_PROCESS_251_.tb9_1(3),
ATTRIBUTE_ID=EXP_PROCESS_251_.tb9_2(3),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_251_.tb9_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_251_.tb9_0(3),
EXP_PROCESS_251_.tb9_1(3),
EXP_PROCESS_251_.tb9_2(3),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_251_.blProcessStatus := false;
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
EXP_UNITTYPE_254_.blProcessStatus := EXP_PROCESS_251_.blProcessStatus ; 
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
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_251',1);
EXP_PROCESS_251_.blProcessStatus := EXP_UNITTYPE_254_.blProcessStatus ; 
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
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_170',1);
EXP_PROCESS_170_.blProcessStatus := EXP_PROCESS_251_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
DECLARE 
    nuBinaryIndex Binary_Integer;
BEGIN 
    nuBinaryIndex := EXP_PROCESS_251_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = EXP_PROCESS_251_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||EXP_PROCESS_251_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||EXP_PROCESS_251_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := EXP_PROCESS_251_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       EXP_PROCESS_251_.blProcessStatus := FALSE;
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
 nuIndex := EXP_PROCESS_251_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_PROCESS_251_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_PROCESS_251_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_PROCESS_251_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_PROCESS_251_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_PROCESS_251_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_PROCESS_251_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_PROCESS_251_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_PROCESS_251_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_PROCESS_251_******************************'); end;
/

BEGIN
ut_trace.trace('Realizar Commit del Flujo',1);
if ( not EXP_PROCESS_170_.blProcessStatus) then
 return;
 end if;
ut_trace.trace('Realizar Commit de EXP_PROCESS_170 ',1);
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
    nuBinaryIndex := EXP_PROCESS_170_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = EXP_PROCESS_170_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||EXP_PROCESS_170_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||EXP_PROCESS_170_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := EXP_PROCESS_170_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       EXP_PROCESS_170_.blProcessStatus := FALSE;
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
 nuIndex := EXP_PROCESS_170_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_PROCESS_170_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_PROCESS_170_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_PROCESS_170_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_PROCESS_170_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_PROCESS_170_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_PROCESS_170_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_PROCESS_170_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_PROCESS_170_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_PROCESS_170_******************************'); end;
/



