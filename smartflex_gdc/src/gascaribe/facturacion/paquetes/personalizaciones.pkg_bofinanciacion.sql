CREATE OR REPLACE PACKAGE personalizaciones.pkg_bofinanciacion IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Paquete     :   pkg_bofinanciacion
    Autor       :   Lubin Pineda - GlobalMVM
    Fecha       :   07/02/2025
    Descripcion :   Paquete para el manejo de financiaciones
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    fvalencia   24/04/2025  OSF-4294    Se agregan los soguiente procedimiento:
                                        prcObtieneValorToTalExtra, 
                                        prcAgregaCuotasExtrasDiferido, 
                                        prcCreacionDiferido,
                                        prcObtienePorcRecargoMora, 
                                        prcGenerarDiferido
                                        Se eliminan los rollback del método prcVerificaPrioridadPlanFinan                                        
	jerazomvm	28/03/2025  OSF-4155	Se crea el procedimiento prcVerificaPrioridadPlanFinan
    LJLB	    13/02/2025  OSF-4000	se agregan utilidades para traslado a presente mes de forma manual
	jpinedc     07/02/2025  OSF-3893    Creacion
	pacosta     13-05-2025  OSF-4336    Creacion metodo prObtCondFinanxProducto
	jerazomvm	05/06/2025	OSF-4535	Se modifica prcVerificaPrioridadPlanFinan
*******************************************************************************/

    -- Retorna Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;
    
    -- Conviente una financiación en deuda corriente
    PROCEDURE prTraslFinanAdeudaCorriente
    (
        inuProducto         IN  diferido.difenuse%TYPE,
        inuFinanciacion     IN  diferido.difecofi%TYPE,
        idtFechaRegistro    IN  DATE,
        isbDocumento        IN  diferido.difenudo%TYPE,
        inuValorAcorriente  IN  NUMBER,
        iblabono            IN  BOOLEAN,
        isbPrograma         IN  VARCHAR2,
        onuCuentaCobro      OUT cuencobr.cucocodi%TYPE,
        onuError            OUT NUMBER,
        osbError            OUT VARCHAR2        
    );

    -- Convierte un diferido en deuda corriente
    PROCEDURE prTraslDiferidoAdeudaCorriente
    (
        inuDiferido         IN  diferido.difecodi%TYPE,
        idtFechaRegistro    IN  DATE,          
        inuValorAcorriente  IN  NUMBER,
        iblabono            IN  BOOLEAN,
        isbPrograma         IN  VARCHAR2,
        onuCuentaCobro      OUT cuencobr.cucocodi%TYPE,        
        onuError            OUT NUMBER,
        osbError            OUT VARCHAR2     
    );
	PROCEDURE prcTrasladoDifeaCorriente ( inuDiferido   IN diferido.difecodi%type,
										 inuValorTrasl IN  diferido.DIFEVATD%type,
										 inucuenta     IN  cargos.cargcuco%type,
										 inuperifact   IN  cargos.cargpefa%type,
										 onuError      OUT  NUMBER,
										 osbError      OUT  VARCHAR2);


    /**************************************************************************
     Proceso     : prcTrasladoDifeCorriente
     Autor       : Luis Javier Lopez Barrios / Horbath
     Fecha       : 2022-11-22
     Ticket      : OSF-688
     Descripcion : traslado de diferido a corriente de forma manual
				   utilizar con autorizacion del grupo de validacion tecnica

		Parametros Entrada
		 inuDiferido   codigo del diferido
		 inuValorTrasl  valor a trasladar
		 inucuenta      cuenta de cobro donde se generara los cargos
		 inuperifact    periodo de facturacion
		Parametros de salida
		 onuerror  codigo de error 0 - exito -1 error
		 osbError  mensaje de error
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
    13/02/2025	  LJLB		  Creacion	
	***************************************************************************/

	-- Verifica que el plan de negociación de deuda elegido sea el más prioritario o el correcto para elegir según config
	PROCEDURE prcVerificaPrioridadPlanFinan(isbPrograma 		IN cc_financing_request.record_program%TYPE, 
										    inuPlanFinanciacion	IN cc_financing_request.financing_plan_id%TYPE,
										    inuContrato			IN suscripc.susccodi%TYPE
										    );

    --Obtiene porcentaje de mora
    PROCEDURE prcObtienePorcRecargoMora 
    ( 
        inuPlandiferiodo    IN plandife.pldicodi%TYPE,
        onuPorcentajeMora OUT NUMBER
    );

    --Gerenera diferido
    PROCEDURE prcGenerarDiferido 
    (
        inuProducto         IN  diferido.difenuse%TYPE,
        inuConcepto         IN  diferido.difeconc%TYPE,
        inuValor            IN  diferido.difevatd%TYPE,
        inuPlanDiferido     IN  diferido.difepldi%TYPE,
        inuCantidadCuotas   IN  diferido.difenucu%TYPE,
        ionuCodigoFinan      IN OUT  diferido.difecofi%TYPE,
        isbdifedoso         IN  diferido.difenudo%TYPE,
        isbPrograma         IN  diferido.difeprog%TYPE,
        onuDiferido         OUT  diferido.difecodi%TYPE
    ) ;
	
    --Obtiene condiciones de financiacion por producto
    PROCEDURE prObtCondFinanxProducto
    (
      inuIdOrden     IN  or_order.order_id%TYPE,
      inuIdSolicitud IN  mo_packages.package_id%TYPE,
      onuIdPlanFinan OUT plandife.pldicodi%TYPE,
      onuNumCuotas   OUT plandife.pldicuma%TYPE
    );
    
END pkg_bofinanciacion;
/
CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_bofinanciacion IS
    
    -----------------------------------
    -- Identificador del ultimo caso que hizo cambios en este archivo
    -----------------------------------
    csbVersion                 VARCHAR2(15) := 'OSF-4535';

    -----------------------------------
    -- Constantes para el control de la traza
    -----------------------------------
    csbPqt_nombre   CONSTANT VARCHAR2(100) := $$plsql_unit || '.';
    csbNivelTraza   CONSTANT NUMBER        := pkg_traza.cnuNivelTrzDef;
    csbInicio       CONSTANT VARCHAR2(35)  := pkg_traza.csbInicio;
    csbFin          CONSTANT VARCHAR2(35)  := pkg_traza.csbFin;
    csbFin_err      CONSTANT VARCHAR2(35)  := pkg_traza.csbFin_err;
    csbFin_erc      CONSTANT VARCHAR2(35)  := pkg_traza.csbfin_erc;         
   
    -----------------------------------
    -- Constantes privadas del paquete
    -----------------------------------
    cnuTIPO_REF_CUPON   CONSTANT NUMBER(1) := 1;
    
    -----------------------------------
    -- Variables privadas del package
    -----------------------------------
    nuError		NUMBER;  		
    sbMensaje   VARCHAR2(1000);

    --sbError   VARCHAR2(4000);

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fsbVersion
    Descripcion     : Retona la ultima WO que hizo cambios en el paquete
    Autor           : Lubin Pineda - MVM
    Fecha           : 07/02/2025
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     07/02/2025  OSF-3893 Creacion
    ***************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : prTraslFinanAdeudaCorriente
    Descripcion     : Conviente una financiación en deuda corriente
    Autor           : Lubin Pineda - GlobalMVM
    Fecha           : 07/02/2025
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     07/02/2025  OSF-3893    Creacion
    ***************************************************************************/

    PROCEDURE prTraslFinanAdeudaCorriente
    (
        inuProducto         IN  diferido.difenuse%TYPE,
        inuFinanciacion     IN  diferido.difecofi%TYPE,
        idtFechaRegistro    IN  DATE,
        isbDocumento        IN  diferido.difenudo%TYPE,
        inuValorAcorriente  IN  NUMBER,
        iblabono            IN  BOOLEAN,
        isbPrograma         IN  VARCHAR2,
        onuCuentaCobro      OUT cuencobr.cucocodi%TYPE,
        onuError            OUT NUMBER,
        osbError            OUT VARCHAR2
    )
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbPqt_nombre || 'prTraslFinanAdeudaCorriente';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        pkg_bogestion_financiacion.prIniciaVariablesGlobales;

        pkg_bogestion_financiacion.prAgregaDifCobrFinanciacion
        (
            inuProducto         ,
            inuFinanciacion     ,
            idtFechaRegistro    ,
            isbDocumento
        );

        pkg_bogestion_financiacion.prTraslDeudaDiferidaACorriente
        (
            inuValorAcorriente  ,
            idtFechaRegistro    ,
            iblabono            ,
            isbPrograma         ,
            onuError            ,
            osbError
        );

        IF onuError = 0 THEN
            onuCuentaCobro := pkg_bcfinanciacion.fnuObtCuenCobrTraslDifFinCorr( inuFinanciacion );
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
    END prTraslFinanAdeudaCorriente;

    -- Conviente un diferido en deuda corriente
    PROCEDURE prTraslDiferidoAdeudaCorriente
    (
        inuDiferido         IN  diferido.difecodi%TYPE,
        idtFechaRegistro    IN  DATE,
        inuValorAcorriente  IN  NUMBER,
        iblabono            IN  BOOLEAN,
        isbPrograma         IN  VARCHAR2,
        onuCuentaCobro      OUT cuencobr.cucocodi%TYPE,
        onuError            OUT NUMBER,
        osbError            OUT VARCHAR2
    )
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbPqt_nombre || 'prTraslDiferidoAdeudaCorriente';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        pkg_bogestion_financiacion.prIniciaVariablesGlobales;

        pkg_bogestion_financiacion.prAgregaDiferidoTraslCorriente
        (
            inuDiferido
        );

        pkg_bogestion_financiacion.prTraslDeudaDiferidaACorriente
        (
            inuValorAcorriente  ,
            idtFechaRegistro    ,
            iblabono            ,
            isbPrograma         ,
            onuError            ,
            osbError
        );

        IF onuError = 0 THEN
            onuCuentaCobro := pkg_bcfinanciacion.fnuObtCuenCobrTraslDifEnCorr( inuDiferido );
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
    END prTraslDiferidoAdeudaCorriente;


	PROCEDURE prcCreaMoviDife ( inuDiferido           in  NUMBER,
                              inuSubscriptionId     in  NUMBER,
                              inuProducto           in  NUMBER,
                              inuCuotaPagar         in  NUMBER,
                              inuValor              in  NUMBER,
                              isbSignoDife          in  VARCHAR2,
                              isbPrograma           in  diferido.difeprog%type,
                              onuError              out number,
                              osberror              out varchar2) IS

    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prcCreaMoviDife
        Descripcion     : proceso que crea movimiento de diferido
        Autor           : Luis Javier Lopez Barrios
        Fecha           : 21-01-2025

        Parametros Entrada
         inuDiferido        codigo del diferido
         inuSubscriptionId  codigo del contrato
         inuProducto        codigo del producto
         inuCuotaPagar      cuota a pagar
         inuValor           valor a pagar
         isbSignoDife       signo
         isbPrograma        programa
        Parametros de salida
          onuError   codigo del error
          osberror    mensaje del error
        Modificaciones  :
        Autor       Fecha       Caso       Descripcion
        LJLB       15-01-2025   OSF-3855    Creacion
      ***************************************************************************/
      csbMT_NAME      VARCHAR2(100) := csbPqt_nombre || '.prcCreaMoviDife';
      rcMoviDife   pkg_movidife.sbtMoviDife;
    BEGIN
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
      pkg_traza.trace(' inuDiferido => ' || inuDiferido, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' inuSubscriptionId => ' || inuSubscriptionId, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' inuProducto => ' || inuProducto, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' inuCuotaPagar => ' || inuCuotaPagar, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' inuValor => ' || inuValor, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' isbSignoDife => ' || isbSignoDife, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' isbPrograma => ' || isbPrograma, pkg_traza.cnuNivelTrzDef);
      pkg_error.prInicializaError(onuError,osbError );

      rcMoviDife.modidife := inuDiferido;
      rcMoviDife.modisusc := inuSubscriptionId;
      rcMoviDife.modisign := isbSignoDife;
      rcMoviDife.modifeca := SYSDATE;
      rcMoviDife.modicuap := inuCuotaPagar;
      rcMoviDife.modivacu := inuValor;
      rcMoviDife.modidoso := 'Ca'||inuDiferido;
      rcMoviDife.modicaca := 20;
      rcMoviDife.modifech := SYSDATE;
      rcMoviDife.modiusua := pkg_session.getUser;
      rcMoviDife.moditerm := pkg_session.fsbgetTerminal;
      rcMoviDife.modiprog := isbPrograma;
      rcMoviDife.modinuse := inuProducto;
      rcMoviDife.modidiin := 0;
      rcMoviDife.modipoin := 0;
      rcMoviDife.modivain := 0;

      -- Adiciona movimiento diferido
      pkg_movidife.prcInsertarMoviDife(rcMoviDife);
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION

      WHEN  pkg_error.CONTROLLED_ERROR then
            pkg_error.geterror(nuError,sbMensaje);
            pkg_traza.trace(' sbMensaje => ' || sbMensaje, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.CONTROLLED_ERROR;
      WHEN OTHERS then
            Pkg_Error.setError;
            pkg_error.geterror(nuError,sbMensaje);
            pkg_traza.trace(' sbMensaje => ' || sbMensaje, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.CONTROLLED_ERROR;        --}
    END prcCreaMoviDife;

	PROCEDURE prcTrasladoDifeaCorriente ( inuDiferido   IN diferido.difecodi%type,
										  inuValorTrasl IN  diferido.DIFEVATD%type,
										  inucuenta     IN  cargos.cargcuco%type,
										  inuperifact   IN  cargos.cargpefa%type,
										  onuError      OUT  NUMBER,
										  osbError      OUT  VARCHAR2) IS
	/**************************************************************************
	 Proceso     : prcTrasladoDifeCorriente
	 Autor       : Luis Javier Lopez Barrios / Horbath
	 Fecha       : 2022-11-22
	 Ticket      : OSF-688
	 Descripcion : traslado de diferido a corriente de forma manual
				   utilizar con autorizacion del grupo de validacion tecnica

	Parametros Entrada
	 inuDiferido   codigo del diferido
	 inuValorTrasl  valor a trasladar
	 inucuenta      cuenta de cobro donde se generara los cargos
	 inuperifact    periodo de facturacion
	Parametros de salida
	 onuerror  codigo de error 0 - exito -1 error
		 osbError  mensaje de error
	HISTORIA DE MODIFICACIONES
		FECHA        AUTOR       DESCRIPCION
		13/02/2025	  LJLB		  Creacion
	***************************************************************************/
    csbMT_NAME      VARCHAR2(100) := csbPqt_nombre || '.prcTrasladoDifeaCorriente';

     regDiferido  pkg_diferido.sbtRegDiferido;

     blActualNucu   BOOLEAN := FALSE;
     sbexiste VARCHAR2(1);
     rcNota           pkg_bcnotasrecord.tyrcNota;
     tbCargos         pkg_bcnotasrecord.tytbCargos;
     nuNota           notas.notanume%type;

     PROCEDURE prcValidaInfoTras IS
       csbMT_NAME1      VARCHAR2(100) := csbMT_NAME || '.prcValidaInfoTras';
     BEGIN
        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        IF inuValorTrasl <=0 THEN
          onuError := -1;
          osbError := 'El valor ingresado  ['||inuValorTrasl||'] debe ser mayor a cero';
        END IF;
        regDiferido := pkg_diferido.frcObtInfoDiferido(inuDiferido);

        IF regDiferido.difecodi IS NULL THEN
         onuError := -1;
         osbError := osbError||chr(10)||'El diferido ['||inuDiferido||'] no existe';
        END IF;

        IF regDiferido.difesape < inuValorTrasl THEN
         onuError := -1;
         osbError := 'El valor ingresado  ['||inuValorTrasl||'] no puede ser mayor al saldo del diferido ['|| regDiferido.difesape||']';
        END IF;

        IF NOT pkg_cuencobr.fblExiste(inucuenta) THEN
         onuError := -1;
         osbError := osbError||chr(10)||'Cuenta de cobro ['||inucuenta||'] no existe';
        END IF;

        IF NOT pkg_perifact.fblExisteperifact(inuperifact) THEN
         onuError := -1;
         osbError := osbError||chr(10)||'Periodo de facturacion ['||inuperifact||'] no existe';
        END IF;

        IF onuError <> 0 THEN
           Pkg_Error.SetErrorMessage(isbMsgErrr =>  osberror);
        END IF;

        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
     END prcValidaInfoTras;

   BEGIN
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
      pkg_traza.trace(' inuDiferido => ' || inuDiferido, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' inuValorTrasl => ' || inuValorTrasl, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' inucuenta => ' || inucuenta, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' inuperifact => ' || inuperifact, pkg_traza.cnuNivelTrzDef);
      pkg_error.prInicializaError(onuError,osbError );

      prcValidaInfoTras;

      IF regDiferido.difesape = inuValorTrasl THEN
         blActualNucu := true;
      END IF;

      pkg_diferido.prcActualizaSaldPendDife ( inuDiferido,
                                            inuValorTrasl,
                                            blActualNucu  );


      prcCreaMoviDife ( inuDiferido,
                       regDiferido.difesusc,
                       regDiferido.difenuse,
                       regDiferido.difecupa + 1,
                       inuValorTrasl,
                       'CR',
                       'CUSTOMER',
                        onuError,
                        osberror );
      IF onuError <> 0 THEN
         RETURN;
      END IF;
      --  CREA NOTA
        rcNota.sbPrograma:='CUSTOMER';
        rcNota.nuProducto :=regDiferido.difenuse;
        rcNota.nuCuencobr:=inucuenta;
        rcNota.nuNotacons:=70;
        rcNota.dtNotafeco:= trunc(SYSDATE);
        rcNota.sbNotaobse:= 'GENERACION DE NOTA POR PROCESO DE ABONO A DEUDA SEGUN CONSUMO';
        rcNota.sbNotaToken:= 'ND-';
        tbCargos(1).nuProducto := regDiferido.difenuse;
        tbCargos(1).nuContrato :=regDiferido.difesusc;
        tbCargos(1).nuCuencobr :=inucuenta;
        tbCargos(1).nuConcepto:=regDiferido.difeconc;
        tbCargos(1).NuCausaCargo:=20;
        tbCargos(1).nuValor:=inuValorTrasl;
        tbCargos(1).nuValorBase:=null;
   	    tbCargos(1).sbSigno :='DB';
        tbCargos(1).sbAjustaCuenta :='Y';
        tbCargos(1).sbCargdoso :='DF-'||inuDiferido;
       	tbCargos(1).sbBalancePostivo:= 'N';
      	tbCargos(1).boApruebaBal :=FALSE;
        pkg_traza.trace('Llamado api_registranotaydetalle',pkg_traza.cnuNivelTrzDef);
        api_registranotaydetalle(    rcNota,
                            tbCargos,
                            nuNota,
                            onuerror,
                            osberror    ) ;

        pkg_traza.trace(' osberror => ' || osberror, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
       EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
             pkg_error.geterror(onuerror,osberror);
            pkg_traza.trace(' sbError => ' || osberror, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        WHEN OTHERS then
            Pkg_Error.setError;
            pkg_error.geterror(onuerror,osberror);
            pkg_traza.trace(' osberror => ' || osberror, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
  END prcTrasladoDifeaCorriente;
  
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcVerificaPrioridadPlanFinan
    Descripcion     : Verifica que el plan de negociación de deuda elegido
					  sea el más prioritario o el correcto para elegir según config.
    Autor           : Jhon Erazo
    Fecha           : 21-03-2025
  
    Parametros de Entrada
		isbPrograma			Programa
		inuPlanFinanciacion	Identificador del plan de financiación
		inuContrato			Identificador del contrato
	  
    Parametros de Salida
	
  
    ModIFicaciones  :
    =========================================================
    Autor       Fecha       Caso    	Descripcion
	jerazomvm	21/03/2025	OSF-4155	Creación
	jerazomvm	04/06/2025	OSF-4535	Se ajusta para que despliegue error si el producto tiene saldos 
										pendientes con el programa GCNED y el plan seleccionado se 
										encuentra en el parametro PLANES_NO_FINANCIACION
	***************************************************************************/	
	PROCEDURE prcVerificaPrioridadPlanFinan(isbPrograma 		IN cc_financing_request.record_program%TYPE, 
										    inuPlanFinanciacion	IN cc_financing_request.financing_plan_id%TYPE,
										    inuContrato			IN suscripc.susccodi%TYPE
										    )
	IS
	
		csbMETODO		CONSTANT VARCHAR2(100) := csbPqt_nombre ||'prcVerificaPrioridadPlanFinan';
		
		nuError						NUMBER;  
		nuProduct_id				NUMBER;
		nuExisPlanNoFinanciacion	NUMBER;
		nuCantSaldoPendie			NUMBER;
		nuHoraVali 					NUMBER := pkg_parametros.fnuGetValorNumerico('HORA_NO_REGISTRO_NEGO');
		nuExistePlan_FinanMarca		NUMBER;
		nuExisteSpecialsPlan		NUMBER;
		nuCantPlanFinan				NUMBER;
		nuCantPlanFinan1			NUMBER;	
		nuSpecialPlan 				NUMBER;
		nuAno           			NUMBER;
		nuMes           			NUMBER; 
		nuCantDiferUltim12meses		NUMBER;
		nuFinanPlan     			NUMBER;	
		nuExistePlanFinanUnaVez		NUMBER;
		nuExistePlanFinanRepesca	NUMBER;
		nuCantPlanDifeRepes			NUMBER;
		sbmensaje   				VARCHAR2(2000) := pkg_parametros.fsbGetValorCadena('MENSAJE_VALIDACION_GCNED');	
		sbPrograma 					cc_financing_request.record_program%TYPE := 'GCNED';
		sbPlanEspecial 				VARCHAR2(1);
		sbFinanUnaVez   			parametros.valor_cadena%TYPE;
		sbFinanMarca    			parametros.valor_cadena%TYPE;
		sbActivRestPlCat1			parametros.valor_cadena%TYPE;
		sbActivRestPlCat2			parametros.valor_cadena%TYPE;
		sbFinanRepesca				parametros.valor_cadena%TYPE;
		dtFechaUltDia				DATE;
		dtFechaPrimero				DATE;
		dtFechaSistema				DATE := ldc_boConsGenerales.fdtGetSysDate;
		dtfechainicial      		DATE;
		dtfechafinal        		DATE;
		rcInfoProducto				pkg_bccierre_comercial.tyrcInfoCierreComer;
		
	BEGIN

		pkg_traza.trace(csbMETODO, csbNivelTraza, csbInicio);
		
		pkg_traza.trace('isbPrograma: '			|| isbPrograma 			|| CHR(10) ||
						'inuPlanFinanciacion: '	|| inuPlanFinanciacion	|| CHR(10) ||
						'inuContrato: '			|| inuContrato, csbNivelTraza);
		
		-- Obtiene el producto de la instancia
		prc_obtienevalorinstancia('WORK_INSTANCE',
								  NULL,
								  'PR_PRODUCT',
								  'PRODUCT_ID',
								  nuProduct_id
								  );
		pkg_traza.trace('nuProduct_id: ' || nuProduct_id, csbNivelTraza);

		-- Si el programa es GCNED
		IF(isbPrograma = sbPrograma) THEN	
		
			-- Valida si el producto tiene saldos pendiente con el programa GCNED
			nuCantSaldoPendie := pkg_diferido.fnuObtCantiSaldDifexProducProg(nuProduct_id,
																			 isbPrograma
																			 );
			pkg_traza.trace('nuCantSaldoPendie: ' || nuCantSaldoPendie, csbNivelTraza);																 
																			 
			-- Si el producto tiene saldos pendientes con el programa GCNED
			IF (nuCantSaldoPendie > 0) THEN
			
				-- Valida si el plan seleccionado existe en el parametro PLANES_NO_FINANCIACION 
				nuExisPlanNoFinanciacion := pkg_parametros.fnuValidaSiExisteCadena('PLANES_NO_FINANCIACION', ',', inuPlanFinanciacion);
				pkg_traza.trace('nuExisPlanNoFinanciacion: ' || nuExisPlanNoFinanciacion, csbNivelTraza);	
				
				-- Si el plan de refinanciacion seleccionado existe en parametro PLANES_NO_FINANCIACION
				IF (nuExisPlanNoFinanciacion > 0) THEN
					pkg_error.setErrorMessage(isbMsgErrr => 'El contrato ' || inuContrato || ' tiene saldo de refinanciación y el plan ' || inuPlanFinanciacion || 
															' - ' || pkg_plandife.fsbobtpldidesc(inuPlanFinanciacion) || ' seleccionado no puede ser utilizado.'
											 );

				END IF;
			END IF;			
			
			pkg_traza.trace('nuHoraVali: ' || nuHoraVali, csbNivelTraza);
		
			dtFechaUltDia 	:= TO_DATE(TO_CHAR(LAST_DAY(dtFechaSistema),'dd/mm/yyyy')||' '||nuHoraVali,'dd/mm/yyyy hh24');
			dtFechaPrimero 	:= TO_DATE('01/'||TO_CHAR(dtFechaSistema, 'MM/YYYY')||' '||nuHoraVali,'DD/MM/YYYY HH24' );
			
			pkg_traza.trace('dtFechaUltDia: ' 	|| dtFechaUltDia || CHR(10) ||
							'dtFechaPrimero: '	|| dtFechaPrimero, csbNivelTraza);
				  
			IF dtFechaUltDia < dtFechaSistema OR dtFechaSistema < dtFechaPrimero THEN
			
				-- Valida si el plan de financiación tiene plan de cartera especial
				sbPlanEspecial := pkg_ldc_confplcaes.fsbObtPlanCarteraEspecial(inuPlanFinanciacion);
				pkg_traza.trace('sbPlanEspecial: ' || sbPlanEspecial, csbNivelTraza);
					
				IF sbPlanEspecial IS NOT NULL THEN
					pkg_error.setErrorMessage(-20101, 
											  'No se puede registrar la negociacion de deuda con un plan prende la llama porque se esta ejecutando el cierre financiero'
											  );
				END IF;			  
			END IF;
			
			-- Obtiene el valor del parametro PLAN_FINAN_UNA_VEZ
			sbFinanUnaVez := pkg_parametros.fsbGetValorCadena('PLAN_FINAN_UNA_VEZ');
			pkg_traza.trace('sbFinanUnaVez: ' || sbFinanUnaVez, csbNivelTraza);
			
			-- Obtiene la cantidad del plan de financiación por contrato y plan de financiacion
			nuCantPlanFinan := pkg_bcfinanciacion.fnuObtCantidadPlanFinan(inuContrato,
																		  sbFinanUnaVez
																		  );
			pkg_traza.trace('nuCantPlanFinan: ' || nuCantPlanFinan, csbNivelTraza);

			-- Obtiene el valor del parametro 'PLAN_FINAN_MARCA'
			sbFinanMarca := pkg_parametros.fsbGetValorCadena('PLAN_FINAN_MARCA');
			pkg_traza.trace('sbFinanMarca: ' || sbFinanMarca, csbNivelTraza);

			-- Valida si el plan existe en el parametro PLAN_FINAN_MARCA 
			nuExistePlan_FinanMarca := pkg_parametros.fnuValidaSiExisteCadena('PLAN_FINAN_MARCA', ',', inuPlanFinanciacion);
			pkg_traza.trace('nuExistePlan_FinanMarca: ' || nuExistePlan_FinanMarca, csbNivelTraza);
			
			
			-- si ha tenido el plan 1 y se seleccionó uno diferente a 11 entonces no deja avanzar
			IF (nuCantPlanFinan = 1 AND nuExistePlan_FinanMarca = 0) THEN
				pkg_error.setErrorMessage(-20101, 
										  'El contrato [' || inuContrato || '] ya ha tenido una financiación con el plan(es) [' ||
										  sbFinanUnaVez ||'], solo puede usar el plan(es) [' || sbFinanMarca || ']'
										  );
			END IF;
			
			-- Obtiene la cantidad del plan de financiación por contrato y plan de financiacion
			nuCantPlanFinan1 := pkg_bcfinanciacion.fnuObtCantidadPlanFinan(inuContrato,
																		   sbFinanMarca
																		   );
			pkg_traza.trace('nuCantPlanFinan1: ' || nuCantPlanFinan1, csbNivelTraza);

			-- si es el plan 11 y se seleccionó uno diferente a 11 entonces no deja avanzar
			IF (nuCantPlanFinan1 = 1 AND nuExistePlan_FinanMarca = 0) THEN
				pkg_error.setErrorMessage(-20101, 
										  'El contrato [' || inuContrato || '] ya tiene una financiación con el plan(es) [' ||
										  sbFinanMarca || '], solo puede usar el plan(es) [' || sbFinanMarca || ']'
										  );
			END IF;

			-------------------------------------------Cambio del trigger EFIGAS(2257)--------------------------

			pkg_traza.trace('Cursor para verificar que el contrato con el plan se encuentren en la tabla LDC_SPECIALS_PLAN');
			
			-- Valida si el plan existe en el parametro SPECIALS_PLAN 
			nuExisteSpecialsPlan := pkg_bcld_parameter.fnuValidaSiExisteCadena('SPECIALS_PLAN', ',', inuPlanFinanciacion);
			pkg_traza.trace('nuExisteSpecialsPlan: ' || nuExisteSpecialsPlan, csbNivelTraza);

			IF (nuExisteSpecialsPlan > 0) THEN
			
				-- Valida si el contrato y plan de financiación, tiene planes excepcionales	
				nuSpecialPlan := pkg_ldc_specials_plan.fnuObtExisPlanEspecxContra(inuContrato, 
																				  inuPlanFinanciacion, 
																				  dtFechaSistema
																				  );
				pkg_traza.trace('nuSpecialPlan: ' || nuSpecialPlan, csbNivelTraza);																  
	  
				IF nuSpecialPlan = 0 THEN
	  
					pkg_traza.trace('El contrato ' || inuContrato || ' no se cuentra registrado con el plan ' || inuPlanFinanciacion || 
									' como plan excepcional en la tabla LDC_SPECIALS_PLAN o fecha actual no se encuentra dentro de las fechas de inicio y fin', csbNivelTraza);
					pkg_error.setErrorMessage(-20101, 
											  'El contrato ' || inuContrato || ' no se cuentra registrado con el plan ' || inuPlanFinanciacion || 
											  ' como plan excepcional en la tabla LDC_SPECIALS_PLAN o fecha actual no se encuentra dentro de las fechas de inicio y fin'
											  );
	  
				END IF;
				
			END IF;

			----------------------------------------------------------------------------
			-- se hace la lógica para obtener el plan de financiación prioritario
			-- sólo se hace si no tiene ni 1 ni 11 y a nivel de producto
			----------------------------------------------------------------------------

			dtfechainicial  := TO_DATE(TO_CHAR(ADD_MONTHS(dtFechaSistema,-12),'dd/mm/yyyy')||' 00:00:00','dd/mm/yyyy hh24:mi:ss');
			dtfechafinal    := TO_DATE(TO_CHAR(dtFechaSistema,'dd/mm/yyyy')||' 23:59:59','dd/mm/yyyy hh24:mi:ss');

			pkg_traza.trace('dtfechainicial: ' 	|| dtfechainicial || CHR(10) ||
							'dtfechafinal: '	|| dtfechafinal, csbNivelTraza);
			
			-- consultar año y mes
			pkg_bccierre_comercial.prcObtFechaHabil(nuProduct_id, 
													nuAno, 
													nuMes
													);

			pkg_traza.trace('trg_prioridad_plan_finan => nuAno: '||nuAno||' - nuMes: '||nuMes, csbNivelTraza);
			
			-- consultar informacion del producto
			pkg_bccierre_comercial.prcObtInfoProducto(nuProduct_id,
													  nuAno,
													  nuMes,
													  rcInfoProducto
													  );

			-- consulta la cantidad de financiación de los ultimos 12 meses
			nuCantDiferUltim12meses := pkg_bcfinanciacion.fnuObtCantDiferidosxProducto(nuProduct_id,
																					   dtfechainicial,
																					   dtfechafinal,
																					   sbPrograma
																					   );

			pkg_traza.trace('trg_prioridad_plan_finan => nuCantDiferUltim12meses: '||nuCantDiferUltim12meses, csbNivelTraza);

			IF (rcInfoProducto.nuproducto IS NULL) THEN
				RETURN;
			END IF;

			-- consultar el plan con mayor prioridad
			nuFinanPlan := pkg_bosegmentacioncomercial.fnuPlanFinanMayorPrioridad(rcInfoProducto.nuProducto,
																				  rcInfoProducto.nuLocalidad,
																				  rcInfoProducto.nuSegmento_predio,
																				  rcInfoProducto.nuDireccion,
																				  rcInfoProducto.nuCategoria,
																				  rcInfoProducto.nuSubcategoria,
																				  rcInfoProducto.nuEstado_corte,
																				  rcInfoProducto.nuPlan_comercial,
																				  nuCantDiferUltim12meses,
																				  rcInfoProducto.nuNro_ctas_con_saldo,
																				  rcInfoProducto.sbEstado_financiero,
																				  rcInfoProducto.nuUltimo_plan_fina
																				  );

			pkg_traza.trace('trg_prioridad_plan_finan => nuFinanPlan: '||nuFinanPlan, csbNivelTraza);

			-- Valida si el plan existe en el parametro PLAN_FINAN_UNA_VEZ 
			nuExistePlanFinanUnaVez := pkg_parametros.fnuValidaSiExisteCadena('PLAN_FINAN_UNA_VEZ', ',', inuPlanFinanciacion);
			pkg_traza.trace('nuExistePlanFinanUnaVez: ' || nuExistePlanFinanUnaVez, csbNivelTraza);
			
			-- Valida si el plan existe en el parametro PLAN_FINAN_REPESCA 
			nuExistePlanFinanRepesca := pkg_parametros.fnuValidaSiExisteCadena('PLAN_FINAN_REPESCA', ',', inuPlanFinanciacion);
			pkg_traza.trace('nuExistePlanFinanRepesca: ' || nuExistePlanFinanRepesca, csbNivelTraza);
			
			IF (inuPlanFinanciacion = NVL(nuFinanPlan,inuPlanFinanciacion) OR nuExistePlanFinanUnaVez = 1 OR nuExistePlanFinanRepesca = 1 ) THEN
				NULL;
			ELSE
				-- Obtiene el valor del parametro ACTI_REST_PL_MAY_PRI_NEG_CAT_1
				sbActivRestPlCat1 := pkg_parametros.fsbGetValorCadena('ACTI_REST_PL_MAY_PRI_NEG_CAT_1');
				pkg_traza.trace('sbActivRestPlCat1: ' || sbActivRestPlCat1, csbNivelTraza);
				
				-- Obtiene el valor del parametro ACTI_REST_PL_MAY_PRI_NEG_CAT_1
				sbActivRestPlCat2 := pkg_parametros.fsbGetValorCadena('ACTI_REST_PL_MAY_PRI_NEG_CAT_2');
				pkg_traza.trace('sbActivRestPlCat2: ' || sbActivRestPlCat2, csbNivelTraza);
			
				-- MODIFICACION PARA QUE RESTRINJA POR CATEGORIAS DEPENDIENDO DE LOS PARAMETROS CONFIGURADOS ---
				IF (rcInfoProducto.nuCategoria = 1 AND sbActivRestPlCat1 = 'N') OR
				   (rcInfoProducto.nuCategoria != 1 AND sbActivRestPlCat2 = 'N') THEN
					NULL;
				ELSE
				
					-- Obtiene el valor del parametro PLAN_FINAN_REPESCA
					sbFinanRepesca := pkg_parametros.fsbGetValorCadena('PLAN_FINAN_REPESCA');
					pkg_traza.trace('sbFinanRepesca: ' || sbFinanRepesca, csbNivelTraza);
					
					-- FIN MODIFICACION PARA QUE RESTRINJA POR CATEGORIAS DEPENDIENDO DE LOS PARAMETROS CONFIGURADOS ---
					nuCantPlanDifeRepes := pkg_plandife.fnuObtCantidadPlandifeRepesca(sbFinanRepesca);

					pkg_traza.trace('trg_prioridad_plan_finan => nuCantPlanDifeRepes: '||nuCantPlanDifeRepes, csbNivelTraza);

					IF(nuCantPlanDifeRepes = 1) THEN -- si está activo el plan repesca

						IF (nuFinanPlan IS NOT NULL) THEN

							sbMensaje   := sbMensaje||' ['||nuFinanPlan||'- '||
										   pkg_plandife.fsbobtpldidesc(nuFinanPlan)||']. ';
										   
							pkg_traza.trace('sbMensaje: '||sbMensaje, csbNivelTraza);
						END IF;

						pkg_error.setErrorMessage(-20101,sbMensaje);
					END IF;

					IF (nuFinanPlan IS NOT NULL) THEN

						sbMensaje   := sbMensaje||' ['||nuFinanPlan||'- '||
									   pkg_plandife.fsbobtpldidesc(nuFinanPlan)||']. ';
									   
						pkg_traza.trace('sbMensaje: '||sbMensaje, csbNivelTraza);
					END IF;

					pkg_error.setErrorMessage(-20101,sbMensaje);
				END IF;
				  
			END IF;
				  
		END IF;

		pkg_traza.trace(csbMETODO, csbNivelTraza, pkg_traza.csbFIN);

	EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, csbNivelTraza);
			pkg_traza.trace(csbPqt_nombre, csbNivelTraza, pkg_traza.csbFIN_ERC); 
			RAISE pkg_error.CONTROLLED_ERROR;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, csbNivelTraza);
			pkg_traza.trace(csbPqt_nombre, csbNivelTraza, pkg_traza.csbFIN_ERR); 
			RAISE pkg_Error.Controlled_Error;
	END prcVerificaPrioridadPlanFinan;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : prcObtieneValorToTalExtra 
    Descripcion     : Obtiene Valor total a pagar extra
    Autor           : Luis Felipe Valencia Hurtado
    Fecha           : 11/03/2025 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    fvalencia   11/03/2025  OSF-3846    Creacion
    ***************************************************************************/     
    PROCEDURE prcObtieneValorToTalExtra
    (   
        itbCuotaExtra       IN   pkg_bogestion_financiacion.stytFinanCuotaExtra,
        inuNumeroCuotaExtra IN  NUMBER,
        onuValorCuotaExtra    OUT NUMBER
    ) 
    IS  
        csbMetodo           CONSTANT VARCHAR2(100) := csbPqt_nombre || 'prcObtieneValorToTalExtra';        
        nuError             NUMBER;
        sbError             VARCHAR2 (4000);        
        nuIndice             NUMBER;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        onuValorCuotaExtra := 0;
        
        if (nvl(itbCuotaExtra.count, 0) = 0) then
            return;
        END if;
        
        nuIndice := itbCuotaExtra.FIRST;
        
        loop
            exit when nuIndice is null;
            
            if (itbCuotaExtra(nuIndice).ExtraPayNumber = inuNumeroCuotaExtra) then
                onuValorCuotaExtra := onuValorCuotaExtra + itbCuotaExtra(nuIndice).extraPayValue;
            END IF;
            
            nuIndice := itbCuotaExtra.next(nuIndice);
        END loop;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    EXCEPTION
        When pkg_error.CONTROLLED_ERROR then
            pkg_Error.getError(nuerror, sbError);
            pkg_traza.trace(csbMetodo ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, csbNivelTraza);             
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);    
            raise pkg_error.controlled_error;
        When others then
            pkg_error.seterror;
            pkg_Error.getError(nuerror, sbError);
            pkg_traza.trace(csbMetodo ||' Error WHEN OTHERS, sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            raise pkg_error.controlled_error;
    END prcObtieneValorToTalExtra;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : prcAgregaCuotasExtrasDiferido 
    Descripcion     : Adiciona cuotas extras a diferido
    Autor           : Luis Felipe Valencia Hurtado
    Fecha           : 11/03/2025 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    fvalencia   11/03/2025  OSF-3846    Creacion
    ***************************************************************************/      
    PROCEDURE prcAgregaCuotasExtrasDiferido
    ( 
        inuCodigoDiferido   IN diferido.difecodi%TYPE,
        inuProducto         IN diferido.difenuse%TYPE,
        inuValorDife        IN diferido.difevatd%TYPE,
        isbSigno            IN diferido.difesign%TYPE,
        isbIva              IN char,
        iblUltimoRegistro   IN BOOLEAN
    ) 
    IS    
        -- Variables Locales
        csbMetodo           CONSTANT VARCHAR2(100) := csbPqt_nombre || 'prcAgregaCuotasExtrasDiferido';        
        nuError             NUMBER;
        sbError             VARCHAR2 (4000);
        nuIdCuotaExtra      NUMBER; -- Indice de tabla Cuotras Extras
        tbgCuotaExtra       pkg_bogestion_financiacion.styttbCuotaExtra;
        tbCuotaExtra        pkg_bogestion_financiacion.stytFinanCuotaExtra;
        nugTotalCuotaExtra  cuotextr.cuexvalo%TYPE; -- Total de Cuota extras
        nugCantidadCuotaExtra      cuotextr.cuexnume%TYPE; -- Numero de Cuota extras
        cnuValorTopeAjuste      CONSTANT NUMBER := 1;
        nugValorFinTotal        diferido.difevatd%TYPE;
        nugValorFinIva          diferido.difevatd%TYPE;

        -- Acumuladores de cuotas extras por numero de cuota
        type tytbAcumCuotaExtra IS table of NUMBER index BY binary_integer;
        tbgAcumCuotaExtra tytbAcumCuotaExtra;
        ----------------------------------------------------------------------
        -- Procedimientos Encapsulados
        ----------------------------------------------------------------------     
        PROCEDURE prcCargaCuotas 
        IS        
            nuIndice    NUMBER;
            nuValorCuota cuotextr.cuexvalo%TYPE;
            rcCuotaExtra cuotextr%ROWTYPE;
            
            rcCuotasExtra mo_tyobExtraPayments;
            
            nuQuotaNumber       NUMBER;
            
            nuTotalNumeroCuotas NUMBER;
            
            nuSigno NUMBER;
            
            nuAcumCuotaExtra cuotextr.cuexvalo%type;        
        BEGIN       
            pkg_traza.trace(csbMetodo||'->prcCargaCuotas', csbNivelTraza, pkg_traza.csbINICIO);
            
            -- Se establece el signo de la cuota 
            nuSigno := 1;
            
            if (isbSigno = 'CR') then
                nuSigno := -1;
            end if;
            
            nugTotalCuotaExtra := nvl(nugTotalCuotaExtra, 0);
            nugCantidadCuotaExtra := nvl(nugCantidadCuotaExtra, 0);
            
            -- Valida si hay Valor a distribuir
            IF (nugTotalCuotaExtra = 0) THEN
            
                pkg_traza.trace('No hay cuotas extras a distribuir para el producto '||to_char(inuProducto), csbNivelTraza);
                RETURN;            
            END IF;
            
            -- Guarda como numero de diferido la posicion del diferido
            -- en el arreglo de memoria
            rcCuotaExtra.cuexdife := inuCodigoDiferido;
            rcCuotaExtra.cuexcobr := constants_per.csbNo;
            
            -- Se procesan las cuotas extra
            nuIndice := tbCuotaExtra.first;
            
            WHILE (nuIndice is not null) LOOP
           
                nuQuotaNumber := tbCuotaExtra(nuIndice).ExtraPayNumber;
                
                -- Se verifica que el valor total a financiar no sea igual al valor a financiar del IVA 
                IF (nugValorFinTotal = nugValorFinIva) THEN                
                    --  Error: Error en la configuracion de la cuota normal del diferido 
                    pkg_error.setErrorMessage( isbMsgErrr =>'El valor de la cuota extra es mayor al valor a financiar');                         
                END IF;
                
                -- Calcula el valor proporcional de cuota extra 
                nuValorCuota := tbCuotaExtra(nuIndice).ExtraPayValue;
                nuValorCuota := nuValorCuota * inuValorDife /
                          (nugValorFinTotal - nugValorFinIva);
                
                -- Se aplica la politica de redondeo sobre el valor de la cuota extra calculado 
                pkg_bogestion_facturacion.prcAplicaPoliticaAjuste(inuProducto, nuValorCuota);
                
                rcCuotaExtra.cuexvalo := nuValorCuota;
                
                -- Actualiza acumuladores por numero de cuota.
                IF tbgAcumCuotaExtra.exists(nuQuotaNumber) THEN
                    tbgAcumCuotaExtra(nuQuotaNumber) := tbgAcumCuotaExtra(nuQuotaNumber) +
                                                    nuSigno * rcCuotaExtra.cuexvalo;
                ELSE
                    tbgAcumCuotaExtra(nuQuotaNumber) := nuSigno * rcCuotaExtra.cuexvalo;
                END IF;
                
                rcCuotaExtra.cuexnume := tbCuotaExtra(nuIndice).ExtraPayNumber;
                
                -- Si se trata de la ultima cuota extra del ultimo diferido
                -- Ajusta el valor en caso de que haya diferencia
                -- respecto del acumulado.
                nuAcumCuotaExtra := tbgAcumCuotaExtra(nuQuotaNumber);
                
                IF iblUltimoRegistro THEN
                    prcObtieneValorToTalExtra(tbCuotaExtra, nuQuotaNumber, nuTotalNumeroCuotas);
                
                    IF (nuAcumCuotaExtra <> nuTotalNumeroCuotas) AND
                    (abs(nuAcumCuotaExtra - nuTotalNumeroCuotas) < cnuValorTopeAjuste) THEN
                        pkg_traza.trace('Ajuste de la cuota extra #'||nuQuotaNumber, csbNivelTraza);
                        nuValorCuota := rcCuotaExtra.cuexvalo +
                                      (nuTotalNumeroCuotas - nuAcumCuotaExtra);
                        pkg_traza.trace('Valor Cuota extra='||rcCuotaExtra.cuexvalo||'+ ('||nuTotalNumeroCuotas||'-'||nuAcumCuotaExtra ||') =>'||nuValorCuota, csbNivelTraza);
                        rcCuotaExtra.cuexvalo := nuValorCuota;
                    END IF;
                END IF;
                
                pkg_traza.trace('Numero cuota extra -> ['||to_char(nuQuotaNumber)||']', csbNivelTraza);
                pkg_traza.trace('Valor cuota extra  -> ['||to_char(rcCuotaExtra.cuexvalo)||']', csbNivelTraza);
                
                -- Carga las cuotas Cuotas extras para calculos por Diferido
                pkg_bogestion_financiacion.prcCreaCuotasExtrasDiferido(rcCuotaExtra);
                
                -- Guarda las cuotas Cuotas extras proporcionales en memoria
                rcCuotasExtra := mo_tyobExtraPayments(rcCuotaExtra.cuexdife, -- "CUEXDIFE"
                                                        rcCuotaExtra.cuexnume, -- "CUEXNUME"
                                                        rcCuotaExtra.cuexvalo, -- "CUEXVALO"
                                                        rcCuotaExtra.cuexcobr, -- "CUEXCOBR"
                                                        NULL -- "CUEXCODO"
                                                        );
                
                tbgCuotaExtra.extend;
                nuIdCuotaExtra := tbgCuotaExtra.count;
                tbgCuotaExtra(nuIdCuotaExtra) := rcCuotasExtra;
                
                nuIndice := tbCuotaExtra.next(nuIndice);           
            END LOOP;
            
            pkg_traza.trace(csbMetodo||'->prcCargaCuotas', csbNivelTraza, pkg_traza.csbFIN);        
        EXCEPTION        
            When pkg_error.CONTROLLED_ERROR then
                pkg_Error.getError(nuerror, sbError);
                pkg_traza.trace(csbMetodo ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, csbNivelTraza);             
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);    
                raise pkg_error.controlled_error;
            When others then
                pkg_error.seterror;
                pkg_Error.getError(nuerror, sbError);
                pkg_traza.trace(csbMetodo ||' Error WHEN OTHERS, sbError: ' || sbError, csbNivelTraza);
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                raise pkg_error.controlled_error;         
        END prcCargaCuotas;

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);        
        
        -- Limpia memoria de Cuotas Extras 
        pkg_bogestion_financiacion.prcLimpiaMemoriaCuotaExtra;
        
        -- Si el diferido es de IVA, no se procesa
        IF (isbIva = constants_per.csbSi) THEN
          RETURN;
        END IF;
        
        -- Calcula el valor de cada cuota extra para el diferido de manera proporcional 
        prcCargaCuotas;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);    
    EXCEPTION    
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_Error.getError(nuerror, sbError);
            pkg_traza.trace(csbMetodo ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, csbNivelTraza);             
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);    
            raise pkg_error.controlled_error;
        WHEN others THEN
            pkg_error.seterror;
            pkg_Error.getError(nuerror, sbError);
            pkg_traza.trace(csbMetodo ||' Error WHEN OTHERS, sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            raise pkg_error.controlled_error;   
    END prcAgregaCuotasExtrasDiferido;
    

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : prcCreacionDiferido 
    Descripcion     : Conviente una financiación en deuda corriente
    Autor           : Luis Felipe Valencia Hurtado
    Fecha           : 11/03/2025 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    fvalencia   11/03/2025  OSF-3846    Creacion
    ***************************************************************************/      
    PROCEDURE prcCreacionDiferido
    (   
        inuCodigoFinanciacion IN diferido.difecofi%TYPE,
        inuProducto           IN diferido.difenuse%TYPE,
        inuConceptoDiferido   IN concepto.conccodi%TYPE,
        inuValor              IN diferido.difevatd%TYPE,
        inuNumCuotas          IN diferido.difenucu%TYPE,
        inuPlanDiferido       IN diferido.difepldi%TYPE,
        inuTipoDiferido       IN diferido.difetire%TYPE,
        isbDocumento          IN diferido.difenudo%TYPE,
        isbPrograma           IN diferido.difeprog%TYPE,
        inuPorIntNominal      IN diferido.difeinte%TYPE,
        isbIva                IN VARCHAR2 DEFAULT constants_per.csbNo,
        inuPorcInteres        IN diferido.difeinte%TYPE DEFAULT NULL,
        inuTasaInte           IN diferido.difepldi%TYPE DEFAULT NULL,
        inuSpread             IN diferido.difespre%TYPE DEFAULT NULL,
        inuConcInteres        IN diferido.difecoin%TYPE DEFAULT NULL,
        isbFunciona           IN NUMBER DEFAULT NULL,
        isbSrcConceptInterest IN VARCHAR2 DEFAULT constants_per.csbNo,
        iblUltimoRegistro     IN BOOLEAN DEFAULT FALSE,
        isbSimulaDiferido     IN VARCHAR2 DEFAULT constants_per.csbSi,
        onuCodigoDiferido     OUT diferido.difecodi%TYPE
    ) 
    IS
        csbMetodo           CONSTANT VARCHAR2(100) := csbPqt_nombre || 'prcCreacionDiferido';        
        nuError             NUMBER;
        sbError             VARCHAR2 (4000);

        nuCodigoDiferido    diferido.difecodi%TYPE;
        nuContrato          servsusc.sesususc%TYPE;
        -- Obtiene usuario y terminal
        sbUser              VARCHAR2 (100) := pkg_session.getUser;
        sbTerminal          VARCHAR2 (100) := pkg_session.fsbgetTerminal;
    
        nuCodigoFinanciacion         number; --codigo de financiacion.
        nuValorDife        diferido.difevatd%TYPE; -- Valor diferido
        nuValorCuota       diferido.difevacu%TYPE; -- Valor de la cuota
        nuConcInteres      concepto.conccodi%TYPE; -- Concepto de Interes
        sbSignoDiferido        diferido.difesign%TYPE; -- Signo diferido
        nuSgOper           NUMBER(1); -- Signo operacion acumulativa
        nuLocPorcInteres   diferido.difeinte%TYPE; -- Porcentaje de interes
        nuLocPorIntNominal diferido.difeinte%TYPE; -- Porcentaje Nominal
        nuLocTasaInte      diferido.difepldi%TYPE; -- Codigo Tasa Interes
        nuLocSpread        diferido.difespre%TYPE; -- Valor del Spread
        nuValor            NUMBER;
        
        nuNumCuotas  diferido.difevacu%TYPE; -- Numero de cuotas
        blAjuste     BOOLEAN;
        nuFactAjuste NUMBER;
        nugAcumCuota   NUMBER; -- Acumulador Cuota
        nugMetodo       diferido.difemeca%TYPE; -- Metodo Cuota
        nugFactor       diferido.difefagr%TYPE; -- Factor Gradiente
        nugSpread       diferido.difespre%TYPE; -- valor del Spread
        nugPorcInteres  diferido.difeinte%TYPE; -- Interes Efectivo
        nugPorIntNominal diferido.difeinte%TYPE; -- Interes Nominal
        nugTasaInte     diferido.difetain%TYPE;
        ----------------------------------------------------------------------
        -- Procedimientos Encapsulados
        ----------------------------------------------------------------------
        /*
        Procedure : prcLlenaTablaMemoriaDiferido
        Descripcion : Llena la Tabla de memoria de Diferidos
        Fill Deferred Memory Table
        */
        PROCEDURE prcLlenaTablaMemoriaDiferido 
        IS
            rcDiferido diferido%rowtype; -- Record tabla diferido       
            nuSigno        number;
        
        BEGIN
        
            pkg_traza.trace(csbMetodo||'->prcLlenaTablaMemoriaDiferido', csbNivelTraza, pkg_traza.csbINICIO);
            
            -- Arma record diferido
            rcDiferido.difecodi := nuCodigoDiferido;
            rcDiferido.difesusc := nuContrato;
            rcDiferido.difeconc := inuConceptoDiferido;
            rcDiferido.difevatd := nuValorDife;
            rcDiferido.difevacu := nuValorCuota;
            rcDiferido.difecupa :=  0;
            rcDiferido.difenucu := nuNumCuotas;
            rcDiferido.difesape := nuValorDife;
            rcDiferido.difenudo := isbDocumento;
            rcDiferido.difeinte := nuLocPorcInteres;
            rcDiferido.difeinac := 0;
            rcDiferido.difeusua := sbUser;
            rcDiferido.difeterm := sbTerminal;
            rcDiferido.difesign := sbSignoDiferido;
            rcDiferido.difenuse := inuProducto;
            rcDiferido.difemeca := nugMetodo;
            rcDiferido.difecoin := nuConcInteres;
            rcDiferido.difeprog := isbPrograma;
            rcDiferido.difepldi := inuPlanDiferido;
            rcDiferido.difetain := nuLocTasaInte;
            rcDiferido.difespre := nuLocSpread;
            rcDiferido.difefumo := sysdate;
            rcDiferido.difefein := sysdate;
            rcDiferido.difefagr := nugFactor;
            rcDiferido.difecofi := nuCodigoFinanciacion;
            rcDiferido.difelure := null;
            rcDiferido.difefunc := isbFunciona;
            rcDiferido.difetire := inuTipoDiferido;
            
            -- Adiciona diferido
            pkg_diferido.prinsRegistro(rcDiferido);
            
            pkg_traza.trace(csbMetodo||'->prcLlenaTablaMemoriaDiferido', csbNivelTraza, pkg_traza.csbFIN); 
        EXCEPTION     
            when OTHERS then      
                pkg_error.seterror;
                raise pkg_error.controlled_error;  
        END prcLlenaTablaMemoriaDiferido;

        /*
        Procedure : prcLlenaMovimientoDiferido
        Descripcion : Llena la Tabla de memoria de Mvmto. Diferido
        Fill Transaction Deferred Memory Table
        */
        PROCEDURE prcLlenaMovimientoDiferido 
        IS
            -- Tipo de producto asociado al producto
            nuProductType servicio.servcodi%type;
            
            -- Causa de cargo para el movimiento 
            nuChargeCause cargos.cargcaca%type;
            
            rcMoviDife pkg_movidife.sbtMoviDife;
        BEGIN
            pkg_traza.trace(csbMetodo||'->prcLlenaMovimientoDiferido', csbNivelTraza, pkg_traza.csbINICIO);
            --Se obtiene el tipo de producto 
            nuProductType := pkg_bcproducto.fnuTipoProducto(inuProducto);
            
            -- Se obtiene causa de cargo para paso a diferido (43) 
            nuChargeCause := pkg_bogestion_financiacion.FnuObtCausaCargoDiferido(nuProductType);
            
            -- Arma record de movimiento de diferido
            pkg_traza.trace('Armando registro de movimiento para el diferido '||nuCodigoDiferido, csbNivelTraza);
            rcMoviDife.modidife := nuCodigoDiferido;
            rcMoviDife.modisusc := nuContrato;
            rcMoviDife.modisign := sbSignoDiferido;
            rcMoviDife.modifeca := sysdate;
            rcMoviDife.modicuap := 0;
            rcMoviDife.modivacu := nuValorDife;
            rcMoviDife.modidoso := isbDocumento;
            rcMoviDife.modicaca := nuChargeCause;
            rcMoviDife.modifech := sysdate;
            rcMoviDife.modiusua := sbUser;
            rcMoviDife.moditerm := sbTerminal;
            rcMoviDife.modiprog := isbPrograma;
            rcMoviDife.modinuse := inuProducto;
            rcMoviDife.modidiin := 0;
            rcMoviDife.modipoin := 0;
            rcMoviDife.modivain := 0;
            
            -- Adiciona movimiento diferido
            pkg_movidife.prcInsertarMoviDife(rcMoviDife);
            
            pkg_traza.trace(csbMetodo||'->prcLlenaMovimientoDiferido', csbNivelTraza, pkg_traza.csbFIN);        
        EXCEPTION        
            When pkg_error.CONTROLLED_ERROR then
                pkg_Error.getError(nuerror, sbError);
                pkg_traza.trace(csbMetodo ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, csbNivelTraza);             
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);    
                raise pkg_error.controlled_error;
            When others then
                pkg_error.seterror;
                pkg_Error.getError(nuerror, sbError);
                pkg_traza.trace(csbMetodo ||' Error WHEN OTHERS, sbError: ' || sbError, csbNivelTraza);
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                raise pkg_error.controlled_error;       
        END prcLlenaMovimientoDiferido;   
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);        
        
        pkg_traza.trace('(', csbNivelTraza);        
        pkg_traza.trace('inuCodigoFinanciacion        = '||inuCodigoFinanciacion,  csbNivelTraza);
        pkg_traza.trace('inuConceptoDiferido               = '||inuConceptoDiferido,  csbNivelTraza);
        pkg_traza.trace('inuValor              = ' || inuValor, csbNivelTraza);
        pkg_traza.trace('isbDocumento          = ' || isbDocumento, csbNivelTraza);
        pkg_traza.trace('isbPrograma           = ' || isbPrograma, csbNivelTraza);
        pkg_traza.trace('inuPorIntNominal      = ' || inuPorIntNominal, csbNivelTraza);
        pkg_traza.trace('isbIva                = ' || isbIva,  csbNivelTraza);
        pkg_traza.trace('inuPorcInteres        = ' || inuPorcInteres, csbNivelTraza);
        pkg_traza.trace('inuTasaInte           = ' || inuTasaInte, csbNivelTraza);
        pkg_traza.trace('inuSpread             = ' || inuSpread, csbNivelTraza);
        pkg_traza.trace('inuConcInteres        = ' || inuConcInteres, csbNivelTraza);
        pkg_traza.trace('isbFunciona           = ' || isbFunciona, csbNivelTraza);
        pkg_traza.trace('isbSrcConceptInterest = ' || isbSrcConceptInterest, csbNivelTraza);
        
        IF (iblUltimoRegistro) THEN
            pkg_traza.trace('iblUltimoRegistro         = TRUE',  csbNivelTraza);
        ELSE
            pkg_traza.trace('iblUltimoRegistro         = FALSE',  csbNivelTraza);
        END IF;
        
        pkg_traza.trace('isbSimulaDiferido           = ' || isbSimulaDiferido, csbNivelTraza);        
        pkg_traza.trace(')',  csbNivelTraza);

        --Obtiene el contrato asociado al producto
        nuContrato := pkg_bcproducto.fnucontrato(inuProducto);
        
        -- Obtiene proximo numero de diferido
        pkg_bogestion_financiacion.prcObtieneCodigoDiferido(nuCodigoDiferido);
        
        nuCodigoFinanciacion := inuCodigoFinanciacion;
        
        --Si el codigo de financiacion es null, se obtiene uno nuevo
        IF (nvl(nuCodigoFinanciacion, 0) = 0) THEN
            pkg_bogestion_financiacion.prcObtieneCodigoFinanciacion(nuCodigoFinanciacion);
        END IF;

        IF (nugMetodo IS NULL) THEN
            -- Asigna metodo de calculo del Plan de financiacion        
            nugMetodo := pkg_plandife.fnuObtPLDIMCCD(inuPlanDiferido);
        END IF;        
        
        IF (nugMetodo IS NULL) THEN
            -- Asigna metodo de calculo por default
            nugMetodo := pkg_paraFact.fnuObtPAFAMCDI(99);
        END IF;

        -- Configura manejo de porcentaje de interes y el spread
        pkg_bogestion_financiacion.prcObtPorcentaInteresyspread
        (
            nugMetodo,
            nugPorcInteres,
            nugSpread,
            nugPorIntNominal
        );
        nugSpread := NVL(nugSpread, 0);
        
        pkg_traza.trace('nugMetodo '||nugMetodo, csbNivelTraza);
        pkg_traza.trace('nugSpread '||nugSpread, csbNivelTraza);
        -- Valida el Factor Gradiente        
        pkg_bogestion_financiacion.prcObtFactorGradiente
        (
            inuPlanDiferido,
            nugMetodo,
            nvl(nugPorcInteres,0) + nvl(nugSpread,0),
            inuNumCuotas,
            nugFactor
        );

        -- Valida si el plan existe en BD
        nugTasaInte := pkg_plandife.fnuObtPLDITAIN(inuPlanDiferido);
               
        
        -- Averigua si se trata de un concepto de Interes
        IF (nvl(isbSrcConceptInterest, constants_per.csbNo) = constants_per.csbYes) then       
            pkg_traza.trace('Se detecto concepto de interes, el interes para el diferido sera CERO', csbNivelTraza);
            nuLocPorcInteres   := 0;
            nuLocTasaInte      := nugTasaInte;
            nuLocSpread        := 0;
            nuLocPorIntNominal := 0;       
        else        
            nuLocPorcInteres   := nvl(inuPorcInteres, nugPorcInteres);
            nuLocTasaInte      := nvl(inuTasaInte, nugTasaInte);
            nuLocSpread        := nvl(inuSpread, nugSpread);
            nuLocPorIntNominal := inuPorIntNominal;       
        end if;
        
        -- Valor a diferir
        nuValorDife := abs(inuValor);
        
        -- Evalua si no hay valor a diferir
        if (nuValorDife = 0) then       
            pkg_traza.trace('Valor del diferido CERO, no sera creado', csbNivelTraza);        
            
            return;      
        end if;
        
        -- Establecer signo con el que se debe generar el diferido
        sbSignoDiferido := pkg_bogestion_financiacion.fsbObtieneSignoDiferido(inuValor);
        
        -- Obtiene concepto de interes asociado al concepto
        -- solo si el parametro de concepto de interes es nulo
        if (inuConcInteres is NULL) then
            nuConcInteres := pkg_Concepto.fnuObtCONCCOIN(inuConceptoDiferido);
        else
            nuConcInteres := inuConcInteres;
        end if;
        
        -- Valida el concepto de Interes
        pkg_concepto.prValExiste(nuConcInteres);
        
        -- Determina el porcentaje de Interes de acuerdo al codigo del
        -- Concepto de Interes configurado
        if (nuConcInteres = -1) then      
            nuLocPorcInteres   := 0;
            nuLocTasaInte      := nugTasaInte;
            nuLocSpread        := 0;
            nuLocPorIntNominal := 0;        
        end if;
        
        -- Adiciona cuotas extras a los diferidos que no corresponden
        -- a conceptos IVA
        prcAgregaCuotasExtrasDiferido
        (   
            nuCodigoDiferido,
            inuProducto,
            nuValorDife,
            sbSignoDiferido,
            isbIva,
            iblUltimoRegistro
        );
        
        -- Se modifica DIFENUCU para valores menores al Valor Ajuste
        nuNumCuotas := inuNumCuotas;
        pkg_bogestion_facturacion.prcObtienePoliticaAjuste(
                                                                nuContrato,
                                                                blAjuste,
                                                                nuFactAjuste
                                                            );
        
        if (nuValorDife <= nuFactAjuste) then
            nuNumCuotas  := 1;
            nuValorCuota := nuValorDife;
        end if;
        
        -- Calcula el valor de la cuota
        pkg_bogestion_financiacion.prcCalculaValorCuota
        (
            nuValorDife,
            nuNumCuotas,
            nuLocPorIntNominal,
            nuLocPorcInteres,
            nuLocSpread,
            nugMetodo,
            nugFactor,
            nuValorCuota
        );
        
        pkg_traza.trace('nuLocPorcInteres: ' || nuLocPorcInteres, csbNivelTraza);
        pkg_traza.trace('nuLocSpread: ' || nuLocSpread,  csbNivelTraza);
        pkg_traza.trace('nugMetodo: ' || nugMetodo,  csbNivelTraza);
        pkg_traza.trace('nugFactor: ' || nugFactor,  csbNivelTraza);
        pkg_traza.trace('nuValorCuota: ' || nuValorCuota,  csbNivelTraza);
        pkg_traza.trace('Diferido: ' || nuValorDife,  csbNivelTraza);
        
        -- Valida el valor de la cuota con respecto a los intereses de la
        -- primera cuota
        pkg_traza.trace('Validando cuota < intereses primera cuota...', csbNivelTraza);
        nuValor := nuValorDife;
        
        pkg_traza.trace('? Cuota < Primer Interes ? => ? '||nuValorCuota||' < '||to_char(nuValor * nuLocPorIntNominal/100)||' ?', csbNivelTraza);
        pkg_bogestion_financiacion.prcValidaValorCuota(nugMetodo,
                                 nuLocPorIntNominal,
                                 nuValorCuota,
                                 nuValor);
        
        -- Se aplica la politica de redondeo sobre el valor de la cuota 
        pkg_bogestion_facturacion.prcAplicaPoliticaAjuste(inuProducto, nuValorCuota);
        
        -- Se incluye esta modificacion para tener en cuenta los valores de
        -- cuotas que despues del redondeo son cero para que queden en una cuota
        if (nuValorCuota = 0) then        
            nuNumCuotas  := 1;
            nuValorCuota := nuValorDife;        
        end if;
        
        -- Adiciona diferido a tabla en memoria
        prcLlenaTablaMemoriaDiferido;
        
        -- Actualiza acumuladores
        nuSgOper := 1;
        
        -- Evalua si el signo del diferido es credito
        if (sbSignoDiferido = 'CR') then
            nuSgOper := -1;
        end if;
        
        -- Acumula valor de la cuota
        nugAcumCuota := nugAcumCuota + (nuValorCuota * nuSgOper);
        
        -- Adiciona movimiento de diferido a tabla en memoria
        prcLlenaMovimientoDiferido;

        -- asigna el numero de diferido a variable de paquete
        onuCodigoDiferido := nuCodigoDiferido;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    
    EXCEPTION    
        When pkg_error.CONTROLLED_ERROR then
            pkg_Error.getError(nuerror, sbError);
            pkg_traza.trace(csbMetodo ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, csbNivelTraza);             
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);    
            raise pkg_error.controlled_error;
        When others then
            pkg_error.seterror;
            pkg_Error.getError(nuerror, sbError);
            pkg_traza.trace(csbMetodo ||' Error WHEN OTHERS, sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            raise pkg_error.controlled_error;   
    END prcCreacionDiferido;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : prcObtienePorcRecargoMora 
    Descripcion     : Obtiene porcentaje de mora
    Autor           : Luis Felipe Valencia Hurtado
    Fecha           : 11/03/2025 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    fvalencia   11/03/2025  OSF-3846    Creacion
    ***************************************************************************/   
    PROCEDURE prcObtienePorcRecargoMora 
    ( 
        inuPlandiferiodo    IN plandife.pldicodi%TYPE,
        onuPorcentajeMora OUT NUMBER
    ) 
    IS
        csbMetodo           CONSTANT VARCHAR2(100) := csbPqt_nombre || 'prcObtienePorcRecargoMora';        
        nuError              NUMBER;
        sbError              VARCHAR2 (4000);
        cnuMalPorcentajeMora CONSTANT NUMBER(6) := 120782;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        onuPorcentajeMora := pkg_plandife.fnuObtPLDIPRMO(inuPlandiferiodo);
        onuPorcentajeMora := nvl(onuPorcentajeMora, 0);
        
        if onuPorcentajeMora not between 0 AND 100 then
            -- El porcentaje de mora configurado en el plan de financiacion (%s1) no es correcto
            pkg_error.setErrorMessage(cnuMalPorcentajeMora, inuPlandiferiodo);            
        END if;        
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    EXCEPTION
        When pkg_error.CONTROLLED_ERROR then
            pkg_Error.getError(nuerror, sbError);
            pkg_traza.trace(csbMetodo ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, csbNivelTraza);             
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);    
            raise pkg_error.controlled_error;
        When others then
            pkg_error.seterror;
            pkg_Error.getError(nuerror, sbError);
            pkg_traza.trace(csbMetodo ||' Error WHEN OTHERS, sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            raise pkg_error.controlled_error;
    END prcObtienePorcRecargoMora;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : prcGenerarDiferido 
    Descripcion     : Gerenera diferido
    Autor           : Luis Felipe Valencia Hurtado
    Fecha           : 11/03/2025 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    fvalencia   11/03/2025  OSF-3846    Creacion
    ***************************************************************************/   
    PROCEDURE prcGenerarDiferido 
    (
        inuProducto         IN  diferido.difenuse%TYPE,
        inuConcepto         IN  diferido.difeconc%TYPE,
        inuValor            IN  diferido.difevatd%TYPE,
        inuPlanDiferido     IN  diferido.difepldi%TYPE,
        inuCantidadCuotas   IN  diferido.difenucu%TYPE,
        ionuCodigoFinan      IN OUT  diferido.difecofi%TYPE,
        isbdifedoso         IN  diferido.difenudo%TYPE,
        isbPrograma         IN  diferido.difeprog%TYPE,
        onuDiferido         OUT  diferido.difecodi%TYPE
    ) 
    IS   
        csbMetodo   CONSTANT VARCHAR2(100) := csbPqt_nombre || 'prcGenerarDiferido';        
        nuError     NUMBER;
        sbError     VARCHAR2 (4000);
    
        rcPlandiferido          pkg_PLANDIFE.cuRegistroRId%rowtype;        
        nuCodigoFinanciacion    diferido.difecofi%TYPE;
        nuMetodoCalculo         plandife.pldimccd%TYPE;
        nuMetodo                plandife.pldimccd%TYPE;
        nuCodigoTasa            plandife.plditain%TYPE;
        nuPorcInteres           plandife.pldipoin%TYPE;
        blSpread                BOOLEAN;
        nuCodigoFuncionario         NUMBER;        
        nuConcInteres           diferido.difecoin%TYPE;
        nuConceptoDiferido      diferido.difeconc%type;
        nuTasaUsura             conftain.cotiporc%TYPE;
        nuTasaUsuaraMes         NUMBER;

        ----------------------------------------------------------------------
        -- Procedimientos Encapsulados
        ----------------------------------------------------------------------     
        FUNCTION fnuObtFuncionarioBaseDatos
        RETURN NUMBER
        IS        
            sbUsuarioBaseDatos VARCHAR2 (30);
            rcFunciona     Funciona%rowtype;        
        BEGIN        
            pkg_traza.trace(csbMetodo||'->fnuObtFuncionarioBaseDatos', csbNivelTraza, pkg_traza.csbINICIO);
            
            --Obtiene usuario de base de datos
            sbUsuarioBaseDatos := pkg_session.getUser;
            
            --Obtiene record del funcionario asociado al usuario de la base de datos
            rcFunciona := pkg_session.frcObtFunciona(sbUsuarioBaseDatos);
            
            pkg_traza.trace(csbMetodo||'->fsbGetFuncionaDataBase', csbNivelTraza, pkg_traza.csbFIN);
            
            return rcFunciona.funccodi;
            
        EXCEPTION        
            When pkg_error.CONTROLLED_ERROR then
                pkg_Error.getError(nuerror, sbError);
                pkg_traza.trace(csbMetodo ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, csbNivelTraza);             
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);    
                raise pkg_error.controlled_error;
            When others then
                pkg_error.seterror;
                pkg_Error.getError(nuerror, sbError);
                pkg_traza.trace(csbMetodo ||' Error WHEN OTHERS, sbError: ' || sbError, csbNivelTraza);
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
                raise pkg_error.controlled_error;     
        END fnuObtFuncionarioBaseDatos;
           
    BEGIN    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        --  Obtiene la informacion del plan de financiacion
        rcPlandiferido := pkg_plandife.frcObtRegistroRId(inuPlanDiferido);
        
        -- se busca concepto de financiacion
        BEGIN
            nuConceptoDiferido := pkg_concepto.fnuObtCONCCORE(inuConcepto);
        EXCEPTION 
            WHEN others THEN
                nuConceptoDiferido := inuConcepto;
        END;
        
        IF NVL(nuConceptoDiferido,-1) = -1 THEN 
            nuConceptoDiferido := inuConcepto; 
        END IF;
        
        nuCodigoFinanciacion := ionuCodigoFinan;
        -- Se asigna el consecutivo de financiacion
        IF nuCodigoFinanciacion = 0 THEN
            pkg_bogestion_financiacion.prcObtieneCodigoFinanciacion(nuCodigoFinanciacion);
            ionuCodigoFinan := nuCodigoFinanciacion;
        END IF;       
        
        -- Obtiene tasa de interes
        pkg_bogestion_financiacion.prcObtConfigPlanDiferido
        (
            rcPlandiferido.pldicodi,
            sysdate, 
            nuMetodoCalculo,
            nuCodigoTasa,
            nuPorcInteres,
            blSpread
        );        


        --Obtiene el funcionario asociado al usuario de la base de datos
        nuCodigoFuncionario := fnuObtFuncionarioBaseDatos; 
        
        nuConcInteres := pkg_Concepto.fnuObtCONCCOIN(nuConceptoDiferido);
        
        nuTasaUsura     := pkg_bcfinanciacion.fnuObtienePorcInteresUsura;

        nuTasaUsuaraMes := (power(1 + (nuTasaUsura/100), 1/12) - 1)*100;   
        -- Crea diferido para el ultimo concepto de financiacion procesado
        prcCreacionDiferido
        ( 
            nuCodigoFinanciacion, -- Cod.Financiacion
            inuProducto,  -- Producto
            nuConceptoDiferido, -- Concepto
            inuValor, -- Valor
            inuCantidadCuotas, -- Cuotas
            inuPlanDiferido, --Pla de diferido
            'D', --Tipo de diferido
            isbdifedoso, -- sbDocumento, -
            isbPrograma, -- Programa
            nvl(nuTasaUsuaraMes,0), -- nugPorIntNominal
            constants_per.csbNo, -- isbIva -
            nvl(nuPorcInteres,0), -- inuPorcInteres -- porcentaje de interes
            nuCodigoTasa, -- inuTasaInte
            NULL, -- inuSpread
            nuConcInteres, -- inuConcInteres Lo obtiene a partir del concepto Origen
            nuCodigoFuncionario,
            constants_per.csbNo, -- sbIsInterestConcept,
            FALSE, -- blLastRecord,
            constants_per.csbNo,
            onuDiferido
        ); 
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    
    EXCEPTION 
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_Error.getError(nuerror, sbError);
            pkg_traza.trace(csbMetodo ||' Error WHEN CONTROLLED_ERROR, sbError: ' || sbError, csbNivelTraza);             
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);    
            raise pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.seterror;
            pkg_Error.getError(nuerror, sbError);
            pkg_traza.trace(csbMetodo ||' Error WHEN OTHERS, sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            raise pkg_error.controlled_error;
    END prcGenerarDiferido;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : prObtCondFinanxProducto 
    Descripcion     : Obtiene condiciones de financiacion por producto
					  
    Autor           : Paola Acosta
    Fecha           : 13/05/2025
	
    Modificaciones  :
    Autor           Fecha       	Caso        Descripcion
    Paola.Acosta	13/05/2025   	OSF-4336    Creacion
    ***************************************************************************/    
    PROCEDURE prObtCondFinanxProducto
    (
      inuIdOrden     IN  or_order.order_id%TYPE,
      inuIdSolicitud IN  mo_packages.package_id%TYPE,
      onuIdPlanFinan OUT plandife.pldicodi%TYPE,
      onuNumCuotas   OUT plandife.pldicuma%TYPE)
    IS
        --Constantes
        csbMtd_nombre CONSTANT VARCHAR2(70) := csbPqt_nombre || 'prObtCondFinanxProducto';
        cnuActRecAcom CONSTANT ld_parameter.numeric_value%type := pkg_bcld_parameter.fnuObtieneValorNumerico('LDC_ACT_RECONE_ACOM');
        cnuActRecCM   CONSTANT ld_parameter.numeric_value%type := pkg_bcld_parameter.fnuObtieneValorNumerico('LDC_ACT_RECONE_CM');

        
        --Variables
        nuMenorIdActividad  or_order_activity.order_activity_id%type;
        nuIdActividad       ge_items.items_id%type;
        nuValorOrden        or_order.order_value%type := 0;
        nuIdProducto        or_order_activity.product_id%type;
        nuIdDireccion       pr_product.address_id%type;
        nuIdBarrio          ab_address.neighborthood_id%type;        
        sbLocalizacion      VARCHAR2(2000);
        nuUbicacionGeo      ab_address.geograp_location_id%type;
        nuDepto             ab_address.geograp_location_id%type;
        nuPais              ab_address.geograp_location_id%type;
        nuIdCategoria       servsusc.sesucate%type;
        nuIdSubcategoria    servsusc.sesusuca%type;        
        nuValReconexion     NUMBER;
        rcCondFinan         pkg_ldc_finan_cond.cuCondFinan%ROWTYPE := NULL;
        
    BEGIN
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbInicio); 
        
        --Obtener actividad principal de la ot
        nuMenorIdActividad := pkg_bcordenes.fnuObtMenorIdActividad(inuIdOrden);
        pkg_traza.trace('nuMenorIdActividad: '||nuMenorIdActividad, csbNivelTraza); 
        
        nuIdActividad := pkg_or_order_activity.fnuObtActivity_id(nuMenorIdActividad);
        pkg_traza.trace('nuIdActividad: '||nuIdActividad, csbNivelTraza); 
        
        --Obtener valor de la ot a financiar
        nuValorOrden := NVL(pkg_or_order.fnuObtOrder_value(inuIdOrden),0);
        pkg_traza.trace('nuValorOrden: '||nuValorOrden, csbNivelTraza); 
        
        --Si valor de la orden = 0, obtiene el valor de los items
        IF nuValorOrden= 0 THEN
            nuValorOrden := NVL(pkg_or_order_items.fnuObtValorOrden(inuIdOrden),0);
            pkg_traza.trace('nuValorOrden: '||nuValorOrden, csbNivelTraza); 
        END IF;
        
        --Si valor de los items = 0, obtiene el valor de la actividad principal
        IF nuValorOrden= 0 THEN
            nuValorOrden := NVL(pkg_ge_unit_cost_ite_lis.fnuObtCostoItem(nuIdActividad),0);
            pkg_traza.trace('nuValorOrden: '||nuValorOrden, csbNivelTraza); 
        END IF;
        
        --Obtener el producto
        nuIdProducto := pkg_or_order_activity.fnuObtProducto(inuIdOrden);
        pkg_traza.trace('nuIdProducto: '||nuIdProducto, csbNivelTraza); 
        
        --Obener la direccion del producto
        nuIdDireccion := pkg_bcProducto.fnuIdDireccInstalacion(nuIdProducto);
        pkg_traza.trace('nuIdDireccion: '||nuIdDireccion, csbNivelTraza); 
        
        --Obtener el barrio
        nuIdBarrio := pkg_bcDirecciones.fnuGetBarrio(nuIdDireccion);
        pkg_traza.trace('nuIdBarrio: '||nuIdBarrio, csbNivelTraza);
        
        sbLocalizacion := nuIdBarrio || ',';
        pkg_traza.trace('sbLocalizacion: '||sbLocalizacion, csbNivelTraza);
        
        --Obtener la localidad
        nuUbicacionGeo := pkg_bcDirecciones.fnuGetLocalidad(nuIdDireccion);
        pkg_traza.trace('nuUbicacionGeo: '||nuUbicacionGeo, csbNivelTraza);
        
        sbLocalizacion := sbLocalizacion||nuUbicacionGeo||',';
        pkg_traza.trace('sbLocalizacion: '||sbLocalizacion, csbNivelTraza);
                
        --Obtener el Depto
        nuDepto:= pkg_bcDirecciones.fnuGetUbicaGeoPadre(nuUbicacionGeo);
        pkg_traza.trace('nuDepto: '||nuDepto, csbNivelTraza);
        
        sbLocalizacion := sbLocalizacion||nuDepto||',';
        pkg_traza.trace('sbLocalizacion: '||sbLocalizacion, csbNivelTraza);
        
        --Obtener Pais
        nuPais := pkg_bcDirecciones.fnuGetUbicaGeoPadre(nuDepto);
        pkg_traza.trace('nuPais: '||nuPais, csbNivelTraza);
        
        sbLocalizacion := sbLocalizacion||nuPais;
        pkg_traza.trace('sbLocalizacion: '||sbLocalizacion, csbNivelTraza);
        
        --Obtener categiria
        nuIdCategoria := pkg_bcProducto.fnuCategoria(nuIdProducto);
        pkg_traza.trace('nuIdCategoria: '||nuIdCategoria, csbNivelTraza);
        
        --Obtener subCategoria
        nuIdSubcategoria := pkg_bcProducto.fnuSubcategoria(nuIdProducto);
        pkg_traza.trace('subCategoria: '||nuIdSubcategoria, csbNivelTraza);
        
        nuValReconexion := pkg_bcordenes.fnuValReconexion(nuIdProducto, inuIdSolicitud);
        pkg_traza.trace('nuValReconexion: '||nuValReconexion, csbNivelTraza);
        
        pkg_traza.trace('IF nuIdActividad: '||nuIdActividad||' = '||'cnuActRecAcom: '||cnuActRecAcom, csbNivelTraza);
        pkg_traza.trace('AND nuValReconexion: '||nuValReconexion||' > 0', csbNivelTraza);
        
        IF nuIdActividad = cnuActRecAcom AND nuValReconexion > 0  THEN
            
            nuIdActividad := cnuActRecCM;
            --Busca si existe un criterio que coincida con la ubicacion geografica, categoria y subcategoria del producto
            rcCondFinan := pkg_ldc_finan_cond.frcObtCondFinanciacion(nuIdActividad, 
                                                                     sbLocalizacion,
                                                                     nuIdCategoria,
                                                                     nuIdSubcategoria,
                                                                     nuValorOrden);             
            pkg_traza.trace('rec_finan_cond_id: '||rcCondFinan.rec_finan_cond_id, csbNivelTraza);                                                                  
                                                                     
            IF rcCondFinan.rec_finan_cond_id IS NULL THEN  
                --Se busca configuracion por ubicacion geografica y Categoria
                rcCondFinan := pkg_ldc_finan_cond.frcObtCondFinanciacion(nuIdActividad, 
                                                                         sbLocalizacion,
                                                                         nuIdCategoria,
                                                                         -1,
                                                                         nuValorOrden);
                pkg_traza.trace('cate: -1, rec_finan_cond_id: '||rcCondFinan.rec_finan_cond_id, csbNivelTraza);   
                
                IF rcCondFinan.rec_finan_cond_id IS NULL THEN  
                    --Se busca configuracion por ubicacion geografica
                    rcCondFinan := pkg_ldc_finan_cond.frcObtCondFinanciacion(nuIdActividad, 
                                                                             sbLocalizacion,
                                                                             -1,
                                                                             -1,
                                                                             nuValorOrden);
                    pkg_traza.trace('cate: -1, subcate: -1, rec_finan_cond_id: '||rcCondFinan.rec_finan_cond_id, csbNivelTraza);   
                    
                END IF;                                                                         
            END IF;
            
            --Si el registro no es nulo se asignan condiciones de Financiacion
            IF rcCondFinan.rec_finan_cond_id IS NOT NULL THEN
                onuIdPlanFinan := rcCondFinan.finan_plan_id;
                onuNumCuotas := rcCondFinan.quotas_number;
            END IF;
        
        ELSE   
            pkg_traza.trace('ELSE', csbNivelTraza);
            --Busca si existe un criterio que coincida con la ubicacion geografica, categoria y subcategoria del producto
            rcCondFinan := pkg_ldc_finan_cond.frcObtCondFinanciacion(nuIdActividad, 
                                                                     sbLocalizacion,
                                                                     nuIdCategoria,
                                                                     nuIdSubcategoria,
                                                                     nuValorOrden);
            pkg_traza.trace('rec_finan_cond_id: '||rcCondFinan.rec_finan_cond_id, csbNivelTraza);                                                                      
                                                                     
            IF rcCondFinan.rec_finan_cond_id IS NULL THEN  
                --Se busca configuracion por ubicacion geografica y Categoria
                rcCondFinan := pkg_ldc_finan_cond.frcObtCondFinanciacion(nuIdActividad, 
                                                                         sbLocalizacion,
                                                                         nuIdCategoria,
                                                                         -1,
                                                                         nuValorOrden);
                pkg_traza.trace('cate: -1, rec_finan_cond_id: '||rcCondFinan.rec_finan_cond_id, csbNivelTraza);   
                
                IF rcCondFinan.rec_finan_cond_id IS NULL THEN  
                    --Se busca configuracion por ubicacion geografica
                    rcCondFinan := pkg_ldc_finan_cond.frcObtCondFinanciacion(nuIdActividad, 
                                                                             sbLocalizacion,
                                                                             -1,
                                                                             -1,
                                                                             nuValorOrden);
                    pkg_traza.trace('cate: -1, subcate: -1, rec_finan_cond_id: '||rcCondFinan.rec_finan_cond_id, csbNivelTraza);
                    
                END IF;                                                                         
            END IF; 
            
             --Si el registro no es nulo se asignan condiciones de Financiacion
            IF rcCondFinan.rec_finan_cond_id IS NOT NULL THEN
                onuIdPlanFinan := rcCondFinan.finan_plan_id;
                onuNumCuotas := rcCondFinan.quotas_number;
            END IF;            
        END IF;        
        
        pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin);
        
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: '||nuError || ' sbMensaje: '||sbMensaje, csbNivelTraza);
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_erc); 
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: '||nuError || ' sbMensaje: '||sbMensaje, csbNivelTraza);
            pkg_traza.trace(csbMtd_nombre, csbNivelTraza, csbFin_err); 
            RAISE pkg_error.controlled_error;
    END prObtCondFinanxProducto; 
    
END pkg_bofinanciacion;
/

Prompt Otorgando permisos sobre personalizaciones.pkg_bofinanciacion
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('pkg_bofinanciacion'), upper('personalizaciones'));
END;
/
