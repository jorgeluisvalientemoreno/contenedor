CREATE OR REPLACE FUNCTION ADM_PERSON.LDC_FNCRETORNAPROCEJECIERR2(nupano NUMBER,
                                                                  nupmes NUMBER,
                                                                  sbprocet VARCHAR2) 
RETURN NUMBER IS
    /*****************************************************************
    Propiedad intelectual de JM GESTIONINFORMATICA S.A
    
    Funcion      : ldc_fncretornaprocejecierr2
    Descripci?n  : 
    Autor        : 
    Fecha        : 
    
    Historia de Modificaciones
    FECHA            AUTOR           DESCRIPCION
    20/02/2024       Adrianavg       OSF-2183: Se migra del esquema OPEN al esquema ADM_PERSON
                                     Se declaran variables para la gestión de trazas, se hace uso del pkg_traza.trace	
                                     Se adiciona el bloque de excepciones WHEN OTHERS según las pautas técnicas    
                                     Se reemplaza SELECT-INTO por cursor cuSali
    ******************************************************************/
    --Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;
	csbInicio   	     CONSTANT VARCHAR2(35) 	     := pkg_traza.csbINICIO; 
    Onuerrorcode         NUMBER:= pkg_error.CNUGENERIC_MESSAGE;
    Osberrormessage      VARCHAR2(2000);

    nusali NUMBER(10);
    
    CURSOR cuSali
    IS
    SELECT COUNT(1)
      FROM ldc_osf_estaproc lep
     WHERE lep.ano = nupano
      AND lep.mes = nupmes
      AND TRIM(lep.proceso) = TRIM(sbprocet)
      AND lep.fecha_inicial_ejec IS NOT NULL
      AND lep.fecha_final_ejec IS NOT NULL;
    
BEGIN
    
    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);
    pkg_traza.trace(csbMetodo ||' Ano: '  || nupano, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' Mes: '  || nupmes, csbNivelTraza);    
    pkg_traza.trace(csbMetodo ||' Proceso: '  || sbprocet, csbNivelTraza); 
    
    OPEN cuSali;
    FETCH cuSali INTO nusali;
    CLOSE cuSali;
    
    pkg_traza.trace(csbMetodo ||' nusali: ' || nusali, csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    
    RETURN nusali;
    
EXCEPTION 
    WHEN OTHERS THEN
         pkg_Error.setError;
         pkg_Error.getError(onuerrorcode, osberrormessage);
         pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
         RAISE pkg_Error.Controlled_Error;
END LDC_FNCRETORNAPROCEJECIERR2;
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion LDC_FNCRETORNAPROCEJECIERR2
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNCRETORNAPROCEJECIERR2', 'ADM_PERSON'); 
END;
/
