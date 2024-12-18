CREATE OR REPLACE PACKAGE ADM_PERSON.pkg_boinstancia IS
/*******************************************************************************
Propiedad intelectual de Gases del Caribe

Paquete:     pkg_boinstancia 
Fecha:       27-08-2024
Autor:       jpadilla
Descripción: Paquete que continene las funciones migradas del paquete mo_boinstance_db

Historial de cambios:
Fecha         Autor          Modificación
============  =============  ====================================================
27-08-2024    jpadilla       Se crea el paquete.
*******************************************************************************/


/*******************************************************************************
Función para obtener el id de la instancia de la solicitud.
Enmascara a `mo_boinstance_db.fnuGetPackIDInstance`.
*******************************************************************************/
    FUNCTION fnuObtenerIdSolInstancia RETURN NUMBER;

END pkg_boinstancia;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.pkg_boinstancia IS
    csbSP_NAME    CONSTANT VARCHAR2(35) := $$PLSQL_UNIT || '.';
    csbNivelTraza CONSTANT NUMBER(2) := pkg_traza.fnuNivelTrzDef;

/*******************************************************************************
Propiedad intelectual de Gases del Caribe

Función:     fnuObtenerIdSolInstancia
Fecha:       27-08-2024
Autor:       jpadilla
Descripción: Función para obtener el id de la instancia de la solicitud.
             Enmascara a `mo_boinstance_db.fnuGetPackIDInstance`.

Historial de cambios:
Fecha         Autor          Modificación
============  =============  ====================================================
27-08-2024    jpadilla       Se crea la función.
*******************************************************************************/
    FUNCTION fnuObtenerIdSolInstancia RETURN NUMBER IS
        csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtenerIdSolInstancia';
        sbPackId  MO_PACKAGES.PACKAGE_ID%TYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        sbPackId := mo_boinstance_db.fnuGetPackIDInstance();
        pkg_traza.trace('sbPackId: ' || sbPackId, csbNivelTraza);

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        return sbPackId;
    END;
END pkg_boinstancia;
/
PROMPT "Se crea el paquete pkg_boinstancia"

BEGIN
    pkg_utilidades.praplicarpermisos('PKG_BOINSTANCIA', 'ADM_PERSON');
END;
/
PROMPT "Se otorgan permisos al paquete pkg_boinstancia";
