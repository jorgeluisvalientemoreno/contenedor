CREATE OR REPLACE PACKAGE adm_person.pkg_bcgestion_ventasfnb
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> pkg_bcgestion_ventasfnb </Unidad>
    <Autor> Luis Felipe Valencia Hurtado</Autor>
    <Fecha> 12-12-2024 </Fecha>
    <Descripcion> 
       Paquete de consuntas para ventas fnb
    </Descripcion>
    <Historial>
           <ModIFicacion Autor="felipe.valencia" Fecha="12-12-2024" Inc="OSF-3738" Empresa="GDC">
               Creación
           </ModIFicacion>
     </Historial>
     </Package>
    ******************************************************************/

    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------


    /**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Luis Felipe Valencia Hurtado</Autor>
    <Fecha> 12-12-2024 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
            <ModIFicacion Autor="felipe.valencia" Fecha="12-12-2024" Inc="OSF-3738" Empresa="GDC">
               Creación
           </ModIFicacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2;
	
    FUNCTION fnuvalidaContrato
    RETURN NUMBER;
	
END pkg_bcgestion_ventasfnb;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_bcgestion_ventasfnb
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> pkg_bcgestion_ventasfnb </Unidad>
    <Autor> Luis Felipe Valencia Hurtado</Autor>
    <Fecha> 12-12-2024 </Fecha>
    <Descripcion> 
        Paquete con la logica de CPTCB
    </Descripcion>
    <Historial>
           <ModIFicacion Autor="felipe.valencia" Fecha="12-12-2024" Inc="OSF-3738" Empresa="GDC">
               Creación
           </ModIFicacion>
     </Historial>
     </Package>
    ******************************************************************/

    --------------------------------------------
    -- Constantes 
    --------------------------------------------
    csbVERSION          CONSTANT VARCHAR2(10) := 'OSF-3738';
    csbSP_NAME          CONSTANT VARCHAR2(100):= $$PLSQL_UNIT||'.';
    cnuNVLTRC           CONSTANT NUMBER       := pkg_traza.cnuNivelTrzDef;
	csbInicio   		CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;
    
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
           <ModIFicacion Autor="felipe.valencia" Fecha="12-12-2024" Inc="OSF-3738" Empresa="GDC"> 
               Creación
           </ModIFicacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2
    IS
    BEGIN
        RETURN CSBVERSION;
    END fsbVersion;
	
    /**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de GDC">
    <Unidad> fnuvalidaContrato </Unidad>
    <Autor> Luis Felipe Valencia Hurtado</Autor>
    <Fecha> 12-12-2024 </Fecha>
    <Descripcion> 
        Valida si el numero de suscripcion ingresado existe,
        si tiene producto de gas (7014) ACTIVO y si no tiene algun
        tipo de servicio financiero {7053,7055,7056}
    </Descripcion>
    <Historial>
            <ModIFicacion Autor="felipe.valencia" Fecha="12-12-2024" Inc="OSF-3738" Empresa="GDC">
               Creación
           </ModIFicacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fnuvalidaContrato
    RETURN NUMBER 
    IS
        csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuvalidaContrato';

        nuError NUMBER;

        sbError VARCHAR2(4000);

        sbContrato                  ge_boInstanceControl.stysbValue;
        nuSusccodi                  suscripc.susccodi%type;
        nuProductId                 pr_product.product_id%type;
        nuProdServFinan				pr_product.product_id%type;
        nuProdBrilla				pr_product.product_id%type;
        nuProdBrillaProm			pr_product.product_id%type;

	    CURSOR cuProdxtipo
        (
            inuContrato suscripc.susccodi%TYPE,
					   inuTipoProd servsusc.sesuserv%TYPE
        )
        IS
		SELECT  PRODUCT_ID
		FROM    PR_PRODUCT A
		WHERE   A.SUBSCRIPTION_ID = inuContrato
		AND     A.PRODUCT_TYPE_ID = inuTipoProd
		AND EXISTS (SELECT 'x'
				FROM PS_PRODUCT_STATUS B
				WHERE B.PRODUCT_STATUS_ID = A.PRODUCT_STATUS_ID
				AND (B.IS_ACTIVE_PRODUCT = constants_per.CSBYES));

    BEGIN
        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO);

        sbContrato := ge_boInstanceControl.fsbGetFieldValue ('SUSCRIPC', 'SUSCCODI');

        IF sbContrato IS NOT NULL THEN
            nuSusccodi := to_number(sbContrato);
            --Validar si en contrato existe
            IF pkg_bccontrato.fblexiste(nuSusccodi) THEN
                IF cuProdxtipo%ISOPEN THEN
                    CLOSE cuProdxtipo;
                END IF;

                OPEN cuProdxtipo(nuSusccodi,pkg_bcld_parameter.fnuobtienevalornumerico('COD_SERV_GAS'));
                FETCH cuProdxtipo INTO nuProductId;
                CLOSE cuProdxtipo;

                IF nuProductId IS NOT NULL THEN
                    --Validar el estado del producto = ACTIVO o producto = SUSPENDIDO
                    --Modiicacion de validacion por Aranda 3348 adicionando el estado de producto GAS en SuspENDido
                    --y colocando parametros para los estado del prodcuto
                    IF pkg_bcproducto.fnuEstadoProducto(nuProductId) = pkg_bcld_parameter.fnuobtienevalornumerico('ID_PRODUCT_STATUS_ACTIVO') OR
                    pkg_bcproducto.fnuEstadoProducto(nuProductId) = pkg_bcld_parameter.fnuobtienevalornumerico('ID_PRODUCT_STATUS_SUSP') THEN
                    --Validar que el producto no tenga uno de los productos de servicios financieros

                        IF cuProdxtipo%ISOPEN THEN
                            CLOSE cuProdxtipo;
                        END IF;

                        OPEN cuProdxtipo(nuSusccodi,pkg_bcld_parameter.fnuobtienevalornumerico('COD_PRODUCT_TYPE'));
                        FETCH cuProdxtipo INTO nuProdServFinan;
                        CLOSE cuProdxtipo;

                        IF cuProdxtipo%ISOPEN THEN
                            CLOSE cuProdxtipo;
                        END IF;

                        OPEN cuProdxtipo(nuSusccodi,pkg_bcld_parameter.fnuobtienevalornumerico('COD_PRODUCT_TYPE_BRILLA'));
                        FETCH cuProdxtipo INTO nuProdBrilla;
                        CLOSE cuProdxtipo;

                        IF cuProdxtipo%ISOPEN THEN
                            CLOSE cuProdxtipo;
                        END IF;

                        OPEN cuProdxtipo(nuSusccodi,pkg_bcld_parameter.fnuobtienevalornumerico('COD_PRODUCT_TYPE_BRILLA_PROM'));
                        FETCH cuProdxtipo INTO nuProdBrillaProm;
                        CLOSE cuProdxtipo;


                    IF nuProdServFinan is null  or nuProdBrilla is null or nuProdBrillaProm is null THEN
                        pkg_traza.trace(csbMetodo || 'Retorna 1',cnuNVLTRC);
                        RETURN 1;
                    ELSE
                        pkg_traza.trace(csbMetodo ||' Retorna: ' ||pkg_bcld_parameter.fnuobtienevalornumerico('COD_RETORNO_FORMA_CPTCB'),cnuNVLTRC);
                        RETURN pkg_bcld_parameter.fnuobtienevalornumerico('COD_RETORNO_FORMA_CPTCB'); -- No valida y permite crear productos nuevos al contrato
                    END IF;
                    ELSE
                        pkg_traza.trace(csbMetodo || 'Retorna 4',cnuNVLTRC);
                        RETURN 4;
                    END IF;
                ELSE
                pkg_traza.trace(csbMetodo || 'Retorna 3',cnuNVLTRC);
                RETURN 3;
                END IF;
            ELSE
            pkg_traza.trace(csbMetodo || 'Retorna 2',cnuNVLTRC);
            RETURN 2;
            END IF;
        END IF;
        pkg_traza.trace(csbMetodo || 'Retorna 0',cnuNVLTRC);       

        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN);
         RETURN 0;
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('Error => ' || sbError, cnuNVLTRC);
            RETURN 0;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('Error => ' || sbError, cnuNVLTRC);
            RETURN 0;
    END fnuvalidaContrato;
			
END pkg_bcgestion_ventasfnb;
/
BEGIN
pkg_utilidades.prAplicarPermisos(upper('PKG_BCGESTION_VENTASFNB'),'ADM_PERSON'); 
END;
/