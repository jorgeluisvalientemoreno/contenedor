CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKGESTNOVORDERXTT AS
  PROCEDURE PROCANULPAGO(nuorderid      in or_order.order_id%type,
                         sbEstado_Envio in ldci_ordenmoviles.estado_envio%type,
                         nuestadootmov  in or_order.order_status_id%type,
                         nuoperat       in or_order.operating_unit_id%type,
                         sbfila         in varchar2,
                         nuresp         out number,
                         nutiponov      out number,
                         sbmensnov      out varchar2,
                         Onuerrorcode   out number,
                         Osberrormsg    out varchar2);
  PROCEDURE PROCANULCAMBESTA(nuorderid      in or_order.order_id%type,
                             sbEstado_Envio in ldci_ordenmoviles.estado_envio%type,
                             nuestadootmov  in or_order.order_status_id%type,
                             nuoperat       in or_order.operating_unit_id%type,
                             sbfila         in varchar2,
                             nuresp         out number,
                             nutiponov      out number,
                             sbmensnov      out varchar2,
                             Onuerrorcode   out number,
                             Osberrormsg    out varchar2);
  PROCEDURE PROCREASIGOT(nuorderid      in or_order.order_id%type,
                         sbEstado_Envio in ldci_ordenmoviles.estado_envio%type,
                         nuestadootmov  in or_order.order_status_id%type,
                         nuoperat       in or_order.operating_unit_id%type,
                         sbfila         in varchar2,
                         nuresp         out number,
                         nutiponov      out number,
                         sbmensnov      out varchar2,
                         Onuerrorcode   out number,
                         Osberrormsg    out varchar2);

  PROCEDURE PROCINSLOGANULPAGO (INUORDEN IN or_order.order_id%TYPE,
                                ISBFLAG IN LDCI_LOGANULPAGO.LOANFLAG%TYPE,
                                ONUERRORCODE OUT NUMBER,
                                OSBERRORMSG  OUT VARCHAR2);
END LDCI_PKGESTNOVORDERXTT;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKGESTNOVORDERXTT AS
/* -----------------------------------------------------------------------------
  Propiedad Intelectual Gases de Occidente SA ESP

  Script  : LDCI_PKGESTNOVORDERXTT.sql
  caso   : 200-757
  Autor   : KBaquero
  Fecha   : 16-03-2017
  Descripcion : Paquete de integracion con los sistemas moviles
			  que tiene los procesos de comfiguracion de cada una de las novedades.

  Historia de Modificaciones
  Autor                   Fecha         Descripcion
  KBaquero                16-03-2017    Version inicial
  Eduardo Ag黣ra          24-04-2017    Reestructuracion c贸digo y se quita funcionalidad
                                        que qued贸 en LDCI_PKGESTNOVORDER
*/
---------------------------------------------------------------------------------
/*-------------------------------------------------------------------------------
  PROPIEDAD INTELECTUAL DE GASES DEL CARIBE S.A E.S.P
  PROCEDIMIENTO    : PROCANULPAGO
  AUTOR      : Karem Baquero
  FECHA      : 10-03-2017
  CASO      : 200-757
  DESCRIPCION: Procedimiento que procesa las novedades por pago.
  Historia de Modificaciones
  Autor                   Fecha         Descripcion
  Karem Baquero           10-03-2017    Creaci?n
  LJLB                    26/02/2018    se  adiciona proceso PROCINSLOGANULPAGO para
                                        insertar en la tabla LDCI_LOGANULPAGO
--------------------------------------------------------------------------------*/
  PROCEDURE PROCANULPAGO(nuorderid      in or_order.order_id%type,
                         sbEstado_Envio in ldci_ordenmoviles.estado_envio%type,
                         nuestadootmov  in or_order.order_status_id%type,
                         nuoperat       in or_order.operating_unit_id%type,
                         sbfila         in varchar2,
                         nuresp         out number,
                         nutiponov      out number,
                         sbmensnov      out varchar2,
                         Onuerrorcode   out number,
                         Osberrormsg    out varchar2) AS

    sbTrabSusp LDCI_CARASEWE.CASEVALO%TYPE;
    sbTrabCart LDCI_CARASEWE.CASEVALO%TYPE;
    nuContOTSusp NUMBER;
    nuContOTCart NUMBER;
    --#20150302: jesusv: (INICIO) Variables para control de tiempo en notificacion de anulaciones
    nuMaxLote NUMBER;
    errorLegaliza EXCEPTION;
    sbFlagReconex Varchar2(10); --#20150204: jesusv: Se agrega variable para flag de reconexion
    nuCausal NUMBER;

    --Cursor para extraer datos de la orden en OSF
    CURSOR cuOrdenOSF(nuOrden or_order.order_id%type) IS
      SELECT o.order_id,
         o.subscriber_id,
         o.operating_unit_id,
         o.order_status_id,
         o.causal_id,
         o.task_type_id
      FROM or_order o
      WHERE o.order_id = nuOrden;

    CURSOR cuOrdenActividad(nuOrden or_order.order_id%type) IS
      SELECT o.order_activity_id,
         o.subscriber_id,
         o.subscription_id,
         o.product_id
      FROM or_order_activity o
      WHERE o.order_id = nuOrden;
    rgOrdenOSF       cuOrdenOSF%rowtype;
    rgOrdenActividad cuOrdenActividad%rowtype;

  Begin

    nuTipoNov := -1;

    --Traemos los datos de la orden de trabajo
    OPEN cuOrdenOSF(nuorderid);
    FETCH cuOrdenOSF INTO rgOrdenOSF;
    CLOSE cuOrdenOSF;

    --Traemos los datos de la actividad
    OPEN cuOrdenActividad(nuorderid);
    FETCH cuOrdenActividad
    INTO rgOrdenActividad;
    CLOSE cuOrdenActividad;

    /* Colocamos en comentario ya que ahora no es necesario evaluar las cuentas de cobro del producto. EA: 24/04/2017
    --Si la actividad no tiene producto, se continua con la siguiente orden ya que no se puede validar las cuentas de cobro con saldo
    IF rgOrdenActividad.Product_Id IS NULL THEN
      Onuerrorcode := -1;
      Osberrormsg  := 'ERROR: El ID producto es nulo en la orden ' ||nuorderid || ' y actividad ' ||rgOrdenActividad.Order_Activity_Id || '. ';
      LDCI_pkWebServUtils.Procrearerrorlogint('LDCI_PKGESTNOVORDERXTT.PROCANULPAGO',1,Osberrormsg,null,null);
    END IF;*/

    sbFlagReconex := Null;

    --API de Open para verificar si el producto es candidato para NO suspender
    OS_PEProdSuitRconnectn(inuProductId => rgOrdenActividad.Product_Id,
                           osbFlag => sbFlagReconex,
                           onuErrorCode => onuErrorCode,
                           osbErrorMsg => osbErrorMsg);

    If osbErrorMsg Is Not Null Then
      Onuerrorcode := -1;
      LDCI_pkWebServUtils.proCrearErrorLogInt('proSeleccionaOrdenesAnular<PROCANULPAGO>',1,'Error En Api OS_PEProdSuitRconnectn, Orden: ' ||
                          To_Char(nuorderid) ||' Producto: ' ||To_Char(rgOrdenActividad.Product_Id) ||' Error: ' || osbErrorMsg,Null,Null);
    End If;

    --Ticket 200 1586 LJLB-- se almacena log de pago
    PROCINSLOGANULPAGO (nuorderid,
                        sbFlagReconex,
                        ONUERRORCODE,
                        OSBERRORMSG);

    --El servicio debe ser reconectado
    If sbFlagReconex = 'S' Then

      --LDCI_LOGANULPAGO
      --Evaluamos si la orden no ha sido enviada en la integracion
      IF sbEstado_Envio = 'P' THEN
        Begin
          --Logica para determinar la causal de incumplimiento al legalizar la orden
          IF nuContOTSusp > 0 THEN
            --Si es orden de SISURE
            nuCausal := DALD_PARAMETER.fnuGetNumeric_Value('COD_CAUSAL_LEG_PAGO_SISURE',NULL);
          ELSE
            -- Si es orden de SIMOCAR
            nuCausal := DALD_PARAMETER.fnuGetNumeric_Value('COD_CAUSAL_LEG_PAGO_SIMOCAR',NULL);
          END IF;
          --llamado a API que legaliza la orden de trabajo
          os_legalizeorderallactivities(inuorderid  => nuorderid,
                                        inucausalid => nuCausal,
                                        inupersonid => rgOrdenOSF.Operating_Unit_Id,
                                        idtexeinitialdate => sysdate,
                                        idtexefinaldate => sysdate,
                                        isbcomment => 'Orden legalizada incumplida por pago del usuario. Legalizada desde LDCI_PKGESTNOVORDERXTT.proSeleccionaOrdenesAnular',
                                        idtchangedate => null,
                                        onuerrorcode => Onuerrorcode,
                                        osberrormessage => Osberrormsg);

          If Onuerrorcode = 0 Then
            If LDCI_PKGESTNOVORDER.fblLockOrdenMovil(sbfila /*rgOrdenMoviles(I).idfila*/) then
              UPDATE ldci_ordenmoviles o
                 SET o.Estado_Envio = 'G'
               WHERE rowid = sbfila;

               nuresp := rgOrdenOSF.Order_Status_Id;
            End if;
          END IF;

        EXCEPTION
          WHEN errorLegaliza THEN
            nuresp := rgOrdenOSF.Order_Status_Id;
            Onuerrorcode := -1;
            Osberrormsg  := 'ERROR: <proSeleccionaOrdenesAnular - PROCANULPAGO>: Error legalizando la orden: ' ||nuorderid || ' incumplida. ' || Osberrormsg;
        END;
      ELSE
        --Notificamos anulacion por pago oportuno del cliente
        Onuerrorcode := 0;
        nutiponov    := 1;
        sbmensnov    := 'La orden debe ser legalizada incumplida por pago total oportuno del usuario';
        nuresp       := rgOrdenOSF.Order_Status_Id;
      END IF;
    END IF; --Fin If sbFlagReconex = 'S' Then
    Onuerrorcode := 0;

  EXCEPTION
    WHEN OTHERS THEN
      Onuerrorcode := -1;
      LDCI_pkWebServUtils.Procrearerrorlogint('LDCI_PKGESTNOVORDER.proSeleccionaNovSistema',
                          1,
                          'El proceso de seleccion de ordenes a anular fallo: ' ||
                          DBMS_UTILITY.format_error_backtrace ||
                          Osberrormsg,
                          null,
                          null);
  End PROCANULPAGO;
  --------------------------------------------------------------------------------------------------
  /*
   PROPIEDAD INTELECTUAL DE GASES DEL CARIBE S.A E.S.P
   PROCEDIMIENTO    : PROCANULCAMBESTA
   AUTOR      : Karem Baquero
   FECHA      : 13-03-2017
   CASO      : 200-757
   DESCRIPCION: Procedimiento que procesa las novedades cambio de estado en las orndes en OSF.

   Historia de Modificaciones
   Autor                   Fecha         Descripcion
   Karem Baquero           13-03-2017    Creaci?n
  ------------------------------------------------------------------------------------------------*/
  PROCEDURE PROCANULCAMBESTA(nuorderid      in or_order.order_id%type,
                             sbEstado_Envio in ldci_ordenmoviles.estado_envio%type,
                             nuestadootmov  in or_order.order_status_id%type,
                             nuoperat       in or_order.operating_unit_id%type,
                             sbfila         in varchar2,
                             nuresp         out number,
                             nutiponov      out number,
                             sbmensnov      out varchar2,
                             Onuerrorcode   out number,
                             Osberrormsg    out varchar2) AS

    --Cursor para extraer datos de la orden en OSF
    CURSOR cuOrdenOSF(nuOrden or_order.order_id%type) IS
      SELECT o.order_id,
             o.subscriber_id,
             o.operating_unit_id,
             o.order_status_id,
             o.causal_id,
             o.task_type_id
      FROM or_order o
      WHERE o.order_id = nuOrden;

    rgOrdenOSF cuOrdenOSF%rowtype;

    --#20150317: jesusv: (INICIO) Cursor de estado de la orden en integraciones
    Cursor cuEstadoOrdenMovil(inuOrderId In Ldci_Ordenmoviles.Order_Id%Type) Is
      Select o.Estado_Envio
      From Ldci_Ordenmoviles o
       Where o.Order_Id = inuOrderId;
    rgEstadoOrdenMovil cuEstadoOrdenMovil%RowType;

  BEGIN
    nutiponov := -1;

    --Traemos los datos de la orden de trabajo
    OPEN cuOrdenOSF(nuorderid);
    FETCH cuOrdenOSF INTO rgOrdenOSF;
    CLOSE cuOrdenOSF;

    nuresp := rgOrdenOSF.Order_Status_Id;

    IF (nuestadootmov <> rgOrdenOSF.Order_Status_Id) and (LDCI_PKGESTNOVORDER.fblEnvMensAnul(rgOrdenOSF.task_type_id,rgOrdenOSF.Order_Status_Id)) THEN
      --#20150317: jesusv: (INICIO) Se verifica el estado en la tabla de integraciones para identificar si fue el movil quien la gestiono
      Open cuEstadoOrdenMovil(nuorderid);
      Fetch cuEstadoOrdenMovil
      Into rgEstadoOrdenMovil;
      Close cuEstadoOrdenMovil;

      If rgEstadoOrdenMovil.Estado_Envio In ('P', 'E', 'F') Then
        --#20150317: jesusv: (FIN) Se verifica el estado en la tabla de integraciones para identificar si fue el movil quien la gestiono
        Onuerrorcode := 0;
        sbmensnov    := 'La orden debe ser anulada, ya que fue gestionada desde el sistema central OSF';
        nuresp       := rgOrdenOSF.Order_Status_Id;
        nutiponov    := 0;
      End If; --#20150317: jesusv: --If rgEstadoOrdenMovil.Estado_Envio In ('P', 'E', 'F') Then
    End If; --#20150302: jesusv: Valida si aplica o no el proceso de control de tiempo de anulacion, sino por defecto funcionara como antes

  EXCEPTION
    WHEN OTHERS THEN
      Onuerrorcode := -1;
      Osberrormsg := 'Error obteniendo valor de parametro: ' || Osberrormsg;
      LDCI_pkWebServUtils.Procrearerrorlogint('LDCI_PKGESTNOTIORDEN.proSeleccionaOrdenesAnular.PROCANULCAMBESTA',
                        1,
                        'El proceso de CAMBIO DE ESTADO DE LA ANULACION DE ORDENES FALLO fallo: ' ||
                        DBMS_UTILITY.format_error_backtrace,
                        null,
                        null);
  END PROCANULCAMBESTA;
------------------------------------------------------------------------------------------------------
  /* ---------------------------------------------------------------------------------------------------
   PROPIEDAD INTELECTUAL DE GASES DEL CARIBE S.A E.S.P
   PROCEDIMIENTO    : PROCREASIGOT
   AUTOR      : Karem Baquero
   FECHA      : 14-03-2017
   CASO      : 200-757
   DESCRIPCION: Identifica si una orden debe ser notificada por reasignacion de unidad operativa.

   Historia de Modificaciones
   Autor                   Fecha         Descripcion
   Karem Baquero           14-03-2017    Creaci贸n
   Eduardo Ag黣ra          20-04-2017    Estructuraci贸n del c贸digo
  -----------------------------------------------------------------------------------------------------*/
  PROCEDURE PROCREASIGOT(nuorderid      in or_order.order_id%type,
                         sbEstado_Envio in ldci_ordenmoviles.estado_envio%type,
                         nuestadootmov  in or_order.order_status_id%type,
                         nuoperat       in or_order.operating_unit_id%type,
                         sbfila         in varchar2,
                         nuresp         out number,
                         nutiponov      out number,
                         sbmensnov      out varchar2,
                         Onuerrorcode   out number,
                         Osberrormsg    out varchar2) AS

    --Cursor para extraer datos de la orden en OSF
    CURSOR cuOrdenOSF(nuOrden or_order.order_id%type) IS
      SELECT o.order_id,
             o.subscriber_id,
             o.operating_unit_id,
             o.order_status_id,
             o.causal_id,
             o.task_type_id
      FROM or_order o
      WHERE o.order_id = nuOrden;

    rgOrdenOSF cuOrdenOSF%rowtype;

  BEGIN

    nutiponov := -1;

    --Traemos los datos de la orden de trabajo
    OPEN cuOrdenOSF(nuorderid);
    FETCH cuOrdenOSF INTO rgOrdenOSF;
    CLOSE cuOrdenOSF;

    IF (rgOrdenOSF.operating_unit_id <> nuoperat) THEN
      Osberrormsg  := '';
      nuresp       := rgOrdenOSF.Order_Status_Id;
      Onuerrorcode := 0;
      sbmensnov  := TO_CHAR(rgOrdenOSF.Operating_Unit_Id);
      nutiponov    := 2;
    End If;

  EXCEPTION
    WHEN OTHERS THEN
      Onuerrorcode := -1;
      Osberrormsg  := 'Error ejecutando procedimiento LDCI_PKGESTNOVORDERXTT.PROCREASIGOT: ' ||Osberrormsg;

      LDCI_pkWebServUtils.Procrearerrorlogint('LDCI_PKGESTNOTIORDEN.proSeleccionaOrdenesAnular.PROCREASIGOT',
                        1,
                        'El proceso de reasignacion de la orden fallo: ' ||
                        DBMS_UTILITY.format_error_backtrace,
                        null,
                        null);
  END PROCREASIGOT;
  --------------------------------------------------------------------------------

   PROCEDURE PROCINSLOGANULPAGO (INUORDEN IN or_order.order_id%TYPE,
                                ISBFLAG IN LDCI_LOGANULPAGO.LOANFLAG%TYPE,
                                ONUERRORCODE OUT NUMBER,
                                OSBERRORMSG  OUT VARCHAR2) IS
   /* -----------------------------------------------------------------------------
      Propiedad Intelectual Gases de Caribe

      Script  : PROCINSLOGANULPAGO
      caso   : 200-1586
      Autor   : Luis Javier Lopez Barrios
      Fecha   : 26-02-2018
      Descripcion : se encarga de insertar el log de los productos a suspender

      Historia de Modificaciones
      Autor                   Fecha         Descripcion

    ---------------------------------------------------------------------------------*/

    begin
       INSERT INTO LDCI_LOGANULPAGO ( LOANORDE, LOANFLAG, LOANFERE)
       VALUES (INUORDEN, ISBFLAG,  SYSDATE);

       ONUERRORCODE := 0;

    EXCEPTION
      WHEN OTHERS THEN
         ONUERRORCODE := -1;
         OSBERRORMSG := 'Error no controlado en LDCI_PKGESTNOVORDERXTT.PROCINSLOGANULPAGO '||sqlerrm;
         LDCI_pkWebServUtils.Procrearerrorlogint('LDCI_PKGESTNOVORDERXTT.PROCINSLOGANULPAGO',
                          1,
                          'El proceso de registro de Log anulacion de orden: ' ||
                          DBMS_UTILITY.format_error_backtrace ||
                          OSBERRORMSG,
                          null,
                          null);


    END PROCINSLOGANULPAGO;
End LDCI_PKGESTNOVORDERXTT;
/

PROMPT Otorgando permisos de ejecucion a LDCI_PKGESTNOVORDERXTT
BEGIN
  pkg_utilidades.prAplicarPermisos('LDCI_PKGESTNOVORDERXTT','ADM_PERSON');
END;
/


