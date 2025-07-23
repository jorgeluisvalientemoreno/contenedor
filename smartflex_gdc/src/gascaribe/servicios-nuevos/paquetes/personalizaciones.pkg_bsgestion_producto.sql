CREATE OR REPLACE PACKAGE personalizaciones.pkg_bsgestion_producto IS

    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> pkg_bsgestion_producto </Unidad>
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
    -- Funciones y Procedimientos
    --------------------------------------------

    -- Obtiene la versión del paquete
    FUNCTION fsbVersion
    RETURN VARCHAR2;

    --Registra producto y componente
    PROCEDURE prcRegistraProductoyComponente
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
        inuClaseServicio        IN pr_component.class_service_id%TYPE,
        isbNumeroServicio       IN pr_component.service_number%TYPE,
        idtFechaIniciServicio   IN pr_component.service_date%TYPE,
        idtFechaMedidor         IN pr_component.mediation_date%TYPE,
        inuCantidadcomponentes  IN pr_component.quantity%TYPE,
        inuDiasGracia           IN pr_component.uncharged_time%TYPE,
        isbDireccionalidad      IN pr_component.directionality_id%TYPE,
        inudistrAdmin           IN pr_component.distribut_admin_id%TYPE,
        inuContador             IN pr_component.meter%TYPE,
        inuIdEdificio           IN pr_component.building_id%TYPE,
        inuRutaAsignacion       IN pr_component.assign_route_id%TYPE,
        isbDistrito             IN pr_component.district_id%TYPE,
        isbEsIncluido           IN pr_component.is_included%TYPE,
        inuLocalidad            IN ge_geogra_location.geograp_location_id%TYPE,
        inuBarrio               IN ab_address.neighborthood_id%TYPE,
        isbDireccion            IN ab_address.address%TYPE,
        inuproductoOrigen       IN pr_component.product_origin_id%TYPE,
        inuComposicionIncluidos IN pr_component.included_features_id%TYPE,
        isbEsPrincipal          IN pr_component.is_main%TYPE,
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
    ) ;

END pkg_bsgestion_producto;
/
CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_bsgestion_producto IS

    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> pkg_bsgestion_producto </Unidad>
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
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prCreaProducto </Unidad>
    <Autor>Luis Felipe Valencia Hurtado</Autor>
    <Fecha> 12-12-2024 </Fecha>
    <Descripcion> 
       Proceso de negocio que registro el producto y el componente
    </Descripcion>
    <Historial>
        <Modificacion Autor="felipe.valencia" Fecha="12-12-2024" Inc="OSF-3746" Empresa="GDC">
            Creación
        </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    PROCEDURE prcRegistraProductoyComponente
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
        inuClaseServicio        IN pr_component.class_service_id%TYPE,
        isbNumeroServicio       IN pr_component.service_number%TYPE,
        idtFechaIniciServicio   IN pr_component.service_date%TYPE,
        idtFechaMedidor         IN pr_component.mediation_date%TYPE,
        inuCantidadcomponentes  IN pr_component.quantity%TYPE,
        inuDiasGracia           IN pr_component.uncharged_time%TYPE,
        isbDireccionalidad      IN pr_component.directionality_id%TYPE,
        inudistrAdmin           IN pr_component.distribut_admin_id%TYPE,
        inuContador             IN pr_component.meter%TYPE,
        inuIdEdificio           IN pr_component.building_id%TYPE,
        inuRutaAsignacion       IN pr_component.assign_route_id%TYPE,
        isbDistrito             IN pr_component.district_id%TYPE,
        isbEsIncluido           IN pr_component.is_included%TYPE,
        inuLocalidad            IN ge_geogra_location.geograp_location_id%TYPE,
        inuBarrio               IN ab_address.neighborthood_id%TYPE,
        isbDireccion            IN ab_address.address%TYPE,
        inuproductoOrigen       IN pr_component.product_origin_id%TYPE,
        inuComposicionIncluidos IN pr_component.included_features_id%TYPE,
        isbEsPrincipal          IN pr_component.is_main%TYPE,
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
        csbMetodo CONSTANT VARCHAR2(100) := csbSP_NAME || 'prcRegistraProductoyComponente';
    BEGIN  
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        pkg_bogestion_producto.prcRegistraProducto
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
            inuTelefono,
            onuCodigoError,
            osbMensajeError
        );

        IF NVL(onuCodigoError,0) != 0 THEN
            Pkg_Error.SetErrorMessage( onuCodigoError, osbMensajeError);
        ELSE
            pkg_bogestion_producto.prcRegistraComponente
            (
                onuProducto,
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
                isbDistrito,
                isbEsIncluido,
                inuDireccion,
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
                iblValidar,
                inuProductMotive,
                onuCodigoError,
                osbMensajeError
            );

            IF NVL(onuCodigoError,0) != 0 THEN
                Pkg_Error.SetErrorMessage( onuCodigoError, osbMensajeError);
            END IF;
        END IF;
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
    END prcRegistraProductoyComponente;
END pkg_bsgestion_producto;
/
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_BSGESTION_PRODUCTO', 'PERSONALIZACIONES');
END;
/
