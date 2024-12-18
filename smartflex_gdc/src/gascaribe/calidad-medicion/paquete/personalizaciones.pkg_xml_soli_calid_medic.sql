create or replace PACKAGE                    personalizaciones.pkg_xml_soli_calid_medic IS

   /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : pkg_xml_soli_calid_medic
        Descripcion     : paquete para gestion de solicitudes de calidad de medicion
        Autor           : Jhon Soto
        Fecha           : 18-09-2023
        Parametros de Entrada

        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso     Descripción
		jsoto	    18/09/2023	OSF-1595 Creacion
    ***************************************************************************/

FUNCTION getSolicitudSuspensionCLM   (inuMedioRecepcionId  IN mo_packages.reception_type_id%type,
                                      isbComentario        IN mo_packages.comment_%type,
                                      inuProductoId        IN mo_motive.product_id%type,
                                      inuClienteId         IN suscripc.suscclie%type,
                                      inuTipoSuspensionId  IN ge_suspension_type.suspension_type_id%type,
                                      inuTipoCausalId      IN ge_causal.causal_type_id%type,
                                      inuCausalId          IN ge_causal.causal_id%type)
                                      RETURN constants_per.tipo_xml_sol%type;

FUNCTION getSolicitudReconexionCLM (inuMedioRecepcionId  IN mo_packages.reception_type_id%type,
                                    isbComentario        IN mo_packages.comment_%type,
                                    inuProductoId        IN mo_motive.product_id%type,
                                    inuClienteId         IN suscripc.suscclie%type,
                                    inuTipoSuspensionId  IN ge_suspension_type.suspension_type_id%type)
                                    RETURN constants_per.tipo_xml_sol%type;


END pkg_xml_soli_calid_medic;
/
create or replace package body                    personalizaciones.pkg_xml_soli_calid_medic IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : getSolicitudSuspensionCLM
    Descripcion     : Armar XML para solicitud de Suspensión Calidad Medición
    Autor           : Jhon Soto
    Fecha           : 18-09-2023

    Parametros de Entrada
                    inuMedioRecepcionId  Medio de recepcion
                    isbComentario        Comentario
                    inuProductoId        Producto
                    inuClienteId         Cliente
                    inuTipoSuspensionId  Código del tipo de suspensión.
                    inuTipoCausalId      Código del tipo de causal
                    inuCausalId          Código de la causal


    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    Descripcion
  ***************************************************************************/
  
    -- Constantes para el control de la traza
    csbSP_NAME 	CONSTANT VARCHAR2(35):= 'pkg_xml_soli_calid_medic.';
    cnuNVLTRC 	CONSTANT NUMBER := pkg_traza.cnuNivelTrzDef;
	csbInicio   CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;


FUNCTION getSolicitudSuspensionCLM(inuMedioRecepcionId  IN mo_packages.reception_type_id%type,
                                   isbComentario        IN mo_packages.comment_%type,
                                   inuProductoId        IN mo_motive.product_id%type,
                                   inuClienteId         IN suscripc.suscclie%type,
                                   inuTipoSuspensionId  IN ge_suspension_type.suspension_type_id%type,
                                   inuTipoCausalId      IN ge_causal.causal_type_id%type,
                                   inuCausalId          IN ge_causal.causal_id%type)
                                   RETURN constants_per.tipo_xml_sol%type IS

      csbMetodo     CONSTANT VARCHAR2(50) := csbSP_NAME||'getSolicitudSuspensionCLM';            
      nuContrato    suscripc.susccodi%type;
      sbDireccion   ge_subscriber.address%type;
      nuDireccion   ge_subscriber.address_id%type;

      nuCliente     suscripc.suscclie%type;
      sbXmlSol      constants_per.tipo_xml_sol%type;

      CURSOR cuDatos IS
       Select Su.Susccodi, 
              Ab.Address_Parsed, 
              Ab.Address_Id, 
              Su.Suscclie
         From Suscripc Su, 
              Pr_Product Pr, 
              Ab_Address Ab
        Where Pr.Subscription_Id = Su.Susccodi 
          And Pr.Address_Id = Ab.Address_Id 
          And Pr.Product_Id  = inuProductoId;

  BEGIN
  
	pkg_traza.trace(csbMetodo,cnuNVLTRC,csbInicio);

    pkg_traza.trace(csbMetodo|| 
                   ' inuProductoId: ' ||inuProductoId||' '||
                   ' inuMedioRecepcionId: '||inuMedioRecepcionId||' '||
                   ' isbComentario: ' ||isbComentario||' '||
                   ' inuClienteId: ' ||inuClienteId||' '||
                   ' inuTipoSuspensionId: ' ||inuTipoSuspensionId||' '||
                   ' inuTipoCausalId: '||inuTipoCausalId||' '||
                   ' inuCausalId: '||inuCausalId,cnuNVLTRC);

   OPEN cuDatos;
    FETCH cuDatos
      INTO nuContrato,sbDireccion,nuDireccion,nuCliente;
    CLOSE cuDatos;

    sbXmlSol :=
    '<?xml version="1.0" encoding="ISO-8859-1"?>
     <P_SUSPENSION_POR_CALIDAD_DE_MEDICION_100328 ID_TIPOPAQUETE="100328">
     <RECEPTION_TYPE_ID>'||inuMedioRecepcionId||'</RECEPTION_TYPE_ID>
     <CONTACT_ID>'||nvl(inuClienteId,nuCliente)||'</CONTACT_ID>
     <ADDRESS_ID>'||nuDireccion||'</ADDRESS_ID>
     <COMMENT_>'||isbComentario||'</COMMENT_>
     <PRODUCT>'||inuProductoId||'</PRODUCT>
     <IDENTIFICADOR_DEL_CLIENTE>'||inuClienteId||'</IDENTIFICADOR_DEL_CLIENTE>
     <TIPO_DE_SUSPENSI_N>'||inuTipoSuspensionId||'</TIPO_DE_SUSPENSI_N>
     <TIPO_DE_CAUSAL>'||inuTipoCausalId||'</TIPO_DE_CAUSAL>
     <CAUSAL_ID>'||inuCausalId||'</CAUSAL_ID>
     </P_SUSPENSION_POR_CALIDAD_DE_MEDICION_100328>';
	 
	 pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN);

    return sbXmlSol;

    
  EXCEPTION
    WHEN PKG_ERROR.CONTROLLED_ERROR THEN
		pkg_traza.trace('PKG_ERROR.CONTROLLED_ERROR '||csbMetodo, cnuNVLTRC);
		pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERC);
		raise PKG_ERROR.CONTROLLED_ERROR;
    WHEN others THEN
		pkg_traza.trace('others ' ||csbMetodo, cnuNVLTRC);
		pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERR);
		Pkg_Error.seterror;
		raise PKG_ERROR.CONTROLLED_ERROR;
  END getSolicitudSuspensionCLM;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : getSolicitudReconexionCLM
    Descripcion     : Armar XML para solicitud de Reconexion Calidad Medición
    Autor           : Jhon Soto
    Fecha           : 18-09-2023

    Parametros de Entrada
                    inuMedioRecepcionId  Medio de recepcion
                    isbComentario        Comentario
                    inuProductoId        Producto
                    inuClienteId         Cliente
                    inuTipoSuspensionId  Código del tipo de suspensión.


    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    Descripcion
  ***************************************************************************/

FUNCTION getSolicitudReconexionCLM (inuMedioRecepcionId  IN mo_packages.reception_type_id%type,
                                   isbComentario        IN mo_packages.comment_%type,
                                   inuProductoId        IN mo_motive.product_id%type,
                                   inuClienteId         IN suscripc.suscclie%type,
                                   inuTipoSuspensionId  IN ge_suspension_type.suspension_type_id%type)
                                   RETURN constants_per.tipo_xml_sol%type IS

      csbMetodo     CONSTANT VARCHAR2(50) := csbSP_NAME||'getSolicitudReconexionCLM';            
      nuContrato    suscripc.susccodi%type;
      sbDireccion   ge_subscriber.address%type;
      nuDireccion   ge_subscriber.address_id%type;

      nuCliente     suscripc.suscclie%type;
      sbXmlSol      constants_per.tipo_xml_sol%type;

      CURSOR cuDatos IS
       Select Su.Susccodi, 
              Ab.Address_Parsed, 
              Ab.Address_Id, 
              Su.Suscclie
         From Suscripc Su, 
              Pr_Product Pr, 
              Ab_Address Ab
        Where Pr.Subscription_Id = Su.Susccodi 
          And Pr.Address_Id = Ab.Address_Id 
          And Pr.Product_Id  = inuProductoId;

  BEGIN
  
	pkg_traza.trace(csbMetodo,cnuNVLTRC,csbInicio);
	
    pkg_traza.trace(csbMetodo|| 
                   ' inuProductoId: ' ||inuProductoId||' '||
                   ' inuMedioRecepcionId: '||inuMedioRecepcionId||' '||
                   ' isbComentario: ' ||isbComentario||' '||
                   ' inuClienteId: ' ||inuClienteId||' '||
                   ' inuTipoSuspensionId: ' ||inuTipoSuspensionId,cnuNVLTRC);

   OPEN cuDatos;
    FETCH cuDatos
      INTO nuContrato,sbDireccion,nuDireccion,nuCliente;
    CLOSE cuDatos;

    sbXmlSol :=
    '<?xml version="1.0" encoding="ISO-8859-1"?>
     <P_RECONEXION_POR_CALIDAD_DE_MEDICION_100331 ID_TIPOPAQUETE="100331">
     <RECEPTION_TYPE_ID>'||inuMedioRecepcionId||'</RECEPTION_TYPE_ID>
     <CONTACT_ID>'||nvl(inuClienteId,nuCliente)||'</CONTACT_ID>
     <ADDRESS_ID>'||nuDireccion||'</ADDRESS_ID>
     <COMMENT_>'||isbComentario||'</COMMENT_>
     <PRODUCT>'||inuProductoId||'</PRODUCT>
     <TIPO_DE_SUSPENSION>'||inuTipoSuspensionId||'</TIPO_DE_SUSPENSION>
     </P_RECONEXION_POR_CALIDAD_DE_MEDICION_100331>';

	pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN);

    return sbXmlSol;


  EXCEPTION
    WHEN PKG_ERROR.CONTROLLED_ERROR THEN
		pkg_traza.trace('PKG_ERROR.CONTROLLED_ERROR '||csbMetodo, cnuNVLTRC);
		pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERC);
		raise PKG_ERROR.CONTROLLED_ERROR;
    WHEN others THEN
		pkg_traza.trace('others ' ||csbMetodo, cnuNVLTRC);
		pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERR);
		Pkg_Error.seterror;
		raise PKG_ERROR.CONTROLLED_ERROR;
  END getSolicitudReconexionCLM;


END;
/
PROMPT Otorgando permisos de ejecución a PKG_XML_SOLI_CALID_MEDIC
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_XML_SOLI_CALID_MEDIC','PERSONALIZACIONES');
END;
/
