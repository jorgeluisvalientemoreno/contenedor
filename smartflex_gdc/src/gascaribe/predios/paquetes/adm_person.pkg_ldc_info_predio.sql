CREATE OR REPLACE PACKAGE adm_person.pkg_ldc_info_predio IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    pkg_ldc_info_predio
    Autor       :   Luis Felipe Valencia Hurtado
    Fecha       :   05-07-2024
    Descripcion :   Paquete con los metodos para manejo de información sobre información
                    del predio

    Modificaciones  :
    Autor               Fecha           Caso        Descripcion
    felipe.valencia     05-07-2024      OSF-2752    Creacion
*******************************************************************************/

    FUNCTION fsbVersion RETURN VARCHAR2;


	PROCEDURE prcActualizaCastigo
	(
		inuInfoPredioId     IN ldc_info_predio.ldc_info_predio_id%TYPE,
		isbPredioCastigado  IN ldc_info_predio.predio_castigado%TYPE
	);

END pkg_ldc_info_predio;

/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_ldc_info_predio IS

    -- Identificador del ultimo caso que hizo cambios
    csbVersion 	VARCHAR2(15) := 'OSF-2752';

    -- Constantes para el control de la traza
    csbSP_NAME 	CONSTANT VARCHAR2(35):= $$PLSQL_UNIT||'.';
    cnuNVLTRC 	CONSTANT NUMBER := 5;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion 
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Felipe Valencia Hurtado
    Fecha           : 05/07/2024
    Modificaciones  :
    Autor               Fecha       Caso        Descripcion
    felipe.valencia     05/07/2024  OSF-2752    Creacion
    ***************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;

    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prcActualizaCastigo 
        Descripcion     : Actualiza información de predio castigado
        Autor           : 
        Fecha           : 17/07/2024
        Parametros de Entrada
            inuInfoPredioId     Código de información del predio
            isbPredioCastigado  S si el predio esta castido N de lo contrario
        Parametros de Salida        
        Modificaciones  :
        =========================================================
        Autor               Fecha               Descripción
        felipe.valencia     17/07/2024          OSF-2752: Creación
    ***************************************************************************/
	PROCEDURE prcActualizaCastigo
	(
		inuInfoPredioId     IN ldc_info_predio.ldc_info_predio_id%TYPE,
		isbPredioCastigado  IN ldc_info_predio.predio_castigado%TYPE
	)
	IS
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'prcActualizaCastigo';
	BEGIN
		UPDATE  ldc_info_predio
		SET	    predio_castigado = isbPredioCastigado
		WHERE 	ldc_info_predio_id = inuInfoPredioId;

		IF SQL%NOTFOUND THEN
			RAISE no_data_found;
		END IF;
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
	END prcActualizaCastigo;
END pkg_ldc_info_predio;
/

PROMPT Otorgando permisos de ejecución para adm_person.pkg_ldc_info_predio
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_LDC_INFO_PREDIO', 'ADM_PERSON');
END;
/