CREATE OR REPLACE PACKAGE adm_person.pkg_suscripc IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    pkg_suscripc
    Autor       :   Jhon Erazo - MVM
    Fecha       :   01-02-2024
    Descripcion :   Paquete de primer nivel para manejo del paquete OPEN.SUSCRIPC
    Modificaciones  :
    Autor       Fecha       Caso    	Descripcion
    jcatuche    04-07-2024  OSF-3266    Se agrega el método prActualizaCiclo
    jerazomvm   01-02-2024  OSF-2153	Creacion
*******************************************************************************/

    -- Retona Identificador del ultimo caso que hizo cambios
    FUNCTION fsbVersion RETURN VARCHAR2;

	-- Actualiza el envio de factura por correo electronico
	PROCEDURE prc_updEnvioFacturaCorr
	(
		inuContrato             IN  suscripc.susccodi%TYPE,
		isbEnvFactCorrElec		IN	suscripc.suscefce%TYPE
	);
	-- Actualiza el ciclo 
	PROCEDURE prActualizaCiclo
	(
		inuContrato             IN  suscripc.susccodi%TYPE,
		inuCiclo		        IN	suscripc.susccicl%TYPE
	);
	
	
    
END pkg_suscripc;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_suscripc IS

    -- Identificador del ultimo caso que hizo cambios
    csbVersion                 VARCHAR2(15) := 'OSF-3266';

    -- Constantes para el control de la traza
    csbSP_NAME          CONSTANT VARCHAR2(100):= $$PLSQL_UNIT||'.';
    cnuNVLTRC           CONSTANT NUMBER       := pkg_traza.cnuNivelTrzDef;
	csbInicio   		CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;

    nuError             NUMBER;
    sbError             VARCHAR2(2000);
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion 
    Descripcion     : Retona la ultima WO que hizo cambios en el paquete 
    Autor           : Jhon Erazo - MVM
    Fecha       	: 01-02-2024
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jerazomvm   01-02-2024  OSF-2153	Creacion
    ***************************************************************************/    
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;   
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prc_updEnvioFacturaCorr 
    Descripcion     : Actualiza el envio de factura por correo electronico
    Autor           : Jhon Erazo - MVM 
    Fecha           : 26-01-2024 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jerazomvm   26-01-2024  OSF-2153    Creacion
    ***************************************************************************/                     
    PROCEDURE prc_updEnvioFacturaCorr
	(
		inuContrato             IN  suscripc.susccodi%TYPE,
		isbEnvFactCorrElec		IN	suscripc.suscefce%TYPE
	)
    IS

        -- Nombre de ste mÉtodo
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || 'prc_updEnvioFacturaCorr';
    BEGIN
    
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuContrato: ' 	   || inuContrato || chr(10) ||
						'isbEnvFactCorrElec: ' || isbEnvFactCorrElec, cnuNVLTRC);        
    
        UPDATE suscripc
		SET suscefce = isbEnvFactCorrElec
		WHERE susccodi = inuContrato;
            
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.fsbFIN);
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
			pkg_error.geterror(nuError, sbError);
			pkg_traza.trace('nuError: ' || nuError || ', sbError: ' || sbError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
			RAISE pkg_error.controlled_error;			
    END prc_updEnvioFacturaCorr;  
               
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActualizaCiclo 
    Descripcion     : Actualiza el ciclo de facturación del contrato
    Autor           : Jcatuche
    Fecha           : 04-0172024 
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jcatuche    04-07-2024  OSF-3266    Creacion
    ***************************************************************************/       
    PROCEDURE prActualizaCiclo
	(
		inuContrato             IN  suscripc.susccodi%TYPE,
		inuCiclo		        IN	suscripc.susccicl%TYPE
	)
	IS

        -- Nombre de ste mÉtodo
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || 'prActualizaCiclo';
		
	BEGIN
    
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		pkg_traza.trace('inuContrato    <= '||inuContrato, cnuNVLTRC); 
		pkg_traza.trace('inuCiclo       <= '||inuCiclo, cnuNVLTRC);        
    
        UPDATE suscripc
		SET susccicl = inuCiclo
		WHERE susccodi = inuContrato;
            
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.fsbFIN);
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
			pkg_error.geterror(nuError, sbError);
			pkg_traza.trace('nuError: ' || nuError || ', sbError: ' || sbError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
			RAISE pkg_error.controlled_error;			
    END prActualizaCiclo;  
    
    
    
               
END pkg_suscripc;
/

PROMPT Otorgando permisos de ejecución para adm_person.pkg_suscripc
BEGIN
    pkg_utilidades.prAplicarPermisos(upper('pkg_suscripc'), 'ADM_PERSON');
END;
/

