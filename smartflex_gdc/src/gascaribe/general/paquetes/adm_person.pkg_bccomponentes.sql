CREATE OR REPLACE PACKAGE ADM_PERSON.PKG_BCCOMPONENTES IS
	/*******************************************************************************
		Fuente=Propiedad Intelectual de Gases del Caribe
		pkg_bcordenes
		Autor       :   Jhon Eduar Erazo
		Fecha       :   29-02-2024
		Descripcion :   Paquete con los metodos para manejo de información sobre los componentes
		Modificaciones  :
		Autor       Fecha       Caso     	Descripcion
		jerazomvm	29/02/2022	OSF-2374	Creación
		jpinedc     27/01/2025  OSF-3893    Se crea ftbObtCompActivProducto
        PAcosta     21/04/2025  OSF-4270    Creación objetos:
                                                Cursores: cuIdComponentes y cuRegComponentes
                                                Métodos: ftbComponentesProd y ftbRegComponetesXProdYEsta
                                                Variables globales para el control de la traza
                                                Variables privadas del paquete
	*******************************************************************************/
	-----------------------------------
    -- Cursores
    -----------------------------------
	CURSOR cuRecord( inuComponenteId IN pr_component.component_id%TYPE) 
    IS
	SELECT PR.*,
           PR.rowid
	FROM pr_component PR
	WHERE PR.component_id = inuComponenteId;

	CURSOR cuObtCompActivProducto( inuProducto IN pr_component.product_id%TYPE) 
    IS
	SELECT *
	FROM pr_component co
	WHERE co.product_id = inuProducto
	AND co.component_status_id IN
	(   
        SELECT product_status_id
        FROM ps_product_status
        WHERE prod_status_type_id = 2
        AND is_active_product = 'Y'        
	);
    
    --Consulta componentes asociados a un producto
    CURSOR cuIdComponentes(inuProducto IN pr_component.product_id%TYPE) 
    IS
    SELECT component_id
    FROM pr_component 
    WHERE product_id = inuProducto;	
    
    --Conusulta los componentes en estados 5 y 8 asociados a un producto 
    CURSOR cuRegComponentes (inuProducto IN pr_component.product_id%TYPE)
    IS
    SELECT *
    FROM pr_component
    WHERE product_id = inuProducto
      AND component_status_id IN (pkg_gestion_producto.cnuEst_activo_componente, pkg_gestion_producto.cnuEst_suspend_componente);
    
    -----------------------------------
    -- Tipos/Subtipos
    -----------------------------------
    SUBTYPE sbtComponente 	IS cuRecord%ROWTYPE;
    TYPE tytbsbtComponente 	IS TABLE OF sbtComponente INDEX BY BINARY_INTEGER;
    TYPE tytbcomponent_id 	IS TABLE OF pr_component.component_id%TYPE INDEX BY BINARY_INTEGER;
    TYPE tytbCompActivProducto IS TABLE OF cuObtCompActivProducto%ROWTYPE INDEX BY BINARY_INTEGER;
    TYPE tytbRegComponentes IS TABLE OF cuRegComponentes%ROWTYPE INDEX BY BINARY_INTEGER;
    TYPE tyTbIdComponentes IS TABLE OF cuIdComponentes%ROWTYPE INDEX BY BINARY_INTEGER;
    
    -----------------------------------
    -- Métodos
    -----------------------------------    
    -- Retorna Versión del paquete
    FUNCTION fsbVersion
    RETURN VARCHAR2;

    -- Retorna una tabla pl con los componentes activos de un producto
    FUNCTION ftbObtCompActivProducto( inuProducto IN    pr_component.product_id%TYPE)
    RETURN tytbCompActivProducto;
    
    --Retorna una tabla pl con el id de los componentes asociados a un producto
    FUNCTION ftbComponentesProd(inuIdProducto IN pr_component.product_id%TYPE)
    RETURN tyTbIdComponentes;
    
    --Retorna una tabla pl los registros de los componentes en estado estados 5 y 8 asociados a un producto 
    FUNCTION ftbRegComponetesXProdYEsta(inuIdProducto IN pr_component.product_id%TYPE)
    RETURN tytbRegComponentes;
									
END PKG_BCCOMPONENTES;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.PKG_BCCOMPONENTES IS

    --------------------------------------------
    -- Constantes globales para control de traza
    --------------------------------------------       
    cnuNvlTrc           CONSTANT NUMBER       := pkg_traza.cnuNivelTrzDef;
	csbInicio   		CONSTANT VARCHAR2(35) := pkg_traza.csbInicio;
    csbFin              CONSTANT VARCHAR2(35) := pkg_traza.csbFin;
    csbFin_err          CONSTANT VARCHAR2(35) := pkg_traza.csbFin_err;
    csbFin_erc          CONSTANT VARCHAR2(35) := pkg_traza.csbfin_erc;  
    csbPqt_nombre       CONSTANT VARCHAR2(35) := $$PLSQL_UNIT || '.';
    
    -----------------------------------
    -- Variables privadas del paquete
    ----------------------------------- 
	nuError		NUMBER;  		
	sbMensaje   VARCHAR2(5000);  
	
    -- Identificador del ultimo caso que hizo cambios
    csbVersion 	VARCHAR2(15) := 'OSF-4270';

	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon.Erazo </Autor>
    <Fecha> 29-02-2024 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="29-02-2024" Inc="OSF-2374" Empresa="GDC"> 
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2
    IS
    BEGIN
        return CSBVERSION;
    END fsbVersion;

    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
        <Unidad> ftbObtCompActivProducto </Unidad>
        <Autor> jpinedc </Autor>
        <Fecha> 27/01/2025 </Fecha>
        <Descripcion> 
            Retorna una tabla pl con los componentes activos de un producto
        </Descripcion>    
        <Historial>
            <Modificacion Autor="jpinedc" Fecha="27/01/2025" Inc="OSF-3893" Empresa="GDC"> 
                Creación
            </Modificacion>
        </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION ftbObtCompActivProducto( inuProducto IN    pr_component.product_id%TYPE)
    RETURN tytbCompActivProducto
    IS
        csbMetodo               CONSTANT VARCHAR2(70) := csbPqt_nombre || 'ftbObtCompActivProducto';      
        tbCompActivProducto     tytbCompActivProducto;
    BEGIN

        pkg_traza.trace(csbMetodo, cnuNvlTrc, csbInicio);  
        
        OPEN cuObtCompActivProducto(inuProducto);
        FETCH cuObtCompActivProducto BULK COLLECT INTO tbCompActivProducto;
        CLOSE cuObtCompActivProducto;

        pkg_traza.trace(csbMetodo, cnuNvlTrc, csbFin);  
        
        RETURN tbCompActivProducto;
        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, cnuNvlTrc, csbFin_erc );
            pkg_Error.getError(nuError,sbMensaje);        
            pkg_traza.trace('sbMensaje => ' || sbMensaje, cnuNvlTrc );
            RETURN tbCompActivProducto;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, cnuNvlTrc, csbFin_err);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbMensaje);
            pkg_traza.trace('sbMensaje => ' || sbMensaje, cnuNvlTrc );
            RETURN tbCompActivProducto;        
    END ftbObtCompActivProducto;
    
    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
        <Unidad> ftbComponentesProd </Unidad>
        <Autor> Paola.Acosta </Autor>
        <Fecha> 21-04-2025 </Fecha>
        <Descripcion> 
            Retorna una tabla pl con el id de los componentes asociados a un producto
        </Descripcion>    
        <Historial>
            <Modificacion Autor="Paola.Acosta" Fecha="21-04-2025" Inc="OSF-4270" Empresa="GDC"> 
                Creación
            </Modificacion>
        </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION ftbComponentesProd(inuIdProducto IN pr_component.product_id%TYPE)
    RETURN tyTbIdComponentes 
    IS
        csbMtd_nombre CONSTANT VARCHAR2(70) := csbPqt_nombre || 'ftbComponentesProd';
        otbComponentesProd tyTbIdComponentes;
    
    BEGIN
        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbInicio); 
        
        OPEN cuIdComponentes(inuIdProducto);
        FETCH cuIdComponentes BULK COLLECT INTO otbComponentesProd;
        CLOSE cuIdComponentes;
        
        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin);
        
        RETURN otbComponentesProd;
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTrc);
            pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin_erc); 
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTrc);
            pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin_err); 
            RAISE pkg_error.controlled_error;
    END ftbComponentesProd;
    
    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
        <Unidad> ftbRegComponetesXProdYEsta </Unidad>
        <Autor> Paola.Acosta </Autor>
        <Fecha> 21-04-2025 </Fecha>
        <Descripcion> 
            Retorna una tabla pl los registros de los componentes en estado estados 5 y 8
            asociados a un producto 
        </Descripcion>    
        <Historial>
            <Modificacion Autor="Paola.Acosta" Fecha="21-04-2025" Inc="OSF-4270" Empresa="GDC"> 
                Creación
            </Modificacion>
        </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION ftbRegComponetesXProdYEsta(inuIdProducto IN pr_component.product_id%TYPE)
    RETURN tytbRegComponentes  
    IS
        csbMtd_nombre CONSTANT VARCHAR2(70) := csbPqt_nombre || 'ftbRegComponetesXProdYEsta';
        otbComponentesProd tytbRegComponentes;
    
    BEGIN
        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbInicio); 
        
        OPEN cuRegComponentes(inuIdProducto);
        FETCH cuRegComponentes BULK COLLECT INTO otbComponentesProd;
        CLOSE cuRegComponentes;
        
        pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin);
        
        RETURN otbComponentesProd;
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTrc);
            pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin_erc); 
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.getError(nuError, sbMensaje);
            pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNvlTrc);
            pkg_traza.trace(csbMtd_nombre, cnuNvlTrc, csbFin_err); 
            RAISE pkg_error.controlled_error;
    END ftbRegComponetesXProdYEsta;

END PKG_BCCOMPONENTES;
/
PROMPT Otorgando permisos de ejecución para adm_person.PKG_BCCOMPONENTES
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BCCOMPONENTES', 'ADM_PERSON');
END;
/