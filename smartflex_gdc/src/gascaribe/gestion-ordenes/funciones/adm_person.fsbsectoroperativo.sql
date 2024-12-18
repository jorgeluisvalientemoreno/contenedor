CREATE OR REPLACE FUNCTION ADM_PERSON.FSBSECTOROPERATIVO ( INUSUBSCRIPTION IN NUMBER )
RETURN VARCHAR2 IS
  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : FSBSECTOROPERATIVO
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
                                        Se reemplaza SELECT-INTO por cursor CuSectorOperat
                                        Se declaran variables para la gestión de trazas
                                        Se ajusta el bloque de exceptiones según pautas técnicas                                         
  ******************************************************************/
    --Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef; 
    csbInicio   	       CONSTANT VARCHAR2(35) 	     := pkg_traza.csbINICIO;   
    Onuerrorcode         NUMBER:= pkg_error.CNUGENERIC_MESSAGE;		
    Osberrormessage      VARCHAR2(2000);
    
    SECTOROPERATIVO   VARCHAR2(115);
    
    CURSOR CuSectorOperat
    IS
    SELECT O.OPERATING_SECTOR_ID||' - '||O.DESCRIPTION  
      FROM AB_SEGMENTS B, AB_ADDRESS A, OR_OPERATING_SECTOR O, SUSCRIPC S
     WHERE B.SEGMENTS_ID = A.SEGMENT_ID
       AND B.OPERATING_SECTOR_ID = O.OPERATING_SECTOR_ID
       AND A.ADDRESS_ID = S.SUSCIDDI
       AND S.SUSCCODI = INUSUBSCRIPTION;
    
BEGIN
    
    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);
    pkg_traza.trace(csbMetodo ||' Inusubscription: ' || inusubscription, csbNivelTraza);
    
     OPEN CuSectorOperat;
    FETCH CuSectorOperat INTO SECTOROPERATIVO;
    CLOSE CuSectorOperat;

    pkg_traza.trace(csbMetodo ||' Sectoroperativo: ' || sectoroperativo, csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    
    RETURN ( SECTOROPERATIVO );

EXCEPTION
  WHEN PKG_ERROR.CONTROLLED_ERROR THEN
       pkg_Error.setError;
       pkg_Error.getError(onuerrorcode, osberrormessage);
       pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
       pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC); 
       RAISE PKG_ERROR.CONTROLLED_ERROR;
  WHEN OTHERS THEN
       PKG_ERROR.setError; 
       PKG_ERROR.getError(onuerrorcode, osberrormessage);
       pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
       pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);       
       RAISE PKG_ERROR.CONTROLLED_ERROR;
END FSBSECTOROPERATIVO;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion FSBSECTOROPERATIVO
BEGIN
    pkg_utilidades.prAplicarPermisos('FSBSECTOROPERATIVO', 'ADM_PERSON'); 
END;
/
PROMPT OTORGA PERMISOS a REPORTES sobre funcion FSBSECTOROPERATIVO
GRANT EXECUTE ON ADM_PERSON.FSBSECTOROPERATIVO TO REPORTES;
/
