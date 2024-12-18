CREATE OR REPLACE PACKAGE adm_person.pkg_or_extern_systems_id IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe
    
	Programa 	: pkg_or_extern_systems_id
	Autor       : Luis Felipe Valencia Hurtado
    Fecha       : 12-03-2024
    Descripcion : Paquete con servicios CRUD sobre la entidad OPEN.or_extern_systems_id
    
	Modificaciones  :
    Autor       		Fecha       Caso    	Descripcion
    felipe.valencia   	12-03-2024  OSF-2623 	Creacion
*******************************************************************************/

	PROCEDURE prcactualizaDireccExterna
	(
		inuOrden    	IN  or_order.order_id%type,
		isbDireccion 	IN  or_order.external_address_id%type,
		onuError    	OUT NUMBER,
		osbError    	OUT VARCHAR2
	);
END pkg_or_extern_systems_id;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_or_extern_systems_id IS
	
	-- Constantes para el control de la traza
	csbSP_NAME     CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;
	
	-- Identificador del ultimo caso que hizo cambios
	csbVersion     CONSTANT VARCHAR2(15) := 'OSF-2623';

	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    
	Programa        : fsbVersion
	Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor       	: Luis Felipe Valencia Hurtado
    Fecha       	: 12-03-2024

    Modificaciones  :
    Autor       		Fecha       Caso     	Descripcion
    felipe.valencia   	12-03-2024  OSF-2623 	Creacion
	***************************************************************************/
	FUNCTION fsbVersion 
	RETURN VARCHAR2 
	IS
	BEGIN
		RETURN csbVersion;
	END fsbVersion;
	

	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    
	Programa        : prc_ActualizaDireccionActividad
    Descripcion     : Actualizar la dirección de la externa de la orden

    Autor       	:   Luis Felipe Valencia Hurtado
    Fecha       	:   12-0-32024

    Parametros de Entrada
      inuOrden        	Identificador de la orden
      isbDireccion 		Identificador de la Direccion
    Parametros de Salida
      onuError       codigo de error
      osbError       mensaje de error
    
	Modificaciones  :
    Autor       		Fecha       Caso     	Descripcion
    felipe.valencia   	12-03-2024  OSF-2623 	Creación
	***************************************************************************/
	PROCEDURE prcactualizaDireccExterna
	(
		inuOrden    	IN  or_order.order_id%type,
		isbDireccion 	IN  or_order.external_address_id%type,
		onuError    	OUT NUMBER,
		osbError    	OUT VARCHAR2
	) 
	IS
		csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prcactualizaDireccExterna';
	BEGIN
		pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
		pkg_traza.trace('inuOrden => ' || inuOrden, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace('isbDireccion => ' || isbDireccion, pkg_traza.cnuNivelTrzDef);
		pkg_error.prInicializaError(onuError, osbError);

		UPDATE or_extern_systems_id SET address_id = isbDireccion WHERE order_id = inuOrden;

		pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

	EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.geterror(onuError,osbError);
			pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
			pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
		WHEN OTHERS THEN
			pkg_error.setError;
			pkg_error.geterror(onuError,osbError);
			pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
			pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
	END prcactualizaDireccExterna;

END pkg_or_extern_systems_id;
/
BEGIN
	pkg_utilidades.prAplicarPermisos('PKG_OR_EXTERN_SYSTEMS_ID', 'ADM_PERSON');
END;
/