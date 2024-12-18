CREATE OR REPLACE PACKAGE LDCI_PKGESTINFOADOT AS
  /*
   * Propiedad Intelectual Gases del Caribe SA ESP
   *
   * Script  :
   * RICEF   : I074 - I075
   * Autor   : Jose Donado <jdonado@gascaribe.com>
   * Fecha   : 04-06-2014
   * Descripcion : Paquete gestion de informacion adicional de ordenes moviles

   *
   * Historia de Modificaciones
   * Autor                         Fecha       Descripcion
   * JESUS VIVERO (LUDYCOM)        24-04-2015  #149251-20150424: jesviv: Se agrega calculo de descuento maximo de refinanciacion y fecha de pago como sysdate + dias de gracia
   * JESUS VIVERO (LUDYCOM)        13-05-2015  #148643-20150513: jesviv: Se corrige funcion fnuDescuentoMaxRefinan para calcular de forma correcta el descuento maximo
   * SAMUEL PACHECO (SINCECOMP)    20-01-2016  ca 100-7282: se corrigen error en (Proregistracotizacion) registro de venta cotizada al momento de reenvia venta; de igual forma
                                               se contrala y notifica como error cuando se intenta reenviar una venta ya aplicada
     AAcuna                        04-01-2018  Se agrega flag de validacion de nombre y apellido
   EALVAREZ                      25-01-2019  Se agrega validaci?n del valor de la cuota inicial en una venta, para que sea mayor a cero.
   JOSDON                        21/05/2019  CA 200-2443 Modificación proRegistraCotizacion para agregar campos adicionales a la venta
   JOSDON                        25/07/2019  CA 200-2443 Modificación proRecibeGestionAdicional para retornar mensaje por defecto cuando el resultado es exitoso
   JPINEDC                       26/01/2024  OSF-2021: Se modifican proProcesaXMLVenta y
                                             proProcesaXMLRefinancia

  **/

  FUNCTION fnuDescuentoMaxRefinan(inuProductId In Servsusc.Sesunuse%Type,
                                  inuPlanId    In Number) Return Number;
  PROCEDURE proRecibeGestionAdicional(isbSistema      in VARCHAR2,
                                      isbOperacion    in VARCHAR2,
                                      inuIdProcExter  in NUMBER,
                                      inuOrden        in NUMBER,
                                      isbXML          in CLOB,
                                      onuErrorCode    out NUMBER,
                                      osbErrorMessage out VARCHAR2);
  PROCEDURE proProcesaXMLRefinancia(isbSistema      in VARCHAR2,
                                    inuOrden        in NUMBER,
                                    isbXML          in CLOB,
                                    osbXMLRespuesta out LDCI_PKREPODATAtype.tytabRespuesta,
                                    onuErrorCodi    out NUMBER,
                                    osbErrorMsg     out VARCHAR2);

  PROCEDURE proRegistraCotizacion(inuMensajeId In Number,
                                  inuOrderId   In Number,
                                  isbXMLVenta  In Clob,
                                  onucuotaIni  Out Number,
                                  onuErrorCodi Out Number,
                                  osbErrorMsg  Out Varchar2);

  Procedure proProcesaXMLVenta(isbSistema      In Varchar2,
                               MENSAJE_ID      In Number,
                               inuOrden        In Number,
                               isbXMLVenta     In Clob,
                               otyTabRespuesta Out LDCI_PkRepoDataType.tyTabRespuesta,
                               onuErrorCodi    Out Number,
                               osbErrorMsg     Out Varchar2);
  Procedure proProcesaXMLSoliVisitaVenta(isbSistema      In Varchar2,
                                         inuOrden        In Number,
                                         isbXMLSolicitud In Clob,
                                         otyTabRespuesta Out LDCI_PkRepoDataType.tyTabRespuesta,
                                         onuErrorCodi    Out Number,
                                         osbErrorMsg     Out Varchar2);
  Procedure proProcesaXMLEncuesta(isbSistema      In Varchar2,
                                  inuOrden        In Number,
                                  isbXMLEncuesta  In Clob,
                                  otyTabRespuesta Out LDCI_PkRepoDataType.tyTabRespuesta,
                                  onuErrorCodi    Out Number,
                                  osbErrorMsg     Out Varchar2);
  Procedure proProcesaXMLCalculoConsumo(isbSistema      In Varchar2,
                                        inuOrden        In Number,
                                        isbXMLConsumo   In Clob,
                                        otyTabRespuesta Out LDCI_PkRepoDataType.tyTabRespuesta,
                                        onuErrorCodi    Out Number,
                                        osbErrorMsg     Out Varchar2);
  PROCEDURE proProcesaGestionAdicional(isbSistema   in VARCHAR2,
                                       isbOperacion in VARCHAR2 /*, onuErrorCode out NUMBER, osbErrorMessage out VARCHAR2*/);
  procedure proNotiRespInfoAdic;

  PROCEDURE proProcesaXMLVentaServicios(isbSistema      in VARCHAR2,
                                        inuOrden        in NUMBER,
                                        isbXML          in CLOB,
                                        osbXMLRespuesta out LDCI_PKREPODATAtype.tytabRespuesta,
                                        onuErrorCodi    out NUMBER,
                                        osbErrorMsg     out VARCHAR2);

END LDCI_PKGESTINFOADOT;
/

CREATE OR REPLACE PACKAGE BODY LDCI_PKGESTINFOADOT AS

  FUNCTION fnuDescuentoMaxRefinan(inuProductId In Servsusc.Sesunuse%Type,
                                  inuPlanId    In Number) Return Number As

    /*
    * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
    *
    * Funcion     : fnuDescuentoMaxRefinan
    * Tiquete     :
    * Autor       : JESUS VIVERO (LUDYCOM) <jesus.vivero@ludycom.com>
    * Fecha       : 24-04-2015
    * Descripcion : Calcula el descuento maximo que se le da a un producto segun el plan de refinanciacion.
    *
    * Historia de Modificaciones
    * Autor                    Fecha       Descripcion
    * JESUS VIVERO (LUDYCOM)   24-04-2015  #149251-20150424: jesviv: Creacion de la funcion
    * JESUS VIVERO (LUDYCOM)   13-05-2015  #148643-20150513: jesviv: Se corrige funcion fnuDescuentoMaxRefinan para calcular de forma correcta el descuento maximo
    * AAcuna                   04-01-2018 Se agrega flag de validacion de nombre y apellido
    */

    -- Cursor para consultar descuento por plan y concepto
    Cursor cuDiscount(inuPlanId Number, inuConcept Number) Is
      Select Max(Cdpfporc)
        From Codeplfi
       Where Cdpfpldi = inuPlanId
         And Cdpfconc = inuConcept;

    --Cursor de saldos por concepto distribuidos
    Cursor cuSalConDis(inuProdId In Number) Is
      Select Concept_Id, Pending_Balance
        From CC_Tmp_Bal_By_Conc
       Where Product_Id = inuProdId;

    rgSalConDis cuSalConDis%RowType;

    nuDiscountValue Number;
    nuPorcDiscount  Number;

  BEGIN

    -- Descuento maximo por producto y plan de acuerdo de pago

    nuDiscountValue := 0; -- Inicializa descuento total

    -- Obtiene los conceptos de las cuentas de cobro distribuidas
    CC_BOFinancing.SetProduct(inuProductId => inuProductId,
                              isbSelected  => 'Y',
                              isbCache     => 'N');

    For rgSalConDis in cuSalConDis(inuProductId) Loop

      -- Consulta porcentaje de descuento por concepto y plan
      Open cuDiscount(inuPlanId, rgSalConDis.Concept_Id);
      Fetch cuDiscount
        Into nuPorcDiscount;
      Close cuDiscount;

      nuPorcDiscount := Nvl(nuPorcDiscount, 0) / 100;

      -- Acumula valor de descuento
      nuDiscountValue := nuDiscountValue +
                         (rgSalConDis.Pending_Balance * nuPorcDiscount);

    /*If nuPorcDiscount > 0 Then
                                                                                      Dbms_Output.Put_Line('rgSalConDis.Concept_Id: '||rgSalConDis.Concept_Id);
                                                                                      Dbms_Output.Put_Line('rgSalConDis.Pending_Balance: '||rgSalConDis.Pending_Balance);
                                                                                      Dbms_Output.Put_Line('nuPorcDiscount: '||nuPorcDiscount);
                                                                                      Dbms_Output.Put_Line('nuDiscountValue: '||nuDiscountValue);
                                                                                    End If;*/

    End Loop;

    --Dbms_Output.Put_Line('Descuento Total: '||nuDiscountValue);
    Return nuDiscountValue;

  EXCEPTION
    When Others Then
      Return - 1;
  END fnuDescuentoMaxRefinan;

  PROCEDURE proRecibeGestionAdicional(isbSistema      in VARCHAR2,
                                      isbOperacion    in VARCHAR2,
                                      inuIdProcExter  in NUMBER,
                                      inuOrden        in NUMBER,
                                      isbXML          in CLOB,
                                      onuErrorCode    out NUMBER,
                                      osbErrorMessage out VARCHAR2) AS
    /*
     * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
     *
     * Funcion  : proRecibeGestionAdicional
     * Tiquete :
     * Autor   : Jose Donado <jdonado@gascaribe.com>
     * Fecha   : 04-06-2014
     * Descripcion : Recibe el XML con la informacion adicional de la orden de trabajo
                     gestionada desde el movil
     *
     * Historia de Modificaciones
     * Autor          Fecha      Descripcion
       Jose.Donado    04-06-2014 Creacion del procedimieno
	   JOSDON		  25/07/2019 Se modifica para retornar mensaje por defecto cuando el resultado es exitoso
    **/
    --Variables del Proceso
    nuContador NUMBER;
    --sbExisteGest    NUMBER;

    CURSOR cuSistema(sbSistema ldci_sistmoviltipotrab.sistema_id%TYPE) IS
      SELECT COUNT(s.sistema_id)
        FROM ldci_sistmoviltipotrab s
       WHERE s.sistema_id = sbSistema;

    CURSOR cuOrden(nuOrden or_order.order_id%TYPE) IS
      SELECT o.order_id, o.order_status_id
        FROM or_order o
       WHERE o.order_id = nuOrden;

    CURSOR cuExisteGestion(sbSistema     LDCI_INFGESTOTMOV.SISTEMA_ID%TYPE,
                           nuIdProcExter LDCI_INFGESTOTMOV.PROCESO_EXTERNO_ID%TYPE) IS
      SELECT i.mensaje_id,
             i.sistema_id,
             i.operacion,
             i.order_id,
             i.proceso_externo_id,
             i.estado
        FROM LDCI_INFGESTOTMOV i
       WHERE i.sistema_id = sbSistema
         And i.proceso_externo_id = nuIdProcExter;

    reOrden         cuOrden%ROWTYPE;
    reExisteGestion cuExisteGestion%ROWTYPE;

    --Variables de manejo de error
    sbMsgError VARCHAR2(100);
    errDatosEntrada EXCEPTION; -- Excepcion que valida si proceso registros la consulta
    errExisteGest   EXCEPTION; --Excepcion que valida si ya existe gestion de la operacion

  BEGIN
    --validacion de los parametros de entrada
    IF isbSistema IS NOT NULL THEN
      OPEN cuSistema(isbSistema);
      FETCH cuSistema
        INTO nuContador;
      CLOSE cuSistema;

      IF nuContador = 0 THEN
        sbMsgError := 'El sistema movil ' || isbSistema ||
                      ' no se encuentra configurado en la tabla LDCI_SISTMOVILTIPOTRAB';
        RAISE errDatosEntrada;
      END IF;
    ELSE
      sbMsgError := 'El identificador del sistema enviado no debe ser nulo.';
      RAISE errDatosEntrada;
    END IF;

    IF inuOrden IS NOT NULL THEN
      OPEN cuOrden(inuOrden);
      FETCH cuOrden
        INTO reOrden;
      CLOSE cuOrden;

      IF reOrden.Order_Id IS NULL THEN
        sbMsgError := 'La orden enviada ' || inuOrden ||
                      ' no existe en el sistema';
        RAISE errDatosEntrada;
      END IF;
      /*  ELSE
      sbMsgError := 'El numero de orden enviado no debe ser nulo.';
      RAISE errDatosEntrada;*/
    END IF;

    IF isbXML IS NULL THEN
      sbMsgError := 'No se recibio informacion de los datos adicionales de la orden ' ||
                    inuOrden || ' a gestionar.';
      RAISE errDatosEntrada;
    END IF;

    IF isbOperacion IS NULL THEN
      sbMsgError := 'No se recibio informacion de la operacion a ejecutar de la orden ' ||
                    inuOrden;
      RAISE errDatosEntrada;
    END IF;

    --Valida si ya se ha registrado la gestion
    OPEN cuExisteGestion(isbSistema, inuIdProcExter);
    FETCH cuExisteGestion
      INTO reExisteGestion;

    IF cuExisteGestion%NOTFOUND THEN
      --Almacena la informacion adicional enviada desde el movil para su gestion
      INSERT INTO LDCI_INFGESTOTMOV
        (MENSAJE_ID,
         SISTEMA_ID,
         OPERACION,
         ORDER_ID,
         PROCESO_EXTERNO_ID,
         XML_SOLICITUD,
         ESTADO,
         FECHA_RECEPCION,
         FECHA_PROCESADO,
         FECHA_NOTIFICADO)
      VALUES
        (LDCI_SEQINFOGESNOOT.NEXTVAL,
         isbSistema,
         isbOperacion,
         inuOrden,
         inuIdProcExter,
         isbXML,
         'P',
         SYSDATE,
         NULL,
         NULL);

      onuErrorCode := 0;
	  osbErrorMessage := 'Proceso Exitoso';
      COMMIT;

    ELSE
      IF reExisteGestion.Estado IN ('GE', 'EN') THEN
        UPDATE LDCI_INFGESTOTMOV
           SET XML_SOLICITUD = isbXML, ESTADO = 'P'
         WHERE MENSAJE_ID = reExisteGestion.Mensaje_Id;

        onuErrorCode := 0;
		osbErrorMessage := 'Proceso Exitoso';
        COMMIT;
      ELSE
        CLOSE cuExisteGestion;
        sbMsgError := 'Ya existe gestion de ' || isbOperacion ||
                      ' de la orden ' || inuOrden;
        RAISE errExisteGest;
      END IF;

    END IF;

    CLOSE cuExisteGestion;

  EXCEPTION
    WHEN errDatosEntrada THEN
      onuErrorCode    := -1;
      osbErrorMessage := '[LDCI_PKGESTINFOADOT.proRecibeGestionAdicional.errDatosEntrada]: Error en los datos de entrada, ' ||
                         sbMsgError;
    WHEN errExisteGest THEN
      onuErrorCode    := -1;
      osbErrorMessage := '[LDCI_PKGESTINFOADOT.proRecibeGestionAdicional.errExisteGest]: Error insertando registro. ' ||
                         sbMsgError;
      --RAISE_APPLICATION_ERROR(-20999,sbMsgError);
    WHEN OTHERS THEN
      onuErrorCode    := -1;
      osbErrorMessage := '[LDCI_PKGESTINFOADOT.proRecibeGestionAdicional.others]: ' ||
                         SQLERRM;
  END proRecibeGestionAdicional;

  PROCEDURE proProcesaXMLRefinancia(isbSistema      in VARCHAR2,
                                    inuOrden        in NUMBER,
                                    isbXML          in CLOB,
                                    osbXMLRespuesta out LDCI_PKREPODATAtype.tytabRespuesta,
                                    onuErrorCodi    out NUMBER,
                                    osbErrorMsg     out VARCHAR2) AS
    /*
     * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
     *
     * Funcion  : proProcesaXMLRefinancia
     * Tiquete :
     * Autor   : Jose Donado <jdonado@gascaribe.com>
     * Fecha   : 10-06-2014
     * Descripcion : Recibe el XML de datos adicionales de gestion de cartera para que OSF procese la refinanciacion.
     *
     * Historia de Modificaciones
     * Autor                   Fecha         Descripcion
       Jose.Donado             10-06-2014    Creacion del procedimieno
       JESUS VIVERO (LUDYCOM)  24-04-2015    #149251-20150424: jesviv: Se agrega calculo de descuento maximo de refinanciacion y fecha de pago como sysdate + dias de gracia
        LJLB                   21-05-2018    TICKET 200-1631 -- se coloca validacion de cantidad maxima de refinaciones
        JPINEDC                 26/01/2024   OSF-2021: Se usa API_REGISTERDEBTFINANCING
    **/

    --Datos de Salida
    nuSolicitud mo_packages.package_id%type;
    nuCupon     cupon.cuponume%type;
    nuValor     NUMBER(13, 2) := 0;

    sbFlagValRefi    VARCHAR2(2) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_FLAGVALIREFINA',NULL); --TICKET 200-1631 LJLB -- se almacena flag para validar reconexion

    sbFlagExiRefi    VARCHAR2(2); --TICKET 200-1631 LJLB -- se almacena si se puede o no refinaciar

    CURSOR cuCupon(nuCupon cupon.cuponume%TYPE) IS
      SELECT c.cupovalo FROM cupon c WHERE c.cuponume = nuCupon;

    CURSOR cuXML(isbXMLDat IN CLOB) IS
      SELECT DATOS."INUSUBSCRIPTIONID",
             DATOS."INUPRODUCTID",
             DATOS."ISBDEFERREDLIST",
             DATOS."ISBONLYEXPIREDACC",
             DATOS."ISBREQUIRESIGNING",
             DATOS."IDTREGISTERDATE",
             DATOS."INUDISTRIBUTADMINID",
             DATOS."INURECEPTIONTYPEID",
             DATOS."INUSUBSCRIBERID",
             DATOS."ISBRESPONSEADDRESS",
             DATOS."INUGEOGRALOCATION",
             DATOS."ISBCOMMENT",
             DATOS."INUFINANCINGPLANID",
             DATOS."IDTINITPAYDATE",
             DATOS."INUDISCOUNTVALUE",
             DATOS."INUVALUETOPAY",
             DATOS."INUSPREAD",
             DATOS."INUQUOTESNUMBER",
             DATOS."ISBSUPPORTDOCUMENT",
             DATOS."ISBCOSIGNERSLIST"
        FROM XMLTable('/OS_RegisterDebtFinancing' PASSING
                      XMLType(isbXMLDat) COLUMNS "INUSUBSCRIPTIONID" NUMBER PATH
                      'idSuscripcion',
                      "INUPRODUCTID" NUMBER PATH 'idProducto',
                      "ISBDEFERREDLIST" VARCHAR2(2000) PATH 'listaDiferidos',
                      "ISBONLYEXPIREDACC" VARCHAR2(1) PATH
                      'indicadorDeudaVencida',
                      "ISBREQUIRESIGNING" VARCHAR2(1) PATH
                      'indicadorPerfilFinanc',
                      "IDTREGISTERDATE" DATE PATH 'fechaRegistro',
                      "INUDISTRIBUTADMINID" NUMBER(4) PATH
                      'idLugarRecepcion',
                      "INURECEPTIONTYPEID" NUMBER(4) PATH 'idMedioRecepcion',
                      "INUSUBSCRIBERID" NUMBER(15) PATH 'idCliente',
                      "ISBRESPONSEADDRESS" VARCHAR2(200) PATH 'direccion',
                      "INUGEOGRALOCATION" NUMBER(10) PATH
                      'localizacionGeograf',
                      "ISBCOMMENT" VARCHAR2(2000) PATH 'observacion',
                      "INUFINANCINGPLANID" NUMBER(4) PATH 'idPlanRefinanc',
                      "IDTINITPAYDATE" DATE PATH 'fechaPago',
                      "INUDISCOUNTVALUE" NUMBER(13, 2) PATH 'valorDescontar',
                      "INUVALUETOPAY" NUMBER(13, 2) PATH 'valorPagar',
                      "INUSPREAD" NUMBER(11, 8) PATH 'puntosAdicionales',
                      "INUQUOTESNUMBER" NUMBER(4) PATH 'numeroCuotas',
                      "ISBSUPPORTDOCUMENT" VARCHAR2(30) PATH
                      'documentoSoporte',
                      "ISBCOSIGNERSLIST" VARCHAR2(200) PATH
                      'listaCodeudores') AS DATOS;

    Cursor Cu_DiasGracia(inuPlanId In Number) Is --#149251-20150424: jesviv: Cursor para conseguir los dias de gracia
      Select Max_Grace_Days
        From Cc_Grace_Period g, Plandife p
       Where p.Pldicodi = inuPlanId
         And p.Pldipegr = g.Grace_Period_Id;

    rgXML   cuXML%RowType;
    rgCupon cuCupon%RowType;

    --Variables mensajes SOAP
    --qryCtx        DBMS_XMLGEN.ctxHandle;

    --Estructura de respuesta
    tabRespuesta   LDCI_PKREPODATAtype.tytabRespuesta;
    tyRegRespuesta LDCI_PKREPODATAtype.tyWSRespTrabAdicRecord;

    nuMaxDiscountValue Number; --#149251-20150424: jesviv: Descuento maximo
    nuDiscountValue    Number; --#149251-20150424: jesviv: Descuento
    dtFechaPago        Date; --#149251-20150424: jesviv: Fecha de pago para refinanciar
    nuDiasGracia       Number; --#149251-20150424: jesviv: Dias de gracia

  BEGIN

    OPEN cuXML(isbXML);
    FETCH cuXML
      INTO rgXML;
    CLOSE cuXML;

    -- Se valida si se puede realizar la refinanciacion por el periodo de facturacion del producto
    LDC_OS_ValidBillPeriodByProd(inuProductId    => rgXML.inuProductId,
                                 onuErrorCode    => onuErrorCodi,
                                 osbErrorMessage => osbErrorMsg);

    If Nvl(onuErrorCodi, 0) = 0 Then

      --#149251-20150424: jesviv: (INICIO) - Se inicia segmento para calcular descuentos maximos y fecha de pago
      nuMaxDiscountValue := fnuDescuentoMaxRefinan(inuProductId => rgXML.inuProductId,
                                                   inuPlanId    => rgXML.inuFinancingPlanId);

      If nuMaxDiscountValue > -1 Then

        If rgXML.inuDiscountValue > nuMaxDiscountValue Then
          nuDiscountValue := nuMaxDiscountValue;
        Else
          nuDiscountValue := rgXML.inuDiscountValue;
        End If;

      Else

        nuDiscountValue := rgXML.inuDiscountValue;

      End If;

      Open Cu_DiasGracia(rgXML.inuFinancingPlanId);
      Fetch Cu_DiasGracia
        Into nuDiasGracia;
      Close Cu_DiasGracia;

      dtFechaPago := Trunc(Sysdate) + nuDiasGracia;
      --#149251-20150424: jesviv: (FIN) - Se inicia segmento para calcular descuentos maximos y fecha de pago


      --validar entrega en la gasera
      sbFlagExiRefi := 'S';

      IF FBLAPLICAENTREGA('BSS_CART_LJLB_2001631_1') THEN
        --TICKET 200-1631 LJLB --  se valida si el flag de validacion de refinanciacion esta activo o no
        IF sbFlagValRefi = 'S' THEN
          sbFlagExiRefi := LDC_VALFINPLAREFI.FSBREFINANCIAM(inuOrden); --TICKET 200-1631 LJLB -- se consulta si se puede o refinanciar
        END IF;
      END IF;

      IF sbFlagExiRefi = 'S' THEN
        --llamado al API de refinanciacion
        API_REGISTERDEBTFINANCING(Inusubscriptionid => rgXML.Inusubscriptionid,
                                 Inuproductid      => rgXML.Inuproductid,
                                 Isbdeferredlist   => rgXML.Isbdeferredlist,
                                 Isbonlyexpiredacc => rgXML.Isbonlyexpiredacc,
                                 Isbrequiresigning => rgXML.Isbrequiresigning,
                                 Idtregisterdate   => rgXML.Idtregisterdate,
                                 --Inudistributadminid => rgXML.Inudistributadminid,
                                 Inureceptiontypeid => rgXML.Inureceptiontypeid,
                                 Inusubscriberid    => rgXML.Inusubscriberid,
                                 Isbresponseaddress => rgXML.Isbresponseaddress,
                                 Inugeogralocation  => rgXML.Inugeogralocation,
                                 Isbcomment         => rgXML.Isbcomment,
                                 Inufinancingplanid => rgXML.Inufinancingplanid,
                                 Idtinitpaydate     => dtFechaPago, --rgXML.Idtinitpaydate, #149251-20150424: jesviv: Se calcula fecha de pago
                                 Inudiscountvalue   => nuDiscountValue, --rgXML.Inudiscountvalue, --#149251-20150424: jesviv: se calcula descuento
                                 Inuvaluetopay      => rgXML.Inuvaluetopay,
                                 Inuspread          => rgXML.Inuspread,
                                 Inuquotesnumber    => rgXML.Inuquotesnumber,
                                 Isbsupportdocument => rgXML.Isbsupportdocument,
                                 Isbcosignerslist   => rgXML.Isbcosignerslist,
                                 Onupackageid       => nuSolicitud,
                                 Onucouponnumber    => nuCupon,
                                 Onuerrorcode       => onuErrorCodi,
                                 Osberrormessage    => osbErrorMsg,
                                 isbProcessName     => 'GCNED');

        OPEN cuCupon(nuCupon);
        FETCH cuCupon
          INTO rgCupon;
        CLOSE cuCupon;

        nuValor := rgCupon.Cupovalo;

        IF onuErrorCodi = 0 THEN
          COMMIT;
        ELSE
          nuSolicitud := NULL;
          nuCupon     := NULL;
          nuValor     := NULL;
          ROLLBACK;
        END IF;
     ELSE
       onuErrorCodi := -1;
       osbErrorMsg := 'No se pudo generar la negociaci?n de deuda ya que actualmente el usuario tiene dos financiaciones activas';
     END IF;

    End If;

    -- Genera la Respuesta
    tyRegRespuesta.PARAMETRO := 'idSistema';
    tyRegRespuesta.VALOR := isbSistema;
    tabRespuesta(1) := tyRegRespuesta;
    --
    tyRegRespuesta.PARAMETRO := 'idSolicitud';
    tyRegRespuesta.VALOR := nuSolicitud;
    tabRespuesta(2) := tyRegRespuesta;
    --
    tyRegRespuesta.PARAMETRO := 'numeroCupon';
    tyRegRespuesta.VALOR := nuCupon;
    tabRespuesta(3) := tyRegRespuesta;
    --
    tyRegRespuesta.PARAMETRO := 'valorCupon';
    tyRegRespuesta.VALOR := nuValor;
    tabRespuesta(4) := tyRegRespuesta;
    --
    tyRegRespuesta.PARAMETRO := 'idOrden';
    tyRegRespuesta.VALOR := inuOrden;
    tabRespuesta(5) := tyRegRespuesta;
    --
    tyRegRespuesta.PARAMETRO := 'codigoError';
    tyRegRespuesta.VALOR := onuErrorCodi;
    tabRespuesta(6) := tyRegRespuesta;
    --
    tyRegRespuesta.PARAMETRO := 'mensajeError';
    tyRegRespuesta.VALOR := osbErrorMsg;
    tabRespuesta(7) := tyRegRespuesta;

    /*Qryctx :=  Dbms_Xmlgen.Newcontext ('SELECT :sbSistema AS SISTEMA,
                                        :nuSolicitud AS SOLICITUD,
                                        :nuCupon AS CUPON,
                                        :nuOrden AS ORDEN,
                                        :onuErrorCodi AS ERROR_CODI,
                                        :osbErrorMsg AS ERROR_SMG
                                        FROM   DUAL');

    DBMS_XMLGEN.setBindvalue (qryCtx, 'sbSistema', isbSistema);
    DBMS_XMLGEN.setBindvalue (qryCtx, 'nuSolicitud', nuSolicitud);
    DBMS_XMLGEN.setBindvalue (qryCtx, 'nuCupon', nuCupon);
    DBMS_XMLGEN.setBindvalue (qryCtx, 'nuOrden', inuOrden);
    DBMS_XMLGEN.setBindvalue (qryCtx, 'onuErrorCodi', onuErrorCodi);
    DBMS_XMLGEN.setBindvalue (qryCtx, 'osbErrorMsg', osbErrorMsg);
    DBMS_XMLGEN.SETNULLHANDLING(Qryctx,2);

    Dbms_Xmlgen.setRowSetTag(Qryctx, '');
    DBMS_XMLGEN.setRowTag(qryCtx, 'REFINANC_RESPUESTA');
    --Genera el XML
    --osbXMLRespuesta := DBMS_XMLGEN.getXML(qryCtx);

    --Cierra el contexto
    DBMS_XMLGEN.closeContext(qryCtx);

    --Imprime el XML
    --osbXMLRespuesta := Replace(osbXMLRespuesta, '<?xml version="1.0"?>');   */

    osbXMLRespuesta := tabRespuesta;

  EXCEPTION
    WHEN OTHERS THEN
      onuErrorCodi := -1;
      osbErrorMsg  := '[LDCI_PKGESTINFOADOT.proProcesaXMLRefinancia.others]: ' ||
                      SQLERRM;

  END proProcesaXMLRefinancia;

  /**/
  --JVIVERO
  PROCEDURE proRegistraCotizacion(inuMensajeId In Number,
                                  inuOrderId   In Number,
                                  isbXMLVenta  In Clob,
                                  onucuotaIni  Out Number,
                                  onuErrorCodi Out Number,
                                  osbErrorMsg  Out Varchar2) As

    /*
    * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
    *
    * Proceso     : proRegistraCotizacion
    * Tiquete     :
    * Autor       : JESUS VIVERO (LUDYCOM) <jesus.vivero@ludycom.com>
    * Fecha       : 25-05-2015
    * Descripcion : Registra la cotizaci?n de ventas por sistema externo.
    *
    * Historia de Modificaciones
    * Autor                     Fecha       Descripcion
    * SAMUEL PACHECO (SINCECOMP)20-01-2016  ca 100-7282: se corrigen error en (Proregistracotizacion) registro de venta cotizada al momento de reenvia venta; de igual forma
                                            se contrala y notifica como error cuando se intenta reenviar una venta ya aplicada

      Karem Baquero(sincecomp)  29/07/2015  #7132 : Se agrega la insercci?n del xml en la tabla a para
    *                                       el registro de las ventas.
    * JESUS VIVERO (LUDYCOM)    25-05-2015  #ssssss-20150525: jesviv: Creacion del procedimiento
    * JOSDON                    21/05/2019  CA 200-2443 Modificación de Trámite de ventas, para agregar campos adicionales a la venta
    **/

    -- Cursor para extraer informacion del XML de venta
    Cursor cuInfoVenta(isbXMLDat In Varchar2) Is
      Select Datos.*
        From XMLTable('/P_VENTA_DE_GAS_POR_FORMULARIO_XML_100233' Passing
                      XMLType(isbXMLDat) Columns Fecha_De_Solicitud
                      Varchar2(50) Path 'FECHA_DE_SOLICITUD',
                      Person_Id Number(15) Path 'ID',
                      Pos_Oper_Unit_Id Number(15) Path 'POS_OPER_UNIT_ID',
                      Document_Type_Id Number(2) Path 'DOCUMENT_TYPE_ID',
                      Document_Key Number(15) Path 'DOCUMENT_KEY',
                      Project_Id Number(15) Path 'PROJECT_ID',
                      Comment_ Varchar2(2000) Path 'COMMENT_',
                      Direccion Number(15) Path 'DIRECCION',
                      Categoria Number(2) Path 'CATEGORIA',
                      Subcategoria Number(2) Path 'SUBCATEGORIA',
                      Tipo_De_Identificacion Number(4) Path
                      'TIPO_DE_IDENTIFICACION',
                      Identification Varchar2(20) Path 'IDENTIFICATION',
                      Subscriber_Name Varchar2(100) Path 'SUBSCRIBER_NAME',
                      Apellido Varchar2(100) Path 'APELLIDO',
                      Company Varchar2(100) Path 'COMPANY',
                      Title Varchar2(100) Path 'TITLE',
                      Correo_Electronico Varchar2(100) Path
                      'CORREO_ELECTRONICO',
                      Person_Quantity Number(4) Path 'PERSON_QUANTITY',
                      Old_Operator Varchar2(100) Path 'OLD_OPERATOR',
                      Venta_Empaquetada Varchar2(1) Path 'VENTA_EMPAQUETADA',
                      Tecnico_Venta Number(15) Path 'TECNICO_DE_VENTAS',
                      UT_Instaladora Number(15) Path 'UNIDAD_DE_TRABAJO_INSTALADORA',
                      UT_Certificadora Number(15) Path 'UNIDAD_DE_TRABAJO_CERTIFICADORA',
                      Tipo_Predio Number(4) Path 'TIPO_DE_PREDIO',
                      Predio_Construccion Varchar2(1) Path 'PREDIO_EN_CONSTRUCCION',
                      Predio_Independizacion Varchar2(2) Path 'PREDIO_DE_INDEPENDIZACION',
                      Contrato Number(15) Path 'NUMERO_DE_CONTRATO',
                      Medidor Varchar2(50) Path 'NUMERO_DE_MEDIDOR',
                      Commercial_Plan_Id Number(15) Path
                      'M_INSTALACION_DE_GAS_100219/COMMERCIAL_PLAN_ID',
                      Total_Value Number(13, 2) Path
                      'M_INSTALACION_DE_GAS_100219/TOTAL_VALUE',
                      Plan_De_Financiacion Number(4) Path
                      'M_INSTALACION_DE_GAS_100219/PLAN_DE_FINANCIACION',
                      Initial_Payment Number Path
                      'M_INSTALACION_DE_GAS_100219/INITIAL_PAYMENT',
                      Numero_De_Cuotas Number(4) Path
                      'M_INSTALACION_DE_GAS_100219/NUMERO_DE_CUOTAS',
                      Cuota_Mensual Number(13, 2) Path
                      'M_INSTALACION_DE_GAS_100219/CUOTA_MENSUAL',
                      Init_Payment_Mode Varchar2(2) Path
                      'M_INSTALACION_DE_GAS_100219/INIT_PAYMENT_MODE',
                      Init_Pay_Received Varchar2(1) Path
                      'M_INSTALACION_DE_GAS_100219/INIT_PAY_RECEIVED',
                      Usage Number(4) Path
                      'M_INSTALACION_DE_GAS_100219/USAGE',
                      Install_Type Number(4) Path
                      'M_INSTALACION_DE_GAS_100219/INSTALL_TYPE') As Datos;

    rgInfoVenta cuInfoVenta%RowType;

    -- Cursor para extraer informacion del XML de venta promociones
    Cursor cuInfoPromVenta(isbXMLDat In Varchar2) Is
      Select Datosprom.*
        From XMLTable('/P_VENTA_DE_GAS_POR_FORMULARIO_XML_100233/M_INSTALACION_DE_GAS_100219/PROMOCIONES'
                      Passing XMLType(isbXMLDat) Columns PROMOTION_ID
                      Number(15) Path 'PROMOTION_ID') As Datosprom;

    rgInfoVentaprom cuInfoPromVenta%RowType;

    -- Cursor para extraer informacion del XML de venta telefonos
    Cursor cuInfophoVenta(isbXMLDat In Varchar2) Is
      Select Datospho.*
        From XMLTable('/P_VENTA_DE_GAS_POR_FORMULARIO_XML_100233/TELEFONOS_DE_CONTACTO'
                      Passing XMLType(isbXMLDat) Columns PHONE Number(15) Path
                      'PHONE',
                      PHONE_TYPE_ID Number(1) Path 'PHONE_TYPE_ID') As Datospho;

    -- Cursor para extraer informacion del XML de venta refernecias
    Cursor cuInforefVenta(isbXMLDat In Varchar2) Is
      Select Datosref.*
        From XMLTable('/P_VENTA_DE_GAS_POR_FORMULARIO_XML_100233/REFERENCIAS'
                      Passing XMLType(isbXMLDat) Columns REFERENCE_TYPE_ID
                      Number(15) Path 'REFERENCE_TYPE_ID',
                      NAME_ Number(1) Path 'NAME_',
                      LAST_NAME Number(1) Path 'LAST_NAME',
                      ADDRESS_ID Number(1) Path 'ADDRESS_ID',
                      PHONE Number(1) Path 'PHONE') As Datosref;

    rgInfoVentapho        cuInfophoVenta%RowType;
    sbRegistraVenta       Varchar2(1);
    sbAplicVal            Varchar2(1);
    sbErrorMessage        Varchar2(4000);
    nuseqven              number;
    Nucotizacion_venta_id Ldci_CotiVentasMovil.COTIZACION_VENTA_ID%type;
    stestado              Ldci_CotiVentasMovil.estado%type;
  BEGIN

    --sbRegistraVenta := 'S';

    /* sbAplicVal := Dald_Parameter.fnuGetNumeric_Value('VALIDA_REGIS_COTI_VENTA_MOVIL', Null);

    If Nvl(sbAplicVal, 'N') = 'S' Then*/

    -- Se extrae informacion de la venta
    Open cuInfoVenta(isbXMLVenta);
    Fetch cuInfoVenta
      Into rgInfoVenta;
    Close cuInfoVenta;

    /*Spacheco 14/01/2016: Caso 100-7282 se consulta si la orden de trabajo ya esta registrada en la tablas temporales*/
    begin
      select cotizacion_venta_id, estado
        into Nucotizacion_venta_id, stestado
        from Ldci_CotiVentasMovil l
       where l.order_id = inuOrderId
         and mensaje_id = inuMensajeId;
    exception
      when others then
        Nucotizacion_venta_id := 0;
    end;

    --Spacheco 14/01/2016: Caso 100-7282 SI ARRoja 0 es una venta nueva
    IF Nucotizacion_venta_id = 0 THEN

      select LDCI_SQ_GESTVENTASMOVIL.nextval into nuseqven from dual;

      onucuotaIni := rgInfoVenta.Initial_Payment;


    IF fblaplicaentregaxcaso('200-2262') THEN
      --ealvarez 25/01/2019 C?digo para realizar la validaci?n que el valor inicial sea mayor que cero
      if rgInfoVenta.Initial_Payment <=0 then
        ut_trace.Trace('El valor del pago inicial debe ser mayor que cero', 10);
        --dbms_output.put_line('El valor del pago inicial debe ser mayor que cero');
        RAISE_APPLICATION_ERROR(-20101,'El valor del pago inicial debe ser mayor que cero');
      end if;
    end if;

      Begin
        Insert Into Ldci_CotiVentasMovil
          (COTIZACION_VENTA_ID,
           MENSAJE_ID,
           ORDER_ID,
           FECHA_DE_SOLICITUD,
           PERSON_ID,
           POS_OPER_UNIT_ID,
           DOCUMENT_TYPE_ID,
           DOCUMENT_KEY,
           PROJECT_ID,
           COMMENT_,
           DIRECCION,
           CATEGORIA,
           SUBCATEGORIA,
           TIPO_DE_IDENTIFICACION,
           IDENTIFICATION,
           SUBSCRIBER_NAME,
           APELLIDO,
           COMPANY,
           TITLE,
           CORREO_ELECTRONICO,
           PERSON_QUANTITY,
           OLD_OPERATOR,
           VENTA_EMPAQUETADA,
           TECNICOS_VENTAS_ID,
           UND_INSTALADORA_ID,
           UND_CERTIFICADORA_ID,
           TIPO_PREDIO,
           CONSTRUCCION,
           PREDIO_INDE,
           CONTRATO,
           MEDIDOR,
           COMMERCIAL_PLAN_ID,
           TOTAL_VALUE,
           PLAN_DE_FINANCIACION,
           INITIAL_PAYMENT,
           NUMERO_DE_CUOTAS,
           CUOTA_MENSUAL,
           INIT_PAYMENT_MODE,
           INIT_PAY_RECEIVED,
           USAGE,
           INSTALL_TYPE,
           ESTADO,
           FECHA_REGISTRO,
           fecha_procesado,
           CODIGO_ERROR,
           MENSAJE_ERROR,
           USUARIO,
           solicitud_generada)
        values
          (nuseqven,
           inuMensajeId,
           inuOrderId,
           rgInfoVenta.Fecha_De_Solicitud,
           rgInfoVenta.Person_Id,
           rgInfoVenta.Pos_Oper_Unit_Id,
           rgInfoVenta.Document_Type_Id,
           rgInfoVenta.Document_Key,
           rgInfoVenta.Project_Id,
           rgInfoVenta.Comment_,
           rgInfoVenta.Direccion,
           rgInfoVenta.Categoria,
           rgInfoVenta.Subcategoria,
           rgInfoVenta.Tipo_De_Identificacion,
           rgInfoVenta.Identification,
           rgInfoVenta.Subscriber_Name,
           rgInfoVenta.Apellido,
           rgInfoVenta.Company,
           rgInfoVenta.Title,
           rgInfoVenta.Correo_Electronico,
           rgInfoVenta.Person_Quantity,
           rgInfoVenta.Old_Operator,
           rgInfoVenta.Venta_Empaquetada,
           rgInfoVenta.Tecnico_Venta,
           rgInfoVenta.UT_Instaladora,
           rgInfoVenta.UT_Certificadora,
           rgInfoVenta.Tipo_Predio,
           rgInfoVenta.Predio_Construccion,
           rgInfoVenta.Predio_Independizacion,
           rgInfoVenta.Contrato,
           rgInfoVenta.Medidor,
           rgInfoVenta.Commercial_Plan_Id,
           rgInfoVenta.Total_Value,
           rgInfoVenta.Plan_De_Financiacion,
           rgInfoVenta.Initial_Payment,
           rgInfoVenta.Numero_De_Cuotas,
           rgInfoVenta.Cuota_Mensual,
           rgInfoVenta.Init_Payment_Mode,
           rgInfoVenta.Init_Pay_Received,
           rgInfoVenta.Usage,
           rgInfoVenta.Install_Type,
           --  'P', JJJM
           'R', -- JJJM
           sysdate,
           sysdate,
           null,
           null,
           user,
           -1);

        /*Extracci?n de la inforamci?n de la promoci?n*/
        FOR rgInfoVentaprom IN cuInfoPromVenta(isbXMLVenta) LOOP

          Insert Into LDCI_COTIVENMOVPROMO
            (COTIZACION_VENTA_ID, PROMOTION_ID)
          VALUES
            (nuseqven, rgInfoVentaprom.PROMOTION_ID);

        END LOOP;

        /*Extracci?n de la inforamci?n del telefono*/
        FOR rgInfoVentapho IN cuInfophoVenta(isbXMLVenta) LOOP

          Insert Into LDCI_COTIVENMOVTECO
            (COTIZACION_VENTA_ID, PHONE, PHONE_TYPE_ID)
          VALUES
            (nuseqven, rgInfoVentapho.PHONE, rgInfoVentapho.PHONE_TYPE_ID);

        END LOOP;

        /*Extracci?n de la inforamci?n del telefono*/
        FOR rgInfoVentaref IN cuInforefVenta(isbXMLVenta) LOOP

          Insert Into LDCI_COTIVENMOVREFE
            (COTIZACION_VENTA_ID,
             reference_type_id,
             name_,
             last_name,
             address_id,
             phone)
          VALUES
            (nuseqven,
             rgInfoVentaref.reference_type_id,
             rgInfoVentaref.name_,
             rgInfoVentaref.last_name,
             rgInfoVentaref.address_id,
             rgInfoVentaref.phone);

        END LOOP;

        onuErrorCodi := 0;
        --   commit;

      EXCEPTION
        When Others Then
          onuErrorCodi := -1;
          osbErrorMsg  := '[LDCI_PKGESTINFOADOT.proProcesaXMLVenta.Others]: ' ||
                          SqlErrM;

          UPDATE Ldci_CotiVentasMovil l
             SET l.codigo_error  = onuErrorCodi,
                 l.mensaje_error = osbErrorMsg
           WHERE l.mensaje_id = inuMensajeId
             AND l.order_id = inuOrderId;
      end;
      --Spacheco 14/01/2016: Caso 100-7282 si no es una venta que se esta reenviando
      --y se actualizan datos de la venta
    elsif Nucotizacion_venta_id <> 0 and stestado <> 'A' then
      begin
        update ldci_cotiventasmovil
           set fecha_de_solicitud     = rgInfoVenta.Fecha_De_Solicitud,
               person_id              = rgInfoVenta.Person_Id,
               pos_oper_unit_id       = rgInfoVenta.Pos_Oper_Unit_Id,
               document_type_id       = rgInfoVenta.Document_Type_Id,
               document_key           = rgInfoVenta.Document_Key,
               project_id             = rgInfoVenta.Project_Id,
               comment_               = rgInfoVenta.Comment_,
               direccion              = rgInfoVenta.Direccion,
               categoria              = rgInfoVenta.Categoria,
               subcategoria           = rgInfoVenta.Subcategoria,
               tipo_de_identificacion = rgInfoVenta.Tipo_De_Identificacion,
               identification         = rgInfoVenta.Identification,
               subscriber_name        = rgInfoVenta.Subscriber_Name,
               apellido               = rgInfoVenta.Apellido,
               company                = rgInfoVenta.Company,
               title                  = rgInfoVenta.Title,
               correo_electronico     = rgInfoVenta.Correo_Electronico,
               person_quantity        = rgInfoVenta.Person_Quantity,
               old_operator           = rgInfoVenta.Old_Operator,
               venta_empaquetada      = rgInfoVenta.Venta_Empaquetada,
               TECNICOS_VENTAS_ID     = rgInfoVenta.Tecnico_Venta,
               UND_INSTALADORA_ID     = rgInfoVenta.UT_Instaladora,
               UND_CERTIFICADORA_ID   = rgInfoVenta.UT_Certificadora,
               TIPO_PREDIO            = rgInfoVenta.Tipo_Predio,
               CONSTRUCCION           = rgInfoVenta.Predio_Construccion,
               PREDIO_INDE            = rgInfoVenta.Predio_Independizacion,
               CONTRATO               = rgInfoVenta.Contrato,
               MEDIDOR                = rgInfoVenta.Medidor,
               commercial_plan_id     = rgInfoVenta.Commercial_Plan_Id,
               total_value            = rgInfoVenta.Total_Value,
               plan_de_financiacion   = rgInfoVenta.Plan_De_Financiacion,
               initial_payment        = rgInfoVenta.Initial_Payment,
               numero_de_cuotas       = rgInfoVenta.Numero_De_Cuotas,
               cuota_mensual          = rgInfoVenta.Cuota_Mensual,
               init_payment_mode      = rgInfoVenta.Init_Payment_Mode,
               init_pay_received      = rgInfoVenta.Init_Pay_Received,
               usage                  = rgInfoVenta.Usage,
               install_type           = rgInfoVenta.Install_Type
         where mensaje_id = inuMensajeId
           and order_id = inuOrderId
           and cotizacion_venta_id = Nucotizacion_venta_id;

        /*Spacheco 14/01/2016: Caso 100-7282 se actualiza Extracci?n de la inforamci?n de la promoci?n se actualiza*/
        delete from LDCI_COTIVENMOVPROMO
         where COTIZACION_VENTA_ID = Nucotizacion_venta_id;
        FOR rgInfoVentaprom IN cuInfoPromVenta(isbXMLVenta) LOOP

          Insert Into LDCI_COTIVENMOVPROMO
            (COTIZACION_VENTA_ID, PROMOTION_ID)
          VALUES
            (Nucotizacion_venta_id, rgInfoVentaprom.PROMOTION_ID);

        END LOOP;

        /*Spacheco 14/01/2016: Caso 100-7282 se actualiza Extracci?n de la inforamci?n del telefono*/
        delete from LDCI_COTIVENMOVTECO
         where COTIZACION_VENTA_ID = Nucotizacion_venta_id;

        FOR rgInfoVentapho IN cuInfophoVenta(isbXMLVenta) LOOP

          Insert Into LDCI_COTIVENMOVTECO
            (COTIZACION_VENTA_ID, PHONE, PHONE_TYPE_ID)
          VALUES
            (Nucotizacion_venta_id,
             rgInfoVentapho.PHONE,
             rgInfoVentapho.PHONE_TYPE_ID);

        END LOOP;

        /*Spacheco 14/01/2016: Caso 100-7282 se actualiza REGISTRA EL DETALLE DE REFERENCIAS DE LAS VENTAS REALIZADAS POR EL MOVIL QUE DEBEN SER GESTIONADAS MANUALMENTE ES EL SISTEMA CENTRAL*/

        delete from LDCI_COTIVENMOVREFE
         where COTIZACION_VENTA_ID = Nucotizacion_venta_id;
        FOR rgInfoVentaref IN cuInforefVenta(isbXMLVenta) LOOP

          Insert Into LDCI_COTIVENMOVREFE
            (COTIZACION_VENTA_ID,
             reference_type_id,
             name_,
             last_name,
             address_id,
             phone)
          VALUES
            (Nucotizacion_venta_id,
             rgInfoVentaref.reference_type_id,
             rgInfoVentaref.name_,
             rgInfoVentaref.last_name,
             rgInfoVentaref.address_id,
             rgInfoVentaref.phone);

        END LOOP;
        onuErrorCodi := 0;
      EXCEPTION
        When Others Then
          onuErrorCodi := -1;
          osbErrorMsg  := '[LDCI_PKGESTINFOADOT.proProcesaXMLVenta.Others]: ' ||
                          SqlErrM;

          UPDATE Ldci_CotiVentasMovil l
             SET l.codigo_error  = onuErrorCodi,
                 l.mensaje_error = osbErrorMsg
           WHERE l.mensaje_id = inuMensajeId
             AND l.order_id = inuOrderId;
      end;
      /*Spacheco 14/01/2016: Caso 100-7282 se valida si se esta reenviando venta aplicada*/
    elsif Nucotizacion_venta_id <> 0 and stestado = 'A' then
      onuErrorCodi := -1;
      osbErrorMsg  := '[LDCI_PKGESTINFOADOT.proProcesaXMLVenta]: ' ||
                      'Se este reenviando una venta que esta Aplicada';
    end if;

  EXCEPTION
    When Others Then

      onuErrorCodi := -1;
      osbErrorMsg  := '[LDCI_PKGESTINFOADOT.proProcesaXMLVenta.Others]: ' ||
                      SqlErrM;

  END proRegistraCotizacion;
  /**/

  Procedure proProcesaXMLVenta(isbSistema      In Varchar2,
                               MENSAJE_ID      In Number,
                               inuOrden        In Number,
                               isbXMLVenta     In Clob,
                               otyTabRespuesta Out LDCI_PkRepoDataType.tyTabRespuesta,
                               onuErrorCodi    Out Number,
                               osbErrorMsg     Out Varchar2) As
    /*
    * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
    *
    * Funcion     : proProcesaXMLVenta
    * Tiquete     :
    * Autor       : Jesus Vivero <jesus.vivero@ludycom.com>
    * Fecha       : 17-06-2014
    * Descripcion : Recibe el XML de informacion adicional de registro de venta para que OSF genere la venta.
    *
    * Historia de Modificaciones
    * Autor          Fecha          Descripcion
    * Jesus Vivero   17-06-2014     Creacion del procedimieno
    * JPINEDC        26/01/2024     OSF-2021: Se usa API_REGISTERREQUESTBYXML    
    **/

    -- Cursor para extraer el segmento de XML en texto con la informacion de la venta
    Cursor cuXMLVenta(isbXMLDat In Clob) Is
      Select Replace(Replace(XMLElement("DAT", Datos.XML).getStringVal(),
                             '<DAT>'),
                     '</DAT>') XML
        From XMLTable('/' Passing XMLType(isbXMLDat) Columns XML XMLType Path
                      'P_VENTA_DE_GAS_POR_FORMULARIO_XML_100233') As Datos;

    -- rgInfoVenta cuInfoVenta%RowType;

    --Variables
    sbXMLInfoVenta Varchar2(4000);

    --Datos de Salida
    nuPackageId Number;
    nuMotiveId  Number;
    onucoutaini Number; --karbaq: 29/07/2015 valor de la cuota inicial
    sbapli      varchar2(1); --karbaq: 29/07/2015 validaci?n si se aplica a o no enseguida

    --Estructura de respuesta
    tabRespuesta   LDCI_PkRepoDataType.tyTabRespuesta;
    tyRegRespuesta LDCI_PkRepoDataType.tyWSRespTrabAdicRecord;

  Begin

    -- Se extrae el segmento de XML con la informacion de la venta
    Open cuXMLVenta(isbXMLVenta);
    Fetch cuXMLVenta
      Into sbXMLInfoVenta;
    Close cuXMLVenta;

    --Dbms_OutPut.Put_Line(sbXMLInfoVenta);

    proRegistraCotizacion(MENSAJE_ID,
                          inuOrden,
                          sbXMLInfoVenta,
                          onucoutaini,
                          onuErrorCodi,
                          osbErrorMsg);

    If onuErrorCodi = 0 Then

      sbapli := LDCI_PKOSSVENTMOVILGESMANU.FsbgetValidApli(onucoutaini,
                                                           onuErrorCodi);

      if sbapli = ld_boconstans.csbokFlag then

        -- Llamado a API de OSF para generar la venta por formulario XML
        API_REGISTERREQUESTBYXML(isbRequestXML   => sbXMLInfoVenta,
                                  onuPackageID    => nuPackageId,
                                  onuMotiveID     => nuMotiveId,
                                  onuErrorCode    => onuErrorCodi,
                                  osbErrorMessage => osbErrorMsg);

        -- Se valida la respuesta del API
        If onuErrorCodi = 0 Then

          /*Inicio Karbaq 7132 Se actualiza los datos en la tabla de la informaci?n de ventas*/
          begin
            UPDATE Ldci_CotiVentasMovil l
               SET l.solicitud_generada = nuPackageId,
                   l.fecha_procesado    = sysdate,
                   --                   l.estado             = 'G' JJJM
                   l.estado = 'A' --JJJM
             WHERE l.mensaje_id = MENSAJE_ID
               AND l.order_id = inuOrden;
          EXCEPTION
            When Others Then
              onuErrorCodi := -1;
              osbErrorMsg  := '[LDCI_PKGESTINFOADOT.proProcesaXMLVenta.Others]: ' ||
                              SqlErrM;
              UPDATE Ldci_CotiVentasMovil l
                 SET l.codigo_error  = onuErrorCodi,
                     l.mensaje_error = osbErrorMsg,
                     l.estado        = 'E'
               WHERE l.mensaje_id = MENSAJE_ID
                 AND l.order_id = inuOrden;
          end;
          /*FIN Karbaq 7132 Se actualiza los datos en la tabla de la informaci?n de ventas*/

          -- Commit;
        Else
          nuPackageId := Null;
          nuMotiveId  := Null;
          -- RollBack;

          UPDATE Ldci_CotiVentasMovil l
             SET l.codigo_error  = onuErrorCodi,
                 l.mensaje_error = osbErrorMsg,
                 l.estado        = 'E'
           WHERE l.mensaje_id = MENSAJE_ID
             AND l.order_id = inuOrden;

        End If;
      End If;
    End If;
    -- Genera la Respuesta
    tyRegRespuesta.Parametro := 'idSistema';
    tyRegRespuesta.Valor := isbSistema;
    tabRespuesta(1) := tyRegRespuesta;

    tyRegRespuesta.Parametro := 'idPaquete';
    tyRegRespuesta.Valor := nuPackageId;
    tabRespuesta(2) := tyRegRespuesta;

    tyRegRespuesta.Parametro := 'idMotivo';
    tyRegRespuesta.Valor := nuMotiveId;
    tabRespuesta(3) := tyRegRespuesta;

    tyRegRespuesta.Parametro := 'idOrden';
    tyRegRespuesta.Valor := inuOrden;
    tabRespuesta(4) := tyRegRespuesta;

    tyRegRespuesta.Parametro := 'codigoError';
    tyRegRespuesta.Valor := onuErrorCodi;
    tabRespuesta(5) := tyRegRespuesta;

    tyRegRespuesta.Parametro := 'mensajeError';
    tyRegRespuesta.Valor := osbErrorMsg;
    tabRespuesta(6) := tyRegRespuesta;

    -- Se asigna la respuesta a la salida
    otyTabRespuesta := tabRespuesta;
    commit;
    -- Manejo de excepciones
  Exception
    When Others Then
      onuErrorCodi := -1;
      osbErrorMsg  := '[LDCI_PKGESTINFOADOT.proProcesaXMLVenta.Others]: ' ||
                      SqlErrM;
      UPDATE Ldci_CotiVentasMovil l
         SET l.codigo_error  = onuErrorCodi,
             l.mensaje_error = osbErrorMsg,
             l.estado        = 'E'
       WHERE l.mensaje_id = MENSAJE_ID
         AND l.order_id = inuOrden;

  End proProcesaXMLVenta;

  Procedure proProcesaXMLSoliVisitaVenta(isbSistema      In Varchar2,
                                         inuOrden        In Number,
                                         isbXMLSolicitud In Clob,
                                         otyTabRespuesta Out LDCI_PkRepoDataType.tyTabRespuesta,
                                         onuErrorCodi    Out Number,
                                         osbErrorMsg     Out Varchar2) As
    /*
    * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
    *
    * Funcion     : proProcesaXMLSoliVisitaVenta
    * Tiquete     :
    * Autor       : Jesus Vivero <jesus.vivero@ludycom.com>
    * Fecha       : 09-07-2014
    * Descripcion : Recibe el XML de informacion adicional de registro de solicitud de visita de venta para que OSF genere la nueva solicitud.
    *
       XML de entrada

      <proProcesaXMLSoliVisitaVenta>
        <idUnidadOperativa />
        <idTipoRecepcion />
        <idTipoIdentificacion />
        <identificacion />
        <idTipoSubscriptor />
        <nombre />
        <apellido />
        <telefono />
        <email />
        <direccionContacto />
        <idSegmentoMercado />
        <idDireccionRespuesta />
        <idModoReferencia />
        <observaciones />
        <idRol />
        <idDireccionVisita />
        <tipoPredio />
        <idUsuarioReferente />
      </proProcesaXMLSoliVisitaVenta>

    * Historia de Modificaciones
    * Autor          Fecha      Descripcion
    * Jesus Vivero   17-06-2014 Creacion del procedimieno
    * AAcuna         04-01-2018 Se agrega flag de validacion de nombre y apellido
    **/

    -- Cursor para extraer del XML la informacion de la solicitud de visita de venta
    Cursor cuXMLSolicitud(isbXMLDat In Clob) Is
      Select Datos.Operating_Unit_Id,
             Datos.Reception_Type_Id,
             Datos.Ident_Type_Id,
             Datos.Identification,
             Datos.Subscriber_Type_Id,
             Datos.Subscriber_Name,
             Datos.Subs_Last_Name,
             Datos.Phone,
             Datos.Email,
             Datos.Contact_Address,
             Datos.Marketing_Segment_Id,
             Datos.Address_Id,
             Datos.Refer_Mode_Id,
             Datos.Comments,
             Datos.Role_Id,
             Datos.Direccion_Visita,
             Datos.Tipo_Predio,
             Datos.Usuario_Referente
        From XMLTable('/proProcesaXMLSoliVisitaVenta' Passing
                      XMLType(isbXMLDat) Columns Operating_Unit_Id Number Path
                      'idUnidadOperativa',
                      Reception_Type_Id Number Path 'idTipoRecepcion',
                      Ident_Type_Id Number Path 'idTipoIdentificacion',
                      Identification Varchar2(20) Path 'identificacion',
                      Subscriber_Type_Id Number Path 'idTipoSubscriptor',
                      Subscriber_Name Varchar2(100) Path 'nombre',
                      Subs_Last_Name Varchar2(100) Path 'apellido',
                      Phone Varchar(50) Path 'telefono',
                      Email Varchar2(100) Path 'email',
                      Contact_Address Varchar2(200) Path 'direccionContacto',
                      Marketing_Segment_Id Number Path 'idSegmentoMercado',
                      Address_Id Number Path 'idDireccionRespuesta',
                      Refer_Mode_Id Number Path 'idModoReferencia',
                      Comments Varchar2(2000) Path 'observaciones',
                      Role_Id Number Path 'idRol',
                      Direccion_Visita Number Path 'idDireccionVisita',
                      Tipo_Predio Number Path 'tipoPredio',
                      Usuario_Referente Number Path 'idUsuarioReferente') As Datos;

    -- Cursor para buscar el identificador de la orden que se genero
    Cursor Cu_Orden(inuPacka In Number, inuMotiv In Number) Is
      Select a.Order_Id
        From Or_Order_Activity a --Inner Join Or_Order o On a.Order_Id = o.Order_Id
       Where a.Package_Id = inuPacka --2550434
         And a.Motive_Id = inuMotiv; --2512669;

    Cursor Cu_Suscriptor(isbIdentif In Varchar2) Is
      Select s.Subscriber_Id
        From Ge_Subscriber s
       Where s.Identification = isbIdentif;

    --Variables
    rgSoli           cuXMLSolicitud%RowType;
    nuSubscriberId   Number;
    sbDatosCompletos Varchar2(1);
    SBValNomApe      LD_PARAMETER.VALUE_CHAIN%type;

    --Datos de Salida
    nuPackageId Number;
    nuMotiveId  Number;
    nuOrderId   Number;

    --Estructura de respuesta
    tabRespuesta   LDCI_PkRepoDataType.tyTabRespuesta;
    tyRegRespuesta LDCI_PkRepoDataType.tyWSRespTrabAdicRecord;

  Begin

    -- Buscamos la informacion de la solicitud de visita de venta
    Open cuXMLSolicitud(isbXMLSolicitud);
    Fetch cuXMLSolicitud
      Into rgSoli;
    Close cuXMLSolicitud;

    -- Se obtiene parametros de validacion
    SBValNomApe := Dald_parameter.fsbGetValue_Chain('LDCI_FLAG_VALCERT',
                                                    null);

    if SBValNomApe is null THEN
      onuErrorCodi     := 1;
      osbErrorMsg      := 'Informacion Incompleta al registrar solicitud de visita de venta: Falta crear parametro LDCI_FLAG_VALCERT.';
      sbDatosCompletos := 'N';
    end if;

    -----

    sbDatosCompletos := 'S';

    If rgSoli.Ident_Type_Id Is Null Then
      onuErrorCodi     := 1;
      osbErrorMsg      := 'Informacion Incompleta al registrar solicitud de visita de venta: Falta tipo de identificacion.';
      sbDatosCompletos := 'N';
    End If;

    If rgSoli.Identification Is Null Then
      onuErrorCodi     := 1;
      osbErrorMsg      := 'Informacion Incompleta al registrar solicitud de visita de venta: Falta identificacion.';
      sbDatosCompletos := 'N';
    End If;

    If rgSoli.Subscriber_Type_Id Is Null Then
      onuErrorCodi     := 1;
      osbErrorMsg      := 'Informacion Incompleta al registrar solicitud de visita de venta: Falta tipo de subscriptor.';
      sbDatosCompletos := 'N';
    End If;

    If SBValNomApe = 'S' Then

      If rgSoli.Subscriber_Name Is Null Or rgSoli.Subs_Last_Name Is Null Then
        onuErrorCodi     := 1;
        osbErrorMsg      := 'Informacion Incompleta al registrar solicitud de visita de venta: Falta nombre y/o apellido.';
        sbDatosCompletos := 'N';
      End If;

    Else

      If rgSoli.Subscriber_Name Is Null Or rgSoli.Subs_Last_Name Is Null Then

        rgSoli.Subscriber_Name := 'NO APLICA';
        rgSoli.Subs_Last_Name  := 'NO APLICA';

      End If;

    End If;

    If Nvl(sbDatosCompletos, 'N') = 'S' Then

      -- Validar que el cliente este registrado
      Open Cu_Suscriptor(rgSoli.Identification);
      Fetch Cu_Suscriptor
        Into nuSubscriberId;
      Close Cu_Suscriptor;

      If nuSubscriberId Is Null Then

        Ge_BoSubscriber.CreateSubscriber(inuIdentTypeId      => rgSoli.Ident_Type_Id,
                                         isbIdentification   => rgSoli.Identification,
                                         inuSubscriberTypeId => rgSoli.Subscriber_Type_Id,
                                         isbSubscriberName   => rgSoli.Subscriber_Name,
                                         isbSubsLastName     => rgSoli.Subs_Last_Name,
                                         isbPhone            => rgSoli.Phone,
                                         isbEmail            => rgSoli.Email,
                                         onuSubscriberId     => nuSubscriberId,
                                         isbContactAddress   => rgSoli.Contact_Address,
                                         isbMarketingSegment => rgSoli.Marketing_Segment_Id);

      End If;

      -- Llamado a API de OSF para generar la solicitud de visita de venta por formulario XML
      Ldc_VisitaVentaGasXML(Operating_Unit_Id   => rgSoli.Operating_Unit_Id,
                            Reception_Type_Id   => rgSoli.Reception_Type_Id,
                            Contact_Id          => nuSubscriberId /*rgSoli.Contact_Id*/,
                            Address_Id          => rgSoli.Address_Id,
                            Refer_Mode_Id       => rgSoli.Refer_Mode_Id,
                            Comment_            => rgSoli.Comments,
                            Role_Id             => rgSoli.Role_Id,
                            Direccion_De_Visita => rgSoli.Direccion_Visita,
                            Tipo_De_Predio      => rgSoli.Tipo_Predio,
                            Usuario_Referente   => rgSoli.Usuario_Referente,
                            nuPackage_Id        => nuPackageId,
                            nuMotive_Id         => nuMotiveId,
                            nuOrder_Id          => nuOrderId,
                            nuError             => onuErrorCodi,
                            sbMensajeError      => osbErrorMsg);

      -- Se valida la respuesta del API
      If Nvl(onuErrorCodi, 0) = 0 Then

        Commit;

      Else

        RollBack;

      End If;

      -- Si el API no retorna la informacion de la orden, se consulta aqui
      If nuOrderId Is Null Then
        Open Cu_Orden(nuPackageId, nuMotiveId);
        Fetch Cu_Orden
          Into nuOrderId;
        Close Cu_Orden;
      End If;

    End If; --If Nvl(sbDatosCompletos, 'N') = 'S' Then

    -- Genera la Respuesta
    tyRegRespuesta.Parametro := 'idSistema';
    tyRegRespuesta.Valor := isbSistema;
    tabRespuesta(1) := tyRegRespuesta;

    tyRegRespuesta.Parametro := 'idPaquete';
    tyRegRespuesta.Valor := nuPackageId;
    tabRespuesta(2) := tyRegRespuesta;

    tyRegRespuesta.Parametro := 'idMotivo';
    tyRegRespuesta.Valor := nuMotiveId;
    tabRespuesta(3) := tyRegRespuesta;

    tyRegRespuesta.Parametro := 'idOrden';
    tyRegRespuesta.Valor := Nvl(nuOrderId, inuOrden);
    tabRespuesta(4) := tyRegRespuesta;

    tyRegRespuesta.Parametro := 'codigoError';
    tyRegRespuesta.Valor := Nvl(onuErrorCodi, 0);
    tabRespuesta(5) := tyRegRespuesta;

    tyRegRespuesta.Parametro := 'mensajeError';
    tyRegRespuesta.Valor := osbErrorMsg;
    tabRespuesta(6) := tyRegRespuesta;

    -- Se asigna la respuesta a la salida
    otyTabRespuesta := tabRespuesta;

    -- Manejo de excepciones
  Exception
    When Others Then
      onuErrorCodi := -1;
      osbErrorMsg  := '[LDCI_PKGESTINFOADOT.proProcesaXMLSoliVisitaVenta.Others]: ' ||
                      SqlErrM;

  End proProcesaXMLSoliVisitaVenta;

  Procedure proProcesaXMLEncuesta(isbSistema      In Varchar2,
                                  inuOrden        In Number,
                                  isbXMLEncuesta  In Clob,
                                  otyTabRespuesta Out LDCI_PkRepoDataType.tyTabRespuesta,
                                  onuErrorCodi    Out Number,
                                  osbErrorMsg     Out Varchar2) As
    /*
    * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
    *
    * Funcion     : proProcesaXMLEncuesta
    * Tiquete     :
    * Autor       : Jesus Vivero <jesus.vivero@ludycom.com>
    * Fecha       : 25-08-2014
    * Descripcion : Recibe el XML de informacion adicional de registro de encuestas.
    *
    *  XML de entrada
    *
      <proProcesaXMLEncuesta>
        <idOrden />
        <encuesta>
          <pregunta>
            <idGrupo />
            <idPregunta />
            <respuesta />
          </pregunta>
        </encuesta>
      </proProcesaXMLEncuesta>

    * Historia de Modificaciones
    * Autor          Fecha      Descripcion
    * Jesus Vivero   25-08-2014 Creacion del procedimieno
    **/

    -- Cursor para extraer del XML la informacion de la encuesta
    Cursor cuXMLEncuesta(isbXMLDat In Clob) Is
      Select Enc.Orden_Id, Det.Grupo_Id, Det.Pregunta_Id, Det.Respuesta
        From XMLTable('/proProcesaXMLEncuesta' Passing XMLType(isbXMLDat)
                      Columns Orden_Id Number Path 'idOrden',
                      XMLEncuesta XMLType Path 'encuesta') As Enc,
             XMLTable('/encuesta/pregunta' Passing Enc.XMLEncuesta Columns
                      Grupo_Id Number Path 'idGrupo',
                      Pregunta_Id Number Path 'idPregunta',
                      Respuesta Varchar2(200) Path 'respuesta') As Det;

    --Variables
    nuPreguntasReg Number;

    --Datos de Salida

    --Estructura de respuesta
    tabRespuesta   LDCI_PkRepoDataType.tyTabRespuesta;
    tyRegRespuesta LDCI_PkRepoDataType.tyWSRespTrabAdicRecord;

  Begin

    -- Inicializacion control de error
    onuErrorCodi := 0;
    osbErrorMsg  := Null;

    -- Inicializacion del contador de preguntas registradas
    nuPreguntasReg := 0;

    -- Iniciamos el recorrido del detalle de preguntas de la encuesta
    For rgEncuesta In cuXMLEncuesta(isbXMLEncuesta) Loop

      Begin

        -- Se inserta la pregunta y la respuesta en la tabla donde se almacena la encuesta
        Insert Into Ldc_Encuesta
          (Orden_Id, Grupo_Pregunta_Id, Pregunta_Id, Respuesta)
        Values
          (rgEncuesta.Orden_Id,
           rgEncuesta.Grupo_Id,
           rgEncuesta.Pregunta_Id,
           rgEncuesta.Respuesta);

        -- Se incrementa el numero de preguntas registradas
        nuPreguntasReg := Nvl(nuPreguntasReg, 0) + 1;

      Exception
        When Dup_Val_On_Index Then
          onuErrorCodi := 1;
          osbErrorMsg  := 'Grupo:' || To_Char(rgEncuesta.Grupo_Id) ||
                          ', Pregunta:' || To_Char(rgEncuesta.Pregunta_Id) ||
                          ', Error:Esta pregunta esta duplicada o ya fue registrada con la misma respuesta en la encuesta para esta orden.';
          Exit;
        When Others Then
          onuErrorCodi := 2;
          osbErrorMsg  := 'Grupo:' || To_Char(rgEncuesta.Grupo_Id) ||
                          ', Pregunta:' || To_Char(rgEncuesta.Pregunta_Id) ||
                          ', Error:' || SqlErrM;
          Exit;
      End;

    End Loop;

    -- Se valida si ocurrio error
    If Nvl(onuErrorCodi, 0) = 0 Then

      Commit;

    Else

      RollBack;
      nuPreguntasReg := 0;

    End If;

    -- Genera la Respuesta
    tyRegRespuesta.Parametro := 'idSistema';
    tyRegRespuesta.Valor := isbSistema;
    tabRespuesta(1) := tyRegRespuesta;

    tyRegRespuesta.Parametro := 'idOrden';
    tyRegRespuesta.Valor := inuOrden;
    tabRespuesta(2) := tyRegRespuesta;

    tyRegRespuesta.Parametro := 'preguntasRegistradas';
    tyRegRespuesta.Valor := Nvl(nuPreguntasReg, 0);
    tabRespuesta(3) := tyRegRespuesta;

    tyRegRespuesta.Parametro := 'codigoError';
    tyRegRespuesta.Valor := Nvl(onuErrorCodi, 0);
    tabRespuesta(4) := tyRegRespuesta;

    tyRegRespuesta.Parametro := 'mensajeError';
    tyRegRespuesta.Valor := osbErrorMsg;
    tabRespuesta(5) := tyRegRespuesta;

    -- Se asigna la respuesta a la salida
    otyTabRespuesta := tabRespuesta;

    -- Manejo de excepciones
  Exception
    When Others Then
      onuErrorCodi := -1;
      osbErrorMsg  := '[LDCI_PKGESTINFOADOT.proProcesaXMLEncuesta.Others]: ' ||
                      SqlErrM;

  End proProcesaXMLEncuesta;

  Procedure proProcesaXMLCalculoConsumo(isbSistema      In Varchar2,
                                        inuOrden        In Number,
                                        isbXMLConsumo   In Clob,
                                        otyTabRespuesta Out LDCI_PkRepoDataType.tyTabRespuesta,
                                        onuErrorCodi    Out Number,
                                        osbErrorMsg     Out Varchar2) As
    /*
    * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
    *
    * Funcion     : proProcesaXMLCalculoConsumo
    * Tiquete     :
    * Autor       : Jesus Vivero <jesus.vivero@ludycom.com>
    * Fecha       : 25-08-2014
    * Descripcion : Recibe el XML de informacion adicional de registro de calculo de consumo.
    *
    *  XML de entrada
    *
      <proProcesaXMLCalculoConsumo>
        <idOrden />
        <equipos>
          <equipo>
            <idEquipo />
            <cantidad />
            <capacidadBtu />
            <capacidadM3 />
            <usoDiarioHoras />
            <usoMensualDias />
            <consumoDiarioBtu />
            <consumoMensualM3 />
            <observaciones />
          </equipo>
        </equipos>
      </proProcesaXMLCalculoConsumo>

    * Historia de Modificaciones
    * Autor          Fecha      Descripcion
    * Jesus Vivero   25-08-2014 Creacion del procedimieno
    **/

    -- Cursor para extraer del XML la informacion de la encuesta
    Cursor cuXMLConsumo(isbXMLDat In Clob) Is
      Select Enc.Orden_Id,
             Det.Equipo_Id,
             Det.Cantidad,
             Det.Capacidad_Btu,
             Det.Capacidad_M3,
             Det.Uso_Diario_Horas,
             Det.Uso_Mensual_Dias,
             Det.Consumo_Diario_Btu,
             Det.Consumo_Mensual_M3,
             Det.Observaciones
        From XMLTable('/proProcesaXMLCalculoConsumo' Passing
                      XMLType(isbXMLDat) Columns Orden_Id Number Path
                      'idOrden',
                      XMLEquipos XMLType Path 'equipos') Enc,
             XMLTable('/equipos/equipo' Passing Enc.XMLEquipos Columns
                      Equipo_Id Number Path 'idEquipo',
                      Cantidad Number Path 'cantidad',
                      Capacidad_Btu Number Path 'capacidadBtu',
                      Capacidad_M3 Number Path 'capacidadM3',
                      Uso_Diario_Horas Number Path 'usoDiarioHoras',
                      Uso_Mensual_Dias Number Path 'usoMensualDias',
                      Consumo_Diario_Btu Number Path 'consumoDiarioBtu',
                      Consumo_Mensual_M3 Number Path 'consumoMensualM3',
                      Observaciones Varchar2(4000) Path 'observaciones') As Det;

    --Variables
    nuConsumoReg Number;

    --Datos de Salida

    --Estructura de respuesta
    tabRespuesta   LDCI_PkRepoDataType.tyTabRespuesta;
    tyRegRespuesta LDCI_PkRepoDataType.tyWSRespTrabAdicRecord;

  Begin

    -- Inicializacion control de error
    onuErrorCodi := 0;
    osbErrorMsg  := Null;

    -- Inicializacion del contador de consumo de equipos
    nuConsumoReg := 0;

    -- Iniciamos el recorrido del detalle de consumo de equipos
    For rgConsumo In cuXMLConsumo(isbXMLConsumo) Loop

      Begin

        -- Se inserta el consumo del equipo en la tabla
        Insert Into Ldc_Calculo_Consumo
          (Orden_Id,
           Equipo_Id,
           Cantidad,
           Capacidad_Btu,
           Capacidad_M3,
           Uso_Diario_Horas,
           Uso_Mensual_Dias,
           Consumo_Diario_Btu,
           Consumo_Mensual_M3,
           Observaciones)
        Values
          (rgConsumo.Orden_Id,
           rgConsumo.Equipo_Id,
           rgConsumo.Cantidad,
           rgConsumo.Capacidad_Btu,
           rgConsumo.Capacidad_M3,
           rgConsumo.Uso_Diario_Horas,
           rgConsumo.Uso_Mensual_Dias,
           rgConsumo.Consumo_Diario_Btu,
           rgConsumo.Consumo_Mensual_M3,
           rgConsumo.Observaciones);

        -- Se incrementa el numero de consumos registrados
        nuConsumoReg := Nvl(nuConsumoReg, 0) + 1;

      Exception
        When Dup_Val_On_Index Then
          onuErrorCodi := 1;
          osbErrorMsg  := 'Equipo:' || To_Char(rgConsumo.Equipo_Id) ||
                          ', Error:Este equipo tiene informacion duplicada o ya fue registrado con la misma informacion para esta orden.';
          Exit;
        When Others Then
          onuErrorCodi := 2;
          osbErrorMsg  := 'Equipo:' || To_Char(rgConsumo.Equipo_Id) ||
                          ', Error:' || SqlErrM;
          Exit;
      End;

    End Loop;

    -- Se valida si ocurrio error
    If Nvl(onuErrorCodi, 0) = 0 Then

      Commit;

    Else

      RollBack;
      nuConsumoReg := 0;

    End If;

    -- Genera la Respuesta
    tyRegRespuesta.Parametro := 'idSistema';
    tyRegRespuesta.Valor := isbSistema;
    tabRespuesta(1) := tyRegRespuesta;

    tyRegRespuesta.Parametro := 'idOrden';
    tyRegRespuesta.Valor := inuOrden;
    tabRespuesta(2) := tyRegRespuesta;

    tyRegRespuesta.Parametro := 'consumosRegistrados';
    tyRegRespuesta.Valor := Nvl(nuConsumoReg, 0);
    tabRespuesta(3) := tyRegRespuesta;

    tyRegRespuesta.Parametro := 'codigoError';
    tyRegRespuesta.Valor := Nvl(onuErrorCodi, 0);
    tabRespuesta(4) := tyRegRespuesta;

    tyRegRespuesta.Parametro := 'mensajeError';
    tyRegRespuesta.Valor := osbErrorMsg;
    tabRespuesta(5) := tyRegRespuesta;

    -- Se asigna la respuesta a la salida
    otyTabRespuesta := tabRespuesta;

    -- Manejo de excepciones
  Exception
    When Others Then

      onuErrorCodi := -1;
      osbErrorMsg  := '[LDCI_PKGESTINFOADOT.proProcesaXMLCalculoConsumo.Others]: ' ||
                      SqlErrM;

      --#20150120: jesusv: Se agrega notificacion de respuesta de error
      -- Genera la Respuesta
      tyRegRespuesta.Parametro := 'idSistema';
      tyRegRespuesta.Valor := isbSistema;
      tabRespuesta(1) := tyRegRespuesta;

      tyRegRespuesta.Parametro := 'idOrden';
      tyRegRespuesta.Valor := inuOrden;
      tabRespuesta(2) := tyRegRespuesta;

      tyRegRespuesta.Parametro := 'consumosRegistrados';
      tyRegRespuesta.Valor := 0;
      tabRespuesta(3) := tyRegRespuesta;

      tyRegRespuesta.Parametro := 'codigoError';
      tyRegRespuesta.Valor := onuErrorCodi;
      tabRespuesta(4) := tyRegRespuesta;

      tyRegRespuesta.Parametro := 'mensajeError';
      tyRegRespuesta.Valor := osbErrorMsg;
      tabRespuesta(5) := tyRegRespuesta;

      -- Se asigna la respuesta a la salida
      otyTabRespuesta := tabRespuesta;

  End proProcesaXMLCalculoConsumo;

  PROCEDURE proProcesaGestionAdicional(isbSistema   in VARCHAR2,
                                       isbOperacion in VARCHAR2 /*, onuErrorCode out NUMBER, osbErrorMessage out VARCHAR2*/) AS
    /*
     * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
     *
     * Funcion  : proProcesaGestionAdicional
     * Tiquete :
     * Autor   : Harold Altamiranda <harold.altamiranda@stackpointer.co>
     * Fecha   : 11-07-2014
     * Descripcion : Procesa las solicitudes de gestion adicional
     *
     * Historia de Modificaciones
     * Autor          Fecha                  Descripcion
       Spacheco       15/10/2015             se modifica, para que al momento de registrar errores
                                             en la tabla LDCI_INFGESTOTMOV, registre el codigo de
                                             error (campo COD_ERROR_OSF), y el mensaje de error
                                             (campo MSG_ERROR_OSF)
											 
	    ESANTIAGO      4/06/2020             caso170:se modifica, el proceso de procesamiento de 
		(HORBATH)							 encuestas para que no procese la encuesta hasta 
											 que no se encuentre legalizada la orden la cual la genero. 
		
                                             
    **/
    CURSOR cuSistema IS
      SELECT MENSAJE_ID,
             SISTEMA_ID,
             ORDER_ID,
             XML_SOLICITUD,
             ESTADO,
             OPERACION
        FROM LDCI_INFGESTOTMOV
       WHERE ESTADO in ('P' /*,'GE','EN'*/)
         AND SISTEMA_ID LIKE NVL(isbSistema, '%')
         AND OPERACION LIKE NVL(isbOperacion, '%');
		 
	CURSOR cuOrden (ORDERN NUMBER) IS --caso:170
		select * 
      from or_order o 
      where order_id=ORDERN;
	  
	CURSOR cuValordtt (tipotr NUMBER) IS --caso:170
	select 1 
    FROM TABLE(ldc_boutilities.splitstrings(OPEN.DALD_PARAMETER.fsbGetValue_Chain('TIPO_TRAB_REVI_CONS',NULL),','))
                         where to_number(COLUMN_VALUE)=tipotr;

    osbXMLRespuesta LDCI_PKREPODATAtype.tytabRespuesta;
    contError       number default 0;
    contCorrectos   number default 0;
    --contMesainf NUMBER;
    onuErrorCodi NUMBER;
    osbErrorMsg  VARCHAR2(2000);
	BLCASO170    BOOLEAN;--caso:170
	NUEXITO		 NUMBER;--caso:170
	NUVALTT		 NUMBER;--caso:170
    --Estructura de respuesta
    tyRegRespuesta LDCI_PkRepoDataType.tyWSRespTrabAdicRecord;
	rfcu_order  cuOrden%ROWTYPE; --caso:170
  BEGIN

    --DBMS_OUTPUT.PUT_LINE('[ INICIO PROCESAMIENTO GESTION ADICIONALES, FECHA: ' || to_char(SYSDATE,'DD/MM/YY HH:MI:SS') || ' ]');
    --RECORRE LA TABLA LDCI_INFOGESTIONOTMOVIL EN BUSQUEDA DE SOLICITUDES ADICIONALES PENDIENTES Y GESTIONADAS CON ERROR
	
	BLCASO170 := FBLAPLICAENTREGAXCASO('0000170');--caso:170
	
    FOR REG IN cuSistema LOOP
		
		NUEXITO :=0;
      BEGIN

        --PROCESA LAS GESTIONES ADICIONALES
        onuErrorCodi := 0;
        --DBMS_OUTPUT.PUT_LINE('Operacion: [' || REG.OPERACION || ']');
        IF REG.OPERACION = 'REFINANCIA' THEN
          LDCI_PKGESTINFOADOT.PROPROCESAXMLREFINANCIA(REG.SISTEMA_ID,
                                                      REG.ORDER_ID,
                                                      REG.XML_SOLICITUD,
                                                      osbXMLRespuesta,
                                                      onuErrorCodi,
                                                      osbErrorMsg);
          --DBMS_OUTPUT.PUT_LINE('onuErrorCodi: [' || onuErrorCodi || '] osbErrorMsg: [' || osbErrorMsg || ']');
        ELSIF REG.OPERACION = 'VENTA_FORMULARIO' THEN
          LDCI_PKGESTINFOADOT.proProcesaXMLVenta(REG.SISTEMA_ID,
                                                 REG.MENSAJE_ID,
                                                 REG.ORDER_ID,
                                                 REG.XML_SOLICITUD,
                                                 osbXMLRespuesta,
                                                 onuErrorCodi,
                                                 osbErrorMsg);
          --DBMS_OUTPUT.PUT_LINE('onuErrorCodi: [' || onuErrorCodi || '] osbErrorMsg: [' || osbErrorMsg || ']');
        ELSIF REG.OPERACION = 'SOLICITUD_VISITA' THEN
          LDCI_PKGESTINFOADOT.proProcesaXMLSoliVisitaVenta(REG.SISTEMA_ID,
                                                           REG.ORDER_ID,
                                                           REG.XML_SOLICITUD,
                                                           osbXMLRespuesta,
                                                           onuErrorCodi,
                                                           osbErrorMsg);
          --DBMS_OUTPUT.PUT_LINE('onuErrorCodi: [' || onuErrorCodi || '] osbErrorMsg: [' || osbErrorMsg || ']');
        ELSIF REG.OPERACION = 'ENCUESTA' THEN
		---inicio caso:170
		
			OPEN cuOrden(REG.ORDER_ID);
            FETCH cuOrden INTO rfcu_order;
			CLOSE cuOrden;
			
			OPEN cuValordtt(rfcu_order.task_type_id);
            FETCH cuValordtt INTO NUVALTT;
			CLOSE cuValordtt;
			
			IF NUVALTT = 1 AND BLCASO170 = TRUE THEN
			
				IF rfcu_order.order_status_id =8 THEN
					LDCI_PKGESTINFOADOT.proProcesaXMLEncuesta(REG.SISTEMA_ID,
														REG.ORDER_ID,
														REG.XML_SOLICITUD,
														osbXMLRespuesta,
														onuErrorCodi,
														osbErrorMsg);
				ELSE
				--PROCREARERRORLOGINT
					NUEXITO:=1;
					LDCI_pkWebServUtils.Procrearerrorlogint('proProcesaGestionAdicional',
													  '1',
													  'No está legalizada la orden: '||REG.ORDER_ID||'  mediante el llamado del servicio LDCI_PKWEBSERVUTILS.PROCREARERRORLOGINT ' ||
													  DBMS_UTILITY.format_error_backtrace,
													  null,
													  null);
				
				END IF;
			ELSE
				
				LDCI_PKGESTINFOADOT.proProcesaXMLEncuesta(REG.SISTEMA_ID,
                                                    REG.ORDER_ID,
                                                    REG.XML_SOLICITUD,
                                                    osbXMLRespuesta,
                                                    onuErrorCodi,
                                                    osbErrorMsg);
			
			END IF;		 
		
		-- fin caso: 170
          /*LDCI_PKGESTINFOADOT.proProcesaXMLEncuesta(REG.SISTEMA_ID,
                                                    REG.ORDER_ID,
                                                    REG.XML_SOLICITUD,
                                                    osbXMLRespuesta,
                                                    onuErrorCodi,
                                                    osbErrorMsg);*/
          --DBMS_OUTPUT.PUT_LINE('onuErrorCodi: [' || onuErrorCodi || '] osbErrorMsg: [' || osbErrorMsg || ']');
        ELSIF REG.OPERACION = 'CALCULO_CONSUMO' THEN
          LDCI_PKGESTINFOADOT.proProcesaXMLCalculoConsumo(REG.SISTEMA_ID,
                                                          REG.ORDER_ID,
                                                          REG.XML_SOLICITUD,
                                                          osbXMLRespuesta,
                                                          onuErrorCodi,
                                                          osbErrorMsg);

        ELSIF REG.OPERACION = 'VENTA_SERVICIOS' THEN
          LDCI_PKGESTINFOADOT.proProcesaXMLVentaServicios(REG.SISTEMA_ID,
                                                          REG.ORDER_ID,
                                                          REG.XML_SOLICITUD,
                                                          osbXMLRespuesta,
                                                          onuErrorCodi,
                                                          osbErrorMsg);
          --DBMS_OUTPUT.PUT_LINE('onuErrorCodi: [' || onuErrorCodi || '] osbErrorMsg: [' || osbErrorMsg || ']');
        ELSE
          osbXMLRespuesta.DELETE;
          onuErrorCodi := 1;
          tyRegRespuesta.parametro := 'codigoError';
          tyRegRespuesta.valor := '1';
          osbXMLRespuesta(1) := tyRegRespuesta;
          tyRegRespuesta.parametro := 'mensajeError';
          tyRegRespuesta.valor := 'TIPO DE PROCESO NO DEFINIDO';
          osbXMLRespuesta(2) := tyRegRespuesta;
        END IF;
		
		IF NUEXITO <> 1 THEN --CASO: 170
			-------------------------------------------------------------------------------------------
			--VALIDA QUE EL CODIGO ERROR Y XML DE RESPUESTA NO ESTE NULL
			IF NVL(onuErrorCodi, 0) = 0   THEN

			  --ACTUALIZA LA SOLICITUD A GESTIONADA
			  UPDATE LDCI_INFGESTOTMOV
				 SET ESTADO = 'G', FECHA_PROCESADO = SYSDATE
			   WHERE MENSAJE_ID = REG.MENSAJE_ID;

			  DELETE FROM LDCI_MESAINFGESNOTMOVIL
			   WHERE MENSAJE_ID = REG.MENSAJE_ID;

			  FOR i IN osbXMLRespuesta.FIRST .. osbXMLRespuesta.LAST LOOP
				--REGISTRA EL RESULTADO DEL XML DE RESPUESTA
				INSERT INTO LDCI_MESAINFGESNOTMOVIL
				  (MENSAJE_ID, PARAMETRO_ID, VALOR)
				VALUES
				  (REG.MENSAJE_ID,
				   osbXMLRespuesta(i).PARAMETRO,
				   osbXMLRespuesta(i).VALOR);
				---
				--ACTUALIZA LA SOLICITUD A GESTIONADA con los mensaje de error Spacheco Ara 8827
				if osbXMLRespuesta(i).PARAMETRO = 'codigoError' then
				  UPDATE LDCI_INFGESTOTMOV
					 SET COD_ERROR_OSF = osbXMLRespuesta(i).VALOR
				   WHERE MENSAJE_ID = REG.MENSAJE_ID;
				elsif osbXMLRespuesta(i).PARAMETRO = 'mensajeError' then
				  UPDATE LDCI_INFGESTOTMOV
					 SET msg_error_osf = osbXMLRespuesta(i).VALOR
				   WHERE MENSAJE_ID = REG.MENSAJE_ID;

				end if;

			  END LOOP;
			  contCorrectos := contCorrectos + 1;
			  COMMIT;

			ELSE

			  --ACTUALIZA LA SOLICITUD A GESTIONADA CON ERROR
			  --DBMS_OUTPUT.PUT_LINE('MENSAJE_ID: [' || REG.MENSAJE_ID || '] Fue gestionado con error.');
			  UPDATE LDCI_INFGESTOTMOV
				 SET ESTADO = 'GE', FECHA_PROCESADO = sysdate
			   WHERE MENSAJE_ID = REG.MENSAJE_ID;

			  DELETE FROM LDCI_MESAINFGESNOTMOVIL
			   WHERE MENSAJE_ID = REG.MENSAJE_ID;

			  FOR i IN osbXMLRespuesta.FIRST .. osbXMLRespuesta.LAST LOOP
				--REGISTRA EL RESULTADO DEL XML DE RESPUESTA
				INSERT INTO LDCI_MESAINFGESNOTMOVIL
				  (MENSAJE_ID, PARAMETRO_ID, VALOR)
				VALUES
				  (REG.MENSAJE_ID,
				   osbXMLRespuesta(i).PARAMETRO,
				   osbXMLRespuesta(i).VALOR);

				--ACTUALIZA LA SOLICITUD A GESTIONADA con los mensaje de error Spacheco Ara 8827
				if osbXMLRespuesta(i).PARAMETRO = 'codigoError' then
				  UPDATE LDCI_INFGESTOTMOV
					 SET COD_ERROR_OSF = osbXMLRespuesta(i).VALOR
				   WHERE MENSAJE_ID = REG.MENSAJE_ID;
				elsif osbXMLRespuesta(i).PARAMETRO = 'mensajeError' then
				  UPDATE LDCI_INFGESTOTMOV
					 SET msg_error_osf = osbXMLRespuesta(i).VALOR
				   WHERE MENSAJE_ID = REG.MENSAJE_ID;

				end if;
			  END LOOP;
			  contError := contError + 1;
			  COMMIT;

			END IF;
			----------------------------------------------------------------------------------------------------
		END IF;--NUEXITO <> 1

      EXCEPTION

        WHEN OTHERS THEN
          --DBMS_OUTPUT.PUT_LINE('MENSAJE_ID: ' || REG.MENSAJE_ID || ' EXCEPTION: ' || SQLERRM);
          LDCI_pkWebServUtils.Procrearerrorlogint('LDCI_PKGESTINFOADOT.proProcesaGestionAdicional',
                                                  1,
                                                  'El proceso de gestion adicional fallo: ' ||
                                                  DBMS_UTILITY.format_error_backtrace,
                                                  null,
                                                  null);

          ROLLBACK;
      END;

    END LOOP;

    --DBMS_OUTPUT.PUT_LINE('Solicitud(es) procesada(s) correctamente: [' || contCorrectos || ']');
    --DBMS_OUTPUT.PUT_LINE('Solicitud(es) procesada(s) con error: [' || contError || ']');
    --onuErrorCode := 0;
    --osbErrorMessage := 'El Procesamiento de Gestion Adicionales termino correctamente.';
    --DBMS_OUTPUT.PUT_LINE('[ FIN PROCESAMIENTO GESTION ADICIONALES ]');

  EXCEPTION
    WHEN OTHERS THEN
      --onuErrorCode := -1;
      --osbErrorMessage := '[LDCI_PKGESTINFOADOT.proProcesaGestionAdicional.others]: ' || SQLERRM;
      LDCI_pkWebServUtils.Procrearerrorlogint('LDCI_PKGESTINFOADOT.proProcesaGestionAdicional',
                                              1,
                                              'El proceso de gestion adicional fallo: ' ||
                                              DBMS_UTILITY.format_error_backtrace,
                                              null,
                                              null);
      ROLLBACK;

  END proProcesaGestionAdicional;

  procedure proActuEstaInfoMovil(inuMensajeId    in NUMBER,
                                 isbEstado       in VARCHAR2,
                                 onuErrorCode    out NUMBER,
                                 osbErrorMessage out VARCHAR2) as
    /*
     * Propiedad Intelectual Gases de Occidente SA ESP
     *
     * Script  : LDCI_PKMESAWS.proActuEstaInfoMovil
     * Tiquete : Acta: 20130417 Acta reunion Modificacion-Caja-GRIS.docx
     * Autor   : OLSoftware / Carlos E. Virgen Londono
     * Fecha   : 17/04/2013
     * Descripcion : procedimeinto que actualiza el registro de proceso.
      * Parametros:
      IN :inuMensajeId: Id del mensaje
      IN: isbEstado: ESTADO DE LA SOLICITUD P[PENDIENTE] G[GESTIONADO] GE[GESTIONADO CON ERROR] N[NOTIFICADO] EN [ERROR NOTIFICADO]
      OUT:onuErrorCode: Codigo de error
      OUT:osbErrorMessage: Mensaje de excepcion

     * Historia de Modificaciones
     * Autor              Fecha         Descripcion
     * carlosvl           17/04/2013    Creacion del paquete
    **/
    PRAGMA AUTONOMOUS_TRANSACTION;
    -- excepciones
    EXCEP_UPDATE_CHECK exception; -- menejo de excepciones XML
  begin
    -- inicializa mensaje de salida
    onuErrorCode := 0;

    -- realia la insercion en la tabla LDCI_ESTAPROC
    Update Ldci_Infgestotmov
       Set Estado           = Isbestado,
           Fecha_Notificado = Decode(Isbestado,
                                     'N',
                                     Sysdate,
                                     'EN',
                                     Sysdate,
                                     Fecha_Notificado) --#20150120: jesusv: Se habilita fecha de notificado
     Where Mensaje_Id = Inumensajeid;

    if (SQL%notfound) then
      raise EXCEP_UPDATE_CHECK;
    end if; --if (SQL%notfound)   then

    commit;

  exception
    when EXCEP_UPDATE_CHECK then
      rollback;
      onuErrorCode    := -1;
      osbErrorMessage := '[LDCI_PKGESTINFOADOT.proActuEstaInfoMovil.EXCEP_UPDATE_CHECK]: ' ||
                         chr(13) || 'No se encuentra el mensaje  ' ||
                         inuMensajeId || '.';
      LDCI_pkWebServUtils.Procrearerrorlogint('proActuEstaInfoMovil',
                                              1,
                                              osbErrorMessage,
                                              null,
                                              null);
    when others then
      rollback;
      onuErrorCode    := -1;
      osbErrorMessage := '[LDCI_PKGESTINFOADOT.proActuEstaInfoMovil.others] Error no controlado: ' ||
                         SQLERRM || chr(13) ||
                         DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
  end proActuEstaInfoMovil;

  procedure proGeneraMensajeSOAP(isbSistema      in VARCHAR2,
                                 inuMensajeId    in NUMBER,
                                 inuOrden        in NUMBER,
                                 onuErrorCode    out NUMBER,
                                 osbErrorMessage out VARCHAR2) AS

    /*
     * Propiedad Intelectual Gases de Occidente S.A.   E.S.P
     *
     * Script      : LDCI_PKGESTNOTIORDEN.proGeneraMensajeSOAP
     * Ricef       : I075
     * Autor       : OLSoftware / carlos.virgen <carlos.virgen@olsoftware.com>
     * Fecha       : 15-05-2014
     * Descripcion : Uso de DBMS_XMLGEN
     *
     * Historia de Modificaciones
     * Autor          Fecha      Descripcion
      * carlos.virgen  15-05-2014 Version inicial
    **/

    -- Cursor del Mensaje XML
    orfCursor SYS_REFCURSOR;
    --nuCantOrds         NUMBER := 0;
    --nuCantActs         NUMBER := 0;
    nuMesacodi LDCI_MESAENVWS.MESACODI%TYPE;
    L_Payload  CLOB;
    --sbXmlTransac       VARCHAR2(500);
    --sbESTADO_ENVIO LDCI_ORDENMOVILES.ESTADO_ENVIO%type := 'P';
    qryCtx         DBMS_XMLGEN.ctxHandle;
    sbInputMsgType LDCI_CARASEWE.CASEVALO%type;
    sbSistNotifica LDCI_CARASEWE.CASEDESE%type;

    errorPara01        EXCEPTION; -- Excepcion que verifica que ingresen los parametros de entrada
    Excepnoprocesoregi EXCEPTION; -- Excepcion que valida si proceso registros la consulta
    excepNoProcesoSOAP EXCEPTION; -- Excepcion que valida si proceso peticion SOAP
  begin
    onuErrorCode    := 0;
    osbErrorMessage := null;
    sbSistNotifica  := isbSistema || '_RESINFO';
    -- carga los parametos de la interfaz
    LDCI_PKWEBSERVUTILS.proCaraServWeb(sbSistNotifica,
                                       'INPUT_MESSAGE_TYPE',
                                       sbInputMsgType,
                                       osbErrorMessage);
    if (osbErrorMessage != '0') then
      RAISE errorPara01;
    end if; --if(osbErrorMessage != '0') then

    open orfCursor for
      select MENS.SISTEMA_ID         as "idSistema",
             MENS.OPERACION          as "idOperacion",
             MENS.ORDER_ID           as "idOrden",
             MENS.PROCESO_EXTERNO_ID as "idProcesoExterno",
             cursor (select PARA.PARAMETRO_ID as "idParametro",
                            PARA.VALOR        as "valorParametro"
                       from LDCI_MESAINFGESNOTMOVIL PARA
                      where PARA.MENSAJE_ID = MENS.MENSAJE_ID)                  as "detalleParametros"
        from LDCI_INFGESTOTMOV MENS
       where MENS.MENSAJE_ID = inuMensajeId
      /*and   MENS.ORDER_ID = inuOrden*/
      ;

    -- Genera el mensaje XML
    Qryctx := Dbms_Xmlgen.Newcontext(orfCursor);

    DBMS_XMLGEN.Setrowsettag(Qryctx, sbInputMsgType);
    DBMS_XMLGEN.setRowTag(qryCtx, '');
    Dbms_Xmlgen.setNullHandling(qryCtx, 2);
    dbms_xmlgen.setConvertSpecialChars(qryCtx, false);
    l_payload := dbms_xmlgen.getXML(qryCtx);

    --Valida si proceso registros
    if (DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then
      RAISE excepNoProcesoRegi;
    end if; --if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then

    dbms_xmlgen.closeContext(qryCtx);

    L_Payload := Replace(L_Payload, '<?xml version="1.0"?>');
    L_Payload := Replace(L_Payload,
                         '<detalleParametros_ROW>',
                         '<parametro>');
    L_Payload := Replace(L_Payload,
                         '</detalleParametros_ROW>',
                         '</parametro>');

    L_Payload := Trim(L_Payload);
    --dbms_output.put_line('[proGeneraMensajeSOAP 594 L_Payload ]' ||chr(13) || L_Payload);

    -- Genera el mensaje de envio para la caja gris
    LDCI_PKMESAWS.proCreaMensEnvio(CURRENT_DATE,
                                   sbSistNotifica, -- Sistema configurado en LDCI_CARASEWE
                                   -1,
                                   null,
                                   null,
                                   L_Payload,
                                   0,
                                   0,
                                   nuMesacodi,
                                   onuErrorCode,
                                   osbErrorMessage);

    onuErrorCode := nvl(onuErrorCode, 0);

  exception
    when errorPara01 then
      onuErrorCode    := -1;
      osbErrorMessage := '[LDCI_PKGESTINFOADOT.proGeneraMensajeSOAP.errorPara01]: ' ||
                         osbErrorMessage;
    when excepNoProcesoRegi then
      onuErrorCode    := -1;
      osbErrorMessage := '[LDCI_PKGESTINFOADOT.proGeneraMensajeSOAP.excepNoProcesoRegi]: La consulta no ha arrojo registros.';
    when others then
      osbErrorMessage := -1;
      osbErrorMessage := '[LDCI_PKGESTINFOADOT.proGeneraMensajeSOAP.others]:' ||
                         SQLERRM;
  end proGeneraMensajeSOAP;

  procedure proNotiRespInfoAdic is

    /*
     * Propiedad Intelectual Gases de Occidente S.A.   E.S.P
     *
     * Script      : LDCI_PKGESTNOTIORDEN.proNotiRespInfoAdic
     * Ricef       : I075
     * Autor       : OLSoftware / carlos.virgen <carlos.virgen@olsoftware.com>
     * Fecha       : 15-05-2014
     * Descripcion : Uso de DBMS_XMLGEN
     *
     * Historia de Modificaciones
     * Autor          Fecha      Descripcion
      * carlos.virgen  15-05-2014 Version inicial
    **/

    cursor cuLDCI_INFOGESTIONOTMOVIL is
      select MENSAJE_ID,
             MENS.SISTEMA_ID,
             MENS.OPERACION,
             MENS.ORDER_ID,
             MENS.ESTADO
        from LDCI_INFGESTOTMOV MENS
       where MENS.ESTADO IN ('G', 'GE');

    onuErrorCode    NUMBER := 0;
    osbErrorMessage VARCHAR2(2000);
    --nuMesacodi          LDCI_MESAENVWS.MESACODI%TYPE;
    --L_Payload           CLOB;
    --sbXmlTransac        VARCHAR2(500);
    --sbESTADO_ENVIO      LDCI_ORDENMOVILES.ESTADO_ENVIO%type := 'P';
    --qryCtx              DBMS_XMLGEN.ctxHandle;
    --sbInputMsgType      LDCI_CARASEWE.CASEVALO%type;
    sbEstado_Notif LDCI_INFGESTOTMOV.ESTADO%Type;

    errorPara01        EXCEPTION; -- Excepcion que verifica que ingresen los parametros de entrada
    Excepnoprocesoregi EXCEPTION; -- Excepcion que valida si proceso registros la consulta
    excepNoProcesoSOAP EXCEPTION; -- Excepcion que valida si proceso peticion SOAP

  begin

    for reLDCI_INFOGESTIONOTMOVIL in cuLDCI_INFOGESTIONOTMOVIL loop

      --notifica al sistema externo
      proGeneraMensajeSOAP(isbSistema      => reLDCI_INFOGESTIONOTMOVIL.SISTEMA_ID,
                           inuMensajeId    => reLDCI_INFOGESTIONOTMOVIL.MENSAJE_ID,
                           inuOrden        => reLDCI_INFOGESTIONOTMOVIL.ORDER_ID,
                           onuErrorCode    => onuErrorCode,
                           osbErrorMessage => osbErrorMessage);

      if (onuErrorCode = 0) then

        sbEstado_Notif := Null;
        Select Decode(reLDCI_INFOGESTIONOTMOVIL.ESTADO, 'G', 'N', 'EN')
          Into sbEstado_Notif
          From Dual;
        --- Activado por JJJM
        LDCI_PKGESTINFOADOT.proActuEstaInfoMovil(inuMensajeId    => reLDCI_INFOGESTIONOTMOVIL.MENSAJE_ID,
                                                 isbEstado       => sbEstado_Notif,
                                                 onuErrorCode    => onuErrorCode,
                                                 osbErrorMessage => osbErrorMessage);

      else

        LDCI_pkWebServUtils.Procrearerrorlogint('proNotiRespInfoAdic',
                                                1,
                                                osbErrorMessage,
                                                null,
                                                null);

      end if; --if (onuErrorCode = 0) then

    end loop; --for reLDCI_INFOGESTIONOTMOVIL in cuLDCI_INFOGESTIONOTMOVIL loop

  exception
    when errorPara01 then
      onuErrorCode    := -1;
      osbErrorMessage := '[LDCI_PKGESTINFOADOT.proNotiRespInfoAdic.errorPara01]: ' ||
                         osbErrorMessage;
    when excepNoProcesoRegi then
      onuErrorCode    := -1;
      osbErrorMessage := '[LDCI_PKGESTINFOADOT.proNotiRespInfoAdic.excepNoProcesoRegi]: La consulta no ha arrojo registros.';
    when others then
      osbErrorMessage := -1;
      osbErrorMessage := '[LDCI_PKGESTINFOADOT.proNotiRespInfoAdic.others]:' ||
                         SQLERRM;
  end proNotiRespInfoAdic;
  PROCEDURE proProcesaXMLVentaServicios(isbSistema      in VARCHAR2,
                                        inuOrden        in NUMBER,
                                        isbXML          in CLOB,
                                        osbXMLRespuesta out LDCI_PKREPODATAtype.tytabRespuesta,
                                        onuErrorCodi    out NUMBER,
                                        osbErrorMsg     out VARCHAR2) AS

    /*
    * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
    *
    * Proceso     : proProcesaXMLVentaServicios
    * Tiquete     :
    *  Fecha       : 15-10-2015
    * Descripcion : Registra la ventas por sistema externo.
    *
    * Historia de Modificaciones
    * Autor                    Fecha       Descripcion
    *
    *
    *
    **/
    --Estructura de respuesta
    tabRespuesta   LDCI_PkRepoDataType.tyTabRespuesta;
    tyRegRespuesta LDCI_PkRepoDataType.tyWSRespTrabAdicRecord;

    /*cursor para leer el xml*/
    cursor cuxmlsercv(isbXMLserv In Varchar2) is
      Select Datosprom.*
        From XMLTable('/solicitudVentaServicios' Passing
                      XMLType(isbXMLserv) COLUMNS contrato NUMBER(15) Path
                      'idContrato',
                      RECEPTION_TYPE_ID NUMBER(15) Path 'idMedioRecepcion',
                      PRODUCT NUMBER(15) Path 'idProducto',
                      PERSONA NUMBER(15) Path 'idPersona',
                      PUNTO_ATENCION NUMBER(15) Path 'idPuntoAtencion',
                      POS_OPER_UNIT_ID NUMBER(15) Path 'idUnidadOperativa',
                      FECHA_DE_SOLICITUD VARCHAR2(50) Path 'fechaSolicitud',
                      COMMENT_ VARCHAR2(200) Path 'observacion',
                      CONTACT_ID NUMBER(15) Path 'idContacto',
                      ADDRESS_ID NUMBER(15) Path 'idDireccion',
                      DIR_COBR NUMBER(15) Path 'idDireccionTrabajo',
                      ACTIVIDAD NUMBER(15) Path 'idActividad',
                      idSolicitud NUMBER(15) Path 'idSolicitud') As Datosprom;

    rgInfoserv cuxmlsercv%RowType;

    --    rgInfoservact cuxmlsercvact%RowType;

    onuorden    number;
    onupackages number;
    onumotive   number;
    --onuerrorcode    number;
    --osberrormessage varchar2(2000);

  BEGIN

    --identifica valores del XML

    Open cuxmlsercv(isbXML);
    Fetch cuxmlsercv
      Into rgInfoserv;
    Close cuxmlsercv;

    --registra la solicitud
    LDCI_PKOSSSOLICITUD.proSolicitudVSI(rgInfoserv.Contrato,
                                        rgInfoserv.Reception_Type_Id,
                                        rgInfoserv.Product,
                                        rgInfoserv.PERSONA,
                                        rgInfoserv.Punto_atencion,
                                        rgInfoserv.Pos_Oper_Unit_Id,
                                        rgInfoserv.Fecha_De_Solicitud,
                                        rgInfoserv.Comment_,
                                        rgInfoserv.Contact_Id,
                                        rgInfoserv.Address_Id,
                                        rgInfoserv.DIR_COBR,
                                        rgInfoserv.Actividad,
                                        rgInfoserv.idSolicitud,
                                        onumotive,
                                        onupackages,
                                        onuorden,
                                        onuErrorCodi,
                                        osbErrorMsg);

    -- Genera la Respuesta
    tyRegRespuesta.Parametro := 'idSistema';
    tyRegRespuesta.Valor := isbSistema;
    tabRespuesta(1) := tyRegRespuesta;

    tyRegRespuesta.Parametro := 'idSolicitud';
    tyRegRespuesta.Valor := onupackages;
    tabRespuesta(2) := tyRegRespuesta;

    tyRegRespuesta.Parametro := 'idMotivo';
    tyRegRespuesta.Valor := onumotive;
    tabRespuesta(3) := tyRegRespuesta;

    tyRegRespuesta.Parametro := 'idOrden';
    tyRegRespuesta.Valor := onuorden;
    tabRespuesta(4) := tyRegRespuesta;

    tyRegRespuesta.Parametro := 'codigoError';
    tyRegRespuesta.Valor := onuErrorCodi;
    tabRespuesta(5) := tyRegRespuesta;

    tyRegRespuesta.Parametro := 'mensajeError';
    tyRegRespuesta.Valor := osbErrorMsg;
    tabRespuesta(6) := tyRegRespuesta;

    -- Se asigna la respuesta a la salida
    osbXMLRespuesta := tabRespuesta;

    -- Manejo de excepciones

  Exception
    When Others Then

      onuErrorCodi := -1;
      osbErrorMsg  := '[LDCI_PKGESTINFOADOT.proProcesaXMLVentaServicios.Others]: ' ||
                      SqlErrM;

      -- Genera la Respuesta
      tyRegRespuesta.Parametro := 'idSistema';
      tyRegRespuesta.Valor := isbSistema;
      tabRespuesta(1) := tyRegRespuesta;

      tyRegRespuesta.Parametro := 'idSolicitud';
      tyRegRespuesta.Valor := -1;
      tabRespuesta(2) := tyRegRespuesta;

      tyRegRespuesta.Parametro := 'idMotivo';
      tyRegRespuesta.Valor := -1;
      tabRespuesta(3) := tyRegRespuesta;

      tyRegRespuesta.Parametro := 'idOrden';
      tyRegRespuesta.Valor := -1;
      tabRespuesta(4) := tyRegRespuesta;

      tyRegRespuesta.Parametro := 'codigoError';
      tyRegRespuesta.Valor := onuErrorCodi;
      tabRespuesta(5) := tyRegRespuesta;

      tyRegRespuesta.Parametro := 'mensajeError';
      tyRegRespuesta.Valor := osbErrorMsg;
      tabRespuesta(6) := tyRegRespuesta;

      -- Se asigna la respuesta a la salida
      osbXMLRespuesta := tabRespuesta;

  End proProcesaXMLVentaServicios;

End LDCI_PKGESTINFOADOT;
/

GRANT EXECUTE ON LDCI_PKGESTINFOADOT TO SYSTEM_OBJ_PRIVS_ROLE;
/

