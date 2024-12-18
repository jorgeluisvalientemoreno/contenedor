CREATE OR REPLACE PACKAGE  personalizaciones.pkg_xml_soli_serv_nuevos IS

   /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : pkg_xml_soli_serv_nuevos
        Descripcion     : paquete que contiene las funciones que armen los XML de las solicitudes relacionadas con el 
                          area de Servicios Nuevos de GDC.
        Autor           : Adriana Vargas
        Fecha           : 28-09-2023
        =========================================================
        Autor       Fecha       Caso        Descripcion
        Adrianavg	28-09-2023	OSF-1656    Creacion

        Parametros de Entrada
        Parametros de Salida
    ***************************************************************************/

--
FUNCTION getSolicitudDesbloqueoOrdenes( idtFechaSolicitud   IN mo_packages.request_date%type,
                                        inuMedioRecepcionId IN mo_packages.reception_type_id%type,
                                        inuContactoId       IN mo_packages.contact_id%type,
                                        inuDireccionId      IN ab_address.address_id%type,
                                        isbComentario       IN mo_packages.comment_%type,
                                        inuClienteId        IN ge_subscriber.subscriber_id%type,
                                        inuProducto         IN servsusc.sesunuse%type,
                                        inuContrato         IN suscripc.susccodi%type)
                                RETURN constants_per.tipo_xml_sol%type; 
END pkg_xml_soli_serv_nuevos;
/


CREATE OR REPLACE PACKAGE body  personalizaciones.pkg_xml_soli_serv_nuevos IS
--CONSTANTES
sbXmlSol  constants_per.tipo_xml_sol%type;
sbPkgName VARCHAR2(50) := 'PKG_XML_SOLI_SERV_NUEVOS';
   /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : getSolicitudDesbloqueoOrdenes
        Descripcion     : Arma el XML del tipo de solicitud 100366 - Informacion de desbloqueo de Ordenes
        Autor           : Adriana Vargas
        Fecha           : 28-09-2023
        =========================================================
        Autor       Fecha       Caso        Descripcion
        Adrianavg	28-09-2023	OSF-1656    Creacion

        Parametros de Entrada
        idtFechaSolicitud 	Fecha de Registro de la solicitud
        inuMedioRecepcionId Codigo del medio de recepcion.
        inuContactoId 		Codigo del Contacto
        inuDireccionId 		Direccion
        isbComentario 		Observacion de registro de la solicitud
        inuClienteId 		Codigo del cliente que realizo la solicitud
        inuProducto 		Codigo del Producto
        inuContrato 		Codigo del Contrato


        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso    Descripcion
    ***************************************************************************/

FUNCTION getSolicitudDesbloqueoOrdenes( idtFechaSolicitud   IN mo_packages.request_date%type,
                                        inuMedioRecepcionId IN mo_packages.reception_type_id%type,
                                        inuContactoId       IN mo_packages.contact_id%type,
                                        inuDireccionId      IN ab_address.address_id%type,
                                        isbComentario       IN mo_packages.comment_%type,
                                        inuClienteId        IN ge_subscriber.subscriber_id%type,
                                        inuProducto         IN servsusc.sesunuse%type,
                                        inuContrato         IN suscripc.susccodi%type )
                                    RETURN constants_per.tipo_xml_sol%type IS

    csbMetodo CONSTANT VARCHAR(60) := sbPkgName||'.GETSOLICITUDDESBLOQUEOORDENES';

BEGIN
    UT_TRACE.TRACE('INICIO '||csbMetodo||
                    ' idtFechaSolicitud: '||idtFechaSolicitud||' '||
                    ' inuMedioRecepcionId: '||inuMedioRecepcionId||' '||
                    ' inuContactoId: '||inuContactoId||' '||
                    ' inuDireccionId: '||inuDireccionId||' '||
                    ' isbComentario: '||isbComentario||' '||
                    ' inuClienteId: '||inuClienteId||' '||
                    ' inuProducto: '||inuProducto||' '||
                    ' inuContrato: '||inuContrato ,10);
    sbXmlSol :=
    '<?xml version="1.0" encoding="ISO-8859-1" ?>
    <P_LDC_INFORMACION_DE_DESBLOQUEO_DE_ORDENES_100366 ID_TIPOPAQUETE="100366">
       <FECHA_SOLICITUD>'||idtFechaSolicitud||'</FECHA_SOLICITUD>
       <RECEPTION_TYPE_ID>'||inuMedioRecepcionId||'</RECEPTION_TYPE_ID>
       <CONTACT_ID>'||inuContactoId||'</CONTACT_ID>
       <ADDRESS_ID>'||inuDireccionId||'</ADDRESS_ID>
       <COMMENT_>'||isbComentario||'</COMMENT_>
       <SUSCRIPTOR>'||inuClienteId||'</SUSCRIPTOR>
       <M_INFORMACION_DE_DESBLOQUEO_DE_ORDENES_100348>
          <PRODUCTO>'||inuProducto||'</PRODUCTO>
          <CONTRATO>'||inuContrato||'</CONTRATO>
      </M_INFORMACION_DE_DESBLOQUEO_DE_ORDENES_100348>
    </P_LDC_INFORMACION_DE_DESBLOQUEO_DE_ORDENES_100366>';

    UT_TRACE.TRACE('FIN ' ||csbMetodo, 10);
    return sbXmlSol;
EXCEPTION
WHEN PKG_ERROR.CONTROLLED_ERROR THEN
    UT_TRACE.TRACE('PKG_ERROR.CONTROLLED_ERROR '||csbMetodo, 10);
    raise PKG_ERROR.CONTROLLED_ERROR;
WHEN others THEN
    UT_TRACE.TRACE('others ' ||csbMetodo, 10);
    Pkg_Error.seterror;
    raise PKG_ERROR.CONTROLLED_ERROR;
END;
END pkg_xml_soli_serv_nuevos;
/
PROMPT Otorgando permisos de ejecucion a PKG_XML_SOLI_SERV_NUEVOS
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_XML_SOLI_SERV_NUEVOS','PERSONALIZACIONES');
END;
/