CREATE OR REPLACE PACKAGE LDCI_PKGESTNOTIORDEN AS
  /*
   * Propiedad Intelectual Gases de Occidente SA ESP
   *
   * Script  : I062_PKS_03_LDCI_PKGESTNOTIORDEN.sql
   * RICEF   : I062
   * Autor   : OLSoftware / carlos.virgen <carlos.virgen@olsoftware.com>
   * Fecha   : 14-05-2014
   * Descripcion : Paquete de integracion con los sistemas moviles

   *
   * Historia de Modificaciones
   * Autor                   Fecha         Descripcion
   * carlos.virgen           14-05-2014    Version inicial
   * JESUS VIVERO (LUDYCOM)  09-01-2015    #20150109: jesusv: se agrega validacion para anulacion con el estado financiero
   * JESUS VIVERO (LUDYCOM)  29-01-2015    #20150129: jesusv: se corrige actualizacion de lote de anulacion
   * JESUS VIVERO (LUDYCOM)  04-02-2015    #20150204: jesusv: se cambia validacion de anulacion segun estado financiero por flag que retorna API de reconexion
   * JESUS VIVERO (LUDYCOM)  12-02-2015    #20150212: jesusv: Se agregan controles de fechas a proceso de integraciones (notificaciones y anulaciones)
   * JESUS VIVERO (LUDYCOM)  02-03-2015    #20150302: jesusv: Se agrega control de tiempo entre notificacion de orden y la notificacion de su anulacion
   * JESUS VIVERO (LUDYCOM)  11-03-2015    #143406-20150311: jesusv: se corrige contador de cuentas con saldo en la seccion de cartera en la notificacion de ordenes
   * JESUS VIVERO (LUDYCOM)  17-03-2015    #20150317: jesusv: Se agrega control de estado de la OT en la tabla de integraciones para identificar que no sea por legalizacion del propio movil
   * JESUS VIVERO (LUDYCOM)  05-05-2015    #150395-20150505: jesviv: Se cambia etiqueta de XML "idProdPago" (Errada) por "idProducto" (Correcta)
   * JESUS VIVERO (LUDYCOM)  19-05-2015    #7171-20150519: jesviv: Se agregan nuevos campos al XML de notificacion de ordenes: Tipos de cartera, descripciones geograficas, estados del producto, cliclo de facturacion, ultima actividad de suspension
   * JESUS VIVERO (LUDYCOM)  11-06-2015    #7876-20150611: jesviv: Se agrega informacion de ultimo pago en XML de notificacion de Anulacion
   * Karem Baquero(sincecmop) 11/06/2015   #7298: Se modifica la generaci?n del XML de lectura ya que se cambi? la estructura.
   * Karem Baquero(sincecmop) 16/06/2015   #7298: Se modifica la generaci?n del XML para agregar el detalle de consumos.
   * Karem Baquero(sincecmop) 16/06/2015   #7298: Se crea el proceso <<proDatosConsumoHist>> para obtener los datos del consumo
   * Karem Baquero (Sincecomp)27/07/2015   #8331: Se modifica los cursores de lecturas <<fsbGET_LECTURAS>> y el cusror de consumos <<proDatosConsumoHist>> para que solo se envien los 6 ultimos
   * Karem Baquero(sincecomp) 24-07-2015   #8335 : Se modifica la forma en la que se obtiene la suscripci?n ya no se hace desde la orden, si no desde el producto.
   * Karem Baquero (Sincecomp)27/07/2015   #8335: Se le agrega una funci?n para el manejo de los caracteres Especiales en las observaciones. Teniendo en cuenta la Funci?n <<ge_boemergencyorders.fsbvalidatecharactersxml>>
   * Karem Baquero(sincecomp) 11-08-2015   # se modifica el cursor con el que se obtiene la informaci?n a enviar desde el xml, para los datos del suscriptor<<proGeneMensNotificaOT>>
   * Francisco Castro (sincecomp) 11-08-2015   #9625 se modifica proDatosConsumoHist cambiando el tipo de la variable factor_correccion de number a varchar2(10)
     Samuel Pacheco(JM)           26-05-2016   #se adicional la fecha de ultimo certificado  funcion fsbGET_SERVSUSC
   Adolfo Acuna(JM)       11/08/2016   #Se cambia la etiqueta consumo(Minuscula) por la primera letra en mayuscula (Consumo) en los procedimientos getLecturas y proErrorXML
                         #Se modifica la consulta de PR_CERTIFICATE ya que estaba consultando el campo erroneo (review_date) el campo real es register_date
                         #Se agrego procedimiento generico proNotificaOrdenesENVIO
   Adolfo Acu??a (JM)       24/08/2016   #Se modifica la consulta de PR_CERTIFICATE ya que estaba consultando el campo erroneo (register_date) el campo real es review_date
                         #Se agrega decode para caso 200-144
   FCastro              23/11/2016   Caso 200-675 Se modifica proSeleccionaOrdenesAEnviar para que envie las ordenes con los estados
                                     configuradas en LDCI_SISTMOVILTIPOTRAB
   FCastro              15/01/2017   PC_200-988 Se modifica proSeleccionaOrdenesAEnviar para que cuando el tt sea de lectura realice las validaciones que se hacian en PBPIO
                                     Adicionalmente, se modifica proGeneMensNotificaOT para incluir en el XML de las ordenes a enviar (LDCI_MESAENVWS) el codigo del periodo, a?o, mes,
                                     y el numero de digitos del medidor

   Nivis Carrasquilla    09/03/2017     Caso 200-900:    Caso de vetados
   AAcuna                02/02/2017     Caso 200-988:    Se modifica cursor de servicio suscrito, para agregar los campos de periodo de facturacio,
                                                         cantidad de medidor,a?o de facturacion y mes de facturacion.
   AAcuna                18/08/2017     Caso: 200-1435: Se agrega campo marcaRevPeriodica
   Kbaquero              06/02/2018     CA 200-1744: se modifica la consulta de persion y temperatura para que solo
                                                      se obtenga un registro por la vigencia registrada para la
                                                     de presion y temperatura <<proDatosConsumoHist>>
  JOSDON                 17/04/2020     GLPI 221: Se modifica procedimiento proGeneMensNotificaOT para permitir el env?o de todas las observaciones asociadas a la OT
  JOSDON                 14/07/2021     GLPI 747: Se modifica procedimiento proDatosConsumoHist para corregir XML con lecturas en -1 cuando exista inconsistencias en la configuracion de factores de correccion
  JPINEDC                14/05/2024     OSF-2603: Se usa pkg_Correo
  **/

  -- Variables de paquete para sistema SIGELEC
  --sbCrTransSigelec  varchar2(1) := 'S';  -- para crear transaccion en LDCI_MESAPROC cuando es SIGELEC para insertar errores en validacion de la orden
  sbFgValExcLec varchar2(1) := DALD_PARAMETER.fsbGetValue_Chain('FLAG_ACTIVA_VAL_EXC_LECT');
  sbFgValOrdLec varchar2(1) := DALD_PARAMETER.fsbGetValue_Chain('FLAG_ACTIVA_VALI_ORDEN_SIGELEC');
  --nuTransac      number      := 0;
  /*proceso que consulta los datos de consumo - cons promedio 28/05/2015 KBAQUERO*/
  Procedure proDatosConsumoHist(nuproduct       in pr_product.product_id%type,
                                inuSusccodi     IN SUSCRIPC.SUSCCODI%type,
                                inucantcos      IN number,
                                presion         out cm_vavafaco.vvfcvapr%type,
                                temperatura     out cm_vavafaco.vvfcvapr%type,
                                consumoPromedio out conssesu.cosscoca%type,
                                orfcursorcons   Out SYS_REFCURSOR);

  procedure proGeneMensNotificaOT(isbSistema      in VARCHAR2,
                                  inuTASK_TYPE_ID in NUMBER,
                                  inuTransac      in NUMBER,
                                  inuLote         in NUMBER,
                                  inuLotes        in NUMBER,
                                  onuErrorCode    out NUMBER,
                                  osbErrorMessage out VARCHAR2);

  procedure proNotificaOrdenesSIMOLEG;

  procedure proNotificaOrdenesSIFUVE;

  procedure proNotificaOrdenesSISURE;

  procedure proNotificaOrdenesSIMOCAR;

  Procedure proNotificaOrdenesLUDYENCU;

  procedure proNotificaOrdenesLUDYCRIT;

  procedure proNotificaOrdenesLUDYREVP;

  /*
  * Propiedad Intelectual Gases de Occidente S.A.   E.S.P
  *
  * Script      : LDCI_PKGESTNOTIORDEN.proNotificaOrdenesENVIO
  * Ricef       :
  * Autor       : JM / AAcuna <AAcuna>
  * Fecha       : 10-05-2016
  * Descripcion : Metodo generico para la notificacion de ordenes
  *
  * Historia de Modificaciones
  * Autor          Fecha       Descripcion
  * AAcuna         10-05-2016  Version inicial
  **/

  Procedure proNotificaOrdenesENVIO(isbSistema_Id Ldci_SistMovilTipoTrab.Sistema_Id%Type);

  procedure proNotiOrdenesAnuladas;

  procedure proNotificaExepcion(inuDocumento    in NUMBER,
                                isbAsunto       in VARCHAR2,
                                isbMesExcepcion in VARCHAR2);

  procedure proSeleccionaOrdenesAEnviar;
  /*
  caso 200-900
  Se coloca funcion en comentario por el caso de vetados ya  que se hizo una nueva funcion
  esta se va eliminar dependiendo cuandos se monte en productivo


  FUNCTION FSBREFINANCIA(INUORDER IN NUMBER) RETURN VARCHAR2;
  */

  FUNCTION fsbCalComent(inuActivi in NUMBER) RETURN VARCHAR2;
  FUNCTION fclbCalComent(inuActivi  in NUMBER) RETURN CLOB;

  FUNCTION fsbGET_SUSCRIPC(inuSUSCCODI in NUMBER, inuORDERID in NUMBER)
    RETURN VARCHAR2;

  FUNCTION fsbGET_SERVSUSC(inuSESUNUSE in NUMBER) RETURN VARCHAR2;

  /*se coloca para hacerle test*/
   PROCEDURE obtenerEstadoCuenta ( inuContrato suscripc.susCcodi%TYPE DEFAULT NULL,
                                 inuProducto  servsusc.sesunuse%TYPE DEFAULT NULL,
                                 onuSaldoPend  OUT CUENCOBR.CUCOSACU%TYPE,
                                 onuPeriodoCant  OUT NUMBER,
                                 onuSaldoAnterior OUT CUENCOBR.CUCOSACU%TYPE,
                                 onuSaldoDiferido OUT DIFERIDO.DIFESAPE%TYPE,
                                 onucodigoError OUT NUMBER,
                                 osbmensaerror OUT VARCHAR2
                                 ) ;

  FUNCTION fsbGET_CARTERA(inuSUSCCODI in NUMBER,
                          inuSESUNUSE in NUMBER,
                          inuORDERID  in NUMBER) RETURN CLOB;

  FUNCTION fsbGET_LECTURAS(inuSESUNUSE in NUMBER) RETURN CLOB;

  FUNCTION fsbGET_PREDIO(inuPRODUCT_ID in NUMBER) RETURN VARCHAR2;

  Function fsbGET_SOLICITUD(inuPackageId In Number, inuMotiveID In Number)
    Return CLOB;

  Function fsbGET_CONTACTOS(inuSubscriberID In Number,
                            inuProducID     In Number) Return CLOB;

  Function fsbGET_PAGOS(inuSubscripcion In Number,
                        inuUltimosPagos In Number) Return CLOB;

  FUNCTION fsbGET_PERILECT(inuORDERID in NUMBER) RETURN VARCHAR2;

  PROCEDURE proConceptos(inuProducID in NUMBER, onuXML out VARCHAR2);

  PROCEDURE proSeleccionaOrdenesAnular;

  procedure proActuEstaOrdenGestionada(inuOrden        in NUMBER,
                                       isbEstado       in VARCHAR2,
                                       onuErrorCode    out NUMBER,
                                       osbErrorMessage out VARCHAR2);

  procedure proActuEstaNotiOrdenMoviles(inuTASK_TYPE_ID in NUMBER,
                                        inuLOTE         in NUMBER,
                                        isbEstado       in VARCHAR2,
                                        onuErrorCode    out NUMBER,
                                        osbErrorMessage out VARCHAR2);

  ---Inicio CASO 100-10606
  /*****************************************************************
  UNIDAD       : ProErrorXML
  DESCRIPCION  : servicio para retornar la cadena XML con datos -1.

  AUTOR          : SINCECOMP
  FECHA          : 16/05/2016

  HISTORIA DE MODIFICACIONES
  FECHA             AUTOR             MODIFICACION
  =========       =========           ====================
  ******************************************************************/
  Procedure ProErrorXML(isbproceso       in varchar2,
                        isbMensajeError  in varchar2,
                        isbCadenXMLError out varchar2);
  ---Fin CASO 100-10606

  FUNCTION fclbValidateCharactersXML(iclbCadena IN CLOB) RETURN CLOB;

END LDCI_PKGESTNOTIORDEN;
/

CREATE OR REPLACE PACKAGE BODY LDCI_PKGESTNOTIORDEN AS

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

PROCEDURE proDatosConsumoHist (
   nuproduct         IN     pr_product.product_id%TYPE,
   inuSusccodi       IN     SUSCRIPC.SUSCCODI%TYPE,
   inucantcos        IN     NUMBER,
   presion              OUT cm_vavafaco.vvfcvapr%TYPE,
   temperatura          OUT cm_vavafaco.vvfcvapr%TYPE,
   consumoPromedio      OUT conssesu.cosscoca%TYPE,
   orfcursorcons        OUT SYS_REFCURSOR)
AS
 /*
    FUNCION    : LDCI_PKGESTNOTIORDEN.proDatosConsumoHist
    DESCRIPCION: proceso que consulta los datos de consumo - cons promedio

    Historia de Modificaciones
    Autor    Fecha       Descripcion
    hjmorales  27/10/2016  CA 200-732: Se modifica procedimiento para que devuelva el valor de la presi??n y la temperatura de cm_vavafaco.vvfcvalo en vez de cm_vavafaco.vvfcvapr.
              Se modifica forma para obtener el consumo promedio, se cambia para que sea consultado de hicoprpm.hcppcopr. Se elimina c??digo ya no requerido
   Kbaquero  06/02/2017 CA 200-1744: se modifica para que solo se obtenga un registro por la vigencia de la consulta
                                     de presion y temperatura
   JOSDON    14/07/2021     GLPI 747: Se modifica procedimiento para corregir XML con lecturas en -1 cuando exista inconsistencias en la configuracion de factores de correccion
   */

   sbfactpefa    NUMBER;
   sbfactcodi    NUMBER;
   blnregulado   BOOLEAN;
   nugeoloc      ge_geogra_location.geograp_location_id%TYPE;

   /*
   * CURSOR       CUPEFAFACT
   *
   * DESCRIPCION: Consulta el periodo de facturacion de una factura
   * FECHA:       10-12-2014
   * TIQUETE:     ROLLOUT
   *
   */

   CURSOR CUPEFAFACT (inuFactura NUMBER)
   IS
      SELECT FACTPEFA
        FROM FACTURA
       WHERE FACTCODI = inuFactura;
/*
  * Descripcion: Se calcula cual es el ultimo periodo de las facturas con saldo
  *              Se obtiene las facturas de ese periodo y se suman los saldos pendientes
  * fecha: 03/03/2014
  *    TQ: 3034
  */
  CURSOR cuConsultaUltFact IS
    SELECT cc.CUCOFACT
      FROM CUENCOBR cc
     WHERE cc.CUCOFACT IN
           (SELECT factu.factcodi
              FROM factura factu
             WHERE factu.factsusc = inuSusccodi
               AND (SELECT SUM(CUCOSACU)
                      FROM CUENCOBR CCBR
                     WHERE CCBR.CUCOFACT = factu.factcodi) > 0
               AND factu.FACTPEFA =
                   (SELECT MAX(factusub.FACTPEFA)
                      FROM FACTURA factusub
                     WHERE factusub.factsusc = inuSusccodi
                       AND (SELECT SUM(CUCOSACU)
                              FROM CUENCOBR CCBR
                             WHERE CUCOFACT = factusub.factcodi) > 0))
     group by cc.CUCOFACT;

BEGIN
   /*
   * Select que se encarga de
   * retornar la factura
   */
   OPEN CUCONSULTAULTFACT;

   FETCH CUCONSULTAULTFACT INTO sbfactcodi;

   CLOSE cuConsultaUltFact;

   /*
   * Calcula el periodo de facturacion
   * asociado a la factura
   */

   OPEN CUPEFAFACT (sbfactcodi);

   FETCH CUPEFAFACT INTO sbfactpefa;

   CLOSE CUPEFAFACT;

   GE_BOINSTANCECONTROL.INITINSTANCEMANAGER;
   GE_BOINSTANCECONTROL.CREATEINSTANCE ('DATA_EXTRACTOR', NULL);
   GE_BOINSTANCECONTROL.ADDATTRIBUTE ('DATA_EXTRACTOR',
                                      NULL,
                                      'FACTURA',
                                      'FACTCODI',
                                      sbfactcodi,
                                      TRUE);
   GE_BOINSTANCECONTROL.ADDATTRIBUTE ('DATA_EXTRACTOR',
                                      NULL,
                                      'FACTURA',
                                      'FACTSUSC',
                                      inuSusccodi,
                                      TRUE);
   GE_BOINSTANCECONTROL.ADDATTRIBUTE ('DATA_EXTRACTOR',
                                      NULL,
                                      'FACTURA',
                                      'FACTPEFA',
                                      sbfactpefa,
                                      TRUE);

   blnregulado := LDC_DetalleFact_GasCaribe.fblnoregulado (inuSusccodi);

   IF NOT blnregulado
   THEN
      BEGIN
    --Consulta el ??ltimo consumo promedio con el m??ximo consecutivo por producto del hist??rico
         SELECT hcppcopr
           INTO consumoPromedio
           FROM open.hicoprpm
          WHERE hcppsesu = nuproduct
                AND hcppcons = (SELECT MAX (hcppcons)
                                  FROM open.hicoprpm
                                 WHERE hcppsesu = nuproduct);
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            consumoPromedio := NULL;
      END;


      nugeoloc :=
         daab_address.fnugetgeograp_location_id (
            dapr_product.fnugetaddress_id (nuproduct, 0),
            0);

      BEGIN
         SELECT vvfcvalo
           INTO presion
           FROM open.cm_vavafaco
          WHERE     vvfcsesu = nuproduct
          --CA 200-1744 envio de lecturas en -1 -JM Gestion Infomratica
          AND TRUNC (SYSDATE) between vvfcfeiv and vvfcfefv
              --  AND vvfcfefv >= TRUNC (SYSDATE)
                AND vvfcvafc = 'PRESION_OPERACION';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            SELECT vvfcvalo
              INTO presion
              FROM open.cm_vavafaco
                        --CA 200-1744 envio de lecturas en -1 -JM Gestion Infomratica
             WHERE    TRUNC (SYSDATE) between vvfcfeiv and vvfcfefv
              /* vvfcfefv >= TRUNC (SYSDATE)*/
                   AND vvfcvafc = 'PRESION_OPERACION'
                   AND vvfcubge = nugeoloc AND VVFCSESU IS NULL; --JOSDON 747
                     WHEN OTHERS THEN
                           SELECT vvfcvalo
              INTO presion
              FROM open.cm_vavafaco
                        --CA 200-1744 envio de lecturas en -1 -JM Gestion Infomratica
             WHERE    TRUNC (SYSDATE) between vvfcfeiv and vvfcfefv
              /* vvfcfefv >= TRUNC (SYSDATE)*/
                   AND vvfcvafc = 'PRESION_OPERACION'
                   AND vvfcubge = nugeoloc
                    AND ROWNUM=1;
      END;

      BEGIN
         SELECT vvfcvalo
           INTO temperatura
           FROM open.cm_vavafaco
          WHERE     vvfcsesu = nuproduct
                    --CA 200-1744 envio de lecturas en -1 -JM Gestion Infomratica
          AND  TRUNC (SYSDATE) between vvfcfeiv and vvfcfefv--caso
                --AND vvfcfefv >= TRUNC (SYSDATE)
                AND vvfcvafc = 'TEMPERATURA';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            SELECT vvfcvalo
              INTO temperatura
              FROM open.cm_vavafaco
                        --CA 200-1744 envio de lecturas en -1 -JM Gestion Infomratica
             WHERE   TRUNC (SYSDATE) between vvfcfeiv and vvfcfefv  --vvfcfefv >= TRUNC (SYSDATE)
                   AND vvfcvafc = 'TEMPERATURA'
                   AND vvfcubge = nugeoloc AND VVFCSESU IS NULL; --JOSDON 747
                    WHEN OTHERS THEN
                        SELECT vvfcvalo
              INTO temperatura
              FROM open.cm_vavafaco
                        --CA 200-1744 envio de lecturas en -1 -JM Gestion Infomratica
             WHERE   TRUNC (SYSDATE) between vvfcfeiv and vvfcfefv  --vvfcfefv >= TRUNC (SYSDATE)
                   AND vvfcvafc = 'TEMPERATURA'
                   AND vvfcubge = nugeoloc
                    AND ROWNUM=1;
                     END;
   ELSE
      --Si es no regulado no muestra datos
      temperatura := NULL;
      presion := NULL;
      consumoPromedio := NULL;
   END IF;

   OPEN orfcursorcons FOR
      SELECT Cosscoca AS "valorConsumo",
             Cossfere AS "fechaConsumo",
             Cosstcon "tipoConsumo",
             Cosspefa AS "periFact",
             descPerifact AS "descPerifact"
        FROM (  SELECT SUM (Cosscoca) Cosscoca,
                       Cossfere,
                          Cosstcon
                       || '-'
                       || open.Pktbltipocons.Fsbgetdescription (Cosstcon)
                          Cosstcon,
                       Cosspefa,
                       open.Pktblperifact.Fsbgetdescription (Cosspefa, NULL)
                          descPerifact
                  FROM open.Conssesu c
                 WHERE     c.Cosssesu = Nuproduct
                       AND c.Cossmecc = 4
                       AND Cossfere >= ADD_MONTHS (SYSDATE, -inucantcos)
              GROUP BY Cosspefa, Cosstcon, Cossfere
              ORDER BY Cosspefa DESC)
       WHERE ROWNUM <= inucantcos;
EXCEPTION
   WHEN ex.controlled_error
   THEN
      RAISE ex.controlled_error;
   WHEN OTHERS
   THEN
      errors.seterror;
      RAISE ex.controlled_error;
END proDatosConsumoHist;


procedure proNotificaExepcion(inuDocumento     in NUMBER,
                             isbAsunto        in VARCHAR2,
                             isbMesExcepcion  in VARCHAR2) as
   /*
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     FUNCION    : LDCI_PKGESTNOTIORDEN.proNotificaExepcion
     AUTOR      : Carlos Eduardo Virgen Londono
     FECHA      : 26/01/2012
     RICEF      :
     DESCRIPCION: Notifica excepciones por correo eletronico

    Historia de Modificaciones
    Autor    Fecha       Descripcion
    carlosvl 12/08/2011  Se hace la validacion de datos.
   */

  -- define variables del sistema
  smtpConn     UTL_SMTP.connection;
  --nuUserID     SA_USER.USER_ID%TYPE;
  --nuPersonID   GE_PERSON.person_id%type;
  --sbSubnetmask SA_USER.MASK%type;
  --sbCorreo     GE_PERSON.E_MAIL%type;
  sbMensaje    VARCHAR2(30000);

  -- define cursores
  cursor cuGE_ITEMS_DOCUMENTO(inuID_ITEMS_DOCUMENTO GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO%type) is
     select doc.ID_ITEMS_DOCUMENTO, typ.DESCRIPTION, doc.OPERATING_UNIT_ID, ori.NAME ORINAME, doc.DESTINO_OPER_UNI_ID, des.NAME DESNAME, doc.USER_ID, doc.FECHA, doc.TERMINAL_ID
       from GE_ITEMS_DOCUMENTO doc,
            GE_DOCUMENT_TYPE typ,
            OR_OPERATING_UNIT ori,
            OR_OPERATING_UNIT des
      where doc.DOCUMENT_TYPE_ID = typ.DOCUMENT_TYPE_ID
        and doc.OPERATING_UNIT_ID = ori.OPERATING_UNIT_ID
        and doc.DESTINO_OPER_UNI_ID = des.OPERATING_UNIT_ID
        and ID_ITEMS_DOCUMENTO = inuID_ITEMS_DOCUMENTO;

  --cursor datos de la persona
  cursor cuGE_PERSON(inuUSER_ID GE_PERSON.USER_ID%type) is
      select *
          from GE_PERSON g
          where g.USER_ID = inuUSER_ID;

  -- tipo registro
  reGE_PERSON          cuGE_PERSON%rowtype;
  reGE_ITEMS_DOCUMENTO cuGE_ITEMS_DOCUMENTO%rowtype;

    sbRemitente     ld_parameter.value_chain%TYPE:= pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SMTP_SENDER');
  
    sbMensCorreo          VARCHAR2(4000);
  
begin
      -- abre el registro del documento con excepciones
      open cuGE_ITEMS_DOCUMENTO(inuDocumento);
      fetch cuGE_ITEMS_DOCUMENTO into reGE_ITEMS_DOCUMENTO;
      close cuGE_ITEMS_DOCUMENTO;

      --determina el usuario que esta realizando la operacion
      open cuGE_PERSON(reGE_ITEMS_DOCUMENTO.USER_ID);
      fetch cuGE_PERSON into reGE_PERSON;
      close cuGE_PERSON;

      --sbMensaje
      if (reGE_PERSON.E_MAIL is not null or reGE_PERSON.E_MAIL <> '') then

              -- genera el cuerpo del correo
              sbMensCorreo := sbMensCorreo  ||  '<html><body>';
              sbMensCorreo := sbMensCorreo  ||  '<table  border="1px" width="100%">';
              sbMensCorreo := sbMensCorreo  ||  '<tr>';
              sbMensCorreo := sbMensCorreo  ||  '<td colspan="2"><h1>' || isbAsunto || '</h1></td>';
              sbMensCorreo := sbMensCorreo  ||  '</tr>';
              sbMensCorreo := sbMensCorreo  ||  '<tr>';
              sbMensCorreo := sbMensCorreo  ||  '<td><b>Documento de solicitud</b></td>';
              sbMensCorreo := sbMensCorreo  ||  '<td>' || inuDocumento || ' - ' || reGE_ITEMS_DOCUMENTO.DESCRIPTION || '</td>';
              sbMensCorreo := sbMensCorreo  ||  '</tr>';
              sbMensCorreo := sbMensCorreo  ||  '<tr>';
              sbMensCorreo := sbMensCorreo  ||  '<td><b>Fecha</b></td>';
              sbMensCorreo := sbMensCorreo  ||  '<td>' || to_char(reGE_ITEMS_DOCUMENTO.FECHA, 'DD/MM/YYYY HH:MM:SS') || '</td>';
              sbMensCorreo := sbMensCorreo  ||  '</tr>';

              sbMensCorreo := sbMensCorreo  ||  '<td><b>Unidad Operativa Origen</b></td>';
              sbMensCorreo := sbMensCorreo  ||  '<td>' || reGE_ITEMS_DOCUMENTO.OPERATING_UNIT_ID || '-' || reGE_ITEMS_DOCUMENTO.ORINAME || '</td>';
              sbMensCorreo := sbMensCorreo  ||  '</tr>';

              sbMensCorreo := sbMensCorreo  ||  '<td><b>Unidad Operativa Destino</b></td>';
              sbMensCorreo := sbMensCorreo  ||  '<td>' || reGE_ITEMS_DOCUMENTO.DESTINO_OPER_UNI_ID || '-' || reGE_ITEMS_DOCUMENTO.DESNAME || '</td>';
              sbMensCorreo := sbMensCorreo  ||  '</tr>';

              sbMensCorreo := sbMensCorreo  ||  '<tr>';
              sbMensCorreo := sbMensCorreo  ||  '<td><b>Usuario</b></td>';
              sbMensCorreo := sbMensCorreo  ||  '<td>' || reGE_PERSON.NAME_ || '</td>';
              sbMensCorreo := sbMensCorreo  ||  '</tr>';
              sbMensCorreo := sbMensCorreo  ||  '<tr>';
              sbMensCorreo := sbMensCorreo  ||  '<td><b>Terminal</b></td>';
              sbMensCorreo := sbMensCorreo  ||  '<td>' || reGE_ITEMS_DOCUMENTO.TERMINAL_ID || '</td>';
              sbMensCorreo := sbMensCorreo  ||  '</tr>';

              sbMensCorreo := sbMensCorreo  ||  '<tr>';
              sbMensCorreo := sbMensCorreo  ||  '<td><b>Mensaje</b></td>';
              sbMensCorreo := sbMensCorreo  ||  '<td>' || isbMesExcepcion || '</td>';
              sbMensCorreo := sbMensCorreo  ||  '</tr>';

              sbMensCorreo := sbMensCorreo  ||  '</table>';
              sbMensCorreo := sbMensCorreo  ||  '</body></html>';
              
              pkg_traza.trace( 'sbMensCorreo|' || sbMensCorreo );

            pkg_Correo.prcEnviaCorreo
            (
                isbRemitente        => sbRemitente,
                isbDestinatarios    => reGE_PERSON.E_MAIL,
                isbAsunto           => isbAsunto,
                isbMensaje          => sbMensCorreo
            );

      else
            sbMensaje := 'El usuario ' || reGE_PERSON.PERSON_ID || '-' || reGE_PERSON.NAME_ ||' no tiene configurado el correo electr?ico.';

            pkg_Correo.prcEnviaCorreo
            (
                isbRemitente        => sbRemitente,
                isbDestinatarios    => sbRemitente,
                isbAsunto           => 'Usuario sin correo electrónico ('|| reGE_PERSON.NAME_ || ')',
                isbMensaje          => sbMensaje
            );

      end if;

end proNotificaExepcion;

procedure proCargaVarGlobal(isbCASECODI in LDCI_CARASEWE.CASECODI%type) as
  /*
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     Procedimiento : LDCI_PKGESTNOTIORDEN.proCargaVarGlobal
     AUTOR      : OLSoftware / Carlos E. Virgen
     FECHA      : 25/02/2012
     RICEF      : REQ007-I062
     DESCRIPCION: Limpia y carga las variables globales

    Historia de Modificaciones
    Autor   Fecha   Descripcion
  */
    onuErrorCode      ge_error_log.Error_log_id%TYPE;
    osbErrorMessage   ge_error_log.description%TYPE;
    errorPara01 EXCEPTION;       -- Excepcion que verifica que ingresen los parametros de entrada

begin
      LDCI_PKGESTNOTIORDEN.sbInputMsgType  := null;
      LDCI_PKGESTNOTIORDEN.sbNameSpace     := null;
      LDCI_PKGESTNOTIORDEN.sbUrlWS         := null;
      LDCI_PKGESTNOTIORDEN.sbUrlDesti      := null;
      LDCI_PKGESTNOTIORDEN.sbSoapActi      := null;
      LDCI_PKGESTNOTIORDEN.sbProtocol      := null;
      LDCI_PKGESTNOTIORDEN.sbHost          := null;
      LDCI_PKGESTNOTIORDEN.sbPuerto        := null;
      LDCI_PKGESTNOTIORDEN.sbPrefijoLDC    := null;
      LDCI_PKGESTNOTIORDEN.sbDefiSewe      := null;


      LDCI_PKGESTNOTIORDEN.sbDefiSewe := isbCASECODI;
      -- carga los parametos de la interfaz
      LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'INPUT_MESSAGE_TYPE', LDCI_PKGESTNOTIORDEN.sbInputMsgType, osbErrorMessage);
      if(osbErrorMessage != '0') then
           RAISE errorPara01;
      end if;--if(osbErrorMessage != '0') then

      LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'NAMESPACE', LDCI_PKGESTNOTIORDEN.sbNameSpace, osbErrorMessage);
      if(osbErrorMessage != '0') then
           RAISE errorPara01;
      end if;--if(osbErrorMessage != '0') then

      LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'WSURL', LDCI_PKGESTNOTIORDEN.sbUrlWS, osbErrorMessage);
      if(osbErrorMessage != '0') then
           RAISE errorPara01;
      end if;--if(osbErrorMessage != '0') then

      LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'SOAPACTION', LDCI_PKGESTNOTIORDEN.sbSoapActi, osbErrorMessage);
      if(osbErrorMessage != '0') then
           RAISE errorPara01;
      end if;--if(osbErrorMessage != '0') then

      LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'PROTOCOLO', LDCI_PKGESTNOTIORDEN.sbProtocol, osbErrorMessage);
      if(osbErrorMessage != '0') then
           RAISE errorPara01;
      end if;--if(osbErrorMessage != '0') then

      LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'PUERTO', LDCI_PKGESTNOTIORDEN.sbPuerto, osbErrorMessage);
      if(osbErrorMessage != '0') then
           RAISE errorPara01;
      end if;--if(osbErrorMessage != '0') then

      LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'HOST', LDCI_PKGESTNOTIORDEN.sbHost, osbErrorMessage);
      if(osbErrorMessage != '0') then
           Raise Errorpara01;
      end if;

      /*LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'PREFIJO_LDC', LDCI_PKGESTNOTIORDEN.sbPrefijoLDC, osbErrorMessage);
      if(osbErrorMessage != '0') then
           Raise Errorpara01;
      end if; */

      LDCI_PKGESTNOTIORDEN.Sburldesti := Lower(LDCI_PKGESTNOTIORDEN.Sbprotocol) || '://' || LDCI_PKGESTNOTIORDEN.Sbhost || ':' || LDCI_PKGESTNOTIORDEN.Sbpuerto || '/' || LDCI_PKGESTNOTIORDEN.Sburlws;
      LDCI_PKGESTNOTIORDEN.sbUrlDesti := trim(LDCI_PKGESTNOTIORDEN.sbUrlDesti);

exception
    When Errorpara01 then
      Errors.seterror (-1, 'ERROR: [LDCI_PKGESTNOTIORDEN.proCargaVarGlobal]: Cargando el parametro :' || osbErrorMessage);
      commit; --rollback;
    when others  then
      pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
      Errors.seterror;
      Errors.geterror (onuErrorCode, osbErrorMessage);
      commit; --rollback;
end proCargaVarGlobal;

procedure proActuEstaOrdenGestionada(inuOrden        in NUMBER,
                                     isbEstado       in VARCHAR2,
                                     onuErrorCode    out NUMBER,
                                     osbErrorMessage out VARCHAR2) as
/*
 * Propiedad Intelectual Gases de Occidente SA ESP
 *
 * Script  : LDCI_PKGESTNOTIORDEN.proActuEstaOrdenGestionada
 * Tiquete : I062
 * Autor   : OLSoftware / Carlos E. Virgen Londo?o
 * Fecha   : 17/04/2013
 * Descripcion : procedimeinto que actualiza el registro de proceso.
 * Parametros:
 IN: inuTASK_TYPE_ID: Id del tipo de trabajo
 IN: inuLOTE: Lote
 IN: isbEstado: Estado de env?: P[pendiente] E[enviado] G[Gestionada]
 OUT:onuErrorCode: C?digo de error
 OUT:osbErrorMessage: Mensaje de excepci?n

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

 -- Notficicacion de ordenes asignadas
 update LDCI_ORDENMOVILES set ESTADO_ENVIO = isbEstado
   where ORDER_ID = inuOrden;

 if (SQL%notfound)  then
    raise EXCEP_UPDATE_CHECK;
 end if;--if (SQL%notfound)  then

 commit;

exception
 when EXCEP_UPDATE_CHECK then
   rollback;
   onuErrorCode := -1;
   osbErrorMessage := '[LDCI_PKGESTNOTIORDEN.proActuEstaOrdenGestionada.EXCEP_UPDATE_CHECK]: ' || chr(13) ||
                      'No se encuentra el mensaje  ORDER_ID ' || inuOrden;
   LDCI_pkWebServUtils.Procrearerrorlogint('proActuEstaOrdenGestionada',1,osbErrorMessage, null, null);
 when others then
   rollback;
   onuErrorCode:= -1;
   osbErrorMessage:= '[LDCI_PKGESTNOTIORDEN.proActuEstaOrdenGestionada.others] Error no controlado: '|| SQLERRM || chr(13) || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
end proActuEstaOrdenGestionada;

procedure proActuEstaNotiOrdenMoviles(inuTASK_TYPE_ID  in NUMBER,
                                 inuLOTE          in NUMBER,
                                 isbEstado        in VARCHAR2,
                                 onuErrorCode    out NUMBER,
                                 osbErrorMessage out VARCHAR2) as
/*
 * Propiedad Intelectual Gases de Occidente SA ESP
 *
 * Script  : LDCI_PKGESTNOTIORDEN.proActuEstaNotiOrdenMoviles
 * Tiquete : I062
 * Autor   : OLSoftware / Carlos E. Virgen Londo?o
 * Fecha   : 17/04/2013
 * Descripcion : procedimeinto que actualiza el registro de proceso.
 * Parametros:
 IN: inuTASK_TYPE_ID: Id del tipo de trabajo
 IN: inuLOTE: Lote
 IN: isbEstado: Estado de env?: P[pendiente] E[enviado] G[Gestionada]
 OUT:onuErrorCode: C?digo de error
 OUT:osbErrorMessage: Mensaje de excepci?n

 * Historia de Modificaciones
 * Autor                   Fecha         Descripcion
 * carlosvl                17/04/2013    Creacion del paquete
 * JESUS VIVERO (LUDYCOM)  12-02-2015    #20150212: jesusv: Se agrega actualizacion de fecha de envio de orden a caja gris
**/
 PRAGMA AUTONOMOUS_TRANSACTION;
 -- excepciones
 EXCEP_UPDATE_CHECK exception; -- menejo de excepciones XML
begin
 -- inicializa mensaje de salida
 onuErrorCode := 0;

dbms_output.put_line('[proActuEstaNotiOrdenMoviles] isbEstado ' || isbEstado);
dbms_output.put_line('[proActuEstaNotiOrdenMoviles] inuTASK_TYPE_ID ' || inuTASK_TYPE_ID);
dbms_output.put_line('[proActuEstaNotiOrdenMoviles] inuLOTE ' || inuLOTE);
  -- Notficicacion de ordenes asignadas
  Update Ldci_Ordenmoviles
  Set    Estado_Envio = isbEstado,
         Fecha_Envio  = Decode(isbEstado, 'E', Sysdate, Fecha_Envio) --#20150212: jesusv: Se agrega campo fecha de envio para anulacion
  Where  Task_Type_Id = inuTask_Type_Id
  And    Lote = inuLote;

 if (SQL%notfound)  then
    raise EXCEP_UPDATE_CHECK;
 end if;--if (SQL%notfound)  then

 commit;

exception
 when EXCEP_UPDATE_CHECK then
   rollback;
   onuErrorCode := -1;
   osbErrorMessage := '[LDCI_PKGESTNOTIORDEN.proActuEstaNotiOrdenMoviles.EXCEP_UPDATE_CHECK]: ' || chr(13) ||
                      'No se encuentra el mensaje  TASK_TYPE ' || inuTASK_TYPE_ID ||' Lote ' || inuLOTE;
   LDCI_pkWebServUtils.Procrearerrorlogint('proActuEstaNotiOrdenMoviles',1,osbErrorMessage, null, null);
 when others then
   rollback;
   onuErrorCode:= -1;
   osbErrorMessage:= '[LDCI_PKGESTNOTIORDEN.proActuEstaNotiOrdenMoviles.others] Error no controlado: '|| SQLERRM || chr(13) || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
end proActuEstaNotiOrdenMoviles;

procedure proActuEstaAnulOrdenMoviles(inuTASK_TYPE_ID  in NUMBER,
                                     inuLOTE          in NUMBER,
                                     isbEstadoAnulado in VARCHAR2,
                                     onuErrorCode    out NUMBER,
                                     osbErrorMessage out VARCHAR2) as
/*
 * Propiedad Intelectual Gases de Occidente SA ESP
 *
 * Script  : LDCI_PKGESTNOTIORDEN.proActuEstaAnulOrdenMoviles
 * Tiquete : I062
 * Autor   : OLSoftware / Carlos E. Virgen Londono
 * Fecha   : 17/04/2013
 * Descripcion : procedimeinto que actualiza el registro de proceso.
 * Parametros:
 IN: inuTASK_TYPE_ID: Id del tipo de trabajo
 IN: inuLOTE: Lote
 IN: isbEstado: Estado de env?: P[pendiente] E[enviado] G[Gestionada]
 OUT:onuErrorCode: C?digo de error
 OUT:osbErrorMessage: Mensaje de excepci?n

 * Historia de Modificaciones
 * Autor                   Fecha         Descripcion
 * carlosvl                17/04/2013    Creacion del paquete
 * JESUS VIVERO (LUDYCOM)  12-02-2015    #20150212: jesusv: Se agrega actualizacion de fecha de envio de anulacion de orden a caja gris
**/
 PRAGMA AUTONOMOUS_TRANSACTION;
 -- excepciones
 EXCEP_UPDATE_CHECK exception; -- menejo de excepciones XML
begin
 -- inicializa mensaje de salida
 onuErrorCode := 0;

  -- realia la inserci?n en la tabla LDCI_ESTAPROC
  Update Ldci_Ordenmoviles
  Set    Estado_Envio_Anula = isbEstadoAnulado,
         Fecha_Envio_Anula  = Decode(isbEstadoAnulado, 'E', Sysdate, Fecha_Envio_Anula) --#20150212: jesusv: Se agrega campo fecha de envio para anulacion
  Where  Task_Type_Id = inuTask_Type_Id
  And    Lote_Anula = inuLote;

 if (SQL%notfound)  then
    raise EXCEP_UPDATE_CHECK;
 end if;--if (SQL%notfound)  then

 commit;

exception
 when EXCEP_UPDATE_CHECK then
   rollback;
   onuErrorCode := -1;
   osbErrorMessage := '[LDCI_PKGESTNOTIORDEN.proActuEstaAnulOrdenMoviles.EXCEP_UPDATE_CHECK]: ' || chr(13) ||
                      'No se encuentra el mensaje  TASK_TYPE ' || inuTASK_TYPE_ID ||' Lote ' || inuLOTE;
   LDCI_pkWebServUtils.Procrearerrorlogint('proActuEstaAnulOrdenMoviles',1,osbErrorMessage, null, null);
 when others then
   rollback;
   onuErrorCode:= -1;
   osbErrorMessage:= '[LDCI_PKGESTNOTIORDEN.proActuEstaAnulOrdenMoviles.others] Error no controlado: '|| SQLERRM || chr(13) || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
end proActuEstaAnulOrdenMoviles;

procedure proGeneMensNotificaOT(isbSistema       in  VARCHAR2,
                              inuTASK_TYPE_ID  in  NUMBER,
                              inuTransac       in  NUMBER,
                              inuLote          in  NUMBER,
                              inuLotes         in  NUMBER,
                              onuErrorCode     out NUMBER,
                              osbErrorMessage  out VARCHAR2) AS

/*
 * Propiedad Intelectual Gases de Occidente S.A.   E.S.P
 *
 * Script      : LDCI_PKGESTNOTIORDEN.proGeneMensNotificaOT
 * Ricef       : REQ009-I062
 * Autor       : OLSoftware / carlos.virgen <carlos.virgen@olsoftware.com>
 * Fecha       : 15-05-2014
 * Descripcion : Uso de DBMS_XMLGEN
 *
 * Historia de Modificaciones
 * Autor                   Fecha         Descripcion
 * carlos.virgen           15-05-2014    Version inicial
 * JESUS VIVERO (LUDYCOM)  19-05-2015    #7171-20150519: jesviv: Se agregan campos al XML de notificacion de ordenes
 *Karem Baquero(sincecomp) 24-07-2015    #8335 : Se modifica la forma en la que se obtiene la suscripci?n
 *                                       ya no se hace desde la orden, si no desde el producto.
 *Karem Baquero(sincecomp) 11-08-2015    # se modifica el cursor con el que se obtiene la informaci?n
                                         a enviar desde el xml, para los datos del suscriptor<<proGeneMensNotificaOT>>
  Jorge Valiente           16/05/2016    CASO 200-348: * Modificacion del cursor llamado RFCONSULTA.
                                                         La sentencia la cual contiene el codigo del barrio
                                                         se modificara para adicionar la descripcion del barrio.
  ljlb                     27/02/2018    caso 200 1586   se agrega funcionalidad para actualizar campo proceso_id de la tabla LDCI_ORDENMOVILES
                                                        con el codigo  de envio de mensaje de orden a movil
  JOSDON                 17/04/2020     GLPI 221: Se modifica procedimiento para que a nivel del cursor rfConsulta se permita obtener todas las observaciones asociadas a la OT
**/

   --#NC-INTERNA: Conteo de cantidad de ordenes
   -- conteo de ordenes por lote
   cursor cuContordenes(nuLote NUMBER, nuTASK_TYPE_ID NUMBER) is
     SELECT COUNT(ORDE.ORDER_ID) ORDENES
      FROM LDCI_ORDENMOVILES ORDE
     WHERE ORDE.LOTE = nuLote
       and ORDE.TASK_TYPE_ID = nuTASK_TYPE_ID
       AND ORDE.ESTADO_ENVIO = 'P'
       and ORDE.ESTADO_ENVIO_ANULA is null;

   -- conteo de actividades por lote
   cursor cuContAvtividades(nuLote NUMBER, nuTASK_TYPE_ID NUMBER) is
    SELECT COUNT(ACTI.ACTIVITY_ID) ACTIVIDADES
     FROM LDCI_ORDENMOVILES ORDE, OR_ORDER_ACTIVITY ACTI
    WHERE ORDE.ORDER_ID = ACTI.ORDER_ID
      AND ORDE.TASK_TYPE_ID = nuTASK_TYPE_ID
      AND ACTI.TASK_TYPE_ID = nuTASK_TYPE_ID
      AND ORDE.LOTE = nuLote
      AND ORDE.ESTADO_ENVIO = 'P'
      AND ORDE.ESTADO_ENVIO_ANULA is null;

   -- cursor de la configuracion de sistema movil por tipo de trabajo
   cursor cuLDCI_SISTMOVILTIPOTRAB (isbSISTEMA_ID LDCI_SISTMOVILTIPOTRAB.SISTEMA_ID%type,
                                   inuTASK_TYPE_ID LDCI_SISTMOVILTIPOTRAB.TASK_TYPE_ID%type)  is
    select SISTEMA_ID,TASK_TYPE_ID,
           OP_UNITS,
           REQUIERE_INFO_SUSC,
           REQUIERE_INFO_SESU,
           REQUIERE_INFO_CART,
           REQUIERE_INFO_PRED,
           REQUIERE_INFO_LECT,
           REQUIERE_INFO_CTAC
    from   LDCI_SISTMOVILTIPOTRAB
    where  SISTEMA_ID = isbSISTEMA_ID
    and    TASK_TYPE_ID = inuTASK_TYPE_ID;

   rfConsulta Constants.tyRefCursor;
   --TICKET 2001586 LJLB-- se consultas ordenes procesadas
    CURSOR cuOrdenesProcesa(nuLote NUMBER, nuTASK_TYPE_ID NUMBER) IS
    SELECT ORDE.ORDER_ID ORDENES
    FROM LDCI_ORDENMOVILES ORDE
    WHERE ORDE.LOTE = nuLote
     AND ORDE.TASK_TYPE_ID = nuTASK_TYPE_ID
     AND ORDE.ESTADO_ENVIO = 'P'
     AND ORDE.ESTADO_ENVIO_ANULA is null;

   TYPE tb_ordenesproce IS TABLE OF LDCI_ORDENMOVILES.ORDER_ID%TYPE  ; --TICKET 2001586 LJLB-- Se crea tabla del cursor cuOrdenesProcesa
   vtb_ordenesproce tb_ordenesproce;  --TICKET 2001586 LJLB-- Se crea variable de tipo table
   nulimit_in  NUMBER := 500;  --TICKET 2001586 LJLB-- cantidad de registro a procesar

   nuCantOrds         NUMBER := 0;
   nuCantActs         NUMBER := 0;
   nuMesacodi         LDCI_MESAENVWS.MESACODI%TYPE;
   L_Payload          CLOB;
   sbXmlTransac       VARCHAR2(500);
   sbESTADO_ENVIO LDCI_ORDENMOVILES.ESTADO_ENVIO%type := 'P';
   qryCtx             DBMS_XMLGEN.ctxHandle;
   reLDCI_SISTMOVILTIPOTRAB cuLDCI_SISTMOVILTIPOTRAB%rowtype;
   errorPara01        EXCEPTION;       -- Excepcion que verifica que ingresen los parametros de entrada
   Excepnoprocesoregi EXCEPTION;  -- Excepcion que valida si proceso registros la consulta
   excepNoProcesoSOAP EXCEPTION;  -- Excepcion que valida si proceso peticion SOAP
begin
    proCargaVarGlobal(isbSistema);

    --Carga la configuracion para el tipo de trabajo
    open cuLDCI_SISTMOVILTIPOTRAB(isbSistema, inuTASK_TYPE_ID);
    fetch cuLDCI_SISTMOVILTIPOTRAB into reLDCI_SISTMOVILTIPOTRAB;
    close cuLDCI_SISTMOVILTIPOTRAB;
    --#NC-INTERNA: Conteo de cantidad de ordenes
    open  cuContordenes(inuLote, inuTASK_TYPE_ID);
    fetch cuContordenes into nuCantOrds;
    close cuContordenes;
    open  cuContAvtividades(inuLote, inuTASK_TYPE_ID);
    fetch cuContAvtividades into nuCantActs ;
    close cuContAvtividades;
    dbms_output.put_line('[proGeneMensNotificaOT] ini 406');

    open rfConsulta for
       select ORDE.ORDER_ID as "idOrden",
              ORDE.TASK_TYPE_ID as "idTipoTrab",
              ORDE.ORDER_STATUS_ID  as "idEstado",
              ORDE.ADDRESS_ID as "idDireccion",
              ORDE.ADDRESS as "direccion",
              ORDE.GEOGRA_LOCATION_ID as "idLocalidad",
              (Select d.Description From Ge_Geogra_Location d Where d.Geograp_Location_Id = Orde.Geogra_Location_Id) As "descLocalidad", --#7171-20150519: jesviv: Se agrega descripcion de localidad
              ORDE.NEIGHBORTHOOD as "idBarrio",
              --Inicio CASO 200-348
              open.dage_geogra_location.fsbgetdescription(ORDE.NEIGHBORTHOOD,null) "descBarrio",
              --Fin CASO 200-348
              ORDE.OPER_SECTOR_ID as "idSectorOper",
              (Select d.Description From Or_Operating_Sector d Where d.Operating_Sector_Id = Orde.Oper_Sector_Id) As "descSectorOper", --#7171-20150519: jesviv: Se agrega descripcion del sector operativo
              ORDE.ROUTE_ID as "idRuta",
              ORDE.CONSECUTIVE as "consPredio",
              ORDE.PRIORITY as "prioridad",
              to_char(ORDE.ASSIGNED_DATE, 'YYYY-MM-DD HH24:MI:SS') as "fechaAsig",
              to_char(ORDE.ARRANGE_HOUR, 'YYYY-MM-DD HH24:MI:SS') as "fechaCompromiso",
              to_char(ORDE.CREATED_DATE, 'YYYY-MM-DD HH24:MI:SS') as "fechaCreacion",
              to_char(ORDE.EXEC_ESTIMATE_DATE, 'YYYY-MM-DD HH24:MI:SS') as "fechaPlanEjec",
              to_char(ORDE.MAX_DATE_TO_LEGALIZE, 'YYYY-MM-DD HH24:MI:SS') as "fechaMaxLeg",
              ORDE.OPERATING_UNIT_ID as "idUnidadOper",
              cursor
              (
                select ORDER_ACTIVITY_ID as "idOrdenActividad",
                      ORDER_ITEM_ID as "idItem",
                      ORDER_ID as "idOrdenTrabajo",
                      STATUS as "idEstadoActividad",
                      TASK_TYPE_ID as "idTipoTrabAct",
                      --PACKAGE_ID ,
                      --MOTIVE_ID,
                      --COMPONENT_ID,
                      --INSTANCE_ID,
                      ADDRESS_ID as "idDireccion",
                      --ELEMENT_ID,
                      ----8335 - 8490 : Karbaq 12/08/2015 Se cambia para obtener el cliente del contrato si este viene en blaco
                      decode(SUBSCRIBER_ID,null,decode(open.dapr_product.fnugetsubscription_id(PRODUCT_ID,null), null,null,open.pktblsuscripc.fnugetsuscclie(open.dapr_product.fnugetsubscription_id(PRODUCT_ID,null))),SUBSCRIBER_ID) as "idCliente",
                     --SUBSCRIBER_ID as "idCliente",
                      --SUBSCRIPTION_ID as "idContrato",
                      ----8335 - 8490 : Karbaq 12/08/2015 --Se cambia para obtener el contrato del producto, si el
                      decode(SUBSCRIPTION_ID,null,dapr_product.fnugetsubscription_id(PRODUCT_ID, null),SUBSCRIPTION_ID) as "idContrato",
                      --dapr_product.fnugetsubscription_id(PRODUCT_ID) as "idContrato",
                      PRODUCT_ID as "idProducto",
                      ------8335 - 8490 : Karbaq 12/08/2015 Se cambia para obtener el contrato del producto
                      (Select s.Susccicl From Suscripc s Where s.Susccodi =  decode(SUBSCRIPTION_ID,null,dapr_product.fnugetsubscription_id(PRODUCT_ID, null),SUBSCRIPTION_ID)/*Acti.Subscription_Id*/) As "idCicloFacturacion", --#7171-20150519: jesviv: Se agrega ciclo de facturacion
                      OPERATING_SECTOR_ID as "idSectorOperativo",
                      EXEC_ESTIMATE_DATE as "fechaEstimada",
                      OPERATING_UNIT_ID AS "idUnidadOperativa",
                      fclbCalComent(ORDER_ACTIVITY_ID) as "observaciones",--glpi 221
                      --PROCESS_ID,
                      ACTIVITY_ID as "idActividad",
                      --ORIGIN_ACTIVITY_ID,
                      --ACTIVITY_GROUP_ID,
                      --SEQUENCE_,
                      REGISTER_DATE as "fechaRegistro",
                      --FINAL_DATE,
                      --VALUE1,
                      --VALUE2,
                      --VALUE3,
                      --VALUE4,
                      --COMPENSATED,
                      --ORDER_TEMPLATE_ID,
                      nvl(CONSECUTIVE,0) as "consecutivo",
                      --SERIAL_ITEMS_ID,
                      LEGALIZE_TRY_TIMES as "nroIntentos",
                      --WF_TAG_NAME,
                      --VALUE_REFERENCE,
                      --ACTION_ID,
                      CASE CONF.REQUIERE_INFO_SUSC
                        ----8335 - 8490 : Karbaq 12/08/2015 Se cambia la fomra de obtener suscriptor
                        WHEN 'S' THEN LDCI_PKGESTNOTIORDEN.fsbGET_SUSCRIPC(decode(SUBSCRIPTION_ID,null,dapr_product.fnugetsubscription_id(PRODUCT_ID, null),SUBSCRIPTION_ID)/*ACTI.SUBSCRIPTION_ID*/, ACTI.ORDER_ID)
                        WHEN 'N' THEN NULL
                      END as "Contratos",
                      CASE CONF.REQUIERE_INFO_SESU
                       WHEN 'S' THEN LDCI_PKGESTNOTIORDEN.fsbGET_SERVSUSC(ACTI.PRODUCT_ID)
                       WHEN 'N' THEN NULL
                      END as "Servicios",
                      CASE CONF.REQUIERE_INFO_CART
                        ----8335 - 8490 : Karbaq 12/08/2015 Se cambia la fomra de obtener suscriptor
                       WHEN 'S' THEN LDCI_PKGESTNOTIORDEN.fsbGET_CARTERA(decode(SUBSCRIPTION_ID,null,dapr_product.fnugetsubscription_id(PRODUCT_ID, null),SUBSCRIPTION_ID)/*ACTI.SUBSCRIPTION_ID*/,ACTI.PRODUCT_ID, ACTI.ORDER_ID)
                       WHEN 'N' THEN NULL
                      END as "Carteras",
                      CASE CONF.REQUIERE_INFO_PRED
                       WHEN 'S' THEN LDCI_PKGESTNOTIORDEN.fsbGET_PREDIO(ACTI.PRODUCT_ID)
                       WHEN 'N' THEN NULL
                      END as "Predios",
                      CASE CONF.REQUIERE_INFO_LECT
                       WHEN 'S' THEN LDCI_PKGESTNOTIORDEN.fsbGET_LECTURAS(ACTI.PRODUCT_ID)
                       WHEN 'N' THEN NULL
                      END as "Lecturas",
                       CASE CONF.REQUIERE_INFO_SOLI
                       WHEN 'S' THEN LDCI_PKGESTNOTIORDEN.fsbGET_SOLICITUD(ACTI.PACKAGE_ID, ACTI.MOTIVE_ID)
                       WHEN 'N' THEN NULL
                      END as "Solicitudes",
                      CASE CONF.REQUIERE_INFO_CTAC
                        ----8335 - 8490 : Karbaq 12/08/2015 Se cambia la fomra de obtener cliente
                        WHEN 'S' THEN LDCI_PKGESTNOTIORDEN.fsbGET_CONTACTOS(decode(SUBSCRIBER_ID,null,pktblsuscripc.fnugetsuscclie(dapr_product.fnugetsubscription_id(PRODUCT_ID)),SUBSCRIBER_ID)/*ACTI.SUBSCRIBER_ID*/, ACTI.PRODUCT_ID)
                        WHEN 'N' THEN NULL
                      END as "Contactos"
                 from OR_ORDER_ACTIVITY ACTI
                where ACTI.ORDER_ID = ORDE.ORDER_ID
                  and ACTI.TASK_TYPE_ID = ORDE.TASK_TYPE_ID
              ) as "Actividades"
        from LDCI_ORDENMOVILES ORDE, LDCI_SISTMOVILTIPOTRAB CONF
       where ORDE.TASK_TYPE_ID = inuTASK_TYPE_ID
         and ORDE.LOTE = inuLote
         and ORDE.ESTADO_ENVIO = sbESTADO_ENVIO
         and CONF.SISTEMA_ID  = isbSistema
         and CONF.TASK_TYPE_ID = ORDE.TASK_TYPE_ID
         and ORDE.ESTADO_ENVIO_ANULA is null;
    -- Genera el mensaje XML
    Qryctx :=  Dbms_Xmlgen.Newcontext (rfConsulta);

    -- Asigna el valor de la variable
    --DBMS_XMLGEN.setBindvalue (qryCtx, 'inuLote', inuLote);
    --DBMS_XMLGEN.setBindvalue (qryCtx, 'inuTASK_TYPE_ID', inuTASK_TYPE_ID);
    --DBMS_XMLGEN.setBindvalue (qryCtx, 'isbESTADO_ENVIO', sbESTADO_ENVIO);
    --DBMS_XMLGEN.setBindvalue (qryCtx, 'isbSistema', isbSistema);

      --Dbms_Xmlgen.Setrowsettag(Qryctx, 'urn:NotificarOrdenesLectura');
    --DBMS_XMLGEN.setRowTag(qryCtx, '');
    Dbms_Xmlgen.setNullHandling(qryCtx, 2);
    dbms_xmlgen.setConvertSpecialChars(qryCtx, false);
    l_payload := dbms_xmlgen.getXML(qryCtx);

    --Valida si proceso registros
    if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then
         RAISE excepNoProcesoRegi;
    end if;--if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then

    dbms_xmlgen.closeContext(qryCtx);
    dbms_output.put_line('[proGeneMensNotificaOT] ini 520');
    L_Payload := Replace(L_Payload, '<?xml version="1.0"?>');
    L_Payload := Replace(L_Payload, '<ROWSET',  '<Ordenes');
    L_Payload := Replace(L_Payload, '</ROWSET>',  '</Ordenes>');
    L_Payload := Replace(L_Payload, '<ROW>',  '<Orden>');
    L_Payload := Replace(L_Payload, '</ROW>',  '</Orden>');
    L_Payload := Replace(L_Payload, '<ACTIVIDADES>',  '<Actividades>');
    L_Payload := Replace(L_Payload, '</ACTIVIDADES>',  '</Actividades>');
    L_Payload := Replace(L_Payload, '<Actividades_ROW>',  '<Actividad>');
    L_Payload := Replace(L_Payload, '</Actividades_ROW>',  '</Actividad>');

    sbXmlTransac := '<sistema>' || isbSistema || '</sistema>
                       <transaccion>
                       <proceso>' || inuTransac ||'</proceso>
                       <lote>' || inuLote || '</lote>
                       <cantidadLotes>' || inuLotes || '</cantidadLotes>
                       <cantOrdenes>' || nuCantOrds || '</cantOrdenes>
                       <cantActividades>' || nuCantActs || '</cantActividades>
                    </transaccion>';

    L_Payload := '<' || LDCI_PKGESTNOTIORDEN.sbInputMsgType || '>' || sbXmlTransac || L_Payload || '</' || LDCI_PKGESTNOTIORDEN.sbInputMsgType || '>';
    L_Payload := Trim(L_Payload);
    --dbms_output.put_line('[proGeneMensNotificaOT 594 L_Payload ]' || chr(13) || L_Payload);

       -- Genera el mensaje de envio para la caja gris
    LDCI_PKMESAWS.proCreaMensEnvio(CURRENT_DATE,
                                   isbSistema,  -- Sistema configurado en LDCI_CARASEWE
                                   -1,
                                   inuTransac,
                                   null,
                                   L_Payload,
                                   inuLote,
                                   inuLotes,
                                   nuMesacodi,
                                   onuErrorCode,
                                   osbErrorMessage);

  IF NVL(onuErrorCode,0) <> -1 THEN

      OPEN cuOrdenesProcesa(inuLote, inuTASK_TYPE_ID);
      LOOP
        FETCH cuOrdenesProcesa BULK COLLECT INTO vtb_ordenesproce LIMIT nulimit_in;

          BEGIN
              FORALL i IN 1..vtb_ordenesproce.COUNT SAVE EXCEPTIONS -- save exceptions evita, que se detenga, cpaturando la excepcion
                 UPDATE  LDCI_ORDENMOVILES
                       SET PROCESO_ID = nuMesacodi
                 WHERE ORDER_ID = vtb_ordenesproce(i);
          EXCEPTION
             WHEN others THEN
               null;
          END;
      EXIT WHEN cuOrdenesProcesa%NOTFOUND;
      END LOOP;
      CLOSE cuOrdenesProcesa;
      COMMIT;
  END IF;


dbms_output.put_line('[626.proGeneMensNotificaOT 594 onuErrorCode ]' || onuErrorCode);

exception
  when excepNoProcesoRegi then
        onuErrorCode := -1;
        osbErrorMessage := '[LDCI_PKGESTNOTIORDEN.proGeneMensNotificaOT.excepNoProcesoRegi]: La consulta no ha arrojo registros.';
dbms_output.put_line('[proGeneMensNotificaOT.excepNoProcesoRegi] osbErrorMessage ' || osbErrorMessage);
   when others then
        onuErrorCode := -1;
        osbErrorMessage := '[LDCI_PKGESTNOTIORDEN.proGeneMensNotificaOT.others]:' || SQLERRM;
dbms_output.put_line('[proGeneMensNotificaOT.others] osbErrorMessage ' || osbErrorMessage);
dbms_output.put_line('[proGeneMensNotificaOT.others] format_error_backtrace ' || DBMS_UTILITY.format_error_backtrace);

end proGeneMensNotificaOT;

procedure proGeneMensAnulacionOT(isbSistema       in  VARCHAR2,
                                inuTASK_TYPE_ID  in  NUMBER,
                                inuTransac       in  NUMBER,
                                inuLote          in  NUMBER,
                                inuLotes         in  NUMBER,
                                onuErrorCode     out NUMBER,
                                osbErrorMessage  out VARCHAR2) AS

/*
 * Propiedad Intelectual Gases de Occidente S.A.   E.S.P
 *
 * Script      : LDCI_PKGESTNOTIORDEN.proGeneMensAnulacionOT
 * Ricef       : REQ009-I062
 * Autor       : OLSoftware / carlos.virgen <carlos.virgen@olsoftware.com>
 * Fecha       : 15-05-2014
 * Descripcion : Uso de DBMS_XMLGEN
 *
 * Historia de Modificaciones
 * Autor                   Fecha       Descripcion
 * carlos.virgen           15-05-2014  Version inicial
 * JESUS VIVERO (LUDYCOM)  11-06-2015  #7876-20150611: jesviv: Se agrega informacion de ultimo pago en XML de notificacion de Anulacion
 * Karem Baquero (Sincecomp)27/07/2015 #8335: Se le agrega una funci?n para el manejo de los caracteres
 *                                     Especiales en las observaciones. Teniendo en cuenta la Funci?n
 *                                     <<ge_boemergencyorders.fsbvalidatecharactersxml>>
 *Karem Baquero (Sincecomp)27/07/2015 #8133 se modifica el cursor
 */

   --#NC-INTERNA: Conteo de cantidad de ordenes
   -- conteo de ordenes por lote
   cursor cuContordenes(nuLote NUMBER, nuTASK_TYPE_ID NUMBER) is
     SELECT COUNT(ORDE.ORDER_ID) ORDENES
      FROM LDCI_ORDENMOVILES ORDE
     WHERE ORDE.LOTE_ANULA = nuLote
       and ORDE.TASK_TYPE_ID = nuTASK_TYPE_ID
       AND ORDE.ESTADO_ENVIO_ANULA = 'P';

   -- conteo de actividades por lote
   cursor cuContAvtividades(nuLote NUMBER, nuTASK_TYPE_ID NUMBER) is
    SELECT COUNT(ACTI.ACTIVITY_ID) ACTIVIDADES
     FROM LDCI_ORDENMOVILES ORDE, OR_ORDER_ACTIVITY ACTI
    WHERE ORDE.ORDER_ID = ACTI.ORDER_ID
      AND ORDE.TASK_TYPE_ID = nuTASK_TYPE_ID
      AND ACTI.TASK_TYPE_ID = nuTASK_TYPE_ID
      AND ORDE.LOTE_ANULA = nuLote
      AND ORDE.ESTADO_ENVIO_ANULA = 'P';

   -- cursor de la configuracion de sistema movil por tipo de trabajo
   cursor cuLDCI_SISTMOVILTIPOTRAB (isbSISTEMA_ID LDCI_SISTMOVILTIPOTRAB.SISTEMA_ID%type,
                                   inuTASK_TYPE_ID LDCI_SISTMOVILTIPOTRAB.TASK_TYPE_ID%type)  is
    select SISTEMA_ID,TASK_TYPE_ID, OP_UNITS, REQUIERE_INFO_SUSC, REQUIERE_INFO_SESU,
          REQUIERE_INFO_CART, REQUIERE_INFO_PRED, REQUIERE_INFO_LECT
      from LDCI_SISTMOVILTIPOTRAB
     where SISTEMA_ID = isbSISTEMA_ID
       and TASK_TYPE_ID = inuTASK_TYPE_ID;

   nuCantOrds         NUMBER := 0;
   nuCantActs         NUMBER := 0;
   nuMesacodi         LDCI_MESAENVWS.MESACODI%TYPE;
   L_Payload          CLOB;
   sbXmlTransac       VARCHAR2(500);
   sbESTADO_ENVIO LDCI_ORDENMOVILES.ESTADO_ENVIO_ANULA%type := 'P';
   qryCtx             DBMS_XMLGEN.ctxHandle;
   reLDCI_SISTMOVILTIPOTRAB cuLDCI_SISTMOVILTIPOTRAB%rowtype;
   errorPara01        EXCEPTION;       -- Excepcion que verifica que ingresen los parametros de entrada
   Excepnoprocesoregi EXCEPTION;  -- Excepcion que valida si proceso registros la consulta
   excepNoProcesoSOAP EXCEPTION;  -- Excepcion que valida si proceso peticion SOAP

   nuCantUltPagos     Number; --#7876-20150611: jesviv: registra la cantidad de ultimos pagos a mostrar

begin

    proCargaVarGlobal(isbSistema);

    --Carga la configuracion para el tipo de trabajo
    open cuLDCI_SISTMOVILTIPOTRAB(isbSistema, inuTASK_TYPE_ID);
    fetch cuLDCI_SISTMOVILTIPOTRAB into reLDCI_SISTMOVILTIPOTRAB;
    close cuLDCI_SISTMOVILTIPOTRAB;

    --#NC-INTERNA: Conteo de cantidad de ordenes
    open  cuContordenes(inuLote, inuTASK_TYPE_ID);
    fetch cuContordenes into nuCantOrds;
    close cuContordenes;

    open  cuContAvtividades(inuLote, inuTASK_TYPE_ID);
    fetch cuContAvtividades into nuCantActs ;
    close cuContAvtividades;

    nuCantUltPagos := Dald_Parameter.fnuGetNumeric_Value('CANT_ULT_PAGOS_NOTIF_ANUL_ORD', Null); --#7876-20150611: jesviv: buscar la cantidad de ultimos pagos a mostrar

    -- Genera el mensaje XML
    Qryctx :=  Dbms_Xmlgen.Newcontext ('select ORDE.ORDER_ID as "idOrden",
                                              ORDE.TASK_TYPE_ID as "idTipoTrab",
                                              ORDE.ORDER_STATUS_ID  as "idEstado",
                                              ORDE.ADDRESS_ID as "idDireccion",
                                              ORDE.ADDRESS as "direccion",
                                              ORDE.GEOGRA_LOCATION_ID as "idLocalidad",
                                              ORDE.NEIGHBORTHOOD as "idBarrio",
                                              ORDE.OPER_SECTOR_ID as "idSectorOper",
                                              ORDE.ROUTE_ID as "idRuta",
                                              ORDE.CONSECUTIVE as "consPredio",
                                              ORDE.PRIORITY as "prioridad",
                                              to_char(ORDE.ASSIGNED_DATE, ''YYYY-MM-DD HH24:MI:SS'') as "fechaAsig",
                                              to_char(ORDE.ARRANGE_HOUR, ''YYYY-MM-DD HH24:MI:SS'') as "fechaCompromiso",
                                              to_char(ORDE.CREATED_DATE, ''YYYY-MM-DD HH24:MI:SS'') as "fechaCreacion",
                                              to_char(ORDE.EXEC_ESTIMATE_DATE, ''YYYY-MM-DD HH24:MI:SS'') as "fechaPlanEjec",
                                              to_char(ORDE.MAX_DATE_TO_LEGALIZE, ''YYYY-MM-DD HH24:MI:SS'') as "fechaMaxLeg",
                                              ORDE.OPERATING_UNIT_ID as "idUnidadOper",
                                              cursor
                                              (
                                                select ORDER_ACTIVITY_ID as "idOrdenActividad",
                                                      ORDER_ITEM_ID as "idItem",
                                                      ORDER_ID as "idOrdenTrabajo",
                                                      STATUS as "idEstadoActividad",
                                                      TASK_TYPE_ID as "idTipoTrabAct",
                                                      --PACKAGE_ID ,
                                                      --MOTIVE_ID,
                                                      --COMPONENT_ID,
                                                      --INSTANCE_ID,
                                                      ADDRESS_ID as "idDireccion",
                                                      --ELEMENT_ID,
                                                      SUBSCRIBER_ID as "idCliente",
                                                      SUBSCRIPTION_ID as "idContrato",
                                                      PRODUCT_ID as "idProducto",
                                                      OPERATING_SECTOR_ID as "idSectorOperativo",
                                                      EXEC_ESTIMATE_DATE as "fechaEstimada",
                                                      OPERATING_UNIT_ID as "idUnidadOperativa",
                                                      ge_boemergencyorders.fsbvalidatecharactersxml(COMMENT_) as "observaciones",    --#8335: KarBaq: Se agregael llamado ala funci?n de caracteres especiales
                                                      --COMMENT_ as "observaciones",
                                                      --PROCESS_ID,
                                                      ACTIVITY_ID as "idActividad",
                                                      --ORIGIN_ACTIVITY_ID,
                                                      --ACTIVITY_GROUP_ID,
                                                      --SEQUENCE_,
                                                      REGISTER_DATE as "fechaRegistro",
                                                      --FINAL_DATE,
                                                      --VALUE1,
                                                      --VALUE2,
                                                      --VALUE3,
                                                      --VALUE4,
                                                      --COMPENSATED,
                                                      --ORDER_TEMPLATE_ID,
                                                      CONSECUTIVE as "consecutivo",
                                                      --SERIAL_ITEMS_ID,
                                                      LEGALIZE_TRY_TIMES as "nroIntentos",
                                                      LDCI_PKGESTNOTIORDEN.fsbGET_PAGOS(decode(SUBSCRIPTION_ID,null,dapr_product.fnugetsubscription_id(PRODUCT_ID),SUBSCRIPTION_ID), :nuCantUltPagos) As "Pagos"
                                                 from OR_ORDER_ACTIVITY ACTI
                                                where ACTI.ORDER_ID = ORDE.ORDER_ID
                                                  and ACTI.TASK_TYPE_ID = ORDE.TASK_TYPE_ID
                                              ) as "Actividades",
                                              cursor(SELECT ORDE2.TIPO_ANULACION as "tipoAnulacion",
                                                            ORDE2.OBSERVACION_ANULA as "observacionAnulacion"
                                                     FROM   LDCI_ORDENMOVILES ORDE2
                                                     WHERE  ORDE2.ORDER_ID = ORDE.ORDER_ID) as "Anulacion"
                                        from LDCI_ORDENMOVILES ORDE, LDCI_SISTMOVILTIPOTRAB CONF
                                       where ORDE.TASK_TYPE_ID = :inuTASK_TYPE_ID
                                         and ORDE.LOTE_ANULA = :inuLote
                                         and ORDE.ESTADO_ENVIO_ANULA = :isbESTADO_ENVIO
                                         and CONF.SISTEMA_ID  = :isbSistema
                                         and CONF.TASK_TYPE_ID = ORDE.TASK_TYPE_ID'); --#7876-20150611: jesviv: Se agrega funcion etiqueta con info pago

    -- Asigna el valor de la variable
    DBMS_XMLGEN.setBindvalue (qryCtx, 'inuLote', inuLote);
    DBMS_XMLGEN.setBindvalue (qryCtx, 'inuTASK_TYPE_ID', inuTASK_TYPE_ID);
    DBMS_XMLGEN.setBindvalue (qryCtx, 'isbESTADO_ENVIO', sbESTADO_ENVIO);
    DBMS_XMLGEN.setBindvalue (qryCtx, 'isbSistema', isbSistema);
    DBMS_XMLGEN.setBindvalue (qryCtx, 'nuCantUltPagos', nuCantUltPagos); --#7876-20150611: jesviv: Se establecen la cantidad de ultimos pagos a mostrar


      --Dbms_Xmlgen.Setrowsettag(Qryctx, 'urn:NotificarOrdenesLectura');
    --DBMS_XMLGEN.setRowTag(qryCtx, '');
    Dbms_Xmlgen.setNullHandling(qryCtx, 2);
    dbms_xmlgen.setConvertSpecialChars(qryCtx, false);
    l_payload := dbms_xmlgen.getXML(qryCtx);

    --Valida si proceso registros
    if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then
         RAISE excepNoProcesoRegi;
    end if;--if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then

    dbms_xmlgen.closeContext(qryCtx);

    L_Payload := Replace(L_Payload, '<?xml version="1.0"?>');
    L_Payload := Replace(L_Payload, '<ROWSET',  '<Ordenes');
    L_Payload := Replace(L_Payload, '</ROWSET>',  '</Ordenes>');
    L_Payload := Replace(L_Payload, '<ROW>',  '<Orden>');
    L_Payload := Replace(L_Payload, '</ROW>',  '</Orden>');
    L_Payload := Replace(L_Payload, '<ACTIVIDADES>',  '<Actividades>');
    L_Payload := Replace(L_Payload, '</ACTIVIDADES>',  '</Actividades>');
    L_Payload := Replace(L_Payload, '<Actividades_ROW>',  '<Actividad>');
    L_Payload := Replace(L_Payload, '</Actividades_ROW>',  '</Actividad>');
    --
    L_Payload := Replace(L_Payload, '<ANULACION>',  '<Anulacion>');
    L_Payload := Replace(L_Payload, '</ANULACION>',  '</Anulacion>');
    L_Payload := Replace(L_Payload, '<Anulacion_ROW>');
    L_Payload := Replace(L_Payload, '</Anulacion_ROW>');


    sbXmlTransac := '<sistema>' || isbSistema || '</sistema>
                       <transaccion>
                       <proceso>' || inuTransac ||'</proceso>
                       <lote>' || inuLote || '</lote>
                       <cantidadLotes>' || inuLotes || '</cantidadLotes>
                       <cantOrdenes>' || nuCantOrds || '</cantOrdenes>
                       <cantActividades>' || nuCantActs || '</cantActividades>
                    </transaccion>';

    L_Payload := '<' || LDCI_PKGESTNOTIORDEN.sbInputMsgType || '>' || sbXmlTransac || L_Payload || '</' || LDCI_PKGESTNOTIORDEN.sbInputMsgType || '>';
    L_Payload := Trim(L_Payload);
    --#TODO drop_line dbms_output.put_line('[proGeneMensAnulacionOT 594 L_Payload ]' || chr(13) || L_Payload);

       -- Genera el mensaje de envio para la caja gris
    LDCI_PKMESAWS.proCreaMensEnvio(CURRENT_DATE,
                                   isbSistema || '_ANULA',  -- Sistema configurado en LDCI_CARASEWE
                                   -1,
                                   inuTransac,
                                   null,
                                   L_Payload,
                                   inuLote,
                                   inuLotes,
                                   nuMesacodi,
                                   onuErrorCode,
                                   osbErrorMessage);

exception
  when excepNoProcesoRegi then
        onuErrorCode := -1;
        osbErrorMessage := '[LDCI_PKGESTNOTIORDEN.proGeneMensAnulacionOT.excepNoProcesoRegi]: La consulta no ha arrojo registros.';
   when others then
        onuErrorCode := -1;
        osbErrorMessage := '[LDCI_PKGESTNOTIORDEN.proGeneMensAnulacionOT.others]:' || SQLERRM;
end proGeneMensAnulacionOT;


procedure proNotiOrdenesAnuladas As
/*
 * Propiedad Intelectual Gases de Occidente S.A.   E.S.P
 *
 * Script      : LDCI_PKGESTNOTIORDEN.proNotiOrdenesAnuladas
 * Ricef       : REQ009-I062
 * Autor       : OLSoftware / carlos.virgen <carlos.virgen@olsoftware.com>
 * Fecha       : 15-05-2014
 * Descripcion : Notifica las ordenes asignadas para el sistema WS_SISURE
 *
 * Historia de Modificaciones
 * Autor          Fecha      Descripcion
 * carlos.virgen  15-05-2014 Version inicial
   aacuna         12-12-2016 Se modifica el cursor cuLDCI_SISTMOVILTIPOTRAB para agregar el filtro de  permite_anulacion
                             actualmente recorre todos las ordenes
**/

    onuErrorCode       NUMBER(15);
    osbErrorMessage    GE_ERROR_LOG.DESCRIPTION%TYPE;
    onuProcCodi        NUMBER;
    icbProcPara        CLOB;
    sbSistema          LDCI_DEFISEWE.DESECODI%type := 'WS_SISURE';

    -- cursor de la configuracion de sistema movil por tipo de trabajo
    cursor cuLDCI_SISTMOVILTIPOTRAB (isbSISTEMA_ID LDCI_SISTMOVILTIPOTRAB.SISTEMA_ID%type)  is
     select SISTEMA_ID,TASK_TYPE_ID, OP_UNITS, REQUIERE_INFO_SUSC, REQUIERE_INFO_SESU,
           REQUIERE_INFO_CART, REQUIERE_INFO_PRED, REQUIERE_INFO_LECT
       from LDCI_SISTMOVILTIPOTRAB
      where permite_anulacion = 'S'
      order by SISTEMA_ID, TASK_TYPE_ID;

    -- cursor de las ordenes seleccionadas y pendientes por notificar
    cursor cuLDCI_ORDENMOVILES(inuTASK_TYPE_ID LDCI_ORDENMOVILES.TASK_TYPE_ID%type) is
      select DISTINCT LOTE_ANULA LOTE
        from LDCI_ORDENMOVILES
       where TASK_TYPE_ID = inuTASK_TYPE_ID
         and ESTADO_ENVIO_ANULA = 'P';


    -- cursor numero de lotes por tipo de trabajo
    cursor cuMAX_Lote(inuTASK_TYPE_ID LDCI_ORDENMOVILES.TASK_TYPE_ID%type) is
      select max(LOTE_ANULA) LOTES
        from LDCI_ORDENMOVILES
       where TASK_TYPE_ID = inuTASK_TYPE_ID
         and ESTADO_ENVIO_ANULA = 'P';

   reMAX_Lote cuMAX_Lote%rowtype;
   excepCreaEstaProc EXCEPTION;  -- Excepcion que valida si proceso peticion SOAP
begin

    --Recorre la configuracion de tipo de trabajo por sistema movil
    for reLDCI_SISTMOVILTIPOTRAB in cuLDCI_SISTMOVILTIPOTRAB(sbSistema) loop

       -- Inicializa proceso del sistema
       icbProcPara:= '<PARAMETROS>
                       <PARAMETRO>
                         <NOMBRE>SISTEMA</NOMBRE>
                         <VALOR>' || sbSistema ||'</VALOR>
                       </PARAMETRO>
                     </PARAMETROS>';


       -- crea el identificado de proceso para la interfaz
       LDCI_PKMESAWS.PROCREAESTAPROC(ISBPROCDEFI     => reLDCI_SISTMOVILTIPOTRAB.SISTEMA_ID,
                                     ICBPROCPARA     => icbProcPara,
                                     IDTPROCFEIN     => SYSDATE,
                                     ISBPROCESTA     => 'P',
                                     ISBPROCUSUA     => null,
                                     ISBPROCTERM     => null,
                                     ISBPROCPROG     => null,
                                     ONUPROCCODI     => onuProcCodi,
                                     ONUERRORCODE    => onuErrorCode,
                                     OSBERRORMESSAGE => osbErrorMessage);

       --Valida si el ESTAPROC se creo satisfactoriamente
       if (onuErrorCode <> 0) then
         RAISE excepCreaEstaProc;
       end if;--if (onuErrorCode <> 0) then

       -- determina el numero de lotes por tipo de trabajo
       open cuMAX_Lote(reLDCI_SISTMOVILTIPOTRAB.TASK_TYPE_ID);
       fetch cuMAX_Lote into reMAX_Lote;
       close cuMAX_Lote;

       -- determina y recorre el listado de lotes pendientes por tipo de trabajo
       for reLDCI_ORDENMOVILES in cuLDCI_ORDENMOVILES(reLDCI_SISTMOVILTIPOTRAB.TASK_TYPE_ID) loop

           -- Genera el mensaje para ser notificado al sistema externo
           proGeneMensAnulacionOT(isbSistema       => reLDCI_SISTMOVILTIPOTRAB.SISTEMA_ID,
                                  inuTASK_TYPE_ID  => reLDCI_SISTMOVILTIPOTRAB.TASK_TYPE_ID,
                                  inuTransac       => onuProcCodi,
                                  inuLote          => reLDCI_ORDENMOVILES.LOTE,
                                  inuLotes         => reMAX_Lote.LOTES,
                                  onuErrorCode     => onuErrorCode,
                                  osbErrorMessage  => osbErrorMessage);

           onuErrorCode := nvl(onuErrorCode, 0);
           if (onuErrorCode = 0) then
                  -- Cambia el estado de las ordenes
                  proActuEstaAnulOrdenMoviles(inuTASK_TYPE_ID => reLDCI_SISTMOVILTIPOTRAB.TASK_TYPE_ID,
                                              inuLOTE         => reLDCI_ORDENMOVILES.LOTE,
                                              isbEstadoAnulado => 'E',
                                              onuErrorCode    => onuErrorCode,
                                              osbErrorMessage => osbErrorMessage);
           else
                  LDCI_PKWEBSERVUTILS.PROCREARERRORLOGINT('proNotiOrdenesAnuladas',1,osbErrorMessage, null, null);
           end if;--if (onuErrorCode = 0) then
       end loop; -- for cuLDCI_ORDENMOVILES in cuLDCI_ORDENMOVILES loop

    end loop; --for reLDCI_SISTMOVILTIPOTRAB in cuLDCI_SISTMOVILTIPOTRAB(sbSistema) loop

exception
  when excepCreaEstaProc then
      Errors.seterror;
      Errors.geterror (onuErrorCode, osbErrorMessage);

  when others  then
      pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
      Errors.seterror;
      Errors.geterror (onuErrorCode, osbErrorMessage);
      commit; --rollback;
end proNotiOrdenesAnuladas;

Procedure proNotificaOrdenesSIFUVE As
  /*
  * Propiedad Intelectual Gases de Occidente S.A.   E.S.P
  *
  * Script      : LDCI_PKGESTNOTIORDEN.proNotificaOrdenesSIFUVE
  * Ricef       : REQ009-I062
  * Autor       : Ludycom / jesus.vivero <jesus.vivero@ludycom.com>
  * Fecha       : 03-07-2014
  * Descripcion : Notifica las ordenes asignadas para el sistema WS_SIFUVE
  *
  * Historia de Modificaciones
  * Autor          Fecha       Descripcion
  * jesus.vivero   03-07-2014  Version inicial
  **/

  -- Cursor de la configuracion de sistema movil por tipo de trabajo
  Cursor cuLdci_SistMovilTipoTrab (isbSistema_Id Ldci_SistMovilTipoTrab.Sistema_Id%Type) Is
    Select Sistema_Id,
           Task_Type_Id,
           Op_Units,
           Requiere_Info_Susc,
           Requiere_Info_Sesu,
           Requiere_Info_Cart,
           Requiere_Info_Pred,
           Requiere_Info_Lect
    From   Ldci_SistMovilTipoTrab
    Where  Sistema_Id = isbSistema_Id;

  -- Cursor de las ordenes seleccionadas y pendientes por notificar
  Cursor cuLdci_OrdenMoviles(inuTask_Type_Id Ldci_OrdenMoviles.Task_Type_Id%Type) Is
    Select Distinct Lote
    From   Ldci_OrdenMoviles
    Where  Task_Type_Id = inuTask_Type_Id
    And    Estado_Envio = 'P'
    And ESTADO_ENVIO_ANULA is null;

  -- Cursor numero de lotes por tipo de trabajo
  Cursor cuMax_Lote(inuTask_Type_Id LDCI_OrdenMoviles.Task_Type_Id%Type) Is
    Select Max(Lote) Lotes
    From   Ldci_OrdenMoviles
    Where  Task_Type_Id = inuTask_Type_Id
    And    Estado_Envio = 'P'
    and ESTADO_ENVIO_ANULA is null;

  nuErrorCode         Number(15);
  sbErrorMessage      Ge_Error_Log.Description%Type;
  nuProcCodi          Number;
  cbProcPara          Clob;
  sbSistema           Ldci_Defisewe.DeseCodi%Type := 'WS_SIFUVE';

  reMax_Lote          cuMax_Lote%RowType;
  excepCreaEstaProc   Exception;  -- Excepcion que valida si proceso peticion SOAP

Begin

  -- Recorre la configuracion de tipo de trabajo por sistema movil
  For reLdci_SistMovilTipoTrab In cuLdci_SistMovilTipoTrab(sbSistema) Loop
    -- determina el numero de lotes por tipo de trabajo
    Open cuMax_Lote(reLdci_SistMovilTipoTrab.Task_Type_Id);
      Fetch cuMax_Lote Into reMax_Lote;
    Close cuMax_Lote;

    -- determina y recorre el listado de lotes pendientes por tipo de trabajo
    For reLdci_OrdenMoviles In cuLdci_OrdenMoviles(reLdci_SistMovilTipoTrab.Task_Type_Id) Loop

      -- Inicializa proceso del sistema
      cbProcPara:= '<PARAMETROS>
                     <PARAMETRO>
                      <NOMBRE>SISTEMA</NOMBRE>
                      <VALOR>' || sbSistema ||'</VALOR>
                     </PARAMETRO>
                    </PARAMETROS>';

      -- Crea el identificado de proceso para la interfaz
      Ldci_PkMesaWS.ProcReaEstaProc(isbProcDefi     => sbSistema,
                                    icbProcPara     => cbProcPara,
                                    idtProcFeIn     => Sysdate,
                                    isbProcEsta     => 'P',
                                    isbProcUsua     => Null,
                                    isbProcTerm     => Null,
                                    isbProcProg     => Null,
                                    onuProcCodi     => nuProcCodi,
                                    onuErrorCode    => nuErrorCode,
                                    osbErrorMessage => sbErrorMessage
                                   );

      -- Valida si el ESTAPROC se creo satisfactoriamente
      If (nuErrorCode <> 0) Then
        Raise excepCreaEstaProc;
      End If;--If (nuErrorCode <> 0) Then

      -- Genera el mensaje para ser notificado al sistema externo
      proGeneMensNotificaOT(isbSistema       => sbSistema,
                            inuTask_Type_Id  => reLdci_SistMovilTipoTrab.Task_Type_Id,
                            inuTransac       => nuProcCodi,
                            inuLote          => reLdci_OrdenMoviles.Lote,
                            inuLotes         => reMax_Lote.Lotes,
                            onuErrorCode     => nuErrorCode,
                            osbErrorMessage  => sbErrorMessage
                           );

      nuErrorCode := Nvl(nuErrorCode, 0);

      If nuErrorCode = 0 Then

        -- Cambia el estado de las ordenes
        proActuEstaNotiOrdenMoviles(inuTASK_TYPE_ID => reLDCI_SISTMOVILTIPOTRAB.TASK_TYPE_ID,
                                    inuLOTE         => reLDCI_ORDENMOVILES.LOTE,
                                    isbEstado       => 'E',
                                    onuErrorCode    => nuErrorCode,
                                    osbErrorMessage => sbErrorMessage
                                   );



      Else

        Ldci_PkWebServUtils.ProCrearErrorLoginT('proNotificaOrdenesSIFUVE', 1, sbErrorMessage, Null, Null);

      End If;--If onuErrorCode = 0 Then

    End Loop; --For reLdci_OrdenMoviles In cuLdci_OrdenMoviles(reLdci_SistMovilTipoTrab.Task_Type_Id) Loop

  End Loop; --For reLdci_SistMovilTipoTrab In cuLdci_SistMovilTipoTrab(sbSistema) Loop

Exception
  When excepCreaEstaProc Then
    Errors.SetError;
    Errors.GetError (nuErrorCode, sbErrorMessage);

  When Others Then
    pkErrors.NotifyError (pkErrors.fsbLastObject, SqlErrM, sbErrorMessage);
    Errors.SetError;
    Errors.GetError (nuErrorCode, sbErrorMessage);
    RollBack;
End proNotificaOrdenesSIFUVE;

procedure proNotificaOrdenesSISURE As
/*
 * Propiedad Intelectual Gases de Occidente S.A.   E.S.P
 *
 * Script      : LDCI_PKGESTNOTIORDEN.proNotificaOrdenesSISURE
 * Ricef       : REQ009-I062
 * Autor       : OLSoftware / carlos.virgen <carlos.virgen@olsoftware.com>
 * Fecha       : 15-05-2014
 * Descripcion : Notifica las ordenes asignadas para el sistema WS_SISURE
 *
 * Historia de Modificaciones
 * Autor          Fecha      Descripcion
 * carlos.virgen  15-05-2014 Version inicial
**/

    onuErrorCode       NUMBER(15);
    osbErrorMessage    GE_ERROR_LOG.DESCRIPTION%TYPE;
    onuProcCodi        NUMBER;
    icbProcPara        CLOB;
    sbSistema          LDCI_DEFISEWE.DESECODI%type := 'WS_SISURE';

    -- cursor de la configuracion de sistema movil por tipo de trabajo
    cursor cuLDCI_SISTMOVILTIPOTRAB (isbSISTEMA_ID LDCI_SISTMOVILTIPOTRAB.SISTEMA_ID%type)  is
     select SISTEMA_ID,TASK_TYPE_ID, OP_UNITS, REQUIERE_INFO_SUSC, REQUIERE_INFO_SESU,
           REQUIERE_INFO_CART, REQUIERE_INFO_PRED, REQUIERE_INFO_LECT
       from LDCI_SISTMOVILTIPOTRAB
      where SISTEMA_ID = isbSISTEMA_ID;

    -- cursor de las ordenes seleccionadas y pendientes por notificar
    cursor cuLDCI_ORDENMOVILES(inuTASK_TYPE_ID LDCI_ORDENMOVILES.TASK_TYPE_ID%type) is
      select DISTINCT LOTE
        from LDCI_ORDENMOVILES
       where TASK_TYPE_ID = inuTASK_TYPE_ID
         And ESTADO_ENVIO = 'P'
         And ESTADO_ENVIO_ANULA is null;


    -- cursor numero de lotes por tipo de trabajo
    cursor cuMAX_Lote(inuTASK_TYPE_ID LDCI_ORDENMOVILES.TASK_TYPE_ID%type) is
      select Max(LOTE) LOTES
        from LDCI_ORDENMOVILES
       where TASK_TYPE_ID = inuTASK_TYPE_ID
         And ESTADO_ENVIO = 'P'
         And ESTADO_ENVIO_ANULA is null;

   reMAX_Lote cuMAX_Lote%rowtype;
   excepCreaEstaProc EXCEPTION;  -- Excepcion que valida si proceso peticion SOAP
begin

    --Recorre la configuracion de tipo de trabajo por sistema movil
    for reLDCI_SISTMOVILTIPOTRAB in cuLDCI_SISTMOVILTIPOTRAB(sbSistema) loop
       -- determina el numero de lotes por tipo de trabajo
       open cuMAX_Lote(reLDCI_SISTMOVILTIPOTRAB.TASK_TYPE_ID);
       fetch cuMAX_Lote into reMAX_Lote;
       close cuMAX_Lote;

       -- determina y recorre el listado de lotes pendientes por tipo de trabajo
       for reLDCI_ORDENMOVILES in cuLDCI_ORDENMOVILES(reLDCI_SISTMOVILTIPOTRAB.TASK_TYPE_ID) loop
--dbms_output.put_line('[LDCI_PKGESTNOTIORDEN]<678> sbSistema: ' || sbSistema);
/*dbms_output.put_line('[LDCI_PKGESTNOTIORDEN]<678> TASK_TYPE_ID: ' || reLDCI_SISTMOVILTIPOTRAB.TASK_TYPE_ID);
dbms_output.put_line('[LDCI_PKGESTNOTIORDEN]<678> LOTE: ' || reLDCI_ORDENMOVILES.LOTE);
dbms_output.put_line('[LDCI_PKGESTNOTIORDEN]<678> reMAX_Lote.LOTES: ' || reMAX_Lote.LOTES);       */

              -- Inicializa proceso del sistema
            icbProcPara:= '<PARAMETROS>
                            <PARAMETRO>
                              <NOMBRE>SISTEMA</NOMBRE>
                              <VALOR>' || sbSistema ||'</VALOR>
                            </PARAMETRO>
                          </PARAMETROS>';


            -- crea el identificado de proceso para la interfaz
            LDCI_PKMESAWS.PROCREAESTAPROC(ISBPROCDEFI     => sbSistema,
                                          ICBPROCPARA     => icbProcPara,
                                          IDTPROCFEIN     => SYSDATE,
                                          ISBPROCESTA     => 'P',
                                          ISBPROCUSUA     => null,
                                          ISBPROCTERM     => null,
                                          ISBPROCPROG     => null,
                                          ONUPROCCODI     => onuProcCodi,
                                          ONUERRORCODE    => onuErrorCode,
                                          OSBERRORMESSAGE => osbErrorMessage);

            --Valida si el ESTAPROC se creo satisfactoriamente
            if (onuErrorCode <> 0) then
              RAISE excepCreaEstaProc;
            end if;--if (onuErrorCode <> 0) then

           -- Genera el mensaje para ser notificado al sistema externo
           proGeneMensNotificaOT(isbSistema       => sbSistema,
                                inuTASK_TYPE_ID  => reLDCI_SISTMOVILTIPOTRAB.TASK_TYPE_ID,
                                inuTransac       => onuProcCodi,
                                inuLote          => reLDCI_ORDENMOVILES.LOTE,
                                inuLotes         => reMAX_Lote.LOTES,
                                onuErrorCode     => onuErrorCode,
                                osbErrorMessage  => osbErrorMessage);


           onuErrorCode := nvl(onuErrorCode, 0);
dbms_output.put_line('[1216.proGeneMensNotificaOT] nuErrorCode ' || onuErrorCode);
           if (onuErrorCode = 0) then

dbms_output.put_line('[1219.proGeneMensNotificaOT] nuErrorCode ' || onuErrorCode);
                  -- Cambia el estado de las ordenes
                  proActuEstaNotiOrdenMoviles(inuTASK_TYPE_ID => reLDCI_SISTMOVILTIPOTRAB.TASK_TYPE_ID,
                                              inuLOTE         => reLDCI_ORDENMOVILES.LOTE,
                                              isbEstado       => 'E',
                                              onuErrorCode    => onuErrorCode,
                                              osbErrorMessage => osbErrorMessage);
           else
dbms_output.put_line('[1227.proGeneMensNotificaOT] nuErrorCode ' || onuErrorCode);
                  LDCI_PKWEBSERVUTILS.PROCREARERRORLOGINT('proNotificaOrdenesSISURE',1,osbErrorMessage, null, null);
           end if;--if (onuErrorCode = 0) then
       end loop; -- for cuLDCI_ORDENMOVILES in cuLDCI_ORDENMOVILES loop

    end loop; --for reLDCI_SISTMOVILTIPOTRAB in cuLDCI_SISTMOVILTIPOTRAB(sbSistema) loop

exception
  when excepCreaEstaProc then
      Errors.seterror;
      Errors.geterror (onuErrorCode, osbErrorMessage);

  when others  then
      pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
      Errors.seterror;
      Errors.geterror (onuErrorCode, osbErrorMessage);
      rollback; --rollback;
end proNotificaOrdenesSISURE;

procedure proNotificaOrdenesSIMOCAR As
/*
 * Propiedad Intelectual Gases de Occidente S.A.   E.S.P
 *
 * Script      : LDCI_PKGESTNOTIORDEN.proNotificaOrdenesSIMOCAR
 * Ricef       : REQ009-I062
 * Autor       : OLSoftware / carlos.virgen <carlos.virgen@olsoftware.com>
 * Fecha       : 15-05-2014
 * Descripcion : Notifica las ordenes asignadas para el sistema WS_SIMOCAR
 *
 * Historia de Modificaciones
 * Autor          Fecha      Descripcion
 * carlos.virgen  15-05-2014 Version inicial
**/

    onuErrorCode       NUMBER(15);
    osbErrorMessage    GE_ERROR_LOG.DESCRIPTION%TYPE;
    onuProcCodi        NUMBER;
    icbProcPara        CLOB;
    sbSistema          LDCI_DEFISEWE.DESECODI%type := 'WS_SIMOCAR';

    -- cursor de la configuracion de sistema movil por tipo de trabajo
    cursor cuLDCI_SISTMOVILTIPOTRAB (isbSISTEMA_ID LDCI_SISTMOVILTIPOTRAB.SISTEMA_ID%type)  is
     select SISTEMA_ID,TASK_TYPE_ID, OP_UNITS, REQUIERE_INFO_SUSC, REQUIERE_INFO_SESU,
           REQUIERE_INFO_CART, REQUIERE_INFO_PRED, REQUIERE_INFO_LECT
       from LDCI_SISTMOVILTIPOTRAB
      where SISTEMA_ID = isbSISTEMA_ID;

    -- cursor de las ordenes seleccionadas y pendientes por notificar
    cursor cuLDCI_ORDENMOVILES(inuTASK_TYPE_ID LDCI_ORDENMOVILES.TASK_TYPE_ID%type) is
      select DISTINCT LOTE
        from LDCI_ORDENMOVILES
       where TASK_TYPE_ID = inuTASK_TYPE_ID
         And ESTADO_ENVIO = 'P'
         And ESTADO_ENVIO_ANULA is null;


    -- cursor numero de lotes por tipo de trabajo
    cursor cuMAX_Lote(inuTASK_TYPE_ID LDCI_ORDENMOVILES.TASK_TYPE_ID%type) is
      select Max(LOTE) LOTES
        from LDCI_ORDENMOVILES
       where TASK_TYPE_ID = inuTASK_TYPE_ID
         And ESTADO_ENVIO = 'P'
         And ESTADO_ENVIO_ANULA is null;

   reMAX_Lote cuMAX_Lote%rowtype;
   excepCreaEstaProc EXCEPTION;  -- Excepcion que valida si proceso peticion SOAP
begin
    --Recorre la configuracion de tipo de trabajo por sistema movil
    for reLDCI_SISTMOVILTIPOTRAB in cuLDCI_SISTMOVILTIPOTRAB(sbSistema) loop
       -- determina el numero de lotes por tipo de trabajo
       open cuMAX_Lote(reLDCI_SISTMOVILTIPOTRAB.TASK_TYPE_ID);
       fetch cuMAX_Lote into reMAX_Lote;
       close cuMAX_Lote;

       -- determina y recorre el listado de lotes pendientes por tipo de trabajo
       for reLDCI_ORDENMOVILES in cuLDCI_ORDENMOVILES(reLDCI_SISTMOVILTIPOTRAB.TASK_TYPE_ID) loop
/*dbms_output.put_line('[LDCI_PKGESTNOTIORDEN]<678> sbSistema: ' || sbSistema);
dbms_output.put_line('[LDCI_PKGESTNOTIORDEN]<678> TASK_TYPE_ID: ' || reLDCI_SISTMOVILTIPOTRAB.TASK_TYPE_ID);
dbms_output.put_line('[LDCI_PKGESTNOTIORDEN]<678> LOTE: ' || reLDCI_ORDENMOVILES.LOTE);
dbms_output.put_line('[LDCI_PKGESTNOTIORDEN]<678> reMAX_Lote.LOTES: ' || reMAX_Lote.LOTES);*/

          -- Inicializa proceso del sistema
          icbProcPara:= '<PARAMETROS>
                          <PARAMETRO>
                            <NOMBRE>SISTEMA</NOMBRE>
                            <VALOR>' || sbSistema ||'</VALOR>
                          </PARAMETRO>
                        </PARAMETROS>';


          -- crea el identificado de proceso para la interfaz
          LDCI_PKMESAWS.PROCREAESTAPROC(ISBPROCDEFI     => sbSistema,
                                        ICBPROCPARA     => icbProcPara,
                                        IDTPROCFEIN     => SYSDATE,
                                        ISBPROCESTA     => 'P',
                                        ISBPROCUSUA     => null,
                                        ISBPROCTERM     => null,
                                        ISBPROCPROG     => null,
                                        ONUPROCCODI     => onuProcCodi,
                                        ONUERRORCODE    => onuErrorCode,
                                        OSBERRORMESSAGE => osbErrorMessage);

          --Valida si el ESTAPROC se creo satisfactoriamente
          if (onuErrorCode <> 0) then
            RAISE excepCreaEstaProc;
          end if;--if (onuErrorCode <> 0) then

           -- Genera el mensaje para ser notificado al sistema externo
           proGeneMensNotificaOT(isbSistema       => sbSistema,
                                inuTASK_TYPE_ID  => reLDCI_SISTMOVILTIPOTRAB.TASK_TYPE_ID,
                                inuTransac       => onuProcCodi,
                                inuLote          => reLDCI_ORDENMOVILES.LOTE,
                                inuLotes         => reMAX_Lote.LOTES,
                                onuErrorCode     => onuErrorCode,
                                osbErrorMessage  => osbErrorMessage);

           onuErrorCode := nvl(onuErrorCode, 0);
           if (onuErrorCode = 0) then
                  -- Cambia el estado de las ordenes
                  proActuEstaNotiOrdenMoviles(inuTASK_TYPE_ID => reLDCI_SISTMOVILTIPOTRAB.TASK_TYPE_ID,
                                              inuLOTE         => reLDCI_ORDENMOVILES.LOTE,
                                              isbEstado       => 'E',
                                              onuErrorCode    => onuErrorCode,
                                              osbErrorMessage => osbErrorMessage);
           else
                  LDCI_PKWEBSERVUTILS.PROCREARERRORLOGINT('proNotificaOrdenesSIMOCAR',1,osbErrorMessage, null, null);
           end if;--if (onuErrorCode = 0) then
       end loop; -- for cuLDCI_ORDENMOVILES in cuLDCI_ORDENMOVILES loop

    end loop; --for reLDCI_SISTMOVILTIPOTRAB in cuLDCI_SISTMOVILTIPOTRAB(sbSistema) loop

exception
  when excepCreaEstaProc then
      Errors.seterror;
      Errors.geterror (onuErrorCode, osbErrorMessage);

  when others  then
      pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
      Errors.seterror;
      Errors.geterror (onuErrorCode, osbErrorMessage);
      rollback; --rollback;
end proNotificaOrdenesSIMOCAR;

procedure proNotificaOrdenesSIMOLEG As
/*
 * Propiedad Intelectual Gases de Occidente S.A.   E.S.P
 *
 * Script      : LDCI_PKGESTNOTIORDEN.proNotificaOrdenesSISURE
 * Ricef       : REQ009-I062
 * Autor       : OLSoftware / carlos.virgen <carlos.virgen@olsoftware.com>
 * Fecha       : 15-05-2014
 * Descripcion : Notifica las ordenes asignadas para el sistema WS_SISURE
 *
 * Historia de Modificaciones
 * Autor          Fecha      Descripcion
 * carlos.virgen  15-05-2014 Version inicial
**/

    onuErrorCode       NUMBER(15);
    osbErrorMessage    GE_ERROR_LOG.DESCRIPTION%TYPE;
    onuProcCodi        NUMBER;
    icbProcPara        CLOB;
    sbSistema          LDCI_DEFISEWE.DESECODI%type := 'WS_SIMOLEG';

    -- cursor de la configuracion de sistema movil por tipo de trabajo
    cursor cuLDCI_SISTMOVILTIPOTRAB (isbSISTEMA_ID LDCI_SISTMOVILTIPOTRAB.SISTEMA_ID%type)  is
     select SISTEMA_ID,TASK_TYPE_ID, OP_UNITS, REQUIERE_INFO_SUSC, REQUIERE_INFO_SESU,
           REQUIERE_INFO_CART, REQUIERE_INFO_PRED, REQUIERE_INFO_LECT
       from LDCI_SISTMOVILTIPOTRAB
      where SISTEMA_ID = isbSISTEMA_ID;

    -- cursor de las ordenes seleccionadas y pendientes por notificar
    cursor cuLDCI_ORDENMOVILES(inuTASK_TYPE_ID LDCI_ORDENMOVILES.TASK_TYPE_ID%type) is
      select DISTINCT LOTE
        from LDCI_ORDENMOVILES
       where TASK_TYPE_ID = inuTASK_TYPE_ID
         And ESTADO_ENVIO = 'P'
         And ESTADO_ENVIO_ANULA is null;


    -- cursor numero de lotes por tipo de trabajo
    cursor cuMAX_Lote(inuTASK_TYPE_ID LDCI_ORDENMOVILES.TASK_TYPE_ID%type) is
      select Max(LOTE) LOTES
        from LDCI_ORDENMOVILES
       where TASK_TYPE_ID = inuTASK_TYPE_ID
         And ESTADO_ENVIO = 'P'
         And ESTADO_ENVIO_ANULA is null;

   reMAX_Lote cuMAX_Lote%rowtype;
   excepCreaEstaProc EXCEPTION;  -- Excepcion que valida si proceso peticion SOAP
begin

    --Recorre la configuracion de tipo de trabajo por sistema movil
    for reLDCI_SISTMOVILTIPOTRAB in cuLDCI_SISTMOVILTIPOTRAB(sbSistema) loop
       -- determina el numero de lotes por tipo de trabajo
       open cuMAX_Lote(reLDCI_SISTMOVILTIPOTRAB.TASK_TYPE_ID);
       fetch cuMAX_Lote into reMAX_Lote;
       close cuMAX_Lote;

       -- determina y recorre el listado de lotes pendientes por tipo de trabajo
       for reLDCI_ORDENMOVILES in cuLDCI_ORDENMOVILES(reLDCI_SISTMOVILTIPOTRAB.TASK_TYPE_ID) loop
--dbms_output.put_line('[LDCI_PKGESTNOTIORDEN]<678> sbSistema: ' || sbSistema);
/*dbms_output.put_line('[LDCI_PKGESTNOTIORDEN]<678> TASK_TYPE_ID: ' || reLDCI_SISTMOVILTIPOTRAB.TASK_TYPE_ID);
dbms_output.put_line('[LDCI_PKGESTNOTIORDEN]<678> LOTE: ' || reLDCI_ORDENMOVILES.LOTE);
dbms_output.put_line('[LDCI_PKGESTNOTIORDEN]<678> reMAX_Lote.LOTES: ' || reMAX_Lote.LOTES);       */

          -- Inicializa proceso del sistema
          icbProcPara:= '<PARAMETROS>
                          <PARAMETRO>
                            <NOMBRE>SISTEMA</NOMBRE>
                            <VALOR>' || sbSistema ||'</VALOR>
                          </PARAMETRO>
                        </PARAMETROS>';


          -- crea el identificado de proceso para la interfaz
          LDCI_PKMESAWS.PROCREAESTAPROC(ISBPROCDEFI     => sbSistema,
                                        ICBPROCPARA     => icbProcPara,
                                        IDTPROCFEIN     => SYSDATE,
                                        ISBPROCESTA     => 'P',
                                        ISBPROCUSUA     => null,
                                        ISBPROCTERM     => null,
                                        ISBPROCPROG     => null,
                                        ONUPROCCODI     => onuProcCodi,
                                        ONUERRORCODE    => onuErrorCode,
                                        OSBERRORMESSAGE => osbErrorMessage);

          --Valida si el ESTAPROC se creo satisfactoriamente
          if (onuErrorCode <> 0) then
            RAISE excepCreaEstaProc;
          end if;--if (onuErrorCode <> 0) then

           -- Genera el mensaje para ser notificado al sistema externo
           proGeneMensNotificaOT(isbSistema       => sbSistema,
                                inuTASK_TYPE_ID  => reLDCI_SISTMOVILTIPOTRAB.TASK_TYPE_ID,
                                inuTransac       => onuProcCodi,
                                inuLote          => reLDCI_ORDENMOVILES.LOTE,
                                inuLotes         => reMAX_Lote.LOTES,
                                onuErrorCode     => onuErrorCode,
                                osbErrorMessage  => osbErrorMessage);


           onuErrorCode := nvl(onuErrorCode, 0);
           if (onuErrorCode = 0) then
                  -- Cambia el estado de las ordenes
                  proActuEstaNotiOrdenMoviles(inuTASK_TYPE_ID => reLDCI_SISTMOVILTIPOTRAB.TASK_TYPE_ID,
                                              inuLOTE         => reLDCI_ORDENMOVILES.LOTE,
                                              isbEstado       => 'E',
                                              onuErrorCode    => onuErrorCode,
                                              osbErrorMessage => osbErrorMessage);
           else
                  LDCI_PKWEBSERVUTILS.PROCREARERRORLOGINT('proNotificaOrdenesSIMOLEG',1,osbErrorMessage, null, null);
           end if;--if (onuErrorCode = 0) then
       end loop; -- for cuLDCI_ORDENMOVILES in cuLDCI_ORDENMOVILES loop

    end loop; --for reLDCI_SISTMOVILTIPOTRAB in cuLDCI_SISTMOVILTIPOTRAB(sbSistema) loop

exception
  when excepCreaEstaProc then
      Errors.seterror;
      Errors.geterror (onuErrorCode, osbErrorMessage);

  when others  then
      pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
      Errors.seterror;
      Errors.geterror (onuErrorCode, osbErrorMessage);
      rollback; --rollback;
end proNotificaOrdenesSIMOLEG;

Procedure proNotificaOrdenesLUDYENCU As
  /*
  * Propiedad Intelectual Gases de Occidente S.A.   E.S.P
  *
  * Script      : LDCI_PKGESTNOTIORDEN.proNotificaOrdenesLUDYENCU
  * Ricef       : REQ009-I062
  * Autor       : Ludycom / jesus.vivero <jesus.vivero@ludycom.com>
  * Fecha       : 24-07-2014
  * Descripcion : Notifica las ordenes asignadas para el sistema WS_LUDYENCUESTA
  *
  * Historia de Modificaciones
  * Autor          Fecha       Descripcion
  * jesus.vivero   24-07-2014  Version inicial
  **/

  -- Cursor de la configuracion de sistema movil por tipo de trabajo
  Cursor cuLdci_SistMovilTipoTrab (isbSistema_Id Ldci_SistMovilTipoTrab.Sistema_Id%Type) Is
    Select Sistema_Id,
           Task_Type_Id,
           Op_Units,
           Requiere_Info_Susc,
           Requiere_Info_Sesu,
           Requiere_Info_Cart,
           Requiere_Info_Pred,
           Requiere_Info_Lect
    From   Ldci_SistMovilTipoTrab
    Where  Sistema_Id = isbSistema_Id;

  -- Cursor de las ordenes seleccionadas y pendientes por notificar
  Cursor cuLdci_OrdenMoviles(inuTask_Type_Id Ldci_OrdenMoviles.Task_Type_Id%Type) Is
    Select Distinct Lote
    From   Ldci_OrdenMoviles
    Where  Task_Type_Id = inuTask_Type_Id
    And    Estado_Envio = 'P'
    And ESTADO_ENVIO_ANULA is null;

  -- Cursor numero de lotes por tipo de trabajo
  Cursor cuMax_Lote(inuTask_Type_Id LDCI_OrdenMoviles.Task_Type_Id%Type) Is
    Select Max(Lote) Lotes
    From   Ldci_OrdenMoviles
    Where  Task_Type_Id = inuTask_Type_Id
    And    Estado_Envio = 'P'
    And ESTADO_ENVIO_ANULA is null;

  nuErrorCode         Number(15);
  sbErrorMessage      Ge_Error_Log.Description%Type;
  nuProcCodi          Number;
  cbProcPara          Clob;
  sbSistema           Ldci_Defisewe.DeseCodi%Type := 'WS_LUDYENCUESTA';

  reMax_Lote          cuMax_Lote%RowType;
  excepCreaEstaProc   Exception;  -- Excepcion que valida si proceso peticion SOAP

Begin


  -- Recorre la configuracion de tipo de trabajo por sistema movil
  For reLdci_SistMovilTipoTrab In cuLdci_SistMovilTipoTrab(sbSistema) Loop
    -- determina el numero de lotes por tipo de trabajo
    Open cuMax_Lote(reLdci_SistMovilTipoTrab.Task_Type_Id);
      Fetch cuMax_Lote Into reMax_Lote;
    Close cuMax_Lote;

    -- determina y recorre el listado de lotes pendientes por tipo de trabajo
    For reLdci_OrdenMoviles In cuLdci_OrdenMoviles(reLdci_SistMovilTipoTrab.Task_Type_Id) Loop

      -- Inicializa proceso del sistema
      cbProcPara:= '<PARAMETROS>
                     <PARAMETRO>
                      <NOMBRE>SISTEMA</NOMBRE>
                      <VALOR>' || sbSistema ||'</VALOR>
                     </PARAMETRO>
                    </PARAMETROS>';

      -- Crea el identificado de proceso para la interfaz
      Ldci_PkMesaWS.ProcReaEstaProc(isbProcDefi     => sbSistema,
                                    icbProcPara     => cbProcPara,
                                    idtProcFeIn     => Sysdate,
                                    isbProcEsta     => 'P',
                                    isbProcUsua     => Null,
                                    isbProcTerm     => Null,
                                    isbProcProg     => Null,
                                    onuProcCodi     => nuProcCodi,
                                    onuErrorCode    => nuErrorCode,
                                    osbErrorMessage => sbErrorMessage
                                   );

      -- Valida si el ESTAPROC se creo satisfactoriamente
      If (nuErrorCode <> 0) Then
        Raise excepCreaEstaProc;
      End If;--If (nuErrorCode <> 0) Then

      -- Genera el mensaje para ser notificado al sistema externo
      proGeneMensNotificaOT(isbSistema       => sbSistema,
                            inuTask_Type_Id  => reLdci_SistMovilTipoTrab.Task_Type_Id,
                            inuTransac       => nuProcCodi,
                            inuLote          => reLdci_OrdenMoviles.Lote,
                            inuLotes         => reMax_Lote.Lotes,
                            onuErrorCode     => nuErrorCode,
                            osbErrorMessage  => sbErrorMessage
                           );

      nuErrorCode := Nvl(nuErrorCode, 0);

      If nuErrorCode = 0 Then

        -- Cambia el estado de las ordenes
        proActuEstaNotiOrdenMoviles(inuTASK_TYPE_ID => reLDCI_SISTMOVILTIPOTRAB.TASK_TYPE_ID,
                                    inuLOTE         => reLDCI_ORDENMOVILES.LOTE,
                                    isbEstado       => 'E',
                                    onuErrorCode    => nuErrorCode,
                                    osbErrorMessage => sbErrorMessage
                                   );

      Else

        Ldci_PkWebServUtils.ProCrearErrorLoginT('proNotificaOrdenesLUDYENCUESTAS', 1, sbErrorMessage, Null, Null);

      End If;--If nuErrorCode = 0 Then

    End Loop; --For reLdci_OrdenMoviles In cuLdci_OrdenMoviles(reLdci_SistMovilTipoTrab.Task_Type_Id) Loop

  End Loop; --For reLdci_SistMovilTipoTrab In cuLdci_SistMovilTipoTrab(sbSistema) Loop

Exception
  When excepCreaEstaProc Then
    Errors.SetError;
    Errors.GetError (nuErrorCode, sbErrorMessage);

  When Others Then
    pkErrors.NotifyError (pkErrors.fsbLastObject, SqlErrM, sbErrorMessage);
    Errors.SetError;
    Errors.GetError (nuErrorCode, sbErrorMessage);
    RollBack;
End proNotificaOrdenesLUDYENCU;

procedure proNotificaOrdenesLUDYCRIT As
/*
 * Propiedad Intelectual Gases deL CARBIE S.A.   E.S.P
 *
 * Script      : LDCI_PKGESTNOTIORDEN.proNotificaOrdenesLUDYCRIT
 * Ricef       : REQ009-I062
 * Autor       : Sinceocmp / karem.Baquero <karem.Baquero@sincecomp.com>
 * Fecha       : 19-06-2015
 * Descripcion : Notifica las ordenes asignadas para el sistema WS_LUDYCRIT
 *
 * Historia de Modificaciones
 * Autor          Fecha      Descripcion
 * karem.Baquero  19-06-2015 Version inicial
**/

    onuErrorCode       NUMBER(15);
    osbErrorMessage    GE_ERROR_LOG.DESCRIPTION%TYPE;
    onuProcCodi        NUMBER;
    icbProcPara        CLOB;
    sbSistema          LDCI_DEFISEWE.DESECODI%type := 'WS_LUDYCRIT';

    -- cursor de la configuracion de sistema movil por tipo de trabajo
    cursor cuLDCI_SISTMOVILTIPOTRAB (isbSISTEMA_ID LDCI_SISTMOVILTIPOTRAB.SISTEMA_ID%type)  is
     select SISTEMA_ID,TASK_TYPE_ID, OP_UNITS, REQUIERE_INFO_SUSC, REQUIERE_INFO_SESU,
           REQUIERE_INFO_CART, REQUIERE_INFO_PRED, REQUIERE_INFO_LECT
       from LDCI_SISTMOVILTIPOTRAB
      where SISTEMA_ID = isbSISTEMA_ID;

    -- cursor de las ordenes seleccionadas y pendientes por notificar
    cursor cuLDCI_ORDENMOVILES(inuTASK_TYPE_ID LDCI_ORDENMOVILES.TASK_TYPE_ID%type) is
      select DISTINCT LOTE
        from LDCI_ORDENMOVILES
       where TASK_TYPE_ID = inuTASK_TYPE_ID
         And ESTADO_ENVIO = 'P'
         And ESTADO_ENVIO_ANULA is null;


    -- cursor numero de lotes por tipo de trabajo
    cursor cuMAX_Lote(inuTASK_TYPE_ID LDCI_ORDENMOVILES.TASK_TYPE_ID%type) is
      select Max(LOTE) LOTES
        from LDCI_ORDENMOVILES
       where TASK_TYPE_ID = inuTASK_TYPE_ID
         And ESTADO_ENVIO = 'P'
         And ESTADO_ENVIO_ANULA is null;

   reMAX_Lote cuMAX_Lote%rowtype;
   excepCreaEstaProc EXCEPTION;  -- Excepcion que valida si proceso peticion SOAP
begin

    --Recorre la configuracion de tipo de trabajo por sistema movil
    for reLDCI_SISTMOVILTIPOTRAB in cuLDCI_SISTMOVILTIPOTRAB(sbSistema) loop
       -- determina el numero de lotes por tipo de trabajo
       open cuMAX_Lote(reLDCI_SISTMOVILTIPOTRAB.TASK_TYPE_ID);
       fetch cuMAX_Lote into reMAX_Lote;
       close cuMAX_Lote;

       -- determina y recorre el listado de lotes pendientes por tipo de trabajo
       for reLDCI_ORDENMOVILES in cuLDCI_ORDENMOVILES(reLDCI_SISTMOVILTIPOTRAB.TASK_TYPE_ID) loop
--dbms_output.put_line('[LDCI_PKGESTNOTIORDEN]<678> sbSistema: ' || sbSistema);
/*dbms_output.put_line('[LDCI_PKGESTNOTIORDEN]<678> TASK_TYPE_ID: ' || reLDCI_SISTMOVILTIPOTRAB.TASK_TYPE_ID);
dbms_output.put_line('[LDCI_PKGESTNOTIORDEN]<678> LOTE: ' || reLDCI_ORDENMOVILES.LOTE);
dbms_output.put_line('[LDCI_PKGESTNOTIORDEN]<678> reMAX_Lote.LOTES: ' || reMAX_Lote.LOTES);       */

              -- Inicializa proceso del sistema
            icbProcPara:= '<PARAMETROS>
                            <PARAMETRO>
                              <NOMBRE>SISTEMA</NOMBRE>
                              <VALOR>' || sbSistema ||'</VALOR>
                            </PARAMETRO>
                          </PARAMETROS>';


            -- crea el identificado de proceso para la interfaz
            LDCI_PKMESAWS.PROCREAESTAPROC(ISBPROCDEFI     => sbSistema,
                                          ICBPROCPARA     => icbProcPara,
                                          IDTPROCFEIN     => SYSDATE,
                                          ISBPROCESTA     => 'P',
                                          ISBPROCUSUA     => null,
                                          ISBPROCTERM     => null,
                                          ISBPROCPROG     => null,
                                          ONUPROCCODI     => onuProcCodi,
                                          ONUERRORCODE    => onuErrorCode,
                                          OSBERRORMESSAGE => osbErrorMessage);

            --Valida si el ESTAPROC se creo satisfactoriamente
            if (onuErrorCode <> 0) then
              RAISE excepCreaEstaProc;
            end if;--if (onuErrorCode <> 0) then

           -- Genera el mensaje para ser notificado al sistema externo
           proGeneMensNotificaOT(isbSistema       => sbSistema,
                                inuTASK_TYPE_ID  => reLDCI_SISTMOVILTIPOTRAB.TASK_TYPE_ID,
                                inuTransac       => onuProcCodi,
                                inuLote          => reLDCI_ORDENMOVILES.LOTE,
                                inuLotes         => reMAX_Lote.LOTES,
                                onuErrorCode     => onuErrorCode,
                                osbErrorMessage  => osbErrorMessage);


           onuErrorCode := nvl(onuErrorCode, 0);
dbms_output.put_line('[1216.proGeneMensNotificaOT] nuErrorCode ' || onuErrorCode);
           if (onuErrorCode = 0) then

dbms_output.put_line('[1219.proGeneMensNotificaOT] nuErrorCode ' || onuErrorCode);
                  -- Cambia el estado de las ordenes
                  proActuEstaNotiOrdenMoviles(inuTASK_TYPE_ID => reLDCI_SISTMOVILTIPOTRAB.TASK_TYPE_ID,
                                              inuLOTE         => reLDCI_ORDENMOVILES.LOTE,
                                              isbEstado       => 'E',
                                              onuErrorCode    => onuErrorCode,
                                              osbErrorMessage => osbErrorMessage);
           else
dbms_output.put_line('[1227.proGeneMensNotificaOT] nuErrorCode ' || onuErrorCode);
                  LDCI_PKWEBSERVUTILS.PROCREARERRORLOGINT('proNotificaOrdenesSISURE',1,osbErrorMessage, null, null);
           end if;--if (onuErrorCode = 0) then
       end loop; -- for cuLDCI_ORDENMOVILES in cuLDCI_ORDENMOVILES loop

    end loop; --for reLDCI_SISTMOVILTIPOTRAB in cuLDCI_SISTMOVILTIPOTRAB(sbSistema) loop

exception
  when excepCreaEstaProc then
      Errors.seterror;
      Errors.geterror (onuErrorCode, osbErrorMessage);

  when others  then
      pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
      Errors.seterror;
      Errors.geterror (onuErrorCode, osbErrorMessage);
      rollback; --rollback;
end proNotificaOrdenesLUDYCRIT;

/**/
Procedure proNotificaOrdenesLUDYREVP As
  /*
  * Propiedad Intelectual Gases de Occidente S.A.   E.S.P
  *
  * Script      : LDCI_PKGESTNOTIORDEN.proNotificaOrdenesLUDYREVP
  * Ricef       : REQ009-I062
  * Autor       : sincecomp / Karem Baquero <Karem.baquero@sincecomp.com>
  * Fecha       : 03-07-2014
  * Descripcion : Notifica las ordenes asignadas para el sistema WS_LUDYREVP
  *
  * Historia de Modificaciones
  * Autor          Fecha       Descripcion
  * Karem Baquero   25-09-2015  Version inicial
  **/

  -- Cursor de la configuracion de sistema movil por tipo de trabajo
  Cursor cuLdci_SistMovilTipoTrab (isbSistema_Id Ldci_SistMovilTipoTrab.Sistema_Id%Type) Is
    Select Sistema_Id,
           Task_Type_Id,
           Op_Units,
           Requiere_Info_Susc,
           Requiere_Info_Sesu,
           Requiere_Info_Cart,
           Requiere_Info_Pred,
           Requiere_Info_Lect
    From   Ldci_SistMovilTipoTrab
    Where  Sistema_Id = isbSistema_Id;

  -- Cursor de las ordenes seleccionadas y pendientes por notificar
  Cursor cuLdci_OrdenMoviles(inuTask_Type_Id Ldci_OrdenMoviles.Task_Type_Id%Type) Is
    Select Distinct Lote
    From   Ldci_OrdenMoviles
    Where  Task_Type_Id = inuTask_Type_Id
    And    Estado_Envio = 'P'
    And ESTADO_ENVIO_ANULA is null;

  -- Cursor numero de lotes por tipo de trabajo
  Cursor cuMax_Lote(inuTask_Type_Id LDCI_OrdenMoviles.Task_Type_Id%Type) Is
    Select Max(Lote) Lotes
    From   Ldci_OrdenMoviles
    Where  Task_Type_Id = inuTask_Type_Id
    And    Estado_Envio = 'P'
    and ESTADO_ENVIO_ANULA is null;

  nuErrorCode         Number(15);
  sbErrorMessage      Ge_Error_Log.Description%Type;
  nuProcCodi          Number;
  cbProcPara          Clob;
  sbSistema           Ldci_Defisewe.DeseCodi%Type := 'WS_LUDYREVP';

  reMax_Lote          cuMax_Lote%RowType;
  excepCreaEstaProc   Exception;  -- Excepcion que valida si proceso peticion SOAP

Begin

  -- Recorre la configuracion de tipo de trabajo por sistema movil
  For reLdci_SistMovilTipoTrab In cuLdci_SistMovilTipoTrab(sbSistema) Loop
    -- determina el numero de lotes por tipo de trabajo
    Open cuMax_Lote(reLdci_SistMovilTipoTrab.Task_Type_Id);
      Fetch cuMax_Lote Into reMax_Lote;
    Close cuMax_Lote;

    -- determina y recorre el listado de lotes pendientes por tipo de trabajo
    For reLdci_OrdenMoviles In cuLdci_OrdenMoviles(reLdci_SistMovilTipoTrab.Task_Type_Id) Loop

      -- Inicializa proceso del sistema
      cbProcPara:= '<PARAMETROS>
                     <PARAMETRO>
                      <NOMBRE>SISTEMA</NOMBRE>
                      <VALOR>' || sbSistema ||'</VALOR>
                     </PARAMETRO>
                    </PARAMETROS>';

      -- Crea el identificado de proceso para la interfaz
      Ldci_PkMesaWS.ProcReaEstaProc(isbProcDefi     => sbSistema,
                                    icbProcPara     => cbProcPara,
                                    idtProcFeIn     => Sysdate,
                                    isbProcEsta     => 'P',
                                    isbProcUsua     => Null,
                                    isbProcTerm     => Null,
                                    isbProcProg     => Null,
                                    onuProcCodi     => nuProcCodi,
                                    onuErrorCode    => nuErrorCode,
                                    osbErrorMessage => sbErrorMessage
                                   );

      -- Valida si el ESTAPROC se creo satisfactoriamente
      If (nuErrorCode <> 0) Then
        Raise excepCreaEstaProc;
      End If;--If (nuErrorCode <> 0) Then

      -- Genera el mensaje para ser notificado al sistema externo
      proGeneMensNotificaOT(isbSistema       => sbSistema,
                            inuTask_Type_Id  => reLdci_SistMovilTipoTrab.Task_Type_Id,
                            inuTransac       => nuProcCodi,
                            inuLote          => reLdci_OrdenMoviles.Lote,
                            inuLotes         => reMax_Lote.Lotes,
                            onuErrorCode     => nuErrorCode,
                            osbErrorMessage  => sbErrorMessage
                           );

      nuErrorCode := Nvl(nuErrorCode, 0);

      If nuErrorCode = 0 Then

        -- Cambia el estado de las ordenes
        proActuEstaNotiOrdenMoviles(inuTASK_TYPE_ID => reLDCI_SISTMOVILTIPOTRAB.TASK_TYPE_ID,
                                    inuLOTE         => reLDCI_ORDENMOVILES.LOTE,
                                    isbEstado       => 'E',
                                    onuErrorCode    => nuErrorCode,
                                    osbErrorMessage => sbErrorMessage
                                   );



      Else

        Ldci_PkWebServUtils.ProCrearErrorLoginT('proNotificaOrdenesSIFUVE', 1, sbErrorMessage, Null, Null);

      End If;--If onuErrorCode = 0 Then

    End Loop; --For reLdci_OrdenMoviles In cuLdci_OrdenMoviles(reLdci_SistMovilTipoTrab.Task_Type_Id) Loop

  End Loop; --For reLdci_SistMovilTipoTrab In cuLdci_SistMovilTipoTrab(sbSistema) Loop

Exception
  When excepCreaEstaProc Then
    Errors.SetError;
    Errors.GetError (nuErrorCode, sbErrorMessage);

  When Others Then
    pkErrors.NotifyError (pkErrors.fsbLastObject, SqlErrM, sbErrorMessage);
    Errors.SetError;
    Errors.GetError (nuErrorCode, sbErrorMessage);
    RollBack;
End proNotificaOrdenesLUDYREVP;
/**/

Procedure proNotificaOrdenesENVIO(isbSistema_Id Ldci_SistMovilTipoTrab.Sistema_Id%Type) As
    /*
    * Propiedad Intelectual Gases de Occidente S.A.   E.S.P
    *
    * Script      : LDCI_PKGESTNOTIORDEN.proNotificaOrdenesENVIO
    * Ricef       :
    * Autor       : JM / AAcuna <AAcuna>
    * Fecha       : 10-05-2016
    * Descripcion : Metodo generico para la notificacion de ordenes
    *
    * Historia de Modificaciones
    * Autor          Fecha       Descripcion
    * AAcuna         10-05-2016  Version inicial
    **/

    -- Cursor de la configuracion de sistema movil por tipo de trabajo
    Cursor cuLdci_SistMovilTipoTrab(isbSistema_IdMovil Ldci_SistMovilTipoTrab.Sistema_Id%Type) Is
      Select Sistema_Id,
             Task_Type_Id,
             Op_Units,
             Requiere_Info_Susc,
             Requiere_Info_Sesu,
             Requiere_Info_Cart,
             Requiere_Info_Pred,
             Requiere_Info_Lect
        From Ldci_SistMovilTipoTrab
       Where Sistema_Id = isbSistema_IdMovil;

    -- Cursor de las ordenes seleccionadas y pendientes por notificar
    Cursor cuLdci_OrdenMoviles(inuTask_Type_Id Ldci_OrdenMoviles.Task_Type_Id%Type) Is
      Select Distinct Lote
        From Ldci_OrdenMoviles
       Where Task_Type_Id = inuTask_Type_Id
         And Estado_Envio = 'P'
         And ESTADO_ENVIO_ANULA is null;

    -- Cursor numero de lotes por tipo de trabajo
    Cursor cuMax_Lote(inuTask_Type_Id LDCI_OrdenMoviles.Task_Type_Id%Type) Is
      Select Max(Lote) Lotes
        From Ldci_OrdenMoviles
       Where Task_Type_Id = inuTask_Type_Id
         And Estado_Envio = 'P'
         and ESTADO_ENVIO_ANULA is null;

    nuErrorCode    Number(15);
    sbErrorMessage Ge_Error_Log.Description%Type;
    nuProcCodi     Number;
    cbProcPara     Clob;

    reMax_Lote cuMax_Lote%RowType;
    excepCreaEstaProc Exception; -- Excepcion que valida si proceso peticion SOAP

  Begin

    -- Recorre la configuracion de tipo de trabajo por sistema movil
    For reLdci_SistMovilTipoTrab In cuLdci_SistMovilTipoTrab(isbSistema_Id) Loop
      -- determina el numero de lotes por tipo de trabajo
      Open cuMax_Lote(reLdci_SistMovilTipoTrab.Task_Type_Id);
      Fetch cuMax_Lote
        Into reMax_Lote;
      Close cuMax_Lote;

      -- determina y recorre el listado de lotes pendientes por tipo de trabajo
      For reLdci_OrdenMoviles In cuLdci_OrdenMoviles(reLdci_SistMovilTipoTrab.Task_Type_Id) Loop

        -- Inicializa proceso del sistema
        cbProcPara := '<PARAMETROS>
                     <PARAMETRO>
                      <NOMBRE>SISTEMA</NOMBRE>
                      <VALOR>' || isbSistema_Id ||
                      '</VALOR>
                     </PARAMETRO>
                    </PARAMETROS>';

        -- Crea el identificado de proceso para la interfaz
        Ldci_PkMesaWS.ProcReaEstaProc(isbProcDefi     => isbSistema_Id,
                                      icbProcPara     => cbProcPara,
                                      idtProcFeIn     => Sysdate,
                                      isbProcEsta     => 'P',
                                      isbProcUsua     => Null,
                                      isbProcTerm     => Null,
                                      isbProcProg     => Null,
                                      onuProcCodi     => nuProcCodi,
                                      onuErrorCode    => nuErrorCode,
                                      osbErrorMessage => sbErrorMessage);

        -- Valida si el ESTAPROC se creo satisfactoriamente
        If (nuErrorCode <> 0) Then
          Raise excepCreaEstaProc;
        End If; --If (nuErrorCode <> 0) Then

        -- Genera el mensaje para ser notificado al sistema externo
        proGeneMensNotificaOT(isbSistema      => isbSistema_Id,
                                                   inuTask_Type_Id => reLdci_SistMovilTipoTrab.Task_Type_Id,
                                                   inuTransac      => nuProcCodi,
                                                   inuLote         => reLdci_OrdenMoviles.Lote,
                                                   inuLotes        => reMax_Lote.Lotes,
                                                   onuErrorCode    => nuErrorCode,
                                                   osbErrorMessage => sbErrorMessage);

        nuErrorCode := Nvl(nuErrorCode, 0);

        If nuErrorCode = 0 Then




          -- Cambia el estado de las ordenes
          proActuEstaNotiOrdenMoviles(inuTASK_TYPE_ID => reLDCI_SISTMOVILTIPOTRAB.TASK_TYPE_ID,
                                      inuLOTE         => reLDCI_ORDENMOVILES.LOTE,
                                      isbEstado       => 'E',
                                      onuErrorCode    => nuErrorCode,
                                      osbErrorMessage => sbErrorMessage);

        Else

          Ldci_PkWebServUtils.ProCrearErrorLoginT('proNotificaOrdenesSIFUVE',
                                                  1,
                                                  sbErrorMessage,
                                                  Null,
                                                  Null);

        End If; --If onuErrorCode = 0 Then

      End Loop; --For reLdci_OrdenMoviles In cuLdci_OrdenMoviles(reLdci_SistMovilTipoTrab.Task_Type_Id) Loop

    End Loop; --For reLdci_SistMovilTipoTrab In cuLdci_SistMovilTipoTrab(sbSistema) Loop

  Exception
    When excepCreaEstaProc Then
      Errors.SetError;
      Errors.GetError(nuErrorCode, sbErrorMessage);

    When Others Then
      pkErrors.NotifyError(pkErrors.fsbLastObject, SqlErrM, sbErrorMessage);
      Errors.SetError;
      Errors.GetError(nuErrorCode, sbErrorMessage);
      RollBack;
  End proNotificaOrdenesENVIO;

PROCEDURE proSeleccionaOrdenesAEnviar As
/*
     PROPIEDAD INTELECTUAL DE GASES DEL CARIBE S.A E.S.P
     FUNCION    :
     AUTOR      : Jose Donado
     FECHA      : 16-05-2014
     RICEF      : I062 - Notificacion de Ordenes
     DESCRIPCION: Procedimiento que selecciona las ordenes a ser gestionadas
                  por los sistemas m?viles externos. Estas ordenes son almacenadas
                  en la tabla temporal LDCI_ORDENMOVILES.

    Historia de Modificaciones
    Autor                   Fecha         Descripcion
    JOSDON                  16-05-2014    Creaci?n del procedimiento
    JESUS VIVERO (LUDYCOM)  12-02-2015    #20150212: jesusv: Se agrega fecha de registro de la orden a integraciones
  */

    -- variables para la asignacion del cursor
    TYPE refRegistros is REF CURSOR ;
    Recregistros Refregistros;
    -- atributos del cursor de ordenes
    Nuorder_Id             Ldci_Orden.Order_Id%Type;
    Nutask_Type_Id         Ldci_Orden.Task_Type_Id%Type;
    Nuorder_Status_Id      Ldci_Orden.Order_Status_Id%Type;
    Nuaddress_Id           Ldci_Orden.Address_Id%Type;
    Sbaddress              Ldci_Orden.Address%Type;
    Nugeogra_Location_Id   Ldci_Orden.Geogra_Location_Id%Type;
    Nuneighborthood        Ldci_Orden.Neighborthood%Type;
    Nuoper_Sector_Id       Ldci_Orden.Oper_Sector_Id%Type;
    Nuroute_Id             Ldci_Orden.Route_Id%Type;
    Nuconsecutive          Ldci_Orden.Consecutive%Type;
    Nupriority             Ldci_Orden.Priority%Type;
    Dtassigned_Date        Ldci_Orden.Assigned_Date%Type;
    Dtarrange_Hour         Ldci_Orden.Arrange_Hour%Type;
    Dtcreated_Date         Ldci_Orden.Created_Date%Type;
    Dtexec_Estimate_Date   Ldci_Orden.Exec_Estimate_Date%Type;
    dtMax_Date_To_Legalize LDCI_ORDEN.Max_Date_To_Legalize%type;

    --Variables del Procedimiento
    --sbErrMens       VARCHAR2(2000);
    sbEstAsig       LDCI_CARASEWE.CASEDESE%TYPE;
    nuEstAsig       NUMBER;
    nuOpUnit        NUMBER(15);
    nuContOpUnit    NUMBER;
    nuLote          NUMBER := 1;
    nuMaxLote       NUMBER;
    --nuPaquetes      NUMBER := 0;
    cantOrds        NUMBER := 0;
    nuIsOrden       NUMBER;
    Nutransac       number := 0;

    sbttLect        ld_parameter.value_chain%type;
    nuValOk         number;

    CURSOR cuSistemas IS
    SELECT s.sistema_id
    FROM   ldci_sistmoviltipotrab s
    GROUP BY s.sistema_id
    ORDER BY s.sistema_id ASC;
    ReccuSistemas ldci_sistmoviltipotrab%ROWTYPE;

    CURSOR cuTipoTrabMoviles(sbSistema ldci_sistmoviltipotrab.sistema_id%TYPE) IS
    SELECT s.sistema_id,
           s.task_type_id,
           s.op_units
    FROM   ldci_sistmoviltipotrab s
    WHERE  s.sistema_id = sbSistema
    ORDER BY s.sistema_id ASC, s.task_type_id ASC;
    ReccuTipoTrabMoviles LDCI_SISTMOVILTIPOTRAB%ROWTYPE;

     CURSOR cuEstados(sbSistema ldci_sistmoviltipotrab.sistema_id%TYPE,
                     nuTT or_order.Task_Type_Id%TYPE) IS
    select order_status_id
      from or_order_status os
     where os.order_status_id in (select *
                                    from table(ldc_boutilities.splitstrings((select order_status_id
                                                                               from ldci_sistmoviltipotrab t
                                                                              where t.sistema_id = sbSistema
                                                                                and task_type_id = nuTT), '|')));


    --Variables de Excepci?n
    errorGetOrden  EXCEPTION;
    errorGetParam  EXCEPTION;

    Onuerrorcode   NUMBER;
    Osberrormsg    VARCHAR2(4000);

BEGIN

  --Se obtiene el estado de las ordenes a listar (Asignadas)
  LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_GESTION_ORDENES', 'ESTADO_ASIGNADA', sbEstAsig, Osberrormsg);
  IF Osberrormsg != '0' THEN
     RAISE errorGetParam;
  END IF;

  --Se obtiene la cantidad de registros por lote
  LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_ENVIO_ORDENES', 'NRO_REG_LOTE', nuMaxLote, Osberrormsg);
  IF Osberrormsg != '0' THEN
     RAISE errorGetParam;
  END IF;

  -- Se obtienen parametros para cuando el sistema es SIGELEC
  sbttLect    :=        DALD_PARAMETER.fsbGetValue_Chain('TT_LECT_SIGELEC');


  nuEstAsig := to_number(sbEstAsig);

  SELECT NVL(MAX(O.LOTE),0) + 1
  INTO nuLote
  FROM LDCI_ORDENMOVILES O
  ORDER BY O.TASK_TYPE_ID,O.LOTE;

  --Se recorre el cursor con los sistemas externos configurados
  FOR ReccuSistemas IN cuSistemas LOOP
  --Se recorre el cursor con los tipos de trabajo que se gestionan por m?viles
  FOR ReccuTipoTrabMoviles IN cuTipoTrabMoviles(ReccuSistemas.Sistema_Id) LOOP
    -- Se hallan los estados validos para Envio de Ordenes segun config en LDCI_SISTMOVILTIPOTRAB
     FOR rgE in cuEstados (ReccuTipoTrabMoviles.Sistema_Id, ReccuTipoTrabMoviles.Task_Type_Id) loop
      --Se obtienen las ordenes de trabajo que cumplen con los par?metros de entrada
       OS_GETWORKORDERS(-1,-1,-1,-1,-1,NULL,NULL,ReccuTipoTrabMoviles.Task_Type_Id,rgE.order_status_id,Recregistros,Onuerrorcode,Osberrormsg);

      IF Onuerrorcode = 0  THEN
        --Se recorre el cursor para almacenar las ordenes de trabajo en la tabla temporal
         LOOP FETCH  Recregistros INTO Nuorder_Id, Nutask_Type_Id, Nuorder_Status_Id, Nuaddress_Id,
                                    Sbaddress, Nugeogra_Location_Id, Nuneighborthood, Nuoper_Sector_Id, Nuroute_Id,
                                    Nuconsecutive, Nupriority, Dtassigned_Date, Dtarrange_Hour, Dtcreated_Date,
                                    Dtexec_Estimate_Date, dtMax_Date_To_Legalize;

         EXIT WHEN Recregistros%NOTFOUND;

         --Valida que la unidad operativa de la orden est? habilitada para gestionar el tipo de trabajo por m?viles
         nuOpUnit := daor_order.fnugetoperating_unit_id(Nuorder_Id);

         SELECT count(*)
         INTO nuContOpUnit
         FROM DUAL
         WHERE nuOpUnit IN(
                 SELECT regexp_substr(DECODE(ReccuTipoTrabMoviles.op_units,'-1',to_char(nuOpUnit),ReccuTipoTrabMoviles.op_units),'[^|]+', 1, LEVEL) FROM dual
                 CONNECT BY regexp_substr(DECODE(ReccuTipoTrabMoviles.op_units,'-1',to_char(nuOpUnit),ReccuTipoTrabMoviles.op_units), '[^|]+', 1, LEVEL) IS NOT NULL);

         --Si est? configurada se ingresa a la tabla temporal de ordenes a gestionar por moviles
         IF nuContOpUnit > 0 THEN

           SELECT COUNT(*)
           INTO nuIsOrden
           FROM LDCI_ORDENMOVILES
           WHERE order_id = Nuorder_Id;

           --Se verifica que la orden no haya sido ingresada a la tabla temporal
           IF nuIsOrden = 0 THEN
            nuValOk := 0 ;
            -- Si el tt es de SIGELEC y estan activos los flags de validaciones
            if ','||sbttLect||',' LIKE '%,'||Nutask_Type_Id||',%' and
               (sbFgValExcLec = 'S' or sbFgValOrdLec = 'S') then
               ldci_pkvalidasigelec.provalidaordenLect(Nuorder_Id, Nutask_Type_Id, Nuorder_Status_Id, Nuaddress_Id,
                                                Sbaddress, Nugeogra_Location_Id, Nuneighborthood, Nuoper_Sector_Id, Nuroute_Id,
                                                Nuconsecutive, Nupriority, Dtassigned_Date, Dtarrange_Hour, Dtcreated_Date,
                                                Dtexec_Estimate_Date, dtMax_Date_To_Legalize,nuValOk);

            end if;

            if nuValOk = 0 then

             --Se ingresa la orden a la tabla temporal de gesti?n de ordenes m?viles
             Insert Into Ldci_Ordenmoviles (Order_Id,
                                            Task_Type_Id,
                                            Order_Status_Id,
                                            Operating_Unit_Id,
                                            Address_Id,
                                            Address,
                                            Geogra_Location_Id,
                                            Neighborthood,
                                            Oper_Sector_Id,
                                            Route_Id,
                                            Consecutive,
                                            Priority,
                                            Prior_Order_Id,
                                            Assigned_Date,
                                            Arrange_Hour,
                                            Created_Date,
                                            Exec_Estimate_Date,
                                            Max_Date_To_Legalize,
                                            Transac_Id,
                                            Lote,
                                            Paquetes,
                                            Estado_Envio,
                                            Fecha_Registro) --#20150212: jesusv: Se agrega campo fecha de registro en la BD
             Values                        (Nuorder_Id,
                                            Nutask_Type_Id,
                                            Nuorder_Status_Id,
                                            Nuopunit,
                                            Nuaddress_Id,
                                            Sbaddress,
                                            Nugeogra_Location_Id,
                                            Nuneighborthood,
                                            Nuoper_Sector_Id,
                                            Nuroute_Id,
                                            Nuconsecutive,
                                            Nupriority,
                                            Null,
                                            Dtassigned_Date,
                                            Dtarrange_Hour,
                                            Dtcreated_Date,
                                            Dtexec_Estimate_Date,
                                            Dtmax_Date_To_Legalize,
                                            Nutransac,
                                            Nulote,
                                            Null,
                                            'P',
                                            Sysdate); --#20150212: jesusv: Se agrega campo fecha de registro en la BD

             cantOrds := cantOrds + 1;

             IF(cantOrds >= nuMaxLote)THEN
               nuLote := nuLote + 1;
               cantOrds := 0;
               COMMIT;
             END IF;

           END IF;  -- IF DE VALIDACION SIGELEC

           END IF;

         END IF;

         END LOOP;

      ELSE
        RAISE errorGetOrden;
      END IF;
     END LOOP; -- loop de los estados validos para seleccionar ordenes a enviar parea el tipo de trabajo
  END LOOP;
    --si se da un cambio de sistema se debe cambiar de lote
    nuLote := nuLote + 1;
    cantOrds := 0;
    COMMIT;
  END LOOP;

  -- Si se genero registro en LDCI_ESTAPROC (para Sigelec) se notifican errores y se cambia estado
  -- Esto para cumplir con el proceso que usaba PBPIO
  /*If sbCrTransSigelec = 'N' then
     Ldci_Pkinterfazordlec.NOTIFICARPROCESOORDENES(nuTransac);
     LDCI_PKMESAWS.proActuEstaProc(nuTransac,
                                   CURRENT_DATE,
                                   'F',
                                   Onuerrorcode,
                                   Osberrormsg);
    nuTransac := 0;
    sbCrTransSigelec := 'S';
  End if;*/

  COMMIT;

EXCEPTION
  WHEN errorGetParam THEN
    --Onuerrorcode := -1;
    --Osberrormsg := 'ERROR: <proSeleccionaOrdenesAEnviar>: Error obteniendo valor de par?metro: ' || Osberrormsg;
    LDCI_pkWebServUtils.Procrearerrorlogint('LDCI_PKGESTNOTIORDEN.proSeleccionaOrdenesAEnviar',1,'Error obteniendo valor de parametro: ' || Osberrormsg, null, null);
  WHEN errorGetOrden THEN
    --Osberrormsg := 'ERROR: <proSeleccionaOrdenesAEnviar>: Error en la API de obtenci?n de ordenes: ' || Osberrormsg;
    LDCI_pkWebServUtils.Procrearerrorlogint('LDCI_PKGESTNOTIORDEN.proSeleccionaOrdenesAEnviar',1,'Error en el API de obtencion de ordenes: ' || Osberrormsg, null, null);
  WHEN OTHERS THEN
    --Onuerrorcode := -1;
    --sbErrMens := 'ERROR: <proSeleccionaOrdenesAEnviar>: El proceso de selecci?n de datos fall?: ' || DBMS_UTILITY.format_error_backtrace;
    LDCI_pkWebServUtils.Procrearerrorlogint('LDCI_PKGESTNOTIORDEN.proSeleccionaOrdenesAEnviar',1,'El proceso de seleccion de datos fallo: ' || DBMS_UTILITY.format_error_backtrace, null, null);
END proSeleccionaOrdenesAEnviar;

PROCEDURE proSeleccionaOrdenesAnular As
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
  */

  --Variables del Procedimiento
  nuMaxLote       NUMBER;
  nuCantAnul      NUMBER := 0;
  nuLote          NUMBER := 1;
  nuVar           NUMBER;
  sbTrabSusp      LDCI_CARASEWE.CASEVALO%TYPE;
  sbTrabCart      LDCI_CARASEWE.CASEVALO%TYPE;
  nuContOTSusp    NUMBER;
  nuContOTCart    NUMBER;
  nuSW            BOOLEAN;
  nuCausal        NUMBER;

  onuSaldoPendSesu                NUMBER(13,2);
  --onuSaldoDiferidoSesu            NUMBER(13,2);
  --onuSaldoAnteriorSesu            NUMBER(13,2);
  --onuPeriodoCantSesu              NUMBER(4);

  --Cursor de ordenes pendientes o enviadas al sistema m?il
  CURSOR cuOrdenesMovil IS
    Select o.Order_Id,
           o.Task_Type_Id,
           o.Order_Status_Id,
           o.Operating_Unit_Id,
           o.Estado_Envio,
           o.Lote     --#20150302: jesusv: Se agrega campo a la consulta
    From   Ldci_Ordenmoviles o
    Where  o.Estado_Envio In ('P', 'E', 'F')
    And    Estado_Envio_Anula Is Null;

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

  rgOrdenMoviles     cuOrdenesMovil%rowtype;
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
  nuVar := DALD_PARAMETER.fnuGetNumeric_Value('COD_TIPO_SERV',NULL);

  --Se obtiene el listado de tipos de trabajo de suspension
  LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_SISURE', 'OT_SUSPENSION', sbTrabSusp, Osberrormsg);
  IF Osberrormsg != '0' THEN
     RAISE errorGetParam;
  END IF;

  --Se obtiene el listado de tipos de trabajo de gestion de cartera
  LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_SIMOCAR', 'OT_CARTERA', sbTrabCart, Osberrormsg);
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

  FOR rgOrdenMoviles IN cuOrdenesMovil LOOP
    nuSW := FALSE;

    OPEN cuOrdenOSF(rgOrdenMoviles.Order_Id);
    FETCH cuOrdenOSF INTO rgOrdenOSF;
    CLOSE cuOrdenOSF;

    --Valida que el tipo de trabajo sea de suspensi?
    SELECT count(*)
    INTO nuContOTSusp
    FROM DUAL
    WHERE rgOrdenMoviles.Task_Type_Id IN(
             SELECT regexp_substr(sbTrabSusp,'[^|]+', 1, LEVEL) FROM dual
             CONNECT BY regexp_substr(sbTrabSusp, '[^|]+', 1, LEVEL) IS NOT NULL);

    --Valida que el tipo de trabajo sea de gestion de cartera
    SELECT count(*)
    INTO nuContOTCart
    FROM DUAL
    WHERE rgOrdenMoviles.Task_Type_Id IN(
             SELECT regexp_substr(sbTrabCart,'[^|]+', 1, LEVEL) FROM dual
             CONNECT BY regexp_substr(sbTrabCart, '[^|]+', 1, LEVEL) IS NOT NULL);

    IF (nuContOTSusp > 0 OR nuContOTCart > 0) THEN

      --Se procede a validar si la orden es de suspension de gestion de cartera y el usuario se encuentra con
      --saldo 0 en su producto, para notificar la anulaci? de la orden
/*      OPEN cuServicio(rgOrdenOSF.Subscriber_Id,nuVar);
      FETCH cuServicio INTO rgServicio;
      CLOSE cuServicio;*/

      OPEN cuOrdenActividad(rgOrdenMoviles.Order_Id);
      FETCH cuOrdenActividad INTO rgOrdenActividad;
      CLOSE cuOrdenActividad;

      --Si la actividad no contiene el dato del producto, se continua con la siguiente
      --orden ya que no se puede validar las cuentas de cobro con saldo
      IF rgOrdenActividad.Product_Id IS NULL THEN
        Osberrormsg := 'ERROR: El ID producto es nulo en la orden ' || rgOrdenMoviles.Order_Id || ' y actividad ' || rgOrdenActividad.Order_Activity_Id || '. ';
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
        LDCI_pkWebServUtils.proCrearErrorLogInt('proSeleccionaOrdenesAnular', 1, 'Error En Api OS_PEProdSuitRconnectn, Orden: ' || To_Char(rgOrdenMoviles.Order_Id) || ' Producto: ' || To_Char(rgOrdenActividad.Product_Id) || ' Error: ' || osbErrorMsg, Null, Null);
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
        IF rgOrdenMoviles.Estado_Envio = 'P' THEN
          BEGIN
            --Logica para determinar la causal de incumplimiento al legalizar la orden
            IF nuContOTSusp > 0 THEN--Si es orden de SISURE
              nuCausal := DALD_PARAMETER.fnuGetNumeric_Value('COD_CAUSAL_LEG_PAGO_SISURE',NULL);
            ELSE-- Si es orden de SIMOCAR
              nuCausal := DALD_PARAMETER.fnuGetNumeric_Value('COD_CAUSAL_LEG_PAGO_SIMOCAR',NULL);
            END IF;

            --llamado a API que legaliza la orden de trabajo
            os_legalizeorderallactivities(inuorderid => rgOrdenMoviles.Order_Id,
                                          inucausalid => nuCausal,
                                          inupersonid => rgOrdenMoviles.Operating_Unit_Id,
                                          idtexeinitialdate => sysdate,
                                          idtexefinaldate => sysdate,
                                          isbcomment => 'Orden legalizada incumplida por pago del usuario. Legalizada desde LDCI_PKGESTNOTIORDEN.proSeleccionaOrdenesAnular',
                                          idtchangedate => null,
                                          onuerrorcode => Onuerrorcode,
                                          osberrormessage => Osberrormsg);

            IF Onuerrorcode = 0 THEN
              UPDATE ldci_ordenmoviles o
              SET    o.Estado_Envio = 'G'
              WHERE  o.order_id = rgOrdenMoviles.Order_Id;

              nuSW := TRUE;
            END IF;
          EXCEPTION
            WHEN errorLegaliza THEN
                 Osberrormsg := 'ERROR: <proSeleccionaOrdenesAnular>: Error legalizando la orden: ' || rgOrdenMoviles.Order_Id || ' incumplida. ' || Osberrormsg;
          END;
        ELSE

          --#20150302: jesusv: (INICIO) Valida si aplica o no el proceso de control de tiempo de anulacion, sino por defecto funcionara como antes
          If sbValTiempoAnul = 'S' Then
            sbNotifAnulacion := fsbValidarOrdenNotificada(inuLote          => rgOrdenMoviles.Lote,
                                                          inuMinutosEspera => To_Number(sbMinutosEspera),
                                                          isbErrorMsg      => osbErrorMsg);
          Else
            sbNotifAnulacion := 'S';
          End If;

          If sbNotifAnulacion In ('S','E') Then -- Se valida si se puede notificar la anulacion

            If sbNotifAnulacion = 'E' Then
              LDCI_pkWebServUtils.proCrearErrorLogInt('proSeleccionaOrdenesAnular', 1, 'Error En Subfuncion fsbValidarOrdenNotificada, Orden: ' || To_Char(rgOrdenMoviles.Order_Id) || ' Error: ' || osbErrorMsg, Null, Null);
            End If;
          --#20150302: jesusv: (FIN) Valida si aplica o no el proceso de control de tiempo de anulacion, sino por defecto funcionara como antes

            UPDATE ldci_ordenmoviles o
            SET    o.lote_anula = nuLote,
                   o.estado_envio_anula = 'P',
                   o.tipo_anulacion = 1,
                   o.observacion_anula = 'La orden debe ser legalizada incumplida por pago total oportuno del usuario',
                   o.Fecha_Registro_Anula = Sysdate --#20150212: jesusv: Se registra fecha de anulacion
            WHERE  o.order_id = rgOrdenMoviles.Order_Id;

            nuSW := TRUE;

          End If; --#20150302: jesusv: Valida si aplica o no el proceso de control de tiempo de anulacion, sino por defecto funcionara como antes

        END IF;
      END IF;

    END IF;

    --Si el estado de la orden que est?en proceso de gesti? es diferente
    --al estado de la orden en OSF quiere decir que esta orden fue gestionada
    --desde el sistema central, y se requiere notificar la anulaci? al sistema m?il
    IF (rgOrdenOSF.Order_Status_Id <> rgOrdenMoviles.Order_Status_Id) And (nuSW = FALSE) THEN

      --#20150302: jesusv: (INICIO) Valida si aplica o no el proceso de control de tiempo de anulacion, sino por defecto funcionara como antes
      If sbValTiempoAnul = 'S' Then
        sbNotifAnulacion := fsbValidarOrdenNotificada(inuLote          => rgOrdenMoviles.Lote,
                                                      inuMinutosEspera => To_Number(sbMinutosEspera),
                                                      isbErrorMsg      => osbErrorMsg);
      Else
        sbNotifAnulacion := 'S';
      End If;

      If sbNotifAnulacion In ('S','E') Then -- Se valida si se puede notificar la anulacion

        If sbNotifAnulacion = 'E' Then
          LDCI_pkWebServUtils.proCrearErrorLogInt('proSeleccionaOrdenesAnular', 1, 'Error En Subfuncion fsbValidarOrdenNotificada, Orden: ' || To_Char(rgOrdenMoviles.Order_Id) || ' Error: ' || osbErrorMsg, Null, Null);
        End If;
      --#20150302: jesusv: (FIN) Valida si aplica o no el proceso de control de tiempo de anulacion, sino por defecto funcionara como antes

        --#20150317: jesusv: (INICIO) Se verifica el estado en la tabla de integraciones para identificar si fue el movil quien la gestiono
        Open cuEstadoOrdenMovil(rgOrdenMoviles.Order_Id);
        Fetch cuEstadoOrdenMovil Into rgEstadoOrdenMovil;
        Close cuEstadoOrdenMovil;

        If rgEstadoOrdenMovil.Estado_Envio In ('P', 'E', 'F') Then
        --#20150317: jesusv: (FIN) Se verifica el estado en la tabla de integraciones para identificar si fue el movil quien la gestiono

          UPDATE ldci_ordenmoviles o
          SET    o.order_status_id = rgOrdenOSF.Order_Status_Id,
                 o.lote_anula = nuLote,
                 o.estado_envio_anula = 'P',
                 o.tipo_anulacion = 0,
                 o.observacion_anula = 'La ordenen debe ser anulada, ya que fue gestionada desde el sistema central OSF',
                 o.Fecha_Registro_Anula = Sysdate --#20150212: jesusv: Se registra fecha de anulacion
          WHERE  o.order_id = rgOrdenMoviles.Order_Id;

          nuSW := TRUE;

        End If; --#20150317: jesusv: --If rgEstadoOrdenMovil.Estado_Envio In ('P', 'E', 'F') Then

      End If; --#20150302: jesusv: Valida si aplica o no el proceso de control de tiempo de anulacion, sino por defecto funcionara como antes

    END IF;

    -- Se el usuario tiene orden a anular
    IF nuSW THEN

      nuCantAnul := nuCantAnul + 1;

      IF(nuCantAnul >= nuMaxLote)THEN
         nuLote := nuLote + 1;
         nuCantAnul := 0;
         COMMIT;
      END IF;

    END IF;

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
END proSeleccionaOrdenesAnular;


FUNCTION fsbCalComent(inuActivi  in NUMBER) RETURN VARCHAR2 AS

/*
 * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
 *
 * Funcion  : LDCI_PKGESTNOTIORDEN.fsbCalComent
 * Tiquete :
 * Autor   : Arquitecsoft / hectord <hectord@arqs.co>
 * Fecha   : 14-05-2014
 * Descripcion : Calcula comentarios de una actrividad
 *
 * Historia de Modificaciones
 * Autor          Fecha      Descripcion
 **/

INUCOMMENT NUMBER;
SBCOMMENTACT  OR_ORDER_COMMENT.ORDER_COMMENT%TYPE;
SBCOMMENTOR  OR_ORDER_COMMENT.ORDER_COMMENT%TYPE;

  /*
  * CURSOR       CUACTIVIDAD
  *
  * DESCRIPCION:
  * FECHA:       16-12-2014
  * TIQUETE:     ROLLOUT
  *
  */

CURSOR CUACTIVIDAD is

SELECT ORDER_ID, COMMENT_
FROM  OR_ORDER_ACTIVITY OA
WHERE ORDER_ACTIVITY_ID =INUACTIVI;



  /*
  * CURSOR       CUORDERCOM
  *
  * DESCRIPCION:
  * FECHA:       16-12-2014
  * TIQUETE:     ROLLOUT
  *
  */


CURSOR CUORDERCOM(INUORDEN NUMBER) IS
SELECT  ORDER_COMMENT
FROM    OR_ORDER_COMMENT OC
WHERE   OC.ORDER_ID = INUORDEN  AND
        ORDER_COMMENT_ID = (SELECT MIN(ORDER_COMMENT_ID)
                            FROM OR_ORDER_COMMENT WHERE ORDER_ID =INUORDEN );

BEGIN

OPEN CUACTIVIDAD;
FETCH CUACTIVIDAD INTO INUCOMMENT,SBCOMMENTACT;
CLOSE CUACTIVIDAD;

OPEN CUORDERCOM(INUCOMMENT);
FETCH CUORDERCOM INTO SBCOMMENTOR;
CLOSE CUORDERCOM;

RETURN ge_boemergencyorders.fsbvalidatecharactersxml(SBCOMMENTACT||' '||SBCOMMENTOR); --#8335: KarBaq: Se agrega el llamado ala funci?n de caracteres especiales

EXCEPTION
WHEN OTHERS THEN
    LDCI_PKWEBSERVUTILS.PROCREARERRORLOGINT('LDCI_PKGESTNOTIORDEN.fsbRefinancia',1,'Fallo definiendo flag refinanciar: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE, NULL, NULL);
    RETURN 'ERROR CONSULTANDO COMENTARIOS ';
END fsbCalComent;

FUNCTION fclbCalComent(inuActivi  in NUMBER) RETURN CLOB AS

/*
 * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
 *
 * Funcion  : LDCI_PKGESTNOTIORDEN.fclbCalComent
 * Tiquete : 221
 * Autor   : Jose Donado
 * Fecha   : 17-04-2020
 * Descripcion : Calcula comentarios de una actrividad
 *
 * Historia de Modificaciones
 * Autor          Fecha      Descripcion
   JOSDON         17-04-2020 GLPI 221: Se crea funci?n para retornar todas las observaciones asociadas a la OT.
**/

INUCOMMENT NUMBER;
SBCOMMENTACT  OR_ORDER_COMMENT.ORDER_COMMENT%TYPE;
CLBCOMMENTOR  CLOB;
nuCont        NUMBER := 0;

CURSOR CUACTIVIDAD is
SELECT ORDER_ID, COMMENT_
FROM  OR_ORDER_ACTIVITY OA
WHERE ORDER_ACTIVITY_ID =INUACTIVI;


CURSOR CUORDERCOM(INUORDEN NUMBER) IS
SELECT  ORDER_COMMENT
FROM    OR_ORDER_COMMENT OC
WHERE   OC.ORDER_ID = INUORDEN
ORDER BY REGISTER_DATE ASC;

BEGIN

OPEN CUACTIVIDAD;
FETCH CUACTIVIDAD INTO INUCOMMENT,SBCOMMENTACT;
CLOSE CUACTIVIDAD;

FOR rgCUORDERCOM IN CUORDERCOM(INUCOMMENT) LOOP
  IF nuCont = 0 THEN
    CLBCOMMENTOR := rgCUORDERCOM.ORDER_COMMENT;
  ELSE
    CLBCOMMENTOR := CLBCOMMENTOR || '. ' || rgCUORDERCOM.ORDER_COMMENT;
  END IF;

  nuCont := nuCont + 1;
END LOOP CUORDERCOM;

RETURN fclbValidateCharactersXML(SBCOMMENTACT||' '||CLBCOMMENTOR);

EXCEPTION
WHEN OTHERS THEN
    LDCI_PKWEBSERVUTILS.PROCREARERRORLOGINT('LDCI_PKGESTNOTIORDEN.fclbCalComent',1,'Fallo obteniendo comentarios de la orden: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE, NULL, NULL);
    RETURN 'ERROR CONSULTANDO COMENTARIOS ';
END fclbCalComent;

/*
caso 200-900
Se coloca funcion en comentario por el caso de vetados ya  que se hizo una nueva funcion
esta se va eliminar dependiendo cuandos se monte en productivo

FUNCTION fsbRefinancia(inuOrder  in NUMBER) RETURN VARCHAR2 AS

 * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
 *
 * Funcion  : LDCI_PKGESTNOTIORDEN.fsbRefinancia
 * Tiquete : test
 * Autor   : Arquitecsoft / hectord <hectord@arqs.co>
 * Fecha   : 14-05-2014
 * Descripcion : Retorna N si el contrato asociado a una orden no puede financiar
 *
 * Historia de Modificaciones
 * Autor          Fecha      Descripcion



OSBERRORMESSAGE VARCHAR2(2000);
nuCantRefi NUMBER;
sbCantRefiParam VARCHAR2(200);

  * CURSOR       cuRefinancia
  *
  * DESCRIPCION: Consulta cantidad de refinanciacione
  *              en el ultimo ano
  * FECHA:       2-12-2014
  * TIQUETE:     ROLLOUT
  *


CURSOR cuRefinancia IS

SELECT REFINANCI_TIMES
FROM OPEN.gc_coll_mgmt_pro_det
WHERE ORDER_ID     = inuOrder AND
      IS_LEVEL_MAIN= 'Y'       AND
      ROWNUM<=1;

BEGIN



OPEN cuRefinancia;
FETCH cuRefinancia INTO nuCantRefi;
CLOSE cuRefinancia;

   --Se obtiene el valor minimo de abono
  LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_SIMOCAR', 'MAX_FINANCIA', sbCantRefiParam, osbErrorMessage);

  IF osbErrorMessage != '0'  or sbCantRefiParam is null   THEN
    sbCantRefiParam:='2';
  END IF;

  IF nuCantRefi>to_number(sbCantRefiParam) THEN

    RETURN 'N';

  ELSE

    RETURN 'S';

  END IF;

EXCEPTION
 WHEN OTHERS THEN
    LDCI_pkWebServUtils.Procrearerrorlogint('LDCI_PKGESTNOTIORDEN.fsbRefinancia',1,'Fallo definiendo flag refinanciar: ' || DBMS_UTILITY.format_error_backtrace, null, null);
    RETURN 'N';
END fsbRefinancia;
*/

FUNCTION fsbGET_SUSCRIPC(inuSUSCCODI in NUMBER,inuORDERID in NUMBER) RETURN VARCHAR2 /*CLOB*/ AS

/*
 * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
 *
 * Funcion  : LDCI_PKGESTNOTIORDEN.fsbGET_SUSCRIPC
 * Tiquete : test
 * Autor   : OLSoftware / carlos.virgen <carlos.virgen@olsoftware.com>
 * Fecha   : 14-05-2014
 * Descripcion : Genera XML a partir de la obtenci? de datos del suscriptor
 *
 * Historia de Modificaciones
 * Autor          Fecha      Descripcion
 * carlos.virgen  14-05-2014 Version inicial

   Jose.Donado    26-05-2014 Ajuste para retornar datos del sistema SISURE
   Jorge Valiente 16/05/2016 CASO 100-10606: * En la condicion Exception se adiciono el llamado del servicio
                                               ProErrorXML el cual permitira armar la cadena XML con los
                                               datos -1 y registrar el inconveninete qeu se presento al
                                               generar la cadena XML por el servicio.
**/
  --nuRuta                      NUMBER(15);
  --nuConsecRuta                NUMBER(10);


 L_Payload     CLOB;
 --l_response    CLOB;
 qryCtx        DBMS_XMLGEN.ctxHandle;

  --Variables de manejo de error
 excepNoProcesoRegi EXCEPTION;  -- Excepcion que valida si proceso registros la consulta
  --onuErrorCode        ge_error_log.error_log_id%type;
  --osbErrorMessage     ge_error_log.description%type;

  CURSOR cuORDER(inuORDER_ID OR_ORDER.ORDER_ID%TYPE) IS
  SELECT *
  FROM or_order o
  WHERE o.order_id = inuORDER_ID;

  -- tipo registro
  reOR_ORDER          cuORDER%rowtype;

BEGIN
  IF inuSUSCCODI IS NOT NULL THEN

    -- Abre el registro de la orden de trabajo
    open cuORDER(inuORDERID);
    fetch cuORDER into reOR_ORDER;
    close cuORDER;

    qryCtx :=  DBMS_XMLGEN.NewContext ('select S.SUSCCODI as "idContrato",
                                             S.SUSCTISU as "tipoContrato",
                                               S.SUSCCICL as "ciclo",
                                               DECODE(S.SUSCSAFA,NULL,0) as "saldoAFavor",
                                               SB.SUBSCRIBER_NAME || '' '' || SB.SUBS_LAST_NAME || '' '' || SB.SUBS_SECOND_LAST_NAME as "nombreCliente",
                                               SB.PHONE as "telefono",
                                               G.GEOGRAP_LOCATION_ID as "idBarrio",
                                               G.DISPLAY_DESCRIPTION as "barrioDescripcion",
                                               ' || nvl(reOR_ORDER.ROUTE_ID,-1) ||' as "ruta",
                                               ' || nvl(reOR_ORDER.CONSECUTIVE,-1) ||' as "consecutivoRuta"
                                   from SUSCRIPC S
                                        inner join GE_SUBSCRIBER SB
                                        on(SB.SUBSCRIBER_ID = S.SUSCCLIE)
                                        left join AB_ADDRESS A
                                        on(A.ADDRESS_ID = S.SUSCIDDI)
                                        left join GE_GEOGRA_LOCATION G
                                        on(G.GEOGRAP_LOCATION_ID = A.NEIGHBORTHOOD_ID)
                     where S.SUSCCODI = :inuSUSCCODI');

    DBMS_XMLGEN.setBindvalue (qryCtx, 'inuSUSCCODI', inuSUSCCODI);

  ELSE
    qryCtx :=  DBMS_XMLGEN.NewContext ('select -1 as "idContrato",
                                               -1 as "tipoContrato",
                                               -1 as "ciclo",
                                               -1 as "saldoAFavor",
                                               -1 as "nombreCliente",
                                               -1 as "telefono",
                                               -1 as "idBarrio",
                                               -1 as "barrioDescripcion",
                                               -1 as "ruta",
                                               -1 as "consecutivoRuta"
                                   from DUAL');
  END IF;

    DBMS_XMLGEN.SETNULLHANDLING(qryCtx,2);

    Dbms_Xmlgen.setRowSetTag(Qryctx, '');
    DBMS_XMLGEN.setRowTag(qryCtx, 'Contrato');
    --Genera el XML
    L_Payload := DBMS_XMLGEN.getXML(qryCtx);

    --Valida si proceso registros
    if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then
         RAISE excepNoProcesoRegi;
    end if;--if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then

  --Cierra el contexto
    DBMS_XMLGEN.closeContext(qryCtx);

  --Imprime el XML
    L_Payload := Replace(L_Payload, '<?xml version="1.0"?>');
    --#TODO drop_line dbms_output.PUT_LINE('L_Payload ' || chr(13) || L_Payload);

  return L_Payload;
exception
  when excepNoProcesoRegi then
      L_Payload := '<Contratos><Contrato><programa>LDCI_PKGESTNOTIORDEN_1.fsbGET_SUSCRIPC</programa>
      <excepNoProcesoRegi>No proceso registros ...</excepNoProcesoRegi></Contrato></Contratos>' ;
    ---Inicio CASO 100-10606
    ProErrorXML('fsbGET_SUSCRIPC',L_Payload,L_Payload);
    ---Fin CASO 100-10606
    return L_Payload; --#135387: Se complementa el return
  when others then
      L_Payload := '<Contratos><Contrato><programa>LDCI_PKGESTNOTIORDEN_1.fsbGET_SUSCRIPC</programa>
      <others>' || SQLERRM || '</others></Contrato></Contratos>' ;
    ---Inicio CASO 100-10606
    ProErrorXML('fsbGET_SUSCRIPC',L_Payload,L_Payload);
    ---Fin CASO 100-10606
    return L_Payload; --#135387: Se complementa el return
END fsbGET_SUSCRIPC;

FUNCTION fsbGET_SERVSUSC(inuSESUNUSE in NUMBER) RETURN VARCHAR2 /*CLOB*/ AS

/*
 * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
 *
 * Funcion  : LDCI_PKGESTNOTIORDEN.fsbGET_SERVSUSC
 * Tiquete : test
 * Autor   : Jose Donado <jdonado@gascaribe.com>
 * Fecha   : 27-05-2014
 * Descripcion : Genera XML a partir de la obtenci? de datos del suscriptor
 *
 * Historia de Modificaciones
 * Autor                    Fecha             Descripcion
   Jose.Donado              26-05-2014        Creaci? de la Funcion
   JESUS VIVERO (LUDYCOM)   16-01-2015        #20150116: jesusv: agrega validacion para seleccionar solo el medidor activo
   JESUS VIVERO (LUDYCOM)   19-05-2015        #7171-20150519: jesviv: Se agrega descripcion de estado y datos de ultima actividad de suspension
   Jorge Valiente           16/05/2016        CASO 100-10606: * En la condicion Exception se adiciono el llamado del servicio
                                                                ProErrorXML el cual permitira armar la cadena XML con los
                                                                datos -1 y registrar el inconveninete qeu se presento al
                                                                generar la cadena XML por el servicio.
   Samuel Pacheco           26-05-2016        se adicional la fecha de ultimo certificado
   AAcuna                   02/02/2017        Caso: 200-988: Se modifica cursor de servicio suscrito, para agregar los campos de periodo de facturacio,
                                                             cantidad de medidor,a?o de facturacion y mes de facturacion.
   AAcuna                   18/08/2017        Caso: 200-1435: Se agrega campo marcaRevPeriodica
   fresie                   20/11/2020        Cambio 0000564 Se agregan dos campos adicionales en el cursor para obtener las fechas de plazo
                                              m?nimo de revisi?n y plazo m?ximo que se encuentran en LDC_PLAZOS_CERT
**/
  --nuRuta                      NUMBER(15);
  --nuConsecRuta                NUMBER(10);
  nuIdActividadSusp           Number; --#7171-20150519: jesviv: registra el id de la actividad de suspension
  sbDescActividadSusp         VARCHAR2(1000);
  sbFechActividadSusp         Varchar2(50); --#7171-20150519: jesviv: Registra la fecha de legalizacion de la actividad de suspension
  nuEstProdSusp               NUMBER;

 L_Payload     CLOB;
 --l_response    CLOB;
 qryCtx        DBMS_XMLGEN.ctxHandle;

  --Variables de manejo de error
  excepNoProcesoRegi  EXCEPTION;  -- Excepcion que valida si proceso registros la consulta
  errorGetParam       EXCEPTION;
  --onuErrorCode        ge_error_log.error_log_id%type;
  osbErrorMessage     ge_error_log.description%type;

  Cursor cuSERVSUSC Is
    Select s.Sesususc,
       s.Sesunuse,
       s.Sesuserv,
       s.Sesuesco, --#7171-20150519: jesviv: Se busca el estado de corte
       s.Sesufein,
       s.Sesuesfn,
       s.Sesucate,
       s.Sesusuca,
       s.Sesumult,
       p.Product_Status_Id,
       (Select d.Description
          From Ps_Product_Status d
         Where d.Product_Status_Id = p.Product_Status_Id) Product_Status_Desc, --#7171-20150519: jesviv: Se consulta la descripcion del estado
       p.Suspen_Ord_Act_Id,
       m.Emsscoem,
       medi.elmenudc Digit_Quantity, --#20170127-200-988
       Or_BOOrderInfo.fnuGetPeriodByCycle(s.sesucicl) Bill_Period_Id,     --#20170127-200-988
       (SELECT pefaano
          FROM perifact
         WHERE pefacodi = Or_BOOrderInfo.fnuGetPeriodByCycle(s.sesucicl)) anoFact,     --#20170127-200-988
       (SELECT pefames
          FROM perifact
         WHERE pefacodi = Or_BOOrderInfo.fnuGetPeriodByCycle(s.sesucicl)) mesFact,     --#20170127-200-988,
         (SELECT ldc_fncretornamarcaprod(s.sesunuse) from dual) marcaRevPeriodica,      --20170818-200-1435,
         TO_CHAR((SELECT pc.plazo_min_revision
         FROM open.ldc_plazos_cert pc
         WHERE pc.plazos_cert_id = (SELECT MAX(pc1.plazos_cert_id) FROM open.ldc_plazos_cert pc1 WHERE pc1.id_contrato = s.sesususc AND pc1.id_producto = s.sesunuse)),'DD/MM/YYYY') plazo_min_revision,--Cambio 0000564
         TO_CHAR((SELECT pc.plazo_maximo
         FROM open.ldc_plazos_cert pc
         WHERE pc.plazos_cert_id = (SELECT MAX(pc1.plazos_cert_id) FROM open.ldc_plazos_cert pc1 WHERE pc1.id_contrato = s.sesususc AND pc1.id_producto = s.sesunuse)),'DD/MM/YYYY') plazo_maximo --Cambio 0000564
       From Servsusc s
            Inner Join Pr_Product p
            On (s.Sesunuse = p.Product_id)
            Left Join Elmesesu m
            On (m.Emsssesu = s.Sesunuse And
            Nvl(m.Emssfere, Trunc(Sysdate)) >= Trunc(Sysdate)) --#20150116: jesusv: Se agrego condicion para tener en cuenta el medidor actual
            Left Join elemmedi medi                                 --#20170127-200-988: aacuna: Se agrego condicion para tener en cuenta los digitos de contador
            On (medi.elmeidem = m.emsselme And medi.elmecodi = m.emsscoem)
       Where s.Sesunuse = inuSESUNUSE;


  Cursor cuActividad(nuOrdenActiv Or_Order.Order_Id%Type) Is
    Select o.Order_Activity_Id,
           o.Activity_Id,
           i.Description,
           To_Char(r.Legalization_Date, 'YYYY-MM-DD HH24:MI:SS') Legalization_Date --#7171-20150519: jesviv: Se busca la fecha de legalizacion de la actividad
    From   Or_Order_Activity o
           Inner Join Open.Or_Order r On (o.Order_Id = r.Order_Id) --#7171-20150519: jesviv: Se agrega tabla or_order a la consulta
           Inner Join Ge_Items i On (o.Activity_Id = i.Items_Id)
    Where  o.Order_Activity_Id = nuOrdenActiv;

  --se identifica fecha de certificado
  Cursor cufeccert(nuproduct in number) Is
    select REVIEW_DATE  from PR_CERTIFICATE where product_id = nuproduct order by certificate_id desc;
  -- tipo registro
  reSERVSUSC          cuSERVSUSC%rowtype;
  rgActividad         cuActividad%ROWTYPE;
  dtfeccert           date;
BEGIN

  --Se obtiene el estdo de producto suspendido
  LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_SIMOCAR', 'ESTADO_PROD_SUSP', nuEstProdSusp, osbErrorMessage);
  IF osbErrorMessage != '0' THEN
     RAISE errorGetParam;
  END IF;

--dbms_output.put_line('[fsbGET_SERVSUSC ] inuSESUNUSE ' || inuSESUNUSE);
  IF inuSESUNUSE IS NOT NULL THEN
    -- Abre el registro del servicio
    open cuSERVSUSC;
    fetch cuSERVSUSC into reSERVSUSC;
    close cuSERVSUSC;

     -- identifica fecha de certificado
    open cufeccert(reSERVSUSC.Sesunuse);
    fetch cufeccert into dtfeccert;
    close cufeccert;

    --Parametrizar al pasar esto a productivo
    IF (reSERVSUSC.Product_Status_Id = nuEstProdSusp And reSERVSUSC.Suspen_Ord_Act_Id is not null) THEN
      OPEN cuActividad(reSERVSUSC.Suspen_Ord_Act_Id);
      FETCH cuActividad INTO rgActividad;
      CLOSE cuActividad;

      nuIdActividadSusp   := rgActividad.Activity_Id; --#7171-20150519: jesviv: Se asigna la actividad de suspension
      sbDescActividadSusp := rgActividad.Description;
      sbFechActividadSusp := rgActividad.Legalization_Date; --#7171-20150519: jesviv: Se asigna la fecha de legalizacion de la actividad

    ELSE

      nuIdActividadSusp   := -1; --#7171-20150519: jesviv: Se asigna -1 porque no hay o no aplica actividad de suspension
      sbDescActividadSusp := '-1';
      sbFechActividadSusp := '-1'; --#7171-20150519: jesviv: Se asigna -1 porque no hay o no aplica fecha de legalizacion de la actividad

    END IF;

    --#TODO drop_line dbms_output.PUT_LINE('INI fsbGET_SERVSUSC  inuSERVCODI: ' || inuSESUNUSE);
    qryCtx :=  DBMS_XMLGEN.NewContext ('Select ' || reSERVSUSC.sesususc || ' As "idContrato",
                                               ' || reSERVSUSC.sesunuse || ' As "numeroServicio",
                                               ' || reSERVSUSC.sesuserv || ' As "idServicio",
                                               ''' || to_char(reSERVSUSC.Sesufein, 'YYYY-MM-DD HH24:MI:SS') || ''' As "fechaInstalacion",
                                               ''' || reSERVSUSC.Sesuesfn || ''' As "estadoFinanciero",
                                               ' || reSERVSUSC.Sesucate || ' As "categoria",
                                               ' || reSERVSUSC.Sesusuca || ' As "subcategoria",
                                               ' || reSERVSUSC.Sesumult || ' As "multiFamiliar",
                                               ' || reSERVSUSC.Product_Status_Id || ' As "estadoTecnico",
                                               ''' || reSERVSUSC.Product_Status_Desc || ''' As "descEstadoTecnico",
                                               ''' || reSERVSUSC.Sesuesco || ''' As "estadoCorte",
                                               ' || nuIdActividadSusp || ' As "idUltActividadSuspension",
                                               ''' || sbDescActividadSusp || ''' As "descUltActividadSuspension",
                                               ''' || sbFechActividadSusp || ''' As "fechaUltActividadSuspension",
                                               ''' || reSERVSUSC.Emsscoem || ''' As "medidor",
                                               ''' || reSERVSUSC.Bill_Period_Id || ''' As "idPeriodoFact",
                                               ''' || reSERVSUSC.Anofact || ''' As "anoFact",
                                               ''' || reSERVSUSC.Mesfact || ''' As "mesFact",
                                               ''' || reSERVSUSC.Digit_Quantity || ''' As "digitosMed",
                                               ''' || to_char(dtfeccert, 'YYYY-MM-DD HH24:MI:SS') || ''' As "fechaUltmCertificado",
                                               ''' || reSERVSUSC.Marcarevperiodica || ''' As "marcaRevPeriodica",
                                               ''' || reSERVSUSC.plazo_min_revision || ''' As "plazo_min_revision",
                                               ''' || reSERVSUSC.plazo_maximo || ''' As "plazo_maximo"
                                        From   Dual'); --#7171-20150519: jesviv: Se agregan los nuevos campos
    ELSE
      --#TODO drop_line dbms_output.PUT_LINE('INI fsbGET_SERVSUSC  inuSERVCODI: ' || inuSESUNUSE);
      qryCtx :=  DBMS_XMLGEN.NewContext ('Select -1 As "idContrato",
                                                 -1 As "numeroServicio",
                                                 -1 As "idServicio",
                                                 ''' || to_char(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') || ''' As "fechaInstalacion",
                                                 -1 As "estadoFinanciero",
                                                 -1 As "categoria",
                                                 -1 As "subcategoria",
                                                 -1 As "multiFamiliar",
                                                 -1 As "estadoTecnico",
                                                 -1 As "descEstadoTecnico",
                                                 -1 As "estadoCorte",
                                                 -1 As "idUltActividadSuspension",
                                                 -1 As "descUltActividadSuspension",
                                                 -1 As "fechaUltActividadSuspension",
                                                 -1 As "medidor",
                                                 -1 As "idPeriodoFact",
                                                 -1 As "anoFact",
                                                 -1 As "mesFact",
                                                 -1 As "digitosMed",
                                                 -1 As "fechaUltmCertificado,
                                                 -1 As "marcaRevPeriodica",
                                                 -1 As "plazo_min_revision",
                                                 -1 As "plazo_maximo"
                                          from   DUAL'); --#7171-20150519: jesviv: Se agregan los nuevos campos
    END IF;

    DBMS_XMLGEN.SETNULLHANDLING(qryCtx,2);

    Dbms_Xmlgen.setRowSetTag(Qryctx, '');
    DBMS_XMLGEN.setRowTag(qryCtx, 'Servicio');
    --Genera el XML
    L_Payload := DBMS_XMLGEN.getXML(qryCtx);

    --Valida si proceso registros
    if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then
         RAISE excepNoProcesoRegi;
    end if;--if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then

  --Cierra el contexto
    DBMS_XMLGEN.closeContext(qryCtx);

  --Imprime el XML
    L_Payload := Replace(L_Payload, '<?xml version="1.0"?>');

  return L_Payload;
exception
  when errorGetParam then
      L_Payload := '<Servicios><Servicio><programa>LDCI_PKGESTNOTIORDEN_1.fsbGET_SERVSUSC</programa>
      <errorGetParam>' || OSBERRORMESSAGE || '</errorGetParam></Servicio></Servicios>' ;
      ---Inicio CASO 100-10606
      ProErrorXML('fsbGET_SERVSUSC',L_Payload,L_Payload);
      ---Fin CASO 100-10606
      return L_Payload; --#135387: Se complementa el return
  when excepNoProcesoRegi then
      L_Payload := '<Servicios><Servicio><programa>LDCI_PKGESTNOTIORDEN_1.fsbGET_SERVSUSC</programa>
      <exception>No proceso registros ...</exception></Servicio></Servicios>' ;
  when others then
      L_Payload := '<Servicios><Servicio><programa>LDCI_PKGESTNOTIORDEN_1.fsbGET_SERVSUSC</programa>
      <exception>' || SQLERRM || '</exception></Servicio></Servicios>' ;
      ---Inicio CASO 100-10606
      ProErrorXML('fsbGET_SERVSUSC',L_Payload,L_Payload);
      ---Fin CASO 100-10606
      return L_Payload; --#135387: Se complementa el return
END fsbGET_SERVSUSC;

 PROCEDURE obtenerEstadoCuenta ( inuContrato suscripc.susCcodi%TYPE DEFAULT NULL,
                                 inuProducto  servsusc.sesunuse%TYPE DEFAULT NULL,
                                 onuSaldoPend  OUT CUENCOBR.CUCOSACU%TYPE,
                                 onuPeriodoCant  OUT NUMBER,
                                 onuSaldoAnterior OUT CUENCOBR.CUCOSACU%TYPE,
                                 onuSaldoDiferido OUT DIFERIDO.DIFESAPE%TYPE,
                                 onucodigoError OUT NUMBER,
                                 osbmensaerror OUT VARCHAR2
                                 ) IS
   /*
   * Propiedad Intelectual de gas de caribe
   *
   * Nombre  : obtenerEstadoCuenta
   * Ticket  : 200 1586
   * Autor   : Horbath / Luis Javier Lopez Barrios
   * Fecha   : 26 - 02 -2018
   * Descripcion : Paquete que retorna estado de cuenta del suscriptor

   *Datos de entrada
     inuContrato numero de contrato
     inuProducto  numero de producto

    Datos de salida
     onuSaldoPend       saldo pendiente
     onuPeriodoCant     cantidad de periodos
     onuSaldoAnterior   saldo anterior
     onuSaldoDiferido   Saldo diferido
     onucodigoError     codigo de error 0 - exito -1 - fallo
     osbmensaerror      mensaje de error


   * Historia de Modificaciones
   * Autor                   Fecha         Descripcion
   */

  --TICKET 2001586 LJLB -- se consulta estado de cuenta por contrato
  CURSOR cuEstadoCuenta IS
  SELECT nvl(SUM(SALP),0) SALPEN,
           nvl(SUM(SAL_ANT),0) SAL_ANT
   FROM (
          SELECT  /*+ leading(factura) ndex(factura IX_FACTURA08)
                          use_nl(factura cuencobr)   index(cuencobr IDXCUCO_RELA) */
              CUCOSACU SALP,
              CASE WHEN CUCOFEVE < SYSDATE THEN
                       CUCOSACU - (CASE WHEN CUCOVARE > 0 THEN CUCOVARE ELSE 0 END) - CUCOVRAP
                   ELSE 0
              END SAL_ANT
          from factura, cuencobr
          where   cucofact = factcodi
             and     factsusc = inuContrato
            AND ( nvl(cucosacu,0) - nvl(cucovrap,0) -      ( CASE WHEN cucovare > 0 THEN cucovare ELSE 0 END ) ) > 0 );

  --TICKET 2001586 LJLB -- se consulta estado de cuenta por producto
  CURSOR cuEstadoCuentaNuse IS
  SELECT  sum(CUCOSACU) SALP,
          0 SAL_ANT
  from cuencobr
  where  cuconuse = inuProducto
    AND ( nvl(cucosacu,0) - nvl(cucovrap,0) -      ( CASE WHEN cucovare > 0 THEN cucovare ELSE 0 END ) ) > 0;

  --TICKET 2001586 LJLB -- se consulta saldo diferido por producto
  CURSOR cuSaldDifeNuse  is
  SELECT nvl(sum(d.difesape),0) saldo
  FROM   diferido d
  WHERE  d.difenuse = inuProducto
        And d.difesape > 0;


  --TICKET 2001586 LJLB -- se consulta saldo diferido por contrato
  CURSOR cuSaldDife is
  SELECT nvl(sum(d.difesape),0) saldo
  FROM   diferido d
  WHERE  d.difesusc = inuContrato
        And d.difesape > 0;

  --TICKET 2001586 LJLB -- se consulta periodos vencidos por producto
  CURSOR cuPeriodoCant IS
  SELECT  count(*)
  FROM   factura f, perifact
  WHERE  EXISTS (  SELECT  'X'
                   FROM   cuencobr
                   WHERE  cuencobr.cucofact = f.factcodi
                    AND  (  ( nvl(cuencobr.cucosacu,0) - nvl(cuencobr.cucovrap,0) - CASE WHEN cuencobr.cucovare > 0 THEN cuencobr.cucovare ELSE 0 END ) ) > 0)

    AND f.factsusc = inuContrato
    AND f.factprog = PKBILLCONST.FNUFGCC
    AND f.factpefa = pefacodi
    AND pefafepa < SYSDATE ;

 BEGIN

   onuSaldoPend := 0;
   onuPeriodoCant := 0;
   onuSaldoAnterior := 0;
   onuSaldoDiferido := 0;

   --TICKET 200 1586 LJLB -- se consulta si se procesa por contrato o producto
   IF   inuContrato IS NULL THEN
      open cuEstadoCuentaNuse;
      fetch cuEstadoCuentaNuse into onuSaldoPend,  onuSaldoAnterior;
      if cuEstadoCuentaNuse%notfound then
        onuSaldoPend := 0;
        onuSaldoAnterior := 0;
      end if;
      close cuEstadoCuentaNuse;

      open cuSaldDifeNuse;
      fetch cuSaldDifeNuse into onuSaldoDiferido;
      if cuSaldDifeNuse%notfound then
         onuSaldoDiferido := 0;
      end if;
      close cuSaldDifeNuse;

   ELSE
      open cuEstadoCuenta;
      fetch cuEstadoCuenta into onuSaldoPend,  onuSaldoAnterior;
      if cuEstadoCuenta%notfound then
        onuSaldoPend := 0;
        onuSaldoAnterior := 0;
      end if;
      close cuEstadoCuenta;


      open cuSaldDife;
      fetch cuSaldDife into onuSaldoDiferido;
      if cuSaldDife%notfound then
         onuSaldoDiferido := 0;
      end if;
      close cuSaldDife;
   END IF;

   open cuPeriodoCant;
   fetch cuPeriodoCant into onuPeriodoCant;
   if  cuPeriodoCant%notfound then
       onuPeriodoCant := 0;
   end if;
   close cuPeriodoCant;

   onucodigoError := 0;

  exception
    when others then
         osbmensaerror := 'Error no controlado en obtenerEstadoCuenta '||sqlerrm;
         onucodigoError := 0;

 END obtenerEstadoCuenta;

FUNCTION fsbGET_CARTERA(inuSUSCCODI in NUMBER,inuSESUNUSE in NUMBER,inuORDERID in NUMBER) RETURN CLOB /*CLOB*/ AS
/*
 * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
 *
 * Funcion  : LDCI_PKGESTNOTIORDEN.fsbGET_CARTERA
 * Tiquete : test
 * Autor   : Jose Donado <jdonado@gascaribe.com>
 * Fecha   : 25-06-2014
 * Descripcion : Genera XML con la informaci? del estado de cuenta del suscripor y/o servicio suscrito
 *
 * Historia de Modificaciones
 * Autor                   Fecha         Descripcion
   Jose.Donado             25-06-2014    Creaci? de la Funcion
   JESUS VIVERO (LUDYCOM)  11-03-2015    #143406-20150311: jesusv: se corrige contador de cuentas con saldo
   JESUS VIVERO (LUDYCOM)  19-05-2015    #7171-20150519: jesviv: Se agrega el tipo de cartera
   Jorge Valiente          16/05/2016    CASO 100-10606: * En la condicion Exception se adiciono el llamado del servicio
                                                           ProErrorXML el cual permitira armar la cadena XML con los
                                                           datos -1 y registrar el inconveninete qeu se presento al
                                                           generar la cadena XML por el servicio.
   Nivis Carrasquilla      09/03/2017     Caso 200-900:    Caso de vetados
   ljlb                   26/02/2018    caso 200 1586   se cambia proceso de esta de cuenta de open por uno personalizado

**/

  nuServ                          NUMBER;
  nuSESUNUSE                      NUMBER;

  onuSaldoPendSusc                NUMBER(13,2);
  onuSaldoDiferidoSusc            NUMBER(13,2);
  onuSaldoAnteriorSusc            NUMBER(13,2);
  onuPeriodoCantSusc              NUMBER(4);

  onuSaldoPendSesu                NUMBER(13,2);
  onuSaldoDiferidoSesu            NUMBER(13,2);
  onuSaldoAnteriorSesu            NUMBER(13,2);
  onuPeriodoCantSesu              NUMBER(4);

  sbDiferidos                     VARCHAR2(4000) := '';
  nuCuotaInicial                  NUMBER;
  nuAbonoMinimo                   NUMBER := 0;
  nuCuotaRefiAnt                  NUMBER := 0;
  sbCalculoAutom                  VARCHAR(2);
  sbLecturaSusp                   VARCHAR2(1000);

  sbTrabCart                      LDCI_CARASEWE.CASEVALO%TYPE;
  nuContOTCart                    NUMBER;

  CURSOR cuSERVSUSC(nuServSusc servsusc.sesunuse%type) IS
  SELECT s.sesususc,
         s.sesunuse,
         s.sesuserv
  FROM   servsusc s
  WHERE  s.sesunuse = nuServSusc;

  CURSOR cuSERVSUSC2(nuSusc servsusc.sesususc%type,nuServicio servsusc.sesuserv%TYPE) IS
  SELECT s.sesususc,
         s.sesunuse,
         s.sesuserv
  FROM   servsusc s
  WHERE  s.sesususc = nuSusc
         And s.sesuserv = nuServicio;

  --#143406-20150311: jesusv: (INICIO) Cursor de productos de la subscripcion
  Cursor cuProductos(inuSusc Servsusc.Sesususc%Type) Is
    Select s.Sesususc, s.Sesunuse, s.Sesuserv
    From   Servsusc s
    Where  s.Sesususc = inuSusc;
  --#143406-20150311: jesusv: (FIN) Cursor de productos de la subscripcion

  CURSOR cuDiferidos(nuServSusc diferido.difenuse%type) IS
  SELECT d.difecodi,d.difesape,d.difevacu
  FROM   diferido d
  WHERE  d.difenuse = nuServSusc
        And d.difesape > 0;

  --Cursor para extraer datos de la orden en OSF
  CURSOR cuOrdenOSF(nuOrden or_order.order_id%type) IS
  SELECT o.order_id,o.subscriber_id,o.operating_unit_id,o.order_status_id,o.causal_id,o.task_type_id
  FROM   or_order o
  WHERE  o.order_id = nuOrden;

  --Cursor para obtener la Lectura tomada en la suspension o corte
  CURSOR cuLectura(nuProduct pr_product.product_id%TYPE) IS
  SELECT l.leemleto,l.leemfele
  FROM pr_product p

  INNER JOIN lectelme l
  ON(l.leemdocu = p.suspen_ord_act_id And l.leemclec = 'T')

  WHERE p.product_id = nuProduct;

  --Cursor para obtener el plan de financiacion
  CURSOR cuFinanc(nuOrden NUMBER, nuProducto NUMBER) IS
  SELECT c.product_id,-- AS "idProducto",
         c.debt_age,-- AS "deudaEdad",
         c.total_debt,-- AS "deudaTotal",
         c.outstanding_debt,-- AS "deudaCorrienteNoVencida",
         c.overdue_debt,-- AS "deudaCorrienteVencida",
         c.deferred_debt,-- AS "deudaDiferida",
         c.puni_over_debt,-- AS "deudaCastigada",
         c.refinanci_times,-- AS "refinancUltimoAno",
         c.financing_plan_id,-- AS "idPlanFinanc",
         c.total_debt_current-- AS "deudaTotalCorriente",

  FROM gc_coll_mgmt_pro_det c
  INNER JOIN plandife p
  ON(p.pldicodi = c.financing_plan_id)
  WHERE c.order_id = nuOrden
        And c.product_id = nuProducto;

  --#7171-20150519: jesviv: (INI) Cursor para encontrar el tipo de cartera
  Cursor cuTipoCartera (inuOrder_Id In Number) Is
    Select e.Coll_Mgmt_Proc_Cr_Id, e.Description
    From   Open.GC_Coll_Mgmt_Proc_Crit e, Open.GC_Coll_Mgmt_Pro_Det d
    Where  e.Coll_Mgmt_Proc_Cr_Id = d.Coll_Mgmt_Proc_Cr_Id
    And    d.Order_Id = inuOrder_Id;
  --#7171-20150519: jesviv: (FIN) Cursor para encontrar el tipo de cartera

  rgProductos   cuServSusc%ROWTYPE; --#143406-20150311: jesusv: Se agrega registro de productos para cuentas con saldo
  reSERVSUSC    cuSERVSUSC%ROWTYPE;
  reSERVSUSC2   cuSERVSUSC2%ROWTYPE;
  reOrdenOSF    cuOrdenOSF%ROWTYPE;
  reLectura     cuLectura%ROWTYPE;
  reFinanc      cuFinanc%ROWTYPE;
  rgTipoCartera cuTipoCartera%RowType; --#7171-20150519: jesviv: Registra el tipo de cartera

  TYPE T_CURSOR IS REF CURSOR;
  cuPlanFinanc T_CURSOR;
  --cuConceptos  T_CURSOR;

 L_Payload     CLOB;
 L_Payload2    CLOB;
 L_Payload3    CLOB;
 L_Payload4    CLOB;
 --l_response    CLOB;
 qryCtx        DBMS_XMLGEN.ctxHandle;
 qryCtx2       DBMS_XMLGEN.ctxHandle;
 qryCtx3       DBMS_XMLGEN.ctxHandle;
 qryCtx4       DBMS_XMLGEN.ctxHandle;

  --Variables de manejo de error
  excepCartSusc       EXCEPTION;
  excepCartSesu       EXCEPTION;
  onuErrorCode        ge_error_log.error_log_id%type;
  osbErrorMessage     ge_error_log.description%type;
  errorGetParam       EXCEPTION;

BEGIN

  --Se obtiene el listado de tipos de trabajo de gestion de cartera
  LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_SIMOCAR', 'OT_CARTERA', sbTrabCart, osbErrorMessage);
  IF osbErrorMessage != '0' THEN
     RAISE errorGetParam;
  END IF;

    --Se obtiene el valor minimo de abono
  LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_SIMOCAR', 'ABONO_MINIMO', nuAbonoMinimo, osbErrorMessage);
  IF osbErrorMessage != '0' THEN
     RAISE errorGetParam;
  END IF;

  --Se obtiene el parametro de calculo automatico
  LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_SIMOCAR', 'CALCULO_AUTOMATICO', sbCalculoAutom, osbErrorMessage);
  IF osbErrorMessage != '0' THEN
     RAISE errorGetParam;
  END IF;

  nuSESUNUSE := inuSESUNUSE;

  IF inuSUSCCODI IS NOT NULL THEN
    --TICKET 200 1586 LJLB -- se reemplaza el proceso OS_GETSUBSCRIPBALANCE por el personalizado obtenerEstadoCuenta
    --Obtiene informaci? del estado de cuenta del suscriptor
   /* OS_GETSUBSCRIPBALANCE(INUSUBSCRIPTIONID => inuSUSCCODI,
                          INUPRODUCTTYPE => NULL,
                          ONUOUTSTANDBALANCE => onuSaldoPendSusc,
                          ONUDEFERREDBALANCE => onuSaldoDiferidoSusc,
                          ONUEXPIREDBALANCE => onuSaldoAnteriorSusc,
                          ONUEXPIREDPERIODS => onuPeriodoCantSusc,
                          ONUERRORCODE => onuErrorCode,
                          OSBERRORMESSAGE => osbErrorMessage);*/
    obtenerEstadoCuenta ( inuContrato => inuSUSCCODI,
                           onuSaldoPend => onuSaldoPendSusc,
                           onuPeriodoCant => onuPeriodoCantSusc,
                           onuSaldoAnterior=> onuSaldoAnteriorSusc,
                           onuSaldoDiferido => onuSaldoDiferidoSusc,
                           onucodigoError => onuErrorCode,
                           osbmensaerror  => osbErrorMessage
                           );

    IF onuErrorCode <> 0 THEN
      RAISE excepCartSusc;
    END IF;

    --#143406-20150311: jesusv: (INICIO) Se agrega contador de cuentas con saldo por cada producto de la subscripcion
    onuPeriodoCantSusc := 0;

    For rgProductos In cuProductos(inuSuscCodi) Loop
      onuPeriodoCantSusc := Nvl(onuPeriodoCantSusc, 0) + pkBcCuenCobr.fnuGetBalAccNum(rgProductos.Sesunuse);
    End Loop;
    --#143406-20150311: jesusv: (FIN) Se agrega contador de cuentas con saldo por cada producto de la subscripcion

    --Si se recibe el numero de servicio nulo, se busca el servicio principal(gas)
    IF nuSESUNUSE IS NULL THEN
      --parametro para obtener el codigo del servicio de gas
      nuServ := DALD_PARAMETER.fnuGetNumeric_Value('COD_TIPO_SERV',NULL);

      OPEN cuSERVSUSC2(inuSUSCCODI,nuServ);
      FETCH cuSERVSUSC2 INTO reSERVSUSC2;
      CLOSE cuSERVSUSC2;

      nuSESUNUSE := reSERVSUSC2.Sesunuse;
    END IF;

 END IF;


  IF nuSESUNUSE IS NOT NULL THEN

    IF nuServ IS NULL THEN
      -- Abre el registro del servicio
      OPEN cuSERVSUSC(nuSESUNUSE);
      FETCH cuSERVSUSC INTO reSERVSUSC;
      CLOSE cuSERVSUSC;

      nuServ := reSERVSUSC.Sesuserv;

    END IF;

    --Obtiene informaci? del estado de cuenta del servicio suscrito
   /* OS_GETSUBSCRIPBALANCE(INUSUBSCRIPTIONID => inuSUSCCODI,
                          INUPRODUCTTYPE => nuServ,
                          ONUOUTSTANDBALANCE => onuSaldoPendSesu,
                          ONUDEFERREDBALANCE => onuSaldoDiferidoSesu,
                          ONUEXPIREDBALANCE => onuSaldoAnteriorSesu,
                          ONUEXPIREDPERIODS => onuPeriodoCantSesu,
                          ONUERRORCODE => onuErrorCode,
                          OSBERRORMESSAGE => osbErrorMessage);*/
     obtenerEstadoCuenta ( inuProducto => nuSESUNUSE,
                           onuSaldoPend => onuSaldoPendSesu,
                           onuPeriodoCant => onuPeriodoCantSesu,
                           onuSaldoAnterior=> onuSaldoAnteriorSesu,
                           onuSaldoDiferido => onuSaldoDiferidoSesu,
                           onucodigoError => onuErrorCode,
                           osbmensaerror  => osbErrorMessage
                           );
    IF onuErrorCode <> 0 THEN
      RAISE excepCartSesu;
    END IF;

    onuPeriodoCantSesu := pkBcCuenCobr.fnuGetBalAccNum(nuSesuNuse); --#143406-20150311: jesusv: Se agrega funcion que retorna el numero de cuentas con saldo del producto

 END IF;

  --#7171-20150519: (INI) jesviv: Se consulta el tipo de cartera
  Open cuTipoCartera(inuOrderId);
  Fetch cuTipoCartera Into rgTipoCartera;
  Close cuTipoCartera;
  --#7171-20150519: (FIN) jesviv: Se consulta el tipo de cartera

    -- Genera el mensaje XML
   Qryctx :=  Dbms_Xmlgen.Newcontext ('SELECT nvl(:nuSUSCCODI,-1) AS "idContrato",
                                               Nvl(:nuIdTipoCartera, -1) AS "idTipoCartera",
                                               Nvl(:sbDescTipoCartera, -1) AS "descTipoCartera",
                                               :nuSaldoPendSusc AS "saldoPendiente",
                                               :nuSaldoDiferidoSusc AS "saldoDiferido",
                                               :nuSaldoAnteriorSusc AS "saldoAnterior",
                                               :nuPeriodoCantSusc AS "cuentasPendientes",
                                               CURSOR(
                                               SELECT nvl(:nuSESUNUSE,-1) AS "idProducto",
                                                      :nuSaldoPendSesu AS "saldoPendiente",
                                                      :nuSaldoDiferidoSesu AS "saldoDiferido",
                                                      :nuSaldoAnteriorSesu AS "saldoAnterior",
                                                      :nuPeriodoCantSesu AS "cuentasPendientes"
                                               FROM DUAL) AS "CarteraServicio",
                                               ''CuentasCobro'' as "CuentasCobro",
                                               ''financiacion'' as "financiacion",
                                               ''conceptos'' as "conceptos"
                                     FROM   DUAL'); --#7171-20150519: Se agregan los nuevos campos

    DBMS_XMLGEN.setBindvalue (qryCtx, 'nuSUSCCODI', inuSUSCCODI);
    DBMS_XMLGEN.setBindvalue (qryCtx, 'nuIdTipoCartera', rgTipoCartera.Coll_Mgmt_Proc_Cr_Id); --#7171-20150519: Se asigna el identificador del tipo de cartera
    DBMS_XMLGEN.setBindvalue (qryCtx, 'sbDescTipoCartera', rgTipoCartera.Description); --#7171-20150519: Se agrega la descripcion del tipo de cartera
    DBMS_XMLGEN.setBindvalue (qryCtx, 'nuSaldoPendSusc', onuSaldoPendSusc);
    DBMS_XMLGEN.setBindvalue (qryCtx, 'nuSaldoDiferidoSusc', onuSaldoDiferidoSusc);
    DBMS_XMLGEN.setBindvalue (qryCtx, 'nuSaldoAnteriorSusc', onuSaldoAnteriorSusc);
    DBMS_XMLGEN.setBindvalue (qryCtx, 'nuPeriodoCantSusc', onuPeriodoCantSusc);

    DBMS_XMLGEN.setBindvalue (qryCtx, 'nuSESUNUSE', nuSESUNUSE);
    DBMS_XMLGEN.setBindvalue (qryCtx, 'nuSaldoPendSesu', onuSaldoPendSesu);
    DBMS_XMLGEN.setBindvalue (qryCtx, 'nuSaldoDiferidoSesu', onuSaldoDiferidoSesu);
    DBMS_XMLGEN.setBindvalue (qryCtx, 'nuSaldoAnteriorSesu', onuSaldoAnteriorSesu);
    DBMS_XMLGEN.setBindvalue (qryCtx, 'nuPeriodoCantSesu', onuPeriodoCantSesu);

    DBMS_XMLGEN.SETNULLHANDLING(Qryctx,2);

   Dbms_Xmlgen.setRowSetTag(Qryctx, '');
    DBMS_XMLGEN.setRowTag(qryCtx, 'Cartera');
    --Genera el XML
    L_Payload := DBMS_XMLGEN.getXML(qryCtx);

    --Cierra el contexto
    DBMS_XMLGEN.closeContext(qryCtx);

    Qryctx2 :=  Dbms_Xmlgen.Newcontext('SELECT c.cucocodi AS "idCuentaCobro",
                                               c.cucosacu AS "saldoCuentaCobro"
                                        FROM   cuencobr c
                                        WHERE  c.cuconuse = :nuServSusc
                                               And c.cucosacu > 0');

    DBMS_XMLGEN.setBindvalue (Qryctx2, 'nuServSusc', nuSESUNUSE);

    DBMS_XMLGEN.SETNULLHANDLING(Qryctx2,2);
    DBMS_XMLGEN.setRowSetTag(Qryctx2, 'CuentasCobro');
    DBMS_XMLGEN.setRowTag(Qryctx2, 'Cuenta');

    --Genera el XML
    L_Payload2:= DBMS_XMLGEN.getXML(qryCtx2);

    --Cierra el contexto
    DBMS_XMLGEN.closeContext(qryCtx2);

    --Se valida que la orden sea de gestion de cartera para enviar la informacion de financiacion
    OPEN cuOrdenOSF(inuORDERID);
    FETCH cuOrdenOSF INTO reOrdenOSF;
    CLOSE cuOrdenOSF;

    --Valida que el tipo de trabajo sea de gestion de cartera
    SELECT count(*)
    INTO nuContOTCart
    FROM DUAL
    WHERE reOrdenOSF.Task_Type_Id IN(
             SELECT regexp_substr(sbTrabCart,'[^|]+', 1, LEVEL) FROM dual
             CONNECT BY regexp_substr(sbTrabCart, '[^|]+', 1, LEVEL) IS NOT NULL);

    IF (nuContOTCart > 0) THEN

      FOR rgDiferidos IN cuDiferidos(nuSESUNUSE) LOOP
        sbDiferidos := sbDiferidos || rgDiferidos.difecodi || '|';
        nuCuotaRefiAnt := nuCuotaRefiAnt + rgDiferidos.Difevacu;
      END LOOP;

      sbDiferidos := SUBSTR(sbDiferidos,1,LENGTH(sbDiferidos)-1);

      --Obtener lectura de corte
      OPEN cuLectura(nuSESUNUSE);
      FETCH cuLectura INTO reLectura;
      CLOSE cuLectura;

      IF reLectura.Leemleto IS NOT NULL THEN
        sbLecturaSusp := 'LECTURA DE CORTE: ' || reLectura.Leemleto || ' - FECHA DE LECTURA: ' || to_char(reLectura.Leemfele, 'YYYY-MM-DD HH24:MI:SS');
      ELSE
        sbLecturaSusp := '';
      END IF;
      --

      --Obtener informacion de la Financiacion
      OPEN cuFinanc(inuORDERID,nuSESUNUSE);
      FETCH cuFinanc INTO reFinanc;

      IF cuFinanc%NOTFOUND THEN
        qryCtx3 := DBMS_XMLGEN.NewContext('SELECT -1 AS "idProducto",
                                                  -1 AS "deudaEdad",
                                                  -1 AS "deudaTotal",
                                                  -1 AS "deudaCorrienteNoVencida",
                                                  -1 AS "deudaCorrienteVencida",
                                                  -1 AS "deudaDiferida",
                                                  -1 AS "deudaCastigada",
                                                  -1 AS "refinancUltimoAno",
                                                  -1 AS "idPlanFinanc",
                                                  -1 AS "deudaTotalCorriente",
                                                  -1 AS "diferidosConSaldo",
                                                  -1 AS "cuotaInicial",
                                                  -1 AS "abonoMinimo",
                                                  -1 AS "cuotaRefiAnterior",
                                                  -1 AS "calculoAutomatico",
                                                  -1 AS "lecturaSuspension",
                                                 ''N''  AS "puedeRefinanciar"
                                            FROM dual ');

        Dbms_Xmlgen.setRowSetTag(qryCtx3, null);
        Dbms_Xmlgen.setRowTag(qryCtx3, 'Refinanciacion');
        L_Payload3 := DBMS_XMLGEN.getXML(qryCtx3);
      ELSE
        sp_getdebtneginiquota(
                        reFinanc.Financing_Plan_Id, -- Plan de Acuerdo de Pago
                        'P',     -- Nivel de la negociacion ('P' - Producto)
                        inuSUSCCODI,  -- Contrato
                        reFinanc.Product_Id,   -- Producto
                        nuCuotaInicial   -- Salida: Cuota Inicial
                     );
        nuCuotaInicial := nvl(nuCuotaInicial,0);

        OPEN cuPlanFinanc FOR
        SELECT reFinanc.product_id AS "idProducto",
               reFinanc.debt_age AS "deudaEdad",
               reFinanc.total_debt AS "deudaTotal",
               reFinanc.outstanding_debt AS "deudaCorrienteNoVencida",
               reFinanc.overdue_debt AS "deudaCorrienteVencida",
               reFinanc.deferred_debt AS "deudaDiferida",
               reFinanc.puni_over_debt AS "deudaCastigada",
               reFinanc.refinanci_times AS "refinancUltimoAno",
               reFinanc.financing_plan_id AS "idPlanFinanc",
               reFinanc.total_debt_current AS "deudaTotalCorriente",
               sbDiferidos AS "diferidosConSaldo",
               nuCuotaInicial AS "cuotaInicial",
               nuAbonoMinimo AS "abonoMinimo",
               nuCuotaRefiAnt AS "cuotaRefiAnterior",
               sbCalculoAutom AS "calculoAutomatico",
               sbLecturaSusp AS "lecturaSuspension",
                --fsbRefinancia(inuORDERID) as "puedeRefinanciar"
               LDC_VALFINPLAREFI.fsbRefinanciaM(inuORDERID) as "puedeRefinanciar" -- CA200900
        FROM DUAL;

        qryCtx3 := DBMS_XMLGEN.NewContext(cuPlanFinanc);

        DBMS_XMLGEN.SETNULLHANDLING(qryCtx3,2);
        Dbms_Xmlgen.setRowSetTag(qryCtx3, null);
        Dbms_Xmlgen.setRowTag(qryCtx3, 'Refinanciacion');

        L_Payload3 := DBMS_XMLGEN.getXML(qryCtx3);

        CLOSE cuPlanFinanc;

      END IF;
      --Fin

/*      OPEN cuPlanFinanc FOR
      SELECT c.product_id AS "idProducto",
             c.debt_age AS "deudaEdad",
             c.total_debt AS "deudaTotal",
             c.outstanding_debt AS "deudaCorrienteNoVencida",
             c.overdue_debt AS "deudaCorrienteVencida",
             c.deferred_debt AS "deudaDiferida",
             c.puni_over_debt AS "deudaCastigada",
             c.refinanci_times AS "refinancUltimoAno",
             c.financing_plan_id AS "idPlanFinanc",
             c.total_debt_current AS "deudaTotalCorriente",
             sbDiferidos AS "diferidosConSaldo",
             nuCuotaInicial AS "cuotaInicial",
             nuAbonoMinimo AS "abonoMinimo",
             nuCuotaRefiAnt AS "cuotaRefiAnterior",
             sbCalculoAutom AS "calculoAutomatico",
             sbLecturaSusp AS "lecturaSuspension"
      FROM gc_coll_mgmt_pro_det c
      INNER JOIN plandife p
      ON(p.pldicodi = c.financing_plan_id)
      WHERE c.order_id = inuORDERID
            And c.product_id = nuSESUNUSE;

      qryCtx3 := DBMS_XMLGEN.NewContext(cuPlanFinanc);

      DBMS_XMLGEN.SETNULLHANDLING(qryCtx3,2);
      Dbms_Xmlgen.setRowSetTag(qryCtx3, null);
      Dbms_Xmlgen.setRowTag(qryCtx3, 'Refinanciacion');

      L_Payload3 := DBMS_XMLGEN.getXML(qryCtx3);

      --Valida si proceso registros
      if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx3) = 0) then
        qryCtx3 := DBMS_XMLGEN.NewContext('SELECT -1 AS "idProducto",
                                                  -1 AS "deudaEdad",
                                                  -1 AS "deudaTotal",
                                                  -1 AS "deudaCorrienteNoVencida",
                                                  -1 AS "deudaCorrienteVencida",
                                                  -1 AS "deudaDiferida",
                                                  -1 AS "deudaCastigada",
                                                  -1 AS "refinancUltimoAno",
                                                  -1 AS "idPlanFinanc",
                                                  -1 AS "deudaTotalCorriente",
                                                  -1 AS "diferidosConSaldo",
                                                  -1 AS "cuotaInicial",
                                                  -1 AS "abonoMinimo",
                                                  -1 AS "cuotaRefiAnterior",
                                                  -1 AS "calculoAutomatico",
                                                  -1 AS "lecturaSuspension"
                                            FROM dual ');

        Dbms_Xmlgen.setRowSetTag(qryCtx3, null);
        Dbms_Xmlgen.setRowTag(qryCtx3, 'Refinanciacion');
        L_Payload3 := DBMS_XMLGEN.getXML(qryCtx3);
      end if;*/

      CLOSE cuFinanc;


      --L_Payload4 := fsbGET_CONCEPTOS(nuSESUNUSE);
      proConceptos(nuSESUNUSE,L_Payload4);

    ELSE
        qryCtx3 := DBMS_XMLGEN.NewContext('SELECT -1 AS "idProducto",
                                                  -1 AS "deudaEdad",
                                                  -1 AS "deudaTotal",
                                                  -1 AS "deudaCorrienteNoVencida",
                                                  -1 AS "deudaCorrienteVencida",
                                                  -1 AS "deudaDiferida",
                                                  -1 AS "deudaCastigada",
                                                  -1 AS "refinancUltimoAno",
                                                  -1 AS "idPlanFinanc",
                                                  -1 AS "deudaTotalCorriente",
                                                  -1 AS "diferidosConSaldo",
                                                  -1 AS "cuotaInicial",
                                                  -1 AS "abonoMinimo",
                                                  -1 AS "cuotaRefiAnterior",
                                                  -1 AS "calculoAutomatico",
                                                  -1 AS "lecturaSuspension",
                                                  ''N'' AS "puedeRefinanciar"
                                            FROM dual ');

        Dbms_Xmlgen.setRowSetTag(qryCtx3, null);
        Dbms_Xmlgen.setRowTag(qryCtx3, 'Refinanciacion');
        L_Payload3 := DBMS_XMLGEN.getXML(qryCtx3);

        --

        qryCtx4 := DBMS_XMLGEN.NewContext('SELECT -1 AS "idConcepto",
                                                  -1 AS "presenteMes",
                                                  -1 AS "vencido",
                                                  -1 AS "diferido"
                                           FROM DUAL');

        Dbms_Xmlgen.setRowSetTag(qryCtx4, 'Conceptos');
        Dbms_Xmlgen.setRowTag(qryCtx4, 'Concepto');
        L_Payload4 := DBMS_XMLGEN.getXML(qryCtx4);
    END IF;

    --Cierra el contexto
    DBMS_XMLGEN.closeContext(qryCtx3);
    DBMS_XMLGEN.closeContext(qryCtx4);


    --Imprime el XML
    L_Payload := Replace(L_Payload, '<?xml version="1.0"?>');
    L_Payload2 := Replace(L_Payload2, '<?xml version="1.0"?>');
    L_Payload3 := Replace(L_Payload3, '<?xml version="1.0"?>');
    L_Payload4 := Replace(L_Payload4, '<?xml version="1.0"?>');
    L_Payload := Replace(L_Payload, '<CarteraServicio_ROW>');
    L_Payload := Replace(L_Payload, '</CarteraServicio_ROW>');

    L_Payload := Replace(L_Payload, '</CarteraServicio_ROW>');

    L_Payload := replace(L_Payload, '<CuentasCobro>CuentasCobro</CuentasCobro>',L_Payload2);
    L_Payload := replace(L_Payload, '<financiacion>financiacion</financiacion>',L_Payload3);
    L_Payload := replace(L_Payload, '<conceptos>conceptos</conceptos>',L_Payload4);

    return L_Payload;

EXCEPTION
  WHEN errorGetParam THEN
    L_Payload := '<Cartera><programa>LDCI_PKGESTNOTIORDEN_1.fsbGET_CARTERA</programa>
    <errorGetParam>' || OSBERRORMESSAGE || '</errorGetParam></Cartera>' ;
    ---Inicio CASO 100-10606
    ProErrorXML('fsbGET_CARTERA',L_Payload,L_Payload);
    ---Fin CASO 100-10606
    return L_Payload; --#135387: Se complementa el return
  WHEN excepCartSusc THEN
    L_Payload := '<Cartera><programa>LDCI_PKGESTNOTIORDEN_1.fsbGET_CARTERA</programa>
    <excepCartSusc>' || OSBERRORMESSAGE || '</excepCartSusc></Cartera>' ;
    ---Inicio CASO 100-10606
    ProErrorXML('fsbGET_CARTERA',L_Payload,L_Payload);
    ---Fin CASO 100-10606
    return L_Payload; --#135387: Se complementa el return
  WHEN excepCartSesu THEN
    L_Payload := '<Cartera><programa>LDCI_PKGESTNOTIORDEN_1.fsbGET_CARTERA</programa>
    <excepCartSesu>' || OSBERRORMESSAGE || '</excepCartSesu></Cartera>' ;
    ---Inicio CASO 100-10606
    ProErrorXML('fsbGET_CARTERA',L_Payload,L_Payload);
    ---Fin CASO 100-10606
    return L_Payload; --#135387: Se complementa el return
  WHEN OTHERS THEN
    L_Payload := '<Cartera><programa>LDCI_PKGESTNOTIORDEN_1.fsbGET_CARTERA</programa>
    <others>' || SQLERRM || '</others></Cartera>' ;
    ---Inicio CASO 100-10606
    ProErrorXML('fsbGET_CARTERA',L_Payload,L_Payload);
    ---Fin CASO 100-10606
    return L_Payload; --#135387: Se complementa el return
END fsbGET_CARTERA;

FUNCTION fsbGET_LECTURAS(inuSESUNUSE in NUMBER) RETURN CLOB /*CLOB*/ AS

/*
 * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
 *
 * Funcion  : LDCI_PKGESTNOTIORDEN.fsbGET_LECTURAS
 * Tiquete : test
 * Autor   : Jose Donado <jdonado@gascaribe.com>
 * Fecha   : 28-05-2014
 * Descripcion : Genera XML a partir de la obtenci? de datos de LECTURAS
 *
 * Historia de Modificaciones
 * Autor                    Fecha             Descripcion
   Jose.Donado              26-05-2014        Creaci? de la Funcion
   JESUS VIVERO (LUDYCOM)   16-01-2015        --#20150116: jesusv: agrega validacion para seleccionar solo el medidor activo
   Karem Baquero(sincecmop) 11/06/2015        --#7298: Se modifica la generaci?n del XML de lectura
                                              ya que se cambi? la estructura.
   Karem Baquero(sincecmop) 16/06/2015        --#7298: Se modifica la generaci?n del XML para agregar
                                              el datalle de consumos.
   Karem Baquero(sincecmop) 23/07/2015        --#157820: Se modifica la generaci?n del XML para agregar
                                              el datalle de consumos.
   Jorge Valiente           16/05/2016        CASO 100-10606: * En la condicion Exception se adiciono el llamado del servicio
                                                                ProErrorXML el cual permitira armar la cadena XML con los
                                                                datos -1 y registrar el inconveninete qeu se presento al
                                                                generar la cadena XML por el servicio.
**/


  L_Payload     CLOB;
  L_Payload2    CLOB;
  L_Payloadcons    CLOB;
  --l_response    CLOB;
  qryCtx        DBMS_XMLGEN.ctxHandle;
  qryCtx2       DBMS_XMLGEN.ctxHandle;
  qryCtxcons    DBMS_XMLGEN.ctxHandle;

  --Variables de manejo de error
  excepNoProcesoRegi EXCEPTION;  -- Excepcion que valida si proceso registros la consulta
  errGetLect          EXCEPTION;
  onuErrorCode        ge_error_log.error_log_id%type;
  osbErrorMessage     ge_error_log.description%type;
  inucantcons         number:=1;
  inucantlect         number:=1;
  presion             number;
  temperatura         number;
  consumoPromedio     number;
  orfcursorcons       SYS_REFCURSOR;
  inususc             suscripc.susccodi%type;

  rfLecturas          Constants.tyRefCursor;
  rfConsumos          Constants.tyRefCursor;



  -- variables para la asignacion del cursor
  TYPE refRegistros is REF CURSOR ;
  Recregistros Refregistros;

BEGIN

  IF inuSESUNUSE IS NOT NULL THEN

    inucantlect:=dald_parameter.fnuGetNumeric_Value('CANT_LECTU_BUSCAR',null);

    -- Se buscan las lecturas
    Open rfLecturas For
     select leemleto As "valorLectura",
       leemfele As "fechaLectura",
       leempefa As "periFactLect",
       open.pktblperifact.fsbgetdescription(leempefa) As "descPeriFactLec",
       LEEMPECS As "periConsumo",
       LEEMELME As "elementoMedicion",
       nvl(LEEMOBLE, -1) As "observacionLectura1",
       open.pktblobselect.fsbgetdescription(nvl(LEEMOBLE, -1)) As "descObservacionLectura1",
       open.pktblobselect.fsbgetoblecanl(nvl(LEEMOBLE, -1)) As "flagCausaNoLect1",
       nvl(LEEMOBSB, -1) As "observacionLectura2",
       open.pktblobselect.fsbgetdescription(nvl(LEEMOBSB, -1)) As "descObservacionLectura2",
       open.pktblobselect.fsbgetoblecanl(nvl(LEEMOBSB, -1)) As "flagCausaNoLect2",
       nvl(LEEMOBSC, -1) As "observacionLectura3",
       open.pktblobselect.fsbgetdescription(nvl(LEEMOBSC, -1)) As "descObservacionLectura3",
       open.pktblobselect.fsbgetoblecanl(nvl(LEEMOBSC, -1)) As "flagCausaNoLect3"
  from (Select t.leemleto,
               t.leemfele,
               t.leempefa,
               open.pktblperifact.fsbgetdescription(t.leempefa),
               t.LEEMPECS,
               t.LEEMELME,
               nvl(LEEMOBLE, -1) LEEMOBLE,
               open.pktblobselect.fsbgetdescription(nvl(t.LEEMOBLE, -1)),
               open.pktblobselect.fsbgetoblecanl(nvl(t.LEEMOBLE, -1)),
               nvl(LEEMOBSB, -1) LEEMOBSB,
               open.pktblobselect.fsbgetdescription(nvl(t.LEEMOBSB, -1)),
               open.pktblobselect.fsbgetoblecanl(nvl(t.LEEMOBSB, -1)),
               nvl(LEEMOBSC, -1) LEEMOBSC,
               open.pktblobselect.fsbgetdescription(nvl(t.LEEMOBSC, -1)),
               open.pktblobselect.fsbgetoblecanl(nvl(t.LEEMOBSC, -1))
          From open.LECTELME t
          Left Join open.elmesesu m
            ON (m.emsssesu = t.leemsesu And
               Nvl(m.Emssfere, Trunc(Sysdate)) >= Trunc(Sysdate))
         Where t.leemsesu = inuSESUNUSE --35000025
           And leemclec = 'F'
           And leemfele >= ADD_MONTHS(SYSDATE, -inucantlect)
         Order By leemfele Desc)
 where rownum <= inucantlect;

    qryCtx :=  DBMS_XMLGEN.NewContext(rfLecturas);



  ELSE
    qryCtx :=  DBMS_XMLGEN.NewContext('select -1 as "valorLectura",
                                              -1 as "fechaLectura",
                                              -1 as "periFactLect",
                                              -1 as "descPeriFactLec",
                                              -1 as "periConsumo",
                                              -1 as "elementoMedicion",
                                              -1 as "observacionLectura1",
                                              -1 as "descObservacionLectura1",
                                              -1 as "flagCausaNoLect1",
                                              -1 as "observacionLectura2",
                                              -1 as "descObservacionLectura2",
                                              -1 as "flagCausaNoLect2",
                                              -1 as "observacionLectura3",
                                              -1 as "descObservacionLectura3",
                                              -1 as "flagCausaNoLect3"
                                       from   dual');
   --  reSERVSUSC.Emsscoem := NULL;

  END IF;

  DBMS_XMLGEN.SETNULLHANDLING(qryCtx,2);

  Dbms_Xmlgen.setRowSetTag(Qryctx, 'DetalleLecturas');
  Dbms_Xmlgen.setRowTag(Qryctx, 'Lectura');


  --Genera el XML
  L_Payload := DBMS_XMLGEN.getXML(qryCtx);

  --Valida si proceso registros
  if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then
    RAISE excepNoProcesoRegi;
  end if;

  --Cierra el contexto
  DBMS_XMLGEN.closeContext(qryCtx);


  /*Se obtiene el contrato*/
  inususc := dapr_product.fnugetsubscription_id(inuSESUNUSE, null);

  /*Se obtienen los datos de los consumos*/
  if inususc is not null  and inuSESUNUSE is not null then

    /*Se obtiene el parametro de cuantos consumo se van a extraer*/
    inucantcons:=dald_parameter.fnuGetNumeric_Value('CANT_CONS_BUSCAR',null);

    proDatosConsumoHist(inuSESUNUSE,inususc,inucantcons, presion,temperatura,consumoPromedio,orfcursorcons);

    Qryctx2 :=  DBMS_XMLGEN.NewContext('select ' || Nvl(consumoPromedio, -1) || ' as "consumoPromedio",
                                               ' || Nvl(temperatura, -1) || ' as "temperatura",
                                               ' || Nvl(presion, -1) || ' as "presion",
                                               ''consumo'' as "consumo"
                                        from   dual');
  ELSE
    Qryctx2 :=  DBMS_XMLGEN.NewContext('select -1 as "consumoPromedio",
                                               -1 as "temperatura",
                                               -1 as "presion",
                                               ''consumo'' as "consumo"
                                        from   dual');

  end if;

  Dbms_Xmlgen.setRowSetTag(qryCtx2, '');
  Dbms_Xmlgen.setRowTag(qryCtx2, 'Consumos');

  --Genera el XML
  L_Payload2:= DBMS_XMLGEN.getXML(qryCtx2);


  --Valida si proceso LECTURAS
  if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx2) = 0) then
    RAISE excepNoProcesoRegi;
    -- L_Payload2 := '<Consumo><Lectura><SBCONSTYPE>-1</SBCONSTYPE><DTLASTREADDATE>1999-01-01</DTLASTREADDATE><NULASTREAD>-1</NULASTREAD><SBLASTCOMMENT>-1</SBLASTCOMMENT><DTREADDATE>1999-01-01</DTREADDATE><NUREAD>-1</NUREAD><SBCOMMENT>-1</SBCOMMENT></Lectura></detalleLecturas>';
  end if;
  --Cierra el contexto
  DBMS_XMLGEN.closeContext(qryCtx2);





  qryCtxcons:=  DBMS_XMLGEN.NewContext(orfcursorcons);


  DBMS_XMLGEN.SETNULLHANDLING(qryCtxcons,2);

  Dbms_Xmlgen.setRowSetTag(qryCtxcons, 'DetalleConsumos');
  DBMS_XMLGEN.setRowTag(qryCtxcons, 'Consumo');

  --Genera el XML
  L_Payloadcons:= DBMS_XMLGEN.getXML(qryCtxcons);


  --Valida si proceso CONSUMOS
  if(DBMS_XMLGEN.getNumRowsProcessed(qryCtxcons) = 0) then
    --RAISE excepNoProcesoRegi;
    L_Payloadcons := '<Consumo><valorConsumo>-1</valorConsumo><fechaConsumo>-1</fechaConsumo><tipoConsumo>-1</tipoConsumo><periFact>-1</periFact><descPerifact>-1</descPerifact></Consumo>';
  end if;

  DBMS_XMLGEN.closeContext(qryCtxcons);



  --Imprime el XML
  L_Payload := Replace(L_Payload, '<?xml version="1.0"?>');
  L_Payload2 := Replace(L_Payload2, '<?xml version="1.0"?>');
  L_Payloadcons := Replace(L_Payloadcons, '<?xml version="1.0"?>');
  L_Payloadcons := Replace(L_Payloadcons, '<DetalleConsumos>');
   L_Payloadcons := Replace(L_Payloadcons, '</DetalleConsumos>');


  L_Payload2 := replace(L_Payload2, '<consumo>consumo</consumo>',L_Payloadcons);
  L_Payload := trim(L_Payload) || trim(L_Payload2);

  return L_Payload;

exception
  when excepNoProcesoRegi then
    L_Payload := '<Lecturas><DetalleLecturas><Lectura><programa>LDCI_PKGESTNOTIORDEN.fsbGET_LECTURAS</programa>
    <excepNoProcesoRegi>No proceso registros ...</excepNoProcesoRegi></Lectura></DetalleLecturas></Lecturas>' ;
    ---Inicio CASO 100-10606
    ProErrorXML('fsbGET_LECTURAS',L_Payload,L_Payload);
    ---Fin CASO 100-10606
    return L_Payload; --#135387: Se complementa el return
  when errGetLect then
    L_Payload := '<Lecturas><DetalleLecturas><Lectura><programa>LDCI_PKGESTNOTIORDEN.fsbGET_LECTURAS</programa>
    <errGetLect>' || osbErrorMessage || '</errGetLect></Lectura></DetalleLecturas></Lecturas>' ;
    ---Inicio CASO 100-10606
    ProErrorXML('fsbGET_LECTURAS',L_Payload,L_Payload);
    ---Fin CASO 100-10606
    return L_Payload; --#135387: Se complementa el return
  when others then
    L_Payload := '<Lecturas><DetalleLecturas><Lectura><programa>LDCI_PKGESTNOTIORDEN.fsbGET_LECTURAS</programa>
    <others>' || SQLERRM || '</others></Lectura></DetalleLecturas></Lecturas>' ;
    ---Inicio CASO 100-10606
    ProErrorXML('fsbGET_LECTURAS',L_Payload,L_Payload);
    ---Fin CASO 100-10606
    return L_Payload; --#135387: Se complementa el return
END fsbGET_LECTURAS;

FUNCTION fsbGET_PREDIO(inuPRODUCT_ID in NUMBER) RETURN VARCHAR2 /*CLOB*/ AS

/*
 * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
 *
 * Funcion  : LDCI_PKGESTNOTIORDEN.fsbGET_PREDIO
 * Tiquete : test
 * Autor   : Jose Donado <jdonado@gascaribe.com>
 * Fecha   : 14-05-2014
 * Descripcion : Genera XML a partir de la obtenci? de datos del PREDIO
 *
 * Historia de Modificaciones
 * Autor                                           Fecha      Descripcion
 * Jose.Donado                                     28-05-2014 Creaci? de la Funcion
 * Carlos E. Virgen <carlos.virgen@olsoftware.com> 06-01-2015 #135387: Carga DBMS_XMLGEN con Cursor referenciado.
   Jorge Valiente                                  16/05/2016 CASO 100-10606: * En la condicion Exception se adiciono el llamado del servicio
                                                                                ProErrorXML el cual permitira armar la cadena XML con los
                                                                                datos -1 y registrar el inconveninete qeu se presento al
                                                                                generar la cadena XML por el servicio.
**/
  sbTag         VARCHAR2(15);
  nuCoordXGeo   NUMBER;
  nuCoordYGeo   NUMBER;
  nuCoordXPln   NUMBER;
  nuCoordYPln   NUMBER;
  rfConsulta SYS_REFCURSOR; --#135387:06-01-2015: Se agrega variable de cursor referenciado.


  CURSOR cuPredio(nuPRODUCT_ID PR_PRODUCT.PRODUCT_ID%TYPE) IS
  select A.ADDRESS_ID as idDireccion,
         A.SEGMENT_ID as IdSegmento,
         A.ADDRESS as direccion,
         S.BLOCK_ID as consecutivoManzana,
         S.BLOCK_SIDE  ladoManzana,
         S.GEOGRAP_LOCATION_ID as ubicacionGeografica,
         A.NEIGHBORTHOOD_ID as idBarrio
  from   PR_PRODUCT P
  inner join AB_ADDRESS A
  on(A.ADDRESS_ID = P.ADDRESS_ID)
  inner join AB_SEGMENTS S
  on(S.SEGMENTS_ID = A.SEGMENT_ID)
  where  P.PRODUCT_ID = nuPRODUCT_ID;

  -- tipo registro
  rePredio          cuPredio%ROWTYPE;

 L_Payload     CLOB;
 --l_response    CLOB;
 qryCtx        DBMS_XMLGEN.ctxHandle;

  --Variables de manejo de error
 excepNoProcesoRegi EXCEPTION;  -- Excepcion que valida si proceso registros la consulta
  --onuErrorCode        ge_error_log.error_log_id%type;
  --osbErrorMessage     ge_error_log.description%type;


BEGIN
--dbms_output.put_line('[fsbGET_PREDIO ] inuPRODUCT_ID ' || inuPRODUCT_ID);
  IF (inuPRODUCT_ID IS NOT NULL AND inuPRODUCT_ID <> 0) THEN

    -- Abre el registro del servicio
    open cuPredio(inuPRODUCT_ID);
    fetch cuPredio into rePredio;
    close cuPredio;


    IF (rePredio.Iddireccion IS NOT NULL) THEN
       BEGIN
       GISCARIBE.GIS_INFOCOORDPREDIO@DB_GISCAR(un_AddressId => rePredio.Iddireccion,
                                                  un_Tag => sbTag,
                                                  una_CoordXGeo => nuCoordXGeo,
                                                  una_CoordYGeo => nuCoordYGeo,
                                                  una_CoordXPln => nuCoordXPln,
                                                  una_CoordYPln => nuCoordYPln);
       EXCEPTION WHEN OTHERS THEN
         sbTag   := -1;
         nuCoordXGeo := -1;
         nuCoordYGeo := -1;
         nuCoordXPln := -1;
         nuCoordYPln := -1;
       END;

    END IF;

  open rfConsulta for --#135387:06-01-2015: Se carga cursor referenciado
   SELECT rePredio.Iddireccion as "idDireccion",
      NVL(rePredio.Idsegmento,-1) as "idSegmento",
      NVL(rePredio.Direccion,-1) as "direccion",
      NVL(rePredio.Consecutivomanzana,-1) as "consecutivoManzana",
      NVL(rePredio.Ladomanzana,-1) as "ladoManzana",
      NVL(rePredio.Ubicaciongeografica,-1) as "ubicacionGeografica",
      NVL(rePredio.Idbarrio,-1) as "idBarrio",
      sbTag as "tag",
      nuCoordXGeo as "coordenadaXGeo",
      nuCoordYGeo as "coordenadaYGeo",
      nuCoordXPln as "coordenadaXPln",
      nuCoordYPln as "coordenadaYPln"
   FROM   DUAL;
    qryCtx :=  DBMS_XMLGEN.NewContext(rfConsulta);  --#135387:06-01-2015: Se inicializa el contexto XML

  /*#135387:06-01-2015: Se desactiva el codigo anterior
    qryCtx :=  DBMS_XMLGEN.NewContext ('SELECT ' || rePredio.Iddireccion || ' as "idDireccion",
                                             ' || NVL(rePredio.Idsegmento,-1) || ' as "idSegmento",
                                             ''' || NVL(rePredio.Direccion,-1) || ''' as "direccion",
                                             ' || NVL(rePredio.Consecutivomanzana,-1) || ' as "consecutivoManzana",
                                             ''' || NVL(rePredio.Ladomanzana,-1) || '''  "ladoManzana",
                                             ' || NVL(rePredio.Ubicaciongeografica,-1) || ' as "ubicacionGeografica",
                                             ' || NVL(rePredio.Idbarrio,-1) || ' as "idBarrio",
                                             ''' || sbTag || ''' as "tag",
                                             ''' || nuCoordXGeo || ''' as "coordenadaXGeo",
                                             ''' || nuCoordYGeo || ''' as "coordenadaYGeo",
                                             ''' || nuCoordXPln || ''' as "coordenadaXPln",
                                             ''' || nuCoordYPln || ''' as "coordenadaYPln"
                                 FROM   DUAL');*/
  ELSE
    qryCtx :=  DBMS_XMLGEN.NewContext ('SELECT -1 as "idDireccion",
                                             -1 as "idSegmento",
                                             -1 as "direccion",
                                             -1 as "consecutivoManzana",
                                             -1  "ladoManzana",
                                             -1 as "ubicacionGeografica",
                                             -1 as "idBarrio",
                                             -1 as "tag",
                                             -1 as "coordenadaXGeo",
                                             -1 as "coordenadaYGeo",
                                             -1 as "coordenadaXPln",
                                             -1 as "coordenadaYPln"
                                 FROM   DUAL');
  END IF;

    DBMS_XMLGEN.SETNULLHANDLING(qryCtx,2);
    Dbms_Xmlgen.setRowSetTag(Qryctx, '');
    DBMS_XMLGEN.setRowTag(qryCtx, 'Predio');
    --Genera el XML
    L_Payload := DBMS_XMLGEN.getXML(qryCtx);


    --Valida si proceso registros
    if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then
         RAISE excepNoProcesoRegi;
    end if;--if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then

    --Cierra el contexto
    DBMS_XMLGEN.closeContext(qryCtx);

    --Imprime el XML
    L_Payload := Replace(L_Payload, '<?xml version="1.0"?>');

  return L_Payload;
exception
  when excepNoProcesoRegi then
      L_Payload := '<Predios><Predio><programa>LDCI_PKGESTNOTIORDEN.fsbGET_PREDIO</programa>
      <excepNoProcesoRegi>No proceso registros ...</excepNoProcesoRegi></Predio></Predios>' ;
      ---Inicio CASO 100-10606
      ProErrorXML('fsbGET_PREDIO',L_Payload,L_Payload);
      ---Fin CASO 100-10606
    return L_Payload; --#135387: Se complementa el return
  when others then
      L_Payload := '<Predios><Predio><programa>LDCI_PKGESTNOTIORDEN.fsbGET_PREDIO</programa>
      <others>' || SQLERRM || '</others></Predio></Predios>' ;
      ---Inicio CASO 100-10606
      ProErrorXML('fsbGET_PREDIO',L_Payload,L_Payload);
      ---Fin CASO 100-10606
    return L_Payload; --#135387: Se complementa el return
END fsbGET_PREDIO;


Function fsbGET_SOLICITUD(inuPackageId In Number, inuMotiveID In Number) Return CLOB As

  /*
  * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
  *
  * Funcion     : LDCI_PKGESTNOTIORDEN.fsbGET_SOLICITUD
  * Tiquete     : test
  * Autor       : Ludycom / jesus.vivero <jesus.vivero@ludycom.com>
  * Fecha       : 28-05-2014
  * Descripcion : Genera XML a partir de una solicitud
  *
  * Historia de Modificaciones
  * Autor                     Fecha        Descripcion
  * JESUS VIVERO (LUDYCOM)    28-05-2014   Se crea funcion
  * JESUS VIVERO (LUDYCOM)    28-01-2015   #20150202: jesusv: Se cambia query a cursor referenciado
    Jorge Valiente            16/05/2016   CASO 100-10606: * En la condicion Exception se adiciono el llamado del servicio
                                                             ProErrorXML el cual permitira armar la cadena XML con los
                                                             datos -1 y registrar el inconveninete qeu se presento al
                                                             generar la cadena XML por el servicio.

  **/

  -- Cursor para buscar la informacion de la solicitud
  Cursor Cu_Solicitud Is
    Select mp.Package_Id,
           mp.Package_Type_Id,
           pp.Description Desc_Package_Type,
           pm.Description Desc_Motive_Type,
           mm.Motive_Id,
           pm.Motive_Type_Id,
           mp.Contact_Id,
           mm.priority,
           ge_boemergencyorders.fsbvalidatecharactersxml(mp.Comment_) Comment_   --#8335: KarBaq: Se agregael llamado ala funci?n de caracteres especiales
           --mp.Comment_
    From   Mo_Packages mp Inner Join Mo_Motive mm       On mp.Package_Id      = mm.Package_Id
                          Inner Join Ps_Package_Type pp On mp.Package_Type_Id = pp.Package_Type_Id
                          Inner Join Ps_Motive_Type pm  On mm.Motive_Type_Id  = pm.Motive_Type_Id
    Where  mp.Package_Id = inuPackageId
    And    mm.Motive_Id  = inuMotiveID;

  -- Cursor para buscar la informacion del contacto de la solicitud (Persona que reporta)
  Cursor Cu_Contact (inuContactId In Number) Is
    Select s.Subscriber_Id,
           s.Identification,
           Trim(s.Subscriber_Name || ' ' || s.Subs_Last_Name || ' ' || s.Subs_Second_Last_Name) Contact,
           /*s.Subscriber_Name,
           s.Subs_Last_Name,
           s.Subs_Second_Last_Name,*/
           s.Phone
    From   Ge_Subscriber s
    Where  s.Subscriber_Id = inuContactId;

  -- Registros de datos
  rgSolicitud Cu_Solicitud%RowType;
  rgContact   Cu_Contact%RowType;
  rfConsulta  Sys_RefCursor; --#20150202: jesusv: Se agrega variable de cursor referenciado.

  -- Variables para generar el XML
  L_Payload     Clob;
  qryCtx        Dbms_XMLGen.ctxHandle;
  --sbSqlContact  Varchar2(2000);

  --Variables de manejo de error
  excepNoProcesoRegi Exception;  -- Excepcion que valida si proceso registros la consulta

Begin

  If (inuPackageId Is Not Null And inuMotiveID Is Not Null) Then

    -- Se busca la informacion de la solicitud
    Open Cu_Solicitud;
    Fetch Cu_Solicitud Into rgSolicitud;
    Close Cu_Solicitud;

    -- Se busca informacion de contacto
    Open Cu_Contact(rgSolicitud.Contact_Id);
    Fetch Cu_Contact Into rgContact;
    Close Cu_Contact;

    Open rfConsulta For Select Nvl(rgSolicitud.Package_Id, -1) As "idSolicitud", --#20150202: jesusv: se agrega cursor referenciado
                               Nvl(rgSolicitud.Desc_Package_Type, -1) As "descSolicitud",
                               Nvl(rgSolicitud.Motive_Id, -1) As "idMotivo",
                               Nvl(rgSolicitud.Motive_Type_Id, -1) As "tipoMotivo",
                               Nvl(rgSolicitud.Desc_Motive_Type, -1) As "descMotivo",
                               Nvl(rgContact.Subscriber_Id, -1) As "idSubscriptor",
                               Nvl(rgContact.Identification, -1) As "identificacion",
                               Nvl(rgContact.Contact, -1) As "contacto",
                               Nvl(rgContact.Phone, -1) As "telefono",
                               Nvl(rgSolicitud.priority, -1) As "idPrioridad",
                               Nvl(rgSolicitud.Comment_ , -1) As "observacion"
                        From   Dual;

    qryCtx :=  DBMS_XMLGEN.NewContext(rfConsulta);  --#20150202: jesusv: Se inicializa el contexto XML

    /* #20150202: jesusv: Se quita segmento de codigo y se agrega cursor referenciado
    -- Se construye el query para generar el XML
    If rgContact.Subscriber_Id Is Not Null Then

      sbSqlContact := To_Char(rgContact.Subscriber_Id) || ' As "idSubscriptor",
                      ''' || rgContact.Identification || ''' As "identificacion",
                      ''' || rgContact.Contact || ''' As "contacto",
                      ''' || rgContact.Phone || ''' As "telefono",';

    Else

      sbSqlContact := '-1 As "idSubscriptor",
                       -1 As "identificacion",
                       -1 As "contacto",
                       -1 As "telefono",';

    End If;

    qryCtx :=  Dbms_XMLGen.NewContext ('Select ' || rgSolicitud.Package_Id || ' As "idSolicitud",
                                               ''' || rgSolicitud.Desc_Package_Type || ''' As "descSolicitud",
                                               ' || rgSolicitud.Motive_Id || ' As "idMotivo",
                                               ' || rgSolicitud.Motive_Type_Id || ' As "tipoMotivo",
                                               ''' || rgSolicitud.Desc_Motive_Type || ''' As "descMotivo",
                                               ' || sbSqlContact || '
                                               ' || rgSolicitud.priority || ' As "idPrioridad",
                                               ''' || rgSolicitud.Comment_ || ''' As "observacion"
                                        From   Dual');
    */

  Else

    qryCtx :=  Dbms_XMLGen.NewContext ('Select -1 As "idSolicitud",
                                               -1 As "descSolicitud",
                                               -1 As "idMotivo",
                                               -1 As "tipoMotivo",
                                               -1 As "descMotivo",
                                               -1 As "idSubscriptor",
                                               -1 As "identificacion",
                                               -1 As "contacto",
                                               -1 As "telefono",
                                               -1 As "idPrioridad",
                                               -1 As "observacion"
                                        From   Dual');

  End If;

  Dbms_XMLGen.SetNullHandling(qryCtx,2);

  Dbms_XMLGen.setRowSetTag(qryCtx, '');
  Dbms_XMLGen.setRowTag(qryCtx, 'Solicitud');

  -- Se genera el XML
  L_Payload := Dbms_XMLGen.GetXML(qryCtx);

  -- Se valida si proceso registros
  If (Dbms_XMLGen.getNumRowsProcessed(qryCtx) = 0) Then
    Raise excepNoProcesoRegi;
  End If; --If (Dbms_XMLGen.getNumRowsProcessed(qryCtx) = 0) Then

  -- Se cierra el contexto
  Dbms_XMLGen.closeContext(qryCtx);

  -- Se imprime el XML
  L_Payload := Replace(L_Payload, '<?xml version="1.0"?>');

  -- Se retorna el XML generado
  Return L_Payload;

-- Manejo de Excepciones
Exception
  When excepNoProcesoRegi Then
    L_Payload := '<Solicitud><programa>LDCI_PKGESTNOTIORDEN.fsbGET_SOLICITUD</programa>
    <excepNoProcesoRegi>No proceso registros ...</excepNoProcesoRegi></Solicitud>';
    ---Inicio CASO 100-10606
    ProErrorXML('fsbGET_SOLICITUD',L_Payload,L_Payload);
    ---Fin CASO 100-10606
    Return L_Payload;
  When Others Then
    L_Payload := '<Solicitud><programa>LDCI_PKGESTNOTIORDEN.fsbGET_SOLICITUD</programa>
    <others>' || SqlErrM || '</others></Solicitud>';
    ---Inicio CASO 100-10606
    ProErrorXML('fsbGET_SOLICITUD',L_Payload,L_Payload);
    ---Fin CASO 100-10606
    Return L_Payload;
End fsbGET_SOLICITUD;


Function fsbGET_CONTACTOS(inuSubscriberID In Number, inuProducID In Number) Return CLOB As

  /*
  * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
  *
  * Funcion     : LDCI_PKGESTNOTIORDEN.fsbGET_CONTACTOS
  * Tiquete     : test
  * Autor       : Ludycom / jesus.vivero <jesus.vivero@ludycom.com>
  * Fecha       : 30-07-2014
  * Descripcion : Genera XML de contactos asociados a un producto
  *
  * Historia de Modificaciones
  * Autor                   Fecha         Descripcion
  * JESUS VIVERO (LUDYCOM)  05-05-2015    #150395-20150505: jesviv: Se cambia etiqueta de XML "idProdPago" (Errada) por "idProducto" (Correcta)
    Jorge Valiente          16/05/2016    CASO 100-10606: * En la condicion Exception se adiciono el llamado del servicio
                                                            ProErrorXML el cual permitira armar la cadena XML con los
                                                            datos -1 y registrar el inconveninete qeu se presento al
                                                            generar la cadena XML por el servicio.
  **/

  -- Cursor para buscar la informacion del contacto de la solicitud (Persona que reporta)
  Cursor Cu_Product (inuIdSubscriptor In Number) Is
    Select p.Product_Id
    From   Pr_Product p Inner Join Suscripc s On p.Subscription_Id = s.Susccodi
    Where  p.Product_Type_Id = Dald_Parameter.fnuGetNumeric_Value('COD_TIPO_SERV', Null)
    And    s.Suscclie        = inuIdSubscriptor;

  -- Variables
  nuIdProducto Number;

  -- Registros de datos
  --rgSolicitud Cu_Solicitud%RowType;
  --rgContact   Cu_Contact%RowType;

  -- Variables para generar el XML
  L_Payload     Clob;
  qryCtx        Dbms_XMLGen.ctxHandle;

  --Variables de manejo de error
  excepNoProcesoRegi Exception;  -- Excepcion que valida si proceso registros la consulta

Begin

  If inuSubscriberID Is Not Null Then

    If inuProducID Is Null Then

      -- Se busca informacion de contacto
      Open Cu_Product(inuSubscriberID);
      Fetch Cu_Product Into nuIdProducto;
      Close Cu_Product;

    Else

      nuIdProducto := inuProducID;

    End If;

    -- Se construye el query para generar el XML
    qryCtx := Dbms_XMLGen.NewContext ('Select p.Product_Id As "idProducto",
                                              p.Subscriber_Id As "idContacto",
                                              p.Role_Id As "idRol",
                                              s.Identification As "identificacion",
                                              s.Subscriber_Name ||'' ''|| s.Subs_Last_Name ||'' ''|| s.Subs_Second_Last_Name As "nombre",
                                              a.Address As "direccion",
                                              s.Phone As "telefono"
                                       From   Pr_Subs_Type_Prod p Inner Join Ge_Subscriber s On (p.Subscriber_Id = s.Subscriber_Id)
                                                                  Inner Join Ab_Address a On (s.Address_Id = a.Address_Id)
                                       Where  p.Product_Id = :inuIdProducto
                                       Group By p.Product_Id,
                                                p.Subscriber_Id,
                                                p.Role_Id,
                                                s.Identification,
                                                s.Subscriber_Name ||'' ''|| s.Subs_Last_Name ||'' ''|| s.Subs_Second_Last_Name,
                                                a.Address,
                                                s.Phone'
                                     );
    Dbms_XMLGen.SetBindValue (qryCtx, 'inuIdProducto', nuIdProducto);

  Else

    qryCtx := Dbms_XMLGen.NewContext ('Select -1 As "idProducto",
                                              -1 As "idContacto",
                                              -1 As "idRol",
                                              -1 As "identificacion",
                                              -1 As "nombre",
                                              -1 As "direccion",
                                              -1 As "telefono"
                                       From   Dual'
                                     );

  End If; --If inuSubscriberID Is Not Null Then

  Dbms_XMLGen.SetNullHandling(qryCtx,2);

  Dbms_XMLGen.setRowSetTag(qryCtx, 'Contactos');
  Dbms_XMLGen.setRowTag(qryCtx, 'Contacto');

  -- Se genera el XML
  L_Payload := Dbms_XMLGen.GetXML(qryCtx);

  -- Se valida si proceso registros
  If Dbms_XMLGen.getNumRowsProcessed(qryCtx) = 0 Then
    --Raise excepNoProcesoRegi;
    L_Payload := '<Contacto><idProducto>-1</idProducto><idContacto>-1</idContacto><idRol>-1</idRol><identificacion>-1</identificacion><nombre>-1</nombre><direccion>-1</direccion><telefono>-1</telefono></Contacto>';  --#150395-20150505: jesviv.
  End If; --If Dbms_XMLGen.getNumRowsProcessed(qryCtx) = 0 Then

  -- Se cierra el contexto
  Dbms_XMLGen.closeContext(qryCtx);

  -- Se imprime el XML
  L_Payload := Replace(L_Payload, '<?xml version="1.0"?>');
  L_Payload := Replace(L_Payload, '<Contactos>');
  L_Payload := Replace(L_Payload, '</Contactos>');

  -- Se retorna el XML generado
  Return L_Payload;

-- Manejo de Excepciones
Exception
  When excepNoProcesoRegi Then
    L_Payload := '<Solicitud><programa>LDCI_PKGESTNOTIORDEN.fsbGET_CONTACTOS</programa>
    <excepNoProcesoRegi>No proceso registros ...</excepNoProcesoRegi></Solicitud>';
    ---Inicio CASO 100-10606
    ProErrorXML('fsbGET_CONTACTOS',L_Payload,L_Payload);
    ---Fin CASO 100-10606
    Return L_Payload;
  When Others Then
    L_Payload := '<Solicitud><programa>LDCI_PKGESTNOTIORDEN.fsbGET_CONTACTOS</programa>
    <others>' || SqlErrM || '</others></Solicitud>';
    ---Inicio CASO 100-10606
    ProErrorXML('fsbGET_CONTACTOS',L_Payload,L_Payload);
    ---Fin CASO 100-10606
    Return L_Payload;
End fsbGET_CONTACTOS;

Function fsbGET_PAGOS(inuSubscripcion In Number, inuUltimosPagos In Number) Return CLOB As

  /*
  * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
  *
  * Funcion     : LDCI_PKGESTNOTIORDEN.fsbGET_PAGOS
  * Tiquete     : #7876
  * Autor       : Ludycom / jesus.vivero <jesus.vivero@ludycom.com>
  * Fecha       : 11-06-2015
  * Descripcion : Genera XML de informacion de ultimos pagos asocidos a un contrato
  *
  * Historia de Modificaciones
  * Autor                   Fecha         Descripcion
  * JESUS VIVERO (LUDYCOM)  11-06-2015    #7876-20150611: jesviv: Se crea funcion
    Jorge Valiente          16/05/2016    CASO 100-10606: * En la condicion Exception se adiciono el llamado del servicio
                                                            ProErrorXML el cual permitira armar la cadena XML con los
                                                            datos -1 y registrar el inconveninete qeu se presento al
                                                            generar la cadena XML por el servicio.
  **/

  -- Variables para generar el XML
  L_Payload     Clob;
  qryCtx        DBMS_XMLGEN.ctxHandle;

Begin

  If inuSubscripcion Is Not Null Then

    -- Se construye el query para generar el XML
    qryCtx := DBMS_XMLGEN.NewContext ('Select Pagoconc "conciliacion",
                                              Pagofepa "fechaPago",
                                              Pagovapa "valor",
                                              Pagofegr "fechaGrabacion",
                                              Pagocupo "cupon"
                                       From   (Select ROW_NUMBER() Over (Partition By Pagosusc Order By Pagofepa Desc) Numero,
                                                      Pagoconc, Pagofepa, Pagovapa, Pagofegr, Pagocupo
                                               From   Pagos
                                               Where  Pagosusc = :inuSubscripcion
                                              ) x
                                       Where  x.Numero <= :inuUltimosPagos'
                                     );

    DBMS_XMLGEN.SetBindValue (qryCtx, 'inuSubscripcion', inuSubscripcion);
    DBMS_XMLGEN.SetBindValue (qryCtx, 'inuUltimosPagos', inuUltimosPagos);

  Else

    qryCtx := DBMS_XMLGEN.NewContext ('Select -1 As "conciliacion",
                                              -1 As "fechaPago",
                                              -1 As "valor",
                                              -1 As "fechaGrabacion",
                                              -1 As "cupon"
                                       From   Dual'
                                     );

  End If; --If inuSubscriberID Is Not Null Then

  DBMS_XMLGEN.SetNullHandling(qryCtx, 2);

  DBMS_XMLGEN.setRowSetTag(qryCtx, 'Pagos');
  DBMS_XMLGEN.setRowTag(qryCtx, 'DetallePago');

  -- Se genera el XML
  L_Payload := DBMS_XMLGEN.GetXML(qryCtx);

  -- Se valida si proceso registros
  If DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0 Then
    L_Payload := '<Pagos><DetallePago><conciliacion>-1</conciliacion><fechaPago>-1</fechaPago><valor>-1</valor><fechaGrabacion>-1</fechaGrabacion><cupon>-1</cupon></DetallePago></Pagos>';
  End If; --If Dbms_XMLGen.getNumRowsProcessed(qryCtx) = 0 Then

  -- Se cierra el contexto
  DBMS_XMLGEN.closeContext(qryCtx);

  -- Se imprime el XML
  L_Payload := Replace(L_Payload, '<?xml version="1.0"?>');
  L_Payload := Replace(L_Payload, '<Pagos>');
  L_Payload := Replace(L_Payload, '</Pagos>');

  -- Se retorna el XML generado
  Return L_Payload;

-- Manejo de Excepciones
Exception
  When Others Then
    L_Payload := '<DetallePago><programa>LDCI_PKGESTNOTIORDEN.fsbGET_PAGOS</programa>
    <others>' || SqlErrM || '</others></DetallePago>';
    ---Inicio CASO 100-10606
    ProErrorXML('fsbGET_PAGOS',L_Payload,L_Payload);
    ---Fin CASO 100-10606
    Return L_Payload;
End fsbGET_PAGOS;

FUNCTION fsbGET_PERILECT(inuORDERID in NUMBER) RETURN VARCHAR2 /*CLOB*/ AS

/*
 * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
 *
 * Funcion  : LDCI_PKGESTNOTIORDEN.fsbGET_PERILECT
 * Tiquete : test
 * Autor   : OLSoftware / carlos.virgen <carlos.virgen@olsoftware.com>
 * Fecha   : 14-05-2014
 * Descripcion : Genera XML a partir de la obtenci? de datos del periodo de lectura y el numero
                 de digitos del medidor (necesarios para Sigelec pero se enviara para todos
                 los sistems (PC_200-988)
 *
 * Historia de Modificaciones
 * Autor          Fecha      Descripcion
 * F.Castro  11-01-2017 Version inicial


**/
  --nuRuta                      NUMBER(15);
  --nuConsecRuta                NUMBER(10);
 TYPE refRegistros is REF CURSOR ;
 Resultado Number(18) := -1;
 Msj Varchar2(200) := '';
 Recregistros Refregistros;
 reg LDCI_ACTIVIDADORDEN%Rowtype;

 Nuorder_Activity_Id Ldci_Actividadorden.Order_Activity_Id%Type;
 Nuconsecutive       Ldci_Actividadorden.Consecutive%Type;
 Nuactivity_Id       Ldci_Actividadorden.Activity_Id%Type;
 Nuaddress_Id        Ldci_Actividadorden.Address_Id%Type;
 Sbaddress           Ldci_Actividadorden.Address%Type;
 Sbsubscriber_Name   Ldci_Actividadorden.Subscriber_Name%Type;
 Nuproduct_Id        Ldci_Actividadorden.Product_Id%Type;
 Sbservice_Number    Ldci_Actividadorden.Service_Number%Type;
 Sbmeter             Ldci_Actividadorden.Meter%Type;
 Nuproduct_Status_Id Ldci_Actividadorden.Product_Status_Id%Type;
 Nusubscription_Id   Ldci_Actividadorden.Subscription_Id%Type;
 Nucategory_Id       Ldci_Actividadorden.Category_Id%Type;
 Nusubcategory_Id    Ldci_Actividadorden.Subcategory_Id%Type;
 Nucons_Cycle_Id     Ldci_Actividadorden.Cons_Cycle_Id%Type;
 Nucons_Period_Id    Ldci_Actividadorden.Cons_Period_Id%Type;
 Nubill_Cycle_Id     Ldci_Actividadorden.Bill_Cycle_Id%Type;
 Nubill_Period_Id    Ldci_Actividadorden.Bill_Period_Id%Type;
 Nuparent_Product_Id Ldci_Actividadorden.Parent_Product_Id%Type;
 Sbparent_Address_Id Ldci_Actividadorden.Parent_Address_Id%Type;
 Sbparent_Address    Ldci_Actividadorden.Parent_Address%Type;
 Sbcausal            Ldci_Actividadorden.Causal%Type;
 Nucons_Type_Id      Ldci_Actividadorden.Cons_Type_Id%Type;
 Numeter_Location    Ldci_Actividadorden.Meter_Location%Type;
 Nudigit_Quantity    Ldci_Actividadorden.Digit_Quantity%Type;
 Nulimit             Ldci_Actividadorden.Limit%Type;
 Sbretry             Ldci_Actividadorden.Retry%Type;
 Nuaverage           Ldci_Actividadorden.Average%Type;
 Nulast_Read         Ldci_Actividadorden.Last_Read%Type;
 Dtlast_Read_Date    Ldci_Actividadorden.Last_Read_Date%Type;
 Nuobservation_A     Ldci_Actividadorden.Observation_A%Type;
 Nuobservation_B     Ldci_Actividadorden.Observation_B%Type;
 NUObservation_C     Ldci_Actividadorden.Observation_C%TYPE;
------------
 nuanofac            perifact.pefaano%type;
 numesfac            perifact.pefames%type;
------------

 L_Payload     CLOB;
 --l_response    CLOB;
 qryCtx        DBMS_XMLGEN.ctxHandle;

  --Variables de manejo de error
 excepNoProcesoRegi EXCEPTION;  -- Excepcion que valida si proceso registros la consulta
  --onuErrorCode        ge_error_log.error_log_id%type;
  --osbErrorMessage     ge_error_log.description%type;

  CURSOR cuperifac (nupefa perifact.pefacodi%TYPE) IS
  SELECT pefaano, pefames
  FROM perifact
  WHERE pefacodi = nupefa;



BEGIN

   OS_GETORDERACTIVITIES(inuOrderId, Recregistros, Resultado, Msj);
   If Resultado = 0 Then
      Fetch  Recregistros  Into Nuorder_Activity_Id, Nuconsecutive, Nuactivity_Id, Nuaddress_Id, Sbaddress,
                                  Sbsubscriber_Name, Nuproduct_Id, Sbservice_Number, Sbmeter, Nuproduct_Status_Id, Nusubscription_Id,
                                  Nucategory_Id, Nusubcategory_Id, Nucons_Cycle_Id, Nucons_Period_Id, Nubill_Cycle_Id, Nubill_Period_Id,
                                  Nuparent_Product_Id, Sbparent_Address_Id, Sbparent_Address, Sbcausal, Nucons_Type_Id, Numeter_Location,
                                  Nudigit_Quantity, Nulimit, Sbretry, Nuaverage, Nulast_Read, Dtlast_Read_Date,
                                  NUObservation_A, NUObservation_B, NUObservation_C;
      Close Recregistros;
   else
     Nudigit_Quantity := null;
     Nubill_Period_Id := null;
   end if;

   if Nubill_Period_Id is not null then
     open cuperifac(Nubill_Period_Id);
     fetch cuperifac into nuanofac, numesfac;
     close cuperifac;
   else
     nuanofac := null;
     numesfac := null;
   end if;

  IF Nubill_Period_Id IS NOT NULL THEN

    qryCtx :=  DBMS_XMLGEN.NewContext ('select ' || nvl(nuanofac,-1) ||' as "anoFact",
                                               ' || nvl(numesfac,-1) ||' as "mesFact",
                                               ' || nvl(Nubill_Period_Id,-1) ||' as "idPeriodoFact",
                                               ' || nvl(Nudigit_Quantity,-1) ||' as "digitosMed"
                                        from dual');

   ------------- DBMS_XMLGEN.setBindvalue (qryCtx, 'inuSUSCCODI', inuSUSCCODI);

  ELSE
    qryCtx :=  DBMS_XMLGEN.NewContext ('select -1 as "anoFact",
                                               -1 as "mesFact",
                                               -1 as "idPeriodoFact",
                                               -1 as "digitosMed"
                                   from DUAL');
  END IF;

    DBMS_XMLGEN.SETNULLHANDLING(qryCtx,2);

    Dbms_Xmlgen.setRowSetTag(Qryctx, '');
    DBMS_XMLGEN.setRowTag(qryCtx, 'Contrato');
    --Genera el XML
    L_Payload := DBMS_XMLGEN.getXML(qryCtx);

    --Valida si proceso registros
    if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then
         RAISE excepNoProcesoRegi;
    end if;--if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then

  --Cierra el contexto
    DBMS_XMLGEN.closeContext(qryCtx);

  --Imprime el XML
    L_Payload := Replace(L_Payload, '<?xml version="1.0"?>');
    --#TODO drop_line dbms_output.PUT_LINE('L_Payload ' || chr(13) || L_Payload);

  return L_Payload;
exception
  when excepNoProcesoRegi then
      L_Payload := '<Contratos><Contrato><programa>LDCI_PKGESTNOTIORDEN_1.fsbGET_PERILECT</programa>
      <excepNoProcesoRegi>No proceso registros ...</excepNoProcesoRegi></Contrato></Contratos>' ;
    ---Inicio CASO 100-10606
    ProErrorXML('fsbGET_SUSCRIPC',L_Payload,L_Payload);
    ---Fin CASO 100-10606
    return L_Payload; --#135387: Se complementa el return
  when others then
      L_Payload := '<Contratos><Contrato><programa>LDCI_PKGESTNOTIORDEN_1.fsbGET_PERILECT</programa>
      <others>' || SQLERRM || '</others></Contrato></Contratos>' ;
    ---Inicio CASO 100-10606
    ProErrorXML('fsbGET_PERILECT',L_Payload,L_Payload);
    ---Fin CASO 100-10606
    return L_Payload; --#135387: Se complementa el return
END fsbGET_PERILECT;

PROCEDURE proConceptos(inuProducID in NUMBER,onuXML out VARCHAR2) AS
  /*
 * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
 *
 * Funcion  : LDCI_PKGESTNOTIORDEN.fsbGET_CONCEPTOS
 * Tiquete : test
 * Autor   : Jose Donado <jdonado@gascaribe.com>
 * Fecha   : 26-09-2014
 * Descripcion : Genera XML de conceptos a partir del producto ingresado
 *
 * Historia de Modificaciones
 * Autor          Fecha      Descripcion
   Jose.Donado    26-09-2014 Creacion de la Funcion
   Jorge Valiente 16/05/2016 CASO 100-10606: * En la condicion Exception se adiciono el llamado del servicio
                                               ProErrorXML el cual permitira armar la cadena XML con los
                                               datos -1 y registrar el inconveninete qeu se presento al
                                               generar la cadena XML por el servicio.
**/
  onuCurrentAccountTotal    NUMBER;
  onuDeferredAccountTotal   NUMBER;
  onuCreditBalance          NUMBER;
  onuClaimValue             NUMBER;
  onuDefClaimValue          NUMBER;
  otbBalanceAccounts        fa_boaccountstatustodate.tytbBalanceAccounts;
  otbDeferredBalance        fa_boaccountstatustodate.tytbDeferredBalance;
  pos                       VARCHAR2(1000);
  conta                     NUMBER := 1;

  nuPresente                NUMBER(13,2) := 0;
  nuVencido                 NUMBER(13,2) := 0;
  nuDiferido                NUMBER(13,2) := 0;

  L_Payload     Clob;
  qryCtx        Dbms_XMLGen.ctxHandle;

  /*CURSOR cuConceptos(nuConcepto NUMBER) IS
  SELECT C.CONCEPTO,C.PRESENTE_MES,C.VENCIDO,C.DIFERIDO
  FROM   LDCI_TMP_CONCEPTOS C
  WHERE  C.CONCEPTO = nuConcepto;*/

  /*CURSOR cuConceptos2 IS
  SELECT C.CONCEPTO,C.PRESENTE_MES,C.VENCIDO,C.DIFERIDO
  FROM   LDCI_TMP_CONCEPTOS C;*/

  --rgConceptos cuConceptos%rowtype;
  --rgConceptos2 cuConceptos2%rowtype;

  TYPE T_CURSOR IS REF CURSOR;
  cuConcept  T_CURSOR;

Begin
/*    fa_boaccountstatustodate.ProductBalanceAccountsToDate
    (
    inuProducID,
    SYSDATE,
    onuCurrentAccountTotal,
    onuDeferredAccountTotal,
    onuCreditBalance,
    onuClaimValue,
    onuDefClaimValue,
    otbBalanceAccounts,
    otbDeferredBalance
    );

    --Recorre la cartera vencida
    pos:= otbBalanceAccounts.first;

    WHILE pos IS NOT NULL LOOP
      nuPresente := 0;
      nuVencido  := 0;

      IF otbBalanceAccounts(pos).cucodive = 0 THEN
        nuPresente := otbBalanceAccounts(pos).saldvalo;
        nuVencido  := 0;
      ELSE
        nuPresente := 0;
        nuVencido  := otbBalanceAccounts(pos).saldvalo;
      END IF;

      OPEN cuConceptos(otbBalanceAccounts(pos).conccodi);
      FETCH cuConceptos INTO rgConceptos;

      IF cuConceptos%notfound THEN
        INSERT INTO LDCI_TMP_CONCEPTOS(CONCEPTO,PRESENTE_MES,VENCIDO,DIFERIDO)
        VALUES(otbBalanceAccounts(pos).conccodi,nuPresente,nuVencido,0);
      ELSE
        UPDATE LDCI_TMP_CONCEPTOS
        SET    PRESENTE_MES = nuPresente + rgConceptos.PRESENTE_MES,
               VENCIDO      = nuVencido + rgConceptos.VENCIDO
        WHERE  CONCEPTO = otbBalanceAccounts(pos).conccodi;
      END IF;

      CLOSE cuConceptos;

      pos := otbBalanceAccounts.next(pos);
    END loop;

    --Recorre la cartera diferida
    pos:= otbDeferredBalance.first;

    WHILE pos IS NOT NULL LOOP
      nuDiferido := otbDeferredBalance(pos).saldvalo;

      OPEN cuConceptos(otbDeferredBalance(pos).conccodi);
      FETCH cuConceptos INTO rgConceptos;

      IF cuConceptos%notfound THEN
        INSERT INTO LDCI_TMP_CONCEPTOS(CONCEPTO,PRESENTE_MES,VENCIDO,DIFERIDO)
        VALUES(otbDeferredBalance(pos).conccodi,0,0,nuDiferido);
      ELSE
        UPDATE LDCI_TMP_CONCEPTOS
        SET    DIFERIDO = nuDiferido + rgConceptos.diferido
        WHERE  CONCEPTO = otbDeferredBalance(pos).conccodi;
      END IF;

      CLOSE cuConceptos;

      pos := otbDeferredBalance.next(pos);
    END LOOP;


    OPEN cuConcept FOR
    SELECT CONCEPTO AS "idConcepto",
           PRESENTE_MES AS "presenteMes",
           VENCIDO AS "vencido",
           DIFERIDO AS "diferido"
    FROM   LDCI_TMP_CONCEPTOS;

    qryCtx := DBMS_XMLGEN.NewContext(cuConcept);

    DBMS_XMLGEN.SETNULLHANDLING(qryCtx,2);
    Dbms_Xmlgen.setRowSetTag(qryCtx, 'Conceptos');
    Dbms_Xmlgen.setRowTag(qryCtx, 'Concepto');

    L_Payload := DBMS_XMLGEN.getXML(qryCtx);

    --Valida si proceso registros
    if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then
      qryCtx := DBMS_XMLGEN.NewContext('SELECT -1 AS "idConcepto",
                                                -1 AS "presenteMes",
                                                -1 AS "vencido",
                                                -1 AS "diferido"
                                         FROM DUAL');

      Dbms_Xmlgen.setRowSetTag(qryCtx, 'Conceptos');
      Dbms_Xmlgen.setRowTag(qryCtx, 'Concepto');
      L_Payload := DBMS_XMLGEN.getXML(qryCtx);
    end if;

    DBMS_XMLGEN.closeContext(qryCtx);

    CLOSE cuConcept;

    COMMIT; */

    fa_boaccountstatustodate.ProductBalanceAccountsToDate
    (
    inuProducID,
    SYSDATE,
    onuCurrentAccountTotal,
    onuDeferredAccountTotal,
    onuCreditBalance,
    onuClaimValue,
    onuDefClaimValue,
    otbBalanceAccounts,
    otbDeferredBalance
    );

    --Recorre la cartera vencida
    pos:= otbBalanceAccounts.first;

    L_Payload := '<Deuda>' || chr(13);
    L_Payload := L_Payload || '<Conceptos>' || chr(13);

    WHILE pos IS NOT NULL LOOP
      nuPresente := 0;
      nuVencido  := 0;

      IF otbBalanceAccounts(pos).cucodive = 0 THEN
        nuPresente := otbBalanceAccounts(pos).saldvalo;
        nuVencido  := 0;
      ELSE
        nuPresente := 0;
        nuVencido  := otbBalanceAccounts(pos).saldvalo;
      END IF;


        L_Payload := L_Payload || '<Concepto>';
        L_Payload := L_Payload || '<cuencobr>' || otbBalanceAccounts(pos).cucocodi || '</cuencobr>';
        L_Payload := L_Payload || '<concepto>' || otbBalanceAccounts(pos).conccodi || '</concepto>';
        L_Payload := L_Payload || '<presente>' || nuPresente || '</presente>';
        L_Payload := L_Payload || '<vencido>' || nuVencido || '</vencido>';
        L_Payload := L_Payload || '</Concepto>' || chr(13);

        conta := conta + 1;

      pos := otbBalanceAccounts.next(pos);
    END loop;

    L_Payload := L_Payload || '</Conceptos>' || chr(13);

    --Recorre los diferidos
    pos:= otbDeferredBalance.first;

    L_Payload := L_Payload || '<Diferidos>' || chr(13);

    WHILE pos IS NOT NULL LOOP
      nuDiferido := otbDeferredBalance(pos).saldvalo;

      L_Payload := L_Payload || '<diferido>';
      L_Payload := L_Payload || '<concepto>' || otbDeferredBalance(pos).conccodi || '</concepto>';
      L_Payload := L_Payload || '<valorDiferido>' || nuDiferido || '</valorDiferido>';
      L_Payload := L_Payload || '</diferido>' || chr(13);

      pos := otbDeferredBalance.next(pos);
    END LOOP;

    L_Payload := L_Payload || '</Diferidos>' || chr(13);

    L_Payload := L_Payload || '</Deuda>';

   -- dbms_output.put_line(L_Payload);

/*    For rgDeuda In cuXML(L_Payload) Loop
      dbms_output.put_line(rgDeuda.concepto || '-' || rgDeuda.pres || '-' || rgDeuda.venc || '-' || rgDeuda.dife);
    End Loop; */

    OPEN cuConcept FOR
    SELECT Conceptos.concepto AS "idConcepto",
           SUM(Conceptos.presente) AS "presenteMes",
           SUM(Conceptos.vencido) "vencido",
           max(Diferidos.valorDiferido) "diferido"
    FROM XMLTable('/Deuda/Conceptos/Concepto' Passing XMLType(L_Payload)
                      Columns
                      cuencobr    Number        Path 'cuencobr',
                      concepto    Number        Path 'concepto',
                      presente    Number        Path 'presente',
                      vencido     Number        Path 'vencido') As Conceptos
    LEFT JOIN XMLTable('/Deuda/Diferidos/diferido' Passing XMLType(L_Payload)
                      Columns
                      concepto    Number        Path 'concepto',
                      valorDiferido     Number        Path 'valorDiferido') As Diferidos
    ON(Conceptos.concepto = Diferidos.concepto)
    GROUP BY Conceptos.concepto--,Diferidos.valorDiferido
    ORDER BY Conceptos.concepto;

    qryCtx := DBMS_XMLGEN.NewContext(cuConcept);

    DBMS_XMLGEN.SETNULLHANDLING(qryCtx,2);
    Dbms_Xmlgen.setRowSetTag(qryCtx, 'Conceptos');
    Dbms_Xmlgen.setRowTag(qryCtx, 'Concepto');

    L_Payload := DBMS_XMLGEN.getXML(qryCtx);

    --Valida si proceso registros
    if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then
      qryCtx := DBMS_XMLGEN.NewContext('SELECT -1 AS "idConcepto",
                                                -1 AS "presenteMes",
                                                -1 AS "vencido",
                                                -1 AS "diferido"
                                         FROM DUAL');

      Dbms_Xmlgen.setRowSetTag(qryCtx, 'Conceptos');
      Dbms_Xmlgen.setRowTag(qryCtx, 'Concepto');
      L_Payload := DBMS_XMLGEN.getXML(qryCtx);
    end if;

    DBMS_XMLGEN.closeContext(qryCtx);

    CLOSE cuConcept;

    onuXML :=  L_Payload;

  --Return L_Payload;
-- Manejo de Excepciones
Exception
  When Others Then
    L_Payload := '<Conceptos><programa>LDCI_PKGESTNOTIORDEN.fsbGET_CONCEPTOS</programa>
    <others>' || SqlErrM || '</others></Conceptos>';
    ---Inicio CASO 100-10606
    ProErrorXML('proConceptos',L_Payload,onuXML);
    ---Fin CASO 100-10606
    --onuXML :=  L_Payload;
End proConceptos;

---Inicio CASO 100-10606
  /*****************************************************************
  UNIDAD       : ProErrorXML
  DESCRIPCION  : servicio para retornar la cadena XML con datos -1.

  AUTOR          : SINCECOMP
  FECHA          : 16/05/2016

  HISTORIA DE MODIFICACIONES
  FECHA             AUTOR             MODIFICACION
  =========       =========           ====================
  AAcuna         18/08/2017           Caso: 200-1435: Se agrega campo marcaRevPeriodica para agregarle el -1
  ******************************************************************/
Procedure ProErrorXML(isbproceso in varchar2,isbMensajeError in varchar2,isbCadenXMLError out varchar2) is

 L_Payload     CLOB;
 L_Payload2    CLOB;
 L_Payload3    CLOB;
 L_Payload4    CLOB;
 L_Payloadcons CLOB;

 qryCtx        DBMS_XMLGEN.ctxHandle;
 qryCtx2       DBMS_XMLGEN.ctxHandle;
 qryCtx3       DBMS_XMLGEN.ctxHandle;
 qryCtx4       DBMS_XMLGEN.ctxHandle;

begin

  if upper(isbproceso) = upper('proConceptos') then
    LDCI_pkWebServUtils.Procrearerrorlogint(isbproceso,1,isbMensajeError, null, null);
    qryCtx := DBMS_XMLGEN.NewContext('SELECT -1 AS "idConcepto",
                                          -1 AS "presenteMes",
                                          -1 AS "vencido",
                                          -1 AS "diferido"
                                   FROM DUAL');

    Dbms_Xmlgen.setRowSetTag(qryCtx, 'Conceptos');
    Dbms_Xmlgen.setRowTag(qryCtx, 'Concepto');
    isbCadenXMLError := DBMS_XMLGEN.getXML(qryCtx);
  end if;

  if upper(isbproceso) = upper('fsbGET_SUSCRIPC') then
    LDCI_pkWebServUtils.Procrearerrorlogint(isbproceso,1,isbMensajeError, null, null);
    qryCtx :=  DBMS_XMLGEN.NewContext ('select -1 as "idContrato",
                                               -1 as "tipoContrato",
                                               -1 as "ciclo",
                                               -1 as "saldoAFavor",
                                               -1 as "nombreCliente",
                                               -1 as "telefono",
                                               -1 as "idBarrio",
                                               -1 as "barrioDescripcion",
                                               -1 as "ruta",
                                               -1 as "consecutivoRuta"
                                   from DUAL');
    DBMS_XMLGEN.SETNULLHANDLING(qryCtx,2);
    Dbms_Xmlgen.setRowSetTag(Qryctx, '');
    DBMS_XMLGEN.setRowTag(qryCtx, 'Contrato');
    --Genera el XML
    isbCadenXMLError := DBMS_XMLGEN.getXML(qryCtx);
    --Cierra el contexto
    DBMS_XMLGEN.closeContext(qryCtx);
    --Reemplaza encabezado en el XML
    isbCadenXMLError := Replace(isbCadenXMLError, '<?xml version="1.0"?>');
  end if;

  if upper(isbproceso) = upper('fsbGET_SERVSUSC') then
    LDCI_pkWebServUtils.Procrearerrorlogint(isbproceso,1,isbMensajeError, null, null);
    qryCtx :=  DBMS_XMLGEN.NewContext ('Select -1 As "idContrato",
                                               -1 As "numeroServicio",
                                               -1 As "idServicio",
                                               ''' || to_char(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') || ''' As "fechaInstalacion",
                                               -1 As "estadoFinanciero",
                                               -1 As "categoria",
                                               -1 As "subcategoria",
                                               -1 As "multiFamiliar",
                                               -1 As "estadoTecnico",
                                               -1 As "descEstadoTecnico",
                                               -1 As "estadoCorte",
                                               -1 As "idUltActividadSuspension",
                                               -1 As "descUltActividadSuspension",
                                               -1 As "fechaUltActividadSuspension",
                                               -1 As "medidor",
                                               -1 As "idPeriodoFact",
                                               -1 As "anoFact",
                                               -1 As "mesFact",
                                               -1 As "digitosMed",
                                               -1 As "fechaUltmCertificado",
                                               -1 As "marcaRevPeriodica"
                                        from   DUAL');
    DBMS_XMLGEN.SETNULLHANDLING(qryCtx,2);
    Dbms_Xmlgen.setRowSetTag(Qryctx, '');
    DBMS_XMLGEN.setRowTag(qryCtx, 'Servicio');
    --Genera el XML
    isbCadenXMLError := DBMS_XMLGEN.getXML(qryCtx);
    --Cierra el contexto
    DBMS_XMLGEN.closeContext(qryCtx);
    --Reemplaza encabezado en el XML
    isbCadenXMLError := Replace(isbCadenXMLError, '<?xml version="1.0"?>');
  end if;

  if upper(isbproceso) = upper('fsbGET_CARTERA') then
    LDCI_pkWebServUtils.Procrearerrorlogint(isbproceso,1,isbMensajeError, null, null);
    --xml 1
    Qryctx := Dbms_Xmlgen.Newcontext('SELECT -1 AS "idContrato",
                                                 -1 AS "idTipoCartera",
                                                 -1 AS "descTipoCartera",
                                                 -1 AS "saldoPendiente",
                                                 -1 AS "saldoDiferido",
                                                 -1 AS "saldoAnterior",
                                                 -1 AS "cuentasPendientes",
                                                 CURSOR(
                                                 SELECT -1 AS "idProducto",
                                                        -1 AS "saldoPendiente",
                                                        -1 AS "saldoDiferido",
                                                        -1 AS "saldoAnterior",
                                                        -1 AS "cuentasPendientes"
                                                 FROM DUAL) AS "CarteraServicio",
                                                 ''CuentasCobro'' as "CuentasCobro",
                                                 ''financiacion'' as "financiacion",
                                                 ''conceptos'' as "conceptos"
                                       FROM   DUAL'); --#7171-20150519: Se agregan los nuevos campos
    DBMS_XMLGEN.SETNULLHANDLING(Qryctx, 2);
    Dbms_Xmlgen.setRowSetTag(Qryctx, '');
    DBMS_XMLGEN.setRowTag(qryCtx, 'Cartera');
    --Genera el XML
    L_Payload := DBMS_XMLGEN.getXML(qryCtx);
    --Cierra el contexto
    DBMS_XMLGEN.closeContext(qryCtx);
    --xml 2
    Qryctx2 := Dbms_Xmlgen.Newcontext('SELECT -1 AS "idCuentaCobro",
                                                 -1 AS "saldoCuentaCobro"
                                          FROM   Dual');
    DBMS_XMLGEN.SETNULLHANDLING(Qryctx2, 2);
    Dbms_Xmlgen.setRowSetTag(Qryctx2, '');
    DBMS_XMLGEN.setRowTag(Qryctx2, 'CuentasCobro');
    --Genera el XML
    L_Payload2 := DBMS_XMLGEN.getXML(Qryctx2);
    --Cierra el contexto
    DBMS_XMLGEN.closeContext(Qryctx2);
    --xml 3
    qryCtx3 := DBMS_XMLGEN.NewContext('SELECT -1 AS "idProducto",
                                                    -1 AS "deudaEdad",
                                                    -1 AS "deudaTotal",
                                                    -1 AS "deudaCorrienteNoVencida",
                                                    -1 AS "deudaCorrienteVencida",
                                                    -1 AS "deudaDiferida",
                                                    -1 AS "deudaCastigada",
                                                    -1 AS "refinancUltimoAno",
                                                    -1 AS "idPlanFinanc",
                                                    -1 AS "deudaTotalCorriente",
                                                    -1 AS "diferidosConSaldo",
                                                    -1 AS "cuotaInicial",
                                                    -1 AS "abonoMinimo",
                                                    -1 AS "cuotaRefiAnterior",
                                                    -1 AS "calculoAutomatico",
                                                    -1 AS "lecturaSuspension",
                                                   ''N''  AS "puedeRefinanciar"
                                              FROM dual ');

    Dbms_Xmlgen.setRowSetTag(qryCtx3, null);
    Dbms_Xmlgen.setRowTag(qryCtx3, 'Refinanciacion');
    L_Payload3 := DBMS_XMLGEN.getXML(qryCtx3);
    --Cierra el contexto
    DBMS_XMLGEN.closeContext(qryCtx3);
    --/*
    --xml 4
    qryCtx4 := DBMS_XMLGEN.NewContext('SELECT -1 AS "idConcepto",
                                                    -1 AS "presenteMes",
                                                    -1 AS "vencido",
                                                    -1 AS "diferido"
                                             FROM DUAL');

    Dbms_Xmlgen.setRowSetTag(qryCtx4, 'Conceptos');
    Dbms_Xmlgen.setRowTag(qryCtx4, 'Concepto');
    L_Payload4 := DBMS_XMLGEN.getXML(qryCtx4);
    --Cierra el contexto
    DBMS_XMLGEN.closeContext(qryCtx4); --*/
    L_Payload  := Replace(L_Payload, '<?xml version="1.0"?>');
    L_Payload2 := Replace(L_Payload2, '<?xml version="1.0"?>');
    L_Payload3 := Replace(L_Payload3, '<?xml version="1.0"?>');
    L_Payload4 := Replace(L_Payload4, '<?xml version="1.0"?>');
    L_Payload  := Replace(L_Payload, '<CarteraServicio_ROW>');
    L_Payload  := Replace(L_Payload, '</CarteraServicio_ROW>');
    L_Payload := Replace(L_Payload, '</CarteraServicio_ROW>');
    L_Payload := replace(L_Payload,'<CuentasCobro>CuentasCobro</CuentasCobro>',L_Payload2);
    L_Payload := replace(L_Payload,'<financiacion>financiacion</financiacion>',L_Payload3);
    isbCadenXMLError := replace(L_Payload,'<conceptos>conceptos</conceptos>',L_Payload4);
  end if;

  if upper(isbproceso) = upper('fsbGET_LECTURAS') then
    LDCI_pkWebServUtils.Procrearerrorlogint(isbproceso,1,isbMensajeError, null, null);
    --Xml 1
    qryCtx :=  DBMS_XMLGEN.NewContext('select -1 as "valorLectura",
                                                  -1 as "fechaLectura",
                                                  -1 as "periFactLect",
                                                  -1 as "descPeriFactLec",
                                                  -1 as "periConsumo",
                                                  -1 as "elementoMedicion",
                                                  -1 as "observacionLectura1",
                                                  -1 as "descObservacionLectura1",
                                                  -1 as "flagCausaNoLect1",
                                                  -1 as "observacionLectura2",
                                                  -1 as "descObservacionLectura2",
                                                  -1 as "flagCausaNoLect2",
                                                  -1 as "observacionLectura3",
                                                  -1 as "descObservacionLectura3",
                                                  -1 as "flagCausaNoLect3"
                                           from   dual');
      DBMS_XMLGEN.SETNULLHANDLING(qryCtx,2);
      Dbms_Xmlgen.setRowSetTag(Qryctx, 'DetalleLecturas');
      Dbms_Xmlgen.setRowTag(Qryctx, 'Lectura');
      --Genera el XML
      L_Payload := DBMS_XMLGEN.getXML(qryCtx);
      --Cierra el contexto
      DBMS_XMLGEN.closeContext(qryCtx);
      --xml 2
      Qryctx2 :=  DBMS_XMLGEN.NewContext('select -1 as "consumoPromedio",
                                                 -1 as "temperatura",
                                                 -1 as "presion",
                                                 ''consumo'' as "consumo"
                                          from   dual');
      Dbms_Xmlgen.setRowSetTag(qryCtx2, '');
      Dbms_Xmlgen.setRowTag(qryCtx2, 'Consumos');
      --Genera el XML
      L_Payload2:= DBMS_XMLGEN.getXML(qryCtx2);
      --Cierra el contexto
      DBMS_XMLGEN.closeContext(qryCtx2);
      --xml 3
      Qryctx3 :=  DBMS_XMLGEN.NewContext('select -1 as "valorConsumo",
                                                 -1 as "fechaConsumo",
                                                 -1 as "tipoConsumo",
                                                 -1 as "periFact",
                                                 -1 as "descPerifact"
                                          from   dual');
      Dbms_Xmlgen.setRowSetTag(Qryctx3, '');
      Dbms_Xmlgen.setRowTag(Qryctx3, 'Consumo');
      --Genera el XML
      L_Payloadcons:= DBMS_XMLGEN.getXML(Qryctx3);
      --Cierra el contexto
      DBMS_XMLGEN.closeContext(Qryctx3);
      --L_Payloadcons := '<Consumo><valorConsumo>-1</valorConsumo><fechaConsumo>-1</fechaConsumo><tipoConsumo>-1</tipoConsumo><periFact>-1</periFact><descPerifact>-1</descPerifact></Consumo>';
      L_Payload := Replace(L_Payload, '<?xml version="1.0"?>');
      L_Payload2 := Replace(L_Payload2, '<?xml version="1.0"?>');
      L_Payloadcons := Replace(L_Payloadcons, '<?xml version="1.0"?>');
      L_Payloadcons := Replace(L_Payloadcons, '<DetalleConsumos>');
      L_Payloadcons := Replace(L_Payloadcons, '</DetalleConsumos>');
      L_Payload2 := replace(L_Payload2, '<consumo>consumo</consumo>',L_Payloadcons);
      isbCadenXMLError := trim(L_Payload) || trim(L_Payload2);
  end if;

  if upper(isbproceso) = upper('fsbGET_PREDIO') then
    LDCI_pkWebServUtils.Procrearerrorlogint(isbproceso,1,isbMensajeError, null, null);
    qryCtx :=  DBMS_XMLGEN.NewContext ('SELECT -1 as "idDireccion",
                                             -1 as "idSegmento",
                                             -1 as "direccion",
                                             -1 as "consecutivoManzana",
                                             -1  "ladoManzana",
                                             -1 as "ubicacionGeografica",
                                             -1 as "idBarrio",
                                             -1 as "tag",
                                             -1 as "coordenadaXGeo",
                                             -1 as "coordenadaYGeo",
                                             -1 as "coordenadaXPln",
                                             -1 as "coordenadaYPln"
                                 FROM   DUAL');
    DBMS_XMLGEN.SETNULLHANDLING(qryCtx,2);
    Dbms_Xmlgen.setRowSetTag(Qryctx, '');
    DBMS_XMLGEN.setRowTag(qryCtx, 'Predio');
    --Genera el XML
    L_Payload := DBMS_XMLGEN.getXML(qryCtx);
    --Cierra el contexto
    DBMS_XMLGEN.closeContext(qryCtx);
    --Imprime el XML
    isbCadenXMLError := Replace(L_Payload, '<?xml version="1.0"?>');
  end if;

  if upper(isbproceso) = upper('fsbGET_SOLICITUD') then
    LDCI_pkWebServUtils.Procrearerrorlogint(isbproceso,1,isbMensajeError, null, null);
    qryCtx :=  Dbms_XMLGen.NewContext ('Select -1 As "idSolicitud",
                                               -1 As "descSolicitud",
                                               -1 As "idMotivo",
                                               -1 As "tipoMotivo",
                                               -1 As "descMotivo",
                                               -1 As "idSubscriptor",
                                               -1 As "identificacion",
                                               -1 As "contacto",
                                               -1 As "telefono",
                                               -1 As "idPrioridad",
                                               -1 As "observacion"
                                        From   Dual');
    Dbms_XMLGen.SetNullHandling(qryCtx,2);
    Dbms_XMLGen.setRowSetTag(qryCtx, '');
    Dbms_XMLGen.setRowTag(qryCtx, 'Solicitud');
    -- Se genera el XML
    L_Payload := Dbms_XMLGen.GetXML(qryCtx);
    -- Se cierra el contexto
    Dbms_XMLGen.closeContext(qryCtx);
    -- Se imprime el XML
    isbCadenXMLError := Replace(L_Payload, '<?xml version="1.0"?>');
  end if;

  if upper(isbproceso) = upper('fsbGET_PAGOS') then
    LDCI_pkWebServUtils.Procrearerrorlogint(isbproceso,1,isbMensajeError, null, null);
    qryCtx := Dbms_XMLGen.NewContext ('Select -1 As "idProducto",
                                              -1 As "idContacto",
                                              -1 As "idRol",
                                              -1 As "identificacion",
                                              -1 As "nombre",
                                              -1 As "direccion",
                                              -1 As "telefono"
                                       From   Dual'
                                     );
    Dbms_XMLGen.SetNullHandling(qryCtx,2);
    Dbms_XMLGen.setRowSetTag(qryCtx, 'Contactos');
    Dbms_XMLGen.setRowTag(qryCtx, 'Contacto');
    -- Se genera el XML
    L_Payload := Dbms_XMLGen.GetXML(qryCtx);
    -- Se cierra el contexto
    Dbms_XMLGen.closeContext(qryCtx);
    -- Se imprime el XML
    L_Payload := Replace(L_Payload, '<?xml version="1.0"?>');
    L_Payload := Replace(L_Payload, '<Contactos>');
    isbCadenXMLError := Replace(L_Payload, '</Contactos>');
  end if;

  if upper(isbproceso) = upper('fsbGET_PAGOS') then
    LDCI_pkWebServUtils.Procrearerrorlogint(isbproceso,1,isbMensajeError, null, null);
    qryCtx := DBMS_XMLGEN.NewContext ('Select -1 As "conciliacion",
                                              -1 As "fechaPago",
                                              -1 As "valor",
                                              -1 As "fechaGrabacion",
                                              -1 As "cupon"
                                       From   Dual'
                                     );
    DBMS_XMLGEN.SetNullHandling(qryCtx, 2);
    DBMS_XMLGEN.setRowSetTag(qryCtx, 'Pagos');
    DBMS_XMLGEN.setRowTag(qryCtx, 'DetallePago');
    -- Se genera el XML
    L_Payload := DBMS_XMLGEN.GetXML(qryCtx);
    -- Se cierra el contexto
    DBMS_XMLGEN.closeContext(qryCtx);
    -- Se imprime el XML
    L_Payload := Replace(L_Payload, '<?xml version="1.0"?>');
    L_Payload := Replace(L_Payload, '<Pagos>');
    isbCadenXMLError := Replace(L_Payload, '</Pagos>');
  end if;

End ProErrorXML;
---Fin CASO 100-10606

    FUNCTION fclbValidateCharactersXML (iclbCadena IN CLOB)
    RETURN CLOB
/*
 * Propiedad Intelectual Gases del Caribe S. A. E.S.P.
 *
 * Funcion  : fclbValidateCharactersXML
 * Tiquete :  GLPI 221
 * Autor   : Jose Donado
 * Fecha   : 17-04-2020
 * Descripcion : Valida que la cadena ingresada no posea caracteres especiales que generen problema con la construcci?n del XML
 *
 * Historia de Modificaciones
 * Autor          Fecha      Descripcion
   JOSDON         17-04-2020 Se crea funci?n
**/

  IS
    sbAmpersand     varchar2(5) := '&'; -- Signo Y comercial
    sbMenoQue       varchar2(5) := '<'; -- Signo Mayor que
    sbMayoQue       varchar2(5) := '>'; -- Signo Menor que
    sbComillaDoble  varchar2(5) := '"'; -- Signo Comilla Doble
    sbComillaSimple varchar2(5) := '''';-- Signo Comill Sencilla
    iclbCadenaProcesada CLOB;
  BEGIN

    -- Se eliminan los espacios a la cadena para evitar excepciones en la lectura del XML
    iclbCadenaProcesada := TRIM(iclbCadena);
    -- Se hace el replace del ampersand(&), para no modificar los otros campos
    iclbCadenaProcesada := REPLACE(iclbCadenaProcesada,sbAmpersand,sbAmpersand||'amp;');
    -- Se hace el replace a los otros campos (<, >, ", ')
    iclbCadenaProcesada := REPLACE(REPLACE(REPLACE(REPLACE(iclbCadenaProcesada,sbMenoQue,sbAmpersand||'lt;'),sbMayoQue,sbAmpersand||'gt;'),sbComillaDoble,sbAmpersand||'quot;'),sbComillaSimple,sbAmpersand||'apos;');

    RETURN iclbCadenaProcesada;

    EXCEPTION
    WHEN OTHERS THEN
       -- retorna la cadena sin espacion
       RETURN TRIM(iclbCadena);

  END fclbValidateCharactersXML;




End LDCI_PKGESTNOTIORDEN;
/

