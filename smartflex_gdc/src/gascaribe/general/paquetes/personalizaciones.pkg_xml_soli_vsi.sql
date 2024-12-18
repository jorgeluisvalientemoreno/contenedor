create or replace PACKAGE                    personalizaciones.pkg_xml_soli_vsi IS

   /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : pkg_xml_soli_vsi
        Descripcion     : paquete para gestion de solicitudes de VSI
        Autor           : Jhon Soto
        Fecha           : 18-09-2023
        Parametros de Entrada

        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso     Descripción
		jsoto	    18/09/2023	OSF-1581 Creacion
    ***************************************************************************/

FUNCTION getSolicitudVSI (inuContratoID       IN suscripc.susccodi%type,
                         inuMedioRecepcionId  IN mo_packages.reception_type_id%type,
                         isbComentario        IN mo_packages.comment_%type,
                         inuProductoId        IN mo_motive.product_id%type,
                         inuClienteId         IN suscripc.suscclie%type,
                         inuPersonaID          IN ge_person.person_id%type,
                         inuPuntoAtencionId   IN or_operating_unit.operating_unit_id%type,
                         idtFechaSolicitud    IN mo_packages.request_date%type,
                         inuAddressId         IN ab_address.address_id%type,
                         inuTrabajosAddressId IN ab_address.address_id%type,
                         inuActividadId       IN or_order_activity.order_activity_id%type)
                         RETURN constants_per.tipo_xml_sol%type;


END pkg_xml_soli_vsi;
/
create or replace package body  personalizaciones.pkg_xml_soli_vsi IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : getSolicitudVSI
    Descripcion     : Armar XML para solicitud de revision VSI
    Autor           : Jhon Soto
    Fecha           : 18-09-2023

    Parametros de Entrada
                    inuContratoID        ID de contrato
                    inuMedioRecepcionId  Medio de recepcion
                    isbComentario        Comentario
                    inuProductoId        Producto
                    inuClienteId         Cliente
                    inuPersonaID          Código del usuario que registra el tramite, si es nulo se debe tomar el person_id de la persona conectada.
                    inuPuntoAtencion     Código del punto de ateción actual del usuario. Si no se recibe se debe tomar el punto de atención actual del person_id con que se registra la solicitud.
                    idtFechaSolicitud    Fecha de registro de la solicitud, si viene nula se debe tomar el sysdate
                    inuAddressId         Código de la dirección
                    inuTrabajosAddressId Código de la dirección donde se ejecutaran los trabajos.
                    inuActividadId       Código de la actividad a generar

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    Descripcion
  ***************************************************************************/

FUNCTION getSolicitudVSI (inuContratoID       IN suscripc.susccodi%type,
                         inuMedioRecepcionId  IN mo_packages.reception_type_id%type,
                         isbComentario        IN mo_packages.comment_%type,
                         inuProductoId        IN mo_motive.product_id%type,
                         inuClienteId         IN suscripc.suscclie%type,
                         inuPersonaID          IN ge_person.person_id%type,
                         inuPuntoAtencionId   IN or_operating_unit.operating_unit_id%type,
                         idtFechaSolicitud    IN mo_packages.request_date%type,
                         inuAddressId         IN ab_address.address_id%type,
                         inuTrabajosAddressId IN ab_address.address_id%type,
                         inuActividadId       IN or_order_activity.order_activity_id%type)
                         RETURN constants_per.tipo_xml_sol%type IS

      csbMetodo      CONSTANT VARCHAR2(50) := 'PKG_XML_SOLI_VSI.GETSOLICITUDVSI';            
      nuContrato    suscripc.susccodi%type;
      nuCliente     suscripc.suscclie%type;
      sbXmlSolVSI   constants_per.tipo_xml_sol%type;
      nuPersonaId     ge_person.person_id%type;
      nuPuntoAtencionId   or_operating_unit.operating_unit_id%type;

      CURSOR cuDatos IS
       Select Su.Susccodi, 
              Su.Suscclie
         From Suscripc Su
        Where Su.Susccodi  = inuContratoID;

  BEGIN
    UT_TRACE.TRACE('INICIO '||csbMetodo|| 
                   ' inuProductoId: ' ||inuProductoId||' '||
                   ' inuContratoID: ' ||inuContratoID||' '||
                   ' inuMedioRecepcionId: '||inuMedioRecepcionId||' '||
                   ' isbComentario: ' ||isbComentario||' '||
                   ' inuProductoId: ' ||inuProductoId||' '||
                   ' inuClienteId: ' ||inuClienteId||' '||
                   ' inuPersonID: ' ||inuPersonaID||' '||
                   ' inuPuntoAtencionId: '||inuPuntoAtencionId||' '||
                   ' idtFechaSolicitud: '||idtFechaSolicitud||' '||
                   ' inuAddressId: '||inuAddressId||' '||
                   ' inuTrabajosAddressId: '||inuTrabajosAddressId||' '||
                   ' inuActividadId: '||inuActividadId, 10);

   OPEN cuDatos;
    FETCH cuDatos
      INTO nuContrato,nuCliente;
    CLOSE cuDatos;

    if inuPersonaId is null then
           nuPersonaId    := pkg_bopersonal.fnugetpersonaid();
    end if;

    if inuPuntoAtencionId is null and inuPersonaId is null then
        nuPuntoAtencionId := pkg_bopersonal.fnuGetPuntoAtencionId(nuPersonaId);
    elsif inuPuntoAtencionId is null and inuPersonaId is not null then
        nuPuntoAtencionId := pkg_bopersonal.fnuGetPuntoAtencionId(inuPersonaId);
    end if;

    sbXmlSolVSI :=
    '<?xml version="1.0" encoding="ISO-8859-1"?>
     <P_LBC_VENTA_DE_SERVICIOS_DE_INGENIERIA_100101 ID_TIPOPAQUETE="100101">
     <CUSTOMER/>
     <CONTRACT>'||inuContratoId||'</CONTRACT>
     <PRODUCT>'||inuProductoId||'</PRODUCT>
     <FECHA_DE_SOLICITUD>'||nvl(idtFechaSolicitud,sysdate)||'</FECHA_DE_SOLICITUD>
     <ID>'||nvl(inuPersonaId,nuPersonaId)||'</ID>
     <POS_OPER_UNIT_ID>'||nvl(inuPuntoAtencionId,nuPuntoAtencionId)||'</POS_OPER_UNIT_ID>
     <RECEPTION_TYPE_ID>'||inuMedioRecepcionId||'</RECEPTION_TYPE_ID>
     <CONTACT_ID>'||nvl(inuClienteId,nuCliente)||'</CONTACT_ID>
     <ADDRESS_ID>'||inuAddressId||'</ADDRESS_ID>
     <COMMENT_>'||isbComentario||'</COMMENT_>
     <CONTRATO>'||inuContratoId||'</CONTRATO>
     <M_SOLICITUD_DE_TRABAJOS_PARA_UN_CLIENTE_100113>
     <ITEM_ID>'||inuActividadId||'</ITEM_ID>
     <DIRECCION_DE_EJECUCION_DE_TRABAJOS>'||inuTrabajosAddressId||'</DIRECCION_DE_EJECUCION_DE_TRABAJOS>
     <C_GENERICO_22>
     <C_GENERICO_10319/>
     </C_GENERICO_22>
     </M_SOLICITUD_DE_TRABAJOS_PARA_UN_CLIENTE_100113>
     </P_LBC_VENTA_DE_SERVICIOS_DE_INGENIERIA_100101>';

    return sbXmlSolVSI;

    UT_TRACE.TRACE('FIN ' ||csbMetodo, 10);

  EXCEPTION
    WHEN PKG_ERROR.CONTROLLED_ERROR THEN
		UT_TRACE.TRACE('PKG_ERROR.CONTROLLED_ERROR PKG_XML_SOLI_VSI.GETSOLICITUDVSI', 10);
		raise PKG_ERROR.CONTROLLED_ERROR;
    WHEN others THEN
		UT_TRACE.TRACE('others PKG_XML_SOLI_VSI.GETSOLICITUDVSI', 10);
		Pkg_Error.seterror;
		raise PKG_ERROR.CONTROLLED_ERROR;
  END getSolicitudVSI;

END;
/
PROMPT Otorgando permisos de ejecución a pkg_xml_soli_rev_periodica
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_XML_SOLI_VSI','PERSONALIZACIONES');
END;
/
