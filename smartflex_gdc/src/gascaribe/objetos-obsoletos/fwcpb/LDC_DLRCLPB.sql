BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('LDC_DLRCLPB_',
'CREATE OR REPLACE PACKAGE LDC_DLRCLPB_ IS ' || chr(10) ||
'blProcessStatus boolean := true; ' || chr(10) ||
'type tySA_EXECUTABLERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbSA_EXECUTABLERowId tySA_EXECUTABLERowId;type tySA_ROLE_EXECUTABLESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbSA_ROLE_EXECUTABLESRowId tySA_ROLE_EXECUTABLESRowId;type tySA_EXECUTABLE_SYNONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbSA_EXECUTABLE_SYNONRowId tySA_EXECUTABLE_SYNONRowId;type tySA_USER_EXCEPTIONSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbSA_USER_EXCEPTIONSRowId tySA_USER_EXCEPTIONSRowId;type tySA_EXEC_ENTITIESRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbSA_EXEC_ENTITIESRowId tySA_EXEC_ENTITIESRowId;type tySA_MENU_OPTIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbSA_MENU_OPTIONRowId tySA_MENU_OPTIONRowId;type tyGI_CONFIGRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_CONFIGRowId tyGI_CONFIGRowId;type tyGI_CONFIG_COMPRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_CONFIG_COMPRowId tyGI_CONFIG_COMPRowId;type tyGI_COMPOSITIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_COMPOSITIONRowId tyGI_COMPOSITIONRowId;type tyGI_FRAMERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_FRAMERowId tyGI_FRAMERowId;type tyGI_COMP_ATTRIBSRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_COMP_ATTRIBSRowId tyGI_COMP_ATTRIBSRowId;type tyGI_COMP_FRAME_ATTRIBRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGI_COMP_FRAME_ATTRIBRowId tyGI_COMP_FRAME_ATTRIBRowId;type tyGE_STATEMENTRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_STATEMENTRowId tyGE_STATEMENTRowId;type tyGR_CONFIG_EXPRESSIONRowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIG_EXPRESSIONRowId tyGR_CONFIG_EXPRESSIONRowId;type tyGE_MODULERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_MODULERowId tyGE_MODULERowId;type tyGR_CONFIGURA_TYPERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGR_CONFIGURA_TYPERowId tyGR_CONFIGURA_TYPERowId;type tyGE_DISTRIBUTION_FILERowId is table of rowid index by varchar2(100); ' || chr(10) ||
'tbGE_DISTRIBUTION_FILERowId tyGE_DISTRIBUTION_FILERowId;type ty0_0 is table of SA_EXECUTABLE.NAME%type index by binary_integer; ' || chr(10) ||
'old_tb0_0 ty0_0; ' || chr(10) ||
'tb0_0 ty0_0;type ty0_1 is table of SA_EXECUTABLE.EXECUTABLE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb0_1 ty0_1; ' || chr(10) ||
'tb0_1 ty0_1;type ty1_0 is table of SA_ROLE_EXECUTABLES.ROLE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_0 ty1_0; ' || chr(10) ||
'tb1_0 ty1_0;type ty1_1 is table of SA_ROLE_EXECUTABLES.EXECUTABLE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb1_1 ty1_1; ' || chr(10) ||
'tb1_1 ty1_1;type ty2_0 is table of SA_MENU_OPTION.MENU_OPTION_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;type ty2_1 is table of SA_MENU_OPTION.EXECUTABLE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_1 ty2_1; ' || chr(10) ||
'tb2_1 ty2_1;type ty3_0 is table of GE_DISTRIBUTION_FILE.DISTRIBUTION_FILE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb3_0 ty3_0; ' || chr(10) ||
'tb3_0 ty3_0;  executableName ge_catalog.tag_name%type := ''LDC_DLRCLPB''; ' || chr(10) ||
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
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDC_DLRCLPB'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuUserExceptions  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.user_id,a.status,a.usr_exc_type_id,a.comment_ ' || chr(10) ||
'FROM sa_user_exceptions a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDC_DLRCLPB'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuExecEntities  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.entity_id ' || chr(10) ||
'FROM sa_exec_entities a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDC_DLRCLPB'' ' || chr(10) ||
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
'TYPE tyObjectToDelete IS TABLE OF GR_CONFIG_EXPRESSION.OBJECT_NAME%TYPE INDEX BY binary_integer; ' || chr(10) ||
'tbObjectToDelete tyObjectToDelete; ' || chr(10) ||
'clColumn_0 clob; ' || chr(10) ||
' ' || chr(10) ||
'END LDC_DLRCLPB_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:LDC_DLRCLPB_******************************'); END;
/

declare 
nuIndex binary_integer:=0;
BEGIN

if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;
Open LDC_DLRCLPB_.cuRoleExecutables;
loop
 fetch LDC_DLRCLPB_.cuRoleExecutables INTO LDC_DLRCLPB_.rcRoleExecutables;
 exit when  LDC_DLRCLPB_.cuRoleExecutables%notfound;
 LDC_DLRCLPB_.tbRoleExecutables(nuIndex) := LDC_DLRCLPB_.rcRoleExecutables;
 nuIndex := nuIndex + 1;
END loop;
close LDC_DLRCLPB_.cuRoleExecutables;
nuIndex := 0;
Open LDC_DLRCLPB_.cuUserExceptions ;
loop
 fetch LDC_DLRCLPB_.cuUserExceptions INTO  LDC_DLRCLPB_.rcUserExceptions;
 exit when LDC_DLRCLPB_.cuUserExceptions%notfound;
 LDC_DLRCLPB_.tbUserException(nuIndex):=LDC_DLRCLPB_.rcUserExceptions;
 nuIndex := nuIndex + 1;
END loop;
close LDC_DLRCLPB_.cuUserExceptions;
nuIndex := 0;
Open LDC_DLRCLPB_.cuExecEntities ;
loop
 fetch LDC_DLRCLPB_.cuExecEntities INTO  LDC_DLRCLPB_.rcExecEntities;
 exit when LDC_DLRCLPB_.cuExecEntities%notfound;
 LDC_DLRCLPB_.tbExecEntities(nuIndex):=LDC_DLRCLPB_.rcExecEntities;
 nuIndex := nuIndex + 1;
END loop;
close LDC_DLRCLPB_.cuExecEntities;

exception when others then
LDC_DLRCLPB_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN

if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;
DELETE FROM sa_role_executables
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDC_DLRCLPB'
);
DELETE FROM sa_user_exceptions
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDC_DLRCLPB'
);
DELETE FROM sa_exec_entities
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDC_DLRCLPB'
);

exception when others then
LDC_DLRCLPB_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

DECLARE
    nuNumRecords  number;
    sbNumExpression varchar2(32);
    sbNumStatement  varchar2(32);
    xlApplication      xmltype;
    xlComposition  xmltype;
    xlAttributes   xmlType;
    xlAttribute   xmlType;
    nuIndexAttribute   number(2) := 1;
    Procedure DeleteObjectRule
    (
      inuNumExpression   IN gr_config_expression.config_expression_id%type
    )
    IS
      nuNumExpression GR_CONFIG_EXPRESSION.CONFIG_EXPRESSION_ID%type;
      sbObjectName GR_CONFIG_EXPRESSION.OBJECT_NAME%type;
      nuNumObjects number;
    BEGIN
      ut_trace.trace('Obteniendo regla '||inuNumExpression,1);
      SELECT count(1)
      INTO  nuNumRecords
      FROM  GR_CONFIG_EXPRESSION
      WHERE GR_CONFIG_EXPRESSION.CONFIG_EXPRESSION_ID = inuNumExpression;
      IF (nuNumRecords > 0) THEN
        SELECT OBJECT_NAME
        INTO   sbObjectName
        FROM   GR_CONFIG_EXPRESSION
        WHERE  GR_CONFIG_EXPRESSION.CONFIG_EXPRESSION_ID = to_number(inuNumExpression);
        IF ( sbObjectName IS NOT null ) THEN
          ut_trace.trace('Se adiciona al listado de objetos posibles a borrar: '||sbObjectName,1);
          if ( LDC_DLRCLPB_.tbObjectToDelete.last IS null ) then
            nuNumObjects := 1;
          else
            nuNumObjects := LDC_DLRCLPB_.tbObjectToDelete.last + 1;
          end if;
          LDC_DLRCLPB_.tbObjectToDelete(nuNumObjects) := sbObjectName;
        END IF;
        ut_trace.trace('Borrando registro en gr_config_expression: '||inuNumExpression,1);
        DELETE
        FROM GR_CONFIG_EXPRESSION
        WHERE GR_CONFIG_EXPRESSION.CONFIG_EXPRESSION_ID = to_number(sbNumExpression);
      END IF;
 END;
 
BEGIN 
 
if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;
 
  ut_trace.trace('Validando existencia del registro en GE_DISTRIBUTION_FILE',1);
  SELECT count(1)
  INTO  nuNumRecords
  FROM GE_DISTRIBUTION_FILE
  WHERE GE_DISTRIBUTION_FILE.DISTRIBUTION_FILE_ID = 'LDC_DLRCLPB';
  IF (nuNumRecords > 0) THEN
    ut_trace.trace('Obteniendo composicion general',1);
    SELECT extract(GE_DISTRIBUTION_FILE.APP_XML,'/')
    INTO   xlApplication
    FROM   GE_DISTRIBUTION_FILE
    WHERE  GE_DISTRIBUTION_FILE.DISTRIBUTION_FILE_ID = 'LDC_DLRCLPB';
    IF(xlApplication.existsnode('//COMPOSITION') = 0)then
       return;
    END IF;
    xlComposition := xlApplication.extract('//COMPOSITION');
    IF ( ( xlComposition.existsnode('/COMPOSITION/BEFORE_EXPRESSION_ID') = 1 )
      AND (xlComposition.extract('/COMPOSITION/BEFORE_EXPRESSION_ID/text()') IS not null) )
    THEN
      ut_trace.trace('Adicionando regla PRE al borrado: '||sbNumExpression,1);
      sbNumExpression := xlComposition.extract('/COMPOSITION/BEFORE_EXPRESSION_ID/text()').getstringval();
      DeleteObjectRule(to_number(sbNumExpression));
    END IF;
    IF ( ( xlComposition.existsnode('/COMPOSITION/AFTER_EXPRESSION_ID') = 1 )
      AND (xlComposition.extract('/COMPOSITION/AFTER_EXPRESSION_ID/text()') IS not null) )
    THEN
      ut_trace.trace('Adicionando regla POST al borrado: '||sbNumExpression,1);
      sbNumExpression := xlComposition.extract('/COMPOSITION/AFTER_EXPRESSION_ID/text()').getstringval();
      DeleteObjectRule(to_number(sbNumExpression));
    END IF;
    IF(xlApplication.existsnode('//ATTRIBUTE') = 0)then
       return;
    END IF;
    xlAttributes := xlApplication.extract('//ATTRIBUTE');
    IF (xlAttributes is not null AND xlAttributes.existsnode('//ATTRIBUTE') > 0) then
      ut_trace.trace('Recorriendo atributos',1);
      WHILE xlAttributes.Existsnode('//ATTRIBUTE[' || To_Char(nuIndexAttribute) || ']') > 0
      LOOP
        ut_trace.trace ('Atributo en la Posicion:[' || To_Char(nuIndexAttribute) ||']', 1);
        xlAttribute := xlAttributes.Extract('//ATTRIBUTE[' || To_Char(nuIndexAttribute) || ']');
        IF ( ( xlAttribute.existsnode('//INIT_EXPRESSION_ID') = 1 )
           AND (xlAttribute.extract('//INIT_EXPRESSION_ID/text()') IS not null) )
        THEN
          sbNumExpression := xlAttribute.extract('//INIT_EXPRESSION_ID/text()').getstringval();
          DeleteObjectRule(to_number(sbNumExpression));
        END if;
        IF ( ( xlAttribute.existsnode('//VALID_EXPRESSION_ID') = 1 )
           AND (xlAttribute.extract('//VALID_EXPRESSION_ID/text()') IS not null) )
        THEN
          sbNumExpression := xlAttribute.extract('//VALID_EXPRESSION_ID/text()').getstringval();
          DeleteObjectRule(to_number(sbNumExpression));
        END if;
        IF ( ( xlAttribute.existsnode('//SELECT_STATEMENT_ID') = 1 )
           AND (xlAttribute.extract('//SELECT_STATEMENT_ID/text()') IS not null) )
        THEN
          sbNumStatement := xlAttribute.extract('//SELECT_STATEMENT_ID/text()').getstringval();
          ut_trace.trace ('Boorado de sentencia:[' || To_Char(sbNumStatement) ||']', 1);
          DELETE
          FROM ge_statement_columns
          WHERE statement_id = (to_number(sbNumStatement))
          AND not exists ( SELECT 1 FROM ge_report_statement WHERE statement_id = (to_number(sbNumStatement)));
          DELETE
          FROM ge_statement
          WHERE statement_id = (to_number(sbNumStatement))
          AND not exists ( SELECT 1 FROM ge_report_statement WHERE statement_id = (to_number(sbNumStatement)));
        END if;
        nuIndexAttribute := nuIndexAttribute + 1;
      END LOOP;
    END if;
  END IF;
 
 
exception when others then
LDC_DLRCLPB_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
 
END; 
/

DECLARE
 nuIndex binary_integer;
 CURSOR cuObjectsName IS
  SELECT  gr_config_expression.object_name
FROM    sa_executable, gi_config, gi_composition, gi_comp_attribs, gr_config_expression
WHERE   sa_executable.name = 'LDC_DLRCLPB'
AND     gi_config.external_root_id = sa_executable.executable_id
AND     gi_config.config_type_id = 4
AND     gi_config.entity_root_id = 3339
AND     gi_composition.config_id = gi_config.config_id
AND     gi_comp_attribs.composition_id = gi_composition.composition_id
AND     (gi_comp_attribs.init_expression_id = gr_config_expression.config_expression_id
OR      gi_comp_attribs.valid_expression_id = gr_config_expression.config_expression_id)
union all
SELECT  gr_config_expression.object_name
FROM    sa_executable, gi_config, gi_composition, gi_frame, gr_config_expression
WHERE   sa_executable.name = 'LDC_DLRCLPB'
AND     gi_config.external_root_id = sa_executable.executable_id
AND     gi_config.config_type_id = 4
AND     gi_config.entity_root_id = 3339
AND     gi_composition.config_id = gi_config.config_id
AND     gi_frame.composition_id = gi_composition.composition_id
AND     (gi_frame.after_expression_id = gr_config_expression.config_expression_id
OR      gi_frame.before_expression_id = gr_config_expression.config_expression_id);
BEGIN

if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  LDC_DLRCLPB_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
  nuIndex := nuIndex + 1;
 END LOOP;
EXCEPTION 
 when ex.controlled_error then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
 when others then
  ut_trace.trace('No se realiza cache de objetos a borrar: ' || sqlerrm);
END;
/

BEGIN

if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ROLE_EXECUTABLES',1);
  DELETE FROM SA_ROLE_EXECUTABLES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDC_DLRCLPB') AND ROLE_ID=1;

exception when others then
LDC_DLRCLPB_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_USER_EXCEPTIONS',1);
  DELETE FROM SA_USER_EXCEPTIONS WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDC_DLRCLPB') AND 1=2;

exception when others then
LDC_DLRCLPB_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM SA_EXECUTABLE_SYNON WHERE (SYNONYMOUS_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDC_DLRCLPB');
nuIndex binary_integer;
BEGIN

if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXECUTABLE_SYNON',1);
  open  cuRowIdToDelete;
  fetch  cuRowIdToDelete bulk collect INTO tbrowidvalue;
  close  cuRowIdToDelete;
  nuIndex :=tbrowidvalue.first;
  while nuindex IS not null loop
      BEGIN
      DELETE FROM SA_EXECUTABLE_SYNON WHERE rowid = tbrowidvalue(nuIndex);
      EXCEPTION
        when ex.RECORD_HAVE_CHILDREN then
          ut_trace.trace('No se pudo borrar el registro '||tbrowidvalue(nuIndex));
          null;
      END;
      nuindex :=  tbrowidvalue.next(nuindex);
  END loop;

exception when others then
LDC_DLRCLPB_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXEC_ENTITIES',1);
  DELETE FROM SA_EXEC_ENTITIES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDC_DLRCLPB');

exception when others then
LDC_DLRCLPB_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_MENU_OPTION',1);
  DELETE FROM SA_MENU_OPTION WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDC_DLRCLPB');

exception when others then
LDC_DLRCLPB_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_CONFIG_COMP',1);
  DELETE FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDC_DLRCLPB') AND CONFIG_TYPE_ID=4 AND ENTITY_ROOT_ID=3339);

exception when others then
LDC_DLRCLPB_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_CONFIG_COMP',1);
  DELETE FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDC_DLRCLPB') AND CONFIG_TYPE_ID=4 AND ENTITY_ROOT_ID=3339));

exception when others then
LDC_DLRCLPB_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT SELECT_STATEMENT_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDC_DLRCLPB') AND CONFIG_TYPE_ID=4 AND ENTITY_ROOT_ID=3339)));
BEGIN 

if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
LDC_DLRCLPB_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
LDC_DLRCLPB_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT INIT_EXPRESSION_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDC_DLRCLPB') AND CONFIG_TYPE_ID=4 AND ENTITY_ROOT_ID=3339)));
BEGIN 

if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
LDC_DLRCLPB_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
LDC_DLRCLPB_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT VALID_EXPRESSION_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDC_DLRCLPB') AND CONFIG_TYPE_ID=4 AND ENTITY_ROOT_ID=3339)));
BEGIN 

if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
LDC_DLRCLPB_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
LDC_DLRCLPB_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (COMP_ATTRIBS_ID) in (SELECT COMP_ATTRIBS_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDC_DLRCLPB') AND CONFIG_TYPE_ID=4 AND ENTITY_ROOT_ID=3339)));

exception when others then
LDC_DLRCLPB_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_ATTRIBS',1);
  DELETE FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDC_DLRCLPB') AND CONFIG_TYPE_ID=4 AND ENTITY_ROOT_ID=3339));

exception when others then
LDC_DLRCLPB_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=LDC_DLRCLPB_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = LDC_DLRCLPB_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
LDC_DLRCLPB_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := LDC_DLRCLPB_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
LDC_DLRCLPB_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=LDC_DLRCLPB_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = LDC_DLRCLPB_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
nuVarcharIndex := LDC_DLRCLPB_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
LDC_DLRCLPB_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex); 
END loop; 

exception when others then
LDC_DLRCLPB_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=LDC_DLRCLPB_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = LDC_DLRCLPB_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
nuVarcharIndex := LDC_DLRCLPB_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
LDC_DLRCLPB_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex); 
END loop; 

exception when others then
LDC_DLRCLPB_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GI_COMPOSITION WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDC_DLRCLPB') AND CONFIG_TYPE_ID=4 AND ENTITY_ROOT_ID=3339)));
BEGIN 

if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GI_COMPOSITION',1);
for rcData in cuLoadTemporaryTable loop
LDC_DLRCLPB_.tbGI_COMPOSITIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
LDC_DLRCLPB_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT AFTER_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDC_DLRCLPB') AND CONFIG_TYPE_ID=4 AND ENTITY_ROOT_ID=3339)));
BEGIN 

if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
LDC_DLRCLPB_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
LDC_DLRCLPB_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT BEFORE_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDC_DLRCLPB') AND CONFIG_TYPE_ID=4 AND ENTITY_ROOT_ID=3339)));
BEGIN 

if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
LDC_DLRCLPB_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
LDC_DLRCLPB_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (FRAME_ID) in (SELECT FRAME_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDC_DLRCLPB') AND CONFIG_TYPE_ID=4 AND ENTITY_ROOT_ID=3339)));

exception when others then
LDC_DLRCLPB_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_FRAME',1);
  DELETE FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDC_DLRCLPB') AND CONFIG_TYPE_ID=4 AND ENTITY_ROOT_ID=3339));

exception when others then
LDC_DLRCLPB_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GI_COMPOSITION',1);
nuVarcharIndex:=LDC_DLRCLPB_.tbGI_COMPOSITIONRowId.first;  
while (nuVarcharIndex is not null) loop 
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GI_COMPOSITION where rowid = LDC_DLRCLPB_.tbGI_COMPOSITIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
nuVarcharIndex := LDC_DLRCLPB_.tbGI_COMPOSITIONRowId.next(nuVarcharIndex); 
LDC_DLRCLPB_.tbGI_COMPOSITIONRowId.delete(nuOldVarcharIndex); 
END loop; 

exception when others then
LDC_DLRCLPB_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=LDC_DLRCLPB_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = LDC_DLRCLPB_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
nuVarcharIndex := LDC_DLRCLPB_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
LDC_DLRCLPB_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex); 
END loop; 

exception when others then
LDC_DLRCLPB_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=LDC_DLRCLPB_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = LDC_DLRCLPB_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
nuVarcharIndex := LDC_DLRCLPB_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
LDC_DLRCLPB_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex); 
END loop; 

exception when others then
LDC_DLRCLPB_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMPOSITION',1);
  DELETE FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDC_DLRCLPB') AND CONFIG_TYPE_ID=4 AND ENTITY_ROOT_ID=3339);

exception when others then
LDC_DLRCLPB_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_CONFIG',1);
  DELETE FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDC_DLRCLPB') AND CONFIG_TYPE_ID=4 AND ENTITY_ROOT_ID=3339;

exception when others then
LDC_DLRCLPB_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_DISTRIBUTION_FILE',1);
  DELETE FROM GE_DISTRIBUTION_FILE WHERE (DISTRIBUTION_FILE_ID) in (SELECT NAME FROM SA_EXECUTABLE WHERE NAME='LDC_DLRCLPB');

exception when others then
LDC_DLRCLPB_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXECUTABLE',1);
  DELETE FROM SA_EXECUTABLE WHERE NAME='LDC_DLRCLPB';

exception when others then
LDC_DLRCLPB_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;

LDC_DLRCLPB_.old_tb0_0(0):='LDC_DLRCLPB'
;
LDC_DLRCLPB_.tb0_0(0):=UPPER(LDC_DLRCLPB_.old_tb0_0(0));
LDC_DLRCLPB_.tb0_0(0):=LDC_DLRCLPB_.tb0_0(0);
LDC_DLRCLPB_.old_tb0_1(0):=500000000009056;
LDC_DLRCLPB_.tb0_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDC_DLRCLPB_.tb0_0(0), 'EXECUTABLE', 'SA_BOEXECUTABLE.GETNEXTID');
LDC_DLRCLPB_.tb0_1(0):=LDC_DLRCLPB_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_EXECUTABLE fila (0)',1);
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED,CLASS_ID) 
VALUES (LDC_DLRCLPB_.tb0_0(0),
LDC_DLRCLPB_.tb0_1(0),
'Clientes Potenciales Detallado Brilla'
,
null,
'29'
,
8,
2,
61,
1,
6991,
'N'
,
null,
'N'
,
'Y'
,
10,
null,
to_date('06-09-2016 16:13:05','DD-MM-YYYY HH24:MI:SS'),
null);

exception when others then
LDC_DLRCLPB_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;

LDC_DLRCLPB_.tb1_0(0):=1;
LDC_DLRCLPB_.tb1_1(0):=LDC_DLRCLPB_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (LDC_DLRCLPB_.tb1_0(0),
LDC_DLRCLPB_.tb1_1(0));

exception when others then
LDC_DLRCLPB_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;

LDC_DLRCLPB_.old_tb2_0(0):=40011484;
LDC_DLRCLPB_.tb2_0(0):=SA_BOSEQUENCES.FNUNEXTSA_MENU_OPTION;
LDC_DLRCLPB_.tb2_0(0):=LDC_DLRCLPB_.tb2_0(0);
LDC_DLRCLPB_.tb2_1(0):=LDC_DLRCLPB_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_MENU_OPTION fila (0)',1);
INSERT INTO SA_MENU_OPTION(MENU_OPTION_ID,EXECUTABLE_ID,NAME,DESCRIPTION,MENU_ID,MENU_OPTION_TYPE_ID,SEQUENCE_NUMBER,PARENT_MENU_ID,ICON_NAME,PARAMETERS) 
VALUES (LDC_DLRCLPB_.tb2_0(0),
LDC_DLRCLPB_.tb2_1(0),
'LDC_DLRCLPB'
,
'Clientes Potenciales Detallado Brilla'
,
1,
1,
86,
-7,
'FormExecutable'
,
null);

exception when others then
LDC_DLRCLPB_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;

LDC_DLRCLPB_.tb3_0(0):=LDC_DLRCLPB_.tb0_0(0);
LDC_DLRCLPB_.clColumn_0 := '<?xml version="1.0" encoding="UTF-8"?>
<PB xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <APPLICATION>
    <EXECUTABLE_ID>500000000009056</EXECUTABLE_ID>
    <NAME>LDC_DLRCLPB</NAME>
    <DESCRIPTION>Clientes Potenciales Detallado Brilla</DESCRIPTION>
    <VERSION>29</VERSION>
    <MODULE>61</MODULE>
    <DIRECT_EXECUTION>Y</DIRECT_EXECUTION>
    <PATH_FILE_HELP/>
    <OBJECT_NAME>LDC_PKDLRCLPB.DLRCLPB</OBJECT_NAME>
    <QUERY_NAME/>
    <ALLOW_SCHEDULE>N</ALLOW_SCHEDULE>
    <ALLOW_FREQUENCY>N</ALLOW_FREQUENCY>
  </APPLICATION>
  <COMPOSITION>
    <CONFIGURATION_ID>-999999998</CONFIGURATION_ID>
    <ATTRIBUTE_NAME>DUMMY</ATTRIBUTE_NAME>
    <ENTITY_NAME>GI_PROCESS</ENTITY_NAME>
    <TYPE_ATTRIB_ID>1</TYPE_ATTRIB_ID>
    <ENTITY_TYPE_ID>3339</ENTITY_TYPE_ID>
    <EXTERNAL_TYPE_ID>500000000009056</EXTERNAL_TYPE_ID>
    <ENTITY_ID>9623</ENTITY_ID>
    <EXTERNAL_ID>500000000009056</EXTERNAL_ID>
    <FRAME_ID>-7235</FRAME_ID>
    <IS_' ||
'UPDATABLE>N</IS_UPDATABLE>
    <IS_VISIBLE>N</IS_VISIBLE>
    <REQUIRED>N</REQUIRED>
    <DISPLAY_NAME/>
    <MIN_INSTANCE>1</MIN_INSTANCE>
    <MAX_INSTANCE>1</MAX_INSTANCE>
    <TAG_NAME/>
    <AFTER_EXPRESSION_ID/>
    <BEFORE_EXPRESSION_ID/>
    <STATEMENT_CACHE>N</STATEMENT_CACHE>
    <USER_DEFAULT_ALLOWED>N</USER_DEFAULT_ALLOWED>
    <STYLE_CASE>U</STYLE_CASE>
    <SEQUENCE_ID>1</SEQUENCE_ID>
    <EXTERNAL_ROOT_ID>6121</EXTERNAL_ROOT_ID>
    <ATTRIBUTE>
      <ENTITY_ATTRIBUTE_ID>-1</ENTITY_ATTRIBUTE_ID>
      <CONFIGURATION_ID>-999999997</CONFIGURATION_ID>
      <ATTRIBUTE_NAME>NULL</ATTRIBUTE_NAME>
      <ENTITY_ID>-1</ENTITY_ID>
      <ENTITY_NAME>DUAL</ENTITY_NAME>
      <PARENT_CONF_ID>-999999998</PARENT_CONF_ID>
      <TYPE_ATTRIB_ID>2</TYPE_ATTRIB_ID>
      <ENTITY_TYPE_ID>3339</ENTITY_TYPE_ID>
      <EXTERNAL_TYPE_ID>500000000009056</EXTERNAL_TYPE_ID>
      <FRAME_ID>-7235</FRAME_ID>
      <DATA_LENGTH/>
      <DATA_PRECISION/>
      <DATA_SCALE/>
      <DATA_TYPE>NUMBER<' ||
'/DATA_TYPE>
      <DISPLAY_VIEW>10</DISPLAY_VIEW>
      <IS_UPDATABLE>Y</IS_UPDATABLE>
      <IS_VISIBLE>Y</IS_VISIBLE>
      <REQUIRED>N</REQUIRED>
      <DISPLAY_ORDER>0</DISPLAY_ORDER>
      <DISPLAY_NAME>Datos de Entrada</DISPLAY_NAME>
      <INIT_BASIC_EXP_ID/>
      <VALID_BASIC_EXP_ID/>
      <INIT_EXPRESSION_ID/>
      <VALID_EXPRESSION_ID/>
      <DEFAULT_VALUE/>
      <SELECT_STATEMENT/>
      <SELECT_STATEMENT_ID/>
      <TAG_NAME/>
      <PROCESS_SEQUENCE/>
      <STATEMENT_CACHE>N</STATEMENT_CACHE>
      <USER_DEFAULT_ALLOWED>N</USER_DEFAULT_ALLOWED>
      <STYLE_CASE>U</STYLE_CASE>
      <SEQUENCE_ID>2</SEQUENCE_ID>
      <EXTERNAL_ROOT_ID>6121</EXTERNAL_ROOT_ID>
      <PARENT_ATTRIBUTE_NAME/>
      <PARENT_ENTITY_NAME/>
    </ATTRIBUTE>
    <ATTRIBUTE>
      <ENTITY_ATTRIBUTE_ID>3340</ENTITY_ATTRIBUTE_ID>
      <CONFIGURATION_ID>-999999996</CONFIGURATION_ID>
      <ATTRIBUTE_NAME>GEO_AREA_FATHER_ID</ATTRIBUTE_NAME>
      <ENTITY_ID>3065</ENTITY_ID>
      <ENTITY_NAME>GE_' ||
'ORGANIZAT_AREA</ENTITY_NAME>
      <PARENT_CONF_ID>-999999998</PARENT_CONF_ID>
      <TYPE_ATTRIB_ID>2</TYPE_ATTRIB_ID>
      <ENTITY_TYPE_ID>3339</ENTITY_TYPE_ID>
      <EXTERNAL_TYPE_ID>500000000009056</EXTERNAL_TYPE_ID>
      <FRAME_ID>-7235</FRAME_ID>
      <DATA_LENGTH>0</DATA_LENGTH>
      <DATA_PRECISION>6</DATA_PRECISION>
      <DATA_SCALE>0</DATA_SCALE>
      <DATA_TYPE>NUMBER</DATA_TYPE>
      <DISPLAY_VIEW>4</DISPLAY_VIEW>
      <IS_UPDATABLE>Y</IS_UPDATABLE>
      <IS_VISIBLE>Y</IS_VISIBLE>
      <REQUIRED>Y</REQUIRED>
      <DISPLAY_ORDER>1</DISPLAY_ORDER>
      <DISPLAY_NAME>Departamento</DISPLAY_NAME>
      <INIT_BASIC_EXP_ID/>
      <VALID_BASIC_EXP_ID/>
      <INIT_EXPRESSION_ID/>
      <VALID_EXPRESSION_ID/>
      <DEFAULT_VALUE/>
      <SELECT_STATEMENT>SELECT -1 ID, '||chr(38)||'apos;TODOS'||chr(38)||'apos; DESCRIPTION
FROM dual
UNION ALL
SELECT geograp_location_id ID, Description DESCRIPTION
FROM Open.ge_geogra_location
WHERE geog_loca_area_type = 2
AND geograp_location_id '||chr(38)||'lt;'||chr(38)||'gt; -1</SE' ||
'LECT_STATEMENT>
      <SELECT_STATEMENT_ID>120112908</SELECT_STATEMENT_ID>
      <TAG_NAME/>
      <PROCESS_SEQUENCE/>
      <STATEMENT_CACHE>N</STATEMENT_CACHE>
      <USER_DEFAULT_ALLOWED>N</USER_DEFAULT_ALLOWED>
      <STYLE_CASE>U</STYLE_CASE>
      <SEQUENCE_ID>3</SEQUENCE_ID>
      <EXTERNAL_ROOT_ID>6121</EXTERNAL_ROOT_ID>
      <PARENT_ATTRIBUTE_NAME/>
      <PARENT_ENTITY_NAME/>
    </ATTRIBUTE>
    <ATTRIBUTE>
      <ENTITY_ATTRIBUTE_ID>3338</ENTITY_ATTRIBUTE_ID>
      <CONFIGURATION_ID>-999999995</CONFIGURATION_ID>
      <ATTRIBUTE_NAME>ORGANIZAT_AREA_ID</ATTRIBUTE_NAME>
      <ENTITY_ID>3065</ENTITY_ID>
      <ENTITY_NAME>GE_ORGANIZAT_AREA</ENTITY_NAME>
      <PARENT_CONF_ID>-999999998</PARENT_CONF_ID>
      <TYPE_ATTRIB_ID>2</TYPE_ATTRIB_ID>
      <ENTITY_TYPE_ID>3339</ENTITY_TYPE_ID>
      <EXTERNAL_TYPE_ID>500000000009056</EXTERNAL_TYPE_ID>
      <FRAME_ID>-7235</FRAME_ID>
      <DATA_LENGTH>0</DATA_LENGTH>
      <DATA_PRECISION>6</DATA_PRECISION>
      <DATA_SCALE>0</DAT' ||
'A_SCALE>
      <DATA_TYPE>NUMBER</DATA_TYPE>
      <DISPLAY_VIEW>4</DISPLAY_VIEW>
      <IS_UPDATABLE>Y</IS_UPDATABLE>
      <IS_VISIBLE>Y</IS_VISIBLE>
      <REQUIRED>Y</REQUIRED>
      <DISPLAY_ORDER>2</DISPLAY_ORDER>
      <DISPLAY_NAME>Localidad</DISPLAY_NAME>
      <INIT_BASIC_EXP_ID/>
      <VALID_BASIC_EXP_ID/>
      <INIT_EXPRESSION_ID/>
      <VALID_EXPRESSION_ID/>
      <DEFAULT_VALUE/>
      <SELECT_STATEMENT>SELECT -1 ID, '||chr(38)||'apos;TODOS'||chr(38)||'apos; DESCRIPTION
FROM dual
UNION ALL
SELECT geograp_location_id ID, Description DESCRIPTION
FROM Open.ge_geogra_location
WHERE geog_loca_area_type = 3
AND geograp_location_id '||chr(38)||'lt;'||chr(38)||'gt; -1</SELECT_STATEMENT>
      <SELECT_STATEMENT_ID>120112909</SELECT_STATEMENT_ID>
      <TAG_NAME/>
      <PROCESS_SEQUENCE/>
      <STATEMENT_CACHE>N</STATEMENT_CACHE>
      <USER_DEFAULT_ALLOWED>N</USER_DEFAULT_ALLOWED>
      <STYLE_CASE>U</STYLE_CASE>
      <SEQUENCE_ID>4</SEQUENCE_ID>
      <EXTERNAL_ROOT_ID>6121</EXTERNAL_ROOT_ID>
      <PARENT_ATTRIBUTE_NAME' ||
'/>
      <PARENT_ENTITY_NAME/>
    </ATTRIBUTE>
    <ATTRIBUTE>
      <ENTITY_ATTRIBUTE_ID>18237</ENTITY_ATTRIBUTE_ID>
      <CONFIGURATION_ID>-999999994</CONFIGURATION_ID>
      <ATTRIBUTE_NAME>PEFACODI</ATTRIBUTE_NAME>
      <ENTITY_ID>999</ENTITY_ID>
      <ENTITY_NAME>PERIFACT</ENTITY_NAME>
      <PARENT_CONF_ID>-999999998</PARENT_CONF_ID>
      <TYPE_ATTRIB_ID>2</TYPE_ATTRIB_ID>
      <ENTITY_TYPE_ID>3339</ENTITY_TYPE_ID>
      <EXTERNAL_TYPE_ID>500000000009056</EXTERNAL_TYPE_ID>
      <FRAME_ID>-7235</FRAME_ID>
      <DATA_LENGTH>0</DATA_LENGTH>
      <DATA_PRECISION>6</DATA_PRECISION>
      <DATA_SCALE>0</DATA_SCALE>
      <DATA_TYPE>NUMBER</DATA_TYPE>
      <DISPLAY_VIEW>4</DISPLAY_VIEW>
      <IS_UPDATABLE>Y</IS_UPDATABLE>
      <IS_VISIBLE>Y</IS_VISIBLE>
      <REQUIRED>Y</REQUIRED>
      <DISPLAY_ORDER>3</DISPLAY_ORDER>
      <DISPLAY_NAME>Barrio</DISPLAY_NAME>
      <INIT_BASIC_EXP_ID>121035476</INIT_BASIC_EXP_ID>
      <VALID_BASIC_EXP_ID/>
      <INIT_EXPRESSION_ID/>
    ' ||
'  <VALID_EXPRESSION_ID/>
      <DEFAULT_VALUE/>
      <SELECT_STATEMENT>SELECT -1 ID, '||chr(38)||'apos;TODOS'||chr(38)||'apos; DESCRIPTION FROM DUAL
UNION
SELECT GEOGRAP_LOCATION_ID ID, DESCRIPTION DESCRIPTION
FROM OPEN.GE_GEOGRA_LOCATION
WHERE GEOG_LOCA_AREA_TYPE=5
AND GEOGRAP_LOCATION_ID '||chr(38)||'lt;'||chr(38)||'gt; -1</SELECT_STATEMENT>
      <SELECT_STATEMENT_ID>120112910</SELECT_STATEMENT_ID>
      <TAG_NAME/>
      <PROCESS_SEQUENCE/>
      <STATEMENT_CACHE>N</STATEMENT_CACHE>
      <USER_DEFAULT_ALLOWED>N</USER_DEFAULT_ALLOWED>
      <STYLE_CASE>U</STYLE_CASE>
      <SEQUENCE_ID>5</SEQUENCE_ID>
      <EXTERNAL_ROOT_ID>6121</EXTERNAL_ROOT_ID>
      <PARENT_ATTRIBUTE_NAME/>
      <PARENT_ENTITY_NAME/>
    </ATTRIBUTE>
    <ATTRIBUTE>
      <ENTITY_ATTRIBUTE_ID>106118</ENTITY_ATTRIBUTE_ID>
      <CONFIGURATION_ID>-999999993</CONFIGURATION_ID>
      <ATTRIBUTE_NAME>CATEGORY_ID</ATTRIBUTE_NAME>
      <ENTITY_ID>3203</ENTITY_ID>
      <ENTITY_NAME>GE_SUBSCRIBER</ENTITY_NAME>
      <PARENT_CONF_ID>-999999998</PARENT_CONF_ID>
  ' ||
'    <TYPE_ATTRIB_ID>2</TYPE_ATTRIB_ID>
      <ENTITY_TYPE_ID>3339</ENTITY_TYPE_ID>
      <EXTERNAL_TYPE_ID>500000000009056</EXTERNAL_TYPE_ID>
      <FRAME_ID>-7235</FRAME_ID>
      <DATA_LENGTH>0</DATA_LENGTH>
      <DATA_PRECISION>2</DATA_PRECISION>
      <DATA_SCALE>0</DATA_SCALE>
      <DATA_TYPE>NUMBER</DATA_TYPE>
      <DISPLAY_VIEW>4</DISPLAY_VIEW>
      <IS_UPDATABLE>Y</IS_UPDATABLE>
      <IS_VISIBLE>Y</IS_VISIBLE>
      <REQUIRED>Y</REQUIRED>
      <DISPLAY_ORDER>4</DISPLAY_ORDER>
      <DISPLAY_NAME>Categoria</DISPLAY_NAME>
      <INIT_BASIC_EXP_ID/>
      <VALID_BASIC_EXP_ID/>
      <INIT_EXPRESSION_ID/>
      <VALID_EXPRESSION_ID/>
      <DEFAULT_VALUE/>
      <SELECT_STATEMENT>SELECT -1 ID, '||chr(38)||'apos;TODOS'||chr(38)||'apos; DESCRIPTION
FROM dual
UNION ALL
SELECT catecodi ID, catedesc DESCRIPTION
FROM Open.categori
WHERE catecodi '||chr(38)||'lt;'||chr(38)||'gt; -1</SELECT_STATEMENT>
      <SELECT_STATEMENT_ID>120112911</SELECT_STATEMENT_ID>
      <TAG_NAME/>
      <PROCESS_SEQUENCE/>
      <STATEMENT_CACHE>N</ST' ||
'ATEMENT_CACHE>
      <USER_DEFAULT_ALLOWED>N</USER_DEFAULT_ALLOWED>
      <STYLE_CASE>U</STYLE_CASE>
      <SEQUENCE_ID>6</SEQUENCE_ID>
      <EXTERNAL_ROOT_ID>6121</EXTERNAL_ROOT_ID>
      <PARENT_ATTRIBUTE_NAME/>
      <PARENT_ENTITY_NAME/>
    </ATTRIBUTE>
    <ATTRIBUTE>
      <ENTITY_ATTRIBUTE_ID>106056</ENTITY_ATTRIBUTE_ID>
      <CONFIGURATION_ID>-999999992</CONFIGURATION_ID>
      <ATTRIBUTE_NAME>COLLECT_PROGRAM_ID</ATTRIBUTE_NAME>
      <ENTITY_ID>3203</ENTITY_ID>
      <ENTITY_NAME>GE_SUBSCRIBER</ENTITY_NAME>
      <PARENT_CONF_ID>-999999998</PARENT_CONF_ID>
      <TYPE_ATTRIB_ID>2</TYPE_ATTRIB_ID>
      <ENTITY_TYPE_ID>3339</ENTITY_TYPE_ID>
      <EXTERNAL_TYPE_ID>500000000009056</EXTERNAL_TYPE_ID>
      <FRAME_ID>-7235</FRAME_ID>
      <DATA_LENGTH>0</DATA_LENGTH>
      <DATA_PRECISION>2</DATA_PRECISION>
      <DATA_SCALE>0</DATA_SCALE>
      <DATA_TYPE>NUMBER</DATA_TYPE>
      <DISPLAY_VIEW>4</DISPLAY_VIEW>
      <IS_UPDATABLE>Y</IS_UPDATABLE>
      <IS_VISIBLE>Y</IS_VISIB' ||
'LE>
      <REQUIRED>Y</REQUIRED>
      <DISPLAY_ORDER>5</DISPLAY_ORDER>
      <DISPLAY_NAME>Subcategoria</DISPLAY_NAME>
      <INIT_BASIC_EXP_ID/>
      <VALID_BASIC_EXP_ID/>
      <INIT_EXPRESSION_ID/>
      <VALID_EXPRESSION_ID/>
      <DEFAULT_VALUE/>
      <SELECT_STATEMENT>SELECT -1 ID, '||chr(38)||'apos;TODOS'||chr(38)||'apos; DESCRIPTION FROM dual
union all
(
    SELECT  sucacodi ID, sucadesc DESCRIPTION
    FROM    subcateg
    WHERE   sucacate = ge_boInstanceControl.fsbGetFieldValue ('||chr(38)||'apos;GE_SUBSCRIBER'||chr(38)||'apos;, '||chr(38)||'apos;CATEGORY_ID'||chr(38)||'apos;)
    minus
    SELECT -1, '||chr(38)||'apos;NULO'||chr(38)||'apos; FROM dual
)</SELECT_STATEMENT>
      <SELECT_STATEMENT_ID>120112912</SELECT_STATEMENT_ID>
      <TAG_NAME/>
      <PROCESS_SEQUENCE/>
      <STATEMENT_CACHE>N</STATEMENT_CACHE>
      <USER_DEFAULT_ALLOWED>N</USER_DEFAULT_ALLOWED>
      <STYLE_CASE>U</STYLE_CASE>
      <SEQUENCE_ID>7</SEQUENCE_ID>
      <EXTERNAL_ROOT_ID>6121</EXTERNAL_ROOT_ID>
      <PARENT_ATTRIBUTE_NAME/>
      <PARENT_ENTITY_NAME/>
    </ATTRIBUTE>
    <ATTRI' ||
'BUTE>
      <ENTITY_ATTRIBUTE_ID>3341</ENTITY_ATTRIBUTE_ID>
      <CONFIGURATION_ID>-999999991</CONFIGURATION_ID>
      <ATTRIBUTE_NAME>ORGANIZAT_AREA_TYPE</ATTRIBUTE_NAME>
      <ENTITY_ID>3065</ENTITY_ID>
      <ENTITY_NAME>GE_ORGANIZAT_AREA</ENTITY_NAME>
      <PARENT_CONF_ID>-999999998</PARENT_CONF_ID>
      <TYPE_ATTRIB_ID>2</TYPE_ATTRIB_ID>
      <ENTITY_TYPE_ID>3339</ENTITY_TYPE_ID>
      <EXTERNAL_TYPE_ID>500000000009056</EXTERNAL_TYPE_ID>
      <FRAME_ID>-7235</FRAME_ID>
      <DATA_LENGTH>0</DATA_LENGTH>
      <DATA_PRECISION>4</DATA_PRECISION>
      <DATA_SCALE>0</DATA_SCALE>
      <DATA_TYPE>NUMBER</DATA_TYPE>
      <DISPLAY_VIEW/>
      <IS_UPDATABLE>Y</IS_UPDATABLE>
      <IS_VISIBLE>Y</IS_VISIBLE>
      <REQUIRED>Y</REQUIRED>
      <DISPLAY_ORDER>6</DISPLAY_ORDER>
      <DISPLAY_NAME>Ciclo</DISPLAY_NAME>
      <INIT_BASIC_EXP_ID/>
      <VALID_BASIC_EXP_ID/>
      <INIT_EXPRESSION_ID/>
      <VALID_EXPRESSION_ID/>
      <DEFAULT_VALUE/>
      <SELECT_STATEMENT/>
      <S' ||
'ELECT_STATEMENT_ID/>
      <TAG_NAME/>
      <PROCESS_SEQUENCE/>
      <STATEMENT_CACHE>N</STATEMENT_CACHE>
      <USER_DEFAULT_ALLOWED>N</USER_DEFAULT_ALLOWED>
      <STYLE_CASE>U</STYLE_CASE>
      <SEQUENCE_ID>8</SEQUENCE_ID>
      <EXTERNAL_ROOT_ID>6121</EXTERNAL_ROOT_ID>
      <PARENT_ATTRIBUTE_NAME/>
      <PARENT_ENTITY_NAME/>
    </ATTRIBUTE>
    <ATTRIBUTE>
      <ENTITY_ATTRIBUTE_ID>795</ENTITY_ATTRIBUTE_ID>
      <CONFIGURATION_ID>-999999990</CONFIGURATION_ID>
      <ATTRIBUTE_NAME>IDENT_TYPE_ID</ATTRIBUTE_NAME>
      <ENTITY_ID>3203</ENTITY_ID>
      <ENTITY_NAME>GE_SUBSCRIBER</ENTITY_NAME>
      <PARENT_CONF_ID>-999999998</PARENT_CONF_ID>
      <TYPE_ATTRIB_ID>2</TYPE_ATTRIB_ID>
      <ENTITY_TYPE_ID>3339</ENTITY_TYPE_ID>
      <EXTERNAL_TYPE_ID>500000000009056</EXTERNAL_TYPE_ID>
      <FRAME_ID>-7235</FRAME_ID>
      <DATA_LENGTH>0</DATA_LENGTH>
      <DATA_PRECISION>4</DATA_PRECISION>
      <DATA_SCALE>0</DATA_SCALE>
      <DATA_TYPE>NUMBER</DATA_TYPE>
      <DISPLAY_VIE' ||
'W>4</DISPLAY_VIEW>
      <IS_UPDATABLE>Y</IS_UPDATABLE>
      <IS_VISIBLE>Y</IS_VISIBLE>
      <REQUIRED>Y</REQUIRED>
      <DISPLAY_ORDER>7</DISPLAY_ORDER>
      <DISPLAY_NAME>Estado_Corte</DISPLAY_NAME>
      <INIT_BASIC_EXP_ID/>
      <VALID_BASIC_EXP_ID/>
      <INIT_EXPRESSION_ID/>
      <VALID_EXPRESSION_ID/>
      <DEFAULT_VALUE/>
      <SELECT_STATEMENT>SELECT escocodi ID, escodesc DESCRIPTION

FROM Open.estacort</SELECT_STATEMENT>
      <SELECT_STATEMENT_ID>120112913</SELECT_STATEMENT_ID>
      <TAG_NAME/>
      <PROCESS_SEQUENCE/>
      <STATEMENT_CACHE>N</STATEMENT_CACHE>
      <USER_DEFAULT_ALLOWED>N</USER_DEFAULT_ALLOWED>
      <STYLE_CASE>U</STYLE_CASE>
      <SEQUENCE_ID>9</SEQUENCE_ID>
      <EXTERNAL_ROOT_ID>6121</EXTERNAL_ROOT_ID>
      <PARENT_ATTRIBUTE_NAME/>
      <PARENT_ENTITY_NAME/>
    </ATTRIBUTE>
    <ATTRIBUTE>
      <ENTITY_ATTRIBUTE_ID>793</ENTITY_ATTRIBUTE_ID>
      <CONFIGURATION_ID>-999999989</CONFIGURATION_ID>
      <ATTRIBUTE_NAME>SUBSCRIBER_ID</ATTRI' ||
'BUTE_NAME>
      <ENTITY_ID>3203</ENTITY_ID>
      <ENTITY_NAME>GE_SUBSCRIBER</ENTITY_NAME>
      <PARENT_CONF_ID>-999999998</PARENT_CONF_ID>
      <TYPE_ATTRIB_ID>2</TYPE_ATTRIB_ID>
      <ENTITY_TYPE_ID>3339</ENTITY_TYPE_ID>
      <EXTERNAL_TYPE_ID>500000000009056</EXTERNAL_TYPE_ID>
      <FRAME_ID>-7235</FRAME_ID>
      <DATA_LENGTH>0</DATA_LENGTH>
      <DATA_PRECISION>15</DATA_PRECISION>
      <DATA_SCALE>0</DATA_SCALE>
      <DATA_TYPE>NUMBER</DATA_TYPE>
      <DISPLAY_VIEW>4</DISPLAY_VIEW>
      <IS_UPDATABLE>Y</IS_UPDATABLE>
      <IS_VISIBLE>Y</IS_VISIBLE>
      <REQUIRED>Y</REQUIRED>
      <DISPLAY_ORDER>8</DISPLAY_ORDER>
      <DISPLAY_NAME>Proteccion_Datos</DISPLAY_NAME>
      <INIT_BASIC_EXP_ID/>
      <VALID_BASIC_EXP_ID/>
      <INIT_EXPRESSION_ID/>
      <VALID_EXPRESSION_ID/>
      <DEFAULT_VALUE/>
      <SELECT_STATEMENT>SELECT -1 ID, '||chr(38)||'apos;AMBOS'||chr(38)||'apos; DESCRIPTION FROM DUAL
UNION
SELECT 1 ID, '||chr(38)||'apos;AUTORIZA'||chr(38)||'apos; DESCRIPTION FROM DUAL
UNION
SELECT 2 ID, '||chr(38)||'apos;NO AUTOR' ||
'IZA'||chr(38)||'apos; DESCRIPTION FROM DUAL</SELECT_STATEMENT>
      <SELECT_STATEMENT_ID>120112914</SELECT_STATEMENT_ID>
      <TAG_NAME/>
      <PROCESS_SEQUENCE/>
      <STATEMENT_CACHE>N</STATEMENT_CACHE>
      <USER_DEFAULT_ALLOWED>N</USER_DEFAULT_ALLOWED>
      <STYLE_CASE>U</STYLE_CASE>
      <SEQUENCE_ID>10</SEQUENCE_ID>
      <EXTERNAL_ROOT_ID>6121</EXTERNAL_ROOT_ID>
      <PARENT_ATTRIBUTE_NAME/>
      <PARENT_ENTITY_NAME/>
    </ATTRIBUTE>
    <ATTRIBUTE>
      <ENTITY_ATTRIBUTE_ID>90057599</ENTITY_ATTRIBUTE_ID>
      <CONFIGURATION_ID>-999999988</CONFIGURATION_ID>
      <ATTRIBUTE_NAME>SEGMENT_ID</ATTRIBUTE_NAME>
      <ENTITY_ID>1134</ENTITY_ID>
      <ENTITY_NAME>LDC_SEGMENT_SUSC</ENTITY_NAME>
      <PARENT_CONF_ID>-999999998</PARENT_CONF_ID>
      <TYPE_ATTRIB_ID>2</TYPE_ATTRIB_ID>
      <ENTITY_TYPE_ID>3339</ENTITY_TYPE_ID>
      <EXTERNAL_TYPE_ID>500000000009056</EXTERNAL_TYPE_ID>
      <FRAME_ID>-7235</FRAME_ID>
      <DATA_LENGTH>15</DATA_LENGTH>
      <DATA_PRECISION>15</DATA_P' ||
'RECISION>
      <DATA_SCALE>0</DATA_SCALE>
      <DATA_TYPE>NUMBER</DATA_TYPE>
      <DISPLAY_VIEW>4</DISPLAY_VIEW>
      <IS_UPDATABLE>Y</IS_UPDATABLE>
      <IS_VISIBLE>Y</IS_VISIBLE>
      <REQUIRED>Y</REQUIRED>
      <DISPLAY_ORDER>9</DISPLAY_ORDER>
      <DISPLAY_NAME>C¿d. Segmentaci¿n</DISPLAY_NAME>
      <INIT_BASIC_EXP_ID/>
      <VALID_BASIC_EXP_ID/>
      <INIT_EXPRESSION_ID/>
      <VALID_EXPRESSION_ID/>
      <DEFAULT_VALUE/>
      <SELECT_STATEMENT>SELECT -1 ID, '||chr(38)||'apos;TODOS'||chr(38)||'apos; DESCRIPTION FROM dual
union all
select cond_commer_segm_id  ID, DESCRIPTION DESCRIPTION  from LDC_CONDIT_COMMERC_SEGM WHERE cond_commer_segm_id  '||chr(38)||'lt;'||chr(38)||'gt; -1</SELECT_STATEMENT>
      <SELECT_STATEMENT_ID>120112916</SELECT_STATEMENT_ID>
      <TAG_NAME/>
      <PROCESS_SEQUENCE/>
      <STATEMENT_CACHE>N</STATEMENT_CACHE>
      <USER_DEFAULT_ALLOWED>N</USER_DEFAULT_ALLOWED>
      <STYLE_CASE>U</STYLE_CASE>
      <SEQUENCE_ID>11</SEQUENCE_ID>
      <EXTERNAL_ROOT_ID>6121</EXTERNAL_ROOT_ID>
      <PAR' ||
'ENT_ATTRIBUTE_NAME/>
      <PARENT_ENTITY_NAME/>
    </ATTRIBUTE>
  </COMPOSITION>
</PB>
'
;
ut_trace.trace('insertando tabla: GE_DISTRIBUTION_FILE fila (0)',1);
INSERT INTO GE_DISTRIBUTION_FILE(DISTRIBUTION_FILE_ID,APP_XML,DESCRIPTION,FILE_VERSION,VERSION_NUMBER,FILE_NAME,FILE_SOURCE,MD5_HASH,DISTRI_GROUP_ID) 
VALUES (LDC_DLRCLPB_.tb3_0(0),
XMLType(LDC_DLRCLPB_.clColumn_0),
'Clientes Potenciales Detallado Brilla'
,
'1.0.0.0'
,
29,
'LDC_DLRCLPB.APP'
,
null,
'b9d407878b01bbf3259b6533921c6a6d'
,
3);

exception when others then
LDC_DLRCLPB_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
DECLARE
 nuNewStatement number; 
 
BEGIN 
 
if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;
 
  ut_trace.trace('Borrando tabla GE_STATEMENT',1);
  BEGIN
   delete from GE_STATEMENT where STATEMENT_ID = 120112908 and MODULE_ID = 61 and NAME = 'LDC_DLRCLPB_DPTOS';
  EXCEPTION
  when ex.RECORD_HAVE_CHILDREN then
    ut_trace.trace('No se pudo borrar la sentencia: [120112908]',1);
   null;
  END;
ut_trace.trace('Obtiene nueva secuencia de GE_STATEMENT',1);
nuNewStatement := GE_BOSEQUENCE.NEXTGE_STATEMENT();

ut_trace.trace('insertando tabla: GE_STATEMENT ['||nuNewStatement||']',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID, MODULE_ID, DESCRIPTION, STATEMENT, NAME)  
VALUES (nuNewStatement, 61, 'LDC_DLRCLPB_DPTOS', 
'SELECT -1 ID, '|| chr(39) ||'TODOS'|| chr(39) ||' DESCRIPTION
FROM dual
UNION ALL
SELECT geograp_location_id ID, Description DESCRIPTION
FROM Open.ge_geogra_location
WHERE geog_loca_area_type = 2
AND geograp_location_id <> -1', 'LDC_DLRCLPB_DPTOS'); 

ut_trace.trace('Modificando GE_DISTRIBUTION_FILE',1);
UPDATE GE_DISTRIBUTION_FILE SET  GE_DISTRIBUTION_FILE.APP_XML = 
  UPDATEXML(GE_DISTRIBUTION_FILE.APP_XML, 
  '//COMPOSITION/ATTRIBUTE[ENTITY_ATTRIBUTE_ID = 3340 and ENTITY_ID = 3065]/SELECT_STATEMENT_ID/text()', 
  to_char(nuNewStatement)) 
WHERE GE_DISTRIBUTION_FILE.DISTRIBUTION_FILE_ID = 'LDC_DLRCLPB';
 
 
exception when others then
LDC_DLRCLPB_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
 
END; 
/
DECLARE
 nuNewStatement number; 
 
BEGIN 
 
if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;
 
  ut_trace.trace('Borrando tabla GE_STATEMENT',1);
  BEGIN
   delete from GE_STATEMENT where STATEMENT_ID = 120112909 and MODULE_ID = 61 and NAME = 'LDC_DLRCLPB_LOCALI';
  EXCEPTION
  when ex.RECORD_HAVE_CHILDREN then
    ut_trace.trace('No se pudo borrar la sentencia: [120112909]',1);
   null;
  END;
ut_trace.trace('Obtiene nueva secuencia de GE_STATEMENT',1);
nuNewStatement := GE_BOSEQUENCE.NEXTGE_STATEMENT();

ut_trace.trace('insertando tabla: GE_STATEMENT ['||nuNewStatement||']',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID, MODULE_ID, DESCRIPTION, STATEMENT, NAME)  
VALUES (nuNewStatement, 61, 'LDC_DLRCLPB_LOCALI', 
'SELECT -1 ID, '|| chr(39) ||'TODOS'|| chr(39) ||' DESCRIPTION
FROM dual
UNION ALL
SELECT geograp_location_id ID, Description DESCRIPTION
FROM Open.ge_geogra_location
WHERE geog_loca_area_type = 3
AND geograp_location_id <> -1', 'LDC_DLRCLPB_LOCALI'); 

ut_trace.trace('Modificando GE_DISTRIBUTION_FILE',1);
UPDATE GE_DISTRIBUTION_FILE SET  GE_DISTRIBUTION_FILE.APP_XML = 
  UPDATEXML(GE_DISTRIBUTION_FILE.APP_XML, 
  '//COMPOSITION/ATTRIBUTE[ENTITY_ATTRIBUTE_ID = 3338 and ENTITY_ID = 3065]/SELECT_STATEMENT_ID/text()', 
  to_char(nuNewStatement)) 
WHERE GE_DISTRIBUTION_FILE.DISTRIBUTION_FILE_ID = 'LDC_DLRCLPB';
 
 
exception when others then
LDC_DLRCLPB_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
 
END; 
/
DECLARE
 nuNewStatement number; 
 
BEGIN 
 
if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;
 
  ut_trace.trace('Borrando tabla GE_STATEMENT',1);
  BEGIN
   delete from GE_STATEMENT where STATEMENT_ID = 120112910 and MODULE_ID = 61 and NAME = 'LDC_DLRCLPB_BARRIO';
  EXCEPTION
  when ex.RECORD_HAVE_CHILDREN then
    ut_trace.trace('No se pudo borrar la sentencia: [120112910]',1);
   null;
  END;
ut_trace.trace('Obtiene nueva secuencia de GE_STATEMENT',1);
nuNewStatement := GE_BOSEQUENCE.NEXTGE_STATEMENT();

ut_trace.trace('insertando tabla: GE_STATEMENT ['||nuNewStatement||']',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID, MODULE_ID, DESCRIPTION, STATEMENT, NAME)  
VALUES (nuNewStatement, 61, 'LDC_DLRCLPB_BARRIO', 
'SELECT -1 ID, '|| chr(39) ||'TODOS'|| chr(39) ||' DESCRIPTION FROM DUAL
UNION
SELECT GEOGRAP_LOCATION_ID ID, DESCRIPTION DESCRIPTION
FROM OPEN.GE_GEOGRA_LOCATION
WHERE GEOG_LOCA_AREA_TYPE=5
AND GEOGRAP_LOCATION_ID <> -1', 'LDC_DLRCLPB_BARRIO'); 

ut_trace.trace('Modificando GE_DISTRIBUTION_FILE',1);
UPDATE GE_DISTRIBUTION_FILE SET  GE_DISTRIBUTION_FILE.APP_XML = 
  UPDATEXML(GE_DISTRIBUTION_FILE.APP_XML, 
  '//COMPOSITION/ATTRIBUTE[ENTITY_ATTRIBUTE_ID = 18237 and ENTITY_ID = 999]/SELECT_STATEMENT_ID/text()', 
  to_char(nuNewStatement)) 
WHERE GE_DISTRIBUTION_FILE.DISTRIBUTION_FILE_ID = 'LDC_DLRCLPB';
 
 
exception when others then
LDC_DLRCLPB_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
 
END; 
/
DECLARE
 nuNewStatement number; 
 
BEGIN 
 
if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;
 
  ut_trace.trace('Borrando tabla GE_STATEMENT',1);
  BEGIN
   delete from GE_STATEMENT where STATEMENT_ID = 120112911 and MODULE_ID = 61 and NAME = 'LDC_DLRCLPB_CATEG';
  EXCEPTION
  when ex.RECORD_HAVE_CHILDREN then
    ut_trace.trace('No se pudo borrar la sentencia: [120112911]',1);
   null;
  END;
ut_trace.trace('Obtiene nueva secuencia de GE_STATEMENT',1);
nuNewStatement := GE_BOSEQUENCE.NEXTGE_STATEMENT();

ut_trace.trace('insertando tabla: GE_STATEMENT ['||nuNewStatement||']',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID, MODULE_ID, DESCRIPTION, STATEMENT, NAME)  
VALUES (nuNewStatement, 61, 'LDC_DLRCLPB_CATEG', 
'SELECT -1 ID, '|| chr(39) ||'TODOS'|| chr(39) ||' DESCRIPTION
FROM dual
UNION ALL
SELECT catecodi ID, catedesc DESCRIPTION
FROM Open.categori
WHERE catecodi <> -1', 'LDC_DLRCLPB_CATEG'); 

ut_trace.trace('Modificando GE_DISTRIBUTION_FILE',1);
UPDATE GE_DISTRIBUTION_FILE SET  GE_DISTRIBUTION_FILE.APP_XML = 
  UPDATEXML(GE_DISTRIBUTION_FILE.APP_XML, 
  '//COMPOSITION/ATTRIBUTE[ENTITY_ATTRIBUTE_ID = 106118 and ENTITY_ID = 3203]/SELECT_STATEMENT_ID/text()', 
  to_char(nuNewStatement)) 
WHERE GE_DISTRIBUTION_FILE.DISTRIBUTION_FILE_ID = 'LDC_DLRCLPB';
 
 
exception when others then
LDC_DLRCLPB_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
 
END; 
/
DECLARE
 nuNewStatement number; 
 
BEGIN 
 
if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;
 
  ut_trace.trace('Borrando tabla GE_STATEMENT',1);
  BEGIN
   delete from GE_STATEMENT where STATEMENT_ID = 120112912 and MODULE_ID = 61 and NAME = 'LDC_DLRCLPB_SUBCATEG';
  EXCEPTION
  when ex.RECORD_HAVE_CHILDREN then
    ut_trace.trace('No se pudo borrar la sentencia: [120112912]',1);
   null;
  END;
ut_trace.trace('Obtiene nueva secuencia de GE_STATEMENT',1);
nuNewStatement := GE_BOSEQUENCE.NEXTGE_STATEMENT();

ut_trace.trace('insertando tabla: GE_STATEMENT ['||nuNewStatement||']',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID, MODULE_ID, DESCRIPTION, STATEMENT, NAME)  
VALUES (nuNewStatement, 61, 'LDC_DLRCLPB_SUBCATEG', 
'SELECT -1 ID, '|| chr(39) ||'TODOS'|| chr(39) ||' DESCRIPTION FROM dual
union all
(
    SELECT  sucacodi ID, sucadesc DESCRIPTION
    FROM    subcateg
    WHERE   sucacate = ge_boInstanceControl.fsbGetFieldValue ('|| chr(39) ||'GE_SUBSCRIBER'|| chr(39) ||', '|| chr(39) ||'CATEGORY_ID'|| chr(39) ||')
    minus
    SELECT -1, '|| chr(39) ||'NULO'|| chr(39) ||' FROM dual
)', 'LDC_DLRCLPB_SUBCATEG'); 

ut_trace.trace('Modificando GE_DISTRIBUTION_FILE',1);
UPDATE GE_DISTRIBUTION_FILE SET  GE_DISTRIBUTION_FILE.APP_XML = 
  UPDATEXML(GE_DISTRIBUTION_FILE.APP_XML, 
  '//COMPOSITION/ATTRIBUTE[ENTITY_ATTRIBUTE_ID = 106056 and ENTITY_ID = 3203]/SELECT_STATEMENT_ID/text()', 
  to_char(nuNewStatement)) 
WHERE GE_DISTRIBUTION_FILE.DISTRIBUTION_FILE_ID = 'LDC_DLRCLPB';
 
 
exception when others then
LDC_DLRCLPB_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
 
END; 
/
DECLARE
 nuNewStatement number; 
 
BEGIN 
 
if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;
 
  ut_trace.trace('Borrando tabla GE_STATEMENT',1);
  BEGIN
   delete from GE_STATEMENT where STATEMENT_ID = 120112913 and MODULE_ID = 61 and NAME = 'LDC_DLRCLPB_ESCO';
  EXCEPTION
  when ex.RECORD_HAVE_CHILDREN then
    ut_trace.trace('No se pudo borrar la sentencia: [120112913]',1);
   null;
  END;
ut_trace.trace('Obtiene nueva secuencia de GE_STATEMENT',1);
nuNewStatement := GE_BOSEQUENCE.NEXTGE_STATEMENT();

ut_trace.trace('insertando tabla: GE_STATEMENT ['||nuNewStatement||']',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID, MODULE_ID, DESCRIPTION, STATEMENT, NAME)  
VALUES (nuNewStatement, 61, 'LDC_DLRCLPB_ESCO', 
'SELECT escocodi ID, escodesc DESCRIPTION
FROM Open.estacort', 'LDC_DLRCLPB_ESCO'); 

ut_trace.trace('Modificando GE_DISTRIBUTION_FILE',1);
UPDATE GE_DISTRIBUTION_FILE SET  GE_DISTRIBUTION_FILE.APP_XML = 
  UPDATEXML(GE_DISTRIBUTION_FILE.APP_XML, 
  '//COMPOSITION/ATTRIBUTE[ENTITY_ATTRIBUTE_ID = 795 and ENTITY_ID = 3203]/SELECT_STATEMENT_ID/text()', 
  to_char(nuNewStatement)) 
WHERE GE_DISTRIBUTION_FILE.DISTRIBUTION_FILE_ID = 'LDC_DLRCLPB';
 
 
exception when others then
LDC_DLRCLPB_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
 
END; 
/
DECLARE
 nuNewStatement number; 
 
BEGIN 
 
if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;
 
  ut_trace.trace('Borrando tabla GE_STATEMENT',1);
  BEGIN
   delete from GE_STATEMENT where STATEMENT_ID = 120112914 and MODULE_ID = 61 and NAME = 'LDC_DLRCLPB_PTD';
  EXCEPTION
  when ex.RECORD_HAVE_CHILDREN then
    ut_trace.trace('No se pudo borrar la sentencia: [120112914]',1);
   null;
  END;
ut_trace.trace('Obtiene nueva secuencia de GE_STATEMENT',1);
nuNewStatement := GE_BOSEQUENCE.NEXTGE_STATEMENT();

ut_trace.trace('insertando tabla: GE_STATEMENT ['||nuNewStatement||']',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID, MODULE_ID, DESCRIPTION, STATEMENT, NAME)  
VALUES (nuNewStatement, 61, 'LDC_DLRCLPB_PTD', 
'SELECT -1 ID, '|| chr(39) ||'AMBOS'|| chr(39) ||' DESCRIPTION FROM DUAL
UNION
SELECT 1 ID, '|| chr(39) ||'AUTORIZA'|| chr(39) ||' DESCRIPTION FROM DUAL
UNION
SELECT 2 ID, '|| chr(39) ||'NO AUTORIZA'|| chr(39) ||' DESCRIPTION FROM DUAL', 'LDC_DLRCLPB_PTD'); 

ut_trace.trace('Modificando GE_DISTRIBUTION_FILE',1);
UPDATE GE_DISTRIBUTION_FILE SET  GE_DISTRIBUTION_FILE.APP_XML = 
  UPDATEXML(GE_DISTRIBUTION_FILE.APP_XML, 
  '//COMPOSITION/ATTRIBUTE[ENTITY_ATTRIBUTE_ID = 793 and ENTITY_ID = 3203]/SELECT_STATEMENT_ID/text()', 
  to_char(nuNewStatement)) 
WHERE GE_DISTRIBUTION_FILE.DISTRIBUTION_FILE_ID = 'LDC_DLRCLPB';
 
 
exception when others then
LDC_DLRCLPB_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
 
END; 
/
DECLARE
 nuNewStatement number; 
 
BEGIN 
 
if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;
 
  ut_trace.trace('Borrando tabla GE_STATEMENT',1);
  BEGIN
   delete from GE_STATEMENT where STATEMENT_ID = 120112916 and MODULE_ID = 61 and NAME = 'Segmento';
  EXCEPTION
  when ex.RECORD_HAVE_CHILDREN then
    ut_trace.trace('No se pudo borrar la sentencia: [120112916]',1);
   null;
  END;
ut_trace.trace('Obtiene nueva secuencia de GE_STATEMENT',1);
nuNewStatement := GE_BOSEQUENCE.NEXTGE_STATEMENT();

ut_trace.trace('insertando tabla: GE_STATEMENT ['||nuNewStatement||']',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID, MODULE_ID, DESCRIPTION, STATEMENT, NAME)  
VALUES (nuNewStatement, 61, 'Segmento', 
'SELECT -1 ID, '|| chr(39) ||'TODOS'|| chr(39) ||' DESCRIPTION FROM dual
union all
select cond_commer_segm_id  ID, DESCRIPTION DESCRIPTION  from LDC_CONDIT_COMMERC_SEGM WHERE cond_commer_segm_id  <> -1', 'Segmento'); 

ut_trace.trace('Modificando GE_DISTRIBUTION_FILE',1);
UPDATE GE_DISTRIBUTION_FILE SET  GE_DISTRIBUTION_FILE.APP_XML = 
  UPDATEXML(GE_DISTRIBUTION_FILE.APP_XML, 
  '//COMPOSITION/ATTRIBUTE[ENTITY_ATTRIBUTE_ID = 90057599 and ENTITY_ID = 1134]/SELECT_STATEMENT_ID/text()', 
  to_char(nuNewStatement)) 
WHERE GE_DISTRIBUTION_FILE.DISTRIBUTION_FILE_ID = 'LDC_DLRCLPB';
 
 
exception when others then
LDC_DLRCLPB_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
 
END; 
/
DECLARE
  clApplication       clob;
  sbMD5Hash           GE_DISTRIBUTION_FILE.md5_hash%type;
  sbObfuscationInput  varchar2(32767);
BEGIN

if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;

ut_trace.trace('Obteniendo APP_XML de GE_DISTRIBUTION_FILE',1);
  SELECT extract(GE_DISTRIBUTION_FILE.APP_XML, '/').getClobval()
  INTO  clApplication
  FROM GE_DISTRIBUTION_FILE
  WHERE GE_DISTRIBUTION_FILE.DISTRIBUTION_FILE_ID = 'LDC_DLRCLPB';
  ut_trace.trace('validando tamaño del CLOB asociado',1);
  if (LENGTH(clApplication) > 32767) then
    ut_trace.trace('Mayor a 32K, se recorta',10);
    sbObfuscationInput := dbms_lob.substr(clApplication);
  else
    ut_trace.trace('Menor a 32K, se copia',10);
    sbObfuscationInput := clApplication;
  END if;
ut_trace.trace('Obteniendo MD5 Hash',1);
  sbMD5Hash:=lower(rawtohex(sys.dbms_obfuscation_toolkit.md5( input => utl_raw.cast_to_raw(sbObfuscationInput))));
ut_trace.trace('Modificando MD5 ['||sbMD5Hash||'] en GE_DISTRIBUTION_FILE',1);
  UPDATE GE_DISTRIBUTION_FILE SET  GE_DISTRIBUTION_FILE.MD5_HASH = sbMD5Hash
  WHERE GE_DISTRIBUTION_FILE.DISTRIBUTION_FILE_ID = 'LDC_DLRCLPB';

exception when others then
LDC_DLRCLPB_.blProcessStatus := false;
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
 nuIndexInternal := LDC_DLRCLPB_.tb0_0.first;
 while nuIndexInternal IS NOT null loop
  IF (LDC_DLRCLPB_.tb0_0(nuIndexInternal)=isbExecutableName ) THEN
   IF (LDC_DLRCLPB_.tb0_1.exists(nuIndexInternal)) then
    tbExecutableEquivalence(isbExecutableName) := LDC_DLRCLPB_.tb0_1(nuIndexInternal);
   END IF;
   exit;
  END IF;
  nuIndexInternal := LDC_DLRCLPB_.tb0_0.next(nuIndexInternal);
 END loop; 
 return tbExecutableEquivalence(isbExecutableName);
END;
BEGIN

if (not LDC_DLRCLPB_.blProcessStatus) then
 return;
end if;
nuIndex :=  LDC_DLRCLPB_.tbRoleExecutables.first;
while nuIndex IS NOT null loop
 if (LDC_DLRCLPB_.tbRoleExecutables(nuIndex).role_id!=1) then
  nuNewExecutableId := fnuGetNewExecutableId(LDC_DLRCLPB_.tbRoleExecutables(nuIndex).name);
  IF nuNewExecutableId is not null then
    INSERT INTO sa_role_executables (role_id, executable_id)
    VALUES (LDC_DLRCLPB_.tbRoleExecutables(nuIndex).role_id, nuNewExecutableId);
  END IF;
  end if;
 nuIndex := LDC_DLRCLPB_.tbRoleExecutables.next(nuIndex);
END loop;
nuIndex :=  LDC_DLRCLPB_.tbUserException.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LDC_DLRCLPB_.tbUserException(nuIndex).name);
 IF nuNewExecutableId is not null then
  insert INTO sa_user_exceptions (executable_id, user_id, status, usr_exc_type_id, comment_)
  VALUES (nuNewExecutableId ,LDC_DLRCLPB_.tbUserException(nuIndex).user_id, LDC_DLRCLPB_.tbUserException(nuIndex).status , LDC_DLRCLPB_.tbUserException(nuIndex).usr_exc_type_id, LDC_DLRCLPB_.tbUserException(nuIndex).comment_);
 END IF;
 nuIndex := LDC_DLRCLPB_.tbUserException.next(nuIndex);
END loop;
nuIndex :=  LDC_DLRCLPB_.tbExecEntities.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LDC_DLRCLPB_.tbExecEntities(nuIndex).name);
 IF nuNewExecutableId is not null then
  select count(1) into nuRecCount
 from sa_exec_entities
  where executable_id = nuNewExecutableId and entity_id = LDC_DLRCLPB_.tbExecEntities(nuIndex).entity_id;
  IF nuRecCount = 0 then
    insert INTO sa_exec_entities (executable_id, entity_id )
    VALUES (nuNewExecutableId ,LDC_DLRCLPB_.tbExecEntities(nuIndex).entity_id );
  END IF;
 END IF;
 nuIndex := LDC_DLRCLPB_.tbExecEntities.next(nuIndex);
END loop;

exception when others then
LDC_DLRCLPB_.blProcessStatus := false;
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
 nuIndex := LDC_DLRCLPB_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || LDC_DLRCLPB_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(LDC_DLRCLPB_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(LDC_DLRCLPB_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(LDC_DLRCLPB_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || LDC_DLRCLPB_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || LDC_DLRCLPB_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := LDC_DLRCLPB_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('LDC_DLRCLPB_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:LDC_DLRCLPB_******************************'); end;
/
