--set serveroutput on;
DECLARE
    nuErrorCode NUMBER;
    sbErrorMessage VARCHAR2(4000);
    sql_ins VARCHAR2(32000):=NULL;
    sbVariable varchar2(15);
    nuConfExpreId gr_config_expression.config_expression_id%type;
    sbObjectName varchar2(100);
    sbCode varchar2(4000);
    fileMgr         utl_file.file_type;
    sbentrega          clob;
    CURSOR cuGetConfExpre
    (
        inuConfExpreID IN gr_config_expression.config_expression_id%type
    )
    IS
        SELECT rowid,a.* FROM gr_config_expression a
        WHERE config_expression_id in (inuConfExpreID);

    
    sql_ins2 VARCHAR2(32000);
    sql_ins3  VARCHAR2(32000):=NULL;
    tbstring ut_string.tytb_string;
	sbentrega_1 VARCHAR2(8000);
	sbentrega_2 VARCHAR2(8000);
BEGIN

    nuConfExpreId := &id_regla;

    sbVariable := 'IdConfExpre';

    for rcGetConfExpre in cuGetConfExpre(nuConfExpreId) loop


        sbObjectName := replace(rcGetConfExpre.OBJECT_NAME, nuConfExpreId, '''||'||sbVariable||'||''');
        sbCode := replace(rcGetConfExpre.CODE, nuConfExpreId, '''||'||sbVariable||'||''');
        sbcode:=replace(sbcode,'''','"');
        sql_ins := sbVariable||','||
        rcGetConfExpre.CONFIGURA_TYPE_ID||',''';

        sql_ins2:=rcGetConfExpre.EXPRESSION||''',''';

        sql_ins3:=
        rcGetConfExpre.AUTHOR||''', to_date ('''||
        rcGetConfExpre.CREATION_DATE||''',''DD/MM/YYYY HH24:MI:SS''),to_date ('''||
        rcGetConfExpre.GENERATION_DATE||''',''DD/MM/YYYY HH24:MI:SS''),to_date ('''||
        rcGetConfExpre.LAST_MODIFI_DATE||''',''DD/MM/YYYY HH24:MI:SS''),'''||
        rcGetConfExpre.STATUS||''','''||
        rcGetConfExpre.USED_OTHER_EXPRESION||''','''||
        rcGetConfExpre.MODIFICATION_TYPE||''','''||
        rcGetConfExpre.PASSWORD||''','''||
        rcGetConfExpre.EXECUTION_TYPE||''','''||
        rcGetConfExpre.DESCRIPTION||''','''||
        sbObjectName||''','''||
        rcGetConfExpre.OBJECT_TYPE||''',''';

    fileMgr := utl_file.fopen('/smartfiles','GeneraRegla_'||nuConfExpreId||'.sql','w');

    ut_string.extstring(sql_ins2,',',tbstring);

	
sbentrega_1:='/******************************************************************
Propiedad intelectual de Open International Systems Copyright 2001
Archivo     insGR_CONFIG_EXPRESSION_<AAAAMMDD>.sql
Autor       <Nombre autor>
Fecha       <AAAAMMDD>

Descripci�n
Observaciones

Historia de Modificaciones
Fecha         Autor               Modificaci�n
<AAAAMMDD>  <Nombre Autor>              Creaci�n
******************************************************************/
declare
    CURSOR cuData(nuIdConfExpre in gr_config_expression.config_expression_id%type) is
    -- Se obtiene la lista de expresiones a regenerar
    SELECT rowid,config_expression_id, configura_type_id, object_name, expression, object_type,
           description, status
    FROM gr_config_expression
    WHERE config_expression_id in (nuIdConfExpre);

    onuExprId gr_config_expression.config_expression_id%type := NULL;

    nuCountErr number := 0;
    nuProc number := 0;
    nuErrorCode          NUMBER(15);
    sbErrorMsg           VARCHAR2(2000);

    IdConfExpre GR_CONFIG_EXPRESSION.config_expression_id%type;
BEGIN

    dbms_output.put_line(''Inicia Proceso ''||sysdate);
    IdConfExpre := '|| nuConfExpreId ||';

    dbms_output.put_line(''Insertando Regla: ''||IdConfExpre);

    INSERT INTO GR_CONFIG_EXPRESSION
    (config_expression_id,configura_type_id,expression,author,creation_date,generation_date,last_modifi_date,status,
    used_other_expresion,modification_type,password,execution_type,description,object_name,object_type,code)
    VALUES
    (';

    sbentrega_2:=');

    dbms_output.put_line(''Regenerando Regla: ''||IdConfExpre);

    -- Recorre la regla insertada para regenerarla
    for reg in cuData(IdConfExpre) loop
    BEGIN

        GR_BOINTERFACE_BODY.GenerateRule (reg.expression, reg.configura_type_id,
                            reg.description, reg.config_expression_id, onuExprId, reg.object_type);
        GR_BOINTERFACE_BODY.CreateStprByConfExpreId(onuExprId);
        dbms_output.put_line(''Expresion Generada = ''||onuExprId);

        nuProc := nuProc + 1;

        EXCEPTION
            when ex.CONTROLLED_ERROR then
                 nuCountErr := nuCountErr + 1;
                 Errors.getError(nuErrorCode,sbErrorMsg);
                 dbms_output.put_line(substr(''ExprId = ''||reg.config_expression_id||'', Err : ''||nuErrorCode||'', ''||sbErrorMsg,1,250));

            when others then
                 nuCountErr := nuCountErr + 1;
                 Errors.setError;
                        Errors.getError(nuErrorCode,sbErrorMsg);
                 dbms_output.put_line(substr(''ExprId = ''||reg.config_expression_id||'', Err : ''||nuErrorCode||'', ''||sbErrorMsg,1,250));

    END;

    END loop;
    dbms_output.put_line(''Termina regenerar Regla: ''||IdConfExpre);

    --<INSERT_TABLA> o <UPDATE_TABLA>

    commit;

    dbms_output.put_line(''Fin Proceso ''||sysdate);
EXCEPTION
    when ex.CONTROLLED_ERROR  then
        rollback;
        Errors.getError(nuErrorCode, sbErrorMsg);
        dbms_output.put_line(''ERROR CONTROLLED '');
        dbms_output.put_line(''error onuErrorCode: ''||nuErrorCode);
        dbms_output.put_line(''error osbErrorMess: ''||sbErrorMsg);

    when OTHERS then
        rollback;
        Errors.setError;
        Errors.getError(nuErrorCode, sbErrorMsg);
        dbms_output.put_line(''ERROR OTHERS '');
        dbms_output.put_line(''error onuErrorCode: ''||nuErrorCode);
        dbms_output.put_line(''error osbErrorMess: ''||sbErrorMsg);
END;';	
	
	

    utl_file.put_line(fileMgr,sbentrega_1, TRUE);
    utl_file.put(fileMgr,sql_ins);

    FOR i IN 1..tbstring.count
    LOOP
          if i<> tbstring.count then
            if (i= tbstring.first) then
              utl_file.put(fileMgr,tbstring(i)||',');
            else
              if i<> (tbstring.count-1) then
                utl_file.put(fileMgr,tbstring(i)||','||'''||'||chr(10)||'''');

              else
                utl_file.put(fileMgr,tbstring(i)||',');
              END if;
            END if;
          else
            utl_file.put(fileMgr,tbstring(i));
          END if;
    END LOOP;

    utl_file.put(fileMgr,sql_ins3);
    utl_file.put_line(fileMgr,sbCode||'''');
    utl_file.put_line(fileMgr,sbentrega_2, TRUE);
    utl_file.put_line(fileMgr,'/', TRUE);
    utl_file.fclose(fileMgr);

    END loop;

EXCEPTION
    when ex.CONTROLLED_ERROR  then
        Errors.getError(nuErrorCode, sbErrorMessage);
        dbms_output.put_line('ERROR CONTROLLED ');
        dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
        dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);

    when OTHERS then
        Errors.setError;
        Errors.getError(nuErrorCode, sbErrorMessage);
        dbms_output.put_line('ERROR OTHERS ');
        dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
        dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);
END;
/
