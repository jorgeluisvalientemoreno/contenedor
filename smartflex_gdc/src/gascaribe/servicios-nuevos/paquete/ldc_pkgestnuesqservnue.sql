create or replace PACKAGE LDC_PKGESTNUESQSERVNUE IS

/***************************************************************************************************************
   Fecha           IDEntrega           Modificacion
  ============    ================    ============================================
  15-05-2024	 	JSOTO			   OSF-2602 Se reemplaza uso de LDC_Email.mail por pkg_correo.prcEnviaCorreo
****************************************************************************************************************/


  inuSUSPENSION_TYPE_ID CONSTANT NUMBER := dald_parameter.fnugetnumeric_value('LDC_TIPOSUSPSN',
                                                                              NULL); --se almacena el tipo de suspension
  nutipoCausal          CONSTANT NUMBER := dald_parameter.fnugetnumeric_value('LDC_TIPOCAUSN',
                                                                              NULL); --se almacena el tipo de causal
  nuCausal              CONSTANT NUMBER := dald_parameter.fnugetnumeric_value('LDC_CAUSSUSPSN',
                                                                              NULL); --se almacena la causal de suspension

  PROCEDURE proRegistraLogLegalizacion(sbProceso    IN LDC_LOGERRLEGSERVNUEV.proceso%TYPE,
                                       dtFecha      IN LDC_LOGERRLEGSERVNUEV.fechgene%TYPE,
                                       nuOrden      IN LDC_LOGERRLEGSERVNUEV.order_id%TYPE,
                                       nuOrdenPadre IN LDC_LOGERRLEGSERVNUEV.ordepadre%TYPE,
                                       sbError      IN LDC_LOGERRLEGSERVNUEV.menserror%TYPE,
                                       sbUsuario    IN LDC_LOGERRLEGSERVNUEV.usuario%TYPE);
  /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2019-11-27
      Ticket      : 19
      Descripcion : P                                                              roceso que genera log de errores

      Parametros Entrada
      sbProceso  nombre del proceso
      dtFecha    fecha de generacion
      nuProducto producto
      sbError    mensaje de error
      nuSesion   numero de sesion
      sbUsuario  usuario

      Valor de salida

      Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
  ***************************************************************************/
  PROCEDURE prGeneSuspServNuevo(inuProducto   IN pr_product.product_id%TYPE,
                                inuCliente    IN or_order_activity.subscriber_id%TYPE,
                                inuTipoSusp   IN NUMBER,
                                InutipoCausal IN NUMBER,
                                inuCausal     IN NUMBER,
                                IsbComment    IN MO_PACKAGES.COMMENT_%type,
                                OnuPackage_id OUT MO_PACKAGES.PACKAGE_ID%type,
                                onuMotiveId   OUT MO_MOTIVE.MOTIVE_ID%type,
                                onuerror      OUT NUMBER,
                                OsbError      OUT VARCHAR2);
  /**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2019-11-25
    Proceso     : prGeneSuspServNuevo
    Ticket      : 19
    Descripcion : proceso que genere solicitud de suspension

    Parametros Entrada
     inuProducto   codigo de producto
     inuCliente    codigo del cliente
     InutipoCausal tipo de causal
     inuCausal     causal de suspension
     IsbComment    comentario de la solicitud

    Valor de salida
     OnuPackage_id  codigo de la solicitud
     onuMotiveId    codigo del motivo creado
     onuerror      codigo de error
     OsbError      mensaje de error

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

  PROCEDURE PRGENEORDSUSP;
  /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2019-11-25
      Proceso     : PRGENEORDSUSP
      Ticket      : 19
      Descripcion : plugin que genera tramite de suspension

      Parametros Entrada

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
  PROCEDURE PRGENEORDRECO(inuOrden    IN NUMBER,
                          inuProducto IN NUMBER,
                          onuError    OUT NUMBER,
                          osbError    OUT VARCHAR2);
  /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2019-11-25
      Proceso     : PRGENEORDRECO
      Ticket      : 19
      Descripcion : proceso que genera tramite de reconexion de servicio nuevo

      Parametros Entrada
        inuOrden      numero de la orden
        inuProducto   numero de producto
      Valor de salida
        onuError      codigo de error
        osbError      mensaje de error

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

  PROCEDURE PROCGEORRE;
  /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2019-11-25
      Proceso     : PROCGEORRE
      Ticket      : 19
      Descripcion : plugin que genera tramite de reconexion de servicio nuevo

      Parametros Entrada

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

  PROCEDURE PRJOBASIGLEGORSN;
  /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2019-11-26
      Proceso     : PRJOBASIGLEGORSN
      Ticket      : 19
      Descripcion : job que se encarga de asignar y legalizar orden


      Parametros Entrada

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

  PROCEDURE PRVALORDCERTPEND(inuProducto IN NUMBER);
  /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2019-12-9
      Proceso     : PRVALORDCERTPEND
      Ticket      : 19
      Descripcion : proceso que valida si un producto tiene orden de certificacion pendiente


      Parametros Entrada
        inuOrden   NUMERO DE ORDEN

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
  PROCEDURE PRJOBGENNOTISUSP;
  /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2020-02-13
      Proceso     : PRJOBGENNOTISUSP
      Ticket      : 19
      Descripcion : job que se encarga de generar orden de notificacion


      Parametros Entrada

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
  PROCEDURE PRVALILECTSUSP;
  /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2020-02-17
      Proceso     : PRVALILECTSUSP
      Ticket      : 19
      Descripcion : plugin que valida si la lectura de suspension es menor a la configurada en
                   el parametro LDC_LECTMINLEGA

      Parametros Entrada

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
  PROCEDURE PRMARUSUSUSP;
  /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2020-02-17
      Proceso     : PRMARUSUSUSP
      Ticket      : 19
      Descripcion : plugin que se encarga de marcar los productos
                    que se van a suspender en la tabla LDC_PRODNOTASUSP

      Parametros Entrada

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

  PROCEDURE PRJOBGENSUSPSERVNU;
  /**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2020-02-18
    Proceso     : PRJOBGENSUSPSERVNU
    Ticket      : 19
    Descripcion : job que se encarga de generar la suspension de servicio nuevo

    Parametros Entrada

    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
  PROCEDURE PRANULORDCERYSUS(inuProducto IN pr_product.product_id%type);
  /**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2020-02-18
    Proceso     : PRANULORDCERYSUS
    Ticket      : 19
    Descripcion : proceso que anula ordenes de suspension y certificacion

    Parametros Entrada
     inuProducto  codigo del producto

    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

  PROCEDURE PRGENTRAMCERT;
  /**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2020-02-18
    Proceso     : PRGENTRAMCERT
    Ticket      : 19
    Descripcion : proceso se encarga de generar tramite de certificacion

    Parametros Entrada
     inuProducto  codigo del producto

    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

  PROCEDURE PRGENECERTSN(inuProducto   IN NUMBER,
                         isbComentario IN VARCHAR2,
                         onuError      OUT NUMBER,
                         osbError      OUT VARCHAR2);
  /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2019-11-25
      Proceso     : PRGENECERTSN
      Ticket      : 19
      Descripcion : proceso que genera tramite de certificado servicio nuevo

      Parametros Entrada
        inuOrden      numero de la orden
        isbComentario   comentario
      Valor de salida
        onuError      codigo de error
        osbError      mensaje de error

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

  PROCEDURE PRELICARGCERT;
  /**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2019-11-25
    Proceso     : PRELICARGCERT
    Ticket      : 19
    Descripcion : proceso que elimina cargos temporales de certificacion

    Parametros Entrada

    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
   PROCEDURE PRGENEFINACERTSENU;
  /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2020-02-17
      Proceso     : PRGENEFINACERTSENU
      Ticket      : 19
      Descripcion : plugin que se encarga de generar fiannciacion de la certificacion de servicio nuevo

      Parametros Entrada

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
  
   
END LDC_PKGESTNUESQSERVNUE;
/
create or replace PACKAGE BODY LDC_PKGESTNUESQSERVNUE IS

/***************************************************************************************************************
   Fecha           IDEntrega           Modificacion
  ============    ================    ============================================
  15-05-2024	 	JSOTO			   OSF-2602 Se reemplaza uso de LDC_Email.mail por pkg_correo.prcEnviaCorreo
****************************************************************************************************************/



  PROCEDURE proRegistraLogLegalizacion(sbProceso  IN LDC_LOGERRLEGSERVNUEV.proceso%TYPE,
                                        dtFecha    IN LDC_LOGERRLEGSERVNUEV.fechgene%TYPE,
                                        nuOrden    IN LDC_LOGERRLEGSERVNUEV.order_id%TYPE,
                                        nuOrdenPadre    IN LDC_LOGERRLEGSERVNUEV.ordepadre%TYPE,
                                        sbError    IN LDC_LOGERRLEGSERVNUEV.menserror%TYPE,
                                        sbUsuario  IN LDC_LOGERRLEGSERVNUEV.usuario%TYPE
                                      ) IS
   /**************************************************************************
        Autor       : Luis Javier Lopez Barrios / Horbath
        Fecha       : 2019-11-27
        Ticket      : 19
        Descripcion : Proceso que genera log de errores

        Parametros Entrada
        sbProceso  nombre del proceso
        dtFecha    fecha de generacion
        nuProducto producto
        sbError    mensaje de error
        nuSesion   numero de sesion
        sbUsuario  usuario

        Valor de salida

        Historia de Modificaciones
        Fecha               Autor                Modificacion
      =========           =========          ====================
    ***************************************************************************/

  PRAGMA AUTONOMOUS_TRANSACTION;
 BEGIN

    INSERT INTO LDC_LOGERRLEGSERVNUEV
                        (
                          proceso,
                          fechgene,
                          order_id,
                          ordepadre,
                          menserror,
                          usuario
                        )
                VALUES
                (
                  sbProceso,
                  dtFecha,
                  nuOrden,
                  nuOrdenPadre,
                  sbError,
                  sbUsuario
                );
   COMMIT;
 EXCEPTION
   WHEN OTHERS THEN
       NULL;
 END proRegistraLogLegalizacion;

 PROCEDURE prGeneSuspServNuevo(inuProducto   IN pr_product.product_id%TYPE,
                               inuCliente    IN or_order_activity.subscriber_id%TYPE,
                               inuTipoSusp   IN NUMBER,
                               InutipoCausal IN NUMBER,
                               inuCausal     IN NUMBER,
                               IsbComment    IN MO_PACKAGES.COMMENT_%type,
                               OnuPackage_id OUT MO_PACKAGES.PACKAGE_ID%type,
                               onuMotiveId   OUT MO_MOTIVE.MOTIVE_ID%type,
                               onuerror      OUT NUMBER,
                               OsbError      OUT VARCHAR2) IS
  /**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2019-11-25
    Proceso     : prGeneSuspServNuevo
    Ticket      : 19
    Descripcion : proceso que genere solicitud de suspension

    Parametros Entrada
     inuProducto   codigo de producto
     inuCliente    codigo del cliente
     InutipoCausal tipo de causal
     inuCausal     causal de suspension
     IsbComment    comentario de la solicitud

    Valor de salida
     OnuPackage_id  codigo de la solicitud
     onuMotiveId    codigo del motivo creado
     onuerror      codigo de error
     OsbError      mensaje de error

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       	DESCRIPCION
	=========	 ==========		=======================
	24/07/2023	 jerazomvm		CASO OSF-1261:
								1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
								2. Se reemplaza el API OS_RegisterRequestWithXML por el API api_registerRequestByXml.
  ***************************************************************************/
   sbRequestXML VARCHAR2(4000);--se almacena xml
   dtFecha_inicio DATE;--fecha de suspension

 BEGIN
 
	Ut_trace.trace('Inicio LDC_PKGESTNUESQSERVNUE.prGeneSuspServNuevo inuProducto: ' 	|| inuProducto 		|| chr(10) ||
															  'inuCliente: ' 	|| inuCliente 		|| chr(10) ||
															  'inuTipoSusp: ' 	|| inuTipoSusp 		|| chr(10) ||
															  'InutipoCausal: '	|| InutipoCausal	|| chr(10) ||
															  'inuCausal: ' 	|| inuCausal 		|| chr(10) ||
															  'IsbComment: ' 	|| IsbComment, 2);

 dtFecha_inicio :=   SYSDATE + 1 / 24 / 60;

 sbRequestXML := '<?xml version="1.0" encoding="ISO-8859-1"?>
                <P_SUSPENSION_DE_SERVICIOS_NUEVOS_100309  ID_TIPOPAQUETE="100309">
                <RECEPTION_TYPE_ID>10</RECEPTION_TYPE_ID>
                <CONTACT_ID>' ||inuCliente ||'</CONTACT_ID>
                <ADDRESS_ID></ADDRESS_ID>
                <COMMENT_>' || IsbComment ||'</COMMENT_>
                <PRODUCT>' ||inuProducto ||'</PRODUCT>
                <FECHA_DE_SUSPENSION>' ||dtFecha_inicio ||'</FECHA_DE_SUSPENSION>
                <TIPO_DE_SUSPENSION>' ||inuTipoSusp ||'</TIPO_DE_SUSPENSION>
                <TIPO_DE_CAUSAL>' ||InutipoCausal ||'</TIPO_DE_CAUSAL>
                <CAUSAL_ID>' || inuCausal ||'</CAUSAL_ID>
                </P_SUSPENSION_DE_SERVICIOS_NUEVOS_100309>';

	  api_registerRequestByXml(sbRequestXML,
							   OnuPackage_id,
							   onuMotiveId,
							   onuerror,
							   OsbError);
							   
	
	Ut_trace.trace('Fin LDC_PKGESTNUESQSERVNUE.prGeneSuspServNuevo OnuPackage_id: '	|| OnuPackage_id	|| chr(10) ||
																  'onuMotiveId: ' 	|| onuMotiveId 		|| chr(10) ||
																  'onuerror: ' 		|| onuerror 		|| chr(10) ||
															      'OsbError: '		|| OsbError, 2);

 EXCEPTION
  when PKG_ERROR.CONTROLLED_ERROR then
    Pkg_error.getError(onuerror, OsbError);
    raise PKG_ERROR.CONTROLLED_ERROR;
  when OTHERS then
     Pkg_error.seterror;
    Pkg_error.getError(onuerror, OsbError);
    raise PKG_ERROR.CONTROLLED_ERROR;
 END prGeneSuspServNuevo;




 PROCEDURE PRGENEORDSUSP IS
  /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2019-11-25
      Proceso     : PRGENEORDSUSP
      Ticket      : 19
      Descripcion : plugin que genera tramite de suspension

      Parametros Entrada

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        	 AUTOR      	DESCRIPCION
	  ==========	==========		=======================
	  24/07/2023	jerazomvm		CASO OSF-1261:
									1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
									2. Se elimina la funcion fblAplicaEntregaxCaso, para la entrega la cual retorna true.
  ***************************************************************************/
    error NUMBER; --se almacena codigo de error
    sbmensa VARCHAR2(4000); --se almacena mensaje de error
    sbRequestXML  VARCHAR2(4000); --se almacena XMl para
    nuPackage_id NUMBER; --se almacena codigo de la solicitud
    nuMotiveId NUMBER; --se almacena codigo del motivo
    nuOrderId NUMBER; --se almacena numero de orden
    nuClaseCausal NUMBER; --se almacena clase de causal

    nuCliente NUMBER; --se obtiene cliente de la orden de trabajo
    nuProducto NUMBER; --se obtiene producto de la orden de trabajo
    sbComment   VARCHAR2(4000); --se almacena comentario de la suspension
    nuPersona NUMBER; --se almacena persona que legaliza
    nuUnidadOpera number; --se almacena unidad operativa
    nuCausalLeg NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_CAUSLEGSUSPSN', NULL);
    sbTipoSoli VARCHAR2(4000) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_VAL_TRAM_SUSP_SN',NULL);

    --se obtiene producto y cliente de la orden
    CURSOR cugetProducto IS
    SELECT oa.product_id, oa.subscriber_id
    FROM or_order_activity oa
    WHERE oa.order_id = nuOrderId
    and DAMO_PACKAGES.FNUGETPACKAGE_TYPE_ID(oa.package_id, null) in ( SELECT to_number(regexp_substr(sbTipoSoli,'[^,]+', 1, LEVEL)) AS tiso
                                                                        FROM   dual
                                                                        CONNECT BY regexp_substr(sbTipoSoli, '[^,]+', 1, LEVEL) IS NOT NULL);


  BEGIN

    nuOrderId 	:= or_bolegalizeorder.fnuGetCurrentOrder; -- Obtenemos la orden que se esta legalizando
    nuCausalLeg := Daor_order.fnugetCausal_id(nuOrderId, null); --se obtiene causal de legalizacion de la orden

	nuClaseCausal := dage_causal.fnugetclass_causal_id(nuCausalLeg, null); --se obtiene clase de causal
	nuUnidadOpera := daor_order.fnugetoperating_unit_id(nuOrderId,null); --unidad operativa
	nuPersona 	  := daor_order_person.fnugetperson_id(nuUnidadOpera, nuOrderId, NULL); -- persona que legaliza
     

    IF nuClaseCausal = 1 THEN

        --se carga producto y cliente
        OPEN cugetProducto;
        FETCH cugetProducto INTO nuProducto, nuCliente;
        CLOSE cugetProducto;

        sbComment :='SUSPENSION POR SERVICIO NUEVO OT LEGALIZADA['||nuOrderId||']';

        prGeneSuspServNuevo( nuProducto,
                             nuCliente,
                             inuSUSPENSION_TYPE_ID,
                             nutipoCausal,
                             nuCausal,
                             sbComment,
                             nuPackage_id,
                             nuMotiveId,
                             error,
                             sbmensa);

        IF error <> 0 then
            Pkg_error.SetErrorMessage(2741, sbmensa);
            RAISE PKG_ERROR.CONTROLLED_ERROR;
          ELSE
           INSERT INTO LDC_BLOQ_LEGA_SOLICITUD(PACKAGE_ID_ORIG, PACKAGE_ID_GENE)
                    VALUES (NULL, nuPackage_id);

           INSERT INTO LDC_ORDEASIGPROC
                      (
                        ORAPORPA,
                        ORAPSOGE,
                        ORAOPELE,
                        ORAOUNID,
                        ORAOCALE,
                        ORAOITEM,
                        ORAOPROC
                      )
                      VALUES
                      (
                        nuOrderId,
                        nuPackage_id,
                        nuPersona,
                        nuUnidadOpera,
                        nuCausalLeg,
                        null,
                        'SUSPSENU'
                      );
        END IF;
    END IF;

  EXCEPTION
    when PKG_ERROR.CONTROLLED_ERROR then
      Pkg_error.getError(error, sbmensa);
      raise PKG_ERROR.CONTROLLED_ERROR;
    when OTHERS then
       Pkg_error.seterror;
      Pkg_error.getError(error, sbmensa);
      raise PKG_ERROR.CONTROLLED_ERROR;
  END PRGENEORDSUSP;

  PROCEDURE PRGENEORDRECO( inuOrden IN NUMBER,
                           inuProducto IN NUMBER ,
                           onuError OUT NUMBER,
                           osbError OUT VARCHAR2) IS
  /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2019-11-25
      Proceso     : PRGENEORDRECO
      Ticket      : 19
      Descripcion : proceso que genera tramite de reconexion de servicio nuevo

      Parametros Entrada
        inuOrden      numero de la orden
        inuProducto   numero de producto
      Valor de salida
        onuError      codigo de error
        osbError      mensaje de error

      HISTORIA DE MODIFICACIONES
      FECHA        	AUTOR       	DESCRIPCION
	  ==========	=========		===================
	  24/07/2023	jerazomvm		CASO OSF-1261:
									1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
									2. Se elimina la funcion fblAplicaEntregaxCaso, para la entrega la cual retorna true.
									3. Se reemplaza el API OS_RegisterRequestWithXML por el API api_registerRequestByXml.
  ***************************************************************************/

   sbRequestXML  VARCHAR2(4000); --se almacena XMl para
    nuPackage_id NUMBER; --se almacena codigo de la solicitud
    nuMotiveId NUMBER; --se almacena codigo del motivo

    inuSUSPENSION_TYPE_ID NUMBER := dald_parameter.fnugetnumeric_value('LDC_TIPOSUSPRECSN', NULL); --se almacena el tipo de suspension
    nutipoCausal NUMBER := dald_parameter.fnugetnumeric_value('LDC_TIPOCAURECSN', NULL); --se almacena el tipo de causal
    nuCausal  NUMBER := dald_parameter.fnugetnumeric_value('LDC_CAUSSUSPRECSN', NULL); --se almacena la causal de suspension
    nuCliente NUMBER; --se obtiene cliente de la orden de trabajo
    nuProducto NUMBER; --se obtiene producto de la orden de trabajo
    sbComment   VARCHAR2(4000); --se almacena comentario de la suspension
    nuPersona NUMBER; --se almacena persona que legaliza
    nuUnidadOpera number; --se almacena unidad operativa
    nuDireccion NUMBER;

    nuCausalLeg NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_CAUSLEGRECOSN', NULL);
    nuCodigoAtrib NUMBER:= DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_CODPALECT', NULL); --se almacena codigo del parametro
    sbNombreoAtrib VARCHAR2(400) :=  DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_NOMBATRLECT', NULL); --se almacena nombre del parametro
    nuLectura NUMBER; --se almacena lectura

    --se obtiene producto y cliente de la orden
    CURSOR cugetCliente IS
    SELECT s.suscclie, p.ADDRESS_ID
    FROM pr_product p, suscripc s
    WHERE p.product_id = inuProducto
     AND s.susccodi = p.SUBSCRIPTION_ID;

  BEGIN
  
      onuError := 0;
      Ut_Trace.TRACE('INICIA PRGENEORDRECO inuOrden: ' || inuOrden|| ' inuProducto: '||inuProducto, 10);
     
      IF inuOrden IS NOT NULL THEN
          nuUnidadOpera := daor_order.fnugetoperating_unit_id(inuOrden,null); --unidad operativa
		  nuPersona := daor_order_person.fnugetperson_id(nuUnidadOpera, inuOrden, NULL); -- persona que legaliza
          
        Ut_Trace.TRACE('nuUnidadOpera '||nuUnidadOpera , 10);
        Ut_Trace.TRACE('nuPersona '||nuPersona , 10);
          nuLectura := ldc_boordenes.fsbDatoAdicTmpOrden(inuOrden,nuCodigoAtrib,TRIM(sbNombreoAtrib));
                Ut_Trace.TRACE('nuLectura '||nuLectura , 10);
          IF nuLectura  is null then
            onuError := -1;
            osbError := 'Proceso termino con errores : '||'No se ha digitado Lectura';
            RAISE PKG_ERROR.CONTROLLED_ERROR;
          END IF;
      END IF;
         
      --se carga producto y cliente
      OPEN cugetCliente;
      FETCH cugetCliente INTO nuCliente, nuDireccion;
      CLOSE cugetCliente;
		Ut_Trace.TRACE('nuCliente '||nuCliente , 10);
      sbComment :='RECONEXION POR SERVICIO NUEVO OT LEGALIZADA['||inuOrden||']';
      IF inuOrden IS NULL THEN
         sbComment :='RECONEXION POR APROBACION DE CERTIFICACION';
      END IF;

      sbRequestXML := '<?xml version="1.0" encoding="ISO-8859-1"?>
                    <P_RECONEXION_DE_SERVICIOS_NUEVOS_100305  ID_TIPOPAQUETE="100305">
                    <RECEPTION_TYPE_ID>10</RECEPTION_TYPE_ID>
                    <CONTACT_ID>' ||nuCliente ||'</CONTACT_ID>
                    <ADDRESS_ID>'||nuDireccion||'</ADDRESS_ID>
                    <COMMENT_>' || sbComment ||'</COMMENT_>
                    <PRODUCT>' ||inuProducto ||'</PRODUCT>
                    <TIPO_DE_SUSPENSION>' ||inuSUSPENSION_TYPE_ID ||'</TIPO_DE_SUSPENSION>                   
                    </P_RECONEXION_DE_SERVICIOS_NUEVOS_100305>';

         Ut_Trace.TRACE('sbRequestXML '||sbRequestXML , 10);
		 
        api_registerRequestByXml(sbRequestXML,
								 nuPackage_id,
								 nuMotiveId,
								 onuError,
								 osbError
								 );
								 
		Ut_Trace.TRACE('api_registerRequestByXml nuPackage_id: ' || nuPackage_id || chr(10) ||
												'nuMotiveId: '   || nuMotiveId, 10);

        IF onuError <> 0 THEN
           raise PKG_ERROR.CONTROLLED_ERROR;
        ELSE
         IF nuUnidadOpera IS NOT NULL THEN
               Ut_Trace.TRACE('insert orden asignar '||nuUnidadOpera , 10);
           INSERT INTO LDC_BLOQ_LEGA_SOLICITUD(PACKAGE_ID_ORIG, PACKAGE_ID_GENE)
                      VALUES (NULL, nuPackage_id);

           INSERT INTO LDC_ORDEASIGPROC
                      (
                        ORAPORPA,
                        ORAPSOGE,
                        ORAOPELE,
                        ORAOUNID,
                        ORAOCALE,
                        ORAOITEM,
                        ORAOPROC
                      )
                      VALUES
                      (
                        inuOrden,
                        nuPackage_id,
                        nuPersona,
                        nuUnidadOpera,
                        nuCausalLeg,
                        nuLectura,
                        'RECOSENU'
                      );
          END IF;
        END IF;
            Ut_Trace.TRACE('fin PRGENEORDRECO onuError: ' || onuError || chr(10) || 
											 'osbError: ' || osbError , 10);
      
      
  EXCEPTION
    when PKG_ERROR.CONTROLLED_ERROR then
       Pkg_error.getError(onuError, osbError);
    when OTHERS then
        Pkg_error.seterror;
       Pkg_error.getError(onuError, osbError);
       raise PKG_ERROR.CONTROLLED_ERROR;
  END PRGENEORDRECO;

  PROCEDURE PROCGEORRE IS
  /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2019-11-25
      Proceso     : PROCGEORRE
      Ticket      : 19
      Descripcion : plugin que genera tramite de reconexion de servicio nuevo

      Parametros Entrada

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        	AUTOR       	DESCRIPCION	  
	  ===========	=============	=============================
	  24/07/2023	jerazomvm		CASO OSF-1261:
									1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
									2. Se elimina la funcion fblAplicaEntregaxCaso, para la entrega la cual retorna true.
  ***************************************************************************/
    error NUMBER; --se almacena codigo de error
    sbmensa VARCHAR2(4000); --se almacena mensaje de error
    nuOrderId NUMBER; --se almacena numero de orden
    nuClaseCausal NUMBER; --se almacena clase de causal
    nuProducto NUMBER;
    sbTipoSoli VARCHAR2(4000) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_VAL_TRAM_SUSP_SN',NULL);
     inuSUSPENSION_TYPE_ID NUMBER := dald_parameter.fnugetnumeric_value('LDC_TIPOSUSPRECSN', NULL); --se almacena el tipo de suspension

    --se obtiene producto y cliente de la orden
    CURSOR cugetProducto IS
    SELECT oa.product_id
    FROM or_order_activity oa, pr_product p
    WHERE oa.order_id = nuOrderId
     and p.product_id = oa.product_id
     and p.product_status_id = 2
     and DAMO_PACKAGES.FNUGETPACKAGE_TYPE_ID(oa.package_id, null) in ( SELECT to_number(regexp_substr(sbTipoSoli,'[^,]+', 1, LEVEL)) AS tiso
                                                                        FROM   dual
                                                                        CONNECT BY regexp_substr(sbTipoSoli, '[^,]+', 1, LEVEL) IS NOT NULL)
     and exists ( select 1
                  from PR_PROD_SUSPENSION ps
                  where ps.PRODUCT_ID = oa.product_id
                    and ps.ACTIVE = 'Y'
                    AND ps.SUSPENSION_TYPE_ID = inuSUSPENSION_TYPE_ID);

  BEGIN
  
      nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder; -- Obtenemos la orden que se esta legalizando
         Ut_Trace.TRACE('INICIA  PROCGEORRE '||nuOrderId , 10);
      nuClaseCausal := dage_causal.fnugetclass_causal_id(Daor_order.fnugetCausal_id(nuOrderId, null), null); --se obtiene clase de causal
      --se valida clase de causal de legalizacion
      IF nuClaseCausal = 1 THEN
         --Se obtiene producto de la orden
         OPEN cugetProducto;
         FETCH cugetProducto INTO nuProducto;
         CLOSE cugetProducto;

         IF nuProducto IS NOT NULL THEN
           --se llama al proceso de reconexion
           PRGENEORDRECO( nuOrderId,
                           nuProducto ,
                           error,
                           sbmensa);

          IF error <> 0 THEN
            RAISE PKG_ERROR.CONTROLLED_ERROR;
          END IF;
        END IF;
      END IF;
       Ut_Trace.TRACE('FIN  PROCGEORRE '||nuClaseCausal , 10);

  EXCEPTION
    when PKG_ERROR.CONTROLLED_ERROR then
      Pkg_error.getError(error, sbmensa);
      raise PKG_ERROR.CONTROLLED_ERROR;
    when OTHERS then
       Pkg_error.seterror;
      Pkg_error.getError(error, sbmensa);
      raise PKG_ERROR.CONTROLLED_ERROR;
  END PROCGEORRE;

    PROCEDURE PRJOBASIGLEGORSN IS
  /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2019-11-26
      Proceso     : PRJOBASIGLEGORSN
      Ticket      : 19
      Descripcion : job que se encarga de asignar y legalizar orden


      Parametros Entrada

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        	AUTOR       		DESCRIPCION
	  ==========	============		======================================
	  24/07/2023		jerazomvm		CASO OSF-1261:
										1. Se reemplaza el llamado del API os_legalizeorders
										   por el API api_legalizeorders.
										2. Se reemplaza el manejo de errores ex y errors por Pkg_error.
										3. Se elimina la funcion fblAplicaEntregaxCaso, para la entrega la cual retorna true.
										4. Se reemplaza el API OS_ASSIGN_ORDER por el API API_ASSIGN_ORDER
  ***************************************************************************/
    nuParametro NUMBER:= DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_CODPALECT', NULL); --se almacena codigo del parametro
    nuOrden  NUMBER; --se almacena el codigo de la orden
    nuerrorcode NUMBER; --se almacena codigo de error
    sberrormessage VARCHAR2(4000) ;--se almacena mensaje de error

    dtFechaAsig DATE; --se almacena fecha de asigancion
    dtFechaEjecIni DATE; --se almacena fecha inicio de ejecucion
    dtFechaEjecfIN DATE; --se almacena fecha fin de ejecucion
    nuClaseCausal NUMBER; --se almacena clase de causal
    nuTipoSuspLega  NUMBER; -- se almacena tipo de suspension a legalizar
    sbmedidor VARCHAR2(100); --se almacena medidor del producto
    nuLectura  NUMBER; --se alamacena lectura de suspension
    nuOk NUMBER;
    sbCadenalega VARCHAR2(4000);--se almacena cadena de legalizacion
    nuEstadoRegOt NUMBER :=  dald_parameter.fnuGetNumeric_Value('COD_STATUS_REG', NULL); --se almacena estado de regsitrado de la orden

    --variables para el log
    nuparano NUMBER;
    nuparmes NUMBER;
    nutsess  NUMBER;
    sbparuser VARCHAR2(4000);


    --obtiene ordedes de suspension a legalizar
   CURSOR cuOrdenSuspension IS
   SELECT  ot.order_id, oa.product_id, oa.ORDER_ACTIVITY_ID,  S.ORAOUNID, S.ORAOPELE, S.ORAOCALE, S.ORAOITEM, S.ORAPORPA, s.ORAPSOGE
   FROM or_order_activity oa,or_order ot, LDC_ORDEASIGPROC s
   WHERE s.ORAPSOGE =   oa.package_id
      AND oa.order_id = ot.order_id
      AND ot.order_status_id = nuEstadoRegOt
      AND s.ORAOPROC = 'SUSPSENU'
      AND s.ORAOUNID is not null;

     --obtiene ordedes de reconexion a legalizar
   CURSOR cuOrdenReconexion IS
   SELECT  ot.order_id, oa.product_id, oa.ORDER_ACTIVITY_ID,  S.ORAOUNID, S.ORAOPELE, S.ORAOCALE, S.ORAOITEM, S.ORAPORPA, s.ORAPSOGE
   FROM or_order_activity oa,or_order ot, LDC_ORDEASIGPROC s
   WHERE s.ORAPSOGE =   oa.package_id
      AND oa.order_id = ot.order_id
      AND ot.order_status_id =  nuEstadoRegOt
      AND s.ORAOPROC = 'RECOSENU'
      AND s.ORAOUNID is not null;


    -- se consulta lectura de la orden padre
    CURSOR cuLecturaOrdePadre(nucuorden NUMBER) IS
    SELECT decode(s.capture_order,1, value_1,2,value_2,3, value_3, 4, value_4, 5,value_5, 6, value_6, 7,value_7, 8,value_8, 9,value_9,10,value_10,11,value_11,12,value_12,13, value_13, 14,value_14, 15, value_15, 16, value_16,17, value_17, 18, value_18, 19, value_19, 20,value_20, 'NA') lectura
    FROM or_tasktype_add_data d,
        ge_attrib_set_attrib s,
        ge_attributes A,
        or_requ_data_value r ,
        or_order o
    WHERE d.task_type_id = o.task_type_id
    AND d.attribute_set_id = s.attribute_set_id
    AND s.attribute_id = a.attribute_id
    AND r.attribute_set_id = d.attribute_set_id
    AND r.order_id = o.order_id
    AND o.order_id = nucuorden
    AND d.active = 'Y'
    AND A.attribute_id = nuParametro ;

     --Se consulta tipo de suspension para legalizar
    CURSOR cuTipoSuspencion(nuProducto pr_product.product_id%TYPE) IS
    SELECT  Ge_Suspension_Type.Suspension_Type_Id Id
    FROM    Ge_Suspension_Type,
            Ps_Sustyp_By_Protyp,
            Pr_Product
    WHERE   Pr_Product.Product_Id =  nuProducto
    AND     Ps_Sustyp_By_Protyp.Product_Type_Id = Pr_Product.Product_Type_Id
    AND     Ge_Suspension_Type.Class_Suspension = 'A'
    AND     Ge_Suspension_Type.Suspension_Type_Id = Ps_Sustyp_By_Protyp.Suspension_Type_Id
    AND     Exists
                    (
                        SELECT 'X'
                        FROM   Pr_Prod_Suspension PS
                        WHERE  PS.Product_Id = Pr_Product.Product_Id
                        AND    PS.Suspension_Type_Id = Ge_Suspension_Type.Suspension_Type_Id
                        AND    Active = 'Y'
                    );


    --se obtiene datos de la orden padre
    CURSOR cugetdatoOrdePadre(inuOrden NUMBER) IS
    SELECT  ot.ASSIGNED_DATE , ot.EXEC_INITIAL_DATE, ot.EXECUTION_FINAL_DATE
    FROM or_order ot
    WHERE ot.order_id = inuOrden;

    --se consulta medidor ylectura de instalacion
    CURSOR cugetLectMedi(nuProducto pr_product.product_id%TYPE) IS
    SELECT lm.leemleto, em.emsscoem
    FROM lectelme lm, elmesesu em
    WHERE lm.leemsesu = nuProducto
     AND lm.leemclec = 'I'
     AND em.emsssesu = leemsesu;

     --se consulta medidor ylectura de instalacion
    CURSOR cugetMedidor(nuProducto pr_product.product_id%TYPE) IS
    SELECT em.emsscoem
    FROM elmesesu em
    WHERE em.emsssesu = nuProducto;

    -- se valida la clasificacion de la causal
    CURSOR cuTipoCausal (nuCausal ge_causal.CAUSAL_ID%TYPE ) IS
    SELECT DECODE(CLASS_CAUSAL_ID, 1, 1, 2, 0) tipo
    FROM ge_causal
    WHERE CAUSAL_ID = nuCausal;


  BEGIN
  
  ut_trace.trace('Inicio LDC_PKGESTNUESQSERVNUE.PRJOBASIGLEGORSN', 3);
  
      -- Consultamos datos para inicializar el proceso
     SELECT to_number(to_char(SYSDATE,'YYYY'))
           ,to_number(to_char(SYSDATE,'MM'))
           ,userenv('SESSIONID')
           ,USER INTO nuparano,nuparmes,nutsess,sbparuser
       FROM dual;
      -- Inicializamos el proceso
      ldc_proinsertaestaprog(nuparano,nuparmes,'PRJOBASIGLEGORSN','En ejecucion',nutsess,sbparuser);


      --se legaliza orden de suspension
      FOR reg IN cuOrdenSuspension LOOP
        --se setean valores iniciales
        nuerrorcode := null;
        sberrormessage := null;
        nuOrden := null;
        nuOrden := reg.order_id;
        nuClaseCausal := null;
        nuOk := 0;

        IF  nuOrden IS NOT NULL THEN
          OPEN cugetdatoOrdePadre(reg.ORAPORPA);
          FETCH cugetdatoOrdePadre INTO  dtFechaAsig, dtFechaEjecIni, dtFechaEjecfIN;
          IF cugetdatoOrdePadre%NOTFOUND THEN
              sberrormessage := 'No existen datos de orden Padre: ['||nuOrden||']';
            proRegistraLogLegalizacion('PRJOBASIGLEGORSN', SYSDATE,reg.ORAPORPA, nuOrden, sberrormessage,USER );
              nuOk := -1;
          END IF;
          CLOSE cugetdatoOrdePadre;

          IF nuok <> -1 THEN
            delete LDC_BLOQ_LEGA_SOLICITUD where PACKAGE_ID_GENE = reg.ORAPSOGE;
			
			ut_trace.trace('ingresa api_assign_order nuOrden: ' || nuOrden || CHR(10) ||
											'inuOperatingUnit: ' || reg.ORAOUNID, 6);
			
            -- se procede asignar la orden generada
            api_assign_order(nuOrden, 
							 reg.ORAOUNID, 
							 nuerrorcode, 
							 sberrormessage
							 );
							 
			ut_trace.trace('Finaliza api_assign_order nuerrorcode: ' || nuerrorcode || CHR(10) ||
													 'sberrormessage: ' || sberrormessage, 6);
							 
            IF nuerrorcode = 0 THEN
                UPDATE or_order SET ASSIGNED_DATE = dtFechaAsig WHERE ORDER_ID = nuOrden;

                UPDATE OR_ORDER_STAT_CHANGE SET STAT_CHG_DATE = dtFechaAsig, EXECUTION_DATE = dtFechaAsig
                where INITIAL_STATUS_ID = 0 and FINAL_STATUS_ID = 5 and order_id = nuOrden ;

               -- commit;
                dbms_lock.sleep(1);
                nuerrorcode := null;
                sberrormessage := null;
                --se obtiene clase de causal
                OPEN cuTipoCausal(reg.ORAOCALE);
                FETCH cuTipoCausal INTO nuClaseCausal;
                CLOSE cuTipoCausal;

                IF nuClaseCausal = 1 THEN

                  --se obtiene lectura y medidor
                  OPEN cugetLectMedi(reg.product_id);
                  FETCH cugetLectMedi INTO nuLectura, sbmedidor;
                  CLOSE cugetLectMedi;
                    sbCadenalega := nuOrden||'|'||reg.ORAOCALE||'|'||REG.ORAOPELE||'||'||reg.ORDER_ACTIVITY_ID||'>'||nuClaseCausal||';READING>'||NVL(nuLectura,'')||'>9>;COMMENT1>>>;COMMENT2>>>;COMMENT3>>>||'||sbmedidor||';1='||NVL(nuLectura,'')||'=T===|'||'1277;Orden Legalizada por proceso PRJOBASIGLEGORSN';
                ELSE
                   sbCadenalega := nuOrden||'|'||reg.ORAOCALE||'|'||REG.ORAOPELE||'||'||reg.ORDER_ACTIVITY_ID||'>'||nuClaseCausal||';;READING>>>;COMMENT1>>>;COMMENT2>>>;COMMENT3>>>|||1277;Orden Legalizada por proceso PRJOBASIGLEGORSN';
                END IF;

                ut_trace.trace('Ingresa api_legalizeorders isbDataOrder: '	|| sbCadenalega   || chr(10) ||
													  'idtInitDate: '		|| dtFechaEjecIni || chr(10) ||
													  'idtFinalDate: '		|| dtFechaEjecfIN || chr(10) ||
													  'idtChangeDate: '		|| null, 10);
				
				-- se procede a legalizar la orden de trabajo
                api_legalizeorders(sbCadenalega, 
								   dtFechaEjecIni, 
								   dtFechaEjecfIN, 
								   null, 
								   nuerrorcode, 
								   sberrormessage 
								   );
								   
				ut_trace.trace('Sale api_legalizeorders nuerrorcode: '		|| nuerrorcode   || chr(10) ||
													  'sberrormessage: '	|| sberrormessage, 10);
								   
                dbms_lock.sleep(2);
                -- se valida que todo alla terminado bien
                IF nuerrorcode = 0 THEN
                   NULL;
                   COMMIT;
                ELSE
                 --se llena log
                  proRegistraLogLegalizacion('PRJOBASIGLEGORSN', SYSDATE,reg.ORAPORPA, nuOrden, sberrormessage,USER );
                  ROLLBACK;
                END IF;
            ELSE
              --se llena log
              proRegistraLogLegalizacion('PRJOBASIGLEGORSN', SYSDATE,reg.ORAPORPA, nuOrden, sberrormessage,USER );
              ROLLBACK;
            END IF;
          END IF;
        
		END IF;

      END LOOP;

      --se legaliza orden de suspension
      FOR reg IN cuOrdenReconexion LOOP
        --se setean valores iniciales
        nuerrorcode := null;
        sberrormessage := null;
        nuOrden := null;
        nuOrden := reg.order_id;
        nuClaseCausal := null;
        nuOk := 0;

        IF  nuOrden IS NOT NULL THEN
          OPEN cugetdatoOrdePadre(reg.ORAPORPA);
          FETCH cugetdatoOrdePadre INTO  dtFechaAsig, dtFechaEjecIni, dtFechaEjecfIN;
          IF cugetdatoOrdePadre%NOTFOUND THEN
              sberrormessage := 'No existen datos de orden Padre: ['||nuOrden||']';
            proRegistraLogLegalizacion('PRJOBASIGLEGORSN', SYSDATE,reg.ORAPORPA, nuOrden, sberrormessage,USER );
              nuOk := -1;
          END IF;
          CLOSE cugetdatoOrdePadre;

          IF nuok <> -1 THEN
            delete LDC_BLOQ_LEGA_SOLICITUD where PACKAGE_ID_GENE = reg.ORAPSOGE;
			
            ut_trace.trace('ingresa 2 api_assign_order nuOrden: ' || nuOrden || CHR(10) ||
													  'inuOperatingUnit: ' || reg.ORAOUNID, 6);
			
			-- se procede asignar la orden generada
            api_assign_order(nuOrden, 
							 reg.ORAOUNID, 
							 nuerrorcode, 
							 sberrormessage
							 );
							 
			ut_trace.trace('Finaliza api_assign_order nuerrorcode: ' || nuerrorcode || CHR(10) ||
													 'sberrormessage: ' || sberrormessage, 6);
			
            IF nuerrorcode = 0 THEN
                UPDATE or_order SET ASSIGNED_DATE = dtFechaAsig WHERE ORDER_ID = nuOrden;

                UPDATE OR_ORDER_STAT_CHANGE SET STAT_CHG_DATE = dtFechaAsig, EXECUTION_DATE = dtFechaAsig
                where INITIAL_STATUS_ID = 0 and FINAL_STATUS_ID = 5 and order_id = nuOrden ;

               -- commit;
                dbms_lock.sleep(1);
                nuerrorcode := null;
                sberrormessage := null;
                --se obtiene clase de causal
                OPEN cuTipoCausal(reg.ORAOCALE);
                FETCH cuTipoCausal INTO nuClaseCausal;
                CLOSE cuTipoCausal;

                IF nuClaseCausal = 1 THEN
                  --se obtiene tipo de suspension a legalziar
                  OPEN cuTipoSuspencion(reg.product_id);
                  FETCH cuTipoSuspencion INTO nuTipoSuspLega;
                  CLOSE cuTipoSuspencion;

                  --lectura de orden
                  OPEN cuLecturaOrdePadre(reg.product_id);
                  FETCH cuLecturaOrdePadre INTO nuLectura;
                  IF cuLecturaOrdePadre%NOTFOUND THEN
                     nuLectura :=  reg.ORAOITEM;
                  END IF;
                  CLOSE cuLecturaOrdePadre;

                  --se obtiene  medidor
                  OPEN cugetMedidor(reg.product_id);
                  FETCH cugetMedidor INTO sbmedidor;
                  CLOSE cugetMedidor;

                  sbCadenalega := nuOrden||'|'||reg.ORAOCALE||'|'||REG.ORAOPELE||'||'||reg.ORDER_ACTIVITY_ID||'>'||nuClaseCausal||';READING>'||NVL(nuLectura,'')||'>9>;SUSPENSION_TYPE>'||NVL(nuTipoSuspLega,'')||'>>;;|'||''||'|'||sbmedidor||';1='||NVL(nuLectura,'')||'=T===|'||'1277;Orden Legalizada por proceso PRJOBASIGLEGORSN';

                ELSE
                   sbCadenalega := nuOrden||'|'||reg.ORAOCALE||'|'||REG.ORAOPELE||'||'||reg.ORDER_ACTIVITY_ID||'>'||nuClaseCausal||';READING>>>;SUSPENSION_TYPE>>>;;|'||''||'||1277;Orden Legalizada por proceso PRJOBASIGLEGORSN';
                END IF;

                ut_trace.trace('Ingresa api_legalizeorders isbDataOrder: '	|| sbCadenalega   || chr(10) ||
													  'idtInitDate: '		|| dtFechaEjecIni || chr(10) ||
													  'idtFinalDate: '		|| dtFechaEjecfIN || chr(10) ||
													  'idtChangeDate: '		|| null, 10);
				
				-- se procede a legalizar la orden de trabajo
                api_legalizeorders(sbCadenalega, 
								  dtFechaEjecIni, 
								  dtFechaEjecfIN, 
								  null, 
								  nuerrorcode, 
								  sberrormessage 
								  );
								  
				ut_trace.trace('Sale api_legalizeorders nuerrorcode: '		|| nuerrorcode   || chr(10) ||
													  'sberrormessage: '	|| sberrormessage, 10);
								  
                dbms_lock.sleep(2);
                -- se valida que todo alla terminado bien
                IF nuerrorcode = 0 THEN
                   NULL;
                   COMMIT;
                ELSE
                 --se llena log
                  proRegistraLogLegalizacion('PRJOBASIGLEGORSN', SYSDATE,reg.ORAPORPA, nuOrden, sberrormessage,USER );
                  ROLLBACK;
                END IF;
            ELSE
              --se llena log
              proRegistraLogLegalizacion('PRJOBASIGLEGORSN', SYSDATE,reg.ORAPORPA, nuOrden, sberrormessage,USER );
              ROLLBACK;
            END IF;
          END IF; 
        END IF;

      END LOOP;
      ldc_proactualizaestaprog(nutsess,sberrormessage,'PRJOBASIGLEGORSN','Ok');
   
   ut_trace.trace('Fin LDC_PKGESTNUESQSERVNUE.PRJOBASIGLEGORSN', 3);


 EXCEPTION
    WHEN PKG_ERROR.controlled_error THEN
		ut_trace.trace('LDC_PKGESTNUESQSERVNUE.PRJOBASIGLEGORSN PKG_ERROR.controlled_error', 3);
        Pkg_error.geterror(nuerrorcode, sberrormessage);
        proRegistraLogLegalizacion('PRJOBASIGLEGORSN', SYSDATE,null, nuOrden, sberrormessage,USER );
        RAISE;
     WHEN OTHERS THEN
		ut_trace.trace('LDC_PKGESTNUESQSERVNUE.PRJOBASIGLEGORSN OTHERS', 3);
		Pkg_error.seterror;
		Pkg_error.geterror(nuerrorcode, sberrormessage);
		ldc_proactualizaestaprog(nutsess,sberrormessage,'PRJOBASIGLEGORSN','Ok');
		proRegistraLogLegalizacion('PRJOBASIGLEGORSN', SYSDATE,null, nuOrden, sberrormessage,USER );
		rollback;
  END PRJOBASIGLEGORSN;

  PROCEDURE PRVALORDCERTPEND(inuProducto IN NUMBER) IS
 /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2019-12-9
      Proceso     : PRVALORDCERTPEND
      Ticket      : 19
      Descripcion : proceso que valida si un producto tiene orden de certificacion pendiente


      Parametros Entrada
        inuOrden   NUMERO DE ORDEN

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        	AUTOR       	DESCRIPCION
	  ===========	=============	=============================
	  24/07/2023	jerazomvm		CASO OSF-1261:
									1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
									2. Se elimina la funcion fblAplicaEntregaxCaso, para la entrega la cual retorna true.
  ***************************************************************************/
   nuerrorcode NUMBER;
   sberrormessage VARCHAR2(4000);

   sbTitrCert VARCHAR2(100) := DALD_PARAMETER.fsbGetValue_Chain('LDC_TRABCERT',  NULL); --se almacena tipo de trabajo de certificacion
   sbDatos VARCHAR2(1);
   SbcategoPerm  VARCHAR2(100) := DALD_PARAMETER.fsbGetValue_Chain('LDC_CATPERRETCSN',  NULL);  --se almacena categorias permitidas para tramite de cert sn

   --se valdia si el producto tiene orden de certificacion pendiente
   CURSOR cuValidaOrd IS
   SELECT 'X'
   FROM or_order o, or_order_activity oa
   WHERE o.order_id = oa.order_id
    AND o.task_type_id in ( SELECT to_number(regexp_substr(sbTitrCert,'[^,]+', 1, LEVEL)) AS titr
                              FROM   dual
                             CONNECT BY regexp_substr(sbTitrCert, '[^,]+', 1, LEVEL) IS NOT NULL)
    AND o.order_status_id not in (select oe.order_status_id
                                  from or_order_status oe
                                  where oe.IS_FINAL_STATUS = 'Y')
    AND oa.product_id = inuProducto;
    
    cursor cuValidaCate IS
    SELECT 'X'
    FROM (  SELECT to_number(regexp_substr(SbcategoPerm,'[^,]+', 1, LEVEL)) AS categ
              FROM   dual
             CONNECT BY regexp_substr(SbcategoPerm, '[^,]+', 1, LEVEL) IS NOT NULL)
    WHERE categ = dapr_product.fnugetcategory_id(inuProducto, null);
    
    cursor cuValiCert IS
    SELECT 'X'
    FROM pr_certificate
    WHERE product_id = inuProducto;
    

  BEGIN
 
          --se valida categoria
          OPEN cuValidaCate;
          FETCH cuValidaCate INTO sbDatos;
          IF cuValidaCate%NOTFOUND THEN
             CLOSE cuValidaCate;
              Pkg_error.SetErrorMessage(2741, 'categoria del Producto ['||inuProducto||'] no permitida para este proceso, por favor valide parametro LDC_CATPERRETCSN.');
              RAISE PKG_ERROR.controlled_error ;
          END IF;
          CLOSE cuValidaCate;
          
          --se valida certificado
          OPEN cuValiCert;
          FETCH cuValiCert INTO sbDatos;
          IF cuValiCert%FOUND THEN
             CLOSE cuValiCert;
              Pkg_error.SetErrorMessage(2741, 'Producto ['||inuProducto||'] ya se encuentra certificado.');
              RAISE PKG_ERROR.controlled_error ;
          END IF;
          CLOSE cuValiCert;
          
          --se valida ordenes pendiente
          OPEN cuValidaOrd;
          FETCH cuValidaOrd INTO sbDatos;
          IF cuValidaOrd%FOUND THEN
            CLOSE cuValidaOrd;
             Pkg_error.SetErrorMessage(2741, 'Producto ['||inuProducto||'] tiene ordenes de certificacion pendientes.');
              RAISE PKG_ERROR.controlled_error ;
          END IF;
          CLOSE cuValidaOrd;
		  
  EXCEPTION
    WHEN PKG_ERROR.controlled_error THEN
        Pkg_error.geterror(nuerrorcode, sberrormessage);
        RAISE PKG_ERROR.controlled_error ;
     WHEN OTHERS THEN
       Pkg_error.seterror;
      Pkg_error.geterror(nuerrorcode, sberrormessage);
       RAISE PKG_ERROR.controlled_error ;
  END PRVALORDCERTPEND;

  PROCEDURE PRJOBGENNOTISUSP IS
  /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2020-02-13
      Proceso     : PRJOBGENNOTISUSP
      Ticket      : 19
      Descripcion : job que se encarga de generar orden de notificacion


      Parametros Entrada

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
      04/06/2020   HORBATH     CASO 19: Modificar el cursor cugetProduNoti del servicio PRJOBGENNOTISUSP
                                        se la adicionara  una nueva validacaion donde el campo CATEGORY_ID
                                        valide si existe en el nuevo parametro llamado COD_CATEGORIA_NOTIFICACION
      15/04/2021   OLSOFTWARE     CA 705 se agrega condicion para que se validen ordenes 11156 legalizada con exito
	  24/07/2023	jerazomvm		CASO OSF-1261:
									1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
									2. Se elimina la funcion fblAplicaEntregaxCaso, para la entrega la cual retorna true.
									3. Se reemplaza el llamado del método or_boorderactivities.createactivity,
									   por el API api_createorder.
  ***************************************************************************/
   nuerrorcode NUMBER;
   sberrormessage VARCHAR2(4000);
   nupRODUCTO NUMBER;
   sbEstaprod VARCHAR2(400) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_ESACPROD',NULL); --estado del producto a validar
   sbTitrCert VARCHAR2(100) := DALD_PARAMETER.fsbGetValue_Chain('LDC_TITR_VALIDA_IMPRESION',  NULL); --se almacena tipo de trabajo de certificacion
   nuActividaGen NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_ACTNOTIGEN', NULL); --se alamacena actividad de notificacion a  generar
   nuTipoServ NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('COD_SERV_GAS', NULL);  --se almacena tipo de producto de gas
   nuOrderId NUMBER;
   nuNewOrderActivityId         or_order_activity.order_activity_id%type;

     --variables para el log
    nuparano NUMBER;
    nuparmes NUMBER;
    nutsess  NUMBER;
    sbparuser VARCHAR2(4000);
    --inicio ca 705
    sbTitrNotiVa varchar2(4000) := DALD_PARAMETER.fsbGetValue_Chain('LDC_TITRNOTISUSP',  NULL); --se almacenan los tipo de trabajo
    SBcatgeorias VARCHAR2(400) := dald_parameter.fsbgetvalue_chain('COD_CATEGORIA_NOTIFICACION', NULL);
    --fin ca 705
    --se consulta productos a notificar
    CURSOR cugetProduNoti IS
    select p.PRODUCT_ID PRODUCTO, P.ADDRESS_ID DIRECCION, p.SUBSCRIPTION_ID CONTRATO, (SELECT SUSCCLIE FROM suscripc WHERE P.SUBSCRIPTION_ID = SUSCCODI   ) CLIENTE
    from PR_PRODUCT p
    WHERE  p.product_type_id = nuTipoServ
     AND p.PRODUCT_STATUS_ID IN (SELECT to_number(regexp_substr(sbEstaprod,'[^,]+', 1, LEVEL)) AS espr
                                  FROM   dual
                                 CONNECT BY regexp_substr(sbEstaprod, '[^,]+', 1, LEVEL) IS NOT NULL)
     AND NOT EXISTS (SELECT 1 FROM PR_CERTIFICATE PR WHERE PR.PRODUCT_ID = P.PRODUCT_ID)
     AND  NOT EXISTS ( SELECT 1
                         FROM or_order o, or_order_activity oa
                        WHERE o.order_id = oa.order_id
                          and oa.PRODUCT_ID = p.PRODUCT_ID
                          and O.TASK_TYPE_ID IN (SELECT to_number(regexp_substr(sbTitrCert,'[^,]+', 1, LEVEL)) AS titr
                                                  FROM   dual
                                                 CONNECT BY regexp_substr(sbTitrCert, '[^,]+', 1, LEVEL) IS NOT NULL)
                          AND (O.ORDER_STATUS_ID NOT IN
                                                      (SELECT OE.ORDER_STATUS_ID 
                                                        FROM OR_ORDER_STATUS OE WHERE OE.IS_FINAL_STATUS = 'Y')
                             or  ( o.task_type_id in ( SELECT to_number(regexp_substr(sbTitrNotiVa,'[^,]+', 1, LEVEL)) AS titr                                                  
                                                       FROM  dual          
                                                       CONNECT BY regexp_substr(sbTitrNotiVa, '[^,]+', 1, LEVEL) IS NOT NULL) 
									and o.order_status_id = 8 and DAGE_CAUSAL.FNUGETCLASS_CAUSAL_ID(o.causal_id, null) = 1 ))
                       
                        )
      AND category_id IN
             ( SELECT to_number(regexp_substr(SBcatgeorias,'[^,]+', 1, LEVEL)) AS cate                                                  
               FROM  dual          
               CONNECT BY regexp_substr(SBcatgeorias, '[^,]+', 1, LEVEL) IS NOT NULL);
  BEGIN
   
       -- Consultamos datos para inicializar el proceso
     SELECT to_number(to_char(SYSDATE,'YYYY'))
           ,to_number(to_char(SYSDATE,'MM'))
           ,userenv('SESSIONID')
           ,USER INTO nuparano,nuparmes,nutsess,sbparuser
       FROM dual;
      -- Inicializamos el proceso
      ldc_proinsertaestaprog(nuparano,nuparmes,'PRJOBGENNOTISUSP','En ejecucion',nutsess,sbparuser);

         FOR reg IN cugetProduNoti LOOP
             begin
               nuOrderId :=null;
                nuerrorcode := null;
                sberrormessage := null;
                nuNewOrderActivityId := null;
               --se crea orden de trabajo
               api_createorder(inuitemsid          => nuActividaGen,
                               inupackageid        => null,
                               inumotiveid         => null,
                               INUCOMPONENTID      => null,
                               INUINSTANCEID       => null,
                               INUADDRESSID        => reg.DIRECCION,
                               INUELEMENTID        => null,
                               INUSUBSCRIBERID     => REG.CLIENTE,
                               INUSUBSCRIPTIONID   => REG.CONTRATO,
                               INUPRODUCTID        => REG.PRODUCTO,
							   INUOPERUNITID       => null,
							   IDTEXECESTIMDATE    => null,
							   INUPROCESSID        => null,
							   ISBCOMMENT          => 'ORDEN GENERADA POR PROCESO PRJOBGENNOTISUSP',
							   IBLPROCESSORDER     => null,
							   INUPRIORITYID       => null,
							   INUORDERTEMPLATEID  => null,
							   ISBCOMPENSATE       => null,
							   INUCONSECUTIVE      => null,
							   INUROUTEID          => null,
							   INUROUTECONSECUTIVE => null,
							   INULEGALIZETRYTIMES => 0, ---null,200-2686
							   ISBTAGNAME          => null,
							   IBLISACTTOGROUP     => null,
							   INUREFVALUE         => null,
							   INUACTIONID         => null,                                                                                                                                                                
                               IONUORDERID         => nuOrderId,
                               IONUORDERACTIVITYID => nuNewOrderActivityId,                                   
							   ONUERRORCODE		   => nuerrorcode,
							   OSBERRORMESSAGE	   => sberrormessage                               
							   );

                IF nvl(nuOrderId, 0) != 0 then
                 COMMIT;
                ELSE
                  Pkg_error.GETERROR(nuerrorcode, sberrormessage);
                  proRegistraLogLegalizacion('PRJOBGENNOTISUSP', SYSDATE,null, REG.PRODUCTO, sberrormessage,USER );
                  ROLLBACK;
                END IF;
             exception
               when others then
                 proRegistraLogLegalizacion('PRJOBGENNOTISUSP', SYSDATE,null, REG.PRODUCTO, SQLERRM,USER );
                 ROLLBACK;
             end;
         END LOOP;
      ldc_proactualizaestaprog(nutsess,sberrormessage,'PRJOBGENNOTISUSP','Ok');

  EXCEPTION
    WHEN PKG_ERROR.controlled_error THEN
        Pkg_error.geterror(nuerrorcode, sberrormessage);
        ldc_proactualizaestaprog(nutsess,sberrormessage,'PRJOBGENNOTISUSP','ERROR');
         proRegistraLogLegalizacion('PRJOBGENNOTISUSP', SYSDATE,null, nupRODUCTO, sberrormessage,USER );
            ROLLBACK;
        RAISE  ;
     WHEN OTHERS THEN
         Pkg_error.seterror;
        Pkg_error.geterror(nuerrorcode, sberrormessage);
      ldc_proactualizaestaprog(nutsess,sberrormessage,'PRJOBGENNOTISUSP','ERROR');
      proRegistraLogLegalizacion('PRJOBGENNOTISUSP', SYSDATE,null, nupRODUCTO, sberrormessage,USER );
      ROLLBACK;
  END PRJOBGENNOTISUSP;

  PROCEDURE PRVALILECTSUSP IS
  /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2020-02-17
      Proceso     : PRVALILECTSUSP
      Ticket      : 19
      Descripcion : plugin que valida si la lectura de suspension es menor a la configurada en
                   el parametro LDC_LECTMINLEGA

      Parametros Entrada

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        	AUTOR       	DESCRIPCION
	  ===========	=============	=============================
	  24/07/2023	jerazomvm		CASO OSF-1261:
									1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
									2. Se elimina la funcion fblAplicaEntregaxCaso, para la entrega la cual retorna true.
  ***************************************************************************/
   nuerrorcode NUMBER; --se almacena codigo de error
   sberrormessage VARCHAR2(4000); --se almacena mensaje de error
   nuOrderId NUMBER; --se almacen orden de trabajo
   nuClaseCausal NUMBER; --clase de causal
   --Se cambia el paremtro para buscar actividad del codigo 100008464 en el parametro COD_SUSP_CENT_MEDI_LEC
   nuActivNoti NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('COD_SUSP_CENT_MEDI_LEC', NULL); --se almacena actividad de suspension
   nuLecturaMini NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_LECTMINLEGA', NULL); --se almacena lectura minima

   sbDatos VARCHAR2(1); --se almacena resultado de la validacion de la actividad
   nuLectura NUMBER; --se almacena lectura de legalizacion
   dtFechaFinEj DATE; --se almacena fecha de ejecucion
   nuProducto NUMBER; --se almacena codigo del producto

   --se valida actividad de la ordem
   CURSOR cuValidaActi IS
   SELECT oa.product_id
   FROM or_order_activity oa
   WHERE oa.order_id = nuOrderId
    AND oa.activity_id = nuActivNoti;

    --se consulta medidor ylectura de instalacion
    CURSOR cugetLectMedi IS
    SELECT lm.leemleto
    FROM lectelme lm
    WHERE lm.leemsesu = nuProducto
     AND trunc(lm.leemfele) = trunc(dtFechaFinEj);

  BEGIN

      nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder; -- Obtenemos la orden que se esta legalizando
      nuClaseCausal := dage_causal.fnugetclass_causal_id(Daor_order.fnugetCausal_id(nuOrderId, null), null); --se obtiene clase de causal

      --UT_TRACE.TRACE('nuOrderId['|| nuOrderId|| '] - nuClaseCausal['|| nuClaseCausal||']', 10);

      --se valida clase de causal de legalizacion
      IF nuClaseCausal = 1 THEN
        --se valida la actviidad de la orden
        OPEN cuValidaActi;
        FETCH cuValidaActi INTO nuProducto;
        CLOSE cuValidaActi;

        --UT_TRACE.TRACE('nuProducto['|| nuProducto|| ']', 10);

        --si la actividad es de notificacion se valida lectura
        IF nuProducto IS NOT NULL THEN
          dtFechaFinEj := trunc(daor_order.fdtgetexecution_final_date(nuorderid));

          --UT_TRACE.TRACE('dtFechaFinEj['|| dtFechaFinEj|| ']', 10);

          OPEN cugetLectMedi;
          FETCH cugetLectMedi INTO nuLectura;
          CLOSE cugetLectMedi;

          --UT_TRACE.TRACE('nuLectura['|| nuLectura|| '] - nuLecturaMini[' || nuLecturaMini || ']', 10);

          IF NVL(nuLectura,0) < NVL(nuLecturaMini,0) THEN
             Pkg_error.SetErrorMessage(2741, 'La lectura de Suspension ['||nuLectura||'] no puede ser menor a la lecura minima ['||nuLecturaMini||'].');
             RAISE PKG_ERROR.controlled_error ;
          END IF;
        END IF;
      END IF;
 

  EXCEPTION
    WHEN PKG_ERROR.controlled_error THEN
        Pkg_error.geterror(nuerrorcode, sberrormessage);
         RAISE  PKG_ERROR.controlled_error;
     WHEN OTHERS THEN
       Pkg_error.seterror;
      Pkg_error.geterror(nuerrorcode, sberrormessage);
      RAISE PKG_ERROR.controlled_error;
  END PRVALILECTSUSP;

  PROCEDURE 	PRMARUSUSUSP IS
  /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2020-02-17
      Proceso     : PRMARUSUSUSP
      Ticket      : 19
      Descripcion : plugin que se encarga de marcar los productos
                    que se van a suspender en la tabla LDC_PRODNOTASUSP

      Parametros Entrada

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
      15/04/2021   olosftware  ca 705 validar que si producto esta certificado o ya existe
                              en la tabla LDC_PRODNOTASUSP en estado N, no se haga el insert en la tabla
                              LDC_PRODNOTASUSP 
	  24/07/2023	jerazomvm		CASO OSF-1261:
									1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
									2. Se elimina la funcion fblAplicaEntregaxCaso, para la entrega la cual retorna true.
  ***************************************************************************/
   nuerrorcode NUMBER; -- se almacena codigo de error
   sberrormessage VARCHAR2(4000); --se almacena mensaje de error
   nuOrderId NUMBER; --se almacena orden de trabajo
   nuProduCto NUMBER; --se almacena codigo del producto
   nuCliente	ge_subscriber.subscriber_id%type;--almacenara el codidgo del cliente
   nuDias NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_NUMDIES', NULL); --se almacena numero de dias

   --se consulta codigo de producto
   CURSOR cugetProducto IS
   SELECT oa.product_id, subscriber_id
   FROM OR_ORDER_ACTIVITY oa
   WHERE oa.order_id = nuOrderId;

   --inicio ca 705
   sbexiste VARCHAR2(1);
   
   CURSOR cuValidaCerti IS
   SELECT 'X'
   FROM pr_certificate
   WHERE PRODUCT_ID = nuProduCto;
   
   CURSOR cuValiProdenproce IS
   SELECT 'X'
   FROM LDC_PRODNOTASUSP
   WHERE PRNOPROD = nuProduCto
    AND PRNOGESU = 'N';
   --fin ca 705
  BEGIN
   
    nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder; -- Obtenemos la orden que se esta legalizando

    OPEN cugetProducto;
    FETCH cugetProducto INTO nuProduCto, nuCliente;
    CLOSE cugetProducto; 
    
	--se valida certificado
    OPEN cuValidaCerti;
    FETCH cuValidaCerti INTO sbexiste;
      
	IF cuValidaCerti%FOUND THEN
		CLOSE cuValidaCerti;
        RETURN;
    END IF;
        
	CLOSE cuValidaCerti;
        
	--se valida producto en proceso
    OPEN cuValiProdenproce;
    FETCH cuValiProdenproce INTO sbexiste;
        
	IF cuValiProdenproce%FOUND THEN
		CLOSE cuValiProdenproce;
        RETURN;
    END IF;
        
	CLOSE cuValiProdenproce;

    INSERT INTO LDC_PRODNOTASUSP
    (
		PRNOPROD,  PRNOCLIE,   PRNOORPA,    PRNOFELE,    PRNOFEGS
    )
    VALUES
    (
		nuProduCto, nuCliente, nuOrderId,   SYSDATE,  SYSDATE + nuDias
    );

  EXCEPTION
    WHEN PKG_ERROR.controlled_error THEN
        Pkg_error.geterror(nuerrorcode, sberrormessage);
         RAISE  PKG_ERROR.controlled_error;
     WHEN OTHERS THEN
         Pkg_error.seterror;
        Pkg_error.geterror(nuerrorcode, sberrormessage);
      RAISE PKG_ERROR.controlled_error;
  END PRMARUSUSUSP;

  PROCEDURE	PRJOBGENSUSPSERVNU IS
  /**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2020-02-18
    Proceso     : PRJOBGENSUSPSERVNU
    Ticket      : 19
    Descripcion : job que se encarga de generar la suspension de servicio nuevo

    Parametros Entrada

    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
    15/04/2021   olsoftware   ca 705 validar si el producto  está certificado  no procese ese producto
                              y se cambien el estado a S.
	24/07/2023	jerazomvm		CASO OSF-1261:
								1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
								2. Se elimina la funcion fblAplicaEntregaxCaso, para la entrega la cual retorna true.
  ***************************************************************************/
    nuerrorcode NUMBER; -- se almacena codigo de error
    sberrormessage VARCHAR2(4000); --se almacena mensaje de error
    nuPackage_id NUMBER;--se almacena codigo de suspension
    nuMotiveId NUMBER; --se almacena codigo de motivo

    --se obtiene productos para suspender
    CURSOR cuProduSusp IS
    SELECT *
    FROM LDC_PRODNOTASUSP
    WHERE PRNOGESU  = 'N'
     AND PRNOFEGS <= SYSDATE;
     
      --inicio ca 705
   sbexiste VARCHAR2(1);
   
   CURSOR cuValidaCerti(nuProduCto NUMBER) IS
   SELECT 'X'
   FROM pr_certificate
   WHERE PRODUCT_ID = nuProduCto;
   
   --finc a 705

  BEGIN

     FOR reg IN cuProduSusp LOOP
       sbexiste := NULL;
       
    OPEN cuValidaCerti(reg.PRNOPROD);
    FETCH cuValidaCerti INTO sbexiste;
    CLOSE cuValidaCerti;          
          
       IF sbexiste IS NULL THEN
          prGeneSuspServNuevo( reg.PRNOPROD,
                               reg.PRNOCLIE,
                               inuSUSPENSION_TYPE_ID,
                               nutipoCausal,
                               nuCausal,
                               'GENERACION DE SUSPENSION POR JOB PRJOBGENSUSPSERVNU',
                               nuPackage_id,
                               nuMotiveId,
                               nuerrorcode,
                               sberrormessage);

            IF nuerrorcode <> 0 then
               proRegistraLogLegalizacion('PRJOBGENSUSPSERVNU', SYSDATE,null, REG.PRNOPROD, sberrormessage,USER );
               ROLLBACK;
            ELSE
              UPDATE LDC_PRODNOTASUSP SET PRNOGESU = 'S', PRNOSOSU = nuPackage_id
              WHERE PRNOORPA = reg.PRNOORPA;
              COMMIT;
            END IF;
        ELSE
            UPDATE LDC_PRODNOTASUSP SET PRNOGESU = 'S'
            WHERE PRNOORPA = reg.PRNOORPA;
            COMMIT;
        END IF;
     END LOOP;
   
   EXCEPTION
    WHEN PKG_ERROR.controlled_error THEN
        Pkg_error.geterror(nuerrorcode, sberrormessage);
         RAISE  PKG_ERROR.controlled_error;
     WHEN OTHERS THEN
        Pkg_error.seterror;
        Pkg_error.geterror(nuerrorcode, sberrormessage);
      RAISE PKG_ERROR.controlled_error;
  END PRJOBGENSUSPSERVNU;

   PROCEDURE		PRANULORDCERYSUS(inuProducto IN pr_product.product_id%type) IS
   /**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2020-02-18
    Proceso     : PRANULORDCERYSUS
    Ticket      : 19
    Descripcion : proceso que anula ordenes de suspension y certificacion

    Parametros Entrada
     inuProducto  codigo del producto

    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
    05/06/2020   HORBATH     CASO 19: Agregar servicio de anulacion de flujo y commentaria en COMMIT
	24/07/2023	 jerazomvm		CASO OSF-1261:
								1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
								2. Se elimina la funcion fblAplicaEntregaxCaso, para la entrega la cual retorna true.
    ***************************************************************************/
    nuerrorcode NUMBER; -- se almacena codigo de error
    sberrormessage VARCHAR2(4000); --se almacena mensaje de error
    nuCausal NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_CAANUORDEN', NULL); --se almacena causal de legalizacion
    sbTitrServNue  VARCHAR2(4000) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_TITRSERNUEV', NULL); --se almacena tipo de trabajos servicio nuevo
    cnuCommentType NUMBER := 83;
    nuEstadoAnu NUMBER := dald_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ANULADA');
    nuEstaAnuOt NUMBER := dald_parameter.fnuGetNumeric_Value('COD_STATE_CANCEL_OT');
    nuPlanId NUMBER;
   
    sbfrom        VARCHAR2(4000) := dald_parameter.fsbgetvalue_chain('LDC_SMTP_SENDER'); --  se coloca el emisor del correo
    sbfromdisplay VARCHAR2(4000) := 'Open SmartFlex';  
    sbsubject VARCHAR2(4000) := 'Anulacion de ordenes de Servicio Nuevo';
    sbmsg VARCHAR2(4000) := 'Se anulo orden [';
    sbTipoSoli VARCHAR2(200) :=  dald_parameter.fsbgetvalue_chain('LDC_SOLCERTSENU', NULL);
    nuTipoTrab  number :=  dald_parameter.fnugetnumeric_value('TT_VEN_INI', NULL);
    nuExistCert NUMBER;
       
    CURSOR cugetOrdeSev IS
    SELECT O.ORDER_ID, decode(o.task_type_id,nuTipoTrab, 1,0) ttcert,  OA.PACKAGE_ID, damo_packages.fnugetpackage_type_id(oa.package_id, null) tiposoli, daor_operating_unit.fsbgete_mail(o.operating_unit_id, null) correo
    FROM or_order o, or_order_activity oa
    WHERE o.order_id = oa.order_id
     AND o.task_type_id IN ( SELECT to_number(regexp_substr(sbTitrServNue,'[^,]+', 1, LEVEL)) AS titr
                             FROM   dual
                             CONNECT BY regexp_substr(sbTitrServNue, '[^,]+', 1, LEVEL) IS NOT NULL)
     AND o.order_status_id NOT IN ( SELECT order_status_id
                                    FROM or_order_status
                                    WHERE IS_FINAL_STATUS = 'Y')
    AND oa.product_id = inuProducto;

  BEGIN
    
       FOR i IN cugetOrdeSev LOOP        
         nuExistCert := 0;
        IF I.ttcert = 1 THEN
            SELECT COUNT(1) INTO nuExistCert
            FROM(
               SELECT to_number(regexp_substr(sbTipoSoli,'[^,]+', 1, LEVEL)) AS tisol
               FROM   dual
               CONNECT BY regexp_substr(sbTipoSoli, '[^,]+', 1, LEVEL) IS NOT NULL)
             WHERE tisol =  I.tiposoli;
        END IF;
        IF (nuExistCert = 1 and I.ttcert = 1) or I.ttcert = 0  THEN      
          savepoint ldccancelorder;
          ldc_cancel_order(
                            i.order_id,
                            nuCausal,
                            'Anulacion de orden por certificacion de servicio nuevo',
                            cnuCommentType,
                            nuerrorcode,
                            sberrormessage
                            );
  
            IF nuerrorcode <> 0 THEN
              ROLLBACK TO SAVEPOINT ldccancelorder;
              proRegistraLogLegalizacion('PRANULORDCERYSUS', SYSDATE,null, I.order_id, sberrormessage,USER );
            ELSE
                UPDATE or_order_activity
                SET status = 'F'
                WHERE order_id = i.order_id;
                --Cambia estado a la Orden
                UPDATE or_order
                SET order_status_id = nuEstaAnuOt
                WHERE order_id = i.order_id;            
  
                IF I.PACKAGE_ID IS NOT NULL  THEN
                   UPDATE mo_packages
                    SET motive_status_id = nuEstadoAnu
                  WHERE package_id = I.PACKAGE_ID;
  
                  --Cambio estado del motivo
                  UPDATE mo_motive
                     SET annul_date         = SYSDATE,
                         status_change_date = SYSDATE,
                         annul_causal_id    = ge_boparameter.fnuget('ANNUL_CAUSAL'),
                         motive_status_id   = 5,
                         causal_id          = 287
                   WHERE package_id = I.PACKAGE_ID;
                   -- Se obtiene el plan de wf
                    BEGIN
                      nuPlanId := wf_boinstance.fnugetplanid(I.PACKAGE_ID, 17);
                      mo_boannulment.annulwfplan(nuPlanId);
                      
                      if i.correo is not null then
                       begin
                         sbmsg := sbmsg||I.order_id||'] por certificacion.';
                       --se envia correo
					   
					   	  pkg_Correo.prcEnviaCorreo
							(
								isbRemitente        => sbfrom,
								isbDestinatarios    => i.correo,
								isbAsunto           => sbsubject,
								isbMensaje          => sbmsg
							);

					   
                       exception
                         when others then
                          proRegistraLogLegalizacion('PRANULORDCERYSUS', SYSDATE,null, I.order_id, sqlerrm,USER );
                       end;
                      end if;
                      
                    EXCEPTION
                      WHEN OTHERS THEN
                       Pkg_error.SETERROR;
                       Pkg_error.GETERROR(nuerrorcode,sberrormessage);
                       ROLLBACK TO SAVEPOINT ldccancelorder;
                       proRegistraLogLegalizacion('PRANULORDCERYSUS', SYSDATE,null, I.order_id, sberrormessage,USER );
                   END;
                   
                END IF;
  
            END IF;
        END IF;

      END LOOP;

  EXCEPTION
    WHEN PKG_ERROR.controlled_error THEN
        Pkg_error.geterror(nuerrorcode, sberrormessage);
        proRegistraLogLegalizacion('PRANULORDCERYSUS', SYSDATE,null, -1, sberrormessage,USER );
         RAISE  PKG_ERROR.controlled_error;
     WHEN OTHERS THEN
        Pkg_error.seterror;
        Pkg_error.geterror(nuerrorcode, sberrormessage);
         proRegistraLogLegalizacion('PRANULORDCERYSUS', SYSDATE,null, -1, sberrormessage,USER );

      RAISE PKG_ERROR.controlled_error;
  END PRANULORDCERYSUS;

  PROCEDURE 	PRGENTRAMCERT IS
   /**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2020-02-18
    Proceso     : PRGENTRAMCERT
    Ticket      : 19
    Descripcion : proceso se encarga de generar tramite de certificacion

    Parametros Entrada
     inuProducto  codigo del producto

    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
	===========	=============	=============================
	24/07/2023	jerazomvm		CASO OSF-1261:
								1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
								2. Se elimina la funcion fblAplicaEntregaxCaso, para la entrega la cual retorna true.
  ***************************************************************************/
    nuOrderId NUMBER; --se almacena orden de trabajo
    nuClaseCausal NUMBER; --se almacena clase de causal
    nuproducto NUMBER; --se almacena codigo del producto
    nuError  NUMBER; --se almacena codigo de error
    sbError VARCHAR2(4000); --se almacena mensaje de error

   --se consulta codigo de producto
   CURSOR cugetProducto IS
   SELECT oa.product_id
   FROM OR_ORDER_ACTIVITY oa
   WHERE oa.order_id = nuOrderId;

   --se obtiene la observacion de la orden codigo de producto
   CURSOR cugetComentaio IS
   select oo.order_comment
     from or_order_comment oo
    where oo.order_id = nuOrderId;

    sbcomentario or_order_comment.order_comment%type;

  BEGIN
   
    nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder; -- Obtenemos la orden que se esta legalizando
    nuClaseCausal := dage_causal.fnugetclass_causal_id(Daor_order.fnugetCausal_id(nuOrderId, null), null); --se obtiene clase de causal

    OPEN cugetProducto;
    FETCH cugetProducto INTO nuproducto;
    CLOSE cugetProducto;

    OPEN cugetComentaio;
    FETCH cugetComentaio INTO sbcomentario;
    CLOSE cugetComentaio;

    --se crea solicitud de certificado
    PRGENECERTSN(nuproducto, sbcomentario, nuError, sbError);

    IF nuError <> 0 THEN
		RAISE  PKG_ERROR.controlled_error;
    END IF;

   
  EXCEPTION
    WHEN PKG_ERROR.controlled_error THEN
        RAISE  PKG_ERROR.controlled_error;
     WHEN OTHERS THEN
        Pkg_error.seterror;
        RAISE PKG_ERROR.controlled_error;
   END PRGENTRAMCERT;
   PROCEDURE PRGENECERTSN(  inuProducto IN NUMBER ,
                           isbComentario IN VARCHAR2,
                           onuError OUT NUMBER,
                           osbError OUT VARCHAR2) IS
 /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2019-11-25
      Proceso     : PRGENECERTSN
      Ticket      : 19
      Descripcion : proceso que genera tramite de certificado servicio nuevo

      Parametros Entrada
        inuOrden      numero de la orden
        isbComentario   comentario
      Valor de salida
        onuError      codigo de error
        osbError      mensaje de error

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
	  ===========	=============	=============================
	  24/07/2023	jerazomvm		CASO OSF-1261:
									1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
									2. Se reemplaza el API OS_RegisterRequestWithXML por el API api_registerRequestByXml.
  ***************************************************************************/

    sbRequestXML  VARCHAR2(4000); --se almacena XMl para
    nuPackage_id NUMBER; --se almacena codigo de la solicitud
    nuMotiveId NUMBER; --se almacena codigo del motivo

    nuMedioRecep NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_MEDRETRACERTSN', NULL);--se almacena medio de recepcion

    --se obtiene producto y cliente de la orden
    CURSOR cugetCliente IS
    SELECT s.suscclie,  s.susccodi, p.category_id, p.SUBCATEGORY_ID
    FROM pr_product p, suscripc s
    WHERE p.product_id = inuProducto
     AND s.susccodi = p.SUBSCRIPTION_ID;

    regInfoProd cugetCliente%ROWTYPE;

    nuDireccionParseada number;

  BEGIN
  
	Ut_trace.trace('Inicio LDC_PKGESTNUESQSERVNUE.PRGENECERTSN inuProducto: ' 	|| inuProducto	|| chr(10) ||
															  'isbComentario: '	|| isbComentario, 2);

     OPEN cugetCliente;
     FETCH cugetCliente INTO regInfoProd;
     IF cugetCliente%NOTFOUND THEN
         CLOSE cugetCliente;
         Pkg_error.SetErrorMessage(2741, 'No se encontro informacion del Producto ['||inuProducto||'], por favor validar');
         RAISE PKG_ERROR.controlled_error ;
     END IF;
     CLOSE cugetCliente;

     PR_BOADDRESS.GETIDADDRESSANDIDPREMISE(inuProducto,nuDireccionParseada);

     sbRequestXML :=  '<?xml version="1.0" encoding="ISO-8859-1"?>
                       <P_CERTIFICACION_POR_SERVICIOS_NUEVOS_100314 ID_TIPOPAQUETE="100314">
                          <RECEPTION_TYPE_ID>'||nuMedioRecep||'</RECEPTION_TYPE_ID>
                          <COMMENT_>'||isbComentario||'</COMMENT_>
                          <IDENTIFICADOR_DEL_CLIENTE>'||regInfoProd.suscclie||'</IDENTIFICADOR_DEL_CLIENTE>
                         <M_MOTIVO_CERTIFICACION_100298>
                          <PRODUCT_ID>'||inuProducto||'</PRODUCT_ID>
                          <SUBSCRIPTION_ID>'||regInfoProd.susccodi||'</SUBSCRIPTION_ID>
                          <PARSER_ADDRESS_ID>' || nuDireccionParseada || '</PARSER_ADDRESS_ID>
                          <CATEGORY_ID>'||regInfoProd.category_id||'</CATEGORY_ID>
                          <SUBCATEGORY_ID>'||regInfoProd.SUBCATEGORY_ID||'</SUBCATEGORY_ID>
                          </M_MOTIVO_CERTIFICACION_100298>
                        </P_CERTIFICACION_POR_SERVICIOS_NUEVOS_100314>';

        api_registerRequestByXml(sbRequestXML,
								 nuPackage_id,
								 nuMotiveId,
								 onuError,
								 osbError
								 );
								 
		Ut_trace.trace('Fin LDC_PKGESTNUESQSERVNUE.PRGENECERTSN nuPackage_id: '	|| nuPackage_id	|| chr(10) ||
															   'nuMotiveId: ' 	|| nuMotiveId 	|| chr(10) ||
															   'onuerror: ' 	|| onuerror 	|| chr(10) ||
															   'OsbError: '		|| OsbError, 2);


  EXCEPTION
    when PKG_ERROR.CONTROLLED_ERROR then
      Pkg_error.getError(onuError, osbError);
    when OTHERS then
        Pkg_error.seterror;
       Pkg_error.getError(onuError, osbError);
       raise PKG_ERROR.CONTROLLED_ERROR;
  END PRGENECERTSN;

  PROCEDURE  	PRELICARGCERT IS
  /**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2019-11-25
    Proceso     : PRELICARGCERT
    Ticket      : 19
    Descripcion : proceso que elimina cargos temporales de certificacion

    Parametros Entrada

    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
    04/06/2020   HORBATH     CASO 19: Actualizar el valor de 1 enel campo charge_status de la orden
                                      legalizada
	24/07/2023	jerazomvm		CASO OSF-1261:
								1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
								2. Se elimina la funcion fblAplicaEntregaxCaso, para la entrega la cual retorna true.
  ***************************************************************************/
    nuOrderId         NUMBER; --se almacena orden de trabajo
    nuClaseCausal     NUMBER; --se almacena clase de causal
    nuConcCert        NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_CONCCERT', NULL); --se almacena codigo de concepto de certificacion
    nuSolicitud       NUMBER;--se almacena numero de solicitud
    nuProducto        NUMBER;
    nuPackageType     PS_PACKAGE_TYPE.PACKAGE_TYPE_ID%TYPE;

    --se consulta cargos de certificacion
    CURSOR cuGetCargos IS
    SELECT oa.product_id, oa.package_id
    FROM cargos, or_order_activity oa
    WHERE oa.order_id = nuOrderId
     AND cargnuse = oa.product_id
     AND cargconc = nuConcCert
     AND cargcuco <> -1;

    CURSOR cuGePackageType IS
    SELECT P.PACKAGE_TYPE_ID
     FROM OR_ORDER_ACTIVITY a
    INNER JOIN MO_PACKAGES P ON A.PACKAGE_ID = P.PACKAGE_ID
    WHERE A.ORDER_ID = nuOrderId;

  BEGIN

       nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder; -- Obtenemos la orden que se esta legalizando
       nuClaseCausal := dage_causal.fnugetclass_causal_id(Daor_order.fnugetCausal_id(nuOrderId, null), null); --se obtiene clase de causal
       OPEN cuGePackageType;
       FETCH cuGePackageType INTO nuPackageType;
       IF cuGePackageType%NOTFOUND THEN
         nuPackageType := -1;
       END IF;
       CLOSE cuGePackageType;
      IF nuPackageType = 100314 THEN
      --se valida clase de causal de legalizacion
          IF nuClaseCausal = 1 THEN
            OPEN cuGetCargos;
            FETCH cuGetCargos INTO nuProducto, nuSolicitud;
            IF cuGetCargos%FOUND THEN
              --CLOSE cuGetCargos;
              DELETE FROM cargos WHERE CARGNUSE = nuProducto AND cargdoso = 'PP-'||nuSolicitud and cargcuco=-1;
              update or_order oo set oo.charge_status = 1 where oo.order_id=nuOrderId;
            END IF;
            CLOSE cuGetCargos;
          END IF;
      END IF;

  EXCEPTION
    when PKG_ERROR.CONTROLLED_ERROR then
      raise PKG_ERROR.CONTROLLED_ERROR;
    when OTHERS then
        Pkg_error.seterror;
       raise PKG_ERROR.CONTROLLED_ERROR;
   END PRELICARGCERT;
   
    PROCEDURE PRGENEFINACERTSENU is
  /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2020-02-17
      Proceso     : PRGENEFINACERTSENU
      Ticket      : 19
      Descripcion : plugin que se encarga de generar fiannciacion de la certificacion de servicio nuevo

      Parametros Entrada

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA         AUTOR       	DESCRIPCION
	  ===========	=============	=============================
	  24/07/2023	jerazomvm		CASO OSF-1261:
									1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
									2. Se elimina la funcion fblAplicaEntregaxCaso, para la entrega la cual retorna true.
  ***************************************************************************/
   sbTipoSoli VARCHAR2(200) :=  dald_parameter.fsbgetvalue_chain('LDC_SOLCERTSENU', NULL);
   nuOrderId NUMBER; --se almacena orden de trabajo
   nuClaseCausal NUMBER; --se almacena clase de causal
   sbdatos VARCHAR2(1);
   
   CURSOR cuGetOrden IS
   SELECT 'X'
   FROM or_order_activity oa, mo_pAckages s
   WHERE oa.order_id =  nuOrderId
    AND s.package_id = oa.package_id
    AND s.package_type_id in (SELECT to_number(regexp_substr(sbTipoSoli,'[^,]+', 1, LEVEL)) AS tiposoli
                             FROM   dual
                             CONNECT BY regexp_substr(sbTipoSoli, '[^,]+', 1, LEVEL) IS NOT NULL);
   
  BEGIN
  
    nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder; -- Obtenemos la orden que se esta legalizando
    nuClaseCausal := dage_causal.fnugetclass_causal_id(Daor_order.fnugetCausal_id(nuOrderId, null), null); --se obtiene clase de causal
    
	--se valida clase de causal de legalizacion
    IF nuClaseCausal = 1 THEN
     
		OPEN cuGetOrden;
        FETCH cuGetOrden INTO sbdatos;
        IF cuGetOrden%FOUND THEN
         
			LDC_BCFINANCEOT.PRFINANCEOT;
		END IF;
    
	CLOSE cuGetOrden;
       
    END IF;
  
   EXCEPTION
    when PKG_ERROR.CONTROLLED_ERROR then
      raise PKG_ERROR.CONTROLLED_ERROR;
    when OTHERS then
        Pkg_error.seterror;
       raise PKG_ERROR.CONTROLLED_ERROR;
   END PRGENEFINACERTSENU;
END LDC_PKGESTNUESQSERVNUE ;
/