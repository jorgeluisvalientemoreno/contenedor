CREATE OR REPLACE package LDC_BSGESTIONTARIFAS is
  function frfgetConftari( inutipoprod IN NUMBER,
                           onuerror OUT NUMBER,
                           osberror OUT VARCHAR2) RETURN CONSTANTS.TYREFCURSOR;
  /**************************************************************************
    Autor       : olsoftware
    Fecha       : 19/04/2021
    Ticket      : 583
    Proceso     : frfgetConftari
    Descripción: Retorna informacion de la configuracion de tarifas

    Parámetros Entrada
     inutipoprod tipo de producto
    Valor de salida
     onuerror   codigo de erorr 0 - correcto, otro valor incorrecto
     osberror   mensaje de error
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
  PROCEDURE prEnviarCorreo( inuproyecto IN NUMBER,
                            isbDescTari IN VARCHAR2,
                            inuTipoServ IN NUMBER,
                            onuerror OUT NUMBER,
                            osberror OUT VARCHAR2);
  /**************************************************************************
    Autor       : olsoftware
    Fecha       : 19/04/2021
    Ticket      : 583
    Proceso     : prEnviarCorreo
    Descripción: envia correo de aprobacion de tarifa

    Parámetros Entrada
     inuproyecto codigo del proyecto
     isbDescTari descripcion
     inuTipoServ tipo de servicio

    Valor de salida
     onuerror   codigo de erorr 0 - correcto, otro valor incorrecto
     osberror   mensaje de error
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
  PROCEDURE prGetInfoProyTari( inuproytari IN ta_proytari.PRTACONS%type,
                               osbDescTari OUT ta_proytari.PRTADESC%type,
                               onuTipoServ OUT ta_proytari.PRTASERV%type,
                               osbObservacion OUT ta_proytari.prtaobse%type,
                               osbDocumento OUT ta_proytari.prtadocu%type,
                               --onuEstado OUT ta_proytari.PRTAESTA%type,
                               osbFechaIni  OUT VARCHAR2,
                               osbFechaFin OUT VARCHAR2,
                               onuerror OUT NUMBER,
                               osbError OUT VARCHAR2);
   /**************************************************************************
    Autor       : olsoftware
    Fecha       : 19/04/2021
    Ticket      : 583
    Proceso     : prGetInfoProyTari
    Descripción: proceso que devuelve informacion del proyecto


    Parámetros Entrada
     inuproytari proyecto de tarifa
    Valor de salida
     osbDescTari  descripcion de la tarifa
     onuTipoServ  tipo de producto
     onuEstado    estado
     onuerror   codigo de erorr 0 - correcto, otro valor incorrecto
     osberror   mensaje de error
     osbObservacion  observacion
     osbDocumento  documento
     osbFechaIni  Fecha inicial de vigenica
     osbFechaFin fecha final de vigencia
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
  PROCEDURE prProcesatarifas ( inuproytari  IN ta_proytari.PRTACONS%type,
                               isbDescTari   IN  ta_proytari.PRTADESC%type,
                               inuTipoServ   IN  ta_proytari.PRTASERV%type,
                               inuEstado     IN  ta_proytari.PRTAESTA%type,
                               isbObservacion IN ta_proytari.PRTAOBSE%type,
                               isbDocumento IN ta_proytari.PRTAOBSE%type,
                               inuactividad IN  NUMBER,
                               idtFechaIni  IN  DATE,
                               idtFechaFin  IN  DATE,
                               onuproytari  out  ta_proytari.PRTACONS%type,
                               onuerror     OUT NUMBER,
                               osbError     OUT VARCHAR2);
   /**************************************************************************
    Autor       : olsoftware
    Fecha       : 19/04/2021
    Ticket      : 583
    Proceso     : prProcesatarifas
    Descripción: Retorna informacion de la configuracion de tarifas

    Parámetros Entrada
     inuproytari    codigo de tarifa
     isbDescTari    descripcion de la tarifa
     inuTipoServ    tipo de producto
     inuEstado      estado del proyecto
     isbObservacion observacion
     isbDocumento  documento
     inuactividad   actividad
     idtFechaIni    fecha inicial
     idtFechaFin    fecha final
    Valor de salida
     onuerror   codigo de erorr 0 - correcto, otro valor incorrecto
     osberror   mensaje de error
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

  PROCEDURE prLeerarchivoPlano( inuCodigo_Proyecto   IN NUMBER,
                                isbDescripcion       IN LDC_CONFTARI.cotanota%type ,
                                iNUMercado_relevante IN LDC_CONFTARI.COTAMERE%type ,
                                iNutipo_Producto    IN  LDC_CONFTARI.COTASERV%type ,
                                isbTipo_Moneda       IN LDC_CONFTARI.cotatipo%type ,
                                inutarifa_concepto   IN LDC_CONFTARI.cotacotc%type ,
                                inurango_inicial     IN LDC_CONFTARI.cotarain%type ,
                                inurango_final       IN LDC_CONFTARI.cotarafi%type ,
                                inucategoria         IN LDC_CONFTARI.cotacate%type ,
                                inuestrato           IN LDC_CONFTARI.cotasuca%type ,
                                inuvalor_monetario   IN LDC_CONFTARI.cotavalo%type ,
                                inuvalor_porcentaje  IN LDC_CONFTARI.cotaPORC%type,
                                inuTarifaDirecta     IN LDC_CONFTARI.COTATADI%type,
                                inuPorceTariDire     IN LDC_CONFTARI.COTAPTDI%type,
                                inuLinea             IN NUMBER,
                                onuerror             OUT NUMBER,
                                osbError             OUT VARCHAR2);
   /**************************************************************************
    Autor       : olsoftware
    Fecha       : 19/04/2021
    Ticket      : 583
    Proceso     : prLeerarchivoPlano
    Descripción: proceso que se encarga de leer archivo plano

    Parámetros Entrada
     inuCodigo_Proyecto   codigo de proyecto de tarifa
     isbDescripcion       descripcion de la tarifa
     iNutipo_Producto    tipo de producto
     isbTipo_Moneda       Tipo de moneda
     inutarifa_concepto   tarifa por concepto
     inurango_inicial     rango inicial
     inurango_final       rango final
     inucategoria         categoria
     inuestrato           estrato
     inuvalor_monetario   valor monetario
     inuvalor_porcentaje   valor porcentaje
     inuLinea   LINEA DEL ARCHVIO
     inuTarifaDirecta     tarifa directa
        inuPorceTariDire     porcentaje de tarifa directa
    Valor de salida
     onuerror   codigo de erorr 0 - correcto, otro valor incorrecto
     osberror   mensaje de error
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
end LDC_BSGESTIONTARIFAS;
/
CREATE OR REPLACE package BODY LDC_BSGESTIONTARIFAS is

    gsbRemitente      ld_parameter.value_chain%TYPE := pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SMTP_SENDER');

   PROCEDURE prInicializaError(onuerror OUT NUMBER, osberror OUT VARCHAR2) IS
   BEGIN
     onuerror := 0;
     osberror := NULL;
   END prInicializaError;
   function frfgetConftari( inutipoprod IN NUMBER,
                           onuerror OUT NUMBER,
                           osberror OUT VARCHAR2) RETURN CONSTANTS.TYREFCURSOR is
  /**************************************************************************
    Autor       : olsoftware
    Fecha       : 19/04/2021
    Ticket      : 583
    Proceso     : frfgetConftari
    Descripciÿ³n: Retorna informacion de la configuracion de tarifas

    Parÿ¡metros Entrada
     inutipoprod tipo de producto
    Valor de salida
     onuerror   codigo de erorr 0 - correcto, otro valor incorrecto
     osberror   mensaje de error
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
    ORFCURSOR CONSTANTS.TYREFCURSOR;

  BEGIN
    UT_TRACE.TRACE('INICIO LDC_BSGESTIONTARIFAS.frfgetConftari inuservicio '||inutipoprod, 10);
   prInicializaError(onuerror, osberror);

    ORFCURSOR  := LDC_BCGESTIONTARIFAS.frfgetConftari(inutipoprod,
                                                       onuerror,
                                                       osberror);

    UT_TRACE.TRACE('FIN LDC_BSGESTIONTARIFAS.frfgetConftari', 10);

    RETURN ORFCURSOR;


  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
       ERRORS.GETERROR(onuerror, osberror);
      RETURN ORFCURSOR;
    WHEN OTHERS THEN
      ERRORS.SETERROR;
      ERRORS.GETERROR(onuerror, osberror);
       RETURN ORFCURSOR;
  END frfgetConftari;

  PROCEDURE prGetInfoProyTari( inuproytari IN ta_proytari.PRTACONS%type,
                               osbDescTari OUT ta_proytari.PRTADESC%type,
                               onuTipoServ OUT ta_proytari.PRTASERV%type,
                               osbObservacion OUT ta_proytari.prtaobse%type,
                               osbDocumento OUT ta_proytari.prtadocu%type,
                               --onuEstado OUT ta_proytari.PRTAESTA%type,
                               osbFechaIni  OUT VARCHAR2,
                               osbFechaFin OUT VARCHAR2,
                               onuerror OUT NUMBER,
                               osbError OUT VARCHAR2) is
   /**************************************************************************
    Autor       : olsoftware
    Fecha       : 19/04/2021
    Ticket      : 583
    Proceso     : prGetInfoProyTari
    Descripciÿ³n: proceso que devuelve informacion del proyecto


    Parÿ¡metros Entrada
     inuproytari proyecto de tarifa
    Valor de salida
     osbDescTari  descripcion de la tarifa
     onuTipoServ  tipo de producto
     onuEstado    estado
     onuerror   codigo de erorr 0 - correcto, otro valor incorrecto
     osberror   mensaje de error
     osbObservacion  observacion
     osbDocumento  documento
     osbFechaIni  Fecha inicial de vigenica
     osbFechaFin fecha final de vigencia
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

  BEGIN
    UT_TRACE.TRACE('INICIO LDC_BSGESTIONTARIFAS.prGetInfoProyTari inuproytari['||inuproytari||']', 10);
    prInicializaError(onuerror, osberror);

    OPEN LDC_BCGESTIONTARIFAS.cugetInfoProytari(inuproytari);
    FETCH LDC_BCGESTIONTARIFAS.cugetInfoProytari INTO osbDescTari, onuTipoServ, osbObservacion,osbDocumento ;
    IF LDC_BCGESTIONTARIFAS.cugetInfoProytari%NOTFOUND THEN
       onuerror := -1;
       osbError := 'Proyecto de Tarifa ['||inuproytari||'] no existe';
    END IF;
    CLOSE LDC_BCGESTIONTARIFAS.cugetInfoProytari;

    OPEN LDC_BCGESTIONTARIFAS.cuGetFechasVige(inuproytari);
    FETCH LDC_BCGESTIONTARIFAS.cuGetFechasVige INTO osbFechaIni, osbFechaFin;
    CLOSE LDC_BCGESTIONTARIFAS.cuGetFechasVige;

    UT_TRACE.TRACE('FIN LDC_BSGESTIONTARIFAS.prGetInfoProyTari', 10);

   EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
       ERRORS.GETERROR(onuerror, osberror);
    WHEN OTHERS THEN
      ERRORS.SETERROR;
      ERRORS.GETERROR(onuerror, osberror);
  END prGetInfoProyTari;

  PROCEDURE prEnviarCorreo( inuproyecto IN NUMBER,
                            isbDescTari IN VARCHAR2,
                            inuTipoServ IN NUMBER,
                            onuerror OUT NUMBER,
                            osberror OUT VARCHAR2) IS
   /**************************************************************************
    Autor       : olsoftware
    Fecha       : 19/04/2021
    Ticket      : 583
    Proceso     : prEnviarCorreo
    Descripciÿ³n: envia correo de aprobacion de tarifa

    Parÿ¡metros Entrada
     inuproyecto codigo del proyecto
     isbDescTari descripcion
     inuTipoServ tipo de servicio

    Valor de salida
     onuerror   codigo de erorr 0 - correcto, otro valor incorrecto
     osberror   mensaje de error
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
   sbEMail VArCHAR2(400);
   sbNombre GE_PERSON.NAME_%type;

   CURSOR cuGetEmail IS
   SELECT E_MAIL, NAME_
   FROM GE_PERSON
   WHERE person_id = ge_bopersonal.fnugetpersonid;
  BEGIN
     prInicializaError(onuerror, osberror);

      OPEN cuGetEmail;
      FETCH cuGetEmail INTO sbEMail, sbNombre;
      CLOSE cuGetEmail;

      IF sbEMail IS NOT NULL THEN

        pkg_Correo.prcEnviaCorreo
        (
            isbRemitente        => gsbRemitente,
            isbDestinatarios    => sbEMail,
            isbAsunto           => 'Aprobacion de Proyecto de Tarifas',
            isbMensaje          =>
                    'El siguiente proyecto se ha aprobado.<br/><br/>'
                    || '<table> <tr> <td> Id proyecto : </td> <td>    '
                    ||inuproyecto
                    ||'</td> </tr>'
                    || '<tr> <td>  Descripcion Proyecto: </td> <td> '
                    ||isbDescTari
                    ||'</td> </tr> '
                    || '<tr> <td>  Servicio: </td> <td> '
                    ||inuTipoServ
                    ||'</td> </tr> '
                    || '<tr> <td> Fecha de actualizacion:</td> <td> '
                    ||TO_CHAR(SYSDATE,'DD/MM/YYYY HH24:MI:SS')
                    ||'</td> </tr> '
                    || '<tr> <td> Persona que aprobo:</td> <td> '
                    ||sbNombre
                    ||'</td> </tr> </table>'
        );

      END IF;
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
       ERRORS.GETERROR(onuerror, osberror);
    WHEN OTHERS THEN
      ERRORS.SETERROR;
      ERRORS.GETERROR(onuerror, osberror);
  END prEnviarCorreo;

  PROCEDURE prProcesatarifas ( inuproytari  IN  ta_proytari.PRTACONS%type,
                               isbDescTari   IN  ta_proytari.PRTADESC%type,
                               inuTipoServ   IN  ta_proytari.PRTASERV%type,
                               inuEstado     IN  ta_proytari.PRTAESTA%type,
                               isbObservacion IN ta_proytari.PRTAOBSE%type,
                               isbDocumento IN ta_proytari.PRTAOBSE%type,
                               inuactividad IN  NUMBER,
                               idtFechaIni  IN  DATE,
                               idtFechaFin  IN  DATE,
                               onuproytari  out  ta_proytari.PRTACONS%type,
                               onuerror     OUT NUMBER,
                               osbError     OUT VARCHAR2) IS
   /**************************************************************************
    Autor       : olsoftware
    Fecha       : 19/04/2021
    Ticket      : 583
    Proceso     : prProcesatarifas
    Descripciÿ³n: Retorna informacion de la configuracion de tarifas

    Parÿ¡metros Entrada
     inuproytari    codigo de tarifa
     isbDescTari    descripcion de la tarifa
     inuTipoServ    tipo de producto
     inuEstado      estado del proyecto
     isbObservacion observacion
     isbDocumento  documento
     inuactividad   actividad
     idtFechaIni    fecha inicial
     idtFechaFin    fecha final
    Valor de salida
     onuerror   codigo de erorr 0 - correcto, otro valor incorrecto
     osberror   mensaje de error
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
    sbexiste VARCHAR2(1);
    nuExiste NUMBER;
    nuEstado NUMBER;
    onuErrorActu NUMBER;
    osberrorActu VARCHAR2(4000);

    CURSOR cugetExisteProy IS
    SELECT 'X'
    FROM ta_proytari
    WHERE PRTACONS = inuproytari;

    nuTariProy NUMBER;

    CURSOR cuGetVigencia IS
    SELECT VITPTACP
    FROM ta_vigetacp v, ta_taricopr t
    where t.TACPPRTA = inuproytari
     and TACPCONS = VITPTACP
     and (VITPFEIN <> idtFechaIni or VITPFEFI <> idtFechaFin);

    PROCEDURE prValidaInfoTari( onucoderror OUT NUMBER,
                                osbmensError OUT VARCHAR2) IS
      erDatosNovalido EXCEPTION;
    BEGIN

        prInicializaError(onucoderror, osbmensError);

       --IF inuproytari IS NOT NULL THEN
        IF nvl(inuproytari, -1) != -1 THEN
           OPEN cugetExisteProy;
           FETCH cugetExisteProy INTO sbexiste;
           IF cugetExisteProy%NOTFOUND THEN
              CLOSE cugetExisteProy;
              onucoderror := -1;
              osbmensError := 'Proyecto de Tarifa ['||inuproytari||'] no existe.';
              RAISE erDatosNovalido;
           END IF;
           CLOSE cugetExisteProy;
        END IF;

       IF isbDescTari IS NULL THEN
          onucoderror := -1;
          osbmensError := 'Descripcion de la tarifa es obligatoria';
          RAISE erDatosNovalido;
       END IF;

       IF inuTipoServ IS NULL THEN
          onucoderror := -1;
          osbmensError := 'Tipo de producto es obligatorio';
          RAISE erDatosNovalido;
       END IF;

       IF inuEstado IS NULL THEN
          onucoderror := -1;
          osbmensError := 'Estado del proyecto es obligatorio';
          RAISE erDatosNovalido;
       END IF;

       IF isbObservacion IS NULL THEN
         onucoderror := -1;
          osbmensError := 'Observacion del proyecto es obligatorio';
          RAISE erDatosNovalido;
       END IF;

      IF isbDocumento IS NULL THEN
         onucoderror := -1;
          osbmensError := 'Documento del proyecto es obligatorio';
          RAISE erDatosNovalido;
       END IF;


       IF inuactividad IS NULL and inuproytari is not null THEN
          onucoderror := -1;
          osbmensError := 'Actividad a realizar es obligatoria';
           RAISE erDatosNovalido;
       END IF;
    EXCEPTION
      WHEN erDatosNovalido THEN
         NULL;
    END prValidaInfoTari;

  BEGIN
     UT_TRACE.TRACE('INICIO LDC_BSGESTIONTARIFAS.prProcesatarifas inuproytari['||inuproytari||']', 10);
     prInicializaError(onuerror, osberror);
     UT_TRACE.TRACE('isbDescTari ['||isbDescTari||'] inuTipoServ['||inuTipoServ||'] inuEstado['||inuEstado||']', 10);
     UT_TRACE.TRACE('isbObservacion ['||isbObservacion||'] isbDocumento['||isbDocumento||'] inuactividad['||inuactividad||']', 10);
     UT_TRACE.TRACE('idtFechaIni ['||idtFechaIni||'] idtFechaFin['||idtFechaFin||']', 10);
     --se validan datos
      prValidaInfoTari(onuerror, osberror);
      IF onuerror <> 0 THEN
        RETURN;
      END IF;
      --se crea proyecto
      IF nvl(inuproytari, -1) = -1 THEN
        LDC_BOGESTIONTARIFAS.prCreaProyectoTarifa( isbDescTari ,
                                                   inuTipoServ ,
                                                   inuEstado,
                                                   isbObservacion ,
                                                   isbDocumento,
                                                   SYSDATE,
                                                   onuproytari,
                                                   onuerror,
                                                   osberror);
        IF onuerror = 0 THEN
           UPDATE LDC_TEMPTARI SET TETAPROY = onuproytari WHERE TETAPROY = -1;
           LDC_BOGESTIONTARIFAS.prGestionTarifaProyecto ( onuproytari,
                                                           idtFechaIni,
                                                           idtFechaFin,
                                                           onuError,
                                                           osbError);
         ELSE
          RETURN;
        END IF;
      ELSE
          select count(1) into nuExiste
          from LDC_TEMPTARI
          WHERE TETAPROY = inuproytari;
          pkErrors.setApplication('TPRT');
          if inuactividad <> 4 and nuExiste = 0 then
              open cuGetVigencia;
              fetch cuGetVigencia into nuTariProy;
              if cuGetVigencia%found then
                 update TA_VIGETACP set VITPFEIN = idtFechaIni ,VITPFEFI =idtFechaFin
                 where VITPTACP = nuTariProy;
              end if;
              close cuGetVigencia;
          end if;
           UT_TRACE.TRACE('nuExiste ['||nuExiste||']', 10);
           IF nuExiste > 0  THEN
               LDC_BOGESTIONTARIFAS.prGestionTarifaProyecto ( inuproytari,
                                                             idtFechaIni,
                                                             idtFechaFin,
                                                             onuError,
                                                             osbError);
              IF onuError <> 0 THEN
                 RETURN;
              END IF;
           END IF;

           IF inuactividad = 3 THEN
             LDC_BOGESTIONTARIFAS.prActivaTarifa( inuproytari,
                                                  onuErroR,
                                                  osbError);
             IF onuErroR <> 0 THEN
                nuEstado := 5;
                LDC_BOGESTIONTARIFAS.prActualizaProyectoTari( inuproytari,
                                                           isbDescTari ,
                                                           inuTipoServ,
                                                           nuEstado ,
                                                           isbObservacion,
                                                           isbDocumento,
                                                           onuErrorActu ,
                                                           osberrorActu);
                RETURN;
            END IF;

           END IF;
           --se actualiza proyecto
           LDC_BOGESTIONTARIFAS.prActualizaProyectoTari( inuproytari,
                                                         isbDescTari ,
                                                         inuTipoServ,
                                                         inuactividad ,
                                                         isbObservacion,
                                                         isbDocumento,
                                                         onuErroR ,
                                                         osbError);
           IF onuErroR = 0 AND inuactividad = 3 THEN
              PrEnviarCorreo( inuproytari,
                            isbDescTari ,
                            inuTipoServ,
                            onuErrorActu,
                            osberrorActu );
           END IF;
      END IF;


     UT_TRACE.TRACE('FIN LDC_BSGESTIONTARIFAS.prProcesatarifas', 10);
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
       ERRORS.GETERROR(onuerror, osberror);
    WHEN OTHERS THEN
      ERRORS.SETERROR;
      ERRORS.GETERROR(onuerror, osberror);
  END prProcesatarifas;

  PROCEDURE prLeerarchivoPlano( inuCodigo_Proyecto   IN NUMBER,
                                isbDescripcion       IN LDC_CONFTARI.cotanota%type ,
                                inuMercado_relevante IN LDC_CONFTARI.COTAMERE%type ,
                                iNutipo_Producto    IN  LDC_CONFTARI.COTASERV%type ,
                                isbTipo_Moneda       IN LDC_CONFTARI.cotatipo%type ,
                                inutarifa_concepto   IN LDC_CONFTARI.cotacotc%type ,
                                inurango_inicial     IN LDC_CONFTARI.cotarain%type ,
                                inurango_final       IN LDC_CONFTARI.cotarafi%type ,
                                inucategoria         IN LDC_CONFTARI.cotacate%type ,
                                inuestrato           IN LDC_CONFTARI.cotasuca%type ,
                                inuvalor_monetario   IN LDC_CONFTARI.cotavalo%type ,
                                inuvalor_porcentaje  IN LDC_CONFTARI.cotaPORC%type,
                                inuTarifaDirecta     IN LDC_CONFTARI.COTATADI%type,
                                inuPorceTariDire     IN LDC_CONFTARI.COTAPTDI%type,
                                inuLinea             IN NUMBER,
                                onuerror             OUT  NUMBER,
                                osbError             OUT VARCHAR2) IS
   /**************************************************************************
    Autor       : olsoftware
    Fecha       : 19/04/2021
    Ticket      : 583
    Proceso     : prLeerarchivoPlano
    Descripciÿ³n: proceso que se encarga de leer archivo plano

    Parÿ¡metros Entrada
     inuCodigo_Proyecto   codigo de proyecto de tarifa
     isbDescripcion       descripcion de la tarifa
     isNutipo_Producto    tipo de producto
     isbTipo_Moneda       Tipo de moneda
     inutarifa_concepto   tarifa por concepto
     inurango_inicial     rango inicial
     inurango_final       rango final
     inucategoria         categoria
     inuestrato           estrato
     inuvalor_monetario   valor monetario
     inuvalor_porcentaje   valor porcentaje
     inuTarifaDirecta     tarifa directa
    inuPorceTariDire     porcentaje de tarifa directa
    Valor de salida
     onuerror   codigo de erorr 0 - correcto, otro valor incorrecto
     osberror   mensaje de error
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
    sbexiste VARCHAR2(1);
    nuTipoProd NUMBER;

    CURSOR cuValidaMercado IS
    SELECT 'X'
    FROM FA_MERCRELE m
    WHERE M.MERECODI = inuMercado_relevante;

    CURSOR cuVAlidaTimo IS
    SELECT 'X'
    FROM GST_TIPOMONE
    where TIMOCODI = isbTipo_Moneda ;

    CURSOR cuVAlidaConfTari IS
    SELECT COTCSERV
    FROM ta_conftaco
    where COTCCONS = inutarifa_concepto ;

    CURSOR cuValidaCate IS
    SELECT 'X'
    FROM categori
    WHERE catecodi = inucategoria;

    CURSOR cuValidaEstrato IS
    SELECT 'X'
    FROM SUBCATEG
    WHERE SUCACATE = inucategoria
     and sucacodi = inuestrato;

    CURSOR cuExisteRegis IS
    SELECT 'X'
    FROM LDC_TEMPTARI
    WHERE TETAPROY = inuCodigo_Proyecto
      AND TETAMERE = inuMercado_relevante
      AND TETASERV = iNutipo_Producto
      AND TETACOTC = inutarifa_concepto
      AND TETARAIN = inurango_inicial
      AND TETARAFI = inurango_final
      AND TETACATE = inucategoria
      AND TETASUCA = inuestrato;

  BEGIN
     UT_TRACE.TRACE('INICIO LDC_BSGESTIONTARIFAS.prLeerarchivoPlano', 10);
     prInicializaError(onuerror, osberror);

     IF inuLinea = 2 THEN
        delete from LDC_TEMPTARI;
     END IF;

     osberror := ' ERROR ';

     OPEN cuValidaMercado;
     FETCH cuValidaMercado INTO sbexiste;
     IF cuValidaMercado%NOTFOUND THEN
         onuerror := -1;
         osberror := 'Mercado Relevante ['||inuMercado_relevante||'] no existe';
     END IF;
     CLOSE cuValidaMercado;

     OPEN cuVAlidaTimo;
     FETCH cuVAlidaTimo INTO sbexiste;
     IF cuVAlidaTimo%NOTFOUND THEN
         onuerror := -1;
         osberror := osberror||'|Tipo de moneda ['||isbTipo_Moneda||'] no existe';
     END IF;
     CLOSE cuVAlidaTimo;

     OPEN cuVAlidaConfTari;
     FETCH cuVAlidaConfTari INTO nuTipoProd;
     IF cuVAlidaConfTari%NOTFOUND THEN
         onuerror := -1;
         osberror := osberror||'|Tarifa por concepto ['||inutarifa_concepto||'] no existe';
     ELSE
       IF nuTipoProd <> iNutipo_Producto THEN
          onuerror := -1;
         osberror := osberror||'|Tipo de producto ['||nuTipoProd||'] asociado a la tarifa por concepto ['||inutarifa_concepto||'], es diferente al tipo de producto del proyecto ['||iNutipo_Producto||']';
       END IF;
     END IF;
     CLOSE cuVAlidaConfTari;

     IF inurango_inicial < 0 THEN
        onuerror := -1;
        osberror := osberror||'|Rango Inicial ['||inurango_inicial||'] no puede ser menor a cero';
     END IF;

     IF inurango_final < 0 THEN
        onuerror := -1;
        osberror := osberror||'|Rango Final ['||inurango_inicial||'] no puede ser menor a cero';
     ELSIF inurango_final < inurango_inicial THEN
        onuerror := -1;
        osberror := osberror||'|Rango Final ['||inurango_inicial||'] no puede ser menor al rango inicial ['||inurango_inicial||']';
     END IF;

     open cuValidaCate;
     FETCH cuValidaCate INTO sbExiste;
     IF cuValidaCate%NOTFOUND THEN
        onuerror := -1;
        osberror := osberror||'|Categoria ['||inucategoria||'] no existe';
     END IF;
     CLOSE cuValidaCate;

      open cuValidaEstrato;
     FETCH cuValidaEstrato INTO sbExiste;
     IF cuValidaEstrato%NOTFOUND THEN
        onuerror := -1;
        osberror := osberror||'|Subcategoria ['||inuestrato||'] no existe o no esta asociada a la categoria ['||inucategoria||']';
     END IF;
     CLOSE cuValidaEstrato;

     IF inuvalor_monetario < 0 THEN
        onuerror := -1;
        osberror := osberror||'|Valor Monetario ['||inuvalor_monetario||'] no puede ser menor que cero';
     END IF;

     IF inuvalor_porcentaje < 0 THEN
        onuerror := -1;
        osberror := osberror||'|Valor Porcentaje ['||inuvalor_porcentaje||'] no puede ser menor que cero';
     ELSIF inuvalor_porcentaje > 100 THEN
       onuerror := -1;
        osberror := osberror||'|Valor Porcentaje ['||inuvalor_porcentaje||'] no puede ser mayor que 100';
     END IF;

     IF nvl(inuTarifaDirecta,0) < 0 THEN
        onuerror := -1;
        osberror := osberror||'|Tarifa directa ['||inuTarifaDirecta||'] no puede ser menor que cero';
     END IF;

     IF nvl(inuPorceTariDire,0) < 0 THEN
        onuerror := -1;
        osberror := osberror||'|Porcentaje de tarifa directa ['||inuPorceTariDire||'] no puede ser menor que cero';
     ELSIF nvl(inuPorceTariDire,0) > 100 THEN
       onuerror := -1;
        osberror := osberror||'|Porcentaje de tarifa directa ['||inuPorceTariDire||'] no puede ser mayor que 100';
     END IF;

     OPEN cuExisteRegis;
     FETCH cuExisteRegis INTO sbExiste;
     IF cuExisteRegis%FOUND THEN
        onuerror := -1;
        osberror := osberror||'|Combinacion de registro '||inuCodigo_Proyecto||'-'|| inuMercado_relevante ||'-'|| iNutipo_Producto ||'-'|| inutarifa_concepto ||'-'|| inurango_inicial ||'-'|| inurango_final ||'-'|| inucategoria ||'-'|| inuestrato||' Existe';
     END IF;
     CLOSE cuExisteRegis;

     IF onuerror = 0 THEN
     INSERT INTO LDC_TEMPTARI
          (
            TETAPROY,
            TETAMERE,
            TETANOTA,
            TETATIPO,
            TETASERV,
            TETACOTC,
            TETARAIN,
            TETARAFI,
            TETACATE,
            TETASUCA,
            TETAVALO,
            TETAPORC,
            TETATADI,
            TETAPTDI
          )
          VALUES
          (
            inuCodigo_Proyecto   ,
            iNUMercado_relevante ,
            isbDescripcion       ,
            isbTipo_Moneda       ,
            iNutipo_Producto     ,
            inutarifa_concepto   ,
            inurango_inicial     ,
            inurango_final       ,
            inucategoria         ,
            inuestrato           ,
            inuvalor_monetario   ,
            inuvalor_porcentaje,
            inuTarifaDirecta,
            inuPorceTariDire
          );
     END IF;

     UT_TRACE.TRACE('FIN LDC_BSGESTIONTARIFAS.prLeerarchivoPlano', 10);
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
       ERRORS.GETERROR(onuerror, osberror);
    WHEN OTHERS THEN
      ERRORS.SETERROR;
      ERRORS.GETERROR(onuerror, osberror);
  END prLeerarchivoPlano;
end LDC_BSGESTIONTARIFAS;
/
GRANT EXECUTE on LDC_BSGESTIONTARIFAS to SYSTEM_OBJ_PRIVS_ROLE;
/
