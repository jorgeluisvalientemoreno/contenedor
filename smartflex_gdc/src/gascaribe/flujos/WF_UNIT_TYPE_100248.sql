BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_PROCESS_100248_',
'CREATE OR REPLACE PACKAGE EXP_PROCESS_100248_ IS ' || chr(10) ||
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
'tb6_2 ty6_2;type ty7_0 is table of GR_CONFIGURA_TYPE.CONFIGURA_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_0 ty7_0; ' || chr(10) ||
'tb7_0 ty7_0;type ty8_0 is table of GR_CONFIG_EXPRESSION.CONFIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_0 ty8_0; ' || chr(10) ||
'tb8_0 ty8_0;type ty8_1 is table of GR_CONFIG_EXPRESSION.OBJECT_NAME%type index by binary_integer; ' || chr(10) ||
'old_tb8_1 ty8_1; ' || chr(10) ||
'tb8_1 ty8_1;type ty8_2 is table of GR_CONFIG_EXPRESSION.CONFIGURA_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_2 ty8_2; ' || chr(10) ||
'tb8_2 ty8_2;type ty9_0 is table of GE_COMMENT_CLASS.COMMENT_CLASS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb9_0 ty9_0; ' || chr(10) ||
'tb9_0 ty9_0;type ty10_0 is table of GE_ATTRIBUTE_CLASS.ATTRIBUTE_CLASS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb10_0 ty10_0; ' || chr(10) ||
'tb10_0 ty10_0;type ty11_0 is table of GE_ATTRIBUTES_TYPE.ATTRIBUTE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb11_0 ty11_0; ' || chr(10) ||
'tb11_0 ty11_0;type ty12_0 is table of GE_ATTRIBUTES.ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb12_0 ty12_0; ' || chr(10) ||
'tb12_0 ty12_0;type ty12_1 is table of GE_ATTRIBUTES.ATTRIBUTE_CLASS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb12_1 ty12_1; ' || chr(10) ||
'tb12_1 ty12_1;type ty12_2 is table of GE_ATTRIBUTES.ATTRIBUTE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb12_2 ty12_2; ' || chr(10) ||
'tb12_2 ty12_2;type ty13_0 is table of WF_UNIT_ATTRIBUTE.UNIT_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb13_0 ty13_0; ' || chr(10) ||
'tb13_0 ty13_0;type ty13_1 is table of WF_UNIT_ATTRIBUTE.UNIT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb13_1 ty13_1; ' || chr(10) ||
'tb13_1 ty13_1;type ty13_2 is table of WF_UNIT_ATTRIBUTE.ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb13_2 ty13_2; ' || chr(10) ||
'tb13_2 ty13_2;type ty13_3 is table of WF_UNIT_ATTRIBUTE.STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb13_3 ty13_3; ' || chr(10) ||
'tb13_3 ty13_3; ' || chr(10) ||
'CURSOR cuExpression is ' || chr(10) ||
'SELECT PRE_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_TYPE_ID = 100248 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID IN  ' || chr(10) ||
'           (SELECT UNIT_ID ' || chr(10) ||
'           FROM WF_UNIT ' || chr(10) ||
'           WHERE UNIT_TYPE_ID = 100248 ' || chr(10) ||
'       )) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_TYPE_ID = 100248 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID IN  ' || chr(10) ||
'           (SELECT UNIT_ID ' || chr(10) ||
'           FROM WF_UNIT ' || chr(10) ||
'           WHERE UNIT_TYPE_ID = 100248 ' || chr(10) ||
'       )) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_PROCESS_100248_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_PROCESS_100248_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open EXP_PROCESS_100248_.cuExpression;
   fetch EXP_PROCESS_100248_.cuExpression bulk collect INTO EXP_PROCESS_100248_.tbGR_CONFIG_EXPRESSIONId;
   close EXP_PROCESS_100248_.cuExpression;
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
sa_bocreatePackages.CreatePackage('DEL_ROOT_100939_',
'CREATE OR REPLACE PACKAGE DEL_ROOT_100939_ IS ' || chr(10) ||
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
'        WHERE UNIT_ID = 100939 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 100939  ' || chr(10) ||
'       ) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_ID = 100939 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 100939  ' || chr(10) ||
'       ) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END DEL_ROOT_100939_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:DEL_ROOT_100939_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open DEL_ROOT_100939_.cuExpression;
   fetch DEL_ROOT_100939_.cuExpression bulk collect INTO DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONId;
   close DEL_ROOT_100939_.cuExpression;
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
        WHERE UNIT_ID = 100939
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID = 100939 
       )
;
BEGIN

if (not DEL_ROOT_100939_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  DEL_ROOT_100939_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE PROCESS_ID = 100939);
BEGIN 

if (not DEL_ROOT_100939_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100939_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE PROCESS_ID = 100939);
BEGIN 

if (not DEL_ROOT_100939_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100939_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 100939)));
BEGIN 

if (not DEL_ROOT_100939_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100939_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 100939)));
BEGIN 

if (not DEL_ROOT_100939_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100939_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 100939));
BEGIN 

if (not DEL_ROOT_100939_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla WF_UNIT',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100939_.tbWF_UNITRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100939_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 100939);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100939_.blProcessStatus) then
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
DEL_ROOT_100939_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100939_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100939_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100939_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100939_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100939_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria WF_UNIT',1);
nuVarcharIndex:=DEL_ROOT_100939_.tbWF_UNITRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from WF_UNIT where rowid = DEL_ROOT_100939_.tbWF_UNITRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100939_.tbWF_UNITRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100939_.tbWF_UNITRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100939_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_DATA_MAP WHERE (SOURCE_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 100939));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100939_.blProcessStatus) then
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
DEL_ROOT_100939_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_DATA_MAP WHERE (TARGET_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 100939));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100939_.blProcessStatus) then
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
DEL_ROOT_100939_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 100939);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100939_.blProcessStatus) then
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
DEL_ROOT_100939_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT WHERE PROCESS_ID = 100939;
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100939_.blProcessStatus) then
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
DEL_ROOT_100939_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100939_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100939_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100939_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100939_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/

BEGIN
    ut_trace.trace('Actualizar WF_UNIT a ProcessId NULL ',1);
   UPDATE WF_UNIT 
     SET PROCESS_ID = -1, POS_EXPRESSION_ID = null, PRE_EXPRESSION_ID = null, ACTION_ID = null 
     WHERE PROCESS_ID = 100939;
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
    nuBinaryIndex := DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       DEL_ROOT_100939_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100248',1);
EXP_PROCESS_100248_.blProcessStatus := DEL_ROOT_100939_.blProcessStatus ; 
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
 nuIndex := DEL_ROOT_100939_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || DEL_ROOT_100939_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(DEL_ROOT_100939_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(DEL_ROOT_100939_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(DEL_ROOT_100939_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || DEL_ROOT_100939_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || DEL_ROOT_100939_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := DEL_ROOT_100939_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('DEL_ROOT_100939_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:DEL_ROOT_100939_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('DEL_ROOT_100939_',
'CREATE OR REPLACE PACKAGE DEL_ROOT_100939_ IS ' || chr(10) ||
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
'        WHERE UNIT_ID = 100939 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 100939  ' || chr(10) ||
'       ) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_ID = 100939 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 100939  ' || chr(10) ||
'       ) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END DEL_ROOT_100939_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:DEL_ROOT_100939_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open DEL_ROOT_100939_.cuExpression;
   fetch DEL_ROOT_100939_.cuExpression bulk collect INTO DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONId;
   close DEL_ROOT_100939_.cuExpression;
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
        WHERE UNIT_ID = 100939
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID = 100939 
       )
;
BEGIN

if (not DEL_ROOT_100939_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  DEL_ROOT_100939_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE UNIT_ID = 100939);
BEGIN 

if (not DEL_ROOT_100939_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100939_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE UNIT_ID = 100939);
BEGIN 

if (not DEL_ROOT_100939_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100939_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 100939)));
BEGIN 

if (not DEL_ROOT_100939_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100939_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 100939)));
BEGIN 

if (not DEL_ROOT_100939_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100939_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 100939));
BEGIN 

if (not DEL_ROOT_100939_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla WF_UNIT',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100939_.tbWF_UNITRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100939_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 100939);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100939_.blProcessStatus) then
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
DEL_ROOT_100939_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100939_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100939_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100939_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100939_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100939_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria WF_UNIT',1);
nuVarcharIndex:=DEL_ROOT_100939_.tbWF_UNITRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from WF_UNIT where rowid = DEL_ROOT_100939_.tbWF_UNITRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100939_.tbWF_UNITRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100939_.tbWF_UNITRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100939_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_DATA_MAP WHERE (SOURCE_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 100939));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100939_.blProcessStatus) then
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
DEL_ROOT_100939_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_DATA_MAP WHERE (TARGET_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 100939));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100939_.blProcessStatus) then
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
DEL_ROOT_100939_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 100939);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100939_.blProcessStatus) then
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
DEL_ROOT_100939_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT WHERE UNIT_ID = 100939;
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100939_.blProcessStatus) then
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
DEL_ROOT_100939_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100939_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100939_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100939_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100939_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/

BEGIN
    ut_trace.trace('Actualizar WF_UNIT a ProcessId NULL ',1);
   UPDATE WF_UNIT 
     SET PROCESS_ID = -1, POS_EXPRESSION_ID = null, PRE_EXPRESSION_ID = null, ACTION_ID = null 
     WHERE PROCESS_ID = 100939;
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
    nuBinaryIndex := DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := DEL_ROOT_100939_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       DEL_ROOT_100939_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100248',1);
EXP_PROCESS_100248_.blProcessStatus := DEL_ROOT_100939_.blProcessStatus ; 
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
 nuIndex := DEL_ROOT_100939_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || DEL_ROOT_100939_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(DEL_ROOT_100939_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(DEL_ROOT_100939_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(DEL_ROOT_100939_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || DEL_ROOT_100939_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || DEL_ROOT_100939_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := DEL_ROOT_100939_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('DEL_ROOT_100939_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:DEL_ROOT_100939_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_ACTION_343_',
'CREATE OR REPLACE PACKAGE EXP_ACTION_343_ IS ' || chr(10) ||
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
'WHERE  ACTION_ID =343; ' || chr(10) ||
'type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_ACTION_343_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_ACTION_343_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open EXP_ACTION_343_.cuExpression;
   fetch EXP_ACTION_343_.cuExpression bulk collect INTO EXP_ACTION_343_.tbGR_CONFIG_EXPRESSIONId;
   close EXP_ACTION_343_.cuExpression;
END;
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_ACTION_343',1);
EXP_ACTION_343_.blProcessStatus := EXP_PROCESS_100248_.blProcessStatus ; 
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
AND     A.ACTION_ID =343
;
BEGIN

if (not EXP_ACTION_343_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_ACTION_343_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE ACTION_ID=343);
BEGIN 

if (not EXP_ACTION_343_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_ACTION_343_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_ACTION_343_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM GE_ACTION_MODULE WHERE ACTION_ID=343;
nuIndex binary_integer;
BEGIN

if (not EXP_ACTION_343_.blProcessStatus) then
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
EXP_ACTION_343_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_ACTION_343_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_ACTION_343_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_ACTION_343_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_ACTION_343_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_ACTION_343_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_ACTION_343_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_ACTION_343_.blProcessStatus) then
 return;
end if;

EXP_ACTION_343_.tb0_0(0):=2;
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=EXP_ACTION_343_.tb0_0(0),
MODULE_ID=5,
DESCRIPTION='Acciones Ejecuci¿n'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_EXECACC_'

 WHERE CONFIGURA_TYPE_ID = EXP_ACTION_343_.tb0_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (EXP_ACTION_343_.tb0_0(0),
5,
'Acciones Ejecuci¿n'
,
'PL'
,
'FD'
,
'DS'
,
'_EXECACC_'
);
end if;

exception when others then
EXP_ACTION_343_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_343_.blProcessStatus) then
 return;
end if;

EXP_ACTION_343_.old_tb1_0(0):=121401234;
EXP_ACTION_343_.tb1_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
EXP_ACTION_343_.tb1_0(0):=EXP_ACTION_343_.tb1_0(0);
EXP_ACTION_343_.old_tb1_1(0):='MO_EXECACC_CT2E121401234'
;
EXP_ACTION_343_.tb1_1(0):=TO_CHAR(EXP_ACTION_343_.tb1_0(0));
EXP_ACTION_343_.tb1_2(0):=EXP_ACTION_343_.tb0_0(0);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (EXP_ACTION_343_.tb1_0(0),
EXP_ACTION_343_.tb1_1(0),
EXP_ACTION_343_.tb1_2(0),
'CC_BOADMINISTRATIVEPROCESS.ACTIONATTENDADMINPROCESS()'
,
'TESTOSS'
,
to_date('31-07-2008 09:42:51','DD-MM-YYYY HH24:MI:SS'),
to_date('28-02-2024 08:47:35','DD-MM-YYYY HH24:MI:SS'),
to_date('28-02-2024 08:47:35','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Inicia atenci¿n de proceso administrativo'
,
'PP'
,
null);

exception when others then
EXP_ACTION_343_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_343_.blProcessStatus) then
 return;
end if;

EXP_ACTION_343_.tb2_0(0):=343;
EXP_ACTION_343_.tb2_2(0):=EXP_ACTION_343_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ACTION_MODULE fila (0)',1);
UPDATE GE_ACTION_MODULE SET ACTION_ID=EXP_ACTION_343_.tb2_0(0),
MODULE_ID=5,
CONFIG_EXPRESSION_ID=EXP_ACTION_343_.tb2_2(0),
DESCRIPTION='Iniciar atenci¿n de proceso administrativo'
,
EXE_AT_STATUS_CHANGE='N'
,
EXE_TRANSITION_STATE='N'

 WHERE ACTION_ID = EXP_ACTION_343_.tb2_0(0);
if not (sql%found) then
INSERT INTO GE_ACTION_MODULE(ACTION_ID,MODULE_ID,CONFIG_EXPRESSION_ID,DESCRIPTION,EXE_AT_STATUS_CHANGE,EXE_TRANSITION_STATE) 
VALUES (EXP_ACTION_343_.tb2_0(0),
5,
EXP_ACTION_343_.tb2_2(0),
'Iniciar atenci¿n de proceso administrativo'
,
'N'
,
'N'
);
end if;

exception when others then
EXP_ACTION_343_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_343_.blProcessStatus) then
 return;
end if;

EXP_ACTION_343_.tb3_0(0):=EXP_ACTION_343_.tb2_0(0);
EXP_ACTION_343_.tb3_1(0):=9;
ut_trace.trace('insertando tabla sin fallo: GE_VALID_ACTION_MODU fila (0)',1);
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (EXP_ACTION_343_.tb3_0(0),
EXP_ACTION_343_.tb3_1(0));

exception 
when dup_val_on_index then 
 return;
when others then
EXP_ACTION_343_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_343_.blProcessStatus) then
 return;
end if;

EXP_ACTION_343_.tb3_0(1):=EXP_ACTION_343_.tb2_0(0);
EXP_ACTION_343_.tb3_1(1):=16;
ut_trace.trace('insertando tabla sin fallo: GE_VALID_ACTION_MODU fila (1)',1);
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (EXP_ACTION_343_.tb3_0(1),
EXP_ACTION_343_.tb3_1(1));

exception 
when dup_val_on_index then 
 return;
when others then
EXP_ACTION_343_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
DECLARE 
    nuBinaryIndex Binary_Integer;
BEGIN 
    nuBinaryIndex := EXP_ACTION_343_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = EXP_ACTION_343_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||EXP_ACTION_343_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||EXP_ACTION_343_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := EXP_ACTION_343_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       EXP_ACTION_343_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100248',1);
EXP_PROCESS_100248_.blProcessStatus := EXP_ACTION_343_.blProcessStatus ; 
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

if (not EXP_ACTION_343_.blProcessStatus) then
 return;
end if;
nuRowProcess:=EXP_ACTION_343_.tb1_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| EXP_ACTION_343_.tb1_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(EXP_ACTION_343_.tb1_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| EXP_ACTION_343_.tb1_0(nuRowProcess),1);
end;
nuRowProcess := EXP_ACTION_343_.tb1_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
EXP_ACTION_343_.blProcessStatus := false;
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
 nuIndex := EXP_ACTION_343_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_ACTION_343_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_ACTION_343_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_ACTION_343_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_ACTION_343_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_ACTION_343_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_ACTION_343_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_ACTION_343_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_ACTION_343_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_ACTION_343_******************************'); end;
/

BEGIN
ut_trace.trace('Actualizar o Insertar Tabla WF_UNIT_TYPE (Carpeta)',1);
    UPDATE wf_unit_type
    SET
       description = 'LBC-Utilities', display = 'LBC-Utilities', parent_id = 100213, category_id = 0, icon = '', tag_name = 'UNIT_TYPE_100213', is_stage_process = 'N', usable_in_flow_stage = 'N', entity_id = null, multi_instance = 'R', module_id = 9, is_countable = 'N', notification_id = null, viewable = 'N', action_id = null, default_priority_id = null, init_area_expression_id = null, initial_notify_time = null, is_admin_process = 'N', assign_comment_class = null, attend_comment_class = null
    WHERE 
      unit_type_id = 100213;
 if not (sql%found) then 
    INSERT INTO wf_unit_type
    ( unit_type_id, description, display, parent_id, category_id, icon, tag_name, is_stage_process, usable_in_flow_stage, entity_id, multi_instance, module_id, is_countable, notification_id, viewable, action_id, default_priority_id, init_area_expression_id, initial_notify_time, is_admin_process, assign_comment_class, attend_comment_class )
    VALUES
    (100213, 'LBC-Utilities', 'LBC-Utilities', 100213, 0, '', 'UNIT_TYPE_100213', 'N', 'N', null, 'R', 9, 'N', null, 'N', null, null, null, null, 'N', null, null); 
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
sa_bocreatePackages.CreatePackage('EXP_ACTION_258_',
'CREATE OR REPLACE PACKAGE EXP_ACTION_258_ IS ' || chr(10) ||
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
'WHERE  ACTION_ID =258; ' || chr(10) ||
'type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_ACTION_258_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_ACTION_258_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open EXP_ACTION_258_.cuExpression;
   fetch EXP_ACTION_258_.cuExpression bulk collect INTO EXP_ACTION_258_.tbGR_CONFIG_EXPRESSIONId;
   close EXP_ACTION_258_.cuExpression;
END;
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_ACTION_258',1);
EXP_ACTION_258_.blProcessStatus := EXP_PROCESS_100248_.blProcessStatus ; 
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
AND     A.ACTION_ID =258
;
BEGIN

if (not EXP_ACTION_258_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_ACTION_258_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE ACTION_ID=258);
BEGIN 

if (not EXP_ACTION_258_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_ACTION_258_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_ACTION_258_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM GE_ACTION_MODULE WHERE ACTION_ID=258;
nuIndex binary_integer;
BEGIN

if (not EXP_ACTION_258_.blProcessStatus) then
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
EXP_ACTION_258_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_ACTION_258_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_ACTION_258_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_ACTION_258_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_ACTION_258_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_ACTION_258_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_ACTION_258_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_ACTION_258_.blProcessStatus) then
 return;
end if;

EXP_ACTION_258_.tb0_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=EXP_ACTION_258_.tb0_0(0),
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

 WHERE CONFIGURA_TYPE_ID = EXP_ACTION_258_.tb0_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (EXP_ACTION_258_.tb0_0(0),
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
EXP_ACTION_258_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_258_.blProcessStatus) then
 return;
end if;

EXP_ACTION_258_.old_tb1_0(0):=121401235;
EXP_ACTION_258_.tb1_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
EXP_ACTION_258_.tb1_0(0):=EXP_ACTION_258_.tb1_0(0);
EXP_ACTION_258_.old_tb1_1(0):='GE_EXEACTION_CT1E121401235'
;
EXP_ACTION_258_.tb1_1(0):=TO_CHAR(EXP_ACTION_258_.tb1_0(0));
EXP_ACTION_258_.tb1_2(0):=EXP_ACTION_258_.tb0_0(0);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (EXP_ACTION_258_.tb1_0(0),
EXP_ACTION_258_.tb1_1(0),
EXP_ACTION_258_.tb1_2(0),
'nuPackageIdAnulacion = MO_BOINSTANCE_DB.FNUGETPACKIDINSTANCE();nuPackageIdAnular = MO_BCDETALLEANULSOLICITUD.FNUGETANNULPACK(nuPackageIdAnulacion);if (nuPackageIdAnular <> null,nuNotas = FNUREQCHARGESCANCELL(nuPackageIdAnular);GE_BOINSTANCE.GETVALUE("MO_WF_PACK_INTERFAC","ACTIVITY_ID",sbInstance);WF_BOINSTANCE_ATTRIB.UPDINSATTVAL(sbInstance,442,nuNotas);,GE_BOINSTANCE.GETVALUE("MO_WF_PACK_INTERFAC","ACTIVITY_ID",sbInstance);WF_BOINSTANCE_ATTRIB.UPDINSATTVAL(sbInstance,442,0);)'
,
'CARLPARR'
,
to_date('15-05-2013 17:16:40','DD-MM-YYYY HH24:MI:SS'),
to_date('28-02-2024 08:47:38','DD-MM-YYYY HH24:MI:SS'),
to_date('28-02-2024 08:47:38','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Elimina Cargos'
,
'PP'
,
null);

exception when others then
EXP_ACTION_258_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_258_.blProcessStatus) then
 return;
end if;

EXP_ACTION_258_.tb2_0(0):=258;
EXP_ACTION_258_.tb2_2(0):=EXP_ACTION_258_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ACTION_MODULE fila (0)',1);
UPDATE GE_ACTION_MODULE SET ACTION_ID=EXP_ACTION_258_.tb2_0(0),
MODULE_ID=5,
CONFIG_EXPRESSION_ID=EXP_ACTION_258_.tb2_2(0),
DESCRIPTION='Creaci¿n de Notas'
,
EXE_AT_STATUS_CHANGE='N'
,
EXE_TRANSITION_STATE='N'

 WHERE ACTION_ID = EXP_ACTION_258_.tb2_0(0);
if not (sql%found) then
INSERT INTO GE_ACTION_MODULE(ACTION_ID,MODULE_ID,CONFIG_EXPRESSION_ID,DESCRIPTION,EXE_AT_STATUS_CHANGE,EXE_TRANSITION_STATE) 
VALUES (EXP_ACTION_258_.tb2_0(0),
5,
EXP_ACTION_258_.tb2_2(0),
'Creaci¿n de Notas'
,
'N'
,
'N'
);
end if;

exception when others then
EXP_ACTION_258_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_258_.blProcessStatus) then
 return;
end if;

EXP_ACTION_258_.tb3_0(0):=EXP_ACTION_258_.tb2_0(0);
EXP_ACTION_258_.tb3_1(0):=9;
ut_trace.trace('insertando tabla sin fallo: GE_VALID_ACTION_MODU fila (0)',1);
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (EXP_ACTION_258_.tb3_0(0),
EXP_ACTION_258_.tb3_1(0));

exception 
when dup_val_on_index then 
 return;
when others then
EXP_ACTION_258_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
DECLARE 
    nuBinaryIndex Binary_Integer;
BEGIN 
    nuBinaryIndex := EXP_ACTION_258_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = EXP_ACTION_258_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||EXP_ACTION_258_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||EXP_ACTION_258_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := EXP_ACTION_258_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       EXP_ACTION_258_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100248',1);
EXP_PROCESS_100248_.blProcessStatus := EXP_ACTION_258_.blProcessStatus ; 
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

if (not EXP_ACTION_258_.blProcessStatus) then
 return;
end if;
nuRowProcess:=EXP_ACTION_258_.tb1_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| EXP_ACTION_258_.tb1_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(EXP_ACTION_258_.tb1_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| EXP_ACTION_258_.tb1_0(nuRowProcess),1);
end;
nuRowProcess := EXP_ACTION_258_.tb1_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
EXP_ACTION_258_.blProcessStatus := false;
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
 nuIndex := EXP_ACTION_258_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_ACTION_258_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_ACTION_258_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_ACTION_258_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_ACTION_258_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_ACTION_258_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_ACTION_258_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_ACTION_258_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_ACTION_258_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_ACTION_258_******************************'); end;
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
        WHERE UNIT_TYPE_ID = 100248
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID IN 
           (SELECT UNIT_ID
           FROM WF_UNIT
           WHERE UNIT_TYPE_ID = 100248
       ))
;
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_PROCESS_100248_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100248) AND NODE_TYPE_ID=0);
BEGIN 

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_PROCESS_100248_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100248) AND NODE_TYPE_ID=0);
BEGIN 

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_PROCESS_100248_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100248) AND NODE_TYPE_ID=0;
nuIndex binary_integer;
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
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
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_PROCESS_100248_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_PROCESS_100248_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_PROCESS_100248_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_PROCESS_100248_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_PROCESS_100248_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_PROCESS_100248_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_PROCESS_100248_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_PROCESS_100248_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100248;
nuIndex binary_integer;
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
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
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb0_0(0):=3;
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_CATEGORY fila (0)',1);
UPDATE WF_UNIT_CATEGORY SET CATEGORY_ID=EXP_PROCESS_100248_.tb0_0(0),
DISPLAY_NUMBER='Proceso Principal'

 WHERE CATEGORY_ID = EXP_PROCESS_100248_.tb0_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_CATEGORY(CATEGORY_ID,DISPLAY_NUMBER) 
VALUES (EXP_PROCESS_100248_.tb0_0(0),
'Proceso Principal'
);
end if;

exception when others then
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb1_0(0):=9;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (0)',1);
UPDATE GE_MODULE SET MODULE_ID=EXP_PROCESS_100248_.tb1_0(0),
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

 WHERE MODULE_ID = EXP_PROCESS_100248_.tb1_0(0);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (EXP_PROCESS_100248_.tb1_0(0),
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
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb2_0(0):=100248;
EXP_PROCESS_100248_.tb2_1(0):=EXP_PROCESS_100248_.tb0_0(0);
EXP_PROCESS_100248_.tb2_2(0):=EXP_PROCESS_100248_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (0)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100248_.tb2_0(0),
CATEGORY_ID=EXP_PROCESS_100248_.tb2_1(0),
MODULE_ID=EXP_PROCESS_100248_.tb2_2(0),
ACTION_ID=null,
PARENT_ID=983,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_100248'
,
DESCRIPTION='LBC-Anulaci¿n de Solicitudes'
,
DISPLAY='LBC-Anulaci¿n de Solicitudes'
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100248_.tb2_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100248_.tb2_0(0),
EXP_PROCESS_100248_.tb2_1(0),
EXP_PROCESS_100248_.tb2_2(0),
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_100248'
,
'LBC-Anulaci¿n de Solicitudes'
,
'LBC-Anulaci¿n de Solicitudes'
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
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb3_0(0):=100122;
EXP_PROCESS_100248_.tb3_1(0):=EXP_PROCESS_100248_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_ATTRIBUTES_EQUIV fila (0)',1);
UPDATE WF_ATTRIBUTES_EQUIV SET ATTRIBUTES_EQUIV_ID=EXP_PROCESS_100248_.tb3_0(0),
UNIT_TYPE_ID=EXP_PROCESS_100248_.tb3_1(0),
INTERFACE_CONFIG_ID=21,
STD_TIME=0,
MAX_TIME=31536000,
AVG_TIME=0,
DESCRIPTION='Anulación de Solicitud'
,
VALUE_1='9'
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
 WHERE ATTRIBUTES_EQUIV_ID = EXP_PROCESS_100248_.tb3_0(0);
if not (sql%found) then
INSERT INTO WF_ATTRIBUTES_EQUIV(ATTRIBUTES_EQUIV_ID,UNIT_TYPE_ID,INTERFACE_CONFIG_ID,STD_TIME,MAX_TIME,AVG_TIME,DESCRIPTION,VALUE_1,VALUE_2,VALUE_3,VALUE_4,VALUE_5,VALUE_6,VALUE_7,VALUE_8,VALUE_9,VALUE_10,VALUE_11,VALUE_12,VALUE_13,VALUE_14,VALUE_15,VALUE_16,VALUE_17,VALUE_18,VALUE_19,VALUE_20) 
VALUES (EXP_PROCESS_100248_.tb3_0(0),
EXP_PROCESS_100248_.tb3_1(0),
21,
0,
31536000,
0,
'Anulación de Solicitud'
,
'9'
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
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb4_0(0):=0;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (0)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100248_.tb4_0(0),
DESCRIPTION='Ra¿z'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100248_.tb4_0(0);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100248_.tb4_0(0),
'Ra¿z'
);
end if;

exception when others then
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb5_0(0):=100939;
EXP_PROCESS_100248_.tb5_2(0):=EXP_PROCESS_100248_.tb2_0(0);
EXP_PROCESS_100248_.tb5_3(0):=EXP_PROCESS_100248_.tb4_0(0);
EXP_PROCESS_100248_.tb5_4(0):=EXP_PROCESS_100248_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (0)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100248_.tb5_0(0),
PROCESS_ID=null,
UNIT_TYPE_ID=EXP_PROCESS_100248_.tb5_2(0),
NODE_TYPE_ID=EXP_PROCESS_100248_.tb5_3(0),
MODULE_ID=EXP_PROCESS_100248_.tb5_4(0),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='25
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

 WHERE UNIT_ID = EXP_PROCESS_100248_.tb5_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100248_.tb5_0(0),
null,
EXP_PROCESS_100248_.tb5_2(0),
EXP_PROCESS_100248_.tb5_3(0),
EXP_PROCESS_100248_.tb5_4(0),
null,
null,
null,
null,
'25
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
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb0_0(1):=1;
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_CATEGORY fila (1)',1);
UPDATE WF_UNIT_CATEGORY SET CATEGORY_ID=EXP_PROCESS_100248_.tb0_0(1),
DISPLAY_NUMBER='Proceso B¿sico'

 WHERE CATEGORY_ID = EXP_PROCESS_100248_.tb0_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_CATEGORY(CATEGORY_ID,DISPLAY_NUMBER) 
VALUES (EXP_PROCESS_100248_.tb0_0(1),
'Proceso B¿sico'
);
end if;

exception when others then
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb2_0(1):=100237;
EXP_PROCESS_100248_.tb2_1(1):=EXP_PROCESS_100248_.tb0_0(1);
EXP_PROCESS_100248_.tb2_2(1):=EXP_PROCESS_100248_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (1)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100248_.tb2_0(1),
CATEGORY_ID=EXP_PROCESS_100248_.tb2_1(1),
MODULE_ID=EXP_PROCESS_100248_.tb2_2(1),
ACTION_ID=null,
PARENT_ID=100213,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_100237'
,
DESCRIPTION='Contratrabajos - Mediaci¿n'
,
DISPLAY='Contratrabajos - Mediaci¿n'
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100248_.tb2_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100248_.tb2_0(1),
EXP_PROCESS_100248_.tb2_1(1),
EXP_PROCESS_100248_.tb2_2(1),
null,
100213,
null,
null,
null,
null,
'UNIT_TYPE_100237'
,
'Contratrabajos - Mediaci¿n'
,
'Contratrabajos - Mediaci¿n'
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
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb4_0(1):=2;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (1)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100248_.tb4_0(1),
DESCRIPTION='Normal'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100248_.tb4_0(1);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100248_.tb4_0(1),
'Normal'
);
end if;

exception when others then
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb5_0(1):=100945;
EXP_PROCESS_100248_.tb5_1(1):=EXP_PROCESS_100248_.tb5_0(0);
EXP_PROCESS_100248_.tb5_2(1):=EXP_PROCESS_100248_.tb2_0(1);
EXP_PROCESS_100248_.tb5_3(1):=EXP_PROCESS_100248_.tb4_0(1);
EXP_PROCESS_100248_.tb5_4(1):=EXP_PROCESS_100248_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (1)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100248_.tb5_0(1),
PROCESS_ID=EXP_PROCESS_100248_.tb5_1(1),
UNIT_TYPE_ID=EXP_PROCESS_100248_.tb5_2(1),
NODE_TYPE_ID=EXP_PROCESS_100248_.tb5_3(1),
MODULE_ID=EXP_PROCESS_100248_.tb5_4(1),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='119
167'
,
DESCRIPTION='Contratrabajos - Mediaci¿n'
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

 WHERE UNIT_ID = EXP_PROCESS_100248_.tb5_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100248_.tb5_0(1),
EXP_PROCESS_100248_.tb5_1(1),
EXP_PROCESS_100248_.tb5_2(1),
EXP_PROCESS_100248_.tb5_3(1),
EXP_PROCESS_100248_.tb5_4(1),
null,
null,
null,
null,
'119
167'
,
'Contratrabajos - Mediaci¿n'
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
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb2_0(2):=100235;
EXP_PROCESS_100248_.tb2_1(2):=EXP_PROCESS_100248_.tb0_0(1);
EXP_PROCESS_100248_.tb2_2(2):=EXP_PROCESS_100248_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (2)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100248_.tb2_0(2),
CATEGORY_ID=EXP_PROCESS_100248_.tb2_1(2),
MODULE_ID=EXP_PROCESS_100248_.tb2_2(2),
ACTION_ID=null,
PARENT_ID=100213,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_100235'
,
DESCRIPTION='Contratrabajos - Acciones y Estados'
,
DISPLAY='Contratrabajos - Acciones y Estados'
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100248_.tb2_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100248_.tb2_0(2),
EXP_PROCESS_100248_.tb2_1(2),
EXP_PROCESS_100248_.tb2_2(2),
null,
100213,
null,
null,
null,
null,
'UNIT_TYPE_100235'
,
'Contratrabajos - Acciones y Estados'
,
'Contratrabajos - Acciones y Estados'
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
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb5_0(2):=100944;
EXP_PROCESS_100248_.tb5_1(2):=EXP_PROCESS_100248_.tb5_0(0);
EXP_PROCESS_100248_.tb5_2(2):=EXP_PROCESS_100248_.tb2_0(2);
EXP_PROCESS_100248_.tb5_3(2):=EXP_PROCESS_100248_.tb4_0(1);
EXP_PROCESS_100248_.tb5_4(2):=EXP_PROCESS_100248_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (2)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100248_.tb5_0(2),
PROCESS_ID=EXP_PROCESS_100248_.tb5_1(2),
UNIT_TYPE_ID=EXP_PROCESS_100248_.tb5_2(2),
NODE_TYPE_ID=EXP_PROCESS_100248_.tb5_3(2),
MODULE_ID=EXP_PROCESS_100248_.tb5_4(2),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='119
282'
,
DESCRIPTION='Contratrabajos - Acciones y Estados'
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

 WHERE UNIT_ID = EXP_PROCESS_100248_.tb5_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100248_.tb5_0(2),
EXP_PROCESS_100248_.tb5_1(2),
EXP_PROCESS_100248_.tb5_2(2),
EXP_PROCESS_100248_.tb5_3(2),
EXP_PROCESS_100248_.tb5_4(2),
null,
null,
null,
null,
'119
282'
,
'Contratrabajos - Acciones y Estados'
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
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb6_0(0):=118951;
EXP_PROCESS_100248_.tb6_1(0):=EXP_PROCESS_100248_.tb5_0(1);
EXP_PROCESS_100248_.tb6_2(0):=EXP_PROCESS_100248_.tb5_0(2);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (0)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100248_.tb6_0(0),
ORIGIN_ID=EXP_PROCESS_100248_.tb6_1(0),
TARGET_ID=EXP_PROCESS_100248_.tb6_2(0),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION='STATUS_ID == ESTADO_FINALIZADO'
,
EXPRESSION_TYPE=0,
DESCRIPTION=null,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100248_.tb6_0(0);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100248_.tb6_0(0),
EXP_PROCESS_100248_.tb6_1(0),
EXP_PROCESS_100248_.tb6_2(0),
null,
0,
'STATUS_ID == ESTADO_FINALIZADO'
,
0,
null,
1);
end if;

exception when others then
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb0_0(2):=2;
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_CATEGORY fila (2)',1);
UPDATE WF_UNIT_CATEGORY SET CATEGORY_ID=EXP_PROCESS_100248_.tb0_0(2),
DISPLAY_NUMBER='Actividad'

 WHERE CATEGORY_ID = EXP_PROCESS_100248_.tb0_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT_CATEGORY(CATEGORY_ID,DISPLAY_NUMBER) 
VALUES (EXP_PROCESS_100248_.tb0_0(2),
'Actividad'
);
end if;

exception when others then
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb2_0(3):=283;
EXP_PROCESS_100248_.tb2_1(3):=EXP_PROCESS_100248_.tb0_0(2);
EXP_PROCESS_100248_.tb2_2(3):=EXP_PROCESS_100248_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (3)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100248_.tb2_0(3),
CATEGORY_ID=EXP_PROCESS_100248_.tb2_1(3),
MODULE_ID=EXP_PROCESS_100248_.tb2_2(3),
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100248_.tb2_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100248_.tb2_0(3),
EXP_PROCESS_100248_.tb2_1(3),
EXP_PROCESS_100248_.tb2_2(3),
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
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb4_0(2):=1;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (2)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100248_.tb4_0(2),
DESCRIPTION='Arranque'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100248_.tb4_0(2);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100248_.tb4_0(2),
'Arranque'
);
end if;

exception when others then
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb5_0(3):=100940;
EXP_PROCESS_100248_.tb5_1(3):=EXP_PROCESS_100248_.tb5_0(0);
EXP_PROCESS_100248_.tb5_2(3):=EXP_PROCESS_100248_.tb2_0(3);
EXP_PROCESS_100248_.tb5_3(3):=EXP_PROCESS_100248_.tb4_0(2);
EXP_PROCESS_100248_.tb5_4(3):=EXP_PROCESS_100248_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (3)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100248_.tb5_0(3),
PROCESS_ID=EXP_PROCESS_100248_.tb5_1(3),
UNIT_TYPE_ID=EXP_PROCESS_100248_.tb5_2(3),
NODE_TYPE_ID=EXP_PROCESS_100248_.tb5_3(3),
MODULE_ID=EXP_PROCESS_100248_.tb5_4(3),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='0
174'
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

 WHERE UNIT_ID = EXP_PROCESS_100248_.tb5_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100248_.tb5_0(3),
EXP_PROCESS_100248_.tb5_1(3),
EXP_PROCESS_100248_.tb5_2(3),
EXP_PROCESS_100248_.tb5_3(3),
EXP_PROCESS_100248_.tb5_4(3),
null,
null,
null,
null,
'0
174'
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
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb6_0(1):=118950;
EXP_PROCESS_100248_.tb6_1(1):=EXP_PROCESS_100248_.tb5_0(3);
EXP_PROCESS_100248_.tb6_2(1):=EXP_PROCESS_100248_.tb5_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (1)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100248_.tb6_0(1),
ORIGIN_ID=EXP_PROCESS_100248_.tb6_1(1),
TARGET_ID=EXP_PROCESS_100248_.tb6_2(1),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION=null,
EXPRESSION_TYPE=0,
DESCRIPTION=null,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100248_.tb6_0(1);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100248_.tb6_0(1),
EXP_PROCESS_100248_.tb6_1(1),
EXP_PROCESS_100248_.tb6_2(1),
null,
0,
null,
0,
null,
1);
end if;

exception when others then
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb1_0(1):=5;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (1)',1);
UPDATE GE_MODULE SET MODULE_ID=EXP_PROCESS_100248_.tb1_0(1),
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

 WHERE MODULE_ID = EXP_PROCESS_100248_.tb1_0(1);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (EXP_PROCESS_100248_.tb1_0(1),
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
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb7_0(0):=16;
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=EXP_PROCESS_100248_.tb7_0(0),
MODULE_ID=9,
DESCRIPTION='Reglas de Procesos Administrativos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='WF_AD_PRO_RULE'

 WHERE CONFIGURA_TYPE_ID = EXP_PROCESS_100248_.tb7_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (EXP_PROCESS_100248_.tb7_0(0),
9,
'Reglas de Procesos Administrativos'
,
'PL'
,
'FD'
,
'DS'
,
'WF_AD_PRO_RULE'
);
end if;

exception when others then
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.old_tb8_0(0):=121401236;
EXP_PROCESS_100248_.tb8_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
EXP_PROCESS_100248_.tb8_0(0):=EXP_PROCESS_100248_.tb8_0(0);
EXP_PROCESS_100248_.old_tb8_1(0):='WFWF_AD_PRO_RULECT16E121401236'
;
EXP_PROCESS_100248_.tb8_1(0):=TO_CHAR(EXP_PROCESS_100248_.tb8_0(0));
EXP_PROCESS_100248_.tb8_2(0):=EXP_PROCESS_100248_.tb7_0(0);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (EXP_PROCESS_100248_.tb8_0(0),
EXP_PROCESS_100248_.tb8_1(0),
EXP_PROCESS_100248_.tb8_2(0),
'
nuPackageIdAnulacion = CC_BOADMINISTRATIVEPROCESS.FNUGETEXTERNALID();nuPackageIdAnular = MO_BCDETALLEANULSOLICITUD.FNUGETANNULPACK(nuPackageIdAnulacion);nuCategoryId = MO_BOPACKAGES.FNUGETCATEGORYID(nuPackageIdAnular);if (nuCategoryId = NULL,nuCategoryId = -1;,);nuPackId = LDC_BOUTILITIES.FNUGETTIPOPACK(nuPackageIdAnular);AreaAsignada = LDC_BOORDENES.FNUGETAREAORGANIZAT(nuPackId, nuCategoryId, nuPackageIdAnulacion)'
,
'LBTEST'
,
to_date('09-09-2010 18:08:31','DD-MM-YYYY HH24:MI:SS'),
to_date('28-02-2024 08:49:51','DD-MM-YYYY HH24:MI:SS'),
to_date('28-02-2024 08:49:51','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC - Obtiene Area Por Defecto'
,
'PF'
,
null);

exception when others then
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb9_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_COMMENT_CLASS fila (0)',1);
UPDATE GE_COMMENT_CLASS SET COMMENT_CLASS_ID=EXP_PROCESS_100248_.tb9_0(0),
DESCRIPTION='OBSERVACIONES PARA UNA ORDEN'

 WHERE COMMENT_CLASS_ID = EXP_PROCESS_100248_.tb9_0(0);
if not (sql%found) then
INSERT INTO GE_COMMENT_CLASS(COMMENT_CLASS_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100248_.tb9_0(0),
'OBSERVACIONES PARA UNA ORDEN'
);
end if;

exception when others then
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb2_0(4):=100247;
EXP_PROCESS_100248_.tb2_1(4):=EXP_PROCESS_100248_.tb0_0(2);
EXP_PROCESS_100248_.tb2_2(4):=EXP_PROCESS_100248_.tb1_0(1);
EXP_PROCESS_100248_.tb2_5(4):=EXP_PROCESS_100248_.tb8_0(0);
EXP_PROCESS_100248_.tb2_6(4):=EXP_PROCESS_100248_.tb9_0(0);
EXP_PROCESS_100248_.tb2_7(4):=EXP_PROCESS_100248_.tb9_0(0);
EXP_PROCESS_100248_.tb2_8(4):=EXP_PROCESS_100248_.tb9_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (4)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100248_.tb2_0(4),
CATEGORY_ID=EXP_PROCESS_100248_.tb2_1(4),
MODULE_ID=EXP_PROCESS_100248_.tb2_2(4),
ACTION_ID=null,
PARENT_ID=100213,
INIT_AREA_EXPRESSION_ID=EXP_PROCESS_100248_.tb2_5(4),
ASSIGN_COMMENT_CLASS=EXP_PROCESS_100248_.tb2_6(4),
ATTEND_COMMENT_CLASS=EXP_PROCESS_100248_.tb2_7(4),
UNASSIGN_COMMENT_CLASS=EXP_PROCESS_100248_.tb2_8(4),
TAG_NAME='UNIT_TYPE_100247'
,
DESCRIPTION='Actividad de revisi¿n por anulaci¿n'
,
DISPLAY='Actividad de revisi¿n por anulaci¿n'
,
ICON=null,
IS_STAGE_PROCESS='N'
,
USABLE_IN_FLOW_STAGE='N'
,
ENTITY_ID=17,
MULTI_INSTANCE='C'
,
IS_COUNTABLE='N'
,
NOTIFICATION_ID=9000,
VIEWABLE='N'
,
DEFAULT_PRIORITY_ID=-1,
INITIAL_NOTIFY_TIME=0,
IS_ADMIN_PROCESS='Y'
,
ASSIGN_NOTIFICATION_ID=null,
ASSIGNED_USER_ONLY='N'

 WHERE UNIT_TYPE_ID = EXP_PROCESS_100248_.tb2_0(4);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100248_.tb2_0(4),
EXP_PROCESS_100248_.tb2_1(4),
EXP_PROCESS_100248_.tb2_2(4),
null,
100213,
EXP_PROCESS_100248_.tb2_5(4),
EXP_PROCESS_100248_.tb2_6(4),
EXP_PROCESS_100248_.tb2_7(4),
EXP_PROCESS_100248_.tb2_8(4),
'UNIT_TYPE_100247'
,
'Actividad de revisi¿n por anulaci¿n'
,
'Actividad de revisi¿n por anulaci¿n'
,
null,
'N'
,
'N'
,
17,
'C'
,
'N'
,
9000,
'N'
,
-1,
0,
'Y'
,
null,
'N'
);
end if;

exception when others then
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb5_0(4):=100942;
EXP_PROCESS_100248_.tb5_1(4):=EXP_PROCESS_100248_.tb5_0(0);
EXP_PROCESS_100248_.tb5_2(4):=EXP_PROCESS_100248_.tb2_0(4);
EXP_PROCESS_100248_.tb5_3(4):=EXP_PROCESS_100248_.tb4_0(1);
EXP_PROCESS_100248_.tb5_4(4):=EXP_PROCESS_100248_.tb1_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (4)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100248_.tb5_0(4),
PROCESS_ID=EXP_PROCESS_100248_.tb5_1(4),
UNIT_TYPE_ID=EXP_PROCESS_100248_.tb5_2(4),
NODE_TYPE_ID=EXP_PROCESS_100248_.tb5_3(4),
MODULE_ID=EXP_PROCESS_100248_.tb5_4(4),
ACTION_ID=343,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='296
282'
,
DESCRIPTION='Actividad de revisi¿n por anulaci¿n'
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

 WHERE UNIT_ID = EXP_PROCESS_100248_.tb5_0(4);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100248_.tb5_0(4),
EXP_PROCESS_100248_.tb5_1(4),
EXP_PROCESS_100248_.tb5_2(4),
EXP_PROCESS_100248_.tb5_3(4),
EXP_PROCESS_100248_.tb5_4(4),
343,
null,
null,
null,
'296
282'
,
'Actividad de revisi¿n por anulaci¿n'
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
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb6_0(2):=118952;
EXP_PROCESS_100248_.tb6_1(2):=EXP_PROCESS_100248_.tb5_0(2);
EXP_PROCESS_100248_.tb6_2(2):=EXP_PROCESS_100248_.tb5_0(4);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (2)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100248_.tb6_0(2),
ORIGIN_ID=EXP_PROCESS_100248_.tb6_1(2),
TARGET_ID=EXP_PROCESS_100248_.tb6_2(2),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION=null,
EXPRESSION_TYPE=0,
DESCRIPTION=null,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100248_.tb6_0(2);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100248_.tb6_0(2),
EXP_PROCESS_100248_.tb6_1(2),
EXP_PROCESS_100248_.tb6_2(2),
null,
0,
null,
0,
null,
1);
end if;

exception when others then
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb10_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTE_CLASS fila (0)',1);
UPDATE GE_ATTRIBUTE_CLASS SET ATTRIBUTE_CLASS_ID=EXP_PROCESS_100248_.tb10_0(0),
NAME='De Entitdad'
,
DESCRIPTION='Valores que ser¿n tra¿dos de la tabla base usando old record'

 WHERE ATTRIBUTE_CLASS_ID = EXP_PROCESS_100248_.tb10_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTE_CLASS(ATTRIBUTE_CLASS_ID,NAME,DESCRIPTION) 
VALUES (EXP_PROCESS_100248_.tb10_0(0),
'De Entitdad'
,
'Valores que ser¿n tra¿dos de la tabla base usando old record'
);
end if;

exception when others then
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb11_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES_TYPE fila (0)',1);
UPDATE GE_ATTRIBUTES_TYPE SET ATTRIBUTE_TYPE_ID=EXP_PROCESS_100248_.tb11_0(0),
DESCRIPTION='NUMBER'
,
INTERNAL_TYPE=2,
INTERNAL_JAVA_TYPE=2
 WHERE ATTRIBUTE_TYPE_ID = EXP_PROCESS_100248_.tb11_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES_TYPE(ATTRIBUTE_TYPE_ID,DESCRIPTION,INTERNAL_TYPE,INTERNAL_JAVA_TYPE) 
VALUES (EXP_PROCESS_100248_.tb11_0(0),
'NUMBER'
,
2,
2);
end if;

exception when others then
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb12_0(0):=400;
EXP_PROCESS_100248_.tb12_1(0):=EXP_PROCESS_100248_.tb10_0(0);
EXP_PROCESS_100248_.tb12_2(0):=EXP_PROCESS_100248_.tb11_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (0)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=EXP_PROCESS_100248_.tb12_0(0),
ATTRIBUTE_CLASS_ID=EXP_PROCESS_100248_.tb12_1(0),
ATTRIBUTE_TYPE_ID=EXP_PROCESS_100248_.tb12_2(0),
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

 WHERE ATTRIBUTE_ID = EXP_PROCESS_100248_.tb12_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,ATTRIBUTE_CLASS_ID,ATTRIBUTE_TYPE_ID,VALID_EXPRESSION,FATHER_ID,MODULE_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (EXP_PROCESS_100248_.tb12_0(0),
EXP_PROCESS_100248_.tb12_1(0),
EXP_PROCESS_100248_.tb12_2(0),
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
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb13_0(0):=126449;
EXP_PROCESS_100248_.tb13_1(0):=EXP_PROCESS_100248_.tb5_0(3);
EXP_PROCESS_100248_.tb13_2(0):=EXP_PROCESS_100248_.tb12_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (0)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100248_.tb13_0(0),
UNIT_ID=EXP_PROCESS_100248_.tb13_1(0),
ATTRIBUTE_ID=EXP_PROCESS_100248_.tb13_2(0),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=1,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100248_.tb13_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100248_.tb13_0(0),
EXP_PROCESS_100248_.tb13_1(0),
EXP_PROCESS_100248_.tb13_2(0),
null,
null,
'N'
,
1,
'N'
);
end if;

exception when others then
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb2_0(5):=319;
EXP_PROCESS_100248_.tb2_1(5):=EXP_PROCESS_100248_.tb0_0(2);
EXP_PROCESS_100248_.tb2_2(5):=EXP_PROCESS_100248_.tb1_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (5)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100248_.tb2_0(5),
CATEGORY_ID=EXP_PROCESS_100248_.tb2_1(5),
MODULE_ID=EXP_PROCESS_100248_.tb2_2(5),
ACTION_ID=null,
PARENT_ID=983,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_319'
,
DESCRIPTION='Crear Nota'
,
DISPLAY='Crear Nota'
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100248_.tb2_0(5);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100248_.tb2_0(5),
EXP_PROCESS_100248_.tb2_1(5),
EXP_PROCESS_100248_.tb2_2(5),
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_319'
,
'Crear Nota'
,
'Crear Nota'
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
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb5_0(5):=622;
EXP_PROCESS_100248_.tb5_1(5):=EXP_PROCESS_100248_.tb5_0(0);
EXP_PROCESS_100248_.tb5_2(5):=EXP_PROCESS_100248_.tb2_0(5);
EXP_PROCESS_100248_.tb5_3(5):=EXP_PROCESS_100248_.tb4_0(1);
EXP_PROCESS_100248_.tb5_4(5):=EXP_PROCESS_100248_.tb1_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (5)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100248_.tb5_0(5),
PROCESS_ID=EXP_PROCESS_100248_.tb5_1(5),
UNIT_TYPE_ID=EXP_PROCESS_100248_.tb5_2(5),
NODE_TYPE_ID=EXP_PROCESS_100248_.tb5_3(5),
MODULE_ID=EXP_PROCESS_100248_.tb5_4(5),
ACTION_ID=258,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=9000,
GEOMETRY='299
172'
,
DESCRIPTION='Crear Nota'
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

 WHERE UNIT_ID = EXP_PROCESS_100248_.tb5_0(5);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100248_.tb5_0(5),
EXP_PROCESS_100248_.tb5_1(5),
EXP_PROCESS_100248_.tb5_2(5),
EXP_PROCESS_100248_.tb5_3(5),
EXP_PROCESS_100248_.tb5_4(5),
258,
null,
null,
9000,
'299
172'
,
'Crear Nota'
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
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb6_0(3):=123921;
EXP_PROCESS_100248_.tb6_1(3):=EXP_PROCESS_100248_.tb5_0(4);
EXP_PROCESS_100248_.tb6_2(3):=EXP_PROCESS_100248_.tb5_0(5);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (3)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100248_.tb6_0(3),
ORIGIN_ID=EXP_PROCESS_100248_.tb6_1(3),
TARGET_ID=EXP_PROCESS_100248_.tb6_2(3),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION=null,
EXPRESSION_TYPE=0,
DESCRIPTION=null,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100248_.tb6_0(3);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100248_.tb6_0(3),
EXP_PROCESS_100248_.tb6_1(3),
EXP_PROCESS_100248_.tb6_2(3),
null,
0,
null,
0,
null,
1);
end if;

exception when others then
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb13_0(1):=126455;
EXP_PROCESS_100248_.tb13_1(1):=EXP_PROCESS_100248_.tb5_0(4);
EXP_PROCESS_100248_.tb13_2(1):=EXP_PROCESS_100248_.tb12_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (1)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100248_.tb13_0(1),
UNIT_ID=EXP_PROCESS_100248_.tb13_1(1),
ATTRIBUTE_ID=EXP_PROCESS_100248_.tb13_2(1),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=1,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100248_.tb13_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100248_.tb13_0(1),
EXP_PROCESS_100248_.tb13_1(1),
EXP_PROCESS_100248_.tb13_2(1),
null,
null,
'N'
,
1,
'N'
);
end if;

exception when others then
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb2_0(6):=100232;
EXP_PROCESS_100248_.tb2_1(6):=EXP_PROCESS_100248_.tb0_0(1);
EXP_PROCESS_100248_.tb2_2(6):=EXP_PROCESS_100248_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (6)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100248_.tb2_0(6),
CATEGORY_ID=EXP_PROCESS_100248_.tb2_1(6),
MODULE_ID=EXP_PROCESS_100248_.tb2_2(6),
ACTION_ID=null,
PARENT_ID=100213,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_100232'
,
DESCRIPTION='Contratrabajos - Asignaci¿n'
,
DISPLAY='Contratrabajos - Asignaci¿n'
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100248_.tb2_0(6);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100248_.tb2_0(6),
EXP_PROCESS_100248_.tb2_1(6),
EXP_PROCESS_100248_.tb2_2(6),
null,
100213,
null,
null,
null,
null,
'UNIT_TYPE_100232'
,
'Contratrabajos - Asignaci¿n'
,
'Contratrabajos - Asignaci¿n'
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
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb5_0(6):=100943;
EXP_PROCESS_100248_.tb5_1(6):=EXP_PROCESS_100248_.tb5_0(0);
EXP_PROCESS_100248_.tb5_2(6):=EXP_PROCESS_100248_.tb2_0(6);
EXP_PROCESS_100248_.tb5_3(6):=EXP_PROCESS_100248_.tb4_0(1);
EXP_PROCESS_100248_.tb5_4(6):=EXP_PROCESS_100248_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (6)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100248_.tb5_0(6),
PROCESS_ID=EXP_PROCESS_100248_.tb5_1(6),
UNIT_TYPE_ID=EXP_PROCESS_100248_.tb5_2(6),
NODE_TYPE_ID=EXP_PROCESS_100248_.tb5_3(6),
MODULE_ID=EXP_PROCESS_100248_.tb5_4(6),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='460
167'
,
DESCRIPTION='Contratrabajos - Asignaci¿n'
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

 WHERE UNIT_ID = EXP_PROCESS_100248_.tb5_0(6);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100248_.tb5_0(6),
EXP_PROCESS_100248_.tb5_1(6),
EXP_PROCESS_100248_.tb5_2(6),
EXP_PROCESS_100248_.tb5_3(6),
EXP_PROCESS_100248_.tb5_4(6),
null,
null,
null,
null,
'460
167'
,
'Contratrabajos - Asignaci¿n'
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
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb6_0(4):=123924;
EXP_PROCESS_100248_.tb6_1(4):=EXP_PROCESS_100248_.tb5_0(5);
EXP_PROCESS_100248_.tb6_2(4):=EXP_PROCESS_100248_.tb5_0(6);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (4)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100248_.tb6_0(4),
ORIGIN_ID=EXP_PROCESS_100248_.tb6_1(4),
TARGET_ID=EXP_PROCESS_100248_.tb6_2(4),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION='FLAG_VALIDATE == 0'
,
EXPRESSION_TYPE=0,
DESCRIPTION='¿xito '
,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100248_.tb6_0(4);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100248_.tb6_0(4),
EXP_PROCESS_100248_.tb6_1(4),
EXP_PROCESS_100248_.tb6_2(4),
null,
0,
'FLAG_VALIDATE == 0'
,
0,
'¿xito '
,
1);
end if;

exception when others then
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.old_tb8_0(1):=121401237;
EXP_PROCESS_100248_.tb8_0(1):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
EXP_PROCESS_100248_.tb8_0(1):=EXP_PROCESS_100248_.tb8_0(1);
EXP_PROCESS_100248_.old_tb8_1(1):='WFWF_AD_PRO_RULECT16E121401237'
;
EXP_PROCESS_100248_.tb8_1(1):=TO_CHAR(EXP_PROCESS_100248_.tb8_0(1));
EXP_PROCESS_100248_.tb8_2(1):=EXP_PROCESS_100248_.tb7_0(0);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (1)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (EXP_PROCESS_100248_.tb8_0(1),
EXP_PROCESS_100248_.tb8_1(1),
EXP_PROCESS_100248_.tb8_2(1),
'
nuPackageIdAnulacion = CC_BOADMINISTRATIVEPROCESS.FNUGETEXTERNALID();nuPackageIdAnular = MO_BCDETALLEANULSOLICITUD.FNUGETANNULPACK(nuPackageIdAnulacion);nuCategoryId = MO_BOPACKAGES.FNUGETCATEGORYID(nuPackageIdAnular);if (nuCategoryId = NULL,nuCategoryId = -1;,);nuPackId = LDC_BOUTILITIES.FNUGETTIPOPACK(nuPackageIdAnular);AreaAsignada = LDC_BOORDENES.FNUGETAREAORGANIZAT(nuPackId, nuCategoryId, nuPackageIdAnulacion)'
,
'LBTEST'
,
to_date('27-08-2012 13:07:55','DD-MM-YYYY HH24:MI:SS'),
to_date('28-02-2024 08:49:51','DD-MM-YYYY HH24:MI:SS'),
to_date('28-02-2024 08:49:51','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Obtiene Area Por Defecto'
,
'PF'
,
null);

exception when others then
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb2_0(7):=320;
EXP_PROCESS_100248_.tb2_1(7):=EXP_PROCESS_100248_.tb0_0(2);
EXP_PROCESS_100248_.tb2_2(7):=EXP_PROCESS_100248_.tb1_0(1);
EXP_PROCESS_100248_.tb2_5(7):=EXP_PROCESS_100248_.tb8_0(1);
EXP_PROCESS_100248_.tb2_6(7):=EXP_PROCESS_100248_.tb9_0(0);
EXP_PROCESS_100248_.tb2_7(7):=EXP_PROCESS_100248_.tb9_0(0);
EXP_PROCESS_100248_.tb2_8(7):=EXP_PROCESS_100248_.tb9_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (7)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100248_.tb2_0(7),
CATEGORY_ID=EXP_PROCESS_100248_.tb2_1(7),
MODULE_ID=EXP_PROCESS_100248_.tb2_2(7),
ACTION_ID=null,
PARENT_ID=983,
INIT_AREA_EXPRESSION_ID=EXP_PROCESS_100248_.tb2_5(7),
ASSIGN_COMMENT_CLASS=EXP_PROCESS_100248_.tb2_6(7),
ATTEND_COMMENT_CLASS=EXP_PROCESS_100248_.tb2_7(7),
UNASSIGN_COMMENT_CLASS=EXP_PROCESS_100248_.tb2_8(7),
TAG_NAME='UNIT_TYPE_320'
,
DESCRIPTION='Crear Nota Manual'
,
DISPLAY='Crear Nota Manual'
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
DEFAULT_PRIORITY_ID=-1,
INITIAL_NOTIFY_TIME=0,
IS_ADMIN_PROCESS='Y'
,
ASSIGN_NOTIFICATION_ID=null,
ASSIGNED_USER_ONLY='N'

 WHERE UNIT_TYPE_ID = EXP_PROCESS_100248_.tb2_0(7);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100248_.tb2_0(7),
EXP_PROCESS_100248_.tb2_1(7),
EXP_PROCESS_100248_.tb2_2(7),
null,
983,
EXP_PROCESS_100248_.tb2_5(7),
EXP_PROCESS_100248_.tb2_6(7),
EXP_PROCESS_100248_.tb2_7(7),
EXP_PROCESS_100248_.tb2_8(7),
'UNIT_TYPE_320'
,
'Crear Nota Manual'
,
'Crear Nota Manual'
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
-1,
0,
'Y'
,
null,
'N'
);
end if;

exception when others then
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb5_0(7):=623;
EXP_PROCESS_100248_.tb5_1(7):=EXP_PROCESS_100248_.tb5_0(0);
EXP_PROCESS_100248_.tb5_2(7):=EXP_PROCESS_100248_.tb2_0(7);
EXP_PROCESS_100248_.tb5_3(7):=EXP_PROCESS_100248_.tb4_0(1);
EXP_PROCESS_100248_.tb5_4(7):=EXP_PROCESS_100248_.tb1_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (7)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100248_.tb5_0(7),
PROCESS_ID=EXP_PROCESS_100248_.tb5_1(7),
UNIT_TYPE_ID=EXP_PROCESS_100248_.tb5_2(7),
NODE_TYPE_ID=EXP_PROCESS_100248_.tb5_3(7),
MODULE_ID=EXP_PROCESS_100248_.tb5_4(7),
ACTION_ID=343,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='479
286'
,
DESCRIPTION='Crear Nota Manual'
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

 WHERE UNIT_ID = EXP_PROCESS_100248_.tb5_0(7);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100248_.tb5_0(7),
EXP_PROCESS_100248_.tb5_1(7),
EXP_PROCESS_100248_.tb5_2(7),
EXP_PROCESS_100248_.tb5_3(7),
EXP_PROCESS_100248_.tb5_4(7),
343,
null,
null,
null,
'479
286'
,
'Crear Nota Manual'
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
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb6_0(5):=123922;
EXP_PROCESS_100248_.tb6_1(5):=EXP_PROCESS_100248_.tb5_0(5);
EXP_PROCESS_100248_.tb6_2(5):=EXP_PROCESS_100248_.tb5_0(7);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (5)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100248_.tb6_0(5),
ORIGIN_ID=EXP_PROCESS_100248_.tb6_1(5),
TARGET_ID=EXP_PROCESS_100248_.tb6_2(5),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION='FLAG_VALIDATE == 1'
,
EXPRESSION_TYPE=0,
DESCRIPTION='Fallo'
,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100248_.tb6_0(5);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100248_.tb6_0(5),
EXP_PROCESS_100248_.tb6_1(5),
EXP_PROCESS_100248_.tb6_2(5),
null,
0,
'FLAG_VALIDATE == 1'
,
0,
'Fallo'
,
1);
end if;

exception when others then
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb13_0(2):=133675;
EXP_PROCESS_100248_.tb13_1(2):=EXP_PROCESS_100248_.tb5_0(5);
EXP_PROCESS_100248_.tb13_2(2):=EXP_PROCESS_100248_.tb12_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (2)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100248_.tb13_0(2),
UNIT_ID=EXP_PROCESS_100248_.tb13_1(2),
ATTRIBUTE_ID=EXP_PROCESS_100248_.tb13_2(2),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='Y'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100248_.tb13_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100248_.tb13_0(2),
EXP_PROCESS_100248_.tb13_1(2),
EXP_PROCESS_100248_.tb13_2(2),
null,
null,
'N'
,
2,
'Y'
);
end if;

exception when others then
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb10_0(1):=8;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTE_CLASS fila (1)',1);
UPDATE GE_ATTRIBUTE_CLASS SET ATTRIBUTE_CLASS_ID=EXP_PROCESS_100248_.tb10_0(1),
NAME='Por Defecto General'
,
DESCRIPTION='Valores que ser¿n utilizados para clasificaci¿n gen¿rica'

 WHERE ATTRIBUTE_CLASS_ID = EXP_PROCESS_100248_.tb10_0(1);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTE_CLASS(ATTRIBUTE_CLASS_ID,NAME,DESCRIPTION) 
VALUES (EXP_PROCESS_100248_.tb10_0(1),
'Por Defecto General'
,
'Valores que ser¿n utilizados para clasificaci¿n gen¿rica'
);
end if;

exception when others then
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb12_0(1):=442;
EXP_PROCESS_100248_.tb12_1(1):=EXP_PROCESS_100248_.tb10_0(1);
EXP_PROCESS_100248_.tb12_2(1):=EXP_PROCESS_100248_.tb11_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (1)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=EXP_PROCESS_100248_.tb12_0(1),
ATTRIBUTE_CLASS_ID=EXP_PROCESS_100248_.tb12_1(1),
ATTRIBUTE_TYPE_ID=EXP_PROCESS_100248_.tb12_2(1),
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

 WHERE ATTRIBUTE_ID = EXP_PROCESS_100248_.tb12_0(1);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,ATTRIBUTE_CLASS_ID,ATTRIBUTE_TYPE_ID,VALID_EXPRESSION,FATHER_ID,MODULE_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (EXP_PROCESS_100248_.tb12_0(1),
EXP_PROCESS_100248_.tb12_1(1),
EXP_PROCESS_100248_.tb12_2(1),
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
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb13_0(3):=100000591;
EXP_PROCESS_100248_.tb13_1(3):=EXP_PROCESS_100248_.tb5_0(5);
EXP_PROCESS_100248_.tb13_2(3):=EXP_PROCESS_100248_.tb12_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (3)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100248_.tb13_0(3),
UNIT_ID=EXP_PROCESS_100248_.tb13_1(3),
ATTRIBUTE_ID=EXP_PROCESS_100248_.tb13_2(3),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='Y'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100248_.tb13_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100248_.tb13_0(3),
EXP_PROCESS_100248_.tb13_1(3),
EXP_PROCESS_100248_.tb13_2(3),
null,
null,
'N'
,
2,
'Y'
);
end if;

exception when others then
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb2_0(8):=100241;
EXP_PROCESS_100248_.tb2_1(8):=EXP_PROCESS_100248_.tb0_0(1);
EXP_PROCESS_100248_.tb2_2(8):=EXP_PROCESS_100248_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (8)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100248_.tb2_0(8),
CATEGORY_ID=EXP_PROCESS_100248_.tb2_1(8),
MODULE_ID=EXP_PROCESS_100248_.tb2_2(8),
ACTION_ID=null,
PARENT_ID=100213,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_100241'
,
DESCRIPTION='Atenci¿n de la Anulaci¿n'
,
DISPLAY='Atenci¿n de la Anulaci¿n'
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100248_.tb2_0(8);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100248_.tb2_0(8),
EXP_PROCESS_100248_.tb2_1(8),
EXP_PROCESS_100248_.tb2_2(8),
null,
100213,
null,
null,
null,
null,
'UNIT_TYPE_100241'
,
'Atenci¿n de la Anulaci¿n'
,
'Atenci¿n de la Anulaci¿n'
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
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb5_0(8):=100946;
EXP_PROCESS_100248_.tb5_1(8):=EXP_PROCESS_100248_.tb5_0(0);
EXP_PROCESS_100248_.tb5_2(8):=EXP_PROCESS_100248_.tb2_0(8);
EXP_PROCESS_100248_.tb5_3(8):=EXP_PROCESS_100248_.tb4_0(1);
EXP_PROCESS_100248_.tb5_4(8):=EXP_PROCESS_100248_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (8)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100248_.tb5_0(8),
PROCESS_ID=EXP_PROCESS_100248_.tb5_1(8),
UNIT_TYPE_ID=EXP_PROCESS_100248_.tb5_2(8),
NODE_TYPE_ID=EXP_PROCESS_100248_.tb5_3(8),
MODULE_ID=EXP_PROCESS_100248_.tb5_4(8),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='637
167'
,
DESCRIPTION='Atenci¿n de la Anulaci¿n'
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

 WHERE UNIT_ID = EXP_PROCESS_100248_.tb5_0(8);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100248_.tb5_0(8),
EXP_PROCESS_100248_.tb5_1(8),
EXP_PROCESS_100248_.tb5_2(8),
EXP_PROCESS_100248_.tb5_3(8),
EXP_PROCESS_100248_.tb5_4(8),
null,
null,
null,
null,
'637
167'
,
'Atenci¿n de la Anulaci¿n'
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
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb6_0(6):=118948;
EXP_PROCESS_100248_.tb6_1(6):=EXP_PROCESS_100248_.tb5_0(6);
EXP_PROCESS_100248_.tb6_2(6):=EXP_PROCESS_100248_.tb5_0(8);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (6)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100248_.tb6_0(6),
ORIGIN_ID=EXP_PROCESS_100248_.tb6_1(6),
TARGET_ID=EXP_PROCESS_100248_.tb6_2(6),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION=null,
EXPRESSION_TYPE=0,
DESCRIPTION=null,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100248_.tb6_0(6);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100248_.tb6_0(6),
EXP_PROCESS_100248_.tb6_1(6),
EXP_PROCESS_100248_.tb6_2(6),
null,
0,
null,
0,
null,
1);
end if;

exception when others then
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb6_0(7):=123923;
EXP_PROCESS_100248_.tb6_1(7):=EXP_PROCESS_100248_.tb5_0(7);
EXP_PROCESS_100248_.tb6_2(7):=EXP_PROCESS_100248_.tb5_0(6);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (7)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100248_.tb6_0(7),
ORIGIN_ID=EXP_PROCESS_100248_.tb6_1(7),
TARGET_ID=EXP_PROCESS_100248_.tb6_2(7),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION=null,
EXPRESSION_TYPE=0,
DESCRIPTION=null,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100248_.tb6_0(7);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100248_.tb6_0(7),
EXP_PROCESS_100248_.tb6_1(7),
EXP_PROCESS_100248_.tb6_2(7),
null,
0,
null,
0,
null,
1);
end if;

exception when others then
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb13_0(4):=100000584;
EXP_PROCESS_100248_.tb13_1(4):=EXP_PROCESS_100248_.tb5_0(7);
EXP_PROCESS_100248_.tb13_2(4):=EXP_PROCESS_100248_.tb12_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (4)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100248_.tb13_0(4),
UNIT_ID=EXP_PROCESS_100248_.tb13_1(4),
ATTRIBUTE_ID=EXP_PROCESS_100248_.tb13_2(4),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100248_.tb13_0(4);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100248_.tb13_0(4),
EXP_PROCESS_100248_.tb13_1(4),
EXP_PROCESS_100248_.tb13_2(4),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb2_0(9):=252;
EXP_PROCESS_100248_.tb2_1(9):=EXP_PROCESS_100248_.tb0_0(2);
EXP_PROCESS_100248_.tb2_2(9):=EXP_PROCESS_100248_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (9)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100248_.tb2_0(9),
CATEGORY_ID=EXP_PROCESS_100248_.tb2_1(9),
MODULE_ID=EXP_PROCESS_100248_.tb2_2(9),
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100248_.tb2_0(9);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100248_.tb2_0(9),
EXP_PROCESS_100248_.tb2_1(9),
EXP_PROCESS_100248_.tb2_2(9),
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
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb4_0(3):=3;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (3)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100248_.tb4_0(3),
DESCRIPTION='Final'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100248_.tb4_0(3);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100248_.tb4_0(3),
'Final'
);
end if;

exception when others then
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb5_0(9):=100941;
EXP_PROCESS_100248_.tb5_1(9):=EXP_PROCESS_100248_.tb5_0(0);
EXP_PROCESS_100248_.tb5_2(9):=EXP_PROCESS_100248_.tb2_0(9);
EXP_PROCESS_100248_.tb5_3(9):=EXP_PROCESS_100248_.tb4_0(3);
EXP_PROCESS_100248_.tb5_4(9):=EXP_PROCESS_100248_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (9)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100248_.tb5_0(9),
PROCESS_ID=EXP_PROCESS_100248_.tb5_1(9),
UNIT_TYPE_ID=EXP_PROCESS_100248_.tb5_2(9),
NODE_TYPE_ID=EXP_PROCESS_100248_.tb5_3(9),
MODULE_ID=EXP_PROCESS_100248_.tb5_4(9),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='806
174'
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

 WHERE UNIT_ID = EXP_PROCESS_100248_.tb5_0(9);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100248_.tb5_0(9),
EXP_PROCESS_100248_.tb5_1(9),
EXP_PROCESS_100248_.tb5_2(9),
EXP_PROCESS_100248_.tb5_3(9),
EXP_PROCESS_100248_.tb5_4(9),
null,
null,
null,
null,
'806
174'
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
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb6_0(8):=118949;
EXP_PROCESS_100248_.tb6_1(8):=EXP_PROCESS_100248_.tb5_0(8);
EXP_PROCESS_100248_.tb6_2(8):=EXP_PROCESS_100248_.tb5_0(9);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (8)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100248_.tb6_0(8),
ORIGIN_ID=EXP_PROCESS_100248_.tb6_1(8),
TARGET_ID=EXP_PROCESS_100248_.tb6_2(8),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION=null,
EXPRESSION_TYPE=0,
DESCRIPTION=null,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100248_.tb6_0(8);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100248_.tb6_0(8),
EXP_PROCESS_100248_.tb6_1(8),
EXP_PROCESS_100248_.tb6_2(8),
null,
0,
null,
0,
null,
1);
end if;

exception when others then
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb13_0(5):=126450;
EXP_PROCESS_100248_.tb13_1(5):=EXP_PROCESS_100248_.tb5_0(9);
EXP_PROCESS_100248_.tb13_2(5):=EXP_PROCESS_100248_.tb12_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (5)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100248_.tb13_0(5),
UNIT_ID=EXP_PROCESS_100248_.tb13_1(5),
ATTRIBUTE_ID=EXP_PROCESS_100248_.tb13_2(5),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100248_.tb13_0(5);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100248_.tb13_0(5),
EXP_PROCESS_100248_.tb13_1(5),
EXP_PROCESS_100248_.tb13_2(5),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100248_.tb13_0(6):=126451;
EXP_PROCESS_100248_.tb13_1(6):=EXP_PROCESS_100248_.tb5_0(9);
EXP_PROCESS_100248_.tb13_2(6):=EXP_PROCESS_100248_.tb12_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (6)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100248_.tb13_0(6),
UNIT_ID=EXP_PROCESS_100248_.tb13_1(6),
ATTRIBUTE_ID=EXP_PROCESS_100248_.tb13_2(6),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100248_.tb13_0(6);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100248_.tb13_0(6),
EXP_PROCESS_100248_.tb13_1(6),
EXP_PROCESS_100248_.tb13_2(6),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_100248_.blProcessStatus := false;
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
sa_bocreatePackages.CreatePackage('EXP_UNITTYPE_100248_',
'CREATE OR REPLACE PACKAGE EXP_UNITTYPE_100248_ IS ' || chr(10) ||
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
'END EXP_UNITTYPE_100248_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_UNITTYPE_100248_******************************'); END;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_UNITTYPE_100248',1);
EXP_UNITTYPE_100248_.blProcessStatus := EXP_PROCESS_100248_.blProcessStatus ; 
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
AND     A.TASK_CODE = 100248
 
;
BEGIN

if (not EXP_UNITTYPE_100248_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_UNITTYPE_100248_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
FROM WF_UNIT_TYPE_ATTRIB WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100248);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100248_.blProcessStatus) then
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
EXP_UNITTYPE_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_CAUSAL_UNIT_TYPE WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100248);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100248_.blProcessStatus) then
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
EXP_UNITTYPE_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM MO_TIME_UNI_TYP_PRIO WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100248);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100248_.blProcessStatus) then
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
EXP_UNITTYPE_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM OR_ACT_BY_TASK_MOD WHERE (TASK_CODE) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100248);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100248_.blProcessStatus) then
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
EXP_UNITTYPE_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100248;
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100248_.blProcessStatus) then
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
EXP_UNITTYPE_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_UNITTYPE_100248_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100248_.tb0_0(0):=100248;
ut_trace.trace('insertando tabla sin fallo: WF_UNIT_TYPE fila (0)',1);
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_UNITTYPE_100248_.tb0_0(0),
3,
9,
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_100248'
,
'LBC-Anulaci¿n de Solicitudes'
,
'LBC-Anulaci¿n de Solicitudes'
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
EXP_UNITTYPE_100248_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100248',1);
EXP_PROCESS_100248_.blProcessStatus := EXP_UNITTYPE_100248_.blProcessStatus ; 
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
 nuIndex := EXP_UNITTYPE_100248_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_UNITTYPE_100248_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_UNITTYPE_100248_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_UNITTYPE_100248_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_UNITTYPE_100248_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_UNITTYPE_100248_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_UNITTYPE_100248_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_UNITTYPE_100248_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_UNITTYPE_100248_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_UNITTYPE_100248_******************************'); end;
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
EXP_UNITTYPE_283_.blProcessStatus := EXP_PROCESS_100248_.blProcessStatus ; 
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
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100248',1);
EXP_PROCESS_100248_.blProcessStatus := EXP_UNITTYPE_283_.blProcessStatus ; 
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
sa_bocreatePackages.CreatePackage('EXP_UNITTYPE_100247_',
'CREATE OR REPLACE PACKAGE EXP_UNITTYPE_100247_ IS ' || chr(10) ||
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
'tbOR_ACT_BY_TASK_MODRowId tyOR_ACT_BY_TASK_MODRowId;type ty0_0 is table of GR_CONFIGURA_TYPE.CONFIGURA_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty1_0 is table of GR_CONFIG_EXPRESSION.CONFIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_0 ty1_0; ' || chr(10) ||
'tb1_0 ty1_0;type ty1_1 is table of GR_CONFIG_EXPRESSION.OBJECT_NAME%type index by binary_integer; ' || chr(10) ||
'old_tb1_1 ty1_1; ' || chr(10) ||
'tb1_1 ty1_1;type ty1_2 is table of GR_CONFIG_EXPRESSION.CONFIGURA_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_2 ty1_2; ' || chr(10) ||
'tb1_2 ty1_2;type ty2_0 is table of WF_UNIT_TYPE.UNIT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;type ty2_5 is table of WF_UNIT_TYPE.INIT_AREA_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_5 ty2_5; ' || chr(10) ||
'tb2_5 ty2_5;type ty3_0 is table of MO_TIME_UNI_TYP_PRIO.TIME_UNI_TYP_PRIO_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_0 ty3_0; ' || chr(10) ||
'tb3_0 ty3_0;type ty3_1 is table of MO_TIME_UNI_TYP_PRIO.UNIT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_1 ty3_1; ' || chr(10) ||
'tb3_1 ty3_1; ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_UNITTYPE_100247_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_UNITTYPE_100247_******************************'); END;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_UNITTYPE_100247',1);
EXP_UNITTYPE_100247_.blProcessStatus := EXP_PROCESS_100248_.blProcessStatus ; 
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
AND     A.TASK_CODE = 100247
 
;
BEGIN

if (not EXP_UNITTYPE_100247_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_UNITTYPE_100247_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
FROM WF_UNIT_TYPE_ATTRIB WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100247);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100247_.blProcessStatus) then
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
EXP_UNITTYPE_100247_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_CAUSAL_UNIT_TYPE WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100247);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100247_.blProcessStatus) then
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
EXP_UNITTYPE_100247_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM MO_TIME_UNI_TYP_PRIO WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100247);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100247_.blProcessStatus) then
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
EXP_UNITTYPE_100247_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM OR_ACT_BY_TASK_MOD WHERE (TASK_CODE) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100247);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100247_.blProcessStatus) then
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
EXP_UNITTYPE_100247_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100247;
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100247_.blProcessStatus) then
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
EXP_UNITTYPE_100247_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_UNITTYPE_100247_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100247_.tb0_0(0):=16;
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=EXP_UNITTYPE_100247_.tb0_0(0),
MODULE_ID=9,
DESCRIPTION='Reglas de Procesos Administrativos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='WF_AD_PRO_RULE'

 WHERE CONFIGURA_TYPE_ID = EXP_UNITTYPE_100247_.tb0_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (EXP_UNITTYPE_100247_.tb0_0(0),
9,
'Reglas de Procesos Administrativos'
,
'PL'
,
'FD'
,
'DS'
,
'WF_AD_PRO_RULE'
);
end if;

exception when others then
EXP_UNITTYPE_100247_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_100247_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100247_.old_tb1_0(0):=121401236;
EXP_UNITTYPE_100247_.tb1_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
EXP_UNITTYPE_100247_.tb1_0(0):=EXP_UNITTYPE_100247_.tb1_0(0);
EXP_UNITTYPE_100247_.old_tb1_1(0):='WFWF_AD_PRO_RULECT16E121401236'
;
EXP_UNITTYPE_100247_.tb1_1(0):=TO_CHAR(EXP_UNITTYPE_100247_.tb1_0(0));
EXP_UNITTYPE_100247_.tb1_2(0):=EXP_UNITTYPE_100247_.tb0_0(0);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (EXP_UNITTYPE_100247_.tb1_0(0),
EXP_UNITTYPE_100247_.tb1_1(0),
EXP_UNITTYPE_100247_.tb1_2(0),
'
nuPackageIdAnulacion = CC_BOADMINISTRATIVEPROCESS.FNUGETEXTERNALID();nuPackageIdAnular = MO_BCDETALLEANULSOLICITUD.FNUGETANNULPACK(nuPackageIdAnulacion);nuCategoryId = MO_BOPACKAGES.FNUGETCATEGORYID(nuPackageIdAnular);if (nuCategoryId = NULL,nuCategoryId = -1;,);nuPackId = LDC_BOUTILITIES.FNUGETTIPOPACK(nuPackageIdAnular);AreaAsignada = LDC_BOORDENES.FNUGETAREAORGANIZAT(nuPackId, nuCategoryId, nuPackageIdAnulacion)'
,
'LBTEST'
,
to_date('09-09-2010 18:08:31','DD-MM-YYYY HH24:MI:SS'),
to_date('28-02-2024 08:49:51','DD-MM-YYYY HH24:MI:SS'),
to_date('28-02-2024 08:49:51','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LDC - Obtiene Area Por Defecto'
,
'PF'
,
null);

exception when others then
EXP_UNITTYPE_100247_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_100247_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100247_.tb2_0(0):=100247;
EXP_UNITTYPE_100247_.tb2_5(0):=EXP_UNITTYPE_100247_.tb1_0(0);
ut_trace.trace('insertando tabla sin fallo: WF_UNIT_TYPE fila (0)',1);
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_UNITTYPE_100247_.tb2_0(0),
2,
5,
null,
100213,
EXP_UNITTYPE_100247_.tb2_5(0),
1,
1,
1,
'UNIT_TYPE_100247'
,
'Actividad de revisi¿n por anulaci¿n'
,
'Actividad de revisi¿n por anulaci¿n'
,
null,
'N'
,
'N'
,
17,
'C'
,
'N'
,
9000,
'N'
,
-1,
0,
'Y'
,
null,
'N'
);

exception 
when dup_val_on_index then 
 return;
when others then
EXP_UNITTYPE_100247_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_100247_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100247_.tb3_0(0):=1981;
EXP_UNITTYPE_100247_.tb3_1(0):=EXP_UNITTYPE_100247_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: MO_TIME_UNI_TYP_PRIO fila (0)',1);
UPDATE MO_TIME_UNI_TYP_PRIO SET TIME_UNI_TYP_PRIO_ID=EXP_UNITTYPE_100247_.tb3_0(0),
UNIT_TYPE_ID=EXP_UNITTYPE_100247_.tb3_1(0),
PRIORITY_ID=-1,
ATTENTION_LIMIT_TIME=1
 WHERE TIME_UNI_TYP_PRIO_ID = EXP_UNITTYPE_100247_.tb3_0(0);
if not (sql%found) then
INSERT INTO MO_TIME_UNI_TYP_PRIO(TIME_UNI_TYP_PRIO_ID,UNIT_TYPE_ID,PRIORITY_ID,ATTENTION_LIMIT_TIME) 
VALUES (EXP_UNITTYPE_100247_.tb3_0(0),
EXP_UNITTYPE_100247_.tb3_1(0),
-1,
1);
end if;

exception when others then
EXP_UNITTYPE_100247_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100248',1);
EXP_PROCESS_100248_.blProcessStatus := EXP_UNITTYPE_100247_.blProcessStatus ; 
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

if (not EXP_UNITTYPE_100247_.blProcessStatus) then
 return;
end if;
nuRowProcess:=EXP_UNITTYPE_100247_.tb1_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| EXP_UNITTYPE_100247_.tb1_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(EXP_UNITTYPE_100247_.tb1_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| EXP_UNITTYPE_100247_.tb1_0(nuRowProcess),1);
end;
nuRowProcess := EXP_UNITTYPE_100247_.tb1_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
EXP_UNITTYPE_100247_.blProcessStatus := false;
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
 nuIndex := EXP_UNITTYPE_100247_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_UNITTYPE_100247_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_UNITTYPE_100247_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_UNITTYPE_100247_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_UNITTYPE_100247_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_UNITTYPE_100247_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_UNITTYPE_100247_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_UNITTYPE_100247_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_UNITTYPE_100247_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_UNITTYPE_100247_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_UNITTYPE_319_',
'CREATE OR REPLACE PACKAGE EXP_UNITTYPE_319_ IS ' || chr(10) ||
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
'END EXP_UNITTYPE_319_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_UNITTYPE_319_******************************'); END;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_UNITTYPE_319',1);
EXP_UNITTYPE_319_.blProcessStatus := EXP_PROCESS_100248_.blProcessStatus ; 
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
AND     A.TASK_CODE = 319
 
;
BEGIN

if (not EXP_UNITTYPE_319_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_UNITTYPE_319_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
FROM WF_UNIT_TYPE_ATTRIB WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=319);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_319_.blProcessStatus) then
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
EXP_UNITTYPE_319_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_CAUSAL_UNIT_TYPE WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=319);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_319_.blProcessStatus) then
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
EXP_UNITTYPE_319_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM MO_TIME_UNI_TYP_PRIO WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=319);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_319_.blProcessStatus) then
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
EXP_UNITTYPE_319_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM OR_ACT_BY_TASK_MOD WHERE (TASK_CODE) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=319);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_319_.blProcessStatus) then
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
EXP_UNITTYPE_319_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=319;
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_319_.blProcessStatus) then
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
EXP_UNITTYPE_319_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_UNITTYPE_319_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_319_.tb0_0(0):=319;
ut_trace.trace('insertando tabla sin fallo: WF_UNIT_TYPE fila (0)',1);
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_UNITTYPE_319_.tb0_0(0),
2,
5,
null,
983,
null,
null,
null,
null,
'UNIT_TYPE_319'
,
'Crear Nota'
,
'Crear Nota'
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
EXP_UNITTYPE_319_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_319_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_319_.tb1_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTE_CLASS fila (0)',1);
UPDATE GE_ATTRIBUTE_CLASS SET ATTRIBUTE_CLASS_ID=EXP_UNITTYPE_319_.tb1_0(0),
NAME='De Entitdad'
,
DESCRIPTION='Valores que ser¿n tra¿dos de la tabla base usando old record'

 WHERE ATTRIBUTE_CLASS_ID = EXP_UNITTYPE_319_.tb1_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTE_CLASS(ATTRIBUTE_CLASS_ID,NAME,DESCRIPTION) 
VALUES (EXP_UNITTYPE_319_.tb1_0(0),
'De Entitdad'
,
'Valores que ser¿n tra¿dos de la tabla base usando old record'
);
end if;

exception when others then
EXP_UNITTYPE_319_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_319_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_319_.tb2_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES_TYPE fila (0)',1);
UPDATE GE_ATTRIBUTES_TYPE SET ATTRIBUTE_TYPE_ID=EXP_UNITTYPE_319_.tb2_0(0),
DESCRIPTION='NUMBER'
,
INTERNAL_TYPE=2,
INTERNAL_JAVA_TYPE=2
 WHERE ATTRIBUTE_TYPE_ID = EXP_UNITTYPE_319_.tb2_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES_TYPE(ATTRIBUTE_TYPE_ID,DESCRIPTION,INTERNAL_TYPE,INTERNAL_JAVA_TYPE) 
VALUES (EXP_UNITTYPE_319_.tb2_0(0),
'NUMBER'
,
2,
2);
end if;

exception when others then
EXP_UNITTYPE_319_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_319_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_319_.tb3_0(0):=400;
EXP_UNITTYPE_319_.tb3_1(0):=EXP_UNITTYPE_319_.tb1_0(0);
EXP_UNITTYPE_319_.tb3_2(0):=EXP_UNITTYPE_319_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (0)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=EXP_UNITTYPE_319_.tb3_0(0),
ATTRIBUTE_CLASS_ID=EXP_UNITTYPE_319_.tb3_1(0),
ATTRIBUTE_TYPE_ID=EXP_UNITTYPE_319_.tb3_2(0),
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

 WHERE ATTRIBUTE_ID = EXP_UNITTYPE_319_.tb3_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,ATTRIBUTE_CLASS_ID,ATTRIBUTE_TYPE_ID,VALID_EXPRESSION,FATHER_ID,MODULE_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (EXP_UNITTYPE_319_.tb3_0(0),
EXP_UNITTYPE_319_.tb3_1(0),
EXP_UNITTYPE_319_.tb3_2(0),
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
EXP_UNITTYPE_319_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_319_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_319_.tb4_0(0):=109103;
EXP_UNITTYPE_319_.tb4_1(0):=EXP_UNITTYPE_319_.tb0_0(0);
EXP_UNITTYPE_319_.tb4_2(0):=EXP_UNITTYPE_319_.tb3_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE_ATTRIB fila (0)',1);
UPDATE WF_UNIT_TYPE_ATTRIB SET UNIT_TYPE_ATTRIB_ID=EXP_UNITTYPE_319_.tb4_0(0),
UNIT_TYPE_ID=EXP_UNITTYPE_319_.tb4_1(0),
ATTRIBUTE_ID=EXP_UNITTYPE_319_.tb4_2(0),
STATEMENT_ID=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='Y'

 WHERE UNIT_TYPE_ATTRIB_ID = EXP_UNITTYPE_319_.tb4_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE_ATTRIB(UNIT_TYPE_ATTRIB_ID,UNIT_TYPE_ID,ATTRIBUTE_ID,STATEMENT_ID,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_UNITTYPE_319_.tb4_0(0),
EXP_UNITTYPE_319_.tb4_1(0),
EXP_UNITTYPE_319_.tb4_2(0),
null,
'N'
,
2,
'Y'
);
end if;

exception when others then
EXP_UNITTYPE_319_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100248',1);
EXP_PROCESS_100248_.blProcessStatus := EXP_UNITTYPE_319_.blProcessStatus ; 
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
 nuIndex := EXP_UNITTYPE_319_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_UNITTYPE_319_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_UNITTYPE_319_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_UNITTYPE_319_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_UNITTYPE_319_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_UNITTYPE_319_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_UNITTYPE_319_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_UNITTYPE_319_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_UNITTYPE_319_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_UNITTYPE_319_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_UNITTYPE_320_',
'CREATE OR REPLACE PACKAGE EXP_UNITTYPE_320_ IS ' || chr(10) ||
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
'tbOR_ACT_BY_TASK_MODRowId tyOR_ACT_BY_TASK_MODRowId;type ty0_0 is table of GR_CONFIGURA_TYPE.CONFIGURA_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty1_0 is table of GR_CONFIG_EXPRESSION.CONFIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_0 ty1_0; ' || chr(10) ||
'tb1_0 ty1_0;type ty1_1 is table of GR_CONFIG_EXPRESSION.OBJECT_NAME%type index by binary_integer; ' || chr(10) ||
'old_tb1_1 ty1_1; ' || chr(10) ||
'tb1_1 ty1_1;type ty1_2 is table of GR_CONFIG_EXPRESSION.CONFIGURA_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_2 ty1_2; ' || chr(10) ||
'tb1_2 ty1_2;type ty2_0 is table of WF_UNIT_TYPE.UNIT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;type ty2_5 is table of WF_UNIT_TYPE.INIT_AREA_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_5 ty2_5; ' || chr(10) ||
'tb2_5 ty2_5;type ty3_0 is table of GE_ATTRIBUTE_CLASS.ATTRIBUTE_CLASS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_0 ty3_0; ' || chr(10) ||
'tb3_0 ty3_0;type ty4_0 is table of GE_ATTRIBUTES_TYPE.ATTRIBUTE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb4_0 ty4_0; ' || chr(10) ||
'tb4_0 ty4_0;type ty5_0 is table of GE_ATTRIBUTES.ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_0 ty5_0; ' || chr(10) ||
'tb5_0 ty5_0;type ty5_1 is table of GE_ATTRIBUTES.ATTRIBUTE_CLASS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_1 ty5_1; ' || chr(10) ||
'tb5_1 ty5_1;type ty5_2 is table of GE_ATTRIBUTES.ATTRIBUTE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_2 ty5_2; ' || chr(10) ||
'tb5_2 ty5_2;type ty5_3 is table of GE_ATTRIBUTES.VALID_EXPRESSION%type index by binary_integer; ' || chr(10) ||
'old_tb5_3 ty5_3; ' || chr(10) ||
'tb5_3 ty5_3;type ty6_0 is table of WF_UNIT_TYPE_ATTRIB.UNIT_TYPE_ATTRIB_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_0 ty6_0; ' || chr(10) ||
'tb6_0 ty6_0;type ty6_1 is table of WF_UNIT_TYPE_ATTRIB.UNIT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_1 ty6_1; ' || chr(10) ||
'tb6_1 ty6_1;type ty6_2 is table of WF_UNIT_TYPE_ATTRIB.ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_2 ty6_2; ' || chr(10) ||
'tb6_2 ty6_2;type ty6_3 is table of WF_UNIT_TYPE_ATTRIB.STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_3 ty6_3; ' || chr(10) ||
'tb6_3 ty6_3;type ty7_0 is table of MO_TIME_UNI_TYP_PRIO.TIME_UNI_TYP_PRIO_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_0 ty7_0; ' || chr(10) ||
'tb7_0 ty7_0;type ty7_1 is table of MO_TIME_UNI_TYP_PRIO.UNIT_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_1 ty7_1; ' || chr(10) ||
'tb7_1 ty7_1; ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_UNITTYPE_320_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_UNITTYPE_320_******************************'); END;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_UNITTYPE_320',1);
EXP_UNITTYPE_320_.blProcessStatus := EXP_PROCESS_100248_.blProcessStatus ; 
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
AND     A.TASK_CODE = 320
 
;
BEGIN

if (not EXP_UNITTYPE_320_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_UNITTYPE_320_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
FROM WF_UNIT_TYPE_ATTRIB WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=320);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_320_.blProcessStatus) then
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
EXP_UNITTYPE_320_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_CAUSAL_UNIT_TYPE WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=320);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_320_.blProcessStatus) then
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
EXP_UNITTYPE_320_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM MO_TIME_UNI_TYP_PRIO WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=320);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_320_.blProcessStatus) then
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
EXP_UNITTYPE_320_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM OR_ACT_BY_TASK_MOD WHERE (TASK_CODE) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=320);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_320_.blProcessStatus) then
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
EXP_UNITTYPE_320_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=320;
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_320_.blProcessStatus) then
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
EXP_UNITTYPE_320_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_UNITTYPE_320_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_320_.tb0_0(0):=16;
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=EXP_UNITTYPE_320_.tb0_0(0),
MODULE_ID=9,
DESCRIPTION='Reglas de Procesos Administrativos'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='WF_AD_PRO_RULE'

 WHERE CONFIGURA_TYPE_ID = EXP_UNITTYPE_320_.tb0_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (EXP_UNITTYPE_320_.tb0_0(0),
9,
'Reglas de Procesos Administrativos'
,
'PL'
,
'FD'
,
'DS'
,
'WF_AD_PRO_RULE'
);
end if;

exception when others then
EXP_UNITTYPE_320_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_320_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_320_.old_tb1_0(0):=121401237;
EXP_UNITTYPE_320_.tb1_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
EXP_UNITTYPE_320_.tb1_0(0):=EXP_UNITTYPE_320_.tb1_0(0);
EXP_UNITTYPE_320_.old_tb1_1(0):='WFWF_AD_PRO_RULECT16E121401237'
;
EXP_UNITTYPE_320_.tb1_1(0):=TO_CHAR(EXP_UNITTYPE_320_.tb1_0(0));
EXP_UNITTYPE_320_.tb1_2(0):=EXP_UNITTYPE_320_.tb0_0(0);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (EXP_UNITTYPE_320_.tb1_0(0),
EXP_UNITTYPE_320_.tb1_1(0),
EXP_UNITTYPE_320_.tb1_2(0),
'
nuPackageIdAnulacion = CC_BOADMINISTRATIVEPROCESS.FNUGETEXTERNALID();nuPackageIdAnular = MO_BCDETALLEANULSOLICITUD.FNUGETANNULPACK(nuPackageIdAnulacion);nuCategoryId = MO_BOPACKAGES.FNUGETCATEGORYID(nuPackageIdAnular);if (nuCategoryId = NULL,nuCategoryId = -1;,);nuPackId = LDC_BOUTILITIES.FNUGETTIPOPACK(nuPackageIdAnular);AreaAsignada = LDC_BOORDENES.FNUGETAREAORGANIZAT(nuPackId, nuCategoryId, nuPackageIdAnulacion)'
,
'LBTEST'
,
to_date('27-08-2012 13:07:55','DD-MM-YYYY HH24:MI:SS'),
to_date('28-02-2024 08:49:51','DD-MM-YYYY HH24:MI:SS'),
to_date('28-02-2024 08:49:51','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Obtiene Area Por Defecto'
,
'PF'
,
null);

exception when others then
EXP_UNITTYPE_320_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_320_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_320_.tb2_0(0):=320;
EXP_UNITTYPE_320_.tb2_5(0):=EXP_UNITTYPE_320_.tb1_0(0);
ut_trace.trace('insertando tabla sin fallo: WF_UNIT_TYPE fila (0)',1);
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_UNITTYPE_320_.tb2_0(0),
2,
5,
null,
983,
EXP_UNITTYPE_320_.tb2_5(0),
1,
1,
1,
'UNIT_TYPE_320'
,
'Crear Nota Manual'
,
'Crear Nota Manual'
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
-1,
0,
'Y'
,
null,
'N'
);

exception 
when dup_val_on_index then 
 return;
when others then
EXP_UNITTYPE_320_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_320_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_320_.tb3_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTE_CLASS fila (0)',1);
UPDATE GE_ATTRIBUTE_CLASS SET ATTRIBUTE_CLASS_ID=EXP_UNITTYPE_320_.tb3_0(0),
NAME='De Entitdad'
,
DESCRIPTION='Valores que ser¿n tra¿dos de la tabla base usando old record'

 WHERE ATTRIBUTE_CLASS_ID = EXP_UNITTYPE_320_.tb3_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTE_CLASS(ATTRIBUTE_CLASS_ID,NAME,DESCRIPTION) 
VALUES (EXP_UNITTYPE_320_.tb3_0(0),
'De Entitdad'
,
'Valores que ser¿n tra¿dos de la tabla base usando old record'
);
end if;

exception when others then
EXP_UNITTYPE_320_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_320_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_320_.tb4_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES_TYPE fila (0)',1);
UPDATE GE_ATTRIBUTES_TYPE SET ATTRIBUTE_TYPE_ID=EXP_UNITTYPE_320_.tb4_0(0),
DESCRIPTION='NUMBER'
,
INTERNAL_TYPE=2,
INTERNAL_JAVA_TYPE=2
 WHERE ATTRIBUTE_TYPE_ID = EXP_UNITTYPE_320_.tb4_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES_TYPE(ATTRIBUTE_TYPE_ID,DESCRIPTION,INTERNAL_TYPE,INTERNAL_JAVA_TYPE) 
VALUES (EXP_UNITTYPE_320_.tb4_0(0),
'NUMBER'
,
2,
2);
end if;

exception when others then
EXP_UNITTYPE_320_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_320_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_320_.tb5_0(0):=400;
EXP_UNITTYPE_320_.tb5_1(0):=EXP_UNITTYPE_320_.tb3_0(0);
EXP_UNITTYPE_320_.tb5_2(0):=EXP_UNITTYPE_320_.tb4_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (0)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=EXP_UNITTYPE_320_.tb5_0(0),
ATTRIBUTE_CLASS_ID=EXP_UNITTYPE_320_.tb5_1(0),
ATTRIBUTE_TYPE_ID=EXP_UNITTYPE_320_.tb5_2(0),
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

 WHERE ATTRIBUTE_ID = EXP_UNITTYPE_320_.tb5_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,ATTRIBUTE_CLASS_ID,ATTRIBUTE_TYPE_ID,VALID_EXPRESSION,FATHER_ID,MODULE_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (EXP_UNITTYPE_320_.tb5_0(0),
EXP_UNITTYPE_320_.tb5_1(0),
EXP_UNITTYPE_320_.tb5_2(0),
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
EXP_UNITTYPE_320_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_320_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_320_.tb6_0(0):=100000036;
EXP_UNITTYPE_320_.tb6_1(0):=EXP_UNITTYPE_320_.tb2_0(0);
EXP_UNITTYPE_320_.tb6_2(0):=EXP_UNITTYPE_320_.tb5_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE_ATTRIB fila (0)',1);
UPDATE WF_UNIT_TYPE_ATTRIB SET UNIT_TYPE_ATTRIB_ID=EXP_UNITTYPE_320_.tb6_0(0),
UNIT_TYPE_ID=EXP_UNITTYPE_320_.tb6_1(0),
ATTRIBUTE_ID=EXP_UNITTYPE_320_.tb6_2(0),
STATEMENT_ID=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_TYPE_ATTRIB_ID = EXP_UNITTYPE_320_.tb6_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE_ATTRIB(UNIT_TYPE_ATTRIB_ID,UNIT_TYPE_ID,ATTRIBUTE_ID,STATEMENT_ID,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_UNITTYPE_320_.tb6_0(0),
EXP_UNITTYPE_320_.tb6_1(0),
EXP_UNITTYPE_320_.tb6_2(0),
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_UNITTYPE_320_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_320_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_320_.tb7_0(0):=2181;
EXP_UNITTYPE_320_.tb7_1(0):=EXP_UNITTYPE_320_.tb2_0(0);
ut_trace.trace('Actualizar o insertar tabla: MO_TIME_UNI_TYP_PRIO fila (0)',1);
UPDATE MO_TIME_UNI_TYP_PRIO SET TIME_UNI_TYP_PRIO_ID=EXP_UNITTYPE_320_.tb7_0(0),
UNIT_TYPE_ID=EXP_UNITTYPE_320_.tb7_1(0),
PRIORITY_ID=-1,
ATTENTION_LIMIT_TIME=1
 WHERE TIME_UNI_TYP_PRIO_ID = EXP_UNITTYPE_320_.tb7_0(0);
if not (sql%found) then
INSERT INTO MO_TIME_UNI_TYP_PRIO(TIME_UNI_TYP_PRIO_ID,UNIT_TYPE_ID,PRIORITY_ID,ATTENTION_LIMIT_TIME) 
VALUES (EXP_UNITTYPE_320_.tb7_0(0),
EXP_UNITTYPE_320_.tb7_1(0),
-1,
1);
end if;

exception when others then
EXP_UNITTYPE_320_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100248',1);
EXP_PROCESS_100248_.blProcessStatus := EXP_UNITTYPE_320_.blProcessStatus ; 
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

if (not EXP_UNITTYPE_320_.blProcessStatus) then
 return;
end if;
nuRowProcess:=EXP_UNITTYPE_320_.tb1_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| EXP_UNITTYPE_320_.tb1_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(EXP_UNITTYPE_320_.tb1_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| EXP_UNITTYPE_320_.tb1_0(nuRowProcess),1);
end;
nuRowProcess := EXP_UNITTYPE_320_.tb1_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
EXP_UNITTYPE_320_.blProcessStatus := false;
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
 nuIndex := EXP_UNITTYPE_320_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_UNITTYPE_320_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_UNITTYPE_320_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_UNITTYPE_320_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_UNITTYPE_320_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_UNITTYPE_320_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_UNITTYPE_320_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_UNITTYPE_320_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_UNITTYPE_320_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_UNITTYPE_320_******************************'); end;
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
EXP_UNITTYPE_252_.blProcessStatus := EXP_PROCESS_100248_.blProcessStatus ; 
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
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100248',1);
EXP_PROCESS_100248_.blProcessStatus := EXP_UNITTYPE_252_.blProcessStatus ; 
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
sa_bocreatePackages.CreatePackage('EXP_UNITTYPE_100237_',
'CREATE OR REPLACE PACKAGE EXP_UNITTYPE_100237_ IS ' || chr(10) ||
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
'END EXP_UNITTYPE_100237_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_UNITTYPE_100237_******************************'); END;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_UNITTYPE_100237',1);
EXP_UNITTYPE_100237_.blProcessStatus := EXP_PROCESS_100248_.blProcessStatus ; 
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
AND     A.TASK_CODE = 100237
 
;
BEGIN

if (not EXP_UNITTYPE_100237_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_UNITTYPE_100237_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
FROM WF_UNIT_TYPE_ATTRIB WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100237);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100237_.blProcessStatus) then
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
EXP_UNITTYPE_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_CAUSAL_UNIT_TYPE WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100237);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100237_.blProcessStatus) then
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
EXP_UNITTYPE_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM MO_TIME_UNI_TYP_PRIO WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100237);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100237_.blProcessStatus) then
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
EXP_UNITTYPE_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM OR_ACT_BY_TASK_MOD WHERE (TASK_CODE) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100237);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100237_.blProcessStatus) then
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
EXP_UNITTYPE_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100237;
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100237_.blProcessStatus) then
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
EXP_UNITTYPE_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_UNITTYPE_100237_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100237_.tb0_0(0):=100237;
ut_trace.trace('insertando tabla sin fallo: WF_UNIT_TYPE fila (0)',1);
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_UNITTYPE_100237_.tb0_0(0),
1,
9,
null,
100213,
null,
null,
null,
null,
'UNIT_TYPE_100237'
,
'Contratrabajos - Mediaci¿n'
,
'Contratrabajos - Mediaci¿n'
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
EXP_UNITTYPE_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100248',1);
EXP_PROCESS_100248_.blProcessStatus := EXP_UNITTYPE_100237_.blProcessStatus ; 
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
 nuIndex := EXP_UNITTYPE_100237_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_UNITTYPE_100237_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_UNITTYPE_100237_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_UNITTYPE_100237_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_UNITTYPE_100237_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_UNITTYPE_100237_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_UNITTYPE_100237_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_UNITTYPE_100237_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_UNITTYPE_100237_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_UNITTYPE_100237_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_UNITTYPE_100235_',
'CREATE OR REPLACE PACKAGE EXP_UNITTYPE_100235_ IS ' || chr(10) ||
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
'END EXP_UNITTYPE_100235_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_UNITTYPE_100235_******************************'); END;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_UNITTYPE_100235',1);
EXP_UNITTYPE_100235_.blProcessStatus := EXP_PROCESS_100248_.blProcessStatus ; 
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
AND     A.TASK_CODE = 100235
 
;
BEGIN

if (not EXP_UNITTYPE_100235_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_UNITTYPE_100235_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
FROM WF_UNIT_TYPE_ATTRIB WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100235);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100235_.blProcessStatus) then
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
EXP_UNITTYPE_100235_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_CAUSAL_UNIT_TYPE WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100235);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100235_.blProcessStatus) then
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
EXP_UNITTYPE_100235_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM MO_TIME_UNI_TYP_PRIO WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100235);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100235_.blProcessStatus) then
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
EXP_UNITTYPE_100235_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM OR_ACT_BY_TASK_MOD WHERE (TASK_CODE) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100235);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100235_.blProcessStatus) then
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
EXP_UNITTYPE_100235_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100235;
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100235_.blProcessStatus) then
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
EXP_UNITTYPE_100235_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_UNITTYPE_100235_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100235_.tb0_0(0):=100235;
ut_trace.trace('insertando tabla sin fallo: WF_UNIT_TYPE fila (0)',1);
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_UNITTYPE_100235_.tb0_0(0),
1,
9,
null,
100213,
null,
null,
null,
null,
'UNIT_TYPE_100235'
,
'Contratrabajos - Acciones y Estados'
,
'Contratrabajos - Acciones y Estados'
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
EXP_UNITTYPE_100235_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100248',1);
EXP_PROCESS_100248_.blProcessStatus := EXP_UNITTYPE_100235_.blProcessStatus ; 
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
 nuIndex := EXP_UNITTYPE_100235_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_UNITTYPE_100235_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_UNITTYPE_100235_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_UNITTYPE_100235_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_UNITTYPE_100235_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_UNITTYPE_100235_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_UNITTYPE_100235_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_UNITTYPE_100235_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_UNITTYPE_100235_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_UNITTYPE_100235_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_UNITTYPE_100232_',
'CREATE OR REPLACE PACKAGE EXP_UNITTYPE_100232_ IS ' || chr(10) ||
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
'END EXP_UNITTYPE_100232_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_UNITTYPE_100232_******************************'); END;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_UNITTYPE_100232',1);
EXP_UNITTYPE_100232_.blProcessStatus := EXP_PROCESS_100248_.blProcessStatus ; 
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
AND     A.TASK_CODE = 100232
 
;
BEGIN

if (not EXP_UNITTYPE_100232_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_UNITTYPE_100232_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
FROM WF_UNIT_TYPE_ATTRIB WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100232);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100232_.blProcessStatus) then
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
EXP_UNITTYPE_100232_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_CAUSAL_UNIT_TYPE WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100232);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100232_.blProcessStatus) then
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
EXP_UNITTYPE_100232_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM MO_TIME_UNI_TYP_PRIO WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100232);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100232_.blProcessStatus) then
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
EXP_UNITTYPE_100232_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM OR_ACT_BY_TASK_MOD WHERE (TASK_CODE) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100232);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100232_.blProcessStatus) then
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
EXP_UNITTYPE_100232_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100232;
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100232_.blProcessStatus) then
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
EXP_UNITTYPE_100232_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_UNITTYPE_100232_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100232_.tb0_0(0):=100232;
ut_trace.trace('insertando tabla sin fallo: WF_UNIT_TYPE fila (0)',1);
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_UNITTYPE_100232_.tb0_0(0),
1,
9,
null,
100213,
null,
null,
null,
null,
'UNIT_TYPE_100232'
,
'Contratrabajos - Asignaci¿n'
,
'Contratrabajos - Asignaci¿n'
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
EXP_UNITTYPE_100232_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100248',1);
EXP_PROCESS_100248_.blProcessStatus := EXP_UNITTYPE_100232_.blProcessStatus ; 
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
 nuIndex := EXP_UNITTYPE_100232_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_UNITTYPE_100232_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_UNITTYPE_100232_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_UNITTYPE_100232_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_UNITTYPE_100232_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_UNITTYPE_100232_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_UNITTYPE_100232_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_UNITTYPE_100232_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_UNITTYPE_100232_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_UNITTYPE_100232_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_UNITTYPE_100241_',
'CREATE OR REPLACE PACKAGE EXP_UNITTYPE_100241_ IS ' || chr(10) ||
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
'END EXP_UNITTYPE_100241_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_UNITTYPE_100241_******************************'); END;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_UNITTYPE_100241',1);
EXP_UNITTYPE_100241_.blProcessStatus := EXP_PROCESS_100248_.blProcessStatus ; 
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
AND     A.TASK_CODE = 100241
 
;
BEGIN

if (not EXP_UNITTYPE_100241_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_UNITTYPE_100241_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
FROM WF_UNIT_TYPE_ATTRIB WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100241);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100241_.blProcessStatus) then
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
EXP_UNITTYPE_100241_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_CAUSAL_UNIT_TYPE WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100241);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100241_.blProcessStatus) then
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
EXP_UNITTYPE_100241_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM MO_TIME_UNI_TYP_PRIO WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100241);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100241_.blProcessStatus) then
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
EXP_UNITTYPE_100241_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM OR_ACT_BY_TASK_MOD WHERE (TASK_CODE) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100241);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100241_.blProcessStatus) then
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
EXP_UNITTYPE_100241_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100241;
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100241_.blProcessStatus) then
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
EXP_UNITTYPE_100241_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_UNITTYPE_100241_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100241_.tb0_0(0):=100241;
ut_trace.trace('insertando tabla sin fallo: WF_UNIT_TYPE fila (0)',1);
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_UNITTYPE_100241_.tb0_0(0),
1,
9,
null,
100213,
null,
null,
null,
null,
'UNIT_TYPE_100241'
,
'Atenci¿n de la Anulaci¿n'
,
'Atenci¿n de la Anulaci¿n'
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
EXP_UNITTYPE_100241_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100248',1);
EXP_PROCESS_100248_.blProcessStatus := EXP_UNITTYPE_100241_.blProcessStatus ; 
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
 nuIndex := EXP_UNITTYPE_100241_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_UNITTYPE_100241_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_UNITTYPE_100241_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_UNITTYPE_100241_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_UNITTYPE_100241_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_UNITTYPE_100241_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_UNITTYPE_100241_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_UNITTYPE_100241_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_UNITTYPE_100241_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_UNITTYPE_100241_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_PROCESS_100237_',
'CREATE OR REPLACE PACKAGE EXP_PROCESS_100237_ IS ' || chr(10) ||
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
'tb5_2 ty5_2;type ty6_0 is table of GR_CONFIGURA_TYPE.CONFIGURA_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_0 ty6_0; ' || chr(10) ||
'tb6_0 ty6_0;type ty7_0 is table of GR_CONFIG_EXPRESSION.CONFIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_0 ty7_0; ' || chr(10) ||
'tb7_0 ty7_0;type ty7_1 is table of GR_CONFIG_EXPRESSION.OBJECT_NAME%type index by binary_integer; ' || chr(10) ||
'old_tb7_1 ty7_1; ' || chr(10) ||
'tb7_1 ty7_1;type ty7_2 is table of GR_CONFIG_EXPRESSION.CONFIGURA_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_2 ty7_2; ' || chr(10) ||
'tb7_2 ty7_2;type ty8_0 is table of GE_ATTRIBUTE_CLASS.ATTRIBUTE_CLASS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_0 ty8_0; ' || chr(10) ||
'tb8_0 ty8_0;type ty9_0 is table of GE_ATTRIBUTES_TYPE.ATTRIBUTE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb9_0 ty9_0; ' || chr(10) ||
'tb9_0 ty9_0;type ty10_0 is table of GE_ATTRIBUTES.ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb10_0 ty10_0; ' || chr(10) ||
'tb10_0 ty10_0;type ty10_1 is table of GE_ATTRIBUTES.ATTRIBUTE_CLASS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb10_1 ty10_1; ' || chr(10) ||
'tb10_1 ty10_1;type ty10_2 is table of GE_ATTRIBUTES.ATTRIBUTE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb10_2 ty10_2; ' || chr(10) ||
'tb10_2 ty10_2;type ty11_0 is table of WF_UNIT_ATTRIBUTE.UNIT_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb11_0 ty11_0; ' || chr(10) ||
'tb11_0 ty11_0;type ty11_1 is table of WF_UNIT_ATTRIBUTE.UNIT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb11_1 ty11_1; ' || chr(10) ||
'tb11_1 ty11_1;type ty11_2 is table of WF_UNIT_ATTRIBUTE.ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb11_2 ty11_2; ' || chr(10) ||
'tb11_2 ty11_2;type ty11_3 is table of WF_UNIT_ATTRIBUTE.STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb11_3 ty11_3; ' || chr(10) ||
'tb11_3 ty11_3;type ty12_0 is table of GE_STATEMENT.STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb12_0 ty12_0; ' || chr(10) ||
'tb12_0 ty12_0; ' || chr(10) ||
'CURSOR cuExpression is ' || chr(10) ||
'SELECT PRE_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_TYPE_ID = 100237 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID IN  ' || chr(10) ||
'           (SELECT UNIT_ID ' || chr(10) ||
'           FROM WF_UNIT ' || chr(10) ||
'           WHERE UNIT_TYPE_ID = 100237 ' || chr(10) ||
'       )) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_TYPE_ID = 100237 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID IN  ' || chr(10) ||
'           (SELECT UNIT_ID ' || chr(10) ||
'           FROM WF_UNIT ' || chr(10) ||
'           WHERE UNIT_TYPE_ID = 100237 ' || chr(10) ||
'       )) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_PROCESS_100237_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_PROCESS_100237_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open EXP_PROCESS_100237_.cuExpression;
   fetch EXP_PROCESS_100237_.cuExpression bulk collect INTO EXP_PROCESS_100237_.tbGR_CONFIG_EXPRESSIONId;
   close EXP_PROCESS_100237_.cuExpression;
END;
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100237',1);
EXP_PROCESS_100237_.blProcessStatus := EXP_PROCESS_100248_.blProcessStatus ; 
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
sa_bocreatePackages.CreatePackage('DEL_ROOT_100913_',
'CREATE OR REPLACE PACKAGE DEL_ROOT_100913_ IS ' || chr(10) ||
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
'tb1_2 ty1_2;type ty2_0 is table of GR_CONFIG_EXPRESSION.CONFIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;type ty2_1 is table of GR_CONFIG_EXPRESSION.OBJECT_NAME%type index by binary_integer; ' || chr(10) ||
'old_tb2_1 ty2_1; ' || chr(10) ||
'tb2_1 ty2_1;type ty3_0 is table of WF_UNIT_ATTRIBUTE.UNIT_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_0 ty3_0; ' || chr(10) ||
'tb3_0 ty3_0;type ty3_1 is table of WF_UNIT_ATTRIBUTE.UNIT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_1 ty3_1; ' || chr(10) ||
'tb3_1 ty3_1; ' || chr(10) ||
'CURSOR cuExpression is ' || chr(10) ||
'SELECT PRE_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_ID = 100913 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 100913  ' || chr(10) ||
'       ) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_ID = 100913 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 100913  ' || chr(10) ||
'       ) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END DEL_ROOT_100913_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:DEL_ROOT_100913_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open DEL_ROOT_100913_.cuExpression;
   fetch DEL_ROOT_100913_.cuExpression bulk collect INTO DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONId;
   close DEL_ROOT_100913_.cuExpression;
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
        WHERE UNIT_ID = 100913
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID = 100913 
       )
;
BEGIN

if (not DEL_ROOT_100913_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  DEL_ROOT_100913_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE PROCESS_ID = 100913);
BEGIN 

if (not DEL_ROOT_100913_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100913_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE PROCESS_ID = 100913);
BEGIN 

if (not DEL_ROOT_100913_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100913_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 100913)));
BEGIN 

if (not DEL_ROOT_100913_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100913_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 100913)));
BEGIN 

if (not DEL_ROOT_100913_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100913_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 100913));
BEGIN 

if (not DEL_ROOT_100913_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla WF_UNIT',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100913_.tbWF_UNITRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100913_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 100913);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100913_.blProcessStatus) then
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
DEL_ROOT_100913_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100913_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100913_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100913_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100913_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100913_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria WF_UNIT',1);
nuVarcharIndex:=DEL_ROOT_100913_.tbWF_UNITRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from WF_UNIT where rowid = DEL_ROOT_100913_.tbWF_UNITRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100913_.tbWF_UNITRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100913_.tbWF_UNITRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100913_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_DATA_MAP WHERE (SOURCE_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 100913));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100913_.blProcessStatus) then
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
DEL_ROOT_100913_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_DATA_MAP WHERE (TARGET_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 100913));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100913_.blProcessStatus) then
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
DEL_ROOT_100913_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 100913);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100913_.blProcessStatus) then
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
DEL_ROOT_100913_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT WHERE PROCESS_ID = 100913;
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100913_.blProcessStatus) then
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
DEL_ROOT_100913_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100913_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100913_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100913_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100913_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/

BEGIN
    ut_trace.trace('Actualizar WF_UNIT a ProcessId NULL ',1);
   UPDATE WF_UNIT 
     SET PROCESS_ID = -1, POS_EXPRESSION_ID = null, PRE_EXPRESSION_ID = null, ACTION_ID = null 
     WHERE PROCESS_ID = 100913;
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
    nuBinaryIndex := DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       DEL_ROOT_100913_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100237',1);
EXP_PROCESS_100237_.blProcessStatus := DEL_ROOT_100913_.blProcessStatus ; 
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

if (not DEL_ROOT_100913_.blProcessStatus) then
 return;
end if;
nuRowProcess:=DEL_ROOT_100913_.tb2_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| DEL_ROOT_100913_.tb2_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(DEL_ROOT_100913_.tb2_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| DEL_ROOT_100913_.tb2_0(nuRowProcess),1);
end;
nuRowProcess := DEL_ROOT_100913_.tb2_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
DEL_ROOT_100913_.blProcessStatus := false;
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
 nuIndex := DEL_ROOT_100913_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || DEL_ROOT_100913_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(DEL_ROOT_100913_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(DEL_ROOT_100913_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(DEL_ROOT_100913_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || DEL_ROOT_100913_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || DEL_ROOT_100913_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := DEL_ROOT_100913_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('DEL_ROOT_100913_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:DEL_ROOT_100913_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('DEL_ROOT_100913_',
'CREATE OR REPLACE PACKAGE DEL_ROOT_100913_ IS ' || chr(10) ||
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
'        WHERE UNIT_ID = 100913 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 100913  ' || chr(10) ||
'       ) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_ID = 100913 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 100913  ' || chr(10) ||
'       ) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END DEL_ROOT_100913_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:DEL_ROOT_100913_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open DEL_ROOT_100913_.cuExpression;
   fetch DEL_ROOT_100913_.cuExpression bulk collect INTO DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONId;
   close DEL_ROOT_100913_.cuExpression;
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
        WHERE UNIT_ID = 100913
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID = 100913 
       )
;
BEGIN

if (not DEL_ROOT_100913_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  DEL_ROOT_100913_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE UNIT_ID = 100913);
BEGIN 

if (not DEL_ROOT_100913_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100913_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE UNIT_ID = 100913);
BEGIN 

if (not DEL_ROOT_100913_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100913_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 100913)));
BEGIN 

if (not DEL_ROOT_100913_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100913_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 100913)));
BEGIN 

if (not DEL_ROOT_100913_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100913_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 100913));
BEGIN 

if (not DEL_ROOT_100913_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla WF_UNIT',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100913_.tbWF_UNITRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100913_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 100913);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100913_.blProcessStatus) then
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
DEL_ROOT_100913_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100913_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100913_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100913_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100913_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100913_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria WF_UNIT',1);
nuVarcharIndex:=DEL_ROOT_100913_.tbWF_UNITRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from WF_UNIT where rowid = DEL_ROOT_100913_.tbWF_UNITRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100913_.tbWF_UNITRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100913_.tbWF_UNITRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100913_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_DATA_MAP WHERE (SOURCE_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 100913));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100913_.blProcessStatus) then
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
DEL_ROOT_100913_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_DATA_MAP WHERE (TARGET_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 100913));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100913_.blProcessStatus) then
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
DEL_ROOT_100913_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 100913);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100913_.blProcessStatus) then
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
DEL_ROOT_100913_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT WHERE UNIT_ID = 100913;
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100913_.blProcessStatus) then
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
DEL_ROOT_100913_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100913_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100913_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100913_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100913_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/

BEGIN
    ut_trace.trace('Actualizar WF_UNIT a ProcessId NULL ',1);
   UPDATE WF_UNIT 
     SET PROCESS_ID = -1, POS_EXPRESSION_ID = null, PRE_EXPRESSION_ID = null, ACTION_ID = null 
     WHERE PROCESS_ID = 100913;
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
    nuBinaryIndex := DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := DEL_ROOT_100913_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       DEL_ROOT_100913_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100237',1);
EXP_PROCESS_100237_.blProcessStatus := DEL_ROOT_100913_.blProcessStatus ; 
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
 nuIndex := DEL_ROOT_100913_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || DEL_ROOT_100913_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(DEL_ROOT_100913_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(DEL_ROOT_100913_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(DEL_ROOT_100913_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || DEL_ROOT_100913_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || DEL_ROOT_100913_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := DEL_ROOT_100913_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('DEL_ROOT_100913_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:DEL_ROOT_100913_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_ACTION_8063_',
'CREATE OR REPLACE PACKAGE EXP_ACTION_8063_ IS ' || chr(10) ||
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
'WHERE  ACTION_ID =8063; ' || chr(10) ||
'type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_ACTION_8063_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_ACTION_8063_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open EXP_ACTION_8063_.cuExpression;
   fetch EXP_ACTION_8063_.cuExpression bulk collect INTO EXP_ACTION_8063_.tbGR_CONFIG_EXPRESSIONId;
   close EXP_ACTION_8063_.cuExpression;
END;
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_ACTION_8063',1);
EXP_ACTION_8063_.blProcessStatus := EXP_PROCESS_100237_.blProcessStatus ; 
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
AND     A.ACTION_ID =8063
;
BEGIN

if (not EXP_ACTION_8063_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_ACTION_8063_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE ACTION_ID=8063);
BEGIN 

if (not EXP_ACTION_8063_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_ACTION_8063_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_ACTION_8063_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM GE_ACTION_MODULE WHERE ACTION_ID=8063;
nuIndex binary_integer;
BEGIN

if (not EXP_ACTION_8063_.blProcessStatus) then
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
EXP_ACTION_8063_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_ACTION_8063_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_ACTION_8063_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_ACTION_8063_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_ACTION_8063_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_ACTION_8063_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_ACTION_8063_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_ACTION_8063_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8063_.tb0_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=EXP_ACTION_8063_.tb0_0(0),
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

 WHERE CONFIGURA_TYPE_ID = EXP_ACTION_8063_.tb0_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (EXP_ACTION_8063_.tb0_0(0),
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
EXP_ACTION_8063_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_8063_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8063_.old_tb1_0(0):=121401240;
EXP_ACTION_8063_.tb1_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
EXP_ACTION_8063_.tb1_0(0):=EXP_ACTION_8063_.tb1_0(0);
EXP_ACTION_8063_.old_tb1_1(0):='GE_EXEACTION_CT1E121401240'
;
EXP_ACTION_8063_.tb1_1(0):=TO_CHAR(EXP_ACTION_8063_.tb1_0(0));
EXP_ACTION_8063_.tb1_2(0):=EXP_ACTION_8063_.tb0_0(0);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (EXP_ACTION_8063_.tb1_0(0),
EXP_ACTION_8063_.tb1_1(0),
EXP_ACTION_8063_.tb1_2(0),
'GE_BOINT_MESSAGE.GETATTRIBUTETEXT("HEADER","INSTANCE_ID",NUINSTANCEID);GE_BOINT_MESSAGE.GETATTRIBUTETEXT("HEADER","EXTERNAL_ID",NUCOMPONENTID);IF (MO_BODATA.FDTGETVALUE("MO_COMPONENT","MEDIATION_DATE",NUCOMPONENTID)<> NULL,NUMOTIVETYPEID = MO_BODATA.FNUGETVALUE("MO_COMPONENT","MOTIVE_TYPE_ID",NUCOMPONENTID);IF (PS_BOMOTIVETYPE.FBOISACTIVATIONTYPE(NUMOTIVETYPEID) = GE_BOCONSTANTS.GETTRUE(),SM_BOSERVICEMEDIATION.REGISTERACTCOMPMOTIVE(NUCOMPONENTID,NUINSTANCEID,GE_BOCONSTANTS.GETFALSE());,SM_BOSERVICEMEDIATION.REGISTERACTCOMPMOTIVE(NUCOMPONENTID,NUINSTANCEID,GE_BOCONSTANTS.GETTRUE()););,)'
,
'LBTEST'
,
to_date('17-02-2011 11:54:40','DD-MM-YYYY HH24:MI:SS'),
to_date('28-02-2024 08:48:29','DD-MM-YYYY HH24:MI:SS'),
to_date('28-02-2024 08:48:29','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LBC - Deshacer Labores de mediaci¿n'
,
'PP'
,
null);

exception when others then
EXP_ACTION_8063_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_8063_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8063_.tb2_0(0):=8063;
EXP_ACTION_8063_.tb2_2(0):=EXP_ACTION_8063_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ACTION_MODULE fila (0)',1);
UPDATE GE_ACTION_MODULE SET ACTION_ID=EXP_ACTION_8063_.tb2_0(0),
MODULE_ID=14,
CONFIG_EXPRESSION_ID=EXP_ACTION_8063_.tb2_2(0),
DESCRIPTION='LBC - Deshacer Labores de mediaci¿n'
,
EXE_AT_STATUS_CHANGE='N'
,
EXE_TRANSITION_STATE='N'

 WHERE ACTION_ID = EXP_ACTION_8063_.tb2_0(0);
if not (sql%found) then
INSERT INTO GE_ACTION_MODULE(ACTION_ID,MODULE_ID,CONFIG_EXPRESSION_ID,DESCRIPTION,EXE_AT_STATUS_CHANGE,EXE_TRANSITION_STATE) 
VALUES (EXP_ACTION_8063_.tb2_0(0),
14,
EXP_ACTION_8063_.tb2_2(0),
'LBC - Deshacer Labores de mediaci¿n'
,
'N'
,
'N'
);
end if;

exception when others then
EXP_ACTION_8063_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_8063_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8063_.tb3_0(0):=EXP_ACTION_8063_.tb2_0(0);
EXP_ACTION_8063_.tb3_1(0):=4;
ut_trace.trace('insertando tabla sin fallo: GE_VALID_ACTION_MODU fila (0)',1);
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (EXP_ACTION_8063_.tb3_0(0),
EXP_ACTION_8063_.tb3_1(0));

exception 
when dup_val_on_index then 
 return;
when others then
EXP_ACTION_8063_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_8063_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8063_.tb3_0(1):=EXP_ACTION_8063_.tb2_0(0);
EXP_ACTION_8063_.tb3_1(1):=9;
ut_trace.trace('insertando tabla sin fallo: GE_VALID_ACTION_MODU fila (1)',1);
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (EXP_ACTION_8063_.tb3_0(1),
EXP_ACTION_8063_.tb3_1(1));

exception 
when dup_val_on_index then 
 return;
when others then
EXP_ACTION_8063_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_8063_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8063_.tb3_0(2):=EXP_ACTION_8063_.tb2_0(0);
EXP_ACTION_8063_.tb3_1(2):=14;
ut_trace.trace('insertando tabla sin fallo: GE_VALID_ACTION_MODU fila (2)',1);
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (EXP_ACTION_8063_.tb3_0(2),
EXP_ACTION_8063_.tb3_1(2));

exception 
when dup_val_on_index then 
 return;
when others then
EXP_ACTION_8063_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
DECLARE 
    nuBinaryIndex Binary_Integer;
BEGIN 
    nuBinaryIndex := EXP_ACTION_8063_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = EXP_ACTION_8063_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||EXP_ACTION_8063_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||EXP_ACTION_8063_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := EXP_ACTION_8063_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       EXP_ACTION_8063_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100237',1);
EXP_PROCESS_100237_.blProcessStatus := EXP_ACTION_8063_.blProcessStatus ; 
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

if (not EXP_ACTION_8063_.blProcessStatus) then
 return;
end if;
nuRowProcess:=EXP_ACTION_8063_.tb1_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| EXP_ACTION_8063_.tb1_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(EXP_ACTION_8063_.tb1_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| EXP_ACTION_8063_.tb1_0(nuRowProcess),1);
end;
nuRowProcess := EXP_ACTION_8063_.tb1_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
EXP_ACTION_8063_.blProcessStatus := false;
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
 nuIndex := EXP_ACTION_8063_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_ACTION_8063_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_ACTION_8063_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_ACTION_8063_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_ACTION_8063_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_ACTION_8063_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_ACTION_8063_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_ACTION_8063_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_ACTION_8063_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_ACTION_8063_******************************'); end;
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
        WHERE UNIT_TYPE_ID = 100237
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID IN 
           (SELECT UNIT_ID
           FROM WF_UNIT
           WHERE UNIT_TYPE_ID = 100237
       ))
;
BEGIN

if (not EXP_PROCESS_100237_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_PROCESS_100237_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100237) AND NODE_TYPE_ID=0);
BEGIN 

if (not EXP_PROCESS_100237_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_PROCESS_100237_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_PROCESS_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100237) AND NODE_TYPE_ID=0);
BEGIN 

if (not EXP_PROCESS_100237_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_PROCESS_100237_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_PROCESS_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100237) AND NODE_TYPE_ID=0;
nuIndex binary_integer;
BEGIN

if (not EXP_PROCESS_100237_.blProcessStatus) then
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
EXP_PROCESS_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_PROCESS_100237_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_PROCESS_100237_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_PROCESS_100237_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_PROCESS_100237_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_PROCESS_100237_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_PROCESS_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_PROCESS_100237_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_PROCESS_100237_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_PROCESS_100237_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_PROCESS_100237_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_PROCESS_100237_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_PROCESS_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100237;
nuIndex binary_integer;
BEGIN

if (not EXP_PROCESS_100237_.blProcessStatus) then
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
EXP_PROCESS_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_PROCESS_100237_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100237_.tb0_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_CATEGORY fila (0)',1);
UPDATE WF_UNIT_CATEGORY SET CATEGORY_ID=EXP_PROCESS_100237_.tb0_0(0),
DISPLAY_NUMBER='Proceso B¿sico'

 WHERE CATEGORY_ID = EXP_PROCESS_100237_.tb0_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_CATEGORY(CATEGORY_ID,DISPLAY_NUMBER) 
VALUES (EXP_PROCESS_100237_.tb0_0(0),
'Proceso B¿sico'
);
end if;

exception when others then
EXP_PROCESS_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100237_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100237_.tb1_0(0):=9;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (0)',1);
UPDATE GE_MODULE SET MODULE_ID=EXP_PROCESS_100237_.tb1_0(0),
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

 WHERE MODULE_ID = EXP_PROCESS_100237_.tb1_0(0);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (EXP_PROCESS_100237_.tb1_0(0),
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
EXP_PROCESS_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100237_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100237_.tb2_0(0):=100237;
EXP_PROCESS_100237_.tb2_1(0):=EXP_PROCESS_100237_.tb0_0(0);
EXP_PROCESS_100237_.tb2_2(0):=EXP_PROCESS_100237_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (0)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100237_.tb2_0(0),
CATEGORY_ID=EXP_PROCESS_100237_.tb2_1(0),
MODULE_ID=EXP_PROCESS_100237_.tb2_2(0),
ACTION_ID=null,
PARENT_ID=100213,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_100237'
,
DESCRIPTION='Contratrabajos - Mediaci¿n'
,
DISPLAY='Contratrabajos - Mediaci¿n'
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100237_.tb2_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100237_.tb2_0(0),
EXP_PROCESS_100237_.tb2_1(0),
EXP_PROCESS_100237_.tb2_2(0),
null,
100213,
null,
null,
null,
null,
'UNIT_TYPE_100237'
,
'Contratrabajos - Mediaci¿n'
,
'Contratrabajos - Mediaci¿n'
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
EXP_PROCESS_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100237_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100237_.tb3_0(0):=0;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (0)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100237_.tb3_0(0),
DESCRIPTION='Ra¿z'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100237_.tb3_0(0);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100237_.tb3_0(0),
'Ra¿z'
);
end if;

exception when others then
EXP_PROCESS_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100237_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100237_.tb4_0(0):=100913;
EXP_PROCESS_100237_.tb4_2(0):=EXP_PROCESS_100237_.tb2_0(0);
EXP_PROCESS_100237_.tb4_3(0):=EXP_PROCESS_100237_.tb3_0(0);
EXP_PROCESS_100237_.tb4_4(0):=EXP_PROCESS_100237_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (0)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100237_.tb4_0(0),
PROCESS_ID=null,
UNIT_TYPE_ID=EXP_PROCESS_100237_.tb4_2(0),
NODE_TYPE_ID=EXP_PROCESS_100237_.tb4_3(0),
MODULE_ID=EXP_PROCESS_100237_.tb4_4(0),
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

 WHERE UNIT_ID = EXP_PROCESS_100237_.tb4_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100237_.tb4_0(0),
null,
EXP_PROCESS_100237_.tb4_2(0),
EXP_PROCESS_100237_.tb4_3(0),
EXP_PROCESS_100237_.tb4_4(0),
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
EXP_PROCESS_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100237_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100237_.tb0_0(1):=2;
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_CATEGORY fila (1)',1);
UPDATE WF_UNIT_CATEGORY SET CATEGORY_ID=EXP_PROCESS_100237_.tb0_0(1),
DISPLAY_NUMBER='Actividad'

 WHERE CATEGORY_ID = EXP_PROCESS_100237_.tb0_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_CATEGORY(CATEGORY_ID,DISPLAY_NUMBER) 
VALUES (EXP_PROCESS_100237_.tb0_0(1),
'Actividad'
);
end if;

exception when others then
EXP_PROCESS_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100237_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100237_.tb2_0(1):=252;
EXP_PROCESS_100237_.tb2_1(1):=EXP_PROCESS_100237_.tb0_0(1);
EXP_PROCESS_100237_.tb2_2(1):=EXP_PROCESS_100237_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (1)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100237_.tb2_0(1),
CATEGORY_ID=EXP_PROCESS_100237_.tb2_1(1),
MODULE_ID=EXP_PROCESS_100237_.tb2_2(1),
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100237_.tb2_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100237_.tb2_0(1),
EXP_PROCESS_100237_.tb2_1(1),
EXP_PROCESS_100237_.tb2_2(1),
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
EXP_PROCESS_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100237_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100237_.tb3_0(1):=3;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (1)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100237_.tb3_0(1),
DESCRIPTION='Final'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100237_.tb3_0(1);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100237_.tb3_0(1),
'Final'
);
end if;

exception when others then
EXP_PROCESS_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100237_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100237_.tb4_0(1):=100916;
EXP_PROCESS_100237_.tb4_1(1):=EXP_PROCESS_100237_.tb4_0(0);
EXP_PROCESS_100237_.tb4_2(1):=EXP_PROCESS_100237_.tb2_0(1);
EXP_PROCESS_100237_.tb4_3(1):=EXP_PROCESS_100237_.tb3_0(1);
EXP_PROCESS_100237_.tb4_4(1):=EXP_PROCESS_100237_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (1)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100237_.tb4_0(1),
PROCESS_ID=EXP_PROCESS_100237_.tb4_1(1),
UNIT_TYPE_ID=EXP_PROCESS_100237_.tb4_2(1),
NODE_TYPE_ID=EXP_PROCESS_100237_.tb4_3(1),
MODULE_ID=EXP_PROCESS_100237_.tb4_4(1),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='439
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
ENTITY_ID=null,
VIEWABLE='N'

 WHERE UNIT_ID = EXP_PROCESS_100237_.tb4_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100237_.tb4_0(1),
EXP_PROCESS_100237_.tb4_1(1),
EXP_PROCESS_100237_.tb4_2(1),
EXP_PROCESS_100237_.tb4_3(1),
EXP_PROCESS_100237_.tb4_4(1),
null,
null,
null,
null,
'439
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
null,
'N'
);
end if;

exception when others then
EXP_PROCESS_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100237_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100237_.tb2_0(2):=283;
EXP_PROCESS_100237_.tb2_1(2):=EXP_PROCESS_100237_.tb0_0(1);
EXP_PROCESS_100237_.tb2_2(2):=EXP_PROCESS_100237_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (2)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100237_.tb2_0(2),
CATEGORY_ID=EXP_PROCESS_100237_.tb2_1(2),
MODULE_ID=EXP_PROCESS_100237_.tb2_2(2),
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100237_.tb2_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100237_.tb2_0(2),
EXP_PROCESS_100237_.tb2_1(2),
EXP_PROCESS_100237_.tb2_2(2),
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
EXP_PROCESS_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100237_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100237_.tb3_0(2):=1;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (2)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100237_.tb3_0(2),
DESCRIPTION='Arranque'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100237_.tb3_0(2);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100237_.tb3_0(2),
'Arranque'
);
end if;

exception when others then
EXP_PROCESS_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100237_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100237_.tb4_0(2):=100915;
EXP_PROCESS_100237_.tb4_1(2):=EXP_PROCESS_100237_.tb4_0(0);
EXP_PROCESS_100237_.tb4_2(2):=EXP_PROCESS_100237_.tb2_0(2);
EXP_PROCESS_100237_.tb4_3(2):=EXP_PROCESS_100237_.tb3_0(2);
EXP_PROCESS_100237_.tb4_4(2):=EXP_PROCESS_100237_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (2)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100237_.tb4_0(2),
PROCESS_ID=EXP_PROCESS_100237_.tb4_1(2),
UNIT_TYPE_ID=EXP_PROCESS_100237_.tb4_2(2),
NODE_TYPE_ID=EXP_PROCESS_100237_.tb4_3(2),
MODULE_ID=EXP_PROCESS_100237_.tb4_4(2),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='34
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
IS_COUNTABLE='N'
,
MIN_GROUP_SIZE=null,
EXECUTION_ORDER='A'
,
ANNULATION_ORDER='N'
,
ENTITY_ID=null,
VIEWABLE='N'

 WHERE UNIT_ID = EXP_PROCESS_100237_.tb4_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100237_.tb4_0(2),
EXP_PROCESS_100237_.tb4_1(2),
EXP_PROCESS_100237_.tb4_2(2),
EXP_PROCESS_100237_.tb4_3(2),
EXP_PROCESS_100237_.tb4_4(2),
null,
null,
null,
null,
'34
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
EXP_PROCESS_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100237_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100237_.tb5_0(0):=118940;
EXP_PROCESS_100237_.tb5_1(0):=EXP_PROCESS_100237_.tb4_0(2);
EXP_PROCESS_100237_.tb5_2(0):=EXP_PROCESS_100237_.tb4_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (0)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100237_.tb5_0(0),
ORIGIN_ID=EXP_PROCESS_100237_.tb5_1(0),
TARGET_ID=EXP_PROCESS_100237_.tb5_2(0),
GEOMETRY='114
328
444
328'
,
GROUP_ID=0,
EXPRESSION='FLAG_VALIDATE == NO o FLAG_VALIDATE == SI'
,
EXPRESSION_TYPE=0,
DESCRIPTION='Sin ¿rdenes de contratrabajos'
,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100237_.tb5_0(0);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100237_.tb5_0(0),
EXP_PROCESS_100237_.tb5_1(0),
EXP_PROCESS_100237_.tb5_2(0),
'114
328
444
328'
,
0,
'FLAG_VALIDATE == NO o FLAG_VALIDATE == SI'
,
0,
'Sin ¿rdenes de contratrabajos'
,
1);
end if;

exception when others then
EXP_PROCESS_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100237_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100237_.tb1_0(1):=14;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (1)',1);
UPDATE GE_MODULE SET MODULE_ID=EXP_PROCESS_100237_.tb1_0(1),
DESCRIPTION='Activaci¿n'
,
MNEMONIC='SM'
,
LAST_MESSAGE=1,
PATH_MODULE='Services_Mediator'
,
ICON_NAME=null,
LOCALIZATION='IN'

 WHERE MODULE_ID = EXP_PROCESS_100237_.tb1_0(1);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (EXP_PROCESS_100237_.tb1_0(1),
'Activaci¿n'
,
'SM'
,
1,
'Services_Mediator'
,
null,
'IN'
);
end if;

exception when others then
EXP_PROCESS_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100237_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100237_.tb2_0(3):=100240;
EXP_PROCESS_100237_.tb2_1(3):=EXP_PROCESS_100237_.tb0_0(1);
EXP_PROCESS_100237_.tb2_2(3):=EXP_PROCESS_100237_.tb1_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (3)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100237_.tb2_0(3),
CATEGORY_ID=EXP_PROCESS_100237_.tb2_1(3),
MODULE_ID=EXP_PROCESS_100237_.tb2_2(3),
ACTION_ID=8063,
PARENT_ID=100213,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_100240'
,
DESCRIPTION='Deshacer Labores de Mediaci¿n'
,
DISPLAY='Deshacer Labores de Mediaci¿n'
,
ICON=null,
IS_STAGE_PROCESS='N'
,
USABLE_IN_FLOW_STAGE='N'
,
ENTITY_ID=43,
MULTI_INSTANCE='C'
,
IS_COUNTABLE='N'
,
NOTIFICATION_ID=9012,
VIEWABLE='Y'
,
DEFAULT_PRIORITY_ID=null,
INITIAL_NOTIFY_TIME=null,
IS_ADMIN_PROCESS='N'
,
ASSIGN_NOTIFICATION_ID=null,
ASSIGNED_USER_ONLY=null
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100237_.tb2_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100237_.tb2_0(3),
EXP_PROCESS_100237_.tb2_1(3),
EXP_PROCESS_100237_.tb2_2(3),
8063,
100213,
null,
null,
null,
null,
'UNIT_TYPE_100240'
,
'Deshacer Labores de Mediaci¿n'
,
'Deshacer Labores de Mediaci¿n'
,
null,
'N'
,
'N'
,
43,
'C'
,
'N'
,
9012,
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
EXP_PROCESS_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100237_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100237_.tb3_0(3):=2;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (3)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100237_.tb3_0(3),
DESCRIPTION='Normal'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100237_.tb3_0(3);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100237_.tb3_0(3),
'Normal'
);
end if;

exception when others then
EXP_PROCESS_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100237_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100237_.tb6_0(0):=7;
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=EXP_PROCESS_100237_.tb6_0(0),
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

 WHERE CONFIGURA_TYPE_ID = EXP_PROCESS_100237_.tb6_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (EXP_PROCESS_100237_.tb6_0(0),
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
EXP_PROCESS_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100237_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100237_.old_tb7_0(0):=121401241;
EXP_PROCESS_100237_.tb7_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
EXP_PROCESS_100237_.tb7_0(0):=EXP_PROCESS_100237_.tb7_0(0);
EXP_PROCESS_100237_.old_tb7_1(0):='WFWF_PRE_RULECT7E121401241'
;
EXP_PROCESS_100237_.tb7_1(0):=TO_CHAR(EXP_PROCESS_100237_.tb7_0(0));
EXP_PROCESS_100237_.tb7_2(0):=EXP_PROCESS_100237_.tb6_0(0);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (EXP_PROCESS_100237_.tb7_0(0),
EXP_PROCESS_100237_.tb7_1(0),
EXP_PROCESS_100237_.tb7_2(0),
'GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstancia);GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstancia,null,"WF_INSTANCE","INSTANCE_ID",nuIdInstancia);WF_BOINSTANCE_TRANS.SETGROUPTRANSTONEXTTASKS(nuIdInstancia,252)'
,
'LBTEST'
,
to_date('25-02-2011 09:12:07','DD-MM-YYYY HH24:MI:SS'),
to_date('28-02-2024 08:48:41','DD-MM-YYYY HH24:MI:SS'),
to_date('28-02-2024 08:48:41','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Generar Grupo de Transiciones Salientes de Clones hacia una Tarea espec¿fica'
,
'PP'
,
null);

exception when others then
EXP_PROCESS_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100237_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100237_.tb6_0(1):=9;
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (1)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=EXP_PROCESS_100237_.tb6_0(1),
MODULE_ID=9,
DESCRIPTION='Reglas Post'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='WF_POST_RULE'

 WHERE CONFIGURA_TYPE_ID = EXP_PROCESS_100237_.tb6_0(1);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (EXP_PROCESS_100237_.tb6_0(1),
9,
'Reglas Post'
,
'PL'
,
'FD'
,
'DS'
,
'WF_POST_RULE'
);
end if;

exception when others then
EXP_PROCESS_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100237_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100237_.old_tb7_0(1):=121401242;
EXP_PROCESS_100237_.tb7_0(1):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
EXP_PROCESS_100237_.tb7_0(1):=EXP_PROCESS_100237_.tb7_0(1);
EXP_PROCESS_100237_.old_tb7_1(1):='WFWF_POST_RULECT9E121401242'
;
EXP_PROCESS_100237_.tb7_1(1):=TO_CHAR(EXP_PROCESS_100237_.tb7_0(1));
EXP_PROCESS_100237_.tb7_2(1):=EXP_PROCESS_100237_.tb6_0(1);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (1)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (EXP_PROCESS_100237_.tb7_0(1),
EXP_PROCESS_100237_.tb7_1(1),
EXP_PROCESS_100237_.tb7_2(1),
'Ge_boInstanceControl.GetCurrentInstance(sbInstance);Ge_boInstanceControl.GetAttributeNewValue(sbInstance, null, "WF_INSTANCE", "EXTERNAL_ID", sbComponentId);nuComponentId=UT_CONVERT.FNUCHARTONUMBER(sbComponentId);sbSysdate=UT_DATE.FSBSTR_SYSDATE();dtSysdate=UT_CONVERT.FNUCHARTODATE(sbSysdate);MO_BOCOMPONENT.UPDCHILDMEDIATIONDATE(sbComponentId,dtSysdate)'
,
'LBTEST'
,
to_date('25-02-2011 09:12:57','DD-MM-YYYY HH24:MI:SS'),
to_date('28-02-2024 08:48:41','DD-MM-YYYY HH24:MI:SS'),
to_date('28-02-2024 08:48:41','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Establece fecha de mediaci¿n componentes hijos directos'
,
'PP'
,
null);

exception when others then
EXP_PROCESS_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100237_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100237_.tb4_0(3):=100918;
EXP_PROCESS_100237_.tb4_1(3):=EXP_PROCESS_100237_.tb4_0(0);
EXP_PROCESS_100237_.tb4_2(3):=EXP_PROCESS_100237_.tb2_0(3);
EXP_PROCESS_100237_.tb4_3(3):=EXP_PROCESS_100237_.tb3_0(3);
EXP_PROCESS_100237_.tb4_4(3):=EXP_PROCESS_100237_.tb1_0(1);
EXP_PROCESS_100237_.tb4_6(3):=EXP_PROCESS_100237_.tb7_0(0);
EXP_PROCESS_100237_.tb4_7(3):=EXP_PROCESS_100237_.tb7_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (3)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100237_.tb4_0(3),
PROCESS_ID=EXP_PROCESS_100237_.tb4_1(3),
UNIT_TYPE_ID=EXP_PROCESS_100237_.tb4_2(3),
NODE_TYPE_ID=EXP_PROCESS_100237_.tb4_3(3),
MODULE_ID=EXP_PROCESS_100237_.tb4_4(3),
ACTION_ID=8063,
PRE_EXPRESSION_ID=EXP_PROCESS_100237_.tb4_6(3),
POS_EXPRESSION_ID=EXP_PROCESS_100237_.tb4_7(3),
NOTIFICATION_ID=9012,
GEOMETRY='212
172'
,
DESCRIPTION='Deshacer Labores de Mediaci¿n'
,
ONLINE_EXEC_ID=null,
MULTI_INSTANCE='C'
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
ENTITY_ID=43,
VIEWABLE='Y'

 WHERE UNIT_ID = EXP_PROCESS_100237_.tb4_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100237_.tb4_0(3),
EXP_PROCESS_100237_.tb4_1(3),
EXP_PROCESS_100237_.tb4_2(3),
EXP_PROCESS_100237_.tb4_3(3),
EXP_PROCESS_100237_.tb4_4(3),
8063,
EXP_PROCESS_100237_.tb4_6(3),
EXP_PROCESS_100237_.tb4_7(3),
9012,
'212
172'
,
'Deshacer Labores de Mediaci¿n'
,
null,
'C'
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
43,
'Y'
);
end if;

exception when others then
EXP_PROCESS_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100237_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100237_.tb5_0(1):=118946;
EXP_PROCESS_100237_.tb5_1(1):=EXP_PROCESS_100237_.tb4_0(3);
EXP_PROCESS_100237_.tb5_2(1):=EXP_PROCESS_100237_.tb4_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (1)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100237_.tb5_0(1),
ORIGIN_ID=EXP_PROCESS_100237_.tb5_1(1),
TARGET_ID=EXP_PROCESS_100237_.tb5_2(1),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION='CAUSAL == EXITO'
,
EXPRESSION_TYPE=0,
DESCRIPTION=null,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100237_.tb5_0(1);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100237_.tb5_0(1),
EXP_PROCESS_100237_.tb5_1(1),
EXP_PROCESS_100237_.tb5_2(1),
null,
0,
'CAUSAL == EXITO'
,
0,
null,
1);
end if;

exception when others then
EXP_PROCESS_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100237_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100237_.tb8_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTE_CLASS fila (0)',1);
UPDATE GE_ATTRIBUTE_CLASS SET ATTRIBUTE_CLASS_ID=EXP_PROCESS_100237_.tb8_0(0),
NAME='De Entitdad'
,
DESCRIPTION='Valores que ser¿n tra¿dos de la tabla base usando old record'

 WHERE ATTRIBUTE_CLASS_ID = EXP_PROCESS_100237_.tb8_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTE_CLASS(ATTRIBUTE_CLASS_ID,NAME,DESCRIPTION) 
VALUES (EXP_PROCESS_100237_.tb8_0(0),
'De Entitdad'
,
'Valores que ser¿n tra¿dos de la tabla base usando old record'
);
end if;

exception when others then
EXP_PROCESS_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100237_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100237_.tb9_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES_TYPE fila (0)',1);
UPDATE GE_ATTRIBUTES_TYPE SET ATTRIBUTE_TYPE_ID=EXP_PROCESS_100237_.tb9_0(0),
DESCRIPTION='NUMBER'
,
INTERNAL_TYPE=2,
INTERNAL_JAVA_TYPE=2
 WHERE ATTRIBUTE_TYPE_ID = EXP_PROCESS_100237_.tb9_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES_TYPE(ATTRIBUTE_TYPE_ID,DESCRIPTION,INTERNAL_TYPE,INTERNAL_JAVA_TYPE) 
VALUES (EXP_PROCESS_100237_.tb9_0(0),
'NUMBER'
,
2,
2);
end if;

exception when others then
EXP_PROCESS_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100237_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100237_.tb10_0(0):=400;
EXP_PROCESS_100237_.tb10_1(0):=EXP_PROCESS_100237_.tb8_0(0);
EXP_PROCESS_100237_.tb10_2(0):=EXP_PROCESS_100237_.tb9_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (0)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=EXP_PROCESS_100237_.tb10_0(0),
ATTRIBUTE_CLASS_ID=EXP_PROCESS_100237_.tb10_1(0),
ATTRIBUTE_TYPE_ID=EXP_PROCESS_100237_.tb10_2(0),
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

 WHERE ATTRIBUTE_ID = EXP_PROCESS_100237_.tb10_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,ATTRIBUTE_CLASS_ID,ATTRIBUTE_TYPE_ID,VALID_EXPRESSION,FATHER_ID,MODULE_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (EXP_PROCESS_100237_.tb10_0(0),
EXP_PROCESS_100237_.tb10_1(0),
EXP_PROCESS_100237_.tb10_2(0),
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
EXP_PROCESS_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100237_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100237_.tb11_0(0):=126445;
EXP_PROCESS_100237_.tb11_1(0):=EXP_PROCESS_100237_.tb4_0(1);
EXP_PROCESS_100237_.tb11_2(0):=EXP_PROCESS_100237_.tb10_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (0)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100237_.tb11_0(0),
UNIT_ID=EXP_PROCESS_100237_.tb11_1(0),
ATTRIBUTE_ID=EXP_PROCESS_100237_.tb11_2(0),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100237_.tb11_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100237_.tb11_0(0),
EXP_PROCESS_100237_.tb11_1(0),
EXP_PROCESS_100237_.tb11_2(0),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100237_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100237_.tb11_0(1):=126444;
EXP_PROCESS_100237_.tb11_1(1):=EXP_PROCESS_100237_.tb4_0(1);
EXP_PROCESS_100237_.tb11_2(1):=EXP_PROCESS_100237_.tb10_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (1)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100237_.tb11_0(1),
UNIT_ID=EXP_PROCESS_100237_.tb11_1(1),
ATTRIBUTE_ID=EXP_PROCESS_100237_.tb11_2(1),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100237_.tb11_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100237_.tb11_0(1),
EXP_PROCESS_100237_.tb11_1(1),
EXP_PROCESS_100237_.tb11_2(1),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100237_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100237_.tb5_0(2):=118945;
EXP_PROCESS_100237_.tb5_1(2):=EXP_PROCESS_100237_.tb4_0(2);
EXP_PROCESS_100237_.tb5_2(2):=EXP_PROCESS_100237_.tb4_0(3);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (2)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100237_.tb5_0(2),
ORIGIN_ID=EXP_PROCESS_100237_.tb5_1(2),
TARGET_ID=EXP_PROCESS_100237_.tb5_2(2),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION='FLAG_VALIDATE == SI'
,
EXPRESSION_TYPE=0,
DESCRIPTION=null,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100237_.tb5_0(2);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100237_.tb5_0(2),
EXP_PROCESS_100237_.tb5_1(2),
EXP_PROCESS_100237_.tb5_2(2),
null,
0,
'FLAG_VALIDATE == SI'
,
0,
null,
1);
end if;

exception when others then
EXP_PROCESS_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100237_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100237_.tb8_0(1):=8;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTE_CLASS fila (1)',1);
UPDATE GE_ATTRIBUTE_CLASS SET ATTRIBUTE_CLASS_ID=EXP_PROCESS_100237_.tb8_0(1),
NAME='Por Defecto General'
,
DESCRIPTION='Valores que ser¿n utilizados para clasificaci¿n gen¿rica'

 WHERE ATTRIBUTE_CLASS_ID = EXP_PROCESS_100237_.tb8_0(1);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTE_CLASS(ATTRIBUTE_CLASS_ID,NAME,DESCRIPTION) 
VALUES (EXP_PROCESS_100237_.tb8_0(1),
'Por Defecto General'
,
'Valores que ser¿n utilizados para clasificaci¿n gen¿rica'
);
end if;

exception when others then
EXP_PROCESS_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100237_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100237_.tb10_0(1):=442;
EXP_PROCESS_100237_.tb10_1(1):=EXP_PROCESS_100237_.tb8_0(1);
EXP_PROCESS_100237_.tb10_2(1):=EXP_PROCESS_100237_.tb9_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (1)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=EXP_PROCESS_100237_.tb10_0(1),
ATTRIBUTE_CLASS_ID=EXP_PROCESS_100237_.tb10_1(1),
ATTRIBUTE_TYPE_ID=EXP_PROCESS_100237_.tb10_2(1),
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

 WHERE ATTRIBUTE_ID = EXP_PROCESS_100237_.tb10_0(1);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,ATTRIBUTE_CLASS_ID,ATTRIBUTE_TYPE_ID,VALID_EXPRESSION,FATHER_ID,MODULE_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (EXP_PROCESS_100237_.tb10_0(1),
EXP_PROCESS_100237_.tb10_1(1),
EXP_PROCESS_100237_.tb10_2(1),
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
EXP_PROCESS_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100237_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100237_.old_tb12_0(0):=120197047;
EXP_PROCESS_100237_.tb12_0(0):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
EXP_PROCESS_100237_.tb12_0(0):=EXP_PROCESS_100237_.tb12_0(0);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (0)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (EXP_PROCESS_100237_.tb12_0(0),
9,
'LBC-Valida si se deben Realizar Contrabajos de Mediaci¿n'
,
'SELECT DECODE(COUNT(*), 0, 0, 1) FLAG_VALIDATE
    FROM wf_instance a, mo_component b, sm_interface c
    WHERE b.package_id = CF_BOAnnulment.fnuGetAnnulPack(:INST.EXTERNAL_ID:)
    AND a.external_id = b.component_id
    AND a.instance_id = c.external_id
    AND c.status_id = ge_boparameter.fnuget('|| chr(39) ||'SM_SEND_ORDE_STATUS'|| chr(39) ||')
    AND c.answer_message IS not null
    AND c.answer_message != '|| chr(39) ||'-'|| chr(39) ||''
,
'LBC-Valida si se deben Realizar Contrabajos de Mediaci¿n'
);

exception when others then
EXP_PROCESS_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100237_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100237_.tb11_0(2):=126452;
EXP_PROCESS_100237_.tb11_1(2):=EXP_PROCESS_100237_.tb4_0(2);
EXP_PROCESS_100237_.tb11_2(2):=EXP_PROCESS_100237_.tb10_0(1);
EXP_PROCESS_100237_.tb11_3(2):=EXP_PROCESS_100237_.tb12_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (2)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100237_.tb11_0(2),
UNIT_ID=EXP_PROCESS_100237_.tb11_1(2),
ATTRIBUTE_ID=EXP_PROCESS_100237_.tb11_2(2),
STATEMENT_ID=EXP_PROCESS_100237_.tb11_3(2),
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=1,
MANDATORY='Y'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100237_.tb11_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100237_.tb11_0(2),
EXP_PROCESS_100237_.tb11_1(2),
EXP_PROCESS_100237_.tb11_2(2),
EXP_PROCESS_100237_.tb11_3(2),
null,
'N'
,
1,
'Y'
);
end if;

exception when others then
EXP_PROCESS_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100237_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100237_.tb11_0(3):=126443;
EXP_PROCESS_100237_.tb11_1(3):=EXP_PROCESS_100237_.tb4_0(2);
EXP_PROCESS_100237_.tb11_2(3):=EXP_PROCESS_100237_.tb10_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (3)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100237_.tb11_0(3),
UNIT_ID=EXP_PROCESS_100237_.tb11_1(3),
ATTRIBUTE_ID=EXP_PROCESS_100237_.tb11_2(3),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=1,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100237_.tb11_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100237_.tb11_0(3),
EXP_PROCESS_100237_.tb11_1(3),
EXP_PROCESS_100237_.tb11_2(3),
null,
null,
'N'
,
1,
'N'
);
end if;

exception when others then
EXP_PROCESS_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100237_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100237_.tb11_0(4):=126454;
EXP_PROCESS_100237_.tb11_1(4):=EXP_PROCESS_100237_.tb4_0(3);
EXP_PROCESS_100237_.tb11_2(4):=EXP_PROCESS_100237_.tb10_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (4)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100237_.tb11_0(4),
UNIT_ID=EXP_PROCESS_100237_.tb11_1(4),
ATTRIBUTE_ID=EXP_PROCESS_100237_.tb11_2(4),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='Y'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100237_.tb11_0(4);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100237_.tb11_0(4),
EXP_PROCESS_100237_.tb11_1(4),
EXP_PROCESS_100237_.tb11_2(4),
null,
null,
'N'
,
2,
'Y'
);
end if;

exception when others then
EXP_PROCESS_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100237_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100237_.tb10_0(2):=401;
EXP_PROCESS_100237_.tb10_1(2):=EXP_PROCESS_100237_.tb8_0(1);
EXP_PROCESS_100237_.tb10_2(2):=EXP_PROCESS_100237_.tb9_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (2)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=EXP_PROCESS_100237_.tb10_0(2),
ATTRIBUTE_CLASS_ID=EXP_PROCESS_100237_.tb10_1(2),
ATTRIBUTE_TYPE_ID=EXP_PROCESS_100237_.tb10_2(2),
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

 WHERE ATTRIBUTE_ID = EXP_PROCESS_100237_.tb10_0(2);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,ATTRIBUTE_CLASS_ID,ATTRIBUTE_TYPE_ID,VALID_EXPRESSION,FATHER_ID,MODULE_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (EXP_PROCESS_100237_.tb10_0(2),
EXP_PROCESS_100237_.tb10_1(2),
EXP_PROCESS_100237_.tb10_2(2),
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
EXP_PROCESS_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100237_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100237_.old_tb12_0(1):=120197048;
EXP_PROCESS_100237_.tb12_0(1):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
EXP_PROCESS_100237_.tb12_0(1):=EXP_PROCESS_100237_.tb12_0(1);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (1)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (EXP_PROCESS_100237_.tb12_0(1),
9,
'LBC-Obtiene los Componentes de la Solicitud Para los Cuales se Requiere Generar ¿rdenes Para Deshacer un Proceso de Activaci¿n/Desactivaci¿n'
,
'SELECT b.component_id EXTERNAL_ID
FROM wf_instance a, mo_component b, sm_interface c,wf_instance d
WHERE d.instance_id = WF_BOINSTANCE_TRANS.FNUGETBEFORETASKS(:INST.INSTANCE_ID:, 283)
AND b.package_id = CF_BOAnnulment.fnuGetAnnulPack(d.external_id)
AND a.external_id = b.component_id
AND a.instance_id = c.external_id
AND c.status_id = ge_boparameter.fnuget('|| chr(39) ||'SM_SEND_ORDE_STATUS'|| chr(39) ||')
AND c.answer_message IS not null
AND c.answer_message != '|| chr(39) ||'-'|| chr(39) ||''
,
'LBC-Obtiene los Componentes de la Solicitud para Generaci¿n de Contra¿rdenes de Mediaci¿n'
);

exception when others then
EXP_PROCESS_100237_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100237_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100237_.tb11_0(5):=126459;
EXP_PROCESS_100237_.tb11_1(5):=EXP_PROCESS_100237_.tb4_0(3);
EXP_PROCESS_100237_.tb11_2(5):=EXP_PROCESS_100237_.tb10_0(2);
EXP_PROCESS_100237_.tb11_3(5):=EXP_PROCESS_100237_.tb12_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (5)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100237_.tb11_0(5),
UNIT_ID=EXP_PROCESS_100237_.tb11_1(5),
ATTRIBUTE_ID=EXP_PROCESS_100237_.tb11_2(5),
STATEMENT_ID=EXP_PROCESS_100237_.tb11_3(5),
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=1,
MANDATORY='Y'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100237_.tb11_0(5);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100237_.tb11_0(5),
EXP_PROCESS_100237_.tb11_1(5),
EXP_PROCESS_100237_.tb11_2(5),
EXP_PROCESS_100237_.tb11_3(5),
null,
'N'
,
1,
'Y'
);
end if;

exception when others then
EXP_PROCESS_100237_.blProcessStatus := false;
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
sa_bocreatePackages.CreatePackage('EXP_UNITTYPE_100240_',
'CREATE OR REPLACE PACKAGE EXP_UNITTYPE_100240_ IS ' || chr(10) ||
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
'tb1_1 ty1_1; ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_UNITTYPE_100240_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_UNITTYPE_100240_******************************'); END;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_UNITTYPE_100240',1);
EXP_UNITTYPE_100240_.blProcessStatus := EXP_PROCESS_100237_.blProcessStatus ; 
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
AND     A.TASK_CODE = 100240
 
;
BEGIN

if (not EXP_UNITTYPE_100240_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_UNITTYPE_100240_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
FROM WF_UNIT_TYPE_ATTRIB WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100240);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100240_.blProcessStatus) then
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
EXP_UNITTYPE_100240_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_CAUSAL_UNIT_TYPE WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100240);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100240_.blProcessStatus) then
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
EXP_UNITTYPE_100240_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM MO_TIME_UNI_TYP_PRIO WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100240);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100240_.blProcessStatus) then
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
EXP_UNITTYPE_100240_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM OR_ACT_BY_TASK_MOD WHERE (TASK_CODE) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100240);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100240_.blProcessStatus) then
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
EXP_UNITTYPE_100240_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100240;
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100240_.blProcessStatus) then
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
EXP_UNITTYPE_100240_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_UNITTYPE_100240_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100240_.tb0_0(0):=100240;
ut_trace.trace('insertando tabla sin fallo: WF_UNIT_TYPE fila (0)',1);
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_UNITTYPE_100240_.tb0_0(0),
2,
14,
8063,
100213,
null,
null,
null,
null,
'UNIT_TYPE_100240'
,
'Deshacer Labores de Mediaci¿n'
,
'Deshacer Labores de Mediaci¿n'
,
null,
'N'
,
'N'
,
43,
'C'
,
'N'
,
9012,
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
EXP_UNITTYPE_100240_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_UNITTYPE_100240_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100240_.tb1_0(0):=1;
EXP_UNITTYPE_100240_.tb1_1(0):=EXP_UNITTYPE_100240_.tb0_0(0);
ut_trace.trace('insertando tabla sin fallo: WF_CAUSAL_UNIT_TYPE fila (0)',1);
INSERT INTO WF_CAUSAL_UNIT_TYPE(CAUSAL_ID,UNIT_TYPE_ID,ALIAS) 
VALUES (EXP_UNITTYPE_100240_.tb1_0(0),
EXP_UNITTYPE_100240_.tb1_1(0),
'EXITO'
);

exception 
when dup_val_on_index then 
 return;
when others then
EXP_UNITTYPE_100240_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100237',1);
EXP_PROCESS_100237_.blProcessStatus := EXP_UNITTYPE_100240_.blProcessStatus ; 
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
 nuIndex := EXP_UNITTYPE_100240_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_UNITTYPE_100240_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_UNITTYPE_100240_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_UNITTYPE_100240_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_UNITTYPE_100240_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_UNITTYPE_100240_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_UNITTYPE_100240_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_UNITTYPE_100240_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_UNITTYPE_100240_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_UNITTYPE_100240_******************************'); end;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100248',1);
EXP_PROCESS_100248_.blProcessStatus := EXP_PROCESS_100237_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
DECLARE 
    nuBinaryIndex Binary_Integer;
BEGIN 
    nuBinaryIndex := EXP_PROCESS_100237_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = EXP_PROCESS_100237_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||EXP_PROCESS_100237_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||EXP_PROCESS_100237_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := EXP_PROCESS_100237_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       EXP_PROCESS_100237_.blProcessStatus := FALSE;
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

if (not EXP_PROCESS_100237_.blProcessStatus) then
 return;
end if;
nuRowProcess:=EXP_PROCESS_100237_.tb7_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| EXP_PROCESS_100237_.tb7_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(EXP_PROCESS_100237_.tb7_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| EXP_PROCESS_100237_.tb7_0(nuRowProcess),1);
end;
nuRowProcess := EXP_PROCESS_100237_.tb7_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
EXP_PROCESS_100237_.blProcessStatus := false;
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
 nuIndex := EXP_PROCESS_100237_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_PROCESS_100237_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_PROCESS_100237_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_PROCESS_100237_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_PROCESS_100237_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_PROCESS_100237_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_PROCESS_100237_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_PROCESS_100237_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_PROCESS_100237_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_PROCESS_100237_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_PROCESS_100235_',
'CREATE OR REPLACE PACKAGE EXP_PROCESS_100235_ IS ' || chr(10) ||
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
'        WHERE UNIT_TYPE_ID = 100235 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID IN  ' || chr(10) ||
'           (SELECT UNIT_ID ' || chr(10) ||
'           FROM WF_UNIT ' || chr(10) ||
'           WHERE UNIT_TYPE_ID = 100235 ' || chr(10) ||
'       )) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_TYPE_ID = 100235 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID IN  ' || chr(10) ||
'           (SELECT UNIT_ID ' || chr(10) ||
'           FROM WF_UNIT ' || chr(10) ||
'           WHERE UNIT_TYPE_ID = 100235 ' || chr(10) ||
'       )) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_PROCESS_100235_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_PROCESS_100235_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open EXP_PROCESS_100235_.cuExpression;
   fetch EXP_PROCESS_100235_.cuExpression bulk collect INTO EXP_PROCESS_100235_.tbGR_CONFIG_EXPRESSIONId;
   close EXP_PROCESS_100235_.cuExpression;
END;
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100235',1);
EXP_PROCESS_100235_.blProcessStatus := EXP_PROCESS_100248_.blProcessStatus ; 
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
sa_bocreatePackages.CreatePackage('DEL_ROOT_100908_',
'CREATE OR REPLACE PACKAGE DEL_ROOT_100908_ IS ' || chr(10) ||
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
'        WHERE UNIT_ID = 100908 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 100908  ' || chr(10) ||
'       ) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_ID = 100908 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 100908  ' || chr(10) ||
'       ) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END DEL_ROOT_100908_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:DEL_ROOT_100908_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open DEL_ROOT_100908_.cuExpression;
   fetch DEL_ROOT_100908_.cuExpression bulk collect INTO DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONId;
   close DEL_ROOT_100908_.cuExpression;
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
        WHERE UNIT_ID = 100908
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID = 100908 
       )
;
BEGIN

if (not DEL_ROOT_100908_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  DEL_ROOT_100908_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE PROCESS_ID = 100908);
BEGIN 

if (not DEL_ROOT_100908_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100908_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE PROCESS_ID = 100908);
BEGIN 

if (not DEL_ROOT_100908_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100908_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 100908)));
BEGIN 

if (not DEL_ROOT_100908_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100908_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 100908)));
BEGIN 

if (not DEL_ROOT_100908_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100908_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 100908));
BEGIN 

if (not DEL_ROOT_100908_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla WF_UNIT',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100908_.tbWF_UNITRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100908_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 100908);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100908_.blProcessStatus) then
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
DEL_ROOT_100908_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100908_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100908_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100908_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100908_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100908_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria WF_UNIT',1);
nuVarcharIndex:=DEL_ROOT_100908_.tbWF_UNITRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from WF_UNIT where rowid = DEL_ROOT_100908_.tbWF_UNITRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100908_.tbWF_UNITRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100908_.tbWF_UNITRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100908_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_DATA_MAP WHERE (SOURCE_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 100908));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100908_.blProcessStatus) then
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
DEL_ROOT_100908_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_DATA_MAP WHERE (TARGET_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 100908));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100908_.blProcessStatus) then
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
DEL_ROOT_100908_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 100908);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100908_.blProcessStatus) then
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
DEL_ROOT_100908_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT WHERE PROCESS_ID = 100908;
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100908_.blProcessStatus) then
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
DEL_ROOT_100908_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100908_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100908_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100908_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100908_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/

BEGIN
    ut_trace.trace('Actualizar WF_UNIT a ProcessId NULL ',1);
   UPDATE WF_UNIT 
     SET PROCESS_ID = -1, POS_EXPRESSION_ID = null, PRE_EXPRESSION_ID = null, ACTION_ID = null 
     WHERE PROCESS_ID = 100908;
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
    nuBinaryIndex := DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       DEL_ROOT_100908_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100235',1);
EXP_PROCESS_100235_.blProcessStatus := DEL_ROOT_100908_.blProcessStatus ; 
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
 nuIndex := DEL_ROOT_100908_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || DEL_ROOT_100908_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(DEL_ROOT_100908_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(DEL_ROOT_100908_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(DEL_ROOT_100908_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || DEL_ROOT_100908_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || DEL_ROOT_100908_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := DEL_ROOT_100908_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('DEL_ROOT_100908_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:DEL_ROOT_100908_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('DEL_ROOT_100908_',
'CREATE OR REPLACE PACKAGE DEL_ROOT_100908_ IS ' || chr(10) ||
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
'        WHERE UNIT_ID = 100908 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 100908  ' || chr(10) ||
'       ) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_ID = 100908 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 100908  ' || chr(10) ||
'       ) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END DEL_ROOT_100908_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:DEL_ROOT_100908_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open DEL_ROOT_100908_.cuExpression;
   fetch DEL_ROOT_100908_.cuExpression bulk collect INTO DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONId;
   close DEL_ROOT_100908_.cuExpression;
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
        WHERE UNIT_ID = 100908
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID = 100908 
       )
;
BEGIN

if (not DEL_ROOT_100908_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  DEL_ROOT_100908_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE UNIT_ID = 100908);
BEGIN 

if (not DEL_ROOT_100908_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100908_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE UNIT_ID = 100908);
BEGIN 

if (not DEL_ROOT_100908_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100908_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 100908)));
BEGIN 

if (not DEL_ROOT_100908_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100908_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 100908)));
BEGIN 

if (not DEL_ROOT_100908_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100908_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 100908));
BEGIN 

if (not DEL_ROOT_100908_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla WF_UNIT',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100908_.tbWF_UNITRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100908_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 100908);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100908_.blProcessStatus) then
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
DEL_ROOT_100908_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100908_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100908_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100908_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100908_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100908_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria WF_UNIT',1);
nuVarcharIndex:=DEL_ROOT_100908_.tbWF_UNITRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from WF_UNIT where rowid = DEL_ROOT_100908_.tbWF_UNITRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100908_.tbWF_UNITRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100908_.tbWF_UNITRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100908_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_DATA_MAP WHERE (SOURCE_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 100908));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100908_.blProcessStatus) then
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
DEL_ROOT_100908_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_DATA_MAP WHERE (TARGET_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 100908));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100908_.blProcessStatus) then
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
DEL_ROOT_100908_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 100908);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100908_.blProcessStatus) then
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
DEL_ROOT_100908_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT WHERE UNIT_ID = 100908;
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100908_.blProcessStatus) then
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
DEL_ROOT_100908_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100908_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100908_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100908_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100908_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/

BEGIN
    ut_trace.trace('Actualizar WF_UNIT a ProcessId NULL ',1);
   UPDATE WF_UNIT 
     SET PROCESS_ID = -1, POS_EXPRESSION_ID = null, PRE_EXPRESSION_ID = null, ACTION_ID = null 
     WHERE PROCESS_ID = 100908;
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
    nuBinaryIndex := DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := DEL_ROOT_100908_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       DEL_ROOT_100908_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100235',1);
EXP_PROCESS_100235_.blProcessStatus := DEL_ROOT_100908_.blProcessStatus ; 
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
 nuIndex := DEL_ROOT_100908_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || DEL_ROOT_100908_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(DEL_ROOT_100908_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(DEL_ROOT_100908_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(DEL_ROOT_100908_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || DEL_ROOT_100908_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || DEL_ROOT_100908_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := DEL_ROOT_100908_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('DEL_ROOT_100908_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:DEL_ROOT_100908_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_ACTION_8066_',
'CREATE OR REPLACE PACKAGE EXP_ACTION_8066_ IS ' || chr(10) ||
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
'WHERE  ACTION_ID =8066; ' || chr(10) ||
'type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_ACTION_8066_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_ACTION_8066_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open EXP_ACTION_8066_.cuExpression;
   fetch EXP_ACTION_8066_.cuExpression bulk collect INTO EXP_ACTION_8066_.tbGR_CONFIG_EXPRESSIONId;
   close EXP_ACTION_8066_.cuExpression;
END;
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_ACTION_8066',1);
EXP_ACTION_8066_.blProcessStatus := EXP_PROCESS_100235_.blProcessStatus ; 
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
AND     A.ACTION_ID =8066
;
BEGIN

if (not EXP_ACTION_8066_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_ACTION_8066_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE ACTION_ID=8066);
BEGIN 

if (not EXP_ACTION_8066_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_ACTION_8066_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_ACTION_8066_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM GE_ACTION_MODULE WHERE ACTION_ID=8066;
nuIndex binary_integer;
BEGIN

if (not EXP_ACTION_8066_.blProcessStatus) then
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
EXP_ACTION_8066_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_ACTION_8066_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_ACTION_8066_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_ACTION_8066_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_ACTION_8066_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_ACTION_8066_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_ACTION_8066_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_ACTION_8066_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8066_.tb0_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=EXP_ACTION_8066_.tb0_0(0),
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

 WHERE CONFIGURA_TYPE_ID = EXP_ACTION_8066_.tb0_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (EXP_ACTION_8066_.tb0_0(0),
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
EXP_ACTION_8066_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_8066_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8066_.old_tb1_0(0):=121401243;
EXP_ACTION_8066_.tb1_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
EXP_ACTION_8066_.tb1_0(0):=EXP_ACTION_8066_.tb1_0(0);
EXP_ACTION_8066_.old_tb1_1(0):='GE_EXEACTION_CT1E121401243'
;
EXP_ACTION_8066_.tb1_1(0):=TO_CHAR(EXP_ACTION_8066_.tb1_0(0));
EXP_ACTION_8066_.tb1_2(0):=EXP_ACTION_8066_.tb0_0(0);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (EXP_ACTION_8066_.tb1_0(0),
EXP_ACTION_8066_.tb1_1(0),
EXP_ACTION_8066_.tb1_2(0),
'CF_BOACTIONS.ANNULSTATS()'
,
'LBTEST'
,
to_date('18-02-2011 18:13:53','DD-MM-YYYY HH24:MI:SS'),
to_date('28-02-2024 08:48:53','DD-MM-YYYY HH24:MI:SS'),
to_date('28-02-2024 08:48:53','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LBC - Reversa Estados x Anulaci¿n'
,
'PP'
,
null);

exception when others then
EXP_ACTION_8066_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_8066_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8066_.tb2_0(0):=8066;
EXP_ACTION_8066_.tb2_2(0):=EXP_ACTION_8066_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ACTION_MODULE fila (0)',1);
UPDATE GE_ACTION_MODULE SET ACTION_ID=EXP_ACTION_8066_.tb2_0(0),
MODULE_ID=5,
CONFIG_EXPRESSION_ID=EXP_ACTION_8066_.tb2_2(0),
DESCRIPTION='LBC - Reversa Estados x Anulaci¿n'
,
EXE_AT_STATUS_CHANGE='N'
,
EXE_TRANSITION_STATE='N'

 WHERE ACTION_ID = EXP_ACTION_8066_.tb2_0(0);
if not (sql%found) then
INSERT INTO GE_ACTION_MODULE(ACTION_ID,MODULE_ID,CONFIG_EXPRESSION_ID,DESCRIPTION,EXE_AT_STATUS_CHANGE,EXE_TRANSITION_STATE) 
VALUES (EXP_ACTION_8066_.tb2_0(0),
5,
EXP_ACTION_8066_.tb2_2(0),
'LBC - Reversa Estados x Anulaci¿n'
,
'N'
,
'N'
);
end if;

exception when others then
EXP_ACTION_8066_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_8066_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8066_.tb3_0(0):=EXP_ACTION_8066_.tb2_0(0);
EXP_ACTION_8066_.tb3_1(0):=5;
ut_trace.trace('insertando tabla sin fallo: GE_VALID_ACTION_MODU fila (0)',1);
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (EXP_ACTION_8066_.tb3_0(0),
EXP_ACTION_8066_.tb3_1(0));

exception 
when dup_val_on_index then 
 return;
when others then
EXP_ACTION_8066_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_8066_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8066_.tb3_0(1):=EXP_ACTION_8066_.tb2_0(0);
EXP_ACTION_8066_.tb3_1(1):=9;
ut_trace.trace('insertando tabla sin fallo: GE_VALID_ACTION_MODU fila (1)',1);
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (EXP_ACTION_8066_.tb3_0(1),
EXP_ACTION_8066_.tb3_1(1));

exception 
when dup_val_on_index then 
 return;
when others then
EXP_ACTION_8066_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_8066_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8066_.tb3_0(2):=EXP_ACTION_8066_.tb2_0(0);
EXP_ACTION_8066_.tb3_1(2):=16;
ut_trace.trace('insertando tabla sin fallo: GE_VALID_ACTION_MODU fila (2)',1);
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (EXP_ACTION_8066_.tb3_0(2),
EXP_ACTION_8066_.tb3_1(2));

exception 
when dup_val_on_index then 
 return;
when others then
EXP_ACTION_8066_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
DECLARE 
    nuBinaryIndex Binary_Integer;
BEGIN 
    nuBinaryIndex := EXP_ACTION_8066_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = EXP_ACTION_8066_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||EXP_ACTION_8066_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||EXP_ACTION_8066_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := EXP_ACTION_8066_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       EXP_ACTION_8066_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100235',1);
EXP_PROCESS_100235_.blProcessStatus := EXP_ACTION_8066_.blProcessStatus ; 
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

if (not EXP_ACTION_8066_.blProcessStatus) then
 return;
end if;
nuRowProcess:=EXP_ACTION_8066_.tb1_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| EXP_ACTION_8066_.tb1_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(EXP_ACTION_8066_.tb1_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| EXP_ACTION_8066_.tb1_0(nuRowProcess),1);
end;
nuRowProcess := EXP_ACTION_8066_.tb1_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
EXP_ACTION_8066_.blProcessStatus := false;
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
 nuIndex := EXP_ACTION_8066_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_ACTION_8066_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_ACTION_8066_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_ACTION_8066_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_ACTION_8066_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_ACTION_8066_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_ACTION_8066_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_ACTION_8066_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_ACTION_8066_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_ACTION_8066_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_ACTION_8067_',
'CREATE OR REPLACE PACKAGE EXP_ACTION_8067_ IS ' || chr(10) ||
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
'WHERE  ACTION_ID =8067; ' || chr(10) ||
'type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_ACTION_8067_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_ACTION_8067_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open EXP_ACTION_8067_.cuExpression;
   fetch EXP_ACTION_8067_.cuExpression bulk collect INTO EXP_ACTION_8067_.tbGR_CONFIG_EXPRESSIONId;
   close EXP_ACTION_8067_.cuExpression;
END;
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_ACTION_8067',1);
EXP_ACTION_8067_.blProcessStatus := EXP_PROCESS_100235_.blProcessStatus ; 
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
AND     A.ACTION_ID =8067
;
BEGIN

if (not EXP_ACTION_8067_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_ACTION_8067_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE ACTION_ID=8067);
BEGIN 

if (not EXP_ACTION_8067_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_ACTION_8067_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_ACTION_8067_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM GE_ACTION_MODULE WHERE ACTION_ID=8067;
nuIndex binary_integer;
BEGIN

if (not EXP_ACTION_8067_.blProcessStatus) then
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
EXP_ACTION_8067_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_ACTION_8067_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_ACTION_8067_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_ACTION_8067_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_ACTION_8067_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_ACTION_8067_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_ACTION_8067_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_ACTION_8067_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8067_.tb0_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=EXP_ACTION_8067_.tb0_0(0),
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

 WHERE CONFIGURA_TYPE_ID = EXP_ACTION_8067_.tb0_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (EXP_ACTION_8067_.tb0_0(0),
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
EXP_ACTION_8067_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_8067_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8067_.old_tb1_0(0):=121401244;
EXP_ACTION_8067_.tb1_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
EXP_ACTION_8067_.tb1_0(0):=EXP_ACTION_8067_.tb1_0(0);
EXP_ACTION_8067_.old_tb1_1(0):='GE_EXEACTION_CT1E121401244'
;
EXP_ACTION_8067_.tb1_1(0):=TO_CHAR(EXP_ACTION_8067_.tb1_0(0));
EXP_ACTION_8067_.tb1_2(0):=EXP_ACTION_8067_.tb0_0(0);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (EXP_ACTION_8067_.tb1_0(0),
EXP_ACTION_8067_.tb1_1(0),
EXP_ACTION_8067_.tb1_2(0),
'nuPackageId = MO_BOINSTANCE_DB.FNUGETPACKIDINSTANCE();CF_BOACTIONS.UPDATEELEMENTCATEGORY(nuPackageId)'
,
'LBTEST'
,
to_date('24-02-2011 10:02:41','DD-MM-YYYY HH24:MI:SS'),
to_date('28-02-2024 08:48:57','DD-MM-YYYY HH24:MI:SS'),
to_date('28-02-2024 08:48:57','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'LBC - Actualiza categor¿a de los elementos'
,
'PP'
,
null);

exception when others then
EXP_ACTION_8067_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_8067_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8067_.tb2_0(0):=8067;
EXP_ACTION_8067_.tb2_2(0):=EXP_ACTION_8067_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ACTION_MODULE fila (0)',1);
UPDATE GE_ACTION_MODULE SET ACTION_ID=EXP_ACTION_8067_.tb2_0(0),
MODULE_ID=5,
CONFIG_EXPRESSION_ID=EXP_ACTION_8067_.tb2_2(0),
DESCRIPTION='LBC - Actualiza Categor¿a de Elementos de Red x Anulaci¿n'
,
EXE_AT_STATUS_CHANGE='N'
,
EXE_TRANSITION_STATE='N'

 WHERE ACTION_ID = EXP_ACTION_8067_.tb2_0(0);
if not (sql%found) then
INSERT INTO GE_ACTION_MODULE(ACTION_ID,MODULE_ID,CONFIG_EXPRESSION_ID,DESCRIPTION,EXE_AT_STATUS_CHANGE,EXE_TRANSITION_STATE) 
VALUES (EXP_ACTION_8067_.tb2_0(0),
5,
EXP_ACTION_8067_.tb2_2(0),
'LBC - Actualiza Categor¿a de Elementos de Red x Anulaci¿n'
,
'N'
,
'N'
);
end if;

exception when others then
EXP_ACTION_8067_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_8067_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8067_.tb3_0(0):=EXP_ACTION_8067_.tb2_0(0);
EXP_ACTION_8067_.tb3_1(0):=5;
ut_trace.trace('insertando tabla sin fallo: GE_VALID_ACTION_MODU fila (0)',1);
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (EXP_ACTION_8067_.tb3_0(0),
EXP_ACTION_8067_.tb3_1(0));

exception 
when dup_val_on_index then 
 return;
when others then
EXP_ACTION_8067_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_8067_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8067_.tb3_0(1):=EXP_ACTION_8067_.tb2_0(0);
EXP_ACTION_8067_.tb3_1(1):=9;
ut_trace.trace('insertando tabla sin fallo: GE_VALID_ACTION_MODU fila (1)',1);
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (EXP_ACTION_8067_.tb3_0(1),
EXP_ACTION_8067_.tb3_1(1));

exception 
when dup_val_on_index then 
 return;
when others then
EXP_ACTION_8067_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_8067_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8067_.tb3_0(2):=EXP_ACTION_8067_.tb2_0(0);
EXP_ACTION_8067_.tb3_1(2):=16;
ut_trace.trace('insertando tabla sin fallo: GE_VALID_ACTION_MODU fila (2)',1);
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (EXP_ACTION_8067_.tb3_0(2),
EXP_ACTION_8067_.tb3_1(2));

exception 
when dup_val_on_index then 
 return;
when others then
EXP_ACTION_8067_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
DECLARE 
    nuBinaryIndex Binary_Integer;
BEGIN 
    nuBinaryIndex := EXP_ACTION_8067_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = EXP_ACTION_8067_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||EXP_ACTION_8067_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||EXP_ACTION_8067_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := EXP_ACTION_8067_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       EXP_ACTION_8067_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100235',1);
EXP_PROCESS_100235_.blProcessStatus := EXP_ACTION_8067_.blProcessStatus ; 
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

if (not EXP_ACTION_8067_.blProcessStatus) then
 return;
end if;
nuRowProcess:=EXP_ACTION_8067_.tb1_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| EXP_ACTION_8067_.tb1_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(EXP_ACTION_8067_.tb1_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| EXP_ACTION_8067_.tb1_0(nuRowProcess),1);
end;
nuRowProcess := EXP_ACTION_8067_.tb1_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
EXP_ACTION_8067_.blProcessStatus := false;
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
 nuIndex := EXP_ACTION_8067_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_ACTION_8067_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_ACTION_8067_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_ACTION_8067_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_ACTION_8067_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_ACTION_8067_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_ACTION_8067_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_ACTION_8067_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_ACTION_8067_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_ACTION_8067_******************************'); end;
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
        WHERE UNIT_TYPE_ID = 100235
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID IN 
           (SELECT UNIT_ID
           FROM WF_UNIT
           WHERE UNIT_TYPE_ID = 100235
       ))
;
BEGIN

if (not EXP_PROCESS_100235_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_PROCESS_100235_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100235) AND NODE_TYPE_ID=0);
BEGIN 

if (not EXP_PROCESS_100235_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_PROCESS_100235_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_PROCESS_100235_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100235) AND NODE_TYPE_ID=0);
BEGIN 

if (not EXP_PROCESS_100235_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_PROCESS_100235_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_PROCESS_100235_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100235) AND NODE_TYPE_ID=0;
nuIndex binary_integer;
BEGIN

if (not EXP_PROCESS_100235_.blProcessStatus) then
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
EXP_PROCESS_100235_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_PROCESS_100235_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_PROCESS_100235_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_PROCESS_100235_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_PROCESS_100235_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_PROCESS_100235_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_PROCESS_100235_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_PROCESS_100235_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_PROCESS_100235_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_PROCESS_100235_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_PROCESS_100235_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_PROCESS_100235_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_PROCESS_100235_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100235;
nuIndex binary_integer;
BEGIN

if (not EXP_PROCESS_100235_.blProcessStatus) then
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
EXP_PROCESS_100235_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_PROCESS_100235_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100235_.tb0_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_CATEGORY fila (0)',1);
UPDATE WF_UNIT_CATEGORY SET CATEGORY_ID=EXP_PROCESS_100235_.tb0_0(0),
DISPLAY_NUMBER='Proceso B¿sico'

 WHERE CATEGORY_ID = EXP_PROCESS_100235_.tb0_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_CATEGORY(CATEGORY_ID,DISPLAY_NUMBER) 
VALUES (EXP_PROCESS_100235_.tb0_0(0),
'Proceso B¿sico'
);
end if;

exception when others then
EXP_PROCESS_100235_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100235_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100235_.tb1_0(0):=9;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (0)',1);
UPDATE GE_MODULE SET MODULE_ID=EXP_PROCESS_100235_.tb1_0(0),
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

 WHERE MODULE_ID = EXP_PROCESS_100235_.tb1_0(0);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (EXP_PROCESS_100235_.tb1_0(0),
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
EXP_PROCESS_100235_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100235_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100235_.tb2_0(0):=100235;
EXP_PROCESS_100235_.tb2_1(0):=EXP_PROCESS_100235_.tb0_0(0);
EXP_PROCESS_100235_.tb2_2(0):=EXP_PROCESS_100235_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (0)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100235_.tb2_0(0),
CATEGORY_ID=EXP_PROCESS_100235_.tb2_1(0),
MODULE_ID=EXP_PROCESS_100235_.tb2_2(0),
ACTION_ID=null,
PARENT_ID=100213,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_100235'
,
DESCRIPTION='Contratrabajos - Acciones y Estados'
,
DISPLAY='Contratrabajos - Acciones y Estados'
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100235_.tb2_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100235_.tb2_0(0),
EXP_PROCESS_100235_.tb2_1(0),
EXP_PROCESS_100235_.tb2_2(0),
null,
100213,
null,
null,
null,
null,
'UNIT_TYPE_100235'
,
'Contratrabajos - Acciones y Estados'
,
'Contratrabajos - Acciones y Estados'
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
EXP_PROCESS_100235_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100235_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100235_.tb3_0(0):=0;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (0)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100235_.tb3_0(0),
DESCRIPTION='Ra¿z'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100235_.tb3_0(0);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100235_.tb3_0(0),
'Ra¿z'
);
end if;

exception when others then
EXP_PROCESS_100235_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100235_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100235_.tb4_0(0):=100908;
EXP_PROCESS_100235_.tb4_2(0):=EXP_PROCESS_100235_.tb2_0(0);
EXP_PROCESS_100235_.tb4_3(0):=EXP_PROCESS_100235_.tb3_0(0);
EXP_PROCESS_100235_.tb4_4(0):=EXP_PROCESS_100235_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (0)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100235_.tb4_0(0),
PROCESS_ID=null,
UNIT_TYPE_ID=EXP_PROCESS_100235_.tb4_2(0),
NODE_TYPE_ID=EXP_PROCESS_100235_.tb4_3(0),
MODULE_ID=EXP_PROCESS_100235_.tb4_4(0),
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

 WHERE UNIT_ID = EXP_PROCESS_100235_.tb4_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100235_.tb4_0(0),
null,
EXP_PROCESS_100235_.tb4_2(0),
EXP_PROCESS_100235_.tb4_3(0),
EXP_PROCESS_100235_.tb4_4(0),
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
EXP_PROCESS_100235_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100235_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100235_.tb0_0(1):=2;
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_CATEGORY fila (1)',1);
UPDATE WF_UNIT_CATEGORY SET CATEGORY_ID=EXP_PROCESS_100235_.tb0_0(1),
DISPLAY_NUMBER='Actividad'

 WHERE CATEGORY_ID = EXP_PROCESS_100235_.tb0_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_CATEGORY(CATEGORY_ID,DISPLAY_NUMBER) 
VALUES (EXP_PROCESS_100235_.tb0_0(1),
'Actividad'
);
end if;

exception when others then
EXP_PROCESS_100235_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100235_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100235_.tb1_0(1):=5;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (1)',1);
UPDATE GE_MODULE SET MODULE_ID=EXP_PROCESS_100235_.tb1_0(1),
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

 WHERE MODULE_ID = EXP_PROCESS_100235_.tb1_0(1);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (EXP_PROCESS_100235_.tb1_0(1),
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
EXP_PROCESS_100235_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100235_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100235_.tb2_0(1):=100236;
EXP_PROCESS_100235_.tb2_1(1):=EXP_PROCESS_100235_.tb0_0(1);
EXP_PROCESS_100235_.tb2_2(1):=EXP_PROCESS_100235_.tb1_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (1)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100235_.tb2_0(1),
CATEGORY_ID=EXP_PROCESS_100235_.tb2_1(1),
MODULE_ID=EXP_PROCESS_100235_.tb2_2(1),
ACTION_ID=null,
PARENT_ID=100213,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_100236'
,
DESCRIPTION='Actualizar Estados'
,
DISPLAY='Actualizar Estados'
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100235_.tb2_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100235_.tb2_0(1),
EXP_PROCESS_100235_.tb2_1(1),
EXP_PROCESS_100235_.tb2_2(1),
null,
100213,
null,
null,
null,
null,
'UNIT_TYPE_100236'
,
'Actualizar Estados'
,
'Actualizar Estados'
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
EXP_PROCESS_100235_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100235_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100235_.tb3_0(1):=2;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (1)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100235_.tb3_0(1),
DESCRIPTION='Normal'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100235_.tb3_0(1);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100235_.tb3_0(1),
'Normal'
);
end if;

exception when others then
EXP_PROCESS_100235_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100235_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100235_.tb4_0(1):=100912;
EXP_PROCESS_100235_.tb4_1(1):=EXP_PROCESS_100235_.tb4_0(0);
EXP_PROCESS_100235_.tb4_2(1):=EXP_PROCESS_100235_.tb2_0(1);
EXP_PROCESS_100235_.tb4_3(1):=EXP_PROCESS_100235_.tb3_0(1);
EXP_PROCESS_100235_.tb4_4(1):=EXP_PROCESS_100235_.tb1_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (1)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100235_.tb4_0(1),
PROCESS_ID=EXP_PROCESS_100235_.tb4_1(1),
UNIT_TYPE_ID=EXP_PROCESS_100235_.tb4_2(1),
NODE_TYPE_ID=EXP_PROCESS_100235_.tb4_3(1),
MODULE_ID=EXP_PROCESS_100235_.tb4_4(1),
ACTION_ID=8066,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=9000,
GEOMETRY='161
184'
,
DESCRIPTION='Actualizar Estados'
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

 WHERE UNIT_ID = EXP_PROCESS_100235_.tb4_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100235_.tb4_0(1),
EXP_PROCESS_100235_.tb4_1(1),
EXP_PROCESS_100235_.tb4_2(1),
EXP_PROCESS_100235_.tb4_3(1),
EXP_PROCESS_100235_.tb4_4(1),
8066,
null,
null,
9000,
'161
184'
,
'Actualizar Estados'
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
EXP_PROCESS_100235_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100235_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100235_.tb2_0(2):=100268;
EXP_PROCESS_100235_.tb2_1(2):=EXP_PROCESS_100235_.tb0_0(1);
EXP_PROCESS_100235_.tb2_2(2):=EXP_PROCESS_100235_.tb1_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (2)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100235_.tb2_0(2),
CATEGORY_ID=EXP_PROCESS_100235_.tb2_1(2),
MODULE_ID=EXP_PROCESS_100235_.tb2_2(2),
ACTION_ID=8067,
PARENT_ID=100213,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_100268'
,
DESCRIPTION='Actualiza Estados de los Elementos de Red'
,
DISPLAY='Actualiza Estados de los Elementos de Red'
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100235_.tb2_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100235_.tb2_0(2),
EXP_PROCESS_100235_.tb2_1(2),
EXP_PROCESS_100235_.tb2_2(2),
8067,
100213,
null,
null,
null,
null,
'UNIT_TYPE_100268'
,
'Actualiza Estados de los Elementos de Red'
,
'Actualiza Estados de los Elementos de Red'
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
EXP_PROCESS_100235_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100235_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100235_.tb4_0(2):=101007;
EXP_PROCESS_100235_.tb4_1(2):=EXP_PROCESS_100235_.tb4_0(0);
EXP_PROCESS_100235_.tb4_2(2):=EXP_PROCESS_100235_.tb2_0(2);
EXP_PROCESS_100235_.tb4_3(2):=EXP_PROCESS_100235_.tb3_0(1);
EXP_PROCESS_100235_.tb4_4(2):=EXP_PROCESS_100235_.tb1_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (2)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100235_.tb4_0(2),
PROCESS_ID=EXP_PROCESS_100235_.tb4_1(2),
UNIT_TYPE_ID=EXP_PROCESS_100235_.tb4_2(2),
NODE_TYPE_ID=EXP_PROCESS_100235_.tb4_3(2),
MODULE_ID=EXP_PROCESS_100235_.tb4_4(2),
ACTION_ID=8067,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=9000,
GEOMETRY='336
171'
,
DESCRIPTION='Actualiza Estados de los Elementos de Red'
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

 WHERE UNIT_ID = EXP_PROCESS_100235_.tb4_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100235_.tb4_0(2),
EXP_PROCESS_100235_.tb4_1(2),
EXP_PROCESS_100235_.tb4_2(2),
EXP_PROCESS_100235_.tb4_3(2),
EXP_PROCESS_100235_.tb4_4(2),
8067,
null,
null,
9000,
'336
171'
,
'Actualiza Estados de los Elementos de Red'
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
EXP_PROCESS_100235_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100235_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100235_.tb5_0(0):=118943;
EXP_PROCESS_100235_.tb5_1(0):=EXP_PROCESS_100235_.tb4_0(1);
EXP_PROCESS_100235_.tb5_2(0):=EXP_PROCESS_100235_.tb4_0(2);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (0)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100235_.tb5_0(0),
ORIGIN_ID=EXP_PROCESS_100235_.tb5_1(0),
TARGET_ID=EXP_PROCESS_100235_.tb5_2(0),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION=null,
EXPRESSION_TYPE=0,
DESCRIPTION=null,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100235_.tb5_0(0);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100235_.tb5_0(0),
EXP_PROCESS_100235_.tb5_1(0),
EXP_PROCESS_100235_.tb5_2(0),
null,
0,
null,
0,
null,
1);
end if;

exception when others then
EXP_PROCESS_100235_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100235_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100235_.tb2_0(3):=283;
EXP_PROCESS_100235_.tb2_1(3):=EXP_PROCESS_100235_.tb0_0(1);
EXP_PROCESS_100235_.tb2_2(3):=EXP_PROCESS_100235_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (3)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100235_.tb2_0(3),
CATEGORY_ID=EXP_PROCESS_100235_.tb2_1(3),
MODULE_ID=EXP_PROCESS_100235_.tb2_2(3),
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100235_.tb2_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100235_.tb2_0(3),
EXP_PROCESS_100235_.tb2_1(3),
EXP_PROCESS_100235_.tb2_2(3),
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
EXP_PROCESS_100235_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100235_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100235_.tb3_0(2):=1;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (2)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100235_.tb3_0(2),
DESCRIPTION='Arranque'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100235_.tb3_0(2);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100235_.tb3_0(2),
'Arranque'
);
end if;

exception when others then
EXP_PROCESS_100235_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100235_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100235_.tb4_0(3):=100910;
EXP_PROCESS_100235_.tb4_1(3):=EXP_PROCESS_100235_.tb4_0(0);
EXP_PROCESS_100235_.tb4_2(3):=EXP_PROCESS_100235_.tb2_0(3);
EXP_PROCESS_100235_.tb4_3(3):=EXP_PROCESS_100235_.tb3_0(2);
EXP_PROCESS_100235_.tb4_4(3):=EXP_PROCESS_100235_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (3)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100235_.tb4_0(3),
PROCESS_ID=EXP_PROCESS_100235_.tb4_1(3),
UNIT_TYPE_ID=EXP_PROCESS_100235_.tb4_2(3),
NODE_TYPE_ID=EXP_PROCESS_100235_.tb4_3(3),
MODULE_ID=EXP_PROCESS_100235_.tb4_4(3),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='23
191'
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

 WHERE UNIT_ID = EXP_PROCESS_100235_.tb4_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100235_.tb4_0(3),
EXP_PROCESS_100235_.tb4_1(3),
EXP_PROCESS_100235_.tb4_2(3),
EXP_PROCESS_100235_.tb4_3(3),
EXP_PROCESS_100235_.tb4_4(3),
null,
null,
null,
null,
'23
191'
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
EXP_PROCESS_100235_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100235_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100235_.tb5_0(1):=118939;
EXP_PROCESS_100235_.tb5_1(1):=EXP_PROCESS_100235_.tb4_0(3);
EXP_PROCESS_100235_.tb5_2(1):=EXP_PROCESS_100235_.tb4_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (1)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100235_.tb5_0(1),
ORIGIN_ID=EXP_PROCESS_100235_.tb5_1(1),
TARGET_ID=EXP_PROCESS_100235_.tb5_2(1),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION=null,
EXPRESSION_TYPE=0,
DESCRIPTION=null,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100235_.tb5_0(1);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100235_.tb5_0(1),
EXP_PROCESS_100235_.tb5_1(1),
EXP_PROCESS_100235_.tb5_2(1),
null,
0,
null,
0,
null,
1);
end if;

exception when others then
EXP_PROCESS_100235_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100235_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100235_.tb6_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTE_CLASS fila (0)',1);
UPDATE GE_ATTRIBUTE_CLASS SET ATTRIBUTE_CLASS_ID=EXP_PROCESS_100235_.tb6_0(0),
NAME='De Entitdad'
,
DESCRIPTION='Valores que ser¿n tra¿dos de la tabla base usando old record'

 WHERE ATTRIBUTE_CLASS_ID = EXP_PROCESS_100235_.tb6_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTE_CLASS(ATTRIBUTE_CLASS_ID,NAME,DESCRIPTION) 
VALUES (EXP_PROCESS_100235_.tb6_0(0),
'De Entitdad'
,
'Valores que ser¿n tra¿dos de la tabla base usando old record'
);
end if;

exception when others then
EXP_PROCESS_100235_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100235_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100235_.tb7_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES_TYPE fila (0)',1);
UPDATE GE_ATTRIBUTES_TYPE SET ATTRIBUTE_TYPE_ID=EXP_PROCESS_100235_.tb7_0(0),
DESCRIPTION='NUMBER'
,
INTERNAL_TYPE=2,
INTERNAL_JAVA_TYPE=2
 WHERE ATTRIBUTE_TYPE_ID = EXP_PROCESS_100235_.tb7_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES_TYPE(ATTRIBUTE_TYPE_ID,DESCRIPTION,INTERNAL_TYPE,INTERNAL_JAVA_TYPE) 
VALUES (EXP_PROCESS_100235_.tb7_0(0),
'NUMBER'
,
2,
2);
end if;

exception when others then
EXP_PROCESS_100235_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100235_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100235_.tb8_0(0):=400;
EXP_PROCESS_100235_.tb8_1(0):=EXP_PROCESS_100235_.tb6_0(0);
EXP_PROCESS_100235_.tb8_2(0):=EXP_PROCESS_100235_.tb7_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (0)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=EXP_PROCESS_100235_.tb8_0(0),
ATTRIBUTE_CLASS_ID=EXP_PROCESS_100235_.tb8_1(0),
ATTRIBUTE_TYPE_ID=EXP_PROCESS_100235_.tb8_2(0),
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

 WHERE ATTRIBUTE_ID = EXP_PROCESS_100235_.tb8_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,ATTRIBUTE_CLASS_ID,ATTRIBUTE_TYPE_ID,VALID_EXPRESSION,FATHER_ID,MODULE_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (EXP_PROCESS_100235_.tb8_0(0),
EXP_PROCESS_100235_.tb8_1(0),
EXP_PROCESS_100235_.tb8_2(0),
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
EXP_PROCESS_100235_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100235_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100235_.tb9_0(0):=126457;
EXP_PROCESS_100235_.tb9_1(0):=EXP_PROCESS_100235_.tb4_0(1);
EXP_PROCESS_100235_.tb9_2(0):=EXP_PROCESS_100235_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (0)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100235_.tb9_0(0),
UNIT_ID=EXP_PROCESS_100235_.tb9_1(0),
ATTRIBUTE_ID=EXP_PROCESS_100235_.tb9_2(0),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=1,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100235_.tb9_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100235_.tb9_0(0),
EXP_PROCESS_100235_.tb9_1(0),
EXP_PROCESS_100235_.tb9_2(0),
null,
null,
'N'
,
1,
'N'
);
end if;

exception when others then
EXP_PROCESS_100235_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100235_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100235_.tb2_0(4):=252;
EXP_PROCESS_100235_.tb2_1(4):=EXP_PROCESS_100235_.tb0_0(1);
EXP_PROCESS_100235_.tb2_2(4):=EXP_PROCESS_100235_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (4)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100235_.tb2_0(4),
CATEGORY_ID=EXP_PROCESS_100235_.tb2_1(4),
MODULE_ID=EXP_PROCESS_100235_.tb2_2(4),
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100235_.tb2_0(4);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100235_.tb2_0(4),
EXP_PROCESS_100235_.tb2_1(4),
EXP_PROCESS_100235_.tb2_2(4),
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
EXP_PROCESS_100235_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100235_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100235_.tb3_0(3):=3;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (3)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100235_.tb3_0(3),
DESCRIPTION='Final'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100235_.tb3_0(3);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100235_.tb3_0(3),
'Final'
);
end if;

exception when others then
EXP_PROCESS_100235_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100235_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100235_.tb4_0(4):=100911;
EXP_PROCESS_100235_.tb4_1(4):=EXP_PROCESS_100235_.tb4_0(0);
EXP_PROCESS_100235_.tb4_2(4):=EXP_PROCESS_100235_.tb2_0(4);
EXP_PROCESS_100235_.tb4_3(4):=EXP_PROCESS_100235_.tb3_0(3);
EXP_PROCESS_100235_.tb4_4(4):=EXP_PROCESS_100235_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (4)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100235_.tb4_0(4),
PROCESS_ID=EXP_PROCESS_100235_.tb4_1(4),
UNIT_TYPE_ID=EXP_PROCESS_100235_.tb4_2(4),
NODE_TYPE_ID=EXP_PROCESS_100235_.tb4_3(4),
MODULE_ID=EXP_PROCESS_100235_.tb4_4(4),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='517
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

 WHERE UNIT_ID = EXP_PROCESS_100235_.tb4_0(4);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100235_.tb4_0(4),
EXP_PROCESS_100235_.tb4_1(4),
EXP_PROCESS_100235_.tb4_2(4),
EXP_PROCESS_100235_.tb4_3(4),
EXP_PROCESS_100235_.tb4_4(4),
null,
null,
null,
null,
'517
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
EXP_PROCESS_100235_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100235_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100235_.tb5_0(2):=118944;
EXP_PROCESS_100235_.tb5_1(2):=EXP_PROCESS_100235_.tb4_0(2);
EXP_PROCESS_100235_.tb5_2(2):=EXP_PROCESS_100235_.tb4_0(4);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (2)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100235_.tb5_0(2),
ORIGIN_ID=EXP_PROCESS_100235_.tb5_1(2),
TARGET_ID=EXP_PROCESS_100235_.tb5_2(2),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION=null,
EXPRESSION_TYPE=0,
DESCRIPTION=null,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100235_.tb5_0(2);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100235_.tb5_0(2),
EXP_PROCESS_100235_.tb5_1(2),
EXP_PROCESS_100235_.tb5_2(2),
null,
0,
null,
0,
null,
1);
end if;

exception when others then
EXP_PROCESS_100235_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100235_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100235_.tb9_0(1):=126458;
EXP_PROCESS_100235_.tb9_1(1):=EXP_PROCESS_100235_.tb4_0(2);
EXP_PROCESS_100235_.tb9_2(1):=EXP_PROCESS_100235_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (1)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100235_.tb9_0(1),
UNIT_ID=EXP_PROCESS_100235_.tb9_1(1),
ATTRIBUTE_ID=EXP_PROCESS_100235_.tb9_2(1),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=1,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100235_.tb9_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100235_.tb9_0(1),
EXP_PROCESS_100235_.tb9_1(1),
EXP_PROCESS_100235_.tb9_2(1),
null,
null,
'N'
,
1,
'N'
);
end if;

exception when others then
EXP_PROCESS_100235_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100235_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100235_.tb9_0(2):=126440;
EXP_PROCESS_100235_.tb9_1(2):=EXP_PROCESS_100235_.tb4_0(3);
EXP_PROCESS_100235_.tb9_2(2):=EXP_PROCESS_100235_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (2)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100235_.tb9_0(2),
UNIT_ID=EXP_PROCESS_100235_.tb9_1(2),
ATTRIBUTE_ID=EXP_PROCESS_100235_.tb9_2(2),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=1,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100235_.tb9_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100235_.tb9_0(2),
EXP_PROCESS_100235_.tb9_1(2),
EXP_PROCESS_100235_.tb9_2(2),
null,
null,
'N'
,
1,
'N'
);
end if;

exception when others then
EXP_PROCESS_100235_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100235_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100235_.tb9_0(3):=126441;
EXP_PROCESS_100235_.tb9_1(3):=EXP_PROCESS_100235_.tb4_0(4);
EXP_PROCESS_100235_.tb9_2(3):=EXP_PROCESS_100235_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (3)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100235_.tb9_0(3),
UNIT_ID=EXP_PROCESS_100235_.tb9_1(3),
ATTRIBUTE_ID=EXP_PROCESS_100235_.tb9_2(3),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100235_.tb9_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100235_.tb9_0(3),
EXP_PROCESS_100235_.tb9_1(3),
EXP_PROCESS_100235_.tb9_2(3),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_100235_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100235_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100235_.tb9_0(4):=126442;
EXP_PROCESS_100235_.tb9_1(4):=EXP_PROCESS_100235_.tb4_0(4);
EXP_PROCESS_100235_.tb9_2(4):=EXP_PROCESS_100235_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (4)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100235_.tb9_0(4),
UNIT_ID=EXP_PROCESS_100235_.tb9_1(4),
ATTRIBUTE_ID=EXP_PROCESS_100235_.tb9_2(4),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100235_.tb9_0(4);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100235_.tb9_0(4),
EXP_PROCESS_100235_.tb9_1(4),
EXP_PROCESS_100235_.tb9_2(4),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_100235_.blProcessStatus := false;
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
sa_bocreatePackages.CreatePackage('EXP_UNITTYPE_100236_',
'CREATE OR REPLACE PACKAGE EXP_UNITTYPE_100236_ IS ' || chr(10) ||
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
'END EXP_UNITTYPE_100236_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_UNITTYPE_100236_******************************'); END;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_UNITTYPE_100236',1);
EXP_UNITTYPE_100236_.blProcessStatus := EXP_PROCESS_100235_.blProcessStatus ; 
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
AND     A.TASK_CODE = 100236
 
;
BEGIN

if (not EXP_UNITTYPE_100236_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_UNITTYPE_100236_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
FROM WF_UNIT_TYPE_ATTRIB WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100236);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100236_.blProcessStatus) then
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
EXP_UNITTYPE_100236_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_CAUSAL_UNIT_TYPE WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100236);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100236_.blProcessStatus) then
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
EXP_UNITTYPE_100236_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM MO_TIME_UNI_TYP_PRIO WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100236);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100236_.blProcessStatus) then
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
EXP_UNITTYPE_100236_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM OR_ACT_BY_TASK_MOD WHERE (TASK_CODE) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100236);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100236_.blProcessStatus) then
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
EXP_UNITTYPE_100236_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100236;
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100236_.blProcessStatus) then
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
EXP_UNITTYPE_100236_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_UNITTYPE_100236_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100236_.tb0_0(0):=100236;
ut_trace.trace('insertando tabla sin fallo: WF_UNIT_TYPE fila (0)',1);
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_UNITTYPE_100236_.tb0_0(0),
2,
5,
null,
100213,
null,
null,
null,
null,
'UNIT_TYPE_100236'
,
'Actualizar Estados'
,
'Actualizar Estados'
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
EXP_UNITTYPE_100236_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100235',1);
EXP_PROCESS_100235_.blProcessStatus := EXP_UNITTYPE_100236_.blProcessStatus ; 
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
 nuIndex := EXP_UNITTYPE_100236_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_UNITTYPE_100236_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_UNITTYPE_100236_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_UNITTYPE_100236_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_UNITTYPE_100236_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_UNITTYPE_100236_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_UNITTYPE_100236_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_UNITTYPE_100236_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_UNITTYPE_100236_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_UNITTYPE_100236_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_UNITTYPE_100268_',
'CREATE OR REPLACE PACKAGE EXP_UNITTYPE_100268_ IS ' || chr(10) ||
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
'END EXP_UNITTYPE_100268_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_UNITTYPE_100268_******************************'); END;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_UNITTYPE_100268',1);
EXP_UNITTYPE_100268_.blProcessStatus := EXP_PROCESS_100235_.blProcessStatus ; 
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
AND     A.TASK_CODE = 100268
 
;
BEGIN

if (not EXP_UNITTYPE_100268_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_UNITTYPE_100268_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
FROM WF_UNIT_TYPE_ATTRIB WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100268);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100268_.blProcessStatus) then
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
EXP_UNITTYPE_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_CAUSAL_UNIT_TYPE WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100268);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100268_.blProcessStatus) then
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
EXP_UNITTYPE_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM MO_TIME_UNI_TYP_PRIO WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100268);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100268_.blProcessStatus) then
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
EXP_UNITTYPE_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM OR_ACT_BY_TASK_MOD WHERE (TASK_CODE) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100268);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100268_.blProcessStatus) then
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
EXP_UNITTYPE_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100268;
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100268_.blProcessStatus) then
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
EXP_UNITTYPE_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_UNITTYPE_100268_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100268_.tb0_0(0):=100268;
ut_trace.trace('insertando tabla sin fallo: WF_UNIT_TYPE fila (0)',1);
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_UNITTYPE_100268_.tb0_0(0),
2,
5,
8067,
100213,
null,
null,
null,
null,
'UNIT_TYPE_100268'
,
'Actualiza Estados de los Elementos de Red'
,
'Actualiza Estados de los Elementos de Red'
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
EXP_UNITTYPE_100268_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100235',1);
EXP_PROCESS_100235_.blProcessStatus := EXP_UNITTYPE_100268_.blProcessStatus ; 
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
 nuIndex := EXP_UNITTYPE_100268_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_UNITTYPE_100268_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_UNITTYPE_100268_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_UNITTYPE_100268_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_UNITTYPE_100268_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_UNITTYPE_100268_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_UNITTYPE_100268_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_UNITTYPE_100268_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_UNITTYPE_100268_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_UNITTYPE_100268_******************************'); end;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100248',1);
EXP_PROCESS_100248_.blProcessStatus := EXP_PROCESS_100235_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
DECLARE 
    nuBinaryIndex Binary_Integer;
BEGIN 
    nuBinaryIndex := EXP_PROCESS_100235_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = EXP_PROCESS_100235_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||EXP_PROCESS_100235_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||EXP_PROCESS_100235_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := EXP_PROCESS_100235_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       EXP_PROCESS_100235_.blProcessStatus := FALSE;
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
 nuIndex := EXP_PROCESS_100235_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_PROCESS_100235_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_PROCESS_100235_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_PROCESS_100235_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_PROCESS_100235_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_PROCESS_100235_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_PROCESS_100235_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_PROCESS_100235_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_PROCESS_100235_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_PROCESS_100235_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_PROCESS_100232_',
'CREATE OR REPLACE PACKAGE EXP_PROCESS_100232_ IS ' || chr(10) ||
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
'        WHERE UNIT_TYPE_ID = 100232 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID IN  ' || chr(10) ||
'           (SELECT UNIT_ID ' || chr(10) ||
'           FROM WF_UNIT ' || chr(10) ||
'           WHERE UNIT_TYPE_ID = 100232 ' || chr(10) ||
'       )) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_TYPE_ID = 100232 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID IN  ' || chr(10) ||
'           (SELECT UNIT_ID ' || chr(10) ||
'           FROM WF_UNIT ' || chr(10) ||
'           WHERE UNIT_TYPE_ID = 100232 ' || chr(10) ||
'       )) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_PROCESS_100232_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_PROCESS_100232_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open EXP_PROCESS_100232_.cuExpression;
   fetch EXP_PROCESS_100232_.cuExpression bulk collect INTO EXP_PROCESS_100232_.tbGR_CONFIG_EXPRESSIONId;
   close EXP_PROCESS_100232_.cuExpression;
END;
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100232',1);
EXP_PROCESS_100232_.blProcessStatus := EXP_PROCESS_100248_.blProcessStatus ; 
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
sa_bocreatePackages.CreatePackage('DEL_ROOT_100900_',
'CREATE OR REPLACE PACKAGE DEL_ROOT_100900_ IS ' || chr(10) ||
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
'        WHERE UNIT_ID = 100900 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 100900  ' || chr(10) ||
'       ) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_ID = 100900 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 100900  ' || chr(10) ||
'       ) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END DEL_ROOT_100900_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:DEL_ROOT_100900_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open DEL_ROOT_100900_.cuExpression;
   fetch DEL_ROOT_100900_.cuExpression bulk collect INTO DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONId;
   close DEL_ROOT_100900_.cuExpression;
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
        WHERE UNIT_ID = 100900
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID = 100900 
       )
;
BEGIN

if (not DEL_ROOT_100900_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  DEL_ROOT_100900_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE PROCESS_ID = 100900);
BEGIN 

if (not DEL_ROOT_100900_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100900_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE PROCESS_ID = 100900);
BEGIN 

if (not DEL_ROOT_100900_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100900_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 100900)));
BEGIN 

if (not DEL_ROOT_100900_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100900_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 100900)));
BEGIN 

if (not DEL_ROOT_100900_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100900_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 100900));
BEGIN 

if (not DEL_ROOT_100900_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla WF_UNIT',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100900_.tbWF_UNITRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100900_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 100900);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100900_.blProcessStatus) then
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
DEL_ROOT_100900_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100900_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100900_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100900_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100900_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100900_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria WF_UNIT',1);
nuVarcharIndex:=DEL_ROOT_100900_.tbWF_UNITRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from WF_UNIT where rowid = DEL_ROOT_100900_.tbWF_UNITRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100900_.tbWF_UNITRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100900_.tbWF_UNITRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100900_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_DATA_MAP WHERE (SOURCE_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 100900));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100900_.blProcessStatus) then
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
DEL_ROOT_100900_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_DATA_MAP WHERE (TARGET_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 100900));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100900_.blProcessStatus) then
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
DEL_ROOT_100900_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 100900);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100900_.blProcessStatus) then
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
DEL_ROOT_100900_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT WHERE PROCESS_ID = 100900;
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100900_.blProcessStatus) then
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
DEL_ROOT_100900_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100900_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100900_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100900_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100900_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/

BEGIN
    ut_trace.trace('Actualizar WF_UNIT a ProcessId NULL ',1);
   UPDATE WF_UNIT 
     SET PROCESS_ID = -1, POS_EXPRESSION_ID = null, PRE_EXPRESSION_ID = null, ACTION_ID = null 
     WHERE PROCESS_ID = 100900;
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
    nuBinaryIndex := DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       DEL_ROOT_100900_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100232',1);
EXP_PROCESS_100232_.blProcessStatus := DEL_ROOT_100900_.blProcessStatus ; 
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
 nuIndex := DEL_ROOT_100900_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || DEL_ROOT_100900_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(DEL_ROOT_100900_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(DEL_ROOT_100900_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(DEL_ROOT_100900_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || DEL_ROOT_100900_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || DEL_ROOT_100900_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := DEL_ROOT_100900_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('DEL_ROOT_100900_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:DEL_ROOT_100900_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('DEL_ROOT_100900_',
'CREATE OR REPLACE PACKAGE DEL_ROOT_100900_ IS ' || chr(10) ||
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
'        WHERE UNIT_ID = 100900 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 100900  ' || chr(10) ||
'       ) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_ID = 100900 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 100900  ' || chr(10) ||
'       ) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END DEL_ROOT_100900_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:DEL_ROOT_100900_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open DEL_ROOT_100900_.cuExpression;
   fetch DEL_ROOT_100900_.cuExpression bulk collect INTO DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONId;
   close DEL_ROOT_100900_.cuExpression;
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
        WHERE UNIT_ID = 100900
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID = 100900 
       )
;
BEGIN

if (not DEL_ROOT_100900_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  DEL_ROOT_100900_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE UNIT_ID = 100900);
BEGIN 

if (not DEL_ROOT_100900_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100900_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE UNIT_ID = 100900);
BEGIN 

if (not DEL_ROOT_100900_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100900_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 100900)));
BEGIN 

if (not DEL_ROOT_100900_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100900_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 100900)));
BEGIN 

if (not DEL_ROOT_100900_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100900_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 100900));
BEGIN 

if (not DEL_ROOT_100900_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla WF_UNIT',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100900_.tbWF_UNITRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100900_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 100900);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100900_.blProcessStatus) then
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
DEL_ROOT_100900_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100900_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100900_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100900_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100900_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100900_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria WF_UNIT',1);
nuVarcharIndex:=DEL_ROOT_100900_.tbWF_UNITRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from WF_UNIT where rowid = DEL_ROOT_100900_.tbWF_UNITRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100900_.tbWF_UNITRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100900_.tbWF_UNITRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100900_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_DATA_MAP WHERE (SOURCE_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 100900));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100900_.blProcessStatus) then
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
DEL_ROOT_100900_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_DATA_MAP WHERE (TARGET_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 100900));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100900_.blProcessStatus) then
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
DEL_ROOT_100900_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 100900);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100900_.blProcessStatus) then
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
DEL_ROOT_100900_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT WHERE UNIT_ID = 100900;
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100900_.blProcessStatus) then
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
DEL_ROOT_100900_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100900_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100900_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100900_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100900_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/

BEGIN
    ut_trace.trace('Actualizar WF_UNIT a ProcessId NULL ',1);
   UPDATE WF_UNIT 
     SET PROCESS_ID = -1, POS_EXPRESSION_ID = null, PRE_EXPRESSION_ID = null, ACTION_ID = null 
     WHERE PROCESS_ID = 100900;
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
    nuBinaryIndex := DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := DEL_ROOT_100900_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       DEL_ROOT_100900_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100232',1);
EXP_PROCESS_100232_.blProcessStatus := DEL_ROOT_100900_.blProcessStatus ; 
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
 nuIndex := DEL_ROOT_100900_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || DEL_ROOT_100900_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(DEL_ROOT_100900_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(DEL_ROOT_100900_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(DEL_ROOT_100900_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || DEL_ROOT_100900_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || DEL_ROOT_100900_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := DEL_ROOT_100900_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('DEL_ROOT_100900_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:DEL_ROOT_100900_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_ACTION_8064_',
'CREATE OR REPLACE PACKAGE EXP_ACTION_8064_ IS ' || chr(10) ||
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
'WHERE  ACTION_ID =8064; ' || chr(10) ||
'type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_ACTION_8064_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_ACTION_8064_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open EXP_ACTION_8064_.cuExpression;
   fetch EXP_ACTION_8064_.cuExpression bulk collect INTO EXP_ACTION_8064_.tbGR_CONFIG_EXPRESSIONId;
   close EXP_ACTION_8064_.cuExpression;
END;
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_ACTION_8064',1);
EXP_ACTION_8064_.blProcessStatus := EXP_PROCESS_100232_.blProcessStatus ; 
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
AND     A.ACTION_ID =8064
;
BEGIN

if (not EXP_ACTION_8064_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_ACTION_8064_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE ACTION_ID=8064);
BEGIN 

if (not EXP_ACTION_8064_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_ACTION_8064_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_ACTION_8064_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM GE_ACTION_MODULE WHERE ACTION_ID=8064;
nuIndex binary_integer;
BEGIN

if (not EXP_ACTION_8064_.blProcessStatus) then
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
EXP_ACTION_8064_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_ACTION_8064_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_ACTION_8064_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_ACTION_8064_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_ACTION_8064_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_ACTION_8064_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_ACTION_8064_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_ACTION_8064_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8064_.tb0_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=EXP_ACTION_8064_.tb0_0(0),
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

 WHERE CONFIGURA_TYPE_ID = EXP_ACTION_8064_.tb0_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (EXP_ACTION_8064_.tb0_0(0),
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
EXP_ACTION_8064_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_8064_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8064_.old_tb1_0(0):=121401245;
EXP_ACTION_8064_.tb1_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
EXP_ACTION_8064_.tb1_0(0):=EXP_ACTION_8064_.tb1_0(0);
EXP_ACTION_8064_.old_tb1_1(0):='GE_EXEACTION_CT1E121401245'
;
EXP_ACTION_8064_.tb1_1(0):=TO_CHAR(EXP_ACTION_8064_.tb1_0(0));
EXP_ACTION_8064_.tb1_2(0):=EXP_ACTION_8064_.tb0_0(0);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (EXP_ACTION_8064_.tb1_0(0),
EXP_ACTION_8064_.tb1_1(0),
EXP_ACTION_8064_.tb1_2(0),
'CF_BOACTIONS.ANULNETELEM()'
,
'LBTEST'
,
to_date('17-02-2011 14:36:07','DD-MM-YYYY HH24:MI:SS'),
to_date('28-02-2024 08:49:21','DD-MM-YYYY HH24:MI:SS'),
to_date('28-02-2024 08:49:21','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Reversa Elementos de Red x Anulaci¿n'
,
'PP'
,
null);

exception when others then
EXP_ACTION_8064_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_8064_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8064_.tb2_0(0):=8064;
EXP_ACTION_8064_.tb2_2(0):=EXP_ACTION_8064_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ACTION_MODULE fila (0)',1);
UPDATE GE_ACTION_MODULE SET ACTION_ID=EXP_ACTION_8064_.tb2_0(0),
MODULE_ID=5,
CONFIG_EXPRESSION_ID=EXP_ACTION_8064_.tb2_2(0),
DESCRIPTION='LBC - Reversa Elementos de Red x Anulaci¿n'
,
EXE_AT_STATUS_CHANGE='N'
,
EXE_TRANSITION_STATE='N'

 WHERE ACTION_ID = EXP_ACTION_8064_.tb2_0(0);
if not (sql%found) then
INSERT INTO GE_ACTION_MODULE(ACTION_ID,MODULE_ID,CONFIG_EXPRESSION_ID,DESCRIPTION,EXE_AT_STATUS_CHANGE,EXE_TRANSITION_STATE) 
VALUES (EXP_ACTION_8064_.tb2_0(0),
5,
EXP_ACTION_8064_.tb2_2(0),
'LBC - Reversa Elementos de Red x Anulaci¿n'
,
'N'
,
'N'
);
end if;

exception when others then
EXP_ACTION_8064_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_8064_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8064_.tb3_0(0):=EXP_ACTION_8064_.tb2_0(0);
EXP_ACTION_8064_.tb3_1(0):=5;
ut_trace.trace('insertando tabla sin fallo: GE_VALID_ACTION_MODU fila (0)',1);
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (EXP_ACTION_8064_.tb3_0(0),
EXP_ACTION_8064_.tb3_1(0));

exception 
when dup_val_on_index then 
 return;
when others then
EXP_ACTION_8064_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_8064_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8064_.tb3_0(1):=EXP_ACTION_8064_.tb2_0(0);
EXP_ACTION_8064_.tb3_1(1):=9;
ut_trace.trace('insertando tabla sin fallo: GE_VALID_ACTION_MODU fila (1)',1);
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (EXP_ACTION_8064_.tb3_0(1),
EXP_ACTION_8064_.tb3_1(1));

exception 
when dup_val_on_index then 
 return;
when others then
EXP_ACTION_8064_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_8064_.blProcessStatus) then
 return;
end if;

EXP_ACTION_8064_.tb3_0(2):=EXP_ACTION_8064_.tb2_0(0);
EXP_ACTION_8064_.tb3_1(2):=16;
ut_trace.trace('insertando tabla sin fallo: GE_VALID_ACTION_MODU fila (2)',1);
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (EXP_ACTION_8064_.tb3_0(2),
EXP_ACTION_8064_.tb3_1(2));

exception 
when dup_val_on_index then 
 return;
when others then
EXP_ACTION_8064_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
DECLARE 
    nuBinaryIndex Binary_Integer;
BEGIN 
    nuBinaryIndex := EXP_ACTION_8064_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = EXP_ACTION_8064_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||EXP_ACTION_8064_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||EXP_ACTION_8064_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := EXP_ACTION_8064_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       EXP_ACTION_8064_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100232',1);
EXP_PROCESS_100232_.blProcessStatus := EXP_ACTION_8064_.blProcessStatus ; 
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

if (not EXP_ACTION_8064_.blProcessStatus) then
 return;
end if;
nuRowProcess:=EXP_ACTION_8064_.tb1_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| EXP_ACTION_8064_.tb1_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(EXP_ACTION_8064_.tb1_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| EXP_ACTION_8064_.tb1_0(nuRowProcess),1);
end;
nuRowProcess := EXP_ACTION_8064_.tb1_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
EXP_ACTION_8064_.blProcessStatus := false;
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
 nuIndex := EXP_ACTION_8064_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_ACTION_8064_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_ACTION_8064_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_ACTION_8064_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_ACTION_8064_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_ACTION_8064_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_ACTION_8064_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_ACTION_8064_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_ACTION_8064_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_ACTION_8064_******************************'); end;
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
        WHERE UNIT_TYPE_ID = 100232
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID IN 
           (SELECT UNIT_ID
           FROM WF_UNIT
           WHERE UNIT_TYPE_ID = 100232
       ))
;
BEGIN

if (not EXP_PROCESS_100232_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_PROCESS_100232_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100232) AND NODE_TYPE_ID=0);
BEGIN 

if (not EXP_PROCESS_100232_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_PROCESS_100232_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_PROCESS_100232_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100232) AND NODE_TYPE_ID=0);
BEGIN 

if (not EXP_PROCESS_100232_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_PROCESS_100232_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_PROCESS_100232_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100232) AND NODE_TYPE_ID=0;
nuIndex binary_integer;
BEGIN

if (not EXP_PROCESS_100232_.blProcessStatus) then
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
EXP_PROCESS_100232_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_PROCESS_100232_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_PROCESS_100232_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_PROCESS_100232_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_PROCESS_100232_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_PROCESS_100232_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_PROCESS_100232_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_PROCESS_100232_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_PROCESS_100232_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_PROCESS_100232_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_PROCESS_100232_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_PROCESS_100232_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_PROCESS_100232_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100232;
nuIndex binary_integer;
BEGIN

if (not EXP_PROCESS_100232_.blProcessStatus) then
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
EXP_PROCESS_100232_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_PROCESS_100232_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100232_.tb0_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_CATEGORY fila (0)',1);
UPDATE WF_UNIT_CATEGORY SET CATEGORY_ID=EXP_PROCESS_100232_.tb0_0(0),
DISPLAY_NUMBER='Proceso B¿sico'

 WHERE CATEGORY_ID = EXP_PROCESS_100232_.tb0_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_CATEGORY(CATEGORY_ID,DISPLAY_NUMBER) 
VALUES (EXP_PROCESS_100232_.tb0_0(0),
'Proceso B¿sico'
);
end if;

exception when others then
EXP_PROCESS_100232_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100232_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100232_.tb1_0(0):=9;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (0)',1);
UPDATE GE_MODULE SET MODULE_ID=EXP_PROCESS_100232_.tb1_0(0),
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

 WHERE MODULE_ID = EXP_PROCESS_100232_.tb1_0(0);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (EXP_PROCESS_100232_.tb1_0(0),
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
EXP_PROCESS_100232_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100232_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100232_.tb2_0(0):=100232;
EXP_PROCESS_100232_.tb2_1(0):=EXP_PROCESS_100232_.tb0_0(0);
EXP_PROCESS_100232_.tb2_2(0):=EXP_PROCESS_100232_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (0)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100232_.tb2_0(0),
CATEGORY_ID=EXP_PROCESS_100232_.tb2_1(0),
MODULE_ID=EXP_PROCESS_100232_.tb2_2(0),
ACTION_ID=null,
PARENT_ID=100213,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_100232'
,
DESCRIPTION='Contratrabajos - Asignaci¿n'
,
DISPLAY='Contratrabajos - Asignaci¿n'
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100232_.tb2_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100232_.tb2_0(0),
EXP_PROCESS_100232_.tb2_1(0),
EXP_PROCESS_100232_.tb2_2(0),
null,
100213,
null,
null,
null,
null,
'UNIT_TYPE_100232'
,
'Contratrabajos - Asignaci¿n'
,
'Contratrabajos - Asignaci¿n'
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
EXP_PROCESS_100232_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100232_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100232_.tb3_0(0):=0;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (0)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100232_.tb3_0(0),
DESCRIPTION='Ra¿z'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100232_.tb3_0(0);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100232_.tb3_0(0),
'Ra¿z'
);
end if;

exception when others then
EXP_PROCESS_100232_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100232_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100232_.tb4_0(0):=100900;
EXP_PROCESS_100232_.tb4_2(0):=EXP_PROCESS_100232_.tb2_0(0);
EXP_PROCESS_100232_.tb4_3(0):=EXP_PROCESS_100232_.tb3_0(0);
EXP_PROCESS_100232_.tb4_4(0):=EXP_PROCESS_100232_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (0)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100232_.tb4_0(0),
PROCESS_ID=null,
UNIT_TYPE_ID=EXP_PROCESS_100232_.tb4_2(0),
NODE_TYPE_ID=EXP_PROCESS_100232_.tb4_3(0),
MODULE_ID=EXP_PROCESS_100232_.tb4_4(0),
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

 WHERE UNIT_ID = EXP_PROCESS_100232_.tb4_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100232_.tb4_0(0),
null,
EXP_PROCESS_100232_.tb4_2(0),
EXP_PROCESS_100232_.tb4_3(0),
EXP_PROCESS_100232_.tb4_4(0),
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
EXP_PROCESS_100232_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100232_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100232_.tb0_0(1):=2;
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_CATEGORY fila (1)',1);
UPDATE WF_UNIT_CATEGORY SET CATEGORY_ID=EXP_PROCESS_100232_.tb0_0(1),
DISPLAY_NUMBER='Actividad'

 WHERE CATEGORY_ID = EXP_PROCESS_100232_.tb0_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_CATEGORY(CATEGORY_ID,DISPLAY_NUMBER) 
VALUES (EXP_PROCESS_100232_.tb0_0(1),
'Actividad'
);
end if;

exception when others then
EXP_PROCESS_100232_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100232_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100232_.tb2_0(1):=283;
EXP_PROCESS_100232_.tb2_1(1):=EXP_PROCESS_100232_.tb0_0(1);
EXP_PROCESS_100232_.tb2_2(1):=EXP_PROCESS_100232_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (1)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100232_.tb2_0(1),
CATEGORY_ID=EXP_PROCESS_100232_.tb2_1(1),
MODULE_ID=EXP_PROCESS_100232_.tb2_2(1),
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100232_.tb2_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100232_.tb2_0(1),
EXP_PROCESS_100232_.tb2_1(1),
EXP_PROCESS_100232_.tb2_2(1),
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
EXP_PROCESS_100232_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100232_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100232_.tb3_0(1):=1;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (1)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100232_.tb3_0(1),
DESCRIPTION='Arranque'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100232_.tb3_0(1);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100232_.tb3_0(1),
'Arranque'
);
end if;

exception when others then
EXP_PROCESS_100232_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100232_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100232_.tb4_0(1):=100905;
EXP_PROCESS_100232_.tb4_1(1):=EXP_PROCESS_100232_.tb4_0(0);
EXP_PROCESS_100232_.tb4_2(1):=EXP_PROCESS_100232_.tb2_0(1);
EXP_PROCESS_100232_.tb4_3(1):=EXP_PROCESS_100232_.tb3_0(1);
EXP_PROCESS_100232_.tb4_4(1):=EXP_PROCESS_100232_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (1)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100232_.tb4_0(1),
PROCESS_ID=EXP_PROCESS_100232_.tb4_1(1),
UNIT_TYPE_ID=EXP_PROCESS_100232_.tb4_2(1),
NODE_TYPE_ID=EXP_PROCESS_100232_.tb4_3(1),
MODULE_ID=EXP_PROCESS_100232_.tb4_4(1),
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
ENTITY_ID=17,
VIEWABLE='N'

 WHERE UNIT_ID = EXP_PROCESS_100232_.tb4_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100232_.tb4_0(1),
EXP_PROCESS_100232_.tb4_1(1),
EXP_PROCESS_100232_.tb4_2(1),
EXP_PROCESS_100232_.tb4_3(1),
EXP_PROCESS_100232_.tb4_4(1),
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
17,
'N'
);
end if;

exception when others then
EXP_PROCESS_100232_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100232_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100232_.tb1_0(1):=5;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (1)',1);
UPDATE GE_MODULE SET MODULE_ID=EXP_PROCESS_100232_.tb1_0(1),
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

 WHERE MODULE_ID = EXP_PROCESS_100232_.tb1_0(1);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (EXP_PROCESS_100232_.tb1_0(1),
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
EXP_PROCESS_100232_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100232_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100232_.tb2_0(2):=100233;
EXP_PROCESS_100232_.tb2_1(2):=EXP_PROCESS_100232_.tb0_0(1);
EXP_PROCESS_100232_.tb2_2(2):=EXP_PROCESS_100232_.tb1_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (2)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100232_.tb2_0(2),
CATEGORY_ID=EXP_PROCESS_100232_.tb2_1(2),
MODULE_ID=EXP_PROCESS_100232_.tb2_2(2),
ACTION_ID=null,
PARENT_ID=100213,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_100233'
,
DESCRIPTION='Desasignaci¿n Autom¿tica'
,
DISPLAY='Desasignaci¿n Autom¿tica'
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
NOTIFICATION_ID=9000,
VIEWABLE='N'
,
DEFAULT_PRIORITY_ID=null,
INITIAL_NOTIFY_TIME=null,
IS_ADMIN_PROCESS='N'
,
ASSIGN_NOTIFICATION_ID=null,
ASSIGNED_USER_ONLY=null
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100232_.tb2_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100232_.tb2_0(2),
EXP_PROCESS_100232_.tb2_1(2),
EXP_PROCESS_100232_.tb2_2(2),
null,
100213,
null,
null,
null,
null,
'UNIT_TYPE_100233'
,
'Desasignaci¿n Autom¿tica'
,
'Desasignaci¿n Autom¿tica'
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
EXP_PROCESS_100232_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100232_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100232_.tb3_0(2):=2;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (2)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100232_.tb3_0(2),
DESCRIPTION='Normal'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100232_.tb3_0(2);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100232_.tb3_0(2),
'Normal'
);
end if;

exception when others then
EXP_PROCESS_100232_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100232_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100232_.tb4_0(2):=100907;
EXP_PROCESS_100232_.tb4_1(2):=EXP_PROCESS_100232_.tb4_0(0);
EXP_PROCESS_100232_.tb4_2(2):=EXP_PROCESS_100232_.tb2_0(2);
EXP_PROCESS_100232_.tb4_3(2):=EXP_PROCESS_100232_.tb3_0(2);
EXP_PROCESS_100232_.tb4_4(2):=EXP_PROCESS_100232_.tb1_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (2)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100232_.tb4_0(2),
PROCESS_ID=EXP_PROCESS_100232_.tb4_1(2),
UNIT_TYPE_ID=EXP_PROCESS_100232_.tb4_2(2),
NODE_TYPE_ID=EXP_PROCESS_100232_.tb4_3(2),
MODULE_ID=EXP_PROCESS_100232_.tb4_4(2),
ACTION_ID=8064,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=9000,
GEOMETRY='156
176'
,
DESCRIPTION='Desasignaci¿n Autom¿tica'
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

 WHERE UNIT_ID = EXP_PROCESS_100232_.tb4_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100232_.tb4_0(2),
EXP_PROCESS_100232_.tb4_1(2),
EXP_PROCESS_100232_.tb4_2(2),
EXP_PROCESS_100232_.tb4_3(2),
EXP_PROCESS_100232_.tb4_4(2),
8064,
null,
null,
9000,
'156
176'
,
'Desasignaci¿n Autom¿tica'
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
EXP_PROCESS_100232_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100232_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100232_.tb5_0(0):=118936;
EXP_PROCESS_100232_.tb5_1(0):=EXP_PROCESS_100232_.tb4_0(1);
EXP_PROCESS_100232_.tb5_2(0):=EXP_PROCESS_100232_.tb4_0(2);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (0)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100232_.tb5_0(0),
ORIGIN_ID=EXP_PROCESS_100232_.tb5_1(0),
TARGET_ID=EXP_PROCESS_100232_.tb5_2(0),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION='FLAG_VALIDATE == SI'
,
EXPRESSION_TYPE=0,
DESCRIPTION=null,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100232_.tb5_0(0);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100232_.tb5_0(0),
EXP_PROCESS_100232_.tb5_1(0),
EXP_PROCESS_100232_.tb5_2(0),
null,
0,
'FLAG_VALIDATE == SI'
,
0,
null,
1);
end if;

exception when others then
EXP_PROCESS_100232_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100232_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100232_.tb2_0(3):=252;
EXP_PROCESS_100232_.tb2_1(3):=EXP_PROCESS_100232_.tb0_0(1);
EXP_PROCESS_100232_.tb2_2(3):=EXP_PROCESS_100232_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (3)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100232_.tb2_0(3),
CATEGORY_ID=EXP_PROCESS_100232_.tb2_1(3),
MODULE_ID=EXP_PROCESS_100232_.tb2_2(3),
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100232_.tb2_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100232_.tb2_0(3),
EXP_PROCESS_100232_.tb2_1(3),
EXP_PROCESS_100232_.tb2_2(3),
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
EXP_PROCESS_100232_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100232_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100232_.tb3_0(3):=3;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (3)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100232_.tb3_0(3),
DESCRIPTION='Final'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100232_.tb3_0(3);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100232_.tb3_0(3),
'Final'
);
end if;

exception when others then
EXP_PROCESS_100232_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100232_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100232_.tb4_0(3):=100906;
EXP_PROCESS_100232_.tb4_1(3):=EXP_PROCESS_100232_.tb4_0(0);
EXP_PROCESS_100232_.tb4_2(3):=EXP_PROCESS_100232_.tb2_0(3);
EXP_PROCESS_100232_.tb4_3(3):=EXP_PROCESS_100232_.tb3_0(3);
EXP_PROCESS_100232_.tb4_4(3):=EXP_PROCESS_100232_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (3)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100232_.tb4_0(3),
PROCESS_ID=EXP_PROCESS_100232_.tb4_1(3),
UNIT_TYPE_ID=EXP_PROCESS_100232_.tb4_2(3),
NODE_TYPE_ID=EXP_PROCESS_100232_.tb4_3(3),
MODULE_ID=EXP_PROCESS_100232_.tb4_4(3),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='360
182'
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

 WHERE UNIT_ID = EXP_PROCESS_100232_.tb4_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100232_.tb4_0(3),
EXP_PROCESS_100232_.tb4_1(3),
EXP_PROCESS_100232_.tb4_2(3),
EXP_PROCESS_100232_.tb4_3(3),
EXP_PROCESS_100232_.tb4_4(3),
null,
null,
null,
null,
'360
182'
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
EXP_PROCESS_100232_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100232_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100232_.tb5_0(1):=123630;
EXP_PROCESS_100232_.tb5_1(1):=EXP_PROCESS_100232_.tb4_0(1);
EXP_PROCESS_100232_.tb5_2(1):=EXP_PROCESS_100232_.tb4_0(3);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (1)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100232_.tb5_0(1),
ORIGIN_ID=EXP_PROCESS_100232_.tb5_1(1),
TARGET_ID=EXP_PROCESS_100232_.tb5_2(1),
GEOMETRY='65
338
397
337'
,
GROUP_ID=0,
EXPRESSION='FLAG_VALIDATE == NO'
,
EXPRESSION_TYPE=0,
DESCRIPTION='Sin elementos de red a reversar'
,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100232_.tb5_0(1);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100232_.tb5_0(1),
EXP_PROCESS_100232_.tb5_1(1),
EXP_PROCESS_100232_.tb5_2(1),
'65
338
397
337'
,
0,
'FLAG_VALIDATE == NO'
,
0,
'Sin elementos de red a reversar'
,
1);
end if;

exception when others then
EXP_PROCESS_100232_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100232_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100232_.tb6_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTE_CLASS fila (0)',1);
UPDATE GE_ATTRIBUTE_CLASS SET ATTRIBUTE_CLASS_ID=EXP_PROCESS_100232_.tb6_0(0),
NAME='De Entitdad'
,
DESCRIPTION='Valores que ser¿n tra¿dos de la tabla base usando old record'

 WHERE ATTRIBUTE_CLASS_ID = EXP_PROCESS_100232_.tb6_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTE_CLASS(ATTRIBUTE_CLASS_ID,NAME,DESCRIPTION) 
VALUES (EXP_PROCESS_100232_.tb6_0(0),
'De Entitdad'
,
'Valores que ser¿n tra¿dos de la tabla base usando old record'
);
end if;

exception when others then
EXP_PROCESS_100232_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100232_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100232_.tb7_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES_TYPE fila (0)',1);
UPDATE GE_ATTRIBUTES_TYPE SET ATTRIBUTE_TYPE_ID=EXP_PROCESS_100232_.tb7_0(0),
DESCRIPTION='NUMBER'
,
INTERNAL_TYPE=2,
INTERNAL_JAVA_TYPE=2
 WHERE ATTRIBUTE_TYPE_ID = EXP_PROCESS_100232_.tb7_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES_TYPE(ATTRIBUTE_TYPE_ID,DESCRIPTION,INTERNAL_TYPE,INTERNAL_JAVA_TYPE) 
VALUES (EXP_PROCESS_100232_.tb7_0(0),
'NUMBER'
,
2,
2);
end if;

exception when others then
EXP_PROCESS_100232_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100232_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100232_.tb8_0(0):=400;
EXP_PROCESS_100232_.tb8_1(0):=EXP_PROCESS_100232_.tb6_0(0);
EXP_PROCESS_100232_.tb8_2(0):=EXP_PROCESS_100232_.tb7_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (0)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=EXP_PROCESS_100232_.tb8_0(0),
ATTRIBUTE_CLASS_ID=EXP_PROCESS_100232_.tb8_1(0),
ATTRIBUTE_TYPE_ID=EXP_PROCESS_100232_.tb8_2(0),
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

 WHERE ATTRIBUTE_ID = EXP_PROCESS_100232_.tb8_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,ATTRIBUTE_CLASS_ID,ATTRIBUTE_TYPE_ID,VALID_EXPRESSION,FATHER_ID,MODULE_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (EXP_PROCESS_100232_.tb8_0(0),
EXP_PROCESS_100232_.tb8_1(0),
EXP_PROCESS_100232_.tb8_2(0),
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
EXP_PROCESS_100232_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100232_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100232_.tb9_0(0):=126436;
EXP_PROCESS_100232_.tb9_1(0):=EXP_PROCESS_100232_.tb4_0(1);
EXP_PROCESS_100232_.tb9_2(0):=EXP_PROCESS_100232_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (0)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100232_.tb9_0(0),
UNIT_ID=EXP_PROCESS_100232_.tb9_1(0),
ATTRIBUTE_ID=EXP_PROCESS_100232_.tb9_2(0),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=1,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100232_.tb9_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100232_.tb9_0(0),
EXP_PROCESS_100232_.tb9_1(0),
EXP_PROCESS_100232_.tb9_2(0),
null,
null,
'N'
,
1,
'N'
);
end if;

exception when others then
EXP_PROCESS_100232_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100232_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100232_.tb6_0(1):=8;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTE_CLASS fila (1)',1);
UPDATE GE_ATTRIBUTE_CLASS SET ATTRIBUTE_CLASS_ID=EXP_PROCESS_100232_.tb6_0(1),
NAME='Por Defecto General'
,
DESCRIPTION='Valores que ser¿n utilizados para clasificaci¿n gen¿rica'

 WHERE ATTRIBUTE_CLASS_ID = EXP_PROCESS_100232_.tb6_0(1);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTE_CLASS(ATTRIBUTE_CLASS_ID,NAME,DESCRIPTION) 
VALUES (EXP_PROCESS_100232_.tb6_0(1),
'Por Defecto General'
,
'Valores que ser¿n utilizados para clasificaci¿n gen¿rica'
);
end if;

exception when others then
EXP_PROCESS_100232_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100232_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100232_.tb8_0(1):=442;
EXP_PROCESS_100232_.tb8_1(1):=EXP_PROCESS_100232_.tb6_0(1);
EXP_PROCESS_100232_.tb8_2(1):=EXP_PROCESS_100232_.tb7_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (1)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=EXP_PROCESS_100232_.tb8_0(1),
ATTRIBUTE_CLASS_ID=EXP_PROCESS_100232_.tb8_1(1),
ATTRIBUTE_TYPE_ID=EXP_PROCESS_100232_.tb8_2(1),
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

 WHERE ATTRIBUTE_ID = EXP_PROCESS_100232_.tb8_0(1);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,ATTRIBUTE_CLASS_ID,ATTRIBUTE_TYPE_ID,VALID_EXPRESSION,FATHER_ID,MODULE_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (EXP_PROCESS_100232_.tb8_0(1),
EXP_PROCESS_100232_.tb8_1(1),
EXP_PROCESS_100232_.tb8_2(1),
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
EXP_PROCESS_100232_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100232_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100232_.old_tb10_0(0):=120197049;
EXP_PROCESS_100232_.tb10_0(0):=GE_BOSEQUENCE.NEXTGE_STATEMENT;
EXP_PROCESS_100232_.tb10_0(0):=EXP_PROCESS_100232_.tb10_0(0);
ut_trace.trace('insertando tabla: GE_STATEMENT fila (0)',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID,MODULE_ID,DESCRIPTION,STATEMENT,NAME) 
VALUES (EXP_PROCESS_100232_.tb10_0(0),
9,
'LBC-Valida si se deben Realizar Contrabajos de Asignaci¿n'
,
'SELECT CF_BOStatementsWf.fnuGetAnnulNetElem(:INST.EXTERNAL_ID:) FLAG_VALIDATE FROM DUAL'
,
'LBC-Valida si se deben Realizar Contrabajos de Asignaci¿n'
);

exception when others then
EXP_PROCESS_100232_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100232_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100232_.tb9_0(1):=126437;
EXP_PROCESS_100232_.tb9_1(1):=EXP_PROCESS_100232_.tb4_0(1);
EXP_PROCESS_100232_.tb9_2(1):=EXP_PROCESS_100232_.tb8_0(1);
EXP_PROCESS_100232_.tb9_3(1):=EXP_PROCESS_100232_.tb10_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (1)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100232_.tb9_0(1),
UNIT_ID=EXP_PROCESS_100232_.tb9_1(1),
ATTRIBUTE_ID=EXP_PROCESS_100232_.tb9_2(1),
STATEMENT_ID=EXP_PROCESS_100232_.tb9_3(1),
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='Y'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100232_.tb9_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100232_.tb9_0(1),
EXP_PROCESS_100232_.tb9_1(1),
EXP_PROCESS_100232_.tb9_2(1),
EXP_PROCESS_100232_.tb9_3(1),
null,
'N'
,
2,
'Y'
);
end if;

exception when others then
EXP_PROCESS_100232_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100232_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100232_.tb5_0(2):=118937;
EXP_PROCESS_100232_.tb5_1(2):=EXP_PROCESS_100232_.tb4_0(2);
EXP_PROCESS_100232_.tb5_2(2):=EXP_PROCESS_100232_.tb4_0(3);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (2)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100232_.tb5_0(2),
ORIGIN_ID=EXP_PROCESS_100232_.tb5_1(2),
TARGET_ID=EXP_PROCESS_100232_.tb5_2(2),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION=null,
EXPRESSION_TYPE=0,
DESCRIPTION=null,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100232_.tb5_0(2);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100232_.tb5_0(2),
EXP_PROCESS_100232_.tb5_1(2),
EXP_PROCESS_100232_.tb5_2(2),
null,
0,
null,
0,
null,
1);
end if;

exception when others then
EXP_PROCESS_100232_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100232_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100232_.tb9_0(2):=126453;
EXP_PROCESS_100232_.tb9_1(2):=EXP_PROCESS_100232_.tb4_0(2);
EXP_PROCESS_100232_.tb9_2(2):=EXP_PROCESS_100232_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (2)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100232_.tb9_0(2),
UNIT_ID=EXP_PROCESS_100232_.tb9_1(2),
ATTRIBUTE_ID=EXP_PROCESS_100232_.tb9_2(2),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=1,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100232_.tb9_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100232_.tb9_0(2),
EXP_PROCESS_100232_.tb9_1(2),
EXP_PROCESS_100232_.tb9_2(2),
null,
null,
'N'
,
1,
'N'
);
end if;

exception when others then
EXP_PROCESS_100232_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100232_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100232_.tb9_0(3):=126438;
EXP_PROCESS_100232_.tb9_1(3):=EXP_PROCESS_100232_.tb4_0(3);
EXP_PROCESS_100232_.tb9_2(3):=EXP_PROCESS_100232_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (3)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100232_.tb9_0(3),
UNIT_ID=EXP_PROCESS_100232_.tb9_1(3),
ATTRIBUTE_ID=EXP_PROCESS_100232_.tb9_2(3),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100232_.tb9_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100232_.tb9_0(3),
EXP_PROCESS_100232_.tb9_1(3),
EXP_PROCESS_100232_.tb9_2(3),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_100232_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100232_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100232_.tb9_0(4):=126439;
EXP_PROCESS_100232_.tb9_1(4):=EXP_PROCESS_100232_.tb4_0(3);
EXP_PROCESS_100232_.tb9_2(4):=EXP_PROCESS_100232_.tb8_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (4)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100232_.tb9_0(4),
UNIT_ID=EXP_PROCESS_100232_.tb9_1(4),
ATTRIBUTE_ID=EXP_PROCESS_100232_.tb9_2(4),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100232_.tb9_0(4);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100232_.tb9_0(4),
EXP_PROCESS_100232_.tb9_1(4),
EXP_PROCESS_100232_.tb9_2(4),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_100232_.blProcessStatus := false;
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
sa_bocreatePackages.CreatePackage('EXP_UNITTYPE_100233_',
'CREATE OR REPLACE PACKAGE EXP_UNITTYPE_100233_ IS ' || chr(10) ||
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
'END EXP_UNITTYPE_100233_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_UNITTYPE_100233_******************************'); END;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_UNITTYPE_100233',1);
EXP_UNITTYPE_100233_.blProcessStatus := EXP_PROCESS_100232_.blProcessStatus ; 
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
AND     A.TASK_CODE = 100233
 
;
BEGIN

if (not EXP_UNITTYPE_100233_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_UNITTYPE_100233_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
FROM WF_UNIT_TYPE_ATTRIB WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100233);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100233_.blProcessStatus) then
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
EXP_UNITTYPE_100233_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_CAUSAL_UNIT_TYPE WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100233);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100233_.blProcessStatus) then
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
EXP_UNITTYPE_100233_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM MO_TIME_UNI_TYP_PRIO WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100233);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100233_.blProcessStatus) then
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
EXP_UNITTYPE_100233_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM OR_ACT_BY_TASK_MOD WHERE (TASK_CODE) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100233);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100233_.blProcessStatus) then
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
EXP_UNITTYPE_100233_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100233;
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100233_.blProcessStatus) then
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
EXP_UNITTYPE_100233_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_UNITTYPE_100233_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100233_.tb0_0(0):=100233;
ut_trace.trace('insertando tabla sin fallo: WF_UNIT_TYPE fila (0)',1);
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_UNITTYPE_100233_.tb0_0(0),
2,
5,
null,
100213,
null,
null,
null,
null,
'UNIT_TYPE_100233'
,
'Desasignaci¿n Autom¿tica'
,
'Desasignaci¿n Autom¿tica'
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
EXP_UNITTYPE_100233_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100232',1);
EXP_PROCESS_100232_.blProcessStatus := EXP_UNITTYPE_100233_.blProcessStatus ; 
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
 nuIndex := EXP_UNITTYPE_100233_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_UNITTYPE_100233_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_UNITTYPE_100233_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_UNITTYPE_100233_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_UNITTYPE_100233_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_UNITTYPE_100233_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_UNITTYPE_100233_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_UNITTYPE_100233_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_UNITTYPE_100233_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_UNITTYPE_100233_******************************'); end;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100248',1);
EXP_PROCESS_100248_.blProcessStatus := EXP_PROCESS_100232_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
DECLARE 
    nuBinaryIndex Binary_Integer;
BEGIN 
    nuBinaryIndex := EXP_PROCESS_100232_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = EXP_PROCESS_100232_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||EXP_PROCESS_100232_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||EXP_PROCESS_100232_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := EXP_PROCESS_100232_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       EXP_PROCESS_100232_.blProcessStatus := FALSE;
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
 nuIndex := EXP_PROCESS_100232_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_PROCESS_100232_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_PROCESS_100232_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_PROCESS_100232_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_PROCESS_100232_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_PROCESS_100232_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_PROCESS_100232_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_PROCESS_100232_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_PROCESS_100232_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_PROCESS_100232_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_PROCESS_100241_',
'CREATE OR REPLACE PACKAGE EXP_PROCESS_100241_ IS ' || chr(10) ||
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
'tb4_7 ty4_7;type ty5_0 is table of GR_CONFIGURA_TYPE.CONFIGURA_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb5_0 ty5_0; ' || chr(10) ||
'tb5_0 ty5_0;type ty6_0 is table of GR_CONFIG_EXPRESSION.CONFIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_0 ty6_0; ' || chr(10) ||
'tb6_0 ty6_0;type ty6_1 is table of GR_CONFIG_EXPRESSION.OBJECT_NAME%type index by binary_integer; ' || chr(10) ||
'old_tb6_1 ty6_1; ' || chr(10) ||
'tb6_1 ty6_1;type ty6_2 is table of GR_CONFIG_EXPRESSION.CONFIGURA_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb6_2 ty6_2; ' || chr(10) ||
'tb6_2 ty6_2;type ty7_0 is table of WF_TRANSITION.TRANS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_0 ty7_0; ' || chr(10) ||
'tb7_0 ty7_0;type ty7_1 is table of WF_TRANSITION.ORIGIN_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_1 ty7_1; ' || chr(10) ||
'tb7_1 ty7_1;type ty7_2 is table of WF_TRANSITION.TARGET_ID%type index by binary_integer; ' || chr(10) ||
'old_tb7_2 ty7_2; ' || chr(10) ||
'tb7_2 ty7_2;type ty8_0 is table of GE_ATTRIBUTE_CLASS.ATTRIBUTE_CLASS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb8_0 ty8_0; ' || chr(10) ||
'tb8_0 ty8_0;type ty9_0 is table of GE_ATTRIBUTES_TYPE.ATTRIBUTE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb9_0 ty9_0; ' || chr(10) ||
'tb9_0 ty9_0;type ty10_0 is table of GE_ATTRIBUTES.ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb10_0 ty10_0; ' || chr(10) ||
'tb10_0 ty10_0;type ty10_1 is table of GE_ATTRIBUTES.ATTRIBUTE_CLASS_ID%type index by binary_integer; ' || chr(10) ||
'old_tb10_1 ty10_1; ' || chr(10) ||
'tb10_1 ty10_1;type ty10_2 is table of GE_ATTRIBUTES.ATTRIBUTE_TYPE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb10_2 ty10_2; ' || chr(10) ||
'tb10_2 ty10_2;type ty11_0 is table of WF_UNIT_ATTRIBUTE.UNIT_ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb11_0 ty11_0; ' || chr(10) ||
'tb11_0 ty11_0;type ty11_1 is table of WF_UNIT_ATTRIBUTE.UNIT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb11_1 ty11_1; ' || chr(10) ||
'tb11_1 ty11_1;type ty11_2 is table of WF_UNIT_ATTRIBUTE.ATTRIBUTE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb11_2 ty11_2; ' || chr(10) ||
'tb11_2 ty11_2;type ty11_3 is table of WF_UNIT_ATTRIBUTE.STATEMENT_ID%type index by binary_integer; ' || chr(10) ||
'old_tb11_3 ty11_3; ' || chr(10) ||
'tb11_3 ty11_3; ' || chr(10) ||
'CURSOR cuExpression is ' || chr(10) ||
'SELECT PRE_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_TYPE_ID = 100241 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID IN  ' || chr(10) ||
'           (SELECT UNIT_ID ' || chr(10) ||
'           FROM WF_UNIT ' || chr(10) ||
'           WHERE UNIT_TYPE_ID = 100241 ' || chr(10) ||
'       )) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_TYPE_ID = 100241 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID IN  ' || chr(10) ||
'           (SELECT UNIT_ID ' || chr(10) ||
'           FROM WF_UNIT ' || chr(10) ||
'           WHERE UNIT_TYPE_ID = 100241 ' || chr(10) ||
'       )) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_PROCESS_100241_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_PROCESS_100241_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open EXP_PROCESS_100241_.cuExpression;
   fetch EXP_PROCESS_100241_.cuExpression bulk collect INTO EXP_PROCESS_100241_.tbGR_CONFIG_EXPRESSIONId;
   close EXP_PROCESS_100241_.cuExpression;
END;
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100241',1);
EXP_PROCESS_100241_.blProcessStatus := EXP_PROCESS_100248_.blProcessStatus ; 
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
sa_bocreatePackages.CreatePackage('DEL_ROOT_100919_',
'CREATE OR REPLACE PACKAGE DEL_ROOT_100919_ IS ' || chr(10) ||
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
'tb0_7 ty0_7;type ty1_0 is table of GR_CONFIG_EXPRESSION.CONFIG_EXPRESSION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_0 ty1_0; ' || chr(10) ||
'tb1_0 ty1_0;type ty1_1 is table of GR_CONFIG_EXPRESSION.OBJECT_NAME%type index by binary_integer; ' || chr(10) ||
'old_tb1_1 ty1_1; ' || chr(10) ||
'tb1_1 ty1_1;type ty2_0 is table of WF_TRANSITION.TRANS_ID%type index by binary_integer; ' || chr(10) ||
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
'        WHERE UNIT_ID = 100919 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 100919  ' || chr(10) ||
'       ) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_ID = 100919 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 100919  ' || chr(10) ||
'       ) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END DEL_ROOT_100919_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:DEL_ROOT_100919_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open DEL_ROOT_100919_.cuExpression;
   fetch DEL_ROOT_100919_.cuExpression bulk collect INTO DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONId;
   close DEL_ROOT_100919_.cuExpression;
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
        WHERE UNIT_ID = 100919
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID = 100919 
       )
;
BEGIN

if (not DEL_ROOT_100919_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  DEL_ROOT_100919_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE PROCESS_ID = 100919);
BEGIN 

if (not DEL_ROOT_100919_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100919_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE PROCESS_ID = 100919);
BEGIN 

if (not DEL_ROOT_100919_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100919_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 100919)));
BEGIN 

if (not DEL_ROOT_100919_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100919_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 100919)));
BEGIN 

if (not DEL_ROOT_100919_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100919_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 100919));
BEGIN 

if (not DEL_ROOT_100919_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla WF_UNIT',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100919_.tbWF_UNITRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100919_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 100919);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100919_.blProcessStatus) then
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
DEL_ROOT_100919_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100919_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100919_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100919_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100919_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100919_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria WF_UNIT',1);
nuVarcharIndex:=DEL_ROOT_100919_.tbWF_UNITRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from WF_UNIT where rowid = DEL_ROOT_100919_.tbWF_UNITRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100919_.tbWF_UNITRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100919_.tbWF_UNITRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100919_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_DATA_MAP WHERE (SOURCE_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 100919));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100919_.blProcessStatus) then
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
DEL_ROOT_100919_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_DATA_MAP WHERE (TARGET_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 100919));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100919_.blProcessStatus) then
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
DEL_ROOT_100919_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE PROCESS_ID = 100919);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100919_.blProcessStatus) then
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
DEL_ROOT_100919_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT WHERE PROCESS_ID = 100919;
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100919_.blProcessStatus) then
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
DEL_ROOT_100919_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100919_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100919_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100919_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100919_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/

BEGIN
    ut_trace.trace('Actualizar WF_UNIT a ProcessId NULL ',1);
   UPDATE WF_UNIT 
     SET PROCESS_ID = -1, POS_EXPRESSION_ID = null, PRE_EXPRESSION_ID = null, ACTION_ID = null 
     WHERE PROCESS_ID = 100919;
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
    nuBinaryIndex := DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       DEL_ROOT_100919_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100241',1);
EXP_PROCESS_100241_.blProcessStatus := DEL_ROOT_100919_.blProcessStatus ; 
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

if (not DEL_ROOT_100919_.blProcessStatus) then
 return;
end if;
nuRowProcess:=DEL_ROOT_100919_.tb1_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| DEL_ROOT_100919_.tb1_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(DEL_ROOT_100919_.tb1_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| DEL_ROOT_100919_.tb1_0(nuRowProcess),1);
end;
nuRowProcess := DEL_ROOT_100919_.tb1_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
DEL_ROOT_100919_.blProcessStatus := false;
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
 nuIndex := DEL_ROOT_100919_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || DEL_ROOT_100919_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(DEL_ROOT_100919_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(DEL_ROOT_100919_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(DEL_ROOT_100919_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || DEL_ROOT_100919_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || DEL_ROOT_100919_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := DEL_ROOT_100919_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('DEL_ROOT_100919_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:DEL_ROOT_100919_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('DEL_ROOT_100919_',
'CREATE OR REPLACE PACKAGE DEL_ROOT_100919_ IS ' || chr(10) ||
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
'        WHERE UNIT_ID = 100919 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 100919  ' || chr(10) ||
'       ) ' || chr(10) ||
'AND   PRE_EXPRESSION_ID IS NOT NULL ' || chr(10) ||
'UNION ALL  ' || chr(10) ||
'SELECT POS_EXPRESSION_ID ' || chr(10) ||
'FROM   WF_UNIT ' || chr(10) ||
'WHERE   UNIT_ID IN ( ' || chr(10) ||
'        SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE UNIT_ID = 100919 ' || chr(10) ||
'        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT  ' || chr(10) ||
'        WHERE PROCESS_ID = 100919  ' || chr(10) ||
'       ) ' || chr(10) ||
' ' || chr(10) ||
'AND   POS_EXPRESSION_ID IS NOT NULL ; ' || chr(10) ||
'    type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'    tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END DEL_ROOT_100919_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:DEL_ROOT_100919_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open DEL_ROOT_100919_.cuExpression;
   fetch DEL_ROOT_100919_.cuExpression bulk collect INTO DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONId;
   close DEL_ROOT_100919_.cuExpression;
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
        WHERE UNIT_ID = 100919
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID = 100919 
       )
;
BEGIN

if (not DEL_ROOT_100919_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  DEL_ROOT_100919_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE UNIT_ID = 100919);
BEGIN 

if (not DEL_ROOT_100919_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100919_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE UNIT_ID = 100919);
BEGIN 

if (not DEL_ROOT_100919_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100919_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 100919)));
BEGIN 

if (not DEL_ROOT_100919_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100919_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 100919)));
BEGIN 

if (not DEL_ROOT_100919_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100919_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM WF_UNIT WHERE (UNIT_ID) in (SELECT TARGET_ID FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 100919));
BEGIN 

if (not DEL_ROOT_100919_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla WF_UNIT',1);
for rcData in cuLoadTemporaryTable loop
DEL_ROOT_100919_.tbWF_UNITRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
DEL_ROOT_100919_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_TRANSITION WHERE (TARGET_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 100919);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100919_.blProcessStatus) then
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
DEL_ROOT_100919_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100919_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100919_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100919_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100919_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100919_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria WF_UNIT',1);
nuVarcharIndex:=DEL_ROOT_100919_.tbWF_UNITRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from WF_UNIT where rowid = DEL_ROOT_100919_.tbWF_UNITRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100919_.tbWF_UNITRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100919_.tbWF_UNITRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100919_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_DATA_MAP WHERE (SOURCE_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 100919));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100919_.blProcessStatus) then
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
DEL_ROOT_100919_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_DATA_MAP WHERE (TARGET_ID) in (SELECT UNIT_ATTRIBUTE_ID FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 100919));
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100919_.blProcessStatus) then
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
DEL_ROOT_100919_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_ATTRIBUTE WHERE (UNIT_ID) in (SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_ID = 100919);
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100919_.blProcessStatus) then
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
DEL_ROOT_100919_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT WHERE UNIT_ID = 100919;
nuIndex binary_integer;
BEGIN

if (not DEL_ROOT_100919_.blProcessStatus) then
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
DEL_ROOT_100919_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100919_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100919_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not DEL_ROOT_100919_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
DEL_ROOT_100919_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/

BEGIN
    ut_trace.trace('Actualizar WF_UNIT a ProcessId NULL ',1);
   UPDATE WF_UNIT 
     SET PROCESS_ID = -1, POS_EXPRESSION_ID = null, PRE_EXPRESSION_ID = null, ACTION_ID = null 
     WHERE PROCESS_ID = 100919;
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
    nuBinaryIndex := DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := DEL_ROOT_100919_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       DEL_ROOT_100919_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100241',1);
EXP_PROCESS_100241_.blProcessStatus := DEL_ROOT_100919_.blProcessStatus ; 
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
 nuIndex := DEL_ROOT_100919_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || DEL_ROOT_100919_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(DEL_ROOT_100919_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(DEL_ROOT_100919_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(DEL_ROOT_100919_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || DEL_ROOT_100919_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || DEL_ROOT_100919_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := DEL_ROOT_100919_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('DEL_ROOT_100919_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:DEL_ROOT_100919_******************************'); end;
/

BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('EXP_ACTION_47_',
'CREATE OR REPLACE PACKAGE EXP_ACTION_47_ IS ' || chr(10) ||
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
'WHERE  ACTION_ID =47; ' || chr(10) ||
'type tyGR_CONFIG_EXPRESSIONId is table of gr_config_expression.config_expression_id%type index by binary_integer; ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONId tyGR_CONFIG_EXPRESSIONId;  ' || chr(10) ||
' ' || chr(10) ||
' ' || chr(10) ||
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
' ' || chr(10) ||
'END EXP_ACTION_47_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_ACTION_47_******************************'); END;
/


BEGIN
   ut_trace.trace('Cargando tabla en memoria para posterior borrado GR_CONFIG_EXPRESSION',1);
   open EXP_ACTION_47_.cuExpression;
   fetch EXP_ACTION_47_.cuExpression bulk collect INTO EXP_ACTION_47_.tbGR_CONFIG_EXPRESSIONId;
   close EXP_ACTION_47_.cuExpression;
END;
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_ACTION_47',1);
EXP_ACTION_47_.blProcessStatus := EXP_PROCESS_100241_.blProcessStatus ; 
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
AND     A.ACTION_ID =47
;
BEGIN

if (not EXP_ACTION_47_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_ACTION_47_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT CONFIG_EXPRESSION_ID FROM GE_ACTION_MODULE WHERE ACTION_ID=47);
BEGIN 

if (not EXP_ACTION_47_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_ACTION_47_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_ACTION_47_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM GE_ACTION_MODULE WHERE ACTION_ID=47;
nuIndex binary_integer;
BEGIN

if (not EXP_ACTION_47_.blProcessStatus) then
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
EXP_ACTION_47_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_ACTION_47_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_ACTION_47_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_ACTION_47_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_ACTION_47_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_ACTION_47_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_ACTION_47_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_ACTION_47_.blProcessStatus) then
 return;
end if;

EXP_ACTION_47_.tb0_0(0):=2;
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=EXP_ACTION_47_.tb0_0(0),
MODULE_ID=5,
DESCRIPTION='Acciones Ejecuci¿n'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='_EXECACC_'

 WHERE CONFIGURA_TYPE_ID = EXP_ACTION_47_.tb0_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (EXP_ACTION_47_.tb0_0(0),
5,
'Acciones Ejecuci¿n'
,
'PL'
,
'FD'
,
'DS'
,
'_EXECACC_'
);
end if;

exception when others then
EXP_ACTION_47_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_47_.blProcessStatus) then
 return;
end if;

EXP_ACTION_47_.old_tb1_0(0):=121401246;
EXP_ACTION_47_.tb1_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
EXP_ACTION_47_.tb1_0(0):=EXP_ACTION_47_.tb1_0(0);
EXP_ACTION_47_.old_tb1_1(0):='MO_EXECACC_CT2E121401246'
;
EXP_ACTION_47_.tb1_1(0):=TO_CHAR(EXP_ACTION_47_.tb1_0(0));
EXP_ACTION_47_.tb1_2(0):=EXP_ACTION_47_.tb0_0(0);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (EXP_ACTION_47_.tb1_0(0),
EXP_ACTION_47_.tb1_1(0),
EXP_ACTION_47_.tb1_2(0),
'GE_BOInstance.GetValue("MO_PACKAGES","PACKAGE_ID",nuPackageId);MO_BOAnnulment.AnnulFinal(nuPackageId);nuAnnulPackage = MO_BCDETALLEANULSOLICITUD.FNUGETANNULPACK(nuPackageId);CF_BOACTIONS.ANULLFLOWACTIVATE(nuPackageId);nuIdPackageRecupero = MO_BOPackages_Asso.fnuGetPackageFather(nuPackageId, "P_RECUPERO");MO_BOAction.ActivatePackageFlow(nuIdPackageRecupero)'
,
'FLEX'
,
to_date('02-09-2002 21:48:24','DD-MM-YYYY HH24:MI:SS'),
to_date('28-02-2024 08:49:42','DD-MM-YYYY HH24:MI:SS'),
to_date('28-02-2024 08:49:42','DD-MM-YYYY HH24:MI:SS'),
'G'
,
'N'
,
'PU'
,
null,
'DS'
,
'Anulaci¿n final de motivos o componentes'
,
'PP'
,
null);

exception when others then
EXP_ACTION_47_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_47_.blProcessStatus) then
 return;
end if;

EXP_ACTION_47_.tb2_0(0):=47;
EXP_ACTION_47_.tb2_2(0):=EXP_ACTION_47_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ACTION_MODULE fila (0)',1);
UPDATE GE_ACTION_MODULE SET ACTION_ID=EXP_ACTION_47_.tb2_0(0),
MODULE_ID=5,
CONFIG_EXPRESSION_ID=EXP_ACTION_47_.tb2_2(0),
DESCRIPTION='Anulaci¿n Final'
,
EXE_AT_STATUS_CHANGE='N'
,
EXE_TRANSITION_STATE='N'

 WHERE ACTION_ID = EXP_ACTION_47_.tb2_0(0);
if not (sql%found) then
INSERT INTO GE_ACTION_MODULE(ACTION_ID,MODULE_ID,CONFIG_EXPRESSION_ID,DESCRIPTION,EXE_AT_STATUS_CHANGE,EXE_TRANSITION_STATE) 
VALUES (EXP_ACTION_47_.tb2_0(0),
5,
EXP_ACTION_47_.tb2_2(0),
'Anulaci¿n Final'
,
'N'
,
'N'
);
end if;

exception when others then
EXP_ACTION_47_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_ACTION_47_.blProcessStatus) then
 return;
end if;

EXP_ACTION_47_.tb3_0(0):=EXP_ACTION_47_.tb2_0(0);
EXP_ACTION_47_.tb3_1(0):=9;
ut_trace.trace('insertando tabla sin fallo: GE_VALID_ACTION_MODU fila (0)',1);
INSERT INTO GE_VALID_ACTION_MODU(ACTION_ID,VALID_MODULE_ID) 
VALUES (EXP_ACTION_47_.tb3_0(0),
EXP_ACTION_47_.tb3_1(0));

exception 
when dup_val_on_index then 
 return;
when others then
EXP_ACTION_47_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
DECLARE 
    nuBinaryIndex Binary_Integer;
BEGIN 
    nuBinaryIndex := EXP_ACTION_47_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = EXP_ACTION_47_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||EXP_ACTION_47_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||EXP_ACTION_47_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := EXP_ACTION_47_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       EXP_ACTION_47_.blProcessStatus := FALSE;
       rollback;
       ut_trace.trace('**ERROR:'||sqlerrm);
       raise;
END; 
/ 
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100241',1);
EXP_PROCESS_100241_.blProcessStatus := EXP_ACTION_47_.blProcessStatus ; 
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

if (not EXP_ACTION_47_.blProcessStatus) then
 return;
end if;
nuRowProcess:=EXP_ACTION_47_.tb1_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| EXP_ACTION_47_.tb1_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(EXP_ACTION_47_.tb1_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| EXP_ACTION_47_.tb1_0(nuRowProcess),1);
end;
nuRowProcess := EXP_ACTION_47_.tb1_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
EXP_ACTION_47_.blProcessStatus := false;
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
 nuIndex := EXP_ACTION_47_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_ACTION_47_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_ACTION_47_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_ACTION_47_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_ACTION_47_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_ACTION_47_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_ACTION_47_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_ACTION_47_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_ACTION_47_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_ACTION_47_******************************'); end;
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
        WHERE UNIT_TYPE_ID = 100241
        UNION ALL         SELECT UNIT_ID         FROM WF_UNIT 
        WHERE PROCESS_ID IN 
           (SELECT UNIT_ID
           FROM WF_UNIT
           WHERE UNIT_TYPE_ID = 100241
       ))
;
BEGIN

if (not EXP_PROCESS_100241_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_PROCESS_100241_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT PRE_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100241) AND NODE_TYPE_ID=0);
BEGIN 

if (not EXP_PROCESS_100241_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_PROCESS_100241_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_PROCESS_100241_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT POS_EXPRESSION_ID FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100241) AND NODE_TYPE_ID=0);
BEGIN 

if (not EXP_PROCESS_100241_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
EXP_PROCESS_100241_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
EXP_PROCESS_100241_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100241) AND NODE_TYPE_ID=0;
nuIndex binary_integer;
BEGIN

if (not EXP_PROCESS_100241_.blProcessStatus) then
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
EXP_PROCESS_100241_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_PROCESS_100241_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_PROCESS_100241_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_PROCESS_100241_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_PROCESS_100241_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_PROCESS_100241_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_PROCESS_100241_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not EXP_PROCESS_100241_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=EXP_PROCESS_100241_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = EXP_PROCESS_100241_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
EXP_PROCESS_100241_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := EXP_PROCESS_100241_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
EXP_PROCESS_100241_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100241;
nuIndex binary_integer;
BEGIN

if (not EXP_PROCESS_100241_.blProcessStatus) then
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
EXP_PROCESS_100241_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_PROCESS_100241_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100241_.tb0_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_CATEGORY fila (0)',1);
UPDATE WF_UNIT_CATEGORY SET CATEGORY_ID=EXP_PROCESS_100241_.tb0_0(0),
DISPLAY_NUMBER='Proceso B¿sico'

 WHERE CATEGORY_ID = EXP_PROCESS_100241_.tb0_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_CATEGORY(CATEGORY_ID,DISPLAY_NUMBER) 
VALUES (EXP_PROCESS_100241_.tb0_0(0),
'Proceso B¿sico'
);
end if;

exception when others then
EXP_PROCESS_100241_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100241_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100241_.tb1_0(0):=9;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (0)',1);
UPDATE GE_MODULE SET MODULE_ID=EXP_PROCESS_100241_.tb1_0(0),
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

 WHERE MODULE_ID = EXP_PROCESS_100241_.tb1_0(0);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (EXP_PROCESS_100241_.tb1_0(0),
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
EXP_PROCESS_100241_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100241_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100241_.tb2_0(0):=100241;
EXP_PROCESS_100241_.tb2_1(0):=EXP_PROCESS_100241_.tb0_0(0);
EXP_PROCESS_100241_.tb2_2(0):=EXP_PROCESS_100241_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (0)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100241_.tb2_0(0),
CATEGORY_ID=EXP_PROCESS_100241_.tb2_1(0),
MODULE_ID=EXP_PROCESS_100241_.tb2_2(0),
ACTION_ID=null,
PARENT_ID=100213,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_100241'
,
DESCRIPTION='Atenci¿n de la Anulaci¿n'
,
DISPLAY='Atenci¿n de la Anulaci¿n'
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100241_.tb2_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100241_.tb2_0(0),
EXP_PROCESS_100241_.tb2_1(0),
EXP_PROCESS_100241_.tb2_2(0),
null,
100213,
null,
null,
null,
null,
'UNIT_TYPE_100241'
,
'Atenci¿n de la Anulaci¿n'
,
'Atenci¿n de la Anulaci¿n'
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
EXP_PROCESS_100241_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100241_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100241_.tb3_0(0):=0;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (0)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100241_.tb3_0(0),
DESCRIPTION='Ra¿z'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100241_.tb3_0(0);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100241_.tb3_0(0),
'Ra¿z'
);
end if;

exception when others then
EXP_PROCESS_100241_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100241_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100241_.tb4_0(0):=100919;
EXP_PROCESS_100241_.tb4_2(0):=EXP_PROCESS_100241_.tb2_0(0);
EXP_PROCESS_100241_.tb4_3(0):=EXP_PROCESS_100241_.tb3_0(0);
EXP_PROCESS_100241_.tb4_4(0):=EXP_PROCESS_100241_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (0)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100241_.tb4_0(0),
PROCESS_ID=null,
UNIT_TYPE_ID=EXP_PROCESS_100241_.tb4_2(0),
NODE_TYPE_ID=EXP_PROCESS_100241_.tb4_3(0),
MODULE_ID=EXP_PROCESS_100241_.tb4_4(0),
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

 WHERE UNIT_ID = EXP_PROCESS_100241_.tb4_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100241_.tb4_0(0),
null,
EXP_PROCESS_100241_.tb4_2(0),
EXP_PROCESS_100241_.tb4_3(0),
EXP_PROCESS_100241_.tb4_4(0),
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
EXP_PROCESS_100241_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100241_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100241_.tb0_0(1):=2;
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_CATEGORY fila (1)',1);
UPDATE WF_UNIT_CATEGORY SET CATEGORY_ID=EXP_PROCESS_100241_.tb0_0(1),
DISPLAY_NUMBER='Actividad'

 WHERE CATEGORY_ID = EXP_PROCESS_100241_.tb0_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_CATEGORY(CATEGORY_ID,DISPLAY_NUMBER) 
VALUES (EXP_PROCESS_100241_.tb0_0(1),
'Actividad'
);
end if;

exception when others then
EXP_PROCESS_100241_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100241_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100241_.tb2_0(1):=283;
EXP_PROCESS_100241_.tb2_1(1):=EXP_PROCESS_100241_.tb0_0(1);
EXP_PROCESS_100241_.tb2_2(1):=EXP_PROCESS_100241_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (1)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100241_.tb2_0(1),
CATEGORY_ID=EXP_PROCESS_100241_.tb2_1(1),
MODULE_ID=EXP_PROCESS_100241_.tb2_2(1),
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100241_.tb2_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100241_.tb2_0(1),
EXP_PROCESS_100241_.tb2_1(1),
EXP_PROCESS_100241_.tb2_2(1),
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
EXP_PROCESS_100241_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100241_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100241_.tb3_0(1):=1;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (1)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100241_.tb3_0(1),
DESCRIPTION='Arranque'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100241_.tb3_0(1);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100241_.tb3_0(1),
'Arranque'
);
end if;

exception when others then
EXP_PROCESS_100241_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100241_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100241_.tb4_0(1):=100920;
EXP_PROCESS_100241_.tb4_1(1):=EXP_PROCESS_100241_.tb4_0(0);
EXP_PROCESS_100241_.tb4_2(1):=EXP_PROCESS_100241_.tb2_0(1);
EXP_PROCESS_100241_.tb4_3(1):=EXP_PROCESS_100241_.tb3_0(1);
EXP_PROCESS_100241_.tb4_4(1):=EXP_PROCESS_100241_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (1)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100241_.tb4_0(1),
PROCESS_ID=EXP_PROCESS_100241_.tb4_1(1),
UNIT_TYPE_ID=EXP_PROCESS_100241_.tb4_2(1),
NODE_TYPE_ID=EXP_PROCESS_100241_.tb4_3(1),
MODULE_ID=EXP_PROCESS_100241_.tb4_4(1),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='20
187'
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

 WHERE UNIT_ID = EXP_PROCESS_100241_.tb4_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100241_.tb4_0(1),
EXP_PROCESS_100241_.tb4_1(1),
EXP_PROCESS_100241_.tb4_2(1),
EXP_PROCESS_100241_.tb4_3(1),
EXP_PROCESS_100241_.tb4_4(1),
null,
null,
null,
null,
'20
187'
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
EXP_PROCESS_100241_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100241_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100241_.tb1_0(1):=5;
ut_trace.trace('Actualizar o insertar tabla: GE_MODULE fila (1)',1);
UPDATE GE_MODULE SET MODULE_ID=EXP_PROCESS_100241_.tb1_0(1),
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

 WHERE MODULE_ID = EXP_PROCESS_100241_.tb1_0(1);
if not (sql%found) then
INSERT INTO GE_MODULE(MODULE_ID,DESCRIPTION,MNEMONIC,LAST_MESSAGE,PATH_MODULE,ICON_NAME,LOCALIZATION) 
VALUES (EXP_PROCESS_100241_.tb1_0(1),
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
EXP_PROCESS_100241_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100241_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100241_.tb2_0(2):=100242;
EXP_PROCESS_100241_.tb2_1(2):=EXP_PROCESS_100241_.tb0_0(1);
EXP_PROCESS_100241_.tb2_2(2):=EXP_PROCESS_100241_.tb1_0(1);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (2)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100241_.tb2_0(2),
CATEGORY_ID=EXP_PROCESS_100241_.tb2_1(2),
MODULE_ID=EXP_PROCESS_100241_.tb2_2(2),
ACTION_ID=null,
PARENT_ID=100213,
INIT_AREA_EXPRESSION_ID=null,
ASSIGN_COMMENT_CLASS=null,
ATTEND_COMMENT_CLASS=null,
UNASSIGN_COMMENT_CLASS=null,
TAG_NAME='UNIT_TYPE_100242'
,
DESCRIPTION='Atender Anulaci¿n'
,
DISPLAY='Atender Anulaci¿n'
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100241_.tb2_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100241_.tb2_0(2),
EXP_PROCESS_100241_.tb2_1(2),
EXP_PROCESS_100241_.tb2_2(2),
null,
100213,
null,
null,
null,
null,
'UNIT_TYPE_100242'
,
'Atender Anulaci¿n'
,
'Atender Anulaci¿n'
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
EXP_PROCESS_100241_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100241_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100241_.tb3_0(2):=2;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (2)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100241_.tb3_0(2),
DESCRIPTION='Normal'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100241_.tb3_0(2);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100241_.tb3_0(2),
'Normal'
);
end if;

exception when others then
EXP_PROCESS_100241_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100241_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100241_.tb5_0(0):=9;
ut_trace.trace('Actualizar o insertar tabla: GR_CONFIGURA_TYPE fila (0)',1);
UPDATE GR_CONFIGURA_TYPE SET CONFIGURA_TYPE_ID=EXP_PROCESS_100241_.tb5_0(0),
MODULE_ID=9,
DESCRIPTION='Reglas Post'
,
GENERATION_TYPE='PL'
,
EXECUTION_MODE='FD'
,
CALL_TYPE='DS'
,
GENERATION_MASK='WF_POST_RULE'

 WHERE CONFIGURA_TYPE_ID = EXP_PROCESS_100241_.tb5_0(0);
if not (sql%found) then
INSERT INTO GR_CONFIGURA_TYPE(CONFIGURA_TYPE_ID,MODULE_ID,DESCRIPTION,GENERATION_TYPE,EXECUTION_MODE,CALL_TYPE,GENERATION_MASK) 
VALUES (EXP_PROCESS_100241_.tb5_0(0),
9,
'Reglas Post'
,
'PL'
,
'FD'
,
'DS'
,
'WF_POST_RULE'
);
end if;

exception when others then
EXP_PROCESS_100241_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100241_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100241_.old_tb6_0(0):=121401270;
EXP_PROCESS_100241_.tb6_0(0):=GR_BOSEQUENCE.NEXTGR_CONFIG_EXPRESSION;
EXP_PROCESS_100241_.tb6_0(0):=EXP_PROCESS_100241_.tb6_0(0);
EXP_PROCESS_100241_.old_tb6_1(0):='WFWF_POST_RULECT9E121401270'
;
EXP_PROCESS_100241_.tb6_1(0):=TO_CHAR(EXP_PROCESS_100241_.tb6_0(0));
EXP_PROCESS_100241_.tb6_2(0):=EXP_PROCESS_100241_.tb5_0(0);
ut_trace.trace('insertando tabla: GR_CONFIG_EXPRESSION fila (0)',1);
INSERT INTO GR_CONFIG_EXPRESSION(CONFIG_EXPRESSION_ID,OBJECT_NAME,CONFIGURA_TYPE_ID,EXPRESSION,AUTHOR,CREATION_DATE,GENERATION_DATE,LAST_MODIFI_DATE,STATUS,USED_OTHER_EXPRESION,MODIFICATION_TYPE,PASSWORD,EXECUTION_TYPE,DESCRIPTION,OBJECT_TYPE,CODE) 
VALUES (EXP_PROCESS_100241_.tb6_0(0),
EXP_PROCESS_100241_.tb6_1(0),
EXP_PROCESS_100241_.tb6_2(0),
'PRCREVERSAESTADOPRODUCTO()'
,
'OPEN'
,
to_date('01-03-2024 11:46:47','DD-MM-YYYY HH24:MI:SS'),
to_date('01-03-2024 11:46:47','DD-MM-YYYY HH24:MI:SS'),
to_date('01-03-2024 11:46:47','DD-MM-YYYY HH24:MI:SS'),
'R'
,
'N'
,
'PU'
,
null,
'DS'
,
'Reversa el estado del producto - POST'
,
'PP'
,
null);

exception when others then
EXP_PROCESS_100241_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100241_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100241_.tb4_0(2):=100922;
EXP_PROCESS_100241_.tb4_1(2):=EXP_PROCESS_100241_.tb4_0(0);
EXP_PROCESS_100241_.tb4_2(2):=EXP_PROCESS_100241_.tb2_0(2);
EXP_PROCESS_100241_.tb4_3(2):=EXP_PROCESS_100241_.tb3_0(2);
EXP_PROCESS_100241_.tb4_4(2):=EXP_PROCESS_100241_.tb1_0(1);
EXP_PROCESS_100241_.tb4_7(2):=EXP_PROCESS_100241_.tb6_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (2)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100241_.tb4_0(2),
PROCESS_ID=EXP_PROCESS_100241_.tb4_1(2),
UNIT_TYPE_ID=EXP_PROCESS_100241_.tb4_2(2),
NODE_TYPE_ID=EXP_PROCESS_100241_.tb4_3(2),
MODULE_ID=EXP_PROCESS_100241_.tb4_4(2),
ACTION_ID=47,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=EXP_PROCESS_100241_.tb4_7(2),
NOTIFICATION_ID=9000,
GEOMETRY='173
180'
,
DESCRIPTION='Atender Anulaci¿n'
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

 WHERE UNIT_ID = EXP_PROCESS_100241_.tb4_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100241_.tb4_0(2),
EXP_PROCESS_100241_.tb4_1(2),
EXP_PROCESS_100241_.tb4_2(2),
EXP_PROCESS_100241_.tb4_3(2),
EXP_PROCESS_100241_.tb4_4(2),
47,
null,
EXP_PROCESS_100241_.tb4_7(2),
9000,
'173
180'
,
'Atender Anulaci¿n'
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
EXP_PROCESS_100241_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100241_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100241_.tb7_0(0):=118941;
EXP_PROCESS_100241_.tb7_1(0):=EXP_PROCESS_100241_.tb4_0(1);
EXP_PROCESS_100241_.tb7_2(0):=EXP_PROCESS_100241_.tb4_0(2);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (0)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100241_.tb7_0(0),
ORIGIN_ID=EXP_PROCESS_100241_.tb7_1(0),
TARGET_ID=EXP_PROCESS_100241_.tb7_2(0),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION=null,
EXPRESSION_TYPE=0,
DESCRIPTION=null,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100241_.tb7_0(0);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100241_.tb7_0(0),
EXP_PROCESS_100241_.tb7_1(0),
EXP_PROCESS_100241_.tb7_2(0),
null,
0,
null,
0,
null,
1);
end if;

exception when others then
EXP_PROCESS_100241_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100241_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100241_.tb8_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTE_CLASS fila (0)',1);
UPDATE GE_ATTRIBUTE_CLASS SET ATTRIBUTE_CLASS_ID=EXP_PROCESS_100241_.tb8_0(0),
NAME='De Entitdad'
,
DESCRIPTION='Valores que ser¿n tra¿dos de la tabla base usando old record'

 WHERE ATTRIBUTE_CLASS_ID = EXP_PROCESS_100241_.tb8_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTE_CLASS(ATTRIBUTE_CLASS_ID,NAME,DESCRIPTION) 
VALUES (EXP_PROCESS_100241_.tb8_0(0),
'De Entitdad'
,
'Valores que ser¿n tra¿dos de la tabla base usando old record'
);
end if;

exception when others then
EXP_PROCESS_100241_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100241_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100241_.tb9_0(0):=1;
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES_TYPE fila (0)',1);
UPDATE GE_ATTRIBUTES_TYPE SET ATTRIBUTE_TYPE_ID=EXP_PROCESS_100241_.tb9_0(0),
DESCRIPTION='NUMBER'
,
INTERNAL_TYPE=2,
INTERNAL_JAVA_TYPE=2
 WHERE ATTRIBUTE_TYPE_ID = EXP_PROCESS_100241_.tb9_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES_TYPE(ATTRIBUTE_TYPE_ID,DESCRIPTION,INTERNAL_TYPE,INTERNAL_JAVA_TYPE) 
VALUES (EXP_PROCESS_100241_.tb9_0(0),
'NUMBER'
,
2,
2);
end if;

exception when others then
EXP_PROCESS_100241_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100241_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100241_.tb10_0(0):=400;
EXP_PROCESS_100241_.tb10_1(0):=EXP_PROCESS_100241_.tb8_0(0);
EXP_PROCESS_100241_.tb10_2(0):=EXP_PROCESS_100241_.tb9_0(0);
ut_trace.trace('Actualizar o insertar tabla: GE_ATTRIBUTES fila (0)',1);
UPDATE GE_ATTRIBUTES SET ATTRIBUTE_ID=EXP_PROCESS_100241_.tb10_0(0),
ATTRIBUTE_CLASS_ID=EXP_PROCESS_100241_.tb10_1(0),
ATTRIBUTE_TYPE_ID=EXP_PROCESS_100241_.tb10_2(0),
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

 WHERE ATTRIBUTE_ID = EXP_PROCESS_100241_.tb10_0(0);
if not (sql%found) then
INSERT INTO GE_ATTRIBUTES(ATTRIBUTE_ID,ATTRIBUTE_CLASS_ID,ATTRIBUTE_TYPE_ID,VALID_EXPRESSION,FATHER_ID,MODULE_ID,NAME_ATTRIBUTE,LENGTH,PRECISION,SCALE,DEFAULT_VALUE,IS_FIX_OR_VARIABLE,COMMENT_,DISPLAY_NAME) 
VALUES (EXP_PROCESS_100241_.tb10_0(0),
EXP_PROCESS_100241_.tb10_1(0),
EXP_PROCESS_100241_.tb10_2(0),
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
EXP_PROCESS_100241_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100241_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100241_.tb11_0(0):=126446;
EXP_PROCESS_100241_.tb11_1(0):=EXP_PROCESS_100241_.tb4_0(1);
EXP_PROCESS_100241_.tb11_2(0):=EXP_PROCESS_100241_.tb10_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (0)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100241_.tb11_0(0),
UNIT_ID=EXP_PROCESS_100241_.tb11_1(0),
ATTRIBUTE_ID=EXP_PROCESS_100241_.tb11_2(0),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=1,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100241_.tb11_0(0);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100241_.tb11_0(0),
EXP_PROCESS_100241_.tb11_1(0),
EXP_PROCESS_100241_.tb11_2(0),
null,
null,
'N'
,
1,
'N'
);
end if;

exception when others then
EXP_PROCESS_100241_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100241_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100241_.tb2_0(3):=252;
EXP_PROCESS_100241_.tb2_1(3):=EXP_PROCESS_100241_.tb0_0(1);
EXP_PROCESS_100241_.tb2_2(3):=EXP_PROCESS_100241_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_TYPE fila (3)',1);
UPDATE WF_UNIT_TYPE SET UNIT_TYPE_ID=EXP_PROCESS_100241_.tb2_0(3),
CATEGORY_ID=EXP_PROCESS_100241_.tb2_1(3),
MODULE_ID=EXP_PROCESS_100241_.tb2_2(3),
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
 WHERE UNIT_TYPE_ID = EXP_PROCESS_100241_.tb2_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_PROCESS_100241_.tb2_0(3),
EXP_PROCESS_100241_.tb2_1(3),
EXP_PROCESS_100241_.tb2_2(3),
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
EXP_PROCESS_100241_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100241_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100241_.tb3_0(3):=3;
ut_trace.trace('Actualizar o insertar tabla: WF_NODE_TYPE fila (3)',1);
UPDATE WF_NODE_TYPE SET NODE_TYPE_ID=EXP_PROCESS_100241_.tb3_0(3),
DESCRIPTION='Final'

 WHERE NODE_TYPE_ID = EXP_PROCESS_100241_.tb3_0(3);
if not (sql%found) then
INSERT INTO WF_NODE_TYPE(NODE_TYPE_ID,DESCRIPTION) 
VALUES (EXP_PROCESS_100241_.tb3_0(3),
'Final'
);
end if;

exception when others then
EXP_PROCESS_100241_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100241_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100241_.tb4_0(3):=100921;
EXP_PROCESS_100241_.tb4_1(3):=EXP_PROCESS_100241_.tb4_0(0);
EXP_PROCESS_100241_.tb4_2(3):=EXP_PROCESS_100241_.tb2_0(3);
EXP_PROCESS_100241_.tb4_3(3):=EXP_PROCESS_100241_.tb3_0(3);
EXP_PROCESS_100241_.tb4_4(3):=EXP_PROCESS_100241_.tb1_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT fila (3)',1);
UPDATE WF_UNIT SET UNIT_ID=EXP_PROCESS_100241_.tb4_0(3),
PROCESS_ID=EXP_PROCESS_100241_.tb4_1(3),
UNIT_TYPE_ID=EXP_PROCESS_100241_.tb4_2(3),
NODE_TYPE_ID=EXP_PROCESS_100241_.tb4_3(3),
MODULE_ID=EXP_PROCESS_100241_.tb4_4(3),
ACTION_ID=null,
PRE_EXPRESSION_ID=null,
POS_EXPRESSION_ID=null,
NOTIFICATION_ID=null,
GEOMETRY='352
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

 WHERE UNIT_ID = EXP_PROCESS_100241_.tb4_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT(UNIT_ID,PROCESS_ID,UNIT_TYPE_ID,NODE_TYPE_ID,MODULE_ID,ACTION_ID,PRE_EXPRESSION_ID,POS_EXPRESSION_ID,NOTIFICATION_ID,GEOMETRY,DESCRIPTION,ONLINE_EXEC_ID,MULTI_INSTANCE,SINCRONIC_TIMEOUT,ASINCRONIC_TIMEOUT,FUNCTION_TYPE,IS_COUNTABLE,MIN_GROUP_SIZE,EXECUTION_ORDER,ANNULATION_ORDER,ENTITY_ID,VIEWABLE) 
VALUES (EXP_PROCESS_100241_.tb4_0(3),
EXP_PROCESS_100241_.tb4_1(3),
EXP_PROCESS_100241_.tb4_2(3),
EXP_PROCESS_100241_.tb4_3(3),
EXP_PROCESS_100241_.tb4_4(3),
null,
null,
null,
null,
'352
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
EXP_PROCESS_100241_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100241_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100241_.tb7_0(1):=118942;
EXP_PROCESS_100241_.tb7_1(1):=EXP_PROCESS_100241_.tb4_0(2);
EXP_PROCESS_100241_.tb7_2(1):=EXP_PROCESS_100241_.tb4_0(3);
ut_trace.trace('Actualizar o insertar tabla: WF_TRANSITION fila (1)',1);
UPDATE WF_TRANSITION SET TRANS_ID=EXP_PROCESS_100241_.tb7_0(1),
ORIGIN_ID=EXP_PROCESS_100241_.tb7_1(1),
TARGET_ID=EXP_PROCESS_100241_.tb7_2(1),
GEOMETRY=null,
GROUP_ID=0,
EXPRESSION=null,
EXPRESSION_TYPE=0,
DESCRIPTION=null,
TRANSITION_TYPE_ID=1
 WHERE TRANS_ID = EXP_PROCESS_100241_.tb7_0(1);
if not (sql%found) then
INSERT INTO WF_TRANSITION(TRANS_ID,ORIGIN_ID,TARGET_ID,GEOMETRY,GROUP_ID,EXPRESSION,EXPRESSION_TYPE,DESCRIPTION,TRANSITION_TYPE_ID) 
VALUES (EXP_PROCESS_100241_.tb7_0(1),
EXP_PROCESS_100241_.tb7_1(1),
EXP_PROCESS_100241_.tb7_2(1),
null,
0,
null,
0,
null,
1);
end if;

exception when others then
EXP_PROCESS_100241_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100241_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100241_.tb11_0(1):=126456;
EXP_PROCESS_100241_.tb11_1(1):=EXP_PROCESS_100241_.tb4_0(2);
EXP_PROCESS_100241_.tb11_2(1):=EXP_PROCESS_100241_.tb10_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (1)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100241_.tb11_0(1),
UNIT_ID=EXP_PROCESS_100241_.tb11_1(1),
ATTRIBUTE_ID=EXP_PROCESS_100241_.tb11_2(1),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=1,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100241_.tb11_0(1);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100241_.tb11_0(1),
EXP_PROCESS_100241_.tb11_1(1),
EXP_PROCESS_100241_.tb11_2(1),
null,
null,
'N'
,
1,
'N'
);
end if;

exception when others then
EXP_PROCESS_100241_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100241_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100241_.tb11_0(2):=126447;
EXP_PROCESS_100241_.tb11_1(2):=EXP_PROCESS_100241_.tb4_0(3);
EXP_PROCESS_100241_.tb11_2(2):=EXP_PROCESS_100241_.tb10_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (2)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100241_.tb11_0(2),
UNIT_ID=EXP_PROCESS_100241_.tb11_1(2),
ATTRIBUTE_ID=EXP_PROCESS_100241_.tb11_2(2),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100241_.tb11_0(2);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100241_.tb11_0(2),
EXP_PROCESS_100241_.tb11_1(2),
EXP_PROCESS_100241_.tb11_2(2),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_100241_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not EXP_PROCESS_100241_.blProcessStatus) then
 return;
end if;

EXP_PROCESS_100241_.tb11_0(3):=126448;
EXP_PROCESS_100241_.tb11_1(3):=EXP_PROCESS_100241_.tb4_0(3);
EXP_PROCESS_100241_.tb11_2(3):=EXP_PROCESS_100241_.tb10_0(0);
ut_trace.trace('Actualizar o insertar tabla: WF_UNIT_ATTRIBUTE fila (3)',1);
UPDATE WF_UNIT_ATTRIBUTE SET UNIT_ATTRIBUTE_ID=EXP_PROCESS_100241_.tb11_0(3),
UNIT_ID=EXP_PROCESS_100241_.tb11_1(3),
ATTRIBUTE_ID=EXP_PROCESS_100241_.tb11_2(3),
STATEMENT_ID=null,
VALUE=null,
IS_DUPLICABLE='N'
,
IN_OUT=2,
MANDATORY='N'

 WHERE UNIT_ATTRIBUTE_ID = EXP_PROCESS_100241_.tb11_0(3);
if not (sql%found) then
INSERT INTO WF_UNIT_ATTRIBUTE(UNIT_ATTRIBUTE_ID,UNIT_ID,ATTRIBUTE_ID,STATEMENT_ID,VALUE,IS_DUPLICABLE,IN_OUT,MANDATORY) 
VALUES (EXP_PROCESS_100241_.tb11_0(3),
EXP_PROCESS_100241_.tb11_1(3),
EXP_PROCESS_100241_.tb11_2(3),
null,
null,
'N'
,
2,
'N'
);
end if;

exception when others then
EXP_PROCESS_100241_.blProcessStatus := false;
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
sa_bocreatePackages.CreatePackage('EXP_UNITTYPE_100242_',
'CREATE OR REPLACE PACKAGE EXP_UNITTYPE_100242_ IS ' || chr(10) ||
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
'END EXP_UNITTYPE_100242_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:EXP_UNITTYPE_100242_******************************'); END;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_UNITTYPE_100242',1);
EXP_UNITTYPE_100242_.blProcessStatus := EXP_PROCESS_100241_.blProcessStatus ; 
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
AND     A.TASK_CODE = 100242
 
;
BEGIN

if (not EXP_UNITTYPE_100242_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  EXP_UNITTYPE_100242_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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
FROM WF_UNIT_TYPE_ATTRIB WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100242);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100242_.blProcessStatus) then
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
EXP_UNITTYPE_100242_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_CAUSAL_UNIT_TYPE WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100242);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100242_.blProcessStatus) then
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
EXP_UNITTYPE_100242_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM MO_TIME_UNI_TYP_PRIO WHERE (UNIT_TYPE_ID) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100242);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100242_.blProcessStatus) then
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
EXP_UNITTYPE_100242_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM OR_ACT_BY_TASK_MOD WHERE (TASK_CODE) in (SELECT UNIT_TYPE_ID FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100242);
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100242_.blProcessStatus) then
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
EXP_UNITTYPE_100242_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM WF_UNIT_TYPE WHERE UNIT_TYPE_ID=100242;
nuIndex binary_integer;
BEGIN

if (not EXP_UNITTYPE_100242_.blProcessStatus) then
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
EXP_UNITTYPE_100242_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not EXP_UNITTYPE_100242_.blProcessStatus) then
 return;
end if;

EXP_UNITTYPE_100242_.tb0_0(0):=100242;
ut_trace.trace('insertando tabla sin fallo: WF_UNIT_TYPE fila (0)',1);
INSERT INTO WF_UNIT_TYPE(UNIT_TYPE_ID,CATEGORY_ID,MODULE_ID,ACTION_ID,PARENT_ID,INIT_AREA_EXPRESSION_ID,ASSIGN_COMMENT_CLASS,ATTEND_COMMENT_CLASS,UNASSIGN_COMMENT_CLASS,TAG_NAME,DESCRIPTION,DISPLAY,ICON,IS_STAGE_PROCESS,USABLE_IN_FLOW_STAGE,ENTITY_ID,MULTI_INSTANCE,IS_COUNTABLE,NOTIFICATION_ID,VIEWABLE,DEFAULT_PRIORITY_ID,INITIAL_NOTIFY_TIME,IS_ADMIN_PROCESS,ASSIGN_NOTIFICATION_ID,ASSIGNED_USER_ONLY) 
VALUES (EXP_UNITTYPE_100242_.tb0_0(0),
2,
5,
null,
100213,
null,
null,
null,
null,
'UNIT_TYPE_100242'
,
'Atender Anulaci¿n'
,
'Atender Anulaci¿n'
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
EXP_UNITTYPE_100242_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100241',1);
EXP_PROCESS_100241_.blProcessStatus := EXP_UNITTYPE_100242_.blProcessStatus ; 
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
 nuIndex := EXP_UNITTYPE_100242_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_UNITTYPE_100242_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_UNITTYPE_100242_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_UNITTYPE_100242_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_UNITTYPE_100242_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_UNITTYPE_100242_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_UNITTYPE_100242_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_UNITTYPE_100242_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_UNITTYPE_100242_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_UNITTYPE_100242_******************************'); end;
/

BEGIN
ut_trace.trace('Actualizar Variable de Proceso: EXP_PROCESS_100248',1);
EXP_PROCESS_100248_.blProcessStatus := EXP_PROCESS_100241_.blProcessStatus ; 
exception when others then
rollback;
ut_trace.trace('**ERROR:'||sqlerrm,1);
raise;
END;
/
DECLARE 
    nuBinaryIndex Binary_Integer;
BEGIN 
    nuBinaryIndex := EXP_PROCESS_100241_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = EXP_PROCESS_100241_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||EXP_PROCESS_100241_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||EXP_PROCESS_100241_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := EXP_PROCESS_100241_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       EXP_PROCESS_100241_.blProcessStatus := FALSE;
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

if (not EXP_PROCESS_100241_.blProcessStatus) then
 return;
end if;
nuRowProcess:=EXP_PROCESS_100241_.tb6_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| EXP_PROCESS_100241_.tb6_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(EXP_PROCESS_100241_.tb6_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| EXP_PROCESS_100241_.tb6_0(nuRowProcess),1);
end;
nuRowProcess := EXP_PROCESS_100241_.tb6_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
EXP_PROCESS_100241_.blProcessStatus := false;
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
 nuIndex := EXP_PROCESS_100241_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_PROCESS_100241_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_PROCESS_100241_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_PROCESS_100241_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_PROCESS_100241_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_PROCESS_100241_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_PROCESS_100241_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_PROCESS_100241_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_PROCESS_100241_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_PROCESS_100241_******************************'); end;
/

BEGIN
ut_trace.trace('Realizar Commit del Flujo',1);
if ( not EXP_PROCESS_100248_.blProcessStatus) then
 return;
 end if;
ut_trace.trace('Realizar Commit de EXP_PROCESS_100248 ',1);
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
    nuBinaryIndex := EXP_PROCESS_100248_.tbGR_CONFIG_EXPRESSIONId.first;
    while (nuBinaryIndex IS not null) loop 
       BEGIN
           delete from GR_CONFIG_EXPRESSION where config_expression_id = EXP_PROCESS_100248_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex);
           ut_trace.trace('Delete config_expression_id = : '||EXP_PROCESS_100248_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex) || ' OK', 1);
       EXCEPTION
           when ex.RECORD_HAVE_CHILDREN then
               ut_trace.trace('No se pudo borrar la regla config_expression_id '||EXP_PROCESS_100248_.tbGR_CONFIG_EXPRESSIONId(nuBinaryIndex),1);
       END;
       nuBinaryIndex := EXP_PROCESS_100248_.tbGR_CONFIG_EXPRESSIONId.next(nuBinaryIndex);
    END loop;

EXCEPTION 
   when others then
       EXP_PROCESS_100248_.blProcessStatus := FALSE;
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

if (not EXP_PROCESS_100248_.blProcessStatus) then
 return;
end if;
nuRowProcess:=EXP_PROCESS_100248_.tb8_0.first;
while (nuRowProcess is not null) loop 
ut_trace.trace('Genera expresión regla:'|| EXP_PROCESS_100248_.tb8_0(nuRowProcess),1); 
begin
GR_BOINTERFACE_BODY.MakeExpression(EXP_PROCESS_100248_.tb8_0(nuRowProcess)); 
exception when others then
ut_trace.trace('Fallo la generacion de la regla:'|| EXP_PROCESS_100248_.tb8_0(nuRowProcess),1);
end;
nuRowProcess := EXP_PROCESS_100248_.tb8_0.next(nuRowProcess);
END loop;
COMMIT;

exception when others then
EXP_PROCESS_100248_.blProcessStatus := false;
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
 nuIndex := EXP_PROCESS_100248_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || EXP_PROCESS_100248_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(EXP_PROCESS_100248_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(EXP_PROCESS_100248_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(EXP_PROCESS_100248_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || EXP_PROCESS_100248_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || EXP_PROCESS_100248_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := EXP_PROCESS_100248_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('EXP_PROCESS_100248_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:EXP_PROCESS_100248_******************************'); end;
/



