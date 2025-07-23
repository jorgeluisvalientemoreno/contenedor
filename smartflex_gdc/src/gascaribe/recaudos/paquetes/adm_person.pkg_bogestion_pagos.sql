CREATE OR REPLACE PACKAGE adm_person.pkg_bogestion_pagos IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Paquete|    :   pkg_bogestion_pagos
    Autor       :   Jhon Jairo Soto
    Fecha       :   06/12/2024
    Descripcion :   Para publicar Servicios con logica de negocio para pagos
	
    Modificaciones  :
    Autor       Fecha       Caso    	Descripcion
	jsoto		06/12/2024	OSF-3740  	Creacion
	jpinedc     28/01/2025  OSF-3893    Se crea prcAnulaPago
	jsoto		09/06/2025	OSF-4574	Se crea fdtFechaVencimientoEsperaPago

*******************************************************************************/

    -- Retona Identificador del ultimo caso que hizo cambios
    FUNCTION fsbVersion RETURN VARCHAR2;

	PROCEDURE prcObtProdFacturable
    (
       inuContrato             IN  suscripc.susccodi%TYPE,
	   onuProducto			   OUT servsusc.sesunuse%TYPE
    );
	
	PROCEDURE prcRegistraCuentaCuponAg(inuCuponPadre	IN cupon.cuponume%TYPE,
										 inuCupon		IN cupon.cuponume%TYPE
										);
	
    -- Anula el pago de un cupon
    PROCEDURE prcAnulaPago
    (
        inuCupon        IN  cupon.cuponume%TYPE,
        inuCausal       IN  ge_causal.causal_id%TYPE,
        isbObservacion  IN  VARCHAR2
    );
    
	
	FUNCTION fdtFechaVencimientoEsperaPago
	(
		inuSolicitud	IN mo_packages.package_id%TYPE
	)
	RETURN DATE;
	
	
	
END PKG_BOGESTION_PAGOS;
/

CREATE OR REPLACE PACKAGE BODY ADM_PERSON.PKG_BOGESTION_PAGOS IS

    -- Identificador del ultimo caso que hizo cambios
    csbVersion                 VARCHAR2(15) := 'OSF-4574';

    -- Constantes para el control de la traza
    csbSP_NAME                 CONSTANT VARCHAR2(35)         :=  $$PLSQL_UNIT||'.';
    cnuNVLTRC                  CONSTANT NUMBER                := 5;
    
    nuError                     NUMBER;
    sbError                     VARCHAR2(4000);


    --Retona la ultimo caso que hizo cambios en el paquete 
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;

	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtProdFacturable 
    Descripcion     : Obtiene un producto facturable de acuerdo a la prioridad de recaudo
    Autor           : jsoto
    Fecha           : 06/12/2024
	
	Parametros de entrada
		inuContrato   Id de contrato
	
	Parametros de salida
	
		onuProducto   Id de Producto
			
    Modificaciones  :
    Autor       Fecha       Caso        Descripción
    jsoto	    06-12-2024  OSF-3740    Creación
    ***************************************************************************/   
	PROCEDURE prcObtProdFacturable
    (
       inuContrato             IN  suscripc.susccodi%TYPE,
	   onuProducto			   OUT servsusc.sesunuse%TYPE
    )
    IS
        csbMT_NAME   VARCHAR2(70) := csbSP_NAME||'prcObtProdFacturable';
	
    BEGIN
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
        
			onuProducto := RC_BCPAYMENTQUERIES.FNUGETGREATPRIORBILLABLEPROD( inuContrato );
	
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.fsbFIN);
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' ||sbError, cnuNVLTRC);
            pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);  
			onuProducto := NULL;
    END prcObtProdFacturable;   


     /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcRegistraCuentaCuponAg 
    Descripcion     : Inserta datos para cupon agrupador en CUENCUAG
    Autor           : Jhon Jairo Soto 
	
	Parametros de entrada
	inuCuponPadre  	Cupon Padre
	inuCupon		Numero de cupon nuevo
	
	
    Fecha           : 06/12/2024
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jsoto		06-12-2024  OSF-3740    Creacion
    ***************************************************************************/  


	PROCEDURE prcRegistraCuentaCuponAg(inuCuponPadre	IN cupon.cuponume%TYPE,
										 inuCupon		IN cupon.cuponume%TYPE
										)
	IS

		csbMT_NAME  VARCHAR2(70) := csbSP_NAME ||  '.prcRegistraCuentaCuponAg';      
		nuerrorcode NUMBER;         -- se almacena codigo de error
		sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 
		nuContrato	NUMBER;
		nuValorCupon  cupon.cuposusc%TYPE;
			
	BEGIN
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO); 
			
			PKBCCUENCUAG.COPYGROUPINFOBYCOUPON(inuCuponPadre,inuCupon);
				
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
			
			EXCEPTION
				WHEN OTHERS THEN
				pkg_error.SetError;
				pkg_error.getError(nuErrorCode,sbMensError);
				pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
				pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);	

	END prcRegistraCuentaCuponAg;
	
    PROCEDURE prcAnulaPago
    (
        inuCupon        IN  cupon.cuponume%TYPE,
        inuCausal       IN  ge_causal.causal_id%TYPE,
        isbObservacion  IN  VARCHAR2
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcAnulaPago';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);         
    BEGIN

        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO); 
			
        rc_boannulpayments.collectingannul
        (
            inupagocupo => inuCupon,
            isbpaancaap => inuCausal,
            isbpaanobse => isbObservacion
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
    END prcAnulaPago;

     /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fdtFechaVencimientoEsperaPago 
    Descripcion     : Calcula la fecha de espera pago para una solicitud de negociacion
    Autor           : Jhon Jairo Soto 
	
	Parametros de entrada
		inuSolicitud	Código de la Solicitud
	
    Fecha           : 09/06/2025
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jsoto		09-06-2025  OSF-4574    Creacion
    ***************************************************************************/  

	FUNCTION fdtFechaVencimientoEsperaPago
	(
		inuSolicitud	IN mo_packages.package_id%TYPE
	)
	RETURN DATE
	IS
        csbMT_NAME   VARCHAR2(70) := csbSP_NAME||'fdtFechaVencimientoEsperaPago';
		dtFechaVencCupon	DATE;

	
    BEGIN
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
		
			pkg_traza.trace('inuSolicitud: '||inuSolicitud);
       
			dtFechaVencCupon := CC_BOWAITFORPAYMENT.FDTCALCEXPIRATIONDATE(inuSolicitud);
	
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.fsbFIN);
		
		RETURN dtFechaVencCupon;
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' ||sbError, cnuNVLTRC);
            pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);  
    END fdtFechaVencimientoEsperaPago;   


END PKG_BOGESTION_PAGOS;
/

PROMPT Otorgando permisos de ejecución para adm_person.PKG_BOGESTION_PAGOS
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BOGESTION_PAGOS', 'ADM_PERSON');
END;
/

