CREATE OR REPLACE PACKAGE LDC_BODefectNoRepara

/**************************************************************************
    Autor       :Horbath
    Fecha       : 13/09/2021
    Ticket      : 667
    Descripción: Paquete para la gestion de marca de ordenes

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
    31/01/2024  jpinedc     OSF-2247: Ajustes pro migración V8
***************************************************************************/
IS

    /**************************************************************************
        Autor       :Horbath
        Fecha       : 13/09/2021
        Ticket      : 667
        Descripción: Retorna la version actual del objeto
    ***************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2;
    /**************************************************************************
        Autor       :Horbath
        Fecha       : 13/09/2021
        Ticket      : 667
        Descripción: Plugin para registrar la marca de la orden

        Par?metros Entrada

        Valor de salida

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    
    FUNCTION fsbValidateDefectsNoRepair
    (
        inuProduct          IN      pr_product.product_id%type,
		inuOrder		    IN 		or_order.order_id%type,
        isbCertifi          IN      ldc_certificados_oia.certificado%type
    )
    RETURN VARCHAR2;
    
    /**************************************************************************
        Autor       :Horbath
        Fecha       : 13/09/2021
        Ticket      : 667
        Descripción: Plugin para registrar la marca de la orden
    ***************************************************************************/
    PROCEDURE ValidaMarcaProducto;

    /**************************************************************************
        Autor       :Horbath
        Fecha       : 13/09/2021
        Ticket      : 667
        Descripción: Valida si un producto tiene una marca activa
    ***************************************************************************/
    FUNCTION fboMarkActiveProduct
    (
        inuProduct          IN      pr_product.product_id%type
    )
    RETURN BOOLEAN;
    
    /**************************************************************************
        Autor       :Horbath
        Fecha       : 13/09/2021
        Ticket      : 667
        Descripción: Plugin para registrar la marca de la orden
    ***************************************************************************/
    PROCEDURE CreaTramiteSuspen;
    /**************************************************************************
        Autor       :Horbath
        Fecha       : 13/09/2021
        Ticket      : 667
        Descripción: Servicio para registrar solicitud de suspension
    ***************************************************************************/
    PROCEDURE prRegisterRequest
    (
        inuProduct          IN      pr_product.product_id%type,
        inuReceptionType    IN      ge_reception_type.reception_type_id%type,
        isbComment          IN      mo_packages.comment_%type,
        inuSuspType         IN      NUMBER,
        inuCausalType       IN      NUMBER,
        inuCausal           IN      NUMBER
    );
    
    /**************************************************************************
        Nombre      : fsbCreaActNoReparable
        Descripción: Servicio para registrar solicitud de suspension
    ***************************************************************************/
    FUNCTION fsbCreaActNoReparable
    (
        inuPackageId    IN  mo_packages.package_id%TYPE
    )
    RETURN VARCHAR2;
    
    /**************************************************************************
        Nombre       : BorraMarcaProducto
        Descripción: Plugin para borrar la marca del producto
    ***************************************************************************/
    PROCEDURE BorraMarcaProducto;
    /**************************************************************************
        Nombre       : fsbGetMarkLock
        Descripción: Funcion para determinar si un producto tiene marca de bloqueo
    ***************************************************************************/
    FUNCTION fsbGetMarkLock
    (
        inuProduct          IN          pr_product.product_id%type
    )
    RETURN VARCHAR2;
    FUNCTION fsbValDefectsNoRepairbyCod
    (
        inuCertOiaid          IN      ldc_certificados_oia.certificados_oia_id%type
		    
    )
    RETURN VARCHAR2 ;


END LDC_BODefectNoRepara;
/

CREATE OR REPLACE PACKAGE BODY LDC_BODefectNoRepara
/**************************************************************************
    Autor       :Horbath
    Fecha       : 13/09/2021
    Ticket      : 667
    Descripción: Paquete para la gestion de marca de ordenes

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
***************************************************************************/
IS

    csbVERSION  CONSTANT    VARCHAR2(20) := 'OSF-2247';
    
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT ||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
        
    /**************************************************************************
        Autor       :Horbath
        Fecha       : 13/09/2021
        Ticket      : 667
        Descripción: Retorna la version actual del objeto

        Parámetros Entrada

        Valor de salida

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2
    IS
    BEGIN
       RETURN csbVERSION;
    END fsbVersion;
    /**************************************************************************
        Autor       :Horbath
        Fecha       : 13/09/2021
        Ticket      : 667
        Descripción: Plugin para registrar la marca de la orden

        Parámetros Entrada

        Valor de salida

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    
    FUNCTION fsbValidateDefectsNoRepair
    (
        inuProduct          IN      pr_product.product_id%type,
		inuOrder		    IN 		or_order.order_id%type,
        isbCertifi          IN      ldc_certificados_oia.certificado%type
    )
    RETURN VARCHAR2
    
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbValidateDefectsNoRepair';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
        
        sbDefectsNoRepair       ldc_pararepe.paravast%type := daldc_pararepe.fsbGetPARAVAST('LDC_DEFECTOS_NO_REPARABLES', NULL);
        nuTotal                 NUMBER;
        nuDefectsNoRepair       NUMBER;
        nuLastCertificate       ldc_certificados_oia.certificados_oia_id%type;

        CURSOR cuGetLastCertificate
        IS
            SELECT  certificados_oia_id
            FROM    ldc_certificados_oia
            WHERE   id_producto = inuProduct
			        and   order_id = inuOrder
			        and   status_certificado = 'A'
              and   certificado = isbCertifi
            ORDER BY FECHA_REGISTRO desc;

        CURSOR cuTotalDefects
        IS
            select  count(distinct defect_id)
            from    ldc_defectos_oia b
            where   b.certificados_oia_id = nuLastCertificate;

        CURSOR cuDefects
        IS
        
            select  count(1)
            FROM    ldc_defectos_oia b
            where   b.certificados_oia_id = nuLastCertificate
            and     b.defect_id IN  
            (
                SELECT to_number(regexp_substr(sbDefectsNoRepair,'[^,]+', 1,LEVEL))
                FROM dual
                CONNECT BY regexp_substr(sbDefectsNoRepair, '[^,]+', 1, LEVEL) IS NOT NULL
            );
    

        
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
    
        OPEN cuGetLastCertificate;
        FETCH cuGetLastCertificate INTO nuLastCertificate;
        CLOSE cuGetLastCertificate;

        OPEN cuTotalDefects;
        FETCH cuTotalDefects INTO nuTotal;
        CLOSE cuTotalDefects;
        
        OPEN cuDefects;
        FETCH cuDefects INTO nuDefectsNoRepair;
        CLOSE cuDefects;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
        
        IF nuTotal = 0 THEN
            RETURN 'N';
        END IF;
        
        IF nuTotal <> nuDefectsNoRepair THEN
            RETURN 'N';
        END IF;
        
        RETURN 'S';
        
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;    
    END fsbValidateDefectsNoRepair;
    
    /**************************************************************************
        Autor       :Horbath
        Fecha       : 13/09/2021
        Ticket      : 667
        Descripción: Plugin para registrar la marca de la orden

        Parámetros Entrada

        Valor de salida

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    PROCEDURE ValidaMarcaProducto
    
    IS
    
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'ValidaMarcaProducto';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);    
    
        nuOrder             OR_order.order_id%type;
        nuProduct           pr_product.product_id%type;
        nuCausal            ge_causal.causal_id%type;
        nuClassCausal       ge_class_causal.class_causal_id%type;
        nuOrderActivity     OR_order_activity.order_activity_id%type;
        rcMarkProduct       LDC_MARCAPRODREPA%rowtype;
        sbcertificado       ldc_certificados_oia.certificado%TYPE;
        nucodatributo       ge_attributes.attribute_id%TYPE := dald_parameter.fnuGetNumeric_Value('COD_DATO_ADICIONAL_VAL_CERTI',NULL);
        sbnombreatrib       ge_attributes.name_attribute%TYPE := dald_parameter.fsbGetValue_Chain('NOMBRE_ATRI_VAL_CERTI', NULL);
               
        CURSOR cuData
        IS
            SELECT  product_id, ORDER_activity_id
            FROM    OR_order_activity
            WHERE   ORDER_id = nuOrder;
            
        FUNCTION fnuExistMark
        RETURN NUMBER
        IS
            nuCount         NUMBER;
            
            CURSOR cuLDC_MARCAPRODREPA
            IS
            SELECT  COUNT(1)
            FROM    LDC_MARCAPRODREPA
            WHERE   PRODUCTO_ID = nuProduct
            AND     bloqueo = 'Y';
                        
        BEGIN
        
            OPEN cuLDC_MARCAPRODREPA;
            FETCH cuLDC_MARCAPRODREPA INTO nuCount;
            CLOSE cuLDC_MARCAPRODREPA;
                        
            RETURN nuCount;
        
        EXCEPTION
            WHEN pkg_Error.CONTROLLED_ERROR THEN
                RAISE pkg_Error.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                pkg_Error.setError;
                RAISE pkg_Error.CONTROLLED_ERROR;
        END fnuExistMark;
    
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
          
        nuOrder := PKG_BCORDENES.FNUOBTENEROTINSTANCIALEGAL;
        
        pkg_Traza.trace('Orden: ['||nuOrder||']',10);
        
        nuCausal := PKG_BCORDENES.FNUOBTIENECAUSAL(nuOrder);
        
        nuClassCausal := PKG_BCORDENES.FNUOBTIENECLASECAUSAL(nuCausal);
        
        OPEN cuData;
        FETCH cuData INTO nuProduct, nuOrderActivity;
        CLOSE cuData;
        
        sbcertificado := ldc_boordenes.fsbDatoAdicTmpOrden(nuOrder,nucodatributo,TRIM(sbnombreatrib));
        --Valida si existe marca para el producto
        IF fnuExistMark = 0 THEN
            --Valida si la causal es de exito
                IF fsbValidateDefectsNoRepair(nuProduct, nuOrder, sbcertificado) = 'S' THEN
                    rcMarkProduct.MARCA_ID := SEQ_LDC_MARCAPRODREPA.NEXTVAL;
                    rcMarkProduct.PRODUCTO_ID := nuProduct;
                    rcMarkProduct.ORDEN_ID := nuOrder;
                    rcMarkProduct.BLOQUEO := 'Y';
                    rcMarkProduct.FECHA_BLOQUEO := LDC_BOCONSGENERALES.FDTGETSYSDATE;
                    
                    INSERT INTO LDC_MARCAPRODREPA VALUES rcMarkProduct;
                    
                END IF;        
        END IF;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END ValidaMarcaProducto;
    /**************************************************************************
        Autor       :Horbath
        Fecha       : 13/09/2021
        Ticket      : 667
        Descripción: Valida si un producto tiene una marca activa

        Parámetros Entrada

        Valor de salida

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    FUNCTION fboMarkActiveProduct
    (
        inuProduct          IN      pr_product.product_id%type
    )
    RETURN BOOLEAN
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fboMarkActiveProduct';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);       
    
        nuCount             NUMBER;
        
        CURSOR cuLDC_MARCAPRODREPA
        IS
        SELECT  COUNT(1)
        FROM    LDC_MARCAPRODREPA
        WHERE   PRODUCTO_ID = inuProduct
        AND     BLOQUEO = 'Y';
        
        bLMarkActiveProduct BOOLEAN;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
    
        pkg_Traza.trace('Inicio LDC_BODefectNoRepara.fboMarkActiveProduct - Producto: ['||inuProduct||']',10);
        
        OPEN cuLDC_MARCAPRODREPA;
        FETCH cuLDC_MARCAPRODREPA INTO nuCount;
        CLOSE cuLDC_MARCAPRODREPA;
        
        bLMarkActiveProduct := nuCount > 0;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        
        RETURN bLMarkActiveProduct;
    
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END fboMarkActiveProduct;
    
    /**************************************************************************
        Autor       :Horbath
        Fecha       : 13/09/2021
        Ticket      : 667
        Descripción: Plugin para genera solicitud tipo 100156 - Suspensi?n Administrativa por XML

        Parámetros Entrada

        Valor de salida

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    PROCEDURE CreaTramiteSuspen
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'CreaTramiteSuspen';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);    
        
        nuOrder             OR_order.order_id%type;
        nuReceptionType     ge_reception_type.reception_type_id%type;
        nuProduct           pr_product.product_id%type;
        nuSuspType          NUMBER;
        nuCausalType        NUMBER;
        nuCausal            NUMBER;
        nuClient            ge_subscriber.subscriber_id%type;
        nuOrderActivity     OR_order_activity.order_activity_id%type;
        sbComment           mo_packages.comment_%type;
        sbcertificado       ldc_certificados_oia.certificado%TYPE;
        nucodatributo       ge_attributes.attribute_id%TYPE := dald_parameter.fnuGetNumeric_Value('COD_DATO_ADICIONAL_VAL_CERTI',NULL);
        sbnombreatrib       ge_attributes.name_attribute%TYPE := dald_parameter.fsbGetValue_Chain('NOMBRE_ATRI_VAL_CERTI', NULL);
        nuEstadoPro         pr_product.product_status_id%type;
        sbTipoSuspe         ld_parameter.value_chain%type := DALD_PARAMETER.FSBGETVALUE_CHAIN('ID_RP_SUSPENSION_TYPE',NULL);
        sbmensa             VARCHAR2(10000);

        CURSOR cuData
        IS
            SELECT  product_id,
                    subscriber_id,
                    order_activity_id
            FROM    or_order_activity
            WHERE   order_id = nuOrder;

         --Se consulta estado del producto
         CURSOR cuEstadoProducto IS
         SELECT product_status_id
         FROM PR_PRODUCT
         WHERE PRODUCT_ID = nuProduct;
    
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
         
        nuOrder := PKG_BCORDENES.FNUOBTENEROTINSTANCIALEGAL;

        pkg_Traza.trace('Orden: ['||nuOrder||']',10);
        
        OPEN cuData;
        FETCH cuData INTO nuProduct,nuClient,nuOrderActivity;
        CLOSE cuData;
        
        sbcertificado := ldc_boordenes.fsbDatoAdicTmpOrden(nuOrder,nucodatributo,TRIM(sbnombreatrib));
        
        IF fsbValidateDefectsNoRepair(nuProduct, nuOrder, sbcertificado) = 'S' THEN
          
            nuCausalType := daldc_pararepe.fnuGetPAREVANU('LDC_TIPO_CAUSAL_DEF_NO_REPARA', NULL);
            nuCausal := daldc_pararepe.fnuGetPAREVANU('LDC_CAUSAL_DEF_NO_REPARA', NULL);
            nuReceptionType := dald_parameter.fnuGetNumeric_Value('MEDIO_RECEPCION_SUSPADM_PRP', NULL);
            
            nuSuspType       := LDC_FNUGETNUEVAMARCA(nuOrder);
            if nuSuspType = -1 then
                nuSuspType       := ldci_pkrevisionperiodicaweb.fnutiposuspension(nuProduct);
            end if;
            
            
               -- se consulta estado del producto
             OPEN cuEstadoProducto;
             FETCH cuEstadoProducto INTO nuEstadoPro;
             CLOSE cuEstadoProducto;
            
            IF nuEstadoPro <> 1 THEN
               sbmensa := 'Proceso termino con errores : '||'El producto: '||to_char(nuProduct)||' no se encuentra suspendido o esta suspendido con un tipo diferente a['||sbTipoSuspe||']';
               return;
            END IF;
            sbComment := 'CREACION SOLICITUD [PLUGIN] PRODUCTO['||nuProduct||'] TIPO SUSPENSION: ['||nuSuspType||']';
            
            LDC_BODefectNoRepara.prRegisterRequest
            (
                nuProduct,
                nuReceptionType,
                sbComment,
                nuSuspType,
                nuCausalType,
                nuCausal
            );
            
        
        END IF;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
    
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END CreaTramiteSuspen;
    
    /**************************************************************************
        Autor       :Horbath
        Fecha       : 13/09/2021
        Ticket      : 667
        Descripción: Servicio para registrar solicitud de suspension

        Parámetros Entrada

        Valor de salida

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    PROCEDURE prRegisterRequest
    (
        inuProduct          IN      pr_product.product_id%type,
        inuReceptionType    IN      ge_reception_type.reception_type_id%type,
        isbComment          IN      mo_packages.comment_%type,
        inuSuspType         IN      NUMBER,
        inuCausalType       IN      NUMBER,
        inuCausal           IN      NUMBER
    )
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prRegisterRequest';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);     
    
        dtSuspDate          DATE;
        clXML               constants_per.TIPO_XML_SOL%TYPE;
        nuPackageId         mo_packages.package_id%type;
        nuMotiveId          mo_motive.motive_id%type;
        nuErrorCode         NUMBER;
        sbErrorMessage      VARCHAR2(4000);
        nucliente           NUMBER; --se almacena cliente
        nuDireccionId       pr_product.address_id%TYPE;
        
      CURSOR cuGetCliente IS
      SELECT c.suscclie, p.ADDRESS_ID
        FROM pr_product p, suscripc c
       WHERE P.SUBSCRIPTION_ID = c.susccodi
         AND P.PRODUCT_ID = inuProduct;
         
         
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  

        dtSuspDate := LDC_BOCONSGENERALES.FDTGETSYSDATE + 1 / 24 / 60;
        
        OPEN cuGetCliente;
        FETCH cuGetCliente INTO nuCliente, nuDireccionId;
        CLOSE cuGetCliente;

        clXML := PKG_XML_SOLI_REV_PERIODICA.getSuspensionAdministrativa
        (
            inuReceptionType,
            nuCliente,
            nuDireccionId,
            isbComment,
            inuProduct,
            dtSuspDate,
            inuSuspType,
            inuCausalType,
            inuCausal
        );

        API_REGISTERREQUESTBYXML
        (
           clXML,
           nuPackageId,
           nuMotiveId,
           nuErrorCode,
           sbErrorMessage
        );
        
        IF nuErrorCode <> 0 THEN
            pkg_error.setErrorMessage( isbMsgErrr => sbErrorMessage );
        END IF;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END prRegisterRequest;
    
    /**************************************************************************
        Objeto      : fsbCreaActNoReparable
        Autor       : Horbath
        Fecha       : 13/09/2021
        Ticket      : 667
        Descripción: Servicio para registrar solicitud de suspension

        Parámetros Entrada

        Valor de salida

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    FUNCTION fsbCreaActNoReparable
    (
        inuPackageId    IN  mo_packages.package_id%TYPE
    )
    RETURN VARCHAR2
    IS
    
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbCreaActNoReparable';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);  
            
        CURSOR cuCausal
        IS
            SELECT  MM.CAUSAL_ID, CC.CAUSAL_TYPE_ID
            FROM    MO_MOTIVE MM, CC_CAUSAL CC
            WHERE   MM.CAUSAL_ID = CC.CAUSAL_ID
            AND     MM.MOTIVE_ID = inuPackageId;

        nuCausal        mo_motive.causal_id%TYPE;
        nuCausalType    cc_causal.causal_type_id%TYPE;
        nuCausalPar     mo_motive.causal_id%TYPE;
        nuCausalTypePar cc_causal.causal_type_id%TYPE;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  

        OPEN cuCausal;
        FETCH cuCausal INTO nuCausal, nuCausalType;
        CLOSE cuCausal;

        nuCausalPar := daldc_pararepe.fnuGetPAREVANU('LDC_CAUSAL_DEF_NO_REPARA',0);
        nuCausalTypePar := daldc_pararepe.fnuGetPAREVANU('LDC_TIPO_CAUSAL_DEF_NO_REPARA',0);

        IF nuCausalPar = nuCausal AND nuCausalType = nuCausalTypePar THEN
            pkg_Traza.trace('Fin LDC_BODefectNoRepara.fsbCreaActNoReparable - RETURN Y', 15);
            RETURN 'Y';
        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN 'N';

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN 'N';
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN 'N';
    END fsbCreaActNoReparable;
    
    /**************************************************************************
        Nombre       : BorraMarcaProducto
        Fecha       : 13/09/2021
        Ticket      : 667
        Autor       :Horbath
        Descripción: Plugin para borrar la marca del producto

        Parámetros Entrada

        Valor de salida

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    PROCEDURE BorraMarcaProducto

    IS
    
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbCreaActNoReparable';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);      

        nuOrder             OR_order.order_id%type;
        nuProduct           pr_product.product_id%type;
        nuCausal            ge_causal.causal_id%type;
        nuClassCausal       ge_class_causal.class_causal_id%type;
        nuOrderActivity     OR_order_activity.order_activity_id%type;

        CURSOR cuData
        IS
            SELECT  product_id, ORDER_activity_id
            FROM    OR_order_activity
            WHERE   ORDER_id = nuOrder;

        FUNCTION fnuExistMark
        RETURN NUMBER
        IS
            nuCount         NUMBER;

            CURSOR cuLDC_MARCAPRODREPA
            IS
            SELECT  COUNT(1)
            FROM    LDC_MARCAPRODREPA
            WHERE   PRODUCTO_ID = nuProduct
            AND     bloqueo = 'Y';


        BEGIN

            OPEN cuLDC_MARCAPRODREPA;
            FETCH cuLDC_MARCAPRODREPA INTO nuCount;
            CLOSE cuLDC_MARCAPRODREPA;

            RETURN nuCount;

        EXCEPTION
            WHEN pkg_Error.CONTROLLED_ERROR THEN
                RAISE pkg_Error.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                pkg_Error.setError;
                RAISE pkg_Error.CONTROLLED_ERROR;
        END fnuExistMark;


    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  

        nuOrder := PKG_BCORDENES.FNUOBTENEROTINSTANCIALEGAL;
        pkg_Traza.trace('Orden: ['||nuOrder||']',10);

        nuCausal := PKG_BCORDENES.FNUOBTIENECAUSAL(nuOrder);
        nuClassCausal := PKG_BCORDENES.FNUOBTIENECLASECAUSAL(nuCausal);

        OPEN cuData;
        FETCH cuData INTO nuProduct, nuOrderActivity;
        CLOSE cuData;

        IF nuClassCausal = 1 AND fnuExistMark > 0 THEN
        
            UPDATE LDC_MARCAPRODREPA
                SET fecha_inactivacion = LDC_BOCONSGENERALES.FDTGETSYSDATE,
                    bloqueo = 'N'
            WHERE producto_id = nuProduct
            AND   bloqueo = 'Y';
        
        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END BorraMarcaProducto;
    /**************************************************************************
        Nombre       : fsbGetMarkLock
        Autor       :Horbath
        Fecha       : 13/09/2021
        Ticket      : 667
        Descripción: Funcion para determinar si un producto tiene marca de bloqueo

        Parámetros Entrada

        Valor de salida

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    FUNCTION fsbGetMarkLock
    (
        inuProduct          IN          pr_product.product_id%type
    )
    RETURN VARCHAR2
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbGetMarkLock';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);      

        sbResult            VARCHAR2(2);
    
        CURSOR cuGetMark
        IS
            SELECT  DECODE(BLOQUEO, 'Y','S','N')
            FROM    LDC_MARCAPRODREPA
            WHERE   producto_id = inuProduct
            ORDER BY marca_id desc;
    
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
    
        OPEN cuGetMark;
        FETCH cuGetMark INTO sbResult;
        CLOSE cuGetMark;
        
        sbResult := NVL(sbResult, 'N');
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN sbResult;
    
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END fsbGetMarkLock;
    
    FUNCTION fsbValDefectsNoRepairbyCod
    (
        inuCertOiaid          IN      ldc_certificados_oia.certificados_oia_id%type
		    
    )
    RETURN VARCHAR2
    
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbValDefectsNoRepairbyCod';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);   
        
        sbDefectsNoRepair       ldc_pararepe.paravast%type := daldc_pararepe.fsbGetPARAVAST('LDC_DEFECTOS_NO_REPARABLES', NULL);
        nuTotal                 NUMBER;
        nuDefectsNoRepair       NUMBER;
        nuLastCertificate       ldc_certificados_oia.certificados_oia_id%type;

        CURSOR cuGetLastCertificate
        IS
            SELECT  certificados_oia_id
            FROM    ldc_certificados_oia c
            WHERE   c.certificados_oia_id = inuCertOiaid
              AND   status_certificado = 'A'
            ORDER BY FECHA_REGISTRO desc;

        CURSOR cuTotalDefects
        IS
            select  count(distinct defect_id)
            from    ldc_defectos_oia b
            where   b.certificados_oia_id = nuLastCertificate;

        CURSOR cuDefects
        IS
        
            select  count(1)
            FROM    ldc_defectos_oia b
            where   b.certificados_oia_id = nuLastCertificate
            and     b.defect_id IN  
            (
                SELECT to_number(regexp_substr(sbDefectsNoRepair,'[^,]+', 1,LEVEL))
                FROM dual
                CONNECT BY regexp_substr(sbDefectsNoRepair, '[^,]+', 1, LEVEL) IS NOT NULL
            );
    
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        OPEN cuGetLastCertificate;
        FETCH cuGetLastCertificate INTO nuLastCertificate;
        CLOSE cuGetLastCertificate;

        OPEN cuTotalDefects;
        FETCH cuTotalDefects INTO nuTotal;
        CLOSE cuTotalDefects;
        
        OPEN cuDefects;
        FETCH cuDefects INTO nuDefectsNoRepair;
        CLOSE cuDefects;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
                
        IF nuTotal = 0 THEN
            RETURN 'N';
        END IF;
        
        IF nuTotal <> nuDefectsNoRepair THEN
            RETURN 'N';
        END IF;
        
        RETURN 'S';
           
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN 'N';
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RETURN 'N';
    END fsbValDefectsNoRepairbyCod;    

END LDC_BODefectNoRepara;
/

