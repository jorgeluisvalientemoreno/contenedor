/******************************************************************
Propiedad intelectual de Open International Systems Copyright 2001
Archivo     insGR_CONFIG_EXPRESSION_<AAAAMMDD>.sql
Autor       <Nombre autor>
Fecha       <AAAAMMDD>

Descripci¿n
Observaciones

Historia de Modificaciones
Fecha         Autor               Modificaci¿n
<AAAAMMDD>  <Nombre Autor>              Creaci¿n
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
    nuExiste    NUMBER;
BEGIN

    dbms_output.put_line('Inicia Proceso '||sysdate);
    IdConfExpre := 121405063;

    SELECT COUNT(1)
    INTO nuExiste
    FROM open.gr_config_expression c
    where c.config_expression_id = IdConfExpre;

    IF  nuExiste = 0 THEN

            dbms_output.put_line('Insertando Regla: '||IdConfExpre);

            INSERT INTO GR_CONFIG_EXPRESSION
            (config_expression_id,configura_type_id,expression,author,creation_date,generation_date,last_modifi_date,status,
            used_other_expresion,modification_type,password,execution_type,description,object_name,object_type,code)
            VALUES
            (
        IdConfExpre,1,'nuSolicitud = MO_BOINSTANCE_DB.FNUGETPACKIDINSTANCE()','OPEN', to_date ('15/08/24','DD/MM/YYYY HH24:MI:SS'),to_date ('15/08/24','DD/MM/YYYY HH24:MI:SS'),to_date ('15/08/24','DD/MM/YYYY HH24:MI:SS'),'G','N','PU','','DS','Obtener numero de solicitud','GE_EXEACTION_CT1E'||IdConfExpre||'','PP','CREATE OR REPLACE PROCEDURE GE_EXEACTION_CT1E"||IdConfExpre||"(errorNumber OUT NUMBER, errorMessage OUT VARCHAR2)
        IS
        -- Generated by Code Generator (PVCS Version 1.5)
        -- Open Systems Ltd, Copyright 2003.
        V0 NUMBER;
        nuSolicitud NUMBER;

        BEGIN
        V0:=MO_BOINSTANCE_DB.FNUGETPACKIDINSTANCE;
        nuSolicitud:=V0;
        errorNumber := 0;
        errorMessage:= NULL;
        EXCEPTION
            WHEN ex.CONTROLLED_ERROR then
            errors.getError(errorNumber, errorMessage);
            WHEN OTHERS THEN
            errors.setError;
            errors.getError(errorNumber, errorMessage);
        END;
        '
        );

            dbms_output.put_line('Regenerando Regla: '||IdConfExpre);
            
            -- Recorre la regla insertada para regenerarla
            for reg in cuData(IdConfExpre) loop
            BEGIN

                GR_BOINTERFACE_BODY.GenerateRule (reg.expression, reg.configura_type_id,
                                    reg.description, reg.config_expression_id, onuExprId, reg.object_type);
                GR_BOINTERFACE_BODY.CreateStprByConfExpreId(onuExprId);
                dbms_output.put_line('Expresion Generada = '||onuExprId);

                nuProc := nuProc + 1;

                EXCEPTION
                    when ex.CONTROLLED_ERROR then
                        nuCountErr := nuCountErr + 1;
                        Errors.getError(nuErrorCode,sbErrorMsg);
                        dbms_output.put_line(substr('ExprId = '||reg.config_expression_id||', Err : '||nuErrorCode||', '||sbErrorMsg,1,250));

                    when others then
                        nuCountErr := nuCountErr + 1;
                        Errors.setError;
                                Errors.getError(nuErrorCode,sbErrorMsg);
                        dbms_output.put_line(substr('ExprId = '||reg.config_expression_id||', Err : '||nuErrorCode||', '||sbErrorMsg,1,250));

            END;

            END loop;
            dbms_output.put_line('Termina regenerar Regla: '||IdConfExpre);

            --<INSERT_TABLA> o <UPDATE_TABLA>

            commit;

            dbms_output.put_line('Fin Proceso '||sysdate);
    ELSE
            dbms_output.put_line('La regla ya existe.');
    END IF;
EXCEPTION
    when ex.CONTROLLED_ERROR  then
        rollback;
        Errors.getError(nuErrorCode, sbErrorMsg);
        dbms_output.put_line('ERROR CONTROLLED ');
        dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
        dbms_output.put_line('error osbErrorMess: '||sbErrorMsg);

    when OTHERS then
        rollback;
        Errors.setError;
        Errors.getError(nuErrorCode, sbErrorMsg);
        dbms_output.put_line('ERROR OTHERS ');
        dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
        dbms_output.put_line('error osbErrorMess: '||sbErrorMsg);
END;
/