CREATE OR REPLACE PACKAGE personalizaciones.pkg_boactualizadatospredio IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    pkg_boactualizadatospredio
    Autor       :   Luis Felipe Valencia Hurtado
    Fecha       :   08-11-2024
    Descripcion :   Paquete con los metodos para manejo de logica de negocio de
                    la solicitud de actualización de datos de predio

    Modificaciones  :
    Autor               Fecha           Caso        Descripcion
    felipe.valencia     08-11-2024      OSF-3198    Creacion
*******************************************************************************/

    cnuAtribDirDummy            CONSTANT NUMBER := 5001333;
    cnuTipoSolicitudDatoPredio  CONSTANT NUMBER := 100220;

    FUNCTION fsbVersion RETURN VARCHAR2;


    PROCEDURE prcValidaAplicaResolucion
    (
        inuCategoriaVieja    IN  NUMBER,
        inuCategoriaNueva    IN  NUMBER,
        inuSubcategVieja     IN  NUMBER,
        inuSubcategNueva     IN  NUMBER,
        isbResolucion        IN  VARCHAR2
    );

    PROCEDURE prcReglaPreCambiarDatosPredio
    (

        inuDireccionInstalNueva     IN  NUMBER,
        inuDireccionInstalVieja     IN  NUMBER,   
        inuDireccionFactNueva       IN  NUMBER,  
        inuDireccionFactVieja       IN  NUMBER,
        inuSubcategoriaVieja        IN  NUMBER,
        inuSubcategoriaNueva        IN  NUMBER,
        inuCategoriaNueva           IN  NUMBER,
        inuCategoriaVieja           IN  NUMBER,
        isbResolucion               IN  VARCHAR2,
        isbDirIntalacionReal        IN  VARCHAR2,
        isbDirEntregaReal           IN  VARCHAR2
    );

END pkg_boactualizadatospredio;

/
CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_boactualizadatospredio IS

    -- Identificador del ultimo caso que hizo cambios
    csbVersion 	VARCHAR2(15) := 'OSF-3198';

    -- Constantes para el control de la traza
    csbSP_NAME 	CONSTANT VARCHAR2(35):= $$PLSQL_UNIT||'.';
    cnuNVLTRC 	CONSTANT NUMBER := 5;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion 
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Felipe Valencia Hurtado
    Fecha           : 08/11/2024
    Modificaciones  :
    Autor               Fecha       Caso        Descripcion
    felipe.valencia     08/11/2024  OSF-3198    Creacion
    ***************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;


    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prcValidaAplicaResolucion 
        Descripcion     : Valida si debe diligenciar el campo resolución
        Autor           : 
        Fecha           : 08/11/2024
        Parametros de Entrada
        inuCategoriaVieja    Categoría Vieja,
        inuCategoriaNueva    Categoría Nueva,
        inuSubcategVieja     Subcategoría Vieja,
        inuSubcategNueva     Subcategoría Nueva,
        isbResolucion        Resolución

        Parametros de Salida        
        Modificaciones  :
        =========================================================
        Autor               Fecha               Descripción
        felipe.valencia     08/11/2024          OSF-3198: Creación
    ***************************************************************************/
    PROCEDURE prcValidaAplicaResolucion
    (
        inuCategoriaVieja    IN  NUMBER,
        inuCategoriaNueva    IN  NUMBER,
        inuSubcategVieja     IN  NUMBER,
        inuSubcategNueva     IN  NUMBER,
        isbResolucion        IN  VARCHAR2
    )
    IS
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo           CONSTANT VARCHAR2(100) := csbSP_NAME||'prcValidaAplicaResolucion';

    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);    

        pkg_traza.trace('inuCategoriaVieja: ' || inuCategoriaVieja, pkg_traza.cnuNivelTrzDef); 
        pkg_traza.trace('inuCategoriaNueva: ' || inuCategoriaNueva, pkg_traza.cnuNivelTrzDef);   
        pkg_traza.trace('inuSubcategVieja: ' || inuSubcategVieja, pkg_traza.cnuNivelTrzDef);   
        pkg_traza.trace('inuSubcategNueva: ' || inuSubcategNueva, pkg_traza.cnuNivelTrzDef);   
        pkg_traza.trace('isbResolucion: ' || isbResolucion, pkg_traza.cnuNivelTrzDef);     

    
        IF ( (inuCategoriaVieja != 2 AND inuSubcategNueva is not NULL AND inuSubcategNueva != inuSubcategVieja) 
             OR 
             (inuCategoriaNueva is not NULL AND inuCategoriaNueva != inuCategoriaVieja AND inuCategoriaNueva != 2)
        )THEN
                IF ( isbResolucion is NULL )THEN
                    sbError := 'Al cambiar la categoría o la subcategoría se debe ingresar obligatoriamente la resolucíon';
                    pkg_error.setErrorMessage(isbMsgErrr => sbError);
                END IF;
        END IF;

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;
    END prcValidaAplicaResolucion;

    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prcReglaPreCambiarDatosPredio 
        Descripcion     : Ejecuta reglas negocio para regla pre a nivel de motivo 
                          del tramite de actualización predio
        Autor           : 
        Fecha           : 08/11/2024
        Parametros de Entrada
        inuCategoriaVieja    Categoría Vieja,
        inuCategoriaNueva    Categoría Nueva,
        inuSubcategVieja     Subcategoría Vieja,
        inuSubcategNueva     Subcategoría Nueva,
        isbResolucion        Resolución

        Parametros de Salida        
        Modificaciones  :
        =========================================================
        Autor               Fecha               Descripción
        felipe.valencia     08/11/2024          OSF-3198: Creación
    ***************************************************************************/
    PROCEDURE prcReglaPreCambiarDatosPredio
    (

        inuDireccionInstalNueva     IN  NUMBER,
        inuDireccionInstalVieja     IN  NUMBER,   
        inuDireccionFactNueva       IN  NUMBER,  
        inuDireccionFactVieja       IN  NUMBER,
        inuSubcategoriaVieja        IN  NUMBER,
        inuSubcategoriaNueva        IN  NUMBER,
        inuCategoriaNueva           IN  NUMBER,
        inuCategoriaVieja           IN  NUMBER,
        isbResolucion               IN  VARCHAR2,
        isbDirIntalacionReal        IN  VARCHAR2,
        isbDirEntregaReal           IN  VARCHAR2
    )
    IS
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo           CONSTANT VARCHAR2(100) := csbSP_NAME||'prcValidaAplicaResolucion';

        cblVerdadero        BOOLEAN := CONSTANTS_PER.GETTRUE;
        sbParamTipoSol      VARCHAR2(10);
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);    

        pkg_traza.trace('inuDireccionInstalNueva: ' || inuDireccionInstalNueva, pkg_traza.cnuNivelTrzDef); 
        pkg_traza.trace('inuDireccionInstalVieja: ' || inuDireccionInstalVieja, pkg_traza.cnuNivelTrzDef);   
        pkg_traza.trace('inuDireccionFactNueva: ' || inuDireccionFactNueva, pkg_traza.cnuNivelTrzDef);   
        pkg_traza.trace('inuSubcategoriaVieja: ' || inuSubcategoriaVieja, pkg_traza.cnuNivelTrzDef);   
        pkg_traza.trace('inuSubcategoriaNueva: ' || inuSubcategoriaNueva, pkg_traza.cnuNivelTrzDef);  
        pkg_traza.trace('inuCategoriaNueva: ' || inuCategoriaNueva, pkg_traza.cnuNivelTrzDef);   
        pkg_traza.trace('inuCategoriaVieja: ' || inuCategoriaVieja, pkg_traza.cnuNivelTrzDef);      

    
        IF NOT (inuDireccionInstalNueva IS NOT NULL AND 
                inuDireccionInstalNueva != inuDireccionInstalVieja OR 
                inuDireccionFactNueva IS NOT NULL AND 
                inuDireccionFactNueva != inuDireccionFactVieja OR 
                inuSubcategoriaNueva IS NOT NULL AND inuSubcategoriaNueva != inuSubcategoriaVieja OR 
                inuCategoriaNueva IS NOT NULL AND inuCategoriaNueva != inuCategoriaVieja 
        )THEN
            sbError := 'El trámite no puede ser registrado ya que no ha modificado ningún dato';
            pkg_error.setErrorMessage(isbMsgErrr => sbError);
        END IF;

        prcValidaAplicaResolucion
        (
            inuCategoriaVieja,
            inuCategoriaNueva,
            inuSubcategoriaVieja,
            inuSubcategoriaNueva,
            isbResolucion
        );

        sbParamTipoSol := pkg_botiposolicitud.fsbObtParametroTipoSolicitud (cnuTipoSolicitudDatoPredio, cnuAtribDirDummy, cblVerdadero);

        IF ( inuDireccionInstalNueva = sbParamTipoSol ) THEN

            IF ( isbDirIntalacionReal IS NULL ) THEN
                sbError := 'Debe Ingresar la Dirección de Instalación a Registrar en el Sistema';
                pkg_error.setErrorMessage(isbMsgErrr => sbError);
            END IF;
        END IF;

        IF ( inuDireccionFactNueva = sbParamTipoSol ) THEN
            IF ( isbDirEntregaReal IS NULL OR isbDirEntregaReal = '-' ) THEN
                sbError := 'Debe Ingresar la Dirección de Entrega de Factura a Registrar en el Sistema';
                pkg_error.setErrorMessage(isbMsgErrr => sbError);
            END IF;
        END IF;
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;
    END prcReglaPreCambiarDatosPredio;
END pkg_boactualizadatospredio;
/

PROMPT Otorgando permisos de ejecución para personalizaciones.pkg_boactualizadatospredio
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BOACTUALIZADATOSPREDIO', 'PERSONALIZACIONES');
END;
/