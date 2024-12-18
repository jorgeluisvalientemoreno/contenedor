CREATE OR REPLACE PROCEDURE ADM_PERSON.PRC_OBTIENEVALORINSTANCIA
(
	isbInstancia 	IN VARCHAR2,
	isbGrupo 		IN VARCHAR2,
	isbEntidad 		IN VARCHAR2,
	isbAtributo 	IN VARCHAR2,
	osbValor 		OUT VARCHAR2
)
IS

	/*****************************************************************
	Unidad         : PRC_OBTIENEVALORINSTANCIA
	Descripcion    : Obtiene el valor de la instancia

	Autor          : Carlos Gonzalez
	Fecha          : 21/12/2023

	Parametros          Descripcion
	============        ===================
	Entrada
		isbInstancia	Instancia
		isbGrupo		Grupo
		isbEntidad		Entidad
		isbAtributo		Atributo
		
	Salida
		osbValor		Valor de la instancia

	Historia de Modificaciones

	DD-MM-YYYY    <Autor>           Modificacion
	-----------  ---------------	-------------------------------------
	21/12/2023   cgonzalez        	OSF-2093: Creación.
	******************************************************************/
  
	--<<
	-- Variables del proceso
	-- Constantes para el control de la traza
	csbSP_NAME 	CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
	cnuNVLTRC 	CONSTANT NUMBER 		:= pkg_traza.cnuNivelTrzDef;
	csbInicio   CONSTANT VARCHAR2(35) 	:= pkg_traza.fsbINICIO;
	
	nuCodError			NUMBER;
	sbErrorMessage  	VARCHAR2(4000);	
	-->>

BEGIN

	pkg_traza.trace(csbSP_NAME, cnuNVLTRC, csbInicio);
	
	pkg_traza.trace('isbInstancia: '|| isbInstancia, cnuNVLTRC);
	pkg_traza.trace('isbGrupo: '|| isbGrupo, cnuNVLTRC);
	pkg_traza.trace('isbEntidad: '|| isbEntidad, cnuNVLTRC);
	pkg_traza.trace('isbAtributo: '|| isbAtributo, cnuNVLTRC);
	
	ge_boInstanceControl.GetAttributeNewValue(isbInstancia, isbGrupo, isbEntidad, isbAtributo, osbValor);
											  
	pkg_traza.trace('El valor de la instancia es: ' || osbValor, cnuNVLTRC);
	
	pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN);

EXCEPTION
	WHEN others THEN
		Pkg_Error.seterror;
		pkg_error.geterror(nuCodError, sbErrorMessage);
		pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
		pkg_traza.trace('nuCodError: ' || nuCodError || ', ' || 'sbErrorMessage: ' || sbErrorMessage, cnuNVLTRC);
		raise PKG_ERROR.CONTROLLED_ERROR;
END PRC_OBTIENEVALORINSTANCIA;
/
PROMPT Otorgando permisos de ejecución a PRC_OBTIENEVALORINSTANCIA
BEGIN
	pkg_utilidades.prAplicarPermisos('PRC_OBTIENEVALORINSTANCIA', 'ADM_PERSON'); 
END;
/