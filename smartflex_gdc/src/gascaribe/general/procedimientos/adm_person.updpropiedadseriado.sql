create or replace procedure ADM_PERSON.UPDPROPIEDADSERIADO(inuSeriadoId in number)
/**********************************************************************
    PROPIEDAD INTELECTUAL DE ARQUITESOFT  (C) 2014
    Nombre              UpdPropiedadSeriado
    Autor               Paula García
    Fecha               22/11/2014

    Descripción         Procedimiento que actualiza el campo de propiedad del cliente a partir del seriado.
                        Se utiliza en el trigger TRGBU GE_ITEMS_SERIADO
    Parametros
    Nombre              Descripción
    inuSeriadoId        :old id_items_seriado

    Historia de Modificaciones
    Fecha             Autor
    22/11/2014          paulaag [NC 3857]   Creación
    16/01/2015        Mmejia.ARA5954        Modificacion
***********************************************************************/
is
    nuErrorCode NUMBER;
    sbErrorMessage VARCHAR2(4000);

    rcGe_items_seriado dage_items_seriado.styge_items_seriado;
    blActualiza boolean := FALSE;

BEGIN
    /*
    errors.Initialize;
    ut_trace.Init;
    ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
    ut_trace.SetLevel(0);
    */
    ut_trace.Trace('INICIO');

    --Mmejia
    --ARA5954
    --Se desactiva la traza
    --pkgeneralservices.settracedataon('DB','TRGBUGE_ITEMS_SERIADO1');
    --pkgeneralservices.tracedata('INICIO en UpdPropiedadSeriado TRGBUGE_ITEMS_SERIADO1');
    --pkgeneralservices.tracedata('INICIO en UpdPropiedadSeriado inuSeriadoId:'||inuSeriadoId);


    if inuSeriadoId is not null then
       -- Obtiene el record
        rcGe_items_seriado := dage_items_seriado.frcgetrecord(inuSeriadoId);

        pkgeneralservices.tracedata('INICIO en UpdPropiedadSeriado rcGe_items_seriado.propiedad:'||rcGe_items_seriado.propiedad);
        pkgeneralservices.tracedata('INICIO en UpdPropiedadSeriado rcGe_items_seriado.SUBSCRIBER_ID:'||rcGe_items_seriado.SUBSCRIBER_ID);
        pkgeneralservices.tracedata('INICIO en UpdPropiedadSeriado rcGe_items_seriado.operating_unit_id:'||rcGe_items_seriado.operating_unit_id);

        -- Cuando el ítem esta en el inventario de una unidad operativa de la empresa,
        -- propiedad es empresa y se realiza el cambio de medidor, este medidor pasa al usuario
        -- y la propiedad sigue quedando en empresa en vez de cliente.
        if ((rcGe_items_seriado.propiedad = 'E') and (rcGe_items_seriado.SUBSCRIBER_ID is not null)) then
            rcGe_items_seriado.propiedad := 'C';
            blActualiza := TRUE;
        end if;

        -- Cuando el ítem esta en el inventario de una unidad operativa contratista,
        -- propiedad es tercero y se realiza el cambio de medidor, este medidor pasa al usuario
        -- y la propiedad sigue quedando en tercero en vez de cliente.
        if ((rcGe_items_seriado.propiedad = 'T') and (rcGe_items_seriado.SUBSCRIBER_ID is not null)) then
            rcGe_items_seriado.propiedad := 'C';
            blActualiza := TRUE;
        end if;

        -- Cuando el ítem esta en el usuario, propiedad cliente
        -- y se realiza el cambio de medidor, este medidor pasa al contratista y
        -- la propiedad es empresa en vez de tercero.
        if ((rcGe_items_seriado.propiedad = 'C') and (rcGe_items_seriado.operating_unit_id is not null)) then
            -- Valida si la unidad operativa que tiene el seriado, es un contratista
            if  daor_operating_unit.fnugetoper_unit_classif_id(rcGe_items_seriado.operating_unit_id) = 2 then
                -- Si lo tiene un contratista, la propiedad es del Tercero
                rcGe_items_seriado.propiedad := 'T';
                blActualiza := TRUE;
            end if;
        end if;

        -- Si la unidad operativa tiene clasificacion de Empresa
        if  (rcGe_items_seriado.operating_unit_id is not null) then
            if daor_operating_unit.fnugetoper_unit_classif_id(rcGe_items_seriado.operating_unit_id) = 1 then
                rcGe_items_seriado.propiedad := 'E';
                blActualiza := TRUE;
            end if;
        end if;

        if blActualiza then
            -- Actualizar la propiedad
            dage_items_seriado.updrecord(rcGe_items_seriado);
            blActualiza := false;
            commit;
        end if;
    end if;

    dbms_output.put_line('SALIDA onuErrorCode: '||nuErrorCode);
    dbms_output.put_line('SALIDA osbErrorMess: '||sbErrorMessage);

    pkErrors.Pop;

EXCEPTION
    when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
        Errors.getError(nuErrorCode, sbErrorMessage);
    when others then
        Errors.setError;
        Errors.getError(nuErrorCode, sbErrorMessage);
END UPDPROPIEDADSERIADO;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('UPDPROPIEDADSERIADO', 'ADM_PERSON');
END;
/
