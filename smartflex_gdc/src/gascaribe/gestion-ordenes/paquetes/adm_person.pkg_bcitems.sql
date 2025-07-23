CREATE OR REPLACE PACKAGE ADM_PERSON.pkg_bcitems IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Paquete     :   pkg_bcitems
    Autor       :   Jhon Soto - Horbath
    Fecha       :   21-09-2023
    Descripcion :   Paquete con los metodos para manejo de información sobre las
					tablas OPEN.GE_ITEM

    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jsoto       21-09-2023   OSF-1606   Creacion
    fvalencia   27-06-2024  OSF-2932    Se crear el cursor cuRecord, tipo tytbItem
                                        y la función
    jpinedc     27-03-2025  OSF-4042    * Se crea fnuObtieneValorItem
                                        * Se crean CNUADJUSTMENTACTIVITY,
                                        CNUCLASIFICACION_HERR
                                        CNUCLASIFICACION_MATER_INVE
                                        CNUCLASIFICACION_EQUIPO
                                        * Se crea fblExiste
                                        * prcValidaItemExiste
                                        * fnuObtClasificacionItem
                                        * fblItem_Es_Material
                                        * fblItem_Es_Cotizado
                                        
*******************************************************************************/

    CURSOR cuRecord(isbcodigo IN ge_items.code%TYPE) IS
    SELECT  ge_items.*, ge_items.rowid
    FROM    ge_items
    WHERE   code = isbcodigo;

    SUBTYPE styItem  IS cuRecord%ROWTYPE;

    TYPE tytbItem IS TABLE OF styItem INDEX BY BINARY_INTEGER;
    
    CNUADJUSTMENTACTIVITY       CONSTANT    ge_items.items_id%type := GE_BOITEMSCONSTANTS.CNUADJUSTMENTACTIVITY;
    CNUCLASIFICACION_HERR       CONSTANT    ge_items.items_id%type := GE_BOItemsConstants.CNUCLASIFICACION_HERR;
    CNUCLASIFICACION_MATER_INVE CONSTANT    ge_items.items_id%type := GE_BOItemsConstants.CNUCLASIFICACION_MATER_INVE;
    CNUCLASIFICACION_EQUIPO     CONSTANT    ge_items.items_id%type := GE_BOItemsConstants.CNUCLASIFICACION_EQUIPO;
    
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

    FUNCTION frcObtieneRegistroItem(isbCodigo IN ge_items.code%TYPE)
    RETURN styItem;

    FUNCTION fblEsObsoleto
    (
        inuItem     IN  ge_items.items_id%TYPE
    )
    RETURN BOOLEAN;
        
    -- Retorna verdadero si el item existe
    FUNCTION fblExiste
    (
        inuItem            IN  ge_items.item_classif_id%TYPE
    )
    RETURN BOOLEAN;

    -- Eleva mensaje de error si el item no existe
    PROCEDURE prcValidaItemExiste
    (
        inuItem            IN  ge_items.item_classif_id%TYPE
    );
    
    -- Obtiene la clasificación del item
    FUNCTION fnuObtClasificacionItem
    (
        inuItem            IN  ge_items.item_classif_id%TYPE
    )
    RETURN ge_items.item_classif_id%TYPE;

    -- Retorna verdadero si el item esta clasificado como material
    FUNCTION fblItem_Es_Material
    (
        inuItem            IN  ge_items.items_id%TYPE
    )
    RETURN BOOLEAN;

    -- Retorna verdadero si el item esta clasificado como cotizado
    FUNCTION fblItem_Es_Cotizado
    (
        inuItem            IN  ge_items.items_id%TYPE
    )
    RETURN BOOLEAN;
      
END pkg_bcitems;

/

CREATE OR REPLACE PACKAGE BODY ADM_PERSON.pkg_bcitems IS

    -- Identificador del ultimo caso que hizo cambios
    csbVersion 	VARCHAR2(15) := 'OSF-4042';

    -- Constantes para el control de la traza
    csbSP_NAME 	CONSTANT VARCHAR2(35):= 'pkg_bcitems.';
    cnuNVLTRC 	CONSTANT NUMBER := 5;

    csbCLASIFICAION_ITEMS_MATERIAL  CONSTANT LD_Parameter.Value_Chain%TYPE :=   pkg_BCLD_Parameter.fsbObtieneValorCadena('CLASE_ITEMS_DE_MATERIAL');

    csbCOD_ITEMCOTI_LDCRIAIC        CONSTANT LD_Parameter.Value_Chain%TYPE :=   pkg_BCLD_Parameter.fsbObtieneValorCadena('COD_ITEMCOTI_LDCRIAIC');

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

            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

            IF (cuDescripcion%ISOPEN) THEN
                CLOSE cuDescripcion;
            END IF;

            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        END CierraCursorDescripcion;

    BEGIN

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
		pkg_traza.trace('inuItem: ' || inuItem, cnuNVLTRC);

        CierraCursorDescripcion;

        OPEN cuDescripcion(inuItem);
        FETCH cuDescripcion INTO sbDescripcion;
        CLOSE cuDescripcion;

        pkg_traza.trace('sbDescripcion: ' || sbDescripcion, cnuNVLTRC);
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

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

            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

            IF (cuClasificacion%ISOPEN) THEN
                CLOSE cuClasificacion;
            END IF;

            pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        END CierraCursorClasificacion;

    BEGIN

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('inuItem: ' || inuItem, cnuNVLTRC);

        CierraCursorClasificacion;

        OPEN cuClasificacion(inuItem);
        FETCH cuClasificacion INTO nuClasificacion;
        CLOSE cuClasificacion;

        pkg_traza.trace('nuClasificacion: ' || nuClasificacion, cnuNVLTRC);
		pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

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
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fblExiste 
    Descripcion     : Retorna Verdadero si el item existe
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 05/03/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     05/03/2025  OSF-4042 Creacion
    ***************************************************************************/                     
    FUNCTION fblExiste
    (
        inuItem            IN  ge_items.item_classif_id%TYPE
    )
    RETURN BOOLEAN
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fblExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        blExiste        BOOLEAN;
        
        nuItems_Id   ge_items.Items_id%TYPE;
        
        CURSOR cuExiste
        IS
        SELECT items_id
        FROM ge_items
        WHERE items_id = inuItem;
      
        PROCEDURE prcCierraCursor
        IS
            -- Nombre de este mtodo
            csbMetodo1        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcCerrarCursor';
            nuError1         NUMBER;
            sbError1         VARCHAR2(4000);        
        BEGIN

            pkg_traza.trace(csbMetodo1, cnuNVLTRC, pkg_traza.csbINICIO);
            
            IF cuExiste%ISOPEN THEN
                CLOSE cuExiste;
            END IF;  

            pkg_traza.trace(csbMetodo1, cnuNVLTRC, pkg_traza.csbFIN); 
            
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo1, cnuNVLTRC, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError1,sbError1);        
                pkg_traza.trace('sbError1 => ' || sbError1, cnuNVLTRC );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo1, cnuNVLTRC, pkg_traza.csbFIN_ERR);          
                pkg_error.setError;
                pkg_Error.getError(nuError1,sbError1);
                pkg_traza.trace('sbError1 => ' || sbError1, cnuNVLTRC );
                RAISE pkg_error.Controlled_Error;
        
        END prcCierraCursor;

    BEGIN

        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO);  
        
        OPEN cuExiste;
        FETCH cuExiste INTO nuItems_Id;
        CLOSE cuExiste;
        
        blExiste := nuItems_Id IS NOT NULL;
        
        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN);              

        RETURN  blExiste;
        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, cnuNVLTRC );
            prcCierraCursor;
            RETURN  blExiste;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, cnuNVLTRC );
            prcCierraCursor;
            RETURN  blExiste;
    END fblExiste;

    -- Eleva mensaje de error si el item no existe
    PROCEDURE prcValidaItemExiste
    (
        inuItem            IN  ge_items.item_classif_id%TYPE
    )
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcValidaItemExiste';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);  
        
    BEGIN  

        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO);
        
        IF NOT fblExiste( inuItem ) THEN
            pkg_error.setErrorMessage( isbMsgErrr => 'El item [' || inuItem || '] no existe en ge_items'  ); 
        END IF;
        
        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN);
        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, cnuNVLTRC );
            RAISE pkg_error.Controlled_Error ;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, cnuNVLTRC );
            RAISE pkg_error.Controlled_Error ;
    END prcValidaItemExiste;    

    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fnuObtClasificacionItem 
    Descripcion     : Obtiene la clasificación del item
    Autor           : Lubin Pineda - GlobalMVM 
    Fecha           : 25/02/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     25/02/2025  OSF-4042 Creacion
    ***************************************************************************/                     
    FUNCTION fnuObtClasificacionItem
    (
        inuItem            IN  ge_items.item_classif_id%TYPE
    )
    RETURN ge_items.item_classif_id%TYPE
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtClasificacionItem';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        nuItem_classif_id   ge_items.item_classif_id%TYPE;
        
        CURSOR cuObtitem_classif_id
        IS
        SELECT item_classif_id
        FROM ge_items
        WHERE items_id = inuItem;
      
        PROCEDURE prcCierraCursor
        IS
            -- Nombre de este mtodo
            csbMetodo1        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcCerrarCursor';
            nuError1         NUMBER;
            sbError1         VARCHAR2(4000);        
        BEGIN

            pkg_traza.trace(csbMetodo1, cnuNVLTRC, pkg_traza.csbINICIO);
            
            IF cuObtitem_classif_id%ISOPEN THEN
                CLOSE cuObtitem_classif_id;
            END IF;  

            pkg_traza.trace(csbMetodo1, cnuNVLTRC, pkg_traza.csbFIN); 
            
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo1, cnuNVLTRC, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError1,sbError1);        
                pkg_traza.trace('sbError1 => ' || sbError1, cnuNVLTRC );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo1, cnuNVLTRC, pkg_traza.csbFIN_ERR);          
                pkg_error.setError;
                pkg_Error.getError(nuError1,sbError1);
                pkg_traza.trace('sbError1 => ' || sbError1, cnuNVLTRC );
                RAISE pkg_error.Controlled_Error;
        
        END prcCierraCursor;

    BEGIN

        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO);  
        
        OPEN cuObtitem_classif_id;
        FETCH cuObtitem_classif_id INTO nuItem_classif_id;
        CLOSE cuObtitem_classif_id;
        
        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN);              

        RETURN  nuItem_classif_id;
        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, cnuNVLTRC );
            prcCierraCursor;
            RETURN  nuItem_classif_id;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, cnuNVLTRC );
            prcCierraCursor;
            RETURN  nuItem_classif_id;
    END fnuObtClasificacionItem;
    
    -- Retorna verdadero si el item esta clasificado como material
    FUNCTION fblItem_Es_Material
    (
        inuItem            IN  ge_items.items_id%TYPE
    )
    RETURN BOOLEAN
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fblItem_Es_Material';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        blItem_Es_Material   BOOLEAN;
        
        nuEsMaterial         NUMBER;
        
        nuClasificacionItem  NUMBER;
        
        CURSOR cuItem_Es_Material( inuClasificacionItem NUMBER)
        IS
        SELECT to_number(regexp_substr(csbCLASIFICAION_ITEMS_MATERIAL,'[^,]+', 1,LEVEL))
        FROM dual
        WHERE to_number(regexp_substr(csbCLASIFICAION_ITEMS_MATERIAL,'[^,]+', 1,LEVEL)) = inuClasificacionItem
        CONNECT BY regexp_substr(csbCLASIFICAION_ITEMS_MATERIAL, '[^,]+', 1, LEVEL) IS NOT NULL;
        
      
        PROCEDURE prcCierraCursor
        IS
            -- Nombre de este mtodo
            csbMetodo1        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcCerrarCursor';
            nuError1         NUMBER;
            sbError1         VARCHAR2(4000);        
        BEGIN

            pkg_traza.trace(csbMetodo1, cnuNVLTRC, pkg_traza.csbINICIO);
            
            IF cuItem_Es_Material%ISOPEN THEN
                CLOSE cuItem_Es_Material;
            END IF;  

            pkg_traza.trace(csbMetodo1, cnuNVLTRC, pkg_traza.csbFIN); 
            
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo1, cnuNVLTRC, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError1,sbError1);        
                pkg_traza.trace('sbError1 => ' || sbError1, cnuNVLTRC );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo1, cnuNVLTRC, pkg_traza.csbFIN_ERR);          
                pkg_error.setError;
                pkg_Error.getError(nuError1,sbError1);
                pkg_traza.trace('sbError1 => ' || sbError1, cnuNVLTRC );
                RAISE pkg_error.Controlled_Error;
        
        END prcCierraCursor;

    BEGIN

        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO);  
        
        nuClasificacionItem := fnuObtClasificacionItem( inuItem );

        pkg_traza.trace('nuClasificacionItem|'|| nuClasificacionItem, cnuNVLTRC);  
        
        OPEN cuItem_Es_Material(nuClasificacionItem);
        FETCH cuItem_Es_Material INTO nuEsMaterial;
        CLOSE cuItem_Es_Material;

        pkg_traza.trace('nuEsMaterial|'|| nuEsMaterial, cnuNVLTRC);  
        
        blItem_Es_Material := nuEsMaterial IS NOT NULL;
        
        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN);              

        RETURN  blItem_Es_Material;
        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, cnuNVLTRC );
            prcCierraCursor;
            RETURN  blItem_Es_Material;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, cnuNVLTRC );
            prcCierraCursor;
            RETURN  blItem_Es_Material;
    END fblItem_Es_Material;
    
    -- Retorna verdadero si el item esta clasificado como cotizado
    FUNCTION fblItem_Es_Cotizado
    (
        inuItem            IN  ge_items.items_id%TYPE
    )
    RETURN BOOLEAN
    IS
        -- Nombre de este mtodo
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fblItem_Es_Cotizado';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        blItem_Es_Cotizado   BOOLEAN;
        
        nuEsCotizado         NUMBER;
                       
        CURSOR cuItem_Es_Cotizado( inuItemCotizado NUMBER)
        IS
        SELECT count(1) Cantidad
        FROM dual
        WHERE inuItemCotizado IN
        (
            SELECT to_number(regexp_substr(csbCOD_ITEMCOTI_LDCRIAIC,'[^,]+', 1,LEVEL))
            FROM dual
            CONNECT BY regexp_substr(csbCOD_ITEMCOTI_LDCRIAIC, '[^,]+', 1, LEVEL) IS NOT NULL
        );
        
        PROCEDURE prcCierraCursor
        IS
            -- Nombre de este mtodo
            csbMetodo1        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prcCerrarCursor';
            nuError1         NUMBER;
            sbError1         VARCHAR2(4000);        
        BEGIN

            pkg_traza.trace(csbMetodo1, cnuNVLTRC, pkg_traza.csbINICIO);
            
            IF cuItem_Es_Cotizado%ISOPEN THEN
                CLOSE cuItem_Es_Cotizado;
            END IF;  

            pkg_traza.trace(csbMetodo1, cnuNVLTRC, pkg_traza.csbFIN); 
            
        EXCEPTION
            WHEN pkg_error.Controlled_Error THEN
                pkg_traza.trace(csbMetodo1, cnuNVLTRC, pkg_traza.csbFIN_ERC);
                pkg_Error.getError(nuError1,sbError1);        
                pkg_traza.trace('sbError1 => ' || sbError1, cnuNVLTRC );
                RAISE pkg_error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_traza.trace(csbMetodo1, cnuNVLTRC, pkg_traza.csbFIN_ERR);          
                pkg_error.setError;
                pkg_Error.getError(nuError1,sbError1);
                pkg_traza.trace('sbError1 => ' || sbError1, cnuNVLTRC );
                RAISE pkg_error.Controlled_Error;
        
        END prcCierraCursor;

    BEGIN

        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO);  
          
        OPEN cuItem_Es_Cotizado(inuItem);
        FETCH cuItem_Es_Cotizado INTO nuEsCotizado;
        CLOSE cuItem_Es_Cotizado;

        pkg_traza.trace('nuEsCotizado|'|| nuEsCotizado, cnuNVLTRC);  
        
        blItem_Es_Cotizado := nuEsCotizado > 0;
        
        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN);              

        RETURN  blItem_Es_Cotizado;
        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, cnuNVLTRC );
            prcCierraCursor;
            RETURN  blItem_Es_Cotizado;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, cnuNVLTRC );
            prcCierraCursor;
            RETURN  blItem_Es_Cotizado;
    END fblItem_Es_Cotizado; 
            
END pkg_bcitems;
/

PROMPT Otorgando permisos de ejecución para adm_person.pkg_bcitems
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BCITEMS', 'ADM_PERSON');
END;
/

