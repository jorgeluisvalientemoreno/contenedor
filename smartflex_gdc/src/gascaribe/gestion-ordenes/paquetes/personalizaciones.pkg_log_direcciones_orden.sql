CREATE OR REPLACE PACKAGE personalizaciones.pkg_log_direcciones_orden IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe
    
	Programa 	: pkg_log_direcciones_orden
	Autor       : Luis Felipe Valencia Hurtado
    Fecha       : 12-03-2024
    Descripcion : Paquete con servicios CRUD sobre la entidad OPEN.log_direcciones_orden
    
	Modificaciones  :
    Autor       		Fecha       Caso    	Descripcion
    felipe.valencia   	12-03-2024  OSF-2416 	Creacion
*******************************************************************************/

	PROCEDURE prcregistraLogCambioOrden
	(
		inuOrden  			IN 	log_direcciones_orden.orden%TYPE,
		inuDireccionAnt		IN 	log_direcciones_orden.direccion_anterior%TYPE,
		inuDireccionAct		IN 	log_direcciones_orden.direccion_actual%TYPE
	) ;
END pkg_log_direcciones_orden;
/
CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_log_direcciones_orden IS
	
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
    
	Programa        : prc_registraLogCambioOrden
    Descripcion     : Registra el log de cambio de direcciones
					  de la orden

    Autor       	:   Luis Felipe Valencia Hurtado
    Fecha       	:   12-03-2024

    Parametros de Entrada
      inuOrden        	Identificador de la orden
      isbDireccion 		Identificador de la Direccion
    Parametros de Salida
      onuError       codigo de error
      osbError       mensaje de error
    
	Modificaciones  :
    Autor       		Fecha       Caso     	Descripcion
    felipe.valencia   	12-03-2024  OSF-2416 	Creación
	***************************************************************************/
	PROCEDURE prcregistraLogCambioOrden
	(
		inuOrden  			IN 	log_direcciones_orden.orden%TYPE,
		inuDireccionAnt		IN 	log_direcciones_orden.direccion_anterior%TYPE,
		inuDireccionAct		IN 	log_direcciones_orden.direccion_actual%TYPE
	) 
	IS
		PRAGMA AUTONOMOUS_TRANSACTION;
		csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prcregistraLogCambioOrden';
	    sbError             VARCHAR2(4000);
        nuError             NUMBER;   
	BEGIN
		pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
		pkg_traza.trace('inuOrden => ' || inuOrden, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace('inuDireccionAnt => ' || inuDireccionAnt, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace('inuDireccionAct => ' || inuDireccionAct, pkg_traza.cnuNivelTrzDef);


     	INSERT INTO log_direcciones_orden
        (
			orden,
			fecha_cambio,
			direccion_anterior,
			direccion_actual,
			usuario,
			terminal
		)
        VALUES
        (	inuOrden,  -- orden actualizada
			sysdate, -- fecha de registro
			inuDireccionAnt, -- direccion antes de la modificacion de la direccion
			inuDireccionAct,  -- direccion actual
			pkg_session.getuser, -- usuario conectado
			pkg_session.fsbgetterminal  -- terminal
        );

		COMMIT;

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
	END prcregistraLogCambioOrden;

END pkg_log_direcciones_orden;
/
BEGIN
	pkg_utilidades.prAplicarPermisos('PKG_LOG_DIRECCIONES_ORDEN', 'PERSONALIZACIONES');
END;
/