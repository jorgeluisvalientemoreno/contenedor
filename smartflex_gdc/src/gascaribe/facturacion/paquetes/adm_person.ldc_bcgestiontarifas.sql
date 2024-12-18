CREATE OR REPLACE PACKAGE adm_person.ldc_bcgestiontarifas IS

  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  18/06/2024   Adrianavg   OSF-2798: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
  cursor cugetInfoProytari(inuproytari number) IS
   SELECT PRTADESC,
          PRTASERV,
          prtaobse,
          prtadocu
   FROM ta_proytari
   WHERE PRTACONS = inuproytari;

   CURSOR cuGetFechasVige(inuproytari number) IS
   SELECT to_char(V.VITPFEin, 'dd/mm/yyyy hh24:mi:ss'), to_char(V.VITPFEFI,'dd/mm/yyyy hh24:mi:ss')
  FROM  TA_TARICOPR T, TA_VIGETACP V
  WHERE TACPPRTA = inuproytari
    AND VITPTACP =TACPCONS
    AND V.VITPTIPO = 'B';

    PROCEDURE prInicializaError(onuerror OUT NUMBER, osberror OUT VARCHAR2);

   function frfgetConftari( inutipoprod IN NUMBER,
                           onuerror OUT NUMBER,
                           osberror OUT VARCHAR2) RETURN CONSTANTS.TYREFCURSOR;
    /**************************************************************************
    Autor       : olsoftware
    Fecha       : 19/04/2021
    Ticket      : 583
    Proceso     : frfgetConftari
    Descripci��n: Retorna informacion de la configuracion de tarifas

    Par��metros Entrada
     inutipoprod tipo de producto
    Valor de salida
     onuerror   codigo de erorr 0 - correcto, otro valor incorrecto
     osberror   mensaje de error
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

  PROCEDURE prInsertaProyecto( isbDescTari   IN  ta_proytari.PRTADESC%type,
                               inuTipoServ   IN  ta_proytari.PRTASERV%type,
                               inuEstado     IN  ta_proytari.PRTAESTA%type,
                               isbObservacion IN ta_proytari.PRTAOBSE%type,
                               isbDocumento   IN ta_proytari.PRTADOCU%type,
                               idtFecha      IN  DATE,
                               onuProyTarifa OUT NUMBER,
                               onuError      OUT NUMBER,
                               osberror  OUT VARCHAR2);
   /**************************************************************************
    Autor       : olsoftware
    Fecha       : 19/04/2021
    Ticket      : 583
    Proceso     : prInsertaProyecto
    Descripci��n: insertar proyecto de tarifa

    Par��metros Entrada
     isbDescTari  Descripciond el proyecto
     inuTipoServ  tipo de producto
     inuEstado    estado
     isbObservacion  observacion
     isbDocumento  documento
     idtFecha  fecha
    Valor de salida
     onuerror   codigo de erorr 0 - correcto, otro valor incorrecto
     osberror   mensaje de error
     onuProyTarifa  codigo del proyecto de tarifa
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

   PROCEDURE prActualizaProyecto( inuProyTarifa IN NUMBER,
                                 isbDescTari   IN  ta_proytari.PRTADESC%type,
                                 inuTipoServ   IN  ta_proytari.PRTASERV%type,
                                 inuEstado     IN  ta_proytari.PRTAESTA%type,
                                 isbObservacion IN ta_proytari.PRTAOBSE%type,
                                 isbDocumento   IN ta_proytari.PRTADOCU%type,
                                 onuError      OUT NUMBER,
                                 osberror  OUT VARCHAR2);
   /**************************************************************************
    Autor       : olsoftware
    Fecha       : 19/04/2021
    Ticket      : 583
    Proceso     : prActualizaProyecto
    Descripci��n: actualiza proyecto de tarifa

    Par��metros Entrada
     isbDescTari  Descripciond el proyecto
     inuTipoServ  tipo de producto
     inuEstado    estado
     isbObservacion  observacion
     isbDocumento  documento
     inuProyTarifa  codigo del proyecto de tarifa

    Valor de salida
     onuerror   codigo de erorr 0 - correcto, otro valor incorrecto
     osberror   mensaje de error

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

  PROCEDURE prInsertarTarifas( inuproyTari  IN NUMBER,
                               idtfechaIni  IN DATE,
                               idtFechaFin  IN DATE,
                               onuError     OUT  NUMBER,
                               osbError     OUT VARCHAR2);
  /**************************************************************************
    Autor       : olsoftware
    Fecha       : 19/04/2021
    Ticket      : 583
    Proceso     : prInsertarTarifas
    Descripci��n: insertar tarifas de trabajo

    Par��metros Entrada
     inuproyTari  codigo del proyecto de tarifa
     idtfechaIni  fecha inicial
     idtFechaFin  fecha final

    Valor de salida
     onuerror   codigo de erorr 0 - correcto, otro valor incorrecto
     osberror   mensaje de error

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

  PROCEDURE prInsertarTariActi( inuproyTari  IN NUMBER,
                                onuError     OUT  NUMBER,
                                osbError     OUT VARCHAR2);
  /**************************************************************************
    Autor       : olsoftware
    Fecha       : 19/04/2021
    Ticket      : 583
    Proceso     : prInsertarTariActi
    Descripci��n: insertar tarifas activas

    Par��metros Entrada
     inuproyTari  codigo del proyecto de tarifa

    Valor de salida
     onuerror   codigo de erorr 0 - correcto, otro valor incorrecto
     osberror   mensaje de error

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/


END LDC_BCGESTIONTARIFAS;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_BCGESTIONTARIFAS IS
   CNUPROGRAMA CONSTANT NUMBER := 601;
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
    Descripci��n: Retorna informacion de la configuracion de tarifas

    Par��metros Entrada
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

     OPEN ORFCURSOR FOR
        SELECT  cotanota Descripcion,
               COTAMERE Mercado_relevante,
               cotatipo Tipo_Moneda,
               cotacotc tarifa_concepto,
               cotarain rango_inicial,
               cotarafi rango_final,
               cotacate categoria,
               cotasuca estrato,
               cotavalo valor_monetario,
               cotaPORC valor_porcentaje,
               COTATADI tarifa_directa,
               C.COTAPTDI porc_tarifa_directa
          FROM LDC_CONFTARI c
          WHERE c.cotaserv =  inutipoprod
          order by COTAMERE;

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

  PROCEDURE prInsertaProyecto( isbDescTari   IN  ta_proytari.PRTADESC%type,
                               inuTipoServ   IN  ta_proytari.PRTASERV%type,
                               inuEstado     IN  ta_proytari.PRTAESTA%type,
                               isbObservacion IN ta_proytari.PRTAOBSE%type,
                               isbDocumento   IN ta_proytari.PRTADOCU%type,
                               idtFecha      IN  DATE,
                               onuProyTarifa OUT NUMBER,
                               onuError      OUT NUMBER,
                               osberror  OUT VARCHAR2) IS
   /**************************************************************************
    Autor       : olsoftware
    Fecha       : 19/04/2021
    Ticket      : 583
    Proceso     : prInsertaProyecto
    Descripci��n: insertar proyecto de tarifa

    Par��metros Entrada
     isbDescTari  Descripciond el proyecto
     inuTipoServ  tipo de producto
     inuEstado    estado
     isbObservacion  observacion
     isbDocumento  documento
     inuFecha  fecha
    Valor de salida
     onuerror   codigo de erorr 0 - correcto, otro valor incorrecto
     osberror   mensaje de error
     onuProyTarifa  codigo del proyecto de tarifa
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
  BEGIN
    UT_TRACE.TRACE('INICIO LDC_BCGESTIONTARIFAS.prInsertaProyecto ', 10);
    prInicializaError(onuerror, osberror);
     onuProyTarifa := SQ_TA_PROYTARI_PRTACONS.NEXTVAL;
    INSERT INTO TA_PROYTARI
      (
        PRTACONS, PRTADESC, PRTASERV, PRTAFECH, PRTADOCU, PRTAESTA, PRTAOBSE, PRTAPROG, PRTAUSUA, PRTATERM
      )
      VALUES
      (
        onuProyTarifa, isbDescTari, inuTipoServ, idtFecha, substr(isbDocumento,1,49), inuEstado,  isbObservacion, CNUPROGRAMA,pkGeneralServices.fsbGetUserName, pkGeneralServices.fsbGetTerminal
       );


    UT_TRACE.TRACE('FIN LDC_BCGESTIONTARIFAS.prInsertaProyecto ', 10);
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
       ERRORS.GETERROR(onuerror, osberror);
    WHEN OTHERS THEN
      ERRORS.SETERROR;
      ERRORS.GETERROR(onuerror, osberror);
  END prInsertaProyecto;

   PROCEDURE prActualizaProyecto( inuProyTarifa IN NUMBER,
                                 isbDescTari   IN  ta_proytari.PRTADESC%type,
                                 inuTipoServ   IN  ta_proytari.PRTASERV%type,
                                 inuEstado     IN  ta_proytari.PRTAESTA%type,
                                 isbObservacion IN ta_proytari.PRTAOBSE%type,
                                 isbDocumento   IN ta_proytari.PRTADOCU%type,
                                 onuError      OUT NUMBER,
                                 osberror  OUT VARCHAR2) IS
   /**************************************************************************
    Autor       : olsoftware
    Fecha       : 19/04/2021
    Ticket      : 583
    Proceso     : prInsertaProyecto
    Descripci��n: insertar proyecto de tarifa

    Par��metros Entrada
     isbDescTari  Descripciond el proyecto
     inuTipoServ  tipo de producto
     inuEstado    estado
     isbObservacion  observacion
     isbDocumento  documento
     inuProyTarifa  codigo del proyecto de tarifa

    Valor de salida
     onuerror   codigo de erorr 0 - correcto, otro valor incorrecto
     osberror   mensaje de error

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
  BEGIN
    UT_TRACE.TRACE('INICIO LDC_BCGESTIONTARIFAS.prActualizaProyecto ', 10);
    prInicializaError(onuerror, osberror);

    UPDATE TA_PROYTARI SET PRTADESC = isbDescTari,
                          PRTASERV = inuTipoServ,
                          --PRTAFECH = SYSDATE,
                          PRTADOCU = substr(isbDocumento,1,49),
                          PRTAESTA = inuEstado,
                          PRTAOBSE = isbObservacion ,
                          PRTAUSUA = pkGeneralServices.fsbGetUserName,
                          PRTATERM = pkGeneralServices.fsbGetTerminal
    WHERE PRTACONS = inuProyTarifa;
   UT_TRACE.TRACE('FIN LDC_BCGESTIONTARIFAS.prActualizaProyecto ', 10);
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
       ERRORS.GETERROR(onuerror, osberror);
    WHEN OTHERS THEN
      ERRORS.SETERROR;
      ERRORS.GETERROR(onuerror, osberror);
  END prActualizaProyecto;

    PROCEDURE prInsertarTarifas( inuproyTari  IN NUMBER,
                               idtfechaIni  IN DATE,
                               idtFechaFin  IN DATE,
                               onuError     OUT  NUMBER,
                               osbError     OUT VARCHAR2) IS
  /**************************************************************************
    Autor       : olsoftware
    Fecha       : 19/04/2021
    Ticket      : 583
    Proceso     : prInsertarTarifas
    Descripci��n: insertar tarifas de trabajo

    Par��metros Entrada
     inuproyTari  codigo del proyecto de tarifa
     idtfechaIni  fecha inicial
     idtFechaFin  fecha final

    Valor de salida
     onuerror   codigo de erorr 0 - correcto, otro valor incorrecto
     osberror   mensaje de error

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
   rcTA_TARICOPR   TA_TARICOPR%rowtype;
   rcVigenProy     TA_VIGETACP%rowtype;
   rcTA_TARICOPRNULL TA_TARICOPR%rowtype;
   rcVigenProyNULL TA_VIGETACP%rowtype;
   rcTA_RANGVITP  TA_RANGVITP%rowtype;
   rcTA_RANGVITPnull  TA_RANGVITP%rowtype;

   rcta_tariconc  ta_tariconc%rowtype;
   nuTacpCons NUMBER;
   nuTacocons NUMBER;
   nuVITPCONS NUMBER;
   nuVITPCONSTRAB NUMBER;
   nuRAVPCONS NUMBER;

   nuConTarProy NUMBER;

   CURSOR cugetConftari IS
   SELECT distinct TETAMERE,
          TETANOTA,
          TETATIPO,
          TETASERV,
          TETACOTC,
         -- TETARAIN,
         -- TETARAFI,
          TETACATE,
          TETASUCA,
          TETATADI,
          TETAptdi
   FROM LDC_TEMPTARI
   WHERE TETAPROY = inuproyTari;

   CURSOR cugetRangos(NUMERE NUMBER, NUSERV NUMBER, NUCOTC NUMBER,  NUCATE NUMBER,NUSUCA NUMBER ) IS
   SELECT TETARAIN,
          TETARAFI,
          TETAVALO,
          TETAPORC
   FROM LDC_TEMPTARI
   WHERE TETAPROY = inuproyTari
     AND TETAMERE = NUMERE
     AND TETASERV = NUSERV
     AND TETACOTC = NUCOTC
     AND TETACATE = NUCATE
     AND TETASUCA =NUSUCA;

   CURSOR cuExisteTariProy(nuConTacon NUMBER, sbCriterio01 VARCHAR2,  sbCriterio02 VARCHAR2,sbCriterio03 VARCHAR2) IS
   SELECT TACPCONS
   FROM TA_TARICOPR s
   WHERE TACPPRTA = inuproyTari
    AND s.TACPCOTC = nuConTacon
    AND S.TACPSESU = -1
    AND S.TACPSUSC = -1
    AND NVL(S.TACPCR01,'-1') = nvl(sbCriterio01,'-1')
    AND NVL(S.TACPCR02,'-1') = nvl(sbCriterio02,'-1')
    AND NVL(S.TACPCR03,'-1') = nvl( sbCriterio03,'-1');



    PROCEDURE prInicializaDatos IS
    BEGIN
      nuTacpCons := NULL;
      nuVITPCONS := NULL;
      nuRAVPCONS := NULL;
      nuVITPCONSTRAB := NULL;
      rcTA_TARICOPR := rcTA_TARICOPRNULL;
      rcVigenProy  := rcVigenProyNULL;
      rcTA_RANGVITP := rcTA_RANGVITPNULL;
      nuConTarProy := NULL;
    END prInicializaDatos;

    PROCEDURE prActualizaVigencias(isbtipo IN VARCHAR2,
                                   inumere IN NUMBER,
                                   inuTipoServ IN NUMBER,
                                   inuCotc IN NUMBER,
                                   inuCate IN NUMBER,
                                   inusuca IN NUMBER) IS
      CURSOR cuExisteVigeProy(ISBTIPO VARCHAR2) IS
      SELECT VITPCONS
      FROM TA_VIGETACP
      WHERE VITPTACP = nuConTarProy
       AND VITPTIPO = ISBTIPO;

       CURSOR cuExisteRangoProy(inuVigeProy NUMBER) IS
       SELECT RAVPCONS
       FROM TA_RANGVITP
       WHERE RAVPVITP = inuVigeProy;

       CURSOR cuExisteRangoProyGen(inuVigeProy NUMBER, inurangini NUMBER, inurangfinal NUMBER) IS
       SELECT RAVPCONS
       FROM TA_RANGVITP
       WHERE RAVPVITP = inuVigeProy
        AND RAVPLIIN = inurangini
        AND RAVPLISU = inurangfinal;

       nuExiste NUMBER := 0;
       blInsert BOOLEAN := FALSE;
    BEGIN
         UT_TRACE.TRACE('Inicia prActualizaVigencias ISBTIPO '||ISBTIPO, 10);
        IF cuExisteVigeProy%ISOPEN THEN
            CLOSE cuExisteVigeProy;
         END IF;
         nuVITPCONS :=NULL;
         nuRAVPCONS := NULL;

        OPEN cuExisteVigeProy(isbtipo);
        FETCH cuExisteVigeProy INTO nuVITPCONS;
        CLOSE cuExisteVigeProy;
        UT_TRACE.TRACE('nuVITPCONS  '||nuVITPCONS, 10);
        rcVigenProy.VITPTACP := nuConTarProy;
        rcVigenProy.VITPTIPO := isbtipo;
        IF nuVITPCONS IS NULL THEN
            --se inserta tarifa base
          nuVITPCONS := SQ_TA_VIGETACP_VITPCONS.NEXTVAL;
          rcVigenProy.VITPCONS := nuVITPCONS;
          PKTBLTA_VIGETACP.InsRecord(rcVigenProy);
          UT_TRACE.TRACE('inserto vigencia   '||nuVITPCONS, 10);
            nuExiste := 0;
        ELSE
           rcVigenProy.VITPCONS := nuVITPCONS;
           PKTBLTA_VIGETACP.UPRECORD(rcVigenProy);
           UT_TRACE.TRACE('actualizo vigencia   '||nuVITPCONS, 10);
           IF cuExisteRangoProy%ISOPEN THEN
              CLOSE cuExisteRangoProy;
           END IF;

           OPEN cuExisteRangoProy(nuVITPCONS);
           FETCH cuExisteRangoProy INTO  nuRAVPCONS;
           CLOSE cuExisteRangoProy;

           IF nuRAVPCONS IS NULL THEN
              nuExiste := 0;
            ELSE
              nuExiste := 1;
           END IF;

        END IF;
           --se insertan rangos de consumos
        FOR regRang IN cugetRangos(inumere, inuTipoServ,inuCotc,inuCate, inusuca ) LOOP
             --se insertan rangos de consumos
            IF nuExiste = 0 THEN
               nuRAVPCONS := SQ_TA_RANGVITP_RAVPCONS.NEXTVAL;
               blInsert := true;
            ELSE
              OPEN cuExisteRangoProyGen(nuVITPCONS, regRang.TETARAIN,regRang.TETARAFI );
              FETCH cuExisteRangoProyGen INTO nuRAVPCONS;
              CLOSE cuExisteRangoProyGen;

              IF nuRAVPCONS IS NULL THEN
                  nuRAVPCONS := SQ_TA_RANGVITP_RAVPCONS.NEXTVAL;
                  blInsert := true;
              ELSE
                blInsert := false;
              END IF;
            END IF;
            rcTA_RANGVITP.RAVPCONS := nuRAVPCONS;
            rcTA_RANGVITP.RAVPVITP := nuVITPCONS;
            rcTA_RANGVITP.RAVPLIIN := regRang.TETARAIN;
            rcTA_RANGVITP.RAVPLISU := regRang.TETARAFI;
            rcTA_RANGVITP.RAVPVALO := regRang.TETAVALO;
            rcTA_RANGVITP.RAVPPORC := regRang.TETAPORC;
            rcTA_RANGVITP.RAVPPROG := CNUPROGRAMA;
            rcTA_RANGVITP.RAVPUSUA :=  pkGeneralServices.fsbGetUserName;
            rcTA_RANGVITP.RAVPTERM := pkGeneralServices.fsbGetTerminal;
            IF blInsert THEN
               PKTBLTA_RANGVITP.InsRecord(rcTA_RANGVITP);
            ELSE
               PKTBLTA_RANGVITP.UPRECORD(rcTA_RANGVITP);
            END IF;
            UT_TRACE.TRACE('inserto rango consumo  '||nuRAVPCONS, 10);

        END LOOP;

    EXCEPTION
      WHEN OTHERS THEN
          ERRORS.SETERROR;
          RAISE EX.CONTROLLED_ERROR;
    END prActualizaVigencias;
  BEGIN
     UT_TRACE.TRACE('INICIO LDC_BCGESTIONTARIFAS.prInsertarTarifas ', 10);
    prInicializaError(onuerror, osberror);

    FOR reg IN cugetConftari LOOP
        prInicializaDatos;

       IF cuExisteTariProy%ISOPEN THEN
          CLOSE cuExisteTariProy;
       END IF;

       OPEN cuExisteTariProy(reg.TETACOTC, reg.TETASUCA,  reg.TETACATE, reg.TETAMERE);
       FETCH cuExisteTariProy INTO nuConTarProy;
       CLOSE cuExisteTariProy;
        UT_TRACE.TRACE('nuConTarProy ['|| nuConTarProy||'] '||reg.TETAMERE||'-'||reg.TETATIPO||'-'||reg.TETASERV||'-'||reg.TETACOTC||'-'

         -- ||reg.TETARAIN||'-'
         -- ||reg.TETARAFI||'-'
          ||reg.TETACATE||'-'
          ||reg.TETASUCA, 10);

         -- dbms_output.put_line('nuConTarProy ['|| nuConTarProy||'] '||reg.TETAMERE||'-'||reg.TETATIPO||'-'||reg.TETASERV||'-'||reg.TETACOTC||'-' ||reg.TETACATE||'-'
         -- ||reg.TETASUCA);

        --insertar tarifa por proyecto
        rcTA_TARICOPR.TACPPRTA := inuproyTari;
        rcTA_TARICOPR.TACPCOTC := reg.TETACOTC;
        rcTA_TARICOPR.TACPTIMO := reg.TETATIPO;
        rcTA_TARICOPR.TACPRESO := 'ABCDEFGHIJKLMNO';
        rcTA_TARICOPR.TACPDESC := reg.TETANOTA;
        rcTA_TARICOPR.TACPSESU := -1;
        rcTA_TARICOPR.TACPSUSC := -1;
        rcTA_TARICOPR.TACPCR01 := reg.TETASUCA;
        rcTA_TARICOPR.TACPCR02 := reg.TETACATE;
        rcTA_TARICOPR.TACPCR03 := reg.TETAMERE;
        rcTA_TARICOPR.TACPTACC := NULL;
        rcTA_TARICOPR.TACPPROG := CNUPROGRAMA ;
        rcTA_TARICOPR.TACPUSUA := pkGeneralServices.fsbGetUserName;
        rcTA_TARICOPR.TACPTERM := pkGeneralServices.fsbGetTerminal;

        --se inserta tarifa base
        rcVigenProy.VITPTIPO := 'B';
        rcVigenProy.VITPESTA := 'N';
        rcVigenProy.VITPMOCR := 'A';
        rcVigenProy.VITPFEIN := idtfechaIni;
        rcVigenProy.VITPFEFI := idtFechaFin;
        rcVigenProy.VITPVALO := nvl(reg.TETATADI,0);
        rcVigenProy.VITPPORC := nvl(reg.TETAptdi,0);
        rcVigenProy.VITPPROG := CNUPROGRAMA;
        rcVigenProy.VITPUSUA :=  pkGeneralServices.fsbGetUserName;
        rcVigenProy.VITPTERM := pkGeneralServices.fsbGetTerminal;


        IF nuConTarProy IS NULL THEN
           nuTacpCons := SQ_TA_TARICOPR_TACPCONS.NEXTVAL;
           rcTA_TARICOPR.TACPCONS := nuTacpCons;
           PKTBLTA_TARICOPR.InsRecord(rcTA_TARICOPR);
           UT_TRACE.TRACE('inserto tarifa proyecto '||nuTacpCons, 10);
          --se inserta tarifa base
          nuVITPCONS := SQ_TA_VIGETACP_VITPCONS.NEXTVAL;
          rcVigenProy.VITPCONS := nuVITPCONS;
          rcVigenProy.VITPTACP := nuTacpCons;

          PKTBLTA_VIGETACP.InsRecord(rcVigenProy);
          UT_TRACE.TRACE('inserto vigencia tarifa base '||nuVITPCONS, 10);

          --se inserta tarifa de trabajo
          nuVITPCONSTRAB := SQ_TA_VIGETACP_VITPCONS.NEXTVAL;
          rcVigenProy.VITPCONS := nuVITPCONSTRAB;
          rcVigenProy.VITPTIPO := 'T';
          PKTBLTA_VIGETACP.InsRecord(rcVigenProy);
          UT_TRACE.TRACE('inserto tarifa de trabajo '||nuVITPCONSTRAB, 10);
          FOR regRang IN cugetRangos(reg.TETAMERE, reg.TETASERV, reg.TETACOTC,reg.TETACATE, reg.TETASUCA ) LOOP
             --DBMS_OUTPUT.PUT_LINE('rangos a insertar ');
             --se insertan rangos de consumos
              nuRAVPCONS := SQ_TA_RANGVITP_RAVPCONS.NEXTVAL;
              rcTA_RANGVITP.RAVPCONS := nuRAVPCONS;
              rcTA_RANGVITP.RAVPVITP := nuVITPCONS;
              rcTA_RANGVITP.RAVPLIIN := regRang.TETARAIN;
              rcTA_RANGVITP.RAVPLISU := regRang.TETARAFI;
              rcTA_RANGVITP.RAVPVALO := regRang.TETAVALO;
              rcTA_RANGVITP.RAVPPORC := regRang.TETAPORC;
              rcTA_RANGVITP.RAVPPROG := CNUPROGRAMA;
              rcTA_RANGVITP.RAVPUSUA :=  pkGeneralServices.fsbGetUserName;
              rcTA_RANGVITP.RAVPTERM := pkGeneralServices.fsbGetTerminal;
              PKTBLTA_RANGVITP.InsRecord(rcTA_RANGVITP);
              UT_TRACE.TRACE('inserto rango consumo tarifa base '||nuRAVPCONS, 10);
             -- DBMS_OUTPUT.PUT_LINE('inserto rango consumo tarifa base '||nuRAVPCONS);
              nuRAVPCONS := SQ_TA_RANGVITP_RAVPCONS.NEXTVAL;
              rcTA_RANGVITP.RAVPCONS := nuRAVPCONS;
              rcTA_RANGVITP.RAVPVITP := nuVITPCONSTRAB;
              PKTBLTA_RANGVITP.InsRecord(rcTA_RANGVITP);
              UT_TRACE.TRACE('inserto rango consumo tarifa de trabajo '||nuRAVPCONS, 10);
         -- DBMS_OUTPUT.PUT_LINE('inserto rango consumo tarifa de trabajo '||nuRAVPCONS);
          END LOOP;

        ELSE
          rcTA_TARICOPR.TACPCONS := nuConTarProy;
          PKTBLTA_TARICOPR.UPRECORD(rcTA_TARICOPR);
          UT_TRACE.TRACE('inicia actualizar tarifas prActualizaVigencias ', 10);
          prActualizaVigencias('B',reg.TETAMERE, reg.TETASERV, reg.TETACOTC,reg.TETACATE, reg.TETASUCA);
          prActualizaVigencias('T', reg.TETAMERE, reg.TETASERV, reg.TETACOTC,reg.TETACATE, reg.TETASUCA);
          UT_TRACE.TRACE('termina actualizar tarifas prActualizaVigencias ', 10);
        END IF;

    END LOOP;
    UT_TRACE.TRACE('FIN LDC_BCGESTIONTARIFAS.prInsertarTarifas ', 10);
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
       ERRORS.GETERROR(onuerror, osberror);
    WHEN OTHERS THEN
      ERRORS.SETERROR;
      ERRORS.GETERROR(onuerror, osberror);
  END prInsertarTarifas;

   PROCEDURE prInsertarTariActi( inuproyTari  IN NUMBER,
                                onuError     OUT  NUMBER,
                                osbError     OUT VARCHAR2) IS
  /**************************************************************************
    Autor       : olsoftware
    Fecha       : 19/04/2021
    Ticket      : 583
    Proceso     : prInsertarTariActi
    Descripci��n: insertar tarifas activas

    Par��metros Entrada
     inuproyTari  codigo del proyecto de tarifa

    Valor de salida
     onuerror   codigo de erorr 0 - correcto, otro valor incorrecto
     osberror   mensaje de error

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

   nutariConc NUMBER;
   nuTariProy NUMBER;

   rcTA_VIGETACO TA_VIGETACO%rowtype;
   rcTA_VIGETACONULL TA_VIGETACO%rowtype;
   rcTA_RANGVITC TA_RANGVITC%rowtype;
   rcTA_RANGVITCNULL TA_RANGVITC%rowtype;
   rsTA_TARICONC TA_TARICONC%rowtype;
   rsTA_TARICONCNULL TA_TARICONC%rowtype;

   nuVITCCONS NUMBER;
   nuRAVTCONS NUMBER;


   CURSOR cugetTariConc IS
   SELECT S.TACPCONS,TACPTIMO,TACPRESO,TACPDESC, TACPCOTC, S.TACPSESU, S.TACPSUSC, NVL(S.TACPCR01,'-1') TACPCR01,  NVL(S.TACPCR02,'-1') TACPCR02,  NVL(S.TACPCR03,'-1') TACPCR03
   FROM TA_TARICOPR s
   WHERE s.TACPPRTA = inuproyTari ;

   CURSOR cuExisteTariconc(inuConTaco NUMBER, inuProducto NUMBER,
                            inuContrato NUMBER, sbCriterio01 VARCHAR2,
                            sbCriterio02 VARCHAR2,sbCriterio03 VARCHAR2) IS
   SELECT TACOCONS
   FROM TA_TARICONC
   WHERE TACOCOTC = inuConTaco
    AND TACOSUSC = inuContrato
    AND TACOSESU = inuProducto
    AND NVL(TACOCR01,'-1') = sbCriterio01
    AND NVL(TACOCR02,'-1') = sbCriterio02
    AND NVL(TACOCR03,'-1') = sbCriterio03;

    CURSOR cuGetVigenciaProy(nuTariProy IN NUMBER) IS
    SELECT *
    FROM TA_VIGETACP V
    WHERE V.VITPTACP = nuTariProy
     AND V.VITPTIPO = 'T'
     AND V.VITPESTA = 'N';

     regVigenciaProy cuGetVigenciaProy%rowtype;

    CURSOR cuGetRangosProy(inuVigeProy IN NUMBER) IS
    SELECT *
    FROM TA_RANGVITP r
    WHERE R.RAVPVITP = inuVigeProy
     ;

     regRangoProy cuGetRangosProy%rowtype;
    PROCEDURE prInicializaVariables IS

    BEGIN
        nutariConc := NULL;
        rsTA_TARICONC := rsTA_TARICONCNULL;
        rcTA_VIGETACO := rcTA_VIGETACONULL;
        nuVITCCONS := NULL;
        rcTA_RANGVITC := rcTA_RANGVITCNULL;
        nuRAVTCONS := NULL;
    END;
  BEGIN
     UT_TRACE.TRACE('INICIO LDC_BCGESTIONTARIFAS.prInsertarTariActi ', 10);

     prInicializaError(onuerror, osberror);
    FOR regConc IN cugetTariConc LOOP

        prInicializaVariables;

       IF cuExisteTariconc%ISOPEN THEN
         CLOSE cuExisteTariconc;
       END IF;

       OPEN cuExisteTariconc(regConc.TACPCOTC,regConc.TACPSESU,regConc.TACPSUSC,regConc.TACPCR01, regConc.TACPCR02, regConc.TACPCR03 );
       FETCH cuExisteTariconc INTO nutariConc;
       IF cuExisteTariconc%NOTFOUND THEN
          nutariConc := SQ_TA_TARICONC_TACOCONS.NEXTVAL;
          rsTA_TARICONC.TACOCONS := nutariConc;
          rsTA_TARICONC.TACOCOTC := regConc.TACPCOTC;
          rsTA_TARICONC.TACOTIMO := regConc.TACPTIMO;
          rsTA_TARICONC.TACOSUSC := regConc.TACPSUSC;
          rsTA_TARICONC.TACOSESU := regConc.TACPSESU;
          rsTA_TARICONC.TACOCR01 := regConc.TACPCR01;
          rsTA_TARICONC.TACOCR02 := regConc.TACPCR02;
          rsTA_TARICONC.TACOCR03 := regConc.TACPCR03;
          rsTA_TARICONC.TACOPROG := CNUPROGRAMA;
          rsTA_TARICONC.TACOUSUA := pkGeneralServices.fsbGetUserName;
          rsTA_TARICONC.TACOTERM :=  pkGeneralServices.fsbGetTerminal;
          rsTA_TARICONC.TACODESC :=regConc.TACPDESC;

           PKTBLTA_TARICONC.InsRecord(rsTA_TARICONC);
       END IF;
       CLOSE cuExisteTariconc;

       OPEN cuGetVigenciaProy(regConc.TACPCONS);
       FETCH cuGetVigenciaProy INTO regVigenciaProy;
       IF cuGetVigenciaProy%NOTFOUND THEN
          onuerror := -1;
          osberror := 'No existe tarifa de trabajo, relacionada a la tarifa por proyecto ['||regConc.TACPCONS||' - '||regConc.TACPDESC||']';
          CLOSE cuGetVigenciaProy;
          return;
       END IF;
       CLOSE cuGetVigenciaProy;

       nuVITCCONS :=  SQ_TA_VIGETACO_VITCCONS.nextval;

      rcTA_VIGETACO.VITCCONS := nuVITCCONS;
      rcTA_VIGETACO.VITCTACO := nutariConc;
      rcTA_VIGETACO.VITCFEIN := regVigenciaProy.VITPFEIN;
      rcTA_VIGETACO.VITCFEFI := regVigenciaProy.VITPFEFI;
      rcTA_VIGETACO.VITCVIGE := 'S';
      rcTA_VIGETACO.VITCVALO := regVigenciaProy.VITPVALO;
      rcTA_VIGETACO.VITCPORC := regVigenciaProy.VITPPORC;
      rcTA_VIGETACO.VITCPROG := regVigenciaProy.VITPPROG;
      rcTA_VIGETACO.VITCUSUA := pkGeneralServices.fsbGetUserName;
      rcTA_VIGETACO.VITCTERM := pkGeneralServices.fsbGetTerminal;

       PKTBLTA_VIGETACO.InsRecord(rcTA_VIGETACO);

       --se actualiza vigencia en tarifa de trabajo
       UPDATE TA_VIGETACP set VITPVITC = nuVITCCONS, VITPESTA = 'P' WHERE VITPCONS = regVigenciaProy.VITPCONS;

       --se insertan rango de vigencias
       FOR reg IN cuGetRangosProy(regVigenciaProy.VITPCONS) LOOP
           nuRAVTCONS := SQ_TA_RANGVITC_RAVTCONS.NEXTVAL;

           rcTA_RANGVITC.RAVTCONS := nuRAVTCONS;
           rcTA_RANGVITC.RAVTVITC := nuVITCCONS;
           rcTA_RANGVITC.RAVTLIIN := reg.RAVPLIIN;
           rcTA_RANGVITC.RAVTLISU := reg.RAVPLISU;
           rcTA_RANGVITC.RAVTVALO := reg.RAVPVALO;
           rcTA_RANGVITC.RAVTPORC := reg.RAVPPORC;
           rcTA_RANGVITC.RAVTPROG := reg.RAVPPROG;
           rcTA_RANGVITC.RAVTUSUA := pkGeneralServices.fsbGetUserName;
           rcTA_RANGVITC.RAVTTERM := pkGeneralServices.fsbGetTerminal;

            PKTBLTA_RANGVITC.InsRecord(rcTA_RANGVITC);
       END LOOP;
    END LOOP;
    UT_TRACE.TRACE('FIN LDC_BCGESTIONTARIFAS.prInsertarTariActi ', 10);
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
       ERRORS.GETERROR(onuerror, osberror);
    WHEN OTHERS THEN
      ERRORS.SETERROR;
      ERRORS.GETERROR(onuerror, osberror);
  END prInsertarTariActi;

END LDC_BCGESTIONTARIFAS;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_BCGESTIONTARIFAS
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_BCGESTIONTARIFAS', 'ADM_PERSON'); 
END;
/