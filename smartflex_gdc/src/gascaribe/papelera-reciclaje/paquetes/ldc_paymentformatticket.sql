CREATE OR REPLACE PACKAGE "LDC_PAYMENTFORMATTICKET" is

/*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : Ldc_PaymentFormatTicket
    Descripcion    : Paquete que permitir obtener los datos necesarios
                     para el formato de pago en caja.
    Autor          : Emiro Leyva
    Fecha          : 27/02/2015

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/

  -- Obtiene la Version actual del Paquete
    FUNCTION FSBVERSION RETURN VARCHAR2;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : PaymentsHeaderFormat
  Descripcion    : procedimiento para extraer el encabezado
                   a utilizar por el formato de pago en CAJA.
  Autor          :
  Fecha          : 27/02/2015

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos del Encabezado del
                       formato de CAJA.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  Procedure RfPaymentsHeaderFormat(orfcursor Out constants.tyRefCursor);

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : RfPaymentFormat
  Descripcion    : procedimiento para extraer los datos relacionados
                   con el cuerpo del formato de CAJA.
  Autor          :
  Fecha          : 27/02/2015

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos del Cuerpo del
                       formato de CAJA.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  Procedure RfPaymentFormat(orfcursor Out constants.tyRefCursor);

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : RfCouponPayment
  Descripcion    : procedimiento para extraer los datos relacionados
                   con el o los cupones pagados del formato de CAJA.
  Autor          :
  Fecha          : 27/02/2015

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos del Cuerpo del
                       formato de CAJA.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  Procedure RfCouponPayment(orfcursor Out constants.tyRefCursor);

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : RfFootPayment
  Descripcion    : procedimiento para extraer los datos relacionados
                   con el PIN y conciliaion del formato de CAJA.
  Autor          :
  Fecha          : 27/02/2015

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos del Cuerpo del
                       formato de CAJA.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  Procedure RfFootPayment(orfcursor Out constants.tyRefCursor);

end Ldc_PaymentFormatTicket;
/
CREATE OR REPLACE PACKAGE BODY LDC_PAYMENTFORMATTICKET IS

    CSBVERSION                CONSTANT        varchar2(40)  := 'Team_2780_1';

  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : Ldc_PaymentFormatTicket
    Descripcion    : Paquete que permitir obtener los datos necesarios
                     para el formato de pago en caja.
    Autor          : Emiro Leyva
    Fecha          : 27/02/2015

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/

  /*
      Funcion que devuelve la version del pkg*/
    FUNCTION FSBVERSION RETURN VARCHAR2 IS
    BEGIN
      return CSBVERSION;
    END FSBVERSION;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : PaymentsHeaderFormat
  Descripcion    : procedimiento para extraer el encabezado
                   a utilizar por el formato de pago en CAJA.
  Autor          :
  Fecha          : 27/02/2015

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos del Encabezado del
                       formato de CAJA.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  Procedure RfPaymentsHeaderFormat(orfcursor Out constants.tyRefCursor) IS

  begin

    ut_trace.trace('Inicio Ldc_PaymentFormatTicket.RfPaymentsHeaderFormat', 10);

    open orfcursor for
      select sistempr LDC,
             'Nit :'||sistnitc NIT
        from sistema;

    ut_trace.trace('Fin Ldc_PaymentFormatTicket.RfPaymentsHeaderFormat', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;

  END RfPaymentsHeaderFormat;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : RfPaymentFormat
  Descripcion    : procedimiento para extraer los datos relacionados
                   con el cuerpo del formato de CAJA.
  Autor          :
  Fecha          : 27/02/2015

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos del Cuerpo del
                       formato de CAJA.

  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/
  Procedure RfPaymentFormat(orfcursor Out constants.tyRefCursor) IS

    sbDOCUCODI ge_boInstanceControl.stysbValue;

  BEGIN

    ut_trace.trace('Inicio Ldc_PaymentFormatTicket.RfPaymentFormat', 10);

    --sbDOCUCODI := ge_boInstanceControl.fsbGetFieldValue('CA_DOCUMENT',
    --                                                    'DOCUCODI');

    sbDOCUCODI := Pkboca_Print.fnuGetDocumentBox;
    ut_trace.trace('*************************** RfPaymentFormat sbDOCUCODI: '||sbDOCUCODI, 2);

    --sbDOCUCODI := Pkboca_Print.Fsbgetboxname

    open orfcursor for
      select 'Trans.: '||to_char(cd.docucodi)||'    Fec: '||cd.Docufeap Transaccion,
             'Cajero: '||dasa_user.fsbgetmask(CC.CAJEUSER, NULL)
             --||'    '||
             --'FP.: '||to_char(cm.movifopa)
              CodigoCagero,
           --   cd.Docufeap FechaPago,
             'Contrato: '||to_char(cdd.dedosusc)||'-'||subscriber_name||' '||subs_last_name Suscriptor
           --  'Forma Pago  :'||to_char(cm.movifopa) MedioPago
         from ca_document cd, ca_detadocu cdd, CA_CAJERO CC, ge_subscriber, suscripc
       where cd.docucodi = sbDOCUCODI
         and cd.docucodi = cdd.dedodocu
         AND CD.DOCUCAJE = CC.CAJECODI
         and subscriber_id=suscclie
         and susccodi = cdd.dedosusc;

    ut_trace.trace('Fin Ldc_PaymentFormatTicket.RfPaymentFormat', 10);

  EXCEPTION
    when others then
      PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);

  END RfPaymentFormat;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : RfCouponPayment
  Descripcion    : procedimiento para extraer los datos relacionados
                   con el o los cupones pagados del formato de CAJA.
  Autor          :
  Fecha          : 27/02/2015

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos del Cuerpo del
                       formato de CAJA.

  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/
  Procedure RfCouponPayment(orfcursor Out constants.tyRefCursor) IS

    sbDOCUCODI ge_boInstanceControl.stysbValue;

  BEGIN

    /*
    ut_trace.init;
    ut_trace.setlevel(99);
    ut_trace.setoutput(ut_trace.fntrace_output_db);
    */

    ut_trace.trace('Inicio Ldc_PaymentFormatTicket.RfCouponPayment', 10);

    --sbDOCUCODI := ge_boInstanceControl.fsbGetFieldValue('CA_DOCUMENT',
    --                                                    'DOCUCODI');

    sbDOCUCODI := Pkboca_Print.fnuGetDocumentBox;
    ut_trace.trace('********************************************* RfCouponPayment sbDOCUCODI: '||sbDOCUCODI, 2);

    ut_trace.trace('********************************************* [CUPON AGRUPADOR]', 2);

    open orfcursor for
        select  'Cupon :'||to_char(cuponume)||'   '||
                'Valor :'||'$  '||to_char(movivalo,'FM999,999,999')||'  '||
                'FP.: '||to_char(cm.movifopa) VALORDETALLE
        from  ca_detadocu, cupon, ca_movimien cm
        where dedodocu = sbDOCUCODI
        and  dedodocu = cm.movidocu
        and  dedosopo = cuponume;
        --group by dedodocu;

    ut_trace.trace('Fin Ldc_PaymentFormatTicket.RfCouponPayment', 10);

  EXCEPTION
    when others then
      PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);

  END RfCouponPayment;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : RfFootPayment
  Descripcion    : procedimiento para extraer los datos relacionados
                   con el PIN y conciliaion del formato de CAJA.
  Autor          :
  Fecha          : 27/02/2015

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos del Cuerpo del
                       formato de CAJA.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  Procedure RfFootPayment(orfcursor Out constants.tyRefCursor) IS

    sbDOCUCODI ge_boInstanceControl.stysbValue;

  BEGIN

    ut_trace.trace('Inicio Ldc_PaymentFormatTicket.RfFootPayment', 10);

    --sbDOCUCODI := ge_boInstanceControl.fsbGetFieldValue('CA_DOCUMENT',
    --                                                    'DOCUCODI');

    sbDOCUCODI := Pkboca_Print.fnuGetDocumentBox;

    open orfcursor for
      select 'Pin:  '||to_char(cd.docucodi)||'    '||'Conc.:  '||to_char(Pagoconc) PINCONCILIA
        from ca_document cd, ca_detadocu cdd, pagos p
       where cd.docucodi = sbDOCUCODI
         and cd.docucodi = cdd.dedodocu
         and cdd.dedosopo = p.pagocupo;
       --group by Pagonutr, Pagoconc;

    ut_trace.trace('Fin Ldc_PaymentFormatTicket.RfFootPayment', 10);

  EXCEPTION
    when others then
      PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);

  END RfFootPayment;

BEGIN
  null;
  --cnuGasService := Dald_parameter.fnuGetNumeric_Value('COD_TIPO_SERV');
END Ldc_PaymentFormatTicket;
/
GRANT EXECUTE on LDC_PAYMENTFORMATTICKET to SYSTEM_OBJ_PRIVS_ROLE;
/
