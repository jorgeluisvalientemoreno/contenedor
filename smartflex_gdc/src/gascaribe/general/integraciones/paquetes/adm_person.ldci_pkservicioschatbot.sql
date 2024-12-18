CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKSERVICIOSCHATBOT AS

  /*
  PROPIEDAD INTELECTUAL DE GASES DEL CARIBE

  PROCEDIMIENTO : LDCI_PKSERVICIOSCHATBOT
          AUTOR : HORBATH
          FECHA : 07/04/2020


  DESCRIPCION : Paquete para establecer procesos para INNOVACION.

  Historia de Modificaciones

  Autor        Fecha       Descripcion.
epenao       12/12/2023     OSF-1856 Proyecto Organización
                            +Eliminación código en comentarios
                            +Cambiar selects into por cursores. 
                            +Cambio del uso de ldc_boutilities.splitstrings por 
                            el uso de regexp_substr
                            +Cambio uso de ut_trace y dbms_output.put_line 
                            por la gestión personalizada de traza. 
                            +Cambio en la gestión de errores para que use la 
                            personalizada
                            +Cambio de or_boorderactivities.createactivity por 
                            api_createorder
                            +Cambio dapr_product.fnugetaddress_id por 
                            pkg_bcproducto.fnuiddireccinstalacion
                            +Cambio os_assign_order por api_assign_order
                            +Cambio os_registerdebtfinancing por api_registerdebtfinancing
                            +Cambio os_registerrequestwithxml por api_registerrequestbyxml
                            +Cambio damo_packages.getrecord por pkg_bcsolicitudes.frcgetRecord
jpinedc       21/08/2024     OSF-3037: Se modifica prcRegistraSolicitudSacRP
  */


  /*
   * Propiedad Intelectual Gases del caribe
   *
   * servicio: PRLogCHATBOT
   * Autor   : HORBATH
   * Fecha   : 07/04/2020
   * Descripcion : Registro de LOG de errores del CHATBOT
   *
   * onuErrorCode: Codigo de la excepcion
   * osbErrorMessage: Descripcion de la excepcion

   * Autor              Fecha         Descripcion
  **/

  PROCEDURE PRLogCHATBOT(inuSUSCCODI            in number,
                         inuMensaje_id          in number,
                         isbMensaje_descripcion varchar2,
                         idtFecha_Registro      date default sysdate,
                         isbServicio            varchar2);

  /*
   * Propiedad Intelectual Gases del Caribe
   *
   * servicio: PRRegistroFinanciacionDeuda
   * Autor   : HORBATH
   * Fecha   : 07/04/2020
   * Descripcion : Registro de Financiacion de Deuda por contrato
   *
   * onuErrorCode: Codigo de la excepcion
   * osbErrorMessage: Descripcion de la excepcion

   * Autor              Fecha         Descripcion
  **/
  PROCEDURE PRRegistroFinanciacionDeuda(inuSubscriptionId  in suscripc.susccodi%type,
                                        inuProductId       in servsusc.sesunuse%type,
                                        isbDeferredList    in varchar2,
                                        isbOnlyExpiredAcc  in cc_financing_request.only_expired_acc%type,
                                        isbRequireSigning  in cc_financing_request.wait_by_sign%type,
                                        idtRegisterDate    in mo_packages.request_date%type,
                                        inuReceptionTypeId in mo_packages.reception_type_id%type,
                                        inuSubscriberId    in mo_packages.contact_id%type,
                                        isbResponseAddress in ab_address.address%type,
                                        inuGeograLocation  in ge_geogra_location.geograp_location_id%type,
                                        isbComment         in mo_packages.comment_%type,
                                        inuFinancingPlanId in plandife.pldicodi%type,
                                        idtInitPayDate     in diferido.difefein%type,
                                        inuDiscountValue   in cc_financing_request.value_to_finance%type,
                                        inuValueToPay      in cc_financing_request.initial_payment%type,
                                        inuSpread          in diferido.difespre%type,
                                        inuQuotesNumber    in diferido.difenucu%type,
                                        isbSupportDocument in diferido.difenudo%type,
                                        isbCosignersList   in varchar2,
                                        onuPackageId       out mo_packages.package_id%type,
                                        onuCouponNumber    out cupon.cuponume%type,
                                        onuErrorCode       out ge_error_log.message_id%type,
                                        osbErrorMessage    out ge_error_log.description%type,
                                        isbProcessName     in varchar2);

  /*
   * Propiedad Intelectual Gases del Caribe
   *
   * servicio: PRPagoUltimoCupon
   * Autor   : HORBATH
   * Fecha   : 07/04/2020
   * Descripcion : Consulta informacion de ultimo pago realizado. A partir del contrato ingresado,
                   se debe retornar:
                                        el numero de cupon,
                                        valor,
                                        fecha de pago,
                                        descripcion de banco
                                        sucursal donde se realizo el pago.
   *
   * onuErrorCode: Codigo de la excepcion
   * osbErrorMessage: Descripcion de la excepcion

   * Autor              Fecha         Descripcion
  **/
  PROCEDURE PRPagoUltimoCupon(inupagosusc     in pagos.pagosusc%type,
                              onupagocupo     out pagos.pagocupo%type,
                              onuvalor        out pagos.pagovapa%type,
                              odtpagofepa     out pagos.pagofepa%type,
                              osbpagobanc     out varchar2,
                              osbpagosuba     out varchar2,
                              onuErrorCode    out ge_error_log.message_id%type,
                              osbErrorMessage out ge_error_log.description%type,
                              osbPago         out varchar2);

  /*
   * Propiedad Intelectual Gases del Caribe
   *
   * servicio: PRReconexion
   * Autor   : HORBATH
   * Fecha   : 07/04/2020
   * Descripcion : Consulta si el contrato tiene alguan reconexion generada. en caso de tenerla mostrala
                   la fecha de plazo para reconexion en caso de NO tener la orden muestra el ultimo cupon
                   con la respectiva  infoprmacion:
                                                    el numero de cupon,
                                                    valor,
                                                    fecha de pago,
                                                    descripcion de banco
                                                    sucursal donde se realizo el pago.
   *
   * onuErrorCode: Codigo de la excepcion
   * osbErrorMessage: Descripcion de la excepcion

   * Autor              Fecha         Descripcion
  **/
  PROCEDURE PRReconexion(inupagosusc        in pagos.pagosusc%type,
                         odtplazoreconexion out or_order.EXEC_ESTIMATE_DATE%type,
                         onupagocupo        out pagos.pagocupo%type,
                         onuvalor           out pagos.pagovapa%type,
                         odtpagofepa        out pagos.pagofepa%type,
                         osbpagobanc        out varchar2,
                         osbpagosuba        out varchar2,
                         onuErrorCode       out ge_error_log.message_id%type,
                         osbErrorMessage    out ge_error_log.description%type,
                         osbPago            out varchar2);

  /*
   * Propiedad Intelectual Gases del Caribe
   *
   * servicio: PRVerficarSACRP
   * Autor   : HORBATH
   * Fecha   : 15/04/2020
   * Descripcion : Servicio para generar solicitud de verificar SAC RP.
   *
   * onuErrorCode: Codigo de la excepcion
   * osbErrorMessage: Descripcion de la excepcion

   * Autor              Fecha         Descripcion
  **/
  PROCEDURE PRVerficarSACRP(inususccodi     in suscripc.susccodi%type,
                            isbcoment       in mo_packages.comment_%type,
                            isbtelcel       in number,
                            inuMedioRecep   in number,
                            onupackage_id   out mo_packages.package_id%type,
                            onuorder_id     out or_order.order_id%type,
                            onuErrorCode    out ge_error_log.message_id%type,
                            osbErrorMessage out ge_error_log.description%type);

    PROCEDURE prcRegistraSolicitudSacRP
    (
        inuContrato           IN  suscripc.susccodi%TYPE,
        inuMedioRecepcionId   IN  mo_packages.reception_type_id%TYPE,
        isbComentario         IN  mo_packages.comment_%TYPE,
        inuActividadId        IN  or_order_activity.activity_id%TYPE,
        inuOrdenId            IN  or_order_activity.order_id%TYPE,
        onuSolicitud          OUT mo_packages.package_id%TYPE,
        onuCodigoError          OUT ge_error_log.message_id%TYPE,
        osbMensajeError       OUT ge_error_log.description%TYPE
    );

END LDCI_PKSERVICIOSCHATBOT;
/

CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKSERVICIOSCHATBOT AS

  /*
  PROPIEDAD INTELECTUAL DE GASES DEL CARIBE

  PROCEDIMIENTO : LDCI_PKSERVICIOSCHATBOT
          AUTOR : HORBATH
          FECHA : 07/04/2020


  DESCRIPCION : Paquete para establecer procesos para INNOVACION.

  Historia de Modificaciones

  Autor        Fecha       Descripcion.
  */

  /*
   * Propiedad Intelectual Gases del caribe
   *
   * servicio: PRLogCHATBOT
   * Autor   : HORBATH
   * Fecha   : 07/04/2020
   * Descripcion : Registro de LOG de errores del CHATBOT
   *
   * onuErrorCode: Codigo de la excepcion
   * osbErrorMessage: Descripcion de la excepcion

   * Autor              Fecha         Descripcion
  **/
  csbNOMPKG    	   CONSTANT VARCHAR2(35):= $$PLSQL_UNIT||'.'; -- Constantes para el control de la traza
  nuCodigoError    number;
  sbMensajError    VARCHAR2(4000);

    csbVersion     CONSTANT VARCHAR2(15) := 'OSF-2728';

    /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
      Autor       	: Luis Felipe Valencia Hurtado
      Fecha       	: 28-05-2024

      Modificaciones  :
      Autor       		    Fecha         Caso     	Descripcion
      felipe.valencia   	28-05-2024    OSF-2728 	Creacion
    ***************************************************************************/
    FUNCTION fsbVersion 
    RETURN VARCHAR2 
    IS
    BEGIN
      RETURN csbVersion;
    END fsbVersion;

  PROCEDURE PRLogCHATBOT(inuSUSCCODI            in number,
                         inuMensaje_id          in number,
                         isbMensaje_descripcion varchar2,
                         idtFecha_Registro      date default sysdate,
                         isbServicio            varchar2) AS
      csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'PRLogCHATBOT'; --Nombre del método en la traza                         

  BEGIN
    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);

    insert into LDCI_LOGCHATBOT
      (SUSCCODI, ERROR_ID, ERROR_DESCRIPCION, FECHA_REGISTRO, SERVICIO)
    values
      (inuSUSCCODI,
       inuMensaje_id,
       isbMensaje_descripcion,
       idtFecha_Registro,
       isbServicio);

    commit;
    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);
  EXCEPTION
    WHEN OTHERS THEN
      rollback;
      pkg_error.setError;
      pkg_error.getError(nuCodigoError,sbMensajError);  
      pkg_traza.trace('Error:'||nuCodigoError||'-'||sbMensajError,pkg_traza.cnuNivelTrzDef);    
      pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);
  END PRLogCHATBOT;

  /*
   * Propiedad Intelectual Gases del Caribe
   *
   * servicio: PRRegistroFinanciacionDeuda
   * Autor   : HORBATH
   * Fecha   : 07/04/2020
   * Descripcion : Registro de Financiacion de Deuda por contrato
   *
   * onuErrorCode: Codigo de la excepcion
   * osbErrorMessage: Descripcion de la excepcion

   * Autor              Fecha         Descripcion
  **/

  PROCEDURE PRRegistroFinanciacionDeuda(inuSubscriptionId  in suscripc.susccodi%type,
                                        inuProductId       in servsusc.sesunuse%type,
                                        isbDeferredList    in varchar2,
                                        isbOnlyExpiredAcc  in cc_financing_request.only_expired_acc%type,
                                        isbRequireSigning  in cc_financing_request.wait_by_sign%type,
                                        idtRegisterDate    in mo_packages.request_date%type,
                                        inuReceptionTypeId in mo_packages.reception_type_id%type,
                                        inuSubscriberId    in mo_packages.contact_id%type,
                                        isbResponseAddress in ab_address.address%type,
                                        inuGeograLocation  in ge_geogra_location.geograp_location_id%type,
                                        isbComment         in mo_packages.comment_%type,
                                        inuFinancingPlanId in plandife.pldicodi%type,
                                        idtInitPayDate     in diferido.difefein%type,
                                        inuDiscountValue   in cc_financing_request.value_to_finance%type,
                                        inuValueToPay      in cc_financing_request.initial_payment%type,
                                        inuSpread          in diferido.difespre%type,
                                        inuQuotesNumber    in diferido.difenucu%type,
                                        isbSupportDocument in diferido.difenudo%type,
                                        isbCosignersList   in varchar2,
                                        onuPackageId       out mo_packages.package_id%type,
                                        onuCouponNumber    out cupon.cuponume%type,
                                        onuErrorCode       out ge_error_log.message_id%type,
                                        osbErrorMessage    out ge_error_log.description%type,
                                        isbProcessName     in varchar2) AS

    EXCEP_os_registerdebtfinancing exception;
    csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'PRRegistroFinanciacionDeuda'; --Nombre del método en la traza

  BEGIN
    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);
    onuErrorCode := 0;

    api_registerdebtfinancing(	inuSubscriptionId   => inusubscriptionid,
                                 inuProductId        => inuproductid,
                                 isbDeferredList     => isbdeferredlist,
                                 isbOnlyExpiredAcc   => isbonlyexpiredacc,
                                 isbRequireSigning   => isbrequiresigning,
                                 idtRegisterDate     => idtregisterdate,
                                 inuReceptionTypeId  => inureceptiontypeid,
                                 inuSubscriberId     => inusubscriberid,
                                 isbResponseAddress  => isbresponseaddress,
                                 inuGeograLocation   => inugeogralocation,
                                 isbComment          => isbcomment,
                                 inuFinancingPlanId  => inufinancingplanid,
                                 idtInitPayDate      => idtinitpaydate,
                                 inuDiscountValue    => inudiscountvalue,
                                 inuValueToPay       => inuvaluetopay,
                                 inuSpread           => inuspread,
                                 inuQuotesNumber     => inuquotesnumber,
                                 isbSupportDocument  => isbsupportdocument,
                                 isbCosignersList    => isbcosignerslist,
                                 onuPackageId        => onupackageid,
                                 onuCouponNumber     => onucouponnumber,
                                 onuErrorCode        => onuerrorcode,
                                 osbErrorMessage     => osberrormessage,
                                 isbProcessName      => isbprocessname);


    -- valida la ejecucion del API
    if (onuErrorCode <> 0) then
      rollback;
      PRLogCHATBOT(inusubscriptionid,
                   onuerrorcode,
                   osberrormessage,
                   sysdate,
                   csbMetodo);
      raise EXCEP_os_registerdebtfinancing;
    end if;

    -- confirma los datos
    commit;
    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);
  EXCEPTION
    WHEN EXCEP_os_registerdebtfinancing THEN
      rollback;
      pkg_error.setError;
      pkg_error.getError(nuCodigoError,sbMensajError);  
      pkg_traza.trace('Error:'||nuCodigoError||'-'||sbMensajError,pkg_traza.cnuNivelTrzDef);    
      pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);
      
    WHEN OTHERS THEN
      rollback;
      pkg_error.setError;
      pkg_error.getError(onuErrorCode,osbErrorMessage);  
      pkg_traza.trace('Error:'||onuErrorCode||'-'||osbErrorMessage,pkg_traza.cnuNivelTrzDef);    
      PRLogCHATBOT(inusubscriptionid,
                   onuerrorcode,
                   osberrormessage,
                   sysdate,
                   csbMetodo);
     pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);                   

  END PRRegistroFinanciacionDeuda;

  /*
   * Propiedad Intelectual Gases del Caribe
   *
   * servicio: PRUltimoPago
   * Autor   : HORBATH
   * Fecha   : 07/04/2020
   * Descripcion : Consulta informacion de ultimo pago realizado. A partir del contrato ingresado,
                   se debe retornar:
                                        el numero de cupon,
                                        valor,
                                        fecha de pago,
                                        descripcion de banco
                                        sucursal donde se realizo el pago.
   *
   * onuErrorCode: Codigo de la excepcion
   * osbErrorMessage: Descripcion de la excepcion

   * Autor              Fecha         Descripcion


  **/
  PROCEDURE PRPagoUltimoCupon(inupagosusc     in pagos.pagosusc%type,
                              onupagocupo     out pagos.pagocupo%type,
                              onuvalor        out pagos.pagovapa%type,
                              odtpagofepa     out pagos.pagofepa%type,
                              osbpagobanc     out varchar2,
                              osbpagosuba     out varchar2,
                              onuErrorCode    out ge_error_log.message_id%type,
                              osbErrorMessage out ge_error_log.description%type,
                              osbPago         out varchar2) AS

    EXCEP_PRPagoUltimoCupon exception;
    csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'PRPagoUltimoCupon'; --Nombre del método en la traza

    cursor cucupon is
      select c1.cuponume, c1.cupoflpa
        from cupon c1
       where c1.cupofech = (select max(c.cupofech)
                              from cupon c
                             where c.cuposusc = inupagosusc)
         and c1.cuposusc = inupagosusc;

    nucuponume cupon.cuponume%type;
    sbcupoflpa cupon.cupoflpa%type;

    cursor cupagos(inucuponume pagos.pagocupo%type) is
      select p.pagovapa,
             p.pagofepa,
             (select b.bancnomb
                from banco b
               where b.banccodi = p.pagobanc
                 and rownum = 1) pagobanc,
             (select sc.subanomb
                from sucubanc sc
               where sc.subacodi = p.pagosuba
                 and sc.subabanc = p.pagobanc
                 and rownum = 1) pagosuba
        from pagos p
       where p.pagosusc = inupagosusc
         and p.pagocupo = inucuponume;

    rfcupagos cupagos%rowtype;

  BEGIN
    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);
    onupagocupo := 0;
    onuvalor    := 0;
    odtpagofepa := null;
    osbpagobanc := null;
    osbpagosuba := null;
    osbPago     := 'N';

    if inupagosusc is null then
      onuErrorCode    := -1;
      osbErrorMessage := 'Se utilizo el servicio con un contrato NULL';
      PRLogCHATBOT(inupagosusc,
                   onuerrorcode,
                   osberrormessage,
                   sysdate,
                   csbMetodo);
      raise EXCEP_PRPagoUltimoCupon;
    end if;

    open cucupon;
    fetch cucupon
      into nucuponume, sbcupoflpa;
    close cucupon;

    if nucuponume is null then
      onuErrorCode    := 0;
      osbErrorMessage := 'El contrato no tiene un cupon existente';
      osbPago         := 'N';
    else
      open cupagos(nucuponume);
      fetch cupagos
        into rfcupagos;
      if cupagos%found and sbcupoflpa = 'S' then
        if rfcupagos.pagovapa is not null then
          onupagocupo     := nucuponume;
          onuvalor        := rfcupagos.pagovapa;
          odtpagofepa     := rfcupagos.pagofepa;
          osbpagobanc     := rfcupagos.pagobanc;
          osbpagosuba     := rfcupagos.pagosuba;
          onuErrorCode    := 0;
          osbErrorMessage := 'El cupon fue pagado';
          osbPago         := 'S';
        else
          onuErrorCode    := 0;
          osbErrorMessage := 'El cupon no ha sido pagado';
          onupagocupo     := nucuponume;
          osbPago         := 'N';
        end if;
      else
        onuErrorCode    := 0;
        osbErrorMessage := 'El cupon no ha sido pagado';
        onupagocupo     := nucuponume;
        osbPago         := 'N';
      end if;
      close cupagos;
    end if;
     pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);
  EXCEPTION
    WHEN EXCEP_PRPagoUltimoCupon THEN
      onupagocupo := 0;
      onuvalor    := 0;
      odtpagofepa := null;
      osbpagobanc := null;
      osbpagosuba := null;
      osbPago     := 'E';
      pkg_error.setError;
      pkg_error.getError(nuCodigoError,sbMensajError);  
      pkg_traza.trace('Error:'||nuCodigoError||'-'||sbMensajError,pkg_traza.cnuNivelTrzDef);          
      pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);

    WHEN OTHERS THEN
      onupagocupo := 0;
      onuvalor    := 0;
      odtpagofepa := null;
      osbpagobanc := null;
      osbpagosuba := null;
      osbPago     := 'E';
      pkg_error.setError;
      pkg_error.getError(onuErrorCode,osbErrorMessage);  
      pkg_traza.trace('Error:'||onuErrorCode||'-'||osbErrorMessage,pkg_traza.cnuNivelTrzDef);          
      PRLogCHATBOT(inupagosusc,
                   onuerrorcode,
                   osberrormessage,
                   sysdate,
                   csbMetodo);
      pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);             
  END PRPagoUltimoCupon;

  /*
   * Propiedad Intelectual Gases del Caribe
   *
   * servicio: PRReconexion
   * Autor   : HORBATH
   * Fecha   : 07/04/2020
   * Descripcion : Consulta si el contrato tiene alguan reconexion generada. en caso de tenerla mostrala
                   la fecha de plazo para reconexion en caso de NO tener la orden muestra el ultimo cupon
                   con la respectiva  infoprmacion:
                                                    el numero de cupon,
                                                    valor,
                                                    fecha de pago,
                                                    descripcion de banco
                                                    sucursal donde se realizo el pago.
   *
   * onuErrorCode: Codigo de la excepcion
   * osbErrorMessage: Descripcion de la excepcion

   * Autor              Fecha         Descripcion
  **/
  PROCEDURE PRReconexion(inupagosusc        in pagos.pagosusc%type,
                         odtplazoreconexion out or_order.EXEC_ESTIMATE_DATE%type,
                         onupagocupo        out pagos.pagocupo%type,
                         onuvalor           out pagos.pagovapa%type,
                         odtpagofepa        out pagos.pagofepa%type,
                         osbpagobanc        out varchar2,
                         osbpagosuba        out varchar2,
                         onuErrorCode       out ge_error_log.message_id%type,
                         osbErrorMessage    out ge_error_log.description%type,
                         osbPago            out varchar2) AS

    EXCEP_PRReconexion exception;
    csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'PRReconexion'; --Nombre del método en la traza


    csbCODTASKTYPERECO    CONSTANT  ld_parameter.value_chain%type := pkg_bcld_parameter.fsbobtienevalorcadena('CODTASKTYPERECO');
    cursor cureconexion is
      select OO.ORDER_ID, OO.EXEC_ESTIMATE_DATE, oo.created_date
        from or_order oo, or_order_activity ooa
       where oo.order_id = ooa.order_id
         and oo.task_type_id IN ( SELECT (regexp_substr(csbCODTASKTYPERECO,'[^,]+', 1, LEVEL)) AS vlrColumna
                                   FROM dual
                                CONNECT BY regexp_substr(csbCODTASKTYPERECO, '[^,]+', 1, LEVEL) IS NOT NULL   
                                 )
         AND OOA.SUBSCRIPTION_ID = inupagosusc
         and oo.created_date =
             (select max(oo.created_date)
                from or_order oo, or_order_activity ooa
               where oo.order_id = ooa.order_id
                 and oo.task_type_id IN (SELECT (regexp_substr(csbCODTASKTYPERECO,'[^,]+', 1, LEVEL)) AS vlrColumna
                                           FROM dual
                                        CONNECT BY regexp_substr(csbCODTASKTYPERECO, '[^,]+', 1, LEVEL) IS NOT NULL   )
                 AND OOA.SUBSCRIPTION_ID = inupagosusc);

    NUORDER_ID           OR_ORDER.ORDER_ID%TYPE;
    DTEXEC_ESTIMATE_DATE OR_ORDER.EXEC_ESTIMATE_DATE%TYPE;
    DTCreated_Date       OR_ORDER.Created_Date%TYPE;

    blDiaHabil boolean := false;
    nuDias     number := 0;

  BEGIN
    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);
    PRPagoUltimoCupon(inupagosusc,
                      onupagocupo,
                      onuvalor,
                      odtpagofepa,
                      osbpagobanc,
                      osbpagosuba,
                      onuErrorCode,
                      osbErrorMessage,
                      osbPago);

    IF osbPago = 'E' THEN
      odtplazoreconexion := NULL;
      onupagocupo        := 0;
      onuvalor           := 0;
      odtpagofepa        := null;
      osbpagobanc        := null;
      osbpagosuba        := null;
    ELSE
      IF osbPago = 'N' THEN
        odtplazoreconexion := NULL;
      ELSE
        IF osbPago = 'S' THEN

          OPEN cureconexion;
          FETCH cureconexion
            INTO NUORDER_ID, DTEXEC_ESTIMATE_DATE, DTCreated_Date;
          CLOSE cureconexion;

          IF trunc(DTCreated_Date) > trunc(odtpagofepa) THEN

            while blDiaHabil = false loop
              nuDias := nuDias + 1;
              if pkHolidayMgr.fnuGetNumOfDayNonHoliday(odtpagofepa,
                                                       odtpagofepa + nuDias) = 3 then
                blDiaHabil := true;
              end if;
            end loop;

            odtplazoreconexion := odtpagofepa + nuDias;
            onupagocupo        := 0;
            onuvalor           := 0;
            odtpagofepa        := null;
            osbpagobanc        := null;
            osbpagosuba        := null;
            onuErrorCode       := 0;
            osbErrorMessage    := NULL;
            osbPago            := NULL;
          ELSE
            onuErrorCode    := 0;
            osbErrorMessage := 'Despues del pago del cupon no existe orden de reconexion';
          END IF;
        END IF;
      END IF;
    END IF;

   pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);
  EXCEPTION
    WHEN EXCEP_PRReconexion THEN
      odtplazoreconexion := null;
      onupagocupo        := 0;
      onuvalor           := 0;
      odtpagofepa        := null;
      osbpagobanc        := null;
      osbpagosuba        := null;
      osbPago            := 'E';
      
      pkg_error.setError;
      pkg_error.getError(nuCodigoError,sbMensajError);  
      pkg_traza.trace('Error:'||nuCodigoError||'-'||sbMensajError,pkg_traza.cnuNivelTrzDef);    
      pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);

    WHEN OTHERS THEN
      odtplazoreconexion := null;
      onupagocupo        := 0;
      onuvalor           := 0;
      odtpagofepa        := null;
      osbpagobanc        := null;
      osbpagosuba        := null;
      osbPago            := 'E';

      pkg_error.setError;
      pkg_error.getError(onuErrorCode,osbErrorMessage);  
      pkg_traza.trace('Error:'||onuErrorCode||'-'||osbErrorMessage,pkg_traza.cnuNivelTrzDef);          
      PRLogCHATBOT(inupagosusc,
                   onuerrorcode,
                   osberrormessage,
                   sysdate,
                   csbMetodo);
      pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);                   
  END PRReconexion;

  /*
   * Propiedad Intelectual Gases del Caribe
   *
   * servicio: PRVerficarSACRP
   * Autor   : HORBATH
   * Fecha   : 15/04/2020
   * Descripcion : Servicio para generar solicitud de verificar SAC RP.
   *
   * onuErrorCode: Codigo de la excepcion
   * osbErrorMessage: Descripcion de la excepcion

   * Autor              Fecha         Descripcion
     ESANTIAGO        22/10/2020     caso 537: se modifica cadena xml para enviar la direcion del porducto de gas 
											    relacionado con el contrato
	 ESANTIAGO        1/12/2020     caso 613: Se modifico el cursor cuProducto, para que valide la fecha de retiro solo si es diferente de null
  **/
  PROCEDURE PRVerficarSACRP(inususccodi     in suscripc.susccodi%type,
                            isbcoment       in mo_packages.comment_%type,
                            isbtelcel       in number,
                            inuMedioRecep   in number,
                            onupackage_id   out mo_packages.package_id%type,
                            onuorder_id     out or_order.order_id%type,
                            onuErrorCode    out ge_error_log.message_id%type,
                            osbErrorMessage out ge_error_log.description%type) AS

    EXCEP_PRVerficarSACRP exception;
    csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'PRVerficarSACRP'; --Nombre del método en la traza

    --Cursor que obtiene el producto, el contrato del producto y
    --el tipo de trabajo de acuerdo a la orden instanciada
    CURSOR cuProducto(Inucontrato number) IS
      select t.product_id, Inucontrato
        from PR_PRODUCT t
       where t.product_type_id =
             nvl(pkg_bcld_parameter.fnuobtienevalornumerico('COD_SERV_GAS'),
                 7014)
         and (t.retire_date > sysdate OR t.retire_date IS NULL) -- caso: 613
         and t.subscription_id = Inucontrato
         AND ROWNUM = 1;

    nuErrorCode       NUMBER;
    sbErrorMessage    VARCHAR2(4000);
    nuPackageId       mo_packages.package_id%TYPE;
    nuMotiveId        mo_motive.motive_id%TYPE;    
    sbRequestXML1     constants_per.TIPO_XML_SOL%type;
    nuorden           NUMBER;    
    nuPersonId        ge_person.person_id%TYPE;
    nuPtoAtncn        NUMBER;
    sbComment         VARCHAR2(2000) := 'TRAMITE GENERADO DESDE ENCUESTA';
    nuProductId       NUMBER;
    nuContratoId      NUMBER;    
    nuAddressId       NUMBER;   
    nuIdentification  NUMBER;
    nuContactId       NUMBER;  
    ---------------------------------------------------


    --NC 1562 cursor y variables
    sbnumber_id VARCHAR2(20) := pkg_bcld_parameter.fsbobtienevalorcadena('COD_USER_SOLICITUDES_INTERNAS');
    -------------------------

    --CASO 200-796
    sberrrorexcepcion varchar2(4000);
    
    NUCONTRATO    suscripc.susccodi%type;
    SBOBSERVACION LDC_RESPUESTA_GRUPO.OBSERVACION%TYPE;
    NUTELCEL      NUMBER;

    rcPackage         pkg_bcsolicitudes.stySolicitudes;
    rcMotive          damo_motive.styMO_motive;
    inuOrder          or_order.order_id%type;
    inuOrderActivity  or_order_activity.order_activity_id%type;
    nuActivityTypeId  number := pkg_bcld_parameter.fnuobtienevalornumerico('CODACTVERSACRP');
    NUUNIDADOPERATIVA NUMBER := pkg_bcld_parameter.fnuobtienevalornumerico('CODUNIOPEVERSACRP'); ---3055; --
    function fnuPerson_id return number is
      
      cursor cuPerson_id is 
       SELECT PERSON_ID
         FROM GE_PERSON
        WHERE IDENT_TYPE_ID = 110
          AND NUMBER_ID = sbnumber_id;

       nuretorno ge_person.person_id%type := 0 ;

    begin
        open cuPerson_id;
             fetch cuPerson_id into nuretorno;
        close cuPerson_id;

        return nuretorno;
      
    end fnuPerson_id;

    function fnuorganizat_area_id return number is
      
      cursor cuorganizat_area_id is 
    ---obtiene el area organizacional
      SELECT ORGANIZAT_AREA_ID
        FROM CC_ORGA_AREA_SELLER
       WHERE PERSON_ID = nuPersonId
         AND IS_CURRENT = 'Y';
       nuretorno cc_orga_area_seller.organizat_area_id%type := 0 ;
    begin
        open cuorganizat_area_id;
             fetch cuorganizat_area_id into nuretorno;
        close cuorganizat_area_id;

        return nuretorno;
      
    end fnuorganizat_area_id;

    function fnusubscriber_id return number is
      
      cursor cusubscriber_id is 
      SELECT GS.SUBSCRIBER_ID        
        FROM SUSCRIPC S, ge_subscriber gs
       WHERE S.SUSCCODI = inususccodi
         AND S.SUSCCLIE = GS.SUBSCRIBER_ID
         AND rownum = 1;
       nuretorno ge_subscriber.subscriber_id%type := 0 ;
    begin
        open cusubscriber_id;
             fetch cusubscriber_id into nuretorno;
        close cusubscriber_id;

        return nuretorno;
      
    end fnusubscriber_id;


  BEGIN
    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);
    NUCONTRATO    := inususccodi;
    SBOBSERVACION := isbcoment;
    NUTELCEL      := isbtelcel;

    -- Se consulta el usuario configurado en el parametro COD_USER_SOLICITUDES_INTERNAS
    nuIdentification := pkg_bcld_parameter.fsbobtienevalorcadena('COD_USER_SOLICITUDES_INTERNAS');

    -- Se valida si el parametro viene null
    IF (nuIdentification IS NULL) THEN
      sberrrorexcepcion := 'Servicio PRVERIFICACION_SAC_RP - No existe configurado el parametro COD_USER_SOLICITUDES_INTERNAS';

      pkg_error.setErrorMessage(pkg_error.CNUGENERIC_MESSAGE,'No existe configurado usuario en el parametro COD_USER_SOLICITUDES_INTERNAS' );      
    END IF;
    

    nuPersonId := fnuPerson_id;--Obtiene Id de la persona    
    nuPtoAtncn := fnuorganizat_area_id;---obtiene el area organizacional

    --Comentario en el codigo de la solicitud padre prveiniente
    --de la orden de ENTREGA DE ARTICULOS - FNB
    sbComment := SBOBSERVACION || ' - Tel o Cel [' || isbtelcel || ']'; --sbComment || ' ORIGINADO POR LA OT [ ' || nuorden || ' ]';

    OPEN cuProducto(NUCONTRATO);
    FETCH cuProducto
      INTO nuProductId, nuContratoId;
    IF cuProducto%NOTFOUND THEN
      sberrrorexcepcion := 'Servicio PRVERIFICACION_SAC_RP - El cursor cuProducto no arrojo datos con el # de orden' ||
                           nuorden;
      pkg_error.setErrorMessage(pkg_error.CNUGENERIC_MESSAGE,
                               'El cursor cuProducto no arrojo datos con el # de orden' ||nuorden );
      
    END IF;
    CLOSE cuProducto;

    nuAddressId := pkg_bcproducto.fnuiddireccinstalacion(nuProductId);
    
    nuContactId := fnusubscriber_id;
  	-- Inicio caso: 537    
    --P_VERIFICACION_SAC_RP_100330
    sbRequestXML1 := pkg_xml_soli_rev_periodica.getSolicitudVerificacionSACRP (inuMedioRecepcionId => inuMedioRecep,
                                                                               inuContactoId       => nuContactId,
                                                                               inuDireccionId      => nuAddressId,
                                                                               isbComentario       => sbComment,
                                                                               inuProducto         => nuProductId,
                                                                               inuContrato         => nuContratoId,
                                                                               inuTelefono         => NUTELCEL) ;     

    pkg_traza.trace('XML:'||sbRequestXML1,pkg_traza.cnuNivelTrzDef);
	-- Fin caso: 537    
    api_registerRequestByXml(isbRequestXML   => sbRequestXML1,
                             onuPackageId    => nuPackageId,
                             onuMotiveId     => nuMotiveId,
                             onuErrorCode    => nuErrorCode,
                             osbErrorMessage => sbErrorMessage);

                              

    pkg_traza.trace('Paquete : ' || nuPackageId,pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Motivo : ' || nuMotiveId,pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('SALIDA onuErrorCode: ' || nuErrorCode,pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('SALIDA osbErrorMess: ' || sbErrorMessage,pkg_traza.cnuNivelTrzDef);


    if nuErrorCode = 0 then
      onupackage_id   := nuPackageId;
      onuErrorCode    := nuErrorCode;
      osbErrorMessage := sbErrorMessage;

      rcPackage := pkg_bcsolicitudes.frcgetRecord(nuPackageId);
      damo_motive.getRecord(nuMotiveId, rcMotive);

      pkg_traza.trace('Codigo Direccion  : ' || rcPackage.address_id,pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace('Codigo Cliente : ' || rcPackage.subscriber_id,pkg_traza.cnuNivelTrzDef);




      ---Generar OT para la solicitud VERFICAR SAC RP
      api_createorder(inuitemsid          => nuActivityTypeId,
                                          inupackageid        => nuPackageId,
                                          inumotiveid         => nuMotiveId,
                                          inucomponentid      => null,
                                          inuinstanceid       => null,
                                          inuaddressid        => rcPackage.address_id,
                                          inuelementid        => null,
                                          inusubscriberid     => rcPackage.subscriber_id,
                                          inusubscriptionid   => nuContratoId,
                                          inuproductid        => nuProductId,                                           
                                          inuoperunitid       => null,
                                          idtexecestimdate    => null,
                                          inuprocessid        => null,
                                          isbcomment          => 'Orden creada por paquete:'||nuPackageId,
                                          iblprocessorder     => false,
                                          inupriorityid       => null,
                                          ionuorderid         => inuOrder,
                                          ionuorderactivityid => inuOrderActivity,
                                          inuordertemplateid  => null,
                                          isbcompensate       => null,
                                          inuconsecutive      => null,
                                          inurouteid          => null,
                                          inurouteconsecutive => null,
                                          inulegalizetrytimes => null,
                                          isbtagname          => null,
                                          iblisacttogroup     => false,
                                          inurefvalue         => null,
                                          onuErrorCode        => nuCodigoError,
                                          osbErrorMessage     => sbMensajError);

      ----------------------------------------------
      if nvl(inuOrder, 0) > 0 then
        pkg_traza.trace('Orden : ' || inuOrder,pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace('Orden Actividad : ' || inuOrderActivity,pkg_traza.cnuNivelTrzDef);

        ---- ASIGNAR LA ORDEN A LA UNIDAD OPERATIVA
        api_assign_order( inuOrder => inuOrder,
                          inuOperatingUnit => NUUNIDADOPERATIVA,
                          onuErrorCode => onuerrorcode,
                          osbErrorMessage => osberrormessage
                         );
              
                        
        IF onuerrorcode = 0 THEN
          onupackage_id   := nuPackageId;
          onuorder_id     := inuOrder;
          onuErrorCode    := 0;
          osbErrorMessage := NULL;
          
          commit;
        ELSE
          onupackage_id := null;
          onuorder_id   := null;
          rollback;
          raise EXCEP_PRVerficarSACRP;
        END IF;
      else
        onupackage_id   := null;
        onuorder_id     := null;
        onuErrorCode    := -1;
        osbErrorMessage := 'No se genero la orden para el nuevo tramite';
        rollback;
        raise EXCEP_PRVerficarSACRP;
      end if;
    else
      onupackage_id   := null;
      onuorder_id     := null;
      onuErrorCode    := nuErrorCode;
      osbErrorMessage := sbErrorMessage;
      rollback;
      raise EXCEP_PRVerficarSACRP;
    end if;
    
    pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);

  EXCEPTION
    WHEN EXCEP_PRVerficarSACRP THEN
      rollback;
      PRLogCHATBOT(NUCONTRATO,
                   onuerrorcode,
                   osberrormessage,
                   sysdate,
                   csbMetodo);

      pkg_error.setError;
      pkg_error.getError(nuCodigoError,sbMensajError);  
      pkg_traza.trace('Error:'||nuCodigoError||'-'||sbMensajError,pkg_traza.cnuNivelTrzDef);                       

       pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);

    WHEN OTHERS THEN
      rollback;
      pkg_error.setError;
      pkg_error.getError(onuErrorCode,osbErrorMessage);  
      pkg_traza.trace('Error:'||onuErrorCode||'-'||osbErrorMessage,pkg_traza.cnuNivelTrzDef);    

      PRLogCHATBOT(NUCONTRATO,
                   onuerrorcode,
                   osberrormessage,
                   sysdate,
                   csbMetodo);

      pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
  END PRVerficarSACRP;

    /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      
      Programa        : prcRegistraSolicitudSacRP
      Descripcion     : Realiza el registro del solicitud 100306- Solicitud SAC 
                        Revision Periodica y Servicios Asociados


      Autor       	:   Luis Felipe Valencia Hurtado
      Fecha       	:   28-05-2024

      Parametros de Entrada
        inuContrato        	  Identificador Contrato
        inuMedioRecepcionId 	Identificador del medio de recepción
        isbComentario         Comentario
        inuActividadId        Actividad
        inuOrdenId            Orden
        onuSolicitud          Solicitud  
        onuCodigoError        Codigo de error
        osbMensajeError       Mensaje de error
      Parametros de Salida
        nuError       codigo de error
        osbError       mensaje de error
      
    Modificaciones  :
      Autor       		    Fecha       Caso     	Descripcion
      felipe.valencia   	28-05-2024  OSF-2728 	Creación
      lubin.pineda   	    21-08-2024  OSF-3037 	Se quita validación que usa
                                                    pkg_bcservicioschatbot.fnuSolicitudSAC
    ***************************************************************************/
    PROCEDURE prcRegistraSolicitudSacRP
    (
        inuContrato           IN  suscripc.susccodi%TYPE,
        inuMedioRecepcionId   IN  mo_packages.reception_type_id%TYPE,
        isbComentario         IN  mo_packages.comment_%TYPE,
        inuActividadId        IN  or_order_activity.activity_id%TYPE,
        inuOrdenId            IN  or_order_activity.order_id%TYPE,
        onuSolicitud          OUT mo_packages.package_id%TYPE,
        onuCodigoError          OUT ge_error_log.message_id%TYPE,
        osbMensajeError       OUT ge_error_log.description%TYPE
    ) 
    AS

        EXCEP_RegistraSolicitudSacRP exception;
        csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'prcRegistraSolicitudSacRP'; 

        --Cursor que obtiene el producto, el contrato del producto y
        --el tipo de trabajo de acuerdo a la orden instanciada
        CURSOR cuProducto(Inucontrato number) 
        IS
        SELECT  t.product_id
        FROM    pr_product t
        WHERE   t.product_type_id = nvl(pkg_bcld_parameter.fnuobtienevalornumerico('COD_SERV_GAS'),7014)
        AND     (t.retire_date > sysdate OR t.retire_date IS NULL) 
        AND     t.subscription_id = Inucontrato
        AND     ROWNUM = 1;

        nuErrorCode       NUMBER;
        sbErrorMessage    VARCHAR2(4000);
        nuPackageId       mo_packages.package_id%TYPE;
        nuMotiveId        mo_motive.motive_id%TYPE;    
        sbRequestXML      constants_per.TIPO_XML_SOL%type;

        nuProducto        NUMBER; 
        nuIdentification  NUMBER;
        nuCliente         NUMBER;  

        sbnumber_id VARCHAR2(20) := pkg_bcld_parameter.fsbobtienevalorcadena('COD_USER_SOLICITUDES_INTERNAS');

        sberrrorexcepcion varchar2(4000);
  BEGIN
      pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);

      -- Se consulta el usuario configurado en el parametro COD_USER_SOLICITUDES_INTERNAS
      nuIdentification := pkg_bcld_parameter.fsbobtienevalorcadena('COD_USER_SOLICITUDES_INTERNAS');

      -- Se valida si el parametro viene null
      IF (nuIdentification IS NULL) THEN
          sberrrorexcepcion := 'Servicio prcRegistraSolicitudSacRP - No existe configurado el parametro COD_USER_SOLICITUDES_INTERNAS';

          pkg_error.setErrorMessage(pkg_error.CNUGENERIC_MESSAGE,'No existe configurado usuario en el parametro COD_USER_SOLICITUDES_INTERNAS' );      
      END IF;

      IF (cuProducto%ISOPEN) THEN
          CLOSE cuProducto;
      END IF;

      OPEN cuProducto(inuContrato);
      FETCH cuProducto INTO nuProducto;
      IF cuProducto%NOTFOUND THEN
          sberrrorexcepcion := 'Servicio prcRegistraSolicitudSacRP - El cursor cuProducto no arrojo datos';
          pkg_error.setErrorMessage(pkg_error.CNUGENERIC_MESSAGE,sberrrorexcepcion );
      END IF;
      CLOSE cuProducto;
    
      nuCliente := pkg_bccontrato.fnuidcliente(inuContrato);

      sbRequestXML := pkg_xml_soli_rev_periodica.getSolicitudSACRp
                      (
                          inuMedioRecepcionId => inuMedioRecepcionId,
                          isbComentario       => isbComentario,
                          inuProductoId       => nuProducto,
                          inuClienteId        => nuCliente,
                          idtFechaSolicitud   => sysdate,
                          inuActividadId      => inuActividadId,
                          inuOrdenId          => inuOrdenId
                      ) ;     

      pkg_traza.trace('XML:'||sbRequestXML,pkg_traza.cnuNivelTrzDef);

      api_registerRequestByXml
      (
          isbRequestXML   => sbRequestXML,
          onuPackageId    => nuPackageId,
          onuMotiveId     => nuMotiveId,
          onuErrorCode    => nuErrorCode,
          osbErrorMessage => sbErrorMessage
      );

      pkg_traza.trace('Paquete : ' || nuPackageId,pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace('Motivo : ' || nuMotiveId,pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace('SALIDA onuErrorCode: ' || nuErrorCode,pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace('SALIDA osbErrorMess: ' || sbErrorMessage,pkg_traza.cnuNivelTrzDef);

      IF nuErrorCode = 0 THEN
          onuSolicitud    := nuPackageId;
          onuCodigoError  := nuErrorCode;
          osbMensajeError := sbErrorMessage;
      ELSE
          onuSolicitud    := null;
          onuCodigoError  := nuErrorCode;
          osbMensajeError := sbErrorMessage;

          ROLLBACK;

          RAISE EXCEP_RegistraSolicitudSacRP;
      END IF;
    
      pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);
  EXCEPTION
    WHEN EXCEP_RegistraSolicitudSacRP THEN
      ROLLBACK;
      prlogchatbot(inuContrato, onuCodigoError, osbMensajeError, sysdate, csbMetodo);

      pkg_error.setError;
      pkg_error.getError(nuCodigoError,sbMensajError);  
      pkg_traza.trace('Error:'||nuCodigoError||'-'||sbMensajError,pkg_traza.cnuNivelTrzDef);                       

      pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
      ROLLBACK;
      pkg_error.setError;
      pkg_error.getError(onuCodigoError,osbMensajeError);  
      pkg_traza.trace('Error:'||onuCodigoError||'-'||osbMensajeError,pkg_traza.cnuNivelTrzDef);    

      prlogchatbot(inuContrato, onuCodigoError, osbMensajeError, sysdate, csbMetodo);

      pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
  END prcRegistraSolicitudSacRP;

END LDCI_PKSERVICIOSCHATBOT;
/

PROMPT Asignación de permisos para el paquete LDCI_PKSERVICIOSCHATBOT
begin
  pkg_utilidades.prAplicarPermisos('LDCI_PKSERVICIOSCHATBOT', 'ADM_PERSON');
end;
/
PROMPT Asignación de permisos para el paquete LDCI_PKSERVICIOSCHATBOT A REXEINNOVA
begin
   EXECUTE IMMEDIATE 'grant execute on ADM_PERSON.LDCI_PKSERVICIOSCHATBOT TO REXEINNOVA';
end;
/

