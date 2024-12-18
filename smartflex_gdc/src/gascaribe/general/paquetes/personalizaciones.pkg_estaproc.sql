CREATE OR REPLACE PACKAGE personalizaciones.pkg_estaproc
IS
    /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Paquete         : personalizaciones.pkg_estaproc
      Descripcion     : Paquete para el manejo de la tabla estaproc
      Autor           : Luis Javier Lopez Barrios
      Fecha           : 01-06-2023

      Parametros de Entrada
        isbProceso    nombre del proceso
        inuTotalRegi  total de registros a procesar
      Parametros de Salida

      Modificaciones  :
      =========================================================
      Autor       Fecha         Caso        Descripción
      jpinedc     14-03-2024    OSF-2377    Se crea prBorraEstaproc
                                            Ajustes por Validación Técnica
      adrianavg   18/04/2024    OSF-2388    Ajustar prInsertaEstaproc                                            
    ***************************************************************************/

    -- proceso que inserta en tabla de estaproc
    PROCEDURE prInsertaEstaproc
    (
        isbProceso     IN estaproc.proceso%TYPE,
        inuTotalRegi   IN estaproc.total_registro%TYPE
    );

    -- proceso que actualiza avance de ejecucion en la tabla de estaproc
    PROCEDURE prActualizaAvance
    (
        isbProceso       IN estaproc.proceso%TYPE,
        isbObservacion   IN estaproc.observacion%TYPE,
        inuRegiProce     IN estaproc.regis_procesado%TYPE,
        inuTotalRegi     IN estaproc.total_registro%TYPE
    );

    -- funcion que valida estado de ejecucion de un proceso
    FUNCTION fblValidaEjecucionProc (isbProceso IN estaproc.proceso%TYPE)
    RETURN BOOLEAN;

    -- proceso que actualiza en tabla de estaproc
    PROCEDURE prActualizaEstaproc
    (
        isbProceso       IN estaproc.proceso%TYPE,
        isbEstado        IN estaproc.estado%TYPE DEFAULT 'OK',
        isbObservacion   IN estaproc.observacion%TYPE DEFAULT NULL
    );

    -- proceso que borra un registro de estaproc
    PROCEDURE prBorraEstaproc (isbProceso IN estaproc.proceso%TYPE);

END pkg_estaproc;
/


CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_estaproc
IS
    csbSP_NAME      CONSTANT VARCHAR2 (35) := $$PLSQL_UNIT || '.';
    csbNivelTraza   CONSTANT NUMBER (2) := pkg_traza.fnuNivelTrzDef;

    PROCEDURE prInsertaEstaproc
    (
        isbProceso     IN estaproc.proceso%TYPE,
        inuTotalRegi   IN estaproc.total_registro%TYPE
    )
    IS
        /***************************************************************************
          Propiedad Intelectual de Gases del Caribe
          Programa        : prInsertaEstaproc
          Descripcion     : proceso que inserta en tabla de estaproc
          Autor           : Luis Javier Lopez Barrios
          Fecha           : 01-06-2023

          Parametros de Entrada
            isbProceso    nombre del proceso
            inuTotalRegi  total de registros a procesar

          Parametros de Salida

          Modificaciones  :
          =========================================================
          Autor       Fecha       Caso    Descripción
          adrianavg   18/04/2024  2388    Ajustar valor para asignación de la sesion en nutsess
        ***************************************************************************/
        csbMetodo   CONSTANT VARCHAR2 (70)
                                 := csbSP_NAME || 'prInsertaEstaproc' ;
        nuError              NUMBER;
        sbError              VARCHAR2 (4000);

        PRAGMA AUTONOMOUS_TRANSACTION;
        nuparano             NUMBER;
        nuparmes             NUMBER;
        nutsess              NUMBER;
        sbparuser            VARCHAR2 (4000);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        nuparano := TO_NUMBER (TO_CHAR (SYSDATE, 'YYYY'));
        nuparmes := TO_NUMBER (TO_CHAR (SYSDATE, 'MM'));
        nutsess  := nvl(userenv('SESSIONID'),pkg_Session.fnuGetSesion);
        sbparuser := pkg_Session.getUser;

        INSERT INTO estaproc
        (
            anio,
            mes,
            proceso,
            estado,
            total_registro,
            regis_procesado,
            fecha_inicial_ejec,
            sesion,
            usuario_conectado
        )
        VALUES
        (
            nuparano,
            nuparmes,
            isbProceso,
            'En ejecucion',
            inuTotalRegi,
            0,
            SYSDATE,
            nutsess,
            sbparuser
        );

        COMMIT;
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
    END prInsertaEstaproc;

    PROCEDURE prActualizaEstaproc
    (
        isbProceso       IN estaproc.proceso%TYPE,
        isbEstado        IN estaproc.estado%TYPE DEFAULT 'OK',
        isbObservacion   IN estaproc.observacion%TYPE DEFAULT NULL
    )
    IS
        /***************************************************************************
         Propiedad Intelectual de Gases del Caribe
         Programa        : prActualizaEstaproc
         Descripcion     : proceso que actualiza en tabla de estaproc
         Autor           : Luis Javier Lopez Barrios
         Fecha           : 01-06-2023

         Parametros de Entrada
           isbProceso       nombre del proceso
           isbEstado        estado del proceso
           isbObservacion   observacion
         Parametros de Salida

         Modificaciones  :
         =========================================================
         Autor       Fecha       Caso    Descripción
       ***************************************************************************/
        csbMetodo   CONSTANT VARCHAR2 (70)
                                 := csbSP_NAME || 'prActualizaEstaproc' ;
        nuError              NUMBER;
        sbError              VARCHAR2 (4000);
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        UPDATE estaproc l
        SET fecha_final_ejec = SYSDATE,
            estado = 'Terminó ' || isbEstado,
            l.observacion = isbObservacion
        WHERE l.proceso = isbProceso;

        COMMIT;
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
    END prActualizaEstaproc;

    PROCEDURE prActualizaAvance
    (
        isbProceso       IN estaproc.proceso%TYPE,
        isbObservacion   IN estaproc.observacion%TYPE,
        inuRegiProce     IN estaproc.regis_procesado%TYPE,
        inuTotalRegi     IN estaproc.total_registro%TYPE
    )
    IS
        /***************************************************************************
          Propiedad Intelectual de Gases del Caribe
          Programa        : prActualizaAvance
          Descripcion     : proceso que actualiza avance de ejecucion en la tabla de estaproc
          Autor           : Luis Javier Lopez Barrios
          Fecha           : 01-06-2023

          Parametros de Entrada
            isbProceso       nombre del proceso
            isbObservacion   observacion
            inuRegiProce     registros procesado
            inuTotalRegi     total registros a procesar
          Parametros de Salida

          Modificaciones  :
          =========================================================
          Autor       Fecha       Caso    Descripción
        ***************************************************************************/
        csbMetodo   CONSTANT VARCHAR2 (70)
                                 := csbSP_NAME || 'prActualizaAvance' ;
        nuError              NUMBER;
        sbError              VARCHAR2 (4000);
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        UPDATE estaproc l
        SET l.total_registro = inuTotalRegi,
               l.regis_procesado = inuRegiProce,
               l.observacion = isbObservacion
        WHERE l.proceso = isbProceso;

        COMMIT;
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
    END prActualizaAvance;

    FUNCTION fblValidaEjecucionProc (isbProceso IN estaproc.proceso%TYPE)
    RETURN BOOLEAN
    IS
        /***************************************************************************
          Propiedad Intelectual de Gases del Caribe
          Programa        : fblValidaEjecucionProc
          Descripcion     : funcion que valida estado de ejecucion de un proceso
          Autor           : Luis Javier Lopez Barrios
          Fecha           : 01-06-2023

          Parametros de Entrada
            isbProceso       nombre del proceso
          Parametros de Salida

          Modificaciones  :
          =========================================================
          Autor       Fecha       Caso    Descripción
        ***************************************************************************/
        csbMetodo   CONSTANT VARCHAR2 (70)
                                 := csbSP_NAME || 'fblValidaEjecucionProc' ;
        nuError              NUMBER;
        sbError              VARCHAR2 (4000);

        blEjecucion          BOOLEAN := FALSE;
        sbExiste             VARCHAR2 (1);

        CURSOR cuGetExisteEje IS
            SELECT 'X'
              FROM gv$session, estaproc
             WHERE     UPPER (PROCESO) LIKE '%' || UPPER (isbProceso) || '%'
                   AND SESION = AUDSID;
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        IF cuGetExisteEje%ISOPEN
        THEN
            CLOSE cuGetExisteEje;
        END IF;

        OPEN cuGetExisteEje;
        FETCH cuGetExisteEje INTO sbExiste;
        CLOSE cuGetExisteEje;

        blEjecucion := sbExiste IS NOT NULL;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        RETURN blEjecucion;
    EXCEPTION
        WHEN pkg_error.Controlled_Error
        THEN
            pkg_traza.trace (csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError (nuError, sbError);
            pkg_traza.trace ('sbError => ' || sbError, csbNivelTraza);
            RETURN blEjecucion;
        WHEN OTHERS
        THEN
            pkg_traza.trace (csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            pkg_Error.getError (nuError, sbError);
            pkg_traza.trace ('sbError => ' || sbError, csbNivelTraza);
            RETURN blEjecucion;
    END fblValidaEjecucionProc;

    PROCEDURE prBorraEstaproc (isbProceso IN estaproc.proceso%TYPE)
    IS
        /***************************************************************************
          Propiedad Intelectual de Gases del Caribe
          Programa        : prBorraEstaproc
          Descripcion     : proceso que borra un registro de estaproc
          Autor           : Lubin Pineda
          Fecha           : 11-03-2024

          Parametros de Entrada
            isbProceso       nombre del proceso
          Parametros de Salida

          Modificaciones  :
          =========================================================
          Autor       Fecha       Caso        Descripción
          jpinedc     11/03/2024  OSF-2377    Creación
        ***************************************************************************/
        csbMetodo   CONSTANT VARCHAR2 (70) := csbSP_NAME || 'prBorraEstaproc';
        nuError              NUMBER;
        sbError              VARCHAR2 (4000);
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        DELETE estaproc l
         WHERE l.proceso = isbProceso;

        COMMIT;

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
    END prBorraEstaproc;
END pkg_estaproc;
/
begin
 pkg_utilidades.prAplicarPermisos('PKG_ESTAPROC', 'PERSONALIZACIONES');
end ;
/