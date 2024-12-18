CREATE OR REPLACE PACKAGE adm_person.pkg_BOConexionBD
IS
/*
    Propiedad intelectual de Gases del Caribe

    Unidad:       pkg_BOConexionBD
    Descripcion:  Paquete contenedor de los procedimientos usados para
                  la conexion a la base de datos

    Autor:        German Dario Guevara Alzate - GlobaMVM
    Fecha:        09/04/2024

    Historial de Modificaciones
    --------------------------------------------------------------
    Fecha       Autor         Modificación
    --------------------------------------------------------------
    09/04/2024  GDGuevara     Creación: Caso OSF-2174
*/
    -- Obtiene la cadena de conexion encriptada a la base de datos
    FUNCTION fsbConexEncriptada RETURN VARCHAR2;

END pkg_BOConexionBD;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_BOConexionBD
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

    -- Obtiene la cadena de conexion encriptada a la base de datos
    FUNCTION fsbConexEncriptada RETURN VARCHAR2
    IS
        csbProgram      CONSTANT VARCHAR2(30) := 'fsbConexEncriptada';

        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        sbConexEncript  VARCHAR2(4000);
        sbConexion      VARCHAR2(4000);
        sbUsuario       VARCHAR2(4000);
        sbPassword      VARCHAR2(4000);
        sbInstance      VARCHAR2(4000);
    BEGIN
        sbConexEncript := null;
        pkg_traza.trace(csbMetodo||'.'||csbProgram, csbNivelTraza, csbInicio);

        -- Trae las credenciales de la conexion activa
        ge_boDatabaseConnection.getConnectionString
        (
            sbUsuario,
            sbPassword,
            sbInstance
        );
        -- Arma la cadena de conexion
        sbConexion := sbUsuario || '/' || sbPassword || '@' || sbInstance;

        -- Codifica la contraseña
        sbConexEncript := bi_boServiciosDotnet.fsbCodificarContrasena(sbConexion);

        pkg_traza.trace(csbMetodo||'.'||csbProgram, csbNivelTraza, csbFin);
        -- Retorna la cadena de conexion encriptada
        RETURN sbConexEncript;
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo||'.'||csbProgram, csbNivelTraza, csbFin_Erc);
            RETURN sbConexEncript;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo||'.'||csbProgram, csbNivelTraza, csbFin_Err);
            RETURN sbConexEncript;
    END fsbConexEncriptada;

END pkg_BOConexionBD;
/

PROMPT Otorgando permisos de ejecución a pkg_BOConexionBD
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BOCONEXIONBD','ADM_PERSON');
END;
/