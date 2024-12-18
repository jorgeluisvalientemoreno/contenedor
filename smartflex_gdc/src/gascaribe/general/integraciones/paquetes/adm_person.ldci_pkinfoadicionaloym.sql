CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKINFOADICIONALOYM AS
  /*-----------------------------------------------------------------------------------------------------------------------------------
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
   * Eduardo Aguera                27-04-2017  Se crean procedimientos para procesar asignacion, reasignacion y cambio de estado
                                               de ordenes.
  *-----------------------------------------------------------------------------------------------------------------------------------*/

  PROCEDURE proProcesaXMLVentaServicios(MENSAJE_ID            In Number,
                                        isbSistema            in VARCHAR2,
                                        inuOrden              in NUMBER,
                                        isbXML                in CLOB,
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

  PROCEDURE proProcesaXMLIPLIO ( MENSAJE_ID            In Number,
                                 isbSistema            in VARCHAR2,
                                 inuOrden              in NUMBER,
                                 isbXML                in CLOB,
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

  PROCEDURE proProcesaXMLAsignacion( MENSAJE_ID            In Number,
                                     isbSistema            in VARCHAR2,
                                     inuOrden              in NUMBER,
                                     isbXML                in CLOB,
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

  PROCEDURE proProcesaXMLReasignacion( MENSAJE_ID            In Number,
                                       isbSistema            in VARCHAR2,
                                       inuOrden              in NUMBER,
                                       isbXML                in CLOB,
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

  PROCEDURE proProcesaXMLCambioEstado( MENSAJE_ID            In Number,
                                       isbSistema            in VARCHAR2,
                                       inuOrden              in NUMBER,
                                       isbXML                in CLOB,
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

END LDCI_PKINFOADICIONALOYM;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKINFOADICIONALOYM AS

  PROCEDURE proProcesaXMLVentaServicios(MENSAJE_ID    In Number,
                                        isbSistema    in VARCHAR2, --
                                        inuOrden      in NUMBER, --
                                        isbXML        in CLOB, --
                                        isbEstado     in Varchar2,
                                        isbOperacion  in Varchar2,
                                        inuProcesoExt in number,
                                        idtFechaRece  in date,
                                        idtFechaProc  in date,
                                        idtFechaNoti  in date,
                                        inuCodErrOsf  in number,
                                        isbMsgErrOsf  in Varchar2,
                                        ocurRespuesta Out SYS_REFCURSOR,
                                        onuErrorCodi  out NUMBER,
                                        osbErrorMsg   out VARCHAR2) AS

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
    /*tyRegRespuesta.Parametro := 'idSistema';
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
    tabRespuesta(6) := tyRegRespuesta;*/

    open ocurRespuesta for
      select 'idSistema' parametro, isbSistema valor
        from dual
      union
      select 'idSolicitud' parametro, to_char(onupackages) valor
        from dual
      union
      select 'idMotivo' parametro, to_char(onumotive) valor
        from dual
      union
      select 'idOrden' parametro, to_char(onuorden) valor
        from dual
      union
      select 'codigoError' parametro, to_char(onuErrorCodi) valor
        from dual
      union
      select 'mensajeError' parametro, osbErrorMsg valor from dual;

    -- Se asigna la respuesta a la salida
    -- osbXMLRespuesta := tabRespuesta;

    -- Manejo de excepciones

  Exception
    When Others Then

      onuErrorCodi := -1;
      osbErrorMsg  := '[LDCI_PKINFOADICIONALOYM.proProcesaXMLVentaServicios.Others]: ' ||
                      SqlErrM;

      -- Genera la Respuesta
      /*tyRegRespuesta.Parametro := 'idSistema';
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
      tabRespuesta(6) := tyRegRespuesta;*/

      open ocurRespuesta for
        select 'idSistema' parametro, isbSistema valor
          from dual
        union
        select 'idSolicitud' parametro, to_char(-1) valor
          from dual
        union
        select 'idMotivo' parametro, to_char(-1) valor
          from dual
        union
        select 'idOrden' parametro, to_char(-1) valor
          from dual
        union
        select 'codigoError' parametro, to_char(onuErrorCodi) valor
          from dual
        union
        select 'mensajeError' parametro, osbErrorMsg valor from dual;

    -- Se asigna la respuesta a la salida
    -- osbXMLRespuesta := tabRespuesta;

  End proProcesaXMLVentaServicios;

  ---------------------------------------------------------------------------------------

  PROCEDURE proProcesaXMLIPLIO(MENSAJE_ID    In Number,
                               isbSistema    in VARCHAR2, --
                               inuOrden      in NUMBER, --
                               isbXML        in CLOB, --
                               isbEstado     in Varchar2,
                               isbOperacion  in Varchar2,
                               inuProcesoExt in number,
                               idtFechaRece  in date,
                               idtFechaProc  in date,
                               idtFechaNoti  in date,
                               inuCodErrOsf  in number,
                               isbMsgErrOsf  in Varchar2,
                               ocurRespuesta Out SYS_REFCURSOR,
                               onuErrorCodi  out NUMBER,
                               osbErrorMsg   out VARCHAR2) AS

    /*
    * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
    *
    * Proceso     : proProcesaXMLIPLIO
    * Tiquete     :
    *  Fecha       : 15-10-2015
    * Descripcion : Genera Orden IPLIO.
    *
    * Historia de Modificaciones
    * Autor                    Fecha       Descripcion
    *
    *
    *
    **/

    /*cursor para leer el xml*/
    cursor cuxmlsercv(isbXMLserv In Varchar2) is
      Select Datosserv.*
        From XMLTable('/proProcesaXMLIPLIO' Passing XMLType(isbXMLserv)
                      COLUMNS medidor varchar2(50) Path 'idMedidor',
                      contrato NUMBER(15) Path 'idContrato',
                      producto NUMBER(15) Path 'idProducto') As Datosserv;

    rgInfoserv cuxmlsercv%RowType;

    -- cursor para hallar producto y contrato con base en el medidor
    cursor cuGetProdbyMed(cnucontrato servsusc.sesususc%type,
                          cnuproducto servsusc.sesunuse%type,
                          cnumedidor  elemmedi.elmecodi%type) is
      select suscclie, sesususc, sesunuse
        from open.lectelme l, open.servsusc ss, open.suscripc sc
       where sc.susccodi = ss.sesususc
         and ss.sesunuse = l.leemsesu
         and sc.susccodi =
             decode(nvl(cnucontrato, -1), -1, sc.susccodi, cnucontrato)
         and ss.sesunuse =
             decode(nvl(cnuproducto, -1), -1, ss.sesunuse, cnuproducto)
         and l.leemelme = (select m.elmeidem
                             from open.elemmedi m
                            where m.elmecodi = cnumedidor)
       order by l.leemfele desc;

    cursor cuGetProducto(cnucontrato servsusc.sesususc%type,
                         cnuproducto servsusc.sesunuse%type) is
      select suscclie, sesususc, sesunuse
        from open.servsusc ss, open.suscripc sc
       where sc.susccodi = ss.sesususc
         and ss.sesuserv = 7014
         and sc.susccodi =
             decode(cnucontrato, -1, sc.susccodi, cnucontrato)
         and ss.sesunuse =
             decode(cnuproducto, -1, ss.sesunuse, cnuproducto);

    -- cursor para hallar address_id
    cursor cuAddress(cnuproducto servsusc.sesunuse%type) is
      select pr.address_id
        from pr_product pr
       where pr.product_id = cnuproducto;

    -- cursor para hallar sector_operativo
    cursor cuSectOp(cnuaddress pr_product.address_id%type) is
      select as1.operating_sector_id
        from ab_segments as1
       where as1.segments_id in
             (select ad.segment_id
                from ab_address ad
               where ad.address_id = cnuaddress);

    --    rgInfoservact cuxmlsercvact%RowType;

    nucliente   suscripc.susccodi%type;
    nuAddress   pr_product.address_id%type;
    nuActividad or_order_activity.activity_id%type;
    nuSeop      ab_segments.operating_sector_id%type;
    onucontrato servsusc.sesususc%type;
    onuproducto servsusc.sesunuse%type;
    onuorden    number;
    --onuerrorcode    number;
    --osberrormessage varchar2(2000);

  BEGIN

    --identifica valores del XML

    Open cuxmlsercv(isbXML);
    Fetch cuxmlsercv
      Into rgInfoserv;
    Close cuxmlsercv;

    -- Halla y Valida Contrato y Producto
    if rgInfoserv.Contrato is null and rgInfoserv.Producto is null and
       rgInfoserv.medidor is null then
      onuErrorCodi := -1;
      osbErrorMsg  := 'No hay datos en el XML';
    elsif rgInfoserv.medidor is not null then
      open cuGetProdbyMed(nvl(rgInfoserv.Contrato, -1),
                          nvl(rgInfoserv.Producto, -1),
                          rgInfoserv.medidor);
      fetch cuGetProdbyMed
        into nucliente, onucontrato, onuProducto;
      if cuGetProdbyMed%notfound then
        onuErrorCodi := -1;
        osbErrorMsg  := 'Medidor, Contrato o Producto no corresponden o no existen';
      end if;
      close cuGetProdbyMed;

    elsif rgInfoserv.medidor is null then
      open cuGetProducto(nvl(rgInfoserv.Contrato, -1),
                         nvl(rgInfoserv.Producto, -1));
      fetch cuGetProducto
        into nucliente, onucontrato, onuProducto;
      if cuGetProducto%notfound then
        onuErrorCodi := -1;
        osbErrorMsg  := 'Medidor o Contrato no corresponden o no existen';
      end if;
      close cuGetProducto;
    end if;

    if nvl(onuErrorCodi, 0) != -1 then
      -- halla Address_Id
      open cuAddress(onuProducto);
      fetch cuAddress
        into nuAddress;
      if cuAddress%notfound then
        nuAddress := null;
      end if;
      close cuAddress;

      -- halla Codigo de Actividad de Ordenes IPLIO
      nuActividad := dald_parameter.fnuGetNumeric_Value('ITEM_IPLI');

      --genera orden IPLIO
      OS_CREATEORDERACTIVITIES(nuActividad,
                               nuAddress,
                               sysdate,
                               'Orden de la Actividad ' || nuActividad ||
                               ' - PNO', -- observacion
                               0,
                               onuorden,
                               onuErrorCodi,
                               osbErrorMsg);

      -- si no hubo error actualiza cliente y sector operativo
      if onuErrorCodi = 0 then
        -- halla sector operativo
        open cuSectOp(nuAddress);
        fetch cuSectOp
          into nuSeop;
        if cuSectOp%notfound then
          nuSeop := null;
        end if;
        close cuSectOp;

        -- Actualiza Cliente y Sector Operativo
        update or_order_activity oa
           set oa.product_id          = onuproducto,
               oa.subscription_id     = onucontrato,
               oa.subscriber_id       = nucliente,
               oa.operating_sector_id = nuSeop
         where oa.order_id = onuorden;
      end if;

    end if;

    if onuErrorCodi != 0 then
      -- hubo error
      open ocurRespuesta for
        select 'idSistema' parametro, isbSistema valor
          from dual
        union
        select 'idContrato' parametro, to_char(onucontrato) valor
          from dual
        union
        select 'idProducto' parametro, to_char(onuproducto) valor
          from dual
        union
        select 'idOrden' parametro, null valor
          from dual
        union
        select 'codigoError' parametro, to_char(onuErrorCodi) valor
          from dual
        union
        select 'mensajeError' parametro, osbErrorMsg valor from dual;
    else
      open ocurRespuesta for
        select 'idSistema' parametro, isbSistema valor
          from dual
        union
        select 'idContrato' parametro, to_char(onucontrato) valor
          from dual
        union
        select 'idProducto' parametro, to_char(onuproducto) valor
          from dual
        union
        select 'idOrden' parametro, to_char(onuorden) valor
          from dual
        union
        select 'codigoError' parametro, to_char(onuErrorCodi) valor
          from dual
        union
        select 'mensajeError' parametro, osbErrorMsg valor from dual;
    end if;

    -- Manejo de excepciones

  Exception
    When Others Then

      onuErrorCodi := -1;
      osbErrorMsg  := '[LDCI_PKINFOADICIONALOYM.proProcesaXMLIPLIO.Others]: ' ||
                      SqlErrM;

      open ocurRespuesta for
        select 'idSistema' parametro, isbSistema valor
          from dual
        union
        select 'idContrato' parametro, to_char(nvl(onucontrato, -1)) valor
          from dual
        union
        select 'idProducto' parametro, to_char(nvl(onuproducto, -1)) valor
          from dual
        union
        select 'idOrden' parametro, null valor
          from dual
        union
        select 'codigoError' parametro, to_char(onuErrorCodi) valor
          from dual
        union
        select 'mensajeError' parametro, osbErrorMsg valor from dual;

  End proProcesaXMLIPLIO;

  -----------------------------------------------------------------------------------------------------------
  PROCEDURE proProcesaXMLAsignacion(MENSAJE_ID    In Number,
                                    isbSistema    in VARCHAR2,
                                    inuOrden      in NUMBER,
                                    isbXML        in CLOB,
                                    isbEstado     in Varchar2,
                                    isbOperacion  in Varchar2,
                                    inuProcesoExt in number,
                                    idtFechaRece  in date,
                                    idtFechaProc  in date,
                                    idtFechaNoti  in date,
                                    inuCodErrOsf  in number,
                                    isbMsgErrOsf  in Varchar2,
                                    ocurRespuesta Out SYS_REFCURSOR,
                                    onuErrorCodi  out NUMBER,
                                    osbErrorMsg   out VARCHAR2) AS

    /*-----------------------------------------------------------------------------
    * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
    *
    * Proceso     : proProcesaXMLAsignacion
    * Tiquete     :
    * Fecha       : 27-04-2017
    * Descripcion : Ejecuta la asignacion de ordenes de trabajo
    *
    * Historia de Modificaciones
    * Autor                    Fecha       Descripcion
    * Eduardo Aguera           27-04-2017  Creacion
    * Elkin Alvarez            22-06-2017  se cambia el llamado a la api por el llamado
                               al procedimiento ldc_assign_order
    *------------------------------------------------------------------------------*/

    --Cursor para leer el xml
    cursor cuxmlasig(isbXMLasig In Varchar2) is
      Select DatosAsig.*
        From XMLTable('/proProcesaXMLAsignacion' Passing
                      XMLType(isbXMLasig) COLUMNS idOrder NUMBER(15) Path
                      'idOrder',
                      idUnidadOper NUMBER(15) Path 'idUnidadOper',
                      dtFechaArreglo VARCHAR2(50) Path 'fechaArreglo',
                      dtFechaCambio VARCHAR2(50) Path 'fechaCambio') As DatosAsig;

    rgInfoAsig      cuxmlasig%RowType;
    DTASSIGNED_DATE DATE;

  BEGIN

    --Leemos el XML
    Open cuxmlasig(isbXML);
    Fetch cuxmlasig
      Into rgInfoAsig;
    Close cuxmlasig;

    --SE LLAMA EL PROCEDIMIENTO LDC_ASSIGN_ORDER EN VEZ DEL API
    LDC_ASSIGN_ORDER(INUORDERID         => rgInfoAsig.idOrder, --
                     INUOPERATINGUNITID => rgInfoAsig.idUnidadOper, --
                     IDTARRANGEDHOUR    => rgInfoAsig.dtFechaArreglo, --
                     IDTCHANGEDATE      => rgInfoAsig.dtFechaCambio, --
                     IDTASSIGORD        => rgInfoAsig.dtFechaCambio, --eam fecha asig, se asume que es la fecha de cambio
                     ONUERRORCODE       => onuErrorCodi, --
                     OSBERRORMESSAGE    => osbErrorMsg);

    /*     --API para asignar la orden a la unidad operativa
    OS_ASSIGN_ORDER(inuOrderId => rgInfoAsig.idOrder,
                     inuoperatingunitid => rgInfoAsig.idUnidadOper,
                     idtarrangedhour => rgInfoAsig.dtFechaArreglo,
                     idtchangedate => rgInfoAsig.dtFechaCambio,
                     onuerrorcode => onuErrorCodi,
                     osberrormessage => osbErrorMsg);*/

    open ocurRespuesta for
      select 'idSistema' parametro, isbSistema valor
        from dual
      union
      select 'codigoError' parametro, to_char(onuErrorCodi) valor
        from dual
      union
      select 'mensajeError' parametro, osbErrorMsg valor from dual;

  Exception
    When Others Then
      onuErrorCodi := -1;
      osbErrorMsg  := '[LDCI_PKINFOADICIONALOYM.proProcesaXMLAsignacion.Others]: ' ||
                      SqlErrM;

      open ocurRespuesta for
        select 'idSistema' parametro, isbSistema valor
          from dual
        union
        select 'codigoError' parametro, to_char(onuErrorCodi) valor
          from dual
        union
        select 'mensajeError' parametro, osbErrorMsg valor from dual;

  End proProcesaXMLAsignacion;

  -----------------------------------------------------------------------------------------------------------
  PROCEDURE proProcesaXMLReasignacion(MENSAJE_ID    In Number,
                                      isbSistema    in VARCHAR2,
                                      inuOrden      in NUMBER,
                                      isbXML        in CLOB,
                                      isbEstado     in Varchar2,
                                      isbOperacion  in Varchar2,
                                      inuProcesoExt in number,
                                      idtFechaRece  in date,
                                      idtFechaProc  in date,
                                      idtFechaNoti  in date,
                                      inuCodErrOsf  in number,
                                      isbMsgErrOsf  in Varchar2,
                                      ocurRespuesta Out SYS_REFCURSOR,
                                      onuErrorCodi  out NUMBER,
                                      osbErrorMsg   out VARCHAR2) AS

    /*-----------------------------------------------------------------------------
    * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
    *
    * Proceso     : proProcesaXMLReasignacion
    * Tiquete     :
    * Fecha       : 27-04-2017
    * Descripcion : Ejecuta la reasignacion de ordenes de trabajo
    *
    * Historia de Modificaciones
    * Autor                    Fecha       Descripcion
    * Eduardo Aguera           27-04-2017  Creacion
    *------------------------------------------------------------------------------*/

    --Cursor para leer el xml
    cursor cuxmlreasig(isbXMLreasig In Varchar2) is
      Select DatosReasig.*
        From XMLTable('/proProcesaXMLReAsignacion' Passing
                      XMLType(isbXMLreasig) COLUMNS idOrder NUMBER(15) Path
                      'idOrder',
                      idUnidadOper NUMBER(15) Path 'idUnidadOper',
                      sbFechaEjecucion VARCHAR2(50) Path 'fechaEjecucion') As DatosReasig;

    rgInfoReasig cuxmlreasig%RowType;

  BEGIN

    --Leemos el XML
    Open cuxmlreasig(isbXML);
    Fetch cuxmlreasig
      Into rgInfoReasig;
    Close cuxmlreasig;

    --API para reasignar la orden a la unidad operativa
    LDC_OS_REASSINGORDER(inuorder        => rgInfoReasig.idOrder,
                         inuoperatunit   => rgInfoReasig.idUnidadOper,
                         idtexecdate     => rgInfoReasig.sbFechaEjecucion,
                         onuerrorcode    => onuErrorCodi,
                         osberrormessage => osbErrorMsg);

    open ocurRespuesta for
      select 'idSistema' parametro, isbSistema valor
        from dual
      union
      select 'codigoError' parametro, to_char(onuErrorCodi) valor
        from dual
      union
      select 'mensajeError' parametro, osbErrorMsg valor from dual;

  Exception
    When Others Then
      onuErrorCodi := -1;
      osbErrorMsg  := '[LDCI_PKINFOADICIONALOYM.proProcesaXMLReasignacion.Others]: ' ||
                      SqlErrM;

      open ocurRespuesta for
        select 'idSistema' parametro, isbSistema valor
          from dual
        union
        select 'codigoError' parametro, to_char(onuErrorCodi) valor
          from dual
        union
        select 'mensajeError' parametro, osbErrorMsg valor from dual;

  End proProcesaXMLReasignacion;

  -----------------------------------------------------------------------------------------------------------
  PROCEDURE proProcesaXMLCambioEstado(MENSAJE_ID    In Number,
                                      isbSistema    in VARCHAR2,
                                      inuOrden      in NUMBER,
                                      isbXML        in CLOB,
                                      isbEstado     in Varchar2,
                                      isbOperacion  in Varchar2,
                                      inuProcesoExt in number,
                                      idtFechaRece  in date,
                                      idtFechaProc  in date,
                                      idtFechaNoti  in date,
                                      inuCodErrOsf  in number,
                                      isbMsgErrOsf  in Varchar2,
                                      ocurRespuesta Out SYS_REFCURSOR,
                                      onuErrorCodi  out NUMBER,
                                      osbErrorMsg   out VARCHAR2) AS

    /*-----------------------------------------------------------------------------
    * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
    *
    * Proceso     : proProcesaXMLCambioEstado
    * Tiquete     :
    * Fecha       : 27-04-2017
    * Descripcion : Ejecuta el cambio de estado de ordenes de trabajo
    *
    * Historia de Modificaciones
    * Autor                    Fecha       Descripcion
    * Eduardo Aguera           27-04-2017  Creacion
    *------------------------------------------------------------------------------*/

    --Cursor para leer el xml
    cursor cuxmlcambest(isbXMLreasig In Varchar2) is
      Select DatosCambEst.*
        From XMLTable('/proProcesaXMLCambioEstado' Passing
                      XMLType(isbXMLreasig) COLUMNS idOrder NUMBER(15) Path
                      'idOrder',
                      idEstado NUMBER(15) Path 'idEstado',
                      idCausal NUMBER(15) Path 'idCausal',
                      sbFechaCambio VARCHAR2(50) Path 'fechaCambio') As DatosCambEst;

    rgInfoCambEst cuxmlcambest%RowType;

  BEGIN

    --Leemos el XML
    Open cuxmlcambest(isbXML);
    Fetch cuxmlcambest
      Into rgInfoCambEst;
    Close cuxmlcambest;

    --API para cambio de estado de la orden
    LDC_CAMBIOESTADO(inuorderid      => rgInfoCambEst.idOrder,
                     inustate        => rgInfoCambEst.idEstado,
                     inucausalid     => rgInfoCambEst.idCausal,
                     idtchangedate   => rgInfoCambEst.sbFechaCambio,
                     onuerrorcode    => onuErrorCodi,
                     osberrormessage => osbErrorMsg);

    open ocurRespuesta for
      select 'idSistema' parametro, isbSistema valor
        from dual
      union
      select 'codigoError' parametro, to_char(onuErrorCodi) valor
        from dual
      union
      select 'mensajeError' parametro, osbErrorMsg valor from dual;

  Exception
    When Others Then
      onuErrorCodi := -1;
      osbErrorMsg  := '[LDCI_PKINFOADICIONALOYM.proProcesaXMLCambioEstado.Others]: ' ||
                      SqlErrM;

      open ocurRespuesta for
        select 'idSistema' parametro, isbSistema valor
          from dual
        union
        select 'codigoError' parametro, to_char(onuErrorCodi) valor
          from dual
        union
        select 'mensajeError' parametro, osbErrorMsg valor from dual;

  End proProcesaXMLCambioEstado;

End LDCI_PKINFOADICIONALOYM;
/

PROMPT Otorgando permisos de ejecucion a LDCI_PKINFOADICIONALOYM
BEGIN
  pkg_utilidades.prAplicarPermisos('LDCI_PKINFOADICIONALOYM','ADM_PERSON');
END;
/
