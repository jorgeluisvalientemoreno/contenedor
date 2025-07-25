BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_PROCESS_100704_',
'CREATE OR REPLACE PACKAGE EXP_PROCESS_100704_ IS ' || chr(10) ||
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
'tb10_3 ty10_3; ' || chr(10) ||
'CURSOR cuExpression is ' || chr(10) ||
'SELECT PRE_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_TYPE_ID = 100704 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID IN  ' || chr(10) ||
'           (SELECT UNIT_ID ' || chr(10) ||
'           FROM WF_UNIT ' || chr(10) ||
'           WHERE UNIT_TYPE_ID = 100704 ' || chr(10) ||
'       )) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_TYPE_ID = 100704 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID IN  ' || chr(10) ||
'           (SELECT UNIT_ID ' || chr(10) ||
'           FROM WF_UNIT ' || chr(10) ||
'           WHERE UNIT_TYPE_ID = 100704 ' || chr(10) ||
'       )) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_PROCESS_100704_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_PROCESS_100704_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open EXP_PROCESS_100704_.cuExpression;
   fetch EXP_PROCESS_100704_.cuExpression bulk collect INTO EXP_PROCESS_100704_.tbGR_CONFIG_EXPRESSIONId;
   close EXP_PROCESS_100704_.cuExpression;
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
sa_bocreatePackages.CreatePackage('DEL_ROOT_103104_',
'CREATE OR REPLACE PACKAGE DEL_ROOT_103104_ IS ' || chr(10) ||
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
'        WHERE UNIT_ID = 103104 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 103104  ' || chr(10) ||
'       ) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_ID = 103104 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 103104  ' || chr(10) ||
'       ) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END DEL_ROOT_103104_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:DEL_ROOT_103104_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open DEL_ROOT_103104_.cuExpression;
   fetch DEL_ROOT_103104_.cuExpression bulk collect INTO DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONId;
   close DEL_ROOT_103104_.cuExpression;
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
        WHERE UNIT_ID = 103104
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID = 103104 
       )
;
BEGIN

if (not DEL_ROOT_103104_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  DEL_ROOT_103104_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE PROCESS_ID = 103104);
BEGIN 

if (not DEL_ROOT_103104_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_103104_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE PROCESS_ID = 103104);
BEGIN 

if (not DEL_ROOT_103104_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_103104_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 103104)));
BEGIN 

if (not DEL_ROOT_103104_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_103104_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 103104)));
BEGIN 

if (not DEL_ROOT_103104_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_103104_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 103104));
BEGIN 

if (not DEL_ROOT_103104_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla WF_UNIT',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_103104_.tbWF_UNITRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_103104_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 103104);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_103104_.blProcessStatus) then
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
DEL_ROOT_103104_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_103104_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_103104_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_103104_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_103104_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_103104_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria WF_UNIT',1);
nuVarcharIndex:=DEL_ROOT_103104_.tbWF_UNITRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from WF_UNIT where rowid = DEL_ROOT_103104_.tbWF_UNITRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_103104_.tbWF_UNITRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_103104_.tbWF_UNITRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_103104_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_DATA_MAP WHERE (SOURCE_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 103104));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_103104_.blProcessStatus) then
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
DEL_ROOT_103104_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_DATA_MAP WHERE (TARGET_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 103104));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_103104_.blProcessStatus) then
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
DEL_ROOT_103104_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 103104);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_103104_.blProcessStatus) then
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
DEL_ROOT_103104_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT WHERE PROCESS_ID = 103104;
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_103104_.blProcessStatus) then
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
DEL_ROOT_103104_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_103104_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_103104_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_103104_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_103104_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/

BEGIN
    ut_trace.trace('Actualizar WF_UNIT a ProcessId NULL ',1);
   UPDATE WF_UNIT 
     SET PROCESS_ID = -1, POS_EXPRESSION_ID = null, PRE_EXPRESSION_ID = null, ACTION_ID = null 
     WHERE PROCESS_ID = 103104;
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
    nuBinaryIndex := DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       DEL_ROOT_103104_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100704',1);
EXP_PROCESS_100704_.blProcessStatus := DEL_ROOT_103104_.blProcessStatus ; 
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
 nuIndex := DEL_ROOT_103104_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || DEL_ROOT_103104_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(DEL_ROOT_103104_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(DEL_ROOT_103104_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(DEL_ROOT_103104_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || DEL_ROOT_103104_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || DEL_ROOT_103104_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := DEL_ROOT_103104_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('DEL_ROOT_103104_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:DEL_ROOT_103104_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('DEL_ROOT_103104_',
'CREATE OR REPLACE PACKAGE DEL_ROOT_103104_ IS ' || chr(10) ||
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
'        WHERE UNIT_ID = 103104 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 103104  ' || chr(10) ||
'       ) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_ID = 103104 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 103104  ' || chr(10) ||
'       ) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END DEL_ROOT_103104_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:DEL_ROOT_103104_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open DEL_ROOT_103104_.cuExpression;
   fetch DEL_ROOT_103104_.cuExpression bulk collect INTO DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONId;
   close DEL_ROOT_103104_.cuExpression;
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
        WHERE UNIT_ID = 103104
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID = 103104 
       )
;
BEGIN

if (not DEL_ROOT_103104_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  DEL_ROOT_103104_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE UNIT_ID = 103104);
BEGIN 

if (not DEL_ROOT_103104_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_103104_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE UNIT_ID = 103104);
BEGIN 

if (not DEL_ROOT_103104_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_103104_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 103104)));
BEGIN 

if (not DEL_ROOT_103104_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_103104_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 103104)));
BEGIN 

if (not DEL_ROOT_103104_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_103104_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 103104));
BEGIN 

if (not DEL_ROOT_103104_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla WF_UNIT',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_103104_.tbWF_UNITRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_103104_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 103104);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_103104_.blProcessStatus) then
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
DEL_ROOT_103104_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_103104_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_103104_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_103104_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_103104_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_103104_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria WF_UNIT',1);
nuVarcharIndex:=DEL_ROOT_103104_.tbWF_UNITRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from WF_UNIT where rowid = DEL_ROOT_103104_.tbWF_UNITRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_103104_.tbWF_UNITRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_103104_.tbWF_UNITRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_103104_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_DATA_MAP WHERE (SOURCE_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 103104));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_103104_.blProcessStatus) then
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
DEL_ROOT_103104_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_DATA_MAP WHERE (TARGET_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 103104));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_103104_.blProcessStatus) then
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
DEL_ROOT_103104_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 103104);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_103104_.blProcessStatus) then
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
DEL_ROOT_103104_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT WHERE UNIT_ID = 103104;
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_103104_.blProcessStatus) then
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
DEL_ROOT_103104_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_103104_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_103104_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_103104_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_103104_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/

BEGIN
    ut_trace.trace('Actualizar WF_UNIT a ProcessId NULL ',1);
   UPDATE WF_UNIT 
     SET PROCESS_ID = -1, POS_EXPRESSION_ID = null, PRE_EXPRESSION_ID = null, ACTION_ID = null 
     WHERE PROCESS_ID = 103104;
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
    nuBinaryIndex := DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := DEL_ROOT_103104_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       DEL_ROOT_103104_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100704',1);
EXP_PROCESS_100704_.blProcessStatus := DEL_ROOT_103104_.blProcessStatus ; 
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
 nuIndex := DEL_ROOT_103104_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || DEL_ROOT_103104_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(DEL_ROOT_103104_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(DEL_ROOT_103104_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(DEL_ROOT_103104_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || DEL_ROOT_103104_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || DEL_ROOT_103104_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := DEL_ROOT_103104_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('DEL_ROOT_103104_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:DEL_ROOT_103104_******************************'); end;
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
EXP_ACTION_100_.blProcessStatus := EXP_PROCESS_100704_.blProcessStatus ; 
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
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100704',1);
EXP_PROCESS_100704_.blProcessStatus := EXP_ACTION_100_.blProcessStatus ; 
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
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_ACTION_8298_',
'CREATE OR REPLACE PACKAGE EXP_ACTION_8298_ IS ' || chr(10) ||
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
'WHERE  ACTION_ID =8298; ' || chr(10) ||
'type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_ACTION_8298_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_ACTION_8298_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open EXP_ACTION_8298_.cuExpression;
   fetch EXP_ACTION_8298_.cuExpression bulk collect INTO EXP_ACTION_8298_.tbGR_CONFIG_EXPRESSIONId;
   close EXP_ACTION_8298_.cuExpression;
END;
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_ACTION_8298',1);
EXP_ACTION_8298_.blProcessStatus := EXP_PROCESS_100704_.blProcessStatus ; 
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
AND     A.ACTION_ID =8298
;
BEGIN

if (not EXP_ACTION_8298_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_ACTION_8298_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE ACTION_ID=8298);
BEGIN 

if (not EXP_ACTION_8298_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_ACTION_8298_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_ACTION_8298_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM GE_ACTION_MODULE WHERE ACTION_ID=8298;
nuIndex binary_integer;
BEGIN

if (not EXP_ACTION_8298_.blProcessStatus) then
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
EXP_ACTION_8298_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_ACTION_8298_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_ACTION_8298_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_ACTION_8298_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_ACTION_8298_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_ACTION_8298_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_ACTION_8298_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_ACTION_8298_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8298_.tb0_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=EXP_ACTION_8298_.tb0_0(0),
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

 WHERE CONFIGURA_TYPE_ID = EXP_ACTION_8298_.tb0_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (EXP_ACTION_8298_.tb0_0(0),
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
EXP_ACTION_8298_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_8298_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8298_.old_tb1_0(0):=121368528;
EXP_ACTION_8298_.tb1_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
EXP_ACTION_8298_.tb1_0(0):=EXP_ACTION_8298_.tb1_0(0);
EXP_ACTION_8298_.old_tb1_1(0):='GE_EXEACTION_CT1E121368528'
;
EXP_ACTION_8298_.tb1_1(0):=TO_CHAR(EXP_ACTION_8298_.tb1_0(0));
EXP_ACTION_8298_.tb1_2(0):=EXP_ACTION_8298_.tb0_0(0);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (EXP_ACTION_8298_.tb1_0(0),
EXP_ACTION_8298_.tb1_1(0),
EXP_ACTION_8298_.tb1_2(0),
'nusolicitud = MO_BOINSTANCE_DB.FNUGETPACKIDINSTANCE();numotivo = CF_BOSTATEMENTSWF.FNUGETINITMOTIVE(nusolicitud);nuclasecausal = LDCFNCOBTIENECLASECAUSAL(nusolicitud);if (nuclasecausal >= 1,MO_BOSUSPENSION.RECONVOLPRATTENTION(numotivo);LDCPROCCREAREGISTROMOSUSPEN(numotivo,"A");,MO_BOMOTIVEACTIONUTIL.EXECTRANSTATUSFORREQU(nusolicitud,60);)'
,
'OPEN'
,
to_date('19-01-2021 08:56:08','DD-MM-YYYY HH24:MI:SS'),
to_date('21-01-2021 10:35:44','DD-MM-YYYY HH24:MI:SS'),
to_date('21-01-2021 10:35:44','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'atender solicitud'
,
'PP'
,
null);

exception when others then
EXP_ACTION_8298_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_8298_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8298_.tb2_0(0):=8298;
EXP_ACTION_8298_.tb2_2(0):=EXP_ACTION_8298_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ACTION_MODULE fila (0)',1);
UPDATE GE_ACTION_MODULE SET ACTION_ID=EXP_ACTION_8298_.tb2_0(0),
MODULE_ID=5,
CONFIG_EXPRESSION_ID=EXP_ACTION_8298_.tb2_2(0),
DESCRIPTION='Atender Solicitud de reconexion por seguridad'
,
EXE_AT_STATUS_CHANGE='N'
,
EXE_TRANSITION_STATE='N'

 WHERE ACTION_ID = EXP_ACTION_8298_.tb2_0(0);
if not (sql%found) then
INSERT INTO GE_ACTION_MODULE(ACTION_ID,MODULE_ID,CONFIG_EXPRESSION_ID,DESCRIPTION,EXE_AT_STATUS_CHANGE,EXE_TRANSITION_STATE) 
VALUES (EXP_ACTION_8298_.tb2_0(0),
5,
EXP_ACTION_8298_.tb2_2(0),
'Atender Solicitud de reconexion por seguridad'
,
'N'
,
'N'
);
end if;

exception when others then
EXP_ACTION_8298_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_8298_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8298_.tb3_0(0):=EXP_ACTION_8298_.tb2_0(0);
EXP_ACTION_8298_.tb3_1(0):=9;
ut_trace.trace('insertando tabla sin fallo: GE_VALID_ACTION_MODU fila (0)',1);
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (EXP_ACTION_8298_.tb3_0(0),
EXP_ACTION_8298_.tb3_1(0));

exception 
when dup_val_on_index then 
 return;
when others then
EXP_ACTION_8298_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_8298_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8298_.tb3_0(1):=EXP_ACTION_8298_.tb2_0(0);
EXP_ACTION_8298_.tb3_1(1):=16;
ut_trace.trace('insertando tabla sin fallo: GE_VALID_ACTION_MODU fila (1)',1);
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (EXP_ACTION_8298_.tb3_0(1),
EXP_ACTION_8298_.tb3_1(1));

exception 
when dup_val_on_index then 
 return;
when others then
EXP_ACTION_8298_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
DECLARE 
    nuBinaryIndex Binary_Integer;
BEGIN 
    nuBinaryIndex := EXP_ACTION_8298_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = EXP_ACTION_8298_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||EXP_ACTION_8298_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||EXP_ACTION_8298_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := EXP_ACTION_8298_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       EXP_ACTION_8298_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100704',1);
EXP_PROCESS_100704_.blProcessStatus := EXP_ACTION_8298_.blProcessStatus ; 
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

if (not EXP_ACTION_8298_.blProcessStatus) then
 return;
end if;
nuRowProcess:=EXP_ACTION_8298_.tb1_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| EXP_ACTION_8298_.tb1_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(EXP_ACTION_8298_.tb1_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| EXP_ACTION_8298_.tb1_0(nuRowProcess),1);
end;
nuRowProcess := EXP_ACTION_8298_.tb1_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
EXP_ACTION_8298_.blProcessStatus := false;
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
 nuIndex := EXP_ACTION_8298_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_ACTION_8298_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_ACTION_8298_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_ACTION_8298_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_ACTION_8298_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_ACTION_8298_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_ACTION_8298_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_ACTION_8298_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_ACTION_8298_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_ACTION_8298_******************************'); end;
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
        WHERE UNIT_TYPE_ID = 100704
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID IN 
           (SELECT UNIT_ID
           FROM WF_UNIT
           WHERE UNIT_TYPE_ID = 100704
       ))
;
BEGIN

if (not EXP_PROCESS_100704_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_PROCESS_100704_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100704) AND NODE_TYPE_ID=0);
BEGIN 

if (not EXP_PROCESS_100704_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_PROCESS_100704_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_PROCESS_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100704) AND NODE_TYPE_ID=0);
BEGIN 

if (not EXP_PROCESS_100704_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_PROCESS_100704_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_PROCESS_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100704) AND NODE_TYPE_ID=0;
nuIndex binary_integer;
BEGIN

if (not EXP_PROCESS_100704_.blProcessStatus) then
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
EXP_PROCESS_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_PROCESS_100704_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_PROCESS_100704_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_PROCESS_100704_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_PROCESS_100704_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_PROCESS_100704_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_PROCESS_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_PROCESS_100704_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_PROCESS_100704_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_PROCESS_100704_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_PROCESS_100704_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_PROCESS_100704_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_PROCESS_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100704;
nuIndex binary_integer;
BEGIN

if (not EXP_PROCESS_100704_.blProcessStatus) then
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
EXP_PROCESS_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_PROCESS_100704_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100704_.tb0_0(0):=3;
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_CATEGORY fila (0)',1);
UPDATE WF_UNIT_CATEGORY SET CATEGORY_ID=EXP_PROCESS_100704_.tb0_0(0),
DISPLAY_NUMBER='Proceso Principal'

 WHERE CATEGORY_ID = EXP_PROCESS_100704_.tb0_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_CATEGORY(CATEGORY_ID,DISPLAY_NUMBER) 
VALUES (EXP_PROCESS_100704_.tb0_0(0),
'Proceso Principal'
);
end if;

exception when others then
EXP_PROCESS_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100704_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100704_.tb1_0(0):=9;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (0)',1);
UPDATE GE_MODULE SET MODULE_ID=EXP_PROCESS_100704_.tb1_0(0),
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

 WHERE MODULE_ID = EXP_PROCESS_100704_.tb1_0(0);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (EXP_PROCESS_100704_.tb1_0(0),
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
EXP_PROCESS_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100704_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100704_.tb2_0(0):=100704;
EXP_PROCESS_100704_.tb2_1(0):=EXP_PROCESS_100704_.tb0_0(0);
EXP_PROCESS_100704_.tb2_2(0):=EXP_PROCESS_100704_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (0)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100704_.tb2_0(0),
CATEGORY_ID=EXP_PROCESS_100704_.tb2_1(0),
MODULE_ID=EXP_PROCESS_100704_.tb2_2(0),
ACTION_ID=null,
PARENT_ID=983,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_100704'
,
DESCRIPTION='LDC - Reconexion por Seguridad'
,
DISPLAY='LDC - Reconexion por Seguridad'
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100704_.tb2_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100704_.tb2_0(0),
EXP_PROCESS_100704_.tb2_1(0),
EXP_PROCESS_100704_.tb2_2(0),
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_100704'
,
'LDC - Reconexion por Seguridad'
,
'LDC - Reconexion por Seguridad'
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
EXP_PROCESS_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100704_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100704_.tb3_0(0):=100282;
EXP_PROCESS_100704_.tb3_1(0):=EXP_PROCESS_100704_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_ATTRIBUTES_EQUIV fila (0)',1);
UPDATE WF_ATTRIBUTES_EQUIV SET ATTRIBUTES_EQUIV_ID=EXP_PROCESS_100704_.tb3_0(0),
UNIT_TYPE_ID=EXP_PROCESS_100704_.tb3_1(0),
INTERFACE_CONFIG_ID=21,
STD_TIME=0,
MAX_TIME=31536000,
AVG_TIME=0,
DESCRIPTION='Reconexion por Seguridad'
,
VALUE_1='100343'
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
 WHERE ATTRIBUTES_EQUIV_ID = EXP_PROCESS_100704_.tb3_0(0);
if not (sql%found) then
INSERT INTO WF_ATTRIBUTES_EQUIV(ATTRIBUTES_EQUIV_ID,UNIT_TYPE_ID,INTERFACE_CONFIG_ID,STD_TIME,MAX_TIME,AVG_TIME,DESCRIPTION,VALUE_1,VALUE_2,VALUE_3,VALUE_4,VALUE_5,VALUE_6,VALUE_7,VALUE_8,VALUE_9,VALUE_10,VALUE_11,VALUE_12,VALUE_13,VALUE_14,VALUE_15,VALUE_16,VALUE_17,VALUE_18,VALUE_19,VALUE_20) 
VALUES (EXP_PROCESS_100704_.tb3_0(0),
EXP_PROCESS_100704_.tb3_1(0),
21,
0,
31536000,
0,
'Reconexion por Seguridad'
,
'100343'
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
EXP_PROCESS_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100704_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100704_.tb4_0(0):=0;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (0)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100704_.tb4_0(0),
DESCRIPTION='Ra¿z'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100704_.tb4_0(0);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100704_.tb4_0(0),
'Ra¿z'
);
end if;

exception when others then
EXP_PROCESS_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100704_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100704_.tb5_0(0):=103104;
EXP_PROCESS_100704_.tb5_2(0):=EXP_PROCESS_100704_.tb2_0(0);
EXP_PROCESS_100704_.tb5_3(0):=EXP_PROCESS_100704_.tb4_0(0);
EXP_PROCESS_100704_.tb5_4(0):=EXP_PROCESS_100704_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (0)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100704_.tb5_0(0),
PROCESS_ID=null,
UNIT_TYPE_ID=EXP_PROCESS_100704_.tb5_2(0),
NODE_TYPE_ID=EXP_PROCESS_100704_.tb5_3(0),
MODULE_ID=EXP_PROCESS_100704_.tb5_4(0),
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

 WHERE UNIT_ID = EXP_PROCESS_100704_.tb5_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100704_.tb5_0(0),
null,
EXP_PROCESS_100704_.tb5_2(0),
EXP_PROCESS_100704_.tb5_3(0),
EXP_PROCESS_100704_.tb5_4(0),
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
EXP_PROCESS_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100704_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100704_.tb0_0(1):=2;
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_CATEGORY fila (1)',1);
UPDATE WF_UNIT_CATEGORY SET CATEGORY_ID=EXP_PROCESS_100704_.tb0_0(1),
DISPLAY_NUMBER='Actividad'

 WHERE CATEGORY_ID = EXP_PROCESS_100704_.tb0_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_CATEGORY(CATEGORY_ID,DISPLAY_NUMBER) 
VALUES (EXP_PROCESS_100704_.tb0_0(1),
'Actividad'
);
end if;

exception when others then
EXP_PROCESS_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100704_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100704_.tb2_0(1):=283;
EXP_PROCESS_100704_.tb2_1(1):=EXP_PROCESS_100704_.tb0_0(1);
EXP_PROCESS_100704_.tb2_2(1):=EXP_PROCESS_100704_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (1)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100704_.tb2_0(1),
CATEGORY_ID=EXP_PROCESS_100704_.tb2_1(1),
MODULE_ID=EXP_PROCESS_100704_.tb2_2(1),
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100704_.tb2_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100704_.tb2_0(1),
EXP_PROCESS_100704_.tb2_1(1),
EXP_PROCESS_100704_.tb2_2(1),
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
EXP_PROCESS_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100704_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100704_.tb4_0(1):=1;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (1)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100704_.tb4_0(1),
DESCRIPTION='Arranque'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100704_.tb4_0(1);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100704_.tb4_0(1),
'Arranque'
);
end if;

exception when others then
EXP_PROCESS_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100704_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100704_.tb5_0(1):=103105;
EXP_PROCESS_100704_.tb5_1(1):=EXP_PROCESS_100704_.tb5_0(0);
EXP_PROCESS_100704_.tb5_2(1):=EXP_PROCESS_100704_.tb2_0(1);
EXP_PROCESS_100704_.tb5_3(1):=EXP_PROCESS_100704_.tb4_0(1);
EXP_PROCESS_100704_.tb5_4(1):=EXP_PROCESS_100704_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (1)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100704_.tb5_0(1),
PROCESS_ID=EXP_PROCESS_100704_.tb5_1(1),
UNIT_TYPE_ID=EXP_PROCESS_100704_.tb5_2(1),
NODE_TYPE_ID=EXP_PROCESS_100704_.tb5_3(1),
MODULE_ID=EXP_PROCESS_100704_.tb5_4(1),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='16
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

 WHERE UNIT_ID = EXP_PROCESS_100704_.tb5_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100704_.tb5_0(1),
EXP_PROCESS_100704_.tb5_1(1),
EXP_PROCESS_100704_.tb5_2(1),
EXP_PROCESS_100704_.tb5_3(1),
EXP_PROCESS_100704_.tb5_4(1),
null,
null,
null,
null,
'16
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
EXP_PROCESS_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100704_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100704_.tb1_0(1):=4;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (1)',1);
UPDATE GE_MODULE SET MODULE_ID=EXP_PROCESS_100704_.tb1_0(1),
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

 WHERE MODULE_ID = EXP_PROCESS_100704_.tb1_0(1);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (EXP_PROCESS_100704_.tb1_0(1),
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
EXP_PROCESS_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100704_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100704_.tb2_0(2):=100702;
EXP_PROCESS_100704_.tb2_1(2):=EXP_PROCESS_100704_.tb0_0(1);
EXP_PROCESS_100704_.tb2_2(2):=EXP_PROCESS_100704_.tb1_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (2)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100704_.tb2_0(2),
CATEGORY_ID=EXP_PROCESS_100704_.tb2_1(2),
MODULE_ID=EXP_PROCESS_100704_.tb2_2(2),
ACTION_ID=100,
PARENT_ID=983,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_100702'
,
DESCRIPTION='Registro de Orden Reconexion Seguridad'
,
DISPLAY='Registro de Orden Reconexion Seguridad'
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
NOTIFICATION_ID=9011,
VIEWABLE='N'
,
DEFAULT_PRIORITY_ID=null,
INITIAL_NOTIFY_TIME=null,
IS_ADMIN_PROCESS='N'
,
ASSIGN_NOTIFICATION_ID=null,
ASSIGNED_USER_ONLY=null
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100704_.tb2_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100704_.tb2_0(2),
EXP_PROCESS_100704_.tb2_1(2),
EXP_PROCESS_100704_.tb2_2(2),
100,
983,
null,
null,
null,
null,
'UNIT_TYPE_100702'
,
'Registro de Orden Reconexion Seguridad'
,
'Registro de Orden Reconexion Seguridad'
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
EXP_PROCESS_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100704_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100704_.tb4_0(2):=2;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (2)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100704_.tb4_0(2),
DESCRIPTION='Normal'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100704_.tb4_0(2);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100704_.tb4_0(2),
'Normal'
);
end if;

exception when others then
EXP_PROCESS_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100704_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100704_.tb5_0(2):=103108;
EXP_PROCESS_100704_.tb5_1(2):=EXP_PROCESS_100704_.tb5_0(0);
EXP_PROCESS_100704_.tb5_2(2):=EXP_PROCESS_100704_.tb2_0(2);
EXP_PROCESS_100704_.tb5_3(2):=EXP_PROCESS_100704_.tb4_0(2);
EXP_PROCESS_100704_.tb5_4(2):=EXP_PROCESS_100704_.tb1_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (2)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100704_.tb5_0(2),
PROCESS_ID=EXP_PROCESS_100704_.tb5_1(2),
UNIT_TYPE_ID=EXP_PROCESS_100704_.tb5_2(2),
NODE_TYPE_ID=EXP_PROCESS_100704_.tb5_3(2),
MODULE_ID=EXP_PROCESS_100704_.tb5_4(2),
ACTION_ID=100,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=9011,
GEOMETRY='230
169'
,
DESCRIPTION='Registro de Orden Reconexion Seguridad'
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

 WHERE UNIT_ID = EXP_PROCESS_100704_.tb5_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100704_.tb5_0(2),
EXP_PROCESS_100704_.tb5_1(2),
EXP_PROCESS_100704_.tb5_2(2),
EXP_PROCESS_100704_.tb5_3(2),
EXP_PROCESS_100704_.tb5_4(2),
100,
null,
null,
9011,
'230
169'
,
'Registro de Orden Reconexion Seguridad'
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
EXP_PROCESS_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100704_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100704_.tb6_0(0):=100000810;
EXP_PROCESS_100704_.tb6_1(0):=EXP_PROCESS_100704_.tb5_0(1);
EXP_PROCESS_100704_.tb6_2(0):=EXP_PROCESS_100704_.tb5_0(2);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (0)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100704_.tb6_0(0),
ORIGIN_ID=EXP_PROCESS_100704_.tb6_1(0),
TARGET_ID=EXP_PROCESS_100704_.tb6_2(0),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION=null,
EXPRESSION_TYPE=0,
DESCRIPTION=null,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100704_.tb6_0(0);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100704_.tb6_0(0),
EXP_PROCESS_100704_.tb6_1(0),
EXP_PROCESS_100704_.tb6_2(0),
null,
0,
null,
0,
null,
1);
end if;

exception when others then
EXP_PROCESS_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100704_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100704_.tb7_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTE_CLASS fila (0)',1);
UPDATE GE_ATTRIBUTE_CLASS SET ATTRIBUTE_CLASS_ID=EXP_PROCESS_100704_.tb7_0(0),
NAME='De Entitdad'
,
DESCRIPTION='Valores que ser¿n tra¿dos de la tabla base usando old record'

 WHERE ATTRIBUTE_CLASS_ID = EXP_PROCESS_100704_.tb7_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTE_CLASS(ATTRIBUTE_CLASS_ID,NAME,DESCRIPTION) 
VALUES (EXP_PROCESS_100704_.tb7_0(0),
'De Entitdad'
,
'Valores que ser¿n tra¿dos de la tabla base usando old record'
);
end if;

exception when others then
EXP_PROCESS_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100704_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100704_.tb8_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES_TYPE fila (0)',1);
UPDATE GE_ATTRIBUTES_TYPE SET ATTRIBUTE_TYPE_ID=EXP_PROCESS_100704_.tb8_0(0),
DESCRIPTION='NUMBER'
,
INTERNAL_TYPE=2,
INTERNAL_JAVA_TYPE=2
 WHERE ATTRIBUTE_TYPE_ID = EXP_PROCESS_100704_.tb8_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES_TYPE(ATTRIBUTE_TYPE_ID,DESCRIPTION,INTERNAL_TYPE,INTERNAL_JAVA_TYPE) 
VALUES (EXP_PROCESS_100704_.tb8_0(0),
'NUMBER'
,
2,
2);
end if;

exception when others then
EXP_PROCESS_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100704_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100704_.tb9_0(0):=400;
EXP_PROCESS_100704_.tb9_1(0):=EXP_PROCESS_100704_.tb7_0(0);
EXP_PROCESS_100704_.tb9_2(0):=EXP_PROCESS_100704_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (0)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=EXP_PROCESS_100704_.tb9_0(0),
ATTRIBUTE_CLASS_ID=EXP_PROCESS_100704_.tb9_1(0),
ATTRIBUTE_TYPE_ID=EXP_PROCESS_100704_.tb9_2(0),
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

 WHERE ATTRIBUTE_ID = EXP_PROCESS_100704_.tb9_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,ATTRIBUTE_CLASS_ID,ATTRIBUTE_TYPE_ID,VALID_EXPRESSION,FATHER_ID,MODULE_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (EXP_PROCESS_100704_.tb9_0(0),
EXP_PROCESS_100704_.tb9_1(0),
EXP_PROCESS_100704_.tb9_2(0),
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
EXP_PROCESS_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100704_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100704_.tb10_0(0):=100001172;
EXP_PROCESS_100704_.tb10_1(0):=EXP_PROCESS_100704_.tb5_0(1);
EXP_PROCESS_100704_.tb10_2(0):=EXP_PROCESS_100704_.tb9_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (0)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100704_.tb10_0(0),
UNIT_ID=EXP_PROCESS_100704_.tb10_1(0),
ATTRIBUTE_ID=EXP_PROCESS_100704_.tb10_2(0),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100704_.tb10_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100704_.tb10_0(0),
EXP_PROCESS_100704_.tb10_1(0),
EXP_PROCESS_100704_.tb10_2(0),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100704_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100704_.tb10_0(1):=100001178;
EXP_PROCESS_100704_.tb10_1(1):=EXP_PROCESS_100704_.tb5_0(1);
EXP_PROCESS_100704_.tb10_2(1):=EXP_PROCESS_100704_.tb9_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (1)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100704_.tb10_0(1),
UNIT_ID=EXP_PROCESS_100704_.tb10_1(1),
ATTRIBUTE_ID=EXP_PROCESS_100704_.tb10_2(1),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100704_.tb10_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100704_.tb10_0(1),
EXP_PROCESS_100704_.tb10_1(1),
EXP_PROCESS_100704_.tb10_2(1),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100704_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100704_.tb7_0(1):=9;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTE_CLASS fila (1)',1);
UPDATE GE_ATTRIBUTE_CLASS SET ATTRIBUTE_CLASS_ID=EXP_PROCESS_100704_.tb7_0(1),
NAME='Legalizacion Ordenes'
,
DESCRIPTION='Valores necesarios en la legalizacion de Ordenes de Trabajo'

 WHERE ATTRIBUTE_CLASS_ID = EXP_PROCESS_100704_.tb7_0(1);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTE_CLASS(ATTRIBUTE_CLASS_ID,NAME,DESCRIPTION) 
VALUES (EXP_PROCESS_100704_.tb7_0(1),
'Legalizacion Ordenes'
,
'Valores necesarios en la legalizacion de Ordenes de Trabajo'
);
end if;

exception when others then
EXP_PROCESS_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100704_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100704_.tb8_0(1):=2;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES_TYPE fila (1)',1);
UPDATE GE_ATTRIBUTES_TYPE SET ATTRIBUTE_TYPE_ID=EXP_PROCESS_100704_.tb8_0(1),
DESCRIPTION='VARCHAR2'
,
INTERNAL_TYPE=1,
INTERNAL_JAVA_TYPE=12
 WHERE ATTRIBUTE_TYPE_ID = EXP_PROCESS_100704_.tb8_0(1);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES_TYPE(ATTRIBUTE_TYPE_ID,DESCRIPTION,INTERNAL_TYPE,INTERNAL_JAVA_TYPE) 
VALUES (EXP_PROCESS_100704_.tb8_0(1),
'VARCHAR2'
,
1,
12);
end if;

exception when others then
EXP_PROCESS_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100704_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100704_.tb9_0(1):=5001480;
EXP_PROCESS_100704_.tb9_1(1):=EXP_PROCESS_100704_.tb7_0(1);
EXP_PROCESS_100704_.tb9_2(1):=EXP_PROCESS_100704_.tb8_0(1);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (1)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=EXP_PROCESS_100704_.tb9_0(1),
ATTRIBUTE_CLASS_ID=EXP_PROCESS_100704_.tb9_1(1),
ATTRIBUTE_TYPE_ID=EXP_PROCESS_100704_.tb9_2(1),
VALID_EXPRESSION=null,
FATHER_ID=null,
MODULE_ID=4,
NAME_ATTRIBUTE='CAUSAL'
,
LENGTH=100,
PRECISION=null,
SCALE=null,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE=null,
COMMENT_='Datos Legalizacion OT OYM - Mantenimientos Correctivos'
,
DISPLAY_NAME='Causal'

 WHERE ATTRIBUTE_ID = EXP_PROCESS_100704_.tb9_0(1);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,ATTRIBUTE_CLASS_ID,ATTRIBUTE_TYPE_ID,VALID_EXPRESSION,FATHER_ID,MODULE_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (EXP_PROCESS_100704_.tb9_0(1),
EXP_PROCESS_100704_.tb9_1(1),
EXP_PROCESS_100704_.tb9_2(1),
null,
null,
4,
'CAUSAL'
,
100,
null,
null,
null,
null,
'Datos Legalizacion OT OYM - Mantenimientos Correctivos'
,
'Causal'
);
end if;

exception when others then
EXP_PROCESS_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100704_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100704_.tb10_0(2):=100001193;
EXP_PROCESS_100704_.tb10_1(2):=EXP_PROCESS_100704_.tb5_0(1);
EXP_PROCESS_100704_.tb10_2(2):=EXP_PROCESS_100704_.tb9_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (2)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100704_.tb10_0(2),
UNIT_ID=EXP_PROCESS_100704_.tb10_1(2),
ATTRIBUTE_ID=EXP_PROCESS_100704_.tb10_2(2),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=1,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100704_.tb10_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100704_.tb10_0(2),
EXP_PROCESS_100704_.tb10_1(2),
EXP_PROCESS_100704_.tb10_2(2),
null,
null,
'N'
,
1,
'N'
);
end if;

exception when others then
EXP_PROCESS_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100704_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100704_.tb1_0(2):=5;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (2)',1);
UPDATE GE_MODULE SET MODULE_ID=EXP_PROCESS_100704_.tb1_0(2),
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

 WHERE MODULE_ID = EXP_PROCESS_100704_.tb1_0(2);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (EXP_PROCESS_100704_.tb1_0(2),
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
EXP_PROCESS_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100704_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100704_.tb2_0(3):=100703;
EXP_PROCESS_100704_.tb2_1(3):=EXP_PROCESS_100704_.tb0_0(1);
EXP_PROCESS_100704_.tb2_2(3):=EXP_PROCESS_100704_.tb1_0(2);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (3)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100704_.tb2_0(3),
CATEGORY_ID=EXP_PROCESS_100704_.tb2_1(3),
MODULE_ID=EXP_PROCESS_100704_.tb2_2(3),
ACTION_ID=null,
PARENT_ID=983,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_100703'
,
DESCRIPTION='Atender Reconexion por seguridad'
,
DISPLAY='Atender Reconexion por seguridad'
,
ICON=null,
IS_STAGE_PROCESS='N'
,
USABLE_IN_FLOW_STAGE='N'
,
ENTITY_ID=null,
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100704_.tb2_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100704_.tb2_0(3),
EXP_PROCESS_100704_.tb2_1(3),
EXP_PROCESS_100704_.tb2_2(3),
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_100703'
,
'Atender Reconexion por seguridad'
,
'Atender Reconexion por seguridad'
,
null,
'N'
,
'N'
,
null,
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
EXP_PROCESS_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100704_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100704_.tb5_0(3):=103107;
EXP_PROCESS_100704_.tb5_1(3):=EXP_PROCESS_100704_.tb5_0(0);
EXP_PROCESS_100704_.tb5_2(3):=EXP_PROCESS_100704_.tb2_0(3);
EXP_PROCESS_100704_.tb5_3(3):=EXP_PROCESS_100704_.tb4_0(2);
EXP_PROCESS_100704_.tb5_4(3):=EXP_PROCESS_100704_.tb1_0(2);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (3)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100704_.tb5_0(3),
PROCESS_ID=EXP_PROCESS_100704_.tb5_1(3),
UNIT_TYPE_ID=EXP_PROCESS_100704_.tb5_2(3),
NODE_TYPE_ID=EXP_PROCESS_100704_.tb5_3(3),
MODULE_ID=EXP_PROCESS_100704_.tb5_4(3),
ACTION_ID=8298,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=9000,
GEOMETRY='450
175'
,
DESCRIPTION='Atender Reconexion por seguridad'
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

 WHERE UNIT_ID = EXP_PROCESS_100704_.tb5_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100704_.tb5_0(3),
EXP_PROCESS_100704_.tb5_1(3),
EXP_PROCESS_100704_.tb5_2(3),
EXP_PROCESS_100704_.tb5_3(3),
EXP_PROCESS_100704_.tb5_4(3),
8298,
null,
null,
9000,
'450
175'
,
'Atender Reconexion por seguridad'
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
EXP_PROCESS_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100704_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100704_.tb6_0(1):=100000811;
EXP_PROCESS_100704_.tb6_1(1):=EXP_PROCESS_100704_.tb5_0(2);
EXP_PROCESS_100704_.tb6_2(1):=EXP_PROCESS_100704_.tb5_0(3);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (1)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100704_.tb6_0(1),
ORIGIN_ID=EXP_PROCESS_100704_.tb6_1(1),
TARGET_ID=EXP_PROCESS_100704_.tb6_2(1),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION=null,
EXPRESSION_TYPE=0,
DESCRIPTION=null,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100704_.tb6_0(1);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100704_.tb6_0(1),
EXP_PROCESS_100704_.tb6_1(1),
EXP_PROCESS_100704_.tb6_2(1),
null,
0,
null,
0,
null,
1);
end if;

exception when others then
EXP_PROCESS_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100704_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100704_.tb10_0(3):=100001228;
EXP_PROCESS_100704_.tb10_1(3):=EXP_PROCESS_100704_.tb5_0(2);
EXP_PROCESS_100704_.tb10_2(3):=EXP_PROCESS_100704_.tb9_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (3)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100704_.tb10_0(3),
UNIT_ID=EXP_PROCESS_100704_.tb10_1(3),
ATTRIBUTE_ID=EXP_PROCESS_100704_.tb10_2(3),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100704_.tb10_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100704_.tb10_0(3),
EXP_PROCESS_100704_.tb10_1(3),
EXP_PROCESS_100704_.tb10_2(3),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100704_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100704_.tb2_0(4):=252;
EXP_PROCESS_100704_.tb2_1(4):=EXP_PROCESS_100704_.tb0_0(1);
EXP_PROCESS_100704_.tb2_2(4):=EXP_PROCESS_100704_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (4)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100704_.tb2_0(4),
CATEGORY_ID=EXP_PROCESS_100704_.tb2_1(4),
MODULE_ID=EXP_PROCESS_100704_.tb2_2(4),
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100704_.tb2_0(4);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100704_.tb2_0(4),
EXP_PROCESS_100704_.tb2_1(4),
EXP_PROCESS_100704_.tb2_2(4),
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
EXP_PROCESS_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100704_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100704_.tb4_0(3):=3;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (3)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100704_.tb4_0(3),
DESCRIPTION='Final'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100704_.tb4_0(3);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100704_.tb4_0(3),
'Final'
);
end if;

exception when others then
EXP_PROCESS_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100704_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100704_.tb5_0(4):=103106;
EXP_PROCESS_100704_.tb5_1(4):=EXP_PROCESS_100704_.tb5_0(0);
EXP_PROCESS_100704_.tb5_2(4):=EXP_PROCESS_100704_.tb2_0(4);
EXP_PROCESS_100704_.tb5_3(4):=EXP_PROCESS_100704_.tb4_0(3);
EXP_PROCESS_100704_.tb5_4(4):=EXP_PROCESS_100704_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (4)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100704_.tb5_0(4),
PROCESS_ID=EXP_PROCESS_100704_.tb5_1(4),
UNIT_TYPE_ID=EXP_PROCESS_100704_.tb5_2(4),
NODE_TYPE_ID=EXP_PROCESS_100704_.tb5_3(4),
MODULE_ID=EXP_PROCESS_100704_.tb5_4(4),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='686
187'
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

 WHERE UNIT_ID = EXP_PROCESS_100704_.tb5_0(4);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100704_.tb5_0(4),
EXP_PROCESS_100704_.tb5_1(4),
EXP_PROCESS_100704_.tb5_2(4),
EXP_PROCESS_100704_.tb5_3(4),
EXP_PROCESS_100704_.tb5_4(4),
null,
null,
null,
null,
'686
187'
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
EXP_PROCESS_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100704_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100704_.tb6_0(2):=100000828;
EXP_PROCESS_100704_.tb6_1(2):=EXP_PROCESS_100704_.tb5_0(3);
EXP_PROCESS_100704_.tb6_2(2):=EXP_PROCESS_100704_.tb5_0(4);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (2)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100704_.tb6_0(2),
ORIGIN_ID=EXP_PROCESS_100704_.tb6_1(2),
TARGET_ID=EXP_PROCESS_100704_.tb6_2(2),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION=null,
EXPRESSION_TYPE=0,
DESCRIPTION=null,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100704_.tb6_0(2);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100704_.tb6_0(2),
EXP_PROCESS_100704_.tb6_1(2),
EXP_PROCESS_100704_.tb6_2(2),
null,
0,
null,
0,
null,
1);
end if;

exception when others then
EXP_PROCESS_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100704_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100704_.tb10_0(4):=100001226;
EXP_PROCESS_100704_.tb10_1(4):=EXP_PROCESS_100704_.tb5_0(3);
EXP_PROCESS_100704_.tb10_2(4):=EXP_PROCESS_100704_.tb9_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (4)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100704_.tb10_0(4),
UNIT_ID=EXP_PROCESS_100704_.tb10_1(4),
ATTRIBUTE_ID=EXP_PROCESS_100704_.tb10_2(4),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=1,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100704_.tb10_0(4);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100704_.tb10_0(4),
EXP_PROCESS_100704_.tb10_1(4),
EXP_PROCESS_100704_.tb10_2(4),
null,
null,
'N'
,
1,
'N'
);
end if;

exception when others then
EXP_PROCESS_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100704_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100704_.tb10_0(5):=100001194;
EXP_PROCESS_100704_.tb10_1(5):=EXP_PROCESS_100704_.tb5_0(4);
EXP_PROCESS_100704_.tb10_2(5):=EXP_PROCESS_100704_.tb9_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (5)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100704_.tb10_0(5),
UNIT_ID=EXP_PROCESS_100704_.tb10_1(5),
ATTRIBUTE_ID=EXP_PROCESS_100704_.tb10_2(5),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100704_.tb10_0(5);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100704_.tb10_0(5),
EXP_PROCESS_100704_.tb10_1(5),
EXP_PROCESS_100704_.tb10_2(5),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100704_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100704_.tb10_0(6):=100001230;
EXP_PROCESS_100704_.tb10_1(6):=EXP_PROCESS_100704_.tb5_0(4);
EXP_PROCESS_100704_.tb10_2(6):=EXP_PROCESS_100704_.tb9_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (6)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100704_.tb10_0(6),
UNIT_ID=EXP_PROCESS_100704_.tb10_1(6),
ATTRIBUTE_ID=EXP_PROCESS_100704_.tb10_2(6),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100704_.tb10_0(6);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100704_.tb10_0(6),
EXP_PROCESS_100704_.tb10_1(6),
EXP_PROCESS_100704_.tb10_2(6),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100704_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100704_.tb10_0(7):=100001212;
EXP_PROCESS_100704_.tb10_1(7):=EXP_PROCESS_100704_.tb5_0(4);
EXP_PROCESS_100704_.tb10_2(7):=EXP_PROCESS_100704_.tb9_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (7)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100704_.tb10_0(7),
UNIT_ID=EXP_PROCESS_100704_.tb10_1(7),
ATTRIBUTE_ID=EXP_PROCESS_100704_.tb10_2(7),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100704_.tb10_0(7);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100704_.tb10_0(7),
EXP_PROCESS_100704_.tb10_1(7),
EXP_PROCESS_100704_.tb10_2(7),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100704_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100704_.tb10_0(8):=100001214;
EXP_PROCESS_100704_.tb10_1(8):=EXP_PROCESS_100704_.tb5_0(4);
EXP_PROCESS_100704_.tb10_2(8):=EXP_PROCESS_100704_.tb9_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (8)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100704_.tb10_0(8),
UNIT_ID=EXP_PROCESS_100704_.tb10_1(8),
ATTRIBUTE_ID=EXP_PROCESS_100704_.tb10_2(8),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100704_.tb10_0(8);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100704_.tb10_0(8),
EXP_PROCESS_100704_.tb10_1(8),
EXP_PROCESS_100704_.tb10_2(8),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_100704_.blProcessStatus := false;
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
sa_bocreatePackages.CreatePackage('EXP_UNITTYPE_100704_',
'CREATE OR REPLACE PACKAGE EXP_UNITTYPE_100704_ IS ' || chr(10) ||
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
'END EXP_UNITTYPE_100704_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_UNITTYPE_100704_******************************'); END;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_UNITTYPE_100704',1);
EXP_UNITTYPE_100704_.blProcessStatus := EXP_PROCESS_100704_.blProcessStatus ; 
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
AND     A.TASK_CODE = 100704
 
;
BEGIN

if (not EXP_UNITTYPE_100704_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_UNITTYPE_100704_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
FROM WF_UNIT_TYPE_ATTRIB WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100704);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100704_.blProcessStatus) then
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
EXP_UNITTYPE_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_CAUSAL_UNIT_TYPE WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100704);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100704_.blProcessStatus) then
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
EXP_UNITTYPE_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM MO_TIME_UNI_TYP_PRIO WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100704);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100704_.blProcessStatus) then
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
EXP_UNITTYPE_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM OR_ACT_BY_TASK_MOD WHERE (TASK_CODE) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100704);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100704_.blProcessStatus) then
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
EXP_UNITTYPE_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100704;
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100704_.blProcessStatus) then
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
EXP_UNITTYPE_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_UNITTYPE_100704_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100704_.tb0_0(0):=100704;
ut_trace.trace('insertando tabla sin fallo: WF_UNIT_TYPE fila (0)',1);
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_UNITTYPE_100704_.tb0_0(0),
3,
9,
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_100704'
,
'LDC - Reconexion por Seguridad'
,
'LDC - Reconexion por Seguridad'
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
EXP_UNITTYPE_100704_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100704',1);
EXP_PROCESS_100704_.blProcessStatus := EXP_UNITTYPE_100704_.blProcessStatus ; 
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
 nuIndex := EXP_UNITTYPE_100704_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_UNITTYPE_100704_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_UNITTYPE_100704_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_UNITTYPE_100704_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_UNITTYPE_100704_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_UNITTYPE_100704_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_UNITTYPE_100704_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_UNITTYPE_100704_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_UNITTYPE_100704_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_UNITTYPE_100704_******************************'); end;
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
EXP_UNITTYPE_283_.blProcessStatus := EXP_PROCESS_100704_.blProcessStatus ; 
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
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100704',1);
EXP_PROCESS_100704_.blProcessStatus := EXP_UNITTYPE_283_.blProcessStatus ; 
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
sa_bocreatePackages.CreatePackage('EXP_UNITTYPE_100702_',
'CREATE OR REPLACE PACKAGE EXP_UNITTYPE_100702_ IS ' || chr(10) ||
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
'tb4_3 ty4_3;type ty5_0 is table of GR_CONFIGURA_TYPE.CONFIGURA_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_0 ty5_0; ' || chr(10) ||
'tb5_0 ty5_0;type ty6_0 is table of GR_CONFIG_EXPRESSION.CONFIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_0 ty6_0; ' || chr(10) ||
'tb6_0 ty6_0;type ty6_1 is table of GR_CONFIG_EXPRESSION.OBJECT_NAME%type index by binary_integer; ' || chr(10) ||
'old_tb6_1 ty6_1; ' || chr(10) ||
'tb6_1 ty6_1;type ty6_2 is table of GR_CONFIG_EXPRESSION.CONFIGURA_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_2 ty6_2; ' || chr(10) ||
'tb6_2 ty6_2;type ty7_0 is table of OR_ACT_BY_TASK_MOD.ACT_BY_TASK_MOD_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_0 ty7_0; ' || chr(10) ||
'tb7_0 ty7_0;type ty7_1 is table of OR_ACT_BY_TASK_MOD.TASK_CODE%type index by binary_integer; ' || chr(10) ||
'old_tb7_1 ty7_1; ' || chr(10) ||
'tb7_1 ty7_1;type ty7_2 is table of OR_ACT_BY_TASK_MOD.CONFIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_2 ty7_2; ' || chr(10) ||
'tb7_2 ty7_2; ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_UNITTYPE_100702_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_UNITTYPE_100702_******************************'); END;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_UNITTYPE_100702',1);
EXP_UNITTYPE_100702_.blProcessStatus := EXP_PROCESS_100704_.blProcessStatus ; 
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
AND     A.TASK_CODE = 100702
 
;
BEGIN

if (not EXP_UNITTYPE_100702_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_UNITTYPE_100702_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
FROM WF_UNIT_TYPE_ATTRIB WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100702);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100702_.blProcessStatus) then
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
EXP_UNITTYPE_100702_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_CAUSAL_UNIT_TYPE WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100702);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100702_.blProcessStatus) then
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
EXP_UNITTYPE_100702_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM MO_TIME_UNI_TYP_PRIO WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100702);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100702_.blProcessStatus) then
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
EXP_UNITTYPE_100702_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM OR_ACT_BY_TASK_MOD WHERE (TASK_CODE) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100702);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100702_.blProcessStatus) then
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
EXP_UNITTYPE_100702_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100702;
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100702_.blProcessStatus) then
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
EXP_UNITTYPE_100702_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_UNITTYPE_100702_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100702_.tb0_0(0):=100702;
ut_trace.trace('insertando tabla sin fallo: WF_UNIT_TYPE fila (0)',1);
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_UNITTYPE_100702_.tb0_0(0),
2,
4,
100,
983,
null,
null,
null,
null,
'UNIT_TYPE_100702'
,
'Registro de Orden Reconexion Seguridad'
,
'Registro de Orden Reconexion Seguridad'
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
EXP_UNITTYPE_100702_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_100702_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100702_.tb1_0(0):=9;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTE_CLASS fila (0)',1);
UPDATE GE_ATTRIBUTE_CLASS SET ATTRIBUTE_CLASS_ID=EXP_UNITTYPE_100702_.tb1_0(0),
NAME='Legalizacion Ordenes'
,
DESCRIPTION='Valores necesarios en la legalizacion de Ordenes de Trabajo'

 WHERE ATTRIBUTE_CLASS_ID = EXP_UNITTYPE_100702_.tb1_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTE_CLASS(ATTRIBUTE_CLASS_ID,NAME,DESCRIPTION) 
VALUES (EXP_UNITTYPE_100702_.tb1_0(0),
'Legalizacion Ordenes'
,
'Valores necesarios en la legalizacion de Ordenes de Trabajo'
);
end if;

exception when others then
EXP_UNITTYPE_100702_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_100702_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100702_.tb2_0(0):=2;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES_TYPE fila (0)',1);
UPDATE GE_ATTRIBUTES_TYPE SET ATTRIBUTE_TYPE_ID=EXP_UNITTYPE_100702_.tb2_0(0),
DESCRIPTION='VARCHAR2'
,
INTERNAL_TYPE=1,
INTERNAL_JAVA_TYPE=12
 WHERE ATTRIBUTE_TYPE_ID = EXP_UNITTYPE_100702_.tb2_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES_TYPE(ATTRIBUTE_TYPE_ID,DESCRIPTION,INTERNAL_TYPE,INTERNAL_JAVA_TYPE) 
VALUES (EXP_UNITTYPE_100702_.tb2_0(0),
'VARCHAR2'
,
1,
12);
end if;

exception when others then
EXP_UNITTYPE_100702_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_100702_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100702_.tb3_0(0):=5001480;
EXP_UNITTYPE_100702_.tb3_1(0):=EXP_UNITTYPE_100702_.tb1_0(0);
EXP_UNITTYPE_100702_.tb3_2(0):=EXP_UNITTYPE_100702_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (0)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=EXP_UNITTYPE_100702_.tb3_0(0),
ATTRIBUTE_CLASS_ID=EXP_UNITTYPE_100702_.tb3_1(0),
ATTRIBUTE_TYPE_ID=EXP_UNITTYPE_100702_.tb3_2(0),
VALID_EXPRESSION=null,
FATHER_ID=null,
MODULE_ID=4,
NAME_ATTRIBUTE='CAUSAL'
,
LENGTH=100,
PRECISION=null,
SCALE=null,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE=null,
COMMENT_='Datos Legalizacion OT OYM - Mantenimientos Correctivos'
,
DISPLAY_NAME='Causal'

 WHERE ATTRIBUTE_ID = EXP_UNITTYPE_100702_.tb3_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,ATTRIBUTE_CLASS_ID,ATTRIBUTE_TYPE_ID,VALID_EXPRESSION,FATHER_ID,MODULE_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (EXP_UNITTYPE_100702_.tb3_0(0),
EXP_UNITTYPE_100702_.tb3_1(0),
EXP_UNITTYPE_100702_.tb3_2(0),
null,
null,
4,
'CAUSAL'
,
100,
null,
null,
null,
null,
'Datos Legalizacion OT OYM - Mantenimientos Correctivos'
,
'Causal'
);
end if;

exception when others then
EXP_UNITTYPE_100702_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_100702_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100702_.tb4_0(0):=100000097;
EXP_UNITTYPE_100702_.tb4_1(0):=EXP_UNITTYPE_100702_.tb0_0(0);
EXP_UNITTYPE_100702_.tb4_2(0):=EXP_UNITTYPE_100702_.tb3_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE_ATTRIB fila (0)',1);
UPDATE WF_UNIT_TYPE_ATTRIB SET UNIT_TYPE_ATTRIB_ID=EXP_UNITTYPE_100702_.tb4_0(0),
UNIT_TYPE_ID=EXP_UNITTYPE_100702_.tb4_1(0),
ATTRIBUTE_ID=EXP_UNITTYPE_100702_.tb4_2(0),
STATEMENT_ID=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_TYPE_ATTRIB_ID = EXP_UNITTYPE_100702_.tb4_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE_ATTRIB(UNIT_TYPE_ATTRIB_ID,UNIT_TYPE_ID,ATTRIBUTE_ID,STATEMENT_ID,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_UNITTYPE_100702_.tb4_0(0),
EXP_UNITTYPE_100702_.tb4_1(0),
EXP_UNITTYPE_100702_.tb4_2(0),
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_UNITTYPE_100702_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_100702_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100702_.tb5_0(0):=404;
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=EXP_UNITTYPE_100702_.tb5_0(0),
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

 WHERE CONFIGURA_TYPE_ID = EXP_UNITTYPE_100702_.tb5_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (EXP_UNITTYPE_100702_.tb5_0(0),
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
EXP_UNITTYPE_100702_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_100702_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100702_.old_tb6_0(0):=121374998;
EXP_UNITTYPE_100702_.tb6_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
EXP_UNITTYPE_100702_.tb6_0(0):=EXP_UNITTYPE_100702_.tb6_0(0);
EXP_UNITTYPE_100702_.old_tb6_1(0):='OR_SEL_TASTYP_CT404E121374998'
;
EXP_UNITTYPE_100702_.tb6_1(0):=TO_CHAR(EXP_UNITTYPE_100702_.tb6_0(0));
EXP_UNITTYPE_100702_.tb6_2(0):=EXP_UNITTYPE_100702_.tb5_0(0);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (EXP_UNITTYPE_100702_.tb6_0(0),
EXP_UNITTYPE_100702_.tb6_1(0),
EXP_UNITTYPE_100702_.tb6_2(0),
'nusolicitud = OR_BOINSTANCE.FNUGETFATHEXTSYSIDFROMINSTANCE();nuproducto = MO_BOPACKAGES.FNUFINDPRODUCTID(nusolicitud);sbidmotive = CF_BOSTATEMENTSWF.FNUGETINITMOTIVE(nusolicitud);nuidmotive = UT_CONVERT.FNUCHARTONUMBER(sbidmotive);sbtiposuspension = LDC_BO_GESTIONSUSPSEG.LDC_FSBVALIDASUSPCEMOACOMPROD(nuproducto);if (sbtiposuspension = "CM",OR_BOINSTANCE.SETSUCCESSININSTANCE();,OR_BOINSTANCE.SETUN_SUCCESSININSTANCE();)'
,
'OPEN'
,
to_date('11-05-2021 20:09:42','DD-MM-YYYY HH24:MI:SS'),
to_date('11-05-2021 20:14:10','DD-MM-YYYY HH24:MI:SS'),
to_date('11-05-2021 20:14:10','DD-MM-YYYY HH24:MI:SS'),
'R'
,
'N'
,
'PU'
,
null,
'DS'
,
'Genera solicitud de reconexión por seguridad cm'
,
'PP'
,
null);

exception when others then
EXP_UNITTYPE_100702_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_100702_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100702_.tb7_0(0):=11338;
EXP_UNITTYPE_100702_.tb7_1(0):=EXP_UNITTYPE_100702_.tb0_0(0);
EXP_UNITTYPE_100702_.tb7_2(0):=EXP_UNITTYPE_100702_.tb6_0(0);
ut_trace.trace('Actualizar o insertar tabla: OR_ACT_BY_TASK_MOD fila (0)',1);
UPDATE OR_ACT_BY_TASK_MOD SET ACT_BY_TASK_MOD_ID=EXP_UNITTYPE_100702_.tb7_0(0),
TASK_CODE=EXP_UNITTYPE_100702_.tb7_1(0),
CONFIG_EXPRESSION_ID=EXP_UNITTYPE_100702_.tb7_2(0),
MODULE_ID=9,
ITEMS_ID=100009108
 WHERE ACT_BY_TASK_MOD_ID = EXP_UNITTYPE_100702_.tb7_0(0);
if not (sql%found) then
INSERT INTO OR_ACT_BY_TASK_MOD(ACT_BY_TASK_MOD_ID,TASK_CODE,CONFIG_EXPRESSION_ID,MODULE_ID,ITEMS_ID) 
VALUES (EXP_UNITTYPE_100702_.tb7_0(0),
EXP_UNITTYPE_100702_.tb7_1(0),
EXP_UNITTYPE_100702_.tb7_2(0),
9,
100009108);
end if;

exception when others then
EXP_UNITTYPE_100702_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_100702_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100702_.old_tb6_0(1):=121374999;
EXP_UNITTYPE_100702_.tb6_0(1):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
EXP_UNITTYPE_100702_.tb6_0(1):=EXP_UNITTYPE_100702_.tb6_0(1);
EXP_UNITTYPE_100702_.old_tb6_1(1):='OR_SEL_TASTYP_CT404E121374999'
;
EXP_UNITTYPE_100702_.tb6_1(1):=TO_CHAR(EXP_UNITTYPE_100702_.tb6_0(1));
EXP_UNITTYPE_100702_.tb6_2(1):=EXP_UNITTYPE_100702_.tb5_0(0);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (1)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (EXP_UNITTYPE_100702_.tb6_0(1),
EXP_UNITTYPE_100702_.tb6_1(1),
EXP_UNITTYPE_100702_.tb6_2(1),
'nusolicitud = OR_BOINSTANCE.FNUGETFATHEXTSYSIDFROMINSTANCE();nuproducto = MO_BOPACKAGES.FNUFINDPRODUCTID(nusolicitud);sbidmotive = CF_BOSTATEMENTSWF.FNUGETINITMOTIVE(nusolicitud);nuidmotive = UT_CONVERT.FNUCHARTONUMBER(sbidmotive);sbtiposuspension = LDC_BO_GESTIONSUSPSEG.LDC_FSBVALIDASUSPCEMOACOMPROD(nuproducto);if (sbtiposuspension = "AC",OR_BOINSTANCE.SETSUCCESSININSTANCE();,OR_BOINSTANCE.SETUN_SUCCESSININSTANCE();)'
,
'OPEN'
,
to_date('11-05-2021 20:14:49','DD-MM-YYYY HH24:MI:SS'),
to_date('11-05-2021 20:15:05','DD-MM-YYYY HH24:MI:SS'),
to_date('11-05-2021 20:15:05','DD-MM-YYYY HH24:MI:SS'),
'R'
,
'N'
,
'PU'
,
null,
'DS'
,
'Genera solicitud de reconexión por seguridad AC'
,
'PP'
,
null);

exception when others then
EXP_UNITTYPE_100702_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_100702_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100702_.tb7_0(1):=11348;
EXP_UNITTYPE_100702_.tb7_1(1):=EXP_UNITTYPE_100702_.tb0_0(0);
EXP_UNITTYPE_100702_.tb7_2(1):=EXP_UNITTYPE_100702_.tb6_0(1);
ut_trace.trace('Actualizar o insertar tabla: OR_ACT_BY_TASK_MOD fila (1)',1);
UPDATE OR_ACT_BY_TASK_MOD SET ACT_BY_TASK_MOD_ID=EXP_UNITTYPE_100702_.tb7_0(1),
TASK_CODE=EXP_UNITTYPE_100702_.tb7_1(1),
CONFIG_EXPRESSION_ID=EXP_UNITTYPE_100702_.tb7_2(1),
MODULE_ID=9,
ITEMS_ID=100009109
 WHERE ACT_BY_TASK_MOD_ID = EXP_UNITTYPE_100702_.tb7_0(1);
if not (sql%found) then
INSERT INTO OR_ACT_BY_TASK_MOD(ACT_BY_TASK_MOD_ID,TASK_CODE,CONFIG_EXPRESSION_ID,MODULE_ID,ITEMS_ID) 
VALUES (EXP_UNITTYPE_100702_.tb7_0(1),
EXP_UNITTYPE_100702_.tb7_1(1),
EXP_UNITTYPE_100702_.tb7_2(1),
9,
100009109);
end if;

exception when others then
EXP_UNITTYPE_100702_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100704',1);
EXP_PROCESS_100704_.blProcessStatus := EXP_UNITTYPE_100702_.blProcessStatus ; 
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

if (not EXP_UNITTYPE_100702_.blProcessStatus) then
 return;
end if;
nuRowProcess:=EXP_UNITTYPE_100702_.tb6_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| EXP_UNITTYPE_100702_.tb6_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(EXP_UNITTYPE_100702_.tb6_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| EXP_UNITTYPE_100702_.tb6_0(nuRowProcess),1);
end;
nuRowProcess := EXP_UNITTYPE_100702_.tb6_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
EXP_UNITTYPE_100702_.blProcessStatus := false;
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
 nuIndex := EXP_UNITTYPE_100702_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_UNITTYPE_100702_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_UNITTYPE_100702_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_UNITTYPE_100702_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_UNITTYPE_100702_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_UNITTYPE_100702_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_UNITTYPE_100702_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_UNITTYPE_100702_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_UNITTYPE_100702_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_UNITTYPE_100702_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_UNITTYPE_100703_',
'CREATE OR REPLACE PACKAGE EXP_UNITTYPE_100703_ IS ' || chr(10) ||
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
'END EXP_UNITTYPE_100703_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_UNITTYPE_100703_******************************'); END;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_UNITTYPE_100703',1);
EXP_UNITTYPE_100703_.blProcessStatus := EXP_PROCESS_100704_.blProcessStatus ; 
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
AND     A.TASK_CODE = 100703
 
;
BEGIN

if (not EXP_UNITTYPE_100703_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_UNITTYPE_100703_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
FROM WF_UNIT_TYPE_ATTRIB WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100703);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100703_.blProcessStatus) then
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
EXP_UNITTYPE_100703_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_CAUSAL_UNIT_TYPE WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100703);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100703_.blProcessStatus) then
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
EXP_UNITTYPE_100703_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM MO_TIME_UNI_TYP_PRIO WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100703);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100703_.blProcessStatus) then
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
EXP_UNITTYPE_100703_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM OR_ACT_BY_TASK_MOD WHERE (TASK_CODE) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100703);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100703_.blProcessStatus) then
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
EXP_UNITTYPE_100703_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100703;
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100703_.blProcessStatus) then
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
EXP_UNITTYPE_100703_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_UNITTYPE_100703_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100703_.tb0_0(0):=100703;
ut_trace.trace('insertando tabla sin fallo: WF_UNIT_TYPE fila (0)',1);
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_UNITTYPE_100703_.tb0_0(0),
2,
5,
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_100703'
,
'Atender Reconexion por seguridad'
,
'Atender Reconexion por seguridad'
,
null,
'N'
,
'N'
,
null,
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
EXP_UNITTYPE_100703_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_100703_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100703_.tb1_0(0):=9;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTE_CLASS fila (0)',1);
UPDATE GE_ATTRIBUTE_CLASS SET ATTRIBUTE_CLASS_ID=EXP_UNITTYPE_100703_.tb1_0(0),
NAME='Legalizacion Ordenes'
,
DESCRIPTION='Valores necesarios en la legalizacion de Ordenes de Trabajo'

 WHERE ATTRIBUTE_CLASS_ID = EXP_UNITTYPE_100703_.tb1_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTE_CLASS(ATTRIBUTE_CLASS_ID,NAME,DESCRIPTION) 
VALUES (EXP_UNITTYPE_100703_.tb1_0(0),
'Legalizacion Ordenes'
,
'Valores necesarios en la legalizacion de Ordenes de Trabajo'
);
end if;

exception when others then
EXP_UNITTYPE_100703_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_100703_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100703_.tb2_0(0):=2;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES_TYPE fila (0)',1);
UPDATE GE_ATTRIBUTES_TYPE SET ATTRIBUTE_TYPE_ID=EXP_UNITTYPE_100703_.tb2_0(0),
DESCRIPTION='VARCHAR2'
,
INTERNAL_TYPE=1,
INTERNAL_JAVA_TYPE=12
 WHERE ATTRIBUTE_TYPE_ID = EXP_UNITTYPE_100703_.tb2_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES_TYPE(ATTRIBUTE_TYPE_ID,DESCRIPTION,INTERNAL_TYPE,INTERNAL_JAVA_TYPE) 
VALUES (EXP_UNITTYPE_100703_.tb2_0(0),
'VARCHAR2'
,
1,
12);
end if;

exception when others then
EXP_UNITTYPE_100703_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_100703_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100703_.tb3_0(0):=5001480;
EXP_UNITTYPE_100703_.tb3_1(0):=EXP_UNITTYPE_100703_.tb1_0(0);
EXP_UNITTYPE_100703_.tb3_2(0):=EXP_UNITTYPE_100703_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (0)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=EXP_UNITTYPE_100703_.tb3_0(0),
ATTRIBUTE_CLASS_ID=EXP_UNITTYPE_100703_.tb3_1(0),
ATTRIBUTE_TYPE_ID=EXP_UNITTYPE_100703_.tb3_2(0),
VALID_EXPRESSION=null,
FATHER_ID=null,
MODULE_ID=4,
NAME_ATTRIBUTE='CAUSAL'
,
LENGTH=100,
PRECISION=null,
SCALE=null,
DEFAULT_VALUE=null,
IS_FIX_OR_VARIABLE=null,
COMMENT_='Datos Legalizacion OT OYM - Mantenimientos Correctivos'
,
DISPLAY_NAME='Causal'

 WHERE ATTRIBUTE_ID = EXP_UNITTYPE_100703_.tb3_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,ATTRIBUTE_CLASS_ID,ATTRIBUTE_TYPE_ID,VALID_EXPRESSION,FATHER_ID,MODULE_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (EXP_UNITTYPE_100703_.tb3_0(0),
EXP_UNITTYPE_100703_.tb3_1(0),
EXP_UNITTYPE_100703_.tb3_2(0),
null,
null,
4,
'CAUSAL'
,
100,
null,
null,
null,
null,
'Datos Legalizacion OT OYM - Mantenimientos Correctivos'
,
'Causal'
);
end if;

exception when others then
EXP_UNITTYPE_100703_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_100703_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100703_.tb4_0(0):=100000098;
EXP_UNITTYPE_100703_.tb4_1(0):=EXP_UNITTYPE_100703_.tb0_0(0);
EXP_UNITTYPE_100703_.tb4_2(0):=EXP_UNITTYPE_100703_.tb3_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE_ATTRIB fila (0)',1);
UPDATE WF_UNIT_TYPE_ATTRIB SET UNIT_TYPE_ATTRIB_ID=EXP_UNITTYPE_100703_.tb4_0(0),
UNIT_TYPE_ID=EXP_UNITTYPE_100703_.tb4_1(0),
ATTRIBUTE_ID=EXP_UNITTYPE_100703_.tb4_2(0),
STATEMENT_ID=null,
IS_DUPLICABLE='N'
,
IN_OUT=1,
MANDATORY='N'

 WHERE UNIT_TYPE_ATTRIB_ID = EXP_UNITTYPE_100703_.tb4_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE_ATTRIB(UNIT_TYPE_ATTRIB_ID,UNIT_TYPE_ID,ATTRIBUTE_ID,STATEMENT_ID,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_UNITTYPE_100703_.tb4_0(0),
EXP_UNITTYPE_100703_.tb4_1(0),
EXP_UNITTYPE_100703_.tb4_2(0),
null,
'N'
,
1,
'N'
);
end if;

exception when others then
EXP_UNITTYPE_100703_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100704',1);
EXP_PROCESS_100704_.blProcessStatus := EXP_UNITTYPE_100703_.blProcessStatus ; 
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
 nuIndex := EXP_UNITTYPE_100703_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_UNITTYPE_100703_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_UNITTYPE_100703_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_UNITTYPE_100703_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_UNITTYPE_100703_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_UNITTYPE_100703_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_UNITTYPE_100703_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_UNITTYPE_100703_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_UNITTYPE_100703_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_UNITTYPE_100703_******************************'); end;
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
EXP_UNITTYPE_252_.blProcessStatus := EXP_PROCESS_100704_.blProcessStatus ; 
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
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100704',1);
EXP_PROCESS_100704_.blProcessStatus := EXP_UNITTYPE_252_.blProcessStatus ; 
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
ut_trace.trace('Realizar Commit del Flujo',1);
if ( not EXP_PROCESS_100704_.blProcessStatus) then
 return;
 end if;
ut_trace.trace('Realizar Commit de EXP_PROCESS_100704 ',1);
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
    nuBinaryIndex := EXP_PROCESS_100704_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = EXP_PROCESS_100704_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||EXP_PROCESS_100704_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||EXP_PROCESS_100704_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := EXP_PROCESS_100704_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       EXP_PROCESS_100704_.blProcessStatus := FALSE;
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
 nuIndex := EXP_PROCESS_100704_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_PROCESS_100704_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_PROCESS_100704_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_PROCESS_100704_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_PROCESS_100704_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_PROCESS_100704_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_PROCESS_100704_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_PROCESS_100704_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_PROCESS_100704_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_PROCESS_100704_******************************'); end;
/



