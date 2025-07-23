CREATE OR REPLACE PACKAGE adm_person.pkg_bogestion_producto IS

    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> pkg_bogestion_producto </Unidad>
    <Autor> Luis Felipe Valencia Hurtado</Autor>
    <Fecha> 12-12-2024 </Fecha>
    <Descripcion> 
        Paquete con la logica de gestion de producto
    </Descripcion>
    <Historial>
           <Modificacion Autor="felipe.valencia" Fecha="23-04-2025" Inc="OSF-4294" Empresa="EFG">
               Se crean los procedimienots prcValidaDatosBasicosProducto prcValidaSeguridadProducto 
           </Modificacion>
           <Modificacion Autor="felipe.valencia" Fecha="12-12-2024" Inc="OSF-3746" Empresa="GDC">
               Creación
           </Modificacion>
     </Historial>
     </Package>
    ******************************************************************/

    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------

    -- Obtiene la versión del paquete
    FUNCTION fsbVersion
    RETURN VARCHAR2;

    --Obtiene el producto por contrato y tipo de producto
    FUNCTION fnuObtProductoPorContratoyTipo
    (   
        inuTipoProdcto  IN pr_product.product_type_id%TYPE,
        inuContrato     IN pr_product.subscription_id%TYPE
    ) 
    RETURN NUMBER;

    --Registra producto
    PROCEDURE prcRegistraProducto 
    (
        inuContrato         IN  pr_product.subscription_id%TYPE,
        inuTipoProducto     IN  pr_product.product_type_id%TYPE,
        inuPlanComercial    IN  pr_product.commercial_plan_id%TYPE,
        idtFechaCreacion    IN  pr_product.creation_date%TYPE,
        inuDireccion        IN  pr_product.address_id%TYPE,
        inuCategoria        IN  pr_product.category_id%TYPE,
        inuSubCategoria     IN  pr_product.subcategory_id%TYPE,
        inuEmpresa          IN  pr_product.company_id%TYPE,
        inuVendedor         IN  pr_product.person_id%TYPE,
        inuCanalVenta       IN  pr_product.organizat_area_id%TYPE,
        onuProducto         OUT pr_product.product_id%TYPE,
        inuEstadoProducto   IN  pr_product.product_status_id%TYPE DEFAULT NULL,
        inuEstadoCorte      IN  servsusc.sesuesco%TYPE DEFAULT NULL,
        inuPlanFact         IN  servsusc.sesuplfa%TYPE DEFAULT NULL,
        inuCicloFact        IN  servsusc.sesucicl%TYPE DEFAULT NULL,
        inuCicloConsumo     IN  servsusc.sesucico%TYPE DEFAULT NULL,
        inuTelefono         IN  pr_product.subs_phone_id%TYPE DEFAULT NULL,
        onuCodigoError      OUT NUMBER,
        osbMensajeError     OUT VARCHAR2
    ) ;

    -- Registra componente
    PROCEDURE prcRegistraComponente 
    (
        inuproducto             IN pr_component.product_id%TYPE,
        inuClaseServicio        IN pr_component.class_service_id%TYPE,
        isbNumeroServicio       IN pr_component.service_number%TYPE,
        idtFechaIniciServicio   IN pr_component.service_date%TYPE,
        idtFechaMedidor         IN pr_component.mediation_date%TYPE,
        inuCantidadcomponentes  IN pr_component.quantity%TYPE,
        inuDiasGracia           IN pr_component.uncharged_time%TYPE,
        isbDireccionalidad      IN pr_component.directionality_id%TYPE,
        inuCategoria            IN pr_component.category_id%TYPE,
        inuSubCategoria         IN pr_component.subcategory_id%TYPE,
        inudistrAdmin           IN pr_component.distribut_admin_id%TYPE,
        inuContador             IN pr_component.meter%TYPE,
        inuIdEdificio           IN pr_component.building_id%TYPE,
        inuRutaAsignacion       IN pr_component.assign_route_id%TYPE,
        isbDistrito             IN pr_component.district_id%TYPE,
        isbEsIncluido           IN pr_component.is_included%TYPE,
        inuIdDireccion          IN ab_address.address_id%TYPE,
        inuLocalidad            IN ge_geogra_location.geograp_location_id%TYPE,
        inuBarrio               IN ab_address.neighborthood_id%TYPE,
        isbDireccion            IN ab_address.address%TYPE,
        inuproductoOrigen       IN pr_component.product_origin_id%TYPE,
        inuComposicionIncluidos IN pr_component.included_features_id%TYPE,
        isbEsPrincipal          IN pr_component.is_main%TYPE,
        inuPlanComercial        IN pr_component.commercial_plan_id%TYPE,
        onuComponente           OUT pr_component.component_id%TYPE,
        iblRegDireccion         IN BOOLEAN DEFAULT TRUE,
        iblElementoMedicion     IN BOOLEAN DEFAULT TRUE,
        iblTelefonoEspecial     IN BOOLEAN DEFAULT TRUE,
        inuComponenteAprovi     IN pr_component.comp_prod_prov_id%TYPE DEFAULT null,
        inuEstadoComponente     IN pr_component.component_status_id%TYPE DEFAULT null,
        iblValidar              IN BOOLEAN DEFAULT TRUE,
        inuProductMotive        NUMBER,
        onuCodigoError          OUT NUMBER,
        osbMensajeError         OUT VARCHAR2
    );
	
	-- Retorna el primer producto del contrato                    
    FUNCTION fnuObtPrimerProdDeContrato(inuContratoId IN suscripc.susccodi%TYPE)
    RETURN pr_product.product_id%TYPE;

    --Valida datos basicos de producto
    PROCEDURE prcValidaDatosBasicosProducto 
    (
        inuproducto         IN servsusc.sesunuse%TYPE,
        onuCodigoError      OUT NUMBER,
        osbMensajeError     OUT VARCHAR2
    ) ;

    --Se valida si el producto tiene restricción de pago por corte
    PROCEDURE prcValidaSeguridadProducto 
    (
        inuproducto         IN servsusc.sesunuse%TYPE,
        isbProceso          IN procrest.prreproc%type,
        onuCodigoError      OUT NUMBER,
        osbMensajeError     OUT VARCHAR2
    ) ;
END pkg_bogestion_producto;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_bogestion_producto IS

    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> pkg_bogestion_producto </Unidad>
    <Autor> Luis Felipe Valencia Hurtado</Autor>
    <Fecha> 12-12-2024 </Fecha>
    <Descripcion> 
        Paquete con la logica de gestion de producto
    </Descripcion>
    <Historial>
           <Modificacion Autor="felipe.valencia" Fecha="12-12-2024" Inc="OSF-3746" Empresa="GDC">
               Creación
           </Modificacion>
     </Historial>
     </Package>
    ******************************************************************/

    --------------------------------------------
    -- Constantes 
    --------------------------------------------

    csbSP_NAME      CONSTANT VARCHAR2(35) := $$PLSQL_UNIT || '.';
    csbNivelTraza   CONSTANT NUMBER := pkg_traza.cnuNivelTrzDef;

    csbVERSION  CONSTANT VARCHAR2(10) := 'OSF-3746';

    -----------------------------------
    -- Variables privadas del package
    -----------------------------------

    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------

    /**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> felipe.valencia </Autor>
    <Fecha> 12-12-2024 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <Modificacion Autor="felipe.valencia" Fecha="12-12-2024" Inc="OSF-3746" Empresa="GDC"> 
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2
    IS
    BEGIN
        return CSBVERSION;
    END fsbVersion;

    /**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de GDC">
    <Unidad> fnuObtProductoPorContratoyTipo </Unidad>
    <Autor> Luis Felipe Valencia Hurtado</Autor>
    <Fecha> 12-12-2024 </Fecha>
    <Descripcion> 
        Obtiene el producto por tipo de producto y contrato
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="NUMBER">
        Número de producto
    </Retorno>
    <Historial>
        <Modificacion Autor="felipe.valencia" Fecha="12-12-2024" Inc="OSF-3746" Empresa="GDC">
            Creación
        </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fnuObtProductoPorContratoyTipo
    (   
        inuTipoProdcto  IN pr_product.product_type_id%TYPE,
        inuContrato     IN pr_product.subscription_id%TYPE
    ) 
    RETURN NUMBER 
    IS
        csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtProductoPorContratoyTipo';

        nuError NUMBER;

        sbError VARCHAR2(4000);

        nuProducto pr_product.product_id%TYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
      
        pkg_traza.trace('Tipo Producto: ' || inuTipoProdcto, csbNivelTraza);
        pkg_traza.trace('Contrato: ' || inuContrato, csbNivelTraza);

        nuProducto := pr_boproduct.fnuGetProdBySuscAndType(inuTipoProdcto,inuContrato);
      
        pkg_traza.trace('Producto: ' || nuProducto, csbNivelTraza);
      
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
      
        RETURN(nuProducto);    
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('Error => ' || sbError, csbNivelTraza);
            RETURN nuProducto;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('Error => ' || sbError, csbNivelTraza);
            RETURN nuProducto;
    END fnuObtProductoPorContratoyTipo;

	  /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcRegistraProducto </Unidad>
    <Autor>Luis Felipe Valencia Hurtado</Autor>
    <Fecha> 12-12-2024 </Fecha>
    <Descripcion> 
       Proceso que registra un producto nuevo
    </Descripcion>
    <Historial>
        <Modificacion Autor="felipe.valencia" Fecha="12-12-2024" Inc="OSF-3746" Empresa="GDC">
            Creación
        </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    PROCEDURE prcRegistraProducto 
    (
        inuContrato         IN  pr_product.subscription_id%TYPE,
        inuTipoProducto     IN  pr_product.product_type_id%TYPE,
        inuPlanComercial    IN  pr_product.commercial_plan_id%TYPE,
        idtFechaCreacion    IN  pr_product.creation_date%TYPE,
        inuDireccion        IN  pr_product.address_id%TYPE,
        inuCategoria        IN  pr_product.category_id%TYPE,
        inuSubCategoria     IN  pr_product.subcategory_id%TYPE,
        inuEmpresa          IN  pr_product.company_id%TYPE,
        inuVendedor         IN  pr_product.person_id%TYPE,
        inuCanalVenta       IN  pr_product.organizat_area_id%TYPE,
        onuProducto         OUT pr_product.product_id%TYPE,
        inuEstadoProducto   IN  pr_product.product_status_id%TYPE DEFAULT NULL,
        inuEstadoCorte      IN  servsusc.sesuesco%TYPE DEFAULT NULL,
        inuPlanFact         IN  servsusc.sesuplfa%TYPE DEFAULT NULL,
        inuCicloFact        IN  servsusc.sesucicl%TYPE DEFAULT NULL,
        inuCicloConsumo     IN  servsusc.sesucico%TYPE DEFAULT NULL,
        inuTelefono         IN  pr_product.subs_phone_id%TYPE DEFAULT NULL,
        onuCodigoError      OUT NUMBER,
        osbMensajeError     OUT VARCHAR2
    ) 
    IS
        csbMetodo CONSTANT VARCHAR2(100) := csbSP_NAME || 'prcRegistraProducto';
    BEGIN  
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        pr_bocreationProduct.Register
        (
            inuContrato,
            inuTipoProducto,
            inuPlanComercial,
            idtFechaCreacion,
            inuDireccion,
            inuCategoria,
            inuSubCategoria,
            inuEmpresa,
            inuVendedor,
            inuCanalVenta,
            onuProducto,
            inuEstadoProducto,
            inuEstadoCorte,
            inuPlanFact,
            inuCicloFact,
            inuCicloConsumo,
            inuTelefono
        );
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);    
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(onuCodigoError, osbMensajeError);
            pkg_traza.trace('Error => ' || osbMensajeError, csbNivelTraza);
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            pkg_Error.getError(onuCodigoError, osbMensajeError);
            pkg_traza.trace('Error => ' || osbMensajeError, csbNivelTraza);
    END prcRegistraProducto;

	  /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcRegistraComponente </Unidad>
    <Autor>Luis Felipe Valencia Hurtado</Autor>
    <Fecha> 12-12-2024 </Fecha>
    <Descripcion> 
       Proceso que registra un componete a un producto
    </Descripcion>
    <Historial>
        <Modificacion Autor="felipe.valencia" Fecha="12-12-2024" Inc="OSF-3746" Empresa="GDC">
            Creación
        </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    PROCEDURE prcRegistraComponente 
    (
        inuproducto             IN pr_component.product_id%TYPE,
        inuClaseServicio        IN pr_component.class_service_id%TYPE,
        isbNumeroServicio       IN pr_component.service_number%TYPE,
        idtFechaIniciServicio   IN pr_component.service_date%TYPE,
        idtFechaMedidor         IN pr_component.mediation_date%TYPE,
        inuCantidadcomponentes  IN pr_component.quantity%TYPE,
        inuDiasGracia           IN pr_component.uncharged_time%TYPE,
        isbDireccionalidad      IN pr_component.directionality_id%TYPE,
        inuCategoria            IN pr_component.category_id%TYPE,
        inuSubCategoria         IN pr_component.subcategory_id%TYPE,
        inudistrAdmin           IN pr_component.distribut_admin_id%TYPE,
        inuContador             IN pr_component.meter%TYPE,
        inuIdEdificio           IN pr_component.building_id%TYPE,
        inuRutaAsignacion       IN pr_component.assign_route_id%TYPE,
        isbDistrito             IN pr_component.district_id%TYPE,
        isbEsIncluido           IN pr_component.is_included%TYPE,
        inuIdDireccion          IN ab_address.address_id%TYPE,
        inuLocalidad            IN ge_geogra_location.geograp_location_id%TYPE,
        inuBarrio               IN ab_address.neighborthood_id%TYPE,
        isbDireccion            IN ab_address.address%TYPE,
        inuproductoOrigen       IN pr_component.product_origin_id%TYPE,
        inuComposicionIncluidos IN pr_component.included_features_id%TYPE,
        isbEsPrincipal          IN pr_component.is_main%TYPE,
        inuPlanComercial        IN pr_component.commercial_plan_id%TYPE,
        onuComponente           OUT pr_component.component_id%TYPE,
        iblRegDireccion         IN BOOLEAN DEFAULT TRUE,
        iblElementoMedicion     IN BOOLEAN DEFAULT TRUE,
        iblTelefonoEspecial     IN BOOLEAN DEFAULT TRUE,
        inuComponenteAprovi     IN pr_component.comp_prod_prov_id%TYPE DEFAULT null,
        inuEstadoComponente     IN pr_component.component_status_id%TYPE DEFAULT null,
        iblValidar              IN BOOLEAN DEFAULT TRUE,
        inuProductMotive        NUMBER,
        onuCodigoError          OUT NUMBER,
        osbMensajeError         OUT VARCHAR2
    ) 
    IS
        csbMetodo CONSTANT VARCHAR2(100) := csbSP_NAME || 'prcRegistraComponente';

        tbComposicionVenta   pkg_ps_prod_motive_comp.tytbps_prod_motive_comp;
        nuComponentePadre   NUMBER;
        nuIndice            BINARY_INTEGER;

        TYPE tytbNumber IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
        TYPE tyrcComponents IS RECORD
        (
            PrComponent     tytbNumber,
            prodMotComp     tytbNumber,
            parentPrComp    tytbNumber,
            MoComponent     tytbNumber,
            parentIndex     tytbNumber
        );

        rcRelacionComponentes     tyrcComponents;
    BEGIN  
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        pkg_ps_prod_motive_comp.prcObtieneRegistros('product_Motive_Id = '||inuProductMotive||' ORDER BY ASSIGN_ORDER ASC', tbComposicionVenta);

        pkg_traza.Trace('Producto-Motivo['||inuProductMotive||']',csbNivelTraza);

        /* Inicializa el componente padre en null */
        nuComponentePadre := NULL;

        pkg_traza.Trace('Composicion de nivel['||tbComposicionVenta.COUNT||']',csbNivelTraza);
		    nuIndice := tbComposicionVenta.FIRST;

        /* Recorre la composicion */
        WHILE (nuIndice IS NOT NULL) LOOP
            /* Calcula el componenete padre */
            IF (tbComposicionVenta(nuIndice).parent_comp IS NOT NULL) THEN
                nuComponentePadre := rcRelacionComponentes.PrComponent(tbComposicionVenta(nuIndice).parent_comp);
            ELSE
                nuComponentePadre := NULL;
            END IF;

            pkg_traza.Trace('Calcula el parent_comp['||nuComponentePadre||']',csbNivelTraza);

            /* Crea un componente por cada registro */
            pr_bocreationComponent.Register
            (
                inuproducto,
                tbComposicionVenta(nuIndice).component_type_id,
                inuClaseServicio,
                isbNumeroServicio,
                idtFechaIniciServicio,
                idtFechaMedidor,
                inuCantidadcomponentes,
                inuDiasGracia,
                isbDireccionalidad,
                inuCategoria,
                inuSubCategoria,
                inudistrAdmin,
                inuContador,
                inuIdEdificio,
                inuRutaAsignacion,
                nuComponentePadre,
                isbDistrito,
                isbEsIncluido,
                inuIdDireccion,
                inuLocalidad,
                inuBarrio,
                isbDireccion,
                inuproductoOrigen,
                inuComposicionIncluidos,
                isbEsPrincipal,
                inuPlanComercial,
                onuComponente,
                iblRegDireccion,
                iblElementoMedicion,
                iblTelefonoEspecial,
                inuComponenteAprovi,
                inuEstadoComponente,
                iblValidar
            );
            pkg_traza.Trace('Componente['||onuComponente||']',csbNivelTraza);
            /* Guarda en la tabla temporal */
            rcRelacionComponentes.prodMotComp(tbComposicionVenta(nuIndice).prod_motive_comp_id) := tbComposicionVenta(nuIndice).prod_motive_comp_id;
            rcRelacionComponentes.PrComponent(tbComposicionVenta(nuIndice).prod_motive_comp_id) := onuComponente;
            rcRelacionComponentes.parentPrComp(tbComposicionVenta(nuIndice).prod_motive_comp_id):= nuComponentePadre;
            rcRelacionComponentes.MoComponent(tbComposicionVenta(nuIndice).prod_motive_comp_id) := NULL;
            rcRelacionComponentes.parentIndex(tbComposicionVenta(nuIndice).prod_motive_comp_id) := tbComposicionVenta(nuIndice).parent_comp;

            nuIndice := tbComposicionVenta.next(nuIndice);
        END LOOP;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);    
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(onuCodigoError, osbMensajeError);
            pkg_traza.trace('Error => ' || osbMensajeError, csbNivelTraza);
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            pkg_Error.getError(onuCodigoError, osbMensajeError);
            pkg_traza.trace('Error => ' || osbMensajeError, csbNivelTraza);
    END prcRegistraComponente;
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtPrimerProdDeContrato 
    Descripcion     : Retorna el primer producto del contrato
	
    Autor           : Jhon Erazo - MVM 
    Fecha           : 30/12/2024
	
	Parametros
		Entrada:
			inuContratoId		Identificador del Producto
		
		Salida:
			nuProducto		Identificador del producto
	
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jerazomvm	30/12/2024	OSF-3816    Creacion
    ***************************************************************************/                     
    FUNCTION fnuObtPrimerProdDeContrato(inuContratoId IN suscripc.susccodi%TYPE)
    RETURN pr_product.product_id%TYPE
    IS

        -- Nombre de ste mÉtodo
        csbMT_NAME  	VARCHAR2(70) := csbSP_NAME || '.fnuObtPrimerProdDeContrato';
        nuerrorcode 	NUMBER;         -- se almacena codigo de error
		nuProducto   	pr_product.product_id%TYPE;
        sbmenserror 	VARCHAR2(2000);  -- se almacena descripcion del error            
        
    BEGIN
    
        pkg_traza.trace(csbMT_NAME, csbNivelTraza, pkg_traza.csbINICIO);
		
		pkg_traza.trace('inuContratoId: ' || inuContratoId, csbNivelTraza);
		
		nuProducto := PR_BOPRODUCT.FNUFIRSTPRODBYCONTRACT(inuContratoId);
		pkg_traza.trace('nuProducto: ' || nuProducto, csbNivelTraza);
            
        pkg_traza.trace(csbMT_NAME, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN nuProducto;
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_error.SetError;
			pkg_error.getError(nuErrorCode,sbMensError);
			pkg_traza.trace(csbMT_NAME||' '||sbMensError, csbNivelTraza);
			pkg_traza.trace(csbMT_NAME,csbNivelTraza,pkg_traza.fsbFIN_ERR);	
            RETURN nuProducto;                 
    END fnuObtPrimerProdDeContrato;


	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcValidaDatosBasicosProducto </Unidad>
    <Autor>Luis Felipe Valencia Hurtado</Autor>
    <Fecha> 21-03-2025 </Fecha>
    <Descripcion> 
       Valida datos basicos de producto
    </Descripcion>
    <Historial>
        <Modificacion Autor="felipe.valencia" Fecha="21-03-2025 " Inc="OSF-3846" Empresa="GDC">
            Creación
        </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    PROCEDURE prcValidaDatosBasicosProducto 
    (
        inuproducto         IN servsusc.sesunuse%TYPE,
        onuCodigoError      OUT NUMBER,
        osbMensajeError     OUT VARCHAR2
    ) 
    IS
        csbMetodo CONSTANT VARCHAR2(100) := csbSP_NAME || 'prcValidaDatosBasicosProducto';

    BEGIN  
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        pkServNumberMgr.ValBasicData(inuproducto);

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);    
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(onuCodigoError, osbMensajeError);
            pkg_traza.trace('Error => ' || osbMensajeError, csbNivelTraza);
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            pkg_Error.getError(onuCodigoError, osbMensajeError);
            pkg_traza.trace('Error => ' || osbMensajeError, csbNivelTraza);
    END prcValidaDatosBasicosProducto;

	  /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcValidaSeguridadProducto </Unidad>
    <Autor>Luis Felipe Valencia Hurtado</Autor>
    <Fecha> 21-03-2025 </Fecha>
    <Descripcion> 
       Se valida si el producto tiene restricción de pago por corte
    </Descripcion>
    <Historial>
        <Modificacion Autor="felipe.valencia" Fecha="21-03-2025 " Inc="OSF-3846" Empresa="GDC">
            Creación
        </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    PROCEDURE prcValidaSeguridadProducto 
    (
        inuproducto         IN servsusc.sesunuse%TYPE,
        isbProceso          IN procrest.prreproc%type,
        onuCodigoError      OUT NUMBER,
        osbMensajeError     OUT VARCHAR2
    ) 
    IS
        csbMetodo CONSTANT VARCHAR2(100) := csbSP_NAME || 'prcValidaSeguridadProducto';

    BEGIN  
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        pkBOProcessSecurity.ValidateProductSecurity(inuproducto, isbProceso);

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);    
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(onuCodigoError, osbMensajeError);
            pkg_traza.trace('Error => ' || osbMensajeError, csbNivelTraza);
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            pkg_Error.getError(onuCodigoError, osbMensajeError);
            pkg_traza.trace('Error => ' || osbMensajeError, csbNivelTraza);
    END prcValidaSeguridadProducto;
END pkg_bogestion_producto;
/
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_BOGESTION_PRODUCTO', 'ADM_PERSON');
END;
/
