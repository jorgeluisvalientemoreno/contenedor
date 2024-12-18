CREATE OR REPLACE PACKAGE adm_person.pkg_BOInterfazActas
IS
/*
    Propiedad intelectual de Gases del Caribe

    Unidad:       pkg_BOInterfazActas
    Descripcion:  Paquete contenedor de los procedimientos usados para
                  interfaz contable

    Autor:        German Dario Guevara Alzate - GlobaMVM
    Fecha:        09/04/2024

    Historial de Modificaciones
    --------------------------------------------------------------
    Fecha       Autor         Modificación
    --------------------------------------------------------------
    09/04/2024  GDGuevara     Creación: Caso OSF-2174
*/
    -- Procesa contabilizacion para SAP
    FUNCTION fnuInterCostoSAP
    (
        inuid_acta      IN NUMBER,
        isbTipoCompFNB  IN VARCHAR2,
        idtFechaIni     IN DATE,
        idtFechaFin     IN DATE
    ) RETURN NUMBER;

END pkg_BOInterfazActas;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_BOInterfazActas
IS
    -- Identificador del ultimo caso que hizo cambios
    csbVersion          CONSTANT VARCHAR2(20) := 'OSF-2174_20240409';      -- Constantes para el control de la traza
    csbMetodo           CONSTANT VARCHAR2(32) := $$PLSQL_UNIT;             -- Nombre del paquete
    csbNivelTraza       CONSTANT NUMBER(2)    := pkg_traza.cnuNivelTrzDef; -- Nivel de traza para esta función.
    csbInicio           CONSTANT VARCHAR2(4)  := pkg_traza.fsbINICIO;      -- Indica inicio de método
    csbFin              CONSTANT VARCHAR2(4)  := pkg_traza.fsbFIN;         -- Indica Fin de método ok
    csbFin_Erc          CONSTANT VARCHAR2(4)  := pkg_traza.fsbFIN_ERC;     -- Indica fin de método con error controlado
    csbFin_Err          CONSTANT VARCHAR2(4)  := pkg_traza.fsbFIN_ERR;     -- Indica fin de método con error no controlado

    -- Procesa contabilizacion para SAP
    FUNCTION fnuInterCostoSAP
    (
        inuid_acta      IN NUMBER,
        isbTipoCompFNB  IN VARCHAR2,
        idtFechaIni     IN DATE,
        idtFechaFin     IN DATE
    ) RETURN NUMBER
    IS
        csbProgram      CONSTANT VARCHAR2(30) := 'fnuInterCostoSAP';
        nuResult        NUMBER;
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
    BEGIN
        nuResult := null;
        pkg_traza.trace(csbMetodo||'.'||csbProgram, csbNivelTraza, csbInicio);

        nuResult := LDCI_PKINTERFAZACTAS.fnuInterCostoSAP
                    (
                        inuid_acta,
                        isbTipoCompFNB,
                        idtFechaIni,
                        idtFechaFin
                    );

        pkg_traza.trace(csbMetodo||'.'||csbProgram, csbNivelTraza, csbFin);
        RETURN nuResult;

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo||'.'||csbProgram, csbNivelTraza, csbFin_Erc);
            RETURN nuResult;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo||'.'||csbProgram, csbNivelTraza, csbFin_Err);
            RETURN nuResult;
    END fnuInterCostoSAP;

END pkg_BOInterfazActas;
/

PROMPT Otorgando permisos de ejecución a pkg_BOInterfazActas
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BOINTERFAZACTAS','ADM_PERSON');
END;
/