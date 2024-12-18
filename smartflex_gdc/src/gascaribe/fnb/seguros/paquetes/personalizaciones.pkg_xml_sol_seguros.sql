create or replace PACKAGE personalizaciones.pkg_xml_sol_seguros IS

   /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : pkg_xml_sol_seguros
        Descripcion     : paquete para creacion de solicitudes de seguros
        Autor           : Jhon Soto
        Fecha           : 19-09-2023
        Parametros de Entrada

        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso     	Descripción
		jsoto	    19/09/2023	OSF-1584 	Creacion
		jerazomvm	30/10/2023	OSF-1808	Se modifica el procedimiento getSolicitudCancelaSeguros
    ***************************************************************************/

FUNCTION getSolicitudVentaSeguros    (inuContratoId        IN suscripc.susccodi%type,
                                      inuMedioRecepcionId  IN mo_packages.reception_type_id%type,
                                      isbComentario        IN mo_packages.comment_%type,
                                      idtFechaSolicitud    IN mo_packages.request_date%type,
                                      inuDireccionId       IN ab_address.address_id%type,
                                      inuClienteId         IN suscripc.suscclie%type,
                                      inuPlanFinanciacionId IN plandife.pldicodi%type,
                                      inuCuotas            IN plandife.pldicuma%type,
                                      inuCategoriaId       IN categori.catecodi%type,
                                      inuSubcategId         IN subcateg.sucacodi%type,
                                      isbExcepcionCom      IN mo_packages.comment_%type,
                                      inuAseguradoraId     IN ge_contratista.id_contratista%type,
                                      inuIdentificacion    IN ld_policy.identification_id%type,
                                      nuLineaProductoId    IN ld_line.line_id%type,
                                      idtFechaNacimiento   IN mo_packages.request_date%type,
                                      inuTipoPolizaId      IN ld_policy.policy_type_id%type,
                                      inuNumeroPoliza      IN ld_policy.policy_id%type,
                                      inuValorPoliza       IN ld_policy.value_policy%type,
                                      inuRespuestaId       IN number,
                                      inuCausalIncl        IN ld_policy.cancel_causal_id%type,
                                      inuProductoId        IN mo_motive.product_id%type)
                                      
                                      RETURN constants_per.tipo_xml_sol%type;
                                      
FUNCTION getSolicitudCancelaSeguros(   inuPersonaId         IN ge_person.person_id%type,
                                       inuMedioRecepcionId  IN mo_packages.reception_type_id%type,
                                       isbComentario        IN mo_packages.comment_%type,
                                       idtFechaSolicitud    IN mo_packages.request_date%type,
                                       inuDireccionId       IN ab_address.address_id%type,
                                       inuClienteId         IN suscripc.suscclie%type,
                                       inuContratoId        IN suscripc.susccodi%type,
                                       inuNumeroPoliza      IN ld_policy.policy_id%type,
                                       inuRespuestaId       IN number,
                                       inuCausalCanceId     IN ld_policy.cancel_causal_id%type,
                                       isbObservacionPoliza IN mo_packages.comment_%type,
                                       isbSolicitud         IN ld_secure_cancella.type_cancel%type)
                                       RETURN constants_per.tipo_xml_sol%type;

END pkg_xml_sol_seguros;
/

create or replace package body personalizaciones.pkg_xml_sol_seguros IS

	-- Constantes para el control de la traza
	csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    cnuNVLTRC       CONSTANT NUMBER(2)  	:= pkg_traza.fnuNivelTrzDef;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : getSolicitudVentaSeguros
    Descripcion     : Armar XML para solicitud para venta de seguros
    Autor           : Jhon Soto
    Fecha           : 18-09-2023

    Parametros de Entrada
    inuContratoId				Código del contrato
    inuMedioRecepcionId			Código del medio de recepción.
    isbComentario				Observación de registro de la solicitud
    idtFechaSolicitud			Fecha de registro de la solicitud, si viene nula se debe tomar el sysdate
    inuDireccionId				Código de la dirección
    inuClienteId				Código del cliente
    inuPlanFinanciacionId		Código del plan de financiación
    inuCuotas					Cantidad de cuotas
    inuCategoriaId				Código de la categoría
    inuSubCategId				Código de la subcategoría
    isbExcepcionCom				Excepción Comercial
    inuAseguradoraId			Código de la aseguradora
    inuIdentificacion			Numero del asegurado
    nuLineaProductoId			Código de la linea de producto
    idtFechaNacimiento			Fecha de nacimiento
    inuTipoPolizaId				Código del tipo de póliza
    inuNumeroPoliza				Número de la póliza
    inuValorPoliza				Valor de la póliza
    inuRespuestaId				Código de la respuesta
    inuCausalIncl				Código de la causal de incumplimento
    inuProductoId				Código del producto


    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    Descripcion
  ***************************************************************************/
FUNCTION getSolicitudVentaSeguros(inuContratoId        IN suscripc.susccodi%type,
                                      inuMedioRecepcionId  IN mo_packages.reception_type_id%type,
                                      isbComentario        IN mo_packages.comment_%type,
                                      idtFechaSolicitud    IN mo_packages.request_date%type,
                                      inuDireccionId       IN ab_address.address_id%type,
                                      inuClienteId         IN suscripc.suscclie%type,
                                      inuPlanFinanciacionId IN plandife.pldicodi%type,
                                      inuCuotas            IN plandife.pldicuma%type,
                                      inuCategoriaId       IN categori.catecodi%type,
                                      inuSubcategId         IN subcateg.sucacodi%type,
                                      isbExcepcionCom      IN mo_packages.comment_%type,
                                      inuAseguradoraId     IN ge_contratista.id_contratista%type,
                                      inuIdentificacion    IN ld_policy.identification_id%type,
                                      nuLineaProductoId    IN ld_line.line_id%type,
                                      idtFechaNacimiento   IN mo_packages.request_date%type,
                                      inuTipoPolizaId      IN ld_policy.policy_type_id%type,
                                      inuNumeroPoliza      IN ld_policy.policy_id%type,
                                      inuValorPoliza       IN ld_policy.value_policy%type,
                                      inuRespuestaId       IN number,
                                      inuCausalIncl        IN ld_policy.cancel_causal_id%type,
                                      inuProductoId        IN mo_motive.product_id%type)
                                   RETURN constants_per.tipo_xml_sol%type IS

	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || 'getSolicitudVentaSeguros';
    sbXmlSol      constants_per.tipo_xml_sol%type;
      
      
        BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.fsbINICIO);
		
        pkg_traza.trace(' inuContratoId: '			|| inuContratoId		 || chr(10) ||
                        ' inuMedioRecepcionId: '	|| inuMedioRecepcionId	 || chr(10) ||
                        ' isbComentario: '			|| isbComentario	 	 || chr(10) ||
                        ' idtFechaSolicitud: '		|| idtFechaSolicitud	 || chr(10) ||
                        ' inuDireccionId: '			|| inuDireccionId    	 || chr(10) ||
                        ' inuClienteId: '			|| inuClienteId			 || chr(10) ||
                        ' inuPlanFinanciacionId: '	|| inuPlanFinanciacionId || chr(10) ||
                        ' inuCuotas: '				|| inuCuotas			 || chr(10) ||
                        ' inuCategoriaId: '			|| inuCategoriaId		 || chr(10) ||
                        ' inuSubCategId: '			|| inuSubCategId		 || chr(10) ||
                        ' isbExcepcionCom: '		|| isbExcepcionCom		 || chr(10) ||
                        ' inuAseguradoraId: ' 		|| inuAseguradoraId		 || chr(10) ||
                        ' inuIdentificacion: ' 		|| inuIdentificacion	 || chr(10) ||
                        ' nuLineaProductoId: '		|| nuLineaProductoId	 || chr(10) ||
                        ' idtFechaNacimiento: '		|| idtFechaNacimiento	 || chr(10) ||
                        ' inuTipoPolizaId: '		|| inuTipoPolizaId	 	 || chr(10) ||
                        ' inuNumeroPoliza: '		|| inuNumeroPoliza		 || chr(10) ||
                        ' inuValorPoliza: '			|| inuValorPoliza		 || chr(10) ||
                        ' inuRespuestaId: '			|| inuRespuestaId		 || chr(10) ||
                        ' inuCausalIncl: '			|| inuCausalIncl		 || chr(10) ||
                        ' inuProductoId: '			|| inuProductoId, cnuNVLTRC);


    sbXmlSol :=
        '<?xml version="1.0" encoding="ISO-8859-1"?>
        <P_TRAMITE_VENTA_SEGUROS_XML_100261 ID_TIPOPAQUETE="100261">
        <CONTRACT>'||inuContratoId||'</CONTRACT>
        <RECEPTION_TYPE_ID>'||inuMedioRecepcionId||'</RECEPTION_TYPE_ID>
        <COMMENT_>'||isbComentario||'</COMMENT_>
        <FECHA_DE_SOLICITUD>'||nvl(idtFechaSolicitud,sysdate)||'</FECHA_DE_SOLICITUD>
        <ADDRESS_ID>'||inuDireccionId||'</ADDRESS_ID>
        <CONTACT_ID>'||inuClienteId||'</CONTACT_ID>
        <FINANCING_PLAN_ID>'||inuPlanFinanciacionId||'</FINANCING_PLAN_ID>
        <QUOTAS_NUMBER>'||inuCuotas||'</QUOTAS_NUMBER>
        <CATEGORIA>'||inuCategoriaId||'</CATEGORIA>
        <SUBCATEGORIA>'||inuSubCategId||'</SUBCATEGORIA>
        <COMM_EXCEPTION>'||isbExcepcionCom||'</COMM_EXCEPTION>
        <M_INSTALACION_DEBRILLA_SEGUROS_100268>
        <ASEGURADORA>'||inuAseguradoraId||'</ASEGURADORA>
        <INFORMACION_DEL_ASEGURADO>'||inuIdentificacion||'</INFORMACION_DEL_ASEGURADO>
        <LINEA_DEL_PRODUCTO>'||nuLineaProductoId||'</LINEA_DEL_PRODUCTO>
        <FECHA_DE_NACIMIENTO>'||idtFechaNacimiento||'</FECHA_DE_NACIMIENTO>
        <TIPO_DE_POLIZA>'||inuTipoPolizaId||'</TIPO_DE_POLIZA>
        <NUMERO_DE_POLIZA>'||inuNumeroPoliza||'</NUMERO_DE_POLIZA>
        <VALOR_DE_LA_POLIZA>'||inuValorPoliza||'</VALOR_DE_LA_POLIZA>
        <ANSWER_ID>'||inuRespuestaId||'</ANSWER_ID>
        <CAUSAL_DE_CUMPLIMIENTO_O_INCUMPLIMIENTO>'||inuCausalIncl||'</CAUSAL_DE_CUMPLIMIENTO_O_INCUMPLIMIENTO>
        <PRODUCT_ID>'||inuProductoId||'</PRODUCT_ID>
        <C_BRILLA_SEGUROS_10333/>
        </M_INSTALACION_DEBRILLA_SEGUROS_100268> 
        </P_TRAMITE_VENTA_SEGUROS_XML_100261>';

    return sbXmlSol;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

  EXCEPTION
    WHEN PKG_ERROR.CONTROLLED_ERROR THEN
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
		raise PKG_ERROR.CONTROLLED_ERROR;
    WHEN others THEN
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
		Pkg_Error.seterror;
		raise PKG_ERROR.CONTROLLED_ERROR;
  END getSolicitudVentaSeguros;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : getSolicitudCancelaSeguros
    Descripcion     : Armar XML para solicitud para cancelación de seguros
    Autor           : Jhon Soto
    Fecha           : 18-09-2023

    Parametros de Entrada
        inuPersonaId		 Código de la persona que registra la solicitud
        inuMedioRecepcionId	 Código del medio de recepción.
        isbComentario		 Observación de registro de la solicitud
        idtFechaSolicitud	 Fecha de registro de la solicitud, si viene nula se debe tomar el sysdate
        inuDireccionId		 Código de la dirección
        inuClienteId		 Código del cliente
        inuContratoId		 Código del contrato
        inuNumeroPoliza		 Número de la póliza a cancelar
        inuRespuestaId		 Código de la respuesta
        inuCausalCanceId	 Código de la causal de cancelación
        isbObservacionPoliza Observación de la póliza
        isbSolicitud		 Solicitud que fue registrada

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    Descripcion
	jerazomvm	30/10/2023	OSF-1808	Se modifica el tipo de dato del parametro isbSolicitud,
										mo_packages.package_id%type por ld_secure_cancella.type_cancel%type
  ***************************************************************************/

FUNCTION getSolicitudCancelaSeguros(   inuPersonaId         IN ge_person.person_id%type,
                                       inuMedioRecepcionId  IN mo_packages.reception_type_id%type,
                                       isbComentario        IN mo_packages.comment_%type,
                                       idtFechaSolicitud    IN mo_packages.request_date%type,
                                       inuDireccionId       IN ab_address.address_id%type,
                                       inuClienteId         IN suscripc.suscclie%type,
                                       inuContratoId        IN suscripc.susccodi%type,
                                       inuNumeroPoliza      IN ld_policy.policy_id%type,
                                       inuRespuestaId       IN number,
                                       inuCausalCanceId     IN ld_policy.cancel_causal_id%type,
                                       isbObservacionPoliza IN mo_packages.comment_%type,
                                       isbSolicitud         IN ld_secure_cancella.type_cancel%type)
                                       RETURN constants_per.tipo_xml_sol%type IS
     
	 csbMT_NAME  VARCHAR2(70) := csbSP_NAME || 'GetAccWithBalOutOfDate';       
     sbXmlSol      constants_per.tipo_xml_sol%type;

  BEGIN
  
	pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.fsbINICIO);
	
    pkg_traza.trace('inuPersonaId: '			|| inuPersonaId 	    || chr(10) ||
					'inuMedioRecepcionId: '		|| inuMedioRecepcionId  || chr(10) ||
					'isbComentario: '			|| isbComentario		|| chr(10) ||
					'idtFechaSolicitud: '		|| idtFechaSolicitud	|| chr(10) ||
					'inuDireccionId: '			|| inuDireccionId		|| chr(10) ||
					'inuClienteId: '			|| inuClienteId			|| chr(10) ||
					'inuContratoId: '			|| inuContratoId		|| chr(10) ||
					'inuNumeroPoliza: '			|| inuNumeroPoliza		|| chr(10) ||
					'inuRespuestaId: '			|| inuRespuestaId		|| chr(10) ||
					'inuCausalCanceId: '		|| inuCausalCanceId		|| chr(10) ||
					'isbObservacionPoliza: '	|| isbObservacionPoliza || chr(10) ||
					'isbSolicitud: '			|| isbSolicitud, cnuNVLTRC);


    sbXmlSol :=
        '<?xml version="1.0" encoding="ISO-8859-1"?>
        <P_CANCELACION_DE_SEGUROS_XML_100266 ID_TIPOPAQUETE="100266">
        <ID>'||inuPersonaId||'</ID>
        <RECEPTION_TYPE_ID>'||inuMedioRecepcionId||'</RECEPTION_TYPE_ID>
        <COMMENT_>'||isbComentario||'</COMMENT_>
        <FECHA_DE_SOLICITUD>'||nvl(idtFechaSolicitud,sysdate)||'</FECHA_DE_SOLICITUD>
        <ADDRESS_ID>'||inuDireccionId||'</ADDRESS_ID>
        <CONTACT_ID>'||inuClienteId||'</CONTACT_ID>
        <CONTRACT>'||inuContratoId||'</CONTRACT>
        <M_CANCELACION_DE_SEGUROS_XML_100273>
        <ANSWER_ID>'||inuRespuestaID||'</ANSWER_ID>
        <POLIZA_A_CANCELAR>'||inuNumeroPoliza||'</POLIZA_A_CANCELAR>
        <CAUSAL_DE_CANCELACION>'||inuCausalCanceId||'</CAUSAL_DE_CANCELACION>
        <OBSERVACIONES_DE_LA_POLIZA>'||isbObservacionPoliza||'</OBSERVACIONES_DE_LA_POLIZA>
        <SOLICITUD_QUE_FUE_REGISTRADA>'||isbSolicitud||'</SOLICITUD_QUE_FUE_REGISTRADA>
        </M_CANCELACION_DE_SEGUROS_XML_100273>
        </P_CANCELACION_DE_SEGUROS_XML_100266>';
    return sbXmlSol;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

  EXCEPTION
    WHEN PKG_ERROR.CONTROLLED_ERROR THEN
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
		raise PKG_ERROR.CONTROLLED_ERROR;
    WHEN others THEN
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
		Pkg_Error.seterror;
		raise PKG_ERROR.CONTROLLED_ERROR;
  END getSolicitudCancelaSeguros;

END;
/
PROMPT Otorgando permisos de ejecución a PKG_XML_SOL_SEGUROS
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_XML_SOL_SEGUROS','PERSONALIZACIONES');
END;
/