BEGIN
setsystemenviroment;
END;
/


BEGIN
sa_bocreatePackages.CreatePackage('LDRREPB_GC_',
'CREATE OR REPLACE PACKAGE LDRREPB_GC_ IS ' || chr(10) ||
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
'tb1_1 ty1_1;type ty2_0 is table of GE_DISTRIBUTION_FILE.DISTRIBUTION_FILE_ID%type index by binary_integer; ' || chr(10) ||
'old_tb2_0 ty2_0; ' || chr(10) ||
'tb2_0 ty2_0;  executableName ge_catalog.tag_name%type := ''LDRREPB_GC''; ' || chr(10) ||
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
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDRREPB_GC'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuUserExceptions  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.user_id,a.status,a.usr_exc_type_id,a.comment_ ' || chr(10) ||
'FROM sa_user_exceptions a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDRREPB_GC'' ' || chr(10) ||
'); ' || chr(10) ||
'CURSOR cuExecEntities  ' || chr(10) ||
'IS  ' || chr(10) ||
'SELECT b.name,a.executable_id,a.entity_id ' || chr(10) ||
'FROM sa_exec_entities a, sa_executable b ' || chr(10) ||
'WHERE a.executable_id = b.executable_id ' || chr(10) ||
'and b.executable_id in ' || chr(10) ||
'( ' || chr(10) ||
'SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME=''LDRREPB_GC'' ' || chr(10) ||
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
'END LDRREPB_GC_;');
END;
/


BEGIN ut_trace.trace('********************Comenzar proceso de objeto:LDRREPB_GC_******************************'); END;
/

declare 
nuIndex binary_integer:=0;
BEGIN

if (not LDRREPB_GC_.blProcessStatus) then
 return;
end if;
Open LDRREPB_GC_.cuRoleExecutables;
loop
 fetch LDRREPB_GC_.cuRoleExecutables INTO LDRREPB_GC_.rcRoleExecutables;
 exit when  LDRREPB_GC_.cuRoleExecutables%notfound;
 LDRREPB_GC_.tbRoleExecutables(nuIndex) := LDRREPB_GC_.rcRoleExecutables;
 nuIndex := nuIndex + 1;
END loop;
close LDRREPB_GC_.cuRoleExecutables;
nuIndex := 0;
Open LDRREPB_GC_.cuUserExceptions ;
loop
 fetch LDRREPB_GC_.cuUserExceptions INTO  LDRREPB_GC_.rcUserExceptions;
 exit when LDRREPB_GC_.cuUserExceptions%notfound;
 LDRREPB_GC_.tbUserException(nuIndex):=LDRREPB_GC_.rcUserExceptions;
 nuIndex := nuIndex + 1;
END loop;
close LDRREPB_GC_.cuUserExceptions;
nuIndex := 0;
Open LDRREPB_GC_.cuExecEntities ;
loop
 fetch LDRREPB_GC_.cuExecEntities INTO  LDRREPB_GC_.rcExecEntities;
 exit when LDRREPB_GC_.cuExecEntities%notfound;
 LDRREPB_GC_.tbExecEntities(nuIndex):=LDRREPB_GC_.rcExecEntities;
 nuIndex := nuIndex + 1;
END loop;
close LDRREPB_GC_.cuExecEntities;

exception when others then
LDRREPB_GC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/

BEGIN

if (not LDRREPB_GC_.blProcessStatus) then
 return;
end if;
DELETE FROM sa_role_executables
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDRREPB_GC'
);
DELETE FROM sa_user_exceptions
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDRREPB_GC'
);
DELETE FROM sa_exec_entities
WHERE executable_id in
(
 SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDRREPB_GC'
);

exception when others then
LDRREPB_GC_.blProcessStatus := false;
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
          if ( LDRREPB_GC_.tbObjectToDelete.last IS null ) then
            nuNumObjects := 1;
          else
            nuNumObjects := LDRREPB_GC_.tbObjectToDelete.last + 1;
          end if;
          LDRREPB_GC_.tbObjectToDelete(nuNumObjects) := sbObjectName;
        END IF;
        ut_trace.trace('Borrando registro en gr_config_expression: '||inuNumExpression,1);
        DELETE
        FROM GR_CONFIG_EXPRESSION
        WHERE GR_CONFIG_EXPRESSION.CONFIG_EXPRESSION_ID = to_number(sbNumExpression);
      END IF;
 END;
 
BEGIN 
 
if (not LDRREPB_GC_.blProcessStatus) then
 return;
end if;
 
  ut_trace.trace('Validando existencia del registro en GE_DISTRIBUTION_FILE',1);
  SELECT count(1)
  INTO  nuNumRecords
  FROM GE_DISTRIBUTION_FILE
  WHERE GE_DISTRIBUTION_FILE.DISTRIBUTION_FILE_ID = 'LDRREPB_GC';
  IF (nuNumRecords > 0) THEN
    ut_trace.trace('Obteniendo composicion general',1);
    SELECT extract(GE_DISTRIBUTION_FILE.APP_XML,'/')
    INTO   xlApplication
    FROM   GE_DISTRIBUTION_FILE
    WHERE  GE_DISTRIBUTION_FILE.DISTRIBUTION_FILE_ID = 'LDRREPB_GC';
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
LDRREPB_GC_.blProcessStatus := false;
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
WHERE   sa_executable.name = 'LDRREPB_GC'
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
WHERE   sa_executable.name = 'LDRREPB_GC'
AND     gi_config.external_root_id = sa_executable.executable_id
AND     gi_config.config_type_id = 4
AND     gi_config.entity_root_id = 3339
AND     gi_composition.config_id = gi_config.config_id
AND     gi_frame.composition_id = gi_composition.composition_id
AND     (gi_frame.after_expression_id = gr_config_expression.config_expression_id
OR      gi_frame.before_expression_id = gr_config_expression.config_expression_id);
BEGIN

if (not LDRREPB_GC_.blProcessStatus) then
 return;
end if;
 nuIndex := 1;
 FOR crObjectsName IN cuObjectsName LOOP
  LDRREPB_GC_.tbObjectToDelete(nuIndex) := crObjectsName.OBJECT_NAME;
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

if (not LDRREPB_GC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_ROLE_EXECUTABLES',1);
  DELETE FROM SA_ROLE_EXECUTABLES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDRREPB_GC') AND ROLE_ID=1;

exception when others then
LDRREPB_GC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDRREPB_GC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_USER_EXCEPTIONS',1);
  DELETE FROM SA_USER_EXCEPTIONS WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDRREPB_GC') AND 1=2;

exception when others then
LDRREPB_GC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
declare
type tyrowidrecord IS table of rowid index BY binary_integer;
tbrowidvalue  tyrowidrecord;
CURSOR cuRowIdToDelete is
SELECT rowid
FROM SA_EXECUTABLE_SYNON WHERE (SYNONYMOUS_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDRREPB_GC');
nuIndex binary_integer;
BEGIN

if (not LDRREPB_GC_.blProcessStatus) then
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
LDRREPB_GC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDRREPB_GC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXEC_ENTITIES',1);
  DELETE FROM SA_EXEC_ENTITIES WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDRREPB_GC');

exception when others then
LDRREPB_GC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDRREPB_GC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_MENU_OPTION',1);
  DELETE FROM SA_MENU_OPTION WHERE (EXECUTABLE_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDRREPB_GC');

exception when others then
LDRREPB_GC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDRREPB_GC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_CONFIG_COMP',1);
  DELETE FROM GI_CONFIG_COMP WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDRREPB_GC') AND CONFIG_TYPE_ID=4 AND ENTITY_ROOT_ID=3339);

exception when others then
LDRREPB_GC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDRREPB_GC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_CONFIG_COMP',1);
  DELETE FROM GI_CONFIG_COMP WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDRREPB_GC') AND CONFIG_TYPE_ID=4 AND ENTITY_ROOT_ID=3339));

exception when others then
LDRREPB_GC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GE_STATEMENT WHERE (STATEMENT_ID) in (SELECT SELECT_STATEMENT_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDRREPB_GC') AND CONFIG_TYPE_ID=4 AND ENTITY_ROOT_ID=3339)));
BEGIN 

if (not LDRREPB_GC_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GE_STATEMENT',1);
for rcData in cuLoadTemporaryTable loop
LDRREPB_GC_.tbGE_STATEMENTRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
LDRREPB_GC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT INIT_EXPRESSION_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDRREPB_GC') AND CONFIG_TYPE_ID=4 AND ENTITY_ROOT_ID=3339)));
BEGIN 

if (not LDRREPB_GC_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
LDRREPB_GC_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
LDRREPB_GC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT VALID_EXPRESSION_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDRREPB_GC') AND CONFIG_TYPE_ID=4 AND ENTITY_ROOT_ID=3339)));
BEGIN 

if (not LDRREPB_GC_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
LDRREPB_GC_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
LDRREPB_GC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDRREPB_GC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (COMP_ATTRIBS_ID) in (SELECT COMP_ATTRIBS_ID FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDRREPB_GC') AND CONFIG_TYPE_ID=4 AND ENTITY_ROOT_ID=3339)));

exception when others then
LDRREPB_GC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDRREPB_GC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_ATTRIBS',1);
  DELETE FROM GI_COMP_ATTRIBS WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDRREPB_GC') AND CONFIG_TYPE_ID=4 AND ENTITY_ROOT_ID=3339));

exception when others then
LDRREPB_GC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not LDRREPB_GC_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GE_STATEMENT',1);
nuVarcharIndex:=LDRREPB_GC_.tbGE_STATEMENTRowId.first;  
while (nuVarcharIndex is not null) loop 
begin
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GE_STATEMENT where rowid = LDRREPB_GC_.tbGE_STATEMENTRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
EXCEPTION
when ex.RECORD_HAVE_CHILDREN then
ut_trace.trace('No se pudo borrar el registro '||nuVarcharIndex,1);
nuOldVarcharIndex:=null;
null;
END;
if nuOldVarcharIndex is not null then
LDRREPB_GC_.tbGE_STATEMENTRowId.delete(nuOldVarcharIndex);
end if;
nuVarcharIndex := LDRREPB_GC_.tbGE_STATEMENTRowId.next(nuVarcharIndex); 
END loop; 

exception when others then
LDRREPB_GC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not LDRREPB_GC_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=LDRREPB_GC_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = LDRREPB_GC_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
nuVarcharIndex := LDRREPB_GC_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
LDRREPB_GC_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex); 
END loop; 

exception when others then
LDRREPB_GC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not LDRREPB_GC_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=LDRREPB_GC_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = LDRREPB_GC_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
nuVarcharIndex := LDRREPB_GC_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
LDRREPB_GC_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex); 
END loop; 

exception when others then
LDRREPB_GC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GI_COMPOSITION WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDRREPB_GC') AND CONFIG_TYPE_ID=4 AND ENTITY_ROOT_ID=3339)));
BEGIN 

if (not LDRREPB_GC_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GI_COMPOSITION',1);
for rcData in cuLoadTemporaryTable loop
LDRREPB_GC_.tbGI_COMPOSITIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
LDRREPB_GC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT AFTER_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDRREPB_GC') AND CONFIG_TYPE_ID=4 AND ENTITY_ROOT_ID=3339)));
BEGIN 

if (not LDRREPB_GC_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
LDRREPB_GC_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
LDRREPB_GC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
 CURSOR cuLoadTemporaryTable IS 
 SELECT rowid FROM GR_CONFIG_EXPRESSION WHERE (CONFIG_EXPRESSION_ID) in (SELECT BEFORE_EXPRESSION_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDRREPB_GC') AND CONFIG_TYPE_ID=4 AND ENTITY_ROOT_ID=3339)));
BEGIN 

if (not LDRREPB_GC_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Cargando a memoria tabla GR_CONFIG_EXPRESSION',1);
for rcData in cuLoadTemporaryTable loop
LDRREPB_GC_.tbGR_CONFIG_EXPRESSIONRowId(rcData.rowid):=rcData.rowid; 
END loop; 

exception when others then
LDRREPB_GC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDRREPB_GC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMP_FRAME_ATTRIB',1);
  DELETE FROM GI_COMP_FRAME_ATTRIB WHERE (FRAME_ID) in (SELECT FRAME_ID FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDRREPB_GC') AND CONFIG_TYPE_ID=4 AND ENTITY_ROOT_ID=3339)));

exception when others then
LDRREPB_GC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDRREPB_GC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_FRAME',1);
  DELETE FROM GI_FRAME WHERE (COMPOSITION_ID) in (SELECT COMPOSITION_ID FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDRREPB_GC') AND CONFIG_TYPE_ID=4 AND ENTITY_ROOT_ID=3339));

exception when others then
LDRREPB_GC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not LDRREPB_GC_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GI_COMPOSITION',1);
nuVarcharIndex:=LDRREPB_GC_.tbGI_COMPOSITIONRowId.first;  
while (nuVarcharIndex is not null) loop 
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GI_COMPOSITION where rowid = LDRREPB_GC_.tbGI_COMPOSITIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
nuVarcharIndex := LDRREPB_GC_.tbGI_COMPOSITIONRowId.next(nuVarcharIndex); 
LDRREPB_GC_.tbGI_COMPOSITIONRowId.delete(nuOldVarcharIndex); 
END loop; 

exception when others then
LDRREPB_GC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not LDRREPB_GC_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=LDRREPB_GC_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = LDRREPB_GC_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
nuVarcharIndex := LDRREPB_GC_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
LDRREPB_GC_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex); 
END loop; 

exception when others then
LDRREPB_GC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
DECLARE 
nuVarcharIndex Varchar2(100);
nuOldVarcharIndex Varchar2(100);
BEGIN 

if (not LDRREPB_GC_.blProcessStatus) then
 return;
end if;
ut_trace.trace('Borrando tabla cargada en memoria GR_CONFIG_EXPRESSION',1);
nuVarcharIndex:=LDRREPB_GC_.tbGR_CONFIG_EXPRESSIONRowId.first;  
while (nuVarcharIndex is not null) loop 
ut_trace.trace('Row id a borrar:'||nuVarcharIndex,1);
delete from GR_CONFIG_EXPRESSION where rowid = LDRREPB_GC_.tbGR_CONFIG_EXPRESSIONRowId(nuVarcharIndex); 
nuOldVarcharIndex:=nuVarcharIndex;
nuVarcharIndex := LDRREPB_GC_.tbGR_CONFIG_EXPRESSIONRowId.next(nuVarcharIndex); 
LDRREPB_GC_.tbGR_CONFIG_EXPRESSIONRowId.delete(nuOldVarcharIndex); 
END loop; 

exception when others then
LDRREPB_GC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDRREPB_GC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_COMPOSITION',1);
  DELETE FROM GI_COMPOSITION WHERE (CONFIG_ID) in (SELECT CONFIG_ID FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDRREPB_GC') AND CONFIG_TYPE_ID=4 AND ENTITY_ROOT_ID=3339);

exception when others then
LDRREPB_GC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDRREPB_GC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GI_CONFIG',1);
  DELETE FROM GI_CONFIG WHERE (EXTERNAL_ROOT_ID) in (SELECT EXECUTABLE_ID FROM SA_EXECUTABLE WHERE NAME='LDRREPB_GC') AND CONFIG_TYPE_ID=4 AND ENTITY_ROOT_ID=3339;

exception when others then
LDRREPB_GC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDRREPB_GC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla GE_DISTRIBUTION_FILE',1);
  DELETE FROM GE_DISTRIBUTION_FILE WHERE (DISTRIBUTION_FILE_ID) in (SELECT NAME FROM SA_EXECUTABLE WHERE NAME='LDRREPB_GC');

exception when others then
LDRREPB_GC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDRREPB_GC_.blProcessStatus) then
 return;
end if;
  ut_trace.trace('Borrando tabla SA_EXECUTABLE',1);
  DELETE FROM SA_EXECUTABLE WHERE NAME='LDRREPB_GC';

exception when others then
LDRREPB_GC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END; 
/
BEGIN

if (not LDRREPB_GC_.blProcessStatus) then
 return;
end if;

LDRREPB_GC_.old_tb0_0(0):='LDRREPB_GC'
;
LDRREPB_GC_.tb0_0(0):=UPPER(LDRREPB_GC_.old_tb0_0(0));
LDRREPB_GC_.tb0_0(0):=LDRREPB_GC_.tb0_0(0);
LDRREPB_GC_.old_tb0_1(0):=500000000007637;
LDRREPB_GC_.tb0_1(0):=GE_BOCATALOG.FNUGETIDSEQFROMCATALOG(LDRREPB_GC_.tb0_0(0), 'EXECUTABLE', 'SA_BOEXECUTABLE.GETNEXTID');
LDRREPB_GC_.tb0_1(0):=LDRREPB_GC_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_EXECUTABLE fila (0)',1);
INSERT INTO SA_EXECUTABLE(NAME,EXECUTABLE_ID,DESCRIPTION,PATH,VERSION,EXECUTABLE_TYPE_ID,EXEC_OPER_TYPE_ID,MODULE_ID,SUBSYSTEM_ID,PARENT_EXECUTABLE_ID,LAST_RECORD_ALLOWED,PATH_FILE_HELP,WITHOUT_RESTR_POLICY,DIRECT_EXECUTION,TIMES_EXECUTED,EXEC_OWNER,LAST_DATE_EXECUTED,CLASS_ID) 
VALUES (LDRREPB_GC_.tb0_0(0),
LDRREPB_GC_.tb0_1(0),
'Generación de reportes B1 y B2'
,
null,
'3'
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
28,
null,
to_date('12-08-2016 08:11:48','DD-MM-YYYY HH24:MI:SS'),
null);

exception when others then
LDRREPB_GC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDRREPB_GC_.blProcessStatus) then
 return;
end if;

LDRREPB_GC_.tb1_0(0):=1;
LDRREPB_GC_.tb1_1(0):=LDRREPB_GC_.tb0_1(0);
ut_trace.trace('insertando tabla: SA_ROLE_EXECUTABLES fila (0)',1);
INSERT INTO SA_ROLE_EXECUTABLES(ROLE_ID,EXECUTABLE_ID) 
VALUES (LDRREPB_GC_.tb1_0(0),
LDRREPB_GC_.tb1_1(0));

exception when others then
LDRREPB_GC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
BEGIN

if (not LDRREPB_GC_.blProcessStatus) then
 return;
end if;

LDRREPB_GC_.tb2_0(0):=LDRREPB_GC_.tb0_0(0);
LDRREPB_GC_.clColumn_0 := '<?xml version="1.0" encoding="UTF-8"?>
<PB xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <APPLICATION>
    <EXECUTABLE_ID>500000000007622</EXECUTABLE_ID>
    <NAME>LDRREPB_GC</NAME>
    <DESCRIPTION>Generación de reportes B1 y B2</DESCRIPTION>
    <VERSION>3</VERSION>
    <MODULE>61</MODULE>
    <DIRECT_EXECUTION>Y</DIRECT_EXECUTION>
    <PATH_FILE_HELP/>
    <OBJECT_NAME>LDC_REPORTE_LEY.PROCESSLDRREPB</OBJECT_NAME>
    <QUERY_NAME/>
    <ALLOW_SCHEDULE>Y</ALLOW_SCHEDULE>
    <ALLOW_FREQUENCY>N</ALLOW_FREQUENCY>
  </APPLICATION>
  <COMPOSITION>
    <CONFIGURATION_ID>-999999998</CONFIGURATION_ID>
    <ATTRIBUTE_NAME>DUMMY</ATTRIBUTE_NAME>
    <ENTITY_NAME>GI_PROCESS</ENTITY_NAME>
    <TYPE_ATTRIB_ID>1</TYPE_ATTRIB_ID>
    <ENTITY_TYPE_ID>3339</ENTITY_TYPE_ID>
    <EXTERNAL_TYPE_ID>500000000007622</EXTERNAL_TYPE_ID>
    <ENTITY_ID>9623</ENTITY_ID>
    <EXTERNAL_ID>500000000007622</EXTERNAL_ID>
    <FRAME_ID>-8938</FRAME_ID>
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
      <ENTITY_ATTRIBUTE_ID>9273</ENTITY_ATTRIBUTE_ID>
      <CONFIGURATION_ID>-999999997</CONFIGURATION_ID>
      <ATTRIBUTE_NAME>OBJECT_TYPE_ID</ATTRIBUTE_NAME>
      <ENTITY_ID>9019</ENTITY_ID>
      <ENTITY_NAME>GE_OBJECT_TYPE</ENTITY_NAME>
      <PARENT_CONF_ID>-999999998</PARENT_CONF_ID>
      <TYPE_ATTRIB_ID>2</TYPE_ATTRIB_ID>
      <ENTITY_TYPE_ID>3339</ENTITY_TYPE_ID>
      <EXTERNAL_TYPE_ID>500000000007622</EXTERNAL_TYPE_ID>
      <FRAME_ID>-8938</FRAME_ID>
      <DATA_LENGTH>0</DATA_LENGTH>
      <DATA_PRECISION>4</DATA_' ||
'PRECISION>
      <DATA_SCALE>0</DATA_SCALE>
      <DATA_TYPE>NUMBER</DATA_TYPE>
      <DISPLAY_VIEW>4</DISPLAY_VIEW>
      <IS_UPDATABLE>Y</IS_UPDATABLE>
      <IS_VISIBLE>Y</IS_VISIBLE>
      <REQUIRED>Y</REQUIRED>
      <DISPLAY_ORDER>0</DISPLAY_ORDER>
      <DISPLAY_NAME>Tipo de reporte</DISPLAY_NAME>
      <INIT_BASIC_EXP_ID/>
      <VALID_BASIC_EXP_ID/>
      <INIT_EXPRESSION_ID/>
      <VALID_EXPRESSION_ID/>
      <DEFAULT_VALUE/>
      <SELECT_STATEMENT>select 1 id, '||chr(38)||'apos;Reporte B1'||chr(38)||'apos; description from dual
union
select 2 id, '||chr(38)||'apos;Reporte B2'||chr(38)||'apos; description from dual</SELECT_STATEMENT>
      <SELECT_STATEMENT_ID>120089624</SELECT_STATEMENT_ID>
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
   ' ||
' <ATTRIBUTE>
      <ENTITY_ATTRIBUTE_ID>-1</ENTITY_ATTRIBUTE_ID>
      <CONFIGURATION_ID>-999999996</CONFIGURATION_ID>
      <ATTRIBUTE_NAME>NULL</ATTRIBUTE_NAME>
      <ENTITY_ID>-1</ENTITY_ID>
      <ENTITY_NAME>DUAL</ENTITY_NAME>
      <PARENT_CONF_ID>-999999998</PARENT_CONF_ID>
      <TYPE_ATTRIB_ID>2</TYPE_ATTRIB_ID>
      <ENTITY_TYPE_ID>3339</ENTITY_TYPE_ID>
      <EXTERNAL_TYPE_ID>500000000007622</EXTERNAL_TYPE_ID>
      <FRAME_ID>-8938</FRAME_ID>
      <DATA_LENGTH/>
      <DATA_PRECISION/>
      <DATA_SCALE/>
      <DATA_TYPE>NUMBER</DATA_TYPE>
      <DISPLAY_VIEW>10</DISPLAY_VIEW>
      <IS_UPDATABLE>Y</IS_UPDATABLE>
      <IS_VISIBLE>Y</IS_VISIBLE>
      <REQUIRED>N</REQUIRED>
      <DISPLAY_ORDER>1</DISPLAY_ORDER>
      <DISPLAY_NAME>Parametros de entrada</DISPLAY_NAME>
      <INIT_BASIC_EXP_ID/>
      <VALID_BASIC_EXP_ID/>
      <INIT_EXPRESSION_ID/>
      <VALID_EXPRESSION_ID/>
      <DEFAULT_VALUE/>
      <SELECT_STATEMENT/>
      <SELECT_STATEMENT_ID/>
      <TAG_NAME/' ||
'>
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
      <ENTITY_ATTRIBUTE_ID>19696</ENTITY_ATTRIBUTE_ID>
      <CONFIGURATION_ID>-999999995</CONFIGURATION_ID>
      <ATTRIBUTE_NAME>TEPFANO</ATTRIBUTE_NAME>
      <ENTITY_ID>1104</ENTITY_ID>
      <ENTITY_NAME>TEMPPEFA</ENTITY_NAME>
      <PARENT_CONF_ID>-999999998</PARENT_CONF_ID>
      <TYPE_ATTRIB_ID>2</TYPE_ATTRIB_ID>
      <ENTITY_TYPE_ID>3339</ENTITY_TYPE_ID>
      <EXTERNAL_TYPE_ID>500000000007622</EXTERNAL_TYPE_ID>
      <FRAME_ID>-8938</FRAME_ID>
      <DATA_LENGTH>0</DATA_LENGTH>
      <DATA_PRECISION>4</DATA_PRECISION>
      <DATA_SCALE>0</DATA_SCALE>
      <DATA_TYPE>NUMBER</DATA_TYPE>
      <DISPLAY_VIEW/>
      <IS_UPDATABLE>Y</IS_UPDATABLE>
     ' ||
' <IS_VISIBLE>Y</IS_VISIBLE>
      <REQUIRED>Y</REQUIRED>
      <DISPLAY_ORDER>2</DISPLAY_ORDER>
      <DISPLAY_NAME>Año</DISPLAY_NAME>
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
      <SEQUENCE_ID>4</SEQUENCE_ID>
      <EXTERNAL_ROOT_ID>6121</EXTERNAL_ROOT_ID>
      <PARENT_ATTRIBUTE_NAME/>
      <PARENT_ENTITY_NAME/>
    </ATTRIBUTE>
    <ATTRIBUTE>
      <ENTITY_ATTRIBUTE_ID>19697</ENTITY_ATTRIBUTE_ID>
      <CONFIGURATION_ID>-999999994</CONFIGURATION_ID>
      <ATTRIBUTE_NAME>TEPFMES</ATTRIBUTE_NAME>
      <ENTITY_ID>1104</ENTITY_ID>
      <ENTITY_NAME>TEMPPEFA</ENTITY_NAME>
      <PARENT_CONF_ID>-999999998</PARENT_CONF_ID>
      <TYPE_ATTRIB_ID>2</TYPE_ATTRIB_ID>
    ' ||
'  <ENTITY_TYPE_ID>3339</ENTITY_TYPE_ID>
      <EXTERNAL_TYPE_ID>500000000007622</EXTERNAL_TYPE_ID>
      <FRAME_ID>-8938</FRAME_ID>
      <DATA_LENGTH>0</DATA_LENGTH>
      <DATA_PRECISION>2</DATA_PRECISION>
      <DATA_SCALE>0</DATA_SCALE>
      <DATA_TYPE>NUMBER</DATA_TYPE>
      <DISPLAY_VIEW/>
      <IS_UPDATABLE>Y</IS_UPDATABLE>
      <IS_VISIBLE>Y</IS_VISIBLE>
      <REQUIRED>Y</REQUIRED>
      <DISPLAY_ORDER>3</DISPLAY_ORDER>
      <DISPLAY_NAME>Mes</DISPLAY_NAME>
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
      <SEQUENCE_ID>5</SEQUENCE_ID>
      <EXTERNAL_ROOT_ID>6121</EXTERNAL_ROOT_ID>
      <PARENT_ATTRIBUTE_NAME/>
      <PARENT_ENTITY_NAME/>
    </ATTRIBUTE>
  ' ||
'</COMPOSITION>
</PB>
'
;
ut_trace.trace('insertando tabla: GE_DISTRIBUTION_FILE fila (0)',1);
INSERT INTO GE_DISTRIBUTION_FILE(DISTRIBUTION_FILE_ID,APP_XML,DESCRIPTION,FILE_VERSION,VERSION_NUMBER,FILE_NAME,FILE_SOURCE,MD5_HASH,DISTRI_GROUP_ID) 
VALUES (LDRREPB_GC_.tb2_0(0),
XMLType(LDRREPB_GC_.clColumn_0),
'Generación de reportes B1 y B2'
,
'1.0.0.0'
,
3,
'LDRREPB_GC.APP'
,
null,
'a872e17d8b15715a8f626ee6a9d05c1d'
,
3);

exception when others then
LDRREPB_GC_.blProcessStatus := false;
rollback;
ut_trace.trace('**ERROR:'||sqlerrm);
raise;
END;
/
DECLARE
 nuNewStatement number; 
 
BEGIN 
 
if (not LDRREPB_GC_.blProcessStatus) then
 return;
end if;
 
  ut_trace.trace('Borrando tabla GE_STATEMENT',1);
  BEGIN
   delete from GE_STATEMENT where STATEMENT_ID = 120089624 and MODULE_ID = 61 and NAME = 'LDRREPB_sentencia1';
  EXCEPTION
  when ex.RECORD_HAVE_CHILDREN then
    ut_trace.trace('No se pudo borrar la sentencia: [120089624]',1);
   null;
  END;
ut_trace.trace('Obtiene nueva secuencia de GE_STATEMENT',1);
nuNewStatement := GE_BOSEQUENCE.NEXTGE_STATEMENT();

ut_trace.trace('insertando tabla: GE_STATEMENT ['||nuNewStatement||']',1);
INSERT INTO GE_STATEMENT(STATEMENT_ID, MODULE_ID, DESCRIPTION, STATEMENT, NAME)  
VALUES (nuNewStatement, 61, 'LDRREPB sentencia para tipo de reporte ', 
'select 1 id, '|| chr(39) ||'Reporte B1'|| chr(39) ||' description from dual
union
select 2 id, '|| chr(39) ||'Reporte B2'|| chr(39) ||' description from dual', 'LDRREPB_sentencia1'); 

ut_trace.trace('Modificando GE_DISTRIBUTION_FILE',1);
UPDATE GE_DISTRIBUTION_FILE SET  GE_DISTRIBUTION_FILE.APP_XML = 
  UPDATEXML(GE_DISTRIBUTION_FILE.APP_XML, 
  '//COMPOSITION/ATTRIBUTE[ENTITY_ATTRIBUTE_ID = 9273 and ENTITY_ID = 9019]/SELECT_STATEMENT_ID/text()', 
  to_char(nuNewStatement)) 
WHERE GE_DISTRIBUTION_FILE.DISTRIBUTION_FILE_ID = 'LDRREPB_GC';
 
 
exception when others then
LDRREPB_GC_.blProcessStatus := false;
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

if (not LDRREPB_GC_.blProcessStatus) then
 return;
end if;

ut_trace.trace('Obteniendo APP_XML de GE_DISTRIBUTION_FILE',1);
  SELECT extract(GE_DISTRIBUTION_FILE.APP_XML, '/').getClobval()
  INTO  clApplication
  FROM GE_DISTRIBUTION_FILE
  WHERE GE_DISTRIBUTION_FILE.DISTRIBUTION_FILE_ID = 'LDRREPB_GC';
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
  WHERE GE_DISTRIBUTION_FILE.DISTRIBUTION_FILE_ID = 'LDRREPB_GC';

exception when others then
LDRREPB_GC_.blProcessStatus := false;
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
 nuIndexInternal := LDRREPB_GC_.tb0_0.first;
 while nuIndexInternal IS NOT null loop
  IF (LDRREPB_GC_.tb0_0(nuIndexInternal)=isbExecutableName ) THEN
   IF (LDRREPB_GC_.tb0_1.exists(nuIndexInternal)) then
    tbExecutableEquivalence(isbExecutableName) := LDRREPB_GC_.tb0_1(nuIndexInternal);
   END IF;
   exit;
  END IF;
  nuIndexInternal := LDRREPB_GC_.tb0_0.next(nuIndexInternal);
 END loop; 
 return tbExecutableEquivalence(isbExecutableName);
END;
BEGIN

if (not LDRREPB_GC_.blProcessStatus) then
 return;
end if;
nuIndex :=  LDRREPB_GC_.tbRoleExecutables.first;
while nuIndex IS NOT null loop
 if (LDRREPB_GC_.tbRoleExecutables(nuIndex).role_id!=1) then
  nuNewExecutableId := fnuGetNewExecutableId(LDRREPB_GC_.tbRoleExecutables(nuIndex).name);
  IF nuNewExecutableId is not null then
    INSERT INTO sa_role_executables (role_id, executable_id)
    VALUES (LDRREPB_GC_.tbRoleExecutables(nuIndex).role_id, nuNewExecutableId);
  END IF;
  end if;
 nuIndex := LDRREPB_GC_.tbRoleExecutables.next(nuIndex);
END loop;
nuIndex :=  LDRREPB_GC_.tbUserException.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LDRREPB_GC_.tbUserException(nuIndex).name);
 IF nuNewExecutableId is not null then
  insert INTO sa_user_exceptions (executable_id, user_id, status, usr_exc_type_id, comment_)
  VALUES (nuNewExecutableId ,LDRREPB_GC_.tbUserException(nuIndex).user_id, LDRREPB_GC_.tbUserException(nuIndex).status , LDRREPB_GC_.tbUserException(nuIndex).usr_exc_type_id, LDRREPB_GC_.tbUserException(nuIndex).comment_);
 END IF;
 nuIndex := LDRREPB_GC_.tbUserException.next(nuIndex);
END loop;
nuIndex :=  LDRREPB_GC_.tbExecEntities.first;
while nuIndex IS NOT null loop
 nuNewExecutableId := fnuGetNewExecutableId(LDRREPB_GC_.tbExecEntities(nuIndex).name);
 IF nuNewExecutableId is not null then
  select count(1) into nuRecCount
 from sa_exec_entities
  where executable_id = nuNewExecutableId and entity_id = LDRREPB_GC_.tbExecEntities(nuIndex).entity_id;
  IF nuRecCount = 0 then
    insert INTO sa_exec_entities (executable_id, entity_id )
    VALUES (nuNewExecutableId ,LDRREPB_GC_.tbExecEntities(nuIndex).entity_id );
  END IF;
 END IF;
 nuIndex := LDRREPB_GC_.tbExecEntities.next(nuIndex);
END loop;

exception when others then
LDRREPB_GC_.blProcessStatus := false;
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
 nuIndex := LDRREPB_GC_.tbObjectToDelete.first;
 while (nuIndex is not null) LOOP
  BEGIN
   ut_trace.trace('Objeto a borrar: ' || LDRREPB_GC_.tbObjectToDelete(nuIndex),1);
   IF(ut_object.fboExistObject(LDRREPB_GC_.tbObjectToDelete(nuIndex)) and not fblIsObjectUseByRule(LDRREPB_GC_.tbObjectToDelete(nuIndex))) THEN
    blObjectDeleted := ut_object.fboDeleteObject(LDRREPB_GC_.tbObjectToDelete(nuIndex));
    ut_trace.trace('  * Borrado ' || LDRREPB_GC_.tbObjectToDelete(nuIndex), 1);
   END IF;
  EXCEPTION when others then
   ut_trace.trace('- No se borra el objeto (' || LDRREPB_GC_.tbObjectToDelete(nuIndex) || '): ' || sqlerrm,1);
  END;
  nuIndex := LDRREPB_GC_.tbObjectToDelete.next(nuIndex);
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
SA_BOCreatePackages.DropPackage('LDRREPB_GC_');
end;
/

BEGIN ut_trace.trace('********************FIN  proceso de objeto:LDRREPB_GC_******************************'); end;
/
