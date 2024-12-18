CREATE OR REPLACE FUNCTION ADM_PERSON.LDC_FNUGETULTIMOBLOQUEO(inuPackageId IN ldc_asigna_unidad_rev_per.solicitud_generada%TYPE)
RETURN NUMBER
IS PRAGMA AUTONOMOUS_TRANSACTION;

  /*****************************************************************
   Propiedad intelectual de Gases del Caribe S.A.

   Unidad         : ldc_fnugetultimobloqueo
   Descripcion    : Consulta si existe un registro de bloqueo por solicitud
                    en la tabla ldc_order
   Autor          : Luis Felipe Valencia Hurtado
   Fecha          :

   Parametros              Descripcion
   ============         ===================
   inuPackageId         Número de solicitud


   Historia de Modificaciones
   Fecha             Autor          Modificacion
   =========       =========       ====================
   15/02/2023      Adrianavg       OSF-2181: Migrar del esquema OPEN al esquema ADM_PERSON                                   
                                   Se declaran variables para la gestión de trazas, se hace uso del pkg_traza.trace
                                   Se ajusta el bloque de exceptiones según pautas técnicas, se retira variable sbErrMsg
   ******************************************************************/
    --Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef; 
    csbInicio   	     CONSTANT VARCHAR2(35) 	     := pkg_traza.csbINICIO;   
    Onuerrorcode         NUMBER:= pkg_error.CNUGENERIC_MESSAGE;	
    Osberrormessage      VARCHAR2(2000);
    
    CURSOR cuLdc_order IS
    SELECT COUNT('X')
      FROM ldc_order o
     WHERE o.package_id = inuPackageId;

    nuCount     NUMBER; 
    
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);
    pkg_traza.trace(csbMetodo ||' inuPackageId: ' || inuPackageId, csbNivelTraza); 

    nuCount := 0;

    OPEN cuLdc_order;
    FETCH cuLdc_order INTO nuCount;
    CLOSE cuLdc_order;

    pkg_traza.trace(csbMetodo ||' nuCount: ' || nuCount, csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
    RETURN nuCount;

EXCEPTION
    WHEN LOGIN_DENIED THEN
         IF(cuLdc_order%ISOPEN) THEN
             CLOSE cuLdc_order;
         END IF;
         pkg_Error.setError;
         pkg_Error.getError(onuerrorcode, osberrormessage);
         pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
         RAISE LOGIN_DENIED; 

    WHEN pkg_Error.Controlled_Error THEN
         IF(cuLdc_order%isopen) THEN
             CLOSE cuLdc_order;
         END IF;
         pkg_Error.setError;
         pkg_Error.getError(onuerrorcode, osberrormessage);
         pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
         RAISE pkg_Error.Controlled_Error; 

    WHEN OTHERS THEN
         IF(cuLdc_order%isopen) THEN
            CLOSE cuLdc_order;
         END IF;
         pkg_Error.setError;
         pkg_Error.getError(onuerrorcode, osberrormessage);
         pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
         RAISE pkg_Error.Controlled_Error; 
END LDC_FNUGETULTIMOBLOQUEO;
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion LDC_FNUGETULTIMOBLOQUEO
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNUGETULTIMOBLOQUEO', 'ADM_PERSON'); 
END;
/
PROMPT "                                                            "
PROMPT OTORGA PERMISOS a REPORTES sobre funcion LDC_FNUGETULTIMOBLOQUEO
GRANT EXECUTE ON ADM_PERSON.LDC_FNUGETULTIMOBLOQUEO TO REPORTES;
/