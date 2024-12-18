create or replace PACKAGE personalizaciones.pkg_xml_soli_emerg IS
   /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : pkg_xml_soli_emerg
        Descripcion     : paquete para creacion de solicitudes de daño en producto
        Autor           : Jhon Soto
        Fecha           : 27-09-2023
        Parametros de Entrada

        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso     Descripción
		jsoto	    26/09/2023	OSF-1672 Creacion
    ***************************************************************************/

FUNCTION getDanoProducto( inuContactoId		    IN	mo_packages.contact_id%TYPE,
                          inuPuntoAtencionId	IN	mo_packages.pos_oper_unit_id%TYPE,
                          inuMedioRecepcionId	IN	mo_packages.reception_type_id%TYPE,
                          inuCausalId		    IN	ge_causal.causal_id%TYPE,
                          isbComentario		    IN	mo_packages.comment_%TYPE,
                          inuTipoProducto		IN	servsusc.sesuserv%TYPE,
                          inuProducto		    IN	servsusc.sesunuse%TYPE,
                          inuNumeroServicio	    IN	pr_product.service_number%TYPE,
                          inuDireccion		    IN	ab_address.address_id%TYPE
                         )
                         RETURN constants_per.tipo_xml_sol%TYPE;

END pkg_xml_soli_emerg;
/
create or replace package body personalizaciones.pkg_xml_soli_emerg IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : getDanoProducto  
    Descripcion     : Armar XML para registrar daño a producto
    Autor           : Jhon Soto
    Fecha           : 27-09-2023

    Parametros de Entrada
        inuContactoId       Contacto
        inuPuntoAtencionId	Punto de atención
        inuMedioRecepcionId	Código del medio de recepción.
        inuCausalId	        Código de la Causal
        isbComentario	    Observación de registro de la solicitud
        inuTipoProducto	    Tipo de producto
        inuProducto	        Código del producto
        inuNumeroServicio	Numero de servicio del producto
        inuDireccion	    Código de la dirección
    
    Retorna: sbXmlSol       Con el XML armado para registrar daño

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    Descripcion
  ***************************************************************************/
FUNCTION getDanoProducto(
                          inuContactoId		IN	mo_packages.contact_id%TYPE,
                          inuPuntoAtencionId	IN	mo_packages.pos_oper_unit_id%TYPE,
                          inuMedioRecepcionId	IN	mo_packages.reception_type_id%TYPE,
                          inuCausalId		    IN	ge_causal.causal_id%TYPE,
                          isbComentario		IN	mo_packages.comment_%TYPE,
                          inuTipoProducto		IN	servsusc.sesuserv%TYPE,
                          inuProducto		    IN	servsusc.sesunuse%TYPE,
                          inuNumeroServicio	IN	pr_product.service_number%TYPE,
                          inuDireccion		IN	ab_address.address_id%TYPE
                         )
                            RETURN constants_per.tipo_xml_sol%TYPE IS

      csbMetodo     CONSTANT VARCHAR2(50) := 'PKG_XML_SOLI_EMERG.GETDANOPRODUCTO'; 
      sbXmlSol      constants_per.tipo_xml_sol%TYPE;
      
      
        BEGIN
        UT_TRACE.TRACE('INICIO '||csbMetodo|| 
                        'inuContactoId: '||inuContactoId||' '||
                        'inuPuntoAtencionId: '||inuPuntoAtencionId||' '||
                        'inuMedioRecepcionId: '||inuMedioRecepcionId||' '||
                        'inuCausalId: '||inuCausalId||' '||
                        'isbComentario: '||isbComentario||' '||
                        'inuTipoProducto: '||inuTipoProducto||' '||
                        'inuProducto: '||inuProducto||' '||
                        'inuNumeroServicio: '||inuNumeroServicio||' '||
                        'inuDireccion: '||inuDireccion
                        ,10);

       sbXmlSol :=
                '<?xml version="1.0" encoding="ISO-8859-1"?>
                <P_REGISTRO_DE_DANO_A_PRODUCTO_POR_XML_100339 ID_TIPOPAQUETE="100339">
                    <CONTACT_ID>'||inuContactoId||'</CONTACT_ID>
                    <POS_OPER_UNIT_ID>'||inuPuntoAtencionId||'</POS_OPER_UNIT_ID>
                    <RECEPTION_TYPE_ID>'||inuMedioRecepcionId||'</RECEPTION_TYPE_ID>
                    <CAUSAL_ID>'||inuCausalId||'</CAUSAL_ID>
                    <COMMENT_>'||isbComentario||'</COMMENT_>
                    <M_DANO_A_PRODUCTO_100325>
                        <IDENTIFICADOR_DEL_TIPO_DE_PRODUCTO>'||inuTipoProducto||'</IDENTIFICADOR_DEL_TIPO_DE_PRODUCTO>
                        <PRODUCTO>'||inuProducto||'</PRODUCTO>
                        <NUMERO_DEL_SERVICIO>'||inuNumeroServicio||'</NUMERO_DEL_SERVICIO>
                        <PARSER_ADDRESS_ID> '||inuDireccion||'</PARSER_ADDRESS_ID>
                    </M_DANO_A_PRODUCTO_100325>
                </P_REGISTRO_DE_DANO_A_PRODUCTO_POR_XML_100339>';

     UT_TRACE.TRACE('FIN ' ||csbMetodo, 10);

     RETURN sbXmlSol;

  EXCEPTION
    WHEN PKG_ERROR.CONTROLLED_ERROR THEN
		UT_TRACE.TRACE('PKG_ERROR.CONTROLLED_ERROR '||csbMetodo, 10);
		raise PKG_ERROR.CONTROLLED_ERROR;
    WHEN others THEN
		UT_TRACE.TRACE('others ' ||csbMetodo, 10);
		Pkg_Error.seterror;
		raise PKG_ERROR.CONTROLLED_ERROR;
  END getDanoProducto;
END;
/
PROMPT Otorgando permisos de ejecución a pkg_xml_soli_emerg
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_XML_SOLI_EMERG','PERSONALIZACIONES');
END;
/