CREATE OR REPLACE PACKAGE personalizaciones.pkg_xml_soli_serv_nuevos IS

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
        Jpinedc     09-01-2024  OSF-3828    Se crea fsbObtXMLSolReconexion

        Parametros de Entrada
        Parametros de Salida
    ***************************************************************************/

    -- Obtiene el XML de solicitudes de Desbloqueo de Ordenes de Servicios Nuevos
    FUNCTION getSolicitudDesbloqueoOrdenes
    (
        idtFechaSolicitud   IN mo_packages.request_date%type,
        inuMedioRecepcionId IN mo_packages.reception_type_id%type,
        inuContactoId       IN mo_packages.contact_id%type,
        inuDireccionId      IN ab_address.address_id%type,
        isbComentario       IN mo_packages.comment_%type,
        inuClienteId        IN ge_subscriber.subscriber_id%type,
        inuProducto         IN servsusc.sesunuse%type,
        inuContrato         IN suscripc.susccodi%type
    )
    RETURN constants_per.tipo_xml_sol%type; 

    -- Obtiene el XML de solicitudes de Reconexion de Servicios Nuevos
    FUNCTION fsbObtXMLSolReconexion
    ( 

        inuClienteId        IN  ge_subscriber.subscriber_id%TYPE ,
        inuDireccionId      IN  ab_address.address_id%TYPE,
        isbComentario       IN  mo_packages.comment_%TYPE,
        inuProducto         IN  servsusc.sesunuse%TYPE,
        inuTipoSuspension   IN  pr_prod_suspension.suspension_type_id%TYPE,
        inuTipoRecepcion    IN  ge_reception_type.reception_type_id%TYPE                  
    )
    RETURN constants_per.tipo_xml_sol%type;
    
END pkg_xml_soli_serv_nuevos;
/

CREATE OR REPLACE PACKAGE body  personalizaciones.pkg_xml_soli_serv_nuevos IS

    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
        
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

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'GETSOLICITUDDESBLOQUEOORDENES';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);        
        
        sbXmlSol  constants_per.tipo_xml_sol%type;

    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        pkg_Traza.Trace( ' idtFechaSolicitud: '||idtFechaSolicitud||' '||
                        ' inuMedioRecepcionId: '||inuMedioRecepcionId||' '||
                        ' inuContactoId: '||inuContactoId||' '||
                        ' inuDireccionId: '||inuDireccionId||' '||
                        ' isbComentario: '||isbComentario||' '||
                        ' inuClienteId: '||inuClienteId||' '||
                        ' inuProducto: '||inuProducto||' '||
                        ' inuContrato: '||inuContrato ,csbNivelTraza);
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

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
         
        return sbXmlSol;
        
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
    END getSolicitudDesbloqueoOrdenes;

   /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fsbObtXMLSolReconexion
        Descripcion     : Obtiene el XML de solicitudes de Reconexion de Servicios Nuevos
        Autor           : Lubin Pineda
        Fecha           : 09-01-2025
        =========================================================
        Parametros de Entrada
        inuClienteId        Id del cliente
        inuDireccionId      Id de la direccion
        isbComentario       Comentario
        inuProducto         Producto
        inuTipoSuspension   Tipo Suspension   

        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso        Descripcion
        jpinedc	    09-01-2025	OSF-3722    Creacion
    ***************************************************************************/
    FUNCTION fsbObtXMLSolReconexion
    ( 

        inuClienteId        IN  ge_subscriber.subscriber_id%TYPE ,
        inuDireccionId      IN  ab_address.address_id%TYPE,
        isbComentario       IN  mo_packages.comment_%TYPE,
        inuProducto         IN  servsusc.sesunuse%TYPE,
        inuTipoSuspension   IN  pr_prod_suspension.suspension_type_id%TYPE,
        inuTipoRecepcion    IN  ge_reception_type.reception_type_id%TYPE                         
    )
    RETURN constants_per.tipo_xml_sol%type
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbObtXMLSolReconexion';
        
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 
            
        sbXMLSolReconexion      constants_per.tipo_xml_sol%type;    
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
            
        sbXMLSolReconexion := '<?xml version="1.0" encoding="ISO-8859-1"?>
                    <P_RECONEXION_DE_SERVICIOS_NUEVOS_100305  ID_TIPOPAQUETE="100305">
                    <RECEPTION_TYPE_ID>' || inuTipoRecepcion || '</RECEPTION_TYPE_ID>
                    <CONTACT_ID>' ||inuClienteId ||'</CONTACT_ID>
                    <ADDRESS_ID>'||inuDireccionId||'</ADDRESS_ID>
                    <COMMENT_>' || isbComentario ||'</COMMENT_>
                    <PRODUCT>' ||inuProducto ||'</PRODUCT>
                    <TIPO_DE_SUSPENSION>' ||inuTipoSuspension ||'</TIPO_DE_SUSPENSION>                   
                    </P_RECONEXION_DE_SERVICIOS_NUEVOS_100305>';

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
                            
        RETURN sbXMLSolReconexion;

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
    END fsbObtXMLSolReconexion;

END pkg_xml_soli_serv_nuevos;
/

PROMPT Otorgando permisos de ejecucion a PKG_XML_SOLI_SERV_NUEVOS
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_XML_SOLI_SERV_NUEVOS','PERSONALIZACIONES');
END;
/

