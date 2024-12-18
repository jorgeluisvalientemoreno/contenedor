CREATE OR REPLACE TRIGGER ADM_PERSON.TRGAU_OR_ORDER
    /**********************************************************************
    PROPIEDAD INTELECTUAL DE ARQUITESOFT  (C) 2014
    Nombre              TRGAU_OR_ORDER
    Autor               Paula Andrea García Rendón
    Fecha               22/11/2014

    Descripción         Trigger para actualizar la propiedad del ítem seriado
                        cuando se realiza un cambio de medidor.
                        NC 3857
    Parametros
    Nombre              Descripción

    Historia de Modificaciones
    Fecha             Autor
    22/11/2014        paulaag
    Creación
    ***********************************************************************/
after update ON  or_order
FOR EACH ROW
DECLARE

	-- Mensaje de error
    OSBERRORMESSAGE GE_ERROR_LOG.DESCRIPTION%TYPE;
	-- Codigo de error
    ONUERRORCODE    GE_ERROR_LOG.ERROR_LOG_ID%TYPE;

    cnuCAMBIOMEDIDORPAMM constant number := 10534;  -- or_task_type
    cnuCAUSALCUMPLE      constant number := 1;   -- ge_causal_type

    nuSeriadoIn     number;
    nuSeriadoOut    number;

BEGIN
--{
    /*
    ut_trace.init;
    ut_trace.setlevel(99);
    ut_trace.setoutput(ut_trace.fntrace_output_db);
    */

    --pkgeneralservices.settracedataon('DB','TRGAU_OR_ORDER');
    --pkgeneralservices.tracedata('TRGAU_OR_ORDER:'||:new.order_id );

    --Valida que la orden es de tipo 10534 - Cambio de medidor PAMM
    if :new.task_type_id = cnuCAMBIOMEDIDORPAMM then
        --pkgeneralservices.tracedata('nutask_type_id:'||:new.task_type_id);

        -- SI true, entonces valide si la causal de legalización es de tipo 9694 - Cumplida
        --pkgeneralservices.tracedata('dage_causal.fnugetcausal_type_id(nucausal_id):'||dage_causal.fnugetcausal_type_id(:new.causal_id));
        if dage_causal.fnugetcausal_type_id(:new.causal_id) = cnuCAUSALCUMPLE then
            -- Si es de tipo cumplida, entonces actualice la propiedad del medidor.

            -- Seriado que entra
            select serial_items_id
                    into nuSeriadoIn
            from or_order_items
            where order_id = :new.order_id
            and serial_items_id is not null
            and out_ = 'N';

            -- Seriado que sale
            select serial_items_id
                    into nuSeriadoOut
            from or_order_items
            where order_id = :new.order_id
            and serial_items_id is not null
            and out_ = 'Y';

            --pkgeneralservices.tracedata('nuSeriadoIn:'||nuSeriadoIn);

            if nuSeriadoIn is not null then
                UpdPropiedadSeriado(nuSeriadoIn);
            end if;

            --pkgeneralservices.tracedata('nuSeriadoOut:'||nuSeriadoOut);

            if nuSeriadoOut is not null then
                UpdPropiedadSeriado(nuSeriadoOut);
            end if;

        end if;
    end if;

    --ut_trace.trace('-- PASO 1. FIN EJECUCION TRGAU_OR_ORDER', 15);
    --pkgeneralservices.tracedata('-- PASO 1. FIN EJECUCION TRGAU_OR_ORDER');
    pkErrors.Pop;

EXCEPTION
    when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        Errors.getError(ONUERRORCODE, OSBERRORMESSAGE);
    when others then
        Errors.setError;
        Errors.getError(ONUERRORCODE, OSBERRORMESSAGE);
--}
END;
/
