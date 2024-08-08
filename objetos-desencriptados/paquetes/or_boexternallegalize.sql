CREATE OR REPLACE PACKAGE BODY OPEN.OR_BOExternalLegalize IS
/*****************************************************************
Propiedad intelectual de Open International Systems (c).

Unidad         : OR_BOExternalLegalize
Descripcion    :
Autor          : jbecerra
Fecha          : 04-Ago-2008

Historia de Modificaciones
Fecha       Autor               Modificacion
=========   =========           ====================
11-09-2014  FSaldana.SAO273724  Se modifica <<ProcessExternalData>>
11-04-2014  AEcheverry.SAO237524    Se modifica <<ProcessExternalData>>
04-06-2013  gcabezas.SAO208772  Se modifica «ProcessExternalData»
25-01-2013  jsflorez.SAO198497  Se crean los metodos:
                                    «SetDamageData»
                                    «GetDamageData»
                                    «ProcessDamageData»
                                    «fboRegenerateAct»
                                Se modifica «ProcessExternalData»
07-09-2012  RGamboa.SAO189700   Se elimina "fblRegenerateActivities" y se modifica
                                "ProcessExternalData".
18-07-2012  GPaz.SAO181853      Se eliminan los metodos:
                                                        «SetDamageData»
                                                        «GetDamageData»
                                                        «ProcessDamageData»
                                Se modifica «ProcessExternalData»
27-03-202   cenaviaSAO178134    Estabilización.
            cenaviaSAO178070    Se modifica el método «ProcessExternalData»
02-08-2011  Marteaga.SAO158136  se modifica «fblRegenerateActivities».
29-08-2011  RGamboa.SAO157054   Se modifica "ProcessExternalData".
16-08-2011  MArteaga.SAO156505  Se modifica «ProcessDamageData».
14-07-2011  MArteaga.SAO153780  Se agregan los metodos: «SetDamageData»
                                                        «GetDamageData»
                                                        «ProcessDamageData»
                                                        «fblRegenerateActivities».
                                Se modifica el metodo «ProcessExternalData».
22-07-2011  RGamboa.SAO151667   Se modifica "ProcessExternalData".
11-06-2011  RGamboa.SAO151670   Se modifica "ProcessExternalData".
10-02-2011  gpazSAO139986       Se modifica <<ProcessExternalData>>
26-May-2010 AEcheverrySAO118590 Se modifica el metodo
                                    <<ProcessExternalData>>
10-05-2010  cjaramillOSAO116866 Se modifica ProcessExternalData para que al final
                                intente asociar la orden a un acta.
25-abr-2010 sagudeloSAO115861   Se modifica ProcessExternalData
01-abr-2009 cburbanoSAO110258   Se modifica ProcessExternalData
22-Oct-2009 MArteagaSAO106035   Se modifica ProcessExternalData
13-Oct-2009 jssanchezSAO105192  Se modifica ProcessExternalData
25-Sep-2009 jssanchezSAO96431   Se modifica ProcessExternalData
02-Jul-2009 yclavijo SAO96649   Se modifica el método ProcessExternalData para
                               pasar la solucion hecha en el sao96330
07-nov-2008 obedoyaSAO84138    Se modifica ProcessExternalData
04-Sep-2008 jhramirezSAO81347  Se modifica el procedimiento ProcessExternalData
01-Sep-2008 vrecaldeSAO79776     Se modifica el metodo ProcessExternalData
21-ago-2008 avillegasSAO79223    Se modifica el metodo ProcessExternalData
19-ago-2008 obedoyaSAO78725   Se modifica el metodo ProcessExternalData
04-Ago-2008 jbecerraSAO79828  Creacion
******************************************************************/

	-- Declaracion de variables y tipos globales privados del paquete
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO273724';

    -- La orden ha sido modificada, ya no podrá realizar la atención automática del daño.
    cnuNoAvaliableToAttend      CONSTANT NUMBER := 8283;

    gnuOrderId                  or_order_activity.order_id%type;
    gnuPackageId                tt_damage.package_id%type;
    gdtInitialDate              tt_damage.initial_date%type;
    gdtAttentionDate            mo_packages.attention_date%type;

    -- Causales que provocan anulacion de la orden
    cnuANNUL_CAUSAL_TYPE constant NUMBER := 18;

    -- Definicion de metodos publicos y privados del paquete

    --Causales que probocan anulacion de la ORDEN, ge_causal
    cnuCausalAnullSuspen    constant  number    := 260;     --Cliente Mostro Factura
    cnuCausalAnullAtent     constant  number    := 460;     --Fallo de Atención -  Reversa Pago

    ----------------------------------------------------------------------------
	-- Definicion de metodos privados del paquete
    ----------------------------------------------------------------------------

    --  retorna  la versión del SAO
    FUNCTION fsbVersion  return varchar2 IS
    BEGIN
        return csbVersion;
    END;

    /*****************************************************************
    Unidad   :      fboRegenerateAct
    Descripcion	:   Valida si una actividad de daños se regenera.
    ******************************************************************/
    FUNCTION fboRegenerateAct
    (
        inuOrderId      in  OR_order.order_id%type,
        inuPackageId    in  or_order_activity.package_id%type
    )
    return boolean
    IS

        nuProcessDamage or_order_activity.process_id%type := TT_BOCreateActivity.fnuPROCESS_DAMAGE;

        CURSOR cuRegenerateActivities
            IS
            SELECT  /*+ index(OriginActivity IDX_OR_ORDER_ACTIVITY_06 )
                        index(RegenActivity IDX_OR_ORDER_ACTIVITY_03 ) */
                    1
            FROM    or_order_activity OriginActivity,
                    or_order_activity RegenActivity
                    /*+ OR_BOExternalLegalize.fboRegenerateAct */
            WHERE   RegenActivity.origin_activity_id = OriginActivity.order_activity_id
            AND     RegenActivity.status <> 'F'
            AND     OriginActivity.process_id = nuProcessDamage
            AND     OriginActivity.package_id = inuPackageId
            AND     OriginActivity.order_id = inuOrderId
            AND     rownum = 1;

    BEGIN
        ut_trace.trace('Inicia OR_BOExternalLegalize.fboRegenerateAct',15);

        for rcRow in cuRegenerateActivities loop
            return TRUE;
        end loop;

        ut_trace.trace('Finaliza OR_BOExternalLegalize.fboRegenerateAct',15);
        return FALSE;

    EXCEPTION
        when ex.CONTROLLED_ERROR THEN
            ut_trace.trace('Error : ex.CONTROLLED_ERROR',15);
            raise;

        when others THEN
            ut_trace.trace('Error : others',15);
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fboRegenerateAct;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  GetDamageData
    Descripcion :  Obtiene los datos para la atención de daños

    Autor       :  Juan Sebastian Florez (jsflorez)
    Fecha       :  25-01-2013

    Historia de Modificaciones
    Fecha        Autor              Modificación
    =========    =========          ====================
    25-01-2013   jsflorez.SAO198497 Creación.
    ***************************************************************/
    PROCEDURE GetDamageData
    (
        onuOrderId              out or_order_activity.order_id%type,
        onuPackageId            out or_order_activity.package_id%type,
        odtInitialDate          out pr_timeout_component.initial_date%type,
        odtFinalDate            out pr_timeout_component.final_date%type
    )
    IS

    BEGIN
        ut_trace.trace('Inicia OR_BOExternalLegalize.GetDamageData',15);

        onuOrderId              := gnuOrderId;
        onuPackageId            := gnuPackageId;
        odtInitialDate          := gdtInitialDate;
        odtFinalDate            := gdtAttentionDate;

        ut_trace.trace('Finaliza OR_BOExternalLegalize.GetDamageData',15);
    EXCEPTION
        when ex.CONTROLLED_ERROR THEN
            ut_trace.trace('Error : ex.CONTROLLED_ERROR',15);
            raise;

        when others THEN
            ut_trace.trace('Error : others',15);
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END GetDamageData;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  SetDamageData
    Descripcion :  Guarda los datos de para la atención de daños

    Autor       :  Juan Sebastian Florez (jsflorez)
    Fecha       :  25-01-2013
    Parametros  :
                   inuOrderId
                   inuPackage_id
                   idtInitial_date
                   idtAttention_date

    Historia de Modificaciones
    Fecha        Autor              Modificación
    =========    =========          ====================
    25-01-2013   jsflorez.SAO198497 Creación.
    ***************************************************************/
    PROCEDURE SetDamageData
    (
        inuOrderId              in or_order_activity.order_id%type,
        inuPackageId            in or_order_activity.package_id%type,
        idtInitialDate          in pr_timeout_component.initial_date%type,
        idtFinalDate            in pr_timeout_component.final_date%type
    )
    IS

    BEGIN
        ut_trace.trace('Inicia OR_BOExternalLegalize.SetDamageData',15);

            gnuOrderId              := inuOrderId;
            gnuPackageId            := inuPackageId;
            gdtInitialDate          := idtInitialDate;
            gdtAttentionDate        := idtFinalDate;

        ut_trace.trace('Finaliza OR_BOExternalLegalize.SetDamageData',15);
    EXCEPTION
        when ex.CONTROLLED_ERROR THEN
            ut_trace.trace('Error : ex.CONTROLLED_ERROR',15);
            raise;

        when others THEN
            ut_trace.trace('Error : others',15);
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  ProcessDamageData
    Descripcion :  Procesa los datos externos para la atencion de daños

    Autor       :  Juan Sebastian Florez (jsflorez)
    Fecha       :  25-01-2013
    Parametros  :
                   inuOrderId

    Historia de Modificaciones
    Fecha        Autor              Modificación
    =========    =========          ====================
    25-01-2013   jsflorez.SAO198497 Creación.
    ***************************************************************/
    PROCEDURE ProcessDamageData(inuOrderId  in  or_order.order_id%type)
    IS
        -- Datos para la atencion de daños
        nuOrderId              or_order_activity.order_id%type;
        nuPackageId            or_order_activity.package_id%type;
        dtInitialDate          pr_timeout_component.initial_date%type;
        dtFinalDate            pr_timeout_component.final_date%type;

    BEGIN
        ut_trace.trace('Inicia OR_BOExternalLegalize.ProcessDamageData',15);

        OR_BOExternalLegalize.GetDamageData
        (
            nuOrderId,
            nuPackageId,
            dtInitialDate,
            dtFinalDate
        );

        if (nuOrderId IS not null AND nuOrderId = inuOrderId
            AND not fboRegenerateAct(nuOrderId, nuPackageId)
            AND CC_BCProductDamage.fboAttendWithLegalOrd(inuOrderId, nuPackageId)) then

            CC_BOProductDamage.RegAffectationDates
            (
                nuPackageId,
                dtInitialDate,
                dtFinalDate
            );
        end if;

        -- Se limpian los datos de los daños
        OR_BOExternalLegalize.SetDamageData
        (
            null,
            null,
            null,
            null
        );

        ut_trace.trace('Finaliza OR_BOExternalLegalize.ProcessDamageData',15);
    EXCEPTION
        when ex.CONTROLLED_ERROR THEN
            ut_trace.trace('Error : ex.CONTROLLED_ERROR',15);
            raise;

        when others THEN
            ut_trace.trace('Error : others',15);
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END;

    /*****************************************************************
    Unidad   :      ProcessExternalData
    Descripcion	:   Proceso los datos externos requeridos en la legalizacion
                    de las ordenes.

    Parametros          Descripcion
    ============        ===================
    Entrada:
        inuOrder                Id de la orden
        inuCausal               Causal de legalizacion de la orden
        idtExecution_date       Fecha de finalizacion de ejecucion de la orden
        itbOrderActivities      Actividades asociadas a la orden

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ============    =================== ====================
    11-09-2014      FSaldana.SAO273724 En el proceso de las órdenes de suspensión
                                         si la orden fue atendida con éxito y causal de
                                         anulación, el producto regresa al estado
                                         activo.

    11-04-2014      AEcheverry.SAO237524    Se incluye el procesamiento de las actividades
                                            de mantenimiento preventivo (processId = 5)
    04-06-2013      gcabezas.SAO208772  Se elimina el manejo de no agrupar actividades para una orden asociada al mantenimiento preventivo
    25-01-2013      jsflorez.SAO200089  Se agrega el llamado al procedimiento «ProcessDamageData»
    07-09-2012      RGamboa.SAO189700   Se elimina llamado a "or_bolegalipreventmaintenace.Legalize"
    18-07-2012      GPaz.SAO181853      Se elimina el llamado al procedimiento «ProcessDamageData»
    27-03-2012      cenaviaSAO178134    Estabilización
                    cenaviaSAO178070    se modifica los procesos de suspension,
                                        retiro y reconexion.
    29-08-2011      RGamboa.SAO157054   Se elimina iblRegenActivities.
    22-07-2011      csolanoSAO153512    Se cambia el método utilizado para
                                        anular el despacho, para utilizar uno
                                        que sincronice la programación.
    28-07-2011      MArteaga.SAO154672  Se modifica para que atienda el daño a porducto
                                        asociado.
    22-07-2011      RGamboa.SAO151667   Se agrega parametro que indica si la legalizacion de la actividad
                                        regenero nuevas actividades.
    30-06-2011      RGamboa.SAO151670   Se elimina lógica de manejo de mantenimiemtos, toda se tendra en
                                        "or_bolegalipreventmaintenace.Legalize".
    10-Fev-2011     gpazSAO139986       Se elimina la asociación de la órden a un acta
    26-May-2010     AEcheverrySAO118590 Se modifican referencias de nuLegalizeCount a nuStatusLegalize
    10-05-2010      cjaramilloSAO116866 Se adiciona llamado a GE_BOCertContratista.AsociarOrdenActa
                                        para asociar la orden a un acta.
    25-abr-2010     sagudeloSAO115861   Se adiciona proceso para ordenes de inspección
    23-Nov-2009     cburbanoSAO110258   Se adiciona proceso para ordenes legalizadas con
                                        causal de anulacion para reconexion y retiro
    22-Oct-2009     MArteagaSAO106035   Se agrega la causal de legalizacion para
                                        cuando se llama a  <<or_bolegalipreventmaintenace.Legalize>>
    28-Sep-2009     jssanchezSAO105192  Se modifica el proceso de mantenimiento correctivo
                                        para que actualice el estado de daño sin importar el
                                        estado de la legalización.
	25-Sep-2009 	jssanchezSAO96431   Se modifica el llamado a if_bofwmaintenance
    02-Jul-2009     yclavijo SAO96649   Se inicializan variables globales de BSS
                                        pkSuspConnService.SetRecordTrigger(rcServsuscNull);
                                        pkSuspConnServiceMgr.SetRecordTrigger(rcServsuscNull);
    07-nov-2008     obedoyaSAO84138     Se modifica el proceso de mantenimiento preventivo
                                        para que desafecte productos afectados
    08-Sep-2008     AecheverrySAO78721  Se modifica la tabla de actividades para que sea variable de entrada y salida
    04-Sep-2008     jhramirezSAO81347   Se modifica la parte de Corte y Reonexión para
                                        cuando la Legalizan en cero se vaya a anular la suspension.

    01-Sep-2008     vrecaldeSAO78729    Se adiciona proceso de corte y reconexiòn
    21-ago-2008     avillegasSAO792223  Se adiciona el proceso de gestión de cobro

    19-ago-2008     obedoyaSAO78725     * Se adiciona el proceso de mantenimiento
                                          preventivo.
    ******************************************************************/
    PROCEDURE ProcessExternalData
    (
        inuOrder            in Or_Order.Order_Id%type,
        inuCausal           in ge_causal.causal_id%type,
        idtExecution_date   in OR_order.execution_final_date%type,
        iotbOrderActivities in out nocopy or_bcorderactivities.tytbOrderActivities
    )
    IS
        nuCurrentActivity       ge_items.items_id%type := null;
        nuCausal_type_id        ge_causal.causal_type_id%type;
        nuIdx                   number ;
        rcOrder_activity        OR_bcorderactivities.tyrcOrderActivities;
        rcServsuscNull          servsusc%rowtype;
        nuDispatch              or_sched_dispatch.sched_dispatch_id%type;
        sbInstanceApp           procesos.procdesc%TYPE;
    BEGIN
        ut_trace.trace('INICIO OR_BOExternalLegalize.ProcessExternalData',2);

        -- Se obtiene el tipo de causal
        nuCausal_type_id := dage_causal.fnuGetCausal_type_id(inuCausal);
        --  ut_trace.trace('-- Se obtiene el tipo de causal := '||nuCausal_type_id,2);

        -- Se iteran todas las actividades
        nuIdx := iotbOrderActivities.first;
        while nuIdx IS not null loop
            -- Se inicializan variables globales para proceso de Sus/REc/Ret
            --pkSuspConnService.SetRecordTrigger(rcServsuscNull);
            --pkSuspConnServiceMgr.SetRecordTrigger(rcServsuscNull);

            ut_trace.trace('itbOrderActivities(nuIdx).nuStatusLegalize['||iotbOrderActivities(nuIdx).nuStatusLegalize||']',2);
            ut_trace.trace('itbOrderActivities(nuIdx).nuProcessId['||rcOrder_activity.nuProcessId||']',2);
            rcOrder_activity := iotbOrderActivities(nuIdx);

            ---------------------------
            -- Mantenimiento Correctivo
            ---------------------------
            if rcOrder_activity.nuProcessId = TT_BOCreateActivity.fnuPROCESS_DAMAGE
            then
                -- Actualiza el estado del paquete
                tt_boorderdamageutilities.UpdatePackageStatus(rcOrder_activity.nuPackageId);

            ----------------------------
            -- Gestion de Cobro
            ----------------------------
            elsif rcOrder_activity.nuProcessId = or_bocreateactbycollmgr.cnuCollectMgrProcess then
                -- La actividad es de gestión de cobro
                or_bocreateactbycollmgr.SuspeConneByCollMng(
                                                            inuOrder,
                                                            rcOrder_activity.nuOrderActivity,
                                                            nvl(rcOrder_activity.nuStatusLegalize,0) = 1);

                iotbOrderActivities(nuIdx).sbTraslateActivity := ge_boconstants.csbNO;
            ----------------------------
            -- Corte y Reconexión
            ----------------------------
            elsif rcOrder_activity.nuProcessId = or_bocreatactiprodtypest.cnuPROCESS_DESCONEXION then
                sbInstanceApp := pkerrors.fsbGetApplication;
                pkerrors.SetApplication(Or_BOConstants.csbORDERS);
             -- Legalizacion con exito y causal diferente de anulación
                if((rcOrder_activity.nuStatusLegalize = 1) AND (nuCausal_type_id <> cnuANNUL_CAUSAL_TYPE)) then
                    OR_boLegalActProdTypeStat.ProductSuspend(rcOrder_activity,inuOrder,inuCausal); --Suspende el producto
                  ut_trace.trace('-- Corte y Reconexión - Legalizacion con exito sin causal de anulación',15);
                -- Legalizacion solo con causal de anulacion, para permitir el pago del trabajo al contratista
                elsif(nuCausal_type_id = cnuANNUL_CAUSAL_TYPE ) THEN
                  ut_trace.trace('-- Corte y Reconexión - Legalizacion con causal de anulacion',15);
                    OR_boLegalActProdTypeStat.AnullSuspProduc(rcOrder_activity,inuOrder,inuCausal); --Mandar a anular la suspension.
                    iotbOrderActivities(nuIdx).sbTraslateActivity := ge_boconstants.csbNO;
                END if;
                pkerrors.SetApplication(sbInstanceApp);
            ------------------
            -- RECONEXIóN
            ------------------
            elsif rcOrder_activity.nuProcessId = or_bocreatactiprodtypest.cnuPROCESS_RECONEXION then
                sbInstanceApp := pkerrors.fsbGetApplication;
                pkerrors.SetApplication(Or_BOConstants.csbORDERS);
                 -- Legalizacion con exito
                if(rcOrder_activity.nuStatusLegalize = 1) then
                --  ut_trace.trace('-- REONEXIóN - Legalizacion con exito',15);
                    OR_boLegalActProdTypeStat.ProductReConect(rcOrder_activity,inuOrder,inuCausal);
                -- Legalizacion con fallo y causal de anulacion
                elsif rcOrder_activity.nuStatusLegalize = 0
                    AND nuCausal_type_id = cnuANNUL_CAUSAL_TYPE
                THEN
                --  ut_trace.trace('-- REONEXIóN - Legalizacion con fallo y causal de anulacion',15);
                    OR_boLegalActProdTypeStat.anullProductReconnect(rcOrder_activity, inuOrder, inuCausal);
                    iotbOrderActivities(nuIdx).sbTraslateActivity := ge_boconstants.csbNO;
                END if;
                pkerrors.SetApplication(sbInstanceApp);
            ------------------
            -- RETIRO
            ------------------
            elsif rcOrder_activity.nuProcessId = or_bocreatactiprodtypest.cnuPROCESS_RETIRO then
                sbInstanceApp := pkerrors.fsbGetApplication;
                pkerrors.SetApplication(Or_BOConstants.csbORDERS);
                 -- Legalizacion con exito
                if(rcOrder_activity.nuStatusLegalize = 1) then
                --  ut_trace.trace('-- RETIRO - Legalizacion con exito',15);
                    OR_boLegalActProdTypeStat.ProductRetire(rcOrder_activity,inuOrder,inuCausal);
                -- Legalizacion con fallo y causal de anulacion
                elsif rcOrder_activity.nuStatusLegalize = 0
                    AND nuCausal_type_id = cnuANNUL_CAUSAL_TYPE
                THEN
                --  ut_trace.trace('-- RETIRO - Legalizacion con fallo y causal de anulacion',15);
                    OR_boLegalActProdTypeStat.anullProductRetire(rcOrder_activity, inuOrder, inuCausal);
                    iotbOrderActivities(nuIdx).sbTraslateActivity := ge_boconstants.csbNO;
                END if;
                pkerrors.SetApplication(sbInstanceApp);
            -----------------------------
            -- Mantenimiento Preventivo
            ----------------------------
            elsif  rcOrder_activity.nuProcessId = OR_boconstants.cnuPROCESS_PREVENT_MAINT then
                -- se atiende el mantenimiento preventivo
               OR_BOLegaliPreventMaintenace.Legalize(rcOrder_activity.nuOrderActivity, inuCausal);
               iotbOrderActivities(nuIdx).sbTraslateActivity := ge_boconstants.csbNO;
            END if;
            nuIdx := iotbOrderActivities.next(nuIdx);
        END loop;
        ------------------
        -- Se acualiza el estado de despacho si existe.
        ------------------
        or_boPrograming.anullOrderScheduler(inuOrder, or_boconstants.csbDispatchStatusLegalized);

        -- Valida si es una Orden de Inspección
        IF or_boinspeccionordenes.fblEsOrdenInspeccion(inuOrder) THEN
            ut_trace.trace('OR_BOExternalLegalize Es Orden de Inspección',2);
            or_bolegordenesinspeccion.ProcesarOrdenInspeccion
            (
                inuOrder,
                inuCausal
            );
        END IF;

        -- Procesa los datos para la atención de daños
        ProcessDamageData(inuOrder);

        ut_trace.trace('FIN OR_BOExternalLegalize.ProcessExternalData',2);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;

    END ProcessExternalData;

END OR_BOExternalLegalize;
/
