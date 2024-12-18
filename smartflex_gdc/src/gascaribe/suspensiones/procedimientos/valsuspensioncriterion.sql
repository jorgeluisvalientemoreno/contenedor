CREATE OR REPLACE PROCEDURE ValSuspensionCriterion
IS

     /*****************************************************************
    Propiedad intelectual Proyecto PETI.

    Unidad         : ValSuspensionCriterion
    Descripcion    : Procedimiento Personalizado con Criterios de validacion
                     ejecutados sobre el proceso de suspension

    Autor          : Luis Felipe Granada Ramirez
    Fecha          : 11-04-2012

    Historia de Modificaciones
    Fecha             Autor               Modificacion
    ==========        ==================  ======================================
    15-07-2019		  HJM CA-200-2722	  Deshabilita la validación del proceso pkbovalidsuspcrit.fboValidateZeroCons
    02-10-2018        FCastro CA-200-2085  El numero de cuentas vencidas obtenido por el servicio
                                           de producto pkboexpiredaccounts.fnuperiodswithexpaccounts
                                           se reemplaza (si la entrega aplica) por la funcion
                                           personalziada pkbovalidsuspcrit.fnuNroCuentasVenc
                                           (CA 200-2085)
    04-10-2016        ncarrasquilla       CA-200-596. Se busca adiciona parametro de la fecha de cuenta de
                                          cobro mas reciente para buscar dias adicionales para la suspension
    30-10-2014        acardenas.NC3484    Se modifica para incluir el parametro LDC_ENCOLA_SUSPENSIONES
                                          que indica si la compa?ia maneja encolamiento de suspensiones
                                          de cartera o no.
                                          En caso de que no se maneje encolamiento, no se genera orden
                                          de suspension por mora si el producto ya esta suspendido por otra
                                          area, por el contrario, se crea una orden en estado "Cerrada" para
                                          dejar trazabilidad y NO se cambia estados de corte ni se registra
                                          la suspension en el producto y los componentes.
                                          Se crea el procedimiento encapsulado GenerateClosedOrder.
    10-10-2014        acardenas.NC2942    Se modifica el criterio "Financiaciones al a?o"
                                          por "Refinanciacion Vigente", para indicar si el
                                          producto tiene una refinanciacion con saldo, esto es
                                          necesario para la suspension de los refianciados con una
                                          cuenta mientras la refinanciacion tiene saldo.
                                          Se modifica el criterio "Cuentas con Saldo" para que
                                          obtenga correctamente el numero de cuentas vencidas.
                                          Se modifica el modelo de validacion de criterios
                                          para que valide que si el producto cumple con una
                                          configuracion particular aplique el criterio de cuentas,
                                          saldo corriente, saldo diferido y refinanciacion vigente.
    01-10-2014        agordillo.RQ1004    Se adiciona logica para soportar el criterio
                                          de cuentas con saldo
    11-04-2012        lgranada.SAO179856  Creacion
    ******************************************************************/


    -- Registro con informacion del proceso actual
    rcCurrentInstance      pkSuspConnService.tyMemoryVar;
    -- Identificador del Producto
    nuNumeServ             servsusc.sesunuse%type;
    -- Identificador de la categoria del producto
    nuCategory             servsusc.sesucate%type;
    -- Identificador de la subCategoria del producto
    nuSubCategory          servsusc.sesusuca%type;
    -- Identificador del Estado de corte del producto
    nuCutStatus            servsusc.sesuesco%type;
    -- Identificador del Ciclo de Facturacion del producto
    nuBillCycle            servsusc.sesucicl%type;
    -- Identificador del departamento asociado a la direccion del producto
    nuDepartment           ge_geogra_location.geograp_location_id%type;
    -- Identificador de la localidad asociada a la direccion del producto
    nuLocality             ge_geogra_location.geograp_location_id%type;
    -- Identificador del barrio asociado a la direccion del producto
    nuNeighborthood        ge_geogra_location.geograp_location_id%type;
    -- Identificador del sector operativo asociado a la localidad del producto
    nuOperatingSector      ge_geogra_location.operating_sector_id%type;
    -- Identificador del Estado del producto
    nuProductStatus        pr_product.product_status_id%type;
    -- Deuda Corriente asociada al producto
    nuProductBalance       cuencobr.cucosacu%type;
    -- Deuda Vencida asociada al producto
    nuProductExpBalance    cuencobr.cucosacu%type;
    -- Estado Financiero del Producto
    sbFinancialStatus      servsusc.sesuesfn%type;
    -- Refinanciacion vigente
    nuCurrentRefinan       number;
    -- Numero de cuentas vencidas
    nuAccountsbalance      number:= 0;
    -- Indicador de encolamiento de suspensiones
    sbEncolamiento         ld_parameter.value_chain%type;

    -- Flag: Determina si el producto debe ser suspendido
    boSuspendProduct       boolean;

    dtCuentaReciente       date; --NLCZ

    csbEntrega2002085          CONSTANT VARCHAR2(100) := 'BSS_CAR_FCF_2002085_3';
    csbEntrega2002722	CONSTANT VARCHAR2(100) := 'BSS_CAR_HJM_2002722_1';

    /*****************************************************************
    Propiedad intelectual Proyecto PETI.

    Unidad         : GenerateClosedOrder
    Descripcion    : Procedimiento encapsulado encargado de generar orden de suspension cerrada
                     en caso de NO realizar encolamiento de suspensiones, que el producto este
                     suspendido por otra area y que cumpla con los criterios de suspension definidos.
    Autor          : Alejandro Cardenas Cardona
    Fecha          : 31-10-2014

    Historia de Modificaciones
    Fecha             Autor                 Modificacion
    31-10-2014        acardenas.NC3484      Creacion
    */

    PROCEDURE GenerateClosedOrder
    (
        inuproductId    in      servsusc.sesunuse%type
    )
    IS
        /* Fecha de la utima orden de traza */
        dtTraceOrderDate    date;
        /* Informacion parametrizada para las ordenes de traza */
        sbTraceOrderData    varchar2(2000);
        /* Actividad parametrizada para las ordenes de traza */
        nuTraceActivity     ge_items.items_id%type;
        /* Unidad de trabajo parametrizada para las orden de traza */
        nuOperatingUnit     or_order.operating_unit_id%type;
        /* Direccion de instalacion del producto */
        nuAddressId         pr_product.address_id%type;
        /* Identificador de la persona parametrizada */
        nuPersonId          or_order_person.person_id%type;
        /* Causal de legalizacion */
        nuCausalId          ge_causal.causal_id%type;
        /* Identificador de la orden de traza generada */
        nuOrderId           or_order.order_id%type;
        /* Clase de Causal */
        nuClassCausal       ge_causal.class_causal_id%type;
        /* Cantidad a legalizar */
        nuItemAmount        OR_order_items.legal_item_amount%type;
        /* Tabla: Datos extraidos de la informacion parametrizada */
        tbTraceOrderData    ut_string.TyTb_String;
        /* Codigo del error */
        nuErrorCode         ge_message.message_id%type;
        /* Mensaje de error */
        sbErrorMessage     ge_error_log.description%type;

        CURSOR cuLastDateOrder
        (
           inuproduct   pr_product.product_id%type,
           inuCausal    OR_order.causal_id%type
        )
        IS
           SELECT   max(created_Date) legal_date
           FROM     OR_order, OR_order_activity
           WHERE    OR_order.order_id = OR_order_activity.order_id
                    AND OR_order.causal_id = inuCausal
                    AND OR_order_activity.product_id = inuproduct
                    AND OR_order.order_status_id = 8;  -- Estado "Cerrada"

        PRAGMA AUTONOMOUS_TRANSACTION;

    BEGIN
    --{
        ut_trace.Trace('Inicio ValSuspensionCriterion.GenerateClosedOrder',4);
        ut_trace.Trace('Producto['||inuProductId||']',5);

        /* Se obtiene la informacion de la orden de traza del valor del parametro LDC_ORDEN_TRAZA_SUSP*/
        sbTraceOrderData := dald_parameter.fsbGetValue_Chain('LDC_ORDEN_TRAZA_SUSP');
        ut_string.ExtString(sbTraceOrderData,'|',tbTraceOrderData);

        /* Extrae informacion de la actividad de traza */
        if(tbTraceOrderData.EXISTS(1)) then
            nuTraceActivity := to_number(tbTraceOrderData(1));
            ut_trace.Trace('Actividad de traza['||nuTraceActivity||']',5);
        end if;

        /* Extrae informacion de la unidad operativa */
        if(tbTraceOrderData.EXISTS(2)) then
            nuOperatingUnit := to_number(tbTraceOrderData(2));
            ut_trace.Trace('Unidad Operativa['||nuOperatingUnit||']',5);
        end if;

        /* Extrae informacion de la persona */
        if(tbTraceOrderData.EXISTS(3)) then
            nuPersonId := to_number(tbTraceOrderData(3));
            ut_trace.Trace('Persona que Legaliza['||nuPersonId||']',5);
        end if;

        /* Extrae informacion de la causal */
        if(tbTraceOrderData.EXISTS(4)) then
            nuCausalId := to_number(tbTraceOrderData(4));
            ut_trace.Trace('Causal de Legalizacion['||nuCausalId||']',5);
        end if;

        -- Verifica si el CURSOR esta abierto
        if  cuLastDateOrder%isopen then
            close cuLastDateOrder;
        END if;

        /* Obtiene la fecha de la ultima orden de traza para el producto */
        open    cuLastDateOrder(inuProductId,nuCausalId);
        fetch   cuLastDateOrder INTO dtTraceOrderDate;
        close   cuLastDateOrder;

        ut_trace.Trace('Fecha de la ultima orden de traza['||dtTraceOrderDate||']',5);

        /* Si no existe orden de traza para el producto, o ya han transcurridos 30 dias
           desde la ultima orden generada. Crea la orden cerrada */
        if (dtTraceOrderDate is null) OR ((sysdate - dtTraceOrderDate) >= 30)
        then
            /* Obtiene la direccion de instalacion del producto */
            nuAddressId := dapr_product.fnuGetAddress_Id(inuProductId);
            ut_trace.Trace('Direccion Instalacion Producto['||nuAddressId||']',5);

            -- Establece cantidad a legalizar dependiendo de la clase de causal
            nuClassCausal   :=  dage_causal.fnugetclass_causal_id(nuCausalId);

            if  nuClassCausal = ge_boconstants.cnuTRUE then
                nuItemAmount := ge_boconstants.cnuTRUE;
            else
                nuItemAmount := ge_boconstants.cnuFALSE;
            END if;

            -- se llama al metodo encargado de validar los datos para la
            -- creacion de la orden de traza.
            or_boorder.ValidCloseOrderData
            (
                 inuOperUnitId=>nuOperatingUnit,
                 inuActivity=>nuTraceActivity,
                 inuAddressId=>nuAddressId,
                 idtFinishDate=>sysdate,
                 inuItemAmount=>nuItemAmount,
                 inuRefValue=>null,
                 inuCausal=>nuCausalId,
                 inuRelationType=>null,
                 ionuOrderId=>nuOrderId,
                 inuOrderRelaId=>null,
                 inuCommentTypeId=>null,
                 isbComment=>null,
                 inuPersonId=>nuPersonId
            );

            -- Se crea la orden de traza cerrada.
            or_boorder.CloseOrderWithProduct
            (
                 inuOperUnitId=>nuOperatingUnit,
                 inuActivity=>nuTraceActivity,
                 inuAddressId=>nuAddressId,
                 idtFinishDate=>sysdate,
                 inuItemAmount=>nuItemAmount,
                 inuRefValue=>null,
                 inuCausalId=>nuCausalId,
                 inuRelationType=>null,
                 ionuOrderId=>nuOrderId,
                 inuOrderRelaId=>null,
                 inuCommentTypeId=>null,
                 isbComment=>null,
                 inuPersonId=>nuPersonId,
                 inuProductId => inuProductId
            );

            ut_trace.Trace('Orden de Traza['||nuOrderId||']',5);

            /* Realiza persistencia en base de datos */
            pkgeneralservices.committransaction;

        END if;

        ut_trace.Trace('Fin ValSuspensionCriterion.GenerateClosedOrder',4);

    EXCEPTION
        when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then
            raise;
        when OTHERS then
            Errors.SetError;
            raise ex.CONTROLLED_ERROR;
    END GenerateClosedOrder;

BEGIN

    ut_trace.trace('Inicio Procedimiento ValSuspensionCriterion', 5);

    -- Obtiene los datos de la instancia actual a procesar
    rcCurrentInstance := pkSuspConnService.frcGetInstanceData;

    -- Obtiene el identificador del Producto
    nuNumeServ := rcCurrentInstance.nuNumeServ;

    -- Obtiene la Categoria del Producto
    nuCategory := pr_bosuspendcriterions.fnuGetServiceCategory (nuNumeServ);

    -- Obtiene la SubCategoria del Producto
    nuSubCategory := pr_bosuspendcriterions.fnuGetServiceSubCateg (nuNumeServ);

    -- Obtiene el Estado de Corte del Producto
    nuCutStatus := pr_bosuspendcriterions.fnuGetServiceCutState (nuNumeServ);

    -- Obtiene el Ciclo de Facturacion del Producto
    nuBillCycle := pr_bosuspendcriterions.fnuGetServiceBillCycle (nuNumeServ);

    -- Obtiene el Departamento asociado a la direccion del producto
    nuDepartment := pr_bosuspendcriterions.fnuGetProductDepartmen (nuNumeServ);

    -- Si no existe Departamento asigna por defecto 0
    if nuDepartment IS null then
       nuDepartment := 0;
    END if;

    -- Obtiene la Localidad asociada a la direccion del producto
    nuLocality := pr_bosuspendcriterions.fnuGetProductLocality (nuNumeServ);

    -- Si no existe Localidad asigna por defecto 0
    if nuLocality IS null then
       nuLocality := 0;
    END if;

    -- Obtiene el Barrio asociado a la direccion del producto
    nuNeighborthood := pr_bosuspendcriterions.fnuGetProductNeighbort (nuNumeServ);

    -- Si no existe Barrio asigna por defecto 0
    if nuNeighborthood IS null then
       nuNeighborthood := 0;
    END if;

    -- Obtiene el Sector operativo asociado a la localidad del producto
    nuOperatingSector := pr_bosuspendcriterions.fnuGetProductOperSect (nuNumeServ);

    -- Si no existe Sector Operativo por localidad asigna el sector por defecto 0
    if nuOperatingSector IS null then
       nuOperatingSector := 0;
    END if;

    -- Obtiene el Estado del producto
    nuProductStatus := pr_bosuspendcriterions.fnuGetProductStatus (nuNumeServ);

    -- Obtiene la Deuda corriente asociada al Producto
    nuProductBalance := pr_bosuspendcriterions.fnuGetProductBalance (nuNumeServ);

    -- Obtiene la Deuda Vencida asociada al Producto
    nuProductExpBalance := pr_bosuspendcriterions.fnuGetProductExpBalanc (nuNumeServ);

    -- Obtiene el Estado Financiero del Producto
    sbFinancialStatus := pr_bosuspendcriterions.fsbGetFinancialStatus (nuNumeServ);

    -- Obtiene el indicador de refinanciacion con saldo del producto
    nuCurrentRefinan :=  pkboValidSuspCrit.fnuCurrentRefinan(nuNumeServ);

    -- Obtiene el numero de periodos del producto con al menos una cuenta vencida
    -- CA 200-2085
    IF OPEN.fblAplicaEntrega(csbEntrega2002085) THEN
       nuAccountsbalance := pkbovalidsuspcrit.fnuNroCuentasVenc(nuNumeServ);
    ELSE
       nuAccountsbalance := pkboexpiredaccounts.fnuperiodswithexpaccounts(nuNumeServ);
    END IF;

    -- agordillo RQ1004 PETI se realiza el paso parametro del nuAccountsbalance
    -- asociado al criterio del campo CRSUCOPA.CSCPCACC

    -- CA-200-596
    -- Obtiene la fecha de vencimiento de la cuenta de cobro mas reciente
    dtCuentaReciente := pkbovalidsuspcrit.fdtGetFecVenCuenCobro(nuNumeServ);

    -------------

    /* Valida los criterios definidos para suspension del producto  */
    boSuspendProduct := pkbovalidsuspcrit.fboValidateSuspendCrit ( nuCategory,
                                                                   nuSubCategory,
                                                                   nuCutStatus,
                                                                   nuBillCycle,
                                                                   nuDepartment,
                                                                   nuLocality,
                                                                   nuNeighborthood,
                                                                   nuOperatingSector,
                                                                   nuProductStatus,
                                                                   nuProductBalance,
                                                                   nuProductExpBalance,
                                                                   sbFinancialStatus,
                                                                   nuCurrentRefinan,
                                                                   nuAccountsbalance,
                                                                   dtCuentaReciente -- CA-200-596
                                                                   );

    /* Si el producto no cumple con ninguno de los grupos de criterios configurados, se detiene el proceso de
       suspension */
    if ( not boSuspendProduct ) then
        ut_trace.trace('Fin Procedimiento ValSuspensionCriterion - No Suspender Producto por Criterios', 5);
        -- El producto %s1 no cumple con los criterios configurados para suspension
        Errors.SetError (901467, nuNumeServ);
        raise ex.CONTROLLED_ERROR;
    end if;

    /* Valida si el producto se encuentra en consumo cero */

   /*200-2722: Se agrega condición para validar si el cambio 200-2272 aplica. Este cambio deshabilita la validación del proceso de consumo cero */
   IF NOT OPEN.fblAplicaEntrega(csbEntrega2002722) THEN
	    boSuspendProduct := pkbovalidsuspcrit.fboValidateZeroCons(nuNumeServ);

	    /* Si el producto se encuentra en consumo cero, se detiene el proceso de suspension */
	    if (boSuspendProduct) then
	        ut_trace.trace('Fin Procedimiento ValSuspensionCriterion - No Suspender Producto por Consumo cero', 5);
	        -- No se puede continuar con el proceso de suspension para el producto %s1
	        Errors.SetError (901468, nuNumeServ);
	        raise ex.CONTROLLED_ERROR;
	    end if;
    END IF;

    /* En este punto el producto cumple con TODOS los criterios de Suspension */

    -- Obtiene el indicador de encolamiento de suspensiones
    sbEncolamiento := dald_parameter.fsbGetValue_Chain('LDC_ENCOLA_SUSPENSIONES');

    /*  Si no se realiza encolamiento de suspensiones y el producto ya esta suspendido,
        se genera una orden cerrada y se retorna error
    */

    IF sbEncolamiento = 'N' AND nuProductStatus = 2 then
        -- Genera orden de traza por encolamiento
        GenerateClosedOrder(nuNumeServ);

        ut_trace.trace('Fin Procedimiento ValSuspensionCriterion - No Suspender Producto por encolamiento', 5);
        Errors.SetError (2741, 'No se realiza encolamiento de suspensiones. El producto ['||nuNumeServ||'] se encuentra suspendido por otra area.');
        raise ex.CONTROLLED_ERROR;
    END if;

    ut_trace.trace('Fin Procedimiento ValSuspensionCriterion - Suspender Producto', 5);

    RETURN;

EXCEPTION

    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;

    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;

END ValSuspensionCriterion;
/
GRANT EXECUTE on VALSUSPENSIONCRITERION to SYSTEM_OBJ_PRIVS_ROLE;
GRANT EXECUTE on VALSUSPENSIONCRITERION to REXEOPEN;
GRANT EXECUTE on VALSUSPENSIONCRITERION to RSELSYS;
/
