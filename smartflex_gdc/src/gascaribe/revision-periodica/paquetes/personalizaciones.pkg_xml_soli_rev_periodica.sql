CREATE OR REPLACE PACKAGE personalizaciones.pkg_xml_soli_rev_periodica IS

   /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : pkg_xml_soli_rev_periodica
        Descripcion     : paquete para gestion de solicitudes de revision periodica
        Autor           : Jhon Soto
        Fecha           : 13-09-2023
        Parametros de Entrada

        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso     Descripción
		jsoto	    13/09/2023	OSF-1573 Creacion
        Adrianavg   02/10/2023  OSF-1658 Añadir funciones que armen los XML de las 
                                         solicitudes relacionadas con el área de Revisión Periódica de GDC.
                                         se añade csbMetodo, sbPkgName, se reemplaza variable sbXmlSolRev por sbXmlSol
                                         se ajusta Inicio y fin del UT_TRACE. Se declara el RETURN de tipo constants_per.tipo_xml_sol%type
		jsoto		30/10/2023	OSF-1858 Agregar funciones getSolicitudVerificacionSACRP
										 Cambio en el manejo de trazas por personalido.
    ***************************************************************************/

FUNCTION getSolicitudRevisionRp (inuMedioRecepcionId  IN mo_packages.reception_type_id%type,
                                 isbComentario        IN mo_packages.comment_%type,
                                 inuProductoId        IN mo_motive.product_id%type,
                                 inuClienteId         IN suscripc.suscclie%type)
    RETURN constants_per.tipo_xml_sol%type;


FUNCTION getSolicitudReparacionRp(inuMedioRecepcionId  IN mo_packages.reception_type_id%type,
                                 isbComentario        IN mo_packages.comment_%type,
                                 inuProductoId        IN mo_motive.product_id%type,
                                 inuClienteId         IN suscripc.suscclie%type)
    RETURN constants_per.tipo_xml_sol%type;


FUNCTION getXMSolicitudCertificacionRp(inuMedioRecepcionId  IN mo_packages.reception_type_id%type,
                                 isbComentario        IN mo_packages.comment_%type,
                                 inuProductoId        IN mo_motive.product_id%type,
                                 inuClienteId         IN suscripc.suscclie%type)
    RETURN constants_per.tipo_xml_sol%type;


FUNCTION getXMSolicitudReconexionRp(inuMedioRecepcionId  IN mo_packages.reception_type_id%type,
									isbComentario        IN mo_packages.comment_%type,
									inuProductoId        IN mo_motive.product_id%type,
									inuClienteId         IN suscripc.suscclie%type,
									inuTipoSuspensionId  IN NUMBER)
    RETURN constants_per.tipo_xml_sol%type;


FUNCTION getSolicitudSACRp(inuMedioRecepcionId  IN mo_packages.reception_type_id%type,
                           isbComentario        IN mo_packages.comment_%type,
                           inuProductoId        IN mo_motive.product_id%type,
                           inuClienteId         IN suscripc.suscclie%type,
                           idtFechaSolicitud    IN mo_packages.request_date%type,
                           inuActividadId       IN or_order_activity.activity_id%type,
                           inuOrdenId           IN or_order_activity.order_id%type)
    RETURN constants_per.tipo_xml_sol%type;


FUNCTION getSolicitudVerificacionRp(inuMedioRecepcionId  IN mo_packages.reception_type_id%type,
									isbComentario        IN mo_packages.comment_%type,
                                    inuProductoId        IN mo_motive.product_id%type,
                                    inuClienteId         IN suscripc.suscclie%type)
    RETURN constants_per.tipo_xml_sol%type;
    

FUNCTION getSuspensionAdministrativa(inuMedioRecepcionId IN mo_packages.reception_type_id%type,
                                     inuContactoId IN mo_packages.contact_id%type,
                                     inuDireccionId IN ab_address.address_id%type,
                                     isbComentario IN mo_packages.comment_%type,
                                     inuProducto IN servsusc.sesunuse%type,
                                     idtFechaSuspension IN pr_prod_suspension.aplication_date%type,
                                     inuTipoSuspension IN ge_suspension_type.suspension_type_id%type,
                                     inuTipoCausal IN ge_causal.causal_type_id%type,
                                     inuCausal IN ge_causal.causal_id%type)
    RETURN constants_per.tipo_xml_sol%type;


FUNCTION getNotiSuspension(inuMedioRecepcionId IN mo_packages.reception_type_id%type,
                           isbComentario IN mo_packages.comment_%type,
                           inuCliente IN ge_subscriber.subscriber_id%type,
                           inuProducto IN servsusc.sesunuse%type,
                           inuContrato IN suscripc.susccodi%type,
                           inuDireccion IN ab_address.address_parsed%type,
                           inuDireccionId IN ab_address.address_id%type,
                           inuUbicacionGeografica IN ge_geogra_location.geograp_location_id%type,
                           inuCategoria IN servsusc.sesucate%type,
                           inuSubcategoria IN servsusc.sesusuca%type)
    RETURN constants_per.tipo_xml_sol%type;
    
FUNCTION getCambioEstado(idtFechaSolicitud IN mo_packages.request_date%type,
                         inuContactoId IN mo_packages.contact_id%type,
                         inuDireccionId IN ab_address.address_id%type,
                         isbComentario IN mo_packages.comment_%type,
                         inuProducto IN servsusc.sesunuse%type,
                         inuContrato IN suscripc.susccodi%type)
    RETURN constants_per.tipo_xml_sol%type;     


FUNCTION getSolicitudVerificacionSACRP(	
										inuMedioRecepcionId IN mo_packages.reception_type_id%type,
										inuContactoId IN mo_packages.contact_id%type,
										inuDireccionId IN ab_address.address_id%type,
										isbComentario IN mo_packages.comment_%type,
										inuProducto IN servsusc.sesunuse%type,
										inuContrato IN suscripc.susccodi%type,
										inuTelefono IN ge_subscriber.phone%type)
    RETURN constants_per.tipo_xml_sol%type;     





END pkg_xml_soli_rev_periodica;
/
CREATE OR REPLACE package body  personalizaciones.pkg_xml_soli_rev_periodica IS

--CONSTANTES
sbXmlSol  constants_per.tipo_xml_sol%type;
sbPkgName VARCHAR2(50) := 'PKG_XML_SOLI_REV_PERIODICA';

    -- Constantes para el control de la traza
cnuNVLTRC 	CONSTANT NUMBER := pkg_traza.cnuNivelTrzDef;
csbInicio   CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;


  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : getSolicitudRevisionRp
    Descripcion     : Armar XML para solicitud de revision periodica
    Autor           : Jhon Soto
    Fecha           : 13-09-2023

    Parametros de Entrada
    inuMedioRecepcionId  Medio de recepcion
    isbComentario        Comentario
    inuProductoId        Producto
    inuClienteId         Cliente

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso     Descripcion
    Adrianavg   02/10/2023  OSF-1658 Se añade csbMetodo, sbPkgName
                                     se reemplaza variable sbXmlSolRev por sbXmlSol
                                     se ajusta Inicio y fin del UT_TRACE      
  ***************************************************************************/

  FUNCTION getSolicitudRevisionRp(inuMedioRecepcionId  IN mo_packages.reception_type_id%type,
                                 isbComentario        IN mo_packages.comment_%type,
                                 inuProductoId        IN mo_motive.product_id%type,
                                 inuClienteId         IN suscripc.suscclie%type)
    RETURN constants_per.tipo_xml_sol%type IS
    csbMetodo CONSTANT VARCHAR(60) := sbPkgName||'.GETSOLICITUDREVISIONRP';
    
      nuContrato    suscripc.susccodi%type;
      sbDireccion   ge_subscriber.address%type;
      nuDireccion   ge_subscriber.address_id%type;
      nuLocalidad   ge_geogra_location.geograp_location_id%type;
      nuCategory    pr_product.category_id%type;
      nuSubcategory pr_product.subcategory_id%type;
      nuCliente     suscripc.suscclie%type; 

      CURSOR cuDatos IS
       Select Su.Susccodi,
              Ab.Address_Parsed,
              Ab.Address_Id,
              Ab.Geograp_Location_Id,
              Pr.Category_Id,
              Pr.Subcategory_Id,
              Su.Suscclie
         From Suscripc Su,
              Pr_Product Pr,
              Ab_Address Ab
        Where Pr.Subscription_Id = Su.Susccodi
          And Pr.Address_Id = Ab.Address_Id
          And Pr.Product_Id  = inuProductoId;
		  


  BEGIN

	pkg_traza.trace(csbMetodo,cnuNVLTRC,csbInicio);

    pkg_traza.trace('inuProductoId: ' || inuProductoId , cnuNVLTRC);

    OPEN cuDatos;
    FETCH cuDatos
      INTO nuContrato,sbDireccion,nuDireccion,nuLocalidad,nuCategory,nuSubcategory,nuCliente;
    CLOSE cuDatos;

    sbXmlSol :=
    '<?xml version="1.0" encoding="ISO-8859-1"?>
                             <P_LDC_SOLICITUD_VISITA_IDENTIFICACION_CERTIFICADO_100237 ID_TIPOPAQUETE="100237">
                             <RECEPTION_TYPE_ID>'||inuMedioRecepcionId||'</RECEPTION_TYPE_ID>
                             <COMMENT_>'||isbComentario||'</COMMENT_>
                             <IDENTIFICADOR_DEL_CLIENTE>'||nvl(inuClienteId,nuCliente)||'</IDENTIFICADOR_DEL_CLIENTE>
                             <M_MOTIVO_VISITA_IDENTIFICACION_CERTIFICADO_100243>
                             <PRODUCT_ID>'||inuProductoId||'</PRODUCT_ID>
                             <SUBSCRIPTION_ID>'||nuContrato||'</SUBSCRIPTION_ID>
                             <ADDRESS>'||sbDireccion||'</ADDRESS>
                             <PARSER_ADDRESS_ID>'||nuDireccion||'</PARSER_ADDRESS_ID>
                             <GEOGRAP_LOCATION_ID>'||nuLocalidad||'</GEOGRAP_LOCATION_ID>
                             <CATEGORY_ID>'||nuCategory||'</CATEGORY_ID>
                             <SUBCATEGORY_ID>'||nuSubcategory||'</SUBCATEGORY_ID>
                             </M_MOTIVO_VISITA_IDENTIFICACION_CERTIFICADO_100243>
                             </P_LDC_SOLICITUD_VISITA_IDENTIFICACION_CERTIFICADO_100237>';

	pkg_traza.trace(csbMetodo,cnuNVLTRC,pkg_traza.csbFIN);
	return sbXmlSol;    
  EXCEPTION
    WHEN PKG_ERROR.CONTROLLED_ERROR THEN
		pkg_traza.trace(csbMetodo,cnuNVLTRC,pkg_traza.csbFIN_ERC);
		raise PKG_ERROR.CONTROLLED_ERROR;
    WHEN others THEN
		pkg_traza.trace(csbMetodo,cnuNVLTRC,pkg_traza.csbFIN_ERR);
		Pkg_Error.seterror;
		raise PKG_ERROR.CONTROLLED_ERROR;
  END getSolicitudRevisionRp;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : getSolicitudReparacionRp
    Descripcion     : Armar XML para solicitud de reparación de revision periodica
    Autor           : Jhon Soto
    Fecha           : 13-09-2023

    Parametros de Entrada
    inuMedioRecepcionId  Medio de recepcion
    isbComentario        Comentario
    inuProductoId        Producto
    inuClienteId         Cliente

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso     Descripcion
    Adrianavg   02/10/2023  OSF-1658 Se añade csbMetodo, 
                                     se reemplaza variable sbXmlSolRep por sbXmlSol
                                     se ajusta Inicio y fin del UT_TRACE    
  ***************************************************************************/

FUNCTION getSolicitudReparacionRp(inuMedioRecepcionId  IN mo_packages.reception_type_id%type,
                                 isbComentario        IN mo_packages.comment_%type,
                                 inuProductoId        IN mo_motive.product_id%type,
                                 inuClienteId         IN suscripc.suscclie%type)
    RETURN constants_per.tipo_xml_sol%type IS
    csbMetodo CONSTANT VARCHAR(60) := sbPkgName||'.GETSOLICITUDREPARACIONRP';
    
      nuContrato    suscripc.susccodi%type;
      sbDireccion   ge_subscriber.address%type;
      nuDireccion   ge_subscriber.address_id%type;
      nuLocalidad   ge_geogra_location.geograp_location_id%type;
      nuCategory    pr_product.category_id%type;
      nuSubcategory pr_product.subcategory_id%type; 
      nuCliente     suscripc.suscclie%type;

      CURSOR cuDatos IS
       Select Su.Susccodi,
              Ab.Address_Parsed,
              Ab.Address_Id,
              Ab.Geograp_Location_Id,
              Pr.Category_Id,
              Pr.Subcategory_Id,
              Su.Suscclie
         From Suscripc Su,
              Pr_Product Pr,
              Ab_Address Ab
        Where Pr.Subscription_Id = Su.Susccodi
          And Pr.Address_Id = Ab.Address_Id
          And Pr.Product_Id  = inuProductoId;

  BEGIN
	pkg_traza.trace(csbMetodo,cnuNVLTRC,csbInicio);

    pkg_traza.trace('inuProductoId: ' || inuProductoId , cnuNVLTRC);

    OPEN cuDatos;
    FETCH cuDatos
      INTO nuContrato,sbDireccion,nuDireccion,nuLocalidad,nuCategory,nuSubcategory,nuCliente;
    CLOSE cuDatos;

    sbXmlSol :=
    '<?xml version="1.0" encoding="ISO-8859-1"?>
                            <P_SOLICITUD_REPARACION_PRP_100294 ID_TIPOPAQUETE="100294">
                            <RECEPTION_TYPE_ID>'||inuMedioRecepcionId||'</RECEPTION_TYPE_ID>
                            <COMMENT_>'||isbComentario||'</COMMENT_>
                            <IDENTIFICADOR_DEL_CLIENTE>'||nvl(inuClienteId,nuCliente)||'</IDENTIFICADOR_DEL_CLIENTE>
                            <M_MOTIVO_SOLICITUD_REPARACION_PRP_100289>
                            <CONTRATO>'||nuContrato||'</CONTRATO>
                            <PRODUCT>'||inuProductoId||'</PRODUCT>
                            <ADDRESS>'||sbDireccion||'</ADDRESS>
                            <PARSER_ADDRESS_ID>'||nuDireccion||'</PARSER_ADDRESS_ID>
                            <GEOGRAP_LOCATION_ID>'||nuLocalidad||'</GEOGRAP_LOCATION_ID>
                            <CATEGORY_ID>'||nuCategory||'</CATEGORY_ID>
                            <SUBCATEGORY_ID>'||nuSubcategory||'</SUBCATEGORY_ID>
                            <C_GAS_10351><C_MEDICION_10352 /></C_GAS_10351>
                            </M_MOTIVO_SOLICITUD_REPARACION_PRP_100289>
                            </P_SOLICITUD_REPARACION_PRP_100294>';

	pkg_traza.trace(csbMetodo,cnuNVLTRC,pkg_traza.csbFIN);
    return sbXmlSol;    
  EXCEPTION
    WHEN PKG_ERROR.CONTROLLED_ERROR THEN
	pkg_traza.trace(csbMetodo,cnuNVLTRC,pkg_traza.csbFIN_ERC);
	raise PKG_ERROR.CONTROLLED_ERROR;
    WHEN others THEN
		pkg_traza.trace(csbMetodo,cnuNVLTRC,pkg_traza.csbFIN_ERR);
		Pkg_Error.seterror;
		raise PKG_ERROR.CONTROLLED_ERROR;
  END getSolicitudReparacionRp;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : getXMSolicitudCertificacionRp
    Descripcion     : Armar XML para solicitud de certificacion de revision periodica
    Autor           : Jhon Soto
    Fecha           : 13-09-2023

    Parametros de Entrada
    inuMedioRecepcionId  Medio de recepcion
    isbComentario        Comentario
    inuProductoId        Producto
    inuClienteId         Cliente

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso     Descripcion
    Adrianavg   02/10/2023  OSF-1658 Se añade csbMetodo, 
                                     se reemplaza variable sbXmlSolCer por sbXmlSol
                                     se ajusta Inicio y fin del UT_TRACE       
  ***************************************************************************/

FUNCTION getXMSolicitudCertificacionRp (inuMedioRecepcionId  IN mo_packages.reception_type_id%type,
                                        isbComentario        IN mo_packages.comment_%type,
                                        inuProductoId        IN mo_motive.product_id%type,
                                        inuClienteId         IN suscripc.suscclie%type)
    RETURN constants_per.tipo_xml_sol%type IS
    csbMetodo CONSTANT VARCHAR(60) := sbPkgName||'.GETXMSOLICITUDCERTIFICACIONRP';
    
      nuContrato    suscripc.susccodi%type;
      sbDireccion   ge_subscriber.address%type;
      nuDireccion   ge_subscriber.address_id%type;
      nuLocalidad   ge_geogra_location.geograp_location_id%type;
      nuCategory    pr_product.category_id%type;
      nuSubcategory pr_product.subcategory_id%type;
      nuCliente     suscripc.suscclie%type;

      CURSOR cuDatos IS
       Select Su.Susccodi,
              Ab.Address_Parsed,
              Ab.Address_Id,
              Ab.Geograp_Location_Id,
              Pr.Category_Id,
              Pr.Subcategory_Id,
              Su.Suscclie
         From Suscripc Su,
              Pr_Product Pr,
              Ab_Address Ab
        Where Pr.Subscription_Id = Su.Susccodi
          And Pr.Address_Id = Ab.Address_Id
          And Pr.Product_Id  = inuProductoId;

  BEGIN
	pkg_traza.trace(csbMetodo,cnuNVLTRC,csbInicio);

    pkg_traza.trace('inuProductoId: ' || inuProductoId , cnuNVLTRC);

    OPEN cuDatos;
    FETCH cuDatos
      INTO nuContrato,sbDireccion,nuDireccion,nuLocalidad,nuCategory,nuSubcategory,nuCliente;
    CLOSE cuDatos;

    sbXmlSol :=
    '<?xml version="1.0" encoding="ISO-8859-1"?>
                             <P_GENERACION_SOLICITUD_DE_CERTIFICACION_PRP_100295 ID_TIPOPAQUETE="100295">
                             <RECEPTION_TYPE_ID>'||inuMedioRecepcionId||'</RECEPTION_TYPE_ID>
                             <COMMENT_>'||isbComentario||'</COMMENT_>
                             <IDENTIFICADOR_DEL_CLIENTE>'||nvl(inuClienteId,nuCliente)||'</IDENTIFICADOR_DEL_CLIENTE>
                             <M_MOTIVO_GENERACION_SOLICITUD_DE_CERTIFICACION_PRP_100290>
                             <CONTRATO>'||nuContrato||'</CONTRATO>
                             <PRODUCT>'||inuProductoId||'</PRODUCT>
                             <ADDRESS>'||sbDireccion ||'</ADDRESS>
                             <PARSER_ADDRESS_ID>'||nuDireccion||'</PARSER_ADDRESS_ID>
                             <GEOGRAP_LOCATION_ID>'||nuLocalidad||'</GEOGRAP_LOCATION_ID>
                             <CATEGORY_ID>'||nuCategory||'</CATEGORY_ID>
                             <SUBCATEGORY_ID>'||nuSubcategory||'</SUBCATEGORY_ID>
                             </M_MOTIVO_GENERACION_SOLICITUD_DE_CERTIFICACION_PRP_100290>
                             </P_GENERACION_SOLICITUD_DE_CERTIFICACION_PRP_100295>';

	pkg_traza.trace(csbMetodo,cnuNVLTRC,pkg_traza.csbFIN);
    return sbXmlSol;    
  EXCEPTION
    WHEN PKG_ERROR.CONTROLLED_ERROR THEN
		pkg_traza.trace(csbMetodo,cnuNVLTRC,pkg_traza.csbFIN_ERC);
		raise PKG_ERROR.CONTROLLED_ERROR;
    WHEN others THEN
		pkg_traza.trace(csbMetodo,cnuNVLTRC,pkg_traza.csbFIN_ERR);
		Pkg_Error.seterror;
		raise PKG_ERROR.CONTROLLED_ERROR;
  END getXMSolicitudCertificacionRp;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : getXMSolicitudReconexionRp
    Descripcion     : Armar XML para solicitud de reconexion de revision periodica
    Autor           : Jhon Soto
    Fecha           : 13-09-2023

    Parametros de Entrada
    inuMedioRecepcionId  Medio de recepcion
    isbComentario        Comentario
    inuProductoId        Producto
    inuClienteId         Cliente

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso     Descripcion
    Adrianavg   02/10/2023  OSF-1658 Se añade csbMetodo, 
                                     se reemplaza variable sbXmlSolRec por sbXmlSol
                                     se ajusta Inicio y fin del UT_TRACE      
  ***************************************************************************/

FUNCTION getXMSolicitudReconexionRp  (inuMedioRecepcionId  IN mo_packages.reception_type_id%type,
                                      isbComentario        IN mo_packages.comment_%type,
                                      inuProductoId        IN mo_motive.product_id%type,
                                      inuClienteId         IN suscripc.suscclie%type,
                                      inuTipoSuspensionId  IN NUMBER)
    RETURN constants_per.tipo_xml_sol%type IS
    csbMetodo CONSTANT VARCHAR(60) := sbPkgName||'.GETXMSOLICITUDRECONEXIONRP';

      nuContrato    suscripc.susccodi%type;
      sbDireccion   ge_subscriber.address%type;
      nuDireccion   ge_subscriber.address_id%type;
      nuLocalidad   ge_geogra_location.geograp_location_id%type;
      nuCategory    pr_product.category_id%type;
      nuSubcategory pr_product.subcategory_id%type; 
      nuCliente     suscripc.suscclie%type;

      CURSOR cuDatos IS
       Select Su.Susccodi,
              Ab.Address_Parsed,
              Ab.Address_Id,
              Ab.Geograp_Location_Id,
              Pr.Category_Id,
              Pr.Subcategory_Id,
              Su.Suscclie
         From Suscripc Su,
              Pr_Product Pr,
              Ab_Address Ab
        Where Pr.Subscription_Id = Su.Susccodi
          And Pr.Address_Id = Ab.Address_Id
          And Pr.Product_Id  = inuProductoId;

  BEGIN
	pkg_traza.trace(csbMetodo,cnuNVLTRC,csbInicio);

    pkg_traza.trace('inuProductoId: ' || inuProductoId , cnuNVLTRC);

    OPEN cuDatos;
    FETCH cuDatos
      INTO nuContrato,sbDireccion,nuDireccion,nuLocalidad,nuCategory,nuSubcategory,nuCliente;
    CLOSE cuDatos;

    sbXmlSol :=
    '<?xml version="1.0" encoding="ISO-8859-1"?>
                          <P_SOLICITUD_DE_RECONEXION_SIN_CERTIFICACION_100321 ID_TIPOPAQUETE="100321">
                          <RECEPTION_TYPE_ID>'||inuMedioRecepcionId||'</RECEPTION_TYPE_ID>
                          <CONTACT_ID>'||nvl(inuClienteId,nuCliente)||'</CONTACT_ID>
                          <COMMENT_>'||isbComentario||'</COMMENT_>
                          <TIPO_DE_SUSPENSION>'||inuTipoSuspensionId||'</TIPO_DE_SUSPENSION>
                           <M_MOTIVO_DE_RECONEXION_SIN_CERTIFICACION_100304>
                            <CONTRATO>'||nuContrato||'</CONTRATO>
                            <PRODUCTO>'||inuProductoId||'</PRODUCTO>
                            <ADDRESS>'||sbDireccion||'</ADDRESS>
                            <PARSER_ADDRESS_ID>'||nudireccion||'</PARSER_ADDRESS_ID>
                            <GEOGRAP_LOCATION_ID>'||nulocalidad||'</GEOGRAP_LOCATION_ID>
                            <CATEGORY_ID>'||nuCategory||'</CATEGORY_ID>
                            <SUBCATEGORY_ID>'||nuSubcategory||'</SUBCATEGORY_ID>
                             <C_GAS_10346>
                              <C_MEDICION_10348/>
                             </C_GAS_10346>
                           </M_MOTIVO_DE_RECONEXION_SIN_CERTIFICACION_100304>
                          </P_SOLICITUD_DE_RECONEXION_SIN_CERTIFICACION_100321>';

	pkg_traza.trace(csbMetodo,cnuNVLTRC,pkg_traza.csbFIN);
    return sbXmlSol;    
  EXCEPTION
    WHEN PKG_ERROR.CONTROLLED_ERROR THEN
		pkg_traza.trace(csbMetodo,cnuNVLTRC,pkg_traza.csbFIN_ERC);
		raise PKG_ERROR.CONTROLLED_ERROR;
    WHEN others THEN
		pkg_traza.trace(csbMetodo,cnuNVLTRC,pkg_traza.csbFIN_ERR);
		Pkg_Error.seterror;
		raise PKG_ERROR.CONTROLLED_ERROR;
  END getXMSolicitudReconexionRp;


  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : getSolicitudSACRp
    Descripcion     : Armar XML para solicitud de revision periodica SAC
    Autor           : Jhon Soto
    Fecha           : 13-09-2023

    Parametros de Entrada
    inuMedioRecepcionId  Medio de recepcion
    isbComentario        Comentario
    inuProductoId        Producto
    inuClienteId         Cliente
    idtFechaSolicitud    Fecha de Solicitud
    inuActividadId       Código de la actividad a generar
    inuOrdenId           Código de la orden a la cual se relacionara la solicitud SAC

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso     Descripcion
    Adrianavg   02/10/2023  OSF-1658 Se añade csbMetodo, 
                                     se reemplaza variable sbXmlSolRevSac por sbXmlSol
                                     se ajusta Inicio y fin del UT_TRACE    
  ***************************************************************************/

FUNCTION getSolicitudSACRp  (inuMedioRecepcionId  IN mo_packages.reception_type_id%type,
                                      isbComentario        IN mo_packages.comment_%type,
                                      inuProductoId        IN mo_motive.product_id%type,
                                      inuClienteId         IN suscripc.suscclie%type,
                                      idtFechaSolicitud    IN mo_packages.request_date%type,
                                      inuActividadId       IN or_order_activity.activity_id%type,
                                      inuOrdenId           IN or_order_activity.order_id%type)
    RETURN constants_per.tipo_xml_sol%type IS
    csbMetodo CONSTANT VARCHAR(60) := sbPkgName||'.GETSOLICITUDSACRP'; 

      nuContrato        suscripc.susccodi%type;
      sbDireccion       ge_subscriber.address%type;
      nuDireccion       ge_subscriber.address_id%type;
      nuLocalidad       ge_geogra_location.geograp_location_id%type;
      nuCategory        pr_product.category_id%type;
      nuSubcategory     pr_product.subcategory_id%type; 
      nuCliente         suscripc.suscclie%type;
      nuPersonaId       ge_person.person_id%type;
      nuPtoAtncndsol    or_operating_unit.operating_unit_id%type;
        
      CURSOR cuDatos IS
       Select Su.Susccodi,
              Ab.Address_Parsed,
              Ab.Address_Id,
              Ab.Geograp_Location_Id,
              Pr.Category_Id,
              Pr.Subcategory_Id,
              Su.Suscclie
         From Suscripc Su,
              Pr_Product Pr,
              Ab_Address Ab
        Where Pr.Subscription_Id = Su.Susccodi
          And Pr.Address_Id = Ab.Address_Id
          And Pr.Product_Id  = inuProductoId;

  BEGIN

	pkg_traza.trace(csbMetodo,cnuNVLTRC,csbInicio);
    pkg_traza.trace('inuProductoId: ' || inuProductoId , cnuNVLTRC);
    nuPersonaId    := pkg_bopersonal.fnugetpersonaid();
    nuPtoAtncndsol := pkg_bopersonal.fnuGetPuntoAtencionId(nuPersonaId);

    OPEN cuDatos;
    FETCH cuDatos
      INTO nuContrato,sbDireccion,nuDireccion,nuLocalidad,nuCategory,nuSubcategory,nuCliente;
    CLOSE cuDatos;

    sbXmlSol :=
    '<?xml version="1.0" encoding="ISO-8859-1"?>
                         <P_SOLICITUD_SAC_REVISION_PERIODICA_100306 ID_TIPOPAQUETE="100306">
                         <FECHA_DE_SOLICITUD>'||nvl(idtFechaSolicitud,sysdate)||'</FECHA_DE_SOLICITUD>
                         <ID>'||nuPersonaId||'</ID >
                         <POS_OPER_UNIT_ID>'||nuPtoAtncndsol||'</POS_OPER_UNIT_ID >
                         <RECEPTION_TYPE_ID>'||inuMedioRecepcionId||'</RECEPTION_TYPE_ID>
                         <IDENTIFICADOR_DEL_CLIENTE>'||inuClienteId||'</IDENTIFICADOR_DEL_CLIENTE>
                         <CONTACT_ID>'||nvl(inuClienteId,nuCliente)||'</CONTACT_ID>
                         <ADDRESS_ID>'||nuDireccion||'</ADDRESS_ID>
                         <COMMENT_>'||isbComentario||'</COMMENT_>
                         <M_ACTIVIDAD_PARA_SOLICITUD_SAC_REVISION_PERIODICA_100310>
                         <SUBSCRIPTION_ID>'|| nuContrato||'</SUBSCRIPTION_ID>
                         <ITEM_ID>'||inuActividadId||'</ITEM_ID>
                         <PRODUCT_ID>'||inuProductoId||'</PRODUCT_ID>
                         <DIRECCI_N_DE_EJECUCI_N_DE_TRABAJOS>'||nuDireccion||'</DIRECCI_N_DE_EJECUCI_N_DE_TRABAJOS>
                         <ORDEN_REV_PERIODICA>'|| inuOrdenId||'</ORDEN_REV_PERIODICA>
                         </M_ACTIVIDAD_PARA_SOLICITUD_SAC_REVISION_PERIODICA_100310>
                         </P_SOLICITUD_SAC_REVISION_PERIODICA_100306>';

	pkg_traza.trace(csbMetodo,cnuNVLTRC,pkg_traza.csbFIN);
    return sbXmlSol;    
  EXCEPTION
    WHEN PKG_ERROR.CONTROLLED_ERROR THEN
		pkg_traza.trace(csbMetodo,cnuNVLTRC,pkg_traza.csbFIN_ERC);
		raise PKG_ERROR.CONTROLLED_ERROR;
    WHEN others THEN
		pkg_traza.trace(csbMetodo,cnuNVLTRC,pkg_traza.csbFIN_ERR);
		Pkg_Error.seterror;
		raise PKG_ERROR.CONTROLLED_ERROR;
  END getSolicitudSACRp;


  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : getSolicitudVerificacionRp
    Descripcion     : Armar XML para solicitud de verificación revision periodica
    Autor           : Jhon Soto
    Fecha           : 13-09-2023

    Parametros de Entrada
    inuMedioRecepcionId  Medio de recepcion
    isbComentario        Comentario
    inuProductoId        Producto
    inuClienteId         Cliente

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso     Descripcion
    Adrianavg   02/10/2023  OSF-1658 Se añade csbMetodo, 
                                     se reemplaza variable sbXmlSolVer por sbXmlSol
                                     se ajusta Inicio y fin del UT_TRACE
  ***************************************************************************/

FUNCTION getSolicitudVerificacionRp  (inuMedioRecepcionId  IN mo_packages.reception_type_id%type,
                                      isbComentario        IN mo_packages.comment_%type,
                                      inuProductoId        IN mo_motive.product_id%type,
                                      inuClienteId         IN suscripc.suscclie%type)
    RETURN constants_per.tipo_xml_sol%type IS
    csbMetodo CONSTANT VARCHAR(60) := sbPkgName||'.GETSOLICITUDVERIFICACIONRP'; 

      nuContrato    suscripc.susccodi%type;
      sbDireccion   ge_subscriber.address%type;
      nuDireccion   ge_subscriber.address_id%type;
      nuLocalidad   ge_geogra_location.geograp_location_id%type;
      nuCategory    pr_product.category_id%type;
      nuSubcategory pr_product.subcategory_id%type;
      nuCliente     suscripc.suscclie%type;

      CURSOR cuDatos IS
       Select Su.Susccodi,
              Ab.Address_Parsed,
              Ab.Address_Id,
              Ab.Geograp_Location_Id,
              Pr.Category_Id,
              Pr.Subcategory_Id,
              Su.Suscclie
         From Suscripc Su,
              Pr_Product Pr,
              Ab_Address Ab
        Where Pr.Subscription_Id = Su.Susccodi
          And Pr.Address_Id = Ab.Address_Id
          And Pr.Product_Id  = inuProductoId;

  BEGIN 
	pkg_traza.trace(csbMetodo,cnuNVLTRC,csbInicio);
    pkg_traza.trace('inuProductoId: ' || inuProductoId , cnuNVLTRC);


    OPEN cuDatos;
    FETCH cuDatos
      INTO nuContrato,sbDireccion,nuDireccion,nuLocalidad,nuCategory,nuSubcategory,nuCliente;
    CLOSE cuDatos;

    sbXmlSol :=
    '<?xml version="1.0" encoding="ISO-8859-1"?>
                        <P_VERIFICACION_SOLICITUD_SAC_RP_100355 ID_TIPOPAQUETE="100355">
                        <RECEPTION_TYPE_ID>'||inuMedioRecepcionId||'</RECEPTION_TYPE_ID>
                        <CONTACT_ID>'||nvl(inuClienteId,nuCliente)||'</CONTACT_ID>
                        <ADDRESS_ID>'||nuDireccion||'</ADDRESS_ID>
                        <COMMENT_>'||isbComentario||'</COMMENT_>
                        <CONTRACT>'||nuContrato||'</CONTRACT>
                        <M_MOTIVO_VERIFICACION_SOLICITUD_SAC_RP_100321>
                        <PRODUCT_ID>'||inuProductoId||'</PRODUCT_ID>
                        </M_MOTIVO_VERIFICACION_SOLICITUD_SAC_RP_100321>
                        </P_VERIFICACION_SOLICITUD_SAC_RP_100355>';

	pkg_traza.trace(csbMetodo,cnuNVLTRC,pkg_traza.csbFIN);
    return sbXmlSol;
  EXCEPTION
    WHEN PKG_ERROR.CONTROLLED_ERROR THEN
		pkg_traza.trace(csbMetodo,cnuNVLTRC,pkg_traza.csbFIN_ERC);
		raise PKG_ERROR.CONTROLLED_ERROR;
    WHEN others THEN
		pkg_traza.trace(csbMetodo,cnuNVLTRC,pkg_traza.csbFIN_ERR);
		Pkg_Error.seterror;
		raise PKG_ERROR.CONTROLLED_ERROR;
  END getSolicitudVerificacionRp;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : getSuspensionAdministrativa
    Descripcion     : Armar XML para el tipo de solicitud 100156 - Suspensión Administrativa por XML
    Autor           : Adriana Vargas - MVM
    Fecha           : 02-10-2023

    Parametros de Entrada
    inuMedioRecepcionId Código del medio de recepción.
    inuContactoId       Código del Contacto
    inuDireccionId      Dirección
    isbComentario       Observación de registro de la solicitud
    inuProducto         Código del Producto
    idtFechaSuspension  Fecha de Suspension
    inuTipoSuspension   Código del Tipo de Suspensión
    inuTipoCausal       Código del Tipo de Causal
    inuCausal           Codigo de la Causal

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso     Descripcion
    Adrianavg   02-10-2023  OSF-1658 Creación    
  ***************************************************************************/

FUNCTION getSuspensionAdministrativa(inuMedioRecepcionId IN mo_packages.reception_type_id%type,
                                     inuContactoId IN mo_packages.contact_id%type,
                                     inuDireccionId IN ab_address.address_id%type,
                                     isbComentario IN mo_packages.comment_%type,
                                     inuProducto IN servsusc.sesunuse%type,
                                     idtFechaSuspension IN pr_prod_suspension.aplication_date%type,
                                     inuTipoSuspension IN ge_suspension_type.suspension_type_id%type,
                                     inuTipoCausal IN ge_causal.causal_type_id%type,
                                     inuCausal IN ge_causal.causal_id%type)
    RETURN constants_per.tipo_xml_sol%type
IS
    csbMetodo CONSTANT VARCHAR(60) := sbPkgName||'.GETSUSPENSIONADMINISTRATIVA';
    BEGIN

	pkg_traza.trace(csbMetodo,cnuNVLTRC,csbInicio);

        pkg_traza.trace(csbMetodo||
                        ' inuMedioRecepcionId: '||inuMedioRecepcionId||' '||
                        ' inuContactoId: '||inuContactoId||' '||
                        ' inuDireccionId: '||inuDireccionId||' '||
                        ' isbComentario: '||isbComentario||' '||
                        ' inuProducto: '||inuProducto||' '||
                        ' idtFechaSuspension: '||idtFechaSuspension||' '|| 
                        ' inuTipoSuspension: '||inuTipoSuspension||' '||
                        ' inuTipoCausal: '||inuTipoCausal||' '||
                        ' inuCausal: '||inuCausal,cnuNVLTRC);
                        
        sbXmlSol :=
        '<?xml version="1.0" encoding="ISO-8859-1"?>
        <P_LBC_SUSPENSION_ADMINISTRATIVA_POR_XML_100156 ID_TIPOPAQUETE="100156">
           <RECEPTION_TYPE_ID>'  ||inuMedioRecepcionId                 ||'</RECEPTION_TYPE_ID>
           <CONTACT_ID>'         ||inuContactoId         ||'</CONTACT_ID>
           <ADDRESS_ID>'         ||inuDireccionId      ||'</ADDRESS_ID>
           <COMMENT_>'           ||isbComentario   ||'</COMMENT_>
           <PRODUCT>'            ||inuProducto       ||'</PRODUCT>
           <FECHA_DE_SUSPENSION>'||idtFechaSuspension               ||'</FECHA_DE_SUSPENSION>
           <TIPO_DE_SUSPENSION>' ||inuTipoSuspension ||'</TIPO_DE_SUSPENSION>
           <TIPO_DE_CAUSAL>'     ||inuTipoCausal||'</TIPO_DE_CAUSAL>
           <CAUSAL_ID>'          ||inuCausal         ||'</CAUSAL_ID>
        </P_LBC_SUSPENSION_ADMINISTRATIVA_POR_XML_100156>';
    
		pkg_traza.trace(csbMetodo,cnuNVLTRC,pkg_traza.csbFIN);
        return sbXmlSol;
    EXCEPTION
    WHEN PKG_ERROR.CONTROLLED_ERROR THEN
		pkg_traza.trace(csbMetodo,cnuNVLTRC,pkg_traza.csbFIN_ERC);
        raise PKG_ERROR.CONTROLLED_ERROR;
    WHEN others THEN
       	pkg_traza.trace(csbMetodo,cnuNVLTRC,pkg_traza.csbFIN_ERR);
        Pkg_Error.seterror;
        raise PKG_ERROR.CONTROLLED_ERROR;
    END;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : getNotiSuspension
    Descripcion     : Armar XML para armar el xml del tipo de solicitud 100246 - Notificacion Suspension por Ausencia de Certificado
    Autor           : Adriana Vargas - MVM
    Fecha           : 02-10-2023

    Parametros de Entrada
    inuMedioRecepcionId     Código del medio de recepción.
    isbComentario           Observación de registro de la solicitud
    inuCliente              Cliente 
    inuProducto             Código del Producto
    inuContrato             Código del Contrato
    inuDireccion            Dirección Parseada
    inuDireccionId          Dirección
    inuUbicacionGeografica  Ubicación Geográfica (Localidad)
    inuCategoria            Categoría
    inuSubcategoria         Subcategoria


    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso     Descripcion
    Adrianavg   02-10-2023  OSF-1658 Creación    
  ***************************************************************************/
  
FUNCTION getNotiSuspension(inuMedioRecepcionId IN mo_packages.reception_type_id%type,
                           isbComentario IN mo_packages.comment_%type,
                           inuCliente IN ge_subscriber.subscriber_id%type,
                           inuProducto IN servsusc.sesunuse%type,
                           inuContrato IN suscripc.susccodi%type,
                           inuDireccion IN ab_address.address_parsed%type,
                           inuDireccionId IN ab_address.address_id%type,
                           inuUbicacionGeografica IN ge_geogra_location.geograp_location_id%type,
                           inuCategoria IN servsusc.sesucate%type,
                           inuSubcategoria IN servsusc.sesusuca%type)
    RETURN constants_per.tipo_xml_sol%type
IS
    csbMetodo CONSTANT VARCHAR(60) := sbPkgName||'.GETNOTISUSPENSION';
    BEGIN

		pkg_traza.trace(csbMetodo,cnuNVLTRC,csbInicio);

        pkg_traza.trace(csbMetodo||
                        ' inuMedioRecepcionId: '||inuMedioRecepcionId||' '||
                        ' isbComentario: '||isbComentario||' '||
                        ' inuCliente: '||inuCliente||' '|| 
                        ' inuProducto: '||inuProducto||' '||
                        ' inuContrato: '||inuContrato||' '||
                        ' inuDireccion: '||inuDireccion||' '||
                        ' inuDireccionId: '||inuDireccionId||' '||
                        ' inuUbicacionGeografica: '||inuUbicacionGeografica||' '||
                        ' inuCategoria: '||inuCategoria||' '||
                        ' inuSubcategoria: '||inuSubcategoria,10);
                        
        sbXmlSol :=
        '<?xml version="1.0" encoding="ISO-8859-1"?>
        <P_NOTIFICACION_SUSPENSION_X_AUSENCIA_DE_CERTIFICADO_100246 ID_TIPOPAQUETE="100246">
            <RECEPTION_TYPE_ID>'||inuMedioRecepcionId||'</RECEPTION_TYPE_ID>
            <COMMENT_>'||isbComentario||'</COMMENT_>
            <IDENTIFICADOR_DEL_CLIENTE>'|| inuCliente|| '</IDENTIFICADOR_DEL_CLIENTE>
            <PRODUCT>'|| inuProducto|| '</PRODUCT>
            <M_NOTIFICACION_SUSPENSION_X_AUSENCIA_DE_CERTIFICADO_100248>
                <PRODUCT_ID>'|| inuProducto|| '</PRODUCT_ID>
                <SUBSCRIPTION_ID>'|| inuContrato|| '</SUBSCRIPTION_ID>
                <ADDRESS>'|| inuDireccion|| '</ADDRESS>
                <PARSER_ADDRESS_ID>'|| inuDireccionId|| '</PARSER_ADDRESS_ID>
                <GEOGRAP_LOCATION_ID>'|| inuUbicacionGeografica|| '</GEOGRAP_LOCATION_ID>
                <CATEGORY_ID>'|| inuCategoria|| '</CATEGORY_ID>
                <SUBCATEGORY_ID>'|| inuSubcategoria|| '</SUBCATEGORY_ID>
            </M_NOTIFICACION_SUSPENSION_X_AUSENCIA_DE_CERTIFICADO_100248>
        </P_NOTIFICACION_SUSPENSION_X_AUSENCIA_DE_CERTIFICADO_100246>';
    
		pkg_traza.trace(csbMetodo,cnuNVLTRC,pkg_traza.csbFIN);
        return sbXmlSol;
    EXCEPTION
    WHEN PKG_ERROR.CONTROLLED_ERROR THEN
		pkg_traza.trace(csbMetodo,cnuNVLTRC,pkg_traza.csbFIN_ERC);
        raise PKG_ERROR.CONTROLLED_ERROR;
    WHEN others THEN
		pkg_traza.trace(csbMetodo,cnuNVLTRC,pkg_traza.csbFIN_ERR);
        Pkg_Error.seterror;
        raise PKG_ERROR.CONTROLLED_ERROR;
    END;    
        
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : getCambioEstado
    Descripcion     : Armar XML para armar el xml del tipo de solicitud 100287 - LDC - Cambio de Estado Producto
    Autor           : Adriana Vargas - MVM
    Fecha           : 02-10-2023

    Parametros de Entrada
    idtFechaSolicitud   Fecha de registro de la solicitud
    inuContactoId       Contacto
    inuDireccionId      Dirección
    isbComentario       Observación de registro de la solicitud
    inuProducto         Código del Producto
    inuContrato         Código del Contrato

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso     Descripcion
    Adrianavg   02-10-2023  OSF-1658 Creación
  ***************************************************************************/    
FUNCTION getCambioEstado(idtFechaSolicitud IN mo_packages.request_date%type,
                         inuContactoId IN mo_packages.contact_id%type,
                         inuDireccionId IN ab_address.address_id%type,
                         isbComentario IN mo_packages.comment_%type,
                         inuProducto IN servsusc.sesunuse%type,
                         inuContrato IN suscripc.susccodi%type)
    RETURN constants_per.tipo_xml_sol%type
IS
    csbMetodo CONSTANT VARCHAR(60) := sbPkgName||'.GETCAMBIOESTADO';
    BEGIN
 		pkg_traza.trace(csbMetodo,cnuNVLTRC,csbInicio);

		pkg_traza.trace(csbMetodo||
                        ' idtFechaSolicitud: '||idtFechaSolicitud||' '||
                        ' inuContactoId: '||inuContactoId||' '||
                        ' inuDireccionId: '||inuDireccionId||' '||
                        ' isbComentario: '||isbComentario||' '||
                        ' inuProducto: '||inuProducto||' '||
                        ' inuContrato: '||inuContrato,10);
                        
        sbXmlSol :=
        '<?xml version="1.0" encoding="ISO-8859-1"?>
        <P_LDC_CAMBIO_DE_ESTADO_100287 ID_TIPOPAQUETE="100287">
          <FECHA_SOLICITUD>'||idtFechaSolicitud||'</FECHA_SOLICITUD>
          <CONTACT_ID>'||inuContactoId||'</CONTACT_ID>
          <ADDRESS_ID>'||inuDireccionId||'</ADDRESS_ID>
          <COMMENT_>'||isbComentario||'</COMMENT_>
          <M_CAMBIO_DE_ESTADO_100284>
            <PRODUCTO>'||inuProducto||'</PRODUCTO>
            <CONTRATO>'||inuContrato||'</CONTRATO>
          </M_CAMBIO_DE_ESTADO_100284>
        </P_LDC_CAMBIO_DE_ESTADO_100287>';
    
		pkg_traza.trace(csbMetodo,cnuNVLTRC,pkg_traza.csbFIN);
        return sbXmlSol;
    EXCEPTION
    WHEN PKG_ERROR.CONTROLLED_ERROR THEN
		pkg_traza.trace(csbMetodo,cnuNVLTRC,pkg_traza.csbFIN_ERC);
        raise PKG_ERROR.CONTROLLED_ERROR;
    WHEN others THEN
		pkg_traza.trace(csbMetodo,cnuNVLTRC,pkg_traza.csbFIN_ERR);
        Pkg_Error.seterror;
        raise PKG_ERROR.CONTROLLED_ERROR;
    END;   



/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : getSolicitudVerificacionSACRP
    Descripcion     : Armar XML para armar el xml del tipo de solicitud 100330 Verificacion RP SAC
    Autor           : Jhon Soto
    Fecha           : 30-10-2023

    Parametros de Entrada
    inuMedioRecepcionId Medio de recepcion
    inuContactoId       Contacto
    inuDireccionId      Dirección
    isbComentario       Observación de registro de la solicitud
    inuProducto         Código del Producto
    inuContrato         Código del Contrato
	inuTelefono      	Telefono

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso     Descripcion
    jsoto   	30-10-2023  OSF-1858 Creación
  ***************************************************************************/    
FUNCTION getSolicitudVerificacionSACRP(	
										inuMedioRecepcionId IN mo_packages.reception_type_id%type,
										inuContactoId IN mo_packages.contact_id%type,
										inuDireccionId IN ab_address.address_id%type,
										isbComentario IN mo_packages.comment_%type,
										inuProducto IN servsusc.sesunuse%type,
										inuContrato IN suscripc.susccodi%type,
										inuTelefono IN ge_subscriber.phone%type)
    RETURN constants_per.tipo_xml_sol%type
IS
    csbMetodo CONSTANT VARCHAR(60) := sbPkgName||'.getSolicitudVerificacionSACRP';
    BEGIN
 		pkg_traza.trace(csbMetodo,cnuNVLTRC,csbInicio);

        pkg_traza.trace(csbMetodo||
						' inuMedioRecepcionId: '||inuMedioRecepcionId||' '||
                        ' inuContactoId: '||inuContactoId||' '||
                        ' inuDireccionId: '||inuDireccionId||' '||
                        ' isbComentario: '||isbComentario||' '||
                        ' inuProducto: '||inuProducto||' '||
                        ' inuTelefono: '||inuTelefono||' '||
                        ' inuContrato: '||inuContrato,10);

                        
        sbXmlSol :=
				'<?xml version="1.0" encoding="ISO-8859-1"?>
				<P_VERIFICACION_SAC_RP_100330 ID_TIPOPAQUETE="100330">
				   <RECEPTION_TYPE_ID>' || inuMedioRecepcionId || '</RECEPTION_TYPE_ID>
				   <CONTACT_ID>' || inuContactoId ||'</CONTACT_ID>
				   <ADDRESS_ID>'||inuDireccionId||'</ADDRESS_ID>
				   <COMMENT_>' || isbComentario ||'</COMMENT_>
				   <M_MOTIVO_VERIFICACION_SAC_RP_100302>
					 <PRODUCTO>' || inuProducto ||'</PRODUCTO>
					 <CONTRATO>' || inuContrato ||'</CONTRATO>
					 <TELEFONO_O_CELULAR>' || inuTelefono ||'</TELEFONO_O_CELULAR>
				   </M_MOTIVO_VERIFICACION_SAC_RP_100302>
				</P_VERIFICACION_SAC_RP_100330>';

		pkg_traza.trace(csbMetodo,cnuNVLTRC,pkg_traza.csbFIN);
        return sbXmlSol;
    EXCEPTION
    WHEN PKG_ERROR.CONTROLLED_ERROR THEN
		pkg_traza.trace(csbMetodo,cnuNVLTRC,pkg_traza.csbFIN_ERC);
        raise PKG_ERROR.CONTROLLED_ERROR;
    WHEN others THEN
		pkg_traza.trace(csbMetodo,cnuNVLTRC,pkg_traza.csbFIN_ERR);
        Pkg_Error.seterror;
        raise PKG_ERROR.CONTROLLED_ERROR;
    END;   


END;
/
PROMPT Otorgando permisos de ejecucion a PKG_XML_SOLI_REV_PERIODICA
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_XML_SOLI_REV_PERIODICA','PERSONALIZACIONES');
END;
/