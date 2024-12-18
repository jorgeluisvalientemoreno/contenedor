CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FNUVISUALIZAORPLO" (inuOrden in or_order.order_id%type) RETURN number IS
/*****************************************************************
    Funcion   :   LDC_fnuVisualizaORPLO
    Descripcion     :   Permite condicionar la visualizacion del proceso de "Legalizar Ordenes" en ORCAO
                        - Si la persona es interna puede visualizar el proceso
                        - Si la persona es externa, debe de estar asignada a la unidad operativa
                          de la orden para poder visualizar el proceso
    Salida         : Retorna la variable nuRetorna    1-Visualiza , 0 - No Visualiza
    Autor       : Alexandra Gordillo
    Fecha       : 30-03-2015

    Historia de Modificaciones
    Fecha       Autor             Modificacion
    =========   ========= ====================
    30-03-2015 Agordillo    REQ.239 Creación
******************************************************************/

    nuperson            ge_person.person_id%type;
    sbes_externa        or_operating_unit.es_externa%type;
    nuOrden             or_order.order_id%type;
    nuOpOrder           or_order.operating_unit_id%type;
    nuRetorna           number;
    nuTemp              number;
    nuTemp2             number := 0;
    nuTemp3             number := 0;
    nuTemp4             number := 0;
BEGIN
    ut_trace.Trace('INICIO fnuVisualizaORPLO',1);

    -- Se consulta la persona conectada al Sistema
    nuperson := ge_bopersonal.fnuGetPersonId;
    -- Se consulta la UO de la Orden
    nuOpOrder := daor_order.fnugetoperating_unit_id(inuOrden);

    ut_trace.Trace('Persona '||nuperson||' Orden '||inuOrden||' Unidad Operativa '||nuOpOrder,1);

    BEGIN

        select count(1) into nuTemp2
        from ge_person
        where person_id=nuperson
        and organizat_area_id is not null;

        select to_number(column_value) into nuTemp4
        from table(ldc_boutilities.splitstrings
        (dald_parameter.fsbgetvalue_chain('COD_AREA_ORGANIZACIONAL_EX',null),','))
        where rownum=1;

        -- Si la persona tiene area organizacional
        IF (nuTemp2 > 0 and nuTemp4 is not null) THEN

            -- Consulta si la persona conectada al sistema pertenece a una Area Organizacional Externa
            select count(1) into nuTemp3
            from ge_person
            where person_id=nuperson
            and organizat_area_id in (select to_number(column_value)
                                from table(ldc_boutilities.splitstrings
                                (dald_parameter.fsbgetvalue_chain('COD_AREA_ORGANIZACIONAL_EX',null),',')))
            and rownum=1;

            IF (nuTemp3 > 0) THEN
            -- En esta condicion no retorna por que posteriormente se valida si la UO de la orden pertence a las UO asignada a la persona
                sbes_externa := 'Y';
            ELSE
                sbes_externa := 'N';
                nuRetorna := 1;
            -- Retorna por que si es una persona interna se permite legalizar
                return nuRetorna;
            END IF;

        ELSE
        -- Si la persona no tiene area organizacional retorna, no permite legalizar la orden
            nuRetorna := 0;
            return nuRetorna;
        END IF;

    EXCEPTION
        when no_data_found then
            sbes_externa := 'Y';
        when others then
            sbes_externa := 'Y';
    END;


    IF (sbes_externa = 'Y') THEN
    -- Se consulta si la persona pertenece a la UO de la orden
        BEGIN
            select count(1) into nuTemp
            from open.or_oper_unit_persons OPEUSE
            where OPEUSE.person_id=nuperson
            and OPEUSE.operating_unit_id=nuOpOrder;
        exception
            when no_data_found then
                nuTemp := 0;
        END;

        -- Si la persona pertenece a la UT retorna
        IF (nuTemp>0) THEN
            nuRetorna := 1;
            Return nuRetorna;
        ELSE
            nuRetorna := 0;
            Return nuRetorna;
        END IF;

    END IF;

    ut_trace.Trace('Fin fnuVisualizaORPLO',1);
EXCEPTION
    when ex.CONTROLLED_ERROR then
        nuRetorna := 0;
        Return nuRetorna;
    when others then
        Errors.setError;
        nuRetorna := 0;
        Return nuRetorna;
END LDC_fnuVisualizaORPLO;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNUVISUALIZAORPLO', 'ADM_PERSON');
END;
/
