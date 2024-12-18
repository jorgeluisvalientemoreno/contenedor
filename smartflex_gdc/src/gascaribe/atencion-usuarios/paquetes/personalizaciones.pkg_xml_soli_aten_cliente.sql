CREATE OR REPLACE PACKAGE personalizaciones.pkg_xml_soli_aten_cliente IS

   /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : pkg_xml_soli_aten_cliente
        Descripcion     : paquete que contiene las funciones que arman los XML del atencion al Cliente de GDC.
        Autor           : Adriana Vargas
        Fecha           : 26-09-2023
        =========================================================
        Autor       Fecha       Caso        Descripcion
        Adrianavg   26-09-2023	OSF-1634    Creacion
		jsoto		16-11-2023  OSF-1799    Corrección del encabezado del xml en todos los método se suprime ||
                                            cambia manejo de trazas por personalizado

        Parametros de Entrada
        Parametros de Salida
    ***************************************************************************/

--
FUNCTION getSolicitudDuplicado( inuMedioRecepcionId IN mo_packages.reception_type_id%type,
                                isbComentario       IN mo_packages.comment_%type,
                                inuClienteId        IN suscripc.suscclie%type,
                                inuRelaSoliPredio   IN NUMBER,
                                inuTipoCausal       IN ge_causal.causal_type_id%type,
                                inuCausal           IN ge_causal.causal_id%type,
                                inuContratoId       IN NUMBER)
                                RETURN constants_per.tipo_xml_sol%type;

FUNCTION getSolicitudInfoGeneral(inuMedioRecepcionId  IN mo_packages.reception_type_id%type,
                                 inuContactoId        IN NUMBER,
                                 inuDireccion         IN ab_address.address_id%type,
                                 isbComentario        IN mo_packages.comment_%type,
                                 inuRelaSoliPredio    IN NUMBER,
                                 inuClaseInfo         IN NUMBER,
                                 inuTipoInfo          IN NUMBER,
                                 inuClienteId         IN NUMBER,
                                 inuContratoId        IN NUMBER)
                                 RETURN constants_per.tipo_xml_sol%type;

FUNCTION getSolicitudDuplicadoKiosco(inuMedioRecepcionId  IN mo_packages.reception_type_id%type,
                                     inuContactoId        IN NUMBER,
                                     isbComentario        IN mo_packages.comment_%type,
                                     inuRelaSoliPredio    IN NUMBER,
                                     inuTipoCausal        IN ge_causal.causal_type_id%type,
                                     inuCausal            IN ge_causal.causal_id%type,
inuContratoId        IN NUMBER,
                                     isbDireccion         IN VARCHAR2,
                                     inuDireccion         IN ab_address.address_id%type,
                                     inuLocalidad         IN NUMBER)
                                     RETURN constants_per.tipo_xml_sol%type;

FUNCTION getSolicitudCuponPortal( inuMedioRecepcionId  IN mo_packages.reception_type_id%type,
                                  isbComentario        IN mo_packages.comment_%type,
                                  inuContratoId        IN NUMBER )
                                  RETURN constants_per.tipo_xml_sol%type;

FUNCTION getSolicitudTrasPresPortal(inuMedioRecepcionId  IN mo_packages.reception_type_id%type,
                                    isbComentario        IN mo_packages.comment_%type,
                                    inuContratoId        IN NUMBER )
                                    RETURN constants_per.tipo_xml_sol%type;
END pkg_xml_soli_aten_cliente;
/


CREATE OR REPLACE PACKAGE body personalizaciones.pkg_xml_soli_aten_cliente IS
--CONSTANTES
sbXmlSol  constants_per.tipo_xml_sol%type;
sbPkgName VARCHAR2(50) := 'PKG_XML_SOLI_ATEN_CLIENTE';
   /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : getSolicitudDuplicado
        Descripcion     : Arma el XML de la solicitud de duplicado 100212
        Autor           : Adriana Vargas
        Fecha           : 26-09-2023
        =========================================================
        Autor       Fecha       Caso        Descripcion
        Adrianavg   26-09-2023	OSF-1634    Creacion

        Parametros de Entrada
        inuMedioRecepcionId     Codigo del medio de recepcion
        isbComentario           Observacion registro de la solicitud
        inuClienteId            Codigo del cliente que realizo la solicitud
        inuRelaSoliPredio       Relacion del solicitante con el predio
        inuTipoCausal           Tipo de causal
        inuCausal               Causal
        inuContrato             Contrato

        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso    Descripcion
    ***************************************************************************/
FUNCTION getSolicitudDuplicado( inuMedioRecepcionId IN mo_packages.reception_type_id%type,
                                isbComentario       IN mo_packages.comment_%type,
                                inuClienteId        IN suscripc.suscclie%type,
                                inuRelaSoliPredio   IN NUMBER,
                                inuTipoCausal       IN ge_causal.causal_type_id%type,
                                inuCausal           IN ge_causal.causal_id%type,
                                inuContratoId         IN NUMBER)
                                RETURN constants_per.tipo_xml_sol%type IS

     csbMetodo CONSTANT VARCHAR(60) := sbPkgName||'.GETSOLICITUDDUPLICADO';
BEGIN

	pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);

    pkg_traza.trace(csbMetodo||
                    ' inuMedioRecepcionId: '||inuMedioRecepcionId||' '||
                    ' isbComentario: '||isbComentario||' '||
                    ' inuClienteId: '||inuClienteId||' '||
                    ' inuRelaSoliPredio: '||inuRelaSoliPredio||' '||
                    ' inuTipoCausal: '||inuTipoCausal||' '||
                    ' inuCausal: '||inuCausal||' '||
                    ' inuContrato: '||inuContratoId ,pkg_traza.cnuNivelTrzDef);

    sbXmlSol :=
        '<?xml version="1.0" encoding="ISO-8859-1"?>
         <P_SOLICITUD_DE_DUPLICADO_100212 ID_TIPOPAQUETE="100212">
         <RECEPTION_TYPE_ID>' ||inuMedioRecepcionId ||'</RECEPTION_TYPE_ID>
         <CONTACT_ID>' ||inuClienteId ||'</CONTACT_ID>
         <COMMENT_>' ||isbComentario ||'</COMMENT_>
         <ROLE_ID>' ||inuRelaSoliPredio ||'</ROLE_ID>
         <TIPO_DE_CAUSA>'||inuTipoCausal||'</TIPO_DE_CAUSA>
         <CAUSAL>'||inuCausal||'</CAUSAL>
         <CONTRACT>' ||inuContratoId ||'</CONTRACT>
         <M_MOTIVO_SOLICITUD_DE_DUPLICADO_100210 />
        </P_SOLICITUD_DE_DUPLICADO_100212>';

	pkg_traza.trace(csbMetodo||' sbXmlSol'||sbXmlSol,pkg_traza.cnuNivelTrzDef);

    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);

    return sbXmlSol;
EXCEPTION
WHEN PKG_ERROR.CONTROLLED_ERROR THEN
    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);
    raise PKG_ERROR.CONTROLLED_ERROR;
WHEN others THEN
    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
    Pkg_Error.seterror;
    raise PKG_ERROR.CONTROLLED_ERROR;
END;

   /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : getSolicitudInfoGeneral
        Descripcion     : Arma el XML de la solicitud de informacion general 100214
        Autor           : Adriana Vargas
        Fecha           : 26-09-2023
        =========================================================
        Autor       Fecha       Caso        Descripcion
        Adrianavg   26-09-2023	OSF-1634    Creacion

        Parametros de Entrada
        Parametro                 Descripcion
        inuMedioRecepcionId       Codigo del medio de recepcion        
        inuContactoId             Codigo del solicitante
        inuDireccion              Direccion respuesta
        isbComentario             Observacion registro de la solicitud
        inuRelaSoliPredio         Relacion del solicitante con el predio
        inuClaseInfo              Clase de informacion       
        inuTipoInfo               Tipo de informacion        
        inuClienteId              Cliente
        inuContratoId             Codigo del contrato

        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso    Descripcion

    ***************************************************************************/
FUNCTION getSolicitudInfoGeneral(inuMedioRecepcionId  IN mo_packages.reception_type_id%type,
                                 inuContactoId        IN NUMBER,
                                 inuDireccion         IN ab_address.address_id%type,
                                 isbComentario        IN mo_packages.comment_%type,
                                 inuRelaSoliPredio    IN NUMBER,
                                 inuClaseInfo         IN NUMBER,
                                 inuTipoInfo          IN NUMBER,
                                 inuClienteId         IN NUMBER,
                                 inuContratoId        IN NUMBER)
                                 RETURN constants_per.tipo_xml_sol%type IS
    csbMetodo CONSTANT VARCHAR(60) := sbPkgName||'.GETSOLICITUDINFOGENERAL';
BEGIN

	pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);
	
    pkg_traza.trace(csbMetodo||
                    ' inuMedioRecepcionId: '||inuMedioRecepcionId||' '||
                    ' inuContactoId: '||inuContactoId||' '||
                    ' inuDireccion: '||inuDireccion||' '||
                    ' isbComentario: '||isbComentario||' '||
                    ' inuRelaSoliPredio: '||inuRelaSoliPredio||' '||
                    ' inuClaseInfo: '||inuClaseInfo||' '||
                    ' inuTipoInfo: '||inuTipoInfo||' '||
                    ' inuClienteId: '||inuClienteId||' '||
                    ' inuContratoId: '||inuContratoId ,pkg_traza.cnuNivelTrzDef);

    sbXmlSol :=
    '<?xml version="1.0" encoding="ISO-8859-1"?>
    <P_SOLICITUD_DE_INFORMACION_GENERAL_100214 ID_TIPOPAQUETE="100214">
    <RECEPTION_TYPE_ID>' || inuMedioRecepcionId || '</RECEPTION_TYPE_ID>
    <CONTACT_ID>' || inuContactoId || '</CONTACT_ID>
    <ADDRESS_ID>'||inuDireccion||'</ADDRESS_ID>
    <COMMENT_>' || isbComentario || '</COMMENT_>
    <ROLE_ID>' ||inuRelaSoliPredio ||'</ROLE_ID>
    <CLASE_DE_INFORMACION>' || inuClaseInfo || '</CLASE_DE_INFORMACION>
    <TIPO_DE_INFORMACION>' || inuTipoInfo || '</TIPO_DE_INFORMACION>
    <CUSTOMER>' || inuClienteId || '</CUSTOMER>
    <CONTRACT>' || inuContratoId || '</CONTRACT>
    <M_MOTIVO_DE_SOLICITUD_DE_INFORMACION_GENERAL_100212/>
    </P_SOLICITUD_DE_INFORMACION_GENERAL_100214>';

	pkg_traza.trace(csbMetodo||' sbXmlSol'||sbXmlSol,pkg_traza.cnuNivelTrzDef);

    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);
    return sbXmlSol;
EXCEPTION
WHEN PKG_ERROR.CONTROLLED_ERROR THEN
    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);
    raise PKG_ERROR.CONTROLLED_ERROR;
WHEN others THEN
    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
    Pkg_Error.seterror;
    raise PKG_ERROR.CONTROLLED_ERROR;

END;

   /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : getSolicitudDuplicadoKiosco
        Descripcion     : Arma el XML de la solicitud de duplicado kiosko 100342
        Autor           : Adriana Vargas
        Fecha           : 26-09-2023
        =========================================================
        Autor       Fecha       Caso        Descripcion
        Adrianavg   26-09-2023	OSF-1634    Creacion

        Parametros de Entrada
        inuMedioRecepcionId     Codigo del medio de recepcion        
        inuContactoId           Codigo del solicitante
        isbComentario           Observacion registro de la solicitud
        inuRelaSoliPredio       Relacion del solicitante con el predio
        inuTipoCausal           Tipo de causal
        inuCausal               Causal
        inuContratoId           Codigo del contrato
        isbDireccion            Direccion parseada del cliente
        inuDireccion            Direccionl cliente
        inuLocalidad            Codigo de la localidad

        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso    Descripcion

    ***************************************************************************/
FUNCTION getSolicitudDuplicadoKiosco(inuMedioRecepcionId  IN mo_packages.reception_type_id%type,
                                     inuContactoId        IN NUMBER,
                                     isbComentario        IN mo_packages.comment_%type,
                                     inuRelaSoliPredio    IN NUMBER,
                                     inuTipoCausal        IN ge_causal.causal_type_id%type,
                                     inuCausal            IN ge_causal.causal_id%type,
                                     inuContratoId        IN NUMBER,
                                     isbDireccion         IN VARCHAR2,
                                     inuDireccion         IN ab_address.address_id%type,
                                     inuLocalidad         IN NUMBER)
                                     RETURN constants_per.tipo_xml_sol%type IS

    csbMetodo CONSTANT VARCHAR(60) := sbPkgName||'.GETSOLICITUDDUPLICADOKIOSCO';
BEGIN

	pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);
	
    pkg_traza.trace(csbMetodo||
					' inuMedioRecepcionId: '||inuMedioRecepcionId||' '||
					' inuContactoId: '||inuContactoId||' '||
					' isbComentario: '||isbComentario||' '||
					' inuRelaSoliPredio: '||inuRelaSoliPredio||' '||
					' inuTipoCausal: '||inuTipoCausal||' '||
					' inuCausal: '||inuCausal||' '||
					' inuContratoId: '||inuContratoId||' '||
					' isbDireccion: '||isbDireccion||' '||
					' inuDireccion: '||inuDireccion||' '||
					' inuLocalidad: '||inuLocalidad,pkg_traza.cnuNivelTrzDef);

    sbXmlSol :=
    '<?xml version="1.0" encoding="ISO-8859-1"?>
    <P_SOLICITUD_DUPLICADO_KIOSCO_100342 ID_TIPOPAQUETE="100342">
    <RECEPTION_TYPE_ID>'|| inuMedioRecepcionId|| '</RECEPTION_TYPE_ID>
    <CONTACT_ID>'|| inuContactoId|| '</CONTACT_ID>
    <ADDRESS_ID></ADDRESS_ID>
    <COMMENT_>'|| isbComentario || '</COMMENT_>
    <ROLE_ID>' ||inuRelaSoliPredio ||'</ROLE_ID>
    <TIPO_DE_CAUSA>'|| inuTipoCausal|| '</TIPO_DE_CAUSA>
    <CAUSAL>'|| inuCausal|| '</CAUSAL>
    <CONTRACT>'|| inuContratoId|| '</CONTRACT>
    <M_MOTIVO_SOLICITUD_DUPLICADO_KIOSCO_100328>
        <ADDRESS>'|| isbDireccion|| '</ADDRESS>
        <PARSER_ADDRESS_ID>'|| inuDireccion|| '</PARSER_ADDRESS_ID>
        <GEOGRAP_LOCATION_ID>'|| inuLocalidad|| ' </GEOGRAP_LOCATION_ID>
    </M_MOTIVO_SOLICITUD_DUPLICADO_KIOSCO_100328>
    </P_SOLICITUD_DUPLICADO_KIOSCO_100342>';

	pkg_traza.trace(csbMetodo||' sbXmlSol'||sbXmlSol,pkg_traza.cnuNivelTrzDef);

    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);
    return sbXmlSol;
EXCEPTION
WHEN PKG_ERROR.CONTROLLED_ERROR THEN
    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);
    raise PKG_ERROR.CONTROLLED_ERROR;
WHEN others THEN
    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
    Pkg_Error.seterror;
    raise PKG_ERROR.CONTROLLED_ERROR;

END;

   /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : getSolicitudCuponPortal
        Descripcion     : Arma el XML de la solicitud de cupon por el portal WEB 1003362
        Autor           : Adriana Vargas
        Fecha           : 26-09-2023
        =========================================================
        Autor       Fecha       Caso        Descripcion
        Adrianavg   26-09-2023	OSF-1634    Creacion

        Parametros de Entrada
        inuMedioRecepcionId    Codigo del medio de recepcion        
        isbComentario          Observacion registro de la solicitud
        inuContratoId          Codigo del contrato

        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso    Descripcion

    ***************************************************************************/
FUNCTION getSolicitudCuponPortal( inuMedioRecepcionId  IN mo_packages.reception_type_id%type,
                                  isbComentario        IN mo_packages.comment_%type,
                                  inuContratoId        IN NUMBER )
                                  RETURN constants_per.tipo_xml_sol%type IS

    csbMetodo CONSTANT VARCHAR(60) := sbPkgName||'.GETSOLICITUDCUPONPORTAL';
BEGIN

	pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);
	
    pkg_traza.trace(csbMetodo||
                    ' inuMedioRecepcionId: '||inuMedioRecepcionId||' '||
                    ' isbComentario: '||isbComentario||' '||
                    ' inuContratoId: '||inuContratoId ,pkg_traza.cnuNivelTrzDef);
    sbXmlSol :=
    '<?xml version="1.0" encoding="ISO-8859-1"?>
    <P_SOLICITUD_DE_CUPON_POR_EL_PORTAL_WEB_100336 ID_TIPOPAQUETE="100336">
    <RECEPTION_TYPE_ID>'||inuMedioRecepcionId||'</RECEPTION_TYPE_ID>
    <COMMENT_>'||isbComentario||'</COMMENT_>
    <M_MOTIVO_SOLICITUD_DE_CUPON_POR_EL_PORTAL_WEB_100303>
    <CONTRATO>'||inuContratoId||'</CONTRATO>
    </M_MOTIVO_SOLICITUD_DE_CUPON_POR_EL_PORTAL_WEB_100303>
    </P_SOLICITUD_DE_CUPON_POR_EL_PORTAL_WEB_100336>';

	pkg_traza.trace(csbMetodo||' sbXmlSol'||sbXmlSol,pkg_traza.cnuNivelTrzDef);

    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);
    return sbXmlSol;
EXCEPTION
WHEN PKG_ERROR.CONTROLLED_ERROR THEN
    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);
    raise PKG_ERROR.CONTROLLED_ERROR;
WHEN others THEN
    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
    Pkg_Error.seterror;
    raise PKG_ERROR.CONTROLLED_ERROR;
END;

   /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : getSolicitudTrasPresPortal
        Descripcion     : Arma el XML de la solicitud solicitud de trasladar diferido a presente 
                          mes por el portal WEB 100340
        Autor           : Adriana Vargas
        Fecha           : 26-09-2023
        =========================================================
        Autor       Fecha       Caso        Descripcion
        Adrianavg   26-09-2023	OSF-1634    Creacion

        Parametros de Entrada
        inuMedioRecepcionId     Codigo del medio de recepcion        
        isbComentario           Observacion registro de la solicitud
        inuContratoId           Codigo del contrato

        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso    Descripcion

    ***************************************************************************/
FUNCTION getSolicitudTrasPresPortal(inuMedioRecepcionId  IN mo_packages.reception_type_id%type,
                                    isbComentario        IN mo_packages.comment_%type,
                                    inuContratoId        IN NUMBER )
                                    RETURN constants_per.tipo_xml_sol%type IS

    csbMetodo CONSTANT VARCHAR(60) := sbPkgName||'.GETSOLICITUDTRASPRESPORTAL';

BEGIN

	pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);
	
    pkg_traza.trace(csbMetodo||
                    ' inuMedioRecepcionId: '||inuMedioRecepcionId||' '||
                    ' isbComentario: '||isbComentario||' '||
                    ' inuContratoId: '||inuContratoId ,pkg_traza.cnuNivelTrzDef);
    sbXmlSol :=
    '<?xml version="1.0" encoding="ISO-8859-1"?>
    <P_SOLICITUD_DE_TRASLADAR_DIFERIDO_A_PRESENTE_MES_POR_EL_PORTAL_WEB_100340 ID_TIPOPAQUETE="100340">
    <RECEPTION_TYPE_ID>'||inuMedioRecepcionId||'</RECEPTION_TYPE_ID>
    <COMMENT_>'||isbComentario||'</COMMENT_>
    <M_MOTIVO_SOLICITUD_DE_TRASLADAR_DIFERIDO_A_PRESENTE_MES_POR_EL_PORTAL_WEB_100307>
    <CONTRATO>'||inuContratoId||'</CONTRATO>
    </M_MOTIVO_SOLICITUD_DE_TRASLADAR_DIFERIDO_A_PRESENTE_MES_POR_EL_PORTAL_WEB_100307>
    </P_SOLICITUD_DE_TRASLADAR_DIFERIDO_A_PRESENTE_MES_POR_EL_PORTAL_WEB_100340>';

	pkg_traza.trace(csbMetodo||' sbXmlSol'||sbXmlSol,pkg_traza.cnuNivelTrzDef);

    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);
    return sbXmlSol;
EXCEPTION
WHEN PKG_ERROR.CONTROLLED_ERROR THEN
    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);
    raise PKG_ERROR.CONTROLLED_ERROR;
WHEN others THEN
    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
    Pkg_Error.seterror;
    raise PKG_ERROR.CONTROLLED_ERROR;
END;
END pkg_xml_soli_aten_cliente;
/

PROMPT Otorgando permisos de ejecucion a pkg_xml_soli_aten_cliente
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_XML_SOLI_ATEN_CLIENTE','PERSONALIZACIONES');
END;
/