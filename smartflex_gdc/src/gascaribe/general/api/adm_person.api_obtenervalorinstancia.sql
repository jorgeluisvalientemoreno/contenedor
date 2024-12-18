create or replace FUNCTION adm_person.API_OBTENERVALORINSTANCIA(ISBENTIDAD   IN GE_ENTITY.NAME_%TYPE,
																ISBATRIBUTO  IN GE_ENTITY_ATTRIBUTES.TECHNICAL_NAME%TYPE
																)		
RETURN VARCHAR2																 
IS
/***************************************************************************
	Propiedad Intelectual de Gases del Caribe
	
    Programa        : API_OBTENERVALORINSTANCIA
    Descripcion     : Api para obtener el valor de la instancia.
    Autor           : Jhon Eduar Erazo Guchavez
    Fecha           : 27-10-2023
	 
    Parametros de Entrada
    
	Parametros de Salida
		
    Modificaciones  :
    =========================================================
    Autor       Fecha           Caso		Descripción
	jerazomvm	27-10-2023		OSF-1813	Creación
***************************************************************************/

	-- Constantes para el control de la traza
	csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    cnuNVLTRC       CONSTANT NUMBER(2)  	:= pkg_traza.fnuNivelTrzDef;
	
	sbInstancia		VARCHAR2(1000);
	
BEGIN

	pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.fsbINICIO);
		
	pkg_traza.trace('ISBENTIDAD: ' 	|| ISBENTIDAD || chr(10) ||
					'ISBATRIBUTO: '	|| ISBATRIBUTO, cnuNVLTRC);

	sbInstancia := ObtenerValorInstancia(ISBENTIDAD,
										 ISBATRIBUTO
										 );
										 
	pkg_traza.trace('sbInstancia: ' 	|| sbInstancia, cnuNVLTRC);													  
							
	pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN);
	
	RETURN sbInstancia;							

EXCEPTION
	WHEN PKG_ERROR.CONTROLLED_ERROR THEN
		pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
		RAISE PKG_ERROR.CONTROLLED_ERROR;
	WHEN OTHERS THEN
		pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
		pkg_Error.SETERROR;
		RAISE PKG_ERROR.CONTROLLED_ERROR;
END API_OBTENERVALORINSTANCIA;
/
BEGIN

	pkg_utilidades.prAplicarPermisos('API_OBTENERVALORINSTANCIA', 'ADM_PERSON'); 

END;
/