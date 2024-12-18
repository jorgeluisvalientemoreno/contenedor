CREATE OR REPLACE PACKAGE adm_person.pkg_bogestion_ordenes IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe
    
	Programa 	: pkg_bogestion_ordenes
	Autor       : Luis Felipe Valencia Hurtado
    Fecha       : 12-03-2024
    Descripcion : Paquete para gestion de ordenes
    
	Modificaciones  :
    Autor       		Fecha       Caso    	Descripcion
    felipe.valencia   	12-03-2024  OSF-2416 	Creacion
*******************************************pkg_bogestion_ordenes************************************/

	PROCEDURE prcActualizaDireccion
	(
		inuOrden  			IN 	or_order.order_id%TYPE,
		inuDireccion		IN 	or_order.external_address_id%TYPE
	);

  --Servicio para obtener el motivo instanciado
  FUNCTION fnuObtMotivoActividad RETURN NUMBER;

END pkg_bogestion_ordenes;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_bogestion_ordenes IS
	
	-- Constantes para el control de la traza
	csbSP_NAME     CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;
	
	-- Identificador del ultimo caso que hizo cambios
	csbVersion     CONSTANT VARCHAR2(15) := 'OSF-2416';

	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    
	Programa        : fsbVersion
	Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor       	: Luis Felipe Valencia Hurtado
    Fecha       	: 12-03-2024

    Modificaciones  :
    Autor       		Fecha       Caso     	Descripcion
    felipe.valencia   	12-03-2024  OSF-2416 	Creacion
	***************************************************************************/
	FUNCTION fsbVersion 
	RETURN VARCHAR2 
	IS
	BEGIN
		RETURN csbVersion;
	END fsbVersion;
	

	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    
	Programa        : prcActualizaDireccion
    Descripcion     : Ejecuta el cambio de dirección de la orden

    Autor       	:   Luis Felipe Valencia Hurtado
    Fecha       	:   12-03-2024

    Parametros de Entrada
      inuOrden        	Identificador de la orden
      isbDireccion 		Identificador de la Direccion
    Parametros de Salida
      nuError       codigo de error
      osbError       mensaje de error
    
	Modificaciones  :
    Autor       		Fecha       Caso     	Descripcion
    felipe.valencia   	12-03-2024  OSF-2416 	Creación
	***************************************************************************/
	PROCEDURE prcActualizaDireccion
	(
		inuOrden  			IN 	or_order.order_id%TYPE,
		inuDireccion		IN 	or_order.external_address_id%TYPE
	) 
	IS
		csbMT_NAME      	VARCHAR2(100) := csbSP_NAME || '.prcActualizaDireccion';
		nuError    		NUMBER;
		sbError    		VARCHAR2(32767);
		sbmensaje         	VARCHAR2(32767);
	BEGIN
		pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
		pkg_traza.trace('inuOrden => ' || inuOrden, pkg_traza.cnuNivelTrzDef);
		pkg_error.prInicializaError(nuError, sbError);

		pkg_or_order.prcActualizaDireccionOrden
		(
			inuOrden,
			inuDireccion,
			nuError,
			sbError
		);

		IF (NVL(nuError,0) = 0) THEN
			pkg_or_order_activity.prcactualizaDireccActividad
			(
				inuOrden,
				inuDireccion,
				nuError,
				sbError
			);
			IF (NVL(nuError,0) = 0) THEN
				pkg_or_extern_systems_id.prcactualizaDireccExterna
				(
					inuOrden,
					inuDireccion,
					nuError,
					sbError
				);
				IF (NVL(nuError,0) <> 0) THEN
					sbmensaje := 'Error actualizando or_extern_systems_id nuError :'||nuError||' sbError: '||sbError;
					Pkg_Error.SetErrorMessage( isbMsgErrr => sbmensaje);
				END IF;
			ELSE
				sbmensaje := 'Error actualizando or_order_activity nuError :'||nuError||' sbError: '||sbError;
				Pkg_Error.SetErrorMessage( isbMsgErrr => sbmensaje);
			END IF;
		ELSE
			sbmensaje := 'Error actualizando or_order nuError :'||nuError||' sbError: '||sbError;
			Pkg_Error.SetErrorMessage( isbMsgErrr => sbmensaje);
		END IF;

		pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;     
	END prcActualizaDireccion;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    
    Programa      : fnuObtMotivoActividad
    Descripcion   : Servicio para obtener el motivo instanciado
    Caso          : OSF-3541
    Autor         : Jorge Valiente
    Fecha         : 19-11-2024
  
    Parametros
      Salida
        nuMotivo    Codigo Motivo                      
  
    Modificaciones  :
    Autor           Fecha       Caso      Descripcion
  ***************************************************************************/
  FUNCTION fnuObtMotivoActividad RETURN NUMBER IS
  
    csbMT_NAME VARCHAR2(100) := csbSP_NAME || '.fnuObtMotivoActividad';
    nuError    NUMBER;
    sbError    VARCHAR2(32767);
  
    nuMotivo NUMBER;
  
  BEGIN
  
    pkg_traza.trace(csbMT_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    pkg_traza.trace('Ejecucion del servicio OR_BOLEGALIZEACTIVITIES.FNUGETCURRMOTIVE',
                    pkg_traza.cnuNivelTrzDef);
  
    nuMotivo := OR_BOLEGALIZEACTIVITIES.FNUGETCURRMOTIVE();
  
    pkg_traza.trace('Motivo: ' || nuMotivo, pkg_traza.cnuNivelTrzDef);
  
    pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  
    RETURN(nuMotivo);
  
  EXCEPTION
  
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error: ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      RAISE pkg_Error.Controlled_Error;
    
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error: ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;
    
  END fnuObtMotivoActividad;

END pkg_bogestion_ordenes;
/
BEGIN
	pkg_utilidades.prAplicarPermisos(upper('pkg_bogestion_ordenes'), 'ADM_PERSON');
END;
/