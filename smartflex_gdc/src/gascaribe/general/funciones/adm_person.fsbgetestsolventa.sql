CREATE OR REPLACE FUNCTION ADM_PERSON.FSBGETESTSOLVENTA (inuproducto pr_product.product_id%type) return varchar2 is
/**************************************************************************************
   Propiedad intelectual de GDC

    Unidad         : fsbGetEstSolVenta
    Descripcion    : Funcion que devuelve estado de la solicitud de venta de un producto

    Autor          : FCastro
    Fecha          : 06-12-2018

    Historia de Modificaciones
    Fecha             Autor               Modificacion
    ==========        ==================  ======================================
    07/02/2023        Adrianavg           OSF-2097: Migrar del esquema OPEN al esquema ADM_PERSON
                                          Se retira esquema antepuesto OPEN a tabla ps_motive_status, mo_packages y mo_motive
                                          Se declaran variables para la gestión de trazas
                                          Se ajusta el bloque de exceptiones según pautas técnicas
****************************************************************************************/
    --Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef; 
    csbInicio   	     CONSTANT VARCHAR2(35) 	     := pkg_traza.csbINICIO;   
    Onuerrorcode         NUMBER:= pkg_error.CNUGENERIC_MESSAGE;		
    Osberrormessage      VARCHAR2(2000);
    
    CURSOR cuVenta IS
    SELECT  p.motive_status_id|| ' - ' || ( SELECT ps.description
                                              FROM ps_motive_status ps
                                             WHERE ps.motive_status_id = p.motive_status_id
        )
    FROM
        mo_packages p,
        mo_motive   m
    WHERE p.package_id = m.package_id
      AND p.package_type_id IN ( 323, 271, 100229, 100271 )
      AND m.product_id = inuproducto;

    sbEstSolVenta varchar2(50);

BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);
    pkg_traza.trace(csbMetodo ||' inuproducto: ' || inuproducto, csbNivelTraza);
    
    OPEN cuventa;
    FETCH cuventa INTO sbestsolventa;
    IF cuventa%notfound THEN
        sbestsolventa := NULL;
    END IF;
    CLOSE cuventa; 
    pkg_traza.trace(csbMetodo ||' sbestsolventa: ' || sbestsolventa, csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    
    RETURN sbestsolventa;
EXCEPTION
    WHEN OTHERS THEN
         pkg_error.seterror;
         pkg_Error.getError(onuerrorcode, osberrormessage);
         pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
         RETURN NULL;
END FSBGETESTSOLVENTA;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion FSBGETESTSOLVENTA
BEGIN
    pkg_utilidades.prAplicarPermisos('FSBGETESTSOLVENTA', 'ADM_PERSON'); 
END;
/
PROMPT OTORGA PERMISOS a REPORTES sobre funcion FSBGETESTSOLVENTA
GRANT EXECUTE ON ADM_PERSON.FSBGETESTSOLVENTA TO REPORTES;
/
