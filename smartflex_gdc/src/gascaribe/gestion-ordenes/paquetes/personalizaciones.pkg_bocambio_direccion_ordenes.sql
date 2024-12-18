CREATE OR REPLACE PACKAGE personalizaciones.pkg_bocambio_direccion_ordenes IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe
    
	Programa 	: pkg_bocambio_direccion_ordenes
	Autor       : Luis Felipe Valencia Hurtado
    Fecha       : 12-03-2024
    Descripcion : Paquete con servicios CRUD sobre la entidad OPEN.log_direcciones_orden
    
	Modificaciones  :
    Autor       		Fecha       Caso    	Descripcion
    felipe.valencia   	12-03-2024  OSF-2416 	Creacion
*******************************************pkg_bocambio_direccion_ordenes************************************/

	PROCEDURE prcprocesaCambioDireccion
	(
		inuOrden  			IN 	log_direcciones_orden.orden%TYPE,
		inuDireccion		IN 	log_direcciones_orden.direccion_anterior%TYPE
	);
END pkg_bocambio_direccion_ordenes;
/
CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_bocambio_direccion_ordenes IS
	
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
    
	Programa        : prcprocesaCambioDireccion
    Descripcion     : Procesa el cambio de dirección de la orden

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
	PROCEDURE prcprocesaCambioDireccion
	(
		inuOrden  			IN 	log_direcciones_orden.orden%TYPE,
		inuDireccion		IN 	log_direcciones_orden.direccion_anterior%TYPE
	) 
	IS
		csbMT_NAME      	VARCHAR2(100) := csbSP_NAME || '.prc_procesaCambioDireccion';
	    sbError             VARCHAR2(4000);
        nuError             NUMBER;   

		osbError             VARCHAR2(4000);
        onuError             NUMBER;

		sbmensaje         	VARCHAR2(10000);
		rcOrden            	pkg_bccambio_direccion_ordenes.tyrcInfoOrden;
	BEGIN
		pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
		pkg_traza.trace('inuOrden => ' || inuOrden, pkg_traza.cnuNivelTrzDef);

		-- se valida que en el campo "orden" se haya ingresado valores numericos y no letras
		IF (pkg_bccambio_direccion_ordenes.fblValidaFormatoOrden(inuOrden) = FALSE) THEN
			sbmensaje := 'Debe ingresar en el campo de orden valores numericos!!!';
			Pkg_Error.SetErrorMessage( isbMsgErrr => sbmensaje); 
		END IF;

		rcOrden := pkg_bccambio_direccion_ordenes.frcObtieneInfoOrden(inuOrden);

		IF rcOrden.nuTipoTrabajo IS NULL THEN
			sbmensaje := 'No existe en la base de datos la orden = '||inuOrden;
			Pkg_Error.SetErrorMessage( isbMsgErrr => sbmensaje);
		ELSE
			-- se valida el TT de la orden sea de acuerdo al parametro
			IF (pkg_bccambio_direccion_ordenes.fblEsPermitidoTipoTrabajo(rcOrden.nuTipoTrabajo)) THEN
				IF (pkg_bccambio_direccion_ordenes.fblEsPermitidoEstado(rcOrden.nuEstadoOrden)) THEN

					pkg_bogestion_ordenes.prcActualizaDireccion(inuOrden,inuDireccion);
					-- se hace el registro en la tabla de log
					pkg_log_direcciones_orden.prcregistraLogCambioOrden(inuOrden, rcOrden.nuDireccion, inuDireccion );

				ELSE
					sbmensaje := 'El estado de la orden = '||inuOrden||' no estan configurados dentro del parametro ESTADOS_CAMBIO_DIRECCION';
					Pkg_Error.SetErrorMessage( isbMsgErrr => sbmensaje);
				END IF;
			ELSE
				sbmensaje := 'El tipo de trabajo de la orden = '||inuOrden||' no estan configurados dentro del parametro TIPOS_TRABAJO_CAMBIO_DIRECCION';
				Pkg_Error.SetErrorMessage( isbMsgErrr => sbmensaje);
			END IF;
		END IF;

		COMMIT;

		pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
			ROLLBACK;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
			ROLLBACK;
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;     
	END prcprocesaCambioDireccion;

END pkg_bocambio_direccion_ordenes;
/
BEGIN
	pkg_utilidades.prAplicarPermisos(upper('pkg_bocambio_direccion_ordenes'), 'PERSONALIZACIONES');
END;
/