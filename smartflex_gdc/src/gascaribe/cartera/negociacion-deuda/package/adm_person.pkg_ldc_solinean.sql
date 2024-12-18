CREATE OR REPLACE PACKAGE adm_person.pkg_ldc_solinean IS
/*****************************************************************
    Propiedad intelectual de Gases del Caribe

    Unidad         : adm_person.pkg_ldc_solinean
    Descripción    : Paquete de primer nivel para gestión de la tabla ldc_solinean
    Autor          : jcatuche
    Fecha          : 22/08/2024

    Fecha           Autor               Modificación
    =========       =========           ====================
	22/08/2024      jcatuche            OSF-3120: Creación
******************************************************************/
    PROCEDURE prInsertaRegistro
    (
        inusolicitud    in ldc_solinean.solicitud%type,
        isbestado       in ldc_solinean.estado%type default 'P',
        isbobservacion  in ldc_solinean.observacion%type default null
    );
    
    PROCEDURE prActualizaRegistro
    (
        inusolicitud    in ldc_solinean.solicitud%type,
        isbestado       in ldc_solinean.estado%type,
        isbobservacion  in ldc_solinean.observacion%type
    );
    
END pkg_ldc_solinean;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_ldc_solinean IS
    -- Constantes para el control de la traza
    csbSP_NAME          CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT||'.';           -- Constante para nombre de función    
    cnuNivelTraza       CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;    -- Nivel de traza para esta función. 
    csbInicio           CONSTANT VARCHAR2(4)        := pkg_traza.fsbINICIO;         -- Indica inicio de método
    csbFin              CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN;            -- Indica Fin de método ok
    csbFin_Erc          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERC;        -- Indica fin de método con error controlado
    csbFin_Err          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERR;        -- Indica fin de método con error no controlado
    
    --Variables generales
    sberror             VARCHAR2(4000);
    nuerror             NUMBER;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prInsertaRegistro
    Descripcion     : Inserta registro en ldc_solinean

    Autor           : jcatuche
    Fecha           : 22/08/2024

    Parametros de Entrada
        inusolicitud    Solicitud
        isbestado       Estado
        isbobservacion  Observación
        
        
        
    Parametros de Salida
        NA
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripción
    jcatuche    22/08/2024  OSF-3120    Creación
  ***************************************************************************/
    PROCEDURE prInsertaRegistro
    (
        inusolicitud    in ldc_solinean.solicitud%type,
        isbestado       in ldc_solinean.estado%type default 'P',
        isbobservacion  in ldc_solinean.observacion%type default null
    ) IS
        pragma AUTONOMOUS_TRANSACTION;
        csbMT_NAME   CONSTANT VARCHAR2(100) := csbSP_NAME||'prInsertaRegistro';
    BEGIN
        pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbInicio);
        
        insert into ldc_solinean (solicitud, fecha, estado, observacion)
        values (inusolicitud, sysdate, isbestado, isbobservacion);
        
        commit;
        
        pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin_Erc);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin_Err);
            RAISE pkg_Error.Controlled_Error;
    END prInsertaRegistro;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActualizaRegistro
    Descripcion     : Actualiza registro en ldc_solinean

    Autor           : jcatuche
    Fecha           : 22/08/2024

    Parametros de Entrada
        inusolicitud    Solicitud
        isbestado       Estado
        isbobservacion  Observación
        
        
        
    Parametros de Salida
        NA
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripción
    jcatuche    22/08/2024  OSF-3120    Creación
  ***************************************************************************/
    PROCEDURE prActualizaRegistro
    (
        inusolicitud    in ldc_solinean.solicitud%type,
        isbestado       in ldc_solinean.estado%type,
        isbobservacion  in ldc_solinean.observacion%type
    ) IS
        csbMT_NAME   CONSTANT VARCHAR2(100) := csbSP_NAME||'prActualizaRegistro';
    BEGIN
        pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbInicio);
        
        update ldc_solinean
        set estado = isbestado, observacion = isbobservacion
        where solicitud = inusolicitud;
        
        pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin_Erc);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbFin_Err);
            RAISE pkg_Error.Controlled_Error;
    END prActualizaRegistro;
    
END pkg_ldc_solinean;
/
begin
    pkg_utilidades.prAplicarPermisos('PKG_LDC_SOLINEAN','ADM_PERSON');
end;
/