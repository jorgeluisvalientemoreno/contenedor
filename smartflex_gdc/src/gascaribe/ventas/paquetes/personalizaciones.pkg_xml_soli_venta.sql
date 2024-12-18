create or replace PACKAGE personalizaciones.pkg_xml_soli_venta IS

    csbNOMPKG CONSTANT VARCHAR2(32) := $$PLSQL_UNIT || '.'; --constante nombre del paquete

   /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : pkg_xml_soli_venta
        Descripcion     : paquete para creacion de solicitudes de ventas
        Autor           : Jhon Soto
        Fecha           : 26-09-2023
        Parametros de Entrada

        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso     Descripción
		jsoto	    26/09/2023	OSF-1643 Creacion
    ***************************************************************************/

FUNCTION getSolicitudConstructora(inuFuncionario           IN ge_person.person_id%TYPE,
                                   inuUnidadOperativa       IN or_operating_unit.operating_unit_id%TYPE,
                                   inuMedioRecepcionId      IN mo_packages.reception_type_id%TYPE,
                                   inuClienteId             IN suscripc.suscclie%TYPE,
                                   inuDireccionRespuesta    IN ab_address.address_id%TYPE,
                                   isbComentario            IN mo_packages.comment_%TYPE,
                                   inuContrato              IN suscripc.susccodi%TYPE,
                                   inuActividad             IN or_order_activity.order_activity_id%TYPE,
                                   inuCausal                IN ge_causal.causal_id%TYPE,
                                   inuDireccionEjec         IN ab_address.address_id%TYPE,
                                   inuTipoVivienda          IN NUMBER
                                  )
                                  RETURN constants_per.tipo_xml_sol%type;



FUNCTION getSolicitudVisitaVentaGas(inuUnidadOperativa   IN or_operating_unit.operating_unit_id%TYPE,
                                      inuMedioRecepcionId  IN mo_packages.reception_type_id%TYPE,
                                      inuContacto          IN suscripc.suscclie%TYPE,
                                      inuDireccionId       IN ab_address.address_id%TYPE,
                                      inuMedioRefer        IN NUMBER,
                                      isbComentario        IN mo_packages.comment_%TYPE,
                                      inuContratoId        IN suscripc.susccodi%TYPE,
                                      inuRelacionCliente   IN NUMBER,
                                      inuCausal            IN ge_causal.causal_id%TYPE,
                                      inuDireccionVisita   IN ab_address.address_id%TYPE,
                                      inuTipoPredio        IN ab_premise.premise_type_id%TYPE,
                                      inuContratoRefe      IN suscripc.susccodi%TYPE,
                                      isbNombre            IN ge_subscriber.subscriber_name%TYPE,
                                      isbApellido          IN ge_subscriber.subs_last_name%TYPE,
                                      isbDireccion         IN ge_subscriber.address_id%TYPE,
                                      isbTelefono          IN ge_subscriber.phone%TYPE
                                      )
                                      RETURN constants_per.tipo_xml_sol%TYPE;
                                      
FUNCTION getSolicitudAnulacionVenta(inuFuncionario       IN ge_person.person_id%TYPE,
                                      inuMedioRecepcionId  IN mo_packages.reception_type_id%TYPE,
                                      inuDireccionId       IN ab_address.address_id%TYPE,
                                      inuContacto          IN suscripc.suscclie%TYPE,
                                      inuMedioRefer        IN NUMBER,
                                      isbComentario        IN mo_packages.comment_%TYPE,
                                      inuSolicitudAnular   IN mo_packages.package_id%TYPE,
                                      inuContratoId        IN suscripc.susccodi%TYPE,
                                      inuCausalAnul        IN ge_causal.causal_id%TYPE
                                    )        
                                    RETURN constants_per.tipo_xml_sol%type;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : getSolicitudAnulacionVenta
    Descripcion     : Armar XML para solicitud para solicitud de venta de gas por formulario
    Autor           : Jorge Valiente
    Fecha           : 22-11-2023

    Parametros de Entrada
    inuFuncionario          Codigo del funcionario
    inuPuntoAtencion        Codigo de la unidad operativa de venta
    inuTipoFormulario       Tipo de Formulario
    inuNumeroFormulario     Numero de formulario con el que se realiza la venta
    isbObservacion          Observacion de la venta
    inuDireccionId          Codigo de la direccion
    inuTipoIdentificacion   Tipo de Identificacion
    inuIdentificacion       Numero de identificacion
    isbNombre               Nombre del cliente
    isbApellido             Apellido del cliente
    isbNombreEmpresa        Nombre de la empresa
    isbCargo                Nombre del cargo en la empresa
    isbCorreo               Correo
    inuCantidadPersonas      Cantidad de personas a cargo
    inuEnergeticoAnterior   Codigo Energetico Anterior
    isbPredioConstruccion   S(Si) o N(No) Predio Construido
    inuTecnicoVentas        Codigo del tecnico de las ventas
    inuUnidadinstaladora    Codigo unidad instaladora
    inuUnidadCertificadora  Codigo unidad certificadora
    inuTelefono             Telefono
    inuTipoPredio           Codigo del tipo de predio
    inuEstadoLey            Codigo estado de Ley
    inuPromocion            Codigo del numero promocion
    inuPlanComercial        Codigo del Plan Comercial
    inuValorTotal           Valor total de la venta
    inuPlanFinanciacion     Codigo plan de financiacion
    inuCuotaIncial          Cuota inicial de venta
    inuNumeroCuotas         Numero de Cuotas
    inuCuotaMensual         Couta Mensual
    inuFormaPago            Codigo de forma de pago
    isbCuotaInicialRecibida S(Si) - N(No) Entrego cuota inicial
    inuTipoInstalacion      Codigo de Tipo de Instalacion
    inuUso                  Codigo de Categoria 1 - Residencial o 2 - No Residencial

    Retorna: sbXmlSol Con el XML armado

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    Descripcion
  ***************************************************************************/
  FUNCTION getSolicitudVentaGasFormulario(inuFuncionario          in ge_person.person_id%TYPE,
                                          inuPuntoAtencion        in mo_packages.pos_oper_unit_id%TYPE,
                                          inuTipoFormulario       in mo_packages.document_type_id%TYPE,
                                          inuNumeroFormulario     in mo_packages.document_key%TYPE,
                                          isbObservacion          in mo_packages.comment_%TYPE,
                                          inuDireccionId          in ab_address.address_id%TYPE,
                                          inuTipoIdentificacion   in ge_subscriber.ident_type_id%TYPE,
                                          inuIdentificacion       in ge_subscriber.identification%TYPE,
                                          isbNombre               in ge_subscriber.subscriber_name%TYPE,
                                          isbApellido             in ge_subscriber.subs_last_name%TYPE,
                                          isbNombreEmpresa        in ge_subs_work_relat.Company%TYPE,
                                          isbCargo                in ge_subs_work_relat.title%TYPE,
                                          isbCorreo               in ge_subscriber.e_mail%TYPE,
                                          inuCantidadPersonas      in ge_subs_housing_data.person_quantity%TYPE,
                                          inuEnergeticoAnterior   in ldc_energetico_ant.energ_ant%TYPE,
                                          isbPredioConstruccion   in ldc_daadventa.construccion%TYPE,
                                          inuTecnicoVentas        in ldc_daadventa.person_id%TYPE,
                                          inuUnidadinstaladora    in ldc_daadventa.oper_unit_inst%TYPE,
                                          inuUnidadCertificadora  in ldc_daadventa.oper_unit_cert%TYPE,
                                          inuTelefono             in ge_subs_phone.phone%TYPE,
                                          inuTipoPredio           in ldc_daadventa.tipo_predio%TYPE,
                                          inuEstadoLey            in ldc_daadventa.estaley%TYPE,
                                          inuPromocion            in mo_mot_promotion.mot_promotion_id%TYPE,
                                          inuPlanComercial        in mo_motive.commercial_plan_id%TYPE,
                                          inuValorTotal           in MO_GAS_SALE_DATA.TOTAL_VALUE%TYPE,
                                          inuPlanFinanciacion     in number,
                                          inuCuotaIncial          in MO_GAS_SALE_DATA.Initial_Payment%TYPE,
                                          inuNumeroCuotas         in number,
                                          inuCuotaMensual         in number,
                                          inuFormaPago            in MO_GAS_SALE_DATA.Init_Payment_Mode%TYPE,
                                          isbCuotaInicialRecibida in MO_GAS_SALE_DATA.Init_Pay_Received%TYPE,
                                          inuTipoInstalacion      in MO_GAS_SALE_DATA.Install_Type%TYPE,
                                          inuUso                  in MO_GAS_SALE_DATA.USAGE%TYPE)
      RETURN constants_per.tipo_xml_sol%TYPE;

END pkg_xml_soli_venta;
/
create or replace package body personalizaciones.pkg_xml_soli_venta IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : getSolicitudConstructora
    Descripcion     : Armar XML para solicitud para venta constructoras
    Autor           : Jhon Soto
    Fecha           : 26-09-2023

    Parametros de Entrada
    inuFuncionario	        Código del funcionario
    inuUnidadOperativa	    Punto de atención
    inuMedioRecepcionId	    Código del medio de recepción.
    inuClienteId	        Código del cliente que realizó la solicitud
    inuDireccionRespuesta	Código de dirección de respuesta
    isbComentario	        Observación de registro de la solicitud
    inuContrato	            Código del contrato
    inuActividad	        Código de actividad
    inuCausal	            Causal
    inuDireccionEjec	    Dirección de ejecución
    inuTipoVivienda	        Tipo de vivienda
    
    Retorna: sbXmlSol       Con el XML armado

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    Descripcion
  ***************************************************************************/
FUNCTION getSolicitudConstructora(inuFuncionario           IN ge_person.person_id%TYPE,
                                   inuUnidadOperativa       IN or_operating_unit.operating_unit_id%TYPE,
                                   inuMedioRecepcionId      IN mo_packages.reception_type_id%TYPE,
                                   inuClienteId             IN suscripc.suscclie%TYPE,
                                   inuDireccionRespuesta    IN ab_address.address_id%TYPE,
                                   isbComentario            IN mo_packages.comment_%TYPE,
                                   inuContrato              IN suscripc.susccodi%TYPE,
                                   inuActividad             IN or_order_activity.order_activity_id%TYPE,
                                   inuCausal                IN ge_causal.causal_id%TYPE,
                                   inuDireccionEjec         IN ab_address.address_id%TYPE,
                                   inuTipoVivienda          IN NUMBER
                                  )
                                   RETURN constants_per.tipo_xml_sol%TYPE IS

      csbMetodo     CONSTANT VARCHAR2(50) := 'PKG_XML_SOLI_VENTA.GETSOLICITUDCONSTRUCTORA'; 
      sbXmlSol      constants_per.tipo_xml_sol%TYPE;
      
      
        BEGIN
        UT_TRACE.TRACE('INICIO '||csbMetodo|| 
                        ' inuFuncionario: '||inuFuncionario||' '||
                        'inuUnidadOperativa: '||inuUnidadOperativa||' '||
                        'inuMedioRecepcionId: '||inuMedioRecepcionId||' '||
                        'inuClienteId: '||inuClienteId||' '||
                        'inuDireccionRespuesta: '||inuDireccionRespuesta||' '||
                        'isbComentario: '||isbComentario||' '||
                        'inuContrato: '||inuContrato||' '||
                        'inuActividad: '||inuActividad||' '||
                        'inuCausal: '||inuCausal||' '||
                        'inuDireccionEjec: '||inuDireccionEjec||' '||
                        'inuTipoVivienda: '||inuTipoVivienda,10);

       sbXmlSol :=
                  '<?xml version="1.0" encoding="ISO-8859-1"?>
                  <P_VENTA_A_CONSTRUCTORAS_323 ID_TIPOPAQUETE="323">
                  <FECHA_DE_SOLICITUD>'||SYSDATE ||'</FECHA_DE_SOLICITUD>
                  <ID>'||inuFuncionario||'</ID>
                  <POS_OPER_UNIT_ID>' || inuUnidadOperativa ||'</POS_OPER_UNIT_ID>
                  <RECEPTION_TYPE_ID>'||inuMedioRecepcionId||'</RECEPTION_TYPE_ID>
                  <IDENTIFICADOR_DEL_CLIENTE>'||inuClienteId||'</IDENTIFICADOR_DEL_CLIENTE>
                  <CONTACT_ID>'|| inuClienteId||'</CONTACT_ID>
                  <ADDRESS_ID>'|| inuDireccionRespuesta||'</ADDRESS_ID>
                  <COMMENT_>'||nvl(isbComentario,'-')||'</COMMENT_>
                  <INFORMACION_DE_CONTRATO>'||'SUBSCRIBER_ID= '||inuClienteId||'|SUBSCRIPTION_ID= '||inuContrato||'</INFORMACION_DE_CONTRATO>
                  <M_SOLICITUD_DE_TRABAJOS_PARA_UNA_CONSTRUCTORA_114>
                  <ITEM_ID>'||inuActividad||'</ITEM_ID>
                  <ADDRESS_ID>'||inuDireccionRespuesta||'</ADDRESS_ID>
                  <DIRECCION_DE_EJECUCION_DE_TRABAJOS>'||inuDireccionEjec||'</DIRECCION_DE_EJECUCION_DE_TRABAJOS>
                  <TIPO_DE_VIVIENDA>'||inuTipoVivienda||'</TIPO_DE_VIVIENDA>
                  </M_SOLICITUD_DE_TRABAJOS_PARA_UNA_CONSTRUCTORA_114>
                  </P_VENTA_A_CONSTRUCTORAS_323>';

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
  END getSolicitudConstructora;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : getSolicitudVisitaVentaGas
    Descripcion     : Armar XML para solicitud para solicitud de Venta de Gas
    Autor           : Jhon Soto
    Fecha           : 26-09-2023

    Parametros de Entrada
    inuUnidadOperativa	        Punto de atención
    inuMedioRecepcionId	        Código del medio de recepción.
    inuContactoId	            Código del contacto
    inuDireccion	            Código de dirección
    inuMedioRefer	            Medio de referencia
    isbComentario	            Observación de registro de la solicitud
    inuContrato	                Código del contrato
    inuRelacionCliente	        Relación con el cliente
    inuCausal	                Causal
    inuDireccionVisita	        Dirección de visita
    inuTipoPredio	            Tipo de predio
    inuContratoRefe	            Contrato referente
    isbNombre	                Nombre
    isbApellido	                Apellido
    isbDireccion	            Dirección
    isbTelefono	                Teléfono

    Retorna: sbXmlSol Con el XML armado

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    Descripcion
  ***************************************************************************/

FUNCTION getSolicitudVisitaVentaGas(inuUnidadOperativa   IN or_operating_unit.operating_unit_id%TYPE,
                                      inuMedioRecepcionId  IN mo_packages.reception_type_id%TYPE,
                                      inuContacto          IN suscripc.suscclie%TYPE,
                                      inuDireccionId       IN ab_address.address_id%TYPE,
                                      inuMedioRefer        IN NUMBER,
                                      isbComentario        IN mo_packages.comment_%TYPE,
                                      inuContratoId        IN suscripc.susccodi%TYPE,
                                      inuRelacionCliente   IN NUMBER,
                                      inuCausal            IN ge_causal.causal_id%TYPE,
                                      inuDireccionVisita   IN ab_address.address_id%TYPE,
                                      inuTipoPredio        IN ab_premise.premise_type_id%TYPE,
                                      inuContratoRefe      IN suscripc.susccodi%TYPE,
                                      isbNombre            IN ge_subscriber.subscriber_name%TYPE,
                                      isbApellido          IN ge_subscriber.subs_last_name%TYPE,
                                      isbDireccion         IN ge_subscriber.address_id%TYPE,
                                      isbTelefono          IN ge_subscriber.phone%TYPE)
                                      RETURN constants_per.tipo_xml_sol%TYPE IS

     csbMetodo     CONSTANT VARCHAR2(50) := 'PKG_XML_SOL_SEGUROS.GETSOLICITUDVISITAVENTAGAS';            
     sbXmlSol      constants_per.tipo_xml_sol%TYPE;

  BEGIN
    UT_TRACE.TRACE('INICIO '||csbMetodo|| 
                    ' inuUnidadOperativa: '||inuUnidadOperativa||' '||
                    'inuMedioRecepcionId: '||inuMedioRecepcionId||' '||
                    'inuContactoId: '||inuContacto||' '||
                    'inuDireccion: '||inuDireccionId||' '||
                    'inuMedioRefer: '||inuMedioRefer||' '||
                    'isbComentario: '||isbComentario||' '||
                    'inuContrato: '||inuContratoId||' '||
                    'inuRelacionCliente: '||inuRelacionCliente||' '||
                    'inuCausal: '||inuCausal||' '||
                    'inuDireccionVisita: '||inuDireccionVisita||' '||
                    'inuTipoPredio: '||inuTipoPredio||' '||
                    'inuContratoRefe: '||inuContratoRefe||' '||
                    'isbNombre: '||isbNombre||' '||
                    'isbApellido: '||isbApellido||' '||
                    'isbDireccion: '||isbDireccion||' '||
                    'isbTelefono: '||isbTelefono
                    ,10);


    sbXmlSol :=
                '<?xml version="1.0" encoding="ISO-8859-1"?> 
                 <P_LDC_VISITA_VENTA_GAS_XML_100268 ID_TIPOPAQUETE="100268">
                 <OPERATING_UNIT_ID>' || inuUnidadOperativa ||'</OPERATING_UNIT_ID>
                 <RECEPTION_TYPE_ID>' || inuMedioRecepcionId || '</RECEPTION_TYPE_ID>
                 <CONTACT_ID>' || inuContacto || '</CONTACT_ID>
                 <ADDRESS_ID>' || inuDireccionId || '</ADDRESS_ID>
                 <REFER_MODE_ID>' || inuMedioRefer || '</REFER_MODE_ID>
                 <COMMENT_>' || isbComentario || '</COMMENT_>
                 <ROLE_ID>' || inuRelacionCliente || '</ROLE_ID>
                 <DIRECCION_DE_VISITA>' || inuDireccionVisita || '</DIRECCION_DE_VISITA>
                 <TIPO_DE_PREDIO>' || inuTipoPredio || '</TIPO_DE_PREDIO>
                 <SUSCRIPCION_DEL_USUARIO_REFERENTE>' || inuContratoRefe || '</SUSCRIPCION_DEL_USUARIO_REFERENTE>
                 <NOMBRE>' || isbNombre || '</NOMBRE>
                 <APELLIDO>' || isbApellido || '</APELLIDO>
                 <DIRECCION>' || isbDireccion || '</DIRECCION>
                 <TELEFONO>' || isbTelefono || '</TELEFONO>
                 <M_INSTALACION_DE_GAS_100276 />
                 </P_LDC_VISITA_VENTA_GAS_XML_100268>';

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
  END getSolicitudVisitaVentaGas;


  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : getSolicitudAnulacionVenta
    Descripcion     : Armar XML para solicitud para solicitud de Anulacion de ventas
    Autor           : Jhon Soto
    Fecha           : 26-09-2023

    Parametros de Entrada
    inuFuncionario	    Código del funcionario
    inuMedioRecepcionId	Código del medio de recepción.
    inuDireccion	    Dirección del cliente
    inuContactoId	    Código del solicitante
    isbComentario	    Observación de registro de la solicitud
    inuSolicitudAnular	Código de solicitud anular
    inuContratoId	    Código del contrato
    inuCausalAnul	    Causal de anulación

    Retorna: sbXmlSol Con el XML armado

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    Descripcion
  ***************************************************************************/

FUNCTION getSolicitudAnulacionVenta(inuFuncionario       IN ge_person.person_id%TYPE,
                                      inuMedioRecepcionId  IN mo_packages.reception_type_id%TYPE,
                                      inuDireccionId       IN ab_address.address_id%TYPE,
                                      inuContacto          IN suscripc.suscclie%TYPE,
                                      inuMedioRefer        IN NUMBER,
                                      isbComentario        IN mo_packages.comment_%TYPE,
                                      inuSolicitudAnular   IN mo_packages.package_id%TYPE,
                                      inuContratoId        IN suscripc.susccodi%TYPE,
                                      inuCausalAnul        IN ge_causal.causal_id%TYPE
                                    )        
                                      RETURN constants_per.tipo_xml_sol%TYPE IS

     csbMetodo     CONSTANT VARCHAR2(50) := 'PKG_XML_SOL_SEGUROS.GETSOLICITUDANULACIONVENTA';            
     sbXmlSol      constants_per.tipo_xml_sol%TYPE;

  BEGIN
    UT_TRACE.TRACE('INICIO '||csbMetodo|| 
                    ' inuFuncionario: '||inuFuncionario||' '||
                    'inuMedioRecepcionId: '||inuMedioRecepcionId||' '||
                    'inuDireccion: '||inuDireccionId||' '||
                    'inuContactoId: '||inuContacto||' '||
                    'isbComentario: '||isbComentario||' '||
                    'inuSolicitudAnular: '||inuSolicitudAnular||' '||
                    'inuContratoId: '||inuContratoId||' '||
                    'inuCausalAnul: '||inuCausalAnul
                    ,10);


    sbXmlSol :=
            '<?xml version="1.0" encoding="ISO-8859-1"?> 
            <P_SOLICITUD_DE_ANULACION_DE_VENTA_SIN_PAGO_DE_CUOTA_INICIAL_100327 ID_TIPOPAQUETE="100327">
            <ID>'||inuFuncionario||'</ID>
            <RECEPTION_TYPE_ID>'||inuMedioRecepcionId||'</RECEPTION_TYPE_ID>
            <ADDRESS_ID>'||inuDireccionId||'</ADDRESS_ID>
            <COMMENT_>'||isbComentario||'</COMMENT_>
            <IDENTIFICADOR_DEL_CLIENTE>'||inuContacto||'</IDENTIFICADOR_DEL_CLIENTE>
            <PACKAGE_ID_ANUL>'||inuSolicitudAnular||'</PACKAGE_ID_ANUL>
            <M_MOTIVO_DE_ANULACION_DE_VENTA_SIN_PAGO_DE_CUOTA_INICIAL_100318>
                <CONTRATO>'||inuContratoId||'</CONTRATO>
                <CAUSAL_ANULACION>' || inuCausalAnul ||'</CAUSAL_ANULACION>
            </M_MOTIVO_DE_ANULACION_DE_VENTA_SIN_PAGO_DE_CUOTA_INICIAL_100318>
            </P_SOLICITUD_DE_ANULACION_DE_VENTA_SIN_PAGO_DE_CUOTA_INICIAL_100327>';

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
  END getSolicitudAnulacionVenta;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : getSolicitudAnulacionVenta
    Descripcion     : Armar XML para solicitud para solicitud de venta de gas por formulario
    Autor           : Jorge Valiente
    Fecha           : 22-11-2023

    Parametros de Entrada
    inuFuncionario          Codigo del funcionario
    inuPuntoAtencion        Codigo de la unidad operativa de venta
    inuTipoFormulario       Tipo de Formulario
    inuNumeroFormulario     Numero de formulario con el que se realiza la venta
    isbObservacion          Observacion de la venta
    inuDireccionId          Codigo de la direccion
    inuTipoIdentificacion   Tipo de Identificacion
    inuIdentificacion       Numero de identificacion
    isbNombre               Nombre del cliente
    isbApellido             Apellido del cliente
    isbNombreEmpresa        Nombre de la empresa
    isbCargo                Nombre del cargo en la empresa
    isbCorreo               Correo
    inuCantidadPersonas      Cantidad de personas a cargo
    inuEnergeticoAnterior   Codigo Energetico Anterior
    isbPredioConstruccion   S(Si) o N(No) Predio Construido
    inuTecnicoVentas        Codigo del tecnico de las ventas
    inuUnidadinstaladora    Codigo unidad instaladora
    inuUnidadCertificadora  Codigo unidad certificadora
    inuTelefono             Telefono
    inuTipoPredio           Codigo del tipo de predio
    inuEstadoLey            Codigo estado de Ley
    inuPromocion            Codigo del numero promocion
    inuPlanComercial        Codigo del Plan Comercial
    inuValorTotal           Valor total de la venta
    inuPlanFinanciacion     Codigo plan de financiacion
    inuCuotaIncial          Cuota inicial de venta
    inuNumeroCuotas         Numero de Cuotas
    inuCuotaMensual         Couta Mensual
    inuFormaPago            Codigo de forma de pago
    isbCuotaInicialRecibida S(Si) - N(No) Entrego cuota inicial
    inuTipoInstalacion      Codigo de Tipo de Instalacion
    inuUso                  Codigo de Categoria 1 - Residencial o 2 - No Residencial

    Retorna: sbXmlSol Con el XML armado

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso    Descripcion
  ***************************************************************************/
  FUNCTION getSolicitudVentaGasFormulario(inuFuncionario          in ge_person.person_id%TYPE,
                                          inuPuntoAtencion        in mo_packages.pos_oper_unit_id%TYPE,
                                          inuTipoFormulario       in mo_packages.document_type_id%TYPE,
                                          inuNumeroFormulario     in mo_packages.document_key%TYPE,
                                          isbObservacion          in mo_packages.comment_%TYPE,
                                          inuDireccionId          in ab_address.address_id%TYPE,
                                          inuTipoIdentificacion   in ge_subscriber.ident_type_id%TYPE,
                                          inuIdentificacion       in ge_subscriber.identification%TYPE,
                                          isbNombre               in ge_subscriber.subscriber_name%TYPE,
                                          isbApellido             in ge_subscriber.subs_last_name%TYPE,
                                          isbNombreEmpresa        in ge_subs_work_relat.Company%TYPE,
                                          isbCargo                in ge_subs_work_relat.title%TYPE,
                                          isbCorreo               in ge_subscriber.e_mail%TYPE,
                                          inuCantidadPersonas      in ge_subs_housing_data.person_quantity%TYPE,
                                          inuEnergeticoAnterior   in ldc_energetico_ant.energ_ant%TYPE,
                                          isbPredioConstruccion   in ldc_daadventa.construccion%TYPE,
                                          inuTecnicoVentas        in ldc_daadventa.person_id%TYPE,
                                          inuUnidadinstaladora    in ldc_daadventa.oper_unit_inst%TYPE,
                                          inuUnidadCertificadora  in ldc_daadventa.oper_unit_cert%TYPE,
                                          inuTelefono             in ge_subs_phone.phone%TYPE,
                                          inuTipoPredio           in ldc_daadventa.tipo_predio%TYPE,
                                          inuEstadoLey            in ldc_daadventa.estaley%TYPE,
                                          inuPromocion            in mo_mot_promotion.mot_promotion_id%TYPE,
                                          inuPlanComercial        in mo_motive.commercial_plan_id%TYPE,
                                          inuValorTotal           in MO_GAS_SALE_DATA.TOTAL_VALUE%TYPE,
                                          inuPlanFinanciacion     in number,
                                          inuCuotaIncial          in MO_GAS_SALE_DATA.Initial_Payment%TYPE,
                                          inuNumeroCuotas         in number,
                                          inuCuotaMensual         in number,
                                          inuFormaPago            in MO_GAS_SALE_DATA.Init_Payment_Mode%TYPE,
                                          isbCuotaInicialRecibida in MO_GAS_SALE_DATA.Init_Pay_Received%TYPE,
                                          inuTipoInstalacion      in MO_GAS_SALE_DATA.Install_Type%TYPE,
                                          inuUso                  in MO_GAS_SALE_DATA.USAGE%TYPE)
      RETURN constants_per.tipo_xml_sol%TYPE IS
    
      csbMetodo CONSTANT VARCHAR2(100) := csbNOMPKG ||
                                          'getSolicitudVentaGasFormulario'; --nombre del metodo
      sbXmlSol    constants_per.tipo_xml_sol%TYPE;
      sbPromocion varchar2(200) := null;
    
    BEGIN
    
      pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    
      if inuPromocion is not null then
        sbPromocion := '<PROMOCIONES GROUP="1">
                            <PROMOTION_ID>' || inuPromocion ||
                       '</PROMOTION_ID>
                          </PROMOCIONES>';
      end if;
    
      sbXmlSol := '<?xml version="1.0" encoding="ISO-8859-1"?> <P_VENTA_DE_GAS_POR_FORMULARIO_271 ID_TIPOPAQUETE="271">
        <ID>' || inuFuncionario ||'</ID>
        <POS_OPER_UNIT_ID>' || inuPuntoAtencion || '</POS_OPER_UNIT_ID>
        <DOCUMENT_TYPE_ID>' || inuTipoFormulario || '</DOCUMENT_TYPE_ID>
        <DOCUMENT_KEY>' || inuNumeroFormulario || '</DOCUMENT_KEY>
        <COMMENT_>' || isbObservacion || '</COMMENT_>
        <DIRECCION>' || inuDireccionId || '</DIRECCION>
        <TIPO_DE_IDENTIFICACION>' || inuTipoIdentificacion || '</TIPO_DE_IDENTIFICACION>
        <IDENTIFICATION>' || inuIdentificacion || '</IDENTIFICATION>
        <SUBSCRIBER_NAME>' || isbNombre || '</SUBSCRIBER_NAME>
        <APELLIDO>' || isbApellido || '</APELLIDO>
        <COMPANY>' || isbNombreEmpresa || '</COMPANY>
        <TITLE>' || isbCargo || '</TITLE>
        <CORREO_ELECTRONICO>' || isbCorreo || '</CORREO_ELECTRONICO>
        <PERSON_QUANTITY>' || inuCantidadPersonas || '</PERSON_QUANTITY>
        <ENERGETICO_ANTERIOR>' || inuEnergeticoAnterior || '</ENERGETICO_ANTERIOR>
        <PREDIO_EN_CONSTRUCCION>' || isbPredioConstruccion || '</PREDIO_EN_CONSTRUCCION>
        <TECNICO_DE_VENTAS>' || inuTecnicoVentas || '</TECNICO_DE_VENTAS>
        <UNIDAD_DE_TRABAJO_INSTALADORA>' || inuUnidadInstaladora || '</UNIDAD_DE_TRABAJO_INSTALADORA>
        <UNIDAD_DE_TRABAJO_CERTIFICADORA>' || inuUnidadCertificadora || '</UNIDAD_DE_TRABAJO_CERTIFICADORA>
        <PHONE>' || inuTelefono || '</PHONE>
        <TIPO_DE_PREDIO>' || inuTipoPredio || '</TIPO_DE_PREDIO>
        <ESTADO_DE_LEY_1581>' || inuEstadoLey || '</ESTADO_DE_LEY_1581>' ||        
        '<M_INSTALACION_DE_GAS_59>
          <COMMERCIAL_PLAN_ID>' || inuPlanComercial || '</COMMERCIAL_PLAN_ID>' ||
          sbPromocion ||
          '<TOTAL_VALUE>' || inuValorTotal || '</TOTAL_VALUE>
          <PLAN_DE_FINANCIACION>' || inuPlanFinanciacion || '</PLAN_DE_FINANCIACION>
          <INITIAL_PAYMENT>' || inuCuotaIncial || '</INITIAL_PAYMENT>
          <NUMERO_DE_CUOTAS>' || inuNumeroCuotas || '</NUMERO_DE_CUOTAS>
          <CUOTA_MENSUAL>' || inuCuotaMensual || '</CUOTA_MENSUAL>
          <INIT_PAYMENT_MODE>' || inuFormaPago || '</INIT_PAYMENT_MODE>
          <INIT_PAY_RECEIVED>' || isbCuotaInicialRecibida || '</INIT_PAY_RECEIVED>
          <INSTALL_TYPE>' || inuTipoInstalacion || '</INSTALL_TYPE>
          <USAGE>'|| inuUso ||'</USAGE>
          <C_GAS_42>
            <CODIGO_DEL_PAQUETE />
            <C_MEDICION_43 />
          </C_GAS_42>
        </M_INSTALACION_DE_GAS_59>
      </P_VENTA_DE_GAS_POR_FORMULARIO_271>';

      pkg_traza.trace('XML[' || sbXmlSol || ']', pkg_traza.cnuNivelTrzDef);    
      
      pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    
      RETURN sbXmlSol;
    
    EXCEPTION
      WHEN Ex.CONTROLLED_ERROR THEN
        pkg_Error.SETERROR;
        pkg_traza.trace(csbMetodo,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbFIN_ERC);
        RAISE Ex.CONTROLLED_ERROR;
      WHEN OTHERS THEN
        pkg_Error.SETERROR;
        pkg_traza.trace(csbMetodo,
                        pkg_traza.cnuNivelTrzDef,
                        pkg_traza.csbFIN_ERR);
        RAISE Ex.CONTROLLED_ERROR;
    END getSolicitudVentaGasFormulario;

END;
/

PROMPT Otorgando permisos de ejecución a pkg_xml_soli_venta
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_XML_SOLI_VENTA','PERSONALIZACIONES');
END;
/