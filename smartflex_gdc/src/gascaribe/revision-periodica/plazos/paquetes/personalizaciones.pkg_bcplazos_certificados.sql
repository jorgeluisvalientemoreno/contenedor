CREATE OR REPLACE PACKAGE personalizaciones.pkg_bcplazos_certificados IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    pkg_bcplazos_certificados
    Autor       :   Luis Felipe Valencia Hurtado
    Fecha       :   19/03/2024
    Descripcion :   Paquete con consultas para de plazos revisión periódica 
    Modificaciones  :
    Autor               Fecha           Caso        Descripcion
    felipe.valencia     19/03/2024      OSF-2443    Creacion
*******************************************************************************/

    FUNCTION fsbVersion 
    RETURN VARCHAR2;

    FUNCTION fdtplazominimo
    (
        inuContrato     IN ldc_plazos_cert.id_contrato%TYPE
    )
    RETURN DATE;

    FUNCTION fnuUnidadPlazominimo
    (
        inuAnio             IN ldc_unit_rp_plamin.anio%TYPE,
        inuMes              IN ldc_unit_rp_plamin.mes%TYPE,
        inuDepartamento     IN ldc_unit_rp_plamin.anio%TYPE
    )
    RETURN NUMBER;
END pkg_bcplazos_certificados;
/
CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_bcplazos_certificados IS

    -- Identificador del ultimo caso que hizo cambios
    csbVersion     VARCHAR2(15) := 'OSF-2443';
    -- Constantes para el control de la traza
    csbSP_NAME     CONSTANT VARCHAR2(35):= $$PLSQL_UNIT;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion 
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Felipe Valencia Hurtado
    Fecha           : 19/03/2024
    Modificaciones  :
    Autor               Fecha       Caso     Descripcion
    felipe.valencia     19/03/2024  OSF-2443 Creacion
    ***************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
    
    
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fnu_obt_cantidad_registros
        Descripcion     : Obtiene la plazo minimo del certificado
        Autor           : 
        Fecha           : 19/03/2024
        Parametros de Entrada
        
        Parametros de Salida        
        Modificaciones  :
        =========================================================
        Autor               Fecha               Descripción
        felipe.valencia     19/03/2024          OSF-2443: Creación
    ***************************************************************************/
    FUNCTION fdtplazominimo
    (
        inuContrato     IN ldc_plazos_cert.id_contrato%TYPE
    )
    RETURN DATE
    IS
        dtFechaMinima       ldc_plazos_cert.plazo_min_revision%TYPE;
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'.fdtplazominimo';

        CURSOR cuObtPlazoMinimo
        (
            inuIdContrato   IN ldc_plazos_cert.id_contrato%TYPE
        )
        IS
        SELECT  plazo_min_revision 
        FROM    ldc_plazos_cert 
        WHERE id_contrato =  inuIdContrato;

    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        IF (cuObtPlazoMinimo%ISOPEN) THEN
            CLOSE cuObtPlazoMinimo;
        END IF;

        OPEN cuObtPlazoMinimo(inuContrato);
        FETCH cuObtPlazoMinimo INTO dtFechaMinima;
        CLOSE cuObtPlazoMinimo;
        
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        RETURN dtFechaMinima;

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RETURN null;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN null;     
    END fdtplazominimo;

    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fnuUnidadPlazominimo
        Descripcion     : Obtiene la unidad operativa del plazo minimo de RP
        Autor           : 
        Fecha           : 19/03/2024
        Parametros de Entrada
        
        Parametros de Salida        
        Modificaciones  :
        =========================================================
        Autor               Fecha               Descripción
        felipe.valencia     19/03/2024          OSF-2443: Creación
    ***************************************************************************/
    FUNCTION fnuUnidadPlazominimo
    (
        inuAnio             IN ldc_unit_rp_plamin.anio%TYPE,
        inuMes              IN ldc_unit_rp_plamin.mes%TYPE,
        inuDepartamento     IN ldc_unit_rp_plamin.anio%TYPE
    )
    RETURN NUMBER
    IS
        nuUnidadOperativa   ldc_unit_rp_plamin.operating_unit_id%TYPE;
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'.fnuUnidadPlazominimo';

        CURSOR cuObtUnidadPlazoMinimo
        (
            inuAnio             IN ldc_unit_rp_plamin.anio%TYPE,
            inuMes              IN ldc_unit_rp_plamin.mes%TYPE,
            inuDepartamento     IN ldc_unit_rp_plamin.anio%TYPE
        )
        IS
        SELECT  operating_unit_id 
        FROM    ldc_unit_rp_plamin 
        WHERE   anio = inuAnio 
        AND     mes = inuMes
        AND     departamento = inuDepartamento;

    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        IF (cuObtUnidadPlazoMinimo%ISOPEN) THEN
            CLOSE cuObtUnidadPlazoMinimo;
        END IF;

        OPEN cuObtUnidadPlazoMinimo(inuAnio,inuMes,inuDepartamento);
        FETCH cuObtUnidadPlazoMinimo INTO nuUnidadOperativa;
        CLOSE cuObtUnidadPlazoMinimo;
        
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        RETURN nuUnidadOperativa;

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RETURN null;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN null; 
    END fnuUnidadPlazominimo;


END pkg_bcplazos_certificados;
/

PROMPT Otorgando permisos de ejecución para personalizaciones.pkg_bcplazos_certificados
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BCPLAZOS_CERTIFICADOS', 'PERSONALIZACIONES');
END;
/