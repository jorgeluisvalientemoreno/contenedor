CREATE OR REPLACE PACKAGE adm_person.PKG_LDC_SOLIPRPLCAES IS
/*****************************************************************
    Propiedad intelectual de Gases del Caribe

    Unidad         : adm_person.PKG_LDC_DESCAPLI
    Descripción    : Paquete de primer nivel para gestión de la tabla ldc_soliprplcaes
    Autor          : jcatuche
    Fecha          : 23/08/2024

    Fecha           Autor               Modificación
    =========       =========           ====================
	23/08/2024      jcatuche            OSF-2974: Creación
******************************************************************/
    PROCEDURE prInsertaRegistro
    (
        inusolicitud    in ldc_soliprplcaes.solicitud%type,
        isbestado       in ldc_soliprplcaes.estado%type
    ); 
    
    PROCEDURE prActualizaRegistro
    (
        inusolicitud    in ldc_soliprplcaes.solicitud%type,
        isbestado       in ldc_soliprplcaes.estado%type
    ); 
    
    
    
    
END PKG_LDC_SOLIPRPLCAES;
/
CREATE OR REPLACE PACKAGE BODY adm_person.PKG_LDC_SOLIPRPLCAES IS
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
    Descripcion     : Inserta registro en ldc_soliprplcaes

    Autor           : jcatuche
    Fecha           : 23/08/2024

    Parametros de Entrada
        inusolicitud    solicitud
        isbestado       estado
        
        
    Parametros de Salida
        NA
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripción
    jcatuche    23/08/2024  OSF-2974    Creación
    ***************************************************************************/
    PROCEDURE prInsertaRegistro
    (
        inusolicitud    in ldc_soliprplcaes.solicitud%type,
        isbestado       in ldc_soliprplcaes.estado%type
    ) IS
        csbMT_NAME   CONSTANT VARCHAR2(100) := csbSP_NAME||'prInsertaRegistro';
    BEGIN
        pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbInicio);
        
        insert into ldc_soliprplcaes (solicitud,fecha_registro,estado)
        values (inusolicitud,sysdate,isbestado);
        
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
    Descripcion     : Actualiza registro en ldc_soliprplcaes

    Autor           : jcatuche
    Fecha           : 23/08/2024

    Parametros de Entrada
        inusolicitud    solicitud
        isbestado       estado
        
        
    Parametros de Salida
        NA
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripción
    jcatuche    23/08/2024  OSF-2974    Creación
    ***************************************************************************/
    PROCEDURE prActualizaRegistro
    (
        inusolicitud    in ldc_soliprplcaes.solicitud%type,
        isbestado       in ldc_soliprplcaes.estado%type
    ) IS
        csbMT_NAME   CONSTANT VARCHAR2(100) := csbSP_NAME||'prActualizaRegistro';
    BEGIN
        pkg_traza.trace(csbMT_NAME, cnuNivelTraza, csbInicio);
        
        update ldc_soliprplcaes
        set estado = isbestado
        where solicitud = inusolicitud
        and estado = 'T'
        ;
        
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
        
END PKG_LDC_SOLIPRPLCAES;
/
begin
    pkg_utilidades.prAplicarPermisos('PKG_LDC_SOLIPRPLCAES','ADM_PERSON');
end;
/