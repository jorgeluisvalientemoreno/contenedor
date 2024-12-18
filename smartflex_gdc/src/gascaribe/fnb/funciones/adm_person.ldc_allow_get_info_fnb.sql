CREATE OR REPLACE FUNCTION ADM_PERSON.LDC_ALLOW_GET_INFO_FNB (inuPackageId  IN mo_packages.package_id%TYPE, 
                                                              nuOpc IN NUMBER DEFAULT 1)
RETURN NUMBER IS
    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_ALLOW_GET_INFO_FNB
    Descripcion    : Valida si debe mostrar la info FNB dado el usuario conectado
                     y la solicitud de venta. Utilizado en CNCRM para:
                     Consulta de Solicitudes de Financiación de Artículos de Proveedores

    Autor          : KCienfuegos.RNP2923
    Fecha          : 02/01/2015

    Parametros                   Descripcion
    ============             ===================
    inuPackageId:              Id del Paquete

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    02/01/2015       KCienfuegos.RNP2923   Creación.
    07/02/2023       Adrianavg             OSF-2097: Migrar del esquema OPEN al esquema ADM_PERSON
                                           Se reemplaza GE_BOPERSONAL.FNUGETPERSONID por PKG_BOPERSONAL.FNUGETPERSONAID
                                           Se reemplaza DAMO_PACKAGES.FNUGETOPERATING_UNIT_ID por PKG_BCSOLICITUDES.FNUGETUNIDADOPERATIVA
                                           Se reemplaza DAOR_OPERATING_UNIT.FNUGETOPER_UNIT_CLASSIF_ID por PKG_BCUNIDADOPERATIVA.FNUGETCLASIFICACION 
                                           Se reemplaza DAOR_OPERATING_UNIT.FNUGETCONTRACTOR_ID por PKG_BCUNIDADOPERATIVA.FNUGETCONTRATISTA
                                           Se declaran variables para la gestión de trazas
                                           Se adiciona bloque de exceptiones when others según pautas técnicas 
    ******************************************************************/
    --Se declaran variables para la gestión de trazas
    csbMetodo            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzApi; 
    csbInicio   	     CONSTANT VARCHAR2(35) 	     := pkg_traza.csbINICIO;   
    Onuerrorcode         NUMBER:= pkg_error.CNUGENERIC_MESSAGE;		
    Osberrormessage      VARCHAR2(2000);
    
    nuOperatingUnit   or_operating_unit.operating_unit_id%TYPE;
    nuOperUnitPack    or_operating_unit.operating_unit_id%TYPE;
    nuOperClassif     or_oper_unit_classif.oper_unit_classif_id%TYPE;
    nuClassSuppl      or_oper_unit_classif.oper_unit_classif_id%TYPE;
    nuClassContract   or_operating_unit.oper_unit_classif_id%TYPE;
    nuContractor      or_operating_unit.contractor_id%TYPE;
    nuContractorPack  or_operating_unit.contractor_id%TYPE;
    nuClassUTPack     or_oper_unit_classif.oper_unit_classif_id%TYPE;
    nuResult          NUMBER := 0;

    --Obtiene la unidad operativa del usuario conectado
    CURSOR cuGetunitBySeller
    IS 
    SELECT organizat_area_id
     FROM cc_orga_area_seller
    WHERE person_id = PKG_BOPERSONAL.FNUGETPERSONAID
      AND IS_current = 'Y'
      AND ROWNUM = 1;

BEGIN
    
    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_error.prInicializaError(onuerrorcode, osberrormessage);
    pkg_traza.trace(csbMetodo ||' inuPackageId: ' || inuPackageId, csbNivelTraza);
    pkg_traza.trace(csbMetodo ||' nuOpc: ' || nuOpc, csbNivelTraza);
    
    nuClassSuppl := DALD_PARAMETER.fnuGetNumeric_Value('SUPPLIER_FNB');
    pkg_traza.trace(csbMetodo ||' Proveedor FNB: ' || nuClassSuppl, csbNivelTraza);
    
    nuClassContract := DALD_PARAMETER.fnuGetNumeric_Value('CONTRACTOR_SALES_FNB');
    pkg_traza.trace(csbMetodo ||' Contratista de venta FNB: ' || nuClassContract, csbNivelTraza);

    --Obtiene la unidad operativa conectada
    OPEN cugetunitbyseller; 
    FETCH cugetunitbyseller INTO nuoperatingunit; 
    CLOSE cugetunitbyseller;
    pkg_traza.trace(csbMetodo ||' Unidad operativa conectada: ' || nuoperatingunit, csbNivelTraza);
    
    --Obtiene la unidad operativa de la solicitud
    nuOperUnitPack := pkg_bcsolicitudes.fnugetunidadoperativa(inuPackageId);
    pkg_traza.trace(csbMetodo ||' Unidad operativa de la solicitud: ' || nuOperUnitPack, csbNivelTraza);
    
    --Obtiene la clasificación de la UT del usuario conectado
    IF nuoperatingunit IS NOT NULL THEN
        nuoperclassif := pkg_bcunidadoperativa.fnugetclasificacion(nuoperatingunit);
        pkg_traza.trace(csbMetodo ||' Clasificación de la UT del usuario conectado: ' || nuoperclassif, csbNivelTraza);
        
        --Obtiene el contratista de la unidad operativa del usuario conectado
        nucontractor := pkg_bcunidadoperativa.fnugetcontratista(nuoperatingunit);
        pkg_traza.trace(csbMetodo ||' Contratista de la unidad operativa: ' || nucontractor, csbNivelTraza);
    END IF;

    IF nuoperunitpack IS NOT NULL THEN
        --Obtiene la clasificación de la UT que registró la venta
        nuclassutpack := pkg_bcunidadoperativa.fnugetclasificacion(nuoperunitpack);
        pkg_traza.trace(csbMetodo ||' Clasificación de la UT que registró la venta: ' || nuclassutpack, csbNivelTraza);
        
        --Obtiene el contratista de la unidad operativa que registró la venta
        nucontractorpack := pkg_bcunidadoperativa.fnugetcontratista(nuoperunitpack);
        pkg_traza.trace(csbMetodo ||' Contratista de la unidad operativa que registró la venta: ' || nucontractorpack, csbNivelTraza);
    END IF;

    --Valida si es clasificación 70-Contratista
    IF nvl(nuOperClassif,-1) = nuClassContract then

        --Valida que el contratista de la ut del usuario conectado, sea el mismo de la ut de la venta
        IF nucontractor = nucontractorpack THEN
            nuresult := 1;
        END IF;

    --Valida si es clasificación 71-Proveedor
    ELSIF nvl(nuOperClassif,-1) = nuClassSuppl then

        IF nuopc = 1 THEN
            --Valida que el contratista de la ut del usuario conectado, sea el mismo de la ut de la venta
            IF nucontractor = nucontractorpack THEN
               nuresult := 1;
            END IF;
        
            --Valida que la clasificación de la ut de venta sea 70 ó 71
            IF nuclassutpack NOT IN ( nuclasssuppl, nuclasscontract ) THEN
               nuresult := 0;
            END IF;
        ELSE
            IF nuclassutpack = nuclasssuppl THEN
               IF nucontractor = nucontractorpack THEN
                  nuresult := 1;
               END IF;
            ELSE
                nuresult := 0;
            END IF;
        END IF;

    ELSE
        nuResult := 1;
    END IF;

    pkg_traza.trace(csbMetodo ||' nuResult: ' || nuResult, csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    
    RETURN nuResult;
EXCEPTION
    WHEN OTHERS THEN  
         pkg_Error.setError;
         pkg_Error.getError(onuerrorcode, osberrormessage);
         pkg_traza.trace(csbMetodo ||' osberrormessage: ' || osberrormessage, csbNivelTraza);
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
         RETURN nuResult;
END LDC_ALLOW_GET_INFO_FNB;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion LDC_ALLOW_GET_INFO_FNB
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_ALLOW_GET_INFO_FNB', 'ADM_PERSON'); 
END;
/
PROMPT OTORGA PERMISOS a REPORTES sobre funcion LDC_ALLOW_GET_INFO_FNB
GRANT EXECUTE ON ADM_PERSON.LDC_ALLOW_GET_INFO_FNB TO REPORTES;
/
