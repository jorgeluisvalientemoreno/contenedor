CREATE OR REPLACE PACKAGE adm_person.pkg_BOSchedule
IS
/*
    Propiedad intelectual de Gases del Caribe

    Unidad:       pkg_BOSchedule
    Descripcion:  Paquete contenedor de los procedimientos usados para
                  la creacion de tareas programadas

    Autor:        German Dario Guevara Alzate - GlobaMVM
    Fecha:        09/04/2024

    Historial de Modificaciones
    --------------------------------------------------------------
    Fecha       Autor         Modificación
    --------------------------------------------------------------
    09/04/2024  GDGuevara     Creación: Caso OSF-2174
*/
    -- Crea una tarea programada
    PROCEDURE prCreaSchedule
    (
        inuExecutable           IN NUMBER, 
        isbParameters           IN VARCHAR2,
        isbWhat                 IN VARCHAR2,
        onuScheduleProcessAux   IN OUT NUMBER,
        isbFrecuency            IN VARCHAR2,
        idtNextProg             IN DATE
    );

END pkg_BOSchedule;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_BOSchedule
IS
    -- Identificador del ultimo caso que hizo cambios
    csbVersion          CONSTANT VARCHAR2(20) := 'OSF-2174_20240409';
    -- Constantes para el control de la traza
    csbMetodo           CONSTANT VARCHAR2(32) := $$PLSQL_UNIT;             -- Nombre del paquete
    csbNivelTraza       CONSTANT NUMBER(2)    := pkg_traza.cnuNivelTrzDef; -- Nivel de traza para esta función.
    csbInicio           CONSTANT VARCHAR2(4)  := pkg_traza.fsbINICIO;      -- Indica inicio de método
    csbFin              CONSTANT VARCHAR2(4)  := pkg_traza.fsbFIN;         -- Indica Fin de método ok
    csbFin_Erc          CONSTANT VARCHAR2(4)  := pkg_traza.fsbFIN_ERC;     -- Indica fin de método con error controlado
    csbFin_Err          CONSTANT VARCHAR2(4)  := pkg_traza.fsbFIN_ERR;     -- Indica fin de método con error no controlado

    -- Crea una tarea programada
    PROCEDURE prCreaSchedule
    (
        inuExecutable           IN NUMBER, 
        isbParameters           IN VARCHAR2,
        isbWhat                 IN VARCHAR2,
        onuScheduleProcessAux   IN OUT NUMBER,
        isbFrecuency            IN VARCHAR2,
        idtNextProg             IN DATE
    )
    IS
        csbProgram      CONSTANT VARCHAR2(30) := 'CreaSchedule';

        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        sbConexEncript  VARCHAR2(4000);
        sbConexion      VARCHAR2(4000);
        sbUsuario       VARCHAR2(4000);
        sbPassword      VARCHAR2(4000);
        sbInstance      VARCHAR2(4000);
    BEGIN
        pkg_traza.trace(csbMetodo||'.'||csbProgram, csbNivelTraza, csbInicio);

        -- Prepara la tarea
        GE_BOSchedule.PrepareSchedule(inuExecutable, isbParameters, isbWhat, onuScheduleProcessAux);

        -- Crea la programacion
        GE_BOSchedule.Scheduleprocess(onuScheduleProcessAux, isbFrecuency, idtNextProg);

        pkg_traza.trace(csbMetodo||'.'||csbProgram, csbNivelTraza, csbFin);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo||'.'||csbProgram, csbNivelTraza, csbFin_Erc);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo||'.'||csbProgram, csbNivelTraza, csbFin_Err);
            RAISE;
    END prCreaSchedule;

END pkg_BOSchedule;
/

PROMPT Otorgando permisos de ejecución a pkg_BOSchedule
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BOSCHEDULE','ADM_PERSON');
END;
/