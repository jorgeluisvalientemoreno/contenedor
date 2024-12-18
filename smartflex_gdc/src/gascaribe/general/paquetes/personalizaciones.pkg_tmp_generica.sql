create or replace PACKAGE personalizaciones.pkg_tmp_generica
IS
    /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Paquete         : personalizaciones.pkg_tmp_generica
      Descripcion     : Paquete para el manejo de la tabla tmp_generica
      Autor           : German Dario Guevara Alzate
      Fecha           : 10/05/2024

      Modificaciones  :
      =========================================================
      Autor       Fecha         Caso        Descripción
      GDGuevara   10/05/2024    OSF-2703    Creacion
    ***************************************************************************/
    rcTmpGenerica       tmp_generica%ROWTYPE;

    CURSOR cuTmpGenerica IS
        SELECT * FROM tmp_generica;
    tyTmpGenerica       cuTmpGenerica%ROWTYPE;

    -- proceso que inserta en tabla de tmp_generica
    PROCEDURE prInsertar
    (
        ircTmpGenerica  IN rcTmpGenerica%TYPE
    );

    -- proceso que consulta la tabla tmp_generica
    FUNCTION fcuConsultar RETURN  Constants_Per.TYREFCURSOR;

    -- proceso que borra toda la tabla tmp_generica
    PROCEDURE prBorrar;

    -- Retona Identificador del ultimo caso que hizo cambios
    FUNCTION fsbVersion RETURN VARCHAR2;

END pkg_tmp_generica;
/
create or replace PACKAGE BODY personalizaciones.pkg_tmp_generica
IS
    -- Identificador del ultimo caso que hizo cambios
    csbVersion      CONSTANT VARCHAR2(15)  := 'OSF-2703';
    csbSP_NAME      CONSTANT VARCHAR2 (35) := $$PLSQL_UNIT || '.';
    csbNivelTraza   CONSTANT NUMBER (2)    := pkg_traza.fnuNivelTrzDef;

    -- Retona la ultima WO que hizo cambios en el paquete
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;

    PROCEDURE prInsertar
    (
        ircTmpGenerica  IN rcTmpGenerica%TYPE
    )
    IS
        /***************************************************************************
          Propiedad Intelectual de Gases del Caribe
          Programa        : prInsertaLiqSeguro
          Descripcion     : proceso que inserta la liquidacion en la tabla tmp_generica
          Autor           : German Dario Guevara Alzate
          Fecha           : 10/05/2024

          Modificaciones  :
          =========================================================
          Autor       Fecha         Caso        Descripción
          GDGuevara   10/05/2024   OSF-2703    Creacion
        ***************************************************************************/
        csbMetodo   CONSTANT VARCHAR2 (70) := csbSP_NAME || 'prInsertaLiqSeguro';
        nuError              NUMBER;
        sbError              VARCHAR2 (4000);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        INSERT INTO tmp_generica VALUES ircTmpGenerica;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.Controlled_Error
        THEN
            pkg_traza.trace (csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError (nuError, sbError);
            pkg_traza.trace ('sbError => ' || sbError, csbNivelTraza);
            ROLLBACK;
        WHEN OTHERS
        THEN
            pkg_traza.trace (csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            pkg_Error.getError (nuError, sbError);
            pkg_traza.trace ('sbError => ' || sbError, csbNivelTraza);
            ROLLBACK;
    END prInsertar;

    FUNCTION fcuConsultar
    RETURN  Constants_Per.TYREFCURSOR
    IS
        /***************************************************************************
          Propiedad Intelectual de Gases del Caribe
          Programa        : fcuConsultar
          Descripcion     : funcion que retorna todos los registros de la tabla
          Autor           : German Dario Guevara Alzate
          Fecha           : 10/05/2024

          Modificaciones  :
          =========================================================
          Autor       Fecha         Caso        Descripción
          GDGuevara   10/05/2024   OSF-2703    Creacion
        ***************************************************************************/
        csbMetodo   CONSTANT VARCHAR2 (70) := csbSP_NAME || 'fcuConsultar' ;
        nuError              NUMBER;
        sbError              VARCHAR2 (4000);
        ocuResultado         Constants_Per.TYREFCURSOR;
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        -- Valida que el cursor no este abierto
        IF ocuResultado%ISOPEN THEN
            CLOSE ocuResultado;
        END IF;

        -- Arma el cursor referenciado
        OPEN ocuResultado FOR SELECT t.* FROM tmp_generica t;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        -- Retorna el cursor referenciado
        RETURN ocuResultado;
    EXCEPTION
        WHEN pkg_error.Controlled_Error
        THEN
            pkg_traza.trace (csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError (nuError, sbError);
            pkg_traza.trace ('sbError => ' || sbError, csbNivelTraza);
            RETURN ocuResultado;
        WHEN OTHERS
        THEN
            pkg_traza.trace (csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            pkg_Error.getError (nuError, sbError);
            pkg_traza.trace ('sbError => ' || sbError, csbNivelTraza);
            RETURN ocuResultado;
    END fcuConsultar;

    PROCEDURE prBorrar
    IS
        /***************************************************************************
          Propiedad Intelectual de Gases del Caribe
          Programa        : prBorrar
          Descripcion     : proceso que borra la tabla tmp_generica
          Autor           : German Dario Guevara Alzate
          Fecha           : 10/05/2024

          Modificaciones  :
          =========================================================
          Autor       Fecha         Caso        Descripción
          GDGuevara   10/05/2024   OSF-2703    Creacion
        ***************************************************************************/
        csbMetodo   CONSTANT VARCHAR2 (70) := csbSP_NAME || 'prBorrar';
        nuError              NUMBER;
        sbError              VARCHAR2 (4000);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        DELETE tmp_generica;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.Controlled_Error
        THEN
            pkg_traza.trace (csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError (nuError, sbError);
            pkg_traza.trace ('sbError => ' || sbError, csbNivelTraza);
            ROLLBACK;
        WHEN OTHERS
        THEN
            pkg_traza.trace (csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            pkg_Error.getError (nuError, sbError);
            pkg_traza.trace ('sbError => ' || sbError, csbNivelTraza);
            ROLLBACK;
    END prBorrar;
END pkg_tmp_generica;
/

BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_TMP_GENERICA', 'PERSONALIZACIONES');
END;
/