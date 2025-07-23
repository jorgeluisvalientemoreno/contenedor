CREATE OR REPLACE PACKAGE ADM_PERSON.pkg_bogestion_financiacion
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> pkg_bogestion_financiacion </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 24-12-2024 </Fecha>
    <Descripcion> 
        Logica de gestión de financiación
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="24-12-2024" Inc="OSF-3801" Empresa="GDC">
               Creación
           </Modificacion>
           <Modificacion Autor="Jose.Pineda" Fecha="07-02-2025" Inc="OSF-3893" Empresa="GDC">
               Creación de prIniciaVariablesGlobales, prAgregaDifCobrFinanciacion,
               prTraslDeudaDiferidaACorriente, prAgregaDiferidoTraslCorriente
           </Modificacion>
           <Modificacion Autor="Jose.Pineda" Fecha="05-03-2025" Inc="OSF-4042" Empresa="GDC">
               Creación de prcCalculaCuotaDiferido
           </Modificacion> 
           <Modificacion Autor="Paola.Acosta" Fecha="23-04-2025" Inc="OSF-4293" Empresa="GDC">
               Creacion metodos fnuObtDeudaVencidaProd, fnuObtDeudaProd y variables globales
           </Modificacion>
            <Modificacion Autor="felipe.valencia" Fecha="11-03-2025" Inc="OSF-3846" Empresa="EFG">
                Se realiza la creación de los siguientes procedimientos y funciones prcObtieneCodigoDiferido
                prcObtieneCodigoFinanciacion, fsbObtieneSignoDiferido, prcCalculaValorCuota
                prcValidaValorCuota, prcObtPorcentaInteresyspread, prcObtFactorGradiente, FnuObtCausaCargoDiferido
            </Modificacion>   
            <Modificacion Autor="Paola.Acosta" Fecha="13-05-2025" Inc="OSF-4336" Empresa="GDC">
               Creacion metodo fnuObtenerTasaInteres
           </Modificacion>            
     </Historial>
     </Package>
    ******************************************************************/

    SUBTYPE stytFinanCuotaExtra IS cc_bcfinancing.tytbExtraPayment;
    SUBTYPE styttbCuotaExtra IS mo_tytbextrapayments;
    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------


    /**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 24-12-2024 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
            <Modificacion Autor="Jhon.Erazo" Fecha="24-12-2024" Inc="OSF-3801" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2;
	
	/**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fnuobtvalorsaldocastigado </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 24-12-2024 </Fecha>
    <Descripcion> 
		Obtiene el valor del saldo castigado
    </Descripcion>
	<Parametros> 
        Entrada:
			inuProductId Identificador del producto
			
		Salida:
			nuValorSaldoCastigado 	valor saldo castigado
			
    </Parametros>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="24-12-2024" Inc="OSF-3801" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fnuobtvalorsaldocastigado(inuProductId	IN pr_product.product_id%type) 
	RETURN NUMBER;
	
	-- Financia una solicitud
	PROCEDURE prcFinanciarPorSolicitud(inuSolicitud NUMBER);

    --Calcula la cuota del diferido
    PROCEDURE prcCalculaCuotaDiferido(inuDiferido         IN NUMBER,
                                    inuContrato         IN NUMBER,
                                    inuSaldo            IN NUMBER,
                                    inuCuotas           IN NUMBER,
                                    inuCuotasFacturadas IN NUMBER,
                                    inuPlanDiferido     IN NUMBER,
                                    inuMetodo           IN NUMBER,
                                    inuTasaInteres      IN NUMBER,
                                    inuPorcentaje       IN NUMBER,
                                    inuFactor           IN NUMBER,
                                    inuSpread           IN NUMBER);
	
    -- Inicializa variables globales del proceso de diferido a corriente
    PROCEDURE prIniciaVariablesGlobales;

    -- Agrega un diferido al traslado a corriente para cobro de financiacion
    PROCEDURE prAgregaDifCobrFinanciacion
    (
        inuProducto         IN  diferido.difenuse%TYPE,
        inuFinanciacion     IN  diferido.difecofi%TYPE,
        idtFechaRegistro    IN  DATE,
        isbDocumento        IN  diferido.difenudo%TYPE
    );

    -- Traslada deuda diferida a deuda corriente    
    PROCEDURE prTraslDeudaDiferidaACorriente
    (
        inuValorAcorriente  IN  NUMBER,
        idtFechaRegistro    IN  DATE,
        iblabono            IN  BOOLEAN,
        isbPrograma         IN  VARCHAR2,
        onuError            OUT NUMBER,
        osbError            OUT VARCHAR2
    );
    
    -- Agrega un diferido para convertirlo en deuda corriente
    PROCEDURE prAgregaDiferidoTraslCorriente
    (
        inudiferido         IN  diferido.difecodi%TYPE
    );	
	
    --Consulta la deuda vencida asociado a un producto
    FUNCTION fnuObtDeudaVencidaProd(inuIdProducto IN NUMBER)
    RETURN NUMBER;
    
    --Consulta la deuda deuda Corriente (Vencida y No vencida) de un producto
    FUNCTION fnuObtDeudaProd(inuIdProducto IN NUMBER)
    RETURN NUMBER;
    
   --Obtiene codigo del diferido
    PROCEDURE prcObtieneCodigoDiferido
    ( 
        onuCodigoDiferido	OUT	diferido.difecodi%TYPE
    );

    --Obtiene el consecutivo de financiacion
    PROCEDURE prcObtieneCodigoFinanciacion
    ( 
        onuCodigoFinanciacion	OUT	diferido.difecofi%TYPE
    );

    --Obtiene el signo con el que se debe generar el diferido
    FUNCTION fsbObtieneSignoDiferido
    (
        inuValorDiferido	IN	diferido.difevatd%TYPE
    ) 
	RETURN VARCHAR2;
    --Calcula el valor de la cuota
    PROCEDURE prcCalculaValorCuota
    ( 
        inuValorDiferido    IN	diferido.difevatd%TYPE,
        inuNumeroCuotas	    IN	diferido.difenucu%TYPE,
        inuInteresNominal	IN	diferido.difeinte%TYPE,
        inuInteresEfectivo	IN	diferido.difeinte%TYPE,
        inuspread		    IN	diferido.DIFESPRE%TYPE,
        inuMetodo		    IN	diferido.difemeca%TYPE,
        inuFactor		    IN	diferido.difefagr%TYPE,
        onuValorCuota	    OUT	diferido.difevacu%TYPE
    );

    --Valida la cuota con respecto al valor del interes de la primera cuota
    PROCEDURE prcValidaValorCuota
    (
        inuMetodo		    IN	diferido.difemeca%TYPE,
        inuPorcentajeInteres IN	diferido.difeinte%TYPE,
        inuValorCuota       IN	diferido.difevacu%TYPE,
        inuValorDiferido    IN	diferido.difevatd%TYPE
    );

    --Obtiene configuración de plan de diferido
    PROCEDURE prcObtConfigPlanDiferido
    (
        inuPlanDiferido	        IN	plandife.pldicodi%TYPE,
        idtFechaInicioVigencia	IN 	plandife.pldifein%TYPE,
        onuMetodoCalculo	    OUT	plandife.pldimccd%TYPE,
        onuCodigoTasa	        OUT	plandife.plditain%TYPE,
        onuPorcInteres	        OUT	plandife.pldipoin%TYPE,
        oblspread	            OUT	BOOLEAN
    );

    --Obtiene Tasa de interes y spread
    PROCEDURE prcObtPorcentaInteresyspread
    (
        inuMetodoCuota  IN 	diferido.difemeca%TYPE,
        ionuTasaInteres	IN OUT	diferido.difeinte%TYPE,
        ionuSpread		IN OUT	diferido.difespre%TYPE,
        onuPorcentajeInteres	OUT	diferido.difespre%TYPE
    );

    --Obtiene Factor Gradiente
    PROCEDURE prcObtFactorGradiente
    (
        inuPlanDiferido     IN diferido.difepldi%TYPE,
        inuMetodoCuota      IN diferido.difemeca%TYPE,
        inuPorcentaje       IN conftain.cotiporc%TYPE,
        inuPlazo            IN plandife.pldicuma%TYPE,
        onuFactor           OUT diferido.difefagr%TYPE
    );

    --Obtiene la causa para el cargo de diferido
    FUNCTION fnuObtCausaCargoDiferido
    (
        inuTipoProducto	IN	servicio.servcodi%TYPE
    ) 
	RETURN NUMBER;

    --Carga las cuotas Cuotas extras para calculos por Diferido
    PROCEDURE prcCreaCuotasExtrasDiferido
    (
        ircRegistro IN CUOTEXTR%ROWTYPE
    );

    --Limpia memorica cuota extra
    PROCEDURE prcLimpiaMemoriaCuotaExtra;

    --Obtiene el valor maximo que puede financiar el usuario
    FUNCTION fnuMaximoValorporUsuario
    (
        inucodigoAccion     IN NUMBER,
        inuCodigoUsuario    IN NUMBER DEFAULT NULL
    ) 
	RETURN NUMBER;

    --Obtiene la tasa de interes
    FUNCTION fnuObtenerTasaInteres
    (
        inuIdTasaInteres IN NUMBER,
        idtVigencia      IN DATE DEFAULT NULL
    )
    RETURN NUMBER;    

END pkg_bogestion_financiacion;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.pkg_bogestion_financiacion
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> pkg_bogestion_financiacion </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 24-12-2024 </Fecha>
    <Descripcion> 
        Logica de gestión de financiación
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="24-12-2024" Inc="OSF-3801" Empresa="GDC">
               Creación
           </Modificacion>
     </Historial>
     </Package>
    ******************************************************************/

    --------------------------------------------
    -- Constantes 
    --------------------------------------------
    csbVERSION      CONSTANT VARCHAR2(10) := 'OSF-4336';
    csbPqt_nombre   CONSTANT VARCHAR2(100):= $$PLSQL_UNIT||'.';
    cnuNVLTRC       CONSTANT NUMBER       := pkg_traza.cnuNivelTrzDef;
	csbInicio   	cONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;
    csbFin          CONSTANT VARCHAR2(35)  := pkg_traza.csbFin;
    csbFin_err      CONSTANT VARCHAR2(35)  := pkg_traza.csbFin_err;
    csbFin_erc      CONSTANT VARCHAR2(35)  := pkg_traza.csbfin_erc; 
    -----------------------------------
    -- Variables privadas del package
    -----------------------------------
	nuError		NUMBER;  		
    sbMensaje   VARCHAR2(1000);
    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------

    /**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon.Erazo </Autor>
    <Fecha> 24-12-2024 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="24-12-2024" Inc="OSF-3801" Empresa="GDC"> 
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2
    IS
    BEGIN
        return CSBVERSION;
    END fsbVersion;
	
	/**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fnuobtvalorsaldocastigado </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 24-12-2024 </Fecha>
    <Descripcion> 
        Obtiene el valor del saldo castigado
    </Descripcion>
	<Parametros> 
        Entrada:
			inuProductId Identificador del producto
			
		Salida:
			nuValorSaldoCastigado 	valor saldo castigado
			
    </Parametros>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fnuobtvalorsaldocastigado(inuProductId	IN pr_product.product_id%type) 
	RETURN NUMBER
    IS
	
		csbMT_NAME  		VARCHAR2(200) := csbPqt_nombre || 'fnuobtvalorsaldocastigado';
		
		nuErrorCodigo         	NUMBER			:= pkg_error.CNUGENERIC_MESSAGE;
		nuValorSaldoCastigado	NUMBER			:= 0;
		sbErrorMensaje			VARCHAR2(2000)	:= NULL;
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuProductId: ' || inuProductId, cnuNVLTRC);  
		
		pkg_error.prInicializaError(nuErrorCodigo, sbErrorMensaje);		    

		-- Obtiene el valor de tarifa valor fijo
		nuValorSaldoCastigado := gc_bodebtmanagement.fnugetpunidebtbyprod(inuProductId);
	
		pkg_traza.trace('nuValorSaldoCastigado: ' || nuValorSaldoCastigado, cnuNVLTRC);  
    
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN nuValorSaldoCastigado;

    EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuErrorCodigo, sbErrorMensaje);
			pkg_traza.trace('nuErrorCodigo: ' || nuErrorCodigo || ' sbErrorMensaje: ' || sbErrorMensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
			RAISE pkg_error.CONTROLLED_ERROR;
			RETURN nuValorSaldoCastigado;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuErrorCodigo, sbErrorMensaje);
			pkg_traza.trace('nuErrorCodigo: ' || nuErrorCodigo || ' sbErrorMensaje: ' || sbErrorMensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR); 
			RAISE pkg_Error.Controlled_Error;
			RETURN nuValorSaldoCastigado;
    END fnuobtvalorsaldocastigado;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcFinanciarPorSolicitud
    Descripcion     : Servicio para generar cuenta de cobro y factura
    Autor           : Jorge Valiente
    Fecha           : 13-01-2025
    Ticket          : OSF-3839    
  
    Parametros
      Entrada
        inuSolicitud        Codigo de Solicitud
        
    Modificaciones
    =========================================================
    Autor       Fecha       Caso       Descripcion
  ***************************************************************************/
  PROCEDURE prcFinanciarPorSolicitud(inuSolicitud NUMBER) IS
  
    csbMetodo CONSTANT VARCHAR2(100) := csbPqt_nombre ||
                                        'prcFinanciarPorSolicitud'; --nombre del metodo
    onuErrorCode    NUMBER;
    osbErrorMessage VARCHAR2(4000);
  
  BEGIN
  
    pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO);
  
    pkg_traza.trace('Solicitud: ' || inuSolicitud, cnuNVLTRC);
  
    pkg_traza.trace('Ejecucion del servicio cc_bofinancing.financingorder',
                    cnuNVLTRC);
  
    cc_bofinancing.financingorder(inuSolicitud);
  
    pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN);
  
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
      pkg_traza.trace('sberror: ' || OsbErrorMessage, cnuNVLTRC);
      pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERC);
      RAISE pkg_Error.Controlled_Error;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
      pkg_traza.trace('sberror: ' || OsbErrorMessage, cnuNVLTRC);
      pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;
    
  END prcFinanciarPorSolicitud;

  /*******************************************************************************
  Método:         prcCalculaCuotaDiferido
  Descripción:    Calcula la cuota del diferido
    
  Autor:          Luis Felipe Valencia
  Fecha:          04/10/2024
    
  Entrada             Descripción
  inuDiferido         Codigo Diferido
  inuContrato         Contrato
  inuSaldo            Saldo a Diferir
  inuCuotas           Número de Cuotas diferidas
  inuCuotasFacturadas Numero de Cuotas Facturadas
  inuPlanDiferido     Plan del diferido 
  inuMetodo           Metodo calculo cuota diferido 
  inuTasaInteres      Codigo tasa de interes 
  inuPorcentaje       Interes 
  inuFactor           Valor factor gradiente 
  inuSpread           Valor del spread 
  
  Salida          Descripción
  NA
    
  Historial de Modificaciones
  =============================
  FECHA           AUTOR               Descripción
  04/10/2024      felipe.valencia             OSF-3237 : Creación
  *******************************************************************************/
  PROCEDURE prcCalculaCuotaDiferido(inuDiferido         IN NUMBER,
                                    inuContrato         IN NUMBER,
                                    inuSaldo            IN NUMBER,
                                    inuCuotas           IN NUMBER,
                                    inuCuotasFacturadas IN NUMBER,
                                    inuPlanDiferido     IN NUMBER,
                                    inuMetodo           IN NUMBER,
                                    inuTasaInteres      IN NUMBER,
                                    inuPorcentaje       IN NUMBER,
                                    inuFactor           IN NUMBER,
                                    inuSpread           IN NUMBER) IS
                                    
    csbMetodo CONSTANT VARCHAR2(70) := csbPqt_nombre ||
                                       'prcCalculaCuotaDiferido';
    nuError NUMBER;
    sbError VARCHAR2(4000);
    
    nuNominalPerc NUMBER;
    nuRoundFactor NUMBER;
    nuFactor      NUMBER;
    nuQuotaValue  diferido.DIFEVACU%type;
    nuMetodo      diferido.DIFEMECA%type;
    nuTasaInte    NUMBER;
    nuSpread      diferido.DIFESPRE%type;
    
    nuInteresPorc     CONFTAIN.COTIPORC%type;
    nuCotitain        CONFTAIN.COTITAIN%type;
    nuPorc            CONFTAIN.COTIPORC%type;
    nuIdCompany       NUMBER := 99;
    nuFactorGradiante NUMBER; --Corresponde al factor gradiente
    nuCuotaCalculada  NUMBER; --valor de la cuota que se calcula con la formula actual.
    nuNumeroCuotas    NUMBER; --Número de cuotas ya facturadas del diferido
    nuevoQuotaValue   NUMBER; --Neuvo Valor despues de aplicar el factor gradiante
    
  BEGIN
    
    pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO);
    
    --Obtener el método de cálculo asociado al diferido
    nuMetodo := inuMetodo;
    --Obtener el interés pactado
    nuTasaInte := inuTasaInteres;
    --Obtener tasa de interes efectivo anual
    nuInteresPorc := inuPorcentaje;
    --Obtener el factor gradiente
    nuFactor := inuFactor;
    --Obtener el Spread
    nuSpread := inuSpread;
    
    --Calcula el interés nominal
    pkDeferredMgr.ValInterestSpread(nuMetodo, -- Método de Cálculo
                                    nuInteresPorc, -- Porcentaje de Interes (Efectivo Anual)
                                    nuSpread, -- Spread
                                    nuNominalPerc -- Interés Nominal (Salida)
                                    );
    
    -- Obtiene el valor de la cuota
    pkDeferredMgr.CalculatePayment(inuSaldo, -- Saldo a Diferir (difesape)
                                   inuCuotas - inuCuotasFacturadas, -- Número de Cuotas  diferido
                                   nuNominalPerc, -- Interés Nominal
                                   nuMetodo, -- Método de Cálculo
                                   nuFactor, --nuSpread,              -- Spread
                                   nuInteresPorc + nuSpread, -- Interes Efectivo más Spread
                                   nuQuotaValue -- Valor de la Cuota (Salida)
                                   );
    
    --  Obtiene el factor de redondeo para la suscripción
    FA_BOPoliticaRedondeo.ObtFactorRedondeo(inuContrato,
                                            nuRoundFactor,
                                            nuIdCompany);
    
    nuFactorGradiante := nuFactor;
    
    nuNumeroCuotas := inuCuotasFacturadas;
    
    nuCuotaCalculada := power((1 + (nuFactorGradiante / 100)),
                              nuNumeroCuotas);
    
    nuevoQuotaValue := nuQuotaValue / nuCuotaCalculada;
    
    nuQuotaValue := nuevoQuotaValue;
    
    --  Aplica política de redondeo al valor de la cuota
    nuQuotaValue := round(nuQuotaValue, nuRoundFactor);
    
    --Actualizar el valor de la cuota en el diferido
    pktbldiferido.upddifevacu(inuDiferido, nuQuotaValue);
    
    pktbldiferido.upddifeinte(inuDiferido, inuPorcentaje);
    
    pktbldiferido.upddifepldi(inuDiferido, inuPlanDiferido);
    
    pktbldiferido.upddifetain(inuDiferido, inuTasaInteres);
    
    pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN);
    
  EXCEPTION
    WHEN pkg_error.Controlled_Error THEN
      pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERC);
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace(' sbError => ' || sbError,
                      pkg_traza.cnuNivelTrzDef);
      RAISE pkg_error.Controlled_Error;
    WHEN OTHERS THEN
      pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      pkg_error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace(' sbError => ' || sbError,
                      pkg_traza.cnuNivelTrzDef);
      RAISE pkg_error.Controlled_Error;
  END prcCalculaCuotaDiferido;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : prIniciaVariablesGlobales 
    Descripcion     : Inicializa variables globales del proceso
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 07/02/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     07/02/2025  OSF-3893 Creacion
    ***************************************************************************/
    PROCEDURE prIniciaVariablesGlobales
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbPqt_nombre || 'prIniciaVariablesGlobales';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
      
    BEGIN

        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO);  
        
        CC_BODefToCurTransfer.GLOBALINITIALIZE;
        
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
    END prIniciaVariablesGlobales;


    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : prAgregaDifCobrFinanciacion 
    Descripcion     : Agrega un diferido al traslado a corriente para cobro de financiacion
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 07/02/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     07/02/2025  OSF-3893 Creacion
    ***************************************************************************/
    PROCEDURE prAgregaDifCobrFinanciacion
    (
        inuProducto         IN  diferido.difenuse%TYPE,
        inuFinanciacion     IN  diferido.difecofi%TYPE,
        idtFechaRegistro    IN  DATE,
        isbDocumento        IN  diferido.difenudo%TYPE
    )
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbPqt_nombre || 'prAgregaDifCobrFinanciacion';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
      
    BEGIN

        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO);
        
        CC_BODefToCurTransfer.ADDDEFERTOCOLLECTFIN
        (
            inuproductid    => inuProducto,
            inufinancingid  => inuFinanciacion,
            idtregisterdate => idtFechaRegistro,
            isbdifenudo     => isbDocumento
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
    END prAgregaDifCobrFinanciacion;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : prTraslDeudaDiferidaACorriente 
    Descripcion     : Convierte deuda diferida a deuda corriente
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 07/02/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     07/02/2025  OSF-3893 Creacion
    ***************************************************************************/
    PROCEDURE prTraslDeudaDiferidaACorriente
    (
        inuValorAcorriente  IN  NUMBER,
        idtFechaRegistro    IN  DATE,
        iblabono            IN  BOOLEAN,
        isbPrograma         IN  VARCHAR2,
        onuError            OUT NUMBER,
        osbError            OUT VARCHAR2
    )
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbPqt_nombre || 'prTraslDeudaDiferidaACorriente';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
      
    BEGIN

        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO);
        
        CC_BODefToCurTransfer.TRANSFERDEBT
        (
            inupayment      => inuValorAcorriente,
            idtinsolv       => idtFechaRegistro,
            iblabono        => iblAbono,
            isbprograma     => isbPrograma,
            onuerrorcode    => onuError,
            osberrormessage => osbError
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
    END prTraslDeudaDiferidaACorriente;
    

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : prAgregaDiferidoTraslCorriente 
    Descripcion     : Agrega un diferido para convertirlo en deuda corriente
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 07/02/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     07/02/2025  OSF-3893 Creacion
    ***************************************************************************/
    PROCEDURE prAgregaDiferidoTraslCorriente
    (
        inudiferido         IN  diferido.difecodi%TYPE
    )
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbPqt_nombre || 'prAgregaDiferidoTraslCorriente';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
      
    BEGIN

        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO);
            
        CC_BODefToCurTransfer.AddDeferToCollect(inudiferido);

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
    END prAgregaDiferidoTraslCorriente;

    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
        <Unidad> fnuObtDeudaVencidaProd </Unidad>
        <Autor> Paola.Acosta </Autor>
        <Fecha> 23-04-2025 </Fecha>
        <Descripcion> 
            Consulta la deuda vencida asociado a un producto
        </Descripcion>    
        <Historial>
            <Modificacion Autor="Paola.Acosta" Fecha="23-04-2025" Inc="OSF-4293" Empresa="GDC"> 
                Creacion
            </Modificacion>
        </Historial>
    </Procedure>
    **************************************************************************/  
    FUNCTION fnuObtDeudaVencidaProd(inuIdProducto IN NUMBER)
    RETURN NUMBER
    IS
        --Constantes
        csbMtd_nombre CONSTANT VARCHAR2(70) := csbPqt_nombre || 'fnuObtDeudaVencidaProd';
        
        --Variables
        nuVlrDeudaVencida NUMBER;
               
    BEGIN
        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbInicio);     
        
        nuVlrDeudaVencida := gc_boDebtManagement.fnuGetExpirDebtByProd(inuIdProducto);
        
        pkg_traza.trace('nuVlrDeudaVencida: ' || nuVlrDeudaVencida, cnuNvlTrc);  
        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin); 
        
        RETURN nuVlrDeudaVencida;
        
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTrc);
            pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin_erc); 
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTrc);
            pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin_err); 
            RAISE pkg_error.controlled_error;
    END fnuObtDeudaVencidaProd;
    
    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
        <Unidad> fnuObtDeudaProd </Unidad>
        <Autor> Paola.Acosta </Autor>
        <Fecha> 23-04-2025 </Fecha>
        <Descripcion> 
            Consulta la deuda deuda Corriente (Vencida y No vencida) de un producto
        </Descripcion>    
        <Historial>
            <Modificacion Autor="Paola.Acosta" Fecha="23-04-2025" Inc="OSF-4293" Empresa="GDC"> 
                Creacion
            </Modificacion>
        </Historial>
    </Procedure>
    **************************************************************************/  
    FUNCTION fnuObtDeudaProd(inuIdProducto IN NUMBER)
    RETURN NUMBER
    IS
        --Constantes
        csbMtd_nombre CONSTANT VARCHAR2(70) := csbPqt_nombre || 'fnuObtDeudaProd';
        
        --Variables
        nuVlrDeuda NUMBER;
               
    BEGIN
        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbInicio);     
        
        nuVlrDeuda := gc_boDebtManagement.fnuGetDebtByProd(inuIdProducto);
        
        pkg_traza.trace('nuVlrDeuda: ' || nuVlrDeuda, cnuNvlTrc);  
        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin); 
        
        RETURN nuVlrDeuda;
        
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTrc);
            pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin_erc); 
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTrc);
            pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin_err); 
            RAISE pkg_error.controlled_error;
    END fnuObtDeudaProd;

	/**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de Gaceras <Empresa>">
    <Unidad> prcObtieneCodigoDiferido </Unidad>
    <Autor> Luis Felipe Valencia Hurtado </Autor>
    <Fecha> 19-02-2025 </Fecha>
    <Descripcion> 
        Obtiene proximo numero de diferido
    </Descripcion>
	<Parametros> 
        Entrada:			
		Salida:
			onuCodigoDiferido 	Codigo del diferido
			
    </Parametros>
    </PROCEDURE>
    **************************************************************************/
    PROCEDURE prcObtieneCodigoDiferido
    ( 
        onuCodigoDiferido	OUT	diferido.difecodi%TYPE
    ) 
    IS
        csbMT_NAME        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prcObtieneCodigoDiferido';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        pkDeferredMgr.GetNewDefNumber(onuCodigoDiferido);

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, pkg_traza.cnuNivelTrzDef );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, pkg_traza.cnuNivelTrzDef );
            RAISE pkg_error.Controlled_Error;
    END prcObtieneCodigoDiferido;

	/**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de Gaceras <Empresa>">
    <Unidad> prcObtieneCodigoFinanciacion </Unidad>
    <Autor> Luis Felipe Valencia Hurtado </Autor>
    <Fecha> 19-02-2025 </Fecha>
    <Descripcion> 
        Obtiene el consecutivo de financiacion
    </Descripcion>
	<Parametros> 
        Entrada:			
		Salida:
			onuCodigoDiferido 	Codigo del diferido
			
    </Parametros>
    </PROCEDURE>
    **************************************************************************/
    PROCEDURE prcObtieneCodigoFinanciacion
    ( 
        onuCodigoFinanciacion	OUT	diferido.difecofi%TYPE
    ) 
    IS
        csbMT_NAME        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prcObtieneCodigoFinanciacion';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        pkDeferredMgr.nuGetNextFincCode(onuCodigoFinanciacion);

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, pkg_traza.cnuNivelTrzDef );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, pkg_traza.cnuNivelTrzDef );
            RAISE pkg_error.Controlled_Error;
    END prcObtieneCodigoFinanciacion;

	/**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fsbObtieneSignoDiferido </Unidad>
    <Autor> Luis Felipe Valencia Hurtado </Autor>
    <Fecha> 19-02-2025 </Fecha>
    <Descripcion> 
        Obtiene el signo con el que se debe generar el diferido
    </Descripcion>
	<Parametros> 
        Entrada:
			inuValorDiferido Valor total del diferido
			
		Salida:
			sbSigno 	Signo del diferido
			
    </Parametros>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fsbObtieneSignoDiferido
    (
        inuValorDiferido	IN	diferido.difevatd%TYPE
    ) 
	RETURN VARCHAR2
    IS	
		csbMT_NAME  		VARCHAR2(200) := csbPqt_nombre || 'fsbObtieneSignoDiferido';
		
		nuErrorCodigo         	NUMBER			:= pkg_error.CNUGENERIC_MESSAGE;
		sbSigno	                VARCHAR2(3);
		sbErrorMensaje			VARCHAR2(2000)	:= NULL;        
    BEGIN		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuValorDiferido: ' || inuValorDiferido, cnuNVLTRC);  
		
		pkg_error.prInicializaError(nuErrorCodigo, sbErrorMensaje);		    

		sbSigno := pkDeferredMgr.fsbGetDefSign(inuValorDiferido);
	
		pkg_traza.trace('sbSigno: ' || sbSigno, cnuNVLTRC);  
    
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
    END fsbObtieneSignoDiferido;

	/**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de Gaceras <Empresa>">
    <Unidad> prcCalculaValorCuota </Unidad>
    <Autor> Luis Felipe Valencia Hurtado </Autor>
    <Fecha> 19-02-2025 </Fecha>
    <Descripcion> 
        Calcula el valor de la cuota
    </Descripcion>
	<Parametros> 
        Entrada:		
            inuValorDiferido    Valor total del diferido
            inuNumeroCuotas	    Número de cuotas
            inuInteresNominal	Porcentaje interes nominal
            inuInteresEfectivo	Porcentaje de interes efectivo
            inuspread		    Spread
            inuMetodo		    Metodo de calculo
            inuFactor		    Factor gradiente
            onuValorCuota	    
		Salida:
			onuValorCuota 	Valor de la cuota
			
    </Parametros>
    </PROCEDURE>
    **************************************************************************/
    PROCEDURE prcCalculaValorCuota
    ( 
        inuValorDiferido    IN	diferido.difevatd%TYPE,
        inuNumeroCuotas	    IN	diferido.difenucu%TYPE,
        inuInteresNominal	IN	diferido.difeinte%TYPE,
        inuInteresEfectivo	IN	diferido.difeinte%TYPE,
        inuspread		    IN	diferido.difespre%TYPE,
        inuMetodo		    IN	diferido.difemeca%TYPE,
        inuFactor		    IN	diferido.difefagr%TYPE,
        onuValorCuota	    OUT	diferido.difevacu%TYPE
    ) 
    IS
        csbMT_NAME        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prcCalculaValorCuota';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        pkDeferredMgr.CalcPeriodPayment
        (
            inuValorDiferido,
            inuNumeroCuotas,
            inuInteresNominal,
            inuInteresEfectivo,
            inuspread,
            inuMetodo,
            inuFactor,
            onuValorCuota
        );

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, pkg_traza.cnuNivelTrzDef );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, pkg_traza.cnuNivelTrzDef );
            RAISE pkg_error.Controlled_Error;
    END prcCalculaValorCuota;

	/**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de Gaceras <Empresa>">
    <Unidad> prcValidaValorCuota </Unidad>
    <Autor> Luis Felipe Valencia Hurtado </Autor>
    <Fecha> 19-02-2025 </Fecha>
    <Descripcion> 
        Valida la cuota con respecto al valor del interes de la primera cuota
    </Descripcion>
	<Parametros> 
        Entrada:	
            inuMetodo		    Metodo de calculo
            inuPorcentajeInteres Porcentaje interes nominal
            inuValorCuota       Valor cuota
            inuValorDiferido    Valor total del diferido
		Salida:
			
    </Parametros>
    </PROCEDURE>
    **************************************************************************/
    PROCEDURE prcValidaValorCuota
    (
        inuMetodo		    IN	diferido.difemeca%TYPE,
        inuPorcentajeInteres IN	diferido.difeinte%TYPE,
        inuValorCuota       IN	diferido.difevacu%TYPE,
        inuValorDiferido    IN	diferido.difevatd%TYPE
    ) 
    IS
        csbMT_NAME        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prcValidaValorCuota';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        pkDeferredMgr.ValPayment
        (
            inuMetodo,
            inuPorcentajeInteres,
            inuValorCuota,
            inuValorDiferido
        );

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, pkg_traza.cnuNivelTrzDef );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, pkg_traza.cnuNivelTrzDef );
            RAISE pkg_error.Controlled_Error;
    END prcValidaValorCuota;

	/**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de Gaceras <Empresa>">
    <Unidad> prcObtConfigPlanDiferido </Unidad>
    <Autor> Luis Felipe Valencia Hurtado </Autor>
    <Fecha> 19-02-2025 </Fecha>
    <Descripcion> 
        Obtiene configuración de plan de diferido
    </Descripcion>
	<Parametros> 
        Entrada:	
        inuPlanDiferido	        Código del plan de diferido
        idtFechaInicioVigencia	Fecha de incio de vigencia
        onuMetodoCalculo	    Método de calculo de cuota 
        onuCodigoTasa	        Código de la tasa de interes
        onuPorcInteres	        Porcentaje de interes
        oblspread	            Spread

		Salida:
			
    </Parametros>
    </PROCEDURE>
    **************************************************************************/
    PROCEDURE prcObtConfigPlanDiferido
    (
        inuPlanDiferido	        IN	plandife.pldicodi%TYPE,
        idtFechaInicioVigencia	IN 	plandife.pldifein%TYPE,
        onuMetodoCalculo	    OUT	plandife.pldimccd%TYPE,
        onuCodigoTasa	        OUT	plandife.plditain%TYPE,
        onuPorcInteres	        OUT	plandife.pldipoin%TYPE,
        oblspread	            OUT	BOOLEAN
    ) 
    IS
        csbMT_NAME        CONSTANT VARCHAR2(70) := csbPqt_nombre||'prcObtConfigPlanDiferido';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        pkDeferredPlanMgr.ValPlanConfig
        (
            inuPlanDiferido,
            idtFechaInicioVigencia,
            onuMetodoCalculo,
            onuCodigoTasa,
            onuPorcInteres,
            oblspread
        );

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, pkg_traza.cnuNivelTrzDef );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, pkg_traza.cnuNivelTrzDef );
            RAISE pkg_error.Controlled_Error;
    END prcObtConfigPlanDiferido;

	/**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de Gaceras <Empresa>">
    <Unidad> prcObtPorcentaInteresyspread </Unidad>
    <Autor> Luis Felipe Valencia Hurtado </Autor>
    <Fecha> 19-02-2025 </Fecha>
    <Descripcion> 
        Obtiene Tasa de interes y spread
    </Descripcion>
	<Parametros> 
        Entrada:	
            inuMetodoCuota          Metodo de Calculo de cuota
            ionuTasaInteres	        Tasa de interes
            ionuSpread		        Spread

		Salida:
            ionuTasaInteres	        Tasa de interes
            ionuSpread		        Spread
            onuPorcentajeInteres	Porcentaje de interes
			
    </Parametros>
    </PROCEDURE>
    **************************************************************************/
    PROCEDURE prcObtPorcentaInteresyspread
    (
        inuMetodoCuota  IN 	diferido.difemeca%TYPE,
        ionuTasaInteres	IN OUT	diferido.difeinte%TYPE,
        ionuSpread		IN OUT	diferido.difespre%TYPE,
        onuPorcentajeInteres	OUT	diferido.difespre%TYPE
    ) 
    IS
        csbMT_NAME      CONSTANT VARCHAR2(70) := csbPqt_nombre||'prcObtPorcentaInteresyspread';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        pkDeferredMgr.ValInterestSpread
        (
            inuMetodoCuota,
            ionuTasaInteres,
            ionuSpread,
            onuPorcentajeInteres
        );

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, pkg_traza.cnuNivelTrzDef );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, pkg_traza.cnuNivelTrzDef );
            RAISE pkg_error.Controlled_Error;
    END prcObtPorcentaInteresyspread;

	/**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de Gaceras <Empresa>">
    <Unidad> prcObtFactorGradiente </Unidad>
    <Autor> Luis Felipe Valencia Hurtado </Autor>
    <Fecha> 19-02-2025 </Fecha>
    <Descripcion> 
        Obtiene Factor Gradiente
    </Descripcion>
	<Parametros> 
        Entrada:	
            inuPlanDiferido         Plan de diferido
            inuMetodoCuota          Metodo de Calculo de cuota
            inuPorcentaje	        Porcentaje Vigente
            inuPlazo		        Plazo
		Salida:
            onuFactor	            Factor Gradiente
			
    </Parametros>
    </PROCEDURE>
    **************************************************************************/
    PROCEDURE prcObtFactorGradiente
    (
        inuPlanDiferido     IN diferido.difepldi%TYPE,
        inuMetodoCuota      IN diferido.difemeca%TYPE,
        inuPorcentaje       IN conftain.cotiporc%TYPE,
        inuPlazo            IN plandife.pldicuma%TYPE,
        onuFactor           OUT diferido.difefagr%TYPE
    ) 
    IS
        csbMT_NAME      CONSTANT VARCHAR2(70) := csbPqt_nombre||'prcObtFactorGradiente';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        pkDeferredMgr.ValGradiantFactor
        (
            inuPlanDiferido,
            inuMetodoCuota,
            inuPorcentaje,
            inuPlazo,
            onuFactor
        );

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, pkg_traza.cnuNivelTrzDef );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, pkg_traza.cnuNivelTrzDef );
            RAISE pkg_error.Controlled_Error;
    END prcObtFactorGradiente;

	/**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fnuObtCausaCargoDiferido </Unidad>
    <Autor> Luis Felipe Valencia Hurtado </Autor>
    <Fecha> 19-02-2025 </Fecha>
    <Descripcion> 
        Obtiene la causa para el cargo de diferido
    </Descripcion>
	<Parametros> 
        Entrada:
			inuTipoProducto     Tipo de Producto
			
		Salida:
			nuCausaCargo 	    Causa Cargo
			
    </Parametros>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fnuObtCausaCargoDiferido
    (
        inuTipoProducto	IN	servicio.servcodi%TYPE
    ) 
	RETURN NUMBER
    IS	
		csbMT_NAME  		VARCHAR2(200) := csbPqt_nombre || 'fnuObtCausaCargoDiferido';
		
		nuErrorCodigo         	NUMBER			:= pkg_error.CNUGENERIC_MESSAGE;
		nuCausaCargo            NUMBER;
		sbErrorMensaje			VARCHAR2(2000)	:= NULL;        
    BEGIN		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuTipoProducto: ' || inuTipoProducto, cnuNVLTRC);  
		
		pkg_error.prInicializaError(nuErrorCodigo, sbErrorMensaje);		    

		nuCausaCargo := FA_BOChargeCauses.fnuDeferredChCause(inuTipoProducto);
	
		pkg_traza.trace('nuCausaCargo: ' || nuCausaCargo, cnuNVLTRC);  
    
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
    END fnuObtCausaCargoDiferido;

	/**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de Gaceras <Empresa>">
    <Unidad> prcCreaCuotasExtrasDiferido </Unidad>
    <Autor> Luis Felipe Valencia Hurtado </Autor>
    <Fecha> 19-02-2025 </Fecha>
    <Descripcion> 
        Carga las cuotas Cuotas extras para calculos por Diferido
    </Descripcion>
	<Parametros> 
        Entrada:	
            ircRegistro   Cuota Extra
		Salida:
			
    </Parametros>
    </PROCEDURE>
    **************************************************************************/
    PROCEDURE prcCreaCuotasExtrasDiferido
    (
        ircRegistro IN CUOTEXTR%ROWTYPE
    ) 
    IS
        csbMT_NAME      CONSTANT VARCHAR2(70) := csbPqt_nombre||'prcCreaCuotasExtrasDiferido';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        pkAditionalPaymentMgr.AddRecord(ircRegistro);

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, pkg_traza.cnuNivelTrzDef );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, pkg_traza.cnuNivelTrzDef );
            RAISE pkg_error.Controlled_Error;
    END prcCreaCuotasExtrasDiferido;

	/**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de Gaceras <Empresa>">
    <Unidad> prcLimpiaMemoriaCuotaExtra </Unidad>
    <Autor> Luis Felipe Valencia Hurtado </Autor>
    <Fecha> 19-02-2025 </Fecha>
    <Descripcion> 
        Limpia memorica cuota extra
    </Descripcion>
	<Parametros> 
        Entrada:	
		Salida:
			
    </Parametros>
    </PROCEDURE>
    **************************************************************************/
    PROCEDURE prcLimpiaMemoriaCuotaExtra
    IS
        csbMT_NAME      CONSTANT VARCHAR2(70) := csbPqt_nombre||'prcLimpiaMemoriaCuotaExtra';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        pkAditionalPaymentMgr.ClearMemory;

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, pkg_traza.cnuNivelTrzDef );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => '||sbError, pkg_traza.cnuNivelTrzDef );
            RAISE pkg_error.Controlled_Error;
    END prcLimpiaMemoriaCuotaExtra;

	/**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fnuObtCausaCargoDiferido </Unidad>
    <Autor> Luis Felipe Valencia Hurtado </Autor>
    <Fecha> 19-02-2025 </Fecha>
    <Descripcion> 
        Obtiene el valor maximo que puede financiar el usuario
    </Descripcion>
	<Parametros> 
        Entrada:
            inucodigoAccion     Código de la Acción
            inuCodigoUsuario    Código del usuario
			
		Salida:
			Valor maximo
			
    </Parametros>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fnuMaximoValorporUsuario
    (
        inucodigoAccion     IN NUMBER,
        inuCodigoUsuario    IN NUMBER DEFAULT NULL
    ) 
	RETURN NUMBER
    IS	
		csbMT_NAME  		VARCHAR2(200) := csbPqt_nombre || 'fnuMaximoValorporUsuario';
		
		nuErrorCodigo         	NUMBER			:= pkg_error.CNUGENERIC_MESSAGE;
		nuValorMaximo           NUMBER;
		sbErrorMensaje			VARCHAR2(2000)	:= NULL;        
    BEGIN		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inucodigoAccion: ' || inucodigoAccion, cnuNVLTRC);  
        pkg_traza.trace('inuCodigoUsuario: ' || inuCodigoUsuario, cnuNVLTRC);  
		
		pkg_error.prInicializaError(nuErrorCodigo, sbErrorMensaje);		    

		nuValorMaximo := GE_BOFinancialProfile.fnuMaxAmountByUser(inucodigoAccion, inuCodigoUsuario);
	
		pkg_traza.trace('nuValorMaximo: ' || nuValorMaximo, cnuNVLTRC);  
    
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN nuValorMaximo;
    EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuErrorCodigo, sbErrorMensaje);
			pkg_traza.trace('nuErrorCodigo: ' || nuErrorCodigo || ' sbErrorMensaje: ' || sbErrorMensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
			RAISE pkg_error.CONTROLLED_ERROR;
			RETURN nuValorMaximo;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuErrorCodigo, sbErrorMensaje);
			pkg_traza.trace('nuErrorCodigo: ' || nuErrorCodigo || ' sbErrorMensaje: ' || sbErrorMensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR); 
			RAISE pkg_Error.Controlled_Error;
			RETURN nuValorMaximo;
    END fnuMaximoValorporUsuario;
    
    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
        <Unidad> fnuObtenerTasaInteres </Unidad>
        <Autor> Paola.Acosta </Autor>
        <Fecha> 13-05-2025 </Fecha>
        <Descripcion> 
            Obtiene la tasa de interes
        </Descripcion>    
        <Historial>
            <Modificacion Autor="Paola.Acosta" Fecha="13-05-2025" Inc="OSF-4336" Empresa="GDC"> 
                Creacion
            </Modificacion>
        </Historial>
    </Procedure>
    **************************************************************************/  
    FUNCTION fnuObtenerTasaInteres(inuIdTasaInteres IN NUMBER,
                                   idtVigencia      IN DATE DEFAULT NULL)
    RETURN NUMBER
    IS
        --Constantes
        csbMtd_nombre CONSTANT VARCHAR2(70) := csbPqt_nombre || 'fnuObtenerTasaInteres';
        
        --Variables
        nuTasaInteres conftain.cotiporc%TYPE;        
                
    BEGIN
        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbInicio);     
        
        nuTasaInteres := fnuGetInterestRate(inuIdTasaInteres, idtVigencia);      
        pkg_traza.trace('nuTasaInteres: '||nuTasaInteres, cnuNvlTrc); 
               
        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin); 
        
        RETURN nuTasaInteres;
        
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTrc);
            pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin_erc); 
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTrc);
            pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin_err); 
            RAISE pkg_error.controlled_error;
    END fnuObtenerTasaInteres;    
    
END pkg_bogestion_financiacion;
/
BEGIN
pkg_utilidades.prAplicarPermisos(upper('pkg_bogestion_financiacion'),'ADM_PERSON'); 
END;
/