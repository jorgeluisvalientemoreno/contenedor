CREATE OR REPLACE FUNCTION ADM_PERSON.FSBGETCALIFICACION (inuProductId IN NUMBER) RETURN VARCHAR2
IS
  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fsbGetCalificacion
    Descripcion    : Función que retorna la ultima calificación de un producto
    Fecha          : 02/02/2013

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================
    
    
    Fecha             Autor             Modificacion
    =========       =========           ====================
    07/02/2023     Adrianavg            OSF-2097: Migrar del esquema OPEN al esquema ADM_PERSON   
                                        Se declaran variables para la gestión de trazas
                                        Se ajusta el bloque de exceptiones según pautas técnicas 
    ****************************************************/
    --Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef; 
    csbInicio   	     CONSTANT VARCHAR2(35) 	     := pkg_traza.csbINICIO;   
    Onuerrorcode         NUMBER:= pkg_error.CNUGENERIC_MESSAGE;	
    Osberrormessage      VARCHAR2(2000);
    
    sbCalificacion CALIVACO.CAVCDESC%TYPE;
    CURSOR cuDesc
    IS
    SELECT CAVCDESC
     FROM CONSSESU join CALIVACO on COSSCAVC = CAVCCODI
    WHERE COSSFERE = (SELECT MAX(COSSFERE)
                        FROM CONSSESU
                       WHERE COSSSESU = inuProductId
                         AND COSSMECC = 1)
     AND COSSSESU = inuProductId
     AND COSSMECC = 1;
     
BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);
    pkg_traza.trace(csbMetodo ||' inuProductId: ' || inuProductId, csbNivelTraza);
    
    OPEN cudesc;
    FETCH cudesc INTO sbcalificacion;
    IF cudesc%notfound THEN
        sbcalificacion := '';
    END IF;
    CLOSE cudesc; 
    
    pkg_traza.trace(csbMetodo ||' sbcalificacion: ' || sbcalificacion, csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    
    RETURN ' CALIFICACIÓN: ' || sbcalificacion;

EXCEPTION
    WHEN OTHERS THEN
         IF cudesc%isopen THEN
            CLOSE cudesc;
         END IF;
         pkg_error.seterror;
         pkg_Error.getError(onuerrorcode, osberrormessage);
         pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);    
         RETURN '';
END;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion FSBGETCALIFICACION
BEGIN
    pkg_utilidades.prAplicarPermisos('FSBGETCALIFICACION', 'ADM_PERSON'); 
END;
/
PROMPT OTORGA PERMISOS a REPORTES sobre funcion FSBGETCALIFICACION
GRANT EXECUTE ON ADM_PERSON.FSBGETCALIFICACION TO REPORTES;
/

