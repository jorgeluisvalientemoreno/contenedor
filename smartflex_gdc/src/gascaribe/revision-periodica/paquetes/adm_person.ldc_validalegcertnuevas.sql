CREATE OR REPLACE PACKAGE ADM_PERSON.LDC_VALIDALEGCERTNUEVAS AS
/*------------------------------------------------------------------------------
  Propiedad intelectual de PETI (c).
  Unidad         : LDC_VALIDALEGCERTNUEVAS
  Descripcion    : Validaciones para legalizaciones de 12162 certificacion
                   de ventas nuevas.
  Autor          : Juan C. Ramirez - Optima Consulting
  Fecha          : 01-DIC-2014
  Metodos              Descripcion
  ============         ===================
  FinanciarConceptosFactura - Genera la financiacion con los parametros concepto factura.
  prFinanceCertNuevas - Genera cargos a la -1, facturas o financiacion por concepto de
                        certificacion en instalaciones nuevas.

  Fecha             Autor             Modificacion
  ===========      =========         ====================
  01-DIC-2014      jcramirez         Creacion - NC4036
------------------------------------------------------------------------------*/

--------------------------------------------------------------------------------
--METODOS
--------------------------------------------------------------------------------

-----------------------------
--FinanciarConceptosFactura--
-----------------------------
    PROCEDURE FinanciarConceptosFactura
    (
        inuNumProdsFinanc       IN    number,                 --Numero de productos a financiar
        inuFactura              IN    factura.factcodi%TYPE,  --Codigo de Factura a Financiar
        inuPlanId               IN    plandife.pldicodi%TYPE, --Codigo del Plan
        inuMetodo               IN    plandife.pldimccd%TYPE, --Metodo de calculo de la cuota
        inuDifeNucu             IN    plandife.pldicuma%TYPE, --Numero de cuotas
        isbDocuSopo             IN    diferido.difenudo%TYPE, --Documento soporte
        isbDifeProg             IN    diferido.difeprog%TYPE, --Programa que ejecuta la financiacion
        onuAcumCuota            OUT   number,                 --Acumulado cuota
        onuSaldo                OUT   number,                 --Saldo
        onuTotalAcumCapital     OUT   number,                 --Total acumulado capital
        onuTotalAcumCuotExtr    OUT   number,                 --Total acumulado cuota extr.
        onuTotalAcumInteres     OUT   number,                 --Total acumulado intereses
        osbRequiereVisado       OUT   varchar2,               --Requiere Visado
        onuDifeCofi             OUT   number                  --Codigo de financiacion
    );

-----------------------
--prFinanceCertNuevas--
-----------------------
    PROCEDURE prFinanceCertNuevas;

--------------
--fsbVersion--
--------------
    FUNCTION fsbVersion RETURN VARCHAR2;

END LDC_VALIDALEGCERTNUEVAS;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDC_VALIDALEGCERTNUEVAS AS
/*------------------------------------------------------------------------------
  Propiedad intelectual de PETI (c).
  Unidad         : LDC_VALIDALEGCERTNUEVAS
  Descripcion    : Validaciones para legalizaciones de 12162 certificacion
                   de ventas nuevas.                                        f
  Autor          : Juan C. Ramirez - Optima Consulting
  Fecha          : 01-DIC-2014
  Metodos              Descripcion
  ============         ===================
  FinanciarConceptosFactura - Genera la financiacion con los parametros concepto factura.
  prFinanceCertNuevas - Genera cargos a la -1, facturas o financiacion por concepto de
                        certificacion en instalaciones nuevas.

  Fecha             Autor             Modificacion
  ===========      =========         ====================
  26-FEB-2015      agordillo         Modificacion Caso.6324
                                     * Se modifica el cursor cuConcCertiVtaFormulario para que tome los tag_name
                                     del parametro nuevo que se crea TAGN_SOL_MOT_GEN_CARG
  01-DIC-2014      jcramirez         Creacion - NC4036
------------------------------------------------------------------------------*/

--------------------------------------------------------------------------------
    --CONSTANTES
--------------------------------------------------------------------------------
    csbVersion CONSTANT VARCHAR2(20) := 'NC4036';

    --Tramites
	cnuVtaConstruc    CONSTANT open.ps_package_type.package_type_id%TYPE := 323;    --Venta Constructoras
	cnuVtaFormular    CONSTANT open.ps_package_type.package_type_id%TYPE := 271;    --Venta de Gas por Formulario
	cnuSoliInterna    CONSTANT open.ps_package_type.package_type_id%TYPE := 329;    --Solicitud de Interna
	cnuVtaCotizada    CONSTANT open.ps_package_type.package_type_id%TYPE := 100229; --Venta de Gas Cotizada
	cnuVtaFormIFRS    CONSTANT open.ps_package_type.package_type_id%TYPE := 100249; --Venta de Gas por Formulario IFRS
	cnuSoliIntIFRS    CONSTANT open.ps_package_type.package_type_id%TYPE := 100259; --Solicitud de Interna IFRS
	cnuVtaCotiIFRS    CONSTANT open.ps_package_type.package_type_id%TYPE := 100272; --Venta de Gas Cotizada IFRS

	--Flujos
	cnuFljVtaFormIFRS CONSTANT open.wf_unit_type.unit_type_id%TYPE := 100595;       -- Venta de Gas por Formulario IFRS
	cnuFljSoliIntIFRS CONSTANT open.wf_unit_type.unit_type_id%TYPE := 100594;       -- Solicitud de Interna IFRS
	cnuFljVtaCotiIFRS CONSTANT open.wf_unit_type.unit_type_id%TYPE := 100592;       -- Venta de Gas Cotizada IFRS

--------------------------------------------------------------------------------
    --CURSORES
--------------------------------------------------------------------------------
    --CURSOR para saber si la Orden de Certificacion, pertenece a la misma direccion de la Venta
    --Cursor para validar la existencia de orden de tipo de trabajo 12162
    ---en un tramite de ventas
    CURSOR cuOrder12162
    (
    inuPackageId        mo_packages.package_id%TYPE,
    inuPkgAddressId     mo_packages.address_id%TYPE
    )
    is
        select count (1)
        from or_order_activity
            where package_id = inuPackageId
            and task_type_id = 12162
            and address_id   = inuPkgAddressId;

    --Cursor para saber si la Orden de Certificacion es regenerada a partir de la legalizacion de una orden de aceptacion de certificacion(10500)
    CURSOR cuIsRegen(inuActivityId or_order_activity.order_activity_id%TYPE) is
        select count(1)
        from or_order_activity, or_order
        where or_order_activity.order_activity_id = inuActivityId
          and or_order.order_id = or_order_activity.order_id
          and (or_order.task_type_id = 10500 and or_order.causal_id = 3332);

    --Cursor para saber si la Orden de Certificacion es regenerada a partir de un mismo tipo de trabajo en la Certificacion
    CURSOR cuIsRegen12162(inuActivityId or_order_activity.order_activity_id%TYPE) IS
        SELECT count(1)
        FROM or_order_activity, or_order
        WHERE or_order_activity.order_activity_id = inuActivityId
          AND or_order.order_id = or_order_activity.order_id
          AND (or_order.task_type_id = 12162)
          AND EXISTS (SELECT 1
                      FROM ge_causal c
                      WHERE c.causal_id = or_order.causal_id
                        AND c.class_causal_id = 2 );

    --Cursor consulta de tipo de flujo de venta para saber si es IFRS o no----
    CURSOR cuIsIFRS
    (
        nuPackageId     wf_instance.parent_external_id%TYPE
    )
    IS
        SELECT  unit_type_id
        FROM    wf_instance
        WHERE   parent_external_id = nuPackageId
          AND     parent_id IS null
          AND     action_id IS null;


    --Cursor para consultar si en los conceptos de la cotizacion, esta el concepto correspondiente a la certificacion(674)
	CURSOR cuConcCertiVtaCotizacion
    (
        nuPackageId       mo_packages.package_id%TYPE,
        nuItemId          or_order_activity.activity_id%TYPE,
        nuConcItemCert    ge_items.concept%TYPE
    )
    IS
	    SELECT COUNT(1)
    	FROM ge_items gei, cc_quotation_item quo, cc_quotation qo
	    WHERE qo.package_id = nuPackageId
          AND qo.status <> 'N'
          AND damo_packages.fnugetpackage_type_id(qo.package_id) IN (cnuVtaCotizada,cnuSoliInterna,cnuSoliIntIFRS,cnuVtaCotiIFRS)
          AND quo.quotation_id=qo.quotation_id
          AND quo.items_id = nuItemId
          AND quo.unit_value > 0
          AND gei.items_id=quo.items_id
          AND gei.concept = nuConcItemCert;

    --Cursor para consultar si en los conceptos del plan comercial esta el concepto correspondiente a la certificacion(674)
    CURSOR cuConcCertiVtaFormulario
    (
        nuPackageTypeId   mo_packages.package_type_id%TYPE,
        nuConcItemCert    ge_items.concept%TYPE,
        nuPlanCome        mo_motive.commercial_plan_id%TYPE
    )
    IS
        SELECT  COUNT(1)
		FROM concsopl
    	WHERE cosoconc = nuConcItemCert
          AND cosoplsu = nuPlanCome
		 -- AND cosotagn = daps_package_type.fsbgettag_name(nuPackageTypeId);
          AND cosotagn in (select column_value   -- Agordillo Caso.6324
                            from table(ldc_boutilities.splitstrings
                            (dald_parameter.fsbgetvalue_chain('TAGN_SOL_MOT_GEN_CARG',null),',')));


        -- Cursor para obtener el plan comercial asociado al motivo de la solicitud
        CURSOR cuPlanComercial(nuPackage mo_packages.package_id%TYPE)
        IS
            SELECT c.commercial_plan_id
            FROM mo_motive m, cc_commercial_plan c
            WHERE m.commercial_plan_id = c.commercial_plan_id
              AND m.package_id = nuPackage;

        -- Cursor para consultar el numero de cuotas en las condiciones de financiacion de la solicitud
        CURSOR cuCondicionNegociacion
        (
        nuPackage mo_packages.package_id%TYPE
        )
        IS
            SELECT quotas_number
            FROM cc_sales_financ_cond
            WHERE package_id = nuPackage;

        -- Cursor para consultar las cuotas del plan acuerdo pago
        CURSOR cuCuotasPlanAcuerdoPago
        (
        inuPlanAP plandife.pldicodi%TYPE
        )
        IS
            SELECT pldicuma
            FROM plandife
            WHERE pldicodi = inuPlanAP;

        --Cursor para obtener el numero de cuotas de financiacion
        CURSOR cuNumCuotasFinan
        (
        inuContrato diferido.difesusc%TYPE
        )
        IS
            SELECT difenucu
            FROM diferido
            WHERE difesusc = inuContrato
              AND difecodi IS NOT NULL
              AND ROWNUM = 1;

      -- Inicia Agordillo Caso.6324
      -- Cursor para validar si la solicitud ya tiene una factura generada.
      -- Este caso se da en ventas sin IFRS donde se les generaba los cargos al momento de crear la venta
      CURSOR cuValCertFacturado
      (
        nuPackage       mo_packages.package_id%TYPE,
        nuConcItemCert  ge_items.concept%TYPE) IS
      select count(1) from cargos
      where cargconc=nuConcItemCert
      and cargsign='DB'
      and cargdoso like '%PP-%'||nuPackage
      and cargfecr >= (select to_date(value_chain) from ld_parameter
                        where parameter_id like '%LIVE_DEPARTURE_DATE_PR%');

    -- Se le pasa como parametro el producto si existe en la instancia
    CURSOR cuValCertFacturadoPR
      (
        nuPackage       mo_packages.package_id%TYPE,
        nuConcItemCert  ge_items.concept%TYPE,
        nuProduct       pr_product.product_id%type) IS
      select count(1) from cargos
      where cargnuse=nuProduct
      and cargconc=nuConcItemCert
      and cargsign='DB'
      and cargdoso like '%PP-%'||nuPackage
      and cargfecr >= (select to_date(value_chain) from ld_parameter
                        where parameter_id like '%LIVE_DEPARTURE_DATE_PR%');
    -- Fin Agordillo Caso.6324

--------------------------------------------------------------------------------
        --METODOS
--------------------------------------------------------------------------------
/*------------------------------------------------------------------------------
  Propiedad intelectual de PETI (c).
  Unidad         : FinanciarConceptosFactura
  Descripcion    : Genera la financiacion con los parametros concepto factura
  Autor          : Juan C. Ramirez - Optima Consulting
  Fecha          : 02-DIC-2014
  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  ===========      =========         ====================
  02-DIC-2014      jcramirez         Creacion - NC4036
------------------------------------------------------------------------------*/
    PROCEDURE FinanciarConceptosFactura
    (
        inuNumProdsFinanc       IN    number,                 --Numero de productos a financiar
        inuFactura              IN    factura.factcodi%TYPE,  --Codigo de Factura a Financiar
        -- Plan de Acuerdo de Pago
        inuPlanId               IN    plandife.pldicodi%TYPE, --Codigo del Plan
        inuMetodo               IN    plandife.pldimccd%TYPE, --Metodo de calculo de la cuota
        inuDifeNucu             IN    plandife.pldicuma%TYPE, --Numero de cuotas
        isbDocuSopo             IN    diferido.difenudo%TYPE, --Documento soporte
        isbDifeProg             IN    diferido.difeprog%TYPE, --Programa que ejecuta la financiacion
        -- Variables de salida del proceso de financiacion
        onuAcumCuota            OUT   number,
        onuSaldo                OUT   number,
        onuTotalAcumCapital     OUT   number,
        onuTotalAcumCuotExtr    OUT   number,
        onuTotalAcumInteres     OUT   number,
        osbRequiereVisado       OUT   varchar2,
        onuDifeCofi             OUT   number
    )
    IS
        nuNumProdsFinanc            number := inuNumProdsFinanc;
		nuInteRate		            diferido.difeinte%TYPE;	-- Porcentaje de interes del diferido
        nuQuotaMethod	            diferido.difemeca%TYPE;	-- Metodo de calculo de la cuota del diferido
        nuTaincodi	                plandife.plditain%TYPE;	-- Codigo Tasa Interes
        boSpread                    boolean;
        sbErrMsg                    varchar2(10000);

    BEGIN
        ut_trace.trace('Inicia LDC_VALIDALEGCERTNUEVAS.FinanciarConceptosFactura ', 11);

        /* Se realiza validacion sobre el saldo pendiente de la factura */
        if( pkBCAccountStatus.fnuGetBalance( inuFactura ) = pkBillConst.CERO )then
            return;
        end if;

        -- Se asigna el consecutivo de financiacion
        pkDeferredMgr.nuGetNextFincCode( onuDifeCofi );

        -- Se instancian en la tabla temporal de saldos por concepto, los
        -- conceptos de la factura
        CC_BOFinancing.SetAccountStatus( inuFactura, GE_BOConstants.csbYES, pkConstante.NO, pkConstante.NO );

        -- Se actualiza la tabla temporal para que sean procesados solo los conceptos
        -- financiables
        CC_BCFinancing.SelectAllowedProducts( pkConstante.SI, nuNumProdsFinanc );

        -- Se instancian en la tabla temporal de saldos por concepto, los
        -- descuentos de financiacion respectivos
        CC_BCFinancing.SetDiscount( inuPlanId );

        -- Obtiene tasa de interes
        pkDeferredPlanMgr.ValPlanConfig (inuPlanId,
                                         pkGeneralServices.fdtGetSystemDate,
                                         nuQuotaMethod,
                                         nuTaincodi,
                                         nuInteRate,
                                         boSpread
                                         );

        -- Se ejecuta el proceso de financiacion
        CC_BOFinancing.ExecDebtFinanc
        (
            inuPlanId,
            inuMetodo,
            pkGeneralServices.fdtGetSystemDate,
            nuInteRate,
            pkBillConst.CERO,
            inuDifeNucu,
            isbDocuSopo,
            pkBillConst.CIENPORCIEN,
            pkBillConst.CERO,
            pkConstante.NO,
            isbDifeProg,
            pkConstante.NO,
            pkConstante.NO,
            onuDifeCofi,
            onuAcumCuota,
            onuSaldo,
            onuTotalAcumCapital,
            onuTotalAcumCuotExtr,
            onuTotalAcumInteres,
            osbRequiereVisado
        );

        -- Se guarda la informacion de la financiacion en la base de datos
        CC_BOFinancing.CommitFinanc;

        -- Se verifica si se generaron diferidos asociados a la financiacion
        if ( not CC_BCFinancing.fboExistDeferred( onuDifeCofi ) ) then
            -- Se asigna NULL al codigo de la financiacion
            onuDifeCofi := NULL;
        end if;

        --dbms_output.put_Line(onuDifeCofi);

        --  realizar commit
        --pkgeneralservices.committransaction;

        ut_trace.trace('Finaliza LDC_VALIDALEGCERTNUEVAS.FinanciarConceptosFactura', 11);
    EXCEPTION
        when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then
    	    raise;

        when OTHERS then
    	    pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    	    raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
    END FinanciarConceptosFactura;

/*------------------------------------------------------------------------------
  Propiedad intelectual de PETI (c).
  Unidad         : prFinanceCertNuevas
  Descripcion    : Genera cargos a la -1, facturas o financiacion por concepto de
                   certificacion en instalaciones nuevas.
  Autor          : Juan C. Ramirez - Optima Consulting
  Fecha          : 01-DIC-2014
  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  ===========      =========         ====================
  26-FEB-2015      agordillo         Modificacion Caso 6324
                                     * Se crea un bloque anonimo  donde se valida que la causal de legalizacion,
                                     se encuentre configurada del parametro COD_CAUSA_COBRO_CERT, las cuales
                                     son validas para generar cargos en la certificacion.
                                     * Se modifica el if de la linea  468
                                     (IF nuTaskTypeId = 12162 and nuCausalClassId = 1 and nuValCasual>0 and nuCount > 0 and nuPkgCertSiCobro > 0  )
                                     donde se incluye la condicion nuValCasual>0 para que ingrese a generar cargos,
                                     en caso dado que la causal sea valida.
  01-DIC-2014      jcramirez         Creacion - NC4036

------------------------------------------------------------------------------*/
    PROCEDURE prFinanceCertNuevas IS

        -- Actividad de Orden
        onuFinanPlanId         plandife.pldicodi%TYPE;
        onuQuotasNumber        plandife.pldicuma%TYPE;
        nuQuotasNumber         plandife.pldicuma%TYPE;
        nuAtrribute_id         ge_attributes.ATTRIBUTE_ID%TYPE;
        sbaditionalattribute   or_temp_data_values.data_value%TYPE;
        nuOrderId              or_order.order_id%TYPE;
        nuPackageID            mo_packages.package_id%TYPE;
        nuOrderActivity        or_order_activity.order_activity_id%TYPE;
        nuItem_id              or_order_activity.activity_id%TYPE;
        onuFinanId             diferido.difecodi%TYPE;
        nuCount                number := 0;
        nuTaskTypeId           or_order.task_type_id%TYPE;
        nuConcepto             or_task_type.concept%TYPE;
        nuPackageTypeId        ps_package_type.package_type_id%TYPE;
        nuPRODUCT_ID           or_order_activity.product_id%TYPE;
        onuerrorcode           NUMBER;
        osberrormessage        VARCHAR2 (4000);
        dtfechVta              mo_packages.request_date%TYPE; --or_order.assigned_date%TYPE;
        nuCate                 pr_product.category_id%TYPE;
        onuIdListaCosto        ge_unit_cost_ite_lis.list_unitary_cost_id%TYPE;
        onuCostoItem           ge_unit_cost_ite_lis.price%TYPE;
        onuPrecioVentaItem     ge_unit_cost_ite_lis.sales_value%TYPE;

        nuCausalId             ge_causal.causal_id%TYPE;
        nuCausalClassId        ge_class_causal.class_causal_id%TYPE;
        nuAddressId            or_order_activity.address_id%TYPE;
		nuItemCode             or_order_activity.activity_id%TYPE;
		nuOriginActivityId     or_order_activity.origin_activity_id%TYPE;
		nuConcItemCert         ge_items.concept%TYPE;
        dtLivePR               date := trunc(to_date(dald_parameter.fsbGetValue_Chain('LIVE_DEPARTURE_DATE_PR'),
                                            ut_date.fsbDATE_FORMAT));
        nuGenCharge            number := 0;
        nuCountConpCot         number := 0;
		nuCountConpForm        number := 0;
		nuGenFinanc            number := 0;
		nuGenFact              number := 0;
		nuMotiveId             MO_Motive.motive_id%TYPE;
		nuCommercialPlanId     mo_motive.commercial_plan_id%TYPE;
		nuPkgCertSiCobro       NUMBER := 0;
		nuPkgCertNoCobro       NUMBER := 0;
		nuFact                 FACTURA.factcodi%TYPE;
		nuMetodo               PLANDIFE.pldimccd%TYPE;
		sbDocuSoporte          DIFERIDO.difenudo%TYPE;
		onuAcumCuota           number;
        onuSaldo               number;
        onuTotalAcumCapital    number;
        onuTotalAcumCuotExtr   number;
        onuTotalAcumInteres    number;
        osbRequiereVisado      varchar2(10);
        onuDifeCofi            number;
        nuIsRegen              number := 0;
        nuIsRegen12162         number := 0;
        nuUnitTypeId           wf_instance.unit_type_id%TYPE;
        blIsIfrs               BOOLEAN := FALSE;
        nuValCasual            number;
        nuFactVta              number;
    BEGIN
        ut_trace.trace('Inicia LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas ', 15);

        --Obtener el identificador de la orden  que se encuentra en la instancia
        nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder;
        ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas or_bolegalizeorder.fnuGetCurrentOrder => '||nuOrderId,10);

        nuOrderActivity := ldc_bcfinanceot.fnuGetActivityId(nuorderid);
        ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas  => nuOrderId=>'||nuOrderId, 10);

        --Obtener causal de legalizacion
        nuCausalId := daor_order.fnugetcausal_id(nuOrderId);
        ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas daor_order.fnugetcausal_id => nuCausalId',10);
        ut_trace.trace('nuCausalId =>'||nuCausalId,10);

        --Obtener tipo de causal
        nuCausalClassId := dage_causal.fnugetclass_causal_id(nuCausalId);
        ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas => nuCausalClassId=>'||nuCausalClassId, 10);

        --Obtener identificador de la solicitud
        nuPackageID := daor_order_activity.Fnugetpackage_Id(nuOrderActivity);
        nuPRODUCT_ID := daor_order_activity.Fnugetproduct_Id(nuOrderActivity);
        nuAddressId  := daor_order_activity.Fnugetaddress_Id(nuOrderActivity);
        ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas => inuPackageID=>'||nuPackageID, 10);

        --Se ejecuta cursor para saber si la Orden de Certificacion corresponde a la misma direccion de venta
        open cuOrder12162 (nuPackageID,nuAddressId);
        fetch cuOrder12162 into nuCount;
        close cuOrder12162;
-------------------------------------------------------
        nuTaskTypeId := daor_order.fnugettask_type_id(nuOrderId);

        --Obtiene el tipo de solicitud
        nuPackageTypeId := damo_packages.fnugetpackage_type_id(nuPackageId);
        ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas nuPackageTypeId =>'||nuPackageTypeId);
        --Consulta el tipo de solicitud para validar si se generaran funciones por concepto de certificacion.
        BEGIN
            SELECT (SELECT COUNT(1) from dual
                WHERE nuPackageTypeId IN (SELECT TO_NUMBER(column_value)
                FROM table (ldc_boutilities.SPLITstrings(dald_parameter.fsbGetValue_Chain('PKG_CERT_SI_COBRO',NULL),','))))
               ,(SELECT COUNT(1) from dual
                WHERE nuPackageTypeId IN (SELECT TO_NUMBER(column_value)
                FROM table (ldc_boutilities.SPLITstrings(dald_parameter.fsbGetValue_Chain('PKG_CERT_NO_COBRO',NULL),','))))
            INTO nuPkgCertSiCobro, nuPkgCertNoCobro
            FROM dual;
        EXCEPTION
            WHEN others THEN
                nuPkgCertSiCobro := 0;
                nuPkgCertNoCobro := 0;
        END;

        -- busco la categoria del producto para asignar el item
        -- con el que se debe cobrar la certificacion
        nuCate := dapr_product.Fnugetcategory_Id(nuPRODUCT_ID);

	    IF nucate = 1 then
            nuItem_id := Dald_parameter.fnuGetNumeric_Value('COD_ITEM_CERTIF_RESID',null);
            IF nuItem_id is null THEN
                ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                'El parametro del item para el cobro de la certificacion a categoria RESIDENCIAL '||
                'aun no esta definido. Revise por LDPAR el parametro "COD_ITEM_CERTIF_RESID"');
                raise ex.CONTROLLED_ERROR;
            END IF;
        ELSE
            nuItem_id := Dald_parameter.fnuGetNumeric_Value('COD_ITEM_CERTIF_COMERC',null);
            IF nuItem_id is null THEN
                ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                'El parametro del item para el cobro de la certificacion a categoria COMERCIAL '||
                'aun no esta definido. Revise por LDPAR el parametro "COD_ITEM_CERTIF_COMERC"');
                raise ex.CONTROLLED_ERROR;
            END IF;
        END IF;

        ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas Items ID '||nuItem_id, 15);

		--Consulta el la fecha de la solicitud como fecha en la que se hizo la venta.
        dtfechVta   := damo_packages.fdtgetrequest_date(nuPackageId);   --sysdate; --daor_order.fdtgetassigned_date(nuOrderId);

        --Se consulta el precio de venta de la certificacion de la instalacion
        GE_BCCertContratista.ObtenerCostoItemLista(nuItem_id,dtfechVta,null,null,null,null,onuIdListaCosto, onuCostoItem, onuPrecioVentaItem);
        ut_trace.trace('onuIdListaCosto '||onuIdListaCosto||' onuCostoItem '||onuCostoItem||' onuPrecioVentaItem '||onuPrecioVentaItem , 15);

        -- Inicia Agordillo Caso.6324
        -- Consulta si la causal de legalizacion es valida para generar cargos
        BEGIN

            select count(1) into nuValCasual
            from (SELECT TO_NUMBER(column_value) causal
            FROM table (ldc_boutilities.SPLITstrings(dald_parameter.fsbGetValue_Chain('COD_CAUSA_COBRO_CERT',NULL),','))) causal_conf
            where causal = nuCausalId;
        EXCEPTION
            when no_data_found then
                nuValCasual := 0;
        END;
        -- Fin Agordillo Caso.6324


        --Valida si el tipo de trabajo que se esta legalizando es un 12162 con causal de exito y pertenece a los tramites de venta 12162
        ut_trace.trace('IF '||nuCausalClassId||' nuPackageId '||nuPackageId||' nuCount '||nuCount||' nuValCasual:'||nuValCasual, 15);

        -- Agordillo Caso.6324
        -- Se agrega la condicion and nuValCasual>0 para validar la causal de legalizacion
        IF nuTaskTypeId = 12162 and nuCausalClassId = 1 and nuValCasual>0 and nuCount > 0 and nuPkgCertSiCobro > 0 then

            ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas nuTaskTypeId=12162 AND nuCausalClassId=1 AND nuPkgCertSiCobro>0',10);
            IF nuPackageID is null or nuPackageID = -1 then
		        ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas nuPackageID is null OR nuPackageID = -1',10);
                ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,'No existe una solicitud asociada a la orden '||nuOrderId);
                raise ex.CONTROLLED_ERROR;
            END IF;

		    ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas daor_task_type.fnugetconcept => nuTaskTypeId => '||nuTaskTypeId,10);
            nuConcepto     := daor_task_type.fnugetconcept(nuTaskTypeId);
            IF nuConcepto is null or nuConcepto = -1 then
		        ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas nuConcepto is null OR nuConcepto = -1',10);
                ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,'El tipo de trabajo no tiene el concepto definido '||nuTaskTypeId);
                raise ex.CONTROLLED_ERROR;
            END IF;

            /*-- busco la categoria del producto para asignar el item
            -- con el que se debe cobrar la certificacion
            nuCate := dapr_product.Fnugetcategory_Id(nuPRODUCT_ID);

	    	IF nucate = 1 then
                nuItem_id := Dald_parameter.fnuGetNumeric_Value('COD_ITEM_CERTIF_RESID',null);
                IF nuItem_id is null THEN
                    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                    'El parametro del item para el cobro de la certificacion a categoria RESIDENCIAL '||
                    'aun no esta definido. Revise por LDPAR el parametro "COD_ITEM_CERTIF_RESID"');
                    raise ex.CONTROLLED_ERROR;
                END IF;
            ELSE
                nuItem_id := Dald_parameter.fnuGetNumeric_Value('COD_ITEM_CERTIF_COMERC',null);
                IF nuItem_id is null THEN
                    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                    'El parametro del item para el cobro de la certificacion a categoria COMERCIAL '||
                    'aun no esta definido. Revise por LDPAR el parametro "COD_ITEM_CERTIF_COMERC"');
                    raise ex.CONTROLLED_ERROR;
                END IF;
            END IF;

            ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas Items ID '||nuItem_id, 15);

		    --Consulta el la fecha de la solicitud como fecha en la que se hizo la venta.
            dtfechVta   := damo_packages.fdtgetrequest_date(nuPackageId);   --sysdate; --daor_order.fdtgetassigned_date(nuOrderId);

            --Se consulta el precio de venta de la certificacion de la instalacion
            GE_BCCertContratista.ObtenerCostoItemLista(nuItem_id,dtfechVta,null,null,null,null,onuIdListaCosto, onuCostoItem, onuPrecioVentaItem);
            ut_trace.trace('onuIdListaCosto '||onuIdListaCosto||' onuCostoItem '||onuCostoItem||' onuPrecioVentaItem '||onuPrecioVentaItem , 15);*/

            -- busco el id del atributo del plan de financiacion
            select ATTRIBUTE_ID into nuAtrribute_id from ge_attributes where NAME_ATTRIBUTE='PLAN_ACUERDO_PAGO_CERTIF';

            -- busco el valor del dato adicional para el plan de financiacion
            sbaditionalattribute:=LDC_BOORDENES.fsbDatoAdicTmpOrden(nuorderid, nuAtrribute_id, 'PLAN_ACUERDO_PAGO_CERTIF');
            onuFinanPlanId := TO_NUMBER (sbaditionalattribute);

            -- busco el id del atributi del numero de cuotas
            select ATTRIBUTE_ID into nuAtrribute_id from ge_attributes where NAME_ATTRIBUTE='NUM_CUOTAS_FINANC_CERTIF';

            -- busco el valor del dato adicional para la cuota
            sbaditionalattribute:=LDC_BOORDENES.fsbDatoAdicTmpOrden(nuorderid, nuAtrribute_id, 'NUM_CUOTAS_FINANC_CERTIF');
            onuQuotasNumber := TO_NUMBER (sbaditionalattribute);

            --Validar si existe una configuracio aplicable
            IF onuFinanPlanId IS NULL or onuQuotasNumber IS NULL THEN
		        ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuFinanPlanId is null OR onuQuotasNumber is null',10);
                --Error
                ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                                 'No se ha digitado los datos adicionales para el Plan de financiacion o la cuota inicial');
                raise ex.CONTROLLED_ERROR;
            END IF;

            --Se obtiene la actividad Origen
            nuOriginActivityId := daor_order_activity.fnugetorigin_activity_id(nuOrderActivity);
            ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas => nuOriginActivityId => ' ||nuOriginActivityId,10);

            --Validar si la orden es regenerada
            IF nuOriginActivityId is not null then
                open cuIsRegen(nuOriginActivityId);
                fetch cuIsRegen into nuIsRegen;
                close cuIsRegen;
            END IF;

            --Validar si la orden es regenerada
            IF nuOriginActivityId is not null then
                open cuIsRegen12162(nuOriginActivityId);
                fetch cuIsRegen12162 into nuIsRegen12162;
                close cuIsRegen12162;
            END IF;
--------------------------------------------------------------------------------
            --Consulta si la solicitud corresponde a IFRS
            BEGIN
                OPEN cuIsIFRS(nuPackageId);
                FETCH cuIsIFRS INTO nuUnitTypeId;
                CLOSE cuIsIFRS;

                --Consulta si el tipo de unidad es IFRS
                IF (nuUnitTypeId IN (cnuFljVtaFormIFRS,cnuFljSoliIntIFRS,cnuFljVtaCotiIFRS)) THEN
                    blIsIfrs := TRUE;
                ELSE
                    blIsIfrs := FALSE;
                END IF;
            EXCEPTION
                WHEN others THEN
                    blIsIfrs := FALSE;
            END;

		    ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas daor_order_activity.fnugetactivity_id => nuOrderActivity => '||nuOrderActivity,10);
	        nuItemCode := daor_order_activity.fnugetactivity_id(nuOrderActivity);
		    ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas dage_items.fnugetconcept => nuItemCode => '||nuItemCode,10);
	        nuConcItemCert := dage_items.fnugetconcept(nuItemCode);

            --Consulta si existen conceptos de certificacion para la Venta Cotizada o solicitud interna
            BEGIN
                OPEN cuConcCertiVtaCotizacion(nuPackageId,nuItemCode,nuConcItemCert);
                FETCH cuConcCertiVtaCotizacion INTO nuCountConpCot;
                CLOSE cuConcCertiVtaCotizacion;
            EXCEPTION
                WHEN others THEN
                    nuCountConpCot := 0;
            END;



    	    SELECT ldc_boutilities.fsbgetvalorcampotabla('MO_MOTIVE','PACKAGE_ID','MOTIVE_ID',nuPackageId)
        	, ldc_boutilities.fsbgetvalorcampotabla('MO_MOTIVE','PACKAGE_ID','COMMERCIAL_PLAN_ID',nuPackageId)
	        INTO nuMotiveId,nuCommercialPlanId
   	        FROM dual
	        WHERE rownum = 1;

        	--Consulta si existen conceptos de certificacion para la Venta por Formulario
            BEGIN
                OPEN cuConcCertiVtaFormulario(damo_packages.fnugetpackage_type_id(nuPackageId),nuConcItemCert,nuCommercialPlanId);
    		    FETCH cuConcCertiVtaFormulario INTO nuCountConpForm;
                CLOSE cuConcCertiVtaFormulario;
            EXCEPTION
                WHEN others THEN
                    nuCountConpForm := 0;
            END;

            -- Inicia Agordillo Caso.6324
            --Consulta si ya existe una factura para la solicitud con el concepto de certificacion
            IF (nuPRODUCT_ID is not null) then
                BEGIN
                    OPEN cuValCertFacturadoPR(nuPackageId,nuConcItemCert,nuPRODUCT_ID);
        		    FETCH cuValCertFacturadoPR INTO nuFactVta;
                    CLOSE cuValCertFacturadoPR;
                EXCEPTION
                WHEN others THEN
                    nuFactVta := 0;
                END;

            ELSE
                BEGIN
                    OPEN cuValCertFacturado(nuPackageId,nuConcItemCert);
        		    FETCH cuValCertFacturado INTO nuFactVta;
                    CLOSE cuValCertFacturado;
                EXCEPTION
                WHEN others THEN
                    nuFactVta := 0;
                END;

            END IF;
            -- Fin Agordillo Caso.6324


/**************************************************************************************/
/***********************Ajustes Aranda 6046 - Errores en condiciones ******************************************/
/**************************************************************************************/

--------------------------------------------------------------------------------
--X1. Certi No regenerada, Sin IFRS, Sin Cargos Conc 674, antes de FechaSalidVivo
--------------------------------------------------------------------------------
            IF (nuIsRegen = 0 AND nuIsRegen12162 = 0)
                AND blIsIfrs = FALSE
                AND (nuCountConpCot = 0 OR nuCountConpForm = 0)
                and trunc(damo_packages.fdtgetrequest_date(nuPackageId)) < dtLivePR then
                ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas (nuIsRegen = 0 AND nuIsRegen12162 = 0) AND blIsIfrs = FALSE AND (nuCountConpCot = 0 OR nuCountConpForm = 0) and trunc(damo_packages.fdtgetrequest_date(nuPackageId)) < dtLivePR',10);
                --Valida que los datos adicionales del plan de financiacion y el numero de cuotas no se legalicen con valores incorrectos
                --Cuando la certificacion fue ofrecida en el paquete de venta
                IF onuFinanPlanId <> -1 then
                    ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuFinanPlanId <> -1',10);
    				IF onuQuotasNumber <> -1 then
	    			   ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuQuotasNumber <> -1',10);
                       ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                             'Debe legalizar la certificacion de la instalacion con plan de financiacion y numero de cuotas igual a -1, por que al cliente se le ofrecio la certificacion en la venta');
                       raise ex.CONTROLLED_ERROR;
                    END IF;
    			END IF;
                --Indica si se deben generar cargos
                nuGenCharge := 0;
	            --Indica si se genera factura
                nuGenFact := 0;
			    --Indica si se genera financiacion
			    nuGenFinanc := 0;
            END IF;


--------------------------------------------------------------------------------
--X2. Certi regenerada a partir de otra certificacion, Sin IFRS, Sin Cargos Conc 674, antes de FechaSalidVivo
--------------------------------------------------------------------------------
            IF (nuIsRegen = 0 AND nuIsRegen12162 = 1)
                AND blIsIfrs = FALSE
                AND (nuCountConpCot = 0 OR nuCountConpForm = 0)
                and trunc(damo_packages.fdtgetrequest_date(nuPackageId)) < dtLivePR then
                ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas (nuIsRegen = 0 AND nuIsRegen12162 = 1) AND blIsIfrs = FALSE AND (nuCountConpCot = 0 OR nuCountConpForm = 0) and trunc(damo_packages.fdtgetrequest_date(nuPackageId)) < dtLivePR',10);
                --Valida que los datos adicionales del plan de financiacion y el numero de cuotas no se legalicen con valores incorrectos
                --Cuando la certificacion fue ofrecida en el paquete de venta
                IF onuFinanPlanId <> -1 then
                    ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuFinanPlanId <> -1',10);
    				IF onuQuotasNumber <> -1 then
	    			   ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuQuotasNumber <> -1',10);
                       ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                             'Debe legalizar la certificacion de la instalacion con plan de financiacion y numero de cuotas igual a -1, por que al cliente se le ofrecio la certificacion en la venta');
                       raise ex.CONTROLLED_ERROR;
                    END IF;
    			END IF;
                --Indica si se deben generar cargos
                nuGenCharge := 0;
	            --Indica si se genera factura
                nuGenFact := 0;
			    --Indica si se genera financiacion
			    nuGenFinanc := 0;
            END IF;

--------------------------------------------------------------------------------
--X3. Certi regenerada por aceptacion de certificacion, Sin IFRS, Sin Cargos Conc 674, despues de FechaSalidVivoRP
--------------------------------------------------------------------------------

            IF (nuIsRegen > 0 AND nuIsRegen12162 = 0)
                and blIsIfrs = FALSE
                and nuFactVta = 0   -- Agordillo Caso.6324 Si no tiene factura generada Antes de IFRS
                and (nuCountConpCot = 0 OR nuCountConpForm = 0)
                and trunc(damo_packages.fdtgetrequest_date(nuPackageId)) >= dtLivePR then
                ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas (nuIsRegen > 0 AND nuIsRegen12162 = 0) and blIsIfrs = FALSE and (nuCountConpCot = 0 OR nuCountConpForm = 0) and trunc(damo_packages.fdtgetrequest_date(nuPackageId)) >= dtLivePR',10);
                --Verifica que el usuario no legalice la certificacion con el plan y numero de cuotas incorrecto
                IF onuFinanPlanId = -1 then
                    ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuFinanPlanId = -1',10);
				    IF onuQuotasNumber > 0 then
                        ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuQuotasNumber > 0',10);
				        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                             'Debe legalizar la certificacion de la instalacion con plan de financiacion diferente de -1 y numero de cuotas > 0, por que el plan -1 no posee las caracteristicas para financiar certificaciones');
                        raise ex.CONTROLLED_ERROR;
                    ELSE
                        IF onuQuotasNumber = 0 THEN
                            ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuQuotasNumber = 0',10);
                            --Indica si se deben generar cargos
                            nuGenCharge := 1;
                            --Indica si se genera factura
                            nuGenFact := 1;
                            --Indica si se genera financiacion
                            nuGenFinanc := 0;
                        ELSE
                            ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuQuotasNumber < 0',10);
                            --Indica si se deben generar cargos
                            nuGenCharge := 0;
                            --Indica si se genera factura
                            nuGenFact := 0;
                            --Indica si se genera financiacion
                            nuGenFinanc := 0;
                        END IF;
                    END IF;
                ELSE
                    ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuFinanPlanId <> -1',10);
                    IF onuQuotasNumber > 0 then
                        ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuQuotasNumber > 0',10);
                        --Indica si se deben generar cargos a la -1
                        nuGenCharge := 1;
                        --Indica si se genera factura
                        nuGenFact := 1;
                        --Indica si se genera financiacion (nuevo)
                        nuGenFinanc := 1;
                    ELSE
                        ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuQuotasNumber <= 0',10);
                        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                             'Debe legalizar la certificacion de la instalacion con numero de cuotas diferente de -1 o 0');
                        raise ex.CONTROLLED_ERROR;

                        --Indica si se deben generar cargos
                        nuGenCharge := 0;
                        --Indica si se genera factura
                        nuGenFact := 0;
                        --Indica si se genera financiacion
                        nuGenFinanc := 0;
                    END IF;
                END IF;
            END IF;

--------------------------------------------------------------------------------
--X4. Certi regenerada a partir de otra certificacion, Sin IFRS, Sin Cargos Conc 674, despues de FechaSalidVivoRP
--------------------------------------------------------------------------------

            IF (nuIsRegen = 0 AND nuIsRegen12162 > 0)
                and blIsIfrs = FALSE
                and nuFactVta = 0   -- Agordillo Caso.6324 Si no tiene factura generada Antes de IFRS
                and (nuCountConpCot = 0 OR nuCountConpForm = 0)
                and trunc(damo_packages.fdtgetrequest_date(nuPackageId)) >= dtLivePR then
                ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas (nuIsRegen = 0 AND nuIsRegen12162 > 0) and blIsIfrs = FALSE and (nuCountConpCot = 0 OR nuCountConpForm = 0) and trunc(damo_packages.fdtgetrequest_date(nuPackageId)) >= dtLivePR',10);
                --Verifica que el usuario no legalice la certificacion con el plan y numero de cuotas incorrecto
                IF onuFinanPlanId = -1 then
                    ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuFinanPlanId = -1',10);
				    IF onuQuotasNumber > 0 then
                        ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuQuotasNumber > 0',10);
				        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                             'Debe legalizar la certificacion de la instalacion con plan de financiacion diferente de -1 y numero de cuotas > 0, por que el plan -1 no posee las caracteristicas para financiar certificaciones');
                        raise ex.CONTROLLED_ERROR;
                    ELSE
                        IF onuQuotasNumber = 0 THEN
                            ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuQuotasNumber = 0',10);
                            --Indica si se deben generar cargos
                            nuGenCharge := 1;
                            --Indica si se genera factura
                            nuGenFact := 1;
                            --Indica si se genera financiacion
                            nuGenFinanc := 0;
                        ELSE
                            ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuQuotasNumber < 0',10);
                            --Indica si se deben generar cargos
                            nuGenCharge := 0;
                            --Indica si se genera factura
                            nuGenFact := 0;
                            --Indica si se genera financiacion
                            nuGenFinanc := 0;
                        END IF;
                    END IF;
                ELSE
                    ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuFinanPlanId <> -1',10);
                    IF onuQuotasNumber > 0 then
                        ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuQuotasNumber > 0',10);
                        --Indica si se deben generar cargos a la -1
                        nuGenCharge := 1;
                        --Indica si se genera factura
                        nuGenFact := 1;
                        --Indica si se genera financiacion (nuevo)
                        nuGenFinanc := 1;
                    ELSE
                        ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuQuotasNumber <= 0',10);
                        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                             'Debe legalizar la certificacion de la instalacion con numero de cuotas diferente de -1 o 0');
                        raise ex.CONTROLLED_ERROR;

                        --Indica si se deben generar cargos
                        nuGenCharge := 0;
                        --Indica si se genera factura
                        nuGenFact := 0;
                        --Indica si se genera financiacion
                        nuGenFinanc := 0;
                    END IF;
                END IF;
            END IF;


--------------------------------------------------------------------------------
--X5. Certificacion regenerada a partir de aceptacion de certificacion, Con IFRS, Sin Cargos Conc 674
--------------------------------------------------------------------------------
            IF (nuIsRegen > 0 AND nuIsRegen12162 = 0)
                and blIsIfrs = TRUE
                and (nuCountConpCot = 0 OR nuCountConpForm = 0) then
                ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas (nuIsRegen > 0 AND nuIsRegen12162 = 0) and blIsIfrs = TRUE and (nuCountConpCot = 0 OR nuCountConpForm = 0)',10);

                --Indica si se deben generar cargos a la -1
                nuGenCharge := 0;
                --Indica si se genera factura
                nuGenFact := 0;
                --Indica si se genera financiacion
                nuGenFinanc := 0;

                --Verifica que se realice la accion cuando el plan seleccionado es diferente a -1
                IF onuFinanPlanId <> -1 then
                    ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuFinanPlanId <> -1',10);
                    IF onuQuotasNumber <> -1 then
                        ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuQuotasNumber <> -1',10);
                        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                             'Debe legalizar la certificacion de la instalacion con plan de financiacion igual -1
                             y numero de cuotas -1, por que bajo el esquema de venta IFRS no es posible cobrar de
                             contado o financiar al cliente la certificacion antes de haberla ejecutado');
                        raise ex.CONTROLLED_ERROR;
                    ELSE
                        ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuQuotasNumber = -1',10);
                        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                             'Debe legalizar la certificacion de la instalacion con plan de financiacion igual -1');
                        raise ex.CONTROLLED_ERROR;
                    END IF;
                ELSE
                    ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuFinanPlanId = -1',10);
                    IF onuQuotasNumber >= 0 then
                        ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuQuotasNumber >= 0',10);
                        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                             'Debe legalizar la certificacion de la instalacion con numero de cuotas -1');
                        raise ex.CONTROLLED_ERROR;
                    ELSE
                        IF onuQuotasNumber = -1 then
                            ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuQuotasNumber = -1',10);
                            --Indica si se deben generar cargos a la -1
                            nuGenCharge := 1;
                            --Indica si se genera factura
                            nuGenFact := 0;
                            --Indica si se genera financiacion
                            nuGenFinanc := 0;
                        END IF;
                    END IF;
                END IF;
            END IF;

--------------------------------------------------------------------------------
--X6. Certificacion regenerada a partir de otra certificacion, Con IFRS, Sin Cargos Conc 674
--------------------------------------------------------------------------------
            IF (nuIsRegen = 0 AND nuIsRegen12162 > 0)
                and blIsIfrs = TRUE
                and (nuCountConpCot = 0 OR nuCountConpForm = 0) then
                ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas (nuIsRegen = 0 AND nuIsRegen12162 > 0) and blIsIfrs = TRUE and (nuCountConpCot = 0 OR nuCountConpForm = 0)',10);

                --Indica si se deben generar cargos a la -1
                nuGenCharge := 0;
                --Indica si se genera factura
                nuGenFact := 0;
                --Indica si se genera financiacion
                nuGenFinanc := 0;

                --Verifica que se realice la accion cuando el plan seleccionado es diferente a -1
                IF onuFinanPlanId <> -1 then
                    ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuFinanPlanId <> -1',10);
                    IF onuQuotasNumber <> -1 then
                        ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuQuotasNumber <> -1',10);
                        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                             'Debe legalizar la certificacion de la instalacion con plan de financiacion igual -1 y numero de cuotas -1, por que bajo el esquema de venta IFRS no es posible cobrar de contado o financiar al cliente la certificacion antes de haberla ejecutado');
                        raise ex.CONTROLLED_ERROR;
                    ELSE
                        ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuQuotasNumber = -1',10);
                        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                             'Debe legalizar la certificacion de la instalacion con plan de financiacion igual -1');
                        raise ex.CONTROLLED_ERROR;
                    END IF;
                ELSE
                    ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuFinanPlanId = -1',10);
                    IF onuQuotasNumber >= 0 then
                        ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuQuotasNumber >= 0',10);
                        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                             'Debe legalizar la certificacion de la instalacion con numero de cuotas -1');
                        raise ex.CONTROLLED_ERROR;
                    ELSE
                        IF onuQuotasNumber = -1 then
                            ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuQuotasNumber = -1',10);
                            --Indica si se deben generar cargos a la -1
                            nuGenCharge := 1;
                            --Indica si se genera factura
                            nuGenFact := 0;
                            --Indica si se genera financiacion
                            nuGenFinanc := 0;
                        END IF;
                    END IF;
                END IF;
            END IF;

--------------------------------------------------------------------------------
--X7. Certificacion regenerada a partir de la aceptacion de certificacion, Con IFRS, Con Cargos Conc 674
--------------------------------------------------------------------------------
            IF (nuIsRegen > 0 AND nuIsRegen12162 = 0)
                and blIsIfrs = TRUE
                and (nuCountConpCot > 0 OR nuCountConpForm > 0) then
                ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas (nuIsRegen > 0 AND nuIsRegen12162 = 0) and blIsIfrs = TRUE and (nuCountConpCot > 0 OR nuCountConpForm > 0)',10);

                --Indica si se deben generar cargos a la -1
                nuGenCharge := 0;
                --Indica si se genera factura
                nuGenFact := 0;
                --Indica si se genera financiacion
                nuGenFinanc := 0;

                --Verifica que se realice la accion cuando el plan seleccionado es diferente a -1
                IF onuFinanPlanId <> -1 then
                    ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuFinanPlanId <> -1',10);
                    IF onuQuotasNumber <> -1 then
                        ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuQuotasNumber <> -1',10);
                        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                             'Debe legalizar la certificacion de la instalacion con plan de financiacion igual -1 y numero de cuotas -1, por que bajo el esquema de venta IFRS no es posible cobrar de contado o financiar al cliente la certificacion antes de haberla ejecutado');
                        raise ex.CONTROLLED_ERROR;
                    ELSE
                        ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuQuotasNumber = -1',10);
                        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                             'Debe legalizar la certificacion de la instalacion con plan de financiacion igual -1');
                        raise ex.CONTROLLED_ERROR;
                    END IF;
                ELSE
                    ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuFinanPlanId = -1',10);
                    IF onuQuotasNumber >= 0 then
                        ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuQuotasNumber >= 0',10);
                        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                             'Debe legalizar la certificacion de la instalacion con numero de cuotas -1');
                        raise ex.CONTROLLED_ERROR;
                    ELSE
                        IF onuQuotasNumber = -1 then
                            ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuQuotasNumber = -1',10);
                            --Indica si se deben generar cargos a la -1
                            nuGenCharge := 0; ---AGordillo tenia el nuGenCharge = 1 y no se deben generar cargos por que ya le estoy cobrando la certificacion al cliente
                            --Indica si se genera factura
                            nuGenFact := 0;
                            --Indica si se genera financiacion
                            nuGenFinanc := 0;
                        END IF;
                    END IF;
                END IF;
            END IF;

--------------------------------------------------------------------------------
--X8. Certificacion regenerada a partir de otra certificacion, Con IFRS, Con Cargos Conc 674
--------------------------------------------------------------------------------
            IF (nuIsRegen = 0 AND nuIsRegen12162 > 0)
                and blIsIfrs = TRUE
                and (nuCountConpCot > 0 OR nuCountConpForm > 0) then
                ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas (nuIsRegen = 0 AND nuIsRegen12162 > 0) and blIsIfrs = TRUE and (nuCountConpCot > 0 OR nuCountConpForm > 0)',10);

                --Indica si se deben generar cargos a la -1
                nuGenCharge := 0;
                --Indica si se genera factura
                nuGenFact := 0;
                --Indica si se genera financiacion
                nuGenFinanc := 0;

                --Verifica que se realice la accion cuando el plan seleccionado es diferente a -1
                IF onuFinanPlanId <> -1 then
                    ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuFinanPlanId <> -1',10);
                    IF onuQuotasNumber <> -1 then
                        ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuQuotasNumber <> -1',10);
                        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                             'Debe legalizar la certificacion de la instalacion con plan de financiacion igual -1 y numero de cuotas -1, por que bajo el esquema de venta IFRS no es posible cobrar de contado o financiar al cliente la certificacion antes de haberla ejecutado');
                        raise ex.CONTROLLED_ERROR;
                    ELSE
                        ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuQuotasNumber = -1',10);
                        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                             'Debe legalizar la certificacion de la instalacion con plan de financiacion igual -1');
                        raise ex.CONTROLLED_ERROR;
                    END IF;
                ELSE
                    ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuFinanPlanId = -1',10);
                    IF onuQuotasNumber >= 0 then
                        ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuQuotasNumber >= 0',10);
                        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                             'Debe legalizar la certificacion de la instalacion con numero de cuotas -1');
                        raise ex.CONTROLLED_ERROR;
                    ELSE
                        IF onuQuotasNumber = -1 then
                            ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuQuotasNumber = -1',10);
                            --Indica si se deben generar cargos a la -1
                            nuGenCharge := 0; ---Agordillo Caso.6324 tenia el nuGenCharge = 1 y no se deben generar cargos por que ya le estoy cobrando la certificacion al cliente
                            --Indica si se genera factura
                            nuGenFact := 0;
                            --Indica si se genera financiacion
                            nuGenFinanc := 0;
                        END IF;
                    END IF;
                END IF;
            END IF;

--------------------------------------------------------------------------------
--X8. Certificacion generada desde la venta, Con IFRS, Con Cargos Conc 674
--------------------------------------------------------------------------------
            IF (nuIsRegen = 0 AND nuIsRegen12162 = 0)
                and blIsIfrs = TRUE
                and (nuCountConpCot > 0 OR nuCountConpForm > 0) then
                ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas (nuIsRegen = 0 AND nuIsRegen12162 = 0) and blIsIfrs = TRUE and (nuCountConpCot > 0 OR nuCountConpForm > 0)',10);

                --Indica si se deben generar cargos a la -1
                nuGenCharge := 0;
                --Indica si se genera factura
                nuGenFact := 0;
                --Indica si se genera financiacion
                nuGenFinanc := 0;

                --Verifica que se realice la accion cuando el plan seleccionado es diferente a -1
                IF onuFinanPlanId <> -1 then
                    ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuFinanPlanId <> -1',10);
                    IF onuQuotasNumber <> -1 then
                        ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuQuotasNumber <> -1',10);
                        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                             'Debe legalizar la certificacion de la instalacion con plan de financiacion igual -1 y numero de cuotas -1, por que bajo el esquema de venta IFRS no es posible cobrar de contado o financiar al cliente la certificacion antes de haberla ejecutado');
                        raise ex.CONTROLLED_ERROR;
                    ELSE
                        ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuQuotasNumber = -1',10);
                        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                             'Debe legalizar la certificacion de la instalacion con plan de financiacion igual -1');
                        raise ex.CONTROLLED_ERROR;
                    END IF;
                ELSE
                    ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuFinanPlanId = -1',10);
                    IF onuQuotasNumber >= 0 then
                        ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuQuotasNumber >= 0',10);
                        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                             'Debe legalizar la certificacion de la instalacion con numero de cuotas -1');
                        raise ex.CONTROLLED_ERROR;
                    ELSE
                        IF onuQuotasNumber = -1 then
                            ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuQuotasNumber = -1',10);
                            --Indica si se deben generar cargos a la -1
                            nuGenCharge := 0; ---Agordillo Caso.6324 tenia el nuGenCharge = 1 y no se deben generar cargos por que ya le estoy cobrando la certificacion al cliente
                            --Indica si se genera factura
                            nuGenFact := 0;
                            --Indica si se genera financiacion
                            nuGenFinanc := 0;
                        END IF;
                    END IF;
                END IF;
            END IF;


/**************************************************************************************/
/***********************Ajustes Aranda 6046 - Errores en condiciones ******************************************/
/**************************************************************************************/


--------------------------------------------------------------------------------
--7. Tipo de paquete certificacion sin cobro
--------------------------------------------------------------------------------
            IF nuPkgCertNoCobro > 0 THEN
                IF onuFinanPlanId <> -1 then
                    ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuFinanPlanId <> -1',10);
                    IF onuQuotasNumber <> -1 then
                        ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuQuotasNumber <> -1',10);
                        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                        'Debe legalizar la certificacion de la instalacion con plan de financiacion y numero de cuotas igual a -1');
                        raise ex.CONTROLLED_ERROR;
                    END IF;
                END IF;

                --Indica si se deben generar cargos
                nuGenCharge := 0;
                --Indica si se genera factura
                nuGenFact := 0;
                --Indica si se genera financiacion
                nuGenFinanc := 0;
            END IF;

        END IF;

--------------------------------------------------------------------------------
        --Generacion de Cargos
--------------------------------------------------------------------------------

/*Se adiciona condicion para que la generacion de cargos a la -1 y factura para el cobro por concepto de certificacion se hagan
sobre tramites de ventas diferentes al tramite de migracion de ventas 100271*/

        IF nuPkgCertSiCobro > 0 THEN
            IF trunc(damo_packages.fdtgetrequest_date(nuPackageId)) >= dtLivePR THEN
                IF onuPrecioVentaItem > 0 then
                ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuPrecioVentaItem > 0',10);
                    IF nuGenCharge=1 then
                    ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas nuGenCharge = 1',10);
                    -- genera el cargo
                    ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas OS_CHARGETOBILL => nuPRODUCT_ID, nuConcepto, onuPrecioVentaItem, nuPackageID => '
                    ||nuPRODUCT_ID||', '||nuConcepto||', '||onuPrecioVentaItem||', '||nuPackageID,10);
                    OS_CHARGETOBILL(nuPRODUCT_ID, nuConcepto, 0, 53, onuPrecioVentaItem, 'PP-'||nuPackageID, null, onuerrorcode, osberrormessage);

                        IF (onuErrorCode <> 0) then
                            ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuErrorCode => '||onuErrorCode,10);
                            gw_boerrors.checkerror(onuErrorCode, osbErrorMessage);
                            raise ex.CONTROLLED_ERROR;
                        END IF;

--------------------------------------------------------------------------------
                --Generacion de Factura
--------------------------------------------------------------------------------
                        IF nuGenFact = 1 THEN
                        ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas nuGenFact=1',10);
                        --Generar una factura con los cargos a la cuenta de cobro -1 generados por la legalizacion de la orden (estos se identifican
                        --porque en la tabla CARGOS, en la tabla CARGDOSO tienen el prefijo "PP" mas el numero de la solicitud), usando el metodo:
                        --Donde inuPackageID es un parametro de entrada que hace referencia al numero de la solicitud padre de la orden de trabajo
                        ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas CC_BOACCOUNTS.GENERATEACCOUNTBYPACK => nuPackageID => '||nuPackageID,10);
                            CC_BOACCOUNTS.GENERATEACCOUNTBYPACK(nuPackageID);
                        END IF;
                    END IF;
                ELSE
                ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuPrecioVentaItem <= 0',10);
                ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                'El Precio de Venta del Item es CERO, Verifique el Valor y/o la Vigencia de la Lista de Precio para el Item '||nuItem_id);
                raise ex.CONTROLLED_ERROR;
                END IF;
            END IF;

        END IF;
--------------------------------------------------------------------------------
        --Generacion de Financiacion
--------------------------------------------------------------------------------
/*Se adiciona condicion para que la generacion de financicacion para el cobro por concepto de certificacion se hagan
sobre tramites de ventas diferentes al tramite de migracion de ventas 100271*/

        IF nuPkgCertSiCobro > 0 THEN
            IF trunc(damo_packages.fdtgetrequest_date(nuPackageId)) >= dtLivePR THEN
                IF onuPrecioVentaItem > 0  then
                ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuPrecioVentaItem > 0',10);
                    IF nuGenCharge = 1 THEN
                    ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas nuGenCharge = 1',10);
                        IF nuGenFact = 1 then
                        ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas nuGenFact = 1',10);
                            IF nuGenFinanc = 1 THEN
                            --Genera financiacion
                            ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas cc_bofinancing.financingorder => nuPackageId => '||nuPackageId,10);

						      --Define documento de soporte
						      sbDocuSoporte := 'PP-'||TO_CHAR(nuPackageId);

        					   --Consulta la factura
                                SELECT cc.cucofact
        						INTO nuFact
        						FROM cargos c, cuencobr cc
        						WHERE c.cargconc = 674
        						AND c.cargdoso = sbDocuSoporte
        						AND cc.cucocodi = c.cargcuco;

        						--Consulta el metodo de Calculo del plan de financiacion
        						SELECT pldimccd
        						INTO nuMetodo
        						FROM plandife
        						WHERE pldicodi = onuFinanPlanId;

        						LDC_VALIDALEGCERTNUEVAS.FinanciarConceptosFactura(nuPRODUCT_ID
            			                    			                         ,nuFact
        																		 ,onuFinanPlanId
        																		 ,nuMetodo
        																		 ,onuQuotasNumber
        																		 ,sbDocuSoporte
        																		 ,'CUSTOMER'
        																		 ,onuAcumCuota
        																		 ,onuSaldo
        																		 ,onuTotalAcumCapital
        																		 ,onuTotalAcumCuotExtr
        																		 ,onuTotalAcumInteres
        																		 ,osbRequiereVisado
        																		 ,onuDifeCofi);
                            END IF;
                        END IF;
                    END IF;
                ELSE
                ut_trace.trace('LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas onuPrecioVentaItem <= 0',10);
                ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                'El Precio de Venta del Item es CERO, Verifique el Valor y/o la Vigencia de la Lista de Precio para el Item '||nuItem_id);
                raise ex.CONTROLLED_ERROR;
                END IF;
            END IF;
        END IF;

        ut_trace.trace('Finaliza LDC_VALIDALEGCERTNUEVAS.prFinanceCertNuevas ', 10);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            ERRORS.seterror;
            raise;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END prFinanceCertNuevas;

/*------------------------------------------------------------------------------
  Propiedad intelectual de PETI (c).
  Unidad         : fsbVersion
  Descripcion    : Retorna la version del paquete.
  Autor          : Juan C. Ramirez - Optima Consulting
  Fecha          : 01-DIC-2014
  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  ===========      =========         ====================
  01-DIC-2014      jcramirez         Creacion
------------------------------------------------------------------------------*/
    FUNCTION fsbVersion
    RETURN VARCHAR2
    IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;

END LDC_VALIDALEGCERTNUEVAS;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_VALIDALEGCERTNUEVAS', 'ADM_PERSON');
END;
/
