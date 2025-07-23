CREATE OR REPLACE PACKAGE ADM_PERSON.PKG_BOFLUJOS IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    PKG_BOFLUJOS
    Autor       :   Jhon Jairo Soto
    Fecha       :   11/12/2024
    Descripcion :   Para publicar Servicios con logica de negocio para flujos
	
    Modificaciones  :
    Autor       Fecha       Caso    	Descripcion
	jsoto		11/12/2024	OSF-3740  	Creacion
*******************************************************************************/

    -- Retona Identificador del ultimo caso que hizo cambios
    FUNCTION fsbVersion RETURN VARCHAR2;

	FUNCTION fblValActividadFlujo(	inuSolicitud		IN mo_packages.package_id%TYPE,
									inuValActividad		IN NUMBER,
									inuValEstActividad 	IN NUMBER
								 ) RETURN BOOLEAN;

	
END PKG_BOFLUJOS;
/

CREATE OR REPLACE PACKAGE BODY ADM_PERSON.PKG_BOFLUJOS IS

    -- Identificador del ultimo caso que hizo cambios
    csbVersion                 VARCHAR2(15) := 'OSF-3740';

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
    Programa        : fblValActividadFlujo 
    Descripcion     : Valida que el flujo se encuentre en la actividad y el estado dados como parametro
    Autor           : Jhon Jairo Soto 
    Fecha           : 11/12/2024
	parametros de entreda
		inuSolicitud		Id de la solicitud
		inuValActividad		Actividad que se quiere validar
		inuValEstActividad	Estado de la actividad que se quiere validar
		
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jsoto		06-12-2024  OSF-3740    Creacion
    ***************************************************************************/  

	FUNCTION fblValActividadFlujo(	inuSolicitud		IN mo_packages.package_id%TYPE,
									inuValActividad		IN NUMBER,
									inuValEstActividad 	IN NUMBER
								 ) RETURN BOOLEAN
									
		
	IS

		csbMT_NAME  VARCHAR2(70) := csbSP_NAME ||  '.fblValActividadFlujo';      
		nuerrorcode NUMBER;         -- se almacena codigo de error
		sbmenserror VARCHAR2(2000);  -- se almacena descripcion del error 
		boValActividad BOOLEAN;
			
	BEGIN
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO); 
			
			boValActividad :=	MO_BOWF_PACK_INTERFAC.FBLACTIVITYEXIST
								(
								inuSolicitud,
								inuValActividad,
								inuValEstActividad
								);
			
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

			RETURN boValActividad;
	
			EXCEPTION
				WHEN OTHERS THEN
				pkg_error.SetError;
				pkg_error.getError(nuErrorCode,sbMensError);
				pkg_traza.trace(csbMT_NAME||' '||sbMensError, cnuNVLTRC);
				pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.fsbFIN_ERR);
				RETURN FALSE;
	END fblValActividadFlujo;
	
END PKG_BOFLUJOS;
/
PROMPT Otorgando permisos de ejecución para ADM_PERSON.PKG_BOFLUJOS
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BOFLUJOS', 'ADM_PERSON');
END;
/