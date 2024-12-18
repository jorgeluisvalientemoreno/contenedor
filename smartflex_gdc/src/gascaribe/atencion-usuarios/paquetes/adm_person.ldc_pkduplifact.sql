CREATE OR REPLACE PACKAGE adm_person.LDC_PKDUPLIFACT IS
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : 
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    09/07/2024              PAcosta         OSF-2889: Cambio de esquema ADM_PERSON                              
    ****************************************************************/            

    --LD_BOSUBSIDY.ProcExportBillDuplicateToPDF
  /*****************************************************************
    Propiedad intelectual de Horbath (c).

    Unidad         : VALIDAFACTURAS
    Descripcion    : Valida que el contrato y el periodo correspondan a la factura
    Autor          : Josh Brito - Horbath Technologies

    Historia de Modificaciones

    Fecha             Autor             Modificacion
    =========       =========           ====================
    15/12/2017      JBRITO              Creacion.
    ******************************************************************/
  PROCEDURE VALIDAFACTURAS (CONTRATO SUSCRIPC.SUSCCODI%TYPE, PERIODO NUMBER, FACTURA FACTURA.FACTCODI%TYPE,
                           ID_PERIODO OUT PERIFACT.PEFACODI%TYPE, CATEGORIA OUT VARCHAR2, MSG OUT VARCHAR2);

  /*****************************************************************
    Propiedad intelectual de Horbath (c).

    Unidad         : OBTIENEFACTURASP
    Descripcion    : Obtendra la informacion de la factura ammacenada en los spool
    Autor          : Josh Brito - Horbath Technologies

    Historia de Modificaciones

    Fecha             Autor             Modificacion
    =========       =========           ====================
    18/12/2017      JBRITO              Creacion.
    ******************************************************************/
  PROCEDURE OBTIENEFACTURASP(CAMPOTXT VARCHAR2, FACTURATXT VARCHAR2, FACTURA FACTURA.FACTCODI%TYPE, EXISTE OUT BOOLEAN);

  /*****************************************************************
    Propiedad intelectual de Horbath (c).

    Unidad         : PROCIMPRIMEFACT
    Descripcion    : Imprime facturas
    Autor          : Josh Brito - Horbath Technologies

    Historia de Modificaciones

    Fecha             Autor             Modificacion
    =========       =========           ====================
    21/12/2017      JBRITO              Creacion.
    ******************************************************************/
  PROCEDURE PROCIMPRIMEFACT(isbsource   VARCHAR2,
                               isbfilename VARCHAR2,
                               isFactura     NUMBER,
                               regOrNoreg VARCHAR2,
                                isDuplicado VARCHAR2,
                                isImpreso VARCHAR2,
                                isPlantilla VARCHAR2);

      /*
    PROCEDURE PROGETFACTSDOC(listFact IN CLOB, regOrNoreg VARCHAR2, ilclob OUT CLOB);
    FUNCTION splitStrings(p_list varchar2, P_DEL VARCHAR2) RETURN split_tbl
    pipelined;
    */

  /*****************************************************************
    Propiedad intelectual de Horbath (c).

    Unidad         : OBTFACTRECURRENTE
    Descripcion    : consulta estado de cuentas o facturas
    Autor          : Josh Brito - Horbath Technologies

    Historia de Modificaciones

    Fecha             Autor             Modificacion
    =========       =========           ====================
    04/10/2019      JBRITO              Creacion.
    ******************************************************************/
  PROCEDURE OBTFACTRECURRENTE(  inuContrato       in NUMBER,
                              orServicios           OUT SYS_REFCURSOR,
                              onuErrorCode          out NUMBER,
                              osbErrorMessage       out VARCHAR2);

  PROCEDURE OBTSEQLOTEFACT(SEQ OUT NUMBER);

END LDC_PKDUPLIFACT;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_PKDUPLIFACT IS

  /*****************************************************************
    Propiedad intelectual de Horbath (c).

    Unidad         : VALIDAFACTURAS
    Descripcion    : Valida que el contrato y el periodo correspondan a la factura
    Autor          : Josh Brito - Horbath Technologies

    Historia de Modificaciones

    Fecha             Autor             Modificacion
    =========       =========           ====================
    15/12/2017      JBRITO              Creacion.
    31/01/2020		Josh Brito			Modificacion. /*--SE VALIDA la factura CON EL codigo del PERIODO.
    									ESTO APLICA CUANDO ES consultado por el contrato en el .NET

    ******************************************************************/
  PROCEDURE VALIDAFACTURAS(CONTRATO SUSCRIPC.SUSCCODI%TYPE, PERIODO NUMBER, FACTURA FACTURA.FACTCODI%TYPE,
                           ID_PERIODO OUT PERIFACT.PEFACODI%TYPE, CATEGORIA OUT VARCHAR2, MSG OUT VARCHAR2) IS

    --vPATHSPOOL VARCHAR2(1000) := dald_parameter.fsbgetvalue_chain('LDC_PARRUTASPOOL');
    --NS      VARCHAR2(1024);

    CURSOR cuVALFACT IS
      SELECT FACTPEFA
      FROM FACTURA
      WHERE FACTSUSC = CONTRATO
      AND FACTCODI = FACTURA
      AND FACTPEFA IN (SELECT PERIFACT.PEFACODI
                      FROM PERIFACT
                      WHERE TO_CHAR(PERIODO) = TO_CHAR(PERIFACT.PEFAANO)||TO_CHAR(PERIFACT.PEFAMES));

    CURSOR cuVALFACTcodPeriodo IS
      SELECT FACTPEFA
      FROM FACTURA
      WHERE FACTSUSC = CONTRATO
      AND FACTCODI = FACTURA
      AND FACTPEFA = PERIODO;

      nFact NUMBER := NULL;
      SI_FUE_UP NUMBER := NULL;

    BEGIN
      /*VALIDAD SI ES FACTURA REGULADA O NO REGULADA*/
      IF NOT LDC_PKDATAFIXUPDEDDOCU.FNNOREGULADO(CONTRATO) THEN
        CATEGORIA := 'R';
      ELSE
        CATEGORIA := 'NR';
      END IF;

      /*--SE VALIDA CON EL PERIODO CUANDO LA EXTRUCTURA ES IGUAL [ANO||MES] DEL PERIODO. ESTO APLICA CUANDO ES INGRESADO POR ARCHIVO EXCEL
      DE ESTA MANERA FUE REQUERIDO EN SU DESARROLLO INICIAL*/
      OPEN cuVALFACT;
        FETCH cuVALFACT
          INTO nFact;
      CLOSE cuVALFACT;

       /*SE VERIFICA CON EL CODIGO DE PERIDO*/
      IF nFact IS NULL THEN
        OPEN cuVALFACTcodPeriodo;
          FETCH cuVALFACTcodPeriodo
            INTO nFact;
        CLOSE cuVALFACTcodPeriodo;
      END IF;

      IF nFact IS NOT NULL THEN
        SELECT COUNT(1)INTO SI_FUE_UP
        FROM LDCUPDOCFACTLOG
        WHERE UPDOFACT = FACTURA
        AND UPFACTAC IS NOT NULL;

        IF SI_FUE_UP = 0 THEN
        --  SYS.DBMS_BACKUP_RESTORE.SEARCHFILES(vPATHSPOOL, NS);
          ID_PERIODO := nFact;
          MSG := 'N';
        ELSE
          ID_PERIODO := 0;
          MSG := 'La Factura:['||TO_CHAR(FACTURA)||'] fue actualizada anteriormente';
        END IF;
      ELSE
        ID_PERIODO := -1;
        MSG := 'La Factura:['||TO_CHAR(FACTURA)||'] o el Periodo de facturacion:['||TO_CHAR(PERIODO)||'] no hacen parte del Contrato:['||TO_CHAR(CONTRATO)||']';
      END IF;


  EXCEPTION
    WHEN OTHERS THEN
      PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);
  END VALIDAFACTURAS;

  /*****************************************************************
    Propiedad intelectual de Horbath (c).

    Unidad         : OBTIENEFACTURASP
    Descripcion    : Obtendra la informacion de la factura almacenada en los spool
    Autor          : Josh Brito - Horbath Technologies

    Historia de Modificaciones

    Fecha             Autor             Modificacion
    =========       =========           ====================
    18/12/2017      JBRITO              Creacion.
    ******************************************************************/
  PROCEDURE OBTIENEFACTURASP(CAMPOTXT VARCHAR2, FACTURATXT VARCHAR2, FACTURA FACTURA.FACTCODI%TYPE, EXISTE OUT BOOLEAN) IS
    /*
    CURSOR cuFACTTXT IS
      SELECT SPOOLS.FACT_TXT
        FROM (Select COLUMN_VALUE FACT_TXT
              from table (LDC_PKDATAFIXUPDEDDOCU.READFILE(DIRECTORIO, ARCHIVO))
        )SPOOLS
        WHERE SPOOLS.FACT_TXT like '%'||TO_CHAR(FACTURA)||'%'; */

    SI_FUE_UP NUMBER := NULL;

    BEGIN
      EXISTE := FALSE;
      LDC_PKDATAFIXUPDEDDOCU.CAMPOS_SPOOLTXT := CAMPOTXT;
      LDC_PKDATAFIXUPDEDDOCU.FAACTURATXT := FACTURATXT;
      EXISTE := TRUE;

      SELECT COUNT(1)INTO SI_FUE_UP
        FROM LDCUPDOCFACTLOG
        WHERE UPDOFACT = FACTURA
        AND UPFACTAC IS NOT NULL;

      IF SI_FUE_UP = 0 THEN
        LDC_PKDATAFIXUPDEDDOCU.UPDATEDOCUMENTSFACT(FACTURA, NULL, NULL, NULL, TRUE);
      END IF;
   /*
      FOR SP IN cuFACTTXT LOOP
          SELECT COLUMN_VALUE INTO LDC_PKDATAFIXUPDEDDOCU.CAMPOS_SPOOLTXT
          FROM TABLE(LDC_PKDATAFIXUPDEDDOCU.READFILE(DIRECTORIO, ARCHIVO))
          WHERE ROWNUM = 1;
          LDC_PKDATAFIXUPDEDDOCU.FAACTURATXT := SP.FACT_TXT;
          EXISTE := TRUE;
          LDC_PKDATAFIXUPDEDDOCU.UPDATEDOCUMENTSFACT(FACTURA, NULL, NULL, NULL, TRUE);
      END LOOP;    */


  EXCEPTION
    WHEN OTHERS THEN
      PKERRORS.SETERRORMESSAGE(pkErrors.Fsbgeterrormessage);
  END OBTIENEFACTURASP;

  /*****************************************************************
    Propiedad intelectual de Horbath (c).

    Unidad         : PROCIMPRIMEFACT
    Descripcion    : Imprime facturas
    Autor          : Josh Brito - Horbath Technologies

    Historia de Modificaciones

    Fecha             Autor             Modificacion
    =========       =========           ====================
    21/12/2017      JBRITO              Creacion.
    16/02/2018      Daniel Valiente     Se a?ade la logica para la aplicacion de la marca de agua y el impreso por
    01/10/2021      Jorge Valiente      Se agrega parametro para permitir definir la plnatilla que se deseea aplicar.
    11/11/2021      Jorga VAliente      Se agrega un paremtro de entreda para establecer el nombre de la plantilla a utilizar en la forma
                                        Se deja de utiliar el parametro PLANTILLA_R_LDCDUPLIFACT
    ******************************************************************/
    PROCEDURE PROCIMPRIMEFACT (isbsource   VARCHAR2,
                                isbfilename VARCHAR2,
                                isFactura     NUMBER,
                                regOrNoreg VARCHAR2,
                                isDuplicado VARCHAR2,
                                isImpreso VARCHAR2,
                                isPlantilla VARCHAR2) IS

        clclob CLOB;
        --modificacion 16.02.18 DVM Caso 200-1515
        texto CLOB;
        nameUser VARCHAR2(100);
        watermark VARCHAR2(2);

        --Inicio CAMBIO 881
        --SBPLANTILLA_R_LDCDUPLIFACT ld_parameter.value_chain%type := nvl(open.dald_parameter.fsbGetValue_Chain('PLANTILLA_R_LDCDUPLIFACT',null),'LDC_FACT_GASCARIBE_REG');
        --Fin CAMBIO 881

    BEGIN
            /*Unificar xml de facturas*/
            SELECT DOCUDOCU into clclob
            FROM ED_DOCUMENT
            WHERE DOCUCODI = isFactura;

            /* Almancena en memoria la plantilla para extraccion y mezcla */
            IF regOrNoreg = 'R' THEN

               --Inicio CAMBIO 881

               --Fin CAMBIO 881
                --pkBOED_DocumentMem.SetTemplate('LDC_FACT_GASCARIBE_REG');
                --pkBOED_DocumentMem.SetTemplate(SBPLANTILLA_R_LDCDUPLIFACT);
                pkBOED_DocumentMem.SetTemplate(isPlantilla);
                --modificacion 16.02.18 DVM Caso 200-1515
                --PARAMETRO MARCA DE AGUA
                watermark := isDuplicado;
                --modificacion 16.02.18 DVM Caso 200-1515
                --CONSULTA DE USUARIO
                IF(isImpreso = '1') THEN
                  SELECT G.NAME_ into nameUser
                  FROM GE_PERSON G
                  WHERE G.PERSON_ID = GE_BOPERSONAL.FNUGETPERSONID;
                ELSE
                  nameUser := '';
                END IF;
                --modificacion 19.02.18 DVM Caso 200-1515
                --SE REEMPLAZA LA ULTIMA ECCION DEL XML Y E AGREGA EL BLOQUE DE LA MARCA DE AGUA Y LA FIRMA
                texto := replace(clclob, '</LDC_FACTURA>', '<LDC_DATOS_MARCA><VISIBLE>' || watermark || '</VISIBLE><IMPRESO>' || nameUser || '</IMPRESO></LDC_DATOS_MARCA></LDC_FACTURA>');
                clclob := texto;
            END IF;
            IF regOrNoreg = 'NR' THEN
                pkBOED_DocumentMem.SetTemplate('FACTURAGCNR');
            END IF;
           -- clclob := iclclob;
            /* Almancena en memoria el archivo para el proceso de extraccion y mezcla */
            pkBOED_DocumentMem.Set_PrintDoc(clclob);
            -- Instancia informacion basica para extraccion y mezcla a partir de un archivo XML
            pkBOED_DocumentMem.SetBasicDataExMe(isbsource, isbfilename);
           -- GE_BOIOpenExecutable.PrintPreviewerRule;
            --GE_BOIOPENEXECUTABLE.PRINTDUPLICATERULE();



    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END PROCIMPRIMEFACT;

     /* PROCEDURE PROGETFACTSDOC(listFact IN CLOB, regOrNoreg VARCHAR2, ilclob OUT CLOB) IS

        CURSOR cuList IS
          SELECT DOCUDOCU
          FROM ED_DOCUMENT
          WHERE DOCUCODI IN (select To_Number(column_value)
                              from table(LDC_PKDUPLIFACT.splitstrings(listFact, ',')));
        clclob CLOB;
        delimitadorIni VARCHAR2(200);
        delimitadorFin VARCHAR2(200);

    BEGIN
        IF regOrNoreg = 'R' THEN
            delimitadorIni := '<LDC_FACTURA>'||CHR(13);
            delimitadorFin := '</LDC_FACTURA>';
        END IF;
        FOR F IN cuList LOOP
            select Substr(F.DOCUDOCU,
                        instr(F.DOCUDOCU, delimitadorIni, 1, 1) +length(delimitadorIni),
                        instr(F.DOCUDOCU, delimitadorFin, 1, 1) - length(delimitadorFin)) INTO clclob
                  from dual;
            ilclob := ilclob || clclob;
        END LOOP;

        ilclob := delimitadorIni || ilclob || delimitadorFin;

    END PROGETFACTSDOC;*



    FUNCTION splitStrings(p_list varchar2, P_DEL VARCHAR2) RETURN split_tbl
      pipelined IS
      L_IDX  PLS_INTEGER;
      L_LIST VARCHAR2(32767) := P_LIST;
    BEGIN
      LOOP
        l_idx := instr(l_list, p_del);
        IF L_IDX > 0 THEN
          PIPE ROW(SUBSTR(L_LIST, 1, L_IDX - 1));
          l_list := substr(l_list, l_idx + LENGTH(p_del));
        ELSE
          PIPE ROW(L_LIST);
          EXIT;
        END IF;
      END LOOP;
      RETURN;
    END splitStrings;
    */


   /*****************************************************************
    Propiedad intelectual de Horbath (c).

    Unidad         : OBTFACTRECURRENTE
    Descripcion    : consulta estado de cuentas o facturas
    Autor          : Josh Brito - Horbath Technologies

    Historia de Modificaciones

    Fecha             Autor             Modificacion
    =========       =========           ====================
    04/10/2019      JBRITO              Creacion.
    ******************************************************************/
  PROCEDURE OBTFACTRECURRENTE(  inuContrato      in NUMBER,
                              orServicios           OUT SYS_REFCURSOR,
                              onuErrorCode          out NUMBER,
                              osbErrorMessage       out VARCHAR2) is



  BEGIN
    onuErrorCode := 0;

      OPEN orServicios for
              SELECT DISTINCT FACTPEFA COD_PERIODO,
                p.PEFAANO || '-' || p.PEFAMES  PERIODO,
                FACTCODI EST_CUENTA,
                FACTFEGE FECHA_EMISION
                FROM factura f, SERVSUSC s, PERIFACT p, ESPRSEPE e
                WHERE f.FACTSUSC = inuContrato--66582274
                and f.FACTSUSC = s.SESUSUSC
                and p.PEFACICL = s.SESUCICL
                and f.FACTPEFA = p.PEFACODI
                and f.FACTPEFA = e.EPSPPEFA
                and e.EPSPSERV = s.SESUSERV
                and e.EPSPPROG = 'FGCA'
                and f.FACTPROG = 6

                --and e.EPSPESTA in ('B','E')
                order by 1 desc;

             /* SELECT FACTPEFA COD_PERIODO,
                (select PEFAANO || '-' || PEFAMES from perifact where pefacodi = FACTPEFA) PERIODO,
                FACTCODI EST_CUENTA,
                FACTFEGE FECHA_EMISION
                FROM factura WHERE FACTSUSC = inuContrato; */

    EXCEPTION
    WHEN ex.CONTROLLED_ERROR then onuErrorCode := -1;
      WHEN OTHERS THEN
        osbErrorMessage:= 'Error Durante la Consulta de Estdos de cuenta';
        onuErrorCode := -1;
        RAISE ex.CONTROLLED_ERROR;




  END OBTFACTRECURRENTE;

  PROCEDURE OBTSEQLOTEFACT(SEQ OUT NUMBER) IS
  BEGIN
    SEQ := SEQ_LOTEFACT.NEXTVAL;

  END OBTSEQLOTEFACT;

END LDC_PKDUPLIFACT;
/
PROMPT Otorgando permisos de ejecucion a LDC_PKDUPLIFACT
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PKDUPLIFACT', 'ADM_PERSON');
END;
/