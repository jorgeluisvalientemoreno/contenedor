CREATE OR REPLACE FUNCTION ADM_PERSON.FNUGETORACLEEDITION 
RETURN NUMBER IS
/*******************************************************************************
  Propiedad intelectual de GDC

  Descripcion    :  
  Autor          : 
  Fecha          : 

  Fecha                IDEntrega           Modificacion
  ============    ================    ============================================
  20/02/2024        Adrianavg         OSF-2183: Se migra del esquema OPEN al esquema ADM_PERSON
                                      Se declaran variables para la gestión de trazas, se hace uso del pkg_traza.trace
                                      Se ajusta el bloque de excepciones según las pautas técnicas
  *******************************************************************************/
    --Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;
	csbInicio   	     CONSTANT VARCHAR2(35) 	     := pkg_traza.csbINICIO; 
    Onuerrorcode         NUMBER:= pkg_error.CNUGENERIC_MESSAGE;
    Osberrormessage      VARCHAR2(2000);
    
    CURSOR cuGetBannerVersion
    IS
    SELECT banner
      FROM v$version
     WHERE UPPER(banner) LIKE UPPER('Oracle Database%');

    rGetBannerVersion cuGetBannerVersion%ROWTYPE;
    nuDatabase NUMBER;
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);

    OPEN cuGetBannerVersion;
    FETCH cuGetBannerVersion INTO rGetBannerVersion;
    CLOSE cuGetBannerVersion;
    pkg_traza.trace(csbMetodo ||' BannerVersion: ' || rGetBannerVersion.banner, csbNivelTraza);
    
    IF INSTR( UPPER(rGetBannerVersion.banner), 'EXPRESS') > 0 THEN
        nuDatabase := 3;
    ELSIF INSTR( UPPER(rGetBannerVersion.banner), 'STANDARD') > 0 THEN
        nuDatabase := 0;
    ELSIF INSTR( UPPER(rGetBannerVersion.banner), 'PERSONAL') > 0 THEN
        nuDatabase := 2;
    ELSIF INSTR( UPPER(rGetBannerVersion.banner), 'ENTERPRISE') > 0 THEN
        nuDatabase := 1;
    ELSE
        nuDatabase := 0;
    END IF;
    
    pkg_traza.trace(csbMetodo ||' nuDatabase: ' || nuDatabase, csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    
    RETURN nuDatabase;
EXCEPTION
    WHEN OTHERS THEN
         pkg_Error.setError;
         pkg_Error.getError(onuerrorcode, osberrormessage);
         pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
         RETURN 'ERROR:' || SQLERRM(SQLCODE);
END fnuGetOracleEdition;
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion FNUGETORACLEEDITION
BEGIN
    pkg_utilidades.prAplicarPermisos('FNUGETORACLEEDITION', 'ADM_PERSON'); 
END;
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS a REXEREPORTES sobre funcion FNUGETORACLEEDITION
GRANT EXECUTE ON ADM_PERSON.FNUGETORACLEEDITION TO REXEREPORTES;
/
