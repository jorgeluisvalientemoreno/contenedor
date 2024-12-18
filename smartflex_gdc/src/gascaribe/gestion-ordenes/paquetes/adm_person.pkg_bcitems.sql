CREATE OR REPLACE PACKAGE adm_person.pkg_bcitems IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    pkg_bcitems
    Autor       :   Jhon Soto - Horbath
    Fecha       :   21-09-2023
    Descripcion :   Paquete con los metodos para manejo de información sobre las 
					tablas OPEN.GE_ITEM

    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    fvalencia   27-06-2024  OSF-2932 Se crear el cursor cuRecord, tipo tytbItem
                                     y la función 
    jsoto      21-09-2023   OSF-1606 Creacion
*******************************************************************************/
    -- Retorna la causal de la orden
    FUNCTION fsbObtenerDescripcion
	(
		inuitem 	IN 	ge_items.items_id%TYPE
	)
    RETURN ge_items.description%TYPE;
    
    FUNCTION fnuObtenerClasificacion
	(
		inuitem 	IN 	ge_items.items_id%TYPE
	)
    RETURN ge_items.item_classif_id%TYPE;

END pkg_bcitems;

/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_bcitems IS

    -- Identificador del ultimo caso que hizo cambios
    csbVersion 	VARCHAR2(15) := 'OSF-2932';

    -- Constantes para el control de la traza
    csbSP_NAME 	CONSTANT VARCHAR2(35):= 'pkg_bcitems.';
    cnuNVLTRC 	CONSTANT NUMBER := 5;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbObtenerDescripcion 
    Descripcion     : Retorna la descripcion del item
    Autor           : Jhon Soto - Horbath
    Fecha           : 21-09-2023

    Parametros de Entrada: 	inuitem:  Código de Item
    Retorna:	 		Descripción del item


    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       21-09-2023  OSF-1606 Creacion
    ***************************************************************************/
    FUNCTION fsbObtenerDescripcion
	(
		inuItem 	IN 	ge_items.items_id%TYPE
	)
    RETURN ge_items.description%TYPE
    IS

        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fsbObtenerDescripcion';
        
        CURSOR cuDescripcion(inuItem IN ge_items.items_id%TYPE) IS
			SELECT  description
			FROM 	ge_items
			WHERE 	items_id = inuItem;
        
        sbDescripcion    ge_items.description%TYPE;
        
        PROCEDURE CierraCursorDescripcion
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.CierraCursorDescripcion';
        BEGIN
        
            ut_trace.trace('Inicia ' || csbMT_NAME1, cnuNVLTRC);
        
            IF (cuDescripcion%ISOPEN) THEN
                CLOSE cuDescripcion;
            END IF;

            ut_trace.trace('Termina ' || csbMT_NAME1, cnuNVLTRC);

        END CierraCursorDescripcion;
        
    BEGIN
    
        ut_trace.trace('Inicia ' || csbMT_NAME, cnuNVLTRC);
		ut_trace.trace('inuItem: ' || inuItem, cnuNVLTRC);
        
        CierraCursorDescripcion;
    
        OPEN cuDescripcion(inuItem);
        FETCH cuDescripcion INTO sbDescripcion;
        CLOSE cuDescripcion;

        ut_trace.trace('sbDescripcion: ' || sbDescripcion, cnuNVLTRC);
		ut_trace.trace('Termina ' || csbMT_NAME, cnuNVLTRC);
        
        RETURN sbDescripcion;
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
            CierraCursorDescripcion;
            RETURN sbDescripcion;
    END fsbObtenerDescripcion;
    
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtenerClasificacion 
    Descripcion     : Retorna el id de la clasificación del item
    Autor           : Jhon Soto - Horbath
    Fecha           : 21-09-2023

    Parametros de Entrada: 	inuitem:  Código de Item
    Retorna:	 		Clasificación del item

    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    jsoto       21-09-2023  OSF-1606 Creacion
    ***************************************************************************/

    FUNCTION fnuObtenerClasificacion
	(
		inuitem 	IN 	ge_items.items_id%TYPE
	)
    RETURN ge_items.item_classif_id%TYPE
        IS

        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fnuObtenerClasificacion';
        
        CURSOR cuClasificacion(inuItem IN ge_items.items_id%TYPE) IS
			SELECT  item_classif_id
			FROM 	ge_items
			WHERE 	items_id = inuItem;
        
        nuClasificacion    ge_items.item_classif_id%TYPE;
        
        PROCEDURE CierraCursorClasificacion
        IS
            -- Nombre de este método
            csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.CierraCursorClasificacion';
        BEGIN
        
            ut_trace.trace('Inicia ' || csbMT_NAME1, cnuNVLTRC);
        
            IF (cuClasificacion%ISOPEN) THEN
                CLOSE cuClasificacion;
            END IF;

            ut_trace.trace('Termina ' || csbMT_NAME1, cnuNVLTRC);

        END CierraCursorClasificacion;
        
    BEGIN
    
        ut_trace.trace('Inicia ' || csbMT_NAME, cnuNVLTRC);
		ut_trace.trace('inuItem: ' || inuItem, cnuNVLTRC);
        
        CierraCursorClasificacion;
    
        OPEN cuClasificacion(inuItem);
        FETCH cuClasificacion INTO nuClasificacion;
        CLOSE cuClasificacion;

        ut_trace.trace('nuClasificacion: ' || nuClasificacion, cnuNVLTRC);
		ut_trace.trace('Termina ' || csbMT_NAME, cnuNVLTRC);
        
        RETURN nuClasificacion;
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
            CierraCursorClasificacion;
            RETURN nuClasificacion;
    END fnuObtenerClasificacion;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : frcObtieneRegistroItem 
    Descripcion     : retorna el registro del item
    Autor           : Luis Felipe Valencia Hurtado
    Fecha           : 28-06-2024
    Caso            : OSF-2932
      
    Parametros de entrada
    inuItem  Id del item a consultar en la tabla ge_items
      
    Parametros de salida
    styItem   Registro del item
      
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    fvalencia   28-06-2024  OSF-2932    Creación
    ***************************************************************************/
    FUNCTION frcObtieneRegistroItem(isbCodigo IN ge_items.code%TYPE)
    RETURN styItem IS
    
      csbMetodo VARCHAR2(70) := csbSP_NAME || 'frcObtieneRegistroItem';
    
      rcDatos      styItem;
      nuError  NUMBER;
      sbError VARCHAR2(2000);
    
    BEGIN
        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);

        pkg_traza.trace('isbCodigo: ' || isbCodigo, pkg_traza.cnuNivelTrzDef);

        IF cuRecord%ISOPEN THEN
            CLOSE cuRecord;
        END IF;

        OPEN cuRecord(isbCodigo);
        FETCH cuRecord INTO rcDatos;
        CLOSE cuRecord;

        pkg_traza.trace('rcDatos.items_id: '||rcDatos.items_id, pkg_traza.cnuNivelTrzDef);

        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);

        RETURN rcDatos;    
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RETURN rcDatos;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
           RETURN rcDatos;
    END frcObtieneRegistroItem;

    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fblEsObsoleto 
        Descripcion     : Valida si el item eviado esta marcado como obsolto
        Autor           : 
        Fecha           : 28/06/2024
        Parametros de Entrada
        
        Parametros de Salida        
        Modificaciones  :
        =========================================================
        Autor               Fecha               Descripción
        felipe.valencia     28/06/2024          OSF-2932: Creación
    ***************************************************************************/
    FUNCTION fblEsObsoleto
    (
        inuItem     IN  ge_items.items_id%TYPE
    )
    RETURN BOOLEAN
    IS
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'fblEsObsoleto';

        blExiste            BOOLEAN := FALSE;
        nuContar            NUMBER;

        CURSOR cuConsultaItem
        IS
        SELECT COUNT(1)
        FROM   ge_items
        WHERE   items_id = inuItem
        AND     NVL(obsoleto, 'N') = 'S';
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        IF (cuConsultaItem%ISOPEN) THEN
            CLOSE cuConsultaItem;
        END IF;

        OPEN cuConsultaItem;
        FETCH cuConsultaItem INTO nuContar;
        CLOSE cuConsultaItem;

        IF (nuContar > 0) THEN
            blExiste := TRUE;
        END IF;  

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        RETURN blExiste;

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RETURN blExiste;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN blExiste;  
    END fblEsObsoleto;
END;
/

PROMPT Otorgando permisos de ejecución para adm_person.pkg_bcitems
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BCITEMS', 'ADM_PERSON');
END;
/