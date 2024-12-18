CREATE OR REPLACE FUNCTION "ADM_PERSON"."FSBVALCRITADICRECONEX" 
(
    inuProductId    pr_product.product_id%type
)
return varchar2
IS
/*
    Propiedad intelectual PETI. (c).

    Procedure	: fsbValCritAdicReconex

    Descripcion	: Determina si un producto cumple con los criterios adicionales
                  de reconexión.
                  Para evaluar los criterios adicionales de reconexión se verifica
                  que el producto NO cumpla con los criterios de suspensión definidos.

    Parametros	:
    Retorno     :

    Autor	: Alejandro Cárdenas C.
    Fecha	: 02-02-2015

    Historia de Modificaciones
    ----------------------------------------------------------------------------
    Fecha           Autor                       Descripción
    ----------------------------------------------------------------------------
    24-04-2015      acardenas.SAO313388         Se modifica el CURSOR cuExpiredAccounts
                                                para que se consulte únicamente las
                                                cuentas de cobro vencidas.
    02-02-2015      acardenas.Aranda135753      Creación.

*/
    -- Registro con información del proceso actual
    rcCurrentInstance      pkSuspConnService.tyMemoryVar;
    -- Identificador del Producto
    nuNumeServ             servsusc.sesunuse%type;
    -- Identificador de la categoría del producto
    nuCategory             servsusc.sesucate%type;
    -- Identificador de la subCategoría del producto
    nuSubCategory          servsusc.sesusuca%type;
    -- Identificador del Estado de corte del producto
    nuCutStatus            servsusc.sesuesco%type;
    -- Identificador del Ciclo de Facturación del producto
    nuBillCycle            servsusc.sesucicl%type;
    -- Identificador del departamento asociado a la dirección del producto
    nuDepartment           ge_geogra_location.geograp_location_id%type;
    -- Identificador de la localidad asociada a la dirección del producto
    nuLocality             ge_geogra_location.geograp_location_id%type;
    -- Identificador del barrio asociado a la dirección del producto
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
    -- Refinanciación vigente
    nuCurrentRefinan       number;
    -- Número de cuentas vencidas
    nuAccountsbalance      number:= 0;
    -- Determina si el producto cumple con los criterios adicionales de suspensión
    boSuspendProduct       boolean;
    -- Determina si el producto cumple con el criterio general de suspensión
    boGeneralSuspProd      boolean;

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

    -- Función Encapsulada para determinar si el producto cumple con el criterio
    -- general de suspensión

    FUNCTION fboValGeneralSuspCrit
    return  boolean
    IS
        boSuspenProd    boolean := FALSE;
        nuCriterSusp    number;
    BEGIN
        -- obtiene el criterio de suspensión general para GAS
        nuCriterSusp := pktblconfcose.fnugetmaxnumsusacc(7014);

        -- Verifica si el producto cumple con el criterio de Suspensión
        if  nuAccountsbalance >= nuCriterSusp then
            boSuspenProd := TRUE;
        END if;

        return  boSuspenProd;

    EXCEPTION
    WHEN pkg_error.controlled_error THEN
        RAISE pkg_error.controlled_error;
    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE pkg_error.controlled_error;
    END fboValGeneralSuspCrit;



BEGIN
    UT_TRACE.TRACE( 'Inicio Procedimiento fsbValCritAdicReconex', 5 );

    -- Obtiene el identificador del Producto
    nuNumeServ := inuProductId;
    UT_TRACE.TRACE( 'Producto ['||nuNumeServ||']', 6 );

    -- Obtiene la Categoría del Producto
    nuCategory := pr_bosuspendcriterions.fnuGetServiceCategory (nuNumeServ);
    UT_TRACE.TRACE( 'Categoria ['||nuCategory||']', 6 );

    -- Obtiene la SubCategoría del Producto
    nuSubCategory := pr_bosuspendcriterions.fnuGetServiceSubCateg (nuNumeServ);
    UT_TRACE.TRACE( 'Subcategoria ['||nuSubCategory||']', 6 );

    -- Obtiene el Estado de Corte del Producto
    nuCutStatus := pr_bosuspendcriterions.fnuGetServiceCutState (nuNumeServ);
    UT_TRACE.TRACE( 'Estado de Corte ['||nuCutStatus||']', 6 );

    -- Obtiene el Ciclo de Facturación del Producto
    nuBillCycle := pr_bosuspendcriterions.fnuGetServiceBillCycle (nuNumeServ);
    UT_TRACE.TRACE( 'Ciclo ['||nuBillCycle||']', 6 );

    -- Obtiene el Departamento asociado a la dirección del producto
    nuDepartment := pr_bosuspendcriterions.fnuGetProductDepartmen (nuNumeServ);
    UT_TRACE.TRACE( 'Departamento ['||nuDepartment||']', 6 );

    -- Si no existe Departamento asigna por defecto 0
    if nuDepartment IS null then
       nuDepartment := 0;
    END if;

    -- Obtiene la Localidad asociada a la dirección del producto
    nuLocality := pr_bosuspendcriterions.fnuGetProductLocality (nuNumeServ);
    UT_TRACE.TRACE( 'Localidad ['||nuLocality||']', 6 );

    -- Si no existe Localidad asigna por defecto 0
    if nuLocality IS null then
       nuLocality := 0;
    END if;

    -- Obtiene el Barrio asociado a la dirección del producto
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

    -- Obtiene el indicador de refinanciación con saldo del producto
    nuCurrentRefinan :=  pkboValidSuspCrit.fnuCurrentRefinan(nuNumeServ);
    UT_TRACE.TRACE( 'Indicador Refinanciación Con Saldo ['||nuCurrentRefinan||']', 6 );

    -- Obtiene el número de periodos del producto con al menos una cuenta vencida
    open    cuExpiredAccounts(nuNumeServ);
    fetch   cuExpiredAccounts INTO nuAccountsbalance;
    close   cuExpiredAccounts;

    UT_TRACE.TRACE( 'Periodos Vencidos ['||nuAccountsbalance||']', 6 );

    /* Valida los criterios adicionales para suspensión del producto  */
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

    -- Verifica si el producto no cumple con el criterio general de suspensión
    boGeneralSuspProd :=  fboValGeneralSuspCrit;

    -- Si el producto SI cumple con el criterio general de suspensión y SI cumple
    -- con el criterio adicional de suspensión, NO se genera la reconexión, en caso
    -- contrario el proceso de Reconexión continua normalmente.

    if boGeneralSuspProd then
        UT_TRACE.TRACE('Criterio de Suspensión General [TRUE]', 6 );
    else
        UT_TRACE.TRACE('Criterio de Suspensión General [FALSE]', 6 );
    END if;

    if boSuspendProduct then
        UT_TRACE.TRACE('Criterio de Suspensión Adicional [TRUE]', 6 );
    else
        UT_TRACE.TRACE('Criterio de Suspensión Adicional [FALSE]', 6 );
    END if;

    if (boSuspendProduct AND boGeneralSuspProd) then
        UT_TRACE.TRACE('El producto ['||nuNumeServ||'] no cumple con los criterios adicionales de Reconexión', 5 );
        RETURN 'N';
    END if;

    UT_TRACE.TRACE( 'Fin Procedimiento fsbValCritAdicReconex', 5 );

    RETURN 'Y';

EXCEPTION
    WHEN pkg_error.controlled_error THEN
        RAISE pkg_error.controlled_error;
    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE pkg_error.controlled_error;
END fsbValCritAdicReconex;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('FSBVALCRITADICRECONEX', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.FSBVALCRITADICRECONEX TO REXEREPORTES;
/

