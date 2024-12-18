  CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKINFOADICIONALVENT AS
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
    JSOTO                          25/01/2024  Se cambia API OS_REGISTERREQUESTWITHXML por API_REGISTERREQUESTBYXML

  **/



  PROCEDURE proRegistraCotizacion(inuMensajeId In Number,
                                  inuOrderId   In Number,
                                  isbXMLVenta  In Clob,
                                  onucuotaIni  Out Number,
                                  onuErrorCodi Out Number,
                                  osbErrorMsg  Out Varchar2);

   Procedure proProcesaXMLVenta(MENSAJE_ID            In Number,    --
                               isbSistema            In Varchar2,  --
                               inuOrden              In Number,    --
                               isbXML                In Clob,      --
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

  Procedure proProcesaXMLSoliVisitaVenta(MENSAJE_ID            In Number,
                                         isbSistema            In Varchar2,      --
                                         inuOrden              In Number,        --
                                         isbXML                In Clob,          --
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


  /*
  * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
  *
  * Funcion     : proProcesaXMLSolSuspension
  * Tiquete     :
  * Autor       : Francisco Castro
  * Fecha       : 10-05-2016
  * Descripcion : Recibe el XML de informacion de suspencion.
  *
  *  XML de entrada
  *
   <proProcesaXMLSolSuspension>
      <fechaSolicitud/>
      <idFuncionario/>
      <idTipoRecepcion/>
      <identificacion/>
      <idProducto/>
      <Comentario/>
      <fechaSuspension/>
      <tipoSuspension/>
      <causalSuspension/>
    </proProcesaXMLSolSuspension >


  * Historia de Modificaciones
  * Autor                Fecha      Descripcion
  * Francisco Castro     10-05-2016 Creacion del procedimieno
  **/



END LDCI_PKINFOADICIONALVENT;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKINFOADICIONALVENT AS

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
      JSOTO                    25/01/2024   Se cambia API OS_REGISTERREQUESTWITHXML por API_REGISTERREQUESTBYXML
    * SAMUEL PACHECO (SINCECOMP)20-01-2016  ca 100-7282: se corrigen error en (Proregistracotizacion) registro de venta cotizada al momento de reenvia venta; de igual forma
                                            se contrala y notifica como error cuando se intenta reenviar una venta ya aplicada

      Karem Baquero(sincecomp)  29/07/2015  #7132 : Se agrega la insercci?n del xml en la tabla a para
    *                                       el registro de las ventas.
    * JESUS VIVERO (LUDYCOM)    25-05-2015  #ssssss-20150525: jesviv: Creacion del procedimiento
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
          osbErrorMsg  := '[LDCI_PKINFOADIONALVENT.proProcesaXMLVenta.Others]: ' ||
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
          osbErrorMsg  := '[LDCI_PKINFOADIONALVENT.proProcesaXMLVenta.Others]: ' ||
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
      osbErrorMsg  := '[LDCI_PKINFOADIONALVENT.proProcesaXMLVenta]: ' ||
                      'Se este reenviando una venta que esta Aplicada';
    end if;
  END proRegistraCotizacion;
  /**/

  Procedure proProcesaXMLVenta(MENSAJE_ID            In Number,    --
                               isbSistema            In Varchar2,  --
                               inuOrden              In Number,    --
                               isbXML                In Clob,      --
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
                               osbErrorMsg           out VARCHAR2) As

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
    * Autor          Fecha      Descripcion
    * Jesus Vivero   17-06-2014 Creacion del procedimieno
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
    Open cuXMLVenta(isbXML);
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
        api_registerrequestbyxml(isbRequestXML   => sbXMLInfoVenta,
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
              osbErrorMsg  := '[LDCI_PKINFOADIONALVENT.proProcesaXMLVenta.Others]: ' ||
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

    /*tyRegRespuesta.Parametro := 'idSistema';
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
    tabRespuesta(6) := tyRegRespuesta;*/

    open ocurRespuesta for
      select 'idSistema' parametro, isbSistema valor from dual union
      select 'idPaquete' parametro, to_char(nuPackageId) valor from dual union
      select 'idMotivo' parametro, to_char(nuMotiveId) valor from dual union
      select 'idOrden' parametro, to_char(inuOrden) valor from dual union
      select 'codigoError' parametro, to_char(onuErrorCodi) valor from dual union
      select 'mensajeError' parametro, osbErrorMsg valor from dual;
    -- Se asigna la respuesta a la salida
   -- otyTabRespuesta := tabRespuesta;
    commit;
    -- Manejo de excepciones
  Exception
    When Others Then
      onuErrorCodi := -1;
      osbErrorMsg  := '[LDCI_PKINFOADIONALVENT.proProcesaXMLVenta.Others]: ' ||
                      SqlErrM;
      UPDATE Ldci_CotiVentasMovil l
         SET l.codigo_error  = onuErrorCodi,
             l.mensaje_error = osbErrorMsg,
             l.estado        = 'E'
       WHERE l.mensaje_id = MENSAJE_ID
         AND l.order_id = inuOrden;

  End proProcesaXMLVenta;

  Procedure proProcesaXMLSoliVisitaVenta(MENSAJE_ID            In Number,
                                         isbSistema            In Varchar2,      --
                                         inuOrden              In Number,        --
                                         isbXML                In Clob,          --
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
                                         osbErrorMsg           out VARCHAR2) As

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

    --Datos de Salida
    nuPackageId Number;
    nuMotiveId  Number;
    nuOrderId   Number;

    --Estructura de respuesta
    tabRespuesta   LDCI_PkRepoDataType.tyTabRespuesta;
    tyRegRespuesta LDCI_PkRepoDataType.tyWSRespTrabAdicRecord;

  Begin

    -- Buscamos la informacion de la solicitud de visita de venta
    Open cuXMLSolicitud(isbXML);
    Fetch cuXMLSolicitud
      Into rgSoli;
    Close cuXMLSolicitud;

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

    If rgSoli.Subscriber_Name Is Null Or rgSoli.Subs_Last_Name Is Null Then
      onuErrorCodi     := 1;
      osbErrorMsg      := 'Informacion Incompleta al registrar solicitud de visita de venta: Falta nombre y/o apellido.';
      sbDatosCompletos := 'N';
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
    /*tyRegRespuesta.Parametro := 'idSistema';
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
    tabRespuesta(6) := tyRegRespuesta;*/

    open ocurRespuesta for
      select 'idSistema' parametro, isbSistema valor from dual union
      select 'idPaquete' parametro, to_char(nuPackageId) valor from dual union
      select 'idMotivo' parametro, to_char(nuMotiveId) valor from dual union
      select 'idOrden' parametro, to_char(Nvl(nuOrderId, inuOrden)) valor from dual union
      select 'codigoError' parametro, to_char(Nvl(onuErrorCodi, 0)) valor from dual union
      select 'mensajeError' parametro, osbErrorMsg valor from dual;

    -- Se asigna la respuesta a la salida
   -- otyTabRespuesta := tabRespuesta;

    -- Manejo de excepciones
  Exception
    When Others Then
      onuErrorCodi := -1;
      osbErrorMsg  := '[LDCI_PKINFOADICIONALVENT.proProcesaXMLSoliVisitaVenta.Others]: ' ||
                      SqlErrM;

  End proProcesaXMLSoliVisitaVenta;



End LDCI_PKINFOADICIONALVENT;
/
PROMPT Otorgando permisos de ejecucion a LDCI_PKINFOADICIONALVENT
BEGIN
  pkg_utilidades.prAplicarPermisos('LDCI_PKINFOADICIONALVENT','ADM_PERSON');
END;
/
