CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKINFOADICIONALCART AS
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

  **/

  FUNCTION fnuDescuentoMaxRefinan(inuProductId In Servsusc.Sesunuse%Type,
                                  inuPlanId    In Number) Return Number;

  PROCEDURE proProcesaXMLRefinancia(MENSAJE_ID            In Number,
                                    isbSistema            in VARCHAR2,  --
                                    inuOrden              in NUMBER,    --
                                    isbXML                in CLOB,      --
                                    isbEstado             in Varchar2,
                                    isbOperacion          in Varchar2,
                                    inuProcesoExt         in number,
                                    idtFechaRece          in date,
                                    idtFechaProc          in date,
                                    idtFechaNoti          in date,
                                    inuCodErrOsf          in number,
                                    isbMsgErrOsf          in Varchar2,
                                    ocurRespuesta         Out SYS_REFCURSOR,
                                    onuErrorCodi          out NUMBER,
                                    osbErrorMsg           out VARCHAR2);



END LDCI_PKINFOADICIONALCART;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKINFOADICIONALCART AS

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
    *
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



  PROCEDURE proProcesaXMLRefinancia(MENSAJE_ID            In Number,
                                    isbSistema            in VARCHAR2,  --
                                    inuOrden              in NUMBER,    --
                                    isbXML                in CLOB,      --
                                    isbEstado             in Varchar2,
                                    isbOperacion          in Varchar2,
                                    inuProcesoExt         in number,
                                    idtFechaRece          in date,
                                    idtFechaProc          in date,
                                    idtFechaNoti          in date,
                                    inuCodErrOsf          in number,
                                    isbMsgErrOsf          in Varchar2,
                                    ocurRespuesta         Out SYS_REFCURSOR,
                                    onuErrorCodi          out NUMBER,
                                    osbErrorMsg           out VARCHAR2) AS

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
    **/

    --Datos de Salida
    nuSolicitud mo_packages.package_id%type;
    nuCupon     cupon.cuponume%type;
    nuValor     NUMBER(13, 2) := 0;

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

      --llamado al API de refinanciacion
      OS_RegisterDebtFinancing(Inusubscriptionid => rgXML.Inusubscriptionid,
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

    End If;

    -- Genera la Respuesta
    /*tyRegRespuesta.PARAMETRO := 'idSistema';
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
    tabRespuesta(7) := tyRegRespuesta;*/

    open ocurRespuesta for
      select 'idSistema' parametro, isbSistema valor from dual union
      select 'idSolicitud' parametro, to_char(nuSolicitud) valor from dual union
      select 'numeroCupon' parametro, to_char(nuCupon) valor from dual union
      select 'valorCupon' parametro, to_char(nuValor) valor from dual union
      select 'idOrden' parametro, to_char(inuOrden) valor from dual union
      select 'codigoError' parametro, to_char(onuErrorCodi) valor from dual union
      select 'mensajeError' parametro, osbErrorMsg valor from dual;

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

   -- osbXMLRespuesta := tabRespuesta;

  EXCEPTION
    WHEN OTHERS THEN
      onuErrorCodi := -1;
      osbErrorMsg  := '[LDCI_PKINFOADICIONALCART.proProcesaXMLRefinancia.others]: ' ||
                      SQLERRM;

  END proProcesaXMLRefinancia;

  /**/
  --JVIVERO


End LDCI_PKINFOADICIONALCART;
/

PROMPT Otorgando permisos de ejecucion a LDCI_PKINFOADICIONALCART
BEGIN
  pkg_utilidades.prAplicarPermisos('LDCI_PKINFOADICIONALCART','ADM_PERSON');
END;
/
