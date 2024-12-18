CREATE OR REPLACE PACKAGE  ADM_PERSON.LDCI_PKBSSPORTALWEB AS

  /*
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     PAQUETE       : LDCI_PKBSSPORTALWEB
     AUTOR         : Sincecomp / Karem Baquero
     FECHA         : 12/06/2014
     RICEF : I080,i081
     DESCRIPCION: Paquete que permite encapsula las operaciones de PORTAL
                  WEB Para BSS Facturaci?n y pagos

    Historia de Modificaciones
    Autor   Fecha      Descripcion
  */

  /*Tipo Record para la entidad pr_product*/
  TYPE rcsuscfact IS RECORD(
    lgfesusc LDCI_LOGFAEL.LGFESUSC%type,
    lgfecicl LDCI_LOGFAEL.LGFESUSC%type,
    lgfeobse LDCI_LOGFAEL.LGFESUSC%type,
    suscdeco suscripc.suscdeco%type);

  TYPE tbsuscfact IS TABLE OF rcsuscfact;
  rfsuscfact tbsuscfact := tbsuscfact();

  procedure proConsultaUltPag(inucontrato     in suscripc.susccodi%TYPE,
                              orfUltpagos     out LDCI_PKREPODATATYPE.tyRefcursor,
                              onuErrorCode    out NUMBER,
                              osbErrorMessage out VARCHAR2);
  --------------------------------------------------------------------------
  --------------------------------------------------------------------------

  PROCEDURE proobtsuscfactelect(insuscod In suscripc.susccodi%Type);
  --------------------------------------------------------------------------
  --------------------------------------------------------------------------
  procedure LDCI_REENV_MANUAL_FACTELECTPB(insuscod        IN VARCHAR2,
                                          inuCurrent      IN NUMBER,
                                          inuTotal        IN NUMBER,
                                          onuErrorCode    OUT NUMBER,
                                          osbErrorMessage OUT VARCHAR2);

  --------------------------------------------------------------------------
  --------------------------------------------------------------------------
  procedure proConsultestFinan(inuSusccodi     in suscripc.susccodi%TYPE,
                               inuprprod       in pr_product.product_id%TYPE,
                               orfestFina      out LDCI_PKREPODATATYPE.tyRefcursor,
                               onuErrorCode    out NUMBER,
                               osbErrorMessage out VARCHAR2);
  --------------------------------------------------------------------------
  --------------------------------------------------------------------------

  procedure proconsulfacelect(inucontrato     in suscripc.susccodi%TYPE,
                              inucicl         in suscripc.susccicl%TYPE,
                              orfUltpagos     out LDCI_PKREPODATATYPE.tyRefcursor,
                              onuErrorCode    out NUMBER,
                              osbErrorMessage out VARCHAR2);

  --------------------------------------------------------------------------
  --------------------------------------------------------------------------
  FUNCTION LDCI_FUNCONSUL_FACTELECT

   RETURN pkConstante.tyRefCursor;

END LDCI_PKBSSPORTALWEB;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKBSSPORTALWEB AS

    /*
       PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
       PAQUETE       : LDCI_PKBSSPORTALWEB
       AUTOR         : Sincecomp / Karem Baquero
       FECHA         : 12/06/2014
       RICEF : I080,i081
       DESCRIPCION: Paquete que permite encapsula las operaciones de PORTAL
                    WEB Para BSS Facturaci?n y pagos

      Historia de Modificaciones
      Autor   Fecha      Descripcion
    */

    --------------------------------------------------------------------------
    --------------------------------------------------------------------------
    PROCEDURE proConsultaUltPag
    (
        inucontrato     IN suscripc.susccodi%TYPE,
        orfUltpagos     OUT LDCI_PKREPODATATYPE.tyRefcursor,
        onuErrorCode    OUT NUMBER,
        osbErrorMessage OUT VARCHAR2
    ) AS

        /***********************************************************
           PROPIEDAD INTELECTUAL DE SURTIGAS S.A E.S.P
           PAQUETE       : LDCI_PKCRMPORTALWEB.proConsultaTecnico
           AUTOR         : Sincecomp / Karem Baquero
           FECHA         : 12/06/2014
           RICEF         : I081
           DESCRIPCION   : Consulta informacion de los ?ltimos pagos de
                           un contrato.

          Historia de Modificaciones
          Autor     Fecha       Descripcion

        ***************************************************************/

    BEGIN

        UT_Trace.Trace('LDCI_PKBSSPORTALWEB.proConsultaUltPag', 15);
        -- carga el cusor referenciado
        OPEN orfUltpagos FOR
            SELECT pagosusc,
                   to_char(p.pagofepa, 'mm') Mes,
                   to_char(p.pagofepa, 'yyyy') pagofepa,
                   SUM(p.pagovapa) valor
            FROM pagos p, banco b, sucubanc s
            WHERE pagosusc = inucontrato --1000012
                  AND pagofepa >= ADD_MONTHS(SYSDATE, -7)
                  AND p.pagobanc = b.banccodi
                  AND p.pagosuba = s.subacodi
                  AND b.banccodi = s.subabanc
            GROUP BY pagosusc,
                     to_char(p.pagofepa, 'mm'),
                     to_char(p.pagofepa, 'yyyy')
            ORDER BY 2, 1;

        onuErrorCode    := 0;
        osbErrorMessage := '';

        UT_Trace.Trace('LDCI_PKBSSPORTALWEB.proConsultaUltPag', 15);
    EXCEPTION
        WHEN OTHERS THEN
            pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
            Errors.seterror;
            Errors.geterror(onuErrorCode, osbErrorMessage);

    END proConsultaUltPag;

    --------------------------------------------------------------------------
    PROCEDURE proinslogfael
    (
        inuSusccicl     IN servsusc.sesucicl%TYPE,
        inucontrato     IN suscripc.susccodi%TYPE,
        isbIsError      VARCHAR2,
        isbDescError    VARCHAR2,
        inupefa         NUMBER,
        inuano          NUMBER,
        inumes          NUMBER,
        onuErrorCode    OUT NUMBER,
        osbErrorMessage OUT VARCHAR2
    ) AS

        /***********************************************************
           PROPIEDAD INTELECTUAL DE SURTIGAS S.A E.S.P
           PAQUETE       : LDCI_PKCRMPORTALWEB.proinslogfael
           AUTOR         :  Luis Fren G
           FECHA         : 21/06/2017
           DESCRIPCION   : Inserta en la tabla de logs.

          Historia de Modificaciones
          Autor     Fecha       Descripcion

        ***************************************************************/

    BEGIN

        UT_Trace.Trace('LDCI_PKBSSPORTALWEB.proinslogfael', 15);
        INSERT INTO OPEN.LDCI_LOGFAEL
            (LGFECICL, LGFEFECH, LGFEFLAG, LGFEOBSE, LGFEPEFA, LGFEPANO, LGFEPMES, LGFESUSC, lgfefepr, lgfenuri)
        VALUES
            (inuSusccicl, SYSDATE, isbIsError, isbDescError, inupefa, inuano, inumes, inuCONTRATO, SYSDATE, 1);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
            Errors.seterror;
            Errors.geterror(onuErrorCode, osbErrorMessage);

    END proinslogfael;
    --------------------------------------------------------------------------

    PROCEDURE proobtsuscfactelect(insuscod IN suscripc.susccodi%TYPE)

        /***********************************************************************************
               PROPIEDAD INTELECTUAL DE SURTIGAS S.A E.S.P
               PAQUETE       : LDCI_PKCRMPORTALWEB.PROOBTCICLFACT
               AUTOR         : Sincecomp / Karem Baquero
               FECHA         : 13/06/2014
               RICEF         : I080
               DESCRIPCION   : Se seleccciona los contratos a enviar la facturaci?n electronica
                               teniendo en cuenta el parametro de d?as para la facturaci?n recurrente..

              Historia de Modificaciones
              Autor     Fecha       Descripcion
              KBaquero  06/11/2014  Se elimina los parametros de salida, debido a que
                                    esto se va a programar como un job y no se acepta
                                    parametros de salida.
              Adoacu    22/04/2016  se actualiza para tener un registro correcto de log  300-4266
        ***********************************************************************************/
     IS
        -- Generaci?n de XML
        nuMesacodi  NUMBER;
        onuMesacodi NUMBER;
        L_Payload   CLOB;
        l_response  CLOB;
        qryCtx      DBMS_XMLGEN.ctxHandle;
				qryCtx1      DBMS_XMLGEN.ctxHandle;

        /*
        * Atributos para envio de mensaje sicronos
        */

        sbTargetFull    LDCI_carasewe.casevalo%TYPE;
        SBNAMESPACE     LDCI_carasewe.casevalo%TYPE;
        SBWSURL         LDCI_carasewe.casevalo%TYPE;
        SBHOST          LDCI_carasewe.casevalo%TYPE;
        SBSOAPACTION    LDCI_carasewe.casevalo%TYPE;
        SBPUERTO        LDCI_carasewe.casevalo%TYPE;
        SBPROTOCOLO     LDCI_carasewe.casevalo%TYPE;
        SBPAYLOAD       LDCI_carasewe.casevalo%TYPE;
        SBMENS          LDCI_carasewe.casevalo%TYPE;
        SBTIPO          LDCI_carasewe.casevalo%TYPE;
        nuEstado        NUMBER;
        nuIntentos      NUMBER;
        codMensaje      NUMBER;
        sbResponse      CLOB;
        nuano           NUMBER;
        numes           NUMBER;
        nupefa          NUMBER;
        nusw            NUMBER := 0;
        onuErrorCode    NUMBER;
        osbErrorMessage VARCHAR2(4000);
        /* insuscod        suscripc.susccodi%Type;*/

        CURSOR cucicl(nuDias IN LD_PARAMETER.NUMERIC_VALUE%TYPE) IS
            SELECT prejfech, pefacicl, pefames, pefaano, e.pefacodi
            FROM procejec p, perifact e
            WHERE (prejprog = 'FGCC' AND prejespr = 'T')
                  AND trunc(SYSDATE) - trunc(prejfech) = nuDias /*30*/
                 --and pefacicl = decode(nucicl, null, pefacicl, nucicl)
                  AND prejcope = pefacodi;

        CURSOR orssusc(isbcicl IN LD_PARAMETER.VALUE_CHAIN%TYPE) IS
            SELECT susccodi CONTRATO, suscdeco E_MAIL, susccicl
            FROM suscripc
            WHERE susccicl IN
                  (SELECT to_number(column_value)
                   FROM TABLE(ldc_boutilities.splitstrings(isbcicl /*'26,207,205,20,21,92,42,263'*/, ','))) --= rgcicl.pefacicl
                  AND susccodi = decode(insuscod, NULL, susccodi, insuscod)
                  AND suscefce = 'S';

        nudias LD_PARAMETER.NUMERIC_VALUE%TYPE;
        sbcicl LD_PARAMETER.VALUE_CHAIN%TYPE;

        excepNoProcesoRegi EXCEPTION; -- Excepcion que valida si proceso registros la consulta
        sbDescError VARCHAR2(4000);
        sbIsError   VARCHAR2(10);
    BEGIN
        /*pendiente de modificaci?n 19/06/2014*/
        BEGIN
            LDCI_PKMESAWS.proCreaEstaProc('WS_NOTSUSCFELE', '<PARAMETROS><PARAMETRO><NOMBRE>insuscod</NOMBRE> <VALOR>' ||
                                           insuscod ||
                                           '</VALOR></PARAMETRO></PARAMETROS>', SYSDATE, 'R', USER, SYS_CONTEXT('USERENV', 'TERMINAL'), 'WS_NOTSUSCFELE', nuMesacodi, onuErrorCode, osbErrorMessage);
        EXCEPTION
            WHEN OTHERS THEN
                ldci_pkWebServUtils.Procrearerrorlogint('FACTURACION ELETRONICA', 1, 'Error procesando FACT ELECTRONICA: ' ||
                                                         SQLERRM ||
                                                         Dbms_Utility.Format_Error_Backtrace, NULL, NULL);
        END;

        nudias := DALD_PARAMETER.fnuGetNumeric_Value('NUM_DIAS_ENV_FACT_ELE', NULL);

        FOR rgcicl IN cucicl(nudias)
        LOOP
            sbcicl := sbcicl || rgcicl.pefacicl || ',';

        END LOOP; --for rgcicl in cucicl(nudias) loop

        SELECT substr(sbcicl, 1, length(sbcicl) - 1) INTO sbcicl FROM dual;

        -- ejecuta la extracci?n de datos
        -- Open orssusc For

        --#RECORRER EL CURSOR   orssusc
        FOR reSSUSC IN orssusc(sbcicl)
        LOOP
            nusw            := 0;
            L_Payload       := NULL;
            onuErrorCode    := 0;
            osbErrorMessage := '';

            qryCtx := DBMS_XMLGEN.NewContext('select  :inuCONTRATO as "codigoSuscripcion", :isbE_MAIL as "destinatario" from dual');
            DBMS_XMLGEN.setBindvalue(qryCtx, 'inuCONTRATO', reSSUSC.CONTRATO);
            DBMS_XMLGEN.setBindvalue(qryCtx, 'isbE_MAIL', reSSUSC.E_MAIL);

            -- Asigna el valor de la variable :inuSERVCODI
            --DBMS_XMLGEN.setBindvalue(qryCtx, 'inuciclo', inuciclo);
            Dbms_Xmlgen.setRowSetTag(Qryctx, 'urn:NotifContFactElec_req');
            DBMS_XMLGEN.setRowTag(qryCtx, '');
            DBMS_XMLGEN.SETNULLHANDLING(ctx => Qryctx, flag => 2);

            --Genera el XML
            L_Payload := DBMS_XMLGEN.getXML(qryCtx);
            L_Payload := REPLACE(L_Payload, '<?xml version="1.0"?>');




            --Valida si proceso registros
            IF (DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) THEN--ojo quitar lmfg
                RAISE excepNoProcesoRegi;
            END IF; --if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then
            --Cierra el contexto
            DBMS_XMLGEN.closeContext(qryCtx);

            -- Genera el mensaje de envio para la caja gris

            /*
            *  ACTUALIZAR ESTADO DEL PROCESO A: PROCESANDO 'P'
            */

            LDCI_PKMESAWS.PROACTUESTAPROC(nuMesacodi, NULL, 'P', onuErrorCode, osbErrorMessage);

            /*CONFIRMAR QUE SE ESTA PROCESANDO EL MENSAJE*/
            COMMIT;

            /*
            * Se consultan los par?metros para el env?o de la interfaz
            */

            LDCI_pkWebServUtils.proCaraServWeb('WS_NOTSUSCFELE', 'NAMESPACE', sbNameSpace, sbMens);
            LDCI_pkWebServUtils.proCaraServWeb('WS_NOTSUSCFELE', 'PROTOCOLO', sbProtocolo, sbMens);
            LDCI_pkWebServUtils.proCaraServWeb('WS_NOTSUSCFELE', 'WSURL', sbWSURL, sbMens);
            LDCI_pkWebServUtils.proCaraServWeb('WS_NOTSUSCFELE', 'HOST', sbHost, sbMens);
            LDCI_pkWebServUtils.proCaraServWeb('WS_NOTSUSCFELE', 'SOAPACTION', sbSoapAction, sbMens);
            LDCI_pkWebServUtils.proCaraServWeb('WS_NOTSUSCFELE', 'PUERTO', sbPuerto, sbMens);
            LDCI_pkWebServUtils.proCaraServWeb('WS_NOTSUSCFELE', 'TIPO', SBTIPO, sbMens);

            /*
            * Se env?a directamente el mensaje al sistema externo
            */

            sbTargetFull := lower(sbProtocolo) || '://' || sbHost || ':' ||
                            sbPuerto || '/' || sbWSURL;
            ldci_pksoapapi.proSetProtocol(lower(sbProtocolo));

            SELECT LDCi_SEQMESAWS.NEXTVAL INTO codMensaje FROM DUAL;

            sbResponse := ldci_pksoapapi.fsbSoapSegmentedCallSync(L_Payload, sbTargetFull, sbSoapAction, sbNameSpace);

            /*
            * Validamos si se logro realizar el envio de la interfaz
            *
            */

            IF NOT LDCI_pksoapapi.boolHttpError THEN

                BEGIN

                    SELECT SUBSTR(EXTRACTVALUE(XMLTYPE(sbResponse), '//codError', ''), 0, 4000) AS descError,
                           EXTRACTVALUE(XMLTYPE(sbResponse), '//suscripcion', '') AS isError
                    INTO sbDescError, sbIsError
                    FROM dual;

                EXCEPTION
                    WHEN OTHERS THEN
                        nusw        := 1;
                        sbIsError   := 'true';
                        sbDescError := SUBSTR(sbResponse, 0, 3000);
                        proinslogfael(reSSUSC.Susccicl, --
                                      reSSUSC.CONTRATO, --
                                      sbIsError, --
                                      sbDescError, --
                                      nupefa, --
                                      nuano, --
                                      numes, --
                                      onuErrorCode, --
                                      osbErrorMessage);

                END;

            ELSE
                nusw        := 1;
                sbIsError   := 'true';
                sbDescError := SUBSTR(sbResponse, 0, 4000);
                proinslogfael(reSSUSC.Susccicl, --
                              reSSUSC.CONTRATO, --
                              sbIsError, --
                              sbDescError, --
                              nupefa, --
                              nuano, --
                              numes, --
                              onuErrorCode, --
                              osbErrorMessage);
            END IF;
            IF sbIsError <> 'true' THEN
                BEGIN

                    SELECT pefames, pefaano, e.pefacodi
                    INTO numes, nuano, nupefa
                    FROM open.procejec p, open.perifact e
                    WHERE (prejprog = 'FGCC' AND prejespr = 'T')
                          AND trunc(SYSDATE) - trunc(prejfech) = nudias /*30*/
                          AND
                          pefacicl =
                          decode(reSSUSC.Susccicl, NULL, pefacicl, reSSUSC.Susccicl)
                          AND prejcope = pefacodi;

                EXCEPTION
                    WHEN OTHERS THEN
                        nusw            := 1;
                        onuErrorCode    := -1;
                        osbErrorMessage := 'No se encuentra periodo de facturacion para este ciclo :' ||
                                           reSSUSC.Susccicl;
                        sbIsError       := 'true';
                        sbDescError     := SUBSTR(osbErrorMessage, 0, 4000);
                        proinslogfael(reSSUSC.Susccicl, --
                                      reSSUSC.CONTRATO, --
                                      sbIsError, --
                                      sbDescError, --
                                      nupefa, --
                                      nuano, --
                                      numes, --
                                      onuErrorCode, --
                                      osbErrorMessage);

                END;
            END IF;
            IF nusw = 0 THEN
                proinslogfael(reSSUSC.Susccicl, --
                              reSSUSC.CONTRATO, --
                              sbIsError, --
                              sbDescError, --
                              nupefa, --
                              nuano, --
                              numes, --
                              onuErrorCode, --
                              osbErrorMessage);
            END IF;
            /*      INSERT INTO OPEN.LDCI_LOGFAEL
              (LGFECICL,
               LGFEFECH,
               LGFEFLAG,
               LGFEOBSE,
               LGFEPEFA,
               LGFEPANO,
               LGFEPMES,
               LGFESUSC,
               lgfefepr,
               lgfenuri)
            VALUES
              (reSSUSC.Susccicl,
               SYSDATE,
               sbIsError,
               sbDescError,
               nupefa,
               nuano,
               numes,
               reSSUSC.CONTRATO,
               sysdate,
               1);
            COMMIT;*/

        /* LDCI_PKMESAWS.proCreaMensEnvio(CURRENT_DATE,
                                                                                                                     'WS_NOTSUSCFELE', -- Sistema configurado en LDCI_CARASEWE
                                                                                                                     -1,
                                                                                                                     nuMesacodi, --0,
                                                                                                                     null,
                                                                                                                     L_Payload,
                                                                                                                     0,
                                                                                                                     0,
                                                                                                                     onuMesacodi,
                                                                                                                     onuErrorCode,
                                                                                                                     osbErrorMessage);*/

        END LOOP; --for reSSUSC in orssusc loop

    EXCEPTION

        WHEN excepNoProcesoRegi THEN

            --DBMS_OUTPUT.PUT_LINE('[exception][excepNoProcesoRegi] No proceso registros ...');
            SELECT s.susccicl
            INTO sbcicl
            FROM suscripc s
            WHERE s.susccodi = insuscod
                  AND rownum = 1;
            sbIsError   := 'true';
            sbDescError := SUBSTR(osbErrorMessage, 0, 4000);
            proinslogfael(to_number(sbcicl), --
                          insuscod, --
                          sbIsError, --
                          sbDescError, --
                          nupefa, --
                          nuano, --
                          numes, --
                          onuErrorCode, --
                          osbErrorMessage);
            Errors.seterror;
            Errors.geterror(onuErrorCode, osbErrorMessage);

        WHEN OTHERS THEN

            SELECT s.susccicl
            INTO sbcicl
            FROM suscripc s
            WHERE s.susccodi = insuscod
                  AND rownum = 1;

            pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
            sbIsError   := 'true';
            sbDescError := SUBSTR(osbErrorMessage, 0, 4000);
            proinslogfael(to_number(sbcicl), --
                          insuscod, --
                          sbIsError, --
                          sbDescError, --
                          nupefa, --
                          nuano, --
                          numes, --
                          onuErrorCode, --
                          osbErrorMessage);
            Errors.seterror;
            Errors.geterror(onuErrorCode, osbErrorMessage);

    END;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : ProcLiquidationSearch
    Descripcion    : Busca todas las p?lizas a partir del contrato y las cancela de acuerdo
                     al alcance del DAA 14787
    Autor          : AAcuna
    Fecha          : 18/10/2012 SAO 159764

    Parametros         Descripci?n
    ============   ===================
    inuPackage:      N?mero del paquete

    Historia de Modificaciones
    Fecha            Autor       Modificaci?n
    =========      =========  ====================
    ******************************************************************/

    FUNCTION LDCI_FUNCONSUL_FACTELECT

     RETURN pkConstante.tyRefCursor

     IS

        rfcursor   pkConstante.tyRefCursor;
        nucicl     ciclo.ciclcodi%TYPE;
        nuSuscripc suscripc.susccodi%TYPE;

    BEGIN

        nucicl := ge_boInstanceControl.fsbGetFieldValue('LDCI_LOGFAEL', 'LGFECICL');

        nuSuscripc := ge_boInstanceControl.fsbGetFieldValue('LDCI_LOGFAEL', 'LGFESUSC');

        OPEN rfcursor FOR
            SELECT lgfesusc "CONTRATO",
                   lgfecicl "CICLO",
                   lgfeobse "OBSERVACION",
                   l.lgfenuri "INTENTOS",
                   l.lgfefepr "FECHA_PROCESO",
                   (SELECT S.suscdeco FROM SUSCRIPC S WHERE SUSCCODI = lgfesusc) "CORREO"
            FROM open.LDCI_LOGFAEL l
            WHERE lgfesusc = decode(nuSuscripc, NULL, lgfesusc, nuSuscripc) --l.lgfefech > sysdate - 2
                  AND lgfecicl = decode(nucicl, NULL, lgfecicl, nucicl)
                  AND l.lgfeflag = 'true'
            /* and l.lgfenuri < DALD_PARAMETER.fnuGetNumeric_Value('NUM_REINTE_FACTELEC',
            NULL);*/
            ;

        RETURN(rfcursor);

        ut_trace.Trace('FIN LDCI_PKBSSPORTALWEB.LDCI_FUNCONSUL_FACTELECT', 10);

    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;

    END LDCI_FUNCONSUL_FACTELECT;

    --------------------------------------------------------------------------
    --------------------------------------------------------------------------

    PROCEDURE LDCI_REENV_MANUAL_FACTELECTPB
    (
        insuscod        IN VARCHAR2,
        inuCurrent      IN NUMBER,
        inuTotal        IN NUMBER,
        onuErrorCode    OUT NUMBER,
        osbErrorMessage OUT VARCHAR2
    ) IS

        CURSOR culogfael(nuSuscripc NUMBER) IS
            SELECT lgfesusc "CONTRATO",
                   lgfecicl "CICLO",
                   lgfeobse "OBSERVACION",
                   (SELECT S.suscdeco FROM SUSCRIPC S WHERE SUSCCODI = lgfesusc) "E_MAIL"
            FROM open.LDCI_LOGFAEL l
            WHERE lgfesusc = decode(nuSuscripc, NULL, lgfesusc, nuSuscripc) --l.lgfefech > sysdate - 2
                 -- and lgfecicl = decode(nucicl, Null, lgfecicl, nucicl)
                  AND l.lgfeflag = 'true';

        /*cursor cususcripc (insuscod in suscripc.susccodi%type ) is
        Select susccodi CONTRATO, suscdeco E_MAIL, susccicl
              From suscripc
             Where   susccodi = insuscod
               And suscefce = 'S';*/

        -- Generaci?n de XML
        nuMesacodi  NUMBER;
        onuMesacodi NUMBER;
        L_Payload   CLOB;
        l_response  CLOB;
        qryCtx      DBMS_XMLGEN.ctxHandle;

        /*
        * Atributos para envio de mensaje sicronos
        */

        sbTargetFull LDCI_carasewe.casevalo%TYPE;
        SBNAMESPACE  LDCI_carasewe.casevalo%TYPE;
        SBWSURL      LDCI_carasewe.casevalo%TYPE;
        SBHOST       LDCI_carasewe.casevalo%TYPE;
        SBSOAPACTION LDCI_carasewe.casevalo%TYPE;
        SBPUERTO     LDCI_carasewe.casevalo%TYPE;
        SBPROTOCOLO  LDCI_carasewe.casevalo%TYPE;
        SBPAYLOAD    LDCI_carasewe.casevalo%TYPE;
        SBMENS       LDCI_carasewe.casevalo%TYPE;
        SBTIPO       LDCI_carasewe.casevalo%TYPE;
        nuEstado     NUMBER;
        nuIntentos   NUMBER;
        codMensaje   NUMBER;
        sbResponse   CLOB;
        nuano        NUMBER;
        numes        NUMBER;
        nupefa       NUMBER;
        nucicl       NUMBER;
        nuSuscripc   suscripc.susccodi%TYPE;

        excepNoProcesoRegi EXCEPTION; -- Excepcion que valida si proceso registros la consulta
        sbDescError VARCHAR2(4000);
        sbIsError   VARCHAR2(10);

        -- rcsuscfact pktblsuscripc.Sys
        -- tbsuscfact dald_detail_liquidation.tytbLD_detail_liquidation;

        --onuErrorCode    number;
        -- osbErrorMessage varchar2(4000);

    BEGIN

        ut_trace.Trace('INICIO LDCI_PKBSSPORTALWEB.LDCI_REENVIO_MANUAL_FACTELECT', 10);

        nuSuscripc := to_number(insuscod);

        FOR rgsusc IN culogfael(nuSuscripc)
        LOOP

            /*for rgsusc in cususcripc(rglog.lgfesusc) loop*/

            BEGIN
                LDCI_PKMESAWS.proCreaEstaProc('WS_NOTSUSCFELE', '<PARAMETROS><PARAMETRO><NOMBRE>insuscod</NOMBRE> <VALOR>' ||
                                               nuSuscripc ||
                                               '</VALOR></PARAMETRO></PARAMETROS>', SYSDATE, 'R', USER, SYS_CONTEXT('USERENV', 'TERMINAL'), 'WS_NOTSUSCFELE', nuMesacodi, onuErrorCode, osbErrorMessage);
            EXCEPTION
                WHEN OTHERS THEN
                    ldci_pkWebServUtils.Procrearerrorlogint('FACTURACION ELETRONICA', 1, 'Error procesando FACT ELECTRONICA: ' ||
                                                             SQLERRM ||
                                                             Dbms_Utility.Format_Error_Backtrace, NULL, NULL);
            END;

            L_Payload       := NULL;
            onuErrorCode    := 0;
            osbErrorMessage := '';

            qryCtx := DBMS_XMLGEN.NewContext('select  :inuCONTRATO as "codigoSuscripcion", :isbE_MAIL as "destinatario" from dual');
            DBMS_XMLGEN.setBindvalue(qryCtx, 'inuCONTRATO', rgsusc.CONTRATO);
            DBMS_XMLGEN.setBindvalue(qryCtx, 'isbE_MAIL', rgsusc.E_MAIL);

            -- Asigna el valor de la variable :inuSERVCODI
            --DBMS_XMLGEN.setBindvalue(qryCtx, 'inuciclo', inuciclo);
            Dbms_Xmlgen.setRowSetTag(Qryctx, 'urn:NotifContFactElec_req');
            DBMS_XMLGEN.setRowTag(qryCtx, '');
            DBMS_XMLGEN.SETNULLHANDLING(ctx => Qryctx, flag => 2);

            --Genera el XML
            L_Payload := DBMS_XMLGEN.getXML(qryCtx);
            L_Payload := REPLACE(L_Payload, '<?xml version="1.0"?>');

            --Valida si proceso registros
            IF (DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) THEN
                RAISE excepNoProcesoRegi;
            END IF; --if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then

            --Cierra el contexto
            DBMS_XMLGEN.closeContext(qryCtx);

            -- Genera el mensaje de envio para la caja gris

            /*
            *  ACTUALIZAR ESTADO DEL PROCESO A: PROCESANDO 'P'
            */

            LDCI_PKMESAWS.PROACTUESTAPROC(nuMesacodi, NULL, 'P', onuErrorCode, osbErrorMessage);

            /*CONFIRMAR QUE SE ESTA PROCESANDO EL MENSAJE*/
            COMMIT;

            /*
            * Se consultan los par?metros para el env?o de la interfaz
            */

            LDCI_pkWebServUtils.proCaraServWeb('WS_NOTSUSCFELE', 'NAMESPACE', sbNameSpace, sbMens);
            LDCI_pkWebServUtils.proCaraServWeb('WS_NOTSUSCFELE', 'PROTOCOLO', sbProtocolo, sbMens);
            LDCI_pkWebServUtils.proCaraServWeb('WS_NOTSUSCFELE', 'WSURL', sbWSURL, sbMens);
            LDCI_pkWebServUtils.proCaraServWeb('WS_NOTSUSCFELE', 'HOST', sbHost, sbMens);
            LDCI_pkWebServUtils.proCaraServWeb('WS_NOTSUSCFELE', 'SOAPACTION', sbSoapAction, sbMens);
            LDCI_pkWebServUtils.proCaraServWeb('WS_NOTSUSCFELE', 'PUERTO', sbPuerto, sbMens);
            LDCI_pkWebServUtils.proCaraServWeb('WS_NOTSUSCFELE', 'TIPO', SBTIPO, sbMens);

            /*
            * Se env?a directamente el mensaje al sistema externo
            */

            sbTargetFull := lower(sbProtocolo) || '://' || sbHost || ':' ||
                            sbPuerto || '/' || sbWSURL;
            ldci_pksoapapi.proSetProtocol(lower(sbProtocolo));

            SELECT LDCi_SEQMESAWS.NEXTVAL INTO codMensaje FROM DUAL;

            sbResponse := ldci_pksoapapi.fsbSoapSegmentedCallSync(L_Payload, sbTargetFull, sbSoapAction, sbNameSpace);

            /*
            * Validamos si se logro realizar el envio de la interfaz
            *
            */

            IF NOT LDCI_pksoapapi.boolHttpError THEN

                BEGIN

                    SELECT SUBSTR(EXTRACTVALUE(XMLTYPE(sbResponse), '//codError', ''), 0, 4000) AS descError,
                           EXTRACTVALUE(XMLTYPE(sbResponse), '//suscripcion', '') AS isError
                    INTO sbDescError, sbIsError
                    FROM dual;

                EXCEPTION
                    WHEN OTHERS THEN

                        sbIsError   := 'true';
                        sbDescError := SUBSTR(sbResponse, 0, 3000);

                END;

            ELSE
                sbIsError   := 'true';
                sbDescError := SUBSTR(sbResponse, 0, 4000);
            END IF;

            /*  BEGIN
              select max(pefames), max(pefaano), max(e.pefacodi)--pefames, pefaano, e.pefacodi
                into numes, nuano, nupefa
                from procejec p, perifact e
               where (prejprog = 'FGCC' and prejespr = 'T')
                 and pefacicl =
                     decode(rgsusc.ciclo, null, pefacicl, rgsusc.ciclo)
                    -- and e.pefaactu = 'S'
                 and prejcope = pefacodi;
            EXCEPTION
              WHEN OTHERS THEN

                onuErrorCode    := -1;
                osbErrorMessage := 'No se encuentra periodo de facturacion para este ciclo :' ||
                                   rgsusc.ciclo;

            END;*/

            UPDATE OPEN.LDCI_LOGFAEL l
            SET LGFEOBSE   = sbDescError,
                LGFEFLAG   = sbIsError,
                l.lgfefepr = SYSDATE,
                l.lgfenuri = nvl(l.lgfenuri, 0) + 1
            WHERE LGFESUSC = rgsusc.CONTRATO;
            /* INSERT INTO OPEN.LDCI_LOGFAEL
              (LGFECICL,
               LGFEFECH,
               LGFEFLAG,
               LGFEOBSE,
               LGFEPEFA,
               LGFEPANO,
               LGFEPMES,
               LGFESUSC)
            VALUES
              (rgsusc.ciclo,
               SYSDATE,
               sbIsError,
               sbDescError,
               nupefa,
               nuano,
               numes,
               rgsusc.CONTRATO);*/
            COMMIT;
            -- end loop; --susc
        END LOOP; --log

    EXCEPTION

        WHEN excepNoProcesoRegi THEN
            Errors.seterror;
            Errors.geterror(onuErrorCode, osbErrorMessage);
            --DBMS_OUTPUT.PUT_LINE('[exception][excepNoProcesoRegi] No proceso registros ...');

        WHEN OTHERS THEN

            pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
            Errors.seterror;
            Errors.geterror(onuErrorCode, osbErrorMessage);

    END LDCI_REENV_MANUAL_FACTELECTPB;

    --------------------------------------------------------------------------
    --------------------------------------------------------------------------

    PROCEDURE proConsultestFinan
    (
        inuSusccodi     IN suscripc.susccodi%TYPE,
        inuprprod       IN pr_product.product_id%TYPE,
        orfestFina      OUT LDCI_PKREPODATATYPE.tyRefcursor,
        onuErrorCode    OUT NUMBER,
        osbErrorMessage OUT VARCHAR2
    ) AS

        /***********************************************************
           PROPIEDAD INTELECTUAL DE SURTIGAS S.A E.S.P
           PAQUETE       : LDCI_PKCRMPORTALWEB.proConsultestFinan
           AUTOR         : Sincecomp / Karem Baquero
           FECHA         : 07/11/2014
           RICEF         : I103
           DESCRIPCION   : Consulta informacion del estado financiero de
                           los productos de un contrato.

          Historia de Modificaciones
          Autor     Fecha       Descripcion

        ***************************************************************/

    BEGIN

        UT_Trace.Trace('LDCI_PKBSSPORTALWEB.proConsultestFinan', 15);

        IF inuSusccodi IS NULL
           AND inuprprod IS NULL THEN
            onuErrorCode    := -1;
            osbErrorMessage := 'Debe ingresar uno de los 2 parametros';
        ELSE
            OPEN orfestFina FOR
                SELECT Sus.Susccodi AS susccodi,
                       Serv.Sesunuse AS nuServicioSuscrito,
                       sesuesfn AS SbEstafina,
                       decode(sesuesfn, 'A', 'AL DIA', 'D', 'Con Deuda', 'C', 'Castigado', 'M', 'EN MORA', sesuesfn) AS Descripcion,
                       Serv.sesuserv AS nuTipoServicio,
                       servicio.SERVDESC AS sbDescripcion
                FROM open.Suscripc Sus,
                     open.Servsusc Serv,
                     open.servicio servicio
                WHERE Sus.Susccodi =
                      decode(inuSusccodi, NULL, Sus.Susccodi, inuSusccodi) --inuSusccodi
                      AND Serv.Sesunuse =
                      decode(inuprprod, NULL, Serv.Sesunuse, inuprprod) --inuSusccodi
                      AND Serv.Sesususc = Sus.Susccodi
                      AND servicio.SERVCODI = Serv.SESUSERV;

            IF NOT orfestFina%ISOPEN THEN
                OPEN orfestFina FOR
                    SELECT * FROM dual WHERE 1 = 2;

            END IF;

            onuErrorCode    := 0;
            osbErrorMessage := '';

        END IF;

        UT_Trace.Trace('LDCI_PKBSSPORTALWEB.proConsultestFinan', 15);
    EXCEPTION
        WHEN OTHERS THEN
            pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
            Errors.seterror;
            Errors.geterror(onuErrorCode, osbErrorMessage);

    END proConsultestFinan;

    --------------------------------------------------------------------------
    --------------------------------------------------------------------------
    PROCEDURE proconsulfacelect
    (
        inucontrato     IN suscripc.susccodi%TYPE,
        inucicl         IN suscripc.susccicl%TYPE,
        orfUltpagos     OUT LDCI_PKREPODATATYPE.tyRefcursor,
        onuErrorCode    OUT NUMBER,
        osbErrorMessage OUT VARCHAR2
    ) AS

        /***********************************************************
           PROPIEDAD INTELECTUAL DE SURTIGAS S.A E.S.P
           PAQUETE       : LDCI_PKCRMPORTALWEB.proconsulfacelect
           AUTOR         : Sincecomp / Karem Baquero
           FECHA         : 12/06/2014
           RICEF         : I109
           DESCRIPCION   : Consulta informacion de los ?ltimos pagos de
                           un contrato.

          Historia de Modificaciones
          Autor     Fecha       Descripcion

        ***************************************************************/

    BEGIN

        UT_Trace.Trace('LDCI_PKBSSPORTALWEB.proConsultaUltPag', 15);
        -- carga el cusor referenciado
        OPEN orfUltpagos FOR
            SELECT pagosusc,
                   to_char(p.pagofepa, 'mm') Mes,
                   to_char(p.pagofepa, 'yyyy') pagofepa,
                   SUM(p.pagovapa) valor
            FROM pagos p, banco b, sucubanc s
            WHERE pagosusc = inucontrato --1000012
                  AND pagofepa >= ADD_MONTHS(SYSDATE, -7)
                  AND p.pagobanc = b.banccodi
                  AND p.pagosuba = s.subacodi
                  AND b.banccodi = s.subabanc
            GROUP BY pagosusc,
                     to_char(p.pagofepa, 'mm'),
                     to_char(p.pagofepa, 'yyyy')
            ORDER BY 2, 1;

        onuErrorCode    := 0;
        osbErrorMessage := '';

        UT_Trace.Trace('LDCI_PKBSSPORTALWEB.proConsultaUltPag', 15);
    EXCEPTION
        WHEN OTHERS THEN
            pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
            Errors.seterror;
            Errors.geterror(onuErrorCode, osbErrorMessage);

    END proconsulfacelect;

--------------------------------------------------------------------------
-------------------------------------------------------------------------

END LDCI_PKBSSPORTALWEB;
/

BEGIN
    pkg_utilidades.prAplicarPermisos('LDCI_PKBSSPORTALWEB', 'ADM_PERSON'); 
END;
/

GRANT EXECUTE on ADM_PERSON.LDCI_PKBSSPORTALWEB to INTEGRACIONES;
GRANT EXECUTE on ADM_PERSON.LDCI_PKBSSPORTALWEB to INTEGRADESA;
GRANT EXECUTE on ADM_PERSON.LDCI_PKBSSPORTALWEB to REXEINNOVA;
/
