CREATE OR REPLACE PACKAGE adm_person.LDC_BCSALESCOMMISSION_NEL is

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : LDC_BCSALESCOMMISSION_NEL
  Descripcion    : Se crea este sercivio copia de LDC_BCSALESCOMMISSION para aplicar al nuevo
                   esquema de liquidacion para contratistas.
  Autor          : Sebastian Tapias
  Fecha          : 23/10/2017
  Autor original             : Sayra Ocoro
  Fecha de creacion original : 08/03/2013

  Nota: Se dejaran comentarios de las actualizaciones y modificaciones realizadas sobre
  el paquete original (LDC_BCSALESCOMMISSION) para guias.

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================
  29-01-2018      Sebastian Tapias   REQ.200-1689 se modifica servicio <<LDC_FNUGETVLRTARIFA>>
  17-06-2020      OLsoftware         CA434: Se modifica <PrGenerateCommission> y <PrGenerateCommission_Hilos>
                                            Se crea <PROCREAOTADDTTGESTVENT>
  02-12-2020      OLsoftware         CA434: Se relacionan las ordenes de comision e index
  25-01-2023      jpinedc - MVM      OSF-839: Se modifican PROCREAOTADDTTGESTVENT,
                                              PrGenerateCommission, 
                                              PrGenerateCommission_Hilos
  01-02-2023      jpinedc - MVM      OSF-804: Se crea pProgramacion
                                              Se modifica ProcessGOPCV
  17-05-2023      jpinedc - MVM      OSF-1113: LDC_BCSALESCOMMISSION_NEL.PrGenerateCommission_Hilos 
                                              Se tiene en cuenta el tipo de asignación N para el
                                              cálculo del sector operativo auxiliar  
  20/06/2024      PAcosta            OSF-2845: Cambio de esquema ADM_PERSON                                                 
  30/07/2024      jpinedc            OSF-2973: * Ajustes por estándares
  05/08/2024      jpinedc            OSF-2973: * Se crean pIniCadenaJobsGOPCVNEL,
                                                pFinCadenaJobsGOPCVNEL,
                                                pProcCadJobsGOPCVNEL
  12/08/2024      jpinedc            OSF-2973: * Se reemplazan PKG_OR_ORDER.PRCACTUALIZADIRECCIONORDEN, 
                                                DAOR_ORDER_ACTIVITY.UPDADDRESS_ID y 
                                                PKG_OR_EXTERN_SYSTEMS_ID.PRCACTUALIZADIRECCEXTERNA
                                                por PKG_BOGESTION_ORDENES.PRCACTUALIZADIRECCION
                                                * Se reemplaza DAMO_PACKAGES.FDTGETREQUEST_DATE por
                                                PKG_BCSOLICITUDES.FDTGETFECHAREGISTRO                                                                                            
  18/06/2025      jpinedc            OSF-4555: * Se borra csbNitSurtigas
  ******************************************************************/

  TYPE RgCommissionRegister IS RECORD(
    onuCommissionValue mo_gas_sale_data.TOTAL_VALUE%type,
    sbIsZone           ldc_info_predio.is_zona%type,
    sbIsZoneOri        ldc_info_predio.is_zona%type
    );

  /*----------------------------------------------------------------
  |                 Variables Globales                              |
  ------------------------------------------------------------------*/

  nuActCIVZNR LDC_PKG_OR_ITEM.order_item_id%type := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ACT_COMISION_INICIO_VENTA_ZNR');
  nuActCIVZSR LDC_PKG_OR_ITEM.order_item_id%type := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ACT_COMISION_INICIO_VENTA_ZSR');
  nuActCIVZNC LDC_PKG_OR_ITEM.order_item_id%type := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ACT_COMISION_INICIO_VENTA_ZNC');
  nuActCIVZSC LDC_PKG_OR_ITEM.order_item_id%type := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ACT_COMISION_INICIO_VENTA_ZSC');
  nuActMZR    LDC_PKG_OR_ITEM.order_item_id%type := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ID_MULTA_VENTA_OTRA_ZONA_RESID');
  nuActMZC    LDC_PKG_OR_ITEM.order_item_id%type := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ID_MULTA_VENTA_OTRA_ZONA_COMM');

  nuRange     number := pkg_BCLD_Parameter.fnuObtieneValorNumerico('RANGO_COMISIONES_VENTA');
  nuActCLVZNR LDC_PKG_OR_ITEM.order_item_id%type := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ACT_COMISION_LEG_VENTA_ZNR');
  nuActCLVZSR LDC_PKG_OR_ITEM.order_item_id%type := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ACT_COMISION_LEG_VENTA_ZSR');
  nuActCLVZNC LDC_PKG_OR_ITEM.order_item_id%type := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ACT_COMISION_LEG_VENTA_ZNC');
  nuActCLVZSC LDC_PKG_OR_ITEM.order_item_id%type := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ACT_COMISION_LEG_VENTA_ZSC');

  nuPkgAtendido ps_package_type.package_type_id%type := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ID_ESTADO_PKG_ATENDTIDO');
  nuPkgAnulado  ps_package_type.package_type_id%type := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ID_ESTADO_PKG_ANULADA');

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : FnuGetCommissionValue
  Descripcion    : Funcion que retorna el valor de la comision de venta al inicio de acuerdo a la
     configuracion realizada en la forma CTCVE.
  Autor          : Sayra Ocoro
  Fecha          : 08/03/2013

  Metodos

  Nombre         :
  Parametros         Descripcion
  ============  ===================


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================
  ******************************************************************/
  function FnuGetCommissionValue(isbTime          IN varchar2,
                                 inuPackageId     IN mo_packages.package_id%type,
                                 inuAddressId     IN ab_address.address_id%type,
                                 inuProductid     IN pr_product.product_id%Type,
                                 inuOperatingUnit IN or_operating_unit.operating_unit_id%type)
    return RgCommissionRegister;
    /**************************************************************************
        Autor       : Olsoftware
        Fecha       : 27-08-2020
        Ticket      : CA434
        Descripcion : Valida si el proceso ya termino

        Parametros Entrada
         isbIdPrograma          Identificador del programa
         inuCantHilos           Cantidad de hilos

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR                       DESCRIPCION
        27/08/2020  OLsoftware.CA434              Creacion
   ***************************************************************************/
    PROCEDURE VerificaFinProceso
    (
        isbIdPrograma   IN   estaprog.esprprog%TYPE,
        inuCantHilos    IN   NUMBER
    );
  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : PrGenerateCommission
    Descripcion    : Procedimiento para generar comisiones por ventas al registro de la solicitud
    Autor          : Sayra Ocoro
    Fecha          : 08/03/2013

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  26/09/2013        emirol            se modifico toda la logica del paquete
    ******************************************************************/
  procedure PrGenerateCommission(isbProcessName IN estaprog.esprprog%type,
                                 indtCorte IN date,
                                 inuCurrentThread IN NUMBER,
                                 inuTotalThreads IN NUMBER);

  procedure PrGenerateCommission_Hilos (indtToday date,
                                        indtCorte date,
                                        indtBegin date,
                                        insbPackagesType varchar2,
                                        innuNroHilo number,
                                        innuTotHilos number,
                                        innusesion number,
                                        isbProcessName IN estaprog.esprprog%type,
                                        inuTotalRegistros IN NUMBER);
  procedure pro_grabalog_comision (inusesion number, idtfecha date, inuhilo number,
                                 inuresult number, isbobse varchar2);

  PROCEDURE ProcessGOPCV;
  /*Funcion que devuelve la version del pkg*/
  FUNCTION fsbVersion RETURN VARCHAR2;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : fnuGetPackagesVR
  Descripcion    : Funcion que valida si una solicitud pertence a un tipo de paquete que tiene asociada unas ot
                   en estado 7 u 8. Se usa en condicion de visualizacion solicitada en la NC 2046
  Autor          : Sayra Ocoro
  Fecha          : 05/12/2013

  Metodos

  Nombre         :
  Parametros         Descripcion
  ============  ===================


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================

  ******************************************************************/

  function fnuGetPackagesVR(inuPackagesId in mo_packages.package_id%type)
    return number;

  /*****************************************************************
    Propiedad intelectual de PETI.
    Unidad         : LDC_FNUGETVLRTARIFA
    Descripcion    : funcion que retorna el valor de la tarifa correspondiente al plan comercial de la solicitud.
    Autor          : Sebastian Tapias
    Fecha          : 23/10/2017

     Parametros              Descripcion
    ============         ===================

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    ******************************************************************/
    function LDC_FNUGETVLRTARIFA(inuPackageId in mo_packages.package_id%type)
    return number;
    
    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Unidad         : fblDemonioActivo
    Descripcion    : Indica si el demonio de SmartFlex esta activo
    Autor          : jpinedc - MVM
    Fecha          : 26/01/2023

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha           Autor             Modificacion
    =========       =========         ====================
    26/01/2023      jpinedc           OSF-839 - Creacion  
    ******************************************************************/     
    function fblDemonioActivo
    return BOOLEAN;
    
    -- Indica si el job de GOPCVNEL esta programado
    procedure pProgramacion
    (
        onuIdProgramacion   OUT ge_process_schedule.process_schedule_id%TYPE,
        odtFechaInicio      OUT ge_process_schedule.start_date_%TYPE,
        osbEstado           OUT ge_process_schedule.status%TYPE
    );
    
    -- Programa Inicial de la cadena de Jobs de GOPCVNEL
    PROCEDURE pIniCadenaJobsGOPCVNEL;

    -- Programa Final de la cadena de Jobs de GOPCVNEL
    PROCEDURE pFinCadenaJobsGOPCVNEL
    (
        inuProgramacion NUMBER, 
        inuCantIni NUMBER
    );

    -- Proceso de GOPCVNEL por medio de cadena de Jobs        
    PROCEDURE pProcCadJobsGOPCVNEL
    ( 
        isbProcessProg  VARCHAR2, 
        inuTotalThreads NUMBER,
        idtfecha        DATE, 
        inuProgramacion NUMBER,
        inuCantIni      NUMBER                 
    );    

    -- Proceso de un hilo de GOPCVNEL para ejecución por cadena de Jobs     
    procedure PrGenerateCommission2(isbProcessName IN estaprog.esprprog%type,
                                 isbtCorte IN VARCHAR2,
                                 inuCurrentThread IN NUMBER,
                                 inuTotalThreads IN NUMBER);                                     
end LDC_BCSALESCOMMISSION_NEL;
/

CREATE OR REPLACE PACKAGE BODY adm_person.LDC_BCSALESCOMMISSION_NEL is

    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;

    /*Variable global*/
    CSBVERSION CONSTANT varchar2(40) := 'OSF-4555';

    csbLDC_CONTRA_SIN_DIGIT_INDEX CONSTANT ld_parameter.value_chain%TYPE := pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_CONTRA_SIN_DIGIT_INDEX');
	
    gsbProgram           VARCHAR2(2000) := 'GOPCVNEL';	
	
	gsbChainJobsGOPCVNEL  VARCHAR2(30) := 'CADENA_JOBS_GOPCVNEL';
    
    gblpCargaParametros     BOOLEAN := FALSE;

    gnuLDC_NUM_HILOS_GOPCVNEL   NUMBER;

    TYPE TYRCPROGRAMA IS RECORD(
        PROGRAM_NAME VARCHAR2(100),
        PACKAGE VARCHAR2(100),
        API VARCHAR2(100),
        PROGRAM_TYPE VARCHAR2(50),
        BLOQUEPL VARCHAR2(4000),
        STEP VARCHAR2(50),
        PROGRAM_ACTION VARCHAR2(4000)
    );

    RCPROGRAMA TYRCPROGRAMA;

    TYPE TYtbSchedChainProg IS TABLE OF TYRCPROGRAMA INDEX BY BINARY_INTEGER;

    tbSchedChainProg  TYtbSchedChainProg;
    
    CURSOR cuCantExcep IS
    SELECT COUNT (1)
    FROM LDC_VENT_EXC_COMISION
    WHERE status_ = 'E';
    
    CURSOR cuEmail (isbMask IN sa_user.mask%TYPE)
    IS
    SELECT ge_person.e_mail
    FROM ge_person, sa_user
    WHERE ge_person.user_id = sa_user.user_id AND sa_user.mask = isbMask;        

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_BCSALESCOMMISSION_NEL
    Descripcion    : Se crea este sercivio copia de LDC_BCSALESCOMMISSION para aplicar al nuevo
                   esquema de liquidacion para contratistas.
    Autor          : Sebastian Tapias
    Fecha          : 23/10/2017
    Autor original             : Sayra Ocoro
    Fecha de creacion original : 08/03/2013

    Nota: Se dejaran comentarios de las actualizaciones y modificaciones realizadas sobre
    el paquete original (LDC_BCSALESCOMMISSION) para guias.

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    06-11-2013      Sayra Ocoro       Se modifica el metodo PrGenerateCommision para que las ordenes
                                      de comision generadas como comisiones sean vistas desde el proceso
                                      de liquidacion a contratistas -> Soluciona NC 1749
    05-12-2013       Sayra Ocoro       Se adiciona la funcion fnuGetPackagesVR para solucionar la NC 2046
    06-03-2014       Emiro Leyva       Aranda 3038 (Debe corregirse para que tome solo el valor de la venta antes de IVA.).
                                       Solucion: se busca el valor de la venta en la tabla cargos de todos los
                                       conceptos de la venta atravez de la funcion LDC_FNUGETVLRVENTA, recibe
                                       como parametro 'PP-' concatenado con el numero de la solicitud de la venta.
    01-04-2014      Sayra Ocoro        Aranda 3275:Se deben actualizar correctamente la direccion (Address_id)
                                       de la venta en los campos "External_address_id" de la entidad OR_ORDER y
                                       "Address_id" de la entidad OR_ORDER_ACTIVITY.
    20-01-2015      Gabriel Gamarra    NC 3968: Se modifica el metodo PrGenerateCommision.
                                      Se agrega validacion para que no procese las solicitudes del tipo
                                      100271 - Venta de Gas Formulario Migracion en la etapa de registro.
    05-02-2016      Francisco Castro  Caso 100.7353: Se implementa funcionalidad para ejecutar el proceso
                                     por hilos
    29-01-2018      Sebastian Tapias   REQ.200-1689 se modifica servicio <<LDC_FNUGETVLRTARIFA>>

    17-06-2020      OLsoftware         CA434: Se modifica <PrGenerateCommission> y <PrGenerateCommission_Hilos>
                                             Se crea <PROCREAOTADDTTGESTVENT>
    ******************************************************************/

    function LDC_FNUGETVLRTARIFA(inuPackageId in mo_packages.package_id%type)
    return number is

    /*****************************************************************
    Propiedad intelectual de PETI.
    Unidad         : LDC_FNUGETVLRTARIFA
    Descripcion    : Funcion que retorna el valor de la venta para calculo de comision.
    Autor          : Sebastian Tapias
    Fecha          : 23/10/2017

     Parametros              Descripcion
    ============         ===================

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    29-01-2018      STapias.REQ 2001689  Se modifica cursor para obtener
                                         la ultima tarifa configurada
    ******************************************************************/
        -----------------------------------
        --Variables
        -----------------------------------
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'LDC_FNUGETVLRTARIFA';
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 
        
        nuTipoPackage      mo_packages.package_type_id%type;
        dtAttentionDate    mo_packages.ATTENTION_DATE%type;
        nuCateCodi         LDC_COMISION_PLAN_NEL.CATECODI%type;
        nuSucaCodi         LDC_COMISION_PLAN_NEL.SUCACODI%type;
        nuProductId        pr_product.product_id%type;
        nuCommercialPlanId LDC_COMISION_PLAN_NEL.COMMERCIAL_PLAN_ID%type;
        nuLiquidaTarifa    NUMBER := 0;
        nuLiquidaCotiza    NUMBER := 0;
        vaLiquida          VARCHAR2(1) := null;
        nuConvalo          NUMBER;
        -----------------------------------
        --Cursores
        -----------------------------------
        CURSOR CUEXISTETARIFA(NUTIPO mo_packages.package_type_id%type) IS
          SELECT count(1) cantidad
            FROM DUAL
           WHERE NUTIPO IN
                 (select to_number(column_value)
                    from table(ldc_boutilities.splitstrings(pkg_BCLD_Parameter.fsbObtieneValorCadena('TIPO_SOLIC_VENTA_TARIFA'),
                                                            ',')));
        CURSOR CUEXISTECOTIZA(NUTIPO mo_packages.package_type_id%type) IS
          SELECT count(1) cantidad
            FROM DUAL
           WHERE NUTIPO IN
                 (select to_number(column_value)
                    from table(ldc_boutilities.splitstrings(pkg_BCLD_Parameter.fsbObtieneValorCadena('TIPO_SOLIC_VENTA_COTIZA'),
                                                            ',')));
         ------------------------------
         -- REQ.200-1689 Stapias -->
         ------------------------------
         /*Se cambia cursor, para obtener la ultima tarifa configurada, en caso de que las fechas se cruzen*/
        cursor cuConceptos(sbComerPlan     in mo_motive.commercial_plan_id%type,
                           dtAttentionDate in TA_VIGETACP.VITPFEIN%type,
                           sbCategory      in LDC_COMISION_PLAN_NEL.CATECODI%type,
                           sbSubcategory   in LDC_COMISION_PLAN_NEL.SUCACODI%type) is
          SELECT nvl(sum(NVL(tv.vitpvalo, 0)), 0)
            FROM TA_VIGETACP tv
           WHERE tv.vitptacp IN
                 (SELECT CONS
        FROM (SELECT max(TV.VITPTACP) CONS, CT.COTCCONC CONCE
              FROM TA_VIGETACP tv, TA_TARICOPR K, TA_CONFTACO CT
             WHERE tv.vitptacp IN
                   (SELECT tt.tacpcons
                      FROM TA_TARICOPR TT, TA_CONFTACO TC
                     WHERE TT.TACPCOTC = TC.COTCCONS
                       AND TT.TACPCR01 = sbComerPlan
                       AND (TT.TACPCR03 = sbCategory OR TT.TACPCR03 = -1)
                       AND (TT.TACPCR02 = sbSubcategory OR TT.TACPCR02 = -1)
                       AND TC.COTCCONC IN
                           (select nvl(to_number(column_value), 0)
                              from table(ldc_boutilities.splitstrings(pkg_BCLD_Parameter.fsbObtieneValorCadena('COD_CONC_VTA_LIQ_COMISIONES'),
                                                                           ','))))
               and dtAttentionDate between tv.vitpfein and tv.vitpfefi
               and tv.vitptipo = 'T'
               AND K.TACPCONS = TV.VITPTACP
               AND K.TACPCOTC = CT.COTCCONS
             GROUP BY CT.COTCCONC) A)
             and dtAttentionDate between tv.vitpfein and tv.vitpfefi
             and tv.vitptipo = 'T';

         ------------------------------
         -- REQ.200-1689 Stapias <--
         ------------------------------

         CURSOR cuVlrItemCoti(nuPackageId in mo_packages.package_id%type) is
         SELECT total_items_value FROM CC_QUOTATION WHERE STATUS = 'C' AND package_id = nuPackageId;
    begin
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        --Obtener tipo de solicitud
        nuTipoPackage := to_number(LDC_BOUTILITIES.fsbGetValorCampoTabla('mo_packages',
                                                                         'PACKAGE_ID',
                                                                         'package_type_id',
                                                                         inuPackageId));
        open CUEXISTETARIFA(nuTipoPackage);
        fetch CUEXISTETARIFA INTO nuLiquidaTarifa;
        close CUEXISTETARIFA;
        
        open CUEXISTECOTIZA(nuTipoPackage);
        fetch CUEXISTECOTIZA INTO nuLiquidaCotiza;
        close CUEXISTECOTIZA;
        
        IF (nuLiquidaTarifa > 0) THEN
            vaLiquida := 'T';
        ELSIF (nuLiquidaCotiza > 0) THEN
            vaLiquida := 'C';
        END IF;
        
        IF (vaLiquida = 'T') THEN
            --Obtener fecha de la solicitud
            dtAttentionDate := pkg_BCSolicitudes.fdtGetFechaRegistro(inuPackageId);
            --Obtener Producto
            nuProductId := to_number(LDC_BOUTILITIES.fsbGetValorCampoTabla('mo_motive',
                                                                         'package_id',
                                                                         'product_id',
                                                                         inuPackageId));
            --Categoria
            nuCateCodi := to_number(pkg_BCProducto.fnuCategoria(nuProductId));
            --Subcategoria
            nuSucaCodi := to_number(pkg_BCProducto.fnuSubCategoria(nuProductId));
            --Obtener plan comercial
            nuCommercialPlanId := to_number(LDC_BOUTILITIES.fsbGetValorCampoTabla('mo_motive',
                                                                                'PACKAGE_ID',
                                                                                'COMMERCIAL_PLAN_ID',
                                                                                inuPackageId));
            open cuConceptos(nuCommercialPlanId,
                           dtAttentionDate,
                           nuCateCodi,
                           nuSucaCodi);
            fetch cuConceptos INTO nuConvalo;
            close cuConceptos;
        ELSIF (vaLiquida = 'C') THEN
            open cuVlrItemCoti(inuPackageId);
            fetch cuVlrItemCoti INTO nuConvalo;
            close cuVlrItemCoti;
        END IF;

        pkg_Traza.Trace('Valor Tarifa ' || nuConvalo, 10);

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
        
        return nuConvalo;

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    end LDC_FNUGETVLRTARIFA;
  /**************************************************************************
        Autor       : Olsoftware
        Fecha       : 27-08-2020
        Ticket      : CA434
        Descripcion : Valida si el proceso ya termino

        Parametros Entrada
         isbIdPrograma          Identificador del programa
         inuCantHilos           Cantidad de hilos

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR                       DESCRIPCION
        27/08/2020  OLsoftware.CA434              Creacion
   ***************************************************************************/
    PROCEDURE VerificaFinProceso
    (
        isbIdPrograma   IN   estaprog.esprprog%TYPE,
        inuCantHilos    IN   NUMBER
    )
    IS
        csbMetodo1        CONSTANT VARCHAR2(70) := csbSP_NAME || 'VerificaFinProceso';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        --  Variable para almacenar indicador de finalizaci¿n de proceso
        blProcesoTermino      BOOLEAN;

        FUNCTION fblProcesoTermino
        (
            isbIdPrograma   IN   estaprog.esprprog%TYPE,
            inuCantHilos    IN   NUMBER
        )
        RETURN BOOLEAN
        IS

            csbMetodo2          CONSTANT VARCHAR2(105) := csbMetodo1 || '.fblProcesoTermino';
            nuError             NUMBER;
            sbError             VARCHAR2(4000);        
            --  Variable que almacena el numero de procesos pendientes de procesar
            nuProcesosTerm      NUMBER;
            blProcesoTermino    BOOLEAN;
            
            CURSOR cuCantEstaProgTerminados
            IS
            SELECT COUNT(1)
            FROM estaprog
            WHERE esprprog LIKE isbIdPrograma || '_%'
            AND esprporc >= 100;
            
        BEGIN
        
            pkg_traza.trace(csbMetodo2, csbNivelTraza, pkg_traza.csbINICIO);  
               
            OPEN cuCantEstaProgTerminados;
            FETCH cuCantEstaProgTerminados INTO nuProcesosTerm;
            CLOSE cuCantEstaProgTerminados;
            
            pkg_traza.trace('nuProcesosTerm|' || nuProcesosTerm , csbNivelTraza ); 
            
            IF(nuProcesosTerm < inuCantHilos)THEN
                blProcesoTermino := FALSE;
            ELSE
                blProcesoTermino := TRUE;
            END IF;
            
            pkg_traza.trace(csbMetodo2, csbNivelTraza, pkg_traza.csbFIN); 
            
            RETURN(blProcesoTermino);

        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo2, csbNivelTraza, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError,sbError);        
                pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo2, csbNivelTraza, pkg_traza.csbFIN_ERR);          
                pkg_error.setError;
                pkg_Error.getError(nuError,sbError);
                pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
                RAISE pkg_error.Controlled_Error;
        END fblProcesoTermino;

    BEGIN
    
        pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbINICIO);  

        --  Define que el proceso no termin¿
        blProcesoTermino      := FALSE;
        LOOP

          --  Verifica en la tabla ESTAPROG si el proceso ya termino
          blProcesoTermino   := fblProcesoTermino(isbIdPrograma,inuCantHilos);

          EXIT WHEN blProcesoTermino;

          --  Define un tiempo de espera de 60 segundos para volver a validar
          DBMS_LOCK.SLEEP(60);
        END LOOP;
        
        pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN);  

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo1, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END VerificaFinProceso;
    
  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : PrGenerateCommission
    Descripcion    : Procedimiento para generar comisiones por ventas al registro de la solicitud
    Autor          : Sayra Ocoro
    Fecha          : 08/03/2013

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
   06-11-2013      Sayra Ocoro        Se modifica el metodo PrGenerateCommision para que las ordenes
                                        de comision generadas como comisiones sean vistas desde el proceso
                                        de liquidacion a contratistas
   19-01-2014      Sayra Ocoro        Se adiciona busqueda de la orden de referencia para la novedad para
                                      solucionar la NC 2561.
                                      Se modifica filtro para no multar doble.
   20-02-2014     Sayra Ocoro        Aranda 89871 : Se modifica logica para manejo de errores
   21-02-2014     Sayra Ocoro        Aranda 2877:  Se modifican los parametros que se envian al apli para
                                     registro de novedades OS_REGISTERNEWCHARGE
   06-03-2014     Emiro Leyva        aranda 3038 (Debe corregirse para que tome solo el valor de la venta antes de IVA.).
                                     Solucion: se busca el valor de la venta en la tabla cargos de todos los
                                     conceptos de la venta atravez de la funcion LDC_FNUGETVLRVENTA, recibe
                                     como parametro 'PP-' concatenado con el numero de la solicitud de la venta.
   25-03-2014     Jorge Valiente     ARANDA 3224: Se colocaron validaciones para identificar cuando las varibales
                                                  con datos provenientes de servicios de 1er nivel tiene dato NULO.
   01-04-2014      Sayra Ocoro       Aranda 3275:Se deben actualizar correctamente la direccion (Address_id)
                                       de la venta en los campos "External_address_id" de la entidad OR_ORDER y
                                       "Address_id" de la entidad OR_ORDER_ACTIVITY.
  10-04-2014      Sayra Ocoro       Aranda 3275_2:Se ajusta la solucion para que actualice los campos OPERATING_SECTOR_ID
                                              y GEOGRAP_LOCATION_ID de la tabla OR_ORDER y tambien el campo
                                               OPERATING_SECTOR_ID  de la tabla OR_ORDER_ACTIVITY.
  16-04-2014    Sayra Ocoro         Aranda 3420: Se corrige mensage de generacion.
  08-09-2014      oparra            TEAM 33. Se modifica el proceso para que se pueda realizar el calculo y el
                                    pago decomisiones a contratistas pertenecientes al tramite de venta a constructoras,
                                    para que aplique para Surtigas y Gases del Caribe.
  20-01-2015      Gabriel Gamarra    NC 3968: Se agrega validacion para que no procese las solicitudes del tipo
                                      100271 - Venta de Gas Formulario Migracion en la etapa de registro.
  05-02-2016      Francisco Castro  Caso 100.7353: Se implementa funcionalidad para ejecutar el proceso
                                    por hilos (se separa parte del codigo original que estaba en PrGenerateCommission
                                    pasandolo para PrGenerateCommission_Hilos
  17-06-2020      OLSoftware        CA434: Se ajusta el cursor cuPackages para que no tenga en cuenta las solicitudes de ventas
                                           que tienen cupones de tipo "DE" y con el flag de pagado en "N".
  25-01-2023      jpinedc - MVM     OSF-839: Se modifica el cursor cuPackages                                           
  ******************************************************************/
  procedure PrGenerateCommission (isbProcessName IN estaprog.esprprog%type,
                                  indtCorte IN date,
                                  inuCurrentThread IN NUMBER,
                                  inuTotalThreads IN NUMBER) is
    csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'PrGenerateCommission';
    nuError         NUMBER;
    sbError         VARCHAR2(4000); 

    dtLastExecution        date;
    dtToday                date := sysdate;

    sbPackagesType         varchar2(3000);

    nuTotReg               number;
    nusesion               number;
    sbProcessProg       estaprog.esprprog%type;

    cursor cuPackages(idtToday         date,
                      idtLastExecution date,
                      isbPackagesType  varchar2) is
    --Solicitudes de venta pendientes por pago de comision al legalizar
     select count(1) from (
     (select mo_packages.package_id id, 'B' sbTime
        from mo_packages
       where mo_packages.request_date between idtLastExecution and idtToday
        and mo_packages.package_type_id in
        (
          SELECT to_number(regexp_substr(isbPackagesType,'[^,]+', 1, LEVEL)) AS tipk
                              FROM   dual
                              CONNECT BY regexp_substr(isbPackagesType, '[^,]+', 1, LEVEL) IS NOT NULL
        )
         AND mo_packages.PACKAGE_TYPE_ID <> 100271
         and mo_packages.MOTIVE_STATUS_ID <> nuPkgAnulado -- 32-Solicitud ANULADA
         and (select count(1) from    cupon where   cupotipo = 'DE' AND cupoflpa = 'N' and cupodocu = to_char(mo_packages.package_id)) = 0
         and not exists
       (select null
                from LDC_PKG_OR_ITEM
               where mo_packages.package_id = LDC_PKG_OR_ITEM.package_id
                 and LDC_PKG_OR_ITEM.order_item_id in
                     (nuActCIVZNR,
                      nuActCIVZSR,
                      nuActCIVZNC,
                      nuActCIVZSC,
                      nuActMZR,
                      nuActMZC)
                 )
        and mod(mo_packages.package_id,inuTotalThreads)+inuCurrentThread= inuTotalThreads)
      union
      --Solicitudes de venta pendientes por pago de comision al legalizar
       (select mo_packages.package_id id, 'L' sbTime
          from mo_packages
         where mo_packages.request_date between idtLastExecution and
               idtToday
        and mo_packages.package_type_id in
        (
          SELECT to_number(regexp_substr(isbPackagesType,'[^,]+', 1, LEVEL)) AS tipk
                              FROM   dual
                              CONNECT BY regexp_substr(isbPackagesType, '[^,]+', 1, LEVEL) IS NOT NULL
        )
           and mo_packages.MOTIVE_STATUS_ID = nuPkgAtendido -- 14-Solicitud atendida
           and (select count(1) from    cupon where   cupotipo = 'DE' AND cupoflpa = 'N' and cupodocu = to_char(mo_packages.package_id)) = 0
           and not exists
         (select null
                  from  LDC_PKG_OR_ITEM
                 where Mo_packages.package_id = LDC_PKG_OR_ITEM.package_id
                   and LDC_PKG_OR_ITEM.order_item_id in
                       (nuActCLVZNR,
                        nuActCLVZSR,
                        nuActCLVZNC,
                        nuActCLVZSC,
                        nuActMZR,
                        nuActMZC)
          )

         and mod(mo_packages.package_id,inuTotalThreads)+inuCurrentThread= inuTotalThreads));

        rgNewParameter ld_parameter%rowtype;

        dtBegin   date;

    begin
  
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
          
        sbProcessProg := TRIM(isbProcessName)||'_'||inuCurrentThread;

        nusesion := userenv('SESSIONID');

        pro_grabalog_comision (nusesion, dtToday, 0, 0, 'Inicia Proceso');

        sbPackagesType := pkg_BCLD_Parameter.fsbObtieneValorCadena('ID_SOLIC_VENTA_GAS_CONST');

        --Obtener la fecha de la ultima ejecucion del proceso
        if (dald_parameter.fblexist('FECHA_COM_REG_VENTA') = FALSE) then
          rgNewParameter.PARAMETER_ID := 'FECHA_COM_REG_VENTA';
          rgNewParameter.VALUE_CHAIN := SYSDATE;
          rgNewParameter.DESCRIPTION := 'ULTIMA FECHA DE EJECUCION DEL PROCESO PARA GENERAR COMISIONES DE VENTA AL REGISTRO';
          insert into ld_parameter
            (PARAMETER_ID, NUMERIC_VALUE, VALUE_CHAIN, DESCRIPTION)
          values
            (rgNewParameter.PARAMETER_ID,
             null,
             rgNewParameter.VALUE_CHAIN,
             rgNewParameter.DESCRIPTION);
          commit;
        end if;
        
        --Almacenar en un parametro para futuras ejecuciones
        dtLastExecution := pkg_BCLD_Parameter.fsbObtieneValorCadena('FECHA_COM_REG_VENTA');
        dtBegin         := dtLastExecution - nuRange;

        pkg_Traza.Trace('Fecha inicio dtBegin --> ' || dtBegin, 10);

        pro_grabalog_comision (nusesion, dtToday, 0, 0, 'Inicia conteo regs a procesar. dtLastExecution: ' ||
                            dtLastExecution || ' dtBegin: '  || dtBegin);

        -- se halla el total de registros a procesar
        open cuPackages(indtCorte, dtBegin, sbPackagesType);
        fetch cuPackages into nuTotReg;
        close cuPackages;

        if nuTotReg is null then 
            nuTotReg := -1;
        end if;

        pro_grabalog_comision (nusesion, dtToday, 0, 0, 'Termina conteo regs a procesar. Nro Regs: ' || nuTotReg);

        pkStatusExeProgramMgr.AddRecord(sbProcessProg, nuTotReg, NULL);

        if nuTotReg > 0 then

            pro_grabalog_comision (nusesion, dtToday, 0, 0, 'Inicia ejecucion hilo');
            -- se crean los jobs y se ejecutan

            COMMIT;

            LDC_BCSALESCOMMISSION_NEL.PrGenerateCommission_Hilos(dtToday,
                                                                 indtCorte,
                                                                 dtBegin,
                                                                 sbPackagesType,
                                                                 inuCurrentThread,
                                                                 inuTotalThreads,
                                                                 nusesion,
                                                                 sbProcessProg,
                                                                 nuTotReg);
 
            pro_grabalog_comision (nusesion, dtToday, 0, 0, 'Termino el hilo');

            pkg_Traza.Trace('Actualizando parametro fecha', 10);
            dald_parameter.UPDVALUE_CHAIN('FECHA_COM_REG_VENTA', to_char(SYSDATE));
            pkg_Traza.Trace('Asentando transaccion', 10);
            commit;

            pkg_Traza.Trace('Fin LDC_BCSALESCOMMISSION_NEL.PrGenerateCommission', 10);

        else
            pro_grabalog_comision (nusesion, dtToday, 0, 0, 'LDC_BCSALESCOMMISSION_NEL.PrGenerateCommission con cero registros a procesar');
            pkg_Traza.Trace('LDC_BCSALESCOMMISSION_NEL.PrGenerateCommission con cero registros a procesar', 10);
        end if;

        pkStatusExeProgramMgr.ProcessFinishOK(sbProcessProg);

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
    exception
        WHEN pkg_Error.Controlled_Error then
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);        
            pkg_Error.getError(nuError,sbError );
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );            
            pro_grabalog_comision (nusesion, dtToday, inuCurrentThread, 0, 'Error: ' || sbError || 'Hilo: '||inuCurrentThread);
            rollback;
            raise pkg_Error.Controlled_Error;
        When others then
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);        
            pkg_Error.setError;
            pkg_Error.getError(nuError,sbError );
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );            
            pro_grabalog_comision (nusesion, dtToday, inuCurrentThread, 0, 'Error: ' || sbError || 'Hilo: '||inuCurrentThread);
            rollback;
            raise pkg_Error.Controlled_Error;
    end PrGenerateCommission;

    /*****************************************************************
    Propiedad intelectual de GDC (c).

    Unidad         : PROCREAOTADDTTGESTVENT
    Descripcion    : Procedimiento para generar la orden adicional de la comision
    Autor          :
    Fecha          : 17-06-2020

    Nombre         :
    Parametros         Descripcion
    ============  ===================

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    17-06-2020       OLSoftware         CA434: Creacion
    25-01-2023       jpinedc - MVM      OSF-839: Se evalua si al 
                                        contratista se le genera
                                        la actividad
    ******************************************************************/
    PROCEDURE  PROCREAOTADDTTGESTVENT
    (
        inuFatherOrder   IN or_order.order_id%type,
        inuPackageId     IN mo_packages.package_id%type,
        inuOperatinUnit  IN or_operating_unit.operating_unit_id%type,
        inuPersonId      IN ge_person.person_id%TYPE,
        onuerrorcode    OUT ge_error_log.error_log_id%TYPE,
        osberrormessage OUT ge_error_log.description%TYPE,
        onuOrder        OUT or_order.order_id%TYPE
    )
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'PROCREAOTADDTTGESTVENT';
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 
        
        nuActiviy            ld_parameter.numeric_value%type := pkg_BCLD_Parameter.fnuObtieneValorNumerico('PARACTIVIDADADDPC');
        nuValueComision      ld_parameter.numeric_value%type := pkg_BCLD_Parameter.fnuObtieneValorNumerico('PARVALORCOMISIONPC');
        nuCount              NUMBER;
        sbQuery              VARCHAR2(300);
        sbComment            or_order_comment.order_comment%TYPE;
        nuTypeComment        ge_comment_type.comment_type_id%TYPE := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ID_TIPO_OBS_COMISION_VENTA');
        
        CURSOR cuFatherOrderData(inuFatherOrder   IN or_order.order_id%type)
        IS
            SELECT  PACKAGE_id,
                    motive_id,
                    component_id,
                    subscription_id,
                    product_id,
                    SUBSCRIBER_ID,
                    address_id,
                    OPERATING_SECTOR_ID
            FROM OR_ORDER_ACTIVITY
            WHERE ORDER_ID = inuFatherOrder
            AND ROWNUM = 1;

        rcDataOrder cuFatherOrderData%rowtype;
        
        nuContractor_Id     or_operating_unit.contractor_id%TYPE;
        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        nuContractor_Id := pkg_BCUnidadOperativa.fnuGetContratista( inuOperatinUnit );
        
        IF INSTR ( ',' || csbLDC_CONTRA_SIN_DIGIT_INDEX || ',', ',' || nuContractor_Id || ',' ) = 0 THEN

            sbComment := 'Orden adicional generada automaticamente por el proceso GOPCVNEL. Orden padre: '||inuFatherOrder;

            pkg_Traza.Trace('Se ejecuta el servicio para crear la novedad',10);

            pkg_Traza.Trace('Parametros- inuOperatinUnit: '||inuOperatinUnit||' - nuActiviy: '||nuActiviy||
                           ' inuPersonId: '||inuPersonId||' nuValueComision: '||nuValueComision||' nuTypeComment: '||nuTypeComment||
                           ' sbComment: '||sbComment ,10);
            LDC_prRegisterNewCharge
            (
                inuOperatinUnit,
                nuActiviy,
                inuPersonId,
                null,
                nuValueComision,
                null,
                null,
                nuTypeComment,
                sbComment,
                onuerrorcode,
                osberrormessage,
                onuOrder
            );

            pkg_Traza.Trace('Salida - osberrormessage: '||osberrormessage||' - osberrormessage: '||osberrormessage||
                           ' onuOrder: '||onuOrder ,10);

            IF onuerrorcode is not null THEN
                pkg_error.setErrorMessage( isbMsgErrr => osberrormessage);
            END IF;

            pkg_Traza.Trace('Orden creada por el servicio PROCREAOTADDTTGESTVENT : '||onuOrder,10);

            OPEN cuFatherOrderData(inuFatherOrder);
            FETCH cuFatherOrderData INTO rcDataOrder;
            CLOSE cuFatherOrderData;
            
            UPDATE OR_ORDER_ACTIVITY
            SET PACKAGE_ID = rcDataOrder.PACKAGE_id,
                motive_id = rcDataOrder.motive_id,
                component_id = rcDataOrder.component_id,
                subscription_id = rcDataOrder.subscription_id,
                product_id = rcDataOrder.product_id,
                SUBSCRIBER_ID = rcDataOrder.SUBSCRIBER_ID
            WHERE ORDER_ID = onuOrder;

        ELSE
            pkg_Traza.Trace('Al contratista ['|| nuContractor_Id || '] no se le genera orden con actividad [' || nuActiviy || ']',10);            
        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END PROCREAOTADDTTGESTVENT;

    PROCEDURE prGenerarTraza
    (
        isbComentario       IN      VARCHAR2,
        inuOrden            IN      OR_order.order_id%type
    )
    IS
    
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prGenerarTraza';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);     

    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
            
        INSERT INTO OR_ORDER_COMMENT VALUES
        (
            SEQ_OR_ORDER_COMMENT.NEXTVAL,
            isbComentario,
            inuOrden,
            -1,
            SYSDATE,
            'N',
            NULL
        );

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
            
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END prGenerarTraza;
    
    /*****************************************************************
    Propiedad intelectual de GDC (c).

    Unidad         : pRegistraExcepcion
    Descripcion    : Realiza el registro en la tabla LDC_PKG_OR_ITEM
    Autor          :
    Fecha          : 18-11-2021

    Nombre         :
    Parametros         Descripcion
    ============  ===================

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    18-11-2021       Horbath         CA854: Creacion
  ******************************************************************/
    PROCEDURE pRegistraExcepcion
    (
        inuPackageId    IN  LDC_PKG_OR_ITEM.package_id%TYPE
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'pRegistraExcepcion';
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        INSERT INTO LDC_VENT_EXC_COMISION (VENT_EXC_COMISION_ID,PACKAGE_ID,STATUS_,REGISTER_DATE,PROCESS_DATE)
        VALUES (
                SEQ_LDC_VENT_EXC_COMISION.NEXTVAL,
                inuPackageId,
                'E',
                LDC_BOConsGenerales.fdtGetSysdate,
                NULL
                );
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END pRegistraExcepcion;
    
    /*****************************************************************
    Propiedad intelectual de GDC (c).

    Unidad         : pActualizaRegistro
    Descripcion    : Actualiza el registro en la tabla LDC_PKG_OR_ITEM
    Autor          :
    Fecha          : 18-11-2021

    Nombre         :
    Parametros         Descripcion
    ============  ===================

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    18-11-2021       Horbath         CA854: Creacion
  ******************************************************************/
    PROCEDURE pActualizaRegistro
    (
        inuPackageId    IN  LDC_PKG_OR_ITEM.package_id%TYPE
    )
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'pActualizaRegistro';
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 
        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        UPDATE LDC_VENT_EXC_COMISION
            SET STATUS_ = 'P',
                process_date = LDC_BOConsGenerales.fdtGetSysdate
        WHERE PACKAGE_ID = inuPackageId;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END pActualizaRegistro;
    
    
    /*****************************************************************
    Propiedad intelectual de GDC (c).

    Unidad         : pReg_LDC_PKG_OR_ITEM
    Descripcion    : Realiza el registro en la tabla LDC_PKG_OR_ITEM
    Autor          :
    Fecha          : 18-11-2021

    Nombre         :
    Parametros         Descripcion
    ============  ===================

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    18-11-2021       Horbath         CA854: Creacion
  ******************************************************************/
    PROCEDURE pReg_LDC_PKG_OR_ITEM
    (
        inuOrderItemId  IN  LDC_PKG_OR_ITEM.order_item_id%TYPE,
        inuOrderId      IN  LDC_PKG_OR_ITEM.order_id%TYPE,
        inuPackageId    IN  LDC_PKG_OR_ITEM.package_id%TYPE,
        idtDate         IN  LDC_PKG_OR_ITEM.fecha%TYPE,
        isbObse         IN  LDC_PKG_OR_ITEM.observacion%TYPE,
        inuCate         IN  LDC_PKG_OR_ITEM_DETAIL.category_id%TYPE DEFAULT NULL,
        inuSuca         IN  LDC_PKG_OR_ITEM_DETAIL.subcategory_id%TYPE DEFAULT NULL,
        isbZone         IN  LDC_PKG_OR_ITEM_DETAIL.zone_id%TYPE DEFAULT NULL,
        idtDateRing     IN  LDC_PKG_OR_ITEM_DETAIL.date_ring%TYPE DEFAULT NULL,
        inuCommPlan     IN  LDC_PKG_OR_ITEM_DETAIL.commercial_plan_id%TYPE DEFAULT NULL,
        inuReqSales     IN  LDC_PKG_OR_ITEM_DETAIL.req_sales_id%TYPE DEFAULT NULL,
        inuLocation     IN  LDC_PKG_OR_ITEM_DETAIL.location_id%TYPE DEFAULT NULL,
        inuDepa         IN  LDC_PKG_OR_ITEM_DETAIL.father_location_id%TYPE DEFAULT NULL,
        inuPayDate      IN  LDC_PKG_OR_ITEM_DETAIL.pay_date%TYPE DEFAULT NULL,
        inuCuponValue   IN  LDC_PKG_OR_ITEM_DETAIL.cupon_value%TYPE DEFAULT NULL,
        inuActa         IN  LDC_PKG_OR_ITEM_DETAIL.id_acta%TYPE DEFAULT NULL
    )
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'pReg_LDC_PKG_OR_ITEM';
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 
        
        CURSOR cuExiste
        IS
            SELECT count(1)
            FROM LDC_PKG_OR_ITEM_DETAIL d
            WHERE d.package_id = inuPackageId;
            
        nuExiste    NUMBER;
    
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  

        INSERT INTO LDC_PKG_OR_ITEM (LDC_PKG_OR_ITEM_ID,ORDER_ITEM_ID,ORDER_ID,PACKAGE_ID,FECHA,OBSERVACION)
        VALUES (
                GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE('LDC_PKG_OR_ITEM','SEQ_LDC_PKG_OR_ITEM'),
                inuOrderItemId,
                inuOrderId,
                inuPackageId,
                idtDate,
                isbObse
                );
          IF inuOrderId  IS NOT NULL THEN
            -- Se consulta la informacion adicional y se agrega
            Open cuExiste;
            fetch cuExiste INTO nuExiste;
            close cuExiste;
            
            IF nuExiste = 0 THEN

                INSERT INTO LDC_PKG_OR_ITEM_DETAIL
                VALUES (
                        inuPackageId,
                        inuOrderId,
                        inuCate,
                        inuSuca,
                        isbZone,
                        idtDateRing,
                        inuCommPlan,
                        inuReqSales,
                        inuLocation,
                        inuDepa,
                        pkg_BCSolicitudes.fdtGetFechaRegistro(inuPackageId),
                        inuPayDate,
                        inuCuponValue,
                        inuActa
                        );
                    
             END IF;
         END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
    
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END pReg_LDC_PKG_OR_ITEM;

/*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : PrGenerateCommission_Hilos
    Descripcion    : Procedimiento para generar comisiones por ventas al registro de la solicitud
                     Mediante hilos
    Autor          : Sayra Ocoro
    Fecha          : 08/03/2013

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
   06-11-2013      Sayra Ocoro        Se modifica el metodo PrGenerateCommision para que las ordenes
                                        de comision generadas como comisiones sean vistas desde el proceso
                                        de liquidacion a contratistas
   19-01-2014      Sayra Ocoro        Se adiciona busqueda de la orden de referencia para la novedad para
                                      solucionar la NC 2561.
                                      Se modifica filtro para no multar doble.
   20-02-2014     Sayra Ocoro        Aranda 89871 : Se modifica logica para manejo de errores
   21-02-2014     Sayra Ocoro        Aranda 2877:  Se modifican los parametros que se envian al apli para
                                     registro de novedades OS_REGISTERNEWCHARGE
   06-03-2014     Emiro Leyva        aranda 3038 (Debe corregirse para que tome solo el valor de la venta antes de IVA.).
                                     Solucion: se busca el valor de la venta en la tabla cargos de todos los
                                     conceptos de la venta atravez de la funcion LDC_FNUGETVLRVENTA, recibe
                                     como parametro 'PP-' concatenado con el numero de la solicitud de la venta.
   25-03-2014     Jorge Valiente     ARANDA 3224: Se colocaron validaciones para identificar cuando las varibales
                                                  con datos provenientes de servicios de 1er nivel tiene dato NULO.
   01-04-2014      Sayra Ocoro       Aranda 3275:Se deben actualizar correctamente la direccion (Address_id)
                                       de la venta en los campos "External_address_id" de la entidad OR_ORDER y
                                       "Address_id" de la entidad OR_ORDER_ACTIVITY.
  10-04-2014      Sayra Ocoro       Aranda 3275_2:Se ajusta la solucion para que actualice los campos OPERATING_SECTOR_ID
                                              y GEOGRAP_LOCATION_ID de la tabla OR_ORDER y tambien el campo
                                               OPERATING_SECTOR_ID  de la tabla OR_ORDER_ACTIVITY.
  16-04-2014    Sayra Ocoro         Aranda 3420: Se corrige mensage de generacion.
  08-09-2014      oparra            TEAM 33. Se modifica el proceso para que se pueda realizar el calculo y el
                                    pago decomisiones a contratistas pertenecientes al tramite de venta a constructoras,
                                    para que aplique para Surtigas y Gases del Caribe.
  20-01-2015      Gabriel Gamarra    NC 3968: Se agrega validacion para que no procese las solicitudes del tipo
                                      100271 - Venta de Gas Formulario Migracion en la etapa de registro.

  05-02-2016      Francisco Castro  Caso 100.7353: Se implementa funcionalidad para ejecutar el proceso
                                    por hilos (se separo parte del codigo original que estaba en PrGenerateCommission
                                    pasandolo para este procedimiento PrGenerateCommission_Hilos

  17-06-2020      OLSoftware        CA434: Se ajusta el cursor cuPackages para que no tenga en cuenta las solicitudes de ventas
                                           que tienen cupones de tipo "DE" y con el flag de pagado en "N".
  02-12-2020      OLsoftware         CA434: Se relacionan las ordenes de comision e index
  
  11-11-2021      Horbath           CA854: Se crea CURSOR cuAplicaSubsidio para determinar si la venta es subsidiada o no
  
  25-01-2023      jpinedc - MVM     OSF-839: Se modifica el cursor cuPackages  
  17-05-2023      jpinedc - MVM     OSF-1113: Se tiene en cuenta el tipo de asignación N para el
                                    cálculo del sector operativo auxiliar
  ******************************************************************/
    procedure PrGenerateCommission_Hilos (indtToday date,
                                        indtCorte date,
                                        indtBegin date,
                                        insbPackagesType varchar2,
                                        innuNroHilo number,
                                        innuTotHilos number,
                                        innusesion number,
                                        isbProcessName IN estaprog.esprprog%type,
                                        inuTotalRegistros IN NUMBER) is
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'PrGenerateCommission_Hilos';
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 
                                                    
        nuTaskTypeId      or_task_type.task_type_id%type;
        nuCateCodi        LDC_COMISION_PLAN_NEL.CATECODI%type;
        nuGeograpDepto    ge_geogra_location.geograp_location_id%type;
        nuGeograpLoca     ge_geogra_location.geograp_location_id%type;
        nuOperatingUnitId or_operating_unit.operating_unit_id%type;
        nuSalesmanId      mo_packages.person_id%type;
        nuZoneIdProduct   or_operating_zone.operating_zone_id%type;
        nuZoneId          or_operating_zone.operating_zone_id%type;
        nuBaseId          ge_base_administra.id_base_administra%Type;
        sbAssignType      or_operating_unit.assign_type%type;
        nuSegmentId       ab_address.segment_id%type;
        nuAdressId        pr_product.address_id%type;
        RgCommission      RgCommissionRegister;
        rgData            ldc_pkg_or_item%rowtype;
        SBobservacion     ldc_pkg_or_item.OBSERVACION%TYPE;
        sbDOCUMENT_KEY    mo_packages.DOCUMENT_KEY%type;
        inuOrderId        or_order.order_id%type;
        nugrabados number := 0;

        inuPersonId            SA_USER.user_id%type;
        isbObservation         VARCHAR2(400);
        onuErrorCode           number;
        osbErrorMessage        varchar2(2000);
        onuErrorCodeAdd        number;
        osbErrorMessageAdd     varchar2(2000);
        inuActivity            ge_items.items_id%type;
        nuOperatingSectorId    ab_segments.operating_sector_id%type;
        nuOperatingSectorIdAux ab_segments.operating_sector_id%type := 0;

        nuContadorTotal     NUMBER := 0;
        nuContador          NUMBER := 0;

        cursor cuPackages(idtToday         date,
                          idtLastExecution date,
                          isbPackagesType  varchar2) is
        --Solicitudes de venta pendientes por pago de comision al legalizar
        select * from (
        (
          select mo_packages.package_id id, 'B' sbTime
            from mo_packages
           --where mo_packages.request_date between idtLastExecution and idtToday
           Where mo_packages.request_date Between To_Date('01022020','DDMMYYYY') And idtToday
            and mo_packages.package_type_id in
            (
              SELECT to_number(regexp_substr(isbPackagesType,'[^,]+', 1, LEVEL)) AS tipk
                                  FROM   dual
                                  CONNECT BY regexp_substr(isbPackagesType, '[^,]+', 1, LEVEL) IS NOT NULL
            )
             AND mo_packages.PACKAGE_TYPE_ID <> 100271
             and mo_packages.MOTIVE_STATUS_ID <> nuPkgAnulado -- 32-Solicitud ANULADA
             and (((select count(1) 
                    from   cupon 
                    where  cupotipo = 'DE' AND cupoflpa = 'S' and cupodocu = to_char(mo_packages.package_id)) > 0) Or
                  ((select count(1) 
                    from   cupon 
                    where  cupotipo = 'DE' AND cupodocu = to_char(mo_packages.package_id)) = 0))  
             and not exists
           (select null
                    from LDC_PKG_OR_ITEM
                   where Mo_packages.package_id = LDC_PKG_OR_ITEM.package_id
                     and LDC_PKG_OR_ITEM.order_item_id in
                         (nuActCIVZNR,
                          nuActCIVZSR,
                          nuActCIVZNC,
                          nuActCIVZSC,
                          nuActMZR,
                          nuActMZC)
            )
            AND mod(mo_packages.package_id,innuTotHilos)+innuNroHilo= innuTotHilos)
          union
          --Solicitudes de venta pendientes por pago de comision al legalizar
           (select mo_packages.package_id id, 'L' sbTime
            from   mo_packages
            Where  mo_packages.request_date Between To_Date('01022020','DDMMYYYY') And idtToday
            and mo_packages.package_type_id in
                (
                  SELECT to_number(regexp_substr(isbPackagesType,'[^,]+', 1, LEVEL)) AS tipk
                                      FROM   dual
                                      CONNECT BY regexp_substr(isbPackagesType, '[^,]+', 1, LEVEL) IS NOT NULL
                )
            and mo_packages.MOTIVE_STATUS_ID = nuPkgAtendido -- 14-Solicitud atendida
             and (((select count(1) 
                    from   cupon 
                    where  cupotipo = 'DE' AND cupoflpa = 'S' and cupodocu = to_char(mo_packages.package_id)) > 0) Or
                  ((select count(1) 
                    from   cupon 
                    where  cupotipo = 'DE' AND cupodocu = to_char(mo_packages.package_id)) = 0))  
               and not exists
             (select null
                      from LDC_PKG_OR_ITEM
                     where mo_packages.package_id = LDC_PKG_OR_ITEM.package_id
                       and LDC_PKG_OR_ITEM.order_item_id in
                           (nuActCLVZNR,
                            nuActCLVZSR,
                            nuActCLVZNC,
                            nuActCLVZSC,
                            nuActMZR,
                            nuActMZC)
            )
            AND mod(mo_packages.package_id,innuTotHilos)+innuNroHilo= innuTotHilos));

        nuProductId    pr_product.product_id%type;
        sbES_externa   or_operating_unit.es_externa%type;

        --Cursor para validar  el sector operativo
        cursor cuOperatingSector(inuBaseId   ge_base_administra.id_base_administra%type,
                                 inuSectorId or_operating_sector.operating_sector_id%type) is
          select count(*) /*distinct nvl(ge_sectorope_zona.id_sector_operativo,0)*/ nuSectorId
            from or_zona_base_adm, ge_sectorope_zona
           where or_zona_base_adm.operating_zone_id =
                 ge_sectorope_zona.id_zona_operativa
             and or_zona_base_adm.id_base_administra = inuBaseId
             and ge_sectorope_zona.id_sector_operativo = inuSectorId;

        nuValue   number := 0;
        nuDays    number := 0;
        nuPercent number;
        nuNDays   number;
        nuBan     number := 0;

        --Cursor para obtener el identificador de la orden de multa
        --Retorna nulo porque el api no alcanza a crear el registro
        cursor cuOtMulta(isbObservation or_order_comment.order_comment%type) is
          select order_id id
            from or_order_comment
           where order_comment like isbObservation;

        --Cursor para validar si durante el proceso ya se genero multa
        cursor cuExisteMulta(inuPackageId mo_packages.package_id%type) is
          select count(*)
            from ldc_pkg_or_item
           where ORDER_ITEM_ID in (nuActMZR, nuActMZC)
             and package_id = inuPackageId;
        nuCount       number := 0;
        nuActivityId  or_order_activity.order_activity_id%type;
        nucontareg    NUMBER(15) DEFAULT 0;
        nucantiregcom NUMBER(15) DEFAULT 0;
        nucantiregtot NUMBER(15) DEFAULT 0;
        sbActivoOrdAdd  ld_parameter.value_chain%TYPE := pkg_BCLD_Parameter.fsbObtieneValorCadena('PARACTIVACIONOTADDPC');
        sbTaskTypeOrdAdd  ld_parameter.value_chain%TYPE := pkg_BCLD_Parameter.fsbObtieneValorCadena('PARTTDIGINDGESTADDPC');
        nuOrderAdd      or_order.order_id%TYPE;
        nuActivityIdAdd     or_order_activity.order_activity_id%type;
    
        CURSOR cuAplicaSubsidio
        (
            inuPackageId    IN  mo_packages.package_id%TYPE
        )
        IS
            SELECT aplicasubsidio
            FROM LDC_SUBSIDIOS
            WHERE PACKAGE_id = inuPackageId;
            
        CURSOR cuApplyCont
        (
            inuContratista     IN   LDC_INFO_OPER_UNIT_NEL.oper_unit_id%TYPE,
            inuTipoComi        IN   LDC_INFO_OPER_UNIT_NEL.tipo_comision_id%TYPE
        )
        IS
            SELECT count(1)
            FROM LDC_INFO_OPER_UNIT_NEL
            WHERE operating_unit_id = inuContratista
            AND tipo_comision_id = inuTipoComi
            AND apply_subcidy = 'Y';
        
        CURSOR cuInfoPremise
        (
            inuPremiseId    IN  ab_info_premise.premise_id%TYPE
        )
        IS
            SELECT date_ring
            FROM ab_info_premise
            WHERE premise_id = inuPremiseId;
            
        sbIsSubcidy     LDC_SUBSIDIOS.aplicasubsidio%TYPE;
        
        CURSOR cuCupon
        (
            inuPackageId    IN  mo_packages.package_id%TYPE
        )
        IS
            SELECT cuponume, cupovalo, cupofech
            FROM cupon
            WHERE cupotipo = 'DE'
            AND cupoflpa = 'S'
            AND cupodocu = TO_CHAR(inuPackageId);
        
        nuCantMeses     ld_parameter.numeric_value%TYPE := pkg_BCLD_Parameter.fnuObtieneValorNumerico('LDC_MESES_ZONA');
        dtFechaRing     ab_info_premise.date_ring%TYPE;
        sbZonaCalc      ldc_info_predio.is_zona%TYPE;
        nuSucate        pr_product.subcategory_id%TYPE;
        nuCommerPlan    pr_product.commercial_plan_id%TYPE;
        nuCupon         cupon.cuponume%TYPE;
        nuCupoVal       cupon.cupovalo%TYPE;
        dtCuponDate     pagos.pagofepa%TYPE;
        nuOperUnit      OR_order.operating_unit_id%TYPE;
        nuPersonId      OR_order_person.person_id%TYPE;
        nuAppliCont     NUMBER;
        nuContraId      ge_contratista.id_contratista%TYPE;
        nuCommiType     LDC_INFO_OPER_UNIT_NEL.tipo_comision_id%TYPE;
        sbZonaTAbla     varchar2(1);

    begin
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        pro_grabalog_comision (innusesion, indtToday, innuNroHilo, 1, 'Inicia Hilo: ' || innuNroHilo);

        --Buscar solicitudes de venta en estado "13 - Registrada" enun rango de fecha
        --Para cada solicitud, validar si ya se le genero una OT cerrada para el pago de la comision, si no, entonces generar OT y generar
        nucantiregcom := 0;
        nucantiregtot := 0;
        nucontareg    := pkg_BCLD_Parameter.fnuObtieneValorNumerico('COD_CANTIDAD_REG_GUARDAR');
        nugrabados := 0;
        
        for pkg in cuPackages(indtCorte, indtBegin, insbPackagesType) loop

            nuContadorTotal := nuContadorTotal + 1;
            nuOrderAdd := NULL;
            onuErrorCodeAdd := NULL;
            osbErrorMessageAdd := NULL;
            
            BEGIN
                pkg_Traza.Trace('Procesando solicitud --> ' || pkg.id || ' (Hilo ' || innuNroHilo || ')', 10);

                pkStatusExeProgramMgr.UpStatusExeProgramAT(isbProcessName,'Procesando... '||pkg.id, inuTotalRegistros, nuContadorTotal);

                nuBan       := 0;
                sbZonaTAbla :=null;
                inuActivity := null;
                inuOrderId  := null;
                --Obtener unidad de trabajo o contratista para consultar en CTCVE
                nuSalesmanId := pkg_BCSolicitudes.fnuGetPersona(pkg.id);
                pkg_Traza.Trace('nuSalesmanId --> ' || nuSalesmanId, 10);
                sbDOCUMENT_KEY := damo_packages.fsbgetdocument_key(pkg.id);
                pkg_Traza.Trace('sbDOCUMENT_KEY --> ' || sbDOCUMENT_KEY, 10);
                if nuSalesmanId is null then
                  pkg_Traza.Trace('No existe un vendedor asociado a la solicitud de venta',
                                 10);
                  pkg_error.setErrorMessage( isbMsgErrr => 'No existe un vendedor asociado a la solicitud de venta ' || pkg.id);
                end if;
                inuPersonId := nuSalesmanId;
                --Obtener la unidad asociada al punto de venta
                nuOperatingUnitId := pkg_BCSolicitudes.fnuGetPuntoVenta(pkg.id);
                pkg_Traza.Trace('nuOperatingUnitId --> ' || nuOperatingUnitId, 10);

                if nuOperatingUnitId is null then
                  pkg_Traza.Trace('La Solicitud ' || pkg.id ||
                                 ' no esta asociado a una unidad de trabajo.',
                                 10);
                    pkg_error.setErrorMessage( isbMsgErrr => 'El Solicitud ' || pkg.id || ' no esta asociado a una unidad de trabajo.');
                end if;
                --Obtener el tipo de unidad operativa asociada a la solicitud de venta
                sbES_externa := pkg_BCUnidadOperativa.fsbGetEsExterna(nuOperatingUnitId);

                pkg_Traza.Trace('sbES_externa --> ' || sbES_externa, 10);

                --Validar si la unidad operativa es externa
                if sbES_externa = 'Y' then

                    nuContraId := pkg_BCUnidadOperativa.fnuGetContratista(nuOperatingUnitId);

                    nuCommiType := to_number(LDC_BOUTILITIES.fsbGetValorCampoTabla('LDC_INFO_OPER_UNIT_NEL',
                                                                                'OPERATING_UNIT_ID',
                                                                                'TIPO_COMISION_ID',
                                                                                nuContraId));

                    pkg_Traza.Trace('Unidad Operativa si es externa', 10);
                    --Obener la direccion del producto
                    nuAdressId := pkg_BCSolicitudes.fnuGetDireccion(pkg.id);
                    pkg_Traza.Trace('nuAdressId --> ' || nuAdressId, 10);

                    --Producto
                    nuProductId := to_number(LDC_BOUTILITIES.fsbGetValorCampoTabla('mo_motive',
                                                                                 'package_id',
                                                                                 'product_id',
                                                                                 pkg.id));
                    pkg_Traza.Trace('nuProductId --> ' || nuProductId, 10);
                    --Categoria
                    nuCateCodi := to_number(LDC_BOUTILITIES.fsbGetValorCampoTabla('mo_motive',
                                                                                'PACKAGE_ID',
                                                                                'CATEGORY_ID',
                                                                                pkg.id));

                    pkg_Traza.Trace('nuCateCodi --> ' || nuCateCodi, 10);

                    nuSucate := pkg_BCProducto.fnuSubCategoria(nuProductId);
                    nuCommerPlan := pkg_BCProducto.fnuTraerCommercialPlanId(nuProductId);

                    OPEN cuCupon(pkg.id);
                    FETCH cuCupon INTO nuCupon, nuCupoVal, dtCuponDate;
                    CLOSE cuCupon;
          
                    --Obtener la localidad
                    nuGeograpLoca := pkg_BCDirecciones.fnuGetLocalidad(nuAdressId);
                    pkg_Traza.Trace('nuGeograpLoca --> ' || nuGeograpLoca, 10);
                    --Obtener el Depto
                    nuGeograpDepto := pkg_BCDirecciones.fnuGetUbicaGeoPadre(nuGeograpLoca);
                    pkg_Traza.Trace('nuGeograpDepto --> ' || nuGeograpDepto, 10);
                    --Obtener el segmento de la direccion del producto
                    nuSegmentId := pkg_BCDirecciones.fnuGetSegmento_Id(nuAdressId);
                    pkg_Traza.Trace('nuSegmentId --> ' || nuSegmentId, 10);
                    --Obtener el sector operativo del segmento
                    nuOperatingSectorId := daab_segments.fnugetoperating_sector_id(nuSegmentId,
                                                                                 null);
                    pkg_Traza.Trace('nuOperatingSectorId --> ' || nuOperatingSectorId,
                                 10);

                    OPEN cuInfoPremise(pkg_BCDirecciones.fnuGetPredio(nuAdressId));
                    FETCH cuInfoPremise INTO dtFechaRing;
                    CLOSE cuInfoPremise;

                    --Obtener la zona del sector operativo asociado a la direccion del producto
                    nuZoneIdProduct := daor_operating_sector.fnugetoperating_zone_id(nuOperatingSectorId);
                    pkg_Traza.Trace('nuZoneIdProduct --> ' || nuZoneIdProduct, 10);
                    --Obtener el tipo de asignacion de la unidad operativa
                    sbAssignType := pkg_BCUnidadOperativa.fsbGetTipoAsignacion(nuOperatingUnitId);
                    pkg_Traza.Trace('sbAssignType --> ' || sbAssignType, 10);

                    IF nuSegmentId IS NOT NULL THEN
                    --VALIDACION DEL SEGMENTO DE LA DIRECCION DEL PRODUCTO
                        IF nuGeograpLoca IS NOT NULL THEN
                          --VALIDACION DE LA LOCALIDAD
                            pkg_Traza.Trace('Valida si el tipo de asignacion es por demanda ' ||
                                         sbAssignType,
                                         10);
                            --Validar si el tipo de asignacion es por DEMANDA  : C => Obtener sectores de la Zona asociada a la Base Operativa de la UT
                            if sbAssignType IN ('C','N') then
                                nuBaseId := pkg_BCUnidadOperativa.fnuGetBaseAdministrativa(nuOperatingUnitId);
                                open cuOperatingSector(nuBaseId, nuOperatingSectorId);
                                fetch cuOperatingSector
                                  into nuOperatingSectorIdAux;
                                close cuOperatingSector;
                            --Si el tipo de asignacion es por CAPACIDAD : S => Obtener sectores de la Zona asociada a la UT
                            elsif sbAssignType = 'S' then
                                nuZoneId := pkg_BCUnidadOperativa.fnuGetZonaOperativa(nuOperatingUnitId);
                                --  dbms_output.put_line('nuZoneId => ' || nuZoneId);
                                nuOperatingSectorIdAux := to_number(LDC_BOUTILITIES.fsbgetvalorcampostabla('ge_sectorope_zona',
                                                                                                       'id_zona_operativa',
                                                                                                       'id_sector_operativo',
                                                                                                       nuZoneId,
                                                                                                       'id_sector_operativo',
                                                                                                       nuOperatingSectorId));
                            end if;

                            pkg_Traza.Trace('nuOperatingSectorIdAux --> ' ||
                                     nuOperatingSectorIdAux,
                                     10);

                            --Validar si se registra multa o comision
                            pkg_Traza.Trace('Valida genera multa o comision ', 10);--Aqui voy
                            if nuOperatingSectorIdAux = 0 or nuOperatingSectorIdAux = -1 then

                                pkg_Traza.Trace('MULTA ', 10);

                                --Validar si la categoria del producto es residencial
                                if nuCateCodi =
                                   pkg_BCLD_Parameter.fnuObtieneValorNumerico('RESIDEN_CATEGORY') then
                                  --Definir item de novedad y tipo de trabajo para multar
                                  nuTaskTypeId := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ID_TT_MULTA_RESID');
                                  inuActivity  := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ID_MULTA_VENTA_OTRA_ZONA_RESID');
                                end if;
                                
                                --Validar si la categoria del producto es residencial
                                if nuCateCodi =
                                   pkg_BCLD_Parameter.fnuObtieneValorNumerico('COMMERCIAL_CATEGORY') then
                                  nuTaskTypeId := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ID_TT_MULTA_COMME');
                                  inuActivity  := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ID_MULTA_VENTA_OTRA_ZONA_COMM');
                                end if;

                                pkg_Traza.Trace('nuTaskTypeId --> ' || nuTaskTypeId ||
                                               ' inuActivity --> ' || inuActivity,
                                               10);

                                --Obtener el valor de la multa de LDC_ALT de acuerdo a la configuracion realizada
                                ldc_boordenes.PROCVALRANGOTIEMPLEGOT(null,
                                                                     null,
                                                                     nuGeograpDepto,
                                                                     null,
                                                                     nuTaskTypeId,
                                                                     null,
                                                                     null,
                                                                     nuDays,
                                                                     nuPercent,
                                                                     nuValue,
                                                                     nuNDays);
                                pkg_Traza.Trace(' Obtener el valor de la multa nuValue --> ' ||
                                               nuValue || ' nuNDays --> ' || nuNDays,
                                               10);
                                --Si existe configuracion
                                if nuValue is not null and nuValue > 0 then
                                    pkg_Traza.Trace('Validando si ya existe multa', 10);
                                    --Validar si ya existe MULTA
                                    nuCount := 0;
                                    open cuExisteMulta(pkg.id);
                                    fetch cuExisteMulta into nuCount;
                                    close cuExisteMulta;

                                    pkg_Traza.Trace('nuCount --> ' || nuCount, 10);

                                    if nuCount = 0 or nuCount is null then
                                        pkg_Traza.Trace('No Existe multa, Registrar multa', 10);
                                        --Registrar multa
                                        isbObservation := 'MULTA GENERADA DESDE PROCESO AUTOMATICO' ||
                                                          ' No.Documento:' || sbDOCUMENT_KEY ||
                                                          ' No. Solicitud:' || pkg.id;
                                        pkg_Traza.Trace(' Observation --> ' || isbObservation,
                                                       10);

                                        ---api de open para crear novedades orden cerrada
                                        LDC_prRegisterNewCharge(nuOperatingUnitId,
                                                                inuActivity,
                                                                inuPersonId,
                                                                null,
                                                                nuValue,
                                                                null,
                                                                null,
                                                                pkg_BCLD_Parameter.fnuObtieneValorNumerico('ID_TIPO_OBS_COMISION_VENTA'),
                                                                isbObservation,
                                                                onuErrorCode,
                                                                osbErrorMessage,
                                                                inuOrderId);
                                         nugrabados := nugrabados + 1;
                                            if mod(nugrabados,nucontareg) = 0 then
                                                pro_grabalog_comision (innusesion, indtToday, innuNroHilo, 0, 'Ha Generado hasta ahora: ' || nugrabados ||
                                                                 ' Ultima Orden generada: ' || inuOrderId);
                                            end if;

                                        pkg_Traza.Trace('onuErrorCode --> ' || onuErrorCode ||
                                                       ' osbErrorMessage' || osbErrorMessage||
                                                       ' sbActivoOrdAdd: '||sbActivoOrdAdd||
                                                       ' TT: '||pkg_BCOrdenes.fnuObtieneTipoTrabajo(inuOrderId)||
                                                       ' sbTaskTypeOrdAdd: '||sbTaskTypeOrdAdd,
                                                       10);

                                        -- CA434 Se valida si la orden se genero con exito y si se debe crear la orden adicional
                                        IF (onuErrorCode = 0 OR onuErrorCode IS NULL) AND sbActivoOrdAdd = 'S' THEN
                                            -- Se valida si el tipo de trabajo aplica
                                            IF INSTR(','||sbTaskTypeOrdAdd||',' , ','||pkg_BCOrdenes.fnuObtieneTipoTrabajo(inuOrderId)||',')  > 0  THEN
                                                -- Se invoca al procedimiento para crear la orden adicional
                                                PROCREAOTADDTTGESTVENT
                                                (
                                                    inuOrderId,
                                                    pkg.id,
                                                    nuOperatingUnitId,
                                                    inuPersonId,
                                                    onuErrorCodeAdd,
                                                    osbErrorMessageAdd,
                                                    nuOrderAdd
                                                );
                            

                                            END IF;

                                        END IF;

                                        pkg_Traza.Trace('onuErrorCode --> ' || onuErrorCode ||
                                                       ' osbErrorMessage' || osbErrorMessage,
                                                       10);
                                                       
                                        if (onuErrorCode <> 0) then
         
                                            pkg_Traza.Trace('NO SE GENERO NOVEDAD DE MULTA', 10);
                                            --persistencia para no generar pago de comisiones en ejecuciones futuras

                                            rgData.order_item_id      := null;
                                            rgData.order_id           := null;
                                            rgData.package_id         := pkg.id;
                                            rgData.FECHA              := pkg_BCLD_Parameter.fsbObtieneValorCadena('FECHA_COM_REG_VENTA');
                                            rgData.OBSERVACION        := 'NO SE GENERO NOVEDAD DE MULTA';

                                            pkg_Traza.Trace('Insert en LDC_PKG_OR_ITEM ', 10);
                                            pkg_Traza.Trace('rgData.LDC_PKG_OR_ITEM_ID->' ||
                                                         rgData.LDC_PKG_OR_ITEM_ID ||
                                                         ' rgData.order_item_id->' ||
                                                         rgData.order_item_id ||
                                                         ' rgData.order_id->' ||
                                                         rgData.order_id ||
                                                         ' rgData.package_id->' ||
                                                         rgData.package_id ||
                                                         ' rgData.FECHA->' || rgData.FECHA ||
                                                         ' rgData.OBSERVACION->' ||
                                                         rgData.OBSERVACION,
                                                         10);

                                            pReg_LDC_PKG_OR_ITEM
                                            (
                                                rgData.order_item_id,
                                                rgData.order_id,
                                                rgData.package_id,
                                                rgData.FECHA,
                                                rgData.OBSERVACION,
                                                nuCateCodi,
                                                nuSucate,
                                                nuZoneIdProduct,
                                                dtFechaRing,
                                                nuCommerPlan,
                                                rgData.package_id,
                                                nuGeograpLoca,
                                                nuGeograpDepto,
                                                dtCuponDate,
                                                nuCupoVal
                                            );

                                        else
 
                                        prGenerarTraza('GOPCVNEL: Orden Padre: '||inuOrderId||' Orden Hija: '||nuOrderAdd, inuOrderId);

                                        pkg_Traza.Trace('inuOrderId --> ' || inuOrderId, 10);
                                        nuActivityId := ldc_bcfinanceot.fnuGetActivityId(inuOrderId);
                                        pkg_Traza.Trace('nuActivityId --> ' || nuActivityId,
                                                     10);
   
                                        pkg_BOGestion_Ordenes.prcActualizaDireccion( inuOrderId,nuAdressId ); 
                                        
                                        daor_order.updgeograp_location_id(inuOrderId,
                                                                        nuGeograpLoca);
                                                                        
                                        pkg_Or_Order.prcActualizaSectorOperativo(inuOrderId,
                                                                        nuOperatingSectorId,
                                                                        nuError,
                                                                        sbError);
                                        IF nuError <> 0 THEN
                                            RAISE pkg_Error.Controlled_Error;
                                        END IF;
                                        daor_order_activity.updoperating_sector_id(nuActivityId,
                                                                                 nuOperatingSectorId);
                                                                                                                                
                                        --Fin Aranda 3275

                                        --Actualizacion de campos orden adicional CA434
                      
                                        IF nuOrderAdd IS NOT NULL THEN

                                            prGenerarTraza('GOPCVNEL: Orden Padre: '||inuOrderId||' Orden Hija: '||nuOrderAdd, nuOrderAdd);

                                            nuActivityIdAdd := ldc_bcfinanceot.fnuGetActivityId(nuOrderAdd);

                                            pkg_BOGestion_Ordenes.prcActualizaDireccion( nuOrderAdd,nuAdressId ); 
                                          
                                            daor_order.updgeograp_location_id(nuOrderAdd,
                                                    nuGeograpLoca);
                                                    
                                            pkg_Or_Order.prcActualizaSectorOperativo(nuOrderAdd,
                                                    nuOperatingSectorId,
                                                    nuError,
                                                    sbError);

                                            IF nuError <> 0 THEN
                                                RAISE pkg_Error.Controlled_Error;
                                            END IF;
                                                    
                                            daor_order_activity.updoperating_sector_id(nuActivityIdAdd,
                                                                                     nuOperatingSectorId);
                                                                                     
                                            OR_BORELATEDORDER.relateorders
                                            (
                                                inuOrderId,
                                                nuOrderAdd,
                                                13
                                            );
                          
                                    -- CA854
                                    nuOperUnit := pkg_BCOrdenes.fnuObtieneUnidadOperativa(inuOrderId);

                                    nuPersonId := pkg_BCOrdenes.fnuObtenerPersona(inuOrderId);

                                    UPDATE or_order_person SET person_id = nuPersonId WHERE ORDER_id = nuOrderAdd;
                                    -- Fin CA854

                                END IF;
                                --Fin Actualizacion de campos orden adicional CA434
                      
                                pkg_Traza.Trace('Fin Actualizacion ', 10);
                                --Fin seccion 07-11-2013
                                SBobservacion := 'SE GENERO NOVEDAD DE MULTA ' ||
                                               inuActivity || ' - ' ||
                                               dage_items.fsbgetdescription(inuActivity);
                                nuBan         := 1;
                                sbZonaTAbla := null;
                            end if;
                        end if;
                    else
                        pkg_Traza.Trace('Ya existe multa, persistencia para no generar pago de comisiones en ejecuciones futuras',
                                     10);
                        --persistencia para no generar pago de comisiones en ejecuciones futuras

                        rgData.order_item_id      := null;
                        rgData.order_id           := null;
                        rgData.package_id         := pkg.id;
                        rgData.FECHA              := pkg_BCLD_Parameter.fsbObtieneValorCadena('FECHA_COM_REG_VENTA');
                        rgData.OBSERVACION        := 'NO SE ENCONTRARON CONDICIONES PARA GENERACION DE MULTA';

                        pkg_Traza.Trace('Insert en LDC_PKG_OR_ITEM ', 10);
                        pkg_Traza.Trace('rgData.LDC_PKG_OR_ITEM_ID->' ||
                                     rgData.LDC_PKG_OR_ITEM_ID ||
                                     ' rgData.order_item_id->' ||
                                     rgData.order_item_id ||
                                     ' rgData.order_id->' || rgData.order_id ||
                                     ' rgData.package_id->' ||
                                     rgData.package_id || ' rgData.FECHA->' ||
                                     rgData.FECHA || ' rgData.OBSERVACION->' ||
                                     rgData.OBSERVACION,
                                     10);

                        pReg_LDC_PKG_OR_ITEM
                        (
                            rgData.order_item_id,
                            rgData.order_id,
                            rgData.package_id,
                            rgData.FECHA,
                            rgData.OBSERVACION,
                            nuCateCodi,
                            nuSucate,
                            null,
                            dtFechaRing,
                            nuCommerPlan,
                            rgData.package_id,
                            nuGeograpLoca,
                            nuGeograpDepto,
                            dtCuponDate,
                            nuCupoVal
                        );

                    end if;
                else

                    pkg_Traza.Trace('COMISION', 10);
                    --Al generar la novedad,  se debe calcular el valor a pagar (con la funcion -> IN: mo_packages.package_id)
                    RgCommission := FnuGetCommissionValue(pkg.sbTime,
                                                          pkg.id,
                                                          nuAdressId,
                                                          nuProductId,
                                                          nuOperatingUnitId);
                    pkg_Traza.Trace('Valida si tiene comision RgCommission.onuCommissionValue -> ' ||
                                   RgCommission.onuCommissionValue,
                                   10);

                    if RgCommission.onuCommissionValue > 0 then

                        pkg_Traza.Trace('No existe comision asociada, Genera comision',
                                     10);
                        inuOrderId := null;
                  
                        -- CA854
                        IF MONTHS_BETWEEN(pkg_BCSolicitudes.fdtGetFechaRegistro(pkg.id), dtFechaRing) <= nuCantMeses THEN
                            sbZonaCalc := 'N';
                        ELSE
                            sbZonaCalc := 'S';
                        END IF;

                        pkg_Traza.Trace('Zona calculada: '||sbZonaCalc||' RgCommission.sbIsZoneOri: '||RgCommission.sbIsZoneOri,10);

                        -- Se valida si la zona calculada es diferente a la que ya tiene
                        IF nvl(RgCommission.sbIsZoneOri,'-') <> sbZonaCalc THEN
                            -- Se registra la exclusion
                            pRegistraExcepcion(pkg.id);
                            -- En caso de caer aca, seguir con el siguiente para no liquidar
                            GOTO siguiente;

                        ELSE

                            pActualizaRegistro(pkg.id);

                        END IF;

                        OPEN cuApplyCont(nuContraId, nuCommiType);
                        FETCH cuApplyCont INTO nuAppliCont;
                        CLOSE cuApplyCont;

                        OPEN cuAplicaSubsidio(pkg.id);
                        FETCH cuAplicaSubsidio INTO sbIsSubcidy;
                        IF cuAplicaSubsidio%NOTFOUND THEN
                         sbIsSubcidy :='N';
                        END IF;
                        
                        CLOSE cuAplicaSubsidio;
                        -- Se valida si la venta tiene subsidio, en ese caso se toma como zona nueva
                        IF sbIsSubcidy = 'Y' AND nuAppliCont > 0 THEN
                            RgCommission.sbIsZone := 'N';
                        END IF;
                  
                        --Validar si la categoria del producto es comercial
                        if nuCateCodi =
                            pkg_BCLD_Parameter.fnuObtieneValorNumerico('RESIDEN_CATEGORY') then
                            if RgCommission.sbIsZone = 'N' then
                                if pkg.sbTime = 'B' then
                                    inuActivity := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ACT_COMISION_INICIO_VENTA_ZNR');
                                else
                                    inuActivity := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ACT_COMISION_LEG_VENTA_ZNR');
                                end if;
                            else
                                if RgCommission.sbIsZone = 'S' then
                                    if pkg.sbTime = 'B' then
                                        inuActivity := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ACT_COMISION_INICIO_VENTA_ZSR');
                                    else
                                        inuActivity := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ACT_COMISION_LEG_VENTA_ZSR');
                                    end if;
                                end if;
                            end if;
                        else
                            --Validar si la categoria del producto es comercial
                            if nuCateCodi =
                                pkg_BCLD_Parameter.fnuObtieneValorNumerico('COMMERCIAL_CATEGORY') then
                                if RgCommission.sbIsZone = 'N' then
                                    if pkg.sbTime = 'B' then
                                        inuActivity := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ACT_COMISION_INICIO_VENTA_ZNC');
                                    else
                                        inuActivity := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ACT_COMISION_LEG_VENTA_ZNC');
                                    end if;
                                else
                                    if RgCommission.sbIsZone = 'S' then
                                        if pkg.sbTime = 'B' then
                                            inuActivity := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ACT_COMISION_INICIO_VENTA_ZSC');
                                        else
                                            inuActivity := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ACT_COMISION_LEG_VENTA_ZSC');
                                        end if;
                                    end if;
                                end if;
                            end if;
                        end if;
                        pkg_Traza.Trace('Actividad inuActivity --> ' ||
                                     inuActivity,
                                     10);
                        --API para registrar novedades
                        isbObservation := 'COMISION GENERADA DESDE PROCESO AUTOMATICO' ||
                                        ' No.Documento:' || sbDOCUMENT_KEY ||
                                        ' No. Solicitud:' || pkg.id;
                        pkg_Traza.Trace('Observation  --> ' || isbObservation, 10);

                        LDC_prRegisterNewCharge(nuOperatingUnitId,
                                              inuActivity,
                                              inuPersonId,
                                              null,
                                              RgCommission.onuCommissionValue,
                                              null,
                                              null,
                                              pkg_BCLD_Parameter.fnuObtieneValorNumerico('ID_TIPO_OBS_COMISION_VENTA'),
                                              isbObservation,
                                              onuErrorCode,
                                              osbErrorMessage,
                                              inuOrderId);

                        pkg_Traza.Trace('onuErrorCode --> ' || onuErrorCode ||
                                     ' osbErrorMessage' || osbErrorMessage,
                                     10);

                        -- CA434 Se valida si la orden se genero con exito y si se debe crear la orden adicional
                        IF (onuErrorCode = 0 OR onuErrorCode IS NULL) AND sbActivoOrdAdd = 'S' THEN
                            -- Se valida si el tipo de trabajo aplica
                            IF INSTR(','||sbTaskTypeOrdAdd||',' , ','||pkg_BCOrdenes.fnuObtieneTipoTrabajo(inuOrderId)||',')  > 0  THEN
                                -- Se invoca al procedimiento para crear la orden adicional
                                PROCREAOTADDTTGESTVENT
                                (
                                    inuOrderId,
                                    pkg.id,
                                    nuOperatingUnitId,
                                    inuPersonId,
                                    onuErrorCodeAdd,
                                    osbErrorMessageAdd,
                                    nuOrderAdd
                                );
                                
                            END IF;

                        END IF;

                                    if (onuErrorCode <> 0) then

                                        pkg_Traza.Trace('NO SE GENERO NOVEDAD DE COMISION', 10);
                                        --persistencia para no generar pago de comisiones en ejecuciones futuras

                                        rgData.order_item_id      := null;
                                        rgData.order_id           := null;
                                        rgData.package_id         := pkg.id;
                                        rgData.FECHA              := pkg_BCLD_Parameter.fsbObtieneValorCadena('FECHA_COM_REG_VENTA');
                                        rgData.OBSERVACION        := 'NO SE GENERO NOVEDAD DE COMISION' ||
                                                                     inuActivity || ' - ' ||
                                                                     dage_items.fsbgetdescription(inuActivity,
                                                                                                  NULL);

                                        pkg_Traza.Trace('Insert en LDC_PKG_OR_ITEM ', 10);
                                        pkg_Traza.Trace('rgData.LDC_PKG_OR_ITEM_ID->' ||
                                                       rgData.LDC_PKG_OR_ITEM_ID ||
                                                       ' rgData.order_item_id->' ||
                                                       rgData.order_item_id ||
                                                       ' rgData.order_id->' || rgData.order_id ||
                                                       ' rgData.package_id->' ||
                                                       rgData.package_id || ' rgData.FECHA->' ||
                                                       rgData.FECHA || ' rgData.OBSERVACION->' ||
                                                       rgData.OBSERVACION,
                                                       10);


                                        pReg_LDC_PKG_OR_ITEM
                                        (
                                            rgData.order_item_id,
                                            rgData.order_id,
                                            rgData.package_id,
                                            rgData.FECHA,
                                            rgData.OBSERVACION,
                                            nuCateCodi,
                                            nuSucate,
                                            RgCommission.sbIsZoneOri,
                                            dtFechaRing,
                                            nuCommerPlan,
                                            rgData.package_id,
                                            nuGeograpLoca,
                                            nuGeograpDepto,
                                            dtCuponDate,
                                            nuCupoVal
                                        );

                                    else

                                        prGenerarTraza('GOPCVNEL: Orden Padre: '||inuOrderId||' Orden Hija: '||nuOrderAdd, inuOrderId);

                                        pkg_Traza.Trace('inuOrderId --> ' || inuOrderId, 10);
                                        nuActivityId := ldc_bcfinanceot.fnuGetActivityId(inuOrderId);
                                        pkg_Traza.Trace('nuActivityId --> ' || nuActivityId, 10);
                                        
                                        PKG_BOGESTION_ORDENES.PRCACTUALIZADIRECCION(inuOrderId,nuAdressId);
                                        
                                        pkg_Traza.Trace('Fin Actualizacion ', 10);
                                        pkg_Traza.Trace('Orden generada inuOrderId --> ' ||
                                                       inuOrderId,
                                                       10);
                                                                       
                                        daor_order.updgeograp_location_id(inuOrderId,
                                                                          nuGeograpLoca);
                                        pkg_Or_Order.prcActualizaSectorOperativo(inuOrderId,
                                                                          nuOperatingSectorId,
                                                                          nuError,
                                                                          sbError);
                                                                          
                                        IF nuError <> 0 THEN
                                            RAISE pkg_Error.Controlled_Error;
                                        END IF;
                                                                                                                  
                                        daor_order_activity.updoperating_sector_id(nuActivityId,
                                                                                   nuOperatingSectorId);
                                                                                   
                                        --Actualizacion de campos orden adicional CA434

                                        IF nuOrderAdd IS NOT NULL THEN

                                            prGenerarTraza('GOPCVNEL: Orden Padre: '||inuOrderId||' Orden Hija: '||nuOrderAdd, nuOrderAdd);

                                            nuActivityIdAdd := ldc_bcfinanceot.fnuGetActivityId(nuOrderAdd);

                                            PKG_BOGESTION_ORDENES.PRCACTUALIZADIRECCION(nuOrderAdd,nuAdressId);
                                                                                     
                                            daor_order.updgeograp_location_id(nuOrderAdd,
                                                                            nuGeograpLoca);
                                            pkg_Or_Order.prcActualizaSectorOperativo(nuOrderAdd,
                                                                            nuOperatingSectorId,
                                                                            nuError,
                                                                            sbError);
                                                                            
                                            IF nuError <> 0 THEN
                                                RAISE pkg_Error.Controlled_Error;
                                            END IF;                                                                            

                                            daor_order_activity.updoperating_sector_id(nuActivityIdAdd,
                                                                                     nuOperatingSectorId);

                                            OR_BORELATEDORDER.relateorders
                                            (
                                                inuOrderId,
                                                nuOrderAdd,
                                                13
                                            );

                                            -- CA854
                                            nuOperUnit := pkg_BCOrdenes.fnuObtieneUnidadOperativa(inuOrderId);

                                            nuPersonId := pkg_BCOrdenes.fnuObtenerPersona(inuOrderId);
                                            
                                            UPDATE or_order_person SET person_id = nuPersonId WHERE ORDER_id = nuOrderAdd;
                                            -- Fin CA854

                                        END IF;
                                        
                                        --Fin Actualizacion de campos orden adicional CA434
                                           
                                        SBobservacion := 'SE GENERO NOVEDAD DE COMISION ' ||
                                         inuActivity || ' - ' ||
                                         dage_items.fsbgetdescription(inuActivity,
                                                                      NULL);
                                        pkg_Traza.Trace('SBobservacion --> ' || SBobservacion,
                                                   10);

                                        nuBan := 1;
                                        sbZonaTAbla :=RgCommission.sbIsZone;
                                    end if;
                                else
                                    if nvl(RgCommission.sbIsZone,'X') = 'X' then
                                        pRegistraExcepcion(pkg.id);
                                    end if;

                                    pkg_Traza.Trace('Ya existe comision, persistencia para no generar pago de comisiones en ejecuciones futuras',
                                                 10);
                                    --persistencia para no generar pago de comisiones en ejecuciones futuras

                                    rgData.order_item_id      := null;
                                    rgData.order_id           := null;
                                    rgData.package_id         := pkg.id;
                                    rgData.FECHA              := pkg_BCLD_Parameter.fsbObtieneValorCadena('FECHA_COM_REG_VENTA');
                                    rgData.OBSERVACION        := 'NO SE ENCONTRARON CONDICIONES PARA PAGO DE COMISION';

                                    pkg_Traza.Trace('Insert en LDC_PKG_OR_ITEM ', 10);
                                    pkg_Traza.Trace('rgData.LDC_PKG_OR_ITEM_ID->' ||
                                                 rgData.LDC_PKG_OR_ITEM_ID ||
                                                 ' rgData.order_item_id->' ||
                                                 rgData.order_item_id ||
                                                 ' rgData.order_id->' || rgData.order_id ||
                                                 ' rgData.package_id->' ||
                                                 rgData.package_id || ' rgData.FECHA->' ||
                                                 rgData.FECHA || ' rgData.OBSERVACION->' ||
                                                 rgData.OBSERVACION,
                                                 10);

                                    pReg_LDC_PKG_OR_ITEM
                                    (
                                        rgData.order_item_id,
                                        rgData.order_id,
                                        rgData.package_id,
                                        rgData.FECHA,
                                        rgData.OBSERVACION,
                                        nuCateCodi,
                                        nuSucate,
                                        RgCommission.sbIsZoneOri,
                                        dtFechaRing,
                                        nuCommerPlan,
                                        rgData.package_id,
                                        nuGeograpLoca,
                                        nuGeograpDepto,
                                        dtCuponDate,
                                        nuCupoVal
                                    );

                                end if;
                            end if;

                            pkg_Traza.Trace(' nuBan --> ' || nuBan, 10);

                            if nuBan = 1 then
                                pkg_Traza.Trace('Valida actividad ' || inuActivity, 10);
                                if nvl(inuActivity, 0) > 0 then
                                    pkg_Traza.Trace('Persistencia para no generar pago de comisiones en ejecuciones futuras',
                                             10);
                                    --persistencia para no generar pago de comisiones en ejecuciones futuras

                                    rgData.order_item_id      := inuActivity;
                                    rgData.order_id           := inuOrderId;
                                    rgData.package_id         := pkg.id;
                                    rgData.FECHA              := pkg_BCLD_Parameter.fsbObtieneValorCadena('FECHA_COM_REG_VENTA');
                                    rgData.OBSERVACION        := SBobservacion;

                                    pkg_Traza.Trace('Insert en LDC_PKG_OR_ITEM ', 10);
                                    pkg_Traza.Trace('rgData.LDC_PKG_OR_ITEM_ID->' ||
                                                 rgData.LDC_PKG_OR_ITEM_ID ||
                                                 ' rgData.order_item_id->' ||
                                                 rgData.order_item_id ||
                                                 ' rgData.order_id->' || rgData.order_id ||
                                                 ' rgData.package_id->' ||
                                                 rgData.package_id || ' rgData.FECHA->' ||
                                                 rgData.FECHA || ' rgData.OBSERVACION->' ||
                                                 rgData.OBSERVACION,
                                                 10);

                                    pReg_LDC_PKG_OR_ITEM
                                    (
                                        rgData.order_item_id,
                                        rgData.order_id,
                                        rgData.package_id,
                                        rgData.FECHA,
                                        rgData.OBSERVACION,
                                        nuCateCodi,
                                        nuSucate,
                                        sbZonaTAbla,
                                        dtFechaRing,
                                        nuCommerPlan,
                                        rgData.package_id,
                                        nuGeograpLoca,
                                        nuGeograpDepto,
                                        dtCuponDate,
                                        nuCupoVal
                                    );

                                end if;
                            end if;

                        ELSE

                            pkg_Traza.Trace('LA DIRECCION DE LA VARIABLE nuAdressId NO EXISTE O NO ES VALIDA',
                                         10);
                            --persistencia para no generar pago de comisiones en ejecuciones futuras

                            rgData.order_item_id      := null;
                            rgData.order_id           := null;
                            rgData.package_id         := pkg.id;
                            rgData.FECHA              := pkg_BCLD_Parameter.fsbObtieneValorCadena('FECHA_COM_REG_VENTA');
                            rgData.OBSERVACION        := 'NO EXISTE DIRECCION VALIDA PARA OBTENER LA LOCALIDAD';

                            pkg_Traza.Trace('Insert en LDC_PKG_OR_ITEM ', 10);
                            pkg_Traza.Trace('rgData.LDC_PKG_OR_ITEM_ID->' ||
                                         rgData.LDC_PKG_OR_ITEM_ID ||
                                         ' rgData.order_item_id->' ||
                                         rgData.order_item_id || ' rgData.order_id->' ||
                                         rgData.order_id || ' rgData.package_id->' ||
                                         rgData.package_id || ' rgData.FECHA->' ||
                                         rgData.FECHA || ' rgData.OBSERVACION->' ||
                                         rgData.OBSERVACION,
                                         10);

                            pReg_LDC_PKG_OR_ITEM
                            (
                                rgData.order_item_id,
                                rgData.order_id,
                                rgData.package_id,
                                rgData.FECHA,
                                rgData.OBSERVACION,
                                nuCateCodi,
                                nuSucate,
                                nuZoneIdProduct,
                                dtFechaRing,
                                nuCommerPlan,
                                rgData.package_id,
                                nuGeograpLoca,
                                nuGeograpDepto,
                                dtCuponDate,
                                nuCupoVal
                            );

                        END IF; --VALIDACION UBICACION GEOGRAFICA
                    ELSE

                        pkg_Traza.Trace('LA DIRECCION DE LA VARIABLE nuAdressId NO EXISTE O NO ES VALIDA',
                                       10);
                        --persistencia para no generar pago de comisiones en ejecuciones futuras

                        rgData.order_item_id      := null;
                        rgData.order_id           := null;
                        rgData.package_id         := pkg.id;
                        rgData.FECHA              := pkg_BCLD_Parameter.fsbObtieneValorCadena('FECHA_COM_REG_VENTA');
                        rgData.OBSERVACION        := 'NO EXISTE SEGMENTO PARA LA DIRECCION';

                        pkg_Traza.Trace('Insert en LDC_PKG_OR_ITEM ', 10);
                        pkg_Traza.Trace('rgData.LDC_PKG_OR_ITEM_ID->' ||
                                       rgData.LDC_PKG_OR_ITEM_ID ||
                                       ' rgData.order_item_id->' ||
                                       rgData.order_item_id || ' rgData.order_id->' ||
                                       rgData.order_id || ' rgData.package_id->' ||
                                       rgData.package_id || ' rgData.FECHA->' ||
                                       rgData.FECHA || ' rgData.OBSERVACION->' ||
                                       rgData.OBSERVACION,
                                       10);

                        pReg_LDC_PKG_OR_ITEM
                        (
                            rgData.order_item_id,
                            rgData.order_id,
                            rgData.package_id,
                            rgData.FECHA,
                            rgData.OBSERVACION,
                            nuCateCodi,
                            nuSucate,
                            nuZoneIdProduct,
                            dtFechaRing,
                            nuCommerPlan,
                            rgData.package_id,
                            nuGeograpLoca,
                            nuGeograpDepto,
                            dtCuponDate,
                            nuCupoVal
                        );

                    END IF; --VALIDACION DEL SEGMENTO DE LA DIRECCION DEL PRODUCTO

                END IF;
            exception
                when others then

                pkg_Traza.Trace('En ERROR others ', 10);
                --persistencia para no generar pago de comisiones en ejecuciones futuras

                rgData.order_item_id      := null;
                rgData.order_id           := null;
                rgData.package_id         := pkg.id;
                rgData.FECHA              := pkg_BCLD_Parameter.fsbObtieneValorCadena('FECHA_COM_REG_VENTA');
                rgData.OBSERVACION        := 'ERROR DURANTE LA EJECUCION DEL PROCESO ' ||
                                           sqlcode || ' - ' || sqlerrm;

                pkg_Traza.Trace('Insert en LDC_PKG_OR_ITEM ', 10);
                pkg_Traza.Trace('rgData.LDC_PKG_OR_ITEM_ID->' ||
                             rgData.LDC_PKG_OR_ITEM_ID ||
                             ' rgData.order_item_id->' || rgData.order_item_id ||
                             ' rgData.order_id->' || rgData.order_id ||
                             ' rgData.package_id->' || rgData.package_id ||
                             ' rgData.FECHA->' || rgData.FECHA ||
                             ' rgData.OBSERVACION->' || rgData.OBSERVACION,
                             10);

                pReg_LDC_PKG_OR_ITEM
                (
                    rgData.order_item_id,
                    rgData.order_id,
                    rgData.package_id,
                    rgData.FECHA,
                    rgData.OBSERVACION,
                    nuCateCodi,
                    nuSucate,
                    nuZoneIdProduct,
                    dtFechaRing,
                    nuCommerPlan,
                    rgData.package_id,
                    nuGeograpLoca,
                    nuGeograpDepto,
                    dtCuponDate,
                    nuCupoVal
                );
            
            end;

            <<siguiente>>
            NULL;
            nucantiregcom := nucantiregcom + 1;
            IF nucantiregcom >= nucontareg THEN
            COMMIT;
            nucantiregtot := nucantiregtot + nucantiregcom;
            nucantiregcom := 0;
            END IF;

        end loop;

        commit;
        pro_grabalog_comision (innusesion, indtToday, innuNroHilo, 0, 'Proceso: ' || nucantiregtot);
        pro_grabalog_comision (innusesion, indtToday, innuNroHilo, 0, 'Genero: ' || nugrabados);
        pro_grabalog_comision (innusesion, indtToday, innuNroHilo, 2, 'Termino Hilo: ' || innuNroHilo ||
                               ' - Proceso Ok');
        pkg_Traza.Trace('Finalizo LDC_BCSALESCOMMISSION_NEL.PrGenerateCommission Hilo ' || innuNroHilo, 10);

    exception
        WHEN pkg_Error.Controlled_Error then
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );    
            pro_grabalog_comision (innusesion, indtToday, innuNroHilo, -1, 'Hilo: ' || innuNroHilo ||
                             ' Termino con errores: ' || sbError);
            rollback;
            raise pkg_Error.Controlled_Error;
        When others then
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );        
            pro_grabalog_comision (innusesion, indtToday, innuNroHilo, -1, 'Hilo: ' || innuNroHilo ||
                             ' Termino con errores: ' || sbError);
            rollback;
            raise pkg_Error.Controlled_Error;
    end PrGenerateCommission_Hilos;
  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : FnuGetCommissionValue
    Descripcion    : Funcion que retorna el valor de la comision de venta al inicio de acuerdo a la
                     configuracion realizada en la forma CTCVE.
    Autor          : Sayra Ocoro
    Fecha          : 08/03/2013

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    19-11-2021        Horbath           CA854: Se ajusta para que valide si la venta es subcidiada, en ese caso siempre
                                        se debe tomar como zona nueva.
    12-08-2014        agordillo         NC 1185, Se cambia el bloque del excepcion para el cursor cuPlanCommissionId,
                                        dado que con no_data_found no se controlaria cuando el cursor viene
                                        nulo, se cambiar por:  IF cuPlanCommissionId%NOTFOUND THEN
  ******************************************************************/

    function FnuGetCommissionValue(isbTime          IN varchar2,
                                 inuPackageId     IN mo_packages.package_id%type,
                                 inuAddressId     IN ab_address.address_id%type,
                                 inuProductid     IN pr_product.product_id%Type,
                                 inuOperatingUnit IN or_operating_unit.operating_unit_id%type)
    return RgCommissionRegister is
    
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'FnuGetCommissionValue';
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 
        
        RgReturn           RgCommissionRegister;
        nuContractorId     or_operating_unit.contractor_id%type;
        nuCommissionType   LDC_COMISION_PLAN_NEL.COMISION_PLAN_ID%type;
        nuCommercialPlanId LDC_COMISION_PLAN_NEL.COMMERCIAL_PLAN_ID%type;
        nuGeograpDepto     LDC_COMISION_PLAN_NEL.DEPACODI%TYPE; -- Se agrega caso 200-1487
        nuCateCodi         LDC_COMISION_PLAN_NEL.CATECODI%type;
        nuSucaCodi         LDC_COMISION_PLAN_NEL.SUCACODI%type;
        nuCommissionPlanId LDC_COMISION_PLAN_NEL.COMISION_PLAN_ID%type;
        dtAttentionDate    mo_packages.ATTENTION_DATE%type;
        nuTotalPercent     LDC_COMI_TARIFA_NEL.PORC_TOTAL_COMI%type;
        nuInitialPercent   LDC_COMI_TARIFA_NEL.PORC_ALFINAL%type;
        nuFinalPercent     LDC_COMI_TARIFA_NEL.PORC_ALFINAL%type;
        nuPercent          ldc_info_predio.PORC_PENETRACION%type;
        nuIdPremise        ab_premise.premise_id%type;
        nuTotalValueValue  mo_gas_sale_data.TOTAL_VALUE%type;
        AXnuDepaCodi       LDC_COMISION_PLAN_NEL.DEPACODI%type; -- Se agrega caso 200-1487
        AXnuCateCodi       LDC_COMISION_PLAN_NEL.CATECODI%type;
        AXnuSucaCodi       LDC_COMISION_PLAN_NEL.SUCACODI%type;
        SW                 NUMBER;
        nuGeograpLoca      ge_geogra_location.geograp_location_id%type;
        --Cursor para obtener
        cursor cuPlanCommissionId(nuCommissionType   LDC_COMISION_PLAN_NEL.COMISION_PLAN_ID%type,
                                  nuCommercialPlanId LDC_COMISION_PLAN_NEL.COMMERCIAL_PLAN_ID%type,
                                  sbIsZone           ldc_info_predio.is_zona%type,
                                  nuDepaCodi         LDC_COMISION_PLAN_NEL.DEPACODI%type,
                                  nuCateCodi         LDC_COMISION_PLAN_NEL.CATECODI%type,
                                  nuSucaCodi         LDC_COMISION_PLAN_NEL.SUCACODI%type) is
          select nvl(COMISION_PLAN_ID, 0) PlanCommissionId
            from LDC_COMISION_PLAN_NEL
           where TIPO_COMISION_ID = nuCommissionType
             and IS_ZONA = sbIsZone
             and COMMERCIAL_PLAN_ID = nuCommercialPlanId
             and NVL(DEPACODI, -1) = NVL(nuDepaCodi, -1)
             and NVL(CATECODI, -1) = NVL(nuCateCodi, -1)
             and NVL(SUCACODI, -1) = NVL(nuSucaCodi, -1);

        --Cursor para obtener los valores para aplicar en el calculo de la comision al registro
        cursor cuCommission(dtAttentionDate    mo_packages.ATTENTION_DATE%type,
                            nuCommissionPlanId LDC_COMISION_PLAN_NEL.COMISION_PLAN_ID%type) is
          select nvl(PORC_TOTAL_COMI, 0) totalPercent,
                 nvl(PORC_ALINICIO, 0) initialPercent,
                 --nvl(VALOR_ALINICIO, 0) initialValue, Se quita caso 200-1487
                 nvl(PORC_ALFINAL, 0) finalPercent
                 --nvl(VALOR_ALFINAL, 0) finalValue Se quita caso 200-1487
            from LDC_COMI_TARIFA_NEL
           where COMISION_PLAN_ID = nuCommissionPlanId
             and dtAttentionDate between FECHA_VIG_INICIAL and FECHA_VIG_FINAL;
             --and nuPercent between RANG_INI_PENETRA and RANG_FIN_PENETRA; Se quita caso 200-1487

        --Cursor para obtener el tipo de zona y el porcentaje de cobertura en la zona
        cursor cuZonePercent(nuIdPremise ab_premise.premise_id%type) is
          select IS_ZONA sbZone, nvl(PORC_PENETRACION, 0) nuPercent
            from ldc_info_predio
           where PREMISE_ID = nuIdPremise
             and rownum = 1;
        sbCargdoso cargos.cargdoso%type;
        
        CURSOR cuAplicaSubsidio
        IS
            SELECT aplicasubsidio
            FROM LDC_SUBSIDIOS
            WHERE PACKAGE_id = inuPackageId;
            
        CURSOR cuApplyCont
        (
            inuContratista     IN   LDC_INFO_OPER_UNIT_NEL.oper_unit_id%TYPE,
            inuTipoComi        IN   LDC_INFO_OPER_UNIT_NEL.tipo_comision_id%TYPE
        )
        IS
            SELECT count(1)
            FROM LDC_INFO_OPER_UNIT_NEL
            WHERE operating_unit_id = inuContratista
            AND tipo_comision_id = inuTipoComi
            AND apply_subcidy = 'Y';

        sbIsSubcidy     LDC_SUBSIDIOS.aplicasubsidio%TYPE;
        nuAppliCont     NUMBER;
    
    begin
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        RgReturn.onuCommissionValue := 0;
        RgReturn.sbIsZone           := 'X';
        RgReturn.sbIsZoneOri       := 'X';
        --NIVELES DE VALIDAcion
        --POR ZONA -> MERCADO RELEVANTE->CATEGORIA->SUBCATEGORIA->PLAN COMERCIAL
        --COMODINES: zona, subcategoria,plan comercial, rango % covertura, (% o valor) excluyentes
        --Obtener id predio
        nuIdPremise := pkg_BCDirecciones.fnuGetPredio(inuAddressId);

        if nuIdPremise is null then
            pkg_error.setErrorMessage( isbMsgErrr => 'No existe predio asociado a la direccion ' || inuAddressId);
        end if;
        
        --Obtener zona  porcentaje de cobertura para la zona
        open cuZonePercent(nuIdPremise);
        fetch cuZonePercent into RgReturn.sbIsZone, nuPercent;
                
        if cuZonePercent%notfound then
          RgReturn.onuCommissionValue := 0;
          RgReturn.sbIsZone           := 'X';
          close cuZonePercent;
          return RgReturn;
        end if;

        RgReturn.sbIsZoneOri := RgReturn.sbIsZone;
    
        --Obtener la localidad
        nuGeograpLoca := pkg_BCDirecciones.fnuGetLocalidad(inuAddressId);
        
        --Categoria
        nuCateCodi := to_number(pkg_BCProducto.fnuCategoria(inuProductId));
        --Subcategoria
        nuSucaCodi := to_number(pkg_BCProducto.fnuSubCategoria(inuProductId));
        --Obtener mercado relevante
        nuGeograpDepto := pkg_BCDirecciones.fnuGetUbicaGeoPadre(nuGeograpLoca);
        pkg_Traza.Trace('FnuGetCommissionValue: Departamento: ['||nuGeograpDepto||']',
                       10);
        --Obtener fecha de la solicitud
        dtAttentionDate := pkg_BCSolicitudes.fdtGetFechaRegistro(inuPackageId);
        
        --Obtener plan comercial
        nuCommercialPlanId := to_number(LDC_BOUTILITIES.fsbGetValorCampoTabla('mo_motive',
                                                                              'PACKAGE_ID',
                                                                              'COMMERCIAL_PLAN_ID',
                                                                              inuPackageId));
        pkg_Traza.Trace('FnuGetCommissionValue: ComercialPlan: ['||nuCommercialPlanId||']',
                       10);
                       
        if nuCommercialPlanId is null or nuCommercialPlanId = -1 then
            pkg_error.setErrorMessage( isbMsgErrr => 'No existe un plan comercial asociado a la solicitud de venta ' || inuPackageId);
        end if;
        --Obtener el contratista de la unidad operativa
        nuContractorId := pkg_BCUnidadOperativa.fnuGetContratista(inuOperatingUnit);

        if nuContractorId is null or nuContractorId = -1 then
            pkg_error.setErrorMessage( isbMsgErrr => 'La unidad operativa ' || inuOperatingUnit || ' no esta asociado a una orden de trabajo.');
        end if;
        --Obtener tipo de comision para contratista y validar
        --Validar si se realizo la configuracion para el contratista
        nuCommissionType := to_number(LDC_BOUTILITIES.fsbGetValorCampoTabla('LDC_INFO_OPER_UNIT_NEL',
                                                                            'OPERATING_UNIT_ID',
                                                                            'TIPO_COMISION_ID',
                                                                            nuContractorId));

        if nuCommissionType = -1 or nuCommissionType is null then
          return RgReturn;
        else

            OPEN cuApplyCont(nuContractorId, nuCommissionType);
            FETCH cuApplyCont INTO nuAppliCont;
            CLOSE cuApplyCont;

            OPEN cuAplicaSubsidio;
            FETCH cuAplicaSubsidio INTO sbIsSubcidy;
            CLOSE cuAplicaSubsidio;
            
            -- Se valida si la venta tiene subsidio, en ese caso se toma como zona nueva
            IF sbIsSubcidy = 'Y' AND nuAppliCont > 0 THEN
             RgReturn.sbIsZoneOri := RgReturn.sbIsZone;
             RgReturn.sbIsZone := 'N';
            END IF;

            SW           := 0;
            AXnuDepaCodi := nuGeograpDepto;
            AXnuCateCodi := nuCateCodi;
            AXnuSucaCodi := nuSucaCodi;
        
            LOOP
                BEGIN
                    open cuPlanCommissionId(nuCommissionType,
                                          nuCommercialPlanId,
                                          RgReturn.sbIsZone,
                                          AXnuDepaCodi,
                                          AXnuCateCodi,
                                          AXnuSucaCodi);
                    fetch cuPlanCommissionId into nuCommissionPlanId;

                    IF cuPlanCommissionId%NOTFOUND THEN
                        IF SW = 0 THEN
                            AXnuDepaCodi := nuGeograpDepto;
                            AXnuCateCodi := nuCateCodi;
                            AXnuSucaCodi := NULL;
                        ELSIF SW = 1 THEN
                            AXnuDepaCodi := NULL;
                            AXnuCateCodi := nuCateCodi;
                            AXnuSucaCodi := nuSucaCodi;
                        ELSIF SW = 2 THEN
                            AXnuDepaCodi := nuGeograpDepto;
                            AXnuCateCodi := NULL;
                            AXnuSucaCodi := NULL;
                        ELSIF SW = 3 THEN
                            AXnuDepaCodi := NULL;
                            AXnuCateCodi := nuCateCodi;
                            AXnuSucaCodi := NULL;
                        ELSIF SW = 4 THEN
                            AXnuDepaCodi := NULL;
                            AXnuCateCodi := NULL;
                            AXnuSucaCodi := NULL;
                        END IF;
                    END IF;

                END;
            
                close cuPlanCommissionId;
                EXIT WHEN nuCommissionPlanId > 0 OR SW = 5;
                SW := SW + 1;

            END LOOP;

            open cuCommission(dtAttentionDate, nuCommissionPlanId);
            fetch cuCommission into nuTotalPercent,nuInitialPercent,nuFinalPercent;
            close cuCommission;
      
            if nuTotalPercent = 0 then
                if isbTime = 'B' then
                  RgReturn.onuCommissionValue := 0;
                else
                  if isbTime = 'L' then
                    RgReturn.onuCommissionValue := 0;
                  end if;
                end if;
                return RgReturn;
            else
                nuTotalValueValue := LDC_FNUGETVLRTARIFA(inuPackageId);
                pkg_Traza.Trace('FnuGetCommissionValue: Valor Tarifa: ['||nuTotalValueValue||']',
                           10);

                if isbTime = 'B' then
                    RgReturn.onuCommissionValue := ((nuTotalPercent / 100) *
                                                 (nuInitialPercent / 100)) *
                                                 nuTotalValueValue;
                    pkg_Traza.Trace('FnuGetCommissionValue: % al inicio: ['||RgReturn.onuCommissionValue||']',
                           10);
                else
                    if isbTime = 'L' then
                        RgReturn.onuCommissionValue := ((nuTotalPercent / 100) *
                                               (nuFinalPercent / 100)) *
                                               nuTotalValueValue;
                        pkg_Traza.Trace('FnuGetCommissionValue: % al final: ['||RgReturn.onuCommissionValue||']',
                       10);
                    end if;
                end if;
                return RgReturn;
            end if;
        end if;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);      
        return RgReturn;
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    end FnuGetCommissionValue;

    /*Funcion que devuelve la version del pkg*/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        return CSBVERSION;
    END FSBVERSION;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fnuGetPackagesVR
    Descripcion    : Funcion que valida si una solicitud pertence a un tipo de paquete que tiene asociada unas ot
                   en estado 7 u 8. Se usa en condicion de visualizacion solicitada en la NC 2046
    Autor          : Sayra Ocoro
    Fecha          : 05/12/2013

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    03-ENE-2015       Jorge Valiente    NC4298: Se creara un nuevo cursor el cual permitira establecer
                                              cuantas ordenes bloqueadas tiene la solicitud.
                                              Esto con el fin de permitirile al funcionario
                                              anular la orden para el proceso de visualizacion
                                              del codicional CNCRM
    12/Abril/2016     Jorge Valiente    SS100-9883: Se creara un nuevo cursor cuOtExito identificar
                                                  las ordenes de la solciitud y fueron legalizadas con
                                                  causal de EXITO.
                                                  Si hay minumo una orden con causal de EXITO esta
                                                  retornara el valor de -1.
                                                  para indicar que esta solcitud NO sera puede ser anulada.
                                                  En caso contrario retornara el codigo de la solcuitud para
                                                  identificar en la regla de visualizcion que la
                                                  solicitud puede ser ANULADA.
                                                  Se modificar la logica del cursor cuPackages para que solo
                                                  identitque las OT ejecutadas.
    ******************************************************************/

    function fnuGetPackagesVR(inuPackagesId in mo_packages.package_id%type)
    return number is

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuGetPackagesVR';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);  
    
        cursor cuOrdenBloqueada(inuPackageId mo_packages.package_id%type,
                                sbTaskTypeId varchar2) is
          select count(*)
            from or_order_activity, or_order
           where or_order_activity.package_id = inuPackageId
             and or_order_activity.order_id = or_order.order_id
             and instr(sbTaskTypeId, to_char(or_order.task_type_id)) > 0
             and or_order.order_status_id in
                 (pkg_BCLD_Parameter.fnuObtieneValorNumerico('COD_ESTA_BLOQ'));

        cursor cuPackages(inuPackageId mo_packages.package_id%type,
                          sbTaskTypeId varchar2) is
          select count(*)
            from or_order_activity, or_order
           where or_order_activity.package_id = inuPackageId
             and or_order_activity.order_id = or_order.order_id
             and instr(sbTaskTypeId, to_char(or_order.task_type_id)) > 0
             and or_order.order_status_id in
                 (pkg_BCLD_Parameter.fnuObtieneValorNumerico('COD_ESTA_EJEC')
                  );

        --Cursor para identificar al menos uan ot legalizada con el identificador
        --de causal de EXITO
        cursor cuOtCausalExito(inuPackageId mo_packages.package_id%type,
                               sbTaskTypeId varchar2) is
          select count(*)
            from or_order_activity, or_order
           where or_order_activity.package_id = inuPackageId
             and or_order_activity.order_id = or_order.order_id
             and instr(sbTaskTypeId, to_char(or_order.task_type_id)) > 0
             and or_order.order_status_id in
                 (pkg_BCLD_Parameter.fnuObtieneValorNumerico('ESTADO_CERRADO'))
             and pkg_BCOrdenes.fnuObtieneClaseCausal(or_order.causal_id) =
                 pkg_BCLD_Parameter.fnuObtieneValorNumerico('COD_IDE_CLA_CAU_EXITO')
          ;

        sbPackagesType varchar2(2000);
        sbTaskTypeId   varchar2(2000);
        nuCount        number := 0;

    begin
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
        
        sbPackagesType := pkg_BCLD_Parameter.fsbObtieneValorCadena('ID_PKG_VALIDA_VENTA');
        if instr(sbPackagesType,
             to_char(pkg_BCSolicitudes.fnuGetTipoSolicitud(inuPackagesId))) > 0 then
            sbTaskTypeId := pkg_BCLD_Parameter.fsbObtieneValorCadena('ID_TT_VALIDA_VENTA');

            pkg_Traza.Trace('Solicitud [' || inuPackagesId ||
                         '] - Tipo de Trabajo [' || sbTaskTypeId || ']',
                         10);

            pkg_Traza.Trace('inicio cuOrdenBloqueada', 10);
            open cuOrdenBloqueada(inuPackagesId, sbTaskTypeId);
            fetch cuOrdenBloqueada into nuCount;
            close cuOrdenBloqueada;
            if nuCount > 0 then
                pkg_Traza.Trace('Retornar --> ' || inuPackagesId, 10);
                return inuPackagesId;
            end if;
            pkg_Traza.Trace('fin cuOrdenBloqueada', 10);

            open cuOtCausalExito(inuPackagesId, sbTaskTypeId);
            fetch cuOtCausalExito into nuCount;
            close cuOtCausalExito;
            if nuCount > 0 then
                return - 1;
            end if;

            open cuPackages(inuPackagesId, sbTaskTypeId);
            fetch cuPackages into nuCount;
            close cuPackages;
            if nuCount > 0 then
                return - 1;
            end if;

            return inuPackagesId;

        else
            return inuPackagesId;
        end if;

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
  end fnuGetPackagesVR;

/*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : pro_grabalog_comision
    Descripcion    : Procedimiento que graba el Log de los Jobs
    Autor          : F.Castro
    Fecha          : 07/02/2016

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================

******************************************************************/
    procedure pro_grabalog_comision (inusesion number, idtfecha date, inuhilo number,
                                     inuresult number, isbobse varchar2) is
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'pro_grabalog_comision';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);                                      
        PRAGMA AUTONOMOUS_TRANSACTION;
    begin

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        insert into ldc_log_salescomission
        (sesion, usuario, fecha_inicio, fecha_final, hilo, resultado, observacion)
        values (inusesion, user, idtfecha, sysdate, inuhilo, inuresult, isbobse);
        commit;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;      
    end pro_grabalog_comision;

    PROCEDURE ProcessGOPCV IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'ProcessGOPCV';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);  
    
        sbNEXT_ATTEMP_DATE ge_boInstanceControl.stysbValue;
        sbFechaActual      DATE := SYSDATE;
        nuProgramacion        GE_PROCESS_SCHEDULE.PROCESS_SCHEDULE_ID%TYPE;
        rcProgramacion        DAGE_PROCESS_SCHEDULE.STYGE_PROCESS_SCHEDULE;
        sbParametros          GE_PROCESS_SCHEDULE.PARAMETERS_%TYPE;
        sbUser                varchar2(100);
        sbPassword            varchar2(1000);
        sbConenCrip           VARCHAR2(500);
        sbInstance            varchar2(4000);
        
        nuIdProgramacion    ge_process_schedule.process_schedule_id%TYPE;
        dtFechaInicio       ge_process_schedule.start_date_%TYPE;
        sbEstado            ge_process_schedule.status%TYPE;

        sbFechaInicio       VARCHAR2(20);    
        sbDescEstado        VARCHAR2(20);
        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        IF NOT LDC_BCSALESCOMMISSION_NEL.fblDemonioActivo THEN
            pkg_error.setErrorMessage( isbMsgErrr => 'El demonio no se encuentra activo. Por favor contacte a TI');
        END IF;
        
        LDC_BCSALESCOMMISSION_NEL.pProgramacion
        ( 
            nuIdProgramacion   ,
            dtFechaInicio      ,
            sbEstado           
        );
    
        IF nuIdProgramacion IS NOT NULL THEN

            sbFechaInicio := TO_CHAR( dtFechaInicio, 'dd/mm/yyyy hh24:mi:ss' );
            
            sbDescEstado  := CASE sbEstado WHEN 'P' THEN 'Programado' WHEN 'X' THEN 'En ejecución' END;
                    
            pkg_error.setErrorMessage( isbMsgErrr => 'Existe la programación [' ||  nuIdProgramacion || '] con fecha de Inicio [' || dtFechaInicio || ']  en estado [' || sbDescEstado || ']');
                   
        END IF;    

        sbNEXT_ATTEMP_DATE := ge_boInstanceControl.fsbGetFieldValue('SM_INTERFACE',
                                                                    'NEXT_ATTEMP_DATE');
        ------------------------------------------------
        -- Required Attributes
        ------------------------------------------------
        if (sbNEXT_ATTEMP_DATE is null) then
          pkg_error.setErrorMessage( isbMsgErrr => 'El atributo [FECHA DE EJECUCION] no puede ser nulo');
        end if;

        -- Caso 434 Se agrega cadena de conexion

        nuProgramacion := GE_BOSCHEDULE.FNUGETSCHEDULEINMEMORY;
        rcProgramacion := DAGE_PROCESS_SCHEDULE.FRCGETRECORD(nuProgramacion);
        sbParametros := rcProgramacion.PARAMETERS_;

        GE_BODATABASECONNECTION.GETCONNECTIONSTRING(sbUser, sbPassword, sbInstance);
        sbConenCrip := sbUser || '/' || sbPassword || '@' || sbInstance;

        sbConenCrip := fa_uiprocesosfact.fsbencriptacadena(sbConenCrip);

        sbParametros := sbParametros||'CON='||sbConenCrip||'|';

        rcProgramacion.PARAMETERS_ := sbParametros;
        DAGE_PROCESS_SCHEDULE.UPDRECORD(rcProgramacion);

        commit;

        ------------------------------------------------
        -- User code
        ------------------------------------------------

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END ProcessGOPCV;

    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Unidad         : fblDemonioActivo
    Descripcion    : Indica si el demonio de SmartFlex esta activo
    Autor          : jpinedc - MVM
    Fecha          : 26/01/2023

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha           Autor             Modificacion
    =========       =========         ====================
    26/01/2023      jpinedc           OSF-839 - Creacion  
    ******************************************************************/  
    function fblDemonioActivo
    return BOOLEAN
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fblDemonioActivo';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        blDemonioActivo  BOOLEAN := FALSE;
        
        CURSOR cuDemonioActivo
        IS
        SELECT count(1) TOTDEMO 
        FROM gv$session 
        WHERE module like 'demonio%';
        
        rcDemonioActivo cuDemonioActivo%ROWTYPE;
        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
        
        OPEN cuDemonioActivo;
        FETCH cuDemonioActivo INTO rcDemonioActivo;
        CLOSE cuDemonioActivo;
        
        blDemonioActivo := NVL(rcDemonioActivo.TOTDEMO,0) > 0;
                
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        
        RETURN blDemonioActivo;
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;    
    END fblDemonioActivo;
    
    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Unidad         : pProgramacion
    Descripcion    : Indica si el job de GOPCVNEL esta programado
    Autor          : jpinedc - MVM
    Fecha          : 13/02/2023

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha           Autor             Modificacion
    =========       =========         ====================
    26/01/2023      jpinedc           OSF-804 - Creación  
    ******************************************************************/     
    procedure pProgramacion
    (
        onuIdProgramacion   OUT ge_process_schedule.process_schedule_id%TYPE,
        odtFechaInicio      OUT ge_process_schedule.start_date_%TYPE,
        osbEstado           OUT ge_process_schedule.status%TYPE
    )
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'pProgramacion';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);  
        
        sbProceso   VARCHAR2(30) := 'GOPCVNEL';
    
        CURSOR cuProgramacion
        IS
        SELECT *
        FROM ge_process_schedule
        WHERE executable_id in
        (
            select executable_id
            from sa_executable
            where name = sbProceso
        ) and
        status IN ( 'P' );
        
        rcProgramacion  cuProgramacion%ROWTYPE;
        
        CURSOR cuEstaprogEjec( idtFechaIni DATE)
        IS
        SELECT *
        FROM estaprog
        WHERE esprprog LIKE sbProceso || '%'
        AND esprfein >= idtFechaIni
        AND esprporc < 100;
        
        TYPE tytbEstaprogEjec IS TABLE OF cuEstaprogEjec%ROWTYPE INDEX BY BINARY_INTEGER;
        
        tbEstaprogEjec tytbEstaprogEjec;
        
        CURSOR cuEstaprogFin( idtFechaIni DATE)
        IS
        SELECT *
        FROM estaprog
        WHERE esprprog LIKE sbProceso || '%'
        AND esprfein >= idtFechaIni
        AND esprporc >= 100;
        
        TYPE tytbEstaprogFin IS TABLE OF cuEstaprogFin%ROWTYPE INDEX BY BINARY_INTEGER;
        
        tbEstaprogFin tytbEstaprogFin;                     
                
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
        
        OPEN cuProgramacion;
        FETCH cuProgramacion INTO rcProgramacion;
        CLOSE cuProgramacion;
        
        IF rcProgramacion.process_schedule_id IS NOT NULL THEN
        
            onuIdProgramacion   := rcProgramacion.process_schedule_id;
            odtFechaInicio      := rcProgramacion.start_date_; 
                
            IF rcProgramacion.start_date_ < sysdate THEN
                osbEstado := 'P';
            ELSE
                
                
            
                IF rcProgramacion.Job > 0 THEN
                
                    pkg_Traza.Trace('rcProgramacion.Job|'|| rcProgramacion.Job, 1);
                
                    OPEN cuEstaprogEjec( rcProgramacion.start_date_ );
                    FETCH cuEstaprogEjec BULK COLLECT INTO tbEstaprogEjec LIMIT 50;
                    CLOSE cuEstaprogEjec;
                    
                    pkg_Traza.Trace('tbEstaprogEjec.Count|'|| tbEstaprogEjec.Count, 1);                    
                    
                    IF tbEstaprogEjec.Count > 0 THEN
                        osbEstado := 'X';
                    ELSE
                            
                        OPEN cuEstaprogFin( rcProgramacion.start_date_ );
                        FETCH cuEstaprogFin BULK COLLECT INTO tbEstaprogFin LIMIT 50;
                        CLOSE cuEstaprogFin;
                        
                        pkg_Traza.Trace('tbEstaprogFin.Count|'|| tbEstaprogFin.Count, 1);                             
                        
                        IF tbEstaprogFin.Count > 0 THEN
                        
                            IF  tbEstaprogFin.Count = 10 THEN
                            
                                onuIdProgramacion   := NULL;
                                odtFechaInicio      := NULL;
                                osbEstado           := NULL; 
                                        
                            ELSE
                                osbEstado           := 'X';                             
                            END IF;
                            
                        ELSE
                        
                            osbEstado := 'P';
                                                    
                        END IF;                      
                    
                    END IF;                    
                                                            
                ELSE
                
                    osbEstado := 'P';
                                        
                END IF;
                                
            END IF;
        
        END IF;
                    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;        
            
    END pProgramacion;       

---------------------------------

    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Unidad         : pCargaParametros
    Descripcion    : Carga parámetros para la ejecución de GOPCVNEL
    Autor          : jpinedc - MVM
    Fecha          : 05/08/2024

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha           Autor             Modificacion
    =========       =========         ====================
    05/08/2024      jpinedc           OSF-2973 - Creación  
    ******************************************************************/  
    
    PROCEDURE pCargaParametros
    IS
        csbMetodo       CONSTANT VARCHAR2(70) := csbSP_NAME ||  'pCargaParametros';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        IF NOT gblpCargaParametros THEN

            gnuLDC_NUM_HILOS_GOPCVNEL := pkg_BCLD_Parameter.fnuObtieneValorNumerico('LDC_NUM_HILOS_GOPCVNEL');
            pkg_Traza.trace('Parametro LDC_NUM_HILOS_GOPCVNEL ['||gnuLDC_NUM_HILOS_GOPCVNEL||']', csbNivelTraza );
            if (gnuLDC_NUM_HILOS_GOPCVNEL IS NULL OR gnuLDC_NUM_HILOS_GOPCVNEL < 1 ) then
                pkg_error.setErrorMessage( isbMsgErrr => 'El parametro LDC_NUM_HILOS_GOPCVNEL tiene valor nulo o menor a 1');
            END if;

            gblpCargaParametros := TRUE;

        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            RAISE pkg_Error.Controlled_Error;
    END pCargaParametros;


    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Unidad         : pCargTabProgCadJobsGOPCVNEL
    Descripcion    : Carga tabla de programas para la ejecución de GOPCVNEL
    Autor          : jpinedc - MVM
    Fecha          : 05/08/2024

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha           Autor             Modificacion
    =========       =========         ====================
    05/08/2024      jpinedc           OSF-2973 - Creación  
    ******************************************************************/  
    PROCEDURE pCargTabProgCadJobsGOPCVNEL IS

        csbMetodo       CONSTANT VARCHAR2(70) := csbSP_NAME ||  'pCargTabProgCadJobsGOPCVNEL';

        nuError         NUMBER;
        sbError         VARCHAR2(4000);

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        tbSchedChainProg.DELETE;

        RCPROGRAMA.PROGRAM_NAME     := 'INI_' || gsbProgram;
        RCPROGRAMA.PACKAGE          := UPPER('LDC_BCSALESCOMMISSION_NEL');
        RCPROGRAMA.API              := UPPER('pIniCadenaJobsGOPCVNEL');
        RCPROGRAMA.PROGRAM_TYPE     := 'STORED_PROCEDURE';
        RCPROGRAMA.STEP             := 'INI_' || gsbProgram;
        RCPROGRAMA.BLOQUEPL         := NULL;
        RCPROGRAMA.PROGRAM_ACTION   := pkg_Scheduler.fsbAction ( RCPROGRAMA.PACKAGE , RCPROGRAMA.API  , RCPROGRAMA.PROGRAM_TYPE, RCPROGRAMA.BLOQUEPL );

        tbSchedChainProg(tbSchedChainProg.COUNT+1)  :=  RCPROGRAMA;

        FOR IND IN 1..gnuLDC_NUM_HILOS_GOPCVNEL LOOP

            RCPROGRAMA.PROGRAM_NAME := 'GOPCVNEL_'|| IND;
            RCPROGRAMA.PACKAGE      := UPPER('LDC_BCSALESCOMMISSION_NEL');
            RCPROGRAMA.API          := UPPER('prGenerateCommission2');
            RCPROGRAMA.PROGRAM_TYPE := 'STORED_PROCEDURE';
            RCPROGRAMA.BLOQUEPL     := NULL;
            RCPROGRAMA.STEP         := 'GOPCVNEL_'|| IND;
            RCPROGRAMA.PROGRAM_ACTION   := pkg_Scheduler.fsbAction ( RCPROGRAMA.PACKAGE , RCPROGRAMA.API  , RCPROGRAMA.PROGRAM_TYPE, RCPROGRAMA.BLOQUEPL );

            tbSchedChainProg(tbSchedChainProg.COUNT+1)  :=  RCPROGRAMA;

        END LOOP;


        RCPROGRAMA.PROGRAM_NAME     := 'FIN_' || gsbProgram;
        RCPROGRAMA.PACKAGE          := UPPER('LDC_BCSALESCOMMISSION_NEL');
        RCPROGRAMA.API              := UPPER('pFinCadenaJobsGOPCVNEL');
        RCPROGRAMA.PROGRAM_TYPE     := 'STORED_PROCEDURE';
        RCPROGRAMA.STEP             := 'FIN_' || gsbProgram;
        RCPROGRAMA.BLOQUEPL         := NULL;

        RCPROGRAMA.PROGRAM_ACTION   := pkg_Scheduler.fsbAction ( RCPROGRAMA.PACKAGE , RCPROGRAMA.API  , RCPROGRAMA.PROGRAM_TYPE, RCPROGRAMA.BLOQUEPL );

        tbSchedChainProg(tbSchedChainProg.COUNT+1)  :=  RCPROGRAMA;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;
    END pCargTabProgCadJobsGOPCVNEL;

    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Unidad         : pCreaReglasCadenaJobsGOPCVNEL
    Descripcion    : Crea las reglas para la ejecución de GOPCVNEL
                    por medio de una cadenade Jobs
                                        
    Autor          : jpinedc - MVM
    Fecha          : 05/08/2024

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha           Autor             Modificacion
    =========       =========         ====================
    05/08/2024      jpinedc           OSF-2973 - Creación  
    ******************************************************************/  
	PROCEDURE pCreaReglasCadenaJobsGOPCVNEL
	IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME ||  'pCreaReglasCadenaJobsGOPCVNEL';

		sbCondicion     VARCHAR2(4000);
		sbAccion        VARCHAR2(4000);

		nuError         NUMBER;
		sbError         VARCHAR2(4000);

	BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

		sbCondicion := 'FALSE';
		sbAccion   := 'start INI_' || gsbProgram;

		pkg_scheduler.define_chain_rule
		(
		   gsbChainJobsGOPCVNEL,
		   sbCondicion,
		   sbAccion
		);

		sbCondicion := REPLACE(sbAccion,'start ','');
		sbCondicion := REPLACE(sbCondicion,',',' succeeded and ');
		sbCondicion := sbCondicion || ' succeeded';

		sbAccion    := 'start ';

		FOR IND0 IN 1..gnuLDC_NUM_HILOS_GOPCVNEL LOOP

			sbAccion   := sbAccion || gsbProgram || '_' || IND0 ;

			IF IND0 < gnuLDC_NUM_HILOS_GOPCVNEL THEN
				sbAccion := sbAccion ||  ',';
			END IF;

		END LOOP;

		pkg_scheduler.define_chain_rule
		(
		   gsbChainJobsGOPCVNEL,
		   sbCondicion,
		   sbAccion
		);

		sbCondicion := REPLACE(sbAccion,'start ','');
		sbCondicion := REPLACE(sbCondicion,',',' succeeded and ');
		sbCondicion := sbCondicion || ' succeeded';

		sbAccion := 'start FIN_' || gsbProgram;

		pkg_scheduler.define_chain_rule
		(
		   gsbChainJobsGOPCVNEL,
		   sbCondicion,
		   sbACCION
		);

		sbCondicion := REPLACE(sbAccion,'start ','');
		sbCondicion := REPLACE(sbCondicion,',',' succeeded and ');
		sbCondicion := sbCondicion || ' succeeded';

		sbAccion := 'END';

		-- termina la cadena
		pkg_scheduler.define_chain_rule
		(
		   gsbChainJobsGOPCVNEL,
		   sbCondicion,
		   sbAccion
		);

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;
	END pCreaReglasCadenaJobsGOPCVNEL;

    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Unidad         : pCreaReglasCadenaJobsGOPCVNEL
    Descripcion    : Crea la cadenada de Jobs para la ejecución de GOPCVNEL
                    
                                        
    Autor          : jpinedc - MVM
    Fecha          : 05/08/2024

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha           Autor             Modificacion
    =========       =========         ====================
    05/08/2024      jpinedc           OSF-2973 - Creación  
    ******************************************************************/ 
    PROCEDURE pCreaCadenaJobsGOPCVNEL
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME ||  'pCreaCadenaJobsGOPCVNEL';

        nuError NUMBER;
        sbError VARCHAR2(4000);

        tbArgumentos  pkg_scheduler.tytbArgumentos;

        tbProgramas   pkg_scheduler.tytbProgramas;
        
        blCadenaCreada  BOOLEAN := FALSE;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        pCargTabProgCadJobsGOPCVNEL;

        IF pkg_scheduler.FBLSCHEDCHAINEXISTS( gsbChainJobsGOPCVNEL ) THEN
            pkg_Traza.trace('Ya existe la cadena ' || gsbChainJobsGOPCVNEL, csbNivelTraza );

            tbProgramas := pkg_scheduler.ftbProgramas( gsbProgram );

            IF
            (
                NVL(tbProgramas.Count,0) <> ( gnuLDC_NUM_HILOS_GOPCVNEL + 2)
                OR
                pkg_scheduler.fblUltEjecCadJobConError(  gsbChainJobsGOPCVNEL )
            )
            THEN

                pkg_scheduler.pDropSchedChain( gsbChainJobsGOPCVNEL );

                pkg_scheduler.create_chain( gsbChainJobsGOPCVNEL );
                
                blCadenaCreada := TRUE;

            END IF;

        ELSE
            pkg_scheduler.create_chain( gsbChainJobsGOPCVNEL );
            
            blCadenaCreada := TRUE;
                            
        END IF;

        IF blCadenaCreada THEN
        
            FOR indtbPr IN 1..tbSchedChainProg.COUNT LOOP

                pkg_Traza.trace('paso|'|| tbSchedChainProg(indtbPr).step, csbNivelTraza );
                pkg_Traza.trace('programa|' || tbSchedChainProg(indtbPr).package || '.' || tbSchedChainProg(indtbPr).api,csbNivelTraza);

                tbArgumentos := pkg_Scheduler.ftbArgumentos( 'ADM_PERSON',tbSchedChainProg(indtbPr).package, tbSchedChainProg(indtbPr).api );

                pkg_Traza.trace('tbArgumentos.count|' || tbArgumentos.count,csbNivelTraza);

                pkg_scheduler.PCREASCHEDCHAINSTEP
                (
                    gsbChainJobsGOPCVNEL,
                    tbSchedChainProg(indtbPr).step,
                    tbSchedChainProg(indtbPr).program_name,
                    tbSchedChainProg(indtbPr).program_type,
                    tbSchedChainProg(indtbPr).program_action,
                    tbArgumentos.count,
                    TRUE,
                    gsbChainJobsGOPCVNEL,
                    nuError,
                    sbError
                );

                pkg_Traza.trace('Res pkg_scheduler.PCREASCHEDCHAINSTEP|' || sbError);

                IF nuError = 0 THEN
                    NULL;
                ELSE
                    Pkg_Error.SetErrorMessage(  isbMsgErrr => 'pCreaSchedChainStep|' || sbError );
                END IF;

            END LOOP;

            pCreaReglasCadenaJobsGOPCVNEL;

        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;
    END pCreaCadenaJobsGOPCVNEL;

    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Unidad         : pDefValArgsCadenaJobsGOPCVNEL
    Descripcion    : Define los valores de los argumentos de los programas
                     usados en la cadena de Jobs para la ejecución de GOPCVNEL
                    
                                        
    Autor          : jpinedc - MVM
    Fecha          : 05/08/2024

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha           Autor             Modificacion
    =========       =========         ====================
    05/08/2024      jpinedc           OSF-2973 - Creación  
    ******************************************************************/ 
    PROCEDURE pDefValArgsCadenaJobsGOPCVNEL
    (
        isbProcessProg  VARCHAR2, 
        inuTotalThreads NUMBER,
        idtfecha        DATE, 
        inuProgramacion NUMBER,
        inuCantIni      NUMBER              
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'pDefValArgsCadenaJobsGOPCVNEL';
        tbArgumentos              pkg_Scheduler.tytbArgumentos;
        sbIndArg            VARCHAR2(100);
        sbStep              VARCHAR2(100);
        nuError             NUMBER;
        sbError             VARCHAR2(4000);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        tbArgumentos := pkg_Scheduler.ftbArgumentos( 'ADM_PERSON','LDC_BCSALESCOMMISSION_NEL', UPPER('prGenerateCommission2'));
                             
        tbArgumentos('ISBPROCESSNAME').VALUE := isbProcessProg;
        tbArgumentos('ISBTCORTE').VALUE := TO_CHAR(idtfecha,'DD/MM/YYYY HH24:MI:SS') ;
        tbArgumentos('INUTOTALTHREADS').VALUE := inuTotalThreads;

        FOR nuHilo in 1..inuTotalThreads LOOP

            tbArgumentos('INUCURRENTTHREAD').VALUE := nuHilo;

            sbStep := 'GOPCVNEL_' || nuHilo;

            pkg_Traza.trace('sbStep|' ||sbStep,csbNivelTraza);

            sbIndArg := tbArgumentos.First;

            LOOP

                EXIT WHEN sbIndArg IS NULL;

                pkg_Traza.trace('sbIndArg|' ||sbIndArg,csbNivelTraza);

                pkg_Traza.trace('tbArgumentos(sbIndArg).position|' ||tbArgumentos(sbIndArg).position,csbNivelTraza);
                pkg_Traza.trace('tbArgumentos(sbIndArg).argument_name|' ||tbArgumentos(sbIndArg).argument_name,csbNivelTraza);
                pkg_Traza.trace('tbArgumentos(sbIndArg).data_type|' ||tbArgumentos(sbIndArg).data_type,csbNivelTraza);
                pkg_Traza.trace('tbArgumentos(sbIndArg).value|' ||tbArgumentos(sbIndArg).value,csbNivelTraza);

                pkg_scheduler.define_program_argument
                (
                    sbStep,
                    tbArgumentos(sbIndArg).position,
                    tbArgumentos(sbIndArg).argument_name,
                    tbArgumentos(sbIndArg).data_type,
                    TRIM(tbArgumentos(sbIndArg).value),
                    nuError,
                    sbError
                );

                IF nuError <> 0 THEN
                    pkg_error.SetErrorMessage( NULL, 'Error Creando el argumento ' || sbStep || '.' || tbArgumentos(sbIndArg).argument_name || '|' || sbError );
                ELSE
                    pkg_Traza.trace( 'OK Creacion el argumento ' || sbStep || '.' || tbArgumentos(sbIndArg).argument_name, csbNivelTraza );
                END IF;

                sbIndArg := tbArgumentos.Next(sbIndArg );

            END LOOP;

            pkg_scheduler.enable
            (
                sbStep,
                nuError,
                sbError
            );

            IF nuError <> 0 THEN
                pkg_error.SetErrorMessage( NULL, 'Error habilitando el programa|' || sbStep || sbError );
            ELSE
                pkg_Traza.trace( 'OK habilitando el programa|' || sbStep, csbNivelTraza );
            END IF;

        END LOOP;

        tbArgumentos.delete;

        tbArgumentos := pkg_Scheduler.ftbArgumentos( 'ADM_PERSON','LDC_BCSALESCOMMISSION_NEL', UPPER('pFinCadenaJobsGOPCVNEL'));

        tbArgumentos('INUPROGRAMACION').VALUE := inuProgramacion;
        tbArgumentos('INUCANTINI').VALUE := inuCantIni;

        sbStep := 'FIN_GOPCVNEL';

        pkg_Traza.trace('sbStep|' ||sbStep,csbNivelTraza);

        sbIndArg := tbArgumentos.First;

        LOOP

            EXIT WHEN sbIndArg IS NULL;

            pkg_Traza.trace('sbIndArg|' ||sbIndArg,csbNivelTraza);

            pkg_Traza.trace('tbArgumentos(sbIndArg).position|' ||tbArgumentos(sbIndArg).position,csbNivelTraza);
            pkg_Traza.trace('tbArgumentos(sbIndArg).argument_name|' ||tbArgumentos(sbIndArg).argument_name,csbNivelTraza);
            pkg_Traza.trace('tbArgumentos(sbIndArg).data_type|' ||tbArgumentos(sbIndArg).data_type,csbNivelTraza);
            pkg_Traza.trace('tbArgumentos(sbIndArg).value|' ||tbArgumentos(sbIndArg).value,csbNivelTraza);

            tbArgumentos(sbIndArg).value :=  tbArgumentos(sbIndArg).value;

            pkg_scheduler.define_program_argument
            (
                sbStep,
                tbArgumentos(sbIndArg).position,
                tbArgumentos(sbIndArg).argument_name,
                tbArgumentos(sbIndArg).data_type,
                tbArgumentos(sbIndArg).value,
                nuError,
                sbError
            );

            IF nuError <> 0 THEN
                pkg_error.SetErrorMessage( NULL, 'Error Creando el argumento ' || sbStep || '.' || tbArgumentos(sbIndArg).argument_name || '|' || sbError );

            ELSE
                pkg_Traza.trace( 'OK Creando el argumento ' || sbStep || '.' || tbArgumentos(sbIndArg).argument_name , csbNivelTraza);
            END IF;

            sbIndArg := tbArgumentos.Next(sbIndArg );

        END LOOP;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;
    END pDefValArgsCadenaJobsGOPCVNEL;

    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Unidad         : pActivaCadenaJobsGOPCVNEL
    Descripcion    : Activa la cadena de Jobs para la ejecución de GOPCVNEL
                    
                                        
    Autor          : jpinedc - MVM
    Fecha          : 05/08/2024

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha           Autor             Modificacion
    =========       =========         ====================
    05/08/2024      jpinedc           OSF-2973 - Creación  
    ******************************************************************/ 
    PROCEDURE pActivaCadenaJobsGOPCVNEL
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'pActivaCadenaJobsGOPCVNEL';
        sbStep              VARCHAR2(100);
        nuError             NUMBER;
        sbError             VARCHAR2(4000);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        sbStep := 'FIN_GOPCVNEL';

        pkg_scheduler.enable
        (
            sbStep,
            nuError,
            sbError
        );

        IF nuError <> 0 THEN
            pkg_error.SetErrorMessage( NULL, 'Error Habilitando el paso ' || sbStep );
        ELSE
            pkg_Traza.trace( 'OK Habilitando el paso ' || sbStep, csbNivelTraza );
        END IF;

        sbStep := 'INI_GOPCVNEL';

        pkg_scheduler.enable
        (
            sbStep,
            nuError,
            sbError
        );

        IF nuError <> 0 THEN
            pkg_error.SetErrorMessage( NULL, 'Error Habilitando el paso ' || sbStep );
        ELSE
            pkg_Traza.trace( 'OK Habilitando el paso ' || sbStep, csbNivelTraza );
        END IF;

        pkg_scheduler.enable
        (
            gsbChainJobsGOPCVNEL,
            nuError,
            sbError
        );

        IF nuError <> 0 THEN
            pkg_error.SetErrorMessage( NULL, 'Error Habilitando la cadena ' || gsbChainJobsGOPCVNEL );
        ELSE
            pkg_Traza.trace( 'OK Habilitando la cadena ' || gsbChainJobsGOPCVNEL, csbNivelTraza );
        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;
    END pActivaCadenaJobsGOPCVNEL;

    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Unidad         : pProcCadJobsGOPCVNEL
    Descripcion    : Ejecuta GOPCVNEL por medio de una cadena de Jobs
                    
                                        
    Autor          : jpinedc - MVM
    Fecha          : 05/08/2024

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha           Autor             Modificacion
    =========       =========         ====================
    05/08/2024      jpinedc           OSF-2973 - Creación  
    ******************************************************************/ 
    PROCEDURE pProcCadJobsGOPCVNEL
    ( 
        isbProcessProg  VARCHAR2, 
        inuTotalThreads NUMBER,
        idtfecha        DATE, 
        inuProgramacion NUMBER,
        inuCantIni      NUMBER                 
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'pProcCadJobsGOPCVNEL';

        nuError             NUMBER;
        sbError             VARCHAR2(4000);

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        pCargaParametros;

        IF pkg_scheduler.fblSchedChainRunning( gsbChainJobsGOPCVNEL ) THEN
            pkg_error.SetErrorMessage( NULL, 'La cadena de Jobs ' || gsbChainJobsGOPCVNEL || ' está corriendo' );
        ELSE

            pCreaCadenaJobsGOPCVNEL;

            pDefValArgsCadenaJobsGOPCVNEL
            (
                isbProcessProg  , 
                inuTotalThreads ,
                idtfecha        , 
                inuProgramacion ,
                inuCantIni                    
            );

            pActivaCadenaJobsGOPCVNEL;

            pkg_scheduler.run_chain(gsbChainJobsGOPCVNEL , 'INI_GOPCVNEL', 'JOB_' || gsbChainJobsGOPCVNEL );

        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;
    END pProcCadJobsGOPCVNEL;
    
    
    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Unidad         : pIniCadenaJobsGOPCVNEL
    Descripcion    : Programa Inicial de la cadena de Jobs de GOPCVNEL
                    
                                        
    Autor          : jpinedc - MVM
    Fecha          : 05/08/2024

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha           Autor             Modificacion
    =========       =========         ====================
    05/08/2024      jpinedc           OSF-2973 - Creación  
    ******************************************************************/     
    PROCEDURE pIniCadenaJobsGOPCVNEL
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'pIniCadenaJobsGOPCVNEL';
        nuError             NUMBER;
        sbError             VARCHAR2(4000);
       
                    
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
                
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;        
    END pIniCadenaJobsGOPCVNEL;       
    
    
    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Unidad         : pFinCadenaJobsGOPCVNEL
    Descripcion    : Programa final de la cadena de Jobs de GOPCVNEL
                    
                                        
    Autor          : jpinedc - MVM
    Fecha          : 05/08/2024

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha           Autor             Modificacion
    =========       =========         ====================
    05/08/2024      jpinedc           OSF-2973 - Creación  
    ******************************************************************/     
    PROCEDURE pFinCadenaJobsGOPCVNEL( inuProgramacion NUMBER, inuCantIni NUMBER)
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'pFinCadenaJobsGOPCVNEL';
        nuError             NUMBER;
        sbError             VARCHAR2(4000); 
            
        nuCantEnd NUMBER;
        sbEmail             ge_person.e_mail%TYPE;
        sbSubject           VARCHAR2 (100) := 'Resultado proceso GOPCVNEL';
        sbMessageEm         VARCHAR2 (2000)
            := 'Durante la ejecucion del proceso GOPCVNEL, hubo solicitudes que quedaron excluidas. Por favor validar.';      
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
            
        -- CA854: Se valida si se crearon nuevos registros en la tabla de excepciones
        OPEN cuCantExcep;
        FETCH cuCantExcep INTO nuCantEnd;
        CLOSE cuCantExcep;

        -- Si es diferente se envia correo al usuario
        IF nuCantEnd > inuCantIni
        THEN
            OPEN cuEmail (dage_process_schedule.fsbgetlog_user (inuProgramacion, 0));
            FETCH cuEmail INTO sbEmail;
            CLOSE cuEmail;

            IF sbEmail IS NOT NULL
            THEN
                pkg_Correo.prcEnviaCorreo
                (
                    isbDestinatarios    =>  sbEmail,
                    isbAsunto           =>  sbSubject,
                    isbMensaje          =>  sbMessageEm
                );
            END IF;
        END IF;

        LDC_prorevercomisionventasanul; 

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;                   
    END pFinCadenaJobsGOPCVNEL;   

    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Unidad         : PrGenerateCommission2
    Descripcion    : Programa que ejecuta un hilo de la cadena de Jobs
                    de GOPCVNEL manejando la fecha isbtCorte como una
                    cadena para evitar problemas en la conversion
                                        
    Autor          : jpinedc - MVM
    Fecha          : 05/08/2024

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha           Autor             Modificacion
    =========       =========         ====================
    05/08/2024      jpinedc           OSF-2973 - Creación  
    ******************************************************************/ 
    procedure PrGenerateCommission2(isbProcessName IN estaprog.esprprog%type,
                                 isbtCorte IN VARCHAR2,
                                 inuCurrentThread IN NUMBER,
                                 inuTotalThreads IN NUMBER)
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'PrGenerateCommission2';
        nuError             NUMBER;
        sbError             VARCHAR2(4000); 
            
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);    
        PrGenerateCommission(isbProcessName,
                                 TO_DATE(isbtCorte,'DD/MM/YYYY HH24:MI:SS'),
                                 inuCurrentThread ,
                                 inuTotalThreads);
                                 
                                 
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;    
    END PrGenerateCommission2;
      
end LDC_BCSALESCOMMISSION_NEL;
/

PROMPT Otorgando permisos de ejecucion a LDC_BCSALESCOMMISSION_NEL
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_BCSALESCOMMISSION_NEL', 'ADM_PERSON');
END;
/

PROMPT Otorgando permisos de ejecucion sobre LDC_BCSALESCOMMISSION_NEL para reportes
GRANT EXECUTE ON adm_person.LDC_BCSALESCOMMISSION_NEL TO rexereportes;
/

