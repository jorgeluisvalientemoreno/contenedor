CREATE OR REPLACE TRIGGER TRG_GE_CONTRATO_AU_SAO604282
AFTER UPDATE OF valor_total_pagado ON ge_contrato
REFERENCING old as old new AS new for each row

    /*****************************************************************
    Unidad      :   TRG_GE_CONTRATO_AU_SAO604282
    Descripcion	:   Valida que el VALOR_TOTAL_PAGADO del contrato (GE_CONTRATO)
                    no disminuya

    Author:
    Parametros          Descripcion
    ============        ===================

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    04-12-2024      jreina.SAO604282    Creación
    ******************************************************************/

DECLARE

    -- Código para generar un error genérico
    cnuGeneric_Error  constant number := 2741;

    -- Aplicación
    sbApp   varchar2(4000);

    -- Modo de generar traza
    sbModoTraza   ge_parameter.value%type;
    
    -- Variables de GE_LOG_TRACE
    sbApplication   varchar2(2000);
    sbDummy         varchar2(2000);
    sbOperation     varchar2(2000);
    sbDbUser        varchar2(4000);
    sbOsUser        varchar2(4000);
    sbSessionId     varchar2(4000);
    sbTerminal      varchar2(4000);
    sbCallStack     varchar2(4000);
    sbHost          varchar2(4000);
    sbIpAddress     varchar2(4000);
    nuErrorLogId    number;
    
    -- Inserta em OPENFLTR
    PROCEDURE InsertOpenfltr (pisbMsg  in  varchar2)
    IS
        cursor cuId
        is
            select nvl (max(OPFTCONS),0) + 1
            from openfltr;

        pragma autonomous_transaction;

        nuID    number;

    BEGIN

        open   cuId;
        fetch cuId into nuID;
        close cuId;

        INSERT INTO openfltr (OPFTCONS, OPFTOBJE, OPFTFECH, OPFTDESC)
        VALUES ( nuId, 'SAO510780', to_date (to_char(sysdate, 'dd-mm-yyyy hh24:mi:ss'), 'dd-mm-yyyy hh24:mi:ss'), pisbMsg );

        commit;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when OTHERS then
            Errors.seterror;
            raise ex.CONTROLLED_ERROR;
    END  InsertOpenfltr;
    
    -- Inserta em GE_LOG_TRACE
    PROCEDURE InsertGeLogTrace (pisbMsg    in  varchar2)
    IS
    
        pragma autonomous_transaction;

    BEGIN

        BEGIN
            dbms_application_info.read_module( sbApplication, sbDummy );
        EXCEPTION
            when ex.controlled_error then
                sbApplication := 'Err al obtener App';
            when others then
                sbApplication := 'Err al obtener App';
        END;

        begin
            SELECT ora_sysevent
            INTO sbOperation
            FROM DUAL;
        EXCEPTION
            when ex.controlled_error then
                sbOperation := 'Err al obtener evento';
            when others then
                sbOperation := 'Err al obtener evento';
        END;

        begin
            sbDbUser := sys_context('USERENV','CURRENT_USER');
        EXCEPTION
            when ex.controlled_error then
                sbDbUser := 'Err al obtener usuario db';
            when others then
                sbDbUser := 'Err al obtener usuario db';
        END;

        begin
            sbOsUser := sys_context('USERENV','OS_USER');
        EXCEPTION
            when ex.controlled_error then
                sbOsUser := 'Err al obtener usuario os';
            when others then
                sbOsUser := 'Err al obtener usuario os';
        END;

        begin
            sbSessionId := sys_context('USERENV','SESSIONID');
        EXCEPTION
            when ex.controlled_error then
                sbSessionId := 'Err al obtener sesion';
            when others then
                sbSessionId := 'Err al obtener sesion';
        END;

        begin
            sbCallStack := substr(DBMS_UTILITY.FORMAT_CALL_STACK, 0,4000);
        EXCEPTION
            when ex.controlled_error then
                sbCallStack := 'Err al obtener call stack';
            when others then
                sbCallStack := 'Err al obtener call stack';
        END;

        begin
            sbHost := sys_context('USERENV','HOST');
        EXCEPTION
            when ex.controlled_error then
                sbHost := 'Err al obtener host';
            when others then
                sbHost := 'Err al obtener host';
        END;

        begin
            sbTerminal := sys_context('USERENV','TERMINAL');
        EXCEPTION
            when ex.controlled_error then
                sbTerminal := 'Err al obtener terminal';
            when others then
                sbTerminal := 'Err al obtener terminal';
        END;

        begin
            sbIpAddress := sys_context('USERENV','IP_ADDRESS');
        EXCEPTION
            when ex.controlled_error then
                sbIpAddress := 'Err al obtener ip';
            when others then
                sbIpAddress := 'Err al obtener ip';
        END;

        SELECT SEQ_GE_ERROR_LOG.NEXTVAL INTO nuErrorLogId FROM dual;

        INSERT INTO ge_error_log
        (
            ERROR_LOG_ID, MESSAGE_ID, TIME_STAMP, DB_USER, OS_USER, SESSION_ID, APPLICATION, METHOD, CALL_STACK,
            DESCRIPTION, MACHINE, TERMINAL, CLIENT_IP)
        VALUES
        (
            nuErrorLogId, -16710429, sysdate, sbDbUser, sbOsUser, sbSessionId, sbApplication, sbOperation, sbCallStack,
            pisbMsg, sbHost, sbTerminal, sbIpAddress);
            
        commit;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when OTHERS then
            Errors.seterror;
            raise ex.CONTROLLED_ERROR;
    END  InsertGeLogTrace;

BEGIN

    -- Valida si el valor_total_pagado del contrato se está disminuyendo
    if (:new.valor_total_pagado < :old.valor_total_pagado) then
    
        -- Obtiene el parámetro PE_TRAZA_VALOR_PAGADO
        sbModoTraza := dage_parameter.fsbgetvalue('PE_TRAZA_VALORPAGADO');

        -- Valida si genera error o se guarda en traza OPENFLTR
        if (sbModoTraza = 'S') then

            -- Se guarda traza en OPENFLTR
            BEGIN
                -- Obtiene aplicación
                sbApp := pkerrors.fsbgetapplication;
            EXCEPTION
                WHEN OTHERS THEN
                    sbApp := 'UNDEFINED';
            END;

            -- Registra traza
            InsertOpenfltr ('TRG_GE_CONTRATO_BU_SAO604282 - Aplicación ['||sbApp||'] Usuario ['||pkgeneralservices.fsbgetusername||'] Terminal ['||pkgeneralservices.fsbgetterminal||
                   '] VALOR TOTAL PAGADO (new) ['||:new.valor_total_pagado||'] VALOR TOTAL PAGADO (old) ['||:old.valor_total_pagado||']');
                   
            InsertGeLogTrace ('TRG_GE_CONTRATO_BU_SAO604282 - Aplicación ['||sbApp||'] Usuario ['||pkgeneralservices.fsbgetusername||'] Terminal ['||pkgeneralservices.fsbgetterminal||
                   '] VALOR TOTAL PAGADO (new) ['||:new.valor_total_pagado||'] VALOR TOTAL PAGADO (old) ['||:old.valor_total_pagado||']');
                   
            -- Genera error por pantalla
            ge_boerrors.seterrorcodeargument(cnuGeneric_Error,'VALOR TOTAL PAGADO del contrato está disminuyendo. Valor actual ['||:old.valor_total_pagado||
                                            '] Valor nuevo ['||:new.valor_total_pagado||'] (Trigger TRG_GE_CONTRATO_AU_SAO604282)');
            raise ex.CONTROLLED_ERROR;
            
        else

            -- Se guarda traza en OPENFLTR
            BEGIN
                -- Obtiene aplicación
                sbApp := pkerrors.fsbgetapplication;
            EXCEPTION
                WHEN OTHERS THEN
                    sbApp := 'UNDEFINED';
            END;
            
            -- Registra traza
            InsertOpenfltr ('TRG_GE_CONTRATO_BU_SAO604282 - Aplicación ['||sbApp||'] Usuario ['||pkgeneralservices.fsbgetusername||'] Terminal ['||pkgeneralservices.fsbgetterminal||
                   '] VALOR TOTAL PAGADO (new) ['||:new.valor_total_pagado||'] VALOR TOTAL PAGADO (old) ['||:old.valor_total_pagado||']');
                   
            InsertGeLogTrace ('TRG_GE_CONTRATO_BU_SAO604282 - Aplicación ['||sbApp||'] Usuario ['||pkgeneralservices.fsbgetusername||'] Terminal ['||pkgeneralservices.fsbgetterminal||
                   '] VALOR TOTAL PAGADO (new) ['||:new.valor_total_pagado||'] VALOR TOTAL PAGADO (old) ['||:old.valor_total_pagado||']');
            
        END if;
        
    END if;

EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise;
    when OTHERS then
        Errors.seterror;
        raise ex.CONTROLLED_ERROR;
END TRG_GE_CONTRATO_AU_SAO604282;
/
