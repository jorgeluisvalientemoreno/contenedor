CREATE OR REPLACE PACKAGE adm_person.ldc_pkgeneraTramiteRp
IS
    /************************************************************************
    PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

           PAQUETE : ldc_pkgeneraTramiteRp
           FECHA : 07/12/202020
     GLPI : 234

    DESCRIPCION : Paquete para generar los xm y tramites de revision periodica GDC.


    Historia de Modificaciones

    Autor        Fecha       Descripcion.
    PAcosta      15/07/2024  OSF-2885: Cambio de esquema ADM_PERSON  
    epenao       14/11/2023  OSF-1764:
                             +Adición gestión de traza 
                             +Cambio creación XML manual por llamado al método: 
                              pkg_xml_soli_rev_periodica.getXMSolicitudReconexionRp
                             +Cambio creación XML manual por llamado al método: 
                              pkg_xml_soli_rev_periodica.getSolicitudVerificacionRp       
                             +Cambio creación XML manual por llamado al método: 
                               pkg_xml_soli_rev_periodica.getSolicitudSACRp     
                             +Cambio creación XML manual por llamado al método: 
                               pkg_xml_soli_rev_periodica.getXMSolicitudCertificacionRp                                                                                      
                             +Cambio del tipo de dato de la variable XML
                             para que sea del tipo: constants_per.tipo_xml_sol%type.
                             +Se cambia el método del registro de solicitud 
                             OS_RegisterRequestWithXML por API_RegisterRequestByXML.       
                             +Cambio de los métodos:
                               dapr_product.fnugetsubcategory_id X pkg_bcproducto.fnusubcategoria
                               dapr_product.fnugetcategory_id  X pkg_bcproducto.fnucategoria      
    
    ************************************************************************/
    --Creación solicitud getSolicitudRevisionRp
    PROCEDURE prGenera100237 (
        inuTipoRecepsol   IN     ge_reception_type.reception_type_id%TYPE,
        sbcomment         IN     mo_packages.comment_%TYPE,
        nuCliente         IN     ge_subscriber.subscriber_id%TYPE,
        nuProducto        IN     pr_product.product_type_id%TYPE,
        nuContrato        IN     suscripc.susccodi%TYPE,
        sbDireccion       IN     ab_address.address_parsed%TYPE,
        nuDireccion       IN     ab_address.address_id%TYPE,
        nuLocalidad       IN     ge_geogra_location.geograp_location_id%TYPE,
        nuCategory        IN     pr_product.category_id%TYPE,
        nuSubcategory     IN     pr_product.subcategory_id%TYPE,
        nuPackageId       OUT    mo_packages.package_id%TYPE,
        nuMotiveId        OUT    mo_motive.motive_id%TYPE,
        nuMensaje         OUT    NUMBER,
        sbMensaje         OUT    VARCHAR2);

    --Creación solicitud getSolicitudReparacionRp
    PROCEDURE prGenera100294 (
        inuTipoRecepsol   IN     ge_reception_type.reception_type_id%TYPE,
        sbcomment         IN     mo_packages.comment_%TYPE,
        nuCliente         IN     ge_subscriber.subscriber_id%TYPE,
        nuProducto        IN     pr_product.product_type_id%TYPE,
        nuContrato        IN     suscripc.susccodi%TYPE,
        sbDireccion       IN     ab_address.address_parsed%TYPE,
        nuDireccion       IN     ab_address.address_id%TYPE,
        nuLocalidad       IN     ge_geogra_location.geograp_location_id%TYPE,
        nuCategory        IN     pr_product.category_id%TYPE,
        nuSubcategory     IN     pr_product.subcategory_id%TYPE,
        nuPackageId       OUT    mo_packages.package_id%TYPE,
        nuMotiveId        OUT    mo_motive.motive_id%TYPE,
        nuMensaje         OUT    NUMBER,
        sbMensaje         OUT    VARCHAR2);

    --Creación solicitud getXMSolicitudCertificacionRp
    PROCEDURE prGenera100295 (
        inuTipoRecepsol   IN     ge_reception_type.reception_type_id%TYPE,
        sbcomment         IN     mo_packages.comment_%TYPE,
        nuCliente         IN     ge_subscriber.subscriber_id%TYPE,
        nuProducto        IN     pr_product.product_type_id%TYPE,
        nuContrato        IN     suscripc.susccodi%TYPE,
        sbDireccion       IN     ab_address.address_parsed%TYPE,
        nuDireccion       IN     ab_address.address_id%TYPE,
        nuLocalidad       IN     ge_geogra_location.geograp_location_id%TYPE,
        nuCategory        IN     pr_product.category_id%TYPE,
        nuSubcategory     IN     pr_product.subcategory_id%TYPE,
        nuPackageId       OUT    mo_packages.package_id%TYPE,
        nuMotiveId        OUT    mo_motive.motive_id%TYPE,
        nuMensaje         OUT    NUMBER,
        sbMensaje         OUT    VARCHAR2);

    --Creación solicitud getSolicitudSACRp
    PROCEDURE prGenera100306 (
        inuTipoRecepsol   IN     ge_reception_type.reception_type_id%TYPE,
        sbcomment         IN     mo_packages.comment_%TYPE,
        nuCliente         IN     ge_subscriber.subscriber_id%TYPE,
        nuProducto        IN     pr_product.product_type_id%TYPE,
        nuContrato        IN     suscripc.susccodi%TYPE,
        nuDireccion       IN     ab_address.address_id%TYPE,
        dtFechaSolic      IN     DATE,
        nuPersonId        IN     ge_person.person_id%TYPE,
        nuActividad       IN     ge_items.items_id%TYPE,
        nuOrden           IN     or_order.order_id%TYPE,
        nuUnidad          IN     mo_packages.pos_oper_unit_id%TYPE,
        nuPackageId       OUT    mo_packages.package_id%TYPE,
        nuMotiveId        OUT    mo_motive.motive_id%TYPE,
        nuMensaje         OUT    NUMBER,
        sbMensaje         OUT    VARCHAR2);

    --Crea solicitud getSolicitudVerificacionRp
    PROCEDURE prGenera100355 (
        inuTipoRecepsol   IN     ge_reception_type.reception_type_id%TYPE,
        sbcomment         IN     mo_packages.comment_%TYPE,
        nuCliente         IN     ge_subscriber.subscriber_id%TYPE,
        nuProducto        IN     pr_product.product_type_id%TYPE,
        nuContrato        IN     suscripc.susccodi%TYPE,
        nuDireccion       IN     ab_address.address_id%TYPE,
        nuPackageId       OUT    mo_packages.package_id%TYPE,
        nuMotiveId        OUT    mo_motive.motive_id%TYPE,
        nuMensaje         OUT    NUMBER,
        sbMensaje         OUT    VARCHAR2);

    
    --Crea solicitud getXMSolicitudReconexionRp
    PROCEDURE prGenera100321 (
        inuTipoRecepsol   IN     ge_reception_type.reception_type_id%TYPE,
        sbcomment         IN     mo_packages.comment_%TYPE,
        nuCliente         IN     ge_subscriber.subscriber_id%TYPE,
        nuProducto        IN     pr_product.product_type_id%TYPE,
        nuContrato        IN     suscripc.susccodi%TYPE,
        sbDireccion       IN     ab_address.address_parsed%TYPE,
        nuDireccion       IN     ab_address.address_id%TYPE,
        nuLocalidad       IN     ge_geogra_location.geograp_location_id%TYPE,
        nuCategory        IN     pr_product.category_id%TYPE,
        nuSubcategory     IN     pr_product.subcategory_id%TYPE,
        nuTipoSuspen      IN     ge_suspension_type.suspension_type_id%TYPE,
        nuPackageId       OUT    mo_packages.package_id%TYPE,
        nuMotiveId        OUT    mo_motive.motive_id%TYPE,
        nuMensaje         OUT    NUMBER,
        sbMensaje         OUT    VARCHAR2);
END ldc_pkgeneraTramiteRp;
/

CREATE OR REPLACE PACKAGE BODY adm_person.ldc_pkgeneraTramiteRp
IS
   csbNOMPKG    	CONSTANT VARCHAR2(35):= $$PLSQL_UNIT||'.'; -- Constantes para el control de la traza     
    PROCEDURE prGenera100237 (
        inuTipoRecepsol   IN     ge_reception_type.reception_type_id%TYPE,
        sbcomment         IN     mo_packages.comment_%TYPE,
        nuCliente         IN     ge_subscriber.subscriber_id%TYPE,
        nuProducto        IN     pr_product.product_type_id%TYPE,
        nuContrato        IN     suscripc.susccodi%TYPE,
        sbDireccion       IN     ab_address.address_parsed%TYPE,
        nuDireccion       IN     ab_address.address_id%TYPE,
        nuLocalidad       IN     ge_geogra_location.geograp_location_id%TYPE,
        nuCategory        IN     pr_product.category_id%TYPE,
        nuSubcategory     IN     pr_product.subcategory_id%TYPE,
        nuPackageId       OUT    mo_packages.package_id%TYPE,
        nuMotiveId        OUT    mo_motive.motive_id%TYPE,
        nuMensaje         OUT    NUMBER,
        sbMensaje         OUT    VARCHAR2)
    IS
        /************************************************************************
        PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

               PAQUETE : prGenera100237
               FECHA : 07/12/2020
             GLPI : 234

        DESCRIPCION : Proceso para generar el tramite de revisión de RP 100237


        Historia de Modificaciones

        Autor        Fecha       Descripcion.
        epenao       14/11/2023  OSF-1764:
                                 +Adición gestión de traza 
                                 +Cambio creación XML manual por llamado al método: 
                                  pkg_xml_soli_rev_periodica.getSolicitudRevisionRp
                                 +Cambio del tipo de dato de la variable XML
                                 para que sea del tipo: constants_per.tipo_xml_sol%type.
                                 +Se cambia el método del registro de solicitud 
                                 OS_RegisterRequestWithXML por API_RegisterRequestByXML.  
        dsaltarin    01/02/2020  442: Se corrige la definicion de la variable nuDireccion

        ************************************************************************/
       csbMetodo      CONSTANT VARCHAR2(100) := csbNOMPKG||'prGenera100237'; --Nombre del método en la traza        
       sbRequestXML   constants_per.tipo_xml_sol%type;
    BEGIN
        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);
        sbRequestXML := pkg_xml_soli_rev_periodica.getSolicitudRevisionRp
                        (    inuMedioRecepcionId =>inuTipoRecepsol,
                             isbComentario  => sbcomment,
                             inuProductoId  => nuProducto,
                             inuClienteId  =>  nuCliente
                        );

        pkg_traza.trace('sbRequestXML:'||sbRequestXML,pkg_traza.cnuNivelTrzDef); 

        API_RegisterRequestByXML (sbRequestXML,
                                   nuPackageId,
                                   nuMotiveId,
                                   nuMensaje,
                                   sbMensaje);

        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);                                   
    END prGenera100237;


    PROCEDURE prGenera100294 (
        inuTipoRecepsol   IN     ge_reception_type.reception_type_id%TYPE,
        sbcomment         IN     mo_packages.comment_%TYPE,
        nuCliente         IN     ge_subscriber.subscriber_id%TYPE,
        nuProducto        IN     pr_product.product_type_id%TYPE,
        nuContrato        IN     suscripc.susccodi%TYPE,
        sbDireccion       IN     ab_address.address_parsed%TYPE,
        nuDireccion       IN     ab_address.address_id%TYPE,
        nuLocalidad       IN     ge_geogra_location.geograp_location_id%TYPE,
        nuCategory        IN     pr_product.category_id%TYPE,
        nuSubcategory     IN     pr_product.subcategory_id%TYPE,
        nuPackageId          OUT mo_packages.package_id%TYPE,
        nuMotiveId           OUT mo_motive.motive_id%TYPE,
        nuMensaje            OUT NUMBER,
        sbMensaje            OUT VARCHAR2)
    IS
        /************************************************************************
        PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

               PAQUETE : prGenera100294
               FECHA : 07/12/2020
             GLPI : 234

        DESCRIPCION : Proceso para generar el reparacion de revisión de RP 100294


        Historia de Modificaciones

        Autor        Fecha       Descripcion.
        epenao       14/11/2023  OSF-1764:
                                 +Adición gestión de traza 
                                 +Cambio creación XML manual por llamado al método: 
                                  pkg_xml_soli_rev_periodica.getSolicitudReparacionRp
                                 +Cambio del tipo de dato de la variable XML
                                 para que sea del tipo: constants_per.tipo_xml_sol%type.
                                 +Se cambia el método del registro de solicitud 
                                 OS_RegisterRequestWithXML por API_RegisterRequestByXML.        
        dsaltarin    01/02/2020  442: Se corrige la definicion de la variable nuDireccion
        ************************************************************************/
       csbMetodo       CONSTANT VARCHAR2(100) := csbNOMPKG||'prGenera100294'; --Nombre del método en la traza
       sbRequestXML    constants_per.tipo_xml_sol%type;
     BEGIN
        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);

        sbRequestXML :=  pkg_xml_soli_rev_periodica.getSolicitudReparacionRp
                         (    inuMedioRecepcionId  => inuTipoRecepsol,
                              isbComentario        => sbComment,
                              inuProductoId        => nuProducto,
                              inuClienteId         => nuCliente
                         );
        
        pkg_traza.trace('sbRequestXML:'||sbRequestXML,pkg_traza.cnuNivelTrzDef);                          

        API_RegisterRequestByXML (sbRequestXML,
                                   nuPackageId,
                                   nuMotiveId,
                                   nuMensaje,
                                   sbMensaje);

        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);
    END prGenera100294;

    PROCEDURE prGenera100295 (
        inuTipoRecepsol   IN     ge_reception_type.reception_type_id%TYPE,
        sbcomment         IN     mo_packages.comment_%TYPE,
        nuCliente         IN     ge_subscriber.subscriber_id%TYPE,
        nuProducto        IN     pr_product.product_type_id%TYPE,
        nuContrato        IN     suscripc.susccodi%TYPE,
        sbDireccion       IN     ab_address.address_parsed%TYPE,
        nuDireccion       IN     ab_address.address_id%TYPE,
        nuLocalidad       IN     ge_geogra_location.geograp_location_id%TYPE,
        nuCategory        IN     pr_product.category_id%TYPE,
        nuSubcategory     IN     pr_product.subcategory_id%TYPE,
        nuPackageId          OUT mo_packages.package_id%TYPE,
        nuMotiveId           OUT mo_motive.motive_id%TYPE,
        nuMensaje            OUT NUMBER,
        sbMensaje            OUT VARCHAR2)
    IS
        /************************************************************************
        PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

               PAQUETE : prGenera100295
               FECHA : 07/12/2020
             GLPI : 234

        DESCRIPCION : Proceso para generar el tramite de certificacion de RP 100295


        Historia de Modificaciones

        Autor        Fecha       Descripcion.
        epenao       14/11/2023  OSF-1764:
                                 +Adición gestión de traza 
                                 +Cambio creación XML manual por llamado al método: 
                                  pkg_xml_soli_rev_periodica.getXMSolicitudCertificacionRp
                                 +Cambio del tipo de dato de la variable XML
                                 para que sea del tipo: constants_per.tipo_xml_sol%type.
                                 +Se cambia el método del registro de solicitud 
                                 OS_RegisterRequestWithXML por API_RegisterRequestByXML.           
        dsaltarin    01/02/2020  442: Se corrige la definicion de la variable nuDireccion
        ************************************************************************/
       csbMetodo       CONSTANT VARCHAR2(100) := csbNOMPKG||'prGenera100295'; --Nombre del método en la traza
       sbRequestXML    constants_per.tipo_xml_sol%type;
    BEGIN
         pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);

        sbRequestXML :=  pkg_xml_soli_rev_periodica.getXMSolicitudCertificacionRp
                         (    inuMedioRecepcionId  => inuTipoRecepsol,
                              isbComentario        => sbComment,
                              inuProductoId        => nuProducto,
                              inuClienteId         => nuCliente
                         );

        pkg_traza.trace('sbRequestXML:'||sbRequestXML,pkg_traza.cnuNivelTrzDef);

        API_RegisterRequestByXML (sbRequestXML,
                                   nuPackageId,
                                   nuMotiveId,
                                   nuMensaje,
                                   sbMensaje);

        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);
    END prGenera100295;

    PROCEDURE prGenera100306 (
        inuTipoRecepsol   IN     ge_reception_type.reception_type_id%TYPE,
        sbcomment         IN     mo_packages.comment_%TYPE,
        nuCliente         IN     ge_subscriber.subscriber_id%TYPE,
        nuProducto        IN     pr_product.product_type_id%TYPE,
        nuContrato        IN     suscripc.susccodi%TYPE,
        nuDireccion       IN     ab_address.address_id%TYPE,
        dtFechaSolic      IN     DATE,
        nuPersonId        IN     ge_person.person_id%TYPE,
        nuActividad       IN     ge_items.items_id%TYPE,
        nuOrden           IN     or_order.order_id%TYPE,
        nuUnidad          IN     mo_packages.pos_oper_unit_id%TYPE,
        nuPackageId          OUT mo_packages.package_id%TYPE,
        nuMotiveId           OUT mo_motive.motive_id%TYPE,
        nuMensaje            OUT NUMBER,
        sbMensaje            OUT VARCHAR2)
    IS
        /************************************************************************
        PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

               PAQUETE : prGenera100306
               FECHA : 07/12/2020
             GLPI : 234

        DESCRIPCION : Proceso para generar el tramite de SAC para RP


        Historia de Modificaciones

        Autor        Fecha       Descripcion.
        epenao       14/11/2023  OSF-1764:
                                 +Adición gestión de traza 
                                 +Cambio creación XML manual por llamado al método: 
                                  pkg_xml_soli_rev_periodica.getSolicitudSACRp
                                 +Cambio del tipo de dato de la variable XML
                                 para que sea del tipo: constants_per.tipo_xml_sol%type.
                                 +Se cambia el método del registro de solicitud 
                                 OS_RegisterRequestWithXML por API_RegisterRequestByXML.           
        dsaltarin    01/02/2020  442: Se corrige la definicion de la variable nuDireccion
        ************************************************************************/
       csbMetodo       CONSTANT VARCHAR2(100) := csbNOMPKG||'prGenera100306'; --Nombre del método en la traza
       sbRequestXML    constants_per.tipo_xml_sol%type;
       nuOk  number;
    BEGIN
         pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);

         sbRequestXML := pkg_xml_soli_rev_periodica.getSolicitudSACRp
                        (    inuMedioRecepcionId => inuTipoRecepsol,
                             isbComentario       => sbComment,
                             inuProductoId       => nuProducto,
                             inuClienteId        => nuCliente,
                             idtFechaSolicitud   => dtFechaSolic,
                             inuActividadId      => nuActividad,
                             inuOrdenId          => nuOrden
                        );

        pkg_traza.trace('sbRequestXML:'||sbRequestXML,pkg_traza.cnuNivelTrzDef);        

        API_RegisterRequestByXML (sbRequestXML,
                                   nuPackageId,
                                   nuMotiveId,
                                   nuMensaje,
                                   sbMensaje);
        nuOk := nuMensaje;
        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);
    END prGenera100306;

    PROCEDURE prGenera100355 (
        inuTipoRecepsol   IN     ge_reception_type.reception_type_id%TYPE,
        sbcomment         IN     mo_packages.comment_%TYPE,
        nuCliente         IN     ge_subscriber.subscriber_id%TYPE,
        nuProducto        IN     pr_product.product_type_id%TYPE,
        nuContrato        IN     suscripc.susccodi%TYPE,
        nuDireccion       IN     ab_address.address_id%TYPE,
        nuPackageId          OUT mo_packages.package_id%TYPE,
        nuMotiveId           OUT mo_motive.motive_id%TYPE,
        nuMensaje            OUT NUMBER,
        sbMensaje            OUT VARCHAR2)
    IS
        /************************************************************************
        PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

               PAQUETE : prGenera100355
               FECHA : 07/12/2020
             GLPI : 234

        DESCRIPCION : Proceso para generar el tramite de verificacion RP


        Historia de Modificaciones

        Autor        Fecha       Descripcion.
        epenao       14/11/2023  OSF-1764:
                                 +Adición gestión de traza 
                                 +Cambio creación XML manual por llamado al método: 
                                  pkg_xml_soli_rev_periodica.getSolicitudVerificacionRp
                                 +Cambio del tipo de dato de la variable XML
                                 para que sea del tipo: constants_per.tipo_xml_sol%type.
                                 +Se cambia el método del registro de solicitud 
                                 OS_RegisterRequestWithXML por API_RegisterRequestByXML.           
        dsaltarin    01/02/2020  442: Se corrige la definicion de la variable nuDireccion
        ************************************************************************/
        csbMetodo      CONSTANT VARCHAR2(100) := csbNOMPKG||'prGenera100355'; --Nombre del método en la traza
        sbRequestXML   constants_per.tipo_xml_sol%type;
    BEGIN
        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);

        sbRequestXML :=  pkg_xml_soli_rev_periodica.getSolicitudVerificacionRp  
                         (    inuMedioRecepcionId  => inuTipoRecepsol,
                              isbComentario        => sbComment,
                              inuProductoId        => nuProducto,
                              inuClienteId         => nuCliente
                         );

        pkg_traza.trace('sbRequestXML:'||sbRequestXML,pkg_traza.cnuNivelTrzDef);                         

        API_RegisterRequestByXML (sbRequestXML,
                                   nuPackageId,
                                   nuMotiveId,
                                   nuMensaje,
                                   sbMensaje);
        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);
    END prGenera100355;

    PROCEDURE prGenera100321 (
        inuTipoRecepsol   IN     ge_reception_type.reception_type_id%TYPE,
        sbcomment         IN     mo_packages.comment_%TYPE,
        nuCliente         IN     ge_subscriber.subscriber_id%TYPE,
        nuProducto        IN     pr_product.product_type_id%TYPE,
        nuContrato        IN     suscripc.susccodi%TYPE,
        sbDireccion       IN     ab_address.address_parsed%TYPE,
        nuDireccion       IN     ab_address.address_id%TYPE,
        nuLocalidad       IN     ge_geogra_location.geograp_location_id%TYPE,
        nuCategory        IN     pr_product.category_id%TYPE,
        nuSubcategory     IN     pr_product.subcategory_id%TYPE,
        nuTipoSuspen      IN     ge_suspension_type.suspension_type_id%TYPE,
        nuPackageId          OUT mo_packages.package_id%TYPE,
        nuMotiveId           OUT mo_motive.motive_id%TYPE,
        nuMensaje            OUT NUMBER,
        sbMensaje            OUT VARCHAR2)
    IS
        /************************************************************************
        PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

               PAQUETE : prGenera100321
               FECHA : 07/12/2020
             GLPI : 234

        DESCRIPCION : Proceso para generar el tramite de reconexión 100321


        Historia de Modificaciones

        Autor        Fecha       Descripcion.
        epenao       14/11/2023  OSF-1764:
                                 +Adición gestión de traza 
                                 +Cambio creación XML manual por llamado al método: 
                                  pkg_xml_soli_rev_periodica.getXMSolicitudReconexionRp
                                 +Cambio del tipo de dato de la variable XML
                                 para que sea del tipo: constants_per.tipo_xml_sol%type.
                                 +Se cambia el método del registro de solicitud 
                                 OS_RegisterRequestWithXML por API_RegisterRequestByXML.       
                                 +Cambio de los métodos:
                                   dapr_product.fnugetsubcategory_id X pkg_bcproducto.fnusubcategoria
                                   dapr_product.fnugetcategory_id  X pkg_bcproducto.fnucategoria   
        dsaltarin    01/02/2020  442: Se corrige la definicion de la variable nuDireccion
        ************************************************************************/
        csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'prGenera100321'; --Nombre del método en la traza

        -- Cursor para obtener los componentes asociados a un motivo
        CURSOR cuComponente (nucumotivos mo_motive.motive_id%TYPE)
        IS
            SELECT COUNT (1)
              FROM mo_component C
             WHERE c.package_id = nucumotivos;

        sbRequestXML     constants_per.tipo_xml_sol%type;
        nucont           NUMBER (4);
        rcComponent      damo_component.stymo_component;
        rcmo_comp_link   damo_comp_link.stymo_comp_link;
        nunumber         NUMBER (4) DEFAULT 0;
        nuprodmotive     mo_component.prod_motive_comp_id%TYPE;
        sbtagname        mo_component.tag_name%TYPE;
        nuclasserv       mo_component.class_service_id%TYPE;
        nucomppadre      mo_component.component_id%TYPE;
    BEGIN
        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);

        sbrequestxml := pkg_xml_soli_rev_periodica.getXMSolicitudReconexionRp  
                        (    inuMedioRecepcionId  => inuTipoRecepsol,
                             isbComentario        => sbcomment,
                             inuProductoId        => nuProducto,
                             inuClienteId         => nucliente,
                             inuTipoSuspensionId  => nuTipoSuspen
                         );
        
        pkg_traza.trace('sbRequestXML:'||sbRequestXML,pkg_traza.cnuNivelTrzDef);

        API_RegisterRequestByXML (sbRequestXML,
                                   nuPackageId,
                                   nuMotiveId,
                                   nuMensaje,
                                   sbMensaje);

        IF nuMensaje = 0
        THEN
            OPEN cuComponente (numotiveid);

            FETCH cuComponente INTO nucont;

            CLOSE cuComponente;

            -- Si el motivo no tine los componentes asociados, se procede a registrarlos
            IF (nucont = 0)
            THEN
                FOR i
                    IN (  SELECT kl.*,
                                 mk.package_id         solicitud,
                                 mk.subcategory_id     subcategoria
                            FROM mo_motive mk, pr_component kl
                           WHERE     mk.motive_id = numotiveid
                                 AND kl.component_status_id <> 9
                                 AND mk.product_id = kl.product_id
                        ORDER BY kl.component_type_id)
                LOOP
                    IF i.component_type_id = 7038
                    THEN
                        nunumber := 1;
                        nuprodmotive := 10346;
                        sbtagname := 'C_GAS_10346';
                        nuclasserv := NULL;
                    ELSIF i.component_type_id = 7039
                    THEN
                        nunumber := 2;
                        nuprodmotive := 10348;
                        sbtagname := 'C_MEDICION_10348';
                        nuclasserv := 3102;
                    END IF;

                    rcComponent.component_id :=
                        mo_bosequences.fnugetcomponentid ();
                    rcComponent.component_number := nunumber;
                    rcComponent.obligatory_flag := 'N';
                    rcComponent.obligatory_change := 'N';
                    rcComponent.notify_assign_flag := 'N';
                    rcComponent.authoriz_letter_flag := 'N';
                    rcComponent.status_change_date := SYSDATE;
                    rcComponent.recording_date := SYSDATE;
                    rcComponent.directionality_id := 'BI';
                    rcComponent.custom_decision_flag := 'N';
                    rcComponent.keep_number_flag := 'N';
                    rcComponent.motive_id := numotiveid;
                    rcComponent.prod_motive_comp_id := nuprodmotive;
                    rcComponent.component_type_id := i.component_type_id;
                    rcComponent.motive_type_id := 75;
                    rcComponent.motive_status_id := 15;
                    rcComponent.product_motive_id := 100304;
                    rcComponent.class_service_id := nuclasserv;
                    rcComponent.package_id := nupackageid;
                    rcComponent.product_id := i.product_id;
                    rcComponent.service_number := i.product_id;
                    rcComponent.component_id_prod := i.component_id;
                    rcComponent.uncharged_time := 0;
                    rcComponent.product_origin_id := i.product_id;
                    rcComponent.quantity := 1;
                    rcComponent.tag_name := sbtagname;
                    rcComponent.is_included := 'N';
                    rcComponent.category_id :=
                        pkg_bcproducto.fnucategoria(i.product_id); --i.category_id;
                    rcComponent.subcategory_id :=
                        pkg_bcproducto.fnusubcategoria (i.product_id); --i.subcategoria;

                    damo_component.Insrecord (rcComponent);

                    IF i.component_type_id = 7038
                    THEN
                        nucomppadre := rcComponent.component_id;
                    END IF;

                    IF (nuMotiveId IS NOT NULL)
                    THEN
                        rcmo_comp_link.child_component_id :=
                            rcComponent.component_id;

                        IF i.component_type_id = 7039
                        THEN
                            rcmo_comp_link.father_component_id := nucomppadre;
                        ELSE
                            rcmo_comp_link.father_component_id := NULL;
                        END IF;

                        rcmo_comp_link.motive_id := nuMotiveId;
                        damo_comp_link.insrecord (rcmo_comp_link);
                    END IF;
                END LOOP;
            END IF;
        END IF;
     pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);
     Exception
       when others then
           pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
           pkg_Error.seterror;
           pkg_Error.Geterror(nuMensaje , sbMensaje );
    END prGenera100321;
END ;
/
PROMPT Otorgando permisos de ejecucion a LDC_PKGENERATRAMITERP
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PKGENERATRAMITERP', 'ADM_PERSON');
END;
/