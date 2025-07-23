CREATE OR REPLACE PACKAGE personalizaciones.pkg_xml_soli_facturacion IS

   /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : pkg_xml_soli_facturacion
        Descripcion     : paquete que contiene las funciones que arman los los XML de las solicitudes relacionadas con 
                          el area de facturacion de GDC.
        Autor           : Adriana Vargas
        Fecha           : 28-09-2023
        =========================================================
        Autor       Fecha       Caso        Descripcion
        Adrianavg   28-09-2023  OSF-1669    Creacion

        Parametros de Entrada
        Parametros de Salida
    ***************************************************************************/

--
FUNCTION getSolicitudCambioUsoServ (inuProducto         IN NUMBER,
                                    idtFechaRegi        IN DATE,
                                    inuMedioRecepcionId IN NUMBER,
                                    inuContactoId       IN NUMBER,
                                    inuDireccion        IN NUMBER,
                                    isbComentario       IN VARCHAR2,
                                    inuRelaCliente      IN NUMBER,
                                    inuCategoria        IN NUMBER,
                                    inuSubcategoria     IN NUMBER,
                                    isbResolucion       IN VARCHAR2,
                                    isbInfoComp         IN VARCHAR2,
                                    isbVisitaCampo      IN VARCHAR2)
                                RETURN constants_per.tipo_xml_sol%type;

FUNCTION getSolicitudCancelacionPlanCom (idtFechaRegi        IN DATE,
                                         inuMedioRecepcionId IN NUMBER,
                                         inuContactoId       IN NUMBER,
                                         inuDireccion        IN NUMBER,
                                         isbComentario       IN VARCHAR2, 
                                         inuRelacionCliente  IN NUMBER,
                                         inuCliente          IN NUMBER,
                                         inuContratoId       IN NUMBER,
                                         inuProductoId       IN NUMBER,
                                         inuTipoProd         IN NUMBER,
                                         inuPlanComerAnte    IN NUMBER,
                                         inuPlanComerActual  IN NUMBER,
                                         inuRespuesta        IN NUMBER)
                                 RETURN constants_per.tipo_xml_sol%type;

END pkg_xml_soli_facturacion;
/
CREATE OR REPLACE PACKAGE body personalizaciones.pkg_xml_soli_facturacion IS
--CONSTANTES
sbXmlSol  constants_per.tipo_xml_sol%type;
sbPkgName VARCHAR2(50) := 'PKG_XML_SOLI_FACTURACION';
   /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : getSolicitudCambioUsoServ
        Descripcion     : Arma el XML de la solicitud Cambio de Uso del Servicio 100225
        Autor           : Adriana Vargas
        Fecha           : 28-09-2023
        =========================================================
        Autor       Fecha       Caso        Descripcion
        Adrianavg   28-09-2023  OSF-1669    Creacion

        Parametros de Entrada
        Parametro                 Descripcion        
        inuProducto               Codigo del producto
        idtFechaRegi              Fecha de registro
        inuMedioRecepcionId       Codigo del medio de recepcion.
        inuContactoId             Codigo del contacto
        inuDireccion              Codigo de direccion
        isbComentario             Observacion de registro de la solicitud
        inuRelaCliente            Relacion con el cliente
        inuCategoria              Categoria
        inuSubcategoria           Subcategoria
        isbResolucion             Resolucion
        isbInfoComp               Informacion completa

        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor           Fecha       Caso      Descripcion
        Jorge Valiente  09/12/2024  OSF-3674  Se agrega TAG REALIZO_VISITA_EN_CAMPO para regitro del tramite en XML
    ***************************************************************************/
FUNCTION getSolicitudCambioUsoServ( inuProducto         IN NUMBER,
                                    idtFechaRegi        IN DATE,
                                    inuMedioRecepcionId IN NUMBER,
                                    inuContactoId       IN NUMBER,
                                    inuDireccion        IN NUMBER,
                                    isbComentario       IN VARCHAR2,
                                    inuRelaCliente      IN NUMBER,
                                    inuCategoria        IN NUMBER,
                                    inuSubcategoria     IN NUMBER,
                                    isbResolucion       IN VARCHAR2,
                                    isbInfoComp         IN VARCHAR2,
                                    isbVisitaCampo      IN VARCHAR2)
                                RETURN constants_per.tipo_xml_sol%type IS

     csbMetodo CONSTANT VARCHAR(60) := sbPkgName||'.GETSOLICITUDCAMBIOUSOSERV';
     nuErrorCode NUMBER; -- se almacena codigo de error
     sbMensError VARCHAR2(2000); -- se almacena descripcion del error 
     
BEGIN

    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);
    
    pkg_traza.trace(' inuProducto: '||inuProducto||' '||
                    ' idtFechaRegi: '||idtFechaRegi||' '||
                    ' inuMedioRecepcionId: '||inuMedioRecepcionId||' '||
                    ' inuContactoId: '||inuContactoId||' '||
                    ' inuDireccion: '||inuDireccion||' '||
                    ' isbComentario: '||isbComentario||' '||
                    ' inuRelaCliente: '||inuRelaCliente||' '||
                    ' inuCategoria: '||inuCategoria||' '||
                    ' inuSubcategoria: '||inuSubcategoria||' '||
                    ' isbResolucion: '||isbResolucion||' '||
                    ' isbInfoComp: '||isbInfoComp||' '||
                    ' isbVisitaCampo: '||isbVisitaCampo ,pkg_traza.cnuNivelTrzDef);

    sbXmlSol :=
            '<?xml version="1.0" encoding ="ISO-8859-1"?>
            <P_CAMBIO_DE_USO_DEL_SERVICIO_100225 ID_TIPOPAQUETE="100225">
            <PRODUCT>' || inuProducto ||'</PRODUCT>
            <FECHA_DE_SOLICITUD>' ||idtFechaRegi || '</FECHA_DE_SOLICITUD>
            <RECEPTION_TYPE_ID>' || inuMedioRecepcionId ||'</RECEPTION_TYPE_ID>
            <CONTACT_ID>' || inuContactoId ||'</CONTACT_ID>
            <ADDRESS_ID>' || inuDireccion ||'</ADDRESS_ID>
            <COMMENT_>' || isbComentario ||'</COMMENT_>
            <ROLE_ID>' || inuRelaCliente ||'</ROLE_ID>
            <M_PATRON_DE_SERVICIOS_100237>
            <CATEGORY_ID>' ||inuCategoria ||'</CATEGORY_ID>
            <SUBCATEGORY_ID>' ||inuSubcategoria ||'</SUBCATEGORY_ID>
            <NUMERO_DE_RESOLUCION>' ||isbResolucion ||'</NUMERO_DE_RESOLUCION>
            <DOCUMENTACION_COMPLETA>' ||isbInfoComp ||'</DOCUMENTACION_COMPLETA>
            <REALIZO_VISITA_EN_CAMPO>' ||isbVisitaCampo ||'</REALIZO_VISITA_EN_CAMPO>
            <C_PATRON_10305>
            <C_GENERICO_10317/>
            </C_PATRON_10305>
            </M_PATRON_DE_SERVICIOS_100237>
            </P_CAMBIO_DE_USO_DEL_SERVICIO_100225>';

    pkg_traza.trace(sbXmlSol, pkg_traza.cnuNivelTrzDef); 

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    
    return sbXmlSol;

EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);                        
    RAISE pkg_Error.Controlled_Error;

    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error; 

END;

   /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : getSolicitudCancelacionPlanCom
        Descripcion     : Arma el XML de la solicitud de Cambio de Plan de Comercial por XML 100298
        Autor           : Adriana Vargas
        Fecha           : 28-09-2023
        =========================================================
        Autor       Fecha       Caso        Descripcion
        Adrianavg   28-09-2023  OSF-1669    Creacion

        Parametros de Entrada
        Parametro               Descripcion
        idtFechaRegi            Fecha de solicitud
        inuMedioRecepcionId     Codigo del medio de recepcion.
        inuContactoId           Codigo del contacto
        inuDireccion            Codigo de direccion
        isbComentario           Observacion de registro de la solicitud
        inuRelacionCliente      Relacion con el cliente
        inuCliente              Cliente
        inuContratoId           Contrato
        inuProductoId           Producto
        inuTipoProd             Tipo de producto
        inuPlanComerAnte        Plan comercial anterior
        inuPlanComerActual      Plan comercial actual
        inuRespuesta            Respuesta

        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso    Descripcion

    ***************************************************************************/
FUNCTION getSolicitudCancelacionPlanCom( idtFechaRegi        IN DATE,
                                         inuMedioRecepcionId IN NUMBER,
                                         inuContactoId       IN NUMBER,
                                         inuDireccion        IN NUMBER,
                                         isbComentario       IN VARCHAR2,                                         
                                         inuRelacionCliente  IN NUMBER,
                                         inuCliente          IN NUMBER,
                                         inuContratoId       IN NUMBER,
                                         inuProductoId       IN NUMBER,
                                         inuTipoProd         IN NUMBER,
                                         inuPlanComerAnte    IN NUMBER,
                                         inuPlanComerActual  IN NUMBER,
                                         inuRespuesta        IN NUMBER)
                                 RETURN constants_per.tipo_xml_sol%type IS

    csbMetodo CONSTANT VARCHAR(60) := sbPkgName||'.GETSOLICITUDCANCELACIONPLANCOM';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error 

BEGIN

    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);

    pkg_traza.trace(' idtFechaRegi: '||idtFechaRegi||' '||
                    ' inuMedioRecepcionId: '||inuMedioRecepcionId||' '||
                    ' inuContactoId: '||inuContactoId||' '||
                    ' inuDireccion: '||inuDireccion||' '||
                    ' isbComentario: '||isbComentario||' '||
                    ' inuRelacionCliente: '||inuRelacionCliente||' '||
                    ' inuCliente: '||inuCliente||' '||
                    ' inuContrato: '||inuContratoId||' '||
                    ' inuProducto: '||inuProductoId||' '||
                    ' inuTipoProd: '||inuTipoProd||' '||
                    ' inuPlanComerAnte: '||inuPlanComerAnte||' '||
                    ' inuPlanComerActual: '||inuPlanComerActual||' '||
                    ' inuRespuesta: '||inuRespuesta , pkg_traza.cnuNivelTrzDef); 

    sbXmlSol :=
            '<?xml version="1.0" encoding="utf-8" ?>
            <P_CAMBIO_DE_PLAN_DE_COMERCIAL_POR_XML_100298 ID_TIPOPAQUETE="100298">
            <FECHA_DE_SOLICITUD>'||idtFechaRegi||'</FECHA_DE_SOLICITUD>
            <RECEPTION_TYPE_ID>'||inuMedioRecepcionId||'</RECEPTION_TYPE_ID>
            <CONTACT_ID>'||inuContactoId||'</CONTACT_ID>
            <ADDRESS_ID>'||inuDireccion||'</ADDRESS_ID>
            <COMMENT_>'||isbComentario||'</COMMENT_>
            <ROLE_ID>'||inuRelacionCliente||'</ROLE_ID>
            <SUSCRIPTOR>'||inuCliente||'</SUSCRIPTOR>
            <ID_TIPOPAQUETE>100298</ID_TIPOPAQUETE>
            <M_CAMBIO_DE_PLAN_COMERCIAL_100293>
              <CONTRATO>'||inuContratoId ||'</CONTRATO>
              <PRODUCT>'||inuProductoId||'</PRODUCT>
              <TIPO_DE_PRODUCTO>'||inuTipoProd||'</TIPO_DE_PRODUCTO>
              <PLAN_COMERCIAL_ACTUAL>'||inuPlanComerAnte||'</PLAN_COMERCIAL_ACTUAL>
              <COMMERCIAL_PLAN_ID>'||inuPlanComerActual||'</COMMERCIAL_PLAN_ID>
              <ANSWER_ID>'||inuRespuesta||'</ANSWER_ID>
            </M_CAMBIO_DE_PLAN_COMERCIAL_100293>
            </P_CAMBIO_DE_PLAN_DE_COMERCIAL_POR_XML_100298>';

    pkg_traza.trace(sbXmlSol, pkg_traza.cnuNivelTrzDef); 
    
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    return sbXmlSol;
    
EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);                        
    RAISE pkg_Error.Controlled_Error;

    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;

END;

END pkg_xml_soli_facturacion;
/

PROMPT Otorgando permisos de ejecucion a PKG_XML_SOLI_FACTURACION
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_XML_SOLI_FACTURACION','PERSONALIZACIONES');
END;
/