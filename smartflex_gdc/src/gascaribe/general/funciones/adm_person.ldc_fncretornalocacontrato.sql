create or replace FUNCTION ADM_PERSON.LDC_FNCRETORNALOCACONTRATO (nucontrato suscripc.susccodi%TYPE
) RETURN NUMBER IS
    /*****************************************************************
    Propiedad intelectual de JM GESTIONINFORMATICA S.A
    
    Funcion      : ldc_fncretornalocacontrato
    Descripci?n  : Función que retorna la localidad del contrato
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
    
    CURSOR culocalidacontrato(nucunucontrato suscripc.susccodi%TYPE) 
    IS
    SELECT di.geograp_location_id localidad
      FROM suscripc su, ab_address di
     WHERE su.susccodi = nucunucontrato
      AND su.susciddi = di.address_id;
    
    nulocacont ge_geogra_location.geograp_location_id%TYPE;
    
BEGIN
    
    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);
    pkg_traza.trace(csbMetodo ||' Contrato: '  || nucontrato, csbNivelTraza);
    
    FOR i IN culocalidacontrato(nucontrato) LOOP
        nulocacont := i.localidad;
    END LOOP;
    
    pkg_traza.trace(csbMetodo ||' Localidad Geografica de la Suscripción: ' || nulocacont, csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    
    RETURN nulocacont;
EXCEPTION 
    WHEN OTHERS THEN
         pkg_Error.setError;
         pkg_Error.getError(onuerrorcode, osberrormessage);
         pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
         RAISE pkg_Error.Controlled_Error;
END LDC_FNCRETORNALOCACONTRATO;
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion LDC_FNCRETORNALOCACONTRATO
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNCRETORNALOCACONTRATO', 'ADM_PERSON'); 
END;
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS a REXEREPORTES sobre funcion LDC_FNCRETORNALOCACONTRATO
GRANT EXECUTE ON ADM_PERSON.LDC_FNCRETORNALOCACONTRATO TO REXEREPORTES;
/ 