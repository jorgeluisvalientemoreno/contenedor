CREATE OR REPLACE FUNCTION ADM_PERSON.FSBGETDEUDORBRILLA (isbopcion VARCHAR2,
                                                          inususc diferido.difesusc%TYPE) RETURN VARCHAR2 IS

/*******************************************************************************
  Propiedad intelectual de GC

  Descripcion    : Funcion que devuelve datos de deudor o codeudor Brilla


  Autor          : F.Castro
  Fecha          : 15-07-2016

  Fecha                IDEntrega           Modificacion
  ============    ================    ============================================ 
  07/02/2023     Adrianavg            OSF-2097: Migrar del esquema OPEN al esquema ADM_PERSON
                                      Se retira esquema antepuesto OPEN a tabla LD_PROMISSORY
                                      Se declaran variables para la gestión de trazas
                                      Se ajusta el bloque de exceptiones según pautas técnicas                                      
  *******************************************************************************/
    --Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef; 
    csbInicio   	       CONSTANT VARCHAR2(35) 	     := pkg_traza.csbINICIO;   
    Onuerrorcode         NUMBER:= pkg_error.CNUGENERIC_MESSAGE;		
    Osberrormessage      VARCHAR2(2000);
    
    sbdeudor varchar2(500);
    
    CURSOR cudeudor 
    IS
    SELECT p.identification|| ' - '|| p.debtorname
      FROM ld_promissory p
     WHERE p.promissory_type = isbopcion
       AND p.package_id = (SELECT MAX(s.package_id)
                             FROM mo_packages s,  or_order_activity a
                            WHERE s.package_type_id = 100264
                              AND s.package_id = a.package_id
                              AND a.subscription_id = inususc);

BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);
    pkg_traza.trace(csbMetodo ||' isbopcion: ' || isbopcion, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' inususc: ' || inususc, csbNivelTraza);
    
    OPEN cudeudor;
    FETCH cudeudor INTO sbdeudor;
    IF cudeudor%notfound THEN
        sbdeudor := NULL;
    END IF;
    CLOSE cudeudor;
    
    pkg_traza.trace(csbMetodo ||' sbdeudor: ' || sbdeudor, csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    
    RETURN sbdeudor;
EXCEPTION
    WHEN OTHERS THEN
         pkg_error.seterror;
         pkg_Error.getError(onuerrorcode, osberrormessage);
         pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
         RETURN NULL;
END fsbgetdeudorbrilla;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion FSBGETDEUDORBRILLA
BEGIN
    pkg_utilidades.prAplicarPermisos('FSBGETDEUDORBRILLA', 'ADM_PERSON'); 
END;
/
PROMPT OTORGA PERMISOS a REPORTES sobre funcion FSBGETDEUDORBRILLA
GRANT EXECUTE ON ADM_PERSON.FSBGETDEUDORBRILLA TO REPORTES;
/
