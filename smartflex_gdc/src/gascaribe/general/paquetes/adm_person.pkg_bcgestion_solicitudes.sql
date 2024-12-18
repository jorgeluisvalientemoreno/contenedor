CREATE OR REPLACE PACKAGE ADM_PERSON.PKG_BCGESTION_SOLICITUDES IS
	/*******************************************************************************
		Fuente=Propiedad Intelectual de Gases del Caribe
		pkg_bcordenes
		Autor       :   Jhon Eduar Erazo
		Fecha       :   29-02-2024
		Descripcion :   Paquete con los metodos para manejo de información sobre las 
						solicitudes
		Modificaciones  :
		Autor       Fecha       Caso     	Descripcion
		jerazomvm	29/02/2022	OSF-2374	Creación
	*******************************************************************************/
	
	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 27-02-2024 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
            <Modificacion Autor="Jhon.Erazo" Fecha="27-02-2024" Inc="OSF-2374" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2;
	
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcObtienProductxSolicitud
    Descripcion     : Busca los productos asociados a la solicitud.
    Autor           : Jhon Erazo
    Fecha           : 29-02-2024
  
    Parametros de Entrada
      inuSolicitudId	identificador de la solicitud
	  
    Parametros de Salida
		otbProducto		Tabla con los productos
  
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    	Descripcion
	jerazomvm	29/02/2024	OSF-2374	Creación
	***************************************************************************/	
	PROCEDURE prcObtienProductxSolicitud(inuSolicitudId  IN  mo_packages.package_id%TYPE,
										 otbProducto  	 OUT pkg_bcproducto.tytbproduct_id
										 );

	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuMotivoxSoliciyProd
    Descripcion     : Obtiene el código del motivo dado el producto y la solicitud.
    Autor           : Jhon Erazo
    Fecha           : 29-02-2024
  
    Parametros de Entrada
		inuSolicitudId	identificador de la solicitud
		inuProductoId	Identificador del producto
	  
    Parametros de Salida
  
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    	Descripcion
	jerazomvm	29/02/2024	OSF-2374	Creación
	***************************************************************************/
	FUNCTION fnuMotivoxSoliciyProd(inuSolicitudId   mo_packages.package_id%TYPE,
								   inuProductoId	pr_product.product_id%TYPE
								   )
	RETURN mo_motive.motive_id%TYPE;
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtieValorAnteriorAttri
    Descripcion     : Obtiene el valor anterior en la entidad MO_DATA_CHANGE, dado
						la entidad, el atributo, el motivo y la llave primaria.
    Autor           : Jhon Erazo
    Fecha           : 01-03-2024
  
    Parametros de Entrada
		isbNombreEntidad	Nombre de la entidad
		isbNombreAtributo	Nombre del atributo
		inuMotivoId			Identificador del motivo
		isbLlavePrimaria	LLave primaria
	  
    Parametros de Salida
  
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    	Descripcion
	jerazomvm	01/03/2024	OSF-2374	Creación
	***************************************************************************/
	FUNCTION fnuObtieValorAnteriorAttri(isbNombreEntidad    IN mo_data_change.entity_name%TYPE,
										isbNombreAtributo   IN mo_data_change.attribute_name%TYPE,
										inuMotivoId     	IN mo_data_change.motive_id%TYPE,
										isbLlavePrimaria    IN mo_data_change.entity_pk%TYPE
										)
	RETURN mo_data_change.entity_attr_old_val%TYPE;
	
END PKG_BCGESTION_SOLICITUDES;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.PKG_BCGESTION_SOLICITUDES IS

    -- Constantes para el control de la traza
    csbSP_NAME 	CONSTANT VARCHAR2(35) := $$PLSQL_UNIT||'.';
	cnuNVLTRC   CONSTANT NUMBER       := pkg_traza.cnuNivelTrzDef;
	csbInicio   CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;
	
    -- Identificador del ultimo caso que hizo cambios
    csbVersion 	VARCHAR2(15) := 'OSF-2374';

	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon.Erazo </Autor>
    <Fecha> 29-02-2024 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="29-02-2024" Inc="OSF-2374" Empresa="GDC"> 
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2
    IS
    BEGIN
        return CSBVERSION;
    END fsbVersion;
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcObtienProductxSolicitud
    Descripcion     : Busca los productos asociados a la solicitud.
    Autor           : Jhon Erazo
    Fecha           : 29-02-2024
  
    Parametros de Entrada
      inuSolicitudId	identificador de la solicitud
	  
    Parametros de Salida
		otbProducto		Tabla con los productos
  
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    	Descripcion
	jerazomvm	29/02/2024	OSF-2374	Creación
	***************************************************************************/	
	PROCEDURE prcObtienProductxSolicitud(inuSolicitudId  IN  mo_packages.package_id%TYPE,
										 otbProducto  	 OUT pkg_bcproducto.tytbproduct_id
										 )
	IS
	
		csbMETODO   CONSTANT VARCHAR2(100) := csbSP_NAME ||'prcObtienProductxSolicitud';
		nuError		NUMBER;  
		sbmensaje   VARCHAR2(1000);
		
		CURSOR cuProductxSolicitud IS
			SELECT o.product_id
			FROM mo_motive o, 
				 mo_packages m
			WHERE m.package_id  = inuSolicitudId
			AND m.package_id 	= o.package_id;
			

	BEGIN

		pkg_traza.trace(csbMETODO, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuSolicitudId: '	|| inuSolicitudId, cnuNVLTRC);
		
		IF (cuProductxSolicitud%ISOPEN) THEN
			CLOSE cuProductxSolicitud;
		END IF;
		
		OPEN cuProductxSolicitud;
		FETCH cuProductxSolicitud BULK COLLECT INTO otbProducto;
		CLOSE cuProductxSolicitud;

		pkg_traza.trace(csbMETODO, cnuNVLTRC, pkg_traza.csbFIN);

	EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
			RAISE pkg_error.CONTROLLED_ERROR;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR); 
			RAISE pkg_Error.Controlled_Error;
	END prcObtienProductxSolicitud;
  
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuMotivoxSoliciyProd
    Descripcion     : Obtiene el código del motivo dado el producto y la solicitud.
    Autor           : Jhon Erazo
    Fecha           : 29-02-2024
  
    Parametros de Entrada
		inuSolicitudId	identificador de la solicitud
		inuProductoId	Identificador del producto
	  
    Parametros de Salida
  
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    	Descripcion
	jerazomvm	29/02/2024	OSF-2374	Creación
	***************************************************************************/
	FUNCTION fnuMotivoxSoliciyProd(inuSolicitudId   mo_packages.package_id%TYPE,
								   inuProductoId	pr_product.product_id%TYPE
								   )
	RETURN mo_motive.motive_id%TYPE
	IS
	
		csbMETODO   CONSTANT VARCHAR2(100) := csbSP_NAME ||'fnuMotivoxSoliciyProd';
		nuError		NUMBER;  
		nuMotiveId 	mo_motive.motive_id%TYPE;
		sbmensaje   VARCHAR2(1000);
		
		CURSOR cuMotivoxSolicyProdu IS
			SELECT  motive_id
			FROM mo_motive
			WHERE package_id = inuSolicitudId
            AND product_id 	 = inuProductoId;			
		
	BEGIN

		pkg_traza.trace(csbMETODO, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuSolicitudId: '	|| inuSolicitudId || chr(10) ||
						'inuProductoId: ' 	|| inuProductoId, cnuNVLTRC);
						
		IF (cuMotivoxSolicyProdu%ISOPEN) THEN
			CLOSE cuMotivoxSolicyProdu;
		END IF;
		
		OPEN cuMotivoxSolicyProdu;
        FETCH cuMotivoxSolicyProdu INTO nuMotiveId;
		CLOSE cuMotivoxSolicyProdu;
		
		pkg_traza.trace('nuMotiveId: '	|| nuMotiveId, cnuNVLTRC);

		pkg_traza.trace(csbMETODO, cnuNVLTRC, pkg_traza.csbFIN);

		RETURN nuMotiveId;

	EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
			RAISE pkg_error.CONTROLLED_ERROR;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR); 
			RAISE pkg_Error.Controlled_Error;
	END fnuMotivoxSoliciyProd;
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtieValorAnteriorAttri
    Descripcion     : Obtiene el valor anterior en la entidad MO_DATA_CHANGE, dado
						la entidad, el atributo, el motivo y la llave primaria.
    Autor           : Jhon Erazo
    Fecha           : 01-03-2024
  
    Parametros de Entrada
		isbNombreEntidad	Nombre de la entidad
		isbNombreAtributo	Nombre del atributo
		inuMotivoId			Identificador del motivo
		isbLlavePrimaria	LLave primaria
		
    Parametros de Salida
  
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    	Descripcion
	jerazomvm	01/03/2024	OSF-2374	Creación
	***************************************************************************/
	FUNCTION fnuObtieValorAnteriorAttri(isbNombreEntidad    IN mo_data_change.entity_name%TYPE,
										isbNombreAtributo   IN mo_data_change.attribute_name%TYPE,
										inuMotivoId     	IN mo_data_change.motive_id%TYPE,
										isbLlavePrimaria    IN mo_data_change.entity_pk%TYPE
										)
	RETURN mo_data_change.entity_attr_old_val%TYPE
	IS
		
		csbMETODO   	CONSTANT VARCHAR2(100) := csbSP_NAME ||'fnuObtieValorAnteriorAttri';
		nuError			NUMBER;  
		nuValorAnteriorAtribu	mo_data_change.entity_attr_old_val%TYPE;
		sbmensaje   	VARCHAR2(1000);
		
		CURSOR cuValorAnteriorAtribu IS
			SELECT entity_attr_old_val
			FROM mo_data_change
			WHERE motive_id 	= inuMotivoId
            AND entity_name 	= isbNombreEntidad
            AND attribute_name  = isbNombreAtributo
            AND entity_pk 		= isbLlavePrimaria;
			
		
	BEGIN

		pkg_traza.trace(csbMETODO, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('isbNombreEntidad: '	|| isbNombreEntidad 	|| chr(10) ||
						'isbNombreAtributo: ' 	|| isbNombreAtributo 	|| chr(10) ||
						'inuMotivoId: ' 		|| inuMotivoId 			|| chr(10) ||
						'isbLlavePrimaria: ' 	|| isbLlavePrimaria, cnuNVLTRC);
						
		IF (cuValorAnteriorAtribu%ISOPEN) THEN
			CLOSE cuValorAnteriorAtribu;
		END IF;
		
		OPEN cuValorAnteriorAtribu;
        FETCH cuValorAnteriorAtribu INTO nuValorAnteriorAtribu;
		CLOSE cuValorAnteriorAtribu;
		
		pkg_traza.trace('nuValorAnteriorAtribu: '	|| nuValorAnteriorAtribu, cnuNVLTRC);

		pkg_traza.trace(csbMETODO, cnuNVLTRC, pkg_traza.csbFIN);

		RETURN nuValorAnteriorAtribu;

	EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
			RAISE pkg_error.CONTROLLED_ERROR;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR); 
			RAISE pkg_Error.Controlled_Error;
	END fnuObtieValorAnteriorAttri;

END PKG_BCGESTION_SOLICITUDES;
/
PROMPT Otorgando permisos de ejecución para adm_person.PKG_BCGESTION_SOLICITUDES
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BCGESTION_SOLICITUDES', 'ADM_PERSON');
END;
/