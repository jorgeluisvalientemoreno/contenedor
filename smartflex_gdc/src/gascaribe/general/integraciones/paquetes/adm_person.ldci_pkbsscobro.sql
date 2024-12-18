CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKBSSCOBRO AS

  /************************************************************************
   PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P


      PAQUETE : LDCI_PKBSSRECA
      AUTOR   : Adrian Baldovino Barrios
      FECHA   : 08/07/2014
      RICEF   : l019
    DESCRIPCION :   Paquete de interfaz que contiene todas las funcionalidades referentes
            a las integraciones de recaudos

   Historia de Modificaciones

   Autor         Fecha       Descripcion.
   abaldovino    08/07/214    Creacion del paquete.
  ************************************************************************/

  PROCEDURE proCreaCuponRefinancia(inuSuscripc     IN SUSCRIPC.SUSCCODI%TYPE, -- Contrato
                                   inuProduct      IN SERVSUSC.SESUNUSE%TYPE, -- Tipo de producto
                                   isbListDife     IN VARCHAR2, -- Lista de diferidos
                                   isbDeuVenci     IN VARCHAR2, -- Solo deuda vencida Y N
                                   isbRqPflFinan   IN VARCHAR2, --Perfil de financiacion N
                                   idtFechaReg     IN DATE, --Fecha de registro
                                   inuLugarRecep   IN NUMBER, --lugar de recepcion GE_DISTRIBUT_ADMIN
                                   inuTipoRecep    IN NUMBER, -- Medio de recepcion GE_RECEPTION_TYPE
                                   inuSuscriber    IN NUMBER, --GE_SUBSCRIBER Si viene nulo se asume que es el due?o
                                   isbDireccion    IN VARCHAR2, --Direccion de respuesta a la solicitud
                                   inuGeograLoc    IN NUMBER, -- id de GE_GEOGRALOCATION
                                   isbObservacion  IN VARCHAR2, --Observacion
                                   inuPlanFinan    IN NUMBER, -- Codigo del plan de financiacion PLANDIFE
                                   idtIniPago      IN DATE, --Fecha del primer pago
                                   inuValorDesc    IN NUMBER, -- Valor a descontar por acuerdo de pago
                                   inuValorTotal   IN NUMBER, -- Valor a pagar
                                   inuPuntAddici   IN NUMBER, --Puntos adicionales
                                   inuNumeroCuotas IN NUMBER, --Numero de cuotas
                                   inuDocumentoSop IN NUMBER, -- Documento Soporte
                                   isbListCodeudor IN VARCHAR2, --Lista de codigos de codeudores de GE_SUBSCRIBER |
                                   onuCupon        OUT NUMBER,
                                   onuSolicitud    OUT NUMBER,
                                   onuCuota        OUT NUMBER,
                                   ONUERRORCOD     OUT NUMBER,
                                   osbErrorMsg     OUT VARCHAR2);

  PROCEDURE proCnltaCupon(inuSuscCodi IN NUMBER,
                          inuCupoCodi IN NUMBER,
                          isbTipoCons IN VARCHAR2,
                          isbUsoApi   IN VARCHAR2,
                          onuReferenc OUT NUMBER,
                          osbCupoTipo OUT VARCHAR2,
                          osbDocument OUT VARCHAR2,
                          onuValorCup OUT NUMBER,
                          odtCupoFech OUT DATE,
                          osbCupoProg OUT VARCHAR2,
                          onuCupoPadr OUT NUMBER,
                          onuSuscCodi OUT NUMBER,
                          osbCupoEsta OUT VARCHAR2,
                          osbDireccio OUT VARCHAR2,
                          osbNombreSu OUT VARCHAR2,
                          odtFechaLim OUT DATE,
                          onuErrorCod OUT NUMBER,
                          osbErrorMes OUT VARCHAR2);

  PROCEDURE proCnltaConcPorFecha(inuCodiEnti     IN banco.banccodi%TYPE,
                                 idtFechaReg     IN DATE,
                                 inuCupon        IN NUMBER,
                                 orfConcPagos    out sys_refcursor,
                                 orfPagos        out sys_refcursor,
                                 onuErrorCode    out NUMBER,
                                 osbErrorMessage out varchar2);

  PROCEDURE proGnraCuponProd(isbXMLProd      IN CLOB,
                             onuCupoNume     OUT CUPON.CUPONUME%TYPE,
                             OnuValorTotal   OUT CUPON.CUPOVALO%TYPE,
                             onuErrorCode    OUT NUMBER,
                             osbErrorMessage OUT VARCHAR2);

  PROCEDURE proGnraCuponPorCtto(inuSusccodi     in SUSCRIPC.SUSCCODI%TYPE,
                                inuSaldoGen     in CUPON.CUPOVALO%TYPE,
                                onuCupoNume     out CUPON.CUPONUME%type,
                                onuErrorCode    out number,
                                osbErrorMessage out varchar2);

  PROCEDURE PROCONSULTASERVCTTO(inuSusccodi     IN suscripc.susccodi%TYPE,
                                CUSERVICIOS     OUT SYS_REFCURSOR,
                                osbNombre       OUT VARCHAR2,
                                onuLocalidad    OUT NUMBER,
                                osbDepartamento OUT VARCHAR2,
                                osbLocalidad    OUT VARCHAR2,
                                osbBarrio       OUT VARCHAR2,
                                osbDireccion    OUT VARCHAR2,
                                onuErrorCode    OUT NUMBER,
                                osbErrorMessage OUT VARCHAR2);

  PROCEDURE PROAGREGACOMENTORDEN(INUORDERID       IN NUMBER,
                                 INUCOMMENTTYPEID IN NUMBER,
                                 ISBCOMMENT       IN VARCHAR2,
                                 onuErrorCode     OUT NUMBER,
                                 osbErrorMessage  OUT VARCHAR2);

  FUNCTION FNUCONSULTASADOANT(nuSusccodi  IN suscripc.susccodi%TYPE,
                              inuServicio IN NUMBER) RETURN NUMBER;

  FUNCTION FNUCONSULTAVALORANTFACT(nuSusccodi     IN suscripc.susccodi%TYPE,
                                   nuTipoServicio IN NUMBER,
                                   nuServicio     IN NUMBER) RETURN NUMBER;

  FUNCTION FNUCONSULTASADOACT(nuSusccodi     IN suscripc.susccodi%TYPE,
                              nuTipoServicio IN NUMBER,
                              nuServicio     IN NUMBER) RETURN NUMBER;

  FUNCTION FNUCONSULTVALANTFACTSERV(nuFactura  IN NUMBER,
                                    nuServicio IN NUMBER) RETURN NUMBER;

END LDCI_PKBSSCOBRO;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKBSSCOBRO AS

  PROCEDURE PROAGREGACOMENTORDEN(INUORDERID       IN NUMBER,
                                 INUCOMMENTTYPEID IN NUMBER,
                                 ISBCOMMENT       IN VARCHAR2,
                                 onuErrorCode     OUT NUMBER,
                                 osbErrorMessage  OUT VARCHAR2) IS

  BEGIN

    OS_ADDORDERCOMMENT(INUORDERID       => INUORDERID,
                       INUCOMMENTTYPEID => INUCOMMENTTYPEID,
                       ISBCOMMENT       => ISBCOMMENT,
                       ONUERRORCODE     => onuErrorCode,
                       OSBERRORMESSAGE  => osbErrorMessage);
    COMMIT;
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      rollback;
      Errors.geterror(onuErrorCode, osbErrorMessage);
    when others then
      rollback;
      onuErrorCode    := -1;
      osbErrorMessage := 'Error general: ' || Sqlerrm;
  END;

  /************************************************************************
   PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

          FUNCTION : FNUCONSULTASADOACT
           AUTOR   : Hector Fabio Dominguez
           FECHA   : 16/05/2013
           RICEF   : I045
       DESCRIPCION : Proceso encargado de retornar la informacion del saldo actual

   Historia de Modificaciones

   Autor        Fecha       Descripcion.
   HECTORFDV    16/05/2013  Creacion del paquete
  ************************************************************************/

  FUNCTION FNUCONSULTASADOACT(nuSusccodi     IN suscripc.susccodi%type,
                              nuTipoServicio IN NUMBER,
                              nuServicio     in NUMBER) RETURN NUMBER IS

    nuIdentificacion   NUMBER;
    nuTelefono         NUMBER;
    onuSaldoPend       NUMBER;
    onuSaldoAnterior   NUMBER;
    onuPeriodoCant     NUMBER;
    sbMunicipio        VARCHAR2(500);
    sbDireccion        VARCHAR2(500);
    sbCategoria        VARCHAR2(500);
    onuErrorCode       NUMBER;
    osbErrorMessage    VARCHAR2(1000);
    ONUDEFERREDBALANCE NUMBER;

    /*
    * Cursor cuSaldoActual
    * Calcula el saldo pendiente
    *
    *
    */
    CURSOR cuSaldoActual IS
      SELECT (NVL(SUM(cc.CUCOSACU), 0) - NVL(SUM(CUCOVRAP), 0)) SALDO
        FROM CUENCOBR cc
       WHERE CUCONUSE = nuServicio;
  BEGIN
    /*
    * Se consulta el api que retorna el
    * saldo actual
    *
    */

    OPEN cuSaldoActual;
    FETCH cuSaldoActual
      INTO onuSaldoPend;
    CLOSE cuSaldoActual;

    /*
    * TQ 3278
    * FECHA: 31-03-2014
    * Ajuste para cuando el retorno de la api
    * sea nulo
    */

    IF onuSaldoPend IS NULL THEN
      onuSaldoPend := 0;
    END IF;

    return onuSaldoPend;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR then
      ROLLBACK;
      Errors.geterror(onuErrorCode, osbErrorMessage);
    WHEN OTHERS THEN
      osbErrorMessage := 'Error consultando saldo actual: ' ||
                         DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
      pkErrors.NotifyError(pkErrors.fsbLastObject,
                           SQLERRM,
                           osbErrorMessage);
      Errors.seterror;
      Errors.geterror(onuErrorCode, osbErrorMessage);
  END FNUCONSULTASADOACT;

  /*****************************************************************
  Propiedad intelectual de Gases de occidente

  Function  :    FNUCONSULTAVALORANTSERV
  Descripcion :  Obtiene el valor facturado

  Parametros  :  Contrato

  Retorno     :onubReturn

  Autor    :  Hector Fabio Dominguez
  Fecha    :  08-01-2014



  *****************************************************************/

  FUNCTION FNUCONSULTVALANTFACTSERV(nuFactura  IN NUMBER,
                                    nuServicio IN NUMBER) RETURN NUMBER IS

    nuSaldoAntServ NUMBER;
    /*
    * Cursor cuConsultaSaldoFact
    * Consulta el saldo pendiente de una factura para un servicio
    *
    */

    CURSOR cuConsultaSaldoFact IS
      SELECT SUM(CUCOSACU) - SUM(CUCOVARE) SALDO
        FROM CUENCOBR cc
       WHERE cc.CUCOFACT = nuFactura
         AND cc.CUCONUSE = nuServicio;

  BEGIN

    /* Realiza la consulta
    * del saldo pendiente a partir del codigo de factura
    * y del codigo del servicio
    *
    */
    OPEN cuConsultaSaldoFact;
    FETCH cuConsultaSaldoFact
      INTO nuSaldoAntServ;
    CLOSE cuConsultaSaldoFact;

    IF nuSaldoAntServ IS NULL THEN

      RETURN 0;

    END IF;

    RETURN nuSaldoAntServ;

  EXCEPTION

    WHEN OTHERS THEN
      RETURN 0;
  END FNUCONSULTVALANTFACTSERV;
  /************************************************************************
   PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

          FUNCTION : FNUCONSULTASADOANT
           AUTOR   : Hector Fabio Dominguez
           FECHA   : 16/05/2013
           RICEF   : I045
       DESCRIPCION : Proceso encargado de retornar la informacion del saldo anterior

   Historia de Modificaciones

   Autor        Fecha       Descripcion.
   HECTORFDV    16/05/2013  Creacion del paquete
  ************************************************************************/

  FUNCTION FNUCONSULTASADOANT(nuSusccodi  IN suscripc.susccodi%type,
                              inuServicio IN NUMBER) RETURN NUMBER IS

    nuIdentificacion   NUMBER;
    nuTelefono         NUMBER;
    onuSaldoPend       NUMBER;
    onuSaldoAnterior   NUMBER;
    onuPeriodoCant     NUMBER;
    sbMunicipio        VARCHAR2(500);
    sbDireccion        VARCHAR2(500);
    sbCategoria        VARCHAR2(500);
    onuErrorCode       NUMBER;
    osbErrorMessage    VARCHAR2(1000);
    ONUDEFERREDBALANCE NUMBER;

    /*
    * Cursor cuSaldoAnterior
    * Calcula el saldo pendiente
    *
    *
    */
    CURSOR cuSaldoAnterior IS
      SELECT (NVL(SUM(cc.CUCOSACU), 0) - NVL(SUM(CUCOVRAP), 0)) SALDO
        FROM CUENCOBR cc
       WHERE CUCONUSE = inuServicio
         AND CUCOFEVE < SYSDATE;

  BEGIN
    /*
    * Se llama al cursor que retorna el saldo anterior
    *
    */

    OPEN cuSaldoAnterior;
    FETCH cuSaldoAnterior
      INTO onuSaldoAnterior;
    CLOSE cuSaldoAnterior;
    /*
    * TQ 3278
    * FECHA: 31-03-2014
    * Ajuste para cuando el retorno de la api
    * sea nulo
    */
    IF onuSaldoAnterior IS NULL THEN
      onuSaldoAnterior := 0;
    END IF;

    return onuSaldoAnterior;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR then
      ROLLBACK;
      Errors.geterror(onuErrorCode, osbErrorMessage);
    WHEN OTHERS THEN
      osbErrorMessage := 'Error consultando saldo anterior: ' ||
                         DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
      pkErrors.NotifyError(pkErrors.fsbLastObject,
                           SQLERRM,
                           osbErrorMessage);
      Errors.seterror;
      Errors.geterror(onuErrorCode, osbErrorMessage);

  END FNUCONSULTASADOANT;

  /*****************************************************************
  Propiedad intelectual de Gases de occidente

  Function  :    FNUCONSULTAVALORFACT
  Descripcion :  Obtiene el valor facturado

  Parametros  :  Contrato

  Retorno     :onubReturn

  Autor    :  Hector Fabio Dominguez
  Fecha    :  08-01-2014



  *****************************************************************/

  FUNCTION FNUCONSULTAVALORANTFACT(nuSusccodi     IN suscripc.susccodi%type,
                                   nuTipoServicio IN NUMBER,
                                   nuServicio     in NUMBER) RETURN NUMBER IS
    nuCodUltFact    NUMBER;
    nuSaldUltFact   NUMBER;
    onuReturnvalue  NUMBER := 0;
    nuSaldoAnterior NUMBER;
    dtFechaVenc     DATE;

    /*
    * Consulta la ultima
    * factura y extrae las cuentas
    * de cobro
    *
    */
    CURSOR cuConsultaUltFact IS
      SELECT GCC.SALDO,
             (SELECT max(factcodi)
                FROM factura fact2
               WHERE factsusc = nuSusccodi
                 AND (SELECT SUM(CUCOSACU)
                        FROM CUENCOBR CCBR
                       WHERE CUCOFACT = fact2.factcodi) > 0) FACTURA
        FROM (SELECT SUM(CUCOSACU) SALDO
                FROM CUENCOBR cc
               WHERE cc.CUCOFACT IN
                     (SELECT factu.factcodi
                        FROM factura factu
                       WHERE factu.factsusc = nuSusccodi
                         AND (SELECT SUM(CUCOSACU)
                                FROM CUENCOBR CCBR
                               WHERE CCBR.CUCOFACT = factu.factcodi) > 0
                         AND factu.FACTPEFA =
                             (SELECT MAX(factusub.FACTPEFA)
                                FROM FACTURA factusub
                               WHERE factusub.factsusc = nuSusccodi
                                 AND (SELECT SUM(CUCOSACU)
                                        FROM CUENCOBR CCBR
                                       WHERE CUCOFACT = factusub.factcodi) > 0))) GCC;

    /*
    * Consulta la fecha de vencimiento
    * primera cuenta de cobro
    * de la factura
    */

    CURSOR cuConsultaFechVenc(iNuCodFact NUMBER) IS
      SELECT CUCOFEVE
        FROM CUENCOBR
       WHERE CUCOFACT = iNuCodFact
         AND ROWNUM <= 1;

  BEGIN

    /*
    * Se consulta
    * la ultima factura generada
    */

    OPEN cuConsultaUltFact;
    FETCH cuConsultaUltFact
      INTO nuSaldUltFact, nuCodUltFact;
    CLOSE cuConsultaUltFact;

    IF nuSaldUltFact IS NULL THEN
      nuSaldUltFact := 0;
    END IF;
    /*
    * Se consulta a fecha de vencimiento de la primera cuenta de cobro
    */

    OPEN cuConsultaFechVenc(nuCodUltFact);
    FETCH cuConsultaFechVenc
      INTO dtFechaVenc;
    CLOSE cuConsultaFechVenc;

    /*
    * Se debe restar el saldo facturado al anterior
    * siempre y cuando el saldo anterior sea superior o igual al facturado
    * en caso contrario quiere decir que el saldo anterior no esta incluido
    *
    */
    nuSaldoAnterior := LDCI_PKBSSCOBRO.FNUCONSULTASADOANT(nuSusccodi,
                                                          nuServicio);

    /*
    * Si la fecha de vencimiento
    * es menor a hoy, quiere decir
    * que se debe realizar la resta
    * del valor facturado
    * al saldo anterior
    * de lo contrario no, ya que el valor facturado
    * no se calculo dentro del saldo pendiente
    */

    IF dtFechaVenc < SYSDATE THEN
      onuReturnvalue := nuSaldoAnterior -
                        FNUCONSULTVALANTFACTSERV(nuCodUltFact, nuServicio); --FNUCONSULTVALANTFACTSERV(nuFactura IN NUMBER,nuTipoServicio) --nuSaldUltFact;
    ELSE
      onuReturnvalue := nuSaldoAnterior;
    END IF;

    /*
    * TQ 3278
    * FECHA: 31-03-2014
    * Ajuste para cuando el retorno de la api
    * sea nulo
    */
    IF onuReturnvalue IS NULL THEN
      onuReturnvalue := 0;
    END IF;

    RETURN onuReturnvalue;

  EXCEPTION
    WHEN OTHERS THEN
      RETURN 0;
  END FNUCONSULTAVALORANTFACT;

  /************************************************************************
   PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

         PROCEDURE : PROCONSULTASUSCRIPC
           AUTOR   : Hector Fabio Dominguez
           FECHA   : 16/05/2014
           RICEF   : I042
       DESCRIPCION : Proceso encargado de consultar la informacion basica
                     de los servicios a partir del numero de contrato

   Historia de Modificaciones

   Autor        Fecha       Descripcion.
   HECTORFDV    16/05/2013  Creacion del procedimiento
  ************************************************************************/

  PROCEDURE PROCONSULTASERVCTTO(inuSusccodi     IN suscripc.susccodi%TYPE,
                                CUSERVICIOS     OUT SYS_REFCURSOR,
                                osbNombre       OUT VARCHAR2,
                                onuLocalidad    OUT NUMBER,
                                osbDepartamento OUT VARCHAR2,
                                osbLocalidad    OUT VARCHAR2,
                                osbBarrio       OUT VARCHAR2,
                                osbDireccion    OUT VARCHAR2,
                                onuErrorCode    OUT NUMBER,
                                osbErrorMessage OUT VARCHAR2) AS

    ONUDEFERREDBALANCE NUMBER;
    nuCantReg          NUMBER;
    CUSUSCRIPCIONESAUX SYS_REFCURSOR;

    /*
    * Consulta datos de un
    * suscriptor
    */
    CURSOR CUDATOSUSCRIPC IS

      SELECT gesus.subscriber_name || ' ' || gesus.subs_last_name sbNombreCliente,
             Addr.Geograp_Location_Id AS nuLocalidad,
             (Select Description
                From Ge_Geogra_Location
               Where Geograp_Location_Id =
                     (Select Geo_Loca_Father_Id
                        From Ge_Geogra_Location
                       Where Geograp_Location_Id = Addr.Geograp_Location_Id)) As sbDepartamento,
             (Select Description
                From Ge_Geogra_Location
               Where Geograp_Location_Id = Addr.Geograp_Location_Id) As sbNombreLocalidad,
             (Select Description
                From Ge_Geogra_Location
               Where Geograp_Location_Id = Addr.NEIGHBORTHOOD_ID) AS SbBarrio,
             (SELECT address FROM ab_address WHERE address_id = Sus.Susciddi) AS sbDireccion
        From Suscripc Sus, Ab_Address Addr, GE_SUBSCRIBER gesus
       Where Sus.Susccodi = inuSusccodi
         AND Addr.Address_Id = Sus.Susciddi
         AND Gesus.Subscriber_Id = Sus.SUSCCLIE;
  BEGIN

    /*
    * Consultamos la informacion del suscriptor
    *
    */

    OPEN CUDATOSUSCRIPC;
    FETCH CUDATOSUSCRIPC
      INTO osbNombre, onuLocalidad, osbDepartamento, osbLocalidad, osbBarrio, osbDireccion;

    /*
    * Consultamos la informacion de los servicios
    *
    */

    CLOSE CUDATOSUSCRIPC;

    OPEN CUSERVICIOS FOR
      SELECT Serv.Sesunuse AS nuServicioSuscrito,
             Serv.sesuserv AS nuTipoServicio,
             servicio.SERVDESC AS sbDescripcion,
             Serv.sesusuca AS nuEstrato,
             LDCI_PKBSSCOBRO.FNUCONSULTAVALORANTFACT(Sus.Susccodi,
                                                     Serv.sesuserv,
                                                     Serv.Sesunuse) AS nuSaldAnterior,
             LDCI_PKBSSCOBRO.Fnuconsultasadoact(Sus.Susccodi,
                                                Serv.sesuserv,
                                                Serv.Sesunuse) As nuSaldActual

        From Suscripc Sus, Servsusc Serv, servicio servicio
       Where Sus.Susccodi = inuSusccodi
         AND Serv.Sesususc = Sus.Susccodi
         AND servicio.SERVCODI = Serv.SESUSERV;

    IF NOT CUSERVICIOS%ISOPEN THEN

      OPEN CUSERVICIOS FOR
        SELECT * FROM dual where 1 = 2;

    END IF;

    IF osbDepartamento IS NULL THEN
      onuErrorCode    := 1;
      osbErrorMessage := 'Contrato no encontrado';
    ELSE
      onuErrorCode    := 0;
      osbErrorMessage := 'Consulta exitosa ';
    END IF;

    COMMIT;

  EXCEPTION

    WHEN ex.CONTROLLED_ERROR then
      ROLLBACK;
      Errors.geterror(onuErrorCode, osbErrorMessage);
    WHEN OTHERS THEN
      ROLLBACK;
      osbErrorMessage := 'Error consultando las facturas: ' ||
                         DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
      pkErrors.NotifyError(pkErrors.fsbLastObject,
                           SQLERRM,
                           osbErrorMessage);
      Errors.seterror;
      Errors.geterror(onuErrorCode, osbErrorMessage);

  END PROCONSULTASERVCTTO;
  /************************************************************************
  * PROPIEDAD INTELECTUAL
  *
  *    PROCEDURE : proCreaCuponRefinancia
  *    AUTOR     : Hector Fabio Dominguez
  *    FECHA     : 25-6-2014
  *    RICEF     : I090
  * DESCRIPCION  : Permite genera un cupon de refinanciacion
  *
  *
  * Historia de Modificaciones
  * Autor        Fecha       Descripcion.
  * HECTORFDV    25-6-2014  Creacion del procedimiento
  ************************************************************************/

  PROCEDURE proCreaCuponRefinancia(inuSuscripc     IN SUSCRIPC.SUSCCODI%TYPE, -- Contrato
                                   inuProduct      IN SERVSUSC.SESUNUSE%TYPE, -- Tipo de producto
                                   isbListDife     IN VARCHAR2, -- Lista de diferidos
                                   isbDeuVenci     IN VARCHAR2, -- Solo deuda vencida Y N
                                   isbRqPflFinan   IN VARCHAR2, --Perfil de financiacion N
                                   idtFechaReg     IN DATE, --Fecha de registro
                                   inuLugarRecep   IN NUMBER, --lugar de recepcion GE_DISTRIBUT_ADMIN
                                   inuTipoRecep    IN NUMBER, -- Medio de recepcion GE_RECEPTION_TYPE
                                   inuSuscriber    IN NUMBER, --GE_SUBSCRIBER Si viene nulo se asume que es el due?o
                                   isbDireccion    IN VARCHAR2, --Direccion de respuesta a la solicitud
                                   inuGeograLoc    IN NUMBER, -- id de GE_GEOGRALOCATION
                                   isbObservacion  IN VARCHAR2, --Observacion
                                   inuPlanFinan    IN NUMBER, -- Codigo del plan de financiacion PLANDIFE
                                   idtIniPago      IN DATE, --Fecha del primer pago
                                   inuValorDesc    IN NUMBER, -- Valor a descontar por acuerdo de pago
                                   inuValorTotal   IN NUMBER, -- Valor a pagar
                                   inuPuntAddici   IN NUMBER, --Puntos adicionales
                                   inuNumeroCuotas IN NUMBER, --Numero de cuotas
                                   inuDocumentoSop IN NUMBER, -- Documento Soporte
                                   isbListCodeudor IN VARCHAR2, --Lista de codigos de codeudores de GE_SUBSCRIBER |
                                   onuCupon        OUT NUMBER,
                                   onuSolicitud    OUT NUMBER,
                                   onuCuota        OUT NUMBER,
                                   ONUERRORCOD     OUT NUMBER,
                                   osbErrorMsg     OUT VARCHAR2

                                   ) IS

    osbDireccion    VARCHAR2(2000);
    onuDocumentoSop NUMBER(12);
    onuGeograLoc    NUMBER(8);
    onuProduct      SERVSUSC.SESUNUSE%TYPE;
    inuDiasgracia   NUMBER(4);
    sbListDife      VARCHAR2(20000);

    /*
    * CURSOR       cuDiasGracia
    *
    * DESCRIPCION: Caldula los dias maximos del periodo de gracia
    * FECHA:       18-9-2014
    * TIQUETE:     ROLLOUT
    *
    */

    CURSOR cuDiasGracia IS

      SELECT MAX_GRACE_DAYS
        FROM CC_GRACE_PERIOD
       WHERE GRACE_PERIOD_ID IN
             (SELECT PLDIPEGR
                FROM OPEN.PLANDIFE
               WHERE PLDICODI = inuPlanFinan)
         AND ROWNUM <= 1;

    /*
    * CURSOR       cuCalculaDiferidos
    *
    * DESCRIPCION: Calcula la cadena de diferidos
    * FECHA:       24-9-2014
    * TIQUETE:     ROLLOUT
    *
    */

    CURSOR cuCalculaDiferidos IS
      SELECT LISTAGG(DIFECODI, '|') WITHIN
       GROUP(
       ORDER BY DIFECODI) diferidos
        FROM DIFERIDO
       where DIFESUSC = inuSuscripc
         AND DIFESAPE > 0
         AND DIFENUSE = inuProduct;

  BEGIN

    OPEN cuDiasGracia;
    FETCH cuDiasGracia
      INTO inuDiasgracia;
    CLOSE cuDiasGracia;

    osbDireccion    := isbDireccion;
    onuGeograLoc    := inuGeograLoc;
    onuDocumentoSop := inuDocumentoSop;

    /*Se Calculan los diferidos*/

    IF isbListDife = 'Y' THEN

      OPEN cuCalculaDiferidos;
      FETCH cuCalculaDiferidos
        INTO sbListDife;
      CLOSE cuCalculaDiferidos;
    ELSE
      sbListDife := isbListDife;
    END IF;

    IF osbDireccion IS NULL OR osbDireccion = '' THEN

      BEGIN
        SELECT ADDRESS_PARSED
          INTO osbDireccion
          FROM AB_ADDRESS
         WHERE ADDRESS_ID =
               (SELECT SUSCIDDI FROM SUSCRIPC WHERE SUSCCODI = inuSuscripc);

      EXCEPTION
        WHEN OTHERS THEN
          osbDireccion := '';
      END;

    END IF;

    IF onuGeograLoc IS NULL OR onuGeograLoc = '' THEN

      BEGIN
        SELECT GEOGRAP_LOCATION_ID
          INTO onuGeograLoc
          FROM AB_ADDRESS
         WHERE ADDRESS_ID =
               (SELECT SUSCIDDI FROM SUSCRIPC WHERE SUSCCODI = inuSuscripc);

      EXCEPTION
        WHEN OTHERS THEN
          onuGeograLoc := -1;
      END;

    END IF;

    IF onuDocumentoSop IS NULL OR onuDocumentoSop = '' THEN

      BEGIN

        SELECT IDENTIFICATION
          INTO onuDocumentoSop
          FROM GE_SUBSCRIBER
         WHERE SUBSCRIBER_ID =
               (SELECT SUSCCLIE FROM SUSCRIPC WHERE SUSCCODI = inuSuscripc);

      EXCEPTION
        WHEN OTHERS THEN
          onuDocumentoSop := -1;
      END;

    END IF;

    IF sbListDife IS NULL THEN

      sbListDife := '';

    END IF;

    --llamado al API de refinanciacion
    OS_RegisterDebtFinancing(Inusubscriptionid  => inuSuscripc, --ok
                             Inuproductid       => inuProduct, --ok
                             Isbdeferredlist    => sbListDife, --ok
                             Isbonlyexpiredacc  => isbDeuVenci, --ok
                             Isbrequiresigning  => isbRqPflFinan, --ok
                             Idtregisterdate    => TRUNC(SYSDATE), --ok
                             Inureceptiontypeid => inuTipoRecep,
                             Inusubscriberid    => inuSuscriber,
                             Isbresponseaddress => osbDireccion,
                             Inugeogralocation  => onuGeograLoc,
                             Isbcomment         => isbObservacion,
                             Inufinancingplanid => inuPlanFinan,
                             Idtinitpaydate     => TRUNC(SYSDATE +
                                                         inuDiasgracia),
                             Inudiscountvalue   => inuValorDesc,
                             Inuvaluetopay      => inuValorTotal,
                             Inuspread          => inuPuntAddici,
                             Inuquotesnumber    => inuNumeroCuotas,
                             Isbsupportdocument => onuDocumentoSop, --inuDocumentoSop
                             Isbcosignerslist   => isbListCodeudor, --ok
                             Onupackageid       => onuSolicitud,
                             Onucouponnumber    => onuCupon,
                             Onuerrorcode       => ONUERRORCOD,
                             Osberrormessage    => osbErrorMsg,
                             isbProcessName     => 'GCNED');

    /*
     * Se calcula el valor de
     * la cuota mensual
    */

    IF ONUERRORCOD = 0 THEN

      SELECT QUOTA_VALUE
        INTO onuCuota
        FROM CC_FINANCING_REQUEST
       WHERE FINANCING_REQUEST_ID = onuSolicitud;

    END IF;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      onuErrorCod := -1;
      osbErrorMsg := 'Error: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE ||
                     ' Localizacion ' || SQLERRM;

      Errors.geterror(onuErrorCod, osbErrorMsg);
    WHEN OTHERS THEN
      onuErrorCod := -1;
      osbErrorMsg := 'Error: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE ||
                     ' Localizacion ' || SQLERRM;

      osbErrorMsg := 'Realizando generacion de refinanciacion ' ||
                     DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
      pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, osbErrorMsg);
      Errors.seterror;
      Errors.geterror(onuErrorCod, osbErrorMsg);

  END proCreaCuponRefinancia;

  PROCEDURE proCnltaCupon(inuSuscCodi IN NUMBER,
                          inuCupoCodi IN NUMBER,
                          isbTipoCons IN VARCHAR2,
                          isbUsoApi   IN VARCHAR2,
                          onuReferenc OUT NUMBER,
                          osbCupoTipo OUT VARCHAR2,
                          osbDocument OUT VARCHAR2,
                          onuValorCup OUT NUMBER,
                          odtCupoFech OUT DATE,
                          osbCupoProg OUT VARCHAR2,
                          onuCupoPadr OUT NUMBER,
                          onuSuscCodi OUT NUMBER,
                          osbCupoEsta OUT VARCHAR2,
                          osbDireccio OUT VARCHAR2,
                          osbNombreSu OUT VARCHAR2,
                          odtFechaLim OUT DATE,
                          onuErrorCod OUT NUMBER,
                          osbErrorMes OUT VARCHAR2) AS

    /************************************************************************
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

           FUNCION   : proCnltaCupon
             AUTOR   : Hector Fabio Dominguez
             FECHA   : 06/06/2014
             RICEF   : I011 ROLLOUT
       DESCRIPCION : Realiza la consulta de cupon


     Parametros de Entrada

          inuSuscCodi IN  NUMBER
          inuCupoCodi IN  NUMBER
          isbTipoCons IN  VARCHAR2


     Parametros de Salida

         osbReferenc OUT NUMBER
         osbCupoTipo OUT VARCHAR2
         osbDocument OUT VARCHAR2
         onuValorCup OUT NUMBER
         odtCupoFech OUT DATE
         osbCupoProg OUT VARCHAR2
         onuCupoPadr OUT NUMBER
         onuSuscCodi OUT NUMBER
         osbCupoEsta OUT VARCHAR2
         osbDireccio OUT VARCHAR2
         osbNombreSu OUT VARCHAR2
         odtFechaLim OUT DATE
         onuErrorCod OUT NUMBER
         osbErrorMes OUT VARCHAR2

     Historia de Modificaciones
     Autor        Fecha       Descripcion.
     sampac		  17/07/2017  se adiciona cursor para consulta de efigas
     HECTORFDV    06/06/2014  Creacion del procedimiento
    ************************************************************************/
    --Variable
    csbEntrega2001359 CONSTANT VARCHAR2(100) := 'BSS_RECA_SAP_2001359_2';
    /*
    * CURSOR CuConsultaSuscripc
    * Consulta los datos del suscriptor
    * 06-06-2014
    * ROLLOUT
    *
    */
    CURSOR CuConsultaSuscripc(nuSuscripc NUMBER) IS
      SELECT DECODE(C.CUPONUME, NULL, 0, C.CUPONUME) REFERENCIA,
             C.CUPOTIPO TIPO,
             C.CUPODOCU DODCUMENTO,
             DECODE(C.CUPOVALO, NULL, 0, C.CUPOVALO) VALOR,
             C.CUPOFECH FECHAGEN,
             C.CUPOPROG PROGRAMA,
             DECODE(C.CUPOCUPA, NULL, 0, C.CUPOCUPA) PADRE,
             DECODE(C.CUPOSUSC, NULL, 0, C.CUPOSUSC) SUSCRIPTOR,
             C.CUPOFLPA ESTADO,
             LDCI_PKBSSRECA.fsbGenAddress(AB.ADDRESS_ID) DIRECCION,
             CL.SUBS_LAST_NAME || ' ' || CL.SUBSCRIBER_NAME NOMBRE,
             trunc(C.CUPOFECH) + 3650 FECHALIMITE
        FROM CUPON C, SUSCRIPC S, AB_ADDRESS AB, GE_SUBSCRIBER CL
       WHERE C.CUPOSUSC = nuSuscripc
         AND S.SUSCCODI = C.CUPOSUSC
         AND S.SUSCIDDI = AB.ADDRESS_ID
         AND CL.SUBSCRIBER_ID = S.SUSCCLIE
         AND C.CUPOFLPA = 'N'
         AND ROWNUM = 1
       ORDER BY CUPOFECH DESC;

    /*
    * CURSOR CuConsultaSuscripcEf
    * Consulta los datos del suscriptor aplicado a Efigas
    * caso 200-1359 07-07-2017
    *
    */
    CURSOR CuConsultaSuscripcEf(nuSuscripc NUMBER) IS
      SELECT DECODE(C.CUPONUME, NULL, 0, C.CUPONUME) REFERENCIA,
             C.CUPOTIPO TIPO,
             C.CUPODOCU DODCUMENTO,
             DECODE(C.CUPOVALO, NULL, 0, C.CUPOVALO) VALOR,
             C.CUPOFECH FECHAGEN,
             C.CUPOPROG PROGRAMA,
             DECODE(C.CUPOCUPA, NULL, 0, C.CUPOCUPA) PADRE,
             DECODE(C.CUPOSUSC, NULL, 0, C.CUPOSUSC) SUSCRIPTOR,
             C.CUPOFLPA ESTADO,
             LDCI_PKBSSRECA.fsbGenAddress(AB.ADDRESS_ID) DIRECCION,
             CL.SUBS_LAST_NAME || ' ' || CL.SUBSCRIBER_NAME NOMBRE,

             (select cucofeve
                from open.cuencobr
               where cucofact = to_number(cupodocu)
                 and rownum = 1) +
             OPEN.DALD_PARAMETER.FNUGETNUMERIC_VALUE('DIAS_AD_FECHAV_CODBAR',
                                                     NULL) FECHALIMITE
        FROM CUPON C, SUSCRIPC S, AB_ADDRESS AB, GE_SUBSCRIBER CL
       WHERE S.SUSCCODI = C.CUPOSUSC
	     and C.CUPOSUSC = nuSuscripc
         AND S.SUSCIDDI = AB.ADDRESS_ID
         AND CL.SUBSCRIBER_ID = S.SUSCCLIE
         AND C.CUPOFLPA = 'N'
         AND C.CUPOPROG = 'FIDF'
         and (select cucofeve
                from open.cuencobr
               where cucofact = to_number(cupodocu)
                 and rownum = 1) +
             OPEN.DALD_PARAMETER.FNUGETNUMERIC_VALUE('DIAS_AD_FECHAV_CODBAR',
                                                     NULL) >= sysdate
       ORDER BY CUPOFECH DESC;

    /*
    * CURSOR CuConsultaSuscripc
    * Consulta los datos del suscriptor
    * 06-06-2014
    * ROLLOUT
    *
    */
    CURSOR CuConsultaCupon(nuCupon NUMBER) IS
      SELECT DECODE(C.CUPONUME, NULL, 0, C.CUPONUME) REFERENCIA,
             C.CUPOTIPO TIPO,
             C.CUPODOCU DODCUMENTO,
             DECODE(C.CUPOVALO, NULL, 0, C.CUPOVALO) VALOR,
             C.CUPOFECH FECHAGEN,
             C.CUPOPROG PROGRAMA,
             DECODE(C.CUPOCUPA, NULL, 0, C.CUPOCUPA) PADRE,
             DECODE(C.CUPOSUSC, NULL, 0, C.CUPOSUSC) SUSCRIPTOR,
             C.CUPOFLPA ESTADO,
             LDCI_PKBSSRECA.fsbGenAddress(AB.ADDRESS_ID) DIRECCION,
             CL.SUBS_LAST_NAME || ' ' || CL.SUBSCRIBER_NAME NOMBRE,
             trunc(C.CUPOFECH) + 3650 FECHALIMITE
        FROM CUPON C, SUSCRIPC S, AB_ADDRESS AB, GE_SUBSCRIBER CL
       WHERE C.CUPONUME = nuCupon
         AND S.SUSCCODI = C.CUPOSUSC
         AND S.SUSCIDDI = AB.ADDRESS_ID
         AND CL.SUBSCRIBER_ID = S.SUSCCLIE
         AND
            -- C.CUPOFLPA       = 'N'           AND
             ROWNUM = 1
       ORDER BY CUPOFECH DESC;

  BEGIN

    /*
    * Se valida el tipo de consulta que se esta realizando
    * isbTipoCons = FAC Consulta por cupon
    * isbTipoCons = SUS Consulta por suscriptor
    */

    IF isbTipoCons = 'FAC' THEN
      OPEN CuConsultaCupon(inuCupoCodi);
      FETCH CuConsultaCupon
        INTO onuReferenc, osbCupoTipo, osbDocument, onuValorCup, odtCupoFech, osbCupoProg, onuCupoPadr, onuSuscCodi, osbCupoEsta, osbDireccio, osbNombreSu, odtFechaLim;
      IF CuConsultaCupon%Found THEN
        onuErrorCod := 0;
      ELSE
        onuErrorCod := 1;
        onuReferenc := -1;
        osbCupoTipo := -1;
        osbDocument := -1;
        onuValorCup := -1;
        odtCupoFech := SYSDATE;
        osbCupoProg := -1;
        onuCupoPadr := -1;
        onuSuscCodi := -1;
        osbCupoEsta := -1;
        osbDireccio := -1;
        osbNombreSu := -1;
        odtFechaLim := SYSDATE + 3650;
        onuErrorCod := -1;
      END IF;

      CLOSE CuConsultaCupon;

    ELSE

      /*Jm SAMPAC || Ca 200-1359 || solo aplica para Efigas*/
      IF open.fblAplicaEntrega(csbEntrega2001359) THEN

        OPEN CuConsultaSuscripcEf(inuSuscCodi);
        FETCH CuConsultaSuscripcEf
          INTO onuReferenc, osbCupoTipo, osbDocument, onuValorCup, odtCupoFech, osbCupoProg, onuCupoPadr, onuSuscCodi, osbCupoEsta, osbDireccio, osbNombreSu, odtFechaLim;
        IF CuConsultaSuscripcEf%Found THEN
          onuErrorCod := 0;
        ELSE
          onuReferenc := -1;
          osbCupoTipo := -1;
          osbDocument := -1;
          onuValorCup := -1;
          odtCupoFech := SYSDATE;
          osbCupoProg := -1;
          onuCupoPadr := -1;
          onuSuscCodi := -1;
          osbCupoEsta := -1;
          osbDireccio := -1;
          osbNombreSu := -1;
          odtFechaLim := SYSDATE + 3650;
          onuErrorCod := -1;
        END IF;
        CLOSE CuConsultaSuscripcEf;
      ELSE
        OPEN CuConsultaSuscripc(inuSuscCodi);
        FETCH CuConsultaSuscripc
          INTO onuReferenc, osbCupoTipo, osbDocument, onuValorCup, odtCupoFech, osbCupoProg, onuCupoPadr, onuSuscCodi, osbCupoEsta, osbDireccio, osbNombreSu, odtFechaLim;
        IF CuConsultaSuscripc%Found THEN
          onuErrorCod := 0;
        ELSE
          onuReferenc := -1;
          osbCupoTipo := -1;
          osbDocument := -1;
          onuValorCup := -1;
          odtCupoFech := SYSDATE;
          osbCupoProg := -1;
          onuCupoPadr := -1;
          onuSuscCodi := -1;
          osbCupoEsta := -1;
          osbDireccio := -1;
          osbNombreSu := -1;
          odtFechaLim := SYSDATE + 3650;
          onuErrorCod := -1;
        END IF;
        CLOSE CuConsultaSuscripc;
      END IF;

    END IF;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      onuErrorCod := -1;
      osbErrorMes := 'Error: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE ||
                     ' Localizacion ' || SQLERRM;

      Errors.geterror(onuErrorCod, osbErrorMes);
    WHEN OTHERS THEN
      onuErrorCod := -1;
      osbErrorMes := 'Error: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE ||
                     ' Localizacion ' || SQLERRM;

      osbErrorMes := 'Realizando consulta de cupon' ||
                     DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
      pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, osbErrorMes);
      Errors.seterror;
      Errors.geterror(onuErrorCod, osbErrorMes);
  END proCnltaCupon;

  PROCEDURE proCnltaConcPorFecha(inuCodiEnti     IN banco.banccodi%TYPE,
                                 idtFechaReg     IN DATE,
                                 inuCupon        IN NUMBER,
                                 orfConcPagos    out sys_refcursor,
                                 orfPagos        out sys_refcursor,
                                 onuErrorCode    out number,
                                 osbErrorMessage out varchar2) is

    /*  AUTOR         : Adrian Baldovino Barrios
        FECHA         : 24/06/2014
        DESCRIPCION   : Devuelve todas las conciliaciones generadas para una entidad en una
                        fecha especifica, de igual forma devuelve el detalle de todos los pagos para cada conciliacion.

        Historia de Modificaciones
        Autor   Fecha      Descripcion
    */
  begin

    IF idtFechaReg IS NOT NULL AND inuCodiEnti IS NOT NULL THEN

      OPEN orfConcPagos FOR
        select /*+ RULE*/
         CONCCONS concCodi,
         CONCNUCU concTtalCpon,
         CONCVATO concVlorTtal,
         CONCFLPR concEstado
          from concilia c
         where c.concbanc = inuCodiEnti
           and to_char(trunc(c.concfere), 'DD/MM/YYYY') =
               to_char(idtFechaReg, 'DD/MM/YYYY');
    ELSE

      OPEN orfConcPagos FOR
        SELECT 1 FROM DUAL WHERE 1 = 2;

    END IF;

    IF inuCupon IS NULL THEN

      OPEN orfPagos FOR
        select /*+ RULE*/
         P.PAGOCUPO  cupoCodi,
         P.PAGOVAPA  pagoVal,
         P.PAGOFEPA  pagoFechPag,
         P.PAGOFEGR  pagoFechGr,
         CU.CUPOCUPA cupoRpl,
         p.pagoconc  concilia
          from pagos p
          join cupon cu on p.pagocupo = cu.cuponume
         WHERE p.pagoconc IN
               (SELECT CONCCONS concCodi
                  FROM concilia c
                 WHERE c.concbanc = inuCodiEnti
                   AND to_char(trunc(c.concfere), 'DD/MM/YYYY') =
                       to_char(idtFechaReg, 'DD/MM/YYYY'));
    ELSE

      OPEN orfPagos FOR
        select /*+ RULE*/
         P.PAGOCUPO  cupoCodi,
         P.PAGOVAPA  pagoVal,
         P.PAGOFEPA  pagoFechPag,
         P.PAGOFEGR  pagoFechGr,
         CU.CUPOCUPA cupoRpl,
         p.pagoconc  concilia
          FROM pagos p
          JOIN cupon cu ON p.pagocupo = cu.cuponume
         WHERE p.pagocupo = inuCupon; /* AND
                                                p.pagoconc IN  ( SELECT  CONCCONS concCodi
                                                                 FROM concilia c
                                                                 WHERE c.concbanc = inuCodiEnti AND
                                                                        to_char(trunc(c.concfere), 'DD/MM/YYYY') = to_char(idtFechaReg, 'DD/MM/YYYY'));
                                                                        */

    END IF;

    onuErrorCode := 0;

  exception
    when others then
      pkErrors.NotifyError(pkErrors.fsbLastObject,
                           SQLERRM,
                           osbErrorMessage);
      Errors.seterror;
      Errors.geterror(onuErrorCode, osbErrorMessage);

  end proCnltaConcPorFecha;

  /************************************************************************
  * PROPIEDAD INTELECTUAL PETI ROLLOUT
  *    PROCEDURE : proGnraCuponProd
  *    AUTOR     : Hector Fabio Dominguez
  *    FECHA     : 25-6-2014
  *    RICEF     : I089
  * DESCRIPCION  : Realiza el procesamiento de un listado de productos para
  *                para generar un cupon que cuando se recaudo solo afecte
  *                a estos productos.
  *
  *
  * Historia de Modificaciones
  * Autor        Fecha       Descripcion.
  * HECTORFDV    25-6-2014  Creacion del procedimiento
  ************************************************************************/

  PROCEDURE proGnraCuponProd(isbXMLProd      IN CLOB,
                             onuCupoNume     OUT CUPON.CUPONUME%TYPE,
                             OnuValorTotal   OUT CUPON.CUPOVALO%TYPE,
                             onuErrorCode    OUT NUMBER,
                             osbErrorMessage OUT VARCHAR2) IS

    /*
    * Tipo de dato para almacenar
    * los productos
    *
    */

    TYPE TYCUPRODUCTOS IS RECORD(
      IDPRODUCTO NUMBER(18, 4),
      NUVALOR    NUMBER(18, 4));

    recordProductos TYCUPRODUCTOS;

  BEGIN

    /*
    * Se recorre el listado de productos
    * para armar el xml correspondiente
    */

    /* isbXMLProd:='<?xml version="1.0" encoding="utf-8" ?>
                 <Productos>';

    LOOP FETCH icuProductos INTO recordProductos;
            EXIT WHEN icuProductos%NOTFOUND;

            isbXMLProd:=isbXMLProd||'<Producto>
                                       <Id_Producto>'||recordProductos.IDPRODUCTO||'</Id_Producto>
                                       <Valor_a_Pagar>'||recordProductos.NUVALOR||'</Valor_a_Pagar>
                                     </Producto>';
            END LOOP;
    CLOSE icuProductos;

    isbXMLProd:=isbXMLProd||'</Productos>';
    */

    OS_COUPONGENERATION(INUREFTYPE      => 1,
                        ISBXMLREFERENCE => isbXMLProd,
                        ONUCUPONUME     => ONUCUPONUME,
                        ONUTOTALVALUE   => OnuValorTotal,
                        ONUERRORCODE    => ONUERRORCODE,
                        OSBERRORMESSAGE => OSBERRORMESSAGE);

  exception
    when ex.CONTROLLED_ERROR then
      rollback;
      Errors.geterror(onuErrorCode, osbErrorMessage);
    when others then
      onuErrorCode    := -1;
      osbErrorMessage := 'Error general: ' || Sqlerrm;
  END proGnraCuponProd;

  procedure proGnraCuponPorCtto(inuSusccodi     in SUSCRIPC.SUSCCODI%TYPE,
                                inuSaldoGen     in CUPON.CUPOVALO%TYPE,
                                onuCupoNume     out CUPON.CUPONUME%type,
                                onuErrorCode    out number,
                                osbErrorMessage out varchar2) is

    /*  AUTOR         : Adrian Baldovino Barrios
        FECHA         : 24/06/2014
        DESCRIPCION   : Genera un cupon a partir de una suscripcion

        Historia de Modificaciones
        Autor   Fecha      Descripcion
    */

    isbXMLReference clob;
    onuTotalValue   number;
  begin

    isbXMLReference := '<?xml version="1.0" encoding="utf-8" ?>
                       <Suscripcion>
                         <Id_Suscripcion>' ||
                       inuSusccodi ||
                       '</Id_Suscripcion>
                         <Valor_a_Pagar>' ||
                       inuSaldoGen ||
                       '</Valor_a_Pagar>
                       </Suscripcion >';
    OS_COUPONGENERATION(INUREFTYPE      => 2,
                        ISBXMLREFERENCE => isbXMLReference,
                        ONUCUPONUME     => ONUCUPONUME,
                        ONUTOTALVALUE   => onuTotalValue,
                        ONUERRORCODE    => ONUERRORCODE,
                        OSBERRORMESSAGE => OSBERRORMESSAGE);

    onuErrorCode := 0;

  exception
    when ex.CONTROLLED_ERROR then
      rollback;
      Errors.geterror(onuErrorCode, osbErrorMessage);
    when others then
      onuErrorCode    := -1;
      osbErrorMessage := 'Error general: ' || Sqlerrm;
  end proGnraCuponPorCtto;

END LDCI_PKBSSCOBRO;
/

BEGIN
    pkg_utilidades.prAplicarPermisos('LDCI_PKBSSCOBRO', 'ADM_PERSON'); 
END;
/

GRANT EXECUTE on ADM_PERSON.LDCI_PKBSSCOBRO to INTEGRACIONES;
GRANT EXECUTE on ADM_PERSON.LDCI_PKBSSCOBRO to INTEGRADESA;
GRANT EXECUTE on ADM_PERSON.LDCI_PKBSSCOBRO to EXEBRILLAAPP;
/
