CREATE OR REPLACE FUNCTION ADM_PERSON.LDC_FNCRETORNALOCACLIENTE ( nucliente ge_subscriber.subscriber_id%TYPE
) RETURN NUMBER IS
    /*****************************************************************
    Propiedad intelectual de JM GESTIONINFORMATICA S.A
    
    Funcion      : ldc_fncretornalocacliente
    Descripci?n  : Función que retorna la localidad del cliente
    Autor        : John Jairo Jimenez Marimon
    Fecha        : 15-06-2016
    
    Historia de Modificaciones
    FECHA            AUTOR           DESCRIPCION
    20/02/2024       Adrianavg       OSF-2183: Se migra del esquema OPEN al esquema ADM_PERSON
                                     Se declaran variables para la gestión de trazas, se hace uso del pkg_traza.trace	
                                     Se adiciona el bloque de excepciones WHEN OTHERS según las pautas técnicas	 
    ******************************************************************/
    --Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;
	csbInicio   	     CONSTANT VARCHAR2(35) 	     := pkg_traza.csbINICIO; 
    Onuerrorcode         NUMBER:= pkg_error.CNUGENERIC_MESSAGE;
    Osberrormessage      VARCHAR2(2000);

    CURSOR culocalidacliente(nucunucliente ge_subscriber.subscriber_id%TYPE) IS
    SELECT di.geograp_location_id localidad
      FROM ge_subscriber cl, ab_address di
     WHERE cl.subscriber_id = nucunucliente
       AND cl.address_id    = di.address_id;
       
    nulocaclie ge_geogra_location.geograp_location_id%TYPE;
    
BEGIN
    
    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);
    pkg_traza.trace(csbMetodo ||' cliente: '  || nucliente, csbNivelTraza);
    
    FOR i IN culocalidacliente(nucliente) LOOP
        nulocaclie := i.localidad;
    END LOOP;
    
    pkg_traza.trace(csbMetodo ||' localidad del cliente: ' || nulocaclie, csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    
    RETURN nulocaclie;
    
EXCEPTION 
    WHEN OTHERS THEN
         pkg_Error.setError;
         pkg_Error.getError(onuerrorcode, osberrormessage);
         pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
         RAISE pkg_Error.Controlled_Error;
END LDC_FNCRETORNALOCACLIENTE;
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion LDC_FNCRETORNALOCACLIENTE
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNCRETORNALOCACLIENTE', 'ADM_PERSON'); 
END;
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS a REXEREPORTES sobre funcion LDC_FNCRETORNALOCACLIENTE
GRANT EXECUTE ON ADM_PERSON.LDC_FNCRETORNALOCACLIENTE TO REXEREPORTES;
/ 