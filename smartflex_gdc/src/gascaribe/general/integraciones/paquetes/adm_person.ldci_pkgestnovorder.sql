CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKGESTNOVORDER AS
  /*
  * Propiedad Intelectual Gases de Occidente SA ESP
  *
  * Script  : I062_PKS_03_LDCI_PKGESTNOTIORDEN.sql
  * RICEF   : I062
  * Autor   : FCastro
  * Fecha   : 18-11-2016
  * Descripcion : Paquete de integracion con los sistemas moviles
                  que selecciona las ordenes a ser anuladas
                  en los sistemas m?iles externos.

  *
  * Historia de Modificaciones
  * Autor                   Fecha         Descripcion
  * FCastro                18-11-2016    Version inicial
  */

  function fblEnvMensAnul (inutipotr ldci_ordenmoviles.task_type_id%type,
                           inuestado ldci_ordenmoviles.order_status_id%type ) return boolean;


  function fblLockOrdenMovil(isbrowid varchar2) return boolean;

  PROCEDURE proSeleccionaNovOrder;

  PROCEDURE proSeleccionaNovSistema(isbSistema in varchar2);

END LDCI_PKGESTNOVORDER;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKGESTNOVORDER AS
  /*
   * Propiedad Intelectual Gases de Occidente SA ESP
   *
   * Script  : I062_PKS_03_LDCI_PKGESTNOTIORDEN.sql
   * RICEF   : I062
   * Autor   : FCastro
   * Fecha   : 18-11-2016
   * Descripcion : Paquete de integracion con los sistemas moviles
                   que selecciona las ordenes a ser anuladas
                   en los sistemas m?iles externos.

   *
   * Historia de Modificaciones
   * Autor                   Fecha         Descripcion
   * FCastro                18-11-2016    Version inicial
   */

  -- Carga variables globales
  sbInputMsgType  LDCI_CARASEWE.CASEVALO%type;
  sbNameSpace     LDCI_CARASEWE.CASEVALO%type;
  sbUrlWS         LDCI_CARASEWE.CASEVALO%type;
  sbUrlDesti      LDCI_CARASEWE.CASEVALO%type;
  sbSoapActi      LDCI_CARASEWE.CASEVALO%type;
  sbProtocol      LDCI_CARASEWE.CASEVALO%type;
  sbHost          LDCI_CARASEWE.CASEVALO%type;
  sbPuerto        LDCI_CARASEWE.CASEVALO%type;
  sbPrefijoLDC    LDCI_CARASEWE.CASEVALO%type;
  sbDefiSewe      LDCI_DEFISEWE.DESECODI%type;

--------------------------------------------------------------------------------------
function fblEnvMensAnul (inutipotr ldci_ordenmoviles.task_type_id%type,
                         inuestado ldci_ordenmoviles.order_status_id%type ) return boolean is

 send boolean := False;
 existe varchar2(1);

 cursor cuEstValidos is
 select 'x'
  from ldci_sistmoviltipotrab sm
 where sm.task_type_id = inutipotr
   and inuestado in (select *
                             from table(ldc_boutilities.splitstrings(sm.est_per_gen_anul, '|')));

begin

open cuEstValidos;
fetch cuEstValidos into existe;
if cuEstValidos%notfound then
 send := false;
else
 send := true;
end if;
close cuEstValidos;

return (send);

exception when others then
 return (false);
end fblEnvMensAnul;

--------------------------------------------------------------------------------------
function fblLockOrdenMovil (isbrowid varchar2) return boolean is
 resource_busy   exception;
 pragma exception_init( resource_busy, -54 );
 success boolean := False;
 nuorder_id  ldci_ordenmoviles.order_id%type;

begin

for i in 1 .. 3 loop
    exit when (success);
     begin
       select order_id
         into nuorder_id
         from ldci_ordenmoviles
        where rowid=isbrowid
        for update NOWAIT;

       success := true;

     exception when resource_busy then
       dbms_lock.sleep(1);
     end;
end loop;

return (success);


exception when others then
 return (false);
end fblLockOrdenMovil;

--------------------------------------------------------------------------------

PROCEDURE proSeleccionaNovOrder As
/*
     PROPIEDAD INTELECTUAL DE GASES DEL CARIBE S.A E.S.P
     FUNCION    :
     AUTOR      : Jose Donado
     FECHA      : 17-06-2014
     RICEF      :
     DESCRIPCION: Procedimiento que selecciona las ordenes a ser anuladas
                  en los sistemas m?iles externos.

    Historia de Modificaciones
    Autor                   Fecha         Descripcion
    JOSDON                  17-06-2014    Creaci? del procedimiento
    JESUS VIVERO (LUDYCOM)  09-01-2015    #20150109: jesusv: se agrega validacion para anulacion con el estado financiero
    JESUS VIVERO (LUDYCOM)  29-01-2015    #20150129: jesusv: se corrige actualizacion de lote de anulacion
    JESUS VIVERO (LUDYCOM)  04-02-2015    #20150204: jesusv: se cambia validacion de anulacion segun estado financiero por flag que retorna API de reconexion
    JESUS VIVERO (LUDYCOM)  12-02-2015    #20150212: jesusv: Se agrega fecha de registro de la orden a anular a integraciones
    JESUS VIVERO (LUDYCOM)  02-03-2015    #20150302: jesusv: Se agrega control de tiempo entre notificacion de orden y la notificacion de su anulacion
    JESUS VIVERO (LUDYCOM)  17-03-2015    #20150317: jesusv: Se agrega control de estado de la OT en la tabla de integraciones para identificar que no sea por legalizacion del propio movil
    aacuna                  12-12-2016    #20161212  aacuna: Se modifica condicional del if linea 539, ya que tenia en cuenta la variable sw interna para hacer el commit y esta variable
                                                             solo es usada para el proceso interno de anulacion de ordenes
  */

  --Variables del Procedimiento
  nuMaxLote       NUMBER;
  nuCantAnul      NUMBER := 0;
  nuLote          NUMBER := 1;
  sbTrabSusp      LDCI_CARASEWE.CASEVALO%TYPE;
  sbTrabCart      LDCI_CARASEWE.CASEVALO%TYPE;
  nuContOTSusp    NUMBER;
  nuContOTCart    NUMBER;
  nuSW            BOOLEAN;
  nuCausal        NUMBER;
  nuCommit        number(5);

  onuSaldoPendSesu                NUMBER(13,2);
  --onuSaldoDiferidoSesu            NUMBER(13,2);
  --onuSaldoAnteriorSesu            NUMBER(13,2);
  --onuPeriodoCantSesu              NUMBER(4);

   -- Cursor para buscar los tt que se pueden anular
 CURSOR cuTTAnulables IS
  select s.sistema_id, s.task_type_id
  from ldci_sistmoviltipotrab s
 where s.permite_anulacion = 'S';

  --Cursor de ordenes pendientes o enviadas al sistema m?il
  CURSOR cuOrdenesMovil (nutipotrab Ldci_Ordenmoviles.Task_Type_Id%type) IS
    Select /*+ index(IDX_ORD_MOVIL_TASK_ID_ESTAN)*/
           rowid,
           o.Order_Id,
           o.Task_Type_Id,
           o.Order_Status_Id,
           o.Operating_Unit_Id,
           o.Estado_Envio,
           o.Lote     --#20150302: jesusv: Se agrega campo a la consulta
    From   Ldci_Ordenmoviles o
    Where  o.Estado_Envio In ('P', 'E', 'F')
    and    o.task_type_id = nutipotrab
  /*  and    order_id in (30189985)*/
    And    Estado_Envio_Anula Is Null;

  ------------------------------------------------------------------------------
  --- registro para guardar los datos
    type tyrcDataRecord is record (
        idfila             varchar2(20),
        Order_Id           Ldci_Ordenmoviles.Order_Id%type,
        Task_Type_Id       Ldci_Ordenmoviles.Task_Type_Id%type,
        Order_Status_Id    Ldci_Ordenmoviles.Order_Status_Id%type,
        Operating_Unit_Id  Ldci_Ordenmoviles.Operating_Unit_Id%type,
        Estado_Envio       Ldci_Ordenmoviles.Estado_Envio%type,
        Lote               Ldci_Ordenmoviles.Lote%type);

    type tytbDataTable is table of tyrcDataRecord index by binary_integer;
    rgOrdenMoviles  tytbDataTable;
  ------------------------------------------------------------------------------


  --Cursor para extraer datos de la orden en OSF
  CURSOR cuOrdenOSF(nuOrden or_order.order_id%type) IS
  SELECT o.order_id,o.subscriber_id,o.operating_unit_id,o.order_status_id,o.causal_id
  FROM   or_order o
  WHERE  o.order_id = nuOrden;

  --Cursor para obtener la informaci? del suscriptor y servicio de gas
  /*CURSOR cuServicio(nuSubscriberId GE_SUBSCRIBER.SUBSCRIBER_ID%TYPE,nuServGas SERVSUSC.SESUSERV%TYPE) IS
  SELECT sc.sesunuse,sc.sesususc,sc.sesuserv
  FROM   suscripc s
  INNER JOIN servsusc sc
  ON(sc.sesususc = s.susccodi)
  WHERE  s.suscclie = nuSubscriberId
         And sc.sesuserv = nuServGas;*/

  CURSOR cuOrdenActividad(nuOrden or_order.order_id%type) IS
  SELECT o.order_activity_id,o.subscriber_id,o.subscription_id,o.product_id
  FROM   or_order_activity o
  WHERE  o.order_id = nuOrden;

  --#20150317: jesusv: (INICIO) Cursor de estado de la orden en integraciones
  Cursor cuEstadoOrdenMovil(inuOrderId In Ldci_Ordenmoviles.Order_Id%Type) Is
    Select o.Estado_Envio
    From   Ldci_Ordenmoviles o
    Where  o.Order_Id = inuOrderId;
  --#20150317: jesusv: (FIN) Cursor de estado de la orden en integraciones

--   rgOrdenMoviles     cuOrdenesMovil%rowtype;
  rgOrdenOSF         cuOrdenOSF%rowtype;
  --rgServicio         cuServicio%rowtype;
  rgOrdenActividad   cuOrdenActividad%rowtype;
  rgEstadoOrdenMovil cuEstadoOrdenMovil%RowType;

  --Variables de Excepci?n
  errorGetParam  EXCEPTION;
  errorGetSaldo  EXCEPTION;
  errorLegaliza  EXCEPTION;

  Onuerrorcode   NUMBER;
  Osberrormsg    VARCHAR2(4000);

  --sbEstadoFinan  Servsusc.Sesuesfn%Type; --#20150109: jesusv: Se agrega nueva variable para el estado financiero del producto

  sbFlagReconex     Varchar2(10);  --#20150204: jesusv: Se agrega variable para flag de reconexion

  --#20150302: jesusv: (INICIO) Variables para control de tiempo en notificacion de anulaciones
  sbNotifAnulacion  Varchar2(1);
  sbValTiempoAnul   Ldci_Carasewe.Casevalo%Type;
  sbMinutosEspera   Ldci_Carasewe.Casevalo%Type;
  --#20150302: jesusv: (FIN) Variables para control de tiempo en notificacion de anulaciones

  --#20150302: jesusv: (INICIO) Se crea sub-funcion para validar tiempo de notificacion de anulacion
  Function fsbValidarOrdenNotificada(inuLote In Number, inuMinutosEspera In Number, isbErrorMsg In Out Varchar2) Return Varchar2 Is

    Cursor cuNotificacion Is
      Select l.Mesafech, l.Mesaestado
      From   Ldci_Mesaenvws l
      Where  l.Mesatamlot = inuLote;

    exExcep           Exception;
    sbValida          Varchar2(1);
    rgNotificacion    cuNotificacion%Rowtype;
    nuMinutosNotif    Number;

  Begin

    sbValida := 'N';

    Open cuNotificacion;
    Fetch cuNotificacion Into rgNotificacion;
    Close cuNotificacion;

    -- Se valida si hay registro de la notificacion
    If rgNotificacion.Mesafech Is Not Null Then

      If rgNotificacion.Mesaestado = 1 Then

        -- Se busca cuantos minutos han pasado desde la notificacion a PI
        Select Trunc((Sysdate - rgNotificacion.Mesafech) * (24 * 60))
        Into   nuMinutosNotif
        From   Dual;

        If nuMinutosNotif >= Nvl(inuMinutosEspera, 0) Then
          sbValida := 'S';
        End If;

      End If;

    End If;

    Return sbValida;

  Exception
    When Others Then
      isbErrorMsg := SqlErrM;
      Return 'E'; -- Retorna 'E' Error
  End fsbValidarOrdenNotificada;
  --#20150302: jesusv: (FIN) Se crea sub-funcion para validar tiempo de notificacion de anulacion

BEGIN

  --parametro para obtener el codigo del servicio de gas
 -- nuVar := DALD_PARAMETER.fnuGetNumeric_Value('COD_TIPO_SERV',NULL);

   --parametro para obtener el codigo del servicio de gas
    nuCommit := DALD_PARAMETER.fnuGetNumeric_Value('REG_COMMIT_ANUL_ORD_MOVILES',NULL);

  --Se obtiene el listado de tipos de trabajo de suspension
  LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_SISURE', 'OT_SUSPENSION', sbTrabSusp, Osberrormsg); -- 10058|12526|12528|12521|10169
  IF Osberrormsg != '0' THEN
     RAISE errorGetParam;
  END IF;

  --Se obtiene el listado de tipos de trabajo de gestion de cartera
  LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_SIMOCAR', 'OT_CARTERA', sbTrabCart, Osberrormsg); -- 5005
  IF Osberrormsg != '0' THEN
     RAISE errorGetParam;
  END IF;

  --Se obtiene la cantidad de registros por lote
  LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES', 'NRO_REG_LOTE', nuMaxLote, Osberrormsg);
  IF Osberrormsg != '0' THEN
     RAISE errorGetParam;
  END IF;

  --#20150302: jesusv: (INICIO) Se cargan parametros para control de tiempo de anulaciones
  -- Se obtiene parametro determinar si se debe validar tiempo entre notificacion de la orden y su anulacion
  Ldci_pkWebServUtils.proCaraServWeb(vCasedese => 'WS_SISURE',
                                     vCasecodi => 'VAL_TIEMPO_NOTIF_ANUL',
                                     vCasevalo => sbValTiempoAnul,
                                     sbMens    => osbErrorMsg);

  sbValTiempoAnul := Nvl(sbValTiempoAnul, 'N');

  -- Se busca el tope de minutos de espera entre la notificacion y anulacion
  Ldci_pkWebServUtils.proCaraServWeb(vCasedese => 'WS_SISURE',
                                     vCasecodi => 'MIN_ESPERA_NOTIF_ANUL',
                                     vCasevalo => sbMinutosEspera,
                                     sbMens    => osbErrorMsg);

  sbMinutosEspera := Nvl(sbMinutosEspera, '0');
  --#20150302: jesusv: (FIN) Se cargan parametros para control de tiempo de anulaciones

  Select Nvl(Max(o.Lote_Anula), 0) + 1 --#20150129: jesusv: se corrige actualizacion de lote de anulacion
  Into   Nulote
  From   Ldci_Ordenmoviles o;

 FOR rg in cuTTAnulables loop
 -- FOR rgOrdenMoviles IN cuOrdenesMovil LOOP
  OPEN cuOrdenesMovil(rg.task_type_id) ;
    LOOP
    FETCH cuOrdenesMovil BULK COLLECT INTO rgOrdenMoviles LIMIT nuCommit ;

    FOR i in 1 .. rgOrdenMoviles.count loop

    nuSW := FALSE;

    OPEN cuOrdenOSF(rgOrdenMoviles(I).Order_Id);
    FETCH cuOrdenOSF INTO rgOrdenOSF;
    CLOSE cuOrdenOSF;

    --Valida que el tipo de trabajo sea de suspensi?
    SELECT count(*)
    INTO nuContOTSusp
    FROM DUAL
    WHERE rgOrdenMoviles(I).Task_Type_Id IN(
             SELECT regexp_substr(sbTrabSusp,'[^|]+', 1, LEVEL) FROM dual
             CONNECT BY regexp_substr(sbTrabSusp, '[^|]+', 1, LEVEL) IS NOT NULL);

    --Valida que el tipo de trabajo sea de gestion de cartera
    SELECT count(*)
    INTO nuContOTCart
    FROM DUAL
    WHERE rgOrdenMoviles(I).Task_Type_Id IN(
             SELECT regexp_substr(sbTrabCart,'[^|]+', 1, LEVEL) FROM dual
             CONNECT BY regexp_substr(sbTrabCart, '[^|]+', 1, LEVEL) IS NOT NULL);

    IF (nuContOTSusp > 0 OR nuContOTCart > 0) THEN

      --Se procede a validar si la orden es de suspension de gestion de cartera y el usuario se encuentra con
      --saldo 0 en su producto, para notificar la anulaci? de la orden
/*      OPEN cuServicio(rgOrdenOSF.Subscriber_Id,nuVar);
      FETCH cuServicio INTO rgServicio;
      CLOSE cuServicio;*/

      OPEN cuOrdenActividad(rgOrdenMoviles(I).Order_Id);
      FETCH cuOrdenActividad INTO rgOrdenActividad;
      CLOSE cuOrdenActividad;

      --Si la actividad no contiene el dato del producto, se continua con la siguiente
      --orden ya que no se puede validar las cuentas de cobro con saldo
      IF rgOrdenActividad.Product_Id IS NULL THEN
        Osberrormsg := 'ERROR: El ID producto es nulo en la orden ' || rgOrdenMoviles(I).Order_Id || ' y actividad ' || rgOrdenActividad.Order_Activity_Id || '. ';
        LDCI_pkWebServUtils.Procrearerrorlogint('LDCI_PKGESTNOTIORDEN.proSeleccionaOrdenesAnular',1,Osberrormsg, null, null);
        CONTINUE;
      END IF;

      --Obtiene informaci? del estado de cuenta del producto
      SELECT NVL(SUM(cc.CUCOSACU),0)-  NVL(SUM(CUCOVRAP),0) SALDO
      INTO   onuSaldoPendSesu
      FROM   CUENCOBR cc WHERE CUCONUSE IN (rgOrdenActividad.Product_Id/*SELECT SV.SESUNUSE
                                          FROM SERVSUSC SV
                                          WHERE SV.SESUSUSC = rgServicio.Sesususc AND SESUSERV = rgServicio.sesuserv*/);

      --OS_PEProdSuitRconnectn(rgOrdenActividad.Product_Id,Onuerrorcode,Osberrormsg);

      sbFlagReconex := Null;
      OS_PEProdSuitRconnectn(inuProductId => rgOrdenActividad.Product_Id, --#20150204: jesusv: Se agrega API de reconexion
                             osbFlag      => sbFlagReconex,
                             onuErrorCode => onuErrorCode,
                             osbErrorMsg  => osbErrorMsg);

      If osbErrorMsg Is Not Null Then
        LDCI_pkWebServUtils.proCrearErrorLogInt('proSeleccionaOrdenesAnular', 1, 'Error En Api OS_PEProdSuitRconnectn, Orden: ' || To_Char(rgOrdenMoviles(I).Order_Id) || ' Producto: ' || To_Char(rgOrdenActividad.Product_Id) || ' Error: ' || osbErrorMsg, Null, Null);
        CONTINUE;
      End If;

      /* #20150204: jesusv: Se quita busqueda del estado financiero
      Begin --#20150109: jesusv: Se agrega bloque de consulta del estado financiero del producto
        Select s.Sesuesfn
        Into   sbEstadoFinan
        From   Open.Servsusc s
        Where  s.Sesunuse = rgOrdenActividad.Product_Id;
      Exception
        When Others Then
          Null;
      End;

      --IF onuSaldoPendSesu = 0 THEN  --#20150109: jesusv: Se comenta este condicional y se cambia por "If sbEstadoFinan In ('A','D') Then"
      If sbEstadoFinan In ('A','D') Then --#20150109: jesusv: Se agrega condicional en reemplazo de "IF onuSaldoPendSesu = 0 THEN"
      */

      If sbFlagReconex = 'S' Then --#20150204: jesusv: Se cambia condicional de validacion por flag de API de reconexion
        IF rgOrdenMoviles(I).Estado_Envio = 'P' THEN
          BEGIN
            --Logica para determinar la causal de incumplimiento al legalizar la orden
            IF nuContOTSusp > 0 THEN--Si es orden de SISURE
              nuCausal := DALD_PARAMETER.fnuGetNumeric_Value('COD_CAUSAL_LEG_PAGO_SISURE',NULL);
            ELSE-- Si es orden de SIMOCAR
              nuCausal := DALD_PARAMETER.fnuGetNumeric_Value('COD_CAUSAL_LEG_PAGO_SIMOCAR',NULL);
            END IF;

            --llamado a API que legaliza la orden de trabajo
            os_legalizeorderallactivities(inuorderid => rgOrdenMoviles(I).Order_Id,
                                          inucausalid => nuCausal,
                                          inupersonid => rgOrdenMoviles(I).Operating_Unit_Id,
                                          idtexeinitialdate => sysdate,
                                          idtexefinaldate => sysdate,
                                          isbcomment => 'Orden legalizada incumplida por pago del usuario. Legalizada desde LDCI_PKGESTNOTIORDEN.proSeleccionaOrdenesAnular',
                                          idtchangedate => null,
                                          onuerrorcode => Onuerrorcode,
                                          osberrormessage => Osberrormsg);

            IF Onuerrorcode = 0 THEN
             if fblLockOrdenMovil (rgOrdenMoviles(I).idfila) then
              UPDATE ldci_ordenmoviles o
              SET    o.Estado_Envio = 'G'
              WHERE  /*o.order_id = rgOrdenMoviles(I).Order_Id;*/ rowid = rgOrdenMoviles(I).idfila;

              nuSW := TRUE;
             end if;
            END IF;
          EXCEPTION
            WHEN errorLegaliza THEN
                 Osberrormsg := 'ERROR: <proSeleccionaOrdenesAnular>: Error legalizando la orden: ' || rgOrdenMoviles(I).Order_Id || ' incumplida. ' || Osberrormsg;
          END;
        ELSE

          --#20150302: jesusv: (INICIO) Valida si aplica o no el proceso de control de tiempo de anulacion, sino por defecto funcionara como antes
          If sbValTiempoAnul = 'S' Then
            sbNotifAnulacion := fsbValidarOrdenNotificada(inuLote          => rgOrdenMoviles(I).Lote,
                                                          inuMinutosEspera => To_Number(sbMinutosEspera),
                                                          isbErrorMsg      => osbErrorMsg);
          Else
            sbNotifAnulacion := 'S';
          End If;

          If sbNotifAnulacion In ('S','E') Then -- Se valida si se puede notificar la anulacion

            If sbNotifAnulacion = 'E' Then
              LDCI_pkWebServUtils.proCrearErrorLogInt('proSeleccionaOrdenesAnular', 1, 'Error En Subfuncion fsbValidarOrdenNotificada, Orden: ' || To_Char(rgOrdenMoviles(I).Order_Id) || ' Error: ' || osbErrorMsg, Null, Null);
            End If;
          --#20150302: jesusv: (FIN) Valida si aplica o no el proceso de control de tiempo de anulacion, sino por defecto funcionara como antes
           if fblLockOrdenMovil (rgOrdenMoviles(I).idfila) then
            UPDATE ldci_ordenmoviles o
            SET    o.lote_anula = nuLote,
                   o.estado_envio_anula = 'P',
                   o.tipo_anulacion = 1,
                   o.observacion_anula = 'La orden debe ser legalizada incumplida por pago total oportuno del usuario',
                   o.Fecha_Registro_Anula = Sysdate --#20150212: jesusv: Se registra fecha de anulacion
            WHERE  /*o.order_id = rgOrdenMoviles(I).Order_Id;*/ rowid = rgOrdenMoviles(I).idfila;

            nuSW := TRUE;
           end if;
          End If; --#20150302: jesusv: Valida si aplica o no el proceso de control de tiempo de anulacion, sino por defecto funcionara como antes

        END IF;
      END IF;

    END IF;

    --Si el estado de la orden que est?en proceso de gesti? es diferente
    --al estado de la orden en OSF quiere decir que esta orden fue gestionada
    --desde el sistema central, y se requiere notificar la anulaci? al sistema m?il
    IF (rgOrdenOSF.Order_Status_Id <> rgOrdenMoviles(I).Order_Status_Id) And (nuSW = FALSE) and
       (fblEnvMensAnul(rgOrdenMoviles(I).task_type_id, rgOrdenOSF.Order_Status_Id))  THEN

      --#20150302: jesusv: (INICIO) Valida si aplica o no el proceso de control de tiempo de anulacion, sino por defecto funcionara como antes
      If sbValTiempoAnul = 'S' Then
        sbNotifAnulacion := fsbValidarOrdenNotificada(inuLote          => rgOrdenMoviles(I).Lote,
                                                      inuMinutosEspera => To_Number(sbMinutosEspera),
                                                      isbErrorMsg      => osbErrorMsg);
      Else
        sbNotifAnulacion := 'S';
      End If;

      If sbNotifAnulacion In ('S','E') Then -- Se valida si se puede notificar la anulacion

        If sbNotifAnulacion = 'E' Then
          LDCI_pkWebServUtils.proCrearErrorLogInt('proSeleccionaOrdenesAnular', 1, 'Error En Subfuncion fsbValidarOrdenNotificada, Orden: ' || To_Char(rgOrdenMoviles(I).Order_Id) || ' Error: ' || osbErrorMsg, Null, Null);
        End If;
      --#20150302: jesusv: (FIN) Valida si aplica o no el proceso de control de tiempo de anulacion, sino por defecto funcionara como antes

        --#20150317: jesusv: (INICIO) Se verifica el estado en la tabla de integraciones para identificar si fue el movil quien la gestiono
        Open cuEstadoOrdenMovil(rgOrdenMoviles(I).Order_Id);
        Fetch cuEstadoOrdenMovil Into rgEstadoOrdenMovil;
        Close cuEstadoOrdenMovil;

        If rgEstadoOrdenMovil.Estado_Envio In ('P', 'E', 'F') Then
        --#20150317: jesusv: (FIN) Se verifica el estado en la tabla de integraciones para identificar si fue el movil quien la gestiono
         if fblLockOrdenMovil (rgOrdenMoviles(I).idfila) then
          UPDATE ldci_ordenmoviles o
          SET    o.order_status_id = rgOrdenOSF.Order_Status_Id,
                 o.lote_anula = nuLote,
                 o.estado_envio_anula = 'P',
                 o.tipo_anulacion = 0,
                 o.observacion_anula = 'La orden debe ser anulada, ya que fue gestionada desde el sistema central OSF',
                 o.Fecha_Registro_Anula = Sysdate --#20150212: jesusv: Se registra fecha de anulacion
          WHERE  /*o.order_id = rgOrdenMoviles(I).Order_Id;*/ rowid = rgOrdenMoviles(I).idfila;

          nuSW := TRUE;
         end if;
        End If; --#20150317: jesusv: --If rgEstadoOrdenMovil.Estado_Envio In ('P', 'E', 'F') Then

      End If; --#20150302: jesusv: Valida si aplica o no el proceso de control de tiempo de anulacion, sino por defecto funcionara como antes

    END IF;

    -- Se el usuario tiene orden a anular
    IF nuSW THEN

      nuCantAnul := nuCantAnul + 1;

      IF(nuCantAnul >= nuMaxLote)THEN
         nuLote := nuLote + 1;
         nuCantAnul := 0;
         --COMMIT;
      END IF;

    END IF;

  END LOOP;

  -- si el usuario tiene ordenes a anular
  -- se hace commit cada vez que procesa los registros en memoria extraidos con el bulk collect
  --IF nuSW THEN
    commit;
  --END IF;

   exit when cuOrdenesMovil%notfound;

  END LOOP;
  close cuOrdenesMovil;

 END LOOP;

 COMMIT;

EXCEPTION
  WHEN errorGetParam THEN
    --Osberrormsg := 'ERROR: <proSeleccionaOrdenesAnular>: Error obteniendo valor de par?etro: ' || Osberrormsg;
    LDCI_pkWebServUtils.Procrearerrorlogint('LDCI_PKGESTNOTIORDEN.proSeleccionaOrdenesAnular',1,'Error obteniendo valor de parametro: ' || Osberrormsg, null, null);
  WHEN errorGetSaldo THEN
    --Osberrormsg := 'ERROR: <proSeleccionaOrdenesAnular>: ' || Osberrormsg;
    LDCI_pkWebServUtils.Procrearerrorlogint('LDCI_PKGESTNOTIORDEN.proSeleccionaOrdenesAnular',1,'Error obteniendo saldo del usuario: ' || Osberrormsg, null, null);
  WHEN OTHERS THEN
    --Onuerrorcode := -1;
    --Osberrormsg := 'ERROR: <proSeleccionaOrdenesAnular>: El proceso de selecci? de ordenes a anular fall? ' || DBMS_UTILITY.format_error_backtrace;
    LDCI_pkWebServUtils.Procrearerrorlogint('LDCI_PKGESTNOTIORDEN.proSeleccionaOrdenesAnular',1,'El proceso de seleccion de ordenes a anular fallo: ' || DBMS_UTILITY.format_error_backtrace, null, null);

END proSeleccionaNovOrder;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE proSeleccionaNovSistema(isbSistema in varchar2) As
  /*---------------------------------------------------------------------------------------------------------------------------------------------------
     PROPIEDAD INTELECTUAL DE GASES DEL CARIBE S.A E.S.P
     FUNCION    :
     AUTOR      : Eduardo Ag?era
     FECHA      : 06-01-2017
     RICEF      :
     DESCRIPCION: Procedimiento que selecciona las ordenes con novedades para ser notificadas a sistemas externos.
                  Este procedimiento se basa en el LDCI_PKGESTNOTIORDEN.proSeleccionaOrdenesAnular

    Historia de Modificaciones
    Autor                   Fecha         Descripcion
    -------------------------------------------------------------------------------------------------------------------------------
    JOSDON                  17-06-2014    Creaci? del procedimiento
    JESUS VIVERO (LUDYCOM)  09-01-2015    #20150109: jesusv: se agrega validacion para anulacion con el estado financiero
    JESUS VIVERO (LUDYCOM)  29-01-2015    #20150129: jesusv: se corrige actualizacion de lote de anulacion
    JESUS VIVERO (LUDYCOM)  04-02-2015    #20150204: jesusv: se cambia validacion de anulacion segun estado financiero por flag que retorna API de reconexion
    JESUS VIVERO (LUDYCOM)  12-02-2015    #20150212: jesusv: Se agrega fecha de registro de la orden a anular a integraciones
    JESUS VIVERO (LUDYCOM)  02-03-2015    #20150302: jesusv: Se agrega control de tiempo entre notificacion de orden y la notificacion de su anulacion
    JESUS VIVERO (LUDYCOM)  17-03-2015    #20150317: jesusv: Se agrega control de estado de la OT en la tabla de integraciones para identificar que no sea por legalizacion del propio movil
    aacuna                  12-12-2016    #20161212  aacuna: Se modifica condicional del if linea 539, ya que tenia en cuenta la variable sw interna para hacer el commit y esta variable
                                                             solo es usada para el proceso interno de anulacion de ordenes
    EAGUERA                 06-01-2017    200-675 Creacion del procedimiento y correcciones para el commit y modificacion para que
                                          se ejecute por sistema.
    KBaquero               16/03/2017     200-757 Se modifica para agregarle el llamado a la comfiguraci?n de novedades
                                            por tipo de trabajo.
  ---------------------------------------------------------------------------------------------------------------------------------------------------*/

  --Variables del Procedimiento
  nuMaxLote         NUMBER;
  nuCantAnul        NUMBER := 0;
  nuLote            NUMBER := 1;
  nuCommit          number(5);

  --Cursor para buscar los tt que se pueden anular
  CURSOR cuTTAnulables IS
    select s.task_type_id
    from ldci_sistmoviltipotrab s
    where s.sistema_id = isbSistema
    and s.permite_anulacion = 'S';

  --Cursor de ordenes pendientes o enviadas al sistema m?il
  CURSOR cuOrdenesMovil (nutipotrab Ldci_Ordenmoviles.Task_Type_Id%type) IS
    Select /*+ index(IDX_ORD_MOVIL_TASK_ID_ESTAN)*/
           rowid,
           o.Order_Id,
           o.Task_Type_Id,
           o.Order_Status_Id,
           o.Operating_Unit_Id,
           o.Estado_Envio,
           o.Lote
    From   Ldci_Ordenmoviles o
    Where  o.Estado_Envio In ('P', 'E', 'F')
    and    o.task_type_id = nutipotrab
    And    Estado_Envio_Anula Is Null;

  --- registro para guardar los datos
  type tyrcDataRecord is record (
      idfila             varchar2(20),
      Order_Id           Ldci_Ordenmoviles.Order_Id%type,
      Task_Type_Id       Ldci_Ordenmoviles.Task_Type_Id%type,
      Order_Status_Id    Ldci_Ordenmoviles.Order_Status_Id%type,
      Operating_Unit_Id  Ldci_Ordenmoviles.Operating_Unit_Id%type,
      Estado_Envio       Ldci_Ordenmoviles.Estado_Envio%type,
      Lote               Ldci_Ordenmoviles.Lote%type);

  type tytbDataTable is table of tyrcDataRecord index by binary_integer;

  rgOrdenMoviles  tytbDataTable;

  --cursor para ubicar el tipo de trabajo por novedad caso 200-757
  cursor cunovextipot(inutipotrab in LDCI_NOVXTITRAB.TASK_TYPE_ID%Type) IS
    select n.novetype_id, n.proceso
      from LDCI_NOVXTITRAB l, LDCI_NOVDETA n
     where l.task_type_id = inutipotrab
       and n.novetype_id = l.novetype_id
       and n.estado = 'A'
     order by l.prioridad;

  rgnovextipot    cunovextipot%rowtype;

  --Variables de Excepci?n
  errorGetParam  EXCEPTION;
  errorGetSaldo  EXCEPTION;
  errorLegaliza  EXCEPTION;

  Onuerrorcode   NUMBER;
  Osberrormsg    VARCHAR2(4000);
  NUTIPON                NUMBER;
  SBMENSNOVE             VARCHAR2(4000);
  isbNombreProcedimiento VARCHAR2(4000);
  NURESPNOVE             NUMBER;
  sbNotifAnulacion  Varchar2(1);
  sbValTiempoAnul   Ldci_Carasewe.Casevalo%Type;
  sbMinutosEspera   Ldci_Carasewe.Casevalo%Type;

  --#20150302: jesusv: (INICIO) Se crea sub-funcion para validar tiempo de notificacion de anulacion
  Function fsbValidarOrdenNotificada(inuLote In Number, inuMinutosEspera In Number, isbErrorMsg In Out Varchar2) Return Varchar2 Is

    Cursor cuNotificacion Is
      Select l.Mesafech, l.Mesaestado
      From   Ldci_Mesaenvws l
      Where  l.Mesatamlot = inuLote;

    exExcep           Exception;
    sbValida          Varchar2(1);
    rgNotificacion    cuNotificacion%Rowtype;
    nuMinutosNotif    Number;

  Begin

    sbValida := 'N';

    Open cuNotificacion;
    Fetch cuNotificacion Into rgNotificacion;
    Close cuNotificacion;

    -- Se valida si hay registro de la notificacion
    If rgNotificacion.Mesafech Is Not Null Then

      If rgNotificacion.Mesaestado = 1 Then

        -- Se busca cuantos minutos han pasado desde la notificacion a PI
        Select Trunc((Sysdate - rgNotificacion.Mesafech) * (24 * 60))
        Into   nuMinutosNotif
        From   Dual;

        If nuMinutosNotif >= Nvl(inuMinutosEspera, 0) Then
          sbValida := 'S';
        End If;

      End If;

    End If;

    Return sbValida;

  Exception
    When Others Then
      isbErrorMsg := SqlErrM;
      Return 'E'; -- Retorna 'E' Error
  End fsbValidarOrdenNotificada;
  --#20150302: jesusv: (FIN) Se crea sub-funcion para validar tiempo de notificacion de anulacion

BEGIN

  --parametro para obtener el codigo del servicio de gas
  nuCommit := DALD_PARAMETER.fnuGetNumeric_Value('REG_COMMIT_ANUL_ORD_MOVILES',NULL);

  /* Se coloca en comentarios ya que el commit no se esta controlando por la variable nuMaxLote sino por nuCommit
  --Se obtiene la cantidad de registros por lote
  LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES', 'NRO_REG_LOTE', nuMaxLote, Osberrormsg);
  IF Osberrormsg != '0' THEN
     RAISE errorGetParam;
  END IF;*/

  -- Se obtiene parametro determinar si se debe validar tiempo entre notificacion de la orden y su anulacion #20150302
  Ldci_pkWebServUtils.proCaraServWeb(vCasedese => 'WS_SISURE',
                                     vCasecodi => 'VAL_TIEMPO_NOTIF_ANUL',
                                     vCasevalo => sbValTiempoAnul,
                                     sbMens    => osbErrorMsg);

  sbValTiempoAnul := Nvl(sbValTiempoAnul, 'N');

  -- Se busca el tope de minutos de espera entre la notificacion y anulacion
  Ldci_pkWebServUtils.proCaraServWeb(vCasedese => 'WS_SISURE',
                                     vCasecodi => 'MIN_ESPERA_NOTIF_ANUL',
                                     vCasevalo => sbMinutosEspera,
                                     sbMens    => osbErrorMsg);

  sbMinutosEspera := Nvl(sbMinutosEspera, '0');

  Select Nvl(Max(o.Lote_Anula), 0) + 1 --#20150129: jesusv: se corrige actualizacion de lote de anulacion
  Into   Nulote
  From   Ldci_Ordenmoviles o;

  --Iteramos por todos los tipos de trabajo anulables del sistema
  FOR rg in cuTTAnulables loop
    -- FOR rgOrdenMoviles IN cuOrdenesMovil LOOP
    OPEN cuOrdenesMovil(rg.task_type_id) ;
    LOOP
      FETCH cuOrdenesMovil BULK COLLECT INTO rgOrdenMoviles LIMIT nuCommit;

      nuCantAnul := 0;
      FOR i in 1 .. rgOrdenMoviles.count loop

        -- Se validan las novedades configuradas para el tipo de trabajo
        for rgnovextipot in cunovextipot(rgOrdenMoviles(I).Task_Type_Id) loop
          isbNombreProcedimiento := '  BEGIN'||chr(10)||'   '||rgnovextipot.proceso||'('||chr(10)||
                                    '     NUORDERID =>            :1,'||chr(10)||
                                    '     sbEstado_Envio =>       :2,'||chr(10)||
                                    '     nuestadootmov   =>      :3,  '||chr(10)||
                                    '     nuoperat     =>         :4,  '||chr(10)||
                                    '     sbfila =>               :5,  '||chr(10)||
                                    '     nuresp =>               :6,  '||chr(10)||
                                    '     nutiponov =>            :7,  '||chr(10)||
                                    '     sbmensnov =>            :8,  '||chr(10)||
                                    '     Onuerrorcode =>         :9,  '||chr(10)||
                                    '     Osberrormsg =>          :10);'||chr(10)||
                                    'END;';


          EXECUTE IMMEDIATE (isbNombreProcedimiento) USING IN rgOrdenMoviles(I).Order_Id,
                                                           IN rgOrdenMoviles(I).Estado_Envio ,
                                                           IN rgOrdenMoviles(I).Order_Status_Id ,
                                                           IN rgOrdenMoviles(I).Operating_Unit_Id,
                                                           IN rgOrdenMoviles(I).idfila,
                                                           OUT NURESPNOVE,
                                                           OUT nuTipoN,
                                                           OUT SBMENSNOVE,
                                                           OUT Onuerrorcode,
                                                           OUT Osberrormsg;

          --Si la orden tuvo novedad se cuenta en el total de novedades
          IF nuTipoN != -1 THEN
            --Verificamos si la novedad puede ser notificada
            If sbValTiempoAnul = 'S' Then
              sbNotifAnulacion := fsbValidarOrdenNotificada(inuLote => rgOrdenMoviles(I).Lote,
                                                            inuMinutosEspera => To_Number(sbMinutosEspera),
                                                            isbErrorMsg => osbErrorMsg);
            Else
              sbNotifAnulacion := 'S';
            End if;

            If sbNotifAnulacion In ('S', 'E') Then
              -- Se valida si se puede notificar la anulacion
              If sbNotifAnulacion = 'E' Then

                 LDCI_pkWebServUtils.proCrearErrorLogInt('LDCI_PKGESTNOVORDER.proSeleccionaNovSistema',
                                                         1,
                                                         'Error En subproceso proSeleccionaNovSistema, Orden: ' || rgOrdenMoviles(I)
                                                         .Order_Id || ' Error: ' ||
                                                          osbErrorMsg,
                                                         Null,
                                                         Null);

              End If;

              If LDCI_PKGESTNOVORDER.fblLockOrdenMovil(rgOrdenMoviles(I).idfila) then
                UPDATE ldci_ordenmoviles o
                   SET o.order_status_id      = NURESPNOVE,
                       o.lote_anula           = nuLote,
                       o.estado_envio_anula   = 'P',
                       o.tipo_anulacion       = nutipon,
                       o.observacion_anula    = SBMENSNOVE,
                       o.Fecha_Registro_Anula = Sysdate
                WHERE rowid = rgOrdenMoviles(I).idfila;

                nuCantAnul := nuCantAnul + 1;
                Exit;  -- Salimos del loop si se cumple la novedad

              END IF;
            End If;
          End If; -- Si la orden tuvo novedad
        End Loop; -- Loop: Se validan las novedades configuradas para el tipo de trabajo
      End Loop;

      If nuCantAnul > 0 then
        nuLote := nuLote + 1;
        COMMIT;
      end if;

      exit when cuOrdenesMovil%notfound;

    END LOOP;
    close cuOrdenesMovil;

  END LOOP;
  --Fin cursor de tipos de trabajo por sistema

  COMMIT;

EXCEPTION
  WHEN errorGetParam THEN
    LDCI_pkWebServUtils.Procrearerrorlogint('LDCI_PKGESTNOVORDER.proSeleccionaNovSistema',1,'Error obteniendo valor de parametro: ' || Osberrormsg, null, null);
  WHEN errorGetSaldo THEN
    LDCI_pkWebServUtils.Procrearerrorlogint('LDCI_PKGESTNOVORDER.proSeleccionaNovSistema',1,'Error obteniendo saldo del usuario: ' || Osberrormsg, null, null);
  WHEN OTHERS THEN
    LDCI_pkWebServUtils.Procrearerrorlogint('LDCI_PKGESTNOVORDER.proSeleccionaNovSistema',1,'El proceso de seleccion de ordenes a anular fallo: ' || DBMS_UTILITY.format_error_backtrace, null, null);

END proSeleccionaNovSistema;


End LDCI_PKGESTNOVORDER;
/

PROMPT Asignación de permisos para el paquete LDCI_PKGESTNOVORDER
begin
  pkg_utilidades.prAplicarPermisos('LDCI_PKGESTNOVORDER', 'ADM_PERSON');
end;
/

GRANT EXECUTE on ADM_PERSON.LDCI_PKGESTNOVORDER to INTEGRACIONES;
GRANT EXECUTE on ADM_PERSON.LDCI_PKGESTNOVORDER to INTEGRADESA;
/
