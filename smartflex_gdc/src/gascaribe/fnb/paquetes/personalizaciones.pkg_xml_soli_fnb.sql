create or replace package personalizaciones.pkg_xml_soli_fnb is
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : pkg_xml_soli_fnb
    Descripcion     : Paquete para la generación de los XMLs de las solicitudes FNB
    Autor           : Edilay Peña Osorio
    Fecha           : 26/09/2023
    Parametros de Entrada

    Parametros de Salida
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso     Descripción
    epenao       26/09/2023 OSF-1627 Creacion paquete.
***************************************************************************/
--Obtiene xml solicitud corrección datos
function getSolicitudCorreccionDatos
(
    inuMedioRecepcionId    IN    NUMBER,   --Código del medio de recepción.
    isbComentario          IN    VARCHAR2, --Observación de registro de la solicitud
    inuClienteId           IN    NUMBER,   --Código del cliente que realizó la solicitud
    inuTipoIden            IN    NUMBER,   --Tipo de identificación
    isbIdentificacion      IN    VARCHAR2, --Número de identificación
    isbNombre              IN    VARCHAR2, --Nombres del cliente
    isbApellido            IN    VARCHAR2  --Apellidos del cliente
)
return constants_per.tipo_xml_sol%type;


--Obtiene xml solicitud pagaré único FNV
function getSolicitudPagareUnicoFnb
(
    inuMedioRecepcionId    IN    NUMBER,   --Código del medio de recepción.
    inuClienteId           IN    NUMBER,   --Código del cliente que realizó la solicitud
    inuDireccion           IN    NUMBER,   --Dirección del contrato
    isbComentario          IN    VARCHAR2, --Observación de registro de la solicitud
    inuContratoId          IN    NUMBER,   --Código del contrato
    inuPagare              IN    NUMBER,   --Código del pagaré
    inuEstadoPagare        IN    NUMBER    --Estado del pagaré
)
return constants_per.tipo_xml_sol%type;



--obtiene xml solicitud Visita FNB
function getSolicitudVisitaFnb
(
    inuContratoId        IN    NUMBER,     --Código de contrato
    inuFuncionario       IN    NUMBER,     --Código del la persona o funcionario
    inuMedioRecepcionId  IN    NUMBER,     --Código del medio de recepción.
    inuDireccion         IN    NUMBER,     --Dirección
    isbComentario        IN    VARCHAR2,   --Observación de registro de la solicitud
    inuMedioRefe         IN    NUMBER,     --Medio por el cual se entero
    inuTipoVisi          IN    NUMBER,     --Tipo de visita
    inuTenderoRefe       IN    NUMBER,     --Tendero Referente
    inuSoliCruzada       IN    NUMBER,     --Solicitud cruzada
    inuTipoPoliza        IN    NUMBER,     --Sublinea de producto / tipo de póliza
    inuRelaCliente       IN    NUMBER,     --Relación del cliente con el predio
    inuDireVisita        IN    NUMBER,     --Dirección de visita
    inuContactoid        IN    NUMBER,     --Id del contacto o cliente
    inuUnidadOperativa   IN    NUMBER      --Unidad operativa
)
return constants_per.tipo_xml_sol%type;

end pkg_xml_soli_fnb;
/

create or replace package body personalizaciones.pkg_xml_soli_fnb is

/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : pkg_xml_soli_fnb
    Descripcion     : Paquete para la generación de los XMLs de las solicitudes FNB
    Autor           : Edilay Peña Osorio
    Fecha           : 26/09/2023
    Parametros de Entrada

    Parametros de Salida
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso     Descripción
    epenao     26/09/2023   OSF-1627 Creacion paquete.
***************************************************************************/

    csbSP_NAME                  CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT||'.';
    csbLF                       CONSTANT VARCHAR2(5)        := chr(10);


function getSolicitudCorreccionDatos
(
    inuMedioRecepcionId    IN    NUMBER,    
    isbComentario          IN    VARCHAR2,  
    inuClienteId           IN    NUMBER,    
    inuTipoIden            IN    NUMBER,    
    isbIdentificacion      IN    VARCHAR2,  
    isbNombre              IN    VARCHAR2,  
    isbApellido            IN    VARCHAR2  
)
return constants_per.tipo_xml_sol%type
is
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : getSolicitudCorreccionDatos
    Descripcion     : Con los datos de entrada genera el XML para la solicitud
                      100296: P_CORRECCION_DE_DATOS_POR_XML_100296
    Autor           : Edilay Peña Osorio
    Fecha           : 26/09/2023
    Parametros de Entrada:
    Nombre                  Tipo      Descripción
    ===================    =========  =============================
    inuMedioRecepcionId    NUMBER     Código del medio de recepción.
    isbComentario          VARCHAR2   Observación de registro de la solicitud
    inuClienteId           NUMBER     Código del cliente que realizó la solicitud
    inuTipoIden            NUMBER     Tipo de identificación
    isbIdentificacion      VARCHAR2   Número de identificación
    isbNombre              VARCHAR2   Nombres del cliente
    isbApellido            VARCHAR2   Apellidos del cliente

    Parametros de Salida
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso     Descripción
    epenao       26/09/2023 OSF-1627 Creacion paquete.
***************************************************************************/
    csbMetodo     CONSTANT VARCHAR2(50) := csbSP_NAME||'getSolicitudCorreccionDatos';
    sbXmlSol      constants_per.tipo_xml_sol%type;
BEGIN
   ut_trace.trace('inicio '||csbMetodo,10);

   sbXmlSol :=
            '<?xml version="1.0" encoding="ISO-8859-1"?>'|| csbLF
            ||'<P_CORRECCION_DE_DATOS_POR_XML_100296 ID_TIPOPAQUETE="100296">'|| csbLF
            ||' <CUSTOMER>' || inuClienteId || '</CUSTOMER>'|| csbLF
            ||' <FECHA_DE_SOLICITUD>' || sysdate ||  '</FECHA_DE_SOLICITUD>'|| csbLF
            ||' <RECEPTION_TYPE_ID>' || inuMedioRecepcionId || '</RECEPTION_TYPE_ID>'|| csbLF
            ||' <COMMENT_>' || isbComentario || '</COMMENT_>'|| csbLF
            ||' <M_DATOS_A_CAMBIAR_100294>'|| csbLF
            ||'  <ANSWER_ID /> '|| csbLF
            ||'  <DOCUMENTACION_COMPLETA>Y</DOCUMENTACION_COMPLETA>'|| csbLF
            ||'  <TIPO_DE_IDENTIFICACION_DEL_CLIENTE>' || inuTipoIden ||'</TIPO_DE_IDENTIFICACION_DEL_CLIENTE>'|| csbLF
            ||'  <IDENTIFICACION_DEL_CLIENTE>' || isbIdentificacion ||'</IDENTIFICACION_DEL_CLIENTE>'|| csbLF
            ||'  <NOMBRE>' || isbNombre || '</NOMBRE>'|| csbLF
            ||'  <APELLIDO>' || isbApellido || '</APELLIDO>'|| csbLF
            ||'  <TELEFONO_DE_CONTACTO_1 /> '|| csbLF
            ||'  <TELEFONO_DE_CONTACTO_2 /> '|| csbLF
            ||'  <CORREO_ELECTRONICO />'|| csbLF
            ||' </M_DATOS_A_CAMBIAR_100294>'|| csbLF
            ||'</P_CORRECCION_DE_DATOS_POR_XML_100296>';

   ut_trace.trace('fin '||csbMetodo,10);
   return sbXmlSol;

EXCEPTION
    WHEN PKG_ERROR.CONTROLLED_ERROR THEN
        UT_TRACE.TRACE('PKG_ERROR.CONTROLLED_ERROR '||csbMetodo, 10);
        raise PKG_ERROR.CONTROLLED_ERROR;
    WHEN others THEN
        UT_TRACE.TRACE('others ' ||csbMetodo, 10);
        Pkg_Error.seterror;
        raise PKG_ERROR.CONTROLLED_ERROR;
END getSolicitudCorreccionDatos;


--Obtiene xml solicitud pagaré único FNV
function getSolicitudPagareUnicoFnb
(
    inuMedioRecepcionId    IN    NUMBER,   
    inuClienteId           IN    NUMBER,   
    inuDireccion           IN    NUMBER,   
    isbComentario          IN    VARCHAR2, 
    inuContratoId          IN    NUMBER,   
    inuPagare              IN    NUMBER,   
    inuEstadoPagare        IN    NUMBER    
)
return constants_per.tipo_xml_sol%type
is
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : getSolicitudPagareUnicoFnb
    Descripcion     : Con los datos de entrada genera el XML para la solicitud
                      100279: P_LDC_SOLICITUD_PAGARE_UNICO_100279
    Autor           : Edilay Peña Osorio
    Fecha           : 26/09/2023
    Parametros de Entrada
    Nombre                  Tipo      Descripción
    ===================    =========  =============================
    inuMedioRecepcionId     NUMBER    Código del medio de recepción.
    inuClienteId            NUMBER    Código del cliente que realizó la solicitud
    inuDireccion            NUMBER    Dirección del contrato
    isbComentario           VARCHAR2  Observación de registro de la solicitud
    inuContratoId           NUMBER    Código del contrato
    inuPagare               NUMBER    Código del pagaré
    inuEstadoPagare         NUMBER    Estado del pagaré

    Parametros de Salida
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso     Descripción
    epenao       26/09/2023 OSF-1627 Creacion paquete.
***************************************************************************/
    csbMetodo     CONSTANT VARCHAR2(50) := csbSP_NAME||'getSolicitudPagareUnicoFnb';
    sbXmlSol      constants_per.tipo_xml_sol%type;
BEGIN
   ut_trace.trace('inicio '||csbMetodo,10);
   sbXmlSol :=
            '<?xml version= "1.0" encoding= "ISO-8859-1" ?>' ||csbLF
            ||'<P_LDC_SOLICITUD_PAGARE_UNICO_100279 ID_TIPOPAQUETE="100279">' ||csbLF
            ||'  <RECEPTION_TYPE_ID>' || inuMedioRecepcionId || '</RECEPTION_TYPE_ID>' ||csbLF
            ||'  <CONTACT_ID>' || inuClienteId ||'</CONTACT_ID>' || csbLF
            ||'  <ADDRESS_ID>' || inuDireccion || '</ADDRESS_ID>' || csbLF
            ||'  <COMMENT_> [LDCSPU - PORTAL BRILLA]' || isbComentario ||'</COMMENT_>' || csbLF
            ||'  <CONTRATO_PENDIENTE>' ||inuContratoId || '</CONTRATO_PENDIENTE>' || csbLF
            ||'  <M_SERVICIOS_FINANCIEROS_100275>' || csbLF
            ||'  <CONSECUTIVO_DEL_PAGAR>' || inuPagare || '</CONSECUTIVO_DEL_PAGAR>' || csbLF
            ||'  <ESTADO_DE_PAGARE>' || inuEstadoPagare || '</ESTADO_DE_PAGARE>' || csbLF
            ||'  <ID_PRODUCTO />' || csbLF
            ||' </M_SERVICIOS_FINANCIEROS_100275>' ||csbLF
            ||'</P_LDC_SOLICITUD_PAGARE_UNICO_100279>';

   ut_trace.trace('fin '||csbMetodo,10);
   return sbXmlSol;

EXCEPTION
    WHEN PKG_ERROR.CONTROLLED_ERROR THEN
        UT_TRACE.TRACE('PKG_ERROR.CONTROLLED_ERROR '||csbMetodo, 10);
        raise PKG_ERROR.CONTROLLED_ERROR;
    WHEN others THEN
        UT_TRACE.TRACE('others ' ||csbMetodo, 10);
        Pkg_Error.seterror;
        raise PKG_ERROR.CONTROLLED_ERROR;
END getSolicitudPagareUnicoFnb;

--obtiene xml solicitud Visita FNB
function getSolicitudVisitaFnb
(
    inuContratoId        IN    NUMBER,
    inuFuncionario       IN    NUMBER,
    inuMedioRecepcionId  IN    NUMBER,
    inuDireccion         IN    NUMBER,
    isbComentario        IN    VARCHAR2, 
    inuMedioRefe         IN    NUMBER, 
    inuTipoVisi          IN    NUMBER, 
    inuTenderoRefe       IN    NUMBER, 
    inuSoliCruzada       IN    NUMBER, 
    inuTipoPoliza        IN    NUMBER, 
    inuRelaCliente       IN    NUMBER, 
    inuDireVisita        IN    NUMBER, 
    inuContactoid        IN    NUMBER, 
    inuUnidadOperativa   IN    NUMBER 
)
return constants_per.tipo_xml_sol%type
IS
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : getSolicitudVisitaFnb
    Descripcion     : Con los datos de entrada genera el XML para la solicitud
                      100245: P_SOLICITUD_DE_VISITA_FINANCIACIONES_NO_BANCARIAS_XML_100245
    Autor           : Edilay Peña Osorio
    Fecha           : 26/09/2023
    Parametros de Entrada
    Nombre                  Tipo      Descripción
    ===================    =========  =============================    
    inuContratoId          NUMBER     Código de contrato
    inuFuncionario         NUMBER     Código del la persona o funcionario
    inuMedioRecepcionId    NUMBER     Código del medio de recepción.
    inuDireccion           NUMBER     Dirección
    isbComentario          VARCHAR2   Observación de registro de la solicitud
    inuMedioRefe           NUMBER     Medio por el cual se entero
    inuTipoVisi            NUMBER     Tipo de visita
    inuTenderoRefe         NUMBER     Tendero Referente
    inuSoliCruzada         NUMBER     Solicitud cruzada
    inuTipoPoliza          NUMBER     Sublinea de producto / tipo de póliza
    inuRelaCliente         NUMBER     Relación del cliente con el predio
    inuDireVisita          NUMBER     Dirección de visita
    inuContactoid          NUMBER     Id del contacto o cliente
    inuUnidadOperativa     NUMBER     Unidad operativa
    
    Parametros de Salida
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso     Descripción
    epenao       26/09/2023 OSF-1627 Creacion paquete.
***************************************************************************/
    csbMetodo     CONSTANT VARCHAR2(50) := csbSP_NAME||'getSolicitudVisitaFnb';
    sbXmlSol      constants_per.tipo_xml_sol%type;
BEGIN
   ut_trace.trace('inicio '||csbMetodo,10);
   sbXmlSol :=
            '<?xml version="1.0" encoding="ISO-8859-1"?>'|| csbLF
            ||'  <P_SOLICITUD_DE_VISITA_FINANCIACIONES_NO_BANCARIAS_XML_100245 ID_TIPOPAQUETE="100245">'|| csbLF
            ||'  <CONTRACT>' || inuContratoId || '</CONTRACT>' || csbLF
            ||'  <FECHA_SOLICITUD>' || trunc(sysdate) ||  '</FECHA_SOLICITUD>' || csbLF
            ||'  <ID>' || inuFuncionario || '</ID>' || csbLF
            ||'  <RECEPTION_TYPE_ID>'||inuMedioRecepcionId||'</RECEPTION_TYPE_ID>'|| csbLF
            ||'  <ADDRESS_ID>' || inuDireccion ||  '</ADDRESS_ID>' || csbLF
            ||'  <COMMENT_>' || isbComentario || '</COMMENT_>' || csbLF
            ||'  <REFER_MODE_ID>' || inuMedioRefe || '</REFER_MODE_ID>' || csbLF
            ||'  <TIPO_DE_VISITA>' || inuTipoVisi || '</TIPO_DE_VISITA>' || csbLF
            ||'  <TENDERO_REFERENTE>' || inuTenderoRefe || '</TENDERO_REFERENTE>' || csbLF
            ||'  <SOLICITUD_CRUZADA>' || inuSoliCruzada || '</SOLICITUD_CRUZADA>' || csbLF
            ||'  <SUBLINEA_DE_PRODUCTO_TIPO_DE_P_LIZA>' || inuTipoPoliza || '</SUBLINEA_DE_PRODUCTO_TIPO_DE_P_LIZA>' || csbLF
            ||'  <ROLE_ID>' || inuRelaCliente || '</ROLE_ID>' || csbLF
            ||'  <DIRECCI_N_DE_VISITA>' || inuDireVisita || '</DIRECCI_N_DE_VISITA>' || csbLF
            ||'  <CONTACT_ID>' || inuContactoid || '</CONTACT_ID>' || csbLF
            ||'  <UNIDAD_OPERATIVA> '||inuUnidadOperativa ||'</UNIDAD_OPERATIVA> '|| csbLF
            ||'  <M_INSTALACI_N_DEBRILLA_SEGUROS_100226/>'|| csbLF
            ||'</P_SOLICITUD_DE_VISITA_FINANCIACIONES_NO_BANCARIAS_XML_100245>';

   ut_trace.trace('fin '||csbMetodo,10);
   return sbXmlSol;

EXCEPTION
    WHEN PKG_ERROR.CONTROLLED_ERROR THEN
        UT_TRACE.TRACE('PKG_ERROR.CONTROLLED_ERROR '||csbMetodo, 10);
        raise PKG_ERROR.CONTROLLED_ERROR;
    WHEN others THEN
        UT_TRACE.TRACE('others ' ||csbMetodo, 10);
        Pkg_Error.seterror;
        raise PKG_ERROR.CONTROLLED_ERROR;
END getSolicitudVisitaFnb;

end pkg_xml_soli_fnb;
/
PROMPT Otorgando permisos de ejecución a pkg_xml_soli_fnb
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_XML_SOLI_FNB','PERSONALIZACIONES');
END;
/

