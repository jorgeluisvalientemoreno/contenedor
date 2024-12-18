CREATE OR REPLACE PROCEDURE ADM_PERSON.api_deladdress
(
     inuIdDireccion 	    in ab_address.address_id%type,
     onuErrorCode 			out ge_error_log.message_id%type,
     osbErrorMessage 		out ge_error_log.description%type
)
IS
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe

	Programa        : api_deladdress
    Descripcion     : Permite el borrado de una dirección si no está relacionada
                      con ningun cliente
    Autor           : Lubin Pineda
    Fecha           : 29/08/2024

	Parametros de Entrada
    inuIdDireccion 	Identificador de la dirección que se quiere borrar

    Parametros de Salida
	onuErrorCode      	Codigo de error
	osbErrorMessage   	Mensaje de error

	Modificaciones  :
    =========================================================
    Autor       Fecha           Descripción
    jpinedc     29/08/2024      OSF-3176: Creacion
***************************************************************************/
	csbMetodo      CONSTANT VARCHAR2(50) := 'api_deladdress';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    CURSOR cuCliente
    IS
    SELECT *
    FROM ge_subscriber sr
    WHERE sr.address_id = inuIdDireccion;
    
    rcCliente   cuCliente%ROWTYPE;
    	
BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    
    OPEN cuCliente;
    FETCH cuCliente INTO rcCliente;
    CLOSE cuCliente;
    
    IF rcCliente.subscriber_id IS NOT NULL THEN
        pkg_error.setErrorMessage( isbMsgErrr => 'No se puede borrar la dirección con id ' || inuIdDireccion || ' por que está asociada al cliente ' || rcCliente.subscriber_id  );
    ELSE

        os_deladdress
        (
            inuIdDireccion,
            onuErrorCode,
            osbErrorMessage
        );

        pkg_traza.trace('onuErrorCode: '||onuErrorCode, csbNivelTraza);
        pkg_traza.trace('osbErrorMessage: '||osbErrorMessage, csbNivelTraza);
        
    END IF;

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
EXCEPTION
    WHEN pkg_error.Controlled_Error THEN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
        pkg_Error.getError(onuErrorCode,osbErrorMessage);        
        pkg_traza.trace('osbErrorMessage => ' || osbErrorMessage, csbNivelTraza );
    WHEN OTHERS THEN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
        pkg_error.setError;
        pkg_Error.getError(onuErrorCode,osbErrorMessage);
        pkg_traza.trace('osbErrorMessage => ' || osbErrorMessage, csbNivelTraza );
END;
/
Prompt Otorgando permisos sobre ADM_PERSON.api_deladdress
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('api_deladdress'), 'ADM_PERSON');
END;
/
Prompt Otorgando permisos sobre ADM_PERSON.api_deladdress a GISOSF
GRANT EXECUTE ON ADM_PERSON.api_deladdress TO GISOSF
/