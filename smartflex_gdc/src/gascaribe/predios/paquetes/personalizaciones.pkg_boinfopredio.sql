CREATE OR REPLACE PACKAGE personalizaciones.pkg_boinfopredio IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    pkg_boinfopredio
    Autor       :   Luis Felipe Valencia Hurtado
    Fecha       :   05-07-2024
    Descripcion :   Paquete con los metodos para manejo de logica de negocio información
                    del predio

    Modificaciones  :
    Autor               Fecha           Caso        Descripcion
    felipe.valencia     05-07-2024      OSF-2752    Creacion
*******************************************************************************/

    FUNCTION fsbVersion RETURN VARCHAR2;


    PROCEDURE prcValidaPredioCastigado
    (
        inudireccion     IN  ab_address.address_id%TYPE
    );

    PROCEDURE prcActualizaPredioCastigado
    (
        inuProducto       IN servsusc.sesunuse%TYPE,
        isbCastigado      IN VARCHAR2
    );
END pkg_boinfopredio;

/
CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_boinfopredio IS

    -- Identificador del ultimo caso que hizo cambios
    csbVersion 	VARCHAR2(15) := 'OSF-3743';

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
        Programa        : prcValidaPredioCastigado 
        Descripcion     : Valida si el predio se ecuentra castigado
        Autor           : 
        Fecha           : 05/07/2024
        Parametros de Entrada

        Parametros de Salida        
        Modificaciones  :
        =========================================================
        Autor               Fecha               Descripción
        felipe.valencia     05/07/2024          OSF-2752: Creación
    ***************************************************************************/
    PROCEDURE prcValidaPredioCastigado
    (
        inudireccion     IN  ab_address.address_id%TYPE
    )
    IS
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'prcValidaPredioCastigado';

        blCastigado         BOOLEAN := FALSE;
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);    

        pkg_traza.trace('inudireccion: ' || inudireccion, pkg_traza.cnuNivelTrzDef);    

        blCastigado := pkg_bcInfoPredio.fblPredioCastigado(inudireccion);

        IF (blCastigado = TRUE) THEN
            sbError := 'No es posible registrar la solicitud ya que el predio tiene un producto castigado';

            Pkg_Error.SetErrorMessage( inuCodeError => 2741,isbMsgErrr => sbError);
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
    END prcValidaPredioCastigado;

    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prcActualizaPredioCastigado
        Descripcion     : Marca o desmarca predio como castigado
        Autor           : Luis Felipe Valencia Hurtado
        Fecha           : 17-12-2024
    
        Parametros de Entrada
        inuProducto       Producto,
        isbCastigado      Castigado
        
        Parametros de Salida
    
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso      Descripcion
    ***************************************************************************/
    PROCEDURE prcActualizaPredioCastigado
    (
        inuProducto       IN servsusc.sesunuse%TYPE,
        isbCastigado      IN VARCHAR2
    ) 
    IS   
        -- Nombre de este metodo
        csbMetodo           VARCHAR2(70) := csbSP_NAME || '.prcActualizaPredioCastigado';
        nuErrorCode         NUMBER; -- se almacena codigo de error
        sbMensError         VARCHAR2(4000); -- se almacena descripcion del error 

        onuCodigoError      NUMBER; 
        osbMensajeError     VARCHAR2(4000);
        nuDireccion         ab_address.address_id%TYPE; 
        oclRespuesta        CLOB;  
        nuInfoPredioId      ldc_info_predio.ldc_info_predio_id%TYPE;
        nuPredio            ldc_info_predio.premise_id%TYPE;
    BEGIN    
        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        pkg_Traza.trace('Producto ['||inuProducto||']',pkg_traza.cnuNivelTrzDef);

        pkg_Traza.trace('Marca Castigo ['||isbCastigado||']',pkg_traza.cnuNivelTrzDef);

        nuDireccion := pkg_bcproducto.fnuiddireccinstalacion(inuProducto);

        pkg_Traza.trace('Direccion del producto ['||nuDireccion||']',pkg_traza.cnuNivelTrzDef);

        nuInfoPredioId := pkg_bcInfoPredio.fnuObtieneInfoPredio(nuDireccion);

        IF (nuInfoPredioId IS NOT NULL) THEN
            nuPredio := pkg_bcInfoPredio.fnuObtienePredio(nuDireccion);
            ldci_pkg_bointegragis.prcMarcaPredioCastigado
            (
                nuPredio,
                isbCastigado,
                oclRespuesta,
                onuCodigoError,
                osbMensajeError
            );

            IF NVL(onuCodigoError,0) = 0 THEN                    
                pkg_ldc_info_predio.prcActualizaCastigo(nuInfoPredioId,isbCastigado);
            ELSE
                Pkg_Error.SetErrorMessage(pkg_error.CNUGENERIC_MESSAGE, osbMensajeError);
            END IF;
        END IF;

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);    
    EXCEPTION
        WHEN pkg_Error.Controlled_Error THEN
            pkg_Error.getError(nuErrorCode, sbMensError);
            pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;        
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuErrorCode, sbMensError);
            pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;        
    END prcActualizaPredioCastigado;
END pkg_boinfopredio;
/

PROMPT Otorgando permisos de ejecución para personalizaciones.pkg_boinfopredio
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BOINFOPREDIO', 'PERSONALIZACIONES');
END;
/