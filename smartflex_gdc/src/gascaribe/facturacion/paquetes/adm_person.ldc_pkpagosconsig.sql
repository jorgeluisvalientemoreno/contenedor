CREATE OR REPLACE PACKAGE adm_person.ldc_pkpagosconsig
/**********************************************************************************
    Propiedad intelectual de CSC. (C).

    Package     : LDC_PkPagosConsig
    Descripci?n : Paquete con la logica de aplicacion de pagos por consignacion masivo
                  sin tener encuenta el Grupo de Recaudo(LDCFPAN).

    Autor     : Carlos Humberto Gonzalez V
    Fecha     : 08-08-2017

    Historia de Modificaciones
    DD-MM-YYYY    <Autor>               Modificacion
    -----------  -------------------    -------------------------------------
    26/06/2024    PAcosta               OSF-2878: Cambio de esquema ADM_PERSON  
    08-08-2017    cgonzalezv            Creacion.
**********************************************************************************/
 IS
  -- Public type declarations
  -- type <TypeName> is <Datatype>;

  -- Public constant declarations
  --<ConstantName> constant <Datatype> := <Value>;

  -- Public variable declarations
  --<VariableName> <Datatype>;

  -- Public function and procedure declarations
  /**********************************************************************************
    Propiedad intelectual de CSC. (C).

    Unidad      : proApplyPayment
    Descripci?n : procedimiento encargado de la aplicacion de los pagos que fueron cargados
                  por la forma LDCARGPAG tabla LDC_LOTEPAGOPRODUCT.

    Autor     : Carlos Humberto Gonzalez
    Fecha     : 08-08-2017

    Historia de Modificaciones
    DD-MM-YYYY    <Autor>               Modificacion
    -----------  -------------------    -------------------------------------
    08-08-2017    cgonzalezv            Creacion.
  **********************************************************************************/
  --<<
  -- Variables Globales
  -->>
  /**************************************************************************
  Propiedad intelectual de CSC. (C).
  Funcion     :  fnufgetTotalPago
  Descripcion :  Obtiene el total a pagar de los productos cargadado por excel
                 para realizar el recaudo por consignacion
  Autor       : Carlos Humberto Gonzalez V
  Fecha       : 16-08-2017

  Historia de Modificaciones
    Fecha               Autor                Modificaci?n
  =========           =========          ====================
  16-08-2017          cgonzalezv              Creaci?n.
  **************************************************************************/
  FUNCTION fnufgetTotalPago
    RETURN VARCHAR2;


  /**************************************************************************
  Propiedad intelectual de CSC. (C).
  Funcion     :  fnufgetVlrCartera
  Descripcion :  Obtiene los productos cargadado por excel para realizar el
                 recaudo por consignacion
  Autor       : Carlos Humberto Gonzalez V
  Fecha       : 15-08-2017

  Historia de Modificaciones
    Fecha               Autor                Modificaci?n
  =========           =========          ====================
  15-08-2017          cgonzalezv              Creaci?n.
  **************************************************************************/
  FUNCTION fnufgetvlrcartera(inususcodi IN suscripc.susccodi%TYPE)
    RETURN NUMBER;

  /**************************************************************************
  Propiedad intelectual de CSC. (C).
  Funcion     :  frfgetProduPagosConsig
  Descripcion :  Obtiene los productos cargadado por excel para realizar el
                 recaudo por consignacion
  Autor       : Carlos Humberto Gonzalez V
  Fecha       : 15-08-2017

  Historia de Modificaciones
    Fecha               Autor                Modificaci?n
  =========           =========          ====================
  15-08-2017          cgonzalezv              Creaci?n.
  **************************************************************************/
  FUNCTION frfgetprodupagosconsig RETURN constants.tyrefcursor;

  ------------------------------------------------------------------------------
  PROCEDURE proapplypayment(inuproductoid IN servsusc.sesunuse%TYPE,
                            inuregistro   IN NUMBER,
                            inutotal      IN NUMBER,
                            onuerrorcode  OUT NUMBER,
                            osberrormess  OUT VARCHAR2);

END ldc_pkpagosconsig;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_PkPagosConsig
/**********************************************************************************
    Propiedad intelectual de CSC. (C).

    Package     : LDC_PkPagosConsig
    Descripci?n : Paquete con la logica de aplicacion de pagos por consignacion masivo
                  sin tener encuenta el Grupo de Recaudo(LDCFPAN).

    Autor     : Carlos Humberto Gonzalez V
    Fecha     : 08-08-2017

    Historia de Modificaciones
    DD-MM-YYYY    <Autor>               Modificacion
    -----------  -------------------    -------------------------------------
    08-08-2017    cgonzalezv            Creacion.
**********************************************************************************/
 IS


  -- Private type declarations
   TYPE rcPagos IS RECORD
  (
    nuBanco      pagos.pagobanc%type,
    nuSucursal   pagos.pagosuba%type,
    nuConcilia   pagos.pagoconc%type,
    nuCuponPago  pagos.pagocupo%type,
    nuVlrPago    pagos.pagovapa%type,
    sbClasdopa   detapago.depacldp%type,
    sbEntidopa   detapago.depaenti%type,
    sbDepadocu   detapago.depadocu%type,
    sbFormpago   pagos.pagotdco%type,
    dtFechapago  pagos.pagofepa%type,
    sbDepanucu   detapago.depanucu%type,
    sbPagonutr   pagos.pagonutr%type,
    sbDepanuau   detapago.depanuau%type,
    nuDepanume   detapago.depanume%TYPE,
    nuProducto   servsusc.sesunuse%TYPE

  );
  -- Se crea el tipo de datos de la tabla registo para procesar el pago
  TYPE TyrcPagos IS TABLE OF rcPagos INDEX BY BINARY_INTEGER ;
  tytblrcPagos TyrcPagos;

  nuCantReg      NUMBER:=0;                -- Variable para la cantidad de registros
  inuConcilia    pagos.pagoconc%TYPE;      -- Consecutivo de conciliacion
  inuTotalvalue  cargos.cargvalo%TYPE :=0; -- Total a pagar


  -- Private constant declarations
     --<ConstantName> constant <Datatype> := <Value>;

  -- Private variable declarations
     --<VariableName> <Datatype>;

  -- Function and procedure implementations
  FUNCTION fnufgetTotalPago
    RETURN VARCHAR2
  /**************************************************************************
  Propiedad intelectual de CSC. (C).
  Funcion     :  fnufgetTotalPago
  Descripcion :  Obtiene el total a pagar de los productos cargadado por excel
                 para realizar el recaudo por consignacion
  Autor       : Carlos Humberto Gonzalez V
  Fecha       : 16-08-2017

  Historia de Modificaciones
    Fecha               Autor                Modificaci?n
  =========           =========          ====================
  16-08-2017          cgonzalezv              Creaci?n.
  **************************************************************************/
    IS
    -- Variables
    nuTotalVlrPago VARCHAR2(50); -- valor total a pagar

    CURSOR cuTotalPago
        IS
    SELECT to_char(SUM(Nvl(vlr_pago,0)), 'fm999,999,999') "Total a Pagar"
      FROM open.ge_subscriber       gs,
           open.suscripc            su,
           open.servsusc            sv,
           open.ldc_lotepagoproduct lo
     WHERE gs.subscriber_id = su.suscclie
       AND su.susccodi      = sv.sesususc
       AND sv.sesunuse      = lo.id_producto
       AND lo.flag_proces   = 'N';

    -- obtiene valor de la cartera
    BEGIN

      OPEN cuTotalPago;
     FETCH cuTotalPago INTO nuTotalVlrPago;
     CLOSE cuTotalPago;

    -- Retorna vlr cartera
    RETURN nuTotalVlrPago;

    EXCEPTION
         --   raise ex.CONTROLLED_ERROR;

        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;


    END fnufgetTotalPago;


  FUNCTION fnufgetVlrCartera (inuSuscodi IN suscripc.susccodi%TYPE)
      RETURN NUMBER
    /**************************************************************************
    Propiedad intelectual de CSC. (C).
    Funcion     :  fnufgetVlrCartera
    Descripcion :  Obtiene los productos cargadado por excel para realizar el
                   recaudo por consignacion
    Autor       :  Carlos Humberto Gonzalez V
    Fecha       :  15-08-2017

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    15-08-2017          cgonzalezv              Creacion.
    **************************************************************************/
    IS
    -- Variables
    nuVlrCartera cargos.cargvalo%TYPE; -- valor de la cartera

    -- Obtiene la cartera de los suscriptores
    CURSOR cuCartera(inuSusc IN suscripc.susccodi%TYPE)
        IS
    SELECT nvl(Sum(cucosacu),0) cartera
      FROM open.cuencobr,open.servsusc
     WHERE sesunuse = cuconuse
       AND cucosacu > 0
       AND sesususc = inuSusc;

    -- obtiene valor de la cartera
    BEGIN
      OPEN cuCartera(inuSuscodi);
     FETCH cuCartera INTO nuVlrCartera;
     CLOSE cuCartera;

    -- Retorna vlr cartera
    RETURN nuVlrCartera;

    EXCEPTION
         --   raise ex.CONTROLLED_ERROR;

        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;


    END fnufgetVlrCartera;

  FUNCTION frfgetProduPagosConsig
    RETURN constants.tyRefCursor
    /**************************************************************************
    Propiedad intelectual de CSC. (C).
    Funcion     :  frfgetProduPagosConsig
    Descripcion :  Obtiene los productos cargadado por excel para realizar el
                   recaudo por consignacion
    Autor       : Carlos Humberto Gonzalez V
    Fecha       : 15-08-2017

    Historia de Modificaciones
      Fecha               Autor                Modificaci?n
    =========           =========          ====================
    15-08-2017          cgonzalezv              Creaci?n.
    **************************************************************************/
    IS

        ocuCursor       constants.tyRefCursor;
        sbSql           varchar2(32000);
        sbDate          VARCHAR2(100) := null;
        sbSubcate       VARCHAR2(32000);
        sbCicloCons     VARCHAR2(50) := null;

        sbPoblacion       ge_boInstanceControl.stysbValue;
        sbFechaInicio     ge_boInstanceControl.stysbValue;
        sbFechaFin        ge_boInstanceControl.stysbValue;
        sbEstrato         ge_boInstanceControl.stysbValue;
        --sbCiclo           ge_boInstanceControl.stysbValue;
    BEGIN

        -- Obtiene los productos para procesar el recaudo
    sbSql :=  ' SELECT sesunuse producto,
                subscriber_name || '' '' || subs_last_name suscripcion,
                to_char(open.ldc_pkpagosconsig.fnufgetvlrcartera(sv.sesususc),
                        ''FM999,999,999'') "VALOR DEUDA",
                to_char(SUM(vlr_pago), ''FM999,999,999'') "VALOR DEL PAGO"
           FROM open.ge_subscriber       gs,
                open.suscripc            su,
                open.servsusc            sv,
                open.ldc_lotepagoproduct lo
          WHERE gs.subscriber_id = su.suscclie
            AND su.susccodi = sv.sesususc
            AND sv.sesunuse = lo.id_producto
            AND lo.flag_proces = ''N''
          GROUP BY sesunuse, subscriber_name, subs_last_name, sv.sesususc';



    open ocuCursor for sbSql;

    RETURN ocuCursor;

    EXCEPTION
         --   raise ex.CONTROLLED_ERROR;

        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END frfgetProduPagosConsig;


  PROCEDURE proCambEstaProcesa (inuProducto IN servsusc.sesunuse%TYPE)
  /**********************************************************************************
   Propiedad intelectual de CSC. (C).

   Unidad      : proCambEstaProcesa
   Descripci?n : procedimiento encargado de actualizar el estado a procesafo en la
                 tabla LDC_LOTEPAGOPRODUCT.

   Autor     : Carlos Humberto Gonzalez
   Fecha     : 10-08-2017

   Historia de Modificaciones
   DD-MM-YYYY    <Autor>               Modificacion
   -----------  -------------------    -------------------------------------
   10-08-2017    cgonzalezv            Creacion.
  **********************************************************************************/
  IS
  BEGIN

  UPDATE open.ldc_lotepagoproduct SET flag_proces = 'S'
    WHERE id_producto  = inuProducto
      AND flag_proces  = 'N';

  END proCambEstaProcesa;


  ---------------------------------------------------------------------------
  PROCEDURE proApplyPayment (inuProductoId         IN  servsusc.sesunuse%type,
                             inuRegistro           IN  number,
                             inuTotal              IN  number,
                             onuErrorCode          OUT number,
                             osbErrorMess          OUT varchar2)
  /**********************************************************************************
   Propiedad intelectual de CSC. (C).

   Unidad      : proApplyPayment
   Descripci?n : procedimiento encargado de la aplicacion de los pagos que fueron cargados
                  por la forma LDCARGPAG tabla LDC_LOTEPAGOPRODUCT.

   Autor     : Carlos Humberto Gonzalez
   Fecha     : 08-08-2017

   Historia de Modificaciones
   DD-MM-YYYY    <Autor>               Modificacion
   -----------  -------------------    -------------------------------------
   08-08-2017    cgonzalezv            Creacion.
  **********************************************************************************/
  IS



  -- Variables para la creacion de la conciliacion bancaria
  inuCouponsnumber  concilia.concnucu%TYPE  ; -- Cantidad de cupones a procesar
  onuConsConcilia   concilia.conccons%TYPE  ; -- Consecutivo de la conciliacion

  -- Variables para la creacion del cupon

  -- Variables para procesar el pago
  inuBanco      pagos.pagobanc%type     ; -- Codigo entidad de recaudo
  inuSucursal   pagos.pagosuba%type     ; -- Codigo subcursal de recaudo
  inuCuponPago  pagos.pagocupo%type     ; -- Numero de cupon
  inuVlrPago    pagos.pagovapa%type     ; -- Valor del cupon
  isbClasdopa   detapago.depacldp%type  ; -- Clase de documento de pago
  isbEntidopa   detapago.depaenti%type  ; -- Entidad que expide el documento de pago
  isbDepadocu   detapago.depadocu%type  ; -- Numero documento de pago
  isbFormpago   pagos.pagotdco%type     ; -- Tipo de direccion de cobro
  idtFechapago  pagos.pagofepa%type     ; -- Fecha de pago
  isbDepanucu   detapago.depanucu%type  ; -- Numero de cuenta
  isbPagonutr   pagos.pagonutr%type     ; -- Numero de transaccion
  isbDepanuau   detapago.depanuau%type  ; -- Numero de autorizacion
  inuDepanume   detapago.depanume%type  ; -- Numero de meses

  nuProduc      servsusc.sesunuse%TYPE  ; -- Codigo del servicio suscrito
  nuValor       pagos.pagovapa%TYPE     ; -- Valor a pagar por producto
  Onucupon      pagos.pagocupo%type     ; -- Numero de cupon

  --
  cnuNULL_ATTRIBUTE     constant number := 2126;

  --<<
  -- cursor Obtiene los productos con los valores a pagar
  -->>
  CURSOR cuPagosProd (inId_Producto IN servsusc.sesunuse%type)
      IS
  SELECT id_producto,
         SUM(vlr_pago)vlr_pago
    FROM open.ldc_lotepagoproduct pr
   WHERE pr.id_producto = inId_Producto
     AND pr.flag_proces ='N'
   GROUP BY  id_contrato,
             id_producto,
             flag_proces;


   --<<
   -- Se declara la tabla PL de tipo registro para tener toda la informacio
   -- para el recaudo
   -->>

   BEGIN

   UT_TRACE.TRACE('INICIA LDC_PkPagosConsig.proApplyPayment',10);


   -- Seteo de variables
   --<<
   -- Setea la informacion de la forma
   -->>
   inuBanco         :=  ge_boInstanceControl.fsbGetFieldValue ('RC_TRBAANUL', 'TBANBARE'); -- Entidad Financiera                    1;           --
   inuSucursal      :=  ge_boInstanceControl.fsbGetFieldValue ('CUENBANC', 'CUBABANC');    -- Punto de pago                         56;          --
   idtFechapago     :=  ge_boInstanceControl.fsbGetFieldValue ('RC_TRBAANUL', 'TBANFERE'); -- Fecha de pago                        (SYSDATE-1);  --
   isbFormpago      :=  ge_boInstanceControl.fsbGetFieldValue ('FORMPAGO', 'FOPACODI');    -- forma de pago                        'CH';         --
   isbEntidopa      :=  ge_boInstanceControl.fsbGetFieldValue ('BANCO', 'BANCCODI');       -- Fecha de pago  Entidad que Expide     1;           --
   isbPagonutr      :=  ge_boInstanceControl.fsbGetFieldValue ('TRANBANC', 'TRBANUTR');    -- Numero de transaccion                 1233;        --
   isbClasdopa      :=  ge_boInstanceControl.fsbGetFieldValue ('CLASDOPA', 'CLDPCODI');    -- Clase de documento de pago            8;           --
   isbDepadocu      :=  ge_boInstanceControl.fsbGetFieldValue ('FORMPAGO', 'FOPADESC');    -- Numero de documento                   12;          --
   isbDepanucu      :=  ge_boInstanceControl.fsbGetFieldValue ('CUENBANC', 'CUBANUCB');    -- Numero de cuenta                      '1234';      --


    -- Validaciones forma de pago cheque
    IF (trim(isbFormpago) = 'CH') then

        -- valida Entidad Expide
        if (isbEntidopa is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Entidad Expide');
            raise ex.CONTROLLED_ERROR;
        end if;

        -- Valida Numero documento
        if (isbDepadocu is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Numero documento');
            raise ex.CONTROLLED_ERROR;
        end if;

        -- valida Clase de documento
        if (isbClasdopa is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Clase de documento');
            raise ex.CONTROLLED_ERROR;
        end if;

        -- valida Numero de cuenta
        if (isbDepanucu is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Numero de cuenta');
            raise ex.CONTROLLED_ERROR;
        end if;

    END IF;



   -- Obtiene los datos del producto que hacen referencia al pago
    OPEN cuPagosProd(inuProductoId);
   FETCH cuPagosProd INTO nuProduc,inuVlrPago;
      IF cuPagosProd%NOTFOUND THEN
         inuVlrPago   := 0;
         nuProduc     := inuProductoId;
     END IF;
   CLOSE cuPagosProd;

   nuCantReg := nuCantReg + 1;

   -- Total a pagar por los productos seleccionados
   inuTotalvalue := inuTotalvalue + inuVlrPago;
    --<<
    -- Armar la tabla de proceso de pagos
    -->>
    IF inuRegistro < inuTotal THEN

       UT_TRACE.TRACE('LDC_PkPagosConsig.proApplyPayment Armando Registro No -->' ||
                      inuRegistro || ' Producto: '||nuProduc,
                      10);


       -- Crea el cupon
       pkBOPagoAnticipado.CREATECUPON(Onucupon,inuVlrPago,nuProduc);
       inuCuponPago := Onucupon;

       -- arma la tabla de proceso de pagos
       tytblrcPagos(nuCantReg).nuBanco      := inuBanco      ;         -- Codigo entidad de recaudo
       tytblrcPagos(nuCantReg).nuSucursal   := inuSucursal   ;         -- Codigo subcursal de recaudo
       tytblrcPagos(nuCantReg).nuConcilia   := inuConcilia   ;         -- Consecutivo de conciliacion
       tytblrcPagos(nuCantReg).nuCuponPago  := inuCuponPago  ;         -- Numero de cupon
       tytblrcPagos(nuCantReg).nuVlrPago    := inuVlrPago    ;         -- Valor del cupon
       tytblrcPagos(nuCantReg).sbClasdopa   := isbClasdopa   ;         -- Clase de documento de pago
       tytblrcPagos(nuCantReg).sbEntidopa   := isbEntidopa   ;         -- Entidad que expide el documento de pago
       tytblrcPagos(nuCantReg).sbDepadocu   := isbDepadocu   ;         -- Numero documento de pago
       tytblrcPagos(nuCantReg).sbFormpago   := isbFormpago   ;         -- Tipo de direccion de cobro
       tytblrcPagos(nuCantReg).dtFechapago  := idtFechapago  ;         -- Fecha de pago
       tytblrcPagos(nuCantReg).sbDepanucu   := isbDepanucu   ;         -- Numero de cuenta
       tytblrcPagos(nuCantReg).sbPagonutr   := isbPagonutr   ;         -- Numero de transaccion
       tytblrcPagos(nuCantReg).sbDepanuau   := isbDepanuau   ;         -- Numero de autorizacion
       tytblrcPagos(nuCantReg).nuDepanume   := inuDepanume   ;         -- Numero de meses
       tytblrcPagos(nuCantReg).nuProducto   := nuProduc      ;         -- Codigo producto

    END IF;

    -- todos los registros
    IF inuRegistro = inuTotal  THEN

       UT_TRACE.TRACE('LDC_PkPagosConsig.proApplyPayment Armando Registro No -->' ||
                      inuRegistro || ' Producto: '||nuProduc,
                      10);

       -- Crea el cupon
       pkBOPagoAnticipado.CREATECUPON(Onucupon,nuValor,nuProduc);
       inuCuponPago := Onucupon;

       --<<
       -- Arma la tabla y procesa los pagos con el ultimo registro
       -->>
       tytblrcPagos(nuCantReg).nuBanco      := inuBanco      ;         -- Codigo entidad de recaudo
       tytblrcPagos(nuCantReg).nuSucursal   := inuSucursal   ;         -- Codigo subcursal de recaudo
       tytblrcPagos(nuCantReg).nuConcilia   := inuConcilia   ;         -- Consecutivo de conciliacion
       tytblrcPagos(nuCantReg).nuCuponPago  := inuCuponPago  ;         -- Numero de cupon
       tytblrcPagos(nuCantReg).nuVlrPago    := inuVlrPago    ;         -- Valor del cupon
       tytblrcPagos(nuCantReg).sbClasdopa   := isbClasdopa   ;         -- Clase de documento de pago
       tytblrcPagos(nuCantReg).sbEntidopa   := isbEntidopa   ;         -- Entidad que expide el documento de pago
       tytblrcPagos(nuCantReg).sbDepadocu   := isbDepadocu   ;         -- Numero documento de pago
       tytblrcPagos(nuCantReg).sbFormpago   := isbFormpago   ;         -- Tipo de direccion de cobro
       tytblrcPagos(nuCantReg).dtFechapago  := idtFechapago  ;         -- Fecha de pago
       tytblrcPagos(nuCantReg).sbDepanucu   := isbDepanucu   ;         -- Numero de cuenta
       tytblrcPagos(nuCantReg).sbPagonutr   := isbPagonutr   ;         -- Numero de transaccion
       tytblrcPagos(nuCantReg).sbDepanuau   := isbDepanuau   ;         -- Numero de autorizacion
       tytblrcPagos(nuCantReg).nuDepanume   := inuDepanume   ;         -- Numero de meses
       tytblrcPagos(nuCantReg).nuProducto   := nuProduc      ;         -- Codigo producto

       --<<
       -- Recorre la tabla registro para procesar los cupones
       -->>
       FOR idx IN tytblrcPagos.FIRST..tytblrcPagos.LAST LOOP
           -- Si existen datos a procesar
           IF tytblrcPagos.EXISTS(idx) THEN

             -- Crea la conciliacion
             IF ( idx = 1 )  THEN

                 UT_TRACE.TRACE('LDC_PkPagosConsig.proApplyPayment Crea Conciliacion-->',10);

                 inuCouponsnumber := inuTotal;
                 --<<
                 -- Creacion de la conciliacion
                 --<<
                 pkBOPagoAnticipado.CREATECONCILIA
                  (
                      inuBanco          ,    -- Codigo entidad de recaudo
                      idtFechapago      ,    -- Fecha de pago
                      inuCouponsnumber  ,    -- Cantidad de cupones a procesar
                      inuTotalvalue     ,    -- Valor total consignacion
                      onuConsConcilia        -- Retorna Consecutivo de la conciliacion
                  );

                  -- Consecutivo de conciliacion
                  tytblrcPagos(idx).nuConcilia := onuConsConcilia;

                  UT_TRACE.TRACE('LDC_PkPagosConsig.proApplyPayment Conciliacion Creada -->' ||
                                  onuConsConcilia,
                                  10);
              ELSE
                 tytblrcPagos(idx).nuConcilia := onuConsConcilia;
              END IF; -- fin crea conciliacion





              UT_TRACE.TRACE('LDC_PkPagosConsig.proApplyPayment Procesando el Recaudo Cupon -->' ||
                              tytblrcPagos(idx).nuCuponPago || ' Producto: '||tytblrcPagos(idx).nuProducto||
                              ' Valor: '||tytblrcPagos(idx).nuVlrPago,
                              10
                             );

              -- si el valor es mayor que cero > 0
              IF tytblrcPagos(idx).nuVlrPago > 0 THEN
                 --<<
                 -- Procesa el Pago y actualiza el flag de procesado
                 -->>
                 BEGIN
                  pkBOPagoAnticipado.REGISTROPAGO
                    (
                        tytblrcPagos(idx).nuBanco     ,       -- Codigo entidad de recaudo
                        tytblrcPagos(idx).nuSucursal  ,       -- Codigo subcursal de recaudo
                        tytblrcPagos(idx).nuConcilia  ,       -- Consecutivo de conciliacion
                        tytblrcPagos(idx).nuCuponPago ,       -- Numero de cupon
                        tytblrcPagos(idx).nuVlrPago   ,       -- Valor del cupon
                        tytblrcPagos(idx).sbClasdopa  ,       -- Clase de documento de pago
                        tytblrcPagos(idx).sbEntidopa  ,       -- Entidad que expide el documento de pago
                        tytblrcPagos(idx).sbDepadocu  ,       -- Numero documento de pago
                        tytblrcPagos(idx).sbFormpago  ,       -- Tipo de direccion de cobro
                        tytblrcPagos(idx).dtFechapago ,       -- Fecha de pago
                        tytblrcPagos(idx).sbDepanucu  ,       -- Numero de cuenta
                        tytblrcPagos(idx).sbPagonutr  ,       -- Numero de transaccion
                        tytblrcPagos(idx).sbDepanuau  ,       -- Numero de autorizacion
                        tytblrcPagos(idx).nuDepanume          -- Numero de meses
                     );

                     UT_TRACE.TRACE('LDC_PkPagosConsig.proCambEstaProcesa Inicia Cambia estado-->' ||
                                    tytblrcPagos(idx).nuCuponPago || ' Producto: '||tytblrcPagos(idx).nuProducto||
                                    ' Valor: '||tytblrcPagos(idx).nuVlrPago,
                                    10
                                    );

                     -- Cambia el estado a procesado
                     proCambEstaProcesa(tytblrcPagos(idx).nuProducto);

                     UT_TRACE.TRACE('LDC_PkPagosConsig.proCambEstaProcesa Fin Cambia estado-->' ||
                                    tytblrcPagos(idx).nuCuponPago || ' Producto: '||tytblrcPagos(idx).nuProducto||
                                    ' Valor: '||tytblrcPagos(idx).nuVlrPago,
                                    10
                                    );

                     EXCEPTION
                        WHEN Others THEN
                             -- NO Cambia el estado del Flag a Procesado
                             UT_TRACE.TRACE('LDC_PkPagosConsig.proApplyPayment ERROR Procesando el Recaudo Cupon -->' ||
                                             tytblrcPagos(idx).nuCuponPago || ' Producto: '||tytblrcPagos(idx).nuProducto||
                                            ' Valor: '||tytblrcPagos(idx).nuVlrPago,
                                              10
                                           );

                          -- Dbms_Output.Put_Line(( 'Error_Backtrace...' || Chr(10) || SQLCODE ||' - '||
                          --                         DBMS_UTILITY.FORMAT_ERROR_BACKTRACE() ));


                 END; -- Fin Procesa pagos
              END IF; -- Fin validacion del pago mayor que cero (>0)
           END IF;
       END LOOP;

    -- Borrado de datos en memoria
    tytblrcPagos.delete;
    nuCantReg    := 0;
    inuConcilia  := NULL;

    END IF; -- Fin recorrido todos los registros
  END proApplyPayment;



END LDC_PkPagosConsig;
/
PROMPT Otorgando permisos de ejecucion a LDC_PKPAGOSCONSIG
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PKPAGOSCONSIG', 'ADM_PERSON');
END;
/