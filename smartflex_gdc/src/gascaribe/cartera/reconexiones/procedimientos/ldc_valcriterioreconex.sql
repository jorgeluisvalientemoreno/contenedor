CREATE OR REPLACE PROCEDURE OPEN.LDC_ValCriterioReconex
IS
/*
    Propiedad intelectual PETI. (c).

    Procedure	: LDC_ValCriterioReconex

    Descripcion	: Determina si un producto cumple con los criterios adicionales
                  de reconexion.
                  Para evaluar los criterios adicionales de reconexion se verifica
                  que el producto NO cumpla con los criterios de suspension definidos.

    Parametros	:
    Retorno     :

    Autor	: Alejandro Cardenas C.
    Fecha	: 16-12-2014

    Historia de Modificaciones
    ----------------------------------------------------------------------------
    Fecha           Autor                   Descripcion
    ----------------------------------------------------------------------------
    30-01-2023      cgonzalez               OSF-840: se adiciona validacion de si un producto tiene ordenes abiertas de tipo de 
											trabajo configurado en parametro COD_TASK_NO_RX no permita generar reconexion.
	07-04-2022      cgonzalez               OSF-194: se adiciona validacion de si un producto tiene saldo de cartera
                                            castigada se debe levantar el error.
    12-02-2015      acardenas.Aranda140438  Se modifica para evaluar las causales
                                            definidas por parametro para NO generar
                                            orden de reconexion si no han transcurrido N
                                            dias.
    16-12-2014      acardenas.NC4383        Creacion.
*/
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
    -- Determina si el producto cumple con los criterios adicionales de suspension
    boSuspendProduct       boolean;
    -- Determina si el producto cumple con el criterio general de suspension
    boGeneralSuspProd      boolean;

    -- Variable para almacenar valor del parametro LDC_CAUSAL_NO_RECONEX
    sbCausalesNoRecon      LD_PARAMETER.value_chain%type;
    -- Fecha de creacion de la ultima orden de reconexion
    dtCreatedDate          OR_order.created_date%type;
    -- Numero de dias para generar reconexion
    nuReconDays            ld_parameter.numeric_value%type;
    -- Tipos de trabajo de reconexion por pago
    sbTaskTypeRecon        LD_PARAMETER.value_chain%type;
    
    nuSaldoCastigado       number;
    
    -- CURSOR para obtener periodos vencidos
    cursor cuExpiredAccounts( inuProduct  in  cuencobr.cuconuse%type)
    IS
        SELECT /*+ leading( cuencobr )
                   index( cuencobr IX_CUENCOBR09 )
                   index( factura  PK_FACTURA )*/
               count(distinct factpefa)
        FROM   cuencobr,factura
        WHERE  cuconuse = inuProduct
          AND  (nvl(cucosacu,0) - (nvl(cucovare, 0 ) + nvl(cucovrap, 0))) > 0
          AND  cucofact = factcodi
          AND  cucofeve < sysdate;

    -- CURSOR para obtener la ultima actividad de reconexion legalizada con fallo
    CURSOR cuLastReconOrder( inuProduct     in  OR_order_Activity.product_id%type,
                             sbTaskTypes    in  ld_parameter.value_chain%type,
                             sbCausales     in  ld_parameter.value_chain%type
                            )
    IS
        SELECT  max(ord.created_date)
        FROM    OR_order_Activity act, OR_order ord
        WHERE   ord.order_status_id = 8     -- Estado Cerrada
                AND instr(sbTaskTypes, to_char(ord.task_Type_id)) > 0
                AND instr(sbCausales,  to_char(ord.causal_id)) > 0
                AND act.order_id = ord.order_id
                AND act.product_id = inuProduct;
                
    --Cursor para obtener saldo de cartera castigada
    CURSOR cuSaldoCastigada(inuProducto IN servsusc.sesunuse%type) IS
        SELECT  SUM(t.PRPCSACA - t.PRPCSARE)
        FROM    open.gc_prodprca t
        WHERE   t.prpcnuse = inuProducto;

    -- Funcion Encapsulada para determinar si el producto cumple con el criterio
    -- general de suspension

    FUNCTION fboValGeneralSuspCrit
    return  boolean
    IS
        boSuspenProd    boolean := FALSE;
        nuCriterSusp    number;
    BEGIN
        -- obtiene el criterio de suspension general para GAS
        nuCriterSusp := pktblconfcose.fnugetmaxnumsusacc(7014);

        -- Verifica si el producto cumple con el criterio de Suspension
        if  nuAccountsbalance >= nuCriterSusp then
            boSuspenProd := TRUE;
        END if;

        return  boSuspenProd;

    EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;
    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
    END fboValGeneralSuspCrit;

BEGIN
    UT_TRACE.TRACE( 'Inicio Procedimiento LDC_ValCriterioReconex', 5 );

    -- Obtiene los datos de la instancia actual a procesar
    rcCurrentInstance := pkSuspConnService.frcGetInstanceData;

    -- Obtiene el identificador del Producto
    nuNumeServ := rcCurrentInstance.nuNumeServ;
    UT_TRACE.TRACE( 'Producto ['||nuNumeServ||']', 6 );

    -- Obtiene la Categoria del Producto
    nuCategory := pr_bosuspendcriterions.fnuGetServiceCategory (nuNumeServ);
    UT_TRACE.TRACE( 'Categoria ['||nuCategory||']', 6 );

    -- Obtiene la SubCategoria del Producto
    nuSubCategory := pr_bosuspendcriterions.fnuGetServiceSubCateg (nuNumeServ);
    UT_TRACE.TRACE( 'Subcategoria ['||nuSubCategory||']', 6 );

    -- Obtiene el Estado de Corte del Producto
    nuCutStatus := pr_bosuspendcriterions.fnuGetServiceCutState (nuNumeServ);
    UT_TRACE.TRACE( 'Estado de Corte ['||nuCutStatus||']', 6 );

    -- Obtiene el Ciclo de Facturacion del Producto
    nuBillCycle := pr_bosuspendcriterions.fnuGetServiceBillCycle (nuNumeServ);
    UT_TRACE.TRACE( 'Ciclo ['||nuBillCycle||']', 6 );

    -- Obtiene el Departamento asociado a la direccion del producto
    nuDepartment := pr_bosuspendcriterions.fnuGetProductDepartmen (nuNumeServ);
    UT_TRACE.TRACE( 'Departamento ['||nuDepartment||']', 6 );

    -- Si no existe Departamento asigna por defecto 0
    if nuDepartment IS null then
       nuDepartment := 0;
    END if;

    -- Obtiene la Localidad asociada a la direccion del producto
    nuLocality := pr_bosuspendcriterions.fnuGetProductLocality (nuNumeServ);
    UT_TRACE.TRACE( 'Localidad ['||nuLocality||']', 6 );

    -- Si no existe Localidad asigna por defecto 0
    if nuLocality IS null then
       nuLocality := 0;
    END if;

    -- Obtiene el Barrio asociado a la direccion del producto
    nuNeighborthood := pr_bosuspendcriterions.fnuGetProductNeighbort (nuNumeServ);
    UT_TRACE.TRACE( 'Barrio ['||nuNeighborthood||']', 6 );

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

    UT_TRACE.TRACE( 'Sector Operativo ['||nuOperatingSector||']', 6 );

    -- Obtiene el Estado del producto
    nuProductStatus := pr_bosuspendcriterions.fnuGetProductStatus (nuNumeServ);
    UT_TRACE.TRACE( 'Estado del Producto ['||nuProductStatus||']', 6 );

    -- Obtiene la Deuda corriente asociada al Producto
    nuProductBalance := pr_bosuspendcriterions.fnuGetProductBalance (nuNumeServ);
    UT_TRACE.TRACE( 'Deuda Corriente ['||nuProductBalance||']', 6 );

    -- Obtiene la Deuda Vencida asociada al Producto
    nuProductExpBalance := pr_bosuspendcriterions.fnuGetProductExpBalanc (nuNumeServ);
    UT_TRACE.TRACE( 'Saldo Vencido ['||nuProductExpBalance||']', 6 );

    -- Obtiene el Estado Financiero del Producto
    sbFinancialStatus := pr_bosuspendcriterions.fsbGetFinancialStatus (nuNumeServ);
    UT_TRACE.TRACE( 'Estado Financiero ['||sbFinancialStatus||']', 6 );

    -- Obtiene el indicador de refinanciacion con saldo del producto
    nuCurrentRefinan :=  pkboValidSuspCrit.fnuCurrentRefinan(nuNumeServ);
    UT_TRACE.TRACE( 'Indicador Refinanciacion Con Saldo ['||nuCurrentRefinan||']', 6 );

    -- Obtiene el numero de periodos del producto con al menos una cuenta vencida

    open    cuExpiredAccounts(nuNumeServ);
    fetch   cuExpiredAccounts INTO nuAccountsbalance;
    close   cuExpiredAccounts;

    UT_TRACE.TRACE( 'Periodos Vencidos ['||nuAccountsbalance||']', 6 );

    /* Valida los criterios adicionales para suspension del producto  */
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
                                                                   nuAccountsbalance
                                                                 );

    -- Verifica si el producto no cumple con el criterio general de suspension
    boGeneralSuspProd :=  fboValGeneralSuspCrit;

    -- Si el producto SI cumple con el criterio general de suspension y SI cumple
    -- con el criterio adicional de suspension, NO se genera la reconexion, en caso
    -- contrario el proceso de Reconexion continua normalmente.

    if boGeneralSuspProd then
        UT_TRACE.TRACE('Criterio de Suspension General [TRUE]', 6 );
    else
        UT_TRACE.TRACE('Criterio de Suspension General [FALSE]', 6 );
    END if;

    if boSuspendProduct then
        UT_TRACE.TRACE('Criterio de Suspension Adicional [TRUE]', 6 );
    else
        UT_TRACE.TRACE('Criterio de Suspension Adicional [FALSE]', 6 );
    END if;

    if (boSuspendProduct AND boGeneralSuspProd) then
        UT_TRACE.TRACE('El producto ['||nuNumeServ||'] no cumple con los criterios adicionales de Reconexion', 5 );
        ERRORS.SETERROR( -1,'El producto ['||nuNumeServ||'] no cumple con los criterios adicionales de Reconexion' );
        RAISE EX.CONTROLLED_ERROR;
    END if;

    -- Aranda 140438
    /* En este punto el producto cumple todas las condiciones de reconexion, se evalua si la
       ultima orden de reconexion se legalizo con alguna de las causales definidas
       en el parametro LDC_CAUSAL_NO_RECONEX.
    */

    sbCausalesNoRecon := dald_parameter.fsbGetValue_Chain('LDC_CAUSAL_NO_RECONEX');
    -- Tipos de trabajo reconexion
    sbTaskTypeRecon   := dald_parameter.fsbGetValue_Chain('COD_TIPOS_TRABAJO_RECONEXION');

    if sbCausalesNoRecon IS not null then
        UT_TRACE.TRACE( 'Determina si debe generar orden pasados N dias', 6 );
        UT_TRACE.TRACE( 'Parametro LDC_CAUSAL_NO_RECONEX --> '||sbCausalesNoRecon, 6 );

        -- Obtiene fecha de la ultima orden de reconexion del producto legalizada con fallo
        if cuLastReconOrder%isopen then
            close cuLastReconOrder;
        END if;

        open    cuLastReconOrder(nuNumeServ,sbTaskTypeRecon,sbCausalesNoRecon);
        fetch   cuLastReconOrder INTO dtCreatedDate;
        close   cuLastReconOrder;

        UT_TRACE.TRACE( 'Fecha de la ultima orden de reconexion con fallo ['||dtCreatedDate||']', 6 );

        if  dtCreatedDate IS not null then
            -- Obtiene el numero de dias para generar reconexion
            nuReconDays := dald_parameter.fnuGetNumeric_Value('LDC_DIAS_RECONEX');
            UT_TRACE.TRACE( 'Dias para generar reconexion LDC_DIAS_RECONEX ['||nuReconDays||']', 6 );

            -- Determina si debe generar orden
            if trunc(pkgeneralservices.fdtgetsystemdate) - trunc(dtCreatedDate) <= nuReconDays then
                UT_TRACE.TRACE('No se genera orden para el producto ['||nuNumeServ||']. No cumple numero de dias para generar Reconexion', 5 );
                ERRORS.SETERROR( -1,'No se genera orden para el producto ['||nuNumeServ||']. No cumple numero de dias para generar Reconexion');
                RAISE EX.CONTROLLED_ERROR;
            END if;

        END if;

    END if;
    
    OPEN cuSaldoCastigada(nuNumeServ);
    FETCH cuSaldoCastigada INTO nuSaldoCastigado;
    CLOSE cuSaldoCastigada;
    
    UT_TRACE.TRACE('Saldo de cartera castigada ['||nuSaldoCastigado||']', 5 );
    
    IF (nuSaldoCastigado > 0) THEN
        UT_TRACE.TRACE('No se genera orden para el producto ['||nuNumeServ||']. Tiene ['||nuSaldoCastigado||'] de saldo de cartera castigada', 5 );
        ERRORS.SETERROR( -1,'No se genera orden para el producto ['||nuNumeServ||']. Tiene ['||nuSaldoCastigado||'] de saldo de cartera castigada');
        RAISE EX.CONTROLLED_ERROR;
    END IF;
	
	--OSF-840:  Validacion de tipos de trabajo
	ldc_vcriterioreconextr(nuNumeServ);

    UT_TRACE.TRACE( 'Fin Procedimiento LDC_ValCriterioReconex', 5 );

    RETURN;

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE EX.CONTROLLED_ERROR;
    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
END LDC_ValCriterioReconex;
/