CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_BOGENERATECHARGEORDER
IS

    /***************************************************************************
    Propiedad intelectual de PETI.

    Unidad         : LDC_BOGenerateCharge
    Descripcion    : Procedimiento Personalizado para generar cargos sobre órdenes
                     autónomas (como las de persecución de cartera), las cuales no están
                     asociadas a ninguna solicitud.
                     El cargo se genera con el concepto asociado al tipo de trabajo
                     y se busca la tarifa vigente del mismo.
                     El cargo generado queda asociado a la solicitud por defecto 0 para
                     que pueda ser facturado y financiado posteriormente, si así se requiere.

    Autor          : Alejandro Cárdenas Cardona
    Fecha          : 10-11-2014

    Historia de Modificaciones
    Fecha             Autor               Modificacion
    ==========        ==================  ======================================
    10-11-2014        acardenas.NC3724    Creación.
    ****************************************************************************/

    nuOrderId       OR_order.order_id%type;
    nuTipoTraba     OR_order.task_type_id%type;
    nuCausalId      ge_causal.causal_id%type;
    nuCausalClas    ge_causal.class_causal_id%type;
    nuCausalType    ge_causal.causal_type_id%type;
    nuConcept       concepto.conccodi%type;
    nuProductId     servsusc.sesunuse%type;
    rcProducto      servsusc%rowtype;
    rcOrderAct      or_order_activity%rowtype;
    nuContrato      suscripc.susccodi%type;
    idtFecha        date;
    inuTipoComp     tipocons.tconcodi%type;
    inuClasServ     compsesu.cmssclse%type;
    rcPackage       damo_packages.stymo_packages;
    rcMotive        damo_motive.stymo_motive;
    nuMotive        mo_motive.motive_id%type;
    nuDefaultPack   mo_packages.package_id%type;
    isbTarifaPerson varchar2(10000);
    inuFOT          number;
    nuValorTarifa   number;
    sbMessage       varchar2(10000);
    nuErrorCode     number;

    /* Obtiene la información necesaria para realizar la busqueda de la tarifa vigente */

    PROCEDURE ObtInfoTarifas
    IS
        -- CURSOR para obtener registro de Actividad de órden
        CURSOR  cuOrderActivity(nuOrderId OR_order.order_id%type)
        IS
            SELECT  *
            FROM    OR_order_activity
            WHERE   order_id = nuOrderId
                    AND product_id IS not null
                    AND rownum = 1;
    BEGIN

        ut_trace.trace('Inicio INICIO LDC_BOGenerateCharge.ObtInfoTarifas', 11);

        -- Obtiene el registro en Actividad de ÿrdenes
        open  cuOrderActivity(nuOrderId);
        fetch cuOrderActivity INTO rcOrderAct;
        close cuOrderActivity;

        -- Obtiene el producto asociado a la actividad de órden
        nuProductId := rcOrderAct.product_id;
        rcProducto  := pktblservsusc.frcgetrecord(nuProductId);

        -- Obtiene el contrato asociado al producto
        nuContrato  := pktblservsusc.fnugetsesususc(nuProductId);

        -- Asigna datos por defecto
        inuFOT          := 1;
        inuTipoComp     := -1;
        inuClasServ     := -1;
        idtFecha        := sysdate;
        isbTarifaPerson := 'N';

        ut_trace.trace('Producto: '||nuProductId, 12);
        ut_trace.trace('Contrato: '||nuContrato, 12);
        ut_trace.trace('FOT: '||inuFOT, 12);
        ut_trace.trace('Fecha: '||idtFecha, 12);

        ut_trace.trace('FIN LDC_BOGenerateCharge.ObtInfoTarifas', 11);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;

        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;

    END ObtInfoTarifas;


BEGIN
    ut_trace.trace('INICIO LDC_BOGenerateCharge', 9);

    -- Obtener el identificador de la orden  que se encuentra en la instancia
    nuOrderId   :=  or_bolegalizeorder.fnuGetCurrentOrder;

    -- Obtener causal de legalización
    nuCausalId  :=  or_boorder.fnugetordercausal(nuOrderId);

    -- Obtiene clase y tipo de causal
    nuCausalClas := dage_causal.fnugetclass_causal_id(nuCausalId);
    nuCausalType := dage_causal.fnugetcausal_type_id(nuCausalId);

    ut_trace.trace('Orden: '||nuOrderId, 10);
    ut_trace.trace('Causal: '||nuCausalId, 10);
    ut_trace.trace('Clase de Causal: '||nuCausalClas, 10);
    ut_trace.trace('Tipo de Causal: '||nuCausalType, 10);

    -- Si la clase de causal es "Éxito" y el tipo diferente a "Anulación"
    -- se realiza el cobro al usuario.

    if nuCausalClas = 1 AND nuCausalType <> 18 then

        -- Obtiene el código del concepto asociado al tipo de trabajo
        nuTipoTraba := daor_order.fnugettask_type_id(nuOrderId);
        nuConcept   := daor_task_type.fnugetconcept(nuTipoTraba);

        ut_trace.trace('Tipo de Trabajo: '||nuTipoTraba, 10);
        ut_trace.trace('Concepto: '||nuConcept, 10);

        -- Si el concepto no es válido o no existe, levanta error
        if nuConcept IS null OR nuConcept < 0 OR not(pktblconcepto.fblexist(nuConcept)) then
            sbMessage := 'El concepto ['||nuConcept||'] asociado al tipo de trabajo a legalizar no es válido';
            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, sbMessage);
      		raise ex.CONTROLLED_ERROR;
        END if;

        -- Obtiene los datos necesarios para buscar la tarifa
        ObtInfoTarifas;

        -- Realiza la búsqueda de la tarifa
        nuValorTarifa := FA_BOServiciosLiqTarifarios.fnuObtValorTarifaValorFijo
                        (
                            rcProducto,
                            nuContrato,
                            nuConcept,
                            null,
                            idtFecha,
                            idtFecha,
                            inuTipoComp,
                            inuClasServ,
                            isbTarifaPerson,
                            inuFOT,
                            null
                        );

        ut_trace.trace('Valor de la tarifa recuperada: '||nuValorTarifa, 10);

        -- Genera el cargo por el valor de la tarifa recuperada
        ut_trace.trace('------ Generación del Cargo ------ ', 10);

        os_chargetobill
        (
            nuProductId,
            nuConcept,
            null,
            41,     -- Causa de Cargo Orden de Trabajo
            nuValorTarifa,
            'PP-0', -- Se asocia al cargo a una solicitud por defecto 0
            null,
            nuErrorCode,
            sbMessage
        );

        if nuErrorCode > 0 then
            ge_boerrors.seterrorcodeargument(nuErrorCode, sbMessage);
      		raise ex.CONTROLLED_ERROR;
        END if;

        ut_trace.trace('Cargo generado: '||nuValorTarifa, 10);

        -- Para facturar y financiar es necesario que la órden esté asociada a
        -- una solicitud. Se utiliza la solicitud por defecto 0

        nuDefaultPack := 0;

        -- Actualiza datos del motivo
        damo_motive.updproduct_id(nuDefaultPack,nuProductId);
        damo_motive.updsubscription_id(nuDefaultPack,nuContrato);
        damo_motive.updpackage_id(nuDefaultPack,nuDefaultPack);
        damo_motive.updcust_care_reques_num(nuDefaultPack,nuDefaultPack);

        ut_trace.trace('Actividad de ÿrden ['||rcOrderAct.order_activity_id||']', 10);
        ut_trace.trace('Asociando solicitud por defecto.... ['||nuDefaultPack||']', 10);

        -- Desasocia la solicitud por defecto a las demás órdenes
        UPDATE  or_order_activity
        SET     PACKAGE_id = null
        WHERE   PACKAGE_id = nuDefaultPack;

        -- Asocia la solicitud por defecto a la actividad de órden actual
        daor_order_activity.updpackage_id(rcOrderAct.order_activity_id,nuDefaultPack);

    END if;

    ut_trace.trace('FIN LDC_BOGenerateCharge', 9);

EXCEPTION

    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;

    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;

END LDC_BOGENERATECHARGEORDER;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_BOGENERATECHARGEORDER', 'ADM_PERSON');
END;
/
