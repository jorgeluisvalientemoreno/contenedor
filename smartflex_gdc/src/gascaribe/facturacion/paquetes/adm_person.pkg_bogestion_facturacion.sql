CREATE OR REPLACE PACKAGE ADM_PERSON.PKG_BOGESTION_FACTURACION IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Paquete     :   PKG_BOGESTION_FACTURACION
    Autor       :   Jhon Jairo Soto
    Fecha       :   06/12/2024
    Descripcion :   Para publicar Servicios con logica de negocio para facturación

    Modificaciones  :
    Autor       Fecha       Caso    	Descripcion
	jsoto		06/12/2024	OSF-3740  	Creacion
	jpinedc     07/02/2025  OSF-3893    Se crean : prDefDatosTrasladoSaldo y
                                        prTrasladaSaldoAfavor
	fvalencia	    11/03/2025 	OSF-3846	Se crear las siguientes funciones y 	
                                      procedimientos:
                                      prcObtienePoliticaAjuste
                                      prcAplicaPoliticaAjuste
                                      prcActualizaCarteraMemoria	
                                      prcActualizaCartera
                                      prcObtieneDatosCuentaCobro
                                      prcGeneraSaldoAFavor
                                      prcAplicaSaldoAFavor
                                      fnuObtieneSaldoPendiente
                                      prcInicializaParametrosMemoria
                                      prcHabilitaManejoCache
	jerazomvm	15/05/2025	OSF-4480	Se crea la función fsbObtGenerarOrdenReparto
  fvalencia     23/05/2025  OSF-4494  Se agrega la función fnuObtieneValorCargo
*******************************************************************************/

    SUBTYPE stytsaldopendientefactura IS pkbcfactura.styfactspfa;
    SUBTYPE stytvalorfacturado IS pkbcfactura.styfactvafa;
    SUBTYPE stytvalorivafacturado IS pkbcfactura.styfactivfa;

    -- Retona Identificador del ultimo caso que hizo cambios
    FUNCTION fsbVersion RETURN VARCHAR2;

	PROCEDURE prcValPoliRedondeoContrato(inuContrato	IN suscripc.susccodi%TYPE,
										 ionuValor		IN OUT cupon.cupovalo%TYPE
										);
    PROCEDURE prcCreaCuentaCobro( inuProducto    IN   servsusc.sesunuse%type,
                                inuContrato   IN   servsusc.sesususc%type,
                                inufactura    IN   factura.factcodi%type,
                                onuCuenta     OUT  cuencobr.cucocodi%type,
                                onuError      OUT  NUMBER,
                                osbError      OUT  VARCHAR2 );
   /**************************************************************************
     Proceso     : prcCreaCuentaCobro
     Autor       : Luis Javier Lopez Barrios / Horbath
     Fecha       : 2022-11-22
     Ticket      : OSF-688
     Descripcion : generar cuenta de cobro

    Parametros Entrada
     inuProducto   codigo del producto
     inuContrato   codigo del contrato
     inufactura    codigo de la factura
    Parametros de salida
     onuCuenta   cuenta de cobro
     onuerror  codigo de error 0 - exito -1 error
     osbError  mensaje de error
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
  PROCEDURE prcCreaFactura( inuContrato      IN   servsusc.sesususc%type,
                            inuPrograma      IN   factura.factprog%type,
                            iblAsignaNumFiscal IN   boolean default true,
                            onuFactura       OUT  factura.factcodi%type,
                            onuError      OUT  NUMBER,
                            osbError      OUT  VARCHAR2 );
   /**************************************************************************
     Proceso     : prcCreaFactura
     Autor       : Luis Javier Lopez Barrios / Horbath
     Fecha       : 2022-11-22
     Ticket      : OSF-688
     Descripcion : generar factura

    Parametros Entrada
     inuContrato   codigo del contrato
     inuPrograma   codigo del programa de la factura
     iblAsignaNumFiscal asigna numero fiscal a la factura
    Parametros de salida
     onuFactura   factura
     onuerror  codigo de error 0 - exito -1 error
     osbError  mensaje de error
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

    -- Genera la factura para la solicitud
    PROCEDURE prcGenerarFacturaPorSolicitud(inuSolicitud NUMBER);
  
    -- Define datos del proceso de traslado de saldo a favor
    PROCEDURE prDefDatosTrasladoSaldo
    (
        idtFechaProceso     IN  DATE DEFAULT SYSDATE,
        isbUsuario          IN  VARCHAR2 DEFAULT USER,
        isbTerminal         IN  VARCHAR2 DEFAULT USERENV('TERMINAL')
    );

    -- Traslada valor de saldo a favor entre productos
    PROCEDURE prTrasladaSaldoAfavor
    (
        inuProductoOrigen   IN  servsusc.sesunuse%TYPE,
        inuContratoOrigen   IN  servsusc.sesususc%TYPE,
        inuValorATrasladar  IN  servsusc.sesusafa%TYPE,   
        inuProductoDestino  IN  servsusc.sesunuse%TYPE,
        isbComentario       IN  VARCHAR2,
        onuError            OUT NUMBER,
        osbError            OUT VARCHAR2
    );

    --Inicializa tabla de memoria de parametros
    PROCEDURE prcInicializaParametrosMemoria;

    -- Habilita manejo de cache para parametros
    PROCEDURE prcHabilitaManejoCache;

    --Obtiene politica de ajuste
    PROCEDURE prcObtienePoliticaAjuste
    (
      inuContrato 	IN suscripc.susccodi%TYPE, 
      oblajuste 		OUT BOOLEAN, 
      onufacajus 		OUT timoempr.tmemfaaj%TYPE
    );

    --Aplica politica de ajuste
    PROCEDURE prcAplicaPoliticaAjuste
    (
      inuProducto 	IN servsusc.sesunuse%TYPE, 
      ionuValorCargo 	IN OUT cargos.cargvalo%TYPE
    );

    --Actualiza cartera en memoria
    PROCEDURE prcActualizaCarteraMemoria
    (
      inuOperacion		IN	NUMBER,
      inuCuentaCobro		IN	cargos.cargcuco%TYPE,
      inuContrato			IN	suscripc.susccodi%TYPE,
      inuPorducto			IN	cargos.cargnuse%TYPE,
      inuConcepto			IN	cargos.cargconc%TYPE,
      inuSigno			IN	cargos.cargsign%TYPE,
      inuValorCargo		IN	cargos.cargvalo%TYPE,
      inuFlagGraba		IN	NUMBER DEFAULT 1
    );

    --Actualiza Cartera
    PROCEDURE prcActualizaCartera;

    --Obtiene información de la cuenta de cobro
    PROCEDURE prcObtieneDatosCuentaCobro
    (
      inuCuentaCobro	IN	cuencobr.cucocodi%TYPE,
      onuValorTotal	OUT	cuencobr.cucovato%TYPE,
      onuValorAbonado	OUT	cuencobr.cucovaab%TYPE,
      onuSaldoCuenta	OUT	cuencobr.cucosacu%TYPE
    );

    --Genera Saldo a Favor
    PROCEDURE prcGeneraSaldoAFavor
    (
      inuCuentaCobro	IN	cuencobr.cucocodi%TYPE
    );

    --Aplica Saldo a favor
    PROCEDURE prcAplicaSaldoAFavor
    (
      inuProducto     IN	servsusc.sesunuse%TYPE,
      inuCuentaCobro  IN	cuencobr.cucocodi%TYPE DEFAULT NULL,
      isbTiporProceso	IN	cargos.cargtipr%TYPE DEFAULT 'P',
      idtFechaCargo  	IN	cargos.cargfecr%TYPE DEFAULT SYSDATE,
      isbDocuSoporte  IN	cargos.cargdoso%TYPE DEFAULT NULL,
      inuActualizabd 	IN   NUMBER DEFAULT 1
    );

    --Obtiene saldo pendiente de la factura
      FUNCTION fnuObtieneSaldoPendiente
      (
          inuFactura	IN	factura.factcodi%TYPE
      ) 
    RETURN NUMBER;

    --Limpia memoria cache facturacion
    PROCEDURE prcLimpiaMemoriaFacturacion;

    --Valida si el concepto de interes existe
      FUNCTION fblValidaConceptoInteres
      (
          inuConcepto 	IN concepto.conccodi%TYPE
      ) 
    RETURN BOOLEAN;

    --Obtiene el valor del iva
      FUNCTION fnuObtieneValorIva
      (
      inuProducto     IN  servsusc.sesunuse%TYPE,
      inuConceptoBase IN  concepto.conccodi%TYPE,
      inuValorBase    IN  cargos.cargvabl%TYPE,
      idtFecha        IN  pericose.pecsfecf%TYPE DEFAULT NULL
      ) 
    RETURN NUMBER;

    --Se evalua ademas que la causa de cargo de los cargos no sea la obtenida
    --del parametro de causa de cargo por traslado de diferido.
      FUNCTION fblValidaCausaCargosTraslado
      (
          inuCausa 	IN cargos.cargcaca%TYPE
      ) 
    RETURN BOOLEAN;

    --Cambia flag de actualización de base de datos
    PROCEDURE prcCambiaFlagActualizaBD;

    -- Obtiene causa del cargo generica
    FUNCTION fnuObtieneCausaCargoGenerica
      (
      inuTipoProducto     IN  servsusc.sesuserv%TYPE
      ) 
    RETURN causcarg.cacacodi%TYPE;

    --Obtiene signo de cancelación de ajuste
      FUNCTION fnuObtieneSignoCancelacion
      (
      inuValor	IN	cargos.cargvalo%TYPE
      ) 
    RETURN VARCHAR2;

    --Limpia tablas en memria
    PROCEDURE prcLimpiaTablasMemoria;

    --Elimina tabla de hash para que sea borrada por cada suscripcion
    PROCEDURE prcCambiaInitVar
    (
      iblvalor IN BOOLEAN
    );
	
	-- Obtiene la orden de reparto generada 
	FUNCTION fsbObtGenerarOrdenReparto(inuTipoProducto			IN servsusc.sesuserv%TYPE,
									   inuItemBarriosIguales	IN NUMBER,
									   inuItemBarriosDiferentes	IN NUMBER
									   )
	RETURN VARCHAR2;

  --Obtiene valor del cargo por concepto
	FUNCTION fnuObtieneValorCargo
  (
    inuConcepto   IN concepto.conccodi%TYPE
	)
	RETURN NUMBER;
	
END PKG_BOGESTION_FACTURACION;
/
create or replace PACKAGE BODY   ADM_PERSON.PKG_BOGESTION_FACTURACION IS

    -- Identificador del ultimo caso que hizo cambios
    csbVersion                 VARCHAR2(15) := 'OSF-4494';

    -- Constantes para el control de la traza
    csbSP_NAME                 CONSTANT VARCHAR2(35)         :=  $$PLSQL_UNIT||'.';
    cnuNVLTRC                  CONSTANT NUMBER                := 5;
    csbNivelTraza              CONSTANT NUMBER(2) := pkg_traza.fnuNivelTrzDef;


    nuError                     NUMBER;
    sbError                     VARCHAR2(4000);


    --Retona la ultimo caso que hizo cambios en el paquete
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;

     /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcValPoliRedondeoContrato
    Descripcion     : Ejecutar validación de política de redondeo
    Autor           : Jhon Jairo Soto
    Fecha           : 06/12/2024

	Parametros de entrada
		inuContrato	Id de Contrato

	Parametros de salida
		ionuValor	  Valor del cupon

    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jsoto		06-12-2024  OSF-3740    Creacion
    ***************************************************************************/

	PROCEDURE prcValPoliRedondeoContrato(inuContrato	IN suscripc.susccodi%TYPE,
										 ionuValor		IN OUT cupon.cupovalo%TYPE
										)
	IS

		csbMT_NAME  VARCHAR2(70) := csbSP_NAME ||  '.prcValPoliRedondeoContrato';
		nuerrorcode NUMBER;         -- se almacena codigo de error
		sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error
		nuContrato	NUMBER;
		nuValorCupon  cupon.cuposusc%TYPE;

	BEGIN
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

			nuValorCupon := ionuValor;

			pkg_traza.trace('ionuValor: '|| ionuValor);

			FA_BOPOLITICAREDONDEO.VALIDAPOLITICACONT(inuContrato,nuValorCupon);

			ionuValor := nuValorCupon;

			pkg_traza.trace('ionuValor: '|| ionuValor);

			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

			EXCEPTION
				WHEN NO_DATA_FOUND THEN
				pkg_error.getError(nuErrorCode,sbMensError);
				pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
				pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERC);
				WHEN OTHERS THEN
				pkg_error.SetError;
				pkg_error.getError(nuErrorCode,sbMensError);
				pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
				pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);

	END prcValPoliRedondeoContrato;
    
     PROCEDURE prcCreaCuentaCobro( inuProducto   IN   servsusc.sesunuse%type,
                                 inuContrato   IN   servsusc.sesususc%type,
                                 inufactura    IN   factura.factcodi%type,
                                 onuCuenta     OUT  cuencobr.cucocodi%type,
                                 onuError      OUT  NUMBER,
                                 osbError      OUT  VARCHAR2 ) IS
  /**************************************************************************
     Proceso     : proCreaCuentaCobro
     Autor       : Luis Javier Lopez Barrios / Horbath
     Fecha       : 2025-01-14
     Ticket      : OSF-3855
     Descripcion : generar cuenta de cobro

    Parametros Entrada
     inuProducto   codigo del producto
     inuContrato   codigo del contrato
     inufactura    codigo de la factura
    Parametros de salida
     onuCuenta   cuenta de cobro
     onuerror  codigo de error 0 - exito -1 error
     osbError  mensaje de error
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prcCreaCuentaCobro';
    rcContrato                              pkg_bccontrato.sbtContrato;
    rcProducto                              pkg_bcproducto.sbtServSusc;
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace('inuProducto => ' || inuProducto, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('inuContrato => ' || inuContrato, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('inufactura => ' || inufactura, pkg_traza.cnuNivelTrzDef);
    
    pkg_error.prInicializaError(onuError,osbError );

    --Se obtiene el record del contrato
    rcContrato := pkg_bccontrato.frcObtInfoContrato(inuContrato);

    -- Se obtiene el consecutivo de la cuenta de cobro
    pkAccountMgr.GetNewAccountNum(onuCuenta);

    -- Se obtienen el record del producto
    rcProducto := pkg_bcproducto.frcObtProducto(inuProducto);

    -- Crea una nueva cuenta de cobro
    pkAccountMgr.AddNewRecord(inufactura, onuCuenta, rcProducto);
    pkg_traza.trace('onuCuenta => ' || onuCuenta, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
 EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_error.geterror(nuError,sbError);
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.geterror(nuError,sbError);
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
  END prcCreaCuentaCobro;
  PROCEDURE prcCreaFactura( inuContrato      IN   servsusc.sesususc%type,
                            inuPrograma      IN   factura.factprog%type,
                            iblAsignaNumFiscal IN   boolean default true,
                            onuFactura       OUT  factura.factcodi%type,
                            onuError      OUT  NUMBER,
                            osbError      OUT  VARCHAR2 ) IS
   /**************************************************************************
     Proceso     : prcCreaFactura
     Autor       : Luis Javier Lopez Barrios / Horbath
     Fecha       : 2025-01-14
     Ticket      : OSF-3855
     Descripcion : generar factura

    Parametros Entrada
     inuContrato   codigo del contrato
     inuPrograma   codigo del programa de la factura
     iblAsignaNumFiscal asigna numero fiscal a la factura
    Parametros de salida
     onuFactura   factura
     onuerror  codigo de error 0 - exito -1 error
     osbError  mensaje de error
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prcCreaFactura';
    rcContrato      pkg_bccontrato.sbtContrato;

    nuCliente      suscripc.suscclie%type; -- se almacena cliente
    nuSistema      NUMBER;

    nuTipoComp     factura.factcons%type;
    nufiscal       FACTURA.factnufi%TYPE;
    nuTipoComprobante NUMBER;

    sbPrefijo       FACTURA.factpref%TYPE;
    nuConsFisca     FACTURA.factconf%TYPE;
    rcSistema       pkg_sistema.sbtSistema;

  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace('inuContrato => ' || inuContrato, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('inuPrograma => ' || inuPrograma, pkg_traza.cnuNivelTrzDef);
    
    pkg_error.prInicializaError(onuError,osbError );

    --Se obtiene el record del contrato
    rcContrato := pkg_bccontrato.frcObtInfoContrato(inuContrato);

    -- Se obtiene numero de factura
    pkAccountStatusMgr.GetNewAccoStatusNum(onuFactura);

     -- Se crea la nueva factura
    pkAccountStatusMgr.AddNewRecord(onuFactura,
                                    inuPrograma,
                                    rcContrato,
                                    GE_BOconstants.fnuGetDocTypeCons);
    
    IF iblAsignaNumFiscal THEN
        pkg_traza.trace('iblAsignaNumFiscal => Verdadero' , pkg_traza.cnuNivelTrzDef);
        --se actualiza numero fiscal
        nuCliente := rcContrato.suscclie;
        nuTipoComp := pkg_factura.fnuObtFACTCONS(onuFactura);        
        rcSistema  := pkg_sistema.frcObtInfoSistema;
        nuSistema  := rcSistema.sistcodi;
        pkg_traza.trace('nuCliente => '||nuCliente , pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace('nuTipoComp => '||nuTipoComp , pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace('nuSistema => '||nuSistema , pkg_traza.cnuNivelTrzDef);
        pkConsecutiveMgr.GetFiscalNumber(pkConsecutiveMgr.gcsbTOKENFACTURA,
                                         onuFactura,
                                         null,
                                         nuTipoComp,
                                         nuCliente,
                                         nuSistema,
                                         nufiscal,
                                         sbPrefijo,
                                         nuConsFisca,
                                         nuTipoComprobante);
        -- Se actualiza la factura
        pktblFactura.UpFiscalNumber(onuFactura,
                                    nufiscal,
                                    nuTipoComp,
                                    nuConsFisca,
                                    sbPrefijo);
    ELSE
       pkg_traza.trace('iblAsignaNumFiscal => Falso' , pkg_traza.cnuNivelTrzDef);
    END IF;
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
 EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN      
        pkg_error.geterror(nuError,sbError);
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.geterror(nuError,sbError);
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
 END prcCreaFactura;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcGenerarFacturaPorSolicitud
    Descripcion     : Servicio para generar cuenta de cobro y factura
    Autor           : Jorge Valiente
    Fecha           : 10-01-2025
    Ticket          : OSF-3839
  
    Parametros
      Entrada
        inuSolicitud        Codigo de Solicitud
        
    Modificaciones
    =========================================================
    Autor       Fecha       Caso       Descripcion
  ***************************************************************************/
  PROCEDURE prcGenerarFacturaPorSolicitud(inuSolicitud NUMBER) IS
  
    csbMetodo CONSTANT VARCHAR2(100) := csbSP_NAME ||
                                        'prcGenerarFacturaPorSolicitud'; --nombre del metodo
    onuErrorCode    NUMBER;
    osbErrorMessage VARCHAR2(4000);
  
  BEGIN
  
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
  
    pkg_traza.trace('Solicitud: ' || inuSolicitud, csbNivelTraza);
  
    pkg_traza.trace('Ejecucion del servicio cc_boaccounts.generateaccountbypack',
                    csbNivelTraza);
  
    cc_boaccounts.generateaccountbypack(inuSolicitud);
  
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
  
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
      pkg_traza.trace('sberror: ' || OsbErrorMessage, csbNivelTraza);
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
      RAISE pkg_Error.Controlled_Error;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
      pkg_traza.trace('sberror: ' || OsbErrorMessage, csbNivelTraza);
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;
    
  END prcGenerarFacturaPorSolicitud;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : prReferenciaCupon 
    Descripcion     : Retorna una tabla pl con los diferidos con saldo del contrato
                      que tengan plan de alivio por contingencia
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 28/01/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     28/01/2025  OSF-3893 Creacion
    ***************************************************************************/                     
    PROCEDURE prDefDatosTrasladoSaldo
    (
        idtFechaProceso     IN  DATE DEFAULT SYSDATE,
        isbUsuario          IN  VARCHAR2 DEFAULT USER,
        isbTerminal         IN  VARCHAR2 DEFAULT USERENV('TERMINAL')
    )
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prDefDatosTrasladoSaldo';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
      
    BEGIN

        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO);  
        
        -- Setea datos del proceso en API de proceso individual
        pkTraslatePositiveBalance.SetBatchProcessData ( idtFechaProceso,
                                                        isbUsuario,
                                                        isbTerminal
                                                         );
        

        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN); 
                   
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, cnuNVLTRC );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, cnuNVLTRC );
            RAISE pkg_error.Controlled_Error;
    END prDefDatosTrasladoSaldo;
    
    -- Traslada valor de saldo a favor entre productos
    PROCEDURE prTrasladaSaldoAfavor
    (
        inuProductoOrigen   IN  servsusc.sesunuse%TYPE,
        inuContratoOrigen   IN  servsusc.sesususc%TYPE,
        inuValorATrasladar  IN  servsusc.sesusafa%TYPE,   
        inuProductoDestino  IN  servsusc.sesunuse%TYPE,
        isbComentario       IN  VARCHAR2,
        onuError            OUT NUMBER,
        osbError            OUT VARCHAR2
    )
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prTrasladaSaldoAfavor';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        tbServicioOrigen	pkTraslatePositiveBalance.tySesunuseMas;        
           
    BEGIN
    
        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO);  
            
        --inicia traslado a producto destino
        tbServicioOrigen.delete;

        tbServicioOrigen(1).sesunuse := inuProductoOrigen;
        tbServicioOrigen(1).sesususc := inuContratoOrigen;
        tbServicioOrigen(1).sesusafa := inuValorATrasladar;

        pkTraslatePositiveBalance.TRANSLATEBYDEPOSIT( tbServicioOrigen,
                                                    inuProductoDestino,
                                                    isbComentario,
                                                    onuError,
                                                    osbError);    

        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN);  
        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(onuError,osbError);
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(onuError,osbError);
    END prTrasladaSaldoAfavor;

	/***************************************************************************
	Propiedad Intelectual de Gases del Caribe
	Programa        : prcObtienePoliticaAjuste
	Descripcion     : Obtiene politica de ajuste
	Autor           : Luis Felipe Valencia Hurtado
	Fecha           : 19-02-2025

	Parametros
		Entrada

	Modificaciones
	=========================================================
	Autor       Fecha       Caso       	Descripcion
	fvalencia	19-02-2025	OSF-3846	Creación
	***************************************************************************/
	PROCEDURE prcObtienePoliticaAjuste
	(
		inuContrato 	IN suscripc.susccodi%TYPE, 
		oblajuste 		OUT BOOLEAN, 
		onufacajus 		OUT timoempr.tmemfaaj%TYPE
	)
	IS
		csbMT_NAME  VARCHAR2(70) := csbSP_NAME ||  '.prcObtienePoliticaAjuste';      
		nuerrorcode NUMBER;         -- se almacena codigo de error
		sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 			
	BEGIN
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO); 
		
		FA_BOPoliticaRedondeo.ObtienePoliticaAjuste
		(	
			inuContrato,
			oblajuste,
			onufacajus
		);
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);			
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
		pkg_error.getError(nuErrorCode,sbMensError);
		pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERC);	
		RAISE pkg_error.CONTROLLED_ERROR;
		WHEN OTHERS THEN
		pkg_error.SetError;
		pkg_error.getError(nuErrorCode,sbMensError);
		pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);	
		RAISE pkg_error.CONTROLLED_ERROR;
	END prcObtienePoliticaAjuste;

	/***************************************************************************
	Propiedad Intelectual de Gases del Caribe
	Programa        : prcAplicaPoliticaAjuste
	Descripcion     : Aplica politica de ajuste
	Autor           : Luis Felipe Valencia Hurtado
	Fecha           : 19-02-2025

	Parametros
		Entrada

	Modificaciones
	=========================================================
	Autor       Fecha       Caso       	Descripcion
	fvalencia	19-02-2025	OSF-3846	Creación
	***************************************************************************/
	PROCEDURE prcAplicaPoliticaAjuste
	(
		inuProducto 	IN servsusc.sesunuse%TYPE, 
		ionuValorCargo 	IN OUT cargos.cargvalo%TYPE
	)
	IS
		csbMT_NAME  VARCHAR2(70) := csbSP_NAME ||  '.prcAplicaPoliticaAjuste';      
		nuerrorcode NUMBER;         -- se almacena codigo de error
		sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 			
	BEGIN
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO); 
		
		FA_BOPoliticaRedondeo.AplicaPolitica
		(	
			inuProducto,
			ionuValorCargo
		);
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);			
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
		pkg_error.getError(nuErrorCode,sbMensError);
		pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERC);	
		RAISE pkg_error.CONTROLLED_ERROR;
		WHEN OTHERS THEN
		pkg_error.SetError;
		pkg_error.getError(nuErrorCode,sbMensError);
		pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);	
		RAISE pkg_error.CONTROLLED_ERROR;
	END prcAplicaPoliticaAjuste;

	/***************************************************************************
	Propiedad Intelectual de Gases del Caribe
	Programa        : prcActualizaCarteraMemoria
	Descripcion     : Actualiza cartera en memoria
	Autor           : Luis Felipe Valencia Hurtado
	Fecha           : 19-02-2025

	Parametros
		Entrada

	Modificaciones
	=========================================================
	Autor       Fecha       Caso       	Descripcion
	fvalencia	19-02-2025	OSF-3846	Creación
	***************************************************************************/
	PROCEDURE prcActualizaCarteraMemoria
	(
		inuOperacion		IN	NUMBER,
		inuCuentaCobro		IN	cargos.cargcuco%TYPE,
		inuContrato			IN	suscripc.susccodi%TYPE,
		inuPorducto			IN	cargos.cargnuse%TYPE,
		inuConcepto			IN	cargos.cargconc%TYPE,
		inuSigno			IN	cargos.cargsign%TYPE,
		inuValorCargo		IN	cargos.cargvalo%TYPE,
		inuFlagGraba		IN	NUMBER DEFAULT 1
	)
	IS
		csbMT_NAME  VARCHAR2(70) := csbSP_NAME ||  '.prcActualizaCarteraMemoria';      
		nuerrorcode NUMBER;         -- se almacena codigo de error
		sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 			
	BEGIN
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO); 
		
		pkUpdAccoReceiv.UpdAccoRec
		(	
			inuOperacion,
			inuCuentaCobro,
			inuContrato,
			inuPorducto,
			inuConcepto,
			inuSigno,
			inuValorCargo,
			inuFlagGraba
		);
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);			
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
		pkg_error.getError(nuErrorCode,sbMensError);
		pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERC);	
		RAISE pkg_error.CONTROLLED_ERROR;
		WHEN OTHERS THEN
		pkg_error.SetError;
		pkg_error.getError(nuErrorCode,sbMensError);
		pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);	
		RAISE pkg_error.CONTROLLED_ERROR;
	END prcActualizaCarteraMemoria;

	/***************************************************************************
	Propiedad Intelectual de Gases del Caribe
	Programa        : prcActualizaCartera 
	Descripcion     : Actualiza Cartera
	Autor           : Luis Felipe Valencia Hurtado
	Fecha           : 19-02-2025

	Parametros
		Entrada

	Modificaciones
	=========================================================
	Autor       Fecha       Caso       	Descripcion
	fvalencia	19-02-2025	OSF-3846	Creación
	***************************************************************************/
	PROCEDURE prcActualizaCartera
	IS
		csbMT_NAME  VARCHAR2(70) := csbSP_NAME ||  '.prcActualizaCartera ';      
		nuerrorcode NUMBER;         -- se almacena codigo de error
		sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 			
	BEGIN
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO); 
		
		pkUpdAccoReceiv.UpdateData;
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);			
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
		pkg_error.getError(nuErrorCode,sbMensError);
		pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERC);	
		RAISE pkg_error.CONTROLLED_ERROR;
		WHEN OTHERS THEN
		pkg_error.SetError;
		pkg_error.getError(nuErrorCode,sbMensError);
		pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);	
		RAISE pkg_error.CONTROLLED_ERROR;
	END prcActualizaCartera;

	/***************************************************************************
	Propiedad Intelectual de Gases del Caribe
	Programa        : prcObtieneDatosCuentaCobro 
	Descripcion     : Obtiene información de la cuenta de cobro
	Autor           : Luis Felipe Valencia Hurtado
	Fecha           : 19-02-2025

	Parametros
		Entrada

	Modificaciones
	=========================================================
	Autor       Fecha       Caso       	Descripcion
	fvalencia	19-02-2025	OSF-3846	Creación
	***************************************************************************/
	PROCEDURE prcObtieneDatosCuentaCobro
	(
		inuCuentaCobro	IN	cuencobr.cucocodi%TYPE,
		onuValorTotal	OUT	cuencobr.cucovato%TYPE,
		onuValorAbonado	OUT	cuencobr.cucovaab%TYPE,
		onuSaldoCuenta	OUT	cuencobr.cucosacu%TYPE
	)
	IS
		csbMT_NAME  VARCHAR2(70) := csbSP_NAME ||  '.prcObtieneDatosCuentaCobro ';      
		nuerrorcode NUMBER;         -- se almacena codigo de error
		sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 			
	BEGIN
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO); 
		
		pkUpdAccoReceiv.GetAccountData
		(
			inuCuentaCobro,
			onuValorTotal,
			onuValorAbonado,
			onuSaldoCuenta
		);
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);			
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
		pkg_error.getError(nuErrorCode,sbMensError);
		pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERC);	
		RAISE pkg_error.CONTROLLED_ERROR;
		WHEN OTHERS THEN
		pkg_error.SetError;
		pkg_error.getError(nuErrorCode,sbMensError);
		pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);	
		RAISE pkg_error.CONTROLLED_ERROR;
	END prcObtieneDatosCuentaCobro;

	/***************************************************************************
	Propiedad Intelectual de Gases del Caribe
	Programa        : prcGeneraSaldoAFavor 
	Descripcion     : Genera Saldo a favor
	Autor           : Luis Felipe Valencia Hurtado
	Fecha           : 19-02-2025

	Parametros
		Entrada

	Modificaciones
	=========================================================
	Autor       Fecha       Caso       	Descripcion
	fvalencia	19-02-2025	OSF-3846	Creación
	***************************************************************************/
	PROCEDURE prcGeneraSaldoAFavor
	(
		inuCuentaCobro	IN	cuencobr.cucocodi%TYPE
	)
	IS
		csbMT_NAME  VARCHAR2(70) := csbSP_NAME ||  '.prcGeneraSaldoAFavor ';      
		nuerrorcode NUMBER;         -- se almacena codigo de error
		sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 			
	BEGIN
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO); 
		
		pkAccountMgr.GenPositiveBal
		(
			inuCuentaCobro
		);
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);			
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
		pkg_error.getError(nuErrorCode,sbMensError);
		pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERC);	
		RAISE pkg_error.CONTROLLED_ERROR;
		WHEN OTHERS THEN
		pkg_error.SetError;
		pkg_error.getError(nuErrorCode,sbMensError);
		pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);	
		RAISE pkg_error.CONTROLLED_ERROR;
	END prcGeneraSaldoAFavor;

	/***************************************************************************
	Propiedad Intelectual de Gases del Caribe
	Programa        : prcAplicaSaldoAFavor 
	Descripcion     : Aplica Saldo a favor
	Autor           : Luis Felipe Valencia Hurtado
	Fecha           : 19-02-2025

	Parametros
		Entrada

	Modificaciones
	=========================================================
	Autor       Fecha       Caso       	Descripcion
	fvalencia	19-02-2025	OSF-3846	Creación
	***************************************************************************/
	PROCEDURE prcAplicaSaldoAFavor
	(
		inuProducto     IN	servsusc.sesunuse%TYPE,
		inuCuentaCobro  IN	cuencobr.cucocodi%TYPE DEFAULT NULL,
		isbTiporProceso	IN	cargos.cargtipr%TYPE DEFAULT 'P',
		idtFechaCargo  	IN	cargos.cargfecr%TYPE DEFAULT SYSDATE,
		isbDocuSoporte  IN	cargos.cargdoso%TYPE DEFAULT NULL,
		inuActualizabd 	IN   NUMBER DEFAULT 1
	)
	IS
		csbMT_NAME  VARCHAR2(70) := csbSP_NAME ||  '.prcAplicaSaldoAFavor ';      
		nuerrorcode NUMBER;         -- se almacena codigo de error
		sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 			
	BEGIN
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO); 
		
		pkAccountMgr.ApplyPositiveBalServ
		(
			inuProducto,
			inuCuentaCobro,
			isbTiporProceso,
			idtFechaCargo,
			isbDocuSoporte,
			inuActualizabd
		);
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);			
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
		pkg_error.getError(nuErrorCode,sbMensError);
		pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERC);	
		RAISE pkg_error.CONTROLLED_ERROR;
		WHEN OTHERS THEN
		pkg_error.SetError;
		pkg_error.getError(nuErrorCode,sbMensError);
		pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);	
		RAISE pkg_error.CONTROLLED_ERROR;
	END prcAplicaSaldoAFavor;

	/***************************************************************************
	Propiedad Intelectual de Gases del Caribe
	Programa        : fnuObtieneSaldoPendiente 
	Descripcion     : Obtiene saldo pendiente de la factura
	Autor           : Luis Felipe Valencia Hurtado
	Fecha           : 19-02-2025

	Parametros
		Entrada

	Modificaciones
	=========================================================
	Autor       Fecha       Caso       	Descripcion
	fvalencia	19-02-2025	OSF-3846	Creación
	***************************************************************************/
    FUNCTION fnuObtieneSaldoPendiente
    (
        inuFactura	IN	factura.factcodi%TYPE
    ) 
	RETURN NUMBER
    IS	
		csbMT_NAME  		VARCHAR2(200) := csbSP_NAME || 'fnuObtieneSaldoPendiente';
		
		nuErrorCodigo         	NUMBER			:= pkg_error.CNUGENERIC_MESSAGE;
		nuSaldoPendiente        NUMBER;
		sbErrorMensaje			VARCHAR2(2000)	:= NULL;        
    BEGIN		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
		
		pkg_traza.trace('inuFactura: ' || inuFactura, cnuNVLTRC);  
		
		pkg_error.prInicializaError(nuErrorCodigo, sbErrorMensaje);		    

		nuSaldoPendiente := pkBCAccountStatus.fnuGetBalance(inuFactura);
	
		pkg_traza.trace('nuSaldoPendiente: ' || nuSaldoPendiente, cnuNVLTRC);  
    
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN nuSaldoPendiente;
    EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuErrorCodigo, sbErrorMensaje);
			pkg_traza.trace('nuErrorCodigo: ' || nuErrorCodigo || ' sbErrorMensaje: ' || sbErrorMensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
			RAISE pkg_error.CONTROLLED_ERROR;
			RETURN nuSaldoPendiente;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuErrorCodigo, sbErrorMensaje);
			pkg_traza.trace('nuErrorCodigo: ' || nuErrorCodigo || ' sbErrorMensaje: ' || sbErrorMensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR); 
			RAISE pkg_Error.Controlled_Error;
			RETURN nuSaldoPendiente;
    END fnuObtieneSaldoPendiente;

   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcInicializaParametrosMemoria
    Descripcion     : Inicializa tabla de memoria de parametros
    Autor           : Luis Felipe Valencia Hurtado
    Fecha           : 19-02-2025

    Parametros
      Entrada

    Modificaciones
    =========================================================
    Autor       Fecha       Caso       	Descripcion
	fvalencia	19-02-2025	OSF-3846	Creación
  ***************************************************************************/
	PROCEDURE prcInicializaParametrosMemoria
	IS
		csbMT_NAME  VARCHAR2(70) := csbSP_NAME ||  '.prcInicializaParametrosMemoria';      
		nuerrorcode NUMBER;         -- se almacena codigo de error
		sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 			
	BEGIN
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO); 
		
		pkBillFuncParameters.InitMemTable;
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);			
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
		pkg_error.getError(nuErrorCode,sbMensError);
		pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERC);	
		RAISE pkg_error.CONTROLLED_ERROR;
		WHEN OTHERS THEN
		pkg_error.SetError;
		pkg_error.getError(nuErrorCode,sbMensError);
		pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);	
		RAISE pkg_error.CONTROLLED_ERROR;
	END prcInicializaParametrosMemoria;

	/***************************************************************************
	Propiedad Intelectual de Gases del Caribe
	Programa        : prcHabilitaManejoCache
	Descripcion     : Habilita manejo de cache para parametros
	Autor           : Luis Felipe Valencia Hurtado
	Fecha           : 19-02-2025

	Parametros
		Entrada

	Modificaciones
	=========================================================
	Autor       Fecha       Caso       	Descripcion
	fvalencia	19-02-2025	OSF-3846	Creación
	***************************************************************************/
	PROCEDURE prcHabilitaManejoCache
	IS
		csbMT_NAME  VARCHAR2(70) := csbSP_NAME ||  '.prcHabilitaManejoCache';      
		nuerrorcode NUMBER;         -- se almacena codigo de error
		sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 			
	BEGIN
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO); 
		
		pkGrlParamExtendedMgr.SetCacheOn;
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);			
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
		pkg_error.getError(nuErrorCode,sbMensError);
		pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERC);	
		RAISE pkg_error.CONTROLLED_ERROR;
		WHEN OTHERS THEN
		pkg_error.SetError;
		pkg_error.getError(nuErrorCode,sbMensError);
		pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);	
		RAISE pkg_error.CONTROLLED_ERROR;
	END prcHabilitaManejoCache;

	/***************************************************************************
	Propiedad Intelectual de Gases del Caribe
	Programa        : prcLimpiaMemoriaFacturacion
	Descripcion     : Limpia memoria cache facturacion
	Autor           : Luis Felipe Valencia Hurtado
	Fecha           : 19-02-2025

	Parametros
		Entrada

	Modificaciones
	=========================================================
	Autor       Fecha       Caso       	Descripcion
	fvalencia	19-02-2025	OSF-3846	Creación
	***************************************************************************/
	PROCEDURE prcLimpiaMemoriaFacturacion
	IS
		csbMT_NAME  VARCHAR2(70) := csbSP_NAME ||  '.prcLimpiaMemoriaFacturacion';      
		nuerrorcode NUMBER;         -- se almacena codigo de error
		sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 			
	BEGIN
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO); 
		
		pktblParafact.ClearMemory;
		pktblSistema.ClearMemory;
		pktblConsecut.ClearMemory;
		pktblCuencobr.ClearMemory;
		pktblFactura.ClearMemory;
		pktblSuscripc.ClearMemory;
		pktblServsusc.ClearMemory;
		pktblConcepto.ClearMemory;
		pktblParametr.ClearMemory;
		pktblMensaje.ClearMemory;
		pktblPerifact.ClearMemory;  
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);			
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
		pkg_error.getError(nuErrorCode,sbMensError);
		pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERC);	
		RAISE pkg_error.CONTROLLED_ERROR;
		WHEN OTHERS THEN
		pkg_error.SetError;
		pkg_error.getError(nuErrorCode,sbMensError);
		pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);	
		RAISE pkg_error.CONTROLLED_ERROR;
	END prcLimpiaMemoriaFacturacion;

	/***************************************************************************
	Propiedad Intelectual de Gases del Caribe
	Programa        : fblValidaConceptoInteres
	Descripcion     : Valida si el concepto de interes existe
	Autor           : Luis Felipe Valencia Hurtado
	Fecha           : 19-02-2025

	Parametros
		Entrada

	Modificaciones
	=========================================================
	Autor       Fecha       Caso       	Descripcion
	fvalencia	19-02-2025	OSF-3846	Creación
	***************************************************************************/
    FUNCTION fblValidaConceptoInteres
    (
        inuConcepto 	IN concepto.conccodi%TYPE
    ) 
	RETURN BOOLEAN
    IS	
		csbMT_NAME  		VARCHAR2(200) := csbSP_NAME || 'fblValidaConceptoInteres';
		
		nuErrorCodigo         	NUMBER			:= pkg_error.CNUGENERIC_MESSAGE;
		blExiste    			BOOLEAN := FALSE;
		sbErrorMensaje			VARCHAR2(2000)	:= NULL;        
    BEGIN		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
		
		pkg_traza.trace('inuConcepto: ' || inuConcepto, cnuNVLTRC);  
		
		pkg_error.prInicializaError(nuErrorCodigo, sbErrorMensaje);		    

		blExiste := pkConceptMgr.fblIsTaxesConcept(inuConcepto);
    
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN blExiste;
    EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuErrorCodigo, sbErrorMensaje);
			pkg_traza.trace('nuErrorCodigo: ' || nuErrorCodigo || ' sbErrorMensaje: ' || sbErrorMensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
			RAISE pkg_error.CONTROLLED_ERROR;
			RETURN blExiste;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuErrorCodigo, sbErrorMensaje);
			pkg_traza.trace('nuErrorCodigo: ' || nuErrorCodigo || ' sbErrorMensaje: ' || sbErrorMensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR); 
			RAISE pkg_Error.Controlled_Error;
			RETURN blExiste;
    END fblValidaConceptoInteres;

	/***************************************************************************
	Propiedad Intelectual de Gases del Caribe
	Programa        : fnuObtieneValorIva
	Descripcion     : Obtiene el valor del iva
	Autor           : Luis Felipe Valencia Hurtado
	Fecha           : 19-02-2025

	Parametros
		Entrada

	Modificaciones
	=========================================================
	Autor       Fecha       Caso       	Descripcion
	fvalencia	19-02-2025	OSF-3846	Creación
	***************************************************************************/
    FUNCTION fnuObtieneValorIva
    (
		inuProducto     IN  servsusc.sesunuse%TYPE,
		inuConceptoBase IN  concepto.conccodi%TYPE,
		inuValorBase    IN  cargos.cargvabl%TYPE,
		idtFecha        IN  pericose.pecsfecf%TYPE DEFAULT NULL
    ) 
	RETURN NUMBER
    IS	
		csbMT_NAME  		VARCHAR2(200) := csbSP_NAME || 'fnuObtieneValorIva';
		
		nuErrorCodigo         	NUMBER			:= pkg_error.CNUGENERIC_MESSAGE;
		nuvaloriva    			NUMBER;
		sbErrorMensaje			VARCHAR2(2000)	:= NULL;        
    BEGIN		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
		
		pkg_traza.trace('inuProducto: ' || inuProducto, cnuNVLTRC);  
		pkg_traza.trace('inuConceptoBase: ' || inuConceptoBase, cnuNVLTRC);
		pkg_traza.trace('inuValorBase: ' || inuValorBase, cnuNVLTRC);
		
		pkg_error.prInicializaError(nuErrorCodigo, sbErrorMensaje);		    

		nuvaloriva := FA_BOIVAModeMgr.fnuGetValueIVA(inuProducto,inuConceptoBase,inuValorBase,idtFecha);
    
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN nuvaloriva;
    EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuErrorCodigo, sbErrorMensaje);
			pkg_traza.trace('nuErrorCodigo: ' || nuErrorCodigo || ' sbErrorMensaje: ' || sbErrorMensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
			RAISE pkg_error.CONTROLLED_ERROR;
			RETURN nuvaloriva;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuErrorCodigo, sbErrorMensaje);
			pkg_traza.trace('nuErrorCodigo: ' || nuErrorCodigo || ' sbErrorMensaje: ' || sbErrorMensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR); 
			RAISE pkg_Error.Controlled_Error;
			RETURN nuvaloriva;
    END fnuObtieneValorIva;

	/***************************************************************************
	Propiedad Intelectual de Gases del Caribe
	Programa        : fblValidaConceptoInteres
	Descripcion     : Se evalua ademas que la causa de cargo de los cargos no sea la obtenida
				      del parametro de causa de cargo por traslado de diferido.
	Autor           : Luis Felipe Valencia Hurtado
	Fecha           : 19-02-2025

	Parametros
		Entrada

	Modificaciones
	=========================================================
	Autor       Fecha       Caso       	Descripcion
	fvalencia	19-02-2025	OSF-3846	Creación
	***************************************************************************/
    FUNCTION fblValidaCausaCargosTraslado
    (
        inuCausa 	IN cargos.cargcaca%TYPE
    ) 
	RETURN BOOLEAN
    IS	
		csbMT_NAME  		VARCHAR2(200) := csbSP_NAME || 'fblValidaCausaCargosTraslado';
		
		nuErrorCodigo         	NUMBER			:= pkg_error.CNUGENERIC_MESSAGE;
		blExiste    			BOOLEAN := FALSE;
		sbErrorMensaje			VARCHAR2(2000)	:= NULL;        
    BEGIN		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
		
		pkg_traza.trace('inuCausa: ' || inuCausa, cnuNVLTRC);  
		
		pkg_error.prInicializaError(nuErrorCodigo, sbErrorMensaje);		    

		blExiste := FA_BOChargeCauses.fboIsDefTransChCause(inuCausa);
    
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN blExiste;
    EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuErrorCodigo, sbErrorMensaje);
			pkg_traza.trace('nuErrorCodigo: ' || nuErrorCodigo || ' sbErrorMensaje: ' || sbErrorMensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
			RAISE pkg_error.CONTROLLED_ERROR;
			RETURN blExiste;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuErrorCodigo, sbErrorMensaje);
			pkg_traza.trace('nuErrorCodigo: ' || nuErrorCodigo || ' sbErrorMensaje: ' || sbErrorMensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR); 
			RAISE pkg_Error.Controlled_Error;
			RETURN blExiste;
    END fblValidaCausaCargosTraslado;

	/***************************************************************************
	Propiedad Intelectual de Gases del Caribe
	Programa        : prcCambiaFlagActualizaBD
	Descripcion     : Cambia flag de actualización de base de datos
	Autor           : Luis Felipe Valencia Hurtado
	Fecha           : 19-02-2025

	Parametros
		Entrada

	Modificaciones
	=========================================================
	Autor       Fecha       Caso       	Descripcion
	fvalencia	19-02-2025	OSF-3846	Creación
	***************************************************************************/
	PROCEDURE prcCambiaFlagActualizaBD
	IS
		csbMT_NAME  VARCHAR2(70) := csbSP_NAME ||  '.prcCambiaFlagActualizaBD';      
		nuerrorcode NUMBER;         -- se almacena codigo de error
		sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 			
	BEGIN
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO); 
		
		FA_BOBillingNotes.SetUpdateDataBaseFlag;  
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);			
	EXCEPTION
	WHEN NO_DATA_FOUND THEN
		pkg_error.getError(nuErrorCode,sbMensError);
		pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERC);	
		RAISE pkg_error.CONTROLLED_ERROR;
	WHEN OTHERS THEN
		pkg_error.SetError;
		pkg_error.getError(nuErrorCode,sbMensError);
		pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);	
		RAISE pkg_error.CONTROLLED_ERROR;
	END prcCambiaFlagActualizaBD;

	/***************************************************************************
	Propiedad Intelectual de Gases del Caribe
	Programa        : fnuObtieneCausaCargoGenerica
	Descripcion     : Obtiene causa del cargo generica
	Autor           : Luis Felipe Valencia Hurtado
	Fecha           : 19-02-2025

	Parametros
		Entrada

	Modificaciones
	=========================================================
	Autor       Fecha       Caso       	Descripcion
	fvalencia	19-02-2025	OSF-3846	Creación
	***************************************************************************/
    FUNCTION fnuObtieneCausaCargoGenerica
    (
		inuTipoProducto     IN  servsusc.sesuserv%TYPE
    ) 
	RETURN causcarg.cacacodi%TYPE
    IS	
		csbMT_NAME  		VARCHAR2(200) := csbSP_NAME || 'fnuObtieneCausaCargoGenerica';
		
		nuErrorCodigo         	NUMBER			:= pkg_error.CNUGENERIC_MESSAGE;
		sbErrorMensaje			VARCHAR2(2000)	:= NULL;     
		nuCausaCargo			causcarg.cacacodi%TYPE;   
    BEGIN		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
		
		pkg_traza.trace('inuTipoProducto: ' || inuTipoProducto, cnuNVLTRC);  
		
		pkg_error.prInicializaError(nuErrorCodigo, sbErrorMensaje);		    

		nuCausaCargo := FA_BOChargeCauses.fnuGenericChCause(inuTipoProducto);
    
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN nuCausaCargo;
    EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuErrorCodigo, sbErrorMensaje);
			pkg_traza.trace('nuErrorCodigo: ' || nuErrorCodigo || ' sbErrorMensaje: ' || sbErrorMensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
			RAISE pkg_error.CONTROLLED_ERROR;
			RETURN nuCausaCargo;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuErrorCodigo, sbErrorMensaje);
			pkg_traza.trace('nuErrorCodigo: ' || nuErrorCodigo || ' sbErrorMensaje: ' || sbErrorMensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR); 
			RAISE pkg_Error.Controlled_Error;
			RETURN nuCausaCargo;
    END fnuObtieneCausaCargoGenerica;

	/***************************************************************************
	Propiedad Intelectual de Gases del Caribe
	Programa        : fnuObtieneCausaCargoGenerica
	Descripcion     : Obtiene signo de cancelación de ajuste
	Autor           : Luis Felipe Valencia Hurtado
	Fecha           : 19-02-2025

	Parametros
		Entrada

	Modificaciones
	=========================================================
	Autor       Fecha       Caso       	Descripcion
	fvalencia	19-02-2025	OSF-3846	Creación
	***************************************************************************/
    FUNCTION fnuObtieneSignoCancelacion
    (
		inuValor	IN	cargos.cargvalo%TYPE
    ) 
	RETURN VARCHAR2
    IS	
		csbMT_NAME  		VARCHAR2(200) := csbSP_NAME || 'fnuObtieneSignoCancelacion';
		
		nuErrorCodigo         	NUMBER			:= pkg_error.CNUGENERIC_MESSAGE;
		sbErrorMensaje			VARCHAR2(2000)	:= NULL;     
		sbSigno					cargos.cargsign%TYPE;   
    BEGIN		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
		
		pkg_traza.trace('inuValor: ' || inuValor, cnuNVLTRC);  
		
		pkg_error.prInicializaError(nuErrorCodigo, sbErrorMensaje);		    

		sbSigno := pkChargeMgr.fsbGetCancelSign(inuValor);
    
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN sbSigno;
    EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuErrorCodigo, sbErrorMensaje);
			pkg_traza.trace('nuErrorCodigo: ' || nuErrorCodigo || ' sbErrorMensaje: ' || sbErrorMensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
			RAISE pkg_error.CONTROLLED_ERROR;
			RETURN sbSigno;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuErrorCodigo, sbErrorMensaje);
			pkg_traza.trace('nuErrorCodigo: ' || nuErrorCodigo || ' sbErrorMensaje: ' || sbErrorMensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR); 
			RAISE pkg_Error.Controlled_Error;
			RETURN sbSigno;
    END fnuObtieneSignoCancelacion;

	/***************************************************************************
	Propiedad Intelectual de Gases del Caribe
	Programa        : prcLimpiaTablasMemoria
	Descripcion     : Limpia tablas en memoria
	Autor           : Luis Felipe Valencia Hurtado
	Fecha           : 19-02-2025

	Parametros
		Entrada

	Modificaciones
	=========================================================
	Autor       Fecha       Caso       	Descripcion
	fvalencia	19-02-2025	OSF-3846	Creación
	***************************************************************************/
	PROCEDURE prcLimpiaTablasMemoria
	IS
		csbMT_NAME  VARCHAR2(70) := csbSP_NAME ||  '.prcLimpiaTablasMemoria';      
		nuerrorcode NUMBER;         -- se almacena codigo de error
		sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 			
	BEGIN
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO); 
		
		pkUpdAccoReceiv.ClearMemTables;
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);			
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
		pkg_error.getError(nuErrorCode,sbMensError);
		pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERC);	
		RAISE pkg_error.CONTROLLED_ERROR;
		WHEN OTHERS THEN
		pkg_error.SetError;
		pkg_error.getError(nuErrorCode,sbMensError);
		pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);	
		RAISE pkg_error.CONTROLLED_ERROR;
	END prcLimpiaTablasMemoria;

		/***************************************************************************
	Propiedad Intelectual de Gases del Caribe
	Programa        : prcCambiaInitVar
	Descripcion     : Elimina tabla de hash para que sea borrada por cada suscripcion
	Autor           : Luis Felipe Valencia Hurtado
	Fecha           : 19-02-2025

	Parametros
		Entrada

	Modificaciones
	=========================================================
	Autor       Fecha       Caso       	Descripcion
	fvalencia	19-02-2025	OSF-3846	Creación
	***************************************************************************/
	PROCEDURE prcCambiaInitVar
	(
		iblvalor IN BOOLEAN
	)
	IS
		csbMT_NAME  VARCHAR2(70) := csbSP_NAME ||  '.prcCambiaInitVar';      
		nuerrorcode NUMBER;         -- se almacena codigo de error
		sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 			
	BEGIN
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO); 
		
		pkExtendedHash.SetInitVar(iblvalor);
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);			
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
		pkg_error.getError(nuErrorCode,sbMensError);
		pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERC);	
		RAISE pkg_error.CONTROLLED_ERROR;
		WHEN OTHERS THEN
		pkg_error.SetError;
		pkg_error.getError(nuErrorCode,sbMensError);
		pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);	
		RAISE pkg_error.CONTROLLED_ERROR;
	END prcCambiaInitVar;
	
	/***************************************************************************
	Propiedad Intelectual de Gases del Caribe
	Programa        : fsbObtGenerarOrdenReparto
	Descripcion     : Obtiene la orden de reparto generada
	
	Autor           : Jhon Erazo
	Fecha           : 15/05/2025

	Parametros
		Entrada
			inuTipoProducto				Tipo de producto
			inuItemBarriosIguales		Items barios iguales
			inuItemBarriosDiferentes	Items barrios diferentes
		Salida
			sbOrdenReparto				Orden de reparto

	Modificaciones
	=========================================================
	Autor       Fecha       Caso       	Descripcion
	jerazomvm	15/05/2025	OSF-4480	Creación
	***************************************************************************/
	FUNCTION fsbObtGenerarOrdenReparto(inuTipoProducto			IN servsusc.sesuserv%TYPE,
									   inuItemBarriosIguales	IN NUMBER,
									   inuItemBarriosDiferentes	IN NUMBER
									   )
	RETURN VARCHAR2
	IS
		csbMT_NAME  VARCHAR2(70) := csbSP_NAME || 'fsbObtGenerarOrdenReparto';     
		
		nuError 		NUMBER;         -- se almacena codigo de error
		sbMensaje		VARCHAR2(2000);  -- se almacena descripcion del error 	
		sbOrdenReparto  VARCHAR2(2000);		
		
	BEGIN
	
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO); 
		
		pkg_traza.trace('inuTipoProducto: ' 			|| inuTipoProducto			|| CHR(10) ||
						'inuItemBarriosIguales: ' 		|| inuItemBarriosIguales 	|| CHR(10) ||
						'inuItemBarriosDiferentes: ' 	|| inuItemBarriosDiferentes, cnuNVLTRC);
		
		-- Se genera la orden de raparto
		sbOrdenReparto := PKBOBILLPRINTUTILITIES.FSBGENDELIVERYORDER(inuTipoProducto, 
																	 inuItemBarriosIguales, 
																	 inuItemBarriosDiferentes
																	 );
																	 
		pkg_traza.trace('sbOrdenReparto: '	|| sbOrdenReparto, cnuNVLTRC);		
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);			
		
		RETURN sbOrdenReparto;
		
	EXCEPTION
		WHEN pkg_error.controlled_error THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTrc);
            pkg_traza.trace(csbMT_NAME, cnuNvlTrc, pkg_traza.csbFIN_ERC); 
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTrc);
            pkg_traza.trace(csbMT_NAME, cnuNvlTrc, pkg_traza.fsbFIN_ERR); 
            RAISE pkg_error.controlled_error;
	END fsbObtGenerarOrdenReparto;

	/***************************************************************************
	Propiedad Intelectual de Gases del Caribe
	Programa        : fnuObtieneValorCargo
	Descripcion     : Obtiene valor del cargo por concepto
	
	Autor           : Luis Felipe Valencia Hurtado
	Fecha           : 23/05/2025

	Parametros
		Entrada
			inuConcepto   Código del concepto
		Salida
			sbOrdenReparto				Orden de reparto

	Modificaciones
	=========================================================
	Autor       Fecha       Caso       	Descripcion
	fvalencia	  23/05/2025	OSF-4494	  Creación
	***************************************************************************/
	FUNCTION fnuObtieneValorCargo
  (
    inuConcepto   IN concepto.conccodi%TYPE
	)
	RETURN NUMBER
	IS
		csbMT_NAME  VARCHAR2(70) := csbSP_NAME || 'fnuObtieneValorCargo';     
		
		nuError 		NUMBER;         -- se almacena codigo de error
		sbMensaje		VARCHAR2(2000);  -- se almacena descripcion del error 	
		nuValor     cargos.cargvalo%TYPE := 0.00;		
	BEGIN	
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO); 
		
		pkg_traza.trace('inuConcepto: '|| inuConcepto, cnuNVLTRC);
		
		nuValor := GetGeneratedCharge(inuConcepto);
																	 
		pkg_traza.trace('nuValor: '	|| nuValor, cnuNVLTRC);		
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);			
		
		RETURN nuValor;		
	EXCEPTION
		WHEN pkg_error.controlled_error THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTrc);
            pkg_traza.trace(csbMT_NAME, cnuNvlTrc, pkg_traza.csbFIN_ERC); 
            RETURN nuValor;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTrc);
            pkg_traza.trace(csbMT_NAME, cnuNvlTrc, pkg_traza.fsbFIN_ERR); 
            RETURN nuValor;
	END fnuObtieneValorCargo;
  
END PKG_BOGESTION_FACTURACION;
/
PROMPT Otorgando permisos de ejecución para adm_person.PKG_BOGESTION_FACTURACION
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BOGESTION_FACTURACION', 'ADM_PERSON');
END;
/