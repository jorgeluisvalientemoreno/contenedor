create or replace FUNCTION FSBGETCADENAENCRIPTADA
(
    isbCadena    IN varchar2,
	inuFuncion	 IN NUMBER DEFAULT 1
)
RETURN VARCHAR2
IS
    /******************************************************************************************
	Autor: Jhon Jairo Soto/Horbath
    Nombre Objeto: FSBGETCADENAENCRIPTADA
    Tipo de objeto: Funcion
    Parametros de entrada
    Nombre              Tipo                                        Descripcion
    ----------------------------------------------------------------------------------------------
    isbCadena	        varchar2	      	IN          			Cadena a encriptar
	inuFuncion			NUMBER				IN						1. Encriptar una Cadena	
																	2. Encriptar dirección


	Fecha: 23-09-2024
	Ticket: OSF-3315
	Descripcion:    Para protección de datos de formatos impresos se encripta la cadena que viene como parametro de entrada

	Historia de modificaciones
	Fecha		Autor			    Descripcion
	23-09-2024	Jhon Jairo Soto	    Creacion
	******************************************************************************************/

    --Variables del proceso
    sbValor          	VARCHAR2(4000);
    csbMetodo        	VARCHAR2(50) := 'FSBGETCADENAENCRIPTADA';
    sbError             VARCHAR2(4000);
    nuError             NUMBER;

BEGIN

 pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);   

	IF inuFuncion = 1 THEN
		
		sbValor := FSBENCRIPTACADENA(isbCadena);
	
	ELSIF inuFuncion = 2 THEN
	
		sbValor := FSBENCRIPTADIRECCION(isbCadena);
	
	END IF;
 
 pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
 
 RETURN sbValor;

EXCEPTION
    WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN sbValor;
END FSBGETCADENAENCRIPTADA;
/
Prompt Otorgando permisos sobre FSBGETCADENAENCRIPTADA
BEGIN
    pkg_utilidades.prAplicarPermisos( 'FSBGETCADENAENCRIPTADA', 'OPEN');
END;
/
