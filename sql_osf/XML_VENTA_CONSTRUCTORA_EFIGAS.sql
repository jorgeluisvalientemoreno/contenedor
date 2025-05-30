inuProducto         IN NUMBER,
                    idtFechaRegi        IN DATE,
                    inuMedioRecepcionId IN NUMBER,
                    inuContactoId       IN NUMBER,
                    inuDireccion        IN NUMBER,
                    isbComentario       IN VARCHAR2,
                    inuRelaCliente      IN NUMBER,
                    inuCategoria        IN NUMBER,
                    inuSubcategoria     IN NUMBER,
                    isbResolucion       IN VARCHAR2,
                    isbInfoComp         IN VARCHAR2)
  RETURN constants_per.tipo_xml_sol%type
  IS

     csbMT_NAME CONSTANT VARCHAR(70) := csbSP_NAME || '.getSolicitudCambioUsoServ';

     nuCodError     NUMBER;
     sbErrorMessage   VARCHAR2(4000);

  BEGIN

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);

    pkg_traza.trace('inuProducto: '     || inuProducto      || chr(10) ||
            'idtFechaRegi: '    || idtFechaRegi     || chr(10) ||
            'inuMedioRecepcionId: ' || inuMedioRecepcionId  || chr(10) ||
            'inuContactoId: '   || inuContactoId    || chr(10) ||
            'inuDireccion: '    || inuDireccion     || chr(10) ||
            'isbComentario: '   || isbComentario    || chr(10) ||
            'inuRelaCliente: '    || inuRelaCliente   || chr(10) ||
            'inuCategoria: '    || inuCategoria     || chr(10) ||
            'inuSubcategoria: '   || inuSubcategoria    || chr(10) ||
            'isbResolucion: '   || isbResolucion    || chr(10) ||
            'isbInfoComp: '     || isbInfoComp, cnuNVLTRC);

    sbXmlSol :=
        '<?xml version="1.0" encoding ="ISO-8859-1"?>
        <P_CAMBIO_DE_USO_DEL_SERVICIO_100225 ID_TIPOPAQUETE="100225">
        <PRODUCT>' || inuProducto || '</PRODUCT>
        <FECHA_DE_SOLICITUD>' || idtFechaRegi || '</FECHA_DE_SOLICITUD>
        <RECEPTION_TYPE_ID>' || inuMedioRecepcionId || '</RECEPTION_TYPE_ID>
        <CONTACT_ID>' || inuContactoId || '</CONTACT_ID>
        <ADDRESS_ID>' || inuDireccion || '</ADDRESS_ID>
        <COMMENT_>' || isbComentario || '</COMMENT_>
        <ROLE_ID>' || inuRelaCliente || '</ROLE_ID>
        <M_PATRON_DE_SERVICIOS_100237>
          <CATEGORY_ID>' ||inuCategoria || '</CATEGORY_ID>
          <SUBCATEGORY_ID>' ||inuSubcategoria || '</SUBCATEGORY_ID>
          <NUMERO_DE_RESOLUCION>' ||isbResolucion || '</NUMERO_DE_RESOLUCION>
          <DOCUMENTACION_COMPLETA>' ||isbInfoComp || '</DOCUMENTACION_COMPLETA>
          <C_PATRON_10305>
            <C_GENERICO_10317/>
          </C_PATRON_10305>
        </M_PATRON_DE_SERVICIOS_100237>
        </P_CAMBIO_DE_USO_DEL_SERVICIO_100225>';
