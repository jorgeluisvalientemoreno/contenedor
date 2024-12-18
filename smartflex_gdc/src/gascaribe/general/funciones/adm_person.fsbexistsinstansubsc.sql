CREATE OR REPLACE FUNCTION ADM_PERSON.FSBEXISTSINSTANSUBSC (ISBINSTANCE   IN VARCHAR2,
                                                            ISBGROUP      IN VARCHAR2,
                                                            ISBENTITY     IN VARCHAR2,
                                                            ISBATTRIBUTE  IN VARCHAR2)
RETURN VARCHAR2 IS
  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : FSBEXISTSINSTANSUBSC
    Descripcion    : 
    Autor          :
    Fecha          :

    Parametros              Descripcion
    ============         ===================

    Fecha             Autor             Modificacion
    =========       =========           ====================
    07/02/2023     Adrianavg            OSF-2097: Migrar del esquema OPEN al esquema ADM_PERSON
                                        Se reemplaza ex.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                        Se reemplaza Errors.setError por PKG_ERROR.setError
                                        Se declaran variables para la gestión de trazas, se hace uso del pkg_traza.trace                                        
                                        Se ajusta el bloque de exceptiones según pautas técnicas
  ******************************************************************/
    --Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef; 
    csbInicio   	       CONSTANT VARCHAR2(35) 	     := pkg_traza.csbINICIO;   
    Onuerrorcode         NUMBER:= pkg_error.CNUGENERIC_MESSAGE;	
    Osberrormessage      VARCHAR2(2000);
    
    nuValue        NUMBER := 1;
    boResult       BOOLEAN := FALSE;
BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);
    pkg_traza.trace(csbMetodo ||' ISBINSTANCE: ' || ISBINSTANCE, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' ISBGROUP: ' || ISBGROUP, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' ISBENTITY: ' || ISBENTITY, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' ISBATTRIBUTE: ' || ISBATTRIBUTE, csbNivelTraza);
    
    boResult := GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK(ISBINSTANCE, ISBGROUP, ISBENTITY, ISBATTRIBUTE, nuValue);
    pkg_traza.trace(csbMetodo ||' nuValue: ' || nuValue, csbNivelTraza);

    IF boResult THEN
       pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
       RETURN 'Y';
    END IF;
    
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN 'N';

EXCEPTION
    WHEN pkg_error.controlled_error THEN
         pkg_error.seterror;
         pkg_Error.getError(onuerrorcode, osberrormessage);
         pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
         RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN 
         pkg_error.seterror;
         pkg_Error.getError(onuerrorcode, osberrormessage);
         pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
         RAISE pkg_error.controlled_error; 
END fsbExistsInstanSubsc;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion FSBEXISTSINSTANSUBSC
BEGIN
    pkg_utilidades.prAplicarPermisos('FSBEXISTSINSTANSUBSC', 'ADM_PERSON'); 
END;
/
PROMPT OTORGA PERMISOS a REPORTES sobre funcion FSBEXISTSINSTANSUBSC
GRANT EXECUTE ON ADM_PERSON.FSBEXISTSINSTANSUBSC TO REPORTES;
/
