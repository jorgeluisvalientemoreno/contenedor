
  CREATE OR REPLACE PACKAGE "OPEN"."PKGLDC_IFRS" IS
  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : pkgLDC_IFRS
    Descripcion    : Paquete donde se implementa para generar informacion del IFRS CArtera Brilla
    Autor          : Samuel Pacheco
    Fecha          : 30/04/2018

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    08-10-2018        hcardona          Ajustes sobre metodos :
                                        ProGenDataModeloIFRS
                                        GenDatos
                                        prExecuteIFRS
    06-12-2021        DANVAL            CA 906
                                        Se adiciona parametro de entrada no obligatorio al
                                        procedimiento que genera el archivo para definir ruta
                                        de guradado, de no tener valor continuara con la logica actual

  ******************************************************************/

  TYPE rcfaco IS RECORD(
    fccofapr NUMBER,
    fccofate NUMBER,
    fccofasc NUMBER,
    fccofaco NUMBER);

  TYPE tbfaco IS TABLE OF rcfaco INDEX BY VARCHAR2(10);

  tfaco tbfaco;

  dtFechaInicial DATE;
  dtFechaFinal   DATE;

  PROCEDURE prExecuteIFRS(sbano NUMBER, sbmes NUMBER, nuti NUMBER);

  /*****************************************************************
  Propiedad intelectual de gdc (c).

  Unidad         : prExecuteIFRS
  Descripcion    : Procedimiento donde se ejecuta servicio para generar informacion IFRS
  Autor          : Samuel Pacheco OROZCO
  Fecha          : 30/04/2018

  Metodos

  Nombre         :
  Parametros         Descripcion
  ============  ===================


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================*/

  PROCEDURE GenDatos(inuYear IN NUMBER, inuMonth IN NUMBER);

  PROCEDURE ProGenDataModeloIFRS(nuAno          IN NUMBER,
                                 nuMes          IN NUMBER,
                                 idttoday       DATE,
                                 nuThreadNumber NUMBER,
                                 nuTotalThreads NUMBER,
                                 innusesion     NUMBER);

  --CA 906
  --DANVAL
  --06-12-2021
  --Se adiciona parametro de entrada con la definicion del directorio en donde se guradara el archivo
  PROCEDURE Proifrsbrillafile(nuAnho       NUMBER,
                              nuMes        NUMBER,
                              inuDirectory in number := null);

  PROCEDURE pro_grabalog(inusesion  NUMBER,
                         inuproceso VARCHAR2,
                         inuano     NUMBER,
                         inumes     NUMBER,
                         idtfecha   DATE,
                         inuhilo    NUMBER,
                         inuresult  NUMBER,
                         isbobse    VARCHAR2);

  --CA 906
  --DANVAL
  --06-12-2021
  --Se adiciona el procedmiento para validar la ruta el PB
  PROCEDURE VALIDDIRECTORY_ID;

END pkgLDC_IFRS;
/
CREATE OR REPLACE PACKAGE BODY "OPEN"."PKGLDC_IFRS" IS
  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : pkgLDC_IFRS
  Descripcion    : Paquete donde se implementa para llenar tabla PARA REPORTE IFRS
  Autor          : SAMUEL PACHECO
  Fecha          : 30/04/2018

  Metodos

  Nombre         :
  Parametros         Descripcion
  ============  ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================
  08-10-2018        hcardona          Ajustes sobre metodos :
                                      ProGenDataModeloIFRS
                                      GenDatos
                                      prExecuteIFRS


  *****************************************************************************/

  nuYear   NUMBER;
  nuMonth  NUMBER;
  dtToday  DATE := SYSDATE;
  nusesion NUMBER;
  sbprog   VARCHAR2(20);

  /*****************************************************************
  Propiedad intelectual de gdc (c).

  Unidad         : prExecuteIFRS
  Descripcion    : Procedimiento donde se ejecuta servicio para generar informacion IFRS
  Autor          : Samuel Pacheco Ocoro
  Fecha          : 30/04/2018

  Metodos

  Nombre         :
  Parametros         Descripcion
  ============  ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================
  08/10/2018        hcardona          Se agrega el hint a la consulta INDEX ( B IDX_TMPINPROV01 ) del CURSOR CurDatos
                                      Se cambia el borrado masivo, por el borrado mediante BULK COLLECT
  ******************************************************************/
  PROCEDURE prExecuteIFRS(sbano NUMBER, sbmes NUMBER, nuti NUMBER) IS
    cnuNULL_ATTRIBUTE CONSTANT NUMBER := 2126;
    nusession NUMBER;
    JobNo     user_jobs.job%TYPE;
    WHAT      VARCHAR2(4000);
    dtFecha   DATE;

    -- Se agrega el hint /*+ INDEX ( B IDX_TMPINPROV01 ) */ a la consulta
    CURSOR CurDatos IS
      SELECT /*+ INDEX ( B IDX_TMPINPROV01 ) */
       B.ROWID ID, B.*
        FROM TMP_INFORME_PROV_CART b
       WHERE b.mes = nuMonth
         AND b.ano = nuYear;

    TYPE ttyData_CurDatos IS TABLE OF CurDatos%ROWTYPE INDEX BY Binary_Integer;

    gtblData_CurDatos ttyData_CurDatos;

    nuLimit Number := 10000;

  BEGIN
    /*
    EXECUTE IMMEDIATE 'alter session set sql_trace=true';

    EXECUTE IMMEDIATE 'alter session set tracefile_identifier= Gen_JOBS_IFRS_TRAZA_';

    EXECUTE IMMEDIATE 'alter session set timed_statistics = true';

    EXECUTE IMMEDIATE 'alter session set statistics_level=all';

    EXECUTE IMMEDIATE 'alter session set max_dump_file_size = unlimited';
    */
    SELECT USERENV('SESSIONID') INTO nusesion FROM DUAL;

    pro_grabalog(nusesion,
                 'IFRS',
                 sbano,
                 sbmes,
                 dtToday,
                 0,
                 0,
                 'Inicia Proceso IFRS');

    nuYear  := TO_NUMBER(sbano);
    nuMonth := TO_NUMBER(sbmes);

    IF nuti = 0 THEN
      -- Se limpia tabla para reproceso
      --DELETE /*+ index ( A, IDX_TMPINPROV01 ) nologging */
      --       FROM TMP_INFORME_PROV_CART A
      --      WHERE A.mes = nuMonth AND A.ano = nuYear;

      --COMMIT;
      -- Se cambia borrado masivo, por el borrado con BULK COLLECT
      OPEN CurDatos;
      LOOP
        FETCH CurDatos BULK COLLECT
          INTO gtblData_CurDatos LIMIT nuLimit;
        FORALL I IN gtblData_CurDatos.FIRST .. gtblData_CurDatos.LAST
          DELETE TMP_INFORME_PROV_CART
           WHERE ROWID = gtblData_CurDatos(I).ID;
        COMMIT;
        EXIT WHEN CurDatos%NOTFOUND;
      END LOOP;
      COMMIT;
    END IF;

    --   mediante un proceso multihilos (Caso PC_200-1823)
    GenDatos(nuYear, nuMonth);
    COMMIT;

    pro_grabalog(nusesion,
                 'IFRS',
                 sbano,
                 sbmes,
                 dtToday,
                 0,
                 0,
                 'Termino IFRS');

    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      ldc_proinsertaestaprog(sbano,
                             sbmes,
                             'IFRS',
                             'Proceso IFRS termino con error ' ||
                             DBMS_UTILITY.format_error_backtrace,
                             nusession,
                             USER);
      RAISE;
  END prExecuteIFRS;

  /*****************************************************************
  Propiedad intelectual de gdc (c).

  Unidad         : GenDatos
  Descripcion    : Procedimiento donde se ejecuta servicio para generar informacion IFRS
  Autor          : Samuel Pacheco Ocoro
  Fecha          : 30/04/2018

  Metodos

  Nombre         :
  Parametros         Descripcion
  ============  ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================
  08/10/2018        hcardona          Se agrega el hint a la consulta INDEX ( LDC_LOG_LDRPCRE, LDC_LOG_LDRPCRE_IDX01 ) del CURSOR cuJobs
  ******************************************************************/
  PROCEDURE GenDatos(inuYear IN NUMBER, inuMonth IN NUMBER) IS
    nuHilosComision NUMBER;
    nuTotReg        NUMBER;
    nuFinJobs       NUMBER(1);
    nuCont          NUMBER;
    nuresult        NUMBER(5);

    CURSOR cuJobs(nuInd NUMBER) IS
      SELECT /*+ INDEX ( LDC_LOG_LDRPCRE, LDC_LOG_LDRPCRE_IDX01 ) */
       resultado
        FROM LDC_LOG_LDRPCRE
       WHERE sesion = nusesion
         AND fecha_inicio = dtToday
         AND hilo = nuind
         AND ano = inuYear
         AND mes = inuMonth
         AND proceso = 'IFRS'
         AND resultado IN (-1, 2); -- -1 Termino con errores, 2 termino OK

    nujob  NUMBER;
    sbWhat VARCHAR2(4000);
  BEGIN
    nuHilosComision := dald_parameter.fnuGetNumeric_Value('IFRS_HILOS');
    sbprog          := 'IFRS';

    -- se crean los jobs y se ejecutan
    FOR rgJob IN 1 .. nuHilosComision LOOP
      sbWhat := 'BEGIN' || CHR(10) || '   SetSystemEnviroment;' || CHR(10) ||
                '   pkgLDC_IFRS.ProGenDataModeloIFRS(' || inuYear || ',' ||
                CHR(10) || '                                ' || inuMonth || ',' ||
                CHR(10) || '                                to_date(''' ||
                TO_CHAR(dtToday, 'DD/MM/YYYY  HH24:MI:SS') || '''),' ||
                CHR(10) || '                                ' || rgJob || ',' ||
                CHR(10) || '                                ' ||
                nuHilosComision || ',' || CHR(10) ||
                '                                ' || nusesion || ');' ||
                CHR(10) || 'END;';
      DBMS_JOB.submit(nujob, sbWhat, SYSDATE + 1 / 3600); -- se programa la ejecucion (los jobs se eliminan automatiamente apenas terminan)
      COMMIT;
    END LOOP;

    -- se verifica si terminaron los jobs
    nuFinJobs := 0;

    WHILE nuFinJobs = 0 LOOP
      nucont := 0;

      FOR i IN 1 .. nuHilosComision LOOP
        OPEN cujobs(i);

        FETCH cujobs
          INTO nuresult;

        IF cujobs%FOUND THEN
          nucont := nucont + 1;
        END IF;

        CLOSE cujobs;
      END LOOP;

      IF nucont = nuHilosComision THEN
        nuFinJobs := 1;
      ELSE
        DBMS_LOCK.SLEEP(60);
      END IF;
    END LOOP;

    pro_grabalog(nusesion,
                 sbprog,
                 inuYear,
                 inuMonth,
                 dtToday,
                 0,
                 0,
                 'Terminaron todos los hilos');
  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      pro_grabalog(nusesion,
                   sbprog,
                   inuYear,
                   inuMonth,
                   dtToday,
                   0,
                   0,
                   'Error: ' || SQLERRM);
      ROLLBACK;
      RAISE;
    WHEN OTHERS THEN
      pro_grabalog(nusesion,
                   sbprog,
                   inuYear,
                   inuMonth,
                   dtToday,
                   0,
                   0,
                   'Error: ' || SQLERRM);
      ROLLBACK;
  END GenDatos;

  /*****************************************************************
  Propiedad intelectual de gdc (c).

  Unidad         : ProGenDataModeloIFRS
  Descripcion    : Procedimiento utilizado para la generacion de los datos del modelo de cartera IFRS
  Autor          : Samuel Pacheco Ocoro
  Fecha          : 30/04/2018

  Metodos

  Nombre         :
  Parametros         Descripcion
  ============  ===================

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================
  08/10/2018        hcardona          Se agrega el hint a la consulta ORDERED USE_NL ( B, A ) INDEX ( A, IDX_ICCART_NUSE_FEGE_NACA ), ( B, IX_SERVSUSC024 ) del CURSOR CurDatos_IC_CARTCOCO
                                      para garantizar que el motor de la base de datos resuelva por este plan de ejecucion.
                                      Metodo proc_SaldoxProducto.

                                      Se agrega el hint index ( diferido, IX_DIFERIDO16 ) al CURSOR CurDatos_Diferido
                                      Metodo proc_Llenar_Diferidos.

                                      Se agrega el hint INDEX ( MOVIDIFE, IX_MOVIDIFE07 ) al CURSOR
                                      Metodo proc_Llenar_Mov_Diferidos.

                                      Se agrega hint INDEX ( PAGOS, IX_PAGO_SUSC ) al CURSOR CurDatos_Pagos
                                      Metodo proc_LLenar_Pagos.

                                      Se agega hint INDEX ( a, idx_tmpinprov ) a la funcion fnBuscarContrato para que la busqueda utilice
                                      el indice mas selectivo de la entidad TMP_INFORME_PROV_CART.

                                      Se cambio hint index(MP, OPT_IDX_MO_PACKAGES_034) por index(MP, PK_MO_PACKAGES) CURSOR curCodeudor
                                      Metodo proc_Actualizar_Codeudor.
                                      Este indice OPT_IDX_MO_PACKAGES_034 no existe

                                      Para los metodos getSubscriptions y getRecordsToProcess se agrego el hint INDEX ( a, idx_tmpinprov ) del
                                      CURSOR cuSuscripc.

                                      Se realiza el cambio de llamado de los procesos
                                      getSubscriptions_Ciclo_0    por getSubscriptions
                                      getRecordsToProcess_Ciclo_0 por getRecordsToProcess
                                      proc_Llenar_OSF_SESUCIER_C0 por proc_Llenar_OSF_SESUCIER
                                      proc_Llenar_OSF_DIFERIDO_C0 por proc_Llenar_OSF_DIFERIDO
                                      proc_Llenar_Facturacion_C0  por proc_Llenar_Facturacion

  24/11/2021        DANVAL            CA 906_1 : Se aplico la validacion a las subconsultas de los procesos en el SELECT para evitar retornar mas de una fila en la respuesta

  ******************************************************************/

  PROCEDURE ProGenDataModeloIFRS(nuAno          IN NUMBER,
                                 nuMes          IN NUMBER,
                                 idttoday       DATE,
                                 nuThreadNumber NUMBER,
                                 nuTotalThreads NUMBER,
                                 innusesion     NUMBER) IS
    --906_1
    nuContrato number := 0;
    nuLinea    number := 0;
    --
    nuLimit      NUMBER := 500;
    nuRegistros  NUMBER := 0;
    F            UTL_FILE.FILE_TYPE;
    sbEncabezado VARCHAR2(4000);

    nuIdx NUMBER;

    --Se crea un objeto tipo cursor
    TYPE TipoCursor IS REF CURSOR;

    -- Define colecciones de cada columna de la tabla
    TYPE tySusccodi IS TABLE OF suscripc.susccodi%TYPE INDEX BY BINARY_INTEGER;

    TYPE tySuscclie IS TABLE OF suscripc.suscclie%TYPE INDEX BY BINARY_INTEGER;

    sbMsgErr ge_error_log.description%TYPE;

    -- Define tipos
    TYPE tytbData IS RECORD(
      susccodi tySusccodi,
      suscclie tySuscclie);

    -- Define variable record
    rctbData      tytbData; -- Record tablas Suscripc
    rctbDataEmpty tytbData; -- Record tablas Suscripc vacia

    --Se define una variable con el objeto tipo cursor
    CursorDinamico TipoCursor;

    --Variable que obtiene el SQL o TABLA a usar
    SQL_DINAMICO VARCHAR2(3000);

    nuDato NUMBER;

    -- Variables
    piTime_Ini             PLS_INTEGER;
    piCpuTime_Ini          PLS_INTEGER;
    piTime_End             PLS_INTEGER;
    piCpuTime_End          PLS_INTEGER;
    nuBulkLimit            NUMBER := 100; -- Numero de registros a devolver
    blMoreRecords          BOOLEAN; -- Mas registros?
    rctbSubscriptions      tytbData; -- Tabla de datos
    rctbSubscriptionsEmpty tytbData; -- Tabla de datos
    nuSubscriptionCurr     NUMBER;

    sbProgram               estaprog.esprprog%TYPE;
    nuRecordsToProcess      NUMBER;
    nuTotalRecordsProcessed NUMBER;
    nuBulkIndex             NUMBER;
    nuTrack                 NUMBER;

    dtFechaInical DATE;
    dtFechaFinal  DATE;

    CURSOR cuCierre IS
      SELECT CICOFEIN, CICOFECH
        FROM LDC_CIERCOME
       WHERE CICOANO = nuAno
         AND CICOMES = nuMes;

    CURSOR CurDatos_OSF_Sesucier(nuContrato IN NUMBER) IS
      WITH FECHAS AS
       (SELECT A.*,
               LAST_DAY(TO_DATE('01/' || CICOMES || '/' || CICOANO)) FECHA_CONTABLE
          FROM LDC_CIERCOME A
         WHERE CICOANO = nuAno
           AND CICOMES = nuMes)
      SELECT /*+ no_merge(FECHAS)
                             ordered
                             use_nl(FECHAS, SE, SC, PE)
                             no_index(SC, idx_sesucier03)
                             index(SE, IX_SERVSUSC024)
                             index(SC, IDX_SESUCIER_BORRAR)
                             index(PE, UX_PERIFACT01)
                        */
       NUANO         ANO,
       NUMES         MES,
       CONTRATO,
       PRODUCTO,
       TIPO_PRODUCTO,
       --( SELECT LDC_dsServicio.fsbGetServdesc ( TIPO_PRODUCTO ) FROM DUAL ) AS DESC_TIPO_PRODUCTO,
       (SELECT pktblservicio.fsbgetdescription(TIPO_PRODUCTO) FROM DUAL) AS DESC_TIPO_PRODUCTO,
       CATEGORIA,
       --( SELECT LDC_dsCategori.fsbGetCatedesc ( CATEGORIA ) FROM DUAL ) AS DESC_CATEGORIA,
       (SELECT pktblcategori.fsbgetdescription(CATEGORIA) FROM DUAL) AS DESC_CATEGORIA,
       SUBCATEGORIA,
       --( SELECT LDC_dsSubCateg.fsbGetSucadesc ( CATEGORIA, SUBCATEGORIA ) FROM DUAL ) AS DESCR_USO,
       (SELECT PKTBLSUBCATEG.fsbGetDescription(CATEGORIA, SUBCATEGORIA)
          FROM DUAL) AS DESCR_USO,
       SESUFEIN AS FECHA_ORIGINACION_PROD,
       EDAD_DEUDA,
       EDAD ALTURA_MORA, --se modifica origen de la columna
       /*DEUDA_CORRIENTE_NO_VENCIDA + DEUDA_CORRIENTE_VENCIDAb*/
       0 SALDO_CORRIENTE_NO_FINANCIADO,
       /*DEUDA_NO_CORRIENTE*/
       0 SALDO_DIFERIDO,
       /*DEUDA_CORRIENTE_VENCIDA + DEUDA_CORRIENTE_NO_VENCIDA + DEUDA_NO_CORRIENTE*/
       0 SALDO_TOTAL,
       /*DEUDA_DIFERIDA_CORRIENTE*/
       0 DEUDA_DIFERIDA_CORRIENTE,
       /*DEUDA_CORRIENTE_VENCIDA*/
       0 DEUDA_CORRIENTE_VENCIDA,
       /*DEUDA_CORRIENTE_NO_VENCIDA*/
       0 DEUDA_CORRIENTE_NO_VENCIDA,
       /*DEUDA_NO_CORRIENTE*/
       0    DEUDA_NO_CORRIENTE,
       NULL DEFAULT_,
       /*( SELECT ALLOCATED_QUOTA
           FROM LDC_QUOTA_FNB
          WHERE SUBSCRIPTION_ID = CONTRATO
       ) CUPO,*/
       (SELECT QUOTA_VALUE
          FROM LD_QUOTA_BY_SUBSC
         WHERE SUBSCRIPTION_ID = CONTRATO
              --906_1
           AND ROWNUM = 1
        --
        ) CUPO,
       (SELECT DELIFACT
          FROM IC_DETLISIM
         WHERE DELINUSE = PRODUCTO
           AND DELIFECO = FECHA_CONTABLE
              --906_1
           AND ROWNUM = 1
        --
        ) SCORE_O_PUNTAJE_FINAL,
       CICLO,
       DEPARTAMENTO,
       LOCALIDAD,
       NULL SALDO_OTROS,
       PEFACODI,
       CICOFEIN,
       CICOFECH,
       CICOHOEJ
        FROM FECHAS, SERVSUSC SE, LDC_OSF_SESUCIER SC, PERIFACT PE
       WHERE SE.SESUSUSC = nuContrato
         AND SC.PRODUCTO = SE.SESUNUSE
         AND SC.NUANO = FECHAS.CICOANO
         AND SC.NUMES = FECHAS.CICOMES
         AND PE.PEFAANO = FECHAS.CICOANO
         AND PE.PEFAMES = FECHAS.CICOMES
         AND SC.CICLO = PE.PEFACICL;

    TYPE ttyDatos_OSF_Sesucier IS TABLE OF CurDatos_OSF_Sesucier%ROWTYPE INDEX BY VARCHAR2(54);

    grcDatos_OSF_Sesucier  curDatos_OSF_Sesucier%ROWTYPE;
    gtblDatos_OSF_Sesucier ttyDatos_OSF_Sesucier;

    CURSOR CurDatos_OSF_Diferidos(nuContrato IN NUMBER) IS
      WITH FECHAS AS
       (SELECT *
          FROM LDC_CIERCOME
         WHERE CICOANO = nuAno
           AND CICOMES = nuMes)
      SELECT /*+ no_merge(FECHAS)
                              ordered
                              use_nl(FECHAS, SERVSUSC, LDC_OSF_DIFERIDO)
                              index(SERVSUSC, IX_SERVSUSC024)
                              index(LDC_OSF_DIFERIDO, ix_LDC_OSF_DIFERIDO_BORRAR)
                            */
       DIFEANO,
       DIFEMES,
       DIFECOFI FINANCIACION,
       DIFESUSC,
       DIFENUSE,
       DIFECODI IDDIFERIDO,
       DIFEPLDI PLAN_FINANCIACION,
       --( SELECT LDC_dsPlandife.fsbGetPldidesc ( DIFEPLDI ) FROM DUAL) AS DESC_PLAN,
       (SELECT pktblplandife.fsbgetdescription(DIFEPLDI) FROM DUAL) AS DESC_PLAN,
       DIFEFEIN FECHA_ORIGINACION_FIN,
       ADD_MONTHS(DIFEFEIN, DIFENUCU) FECHA_TERMINACION_FIN,
       DIFENUCU PLAZO_ORIGINACION,
       NULL DEFAULT_,
       DIFECUPA CUOTAS_COBRADAS,
       DECODE(DIFESIGN, 'DB', DIFESAPE, 'CR', -DIFESAPE, 0) SALDO_CAPITAL,
       NVL((SELECT INTEREST_PERCENT
             FROM CC_FINANCING_REQUEST R
            WHERE R.FINANCING_ID = DIFECOFI
              AND ROWNUM = 1),
           DIFEINTE) TASA_INTERES,
       DIFENUDO,
       DIFEPROG
        FROM FECHAS, SERVSUSC, LDC_OSF_DIFERIDO
       WHERE SESUSUSC = nuContrato
         AND DIFENUSE = SESUNUSE
         AND DIFEANO = CICOANO
         AND DIFEMES = CICOMES;

    TYPE ttyDatos_OSF_Diferidos IS TABLE OF CurDatos_OSF_Diferidos%ROWTYPE INDEX BY VARCHAR2(54);

    grcDatos_OSF_Diferidos  curDatos_OSF_Diferidos%ROWTYPE;
    gtblDatos_OSF_Diferidos ttyDatos_OSF_Diferidos;

    CURSOR CurDatos_Facturacion(nuContrato IN NUMBER) IS
      SELECT /*+
                          ordered
                          use_nl(FACTURA, CUENCOBR, A, CONCEPTO, PERIFACT)
                        */
       FACTSUSC,
       FACTCODI,
       CUCOCODI,
       CUCONUSE,
       CARGCONC,
       CONCDESC,
       CONCTICL,
       CARGSIGN,
       CARGCACA,
       CARGPEFA,
       DECODE(CARGSIGN,
              'DB',
              CARGVALO,
              'CR',
              -CARGVALO,
              'AS',
              -CARGVALO,
              'PA',
              -CARGVALO,
              'SA',
              CARGVALO,
              'AP',
              CARGVALO,
              0) CARGVALO,
       CARGDOSO,
       CARGCODO,
       CARGUSUA,
       CARGTIPR,
       CARGFECR,
       CARGPROG,
       CUCOFEPA,
       NVL(CUCOSACU, 0) CUCOSACU,
       CUCOFEVE,
       FACTPEFA,
       FACTFEGE,
       PEFACODI,
       PEFAANO,
       PEFAMES
        FROM FACTURA, CUENCOBR, CARGOS A, CONCEPTO, PERIFACT
       WHERE FACTSUSC = nuContrato
         AND FACTFEGE BETWEEN dtFechaInicial AND dtFechaFinal
         AND CUCOFACT = FACTCODI
         AND CUCOCODI = CARGCUCO
         AND CARGCONC = CONCCODI
         AND CARGPEFA = PEFACODI;

    TYPE ttyDatos_Facturacion IS TABLE OF CurDatos_Facturacion%ROWTYPE INDEX BY BINARY_INTEGER;

    grcDatos_Facturacion curDatos_Facturacion%ROWTYPE;

    gtblDatos_Facturacion ttyDatos_Facturacion;

    -- Cursores procesar Ciclo 0
    CURSOR CurDatos_OSF_Sesucier_C0(nuContrato IN NUMBER) IS
      WITH FECHAS AS
       (SELECT A.*,
               LAST_DAY(TO_DATE('01/' || CICOMES || '/' || CICOANO)) FECHA_CONTABLE
          FROM LDC_CIERCOME A
         WHERE CICOANO = nuAno
           AND CICOMES = nuMes)
      SELECT /*+ no_merge(FECHAS)
                              ordered
                              use_nl(FECHAS, SE, SC)
                              no_index(SC, idx_sesucier03)
                              index(SE, IX_SERVSUSC024)
                              index(SC, IDX_SESUCIER_BORRAR)
                            */
       NUANO         ANO,
       NUMES         MES,
       CONTRATO,
       PRODUCTO,
       TIPO_PRODUCTO,
       --( SELECT LDC_dsServicio.fsbGetServdesc ( TIPO_PRODUCTO ) FROM dual ) AS DESC_TIPO_PRODUCTO,
       (SELECT pktblservicio.fsbgetdescription(TIPO_PRODUCTO) FROM DUAL) AS DESC_TIPO_PRODUCTO,
       CATEGORIA,
       --( SELECT LDC_dsCategori.fsbGetCatedesc ( CATEGORIA ) FROM DUAL ) AS DESC_CATEGORIA,
       (SELECT pktblcategori.fsbgetdescription(CATEGORIA) FROM DUAL) AS DESC_CATEGORIA,
       SUBCATEGORIA,
       --( SELECT LDC_dsSubCateg.fsbGetSucadesc ( CATEGORIA, SUBCATEGORIA ) FROM DUAL ) AS DESCR_USO,
       (SELECT PKTBLSUBCATEG.fsbGetDescription(CATEGORIA, SUBCATEGORIA)
          FROM DUAL) AS DESCR_USO,
       SESUFEIN AS FECHA_ORIGINACION_PROD,
       EDAD_DEUDA, --se agrega columna
       EDAD ALTURA_MORA, --se modifica origen de la columna
       /*DEUDA_CORRIENTE_NO_VENCIDA + DEUDA_CORRIENTE_VENCIDAb*/
       0 SALDO_CORRIENTE_NO_FINANCIADO,
       /*DEUDA_NO_CORRIENTE*/
       0 SALDO_DIFERIDO,
       /*DEUDA_CORRIENTE_VENCIDA + DEUDA_CORRIENTE_NO_VENCIDA + DEUDA_NO_CORRIENTE*/
       0 SALDO_TOTAL,
       /*DEUDA_DIFERIDA_CORRIENTE*/
       0 DEUDA_DIFERIDA_CORRIENTE,
       /*DEUDA_CORRIENTE_VENCIDA*/
       0 DEUDA_CORRIENTE_VENCIDA,
       /*DEUDA_CORRIENTE_NO_VENCIDA*/
       0 DEUDA_CORRIENTE_NO_VENCIDA,
       /*DEUDA_NO_CORRIENTE*/
       0 DEUDA_NO_CORRIENTE,
       NULL DEFAULT_,
       (SELECT ALLOCATED_QUOTA
          FROM LDC_QUOTA_FNB
         WHERE SUBSCRIPTION_ID = CONTRATO
              --906_1
           AND ROWNUM = 1
        --
        ) CUPO,
       (SELECT DELIFACT
          FROM IC_DETLISIM
         WHERE DELINUSE = PRODUCTO
           AND DELIFECO = FECHA_CONTABLE
              --906_1
           AND ROWNUM = 1
        --
        ) SCORE_O_PUNTAJE_FINAL,
       CICLO,
       DEPARTAMENTO,
       LOCALIDAD,
       NULL SALDO_OTROS,
       0 PEFACODI,
       CICOFEIN,
       CICOFECH,
       CICOHOEJ
        FROM FECHAS, SERVSUSC SE, LDC_OSF_SESUCIER SC
       WHERE SE.SESUSUSC = nuContrato
         AND SC.PRODUCTO = SE.SESUNUSE
         AND SC.NUANO = FECHAS.CICOANO
         AND SC.NUMES = FECHAS.CICOMES;

    TYPE ttyDatos_OSF_Sesucier_C0 IS TABLE OF CurDatos_OSF_Sesucier_C0%ROWTYPE INDEX BY VARCHAR2(54);

    grcDatos_OSF_Sesucier_C0  curDatos_OSF_Sesucier_C0%ROWTYPE;
    gtblDatos_OSF_Sesucier_C0 ttyDatos_OSF_Sesucier_C0;

    CURSOR CurDatos_OSF_Diferidos_C0(nuContrato IN NUMBER) IS
      WITH FECHAS AS
       (SELECT *
          FROM LDC_CIERCOME
         WHERE CICOANO = nuAno
           AND CICOMES = nuMes)
      SELECT /*+ no_merge(FECHAS)
                              ordered
                              use_nl(FECHAS, SERVSUSC, LDC_OSF_DIFERIDO)
                              index(SERVSUSC, IX_SERVSUSC024)
                              index(LDC_OSF_DIFERIDO, ix_LDC_OSF_DIFERIDO_BORRAR)
                            */
       DIFEANO,
       DIFEMES,
       DIFECOFI FINANCIACION,
       DIFESUSC,
       DIFENUSE,
       DIFECODI IDDIFERIDO,
       DIFEPLDI PLAN_FINANCIACION,
       --( SELECT LDC_dsPlandife.fsbGetPldidesc ( DIFEPLDI ) FROM DUAL ) AS DESC_PLAN,
       (SELECT pktblplandife.fsbgetdescription(DIFEPLDI) FROM DUAL) AS DESC_PLAN,
       DIFEFEIN FECHA_ORIGINACION_FIN,
       ADD_MONTHS(DIFEFEIN, DIFENUCU) FECHA_TERMINACION_FIN,
       DIFENUCU PLAZO_ORIGINACION,
       NULL DEFAULT_,
       DIFECUPA CUOTAS_COBRADAS,
       DECODE(DIFESIGN, 'DB', DIFESAPE, 'CR', -DIFESAPE, 0) SALDO_CAPITAL,
       NVL((SELECT INTEREST_PERCENT
             FROM CC_FINANCING_REQUEST R
            WHERE R.FINANCING_ID = DIFECOFI
              AND ROWNUM = 1),
           DIFEINTE) TASA_INTERES,
       DIFENUDO,
       DIFEPROG
        FROM FECHAS, SERVSUSC, LDC_OSF_DIFERIDO
       WHERE SESUSUSC = nuContrato
         AND DIFENUSE = SESUNUSE
         AND DIFEANO = CICOANO
         AND DIFEMES = CICOMES;

    TYPE ttyDatos_OSF_Diferidos_C0 IS TABLE OF CurDatos_OSF_Diferidos_C0%ROWTYPE INDEX BY VARCHAR2(54);

    grcDatos_OSF_Diferidos_C0  curDatos_OSF_Diferidos_C0%ROWTYPE;
    gtblDatos_OSF_Diferidos_C0 ttyDatos_OSF_Diferidos_C0;

    CURSOR CurDatos_Facturacion_C0(nuContrato IN NUMBER) IS
      SELECT /*+
                              ordered
                              use_nl(FACTURA, CUENCOBR, A, CONCEPTO)
                            */
       FACTSUSC,
       FACTCODI,
       CUCOCODI,
       CUCONUSE,
       CARGCONC,
       CONCDESC,
       CONCTICL,
       CARGSIGN,
       CARGCACA,
       CARGPEFA,
       DECODE(CARGSIGN,
              'DB',
              CARGVALO,
              'CR',
              -CARGVALO,
              'AS',
              -CARGVALO,
              'PA',
              -CARGVALO,
              'SA',
              CARGVALO,
              'AP',
              CARGVALO,
              0) CARGVALO,
       CARGDOSO,
       CARGCODO,
       CARGUSUA,
       CARGTIPR,
       CARGFECR,
       CARGPROG,
       CUCOFEPA,
       NVL(CUCOSACU, 0) CUCOSACU,
       CUCOFEVE,
       FACTPEFA,
       FACTFEGE,
       NULL PEFACODI,
       NULL PEFAANO,
       NULL PEFAMES
        FROM FACTURA, CUENCOBR, CARGOS A, CONCEPTO
       WHERE FACTSUSC = nuContrato
         AND FACTFEGE BETWEEN dtFechaInicial AND dtFechaFinal
         AND CUCOFACT = FACTCODI
         AND CUCOCODI = CARGCUCO
         AND CARGCONC = CONCCODI;

    TYPE ttyDatos_Facturacion_C0 IS TABLE OF CurDatos_Facturacion_C0%ROWTYPE INDEX BY BINARY_INTEGER;

    grcDatos_Facturacion_C0 curDatos_Facturacion_C0%ROWTYPE;

    gtblDatos_Facturacion_C0 ttyDatos_Facturacion_C0;

    -- Se agrega el hint a la consulta ORDERED USE_NL ( B, A ) INDEX ( A, IDX_ICCART_NUSE_FEGE_NACA ), ( B, IX_SERVSUSC024 )
    CURSOR CurDatos_IC_CARTCOCO(nuContrato IN NUMBER) IS
      SELECT /*+ ORDERED USE_NL ( B, A ) INDEX ( A, IDX_ICCART_NUSE_FEGE_NACA ), ( B, IX_SERVSUSC024 ) */
       A.*, TO_CHAR(CACCFEGE, 'YYYY') ANHO, TO_CHAR(CACCFEGE, 'MM') MES
        FROM SERVSUSC B, IC_CARTCOCO A
       WHERE B.SESUSUSC = nuContrato
         AND B.SESUNUSE = A.CACCNUSE
         AND A.CACCFEGE BETWEEN dtFechaInicial AND dtFechaFinal
         AND A.CACCNACA IN ('N', 'F');

    TYPE ttyDatos_IC_CARTCOCO IS TABLE OF CurDatos_IC_CARTCOCO%ROWTYPE INDEX BY VARCHAR2(10);

    grcDatos_IC_CARTCOCO  curDatos_IC_CARTCOCO%ROWTYPE;
    gtblDatos_IC_CARTCOCO ttyDatos_IC_CARTCOCO;

    -- Se agrega el hint a la consulta index ( diferido, IX_DIFERIDO16 )
    CURSOR CurDatos_Diferido(nuContrato IN NUMBER) IS
      SELECT /*+ index ( diferido, IX_DIFERIDO16 ) */
       DIFECOFI, DIFESUSC, DIFENUSE
        FROM DIFERIDO
       WHERE DIFESUSC = nuContrato
         AND DIFEFEIN BETWEEN dtFechaInicial AND dtFechaFinal;

    TYPE ttyDatos_Diferido IS TABLE OF CurDatos_Diferido%ROWTYPE INDEX BY VARCHAR2(33);

    grcDatos_Diferido  curDatos_Diferido%ROWTYPE;
    gtblDatos_Diferido ttyDatos_Diferido;

    -- Se agrega el hint a la consulta INDEX ( MOVIDIFE, IX_MOVIDIFE07 )
    CURSOR CurDatos_Mov_Diferido(nuContrato IN NUMBER) IS
      SELECT /*+ INDEX ( MOVIDIFE, IX_MOVIDIFE07 ) */
       MODIDIFE, MODISUSC, MODINUSE, MODISIGN, MODIFECH, MODICUAP, MODIVACU
        FROM MOVIDIFE
       WHERE MODISUSC = nuContrato
         AND MODICUAP > 0
         AND MODIFECA BETWEEN dtFechaInicial AND dtFechaFinal;

    TYPE ttyDatos_Mov_Diferido IS TABLE OF CurDatos_Mov_Diferido%ROWTYPE INDEX BY VARCHAR2(61);

    grcDatos_Mov_Diferido  curDatos_Mov_Diferido%ROWTYPE;
    gtblDatos_Mov_Diferido ttyDatos_Mov_Diferido;

    -- Se agrega el hint a la consulta INDEX ( PAGOS, IX_PAGO_SUSC )
    CURSOR CurDatos_Pagos(nuContrato IN NUMBER) IS
      SELECT /*+ INDEX ( PAGOS, IX_PAGO_SUSC ) */
       PAGOSUSC, PAGOCUPO, PAGOFEPA, PAGOFEGR, PAGOVAPA
        FROM PAGOS
       WHERE PAGOSUSC = nuContrato
         AND PAGOFEPA BETWEEN dtFechaInicial AND dtFechaFinal;

    TYPE ttyDatos_Pagos IS TABLE OF CurDatos_Pagos%ROWTYPE INDEX BY VARCHAR2(12); /*BINARY_INTEGER*/

    grcDatos_Pagos  curDatos_Pagos%ROWTYPE;
    gtblDatos_Pagos ttyDatos_Pagos;

    -- Registros para almacenar los datos de los contratos a evaluar.
    TYPE tyrcDataProductos IS RECORD(
      ANO                           NUMBER(4, 0),
      MES                           NUMBER(2, 0),
      CONTRATO                      NUMBER(8, 0),
      PRODUCTO                      NUMBER(15, 0),
      TIPO_PRODUCTO                 NUMBER(4, 0),
      DESC_TIPO_PRODUCTO            VARCHAR2(30),
      ALTURA_MORA                   NUMBER(5, 0),
      SALDO_CORRIENTE_NO_FINANCIADO NUMBER,
      SALDO_DIFERIDO                NUMBER(15, 2),
      SALDO_TOTAL                   NUMBER,
      DEUDA_DIFERIDA_CORRIENTE      NUMBER(15, 2),
      DEUDA_CORRIENTE_VENCIDA       NUMBER(15, 2),
      DEUDA_CORRIENTE_NO_VENCIDA    NUMBER(15, 2),
      DEUDA_NO_CORRIENTE            NUMBER(15, 2),
      FECHA_ORIGINACION_PROD        DATE,
      CUPO                          NUMBER,
      SCORE_O_PUNTAJE_FINAL         NUMBER,
      CICLO                         NUMBER(10, 0),
      DEPARTAMENTO                  NUMBER(6, 0),
      LOCALIDAD                     NUMBER(6, 0),
      CATEGORIA                     NUMBER(2, 0),
      DESC_CATEGORIA                VARCHAR2(30),
      SUBCATEGORIA                  NUMBER(2, 0),
      DESCR_USO                     VARCHAR2(30),
      PEFACODI                      NUMBER(6, 0),
      CICOFEIN                      DATE,
      CICOFECH                      DATE,
      CICOHOEJ                      DATE,
      ANHO                          NUMBER(4, 0),
      MES_                          NUMBER(2, 0),
      DIFESUSC                      NUMBER(8, 0),
      DIFENUSE                      NUMBER(10, 0),
      FINANCIACION                  NUMBER(15, 0),
      IDDIFERIDO                    NUMBER(15, 0),
      PLAN_FINANCIACION             NUMBER(4, 0),
      DESC_PLAN                     VARCHAR2(60),
      DIFENUDO                      VARCHAR2(30),
      DIFEPROG                      VARCHAR2(10),
      FECHA_ORIGINACION_FIN         DATE,
      FECHA_TERMINACION_FIN         DATE,
      PLAZO_ORIGINACION             NUMBER(4, 0),
      CUOTAS_COBRADAS               NUMBER,
      SALDO_CAPITAL                 NUMBER,
      TASA_INTERES                  NUMBER,
      CODEUDOR                      NUMBER,
      ESTADO_CUENTA                 NUMBER,
      CUENTA_COBRO                  NUMBER,
      FECHA_PAGO                    DATE,
      VALOR_PAGO                    NUMBER,
      FECHA_ULTIMO_MOV              DATE,
      CUOTAS_PAGADAS                NUMBER,
      SALDO_INTERES                 NUMBER,
      SALDO_INTERES_MORA            NUMBER,
      SALDOCTEFINANCIADO            NUMBER,
      SALDOCTENOFINANCIADO          NUMBER,
      FECHA_CIERRE                  DATE,
      MES1                          NUMBER,
      MES2                          NUMBER,
      MES3                          NUMBER,
      MES4                          NUMBER,
      MES5                          NUMBER,
      MES6                          NUMBER,
      MES7                          NUMBER,
      MES8                          NUMBER,
      MES9                          NUMBER,
      MES10                         NUMBER,
      MES11                         NUMBER,
      MES12                         NUMBER,
      MES13                         NUMBER,
      MES14                         NUMBER,
      MES15                         NUMBER,
      MES16                         NUMBER,
      MES17                         NUMBER,
      MES18                         NUMBER,
      MES19                         NUMBER,
      MES20                         NUMBER,
      FECHA_CASTIGO                 DATE,
      VALOR_CASTIGADO               NUMBER,
      EDAD_DEUDA                    NUMBER(5, 0) --se agrega columna
      );

    TYPE tytbDataProductos IS TABLE OF tyrcDataProductos INDEX BY VARCHAR2(54);

    trcDataProductos tytbDataProductos;

    -- Registros para almacenar los datos de los contratos a evaluar.
    TYPE typeInformeProvCart IS RECORD(
      ANO                           NUMBER(4, 0),
      MES                           NUMBER(2, 0),
      CONTRATO                      NUMBER(8, 0),
      PRODUCTO                      NUMBER(15, 0),
      TIPO_PRODUCTO                 NUMBER(4, 0),
      DESC_TIPO_PRODUCTO            VARCHAR2(30),
      ALTURA_MORA                   NUMBER(5, 0),
      SALDO_CORRIENTE_NO_FINANCIADO NUMBER,
      SALDO_DIFERIDO                NUMBER(15, 2),
      SALDO_TOTAL                   NUMBER,
      DEUDA_DIFERIDA_CORRIENTE      NUMBER(15, 2),
      DEUDA_CORRIENTE_VENCIDA       NUMBER(15, 2),
      DEUDA_CORRIENTE_NO_VENCIDA    NUMBER(15, 2),
      DEUDA_NO_CORRIENTE            NUMBER(15, 2),
      FECHA_ORIGINACION_PROD        DATE,
      CUPO                          NUMBER,
      SCORE_O_PUNTAJE_FINAL         NUMBER,
      CICLO                         NUMBER(10, 0),
      DEPARTAMENTO                  NUMBER(6, 0),
      LOCALIDAD                     NUMBER(6, 0),
      CATEGORIA                     NUMBER(2, 0),
      DESC_CATEGORIA                VARCHAR2(30),
      SUBCATEGORIA                  NUMBER(2, 0),
      DESCR_USO                     VARCHAR2(30),
      PEFACODI                      NUMBER(6, 0),
      CICOFEIN                      DATE,
      CICOFECH                      DATE,
      CICOHOEJ                      DATE,
      ANHO                          NUMBER(4, 0),
      MES_                          NUMBER(2, 0),
      DIFESUSC                      NUMBER(8, 0),
      DIFENUSE                      NUMBER(10, 0),
      FINANCIACION                  NUMBER(15, 0),
      IDDIFERIDO                    NUMBER(15, 0),
      PLAN_FINANCIACION             NUMBER(4, 0),
      DESC_PLAN                     VARCHAR2(60),
      DIFENUDO                      VARCHAR2(30),
      DIFEPROG                      VARCHAR2(10),
      FECHA_ORIGINACION_FIN         DATE,
      FECHA_TERMINACION_FIN         DATE,
      PLAZO_ORIGINACION             NUMBER(4, 0),
      CUOTAS_COBRADAS               NUMBER,
      SALDO_CAPITAL                 NUMBER,
      TASA_INTERES                  NUMBER,
      CODEUDOR                      NUMBER,
      ESTADO_CUENTA                 NUMBER,
      CUENTA_COBRO                  NUMBER,
      FECHA_PAGO                    DATE,
      VALOR_PAGO                    NUMBER,
      FECHA_ULTIMO_MOV              DATE,
      CUOTAS_PAGADAS                NUMBER,
      SALDO_INTERES                 NUMBER,
      SALDO_INTERES_MORA            NUMBER,
      SALDOCTEFINANCIADO            NUMBER,
      SALDOCTENOFINANCIADO          NUMBER,
      FECHA_CIERRE                  DATE,
      MES1                          NUMBER,
      MES2                          NUMBER,
      MES3                          NUMBER,
      MES4                          NUMBER,
      MES5                          NUMBER,
      MES6                          NUMBER,
      MES7                          NUMBER,
      MES8                          NUMBER,
      MES9                          NUMBER,
      MES10                         NUMBER,
      MES11                         NUMBER,
      MES12                         NUMBER,
      MES13                         NUMBER,
      MES14                         NUMBER,
      MES15                         NUMBER,
      MES16                         NUMBER,
      MES17                         NUMBER,
      MES18                         NUMBER,
      MES19                         NUMBER,
      MES20                         NUMBER,
      FECHA_CASTIGO                 DATE,
      VALOR_CASTIGADO               NUMBER,
      EDAD_DEUDA                    NUMBER(5, 0) --se agrega columna
      );

    --Variable tipo tabla PL/SQL para almacenar la informacion de la provision
    TYPE tycuInformeProvCart IS TABLE OF typeInformeProvCart INDEX BY BINARY_INTEGER;

    tbInformeProvCart      tycuInformeProvCart;
    tbInformeProvCartEmpty tycuInformeProvCart; -- Tabla de datos

    -- Registros con los movimientos facturados de un Contratao
    TYPE tyrcData_Cargos IS RECORD(
      FACTSUSC NUMBER,
      FACTCODI NUMBER,
      CUCOCODI NUMBER,
      CUCONUSE NUMBER,
      CARGCONC NUMBER,
      CARGCACA NUMBER,
      CARGPEFA NUMBER,
      CARGVALO NUMBER,
      CARGDOSO VARCHAR2(30),
      CARGCODO NUMBER,
      CARGUSUA VARCHAR2(20),
      CARGTIPR VARCHAR2(1),
      CARGFECR DATE,
      CARGPROG NUMBER,
      CUCOFEPA DATE,
      CUCOSACU NUMBER,
      CUCOFEVE DATE,
      FACTPEFA DATE,
      FACTFEGE DATE);

    TYPE tytbData_Cargos IS TABLE OF tyrcData_Cargos INDEX BY VARCHAR2(40);

    trcData_Cargos tytbData_Cargos;

    -- Almacenar movimientos de los contratos por a?o, mes
    TYPE tyrcDataVarProv IS RECORD(
      ANO                  NUMBER,
      MES                  NUMBER,
      PRODUCTO             NUMBER,
      PERIODO              NUMBER,
      FINANCIACION         NUMBER,
      IDDIFERIDO           NUMBER,
      FECHA_ULTIMO_MOV     DATE,
      ESTADO_CUENTA        NUMBER,
      CUENTA_COBRO         NUMBER,
      CUOTAS_COBRADAS      NUMBER,
      CUOTAS_PAGADAS       NUMBER,
      SALDOCTEFINANCIADO   NUMBER,
      SALDOCTENOFINANCIADO NUMBER,
      SALDO_INTERES        NUMBER,
      SALDO_INTERES_MORA   NUMBER,
      FECHA_PAGO           DATE,
      VALOR_PAGO           NUMBER,
      FECHA_CASTIGO        DATE,
      VALOR_CASTIGADO      NUMBER);

    TYPE tytbDataVarProv IS TABLE OF tyrcDataVarProv INDEX BY VARCHAR2(40);

    sbIndex        VARCHAR2(54);
    trcDataVarProv tytbDataVarProv;
    nuCodi         NUMBER;
    sbIndexCargos  VARCHAR2(40);

    -- Registro para almacenar los movimientos de los diferidos de un contrato
    TYPE tyrcData_Mov_Diferidos IS RECORD(
      MODIDIFE NUMBER(15),
      MODISUSC NUMBER(8),
      MODINUSE NUMBER(10),
      MODIFECH DATE,
      MODICUAP NUMBER);

    TYPE tytbData_Mov_Diferidos IS TABLE OF tyrcData_Mov_Diferidos INDEX BY VARCHAR2(40);

    trcData_Mov_Diferidos tytbData_Mov_Diferidos;
    sbIndex_Mov_Diferidos VARCHAR2(54);

    -- Registro para almacenar contratos a procesar
    TYPE tyrcContratos IS RECORD(
      CONTRATO NUMBER(8));

    TYPE tytbContratos IS TABLE OF tyrcContratos INDEX BY BINARY_INTEGER;

    trcContratos      tytbContratos;
    nuIndex_Contratos NUMBER(8);

    TYPE tyrcProductos IS RECORD(
      CONTRATO        NUMBER(8),
      PRODUCTO        NUMBER(10),
      FECHA_CORTE     DATE,
      SALDO_CORRIENTE NUMBER,
      SALDO_DIFERIDO  NUMBER,
      SALDO_TOTAL     NUMBER);

    -- Registro para almacenar productos a procesar
    TYPE tytbProductos IS TABLE OF tyrcProductos INDEX BY VARCHAR2(20);

    trcProductos      tytbProductos;
    sbIndex_Productos VARCHAR2(20);

    -- Se agrega el hint a la consulta INDEX ( a, idx_tmpinprov )
    FUNCTION fnBuscarContrato(nuContrato IN NUMBER,
                              nuMes      IN NUMBER,
                              nuAnho     IN NUMBER) RETURN NUMBER IS
      nuDatos NUMBER := 0;
    BEGIN
      SELECT /*+ INDEX ( a, idx_tmpinprov ) */
       COUNT(1)
        INTO nuDatos
        FROM TMP_INFORME_PROV_CART a
       WHERE a.CONTRATO = nuContrato
         AND a.ANO = nuAnho
         AND a.MES = nuMes;

      RETURN nuDatos;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        nuDatos := 0;
        RETURN nuDatos;
    END;

    -- Se agrega el hint a la consulta ORDERED USE_NL ( B, A ) INDEX ( A, IDX_ICCART_NUSE_FEGE_NACA ), ( B, IX_SERVSUSC024 )
    -- CURSOR CurDatos_IC_CARTCOCO
    PROCEDURE proc_SaldoxProducto(nuContrato IN NUMBER) IS
      CURSOR CurDatos_IC_CARTCOCO IS
        SELECT /*+ ORDERED USE_NL ( B, A ) INDEX ( A, IDX_ICCART_NUSE_FEGE_NACA ), ( B, IX_SERVSUSC024 ) */
         A.*, TO_CHAR(CACCFEGE, 'YYYY') ANHO, TO_CHAR(CACCFEGE, 'MM') MES
          FROM SERVSUSC B, IC_CARTCOCO A
         WHERE B.SESUSUSC = nuContrato
           AND B.SESUNUSE = A.CACCNUSE
           AND A.CACCFEGE BETWEEN dtFechaInicial AND dtFechaFinal
           AND A.CACCNACA IN ('N', 'F');

    BEGIN
      trcProductos.DELETE();

      FOR RegCon IN CurDatos_IC_CARTCOCO LOOP
        sbIndex_Productos := LPAD(RegCon.CACCNUSE, 10, '0') ||
                             LPAD(RegCon.CACCFEGE, 10, '0');

        IF trcProductos.EXISTS(sbIndex_Productos) THEN
          IF RegCon.CACCNACA = 'N' THEN
            trcProductos(sbIndex_Productos).SALDO_CORRIENTE := trcProductos(sbIndex_Productos).SALDO_CORRIENTE +
                                                                RegCon.CACCSAPE;
            trcProductos(sbIndex_Productos).SALDO_TOTAL := trcProductos(sbIndex_Productos).SALDO_TOTAL +
                                                            RegCon.CACCSAPE;
          ELSE
            trcProductos(sbIndex_Productos).SALDO_DIFERIDO := trcProductos(sbIndex_Productos).SALDO_DIFERIDO +
                                                               RegCon.CACCSAPE;
            trcProductos(sbIndex_Productos).SALDO_TOTAL := trcProductos(sbIndex_Productos).SALDO_TOTAL +
                                                            RegCon.CACCSAPE;
          END IF;
        ELSE
          trcProductos(sbIndex_Productos).CONTRATO := RegCon.CACCSUSC;
          trcProductos(sbIndex_Productos).PRODUCTO := RegCon.CACCNUSE;
          trcProductos(sbIndex_Productos).FECHA_CORTE := RegCon.CACCFEGE;
          trcProductos(sbIndex_Productos).SALDO_CORRIENTE := 0;
          trcProductos(sbIndex_Productos).SALDO_DIFERIDO := 0;
          trcProductos(sbIndex_Productos).SALDO_TOTAL := 0;

          IF RegCon.CACCNACA = 'N' THEN
            trcProductos(sbIndex_Productos).SALDO_CORRIENTE := RegCon.CACCSAPE;
            trcProductos(sbIndex_Productos).SALDO_TOTAL := RegCon.CACCSAPE;
          ELSE
            trcProductos(sbIndex_Productos).SALDO_DIFERIDO := RegCon.CACCSAPE;
            trcProductos(sbIndex_Productos).SALDO_TOTAL := RegCon.CACCSAPE;
          END IF;
        END IF;
      END LOOP;
    END;

    PROCEDURE proc_Llenar_OSF_SESUCIER(nuContrato IN NUMBER) IS
      sbIndex          VARCHAR2(54);
      nuConsecutivo    NUMBER := -9999999999;
      nuSaldoCorriente NUMBER := 0;
      nuSaldoDiferido  NUMBER := 0;
      nuSaldoTotal     NUMBER := 0;
    BEGIN
      --{
      proc_SaldoxProducto(nuContrato);

      gtblDatos_OSF_Sesucier.DELETE();

      FOR RegCon IN CurDatos_OSF_Sesucier(nuContrato) LOOP
        --{
        sbIndex := LPAD(RegCon.ANO, 4, '0') || LPAD(RegCon.MES, 2, '0') ||
                   LPAD(RegCon.CONTRATO, 8, '0') ||
                   LPAD(RegCon.PRODUCTO, 10, '0') ||
                   LPAD(nuConsecutivo, 15, '0') ||
                   LPAD(nuConsecutivo, 15, '0');

        gtblDatos_OSF_Sesucier(sbIndex) := RegCon;

        IF fnBuscarContrato(RegCon.CONTRATO, RegCon.MES, RegCon.ANO) <> 0 THEN
          NULL;
        ELSE
          -- El producto tiene financiaciones
          IF trcDataProductos.EXISTS(sbIndex) THEN
            NULL;
          ELSE
            -- Almacenamiento Datos Producto
            trcDataProductos(sbIndex).ANO := RegCon.ANO;
            trcDataProductos(sbIndex).MES := RegCon.MES;
            trcDataProductos(sbIndex).CONTRATO := RegCon.CONTRATO;
            trcDataProductos(sbIndex).PRODUCTO := RegCon.PRODUCTO;
            trcDataProductos(sbIndex).TIPO_PRODUCTO := RegCon.TIPO_PRODUCTO;
            trcDataProductos(sbIndex).DESC_TIPO_PRODUCTO := RegCon.DESC_TIPO_PRODUCTO;
            trcDataProductos(sbIndex).EDAD_DEUDA := RegCon.EDAD_DEUDA;
            trcDataProductos(sbIndex).ALTURA_MORA := RegCon.ALTURA_MORA;

            sbIndex_Productos := LPAD(RegCon.PRODUCTO, 10, '0') ||
                                 LPAD(TRUNC(RegCon.CICOFECH), 10, '0');

            IF trcProductos.EXISTS(sbIndex_Productos) THEN
              trcDataProductos(sbIndex).SALDO_CORRIENTE_NO_FINANCIADO := trcProductos(sbIndex_Productos).SALDO_CORRIENTE;
              trcDataProductos(sbIndex).SALDO_DIFERIDO := trcProductos(sbIndex_Productos).SALDO_DIFERIDO;
              trcDataProductos(sbIndex).SALDO_TOTAL := trcProductos(sbIndex_Productos).SALDO_TOTAL;
            ELSE
              trcDataProductos(sbIndex).SALDO_CORRIENTE_NO_FINANCIADO := 0;
              trcDataProductos(sbIndex).SALDO_DIFERIDO := 0;
              trcDataProductos(sbIndex).SALDO_TOTAL := 0;
            END IF;

            trcDataProductos(sbIndex).DEUDA_DIFERIDA_CORRIENTE := 0;
            trcDataProductos(sbIndex).DEUDA_CORRIENTE_VENCIDA := 0;
            trcDataProductos(sbIndex).DEUDA_CORRIENTE_NO_VENCIDA := 0;
            trcDataProductos(sbIndex).DEUDA_NO_CORRIENTE := 0;
            trcDataProductos(sbIndex).FECHA_ORIGINACION_PROD := RegCon.FECHA_ORIGINACION_PROD;
            trcDataProductos(sbIndex).CUPO := RegCon.CUPO;
            trcDataProductos(sbIndex).SCORE_O_PUNTAJE_FINAL := RegCon.SCORE_O_PUNTAJE_FINAL;
            trcDataProductos(sbIndex).CICLO := RegCon.CICLO;
            trcDataProductos(sbIndex).DEPARTAMENTO := RegCon.DEPARTAMENTO;
            trcDataProductos(sbIndex).LOCALIDAD := RegCon.LOCALIDAD;
            trcDataProductos(sbIndex).CATEGORIA := RegCon.CATEGORIA;
            trcDataProductos(sbIndex).DESC_CATEGORIA := RegCon.DESC_CATEGORIA;
            trcDataProductos(sbIndex).SUBCATEGORIA := RegCon.SUBCATEGORIA;
            trcDataProductos(sbIndex).DESCR_USO := RegCon.DESCR_USO;
            trcDataProductos(sbIndex).PEFACODI := RegCon.PEFACODI;
            trcDataProductos(sbIndex).CICOFEIN := RegCon.CICOFEIN;
            trcDataProductos(sbIndex).CICOFECH := RegCon.CICOFECH;
            trcDataProductos(sbIndex).CICOHOEJ := RegCon.CICOHOEJ;
            trcDataProductos(sbIndex).FINANCIACION := nuConsecutivo;
            trcDataProductos(sbIndex).IDDIFERIDO := nuConsecutivo;
            trcDataProductos(sbIndex).PLAN_FINANCIACION := NULL;
            trcDataProductos(sbIndex).DESC_PLAN := NULL;
            trcDataProductos(sbIndex).DIFENUDO := NULL;
            trcDataProductos(sbIndex).DIFEPROG := NULL;
            trcDataProductos(sbIndex).FECHA_ORIGINACION_FIN := NULL;
            trcDataProductos(sbIndex).FECHA_TERMINACION_FIN := NULL;
            trcDataProductos(sbIndex).PLAZO_ORIGINACION := NULL;
            trcDataProductos(sbIndex).CUOTAS_COBRADAS := NULL;
            trcDataProductos(sbIndex).SALDO_CAPITAL := NULL;
            trcDataProductos(sbIndex).TASA_INTERES := NULL;
            -- Campos a Calcular
            trcDataProductos(sbIndex).CODEUDOR := 0;
            trcDataProductos(sbIndex).ESTADO_CUENTA := -1;
            trcDataProductos(sbIndex).CUENTA_COBRO := -1;
            trcDataProductos(sbIndex).FECHA_PAGO := NULL;
            trcDataProductos(sbIndex).VALOR_PAGO := 0;
            trcDataProductos(sbIndex).FECHA_ULTIMO_MOV := NULL;
            trcDataProductos(sbIndex).CUOTAS_PAGADAS := 0;
            trcDataProductos(sbIndex).SALDO_INTERES := 0;
            trcDataProductos(sbIndex).SALDO_INTERES_MORA := 0;
            trcDataProductos(sbIndex).SALDOCTEFINANCIADO := 0;
            trcDataProductos(sbIndex).SALDOCTENOFINANCIADO := 0;
            trcDataProductos(sbIndex).FECHA_CIERRE := RegCon.CICOFECH;
            trcDataProductos(sbIndex).MES1 := NULL;
            trcDataProductos(sbIndex).MES2 := NULL;
            trcDataProductos(sbIndex).MES3 := NULL;
            trcDataProductos(sbIndex).MES4 := NULL;
            trcDataProductos(sbIndex).MES5 := NULL;
            trcDataProductos(sbIndex).MES6 := NULL;
            trcDataProductos(sbIndex).MES7 := NULL;
            trcDataProductos(sbIndex).MES8 := NULL;
            trcDataProductos(sbIndex).MES9 := NULL;
            trcDataProductos(sbIndex).MES10 := NULL;
            trcDataProductos(sbIndex).MES11 := NULL;
            trcDataProductos(sbIndex).MES12 := NULL;
            trcDataProductos(sbIndex).MES13 := NULL;
            trcDataProductos(sbIndex).MES14 := NULL;
            trcDataProductos(sbIndex).MES15 := NULL;
            trcDataProductos(sbIndex).MES16 := NULL;
            trcDataProductos(sbIndex).MES17 := NULL;
            trcDataProductos(sbIndex).MES18 := NULL;
            trcDataProductos(sbIndex).MES19 := NULL;
            trcDataProductos(sbIndex).MES20 := NULL;
            trcDataProductos(sbIndex).FECHA_CASTIGO := NULL;
            trcDataProductos(sbIndex).VALOR_CASTIGADO := 0;
          END IF;
        END IF;
        --}
      END LOOP;
      --}
    END;

    PROCEDURE proc_Llenar_OSF_DIFERIDO(nuContrato IN NUMBER) IS
      sbIndex         VARCHAR2(54);
      nuConsecutivo   NUMBER := -9999999999;
      sbIndexTemporal VARCHAR2(54);
    BEGIN
      gtblDatos_OSF_Diferidos.DELETE();

      FOR RegCon IN CurDatos_OSF_Diferidos(nuContrato) LOOP
        sbIndex := LPAD(RegCon.DifeAno, 4, '0') ||
                   LPAD(RegCon.DifeMes, 2, '0') ||
                   LPAD(RegCon.Difesusc, 8, '0') ||
                   LPAD(RegCon.Difenuse, 10, '0') ||
                   LPAD(RegCon.Financiacion, 15, '0') ||
                   LPAD(RegCon.IDDiferido, 15, '0');

        sbIndexTemporal := LPAD(RegCon.DifeAno, 4, '0') ||
                           LPAD(RegCon.DifeMes, 2, '0') ||
                           LPAD(RegCon.Difesusc, 8, '0') ||
                           LPAD(RegCon.Difenuse, 10, '0') ||
                           LPAD(nuConsecutivo, 15, '0') ||
                           LPAD(nuConsecutivo, 15, '0');

        gtblDatos_OSF_Diferidos(sbIndex) := RegCon;

        IF trcDataProductos.EXISTS(sbIndex) THEN
          NULL;
        ELSE
          IF trcDataProductos.EXISTS(sbIndexTemporal) THEN
            -- Almacenamiento Datos Producto
            trcDataProductos(sbIndex).ANO := trcDataProductos(sbIndexTemporal).ANO;
            trcDataProductos(sbIndex).MES := trcDataProductos(sbIndexTemporal).MES;
            trcDataProductos(sbIndex).CONTRATO := trcDataProductos(sbIndexTemporal).CONTRATO;
            trcDataProductos(sbIndex).PRODUCTO := trcDataProductos(sbIndexTemporal).PRODUCTO;
            trcDataProductos(sbIndex).TIPO_PRODUCTO := trcDataProductos(sbIndexTemporal).TIPO_PRODUCTO;
            trcDataProductos(sbIndex).DESC_TIPO_PRODUCTO := trcDataProductos(sbIndexTemporal).DESC_TIPO_PRODUCTO;
            trcDataProductos(sbIndex).EDAD_DEUDA := trcDataProductos(sbIndexTemporal).EDAD_DEUDA;
            trcDataProductos(sbIndex).ALTURA_MORA := trcDataProductos(sbIndexTemporal).ALTURA_MORA;
            trcDataProductos(sbIndex).SALDO_CORRIENTE_NO_FINANCIADO := 0;
            trcDataProductos(sbIndex).SALDO_DIFERIDO := 0;
            trcDataProductos(sbIndex).SALDO_TOTAL := 0;
            trcDataProductos(sbIndex).DEUDA_DIFERIDA_CORRIENTE := 0;
            trcDataProductos(sbIndex).DEUDA_CORRIENTE_VENCIDA := 0;
            trcDataProductos(sbIndex).DEUDA_CORRIENTE_NO_VENCIDA := 0;
            trcDataProductos(sbIndex).DEUDA_NO_CORRIENTE := 0;
            trcDataProductos(sbIndex).FECHA_ORIGINACION_PROD := trcDataProductos(sbIndexTemporal).FECHA_ORIGINACION_PROD;
            trcDataProductos(sbIndex).CUPO := trcDataProductos(sbIndexTemporal).CUPO;
            trcDataProductos(sbIndex).SCORE_O_PUNTAJE_FINAL := trcDataProductos(sbIndexTemporal).SCORE_O_PUNTAJE_FINAL;
            trcDataProductos(sbIndex).CICLO := trcDataProductos(sbIndexTemporal).CICLO;
            trcDataProductos(sbIndex).DEPARTAMENTO := trcDataProductos(sbIndexTemporal).DEPARTAMENTO;
            trcDataProductos(sbIndex).LOCALIDAD := trcDataProductos(sbIndexTemporal).LOCALIDAD;
            trcDataProductos(sbIndex).CATEGORIA := trcDataProductos(sbIndexTemporal).CATEGORIA;
            trcDataProductos(sbIndex).DESC_CATEGORIA := trcDataProductos(sbIndexTemporal).DESC_CATEGORIA;
            trcDataProductos(sbIndex).SUBCATEGORIA := trcDataProductos(sbIndexTemporal).SUBCATEGORIA;
            trcDataProductos(sbIndex).DESCR_USO := trcDataProductos(sbIndexTemporal).DESCR_USO;
            trcDataProductos(sbIndex).PEFACODI := trcDataProductos(sbIndexTemporal).PEFACODI;
            trcDataProductos(sbIndex).CICOFEIN := trcDataProductos(sbIndexTemporal).CICOFEIN;
            trcDataProductos(sbIndex).CICOFECH := trcDataProductos(sbIndexTemporal).CICOFECH;
            trcDataProductos(sbIndex).CICOHOEJ := trcDataProductos(sbIndexTemporal).CICOHOEJ;
            -- Datos Diferido
            trcDataProductos(sbIndex).ANHO := RegCon.DIFEANO;
            trcDataProductos(sbIndex).MES_ := RegCon.DIFEMES;
            trcDataProductos(sbIndex).DIFESUSC := RegCon.DIFESUSC;
            trcDataProductos(sbIndex).DIFENUSE := RegCon.DIFENUSE;
            trcDataProductos(sbIndex).FINANCIACION := RegCon.FINANCIACION;
            trcDataProductos(sbIndex).IDDIFERIDO := RegCon.IDDIFERIDO;
            trcDataProductos(sbIndex).PLAN_FINANCIACION := RegCon.PLAN_FINANCIACION;
            trcDataProductos(sbIndex).DESC_PLAN := RegCon.DESC_PLAN;
            trcDataProductos(sbIndex).DIFENUDO := RegCon.DIFENUDO;
            trcDataProductos(sbIndex).DIFEPROG := RegCon.DIFEPROG;
            trcDataProductos(sbIndex).FECHA_ORIGINACION_FIN := RegCon.FECHA_ORIGINACION_FIN;
            trcDataProductos(sbIndex).FECHA_TERMINACION_FIN := RegCon.FECHA_TERMINACION_FIN;
            trcDataProductos(sbIndex).PLAZO_ORIGINACION := RegCon.PLAZO_ORIGINACION;
            trcDataProductos(sbIndex).CUOTAS_COBRADAS := RegCon.CUOTAS_COBRADAS;
            trcDataProductos(sbIndex).SALDO_CAPITAL := RegCon.SALDO_CAPITAL;
            trcDataProductos(sbIndex).TASA_INTERES := RegCon.TASA_INTERES;
            -- Campos a Calcular
            trcDataProductos(sbIndex).CODEUDOR := 0;
            trcDataProductos(sbIndex).ESTADO_CUENTA := -1;
            trcDataProductos(sbIndex).CUENTA_COBRO := -1;
            trcDataProductos(sbIndex).FECHA_PAGO := NULL;
            trcDataProductos(sbIndex).VALOR_PAGO := 0;
            trcDataProductos(sbIndex).FECHA_ULTIMO_MOV := NULL;
            trcDataProductos(sbIndex).CUOTAS_PAGADAS := 0;
            trcDataProductos(sbIndex).SALDO_INTERES := 0;
            trcDataProductos(sbIndex).SALDO_INTERES_MORA := 0;
            trcDataProductos(sbIndex).SALDOCTEFINANCIADO := 0;
            trcDataProductos(sbIndex).SALDOCTENOFINANCIADO := 0;
            trcDataProductos(sbIndex).FECHA_CIERRE := trcDataProductos(sbIndexTemporal).CICOFECH;
            trcDataProductos(sbIndex).MES1 := NULL;
            trcDataProductos(sbIndex).MES2 := NULL;
            trcDataProductos(sbIndex).MES3 := NULL;
            trcDataProductos(sbIndex).MES4 := NULL;
            trcDataProductos(sbIndex).MES5 := NULL;
            trcDataProductos(sbIndex).MES6 := NULL;
            trcDataProductos(sbIndex).MES7 := NULL;
            trcDataProductos(sbIndex).MES8 := NULL;
            trcDataProductos(sbIndex).MES9 := NULL;
            trcDataProductos(sbIndex).MES10 := NULL;
            trcDataProductos(sbIndex).MES11 := NULL;
            trcDataProductos(sbIndex).MES12 := NULL;
            trcDataProductos(sbIndex).MES13 := NULL;
            trcDataProductos(sbIndex).MES14 := NULL;
            trcDataProductos(sbIndex).MES15 := NULL;
            trcDataProductos(sbIndex).MES16 := NULL;
            trcDataProductos(sbIndex).MES17 := NULL;
            trcDataProductos(sbIndex).MES18 := NULL;
            trcDataProductos(sbIndex).MES19 := NULL;
            trcDataProductos(sbIndex).MES20 := NULL;
            trcDataProductos(sbIndex).FECHA_CASTIGO := NULL;
            trcDataProductos(sbIndex).VALOR_CASTIGADO := 0;
          ELSE
            NULL;
          END IF;
        END IF;
      END LOOP;
    END;

    PROCEDURE proc_Llenar_Facturacion(nuContrato IN NUMBER) IS
      sbIndex VARCHAR2(200);
    BEGIN
      gtblDatos_Facturacion.DELETE();

      -- Abre CURSOR
      OPEN curDatos_Facturacion(nuContrato);

      --  Recupera registros
      FETCH curDatos_Facturacion BULK COLLECT
        INTO gtblDatos_Facturacion;

      -- Cierra cursor
      CLOSE curDatos_Facturacion;
    END;

    PROCEDURE proc_Llenar_Diferidos(nuContrato IN NUMBER) IS
      sbIndex VARCHAR2(33);
    BEGIN
      gtblDatos_Diferido.DELETE();

      FOR RegCon IN CurDatos_Diferido(nuContrato) LOOP
        sbIndex := LPAD(RegCon.DIFECOFI, 15, '0') ||
                   LPAD(RegCon.DIFESUSC, 8, '0') ||
                   LPAD(RegCon.DIFENUSE, 10, '0');
        gtblDatos_Diferido(sbIndex) := RegCon;
      END LOOP;
    END;

    PROCEDURE proc_Llenar_Mov_Diferidos(nuContrato IN NUMBER) IS
      sbIndex VARCHAR2(61);
    BEGIN
      gtblDatos_Mov_Diferido.DELETE();

      FOR RegCon IN CurDatos_Mov_Diferido(nuContrato) LOOP
        sbIndex := LPAD(RegCon.Modidife, 15, '0') ||
                   LPAD(RegCon.Modisusc, 8, '0') ||
                   LPAD(RegCon.Modinuse, 10, '0') ||
                   LPAD(RegCon.ModiCuap, 4, '0') ||
                   LPAD(RegCon.Modifech, 24, '0');
        gtblDatos_Mov_Diferido(sbIndex) := RegCon;
      END LOOP;
    END;

    PROCEDURE proc_Llenar_Pagos(nuContrato IN NUMBER) IS
      nuIndex VARCHAR2(12);
    BEGIN
      gtblDatos_Pagos.DELETE();

      FOR RegCon IN CurDatos_Pagos(nuContrato) LOOP
        nuIndex := RegCon.PagoCupo;
        gtblDatos_Pagos(nuIndex) := RegCon;
      END LOOP;
    END;

    PROCEDURE proc_Actualizar_Cuotas_Pagadas(nuContrato IN NUMBER) IS
      sbIndexMovFact  VARCHAR2(200);
      sbIndexDataCont VARCHAR2(54);
    BEGIN
      sbIndexDataCont := trcDataProductos.FIRST;

      LOOP
        --{
        EXIT WHEN sbIndexDataCont IS NULL;
        sbIndexMovFact := gtblDatos_Facturacion.FIRST;

        LOOP
          --{
          EXIT WHEN sbIndexMovFact IS NULL;

          IF SUBSTR(gtblDatos_Facturacion(sbIndexMovFact).CARGDOSO, 1, 3) =
             'DF-' THEN
            IF (SUBSTR(gtblDatos_Facturacion(sbIndexMovFact).CARGDOSO,
                       4,
                       20) = trcDataProductos(sbIndexDataCont).IDDIFERIDO AND gtblDatos_Facturacion(sbIndexMovFact).CUCOFEPA <= trcDataProductos(sbIndexDataCont).CICOFECH AND
               NVL(gtblDatos_Facturacion(sbIndexMovFact).CUCOSACU, 0) = 0) THEN
              IF trcDataProductos(sbIndexDataCont).CUOTAS_PAGADAS IS NULL THEN
                trcDataProductos(sbIndexDataCont).CUOTAS_PAGADAS := 1;
              ELSE
                IF trcDataProductos.EXISTS(sbIndexDataCont) THEN
                  trcDataProductos(sbIndexDataCont).CUOTAS_PAGADAS := trcDataProductos(sbIndexDataCont).CUOTAS_PAGADAS + 1;
                ELSE
                  trcDataProductos(sbIndexDataCont).CUOTAS_PAGADAS := trcDataProductos(sbIndexDataCont).CUOTAS_PAGADAS + 1;
                END IF;
              END IF;
            END IF;
          END IF;

          -- Incrementa indice
          sbIndexMovFact := gtblDatos_Facturacion.NEXT(sbIndexMovFact);
          --}
        END LOOP;

        -- Incrementa indice
        sbIndexDataCont := trcDataProductos.NEXT(sbIndexDataCont);
        --}
      END LOOP;
    END;

    PROCEDURE proc_Actualizar_Ultimo_Mov(nuContrato IN NUMBER) IS
      sbIndexMovDife  VARCHAR2(61);
      sbIndexDataCont VARCHAR2(54);
    BEGIN
      sbIndexDataCont := trcDataProductos.FIRST;

      LOOP
        EXIT WHEN sbIndexDataCont IS NULL;
        sbIndexMovDife := gtblDatos_Mov_Diferido.FIRST;

        LOOP
          EXIT WHEN sbIndexMovDife IS NULL;

          IF gtblDatos_Mov_Diferido(sbIndexMovDife).MODIDIFE = trcDataProductos(sbIndexDataCont).IDDIFERIDO THEN
            IF gtblDatos_Mov_Diferido(sbIndexMovDife).MODIFECH <= trcDataProductos(sbIndexDataCont).CICOFECH THEN
              IF trcDataProductos(sbIndexDataCont).FECHA_ULTIMO_MOV IS NULL THEN
                trcDataProductos(sbIndexDataCont).FECHA_ULTIMO_MOV := gtblDatos_Mov_Diferido(sbIndexMovDife).MODIFECH;
              ELSE
                IF trcDataProductos(sbIndexDataCont).FECHA_ULTIMO_MOV < gtblDatos_Mov_Diferido(sbIndexMovDife).MODIFECH THEN
                  trcDataProductos(sbIndexDataCont).FECHA_ULTIMO_MOV := gtblDatos_Mov_Diferido(sbIndexMovDife).MODIFECH;
                END IF;
              END IF;
            END IF;
          END IF;

          -- Incrementa indice
          sbIndexMovDife := gtblDatos_Mov_Diferido.NEXT(sbIndexMovDife);
        END LOOP;

        -- Incrementa indice
        sbIndexDataCont := trcDataProductos.NEXT(sbIndexDataCont);
      END LOOP;
    END;

    PROCEDURE proc_Actualizar_Intereses(nuContrato IN NUMBER) IS
      sbIndexMovFact  VARCHAR2(200);
      sbIndexDataCont VARCHAR2(54);
    BEGIN
      sbIndexDataCont := trcDataProductos.FIRST;

      LOOP
        EXIT WHEN sbIndexDataCont IS NULL;
        sbIndexMovFact := gtblDatos_Facturacion.FIRST;

        LOOP
          EXIT WHEN sbIndexMovFact IS NULL;

          IF SUBSTR(gtblDatos_Facturacion(sbIndexMovFact).CARGDOSO, 1, 3) =
             'ID-' THEN
            IF (SUBSTR(gtblDatos_Facturacion(sbIndexMovFact).CARGDOSO,
                       4,
                       20) = trcDataProductos(sbIndexDataCont).IDDIFERIDO AND gtblDatos_Facturacion(sbIndexMovFact).CUCOFEPA <= trcDataProductos(sbIndexDataCont).CICOFECH AND gtblDatos_Facturacion(sbIndexMovFact).CARGCACA = 51) THEN
              IF trcDataProductos(sbIndexDataCont).SALDO_INTERES = 0 THEN
                trcDataProductos(sbIndexDataCont).SALDO_INTERES := gtblDatos_Facturacion(sbIndexMovFact).CARGVALO;
              ELSE
                IF trcDataProductos.EXISTS(sbIndexDataCont) THEN
                  trcDataProductos(sbIndexDataCont).SALDO_INTERES := trcDataProductos(sbIndexDataCont).SALDO_INTERES + gtblDatos_Facturacion(sbIndexMovFact).CARGVALO;
                ELSE
                  trcDataProductos(sbIndexDataCont).SALDO_INTERES := gtblDatos_Facturacion(sbIndexMovFact).CARGVALO;
                END IF;
              END IF;
            END IF;
          END IF;

          -- Incrementa indice
          sbIndexMovFact := gtblDatos_Facturacion.NEXT(sbIndexMovFact);
        END LOOP;

        -- Incrementa indice
        sbIndexDataCont := trcDataProductos.NEXT(sbIndexDataCont);
      END LOOP;
    END;

    PROCEDURE proc_Actualizar_Interes_Mora(nuContrato IN NUMBER) IS
      sbIndexMovFact  VARCHAR2(200);
      sbIndexDataCont VARCHAR2(54);
    BEGIN
      sbIndexDataCont := trcDataProductos.FIRST;

      LOOP
        EXIT WHEN sbIndexDataCont IS NULL;
        sbIndexMovFact := gtblDatos_Facturacion.FIRST;

        LOOP
          EXIT WHEN sbIndexMovFact IS NULL;

          IF SUBSTR(gtblDatos_Facturacion(sbIndexMovFact).CARGDOSO, 1, 3) =
             'ID-' THEN
            IF (SUBSTR(gtblDatos_Facturacion(sbIndexMovFact).CARGDOSO,
                       4,
                       20) = trcDataProductos(sbIndexDataCont).IDDIFERIDO AND gtblDatos_Facturacion(sbIndexMovFact).CUCOFEPA >= trcDataProductos(sbIndexDataCont).CICOFECH AND gtblDatos_Facturacion(sbIndexMovFact).CARGFECR < trcDataProductos(sbIndexDataCont).CICOFECH AND gtblDatos_Facturacion(sbIndexMovFact).CARGCACA = 51 AND gtblDatos_Facturacion(sbIndexMovFact).CONCTICL = 5) THEN
              IF trcDataProductos(sbIndexDataCont).SALDO_INTERES_MORA = 0 THEN
                trcDataProductos(sbIndexDataCont).SALDO_INTERES_MORA := gtblDatos_Facturacion(sbIndexMovFact).CARGVALO;
              ELSE
                IF trcDataProductos.EXISTS(sbIndexDataCont) THEN
                  trcDataProductos(sbIndexDataCont).SALDO_INTERES_MORA := trcDataProductos(sbIndexDataCont).SALDO_INTERES_MORA + gtblDatos_Facturacion(sbIndexMovFact).CARGVALO;
                ELSE
                  trcDataProductos(sbIndexDataCont).SALDO_INTERES_MORA := gtblDatos_Facturacion(sbIndexMovFact).CARGVALO;
                END IF;
              END IF;
            END IF;
          END IF;

          -- Incrementa indice
          sbIndexMovFact := gtblDatos_Facturacion.NEXT(sbIndexMovFact);
        END LOOP;

        -- Incrementa indice
        sbIndexDataCont := trcDataProductos.NEXT(sbIndexDataCont);
      END LOOP;
    END;

    PROCEDURE proc_Actualizar_Saldo(nuContrato IN NUMBER) IS
      sbIndexMovFact  VARCHAR2(200);
      sbIndexDataCont VARCHAR2(54);
      sbIndexTemporal VARCHAR2(54);
      nuConseCutivo   NUMBER := -9999999999;
    BEGIN
      sbIndexDataCont := trcDataProductos.FIRST;

      LOOP
        EXIT WHEN sbIndexDataCont IS NULL;
        sbIndexMovFact := gtblDatos_Facturacion.FIRST;

        LOOP
          EXIT WHEN sbIndexMovFact IS NULL;
          sbIndexTemporal := LPAD(trcDataProductos(sbIndexDataCont).ANO,
                                  4,
                                  '0') || LPAD(trcDataProductos(sbIndexDataCont).MES,
                                               2,
                                               '0') ||
                             LPAD(trcDataProductos(sbIndexDataCont).CONTRATO,
                                  8,
                                  '0') || LPAD(trcDataProductos(sbIndexDataCont).PRODUCTO,
                                               10,
                                               '0') ||
                             LPAD(nuConsecutivo, 15, '0') ||
                             LPAD(nuConsecutivo, 15, '0');

          -- Valores Facturados
          IF gtblDatos_Facturacion(sbIndexMovFact).CARGPEFA = trcDataProductos(sbIndexDataCont).PEFACODI THEN
            -- Se evaluan los diferidos
            IF sbIndexDataCont <> sbIndexTemporal THEN
              -- Valores Financiados del Mes
              IF (gtblDatos_Facturacion(sbIndexMovFact)
                 .CARGCACA = 51 AND
                  SUBSTR(gtblDatos_Facturacion(sbIndexMovFact).CARGDOSO,
                         1,
                         3) IN ('DF-', 'ID-')) THEN
                IF trcDataProductos.EXISTS(sbIndexDataCont) THEN
                  IF trcDataProductos(sbIndexDataCont)
                   .IDDIFERIDO = SUBSTR(gtblDatos_Facturacion(sbIndexMovFact).CARGDOSO,
                                          4,
                                          20) THEN
                    trcDataProductos(sbIndexDataCont).SALDOCTEFINANCIADO := trcDataProductos(sbIndexDataCont).SALDOCTEFINANCIADO + gtblDatos_Facturacion(sbIndexMovFact).CARGVALO;
                    trcDataProductos(sbIndexDataCont).ESTADO_CUENTA := gtblDatos_Facturacion(sbIndexMovFact).FACTCODI;
                    trcDataProductos(sbIndexDataCont).CUENTA_COBRO := gtblDatos_Facturacion(sbIndexMovFact).CUCOCODI;
                  ELSE
                    IF trcDataProductos(sbIndexDataCont)
                     .IDDIFERIDO = SUBSTR(gtblDatos_Facturacion(sbIndexMovFact).CARGDOSO,
                                            4,
                                            20) THEN
                      trcDataProductos(sbIndexDataCont).SALDOCTEFINANCIADO := gtblDatos_Facturacion(sbIndexMovFact).CARGVALO;
                      trcDataProductos(sbIndexDataCont).ESTADO_CUENTA := gtblDatos_Facturacion(sbIndexMovFact).FACTCODI;
                      trcDataProductos(sbIndexDataCont).CUENTA_COBRO := gtblDatos_Facturacion(sbIndexMovFact).CUCOCODI;
                    END IF;
                  END IF;
                END IF;
              END IF;
            ELSE
              IF (gtblDatos_Facturacion(sbIndexMovFact)
                 .CARGCACA IN (4, 15) AND
                  SUBSTR(gtblDatos_Facturacion(sbIndexMovFact).CARGDOSO,
                         1,
                         3) NOT IN ('DF-', 'ID-')) THEN
                sbIndexTemporal := LPAD(trcDataProductos(sbIndexDataCont).ANO,
                                        4,
                                        '0') || LPAD(trcDataProductos(sbIndexDataCont).MES,
                                                     2,
                                                     '0') ||
                                   LPAD(trcDataProductos(sbIndexDataCont).CONTRATO,
                                        8,
                                        '0') || LPAD(trcDataProductos(sbIndexDataCont).PRODUCTO,
                                                     10,
                                                     '0') ||
                                   LPAD(nuConsecutivo, 15, '0') ||
                                   LPAD(nuConsecutivo, 15, '0');

                IF trcDataProductos.EXISTS(sbIndexTemporal) THEN
                  IF trcDataProductos(sbIndexTemporal).PRODUCTO = gtblDatos_Facturacion(sbIndexMovFact).CUCONUSE THEN
                    trcDataProductos(sbIndexTemporal).SALDOCTENOFINANCIADO := trcDataProductos(sbIndexTemporal).SALDOCTENOFINANCIADO + gtblDatos_Facturacion(sbIndexMovFact).CARGVALO;
                    trcDataProductos(sbIndexTemporal).ESTADO_CUENTA := gtblDatos_Facturacion(sbIndexMovFact).FACTCODI;
                    trcDataProductos(sbIndexTemporal).CUENTA_COBRO := gtblDatos_Facturacion(sbIndexMovFact).CUCOCODI;
                  END IF;
                ELSE
                  IF trcDataProductos(sbIndexTemporal).PRODUCTO = gtblDatos_Facturacion(sbIndexMovFact).CUCONUSE THEN
                    trcDataProductos(sbIndexTemporal).SALDOCTENOFINANCIADO := gtblDatos_Facturacion(sbIndexMovFact).CARGVALO;
                    trcDataProductos(sbIndexTemporal).ESTADO_CUENTA := gtblDatos_Facturacion(sbIndexMovFact).FACTCODI;
                    trcDataProductos(sbIndexTemporal).CUENTA_COBRO := gtblDatos_Facturacion(sbIndexMovFact).CUCOCODI;
                  END IF;
                END IF;
              END IF;
            END IF;
          END IF;

          -- Incrementa indice
          sbIndexMovFact := gtblDatos_Facturacion.NEXT(sbIndexMovFact);
        END LOOP;

        -- Incrementa indice
        sbIndexDataCont := trcDataProductos.NEXT(sbIndexDataCont);
      END LOOP;
    END;

    PROCEDURE proc_Actualizar_Castigo(nuContrato IN NUMBER) IS
      sbIndexMovFact  VARCHAR2(200);
      sbIndexDataCont VARCHAR2(54);
      sbIndexTemporal VARCHAR2(54);
      nuConseCutivo   NUMBER := -9999999999;
    BEGIN
      sbIndexDataCont := trcDataProductos.FIRST;

      LOOP
        EXIT WHEN sbIndexDataCont IS NULL;
        sbIndexMovFact := gtblDatos_Facturacion.FIRST;

        LOOP
          EXIT WHEN sbIndexMovFact IS NULL;
          sbIndexTemporal := LPAD(trcDataProductos(sbIndexDataCont).ANO,
                                  4,
                                  '0') || LPAD(trcDataProductos(sbIndexDataCont).MES,
                                               2,
                                               '0') ||
                             LPAD(trcDataProductos(sbIndexDataCont).CONTRATO,
                                  8,
                                  '0') || LPAD(trcDataProductos(sbIndexDataCont).PRODUCTO,
                                               10,
                                               '0') ||
                             LPAD(nuConsecutivo, 15, '0') ||
                             LPAD(nuConsecutivo, 15, '0');

          -- Valores Castigados
          IF (gtblDatos_Facturacion(sbIndexMovFact).CARGCACA = 2 AND gtblDatos_Facturacion(sbIndexMovFact).CARGFECR >= trcDataProductos(sbIndexDataCont).CICOFEIN AND gtblDatos_Facturacion(sbIndexMovFact).CARGFECR <= trcDataProductos(sbIndexDataCont).CICOFECH AND gtblDatos_Facturacion(sbIndexMovFact).cuconuse = trcDataProductos(sbIndexDataCont).PRODUCTO) THEN
            -- Se evaluan los Valores Castigados
            IF sbIndexDataCont = sbIndexTemporal THEN
              IF trcDataProductos(sbIndexDataCont).VALOR_CASTIGADO = 0 THEN
                trcDataProductos(sbIndexDataCont).VALOR_CASTIGADO := gtblDatos_Facturacion(sbIndexMovFact).CARGVALO;
                trcDataProductos(sbIndexDataCont).FECHA_CASTIGO := TRUNC(gtblDatos_Facturacion(sbIndexMovFact).CARGFECR);
              ELSE
                IF trcDataProductos.EXISTS(sbIndexDataCont) THEN
                  trcDataProductos(sbIndexDataCont).VALOR_CASTIGADO := trcDataProductos(sbIndexDataCont).VALOR_CASTIGADO + gtblDatos_Facturacion(sbIndexMovFact).CARGVALO;
                  trcDataProductos(sbIndexDataCont).FECHA_CASTIGO := TRUNC(gtblDatos_Facturacion(sbIndexMovFact).CARGFECR);
                ELSE
                  trcDataProductos(sbIndexDataCont).VALOR_CASTIGADO := gtblDatos_Facturacion(sbIndexMovFact).CARGVALO;
                  trcDataProductos(sbIndexDataCont).FECHA_CASTIGO := TRUNC(gtblDatos_Facturacion(sbIndexMovFact).CARGFECR);
                END IF;
              END IF;
            END IF;
          END IF;

          -- Incrementa indice
          sbIndexMovFact := gtblDatos_Facturacion.NEXT(sbIndexMovFact);
        END LOOP;

        -- Incrementa indice
        sbIndexDataCont := trcDataProductos.NEXT(sbIndexDataCont);
      END LOOP;
    END;

    PROCEDURE proc_Actualizar_Pagos(nuContrato IN NUMBER) IS
      sbIndexMovFact  VARCHAR2(200);
      sbIndexDataCont VARCHAR2(54);
      sbIndexTemporal VARCHAR2(54);
      nuConseCutivo   NUMBER := -9999999999;
    BEGIN
      sbIndexDataCont := trcDataProductos.FIRST;

      LOOP
        EXIT WHEN sbIndexDataCont IS NULL;
        sbIndexMovFact := gtblDatos_Facturacion.FIRST;

        LOOP
          EXIT WHEN sbIndexMovFact IS NULL;
          sbIndexTemporal := LPAD(trcDataProductos(sbIndexDataCont).ANO,
                                  4,
                                  '0') || LPAD(trcDataProductos(sbIndexDataCont).MES,
                                               2,
                                               '0') ||
                             LPAD(trcDataProductos(sbIndexDataCont).CONTRATO,
                                  8,
                                  '0') || LPAD(trcDataProductos(sbIndexDataCont).PRODUCTO,
                                               10,
                                               '0') ||
                             LPAD(nuConsecutivo, 15, '0') ||
                             LPAD(nuConsecutivo, 15, '0');

          -- Valores Cancelados por Pago
          IF (gtblDatos_Facturacion(sbIndexMovFact).CARGSIGN = 'PA' AND gtblDatos_Facturacion(sbIndexMovFact).CARGCODO > 0 AND gtblDatos_Facturacion(sbIndexMovFact).CARGFECR >= trcDataProductos(sbIndexDataCont).CICOFEIN AND gtblDatos_Facturacion(sbIndexMovFact).CARGFECR <= trcDataProductos(sbIndexDataCont).CICOFECH) THEN
            -- Se Valores Cancelados por Pago
            IF sbIndexDataCont = sbIndexTemporal THEN
              IF trcDataProductos(sbIndexDataCont).VALOR_PAGO = 0 THEN
                trcDataProductos(sbIndexDataCont).VALOR_PAGO := ABS(gtblDatos_Facturacion(sbIndexMovFact).CARGVALO);
                trcDataProductos(sbIndexDataCont).FECHA_PAGO := gtblDatos_Facturacion(sbIndexMovFact).CARGFECR;
              ELSE
                IF trcDataProductos.EXISTS(sbIndexDataCont) THEN
                  trcDataProductos(sbIndexDataCont).VALOR_PAGO := trcDataProductos(sbIndexDataCont).VALOR_PAGO +
                                                                   ABS(gtblDatos_Facturacion(sbIndexMovFact).CARGVALO);
                  trcDataProductos(sbIndexDataCont).FECHA_PAGO := gtblDatos_Facturacion(sbIndexMovFact).CARGFECR;
                ELSE
                  trcDataProductos(sbIndexDataCont).VALOR_PAGO := ABS(gtblDatos_Facturacion(sbIndexMovFact).CARGVALO);
                  trcDataProductos(sbIndexDataCont).FECHA_PAGO := gtblDatos_Facturacion(sbIndexMovFact).CARGFECR;
                END IF;
              END IF;
            END IF;
          END IF;

          -- Incrementa indice
          sbIndexMovFact := gtblDatos_Facturacion.NEXT(sbIndexMovFact);
        END LOOP;

        -- Incrementa indice
        sbIndexDataCont := trcDataProductos.NEXT(sbIndexDataCont);
      END LOOP;
    END;

    PROCEDURE proc_Actualizar_Pivot(nuContrato IN NUMBER) IS
      D1              NUMBER;
      D2              NUMBER;
      D3              NUMBER;
      D4              NUMBER;
      D5              NUMBER;
      D6              NUMBER;
      D7              NUMBER;
      D8              NUMBER;
      D9              NUMBER;
      D10             NUMBER;
      D11             NUMBER;
      D12             NUMBER;
      D13             NUMBER;
      D14             NUMBER;
      D15             NUMBER;
      D16             NUMBER;
      D17             NUMBER;
      D18             NUMBER;
      D19             NUMBER;
      D20             NUMBER;
      sbIndexDiferido VARCHAR2(33);
      sbIndexDataCont VARCHAR2(54);

      CURSOR cuHerenciaRefinanciaciones(inuIdFinanciacion IN CC_FINANCING_REQUEST.FINANCING_ID%TYPE,
                                        inuIdContrato     IN DIFERIDO.DIFESUSC%TYPE) IS
        SELECT FINANC."1",
               FINANC."2",
               FINANC."3",
               FINANC."4",
               FINANC."5",
               FINANC."6",
               FINANC."7",
               FINANC."8",
               FINANC."9",
               FINANC."10",
               FINANC."11",
               FINANC."12",
               FINANC."13",
               FINANC."14",
               FINANC."15",
               FINANC."16",
               FINANC."17",
               FINANC."18",
               FINANC."19",
               FINANC."20"
          FROM (SELECT INUIDFINANCIACION FINANCIACION FROM DUAL) A
          LEFT JOIN (SELECT *
                       FROM (SELECT ROW_NUMBER() OVER(PARTITION BY FINANCING_ID ORDER BY DIFECOFI) NUM,
                                    FINANCING_ID,
                                    DIFECOFI,
                                    DOCUMENT_SUPPORT
                               FROM (SELECT /*+ ordered use_nl(FR, M, DN, DNP, D, DF1) */
                                     DISTINCT FINANCING_ID,
                                              DF1.DIFECOFI,
                                              DOCUMENT_SUPPORT
                                       FROM CC_FINANCING_REQUEST FR,
                                            MO_PACKAGES          M,
                                            GC_DEBT_NEGOTIATION  DN,
                                            GC_DEBT_NEGOT_PROD   DNP,
                                            GC_DEBT_NEGOT_CHARGE D,
                                            DIFERIDO             DF1
                                      WHERE FR.SUBSCRIPTION_ID = INUIDCONTRATO
                                        AND M.PACKAGE_ID = FR.PACKAGE_ID
                                        AND M.MOTIVE_STATUS_ID = 14
                                        AND DN.PACKAGE_ID = FR.PACKAGE_ID
                                        AND DNP.DEBT_NEGOTIATION_ID =
                                            DN.DEBT_NEGOTIATION_ID
                                        AND D.DEBT_NEGOT_PROD_ID =
                                            DNP.DEBT_NEGOT_PROD_ID
                                        AND DF1.DIFESUSC = FR.SUBSCRIPTION_ID
                                        AND DNP.SESUNUSE = DF1.DIFENUSE
                                        AND ('DF-' || DF1.DIFECODI =
                                            SUPPORT_DOCUMENT OR
                                            'IF-' || DF1.DIFECODI =
                                            SUPPORT_DOCUMENT)
                                      ORDER BY FINANCING_ID, DF1.DIFECOFI DESC))
                     PIVOT(SUM(DIFECOFI)
                        FOR NUM IN(1,
                                  2,
                                  3,
                                  4,
                                  5,
                                  6,
                                  7,
                                  8,
                                  9,
                                  10,
                                  11,
                                  12,
                                  13,
                                  14,
                                  15,
                                  16,
                                  17,
                                  18,
                                  19,
                                  20))
                      ORDER BY FINANCING_ID) FINANC
            ON FINANC.FINANCING_ID = A.FINANCIACION;
    BEGIN
      --{
      sbIndexDiferido := gtblDatos_Diferido.FIRST;

      LOOP
        --{
        EXIT WHEN sbIndexDiferido IS NULL;

        OPEN cuHerenciaRefinanciaciones(gtblDatos_Diferido(sbIndexDiferido).DIFECOFI,
                                        gtblDatos_Diferido(sbIndexDiferido).DIFESUSC);

        FETCH cuHerenciaRefinanciaciones
          INTO D1,
               D2,
               D3,
               D4,
               D5,
               D6,
               D7,
               D8,
               D9,
               D10,
               D11,
               D12,
               D13,
               D14,
               D15,
               D16,
               D17,
               D18,
               D19,
               D20;

        CLOSE cuHerenciaRefinanciaciones;

        sbIndexDataCont := trcDataProductos.FIRST;

        LOOP
          --{
          EXIT WHEN sbIndexDataCont IS NULL;

          -- Validar Financiaciones
          IF trcDataProductos(sbIndexDataCont).FINANCIACION = gtblDatos_Diferido(sbIndexDiferido).DIFECOFI THEN
            trcDataProductos(sbIndexDataCont).MES1 := D1;
            trcDataProductos(sbIndexDataCont).MES2 := D2;
            trcDataProductos(sbIndexDataCont).MES3 := D3;
            trcDataProductos(sbIndexDataCont).MES4 := D4;
            trcDataProductos(sbIndexDataCont).MES5 := D5;
            trcDataProductos(sbIndexDataCont).MES6 := D6;
            trcDataProductos(sbIndexDataCont).MES7 := D7;
            trcDataProductos(sbIndexDataCont).MES8 := D8;
            trcDataProductos(sbIndexDataCont).MES9 := D9;
            trcDataProductos(sbIndexDataCont).MES10 := D10;
            trcDataProductos(sbIndexDataCont).MES11 := D11;
            trcDataProductos(sbIndexDataCont).MES12 := D12;
            trcDataProductos(sbIndexDataCont).MES13 := D13;
            trcDataProductos(sbIndexDataCont).MES14 := D14;
            trcDataProductos(sbIndexDataCont).MES15 := D15;
            trcDataProductos(sbIndexDataCont).MES16 := D16;
            trcDataProductos(sbIndexDataCont).MES17 := D17;
            trcDataProductos(sbIndexDataCont).MES18 := D18;
            trcDataProductos(sbIndexDataCont).MES19 := D19;
            trcDataProductos(sbIndexDataCont).MES20 := D20;
          END IF;

          -- Incrementa indice
          sbIndexDataCont := trcDataProductos.NEXT(sbIndexDataCont);
          --}
        END LOOP;

        -- Incrementa indice
        sbIndexDiferido := gtblDatos_Diferido.NEXT(sbIndexDiferido);
        --}
      END LOOP;
      --}
    END;

    -- Se cambia el hint index(MP, OPT_IDX_MO_PACKAGES_034) por index(MP, PK_MO_PACKAGES) CURSOR curCodeudor
    PROCEDURE proc_Actualizar_Codeudor(nuContrato IN NUMBER) IS
      sbIndexDiferido VARCHAR2(33);
      sbIndexDataCont VARCHAR2(54);
      nuLimit         NUMBER := 100;

      CURSOR curCodeudor(nuContrato IN CC_FINANCING_REQUEST.SUBSCRIPTION_ID%TYPE) IS
        WITH DATOS AS
         (SELECT /*+ ordered
                                               use_nl (MO, MP, S)
                                               index(MO, IDX_MO_MOTIVE_03)
                                               index(MP, PK_MO_PACKAGES)
                                               index(S,  IDX_LD_PROMISSORY02) */
           MO.SUBSCRIPTION_ID,
           MO.PRODUCT_ID,
           MO.MOTIVE_ID,
           MP.PACKAGE_ID,
           S.PROMISSORY_ID,
           S.IDENTIFICATION,
           S.IDENT_TYPE_ID
            FROM MO_MOTIVE MO, MO_PACKAGES MP, LD_PROMISSORY S
           WHERE MO.SUBSCRIPTION_ID = nuContrato
             AND MP.PACKAGE_TYPE_ID = 100264
             AND MO.PACKAGE_ID = MP.PACKAGE_ID
             AND MP.PACKAGE_ID = S.PACKAGE_ID
             AND S.PROMISSORY_TYPE = 'C')
        SELECT /*+ no_merge(DATOS)
                                  ordered
                                  use_nl(DATOS, OOA, L)
                                  index(OOA, IDX_OR_ORDER_ACTIVITY_06)
                                  index(L, IX_LD_ITEM_WORK_ORDER01) */
         OOA.ORDER_ACTIVITY_ID,
         OOA.ORDER_ID,
         OOA.TASK_TYPE_ID,
         OOA.PACKAGE_ID,
         OOA.MOTIVE_ID,
         OOA.SUBSCRIBER_ID,
         OOA.SUBSCRIPTION_ID,
         OOA.PRODUCT_ID,
         DATOS.PROMISSORY_ID,
         DATOS.IDENTIFICATION,
         DATOS.IDENT_TYPE_ID,
         L.ARTICLE_ID,
         L.DIFECODI
          FROM DATOS, OR_ORDER_ACTIVITY OOA, LD_ITEM_WORK_ORDER L
         WHERE OOA.PACKAGE_ID = DATOS.PACKAGE_ID
           AND OOA.ORDER_ACTIVITY_ID = L.ORDER_ACTIVITY_ID
           AND L.DIFECODI > 0;

      TYPE rt_Data IS TABLE OF curCodeudor%ROWTYPE INDEX BY BINARY_INTEGER;

      vrt_Data rt_Data;
    BEGIN
      --{
      OPEN curCodeudor(nuContrato);

      LOOP
        --{
        FETCH curCodeudor BULK COLLECT
          INTO vrt_Data LIMIT nuLimit;

        FOR I IN 1 .. vrt_Data.COUNT LOOP
          --{
          sbIndexDataCont := trcDataProductos.FIRST;

          LOOP
            --{
            EXIT WHEN sbIndexDataCont IS NULL;

            -- Validar Financiaciones con Codeudor
            IF trcDataProductos(sbIndexDataCont).IDDIFERIDO = vrt_Data(I).DIFECODI THEN
              trcDataProductos(sbIndexDataCont).CODEUDOR := 1;
            END IF;

            -- Incrementa indice
            sbIndexDataCont := trcDataProductos.NEXT(sbIndexDataCont);
            --}
          END LOOP;
          --}
        END LOOP;

        EXIT WHEN curCodeudor%NOTFOUND;
        --}
      END LOOP;

      CLOSE curCodeudor;
      --}
    END;

    -- Se adiciona el hint INDEX ( a, idx_tmpinprov ) al subquery de la consulta del CURSOR cuSuscripc
    PROCEDURE getSubscriptions(inuTotalThreads IN NUMBER, -- Total de hilos
                               inuThreadNumber IN NUMBER, -- N???mero de hilo
                               inuTrack        IN NUMBER, -- Track
                               inuLimit        IN NUMBER, -- Numero de registros a devolver
                               nuAno           IN NUMBER,
                               nuMes           IN NUMBER,
                               oblMoreRecords  OUT BOOLEAN, -- Mas registros?
                               iorctbData      OUT tytbData -- Tabla de datos
                               ) IS
      CURSOR cuSuscripc IS
        SELECT /*+ INDEX ( SUSCRIPC, PK_SUSCRIPC ) */
         susccodi, suscclie
          FROM SUSCRIPC
         WHERE susccodi > inuTrack
              --AND susccicl = 7214
           AND MOD(susccodi, inuTotalThreads) + 1 = inuThreadNumber
           AND NOT EXISTS (SELECT /*+ INDEX ( a, idx_tmpinprov ) */
                 1
                  FROM TMP_INFORME_PROV_CART a
                 WHERE a.contrato = susccodi
                   AND a.ano = nuAno
                   AND a.mes = nuMes);
    BEGIN
      --{
      oblMoreRecords := TRUE;

      --  Abre CURSOR
      OPEN cuSuscripc;

      --  Recupera registros
      FETCH cuSuscripc BULK COLLECT
        INTO iorctbData.susccodi, iorctbData.suscclie LIMIT inuLimit;

      IF (cuSuscripc%NOTFOUND) THEN
        --{
        -- No hay mas registros en la tabla
        oblMoreRecords := FALSE;
        --}
      END IF;

      --  Cierra cursor
      CLOSE cuSuscripc;
      --}
    EXCEPTION
      WHEN LOGIN_DENIED THEN
        pkErrors.Pop;
        RAISE LOGIN_DENIED;
      WHEN pkConstante.exERROR_LEVEL2 THEN
        pkErrors.Pop;
        RAISE pkConstante.exERROR_LEVEL2;
      WHEN OTHERS THEN
        --Dbms_Output.put_line (sqlerrm);
        pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, sbMsgErr);
        pkErrors.Pop;
        raise_application_error(pkConstante.nuERROR_LEVEL2, sbMsgErr);
    END getSubscriptions;

    -- Se adiciona el hint INDEX ( a, idx_tmpinprov ) al subquery de la consulta del CURSOR cuSuscripc
    FUNCTION getRecordsToProcess(inuTotalThreads IN NUMBER, -- Total de hilos
                                 inuThreadNumber IN NUMBER, -- Numero de hilo
                                 nuAno           IN NUMBER,
                                 nuMes           IN NUMBER) RETURN NUMBER IS
      CURSOR cuSuscripc IS
        SELECT /*+ INDEX_FFS ( SUSCRIPC, PK_SUSCRIPC ) */
         COUNT(1)
          FROM SUSCRIPC
         WHERE susccodi > 0
              --AND susccicl = 7214
           AND MOD(susccodi, inuTotalThreads) + 1 = inuThreadNumber
           AND NOT EXISTS (SELECT /*+ INDEX ( a, idx_tmpinprov ) */
                 1
                  FROM TMP_INFORME_PROV_CART a
                 WHERE a.contrato = susccodi
                   AND a.ano = nuAno
                   AND a.mes = nuMes);

      -- Variables
      nuCount NUMBER;
    BEGIN
      --{
      nuCount := 0;

      --  Abre CURSOR
      OPEN cuSuscripc;

      --  Cuenta registros
      FETCH cuSuscripc
        INTO nuCount;

      --  Cierra cursor
      CLOSE cuSuscripc;

      RETURN nuCount;
      --}
    EXCEPTION
      WHEN LOGIN_DENIED THEN
        pkErrors.Pop;
        RAISE LOGIN_DENIED;
      WHEN pkConstante.exERROR_LEVEL2 THEN
        pkErrors.Pop;
        RAISE pkConstante.exERROR_LEVEL2;
      WHEN OTHERS THEN
        --dbms_output.put_Line('error ' || sqlerrm );

        pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, sbMsgErr);
        pkErrors.Pop;
        raise_application_error(pkConstante.nuERROR_LEVEL2, sbMsgErr);
    END getRecordsToProcess;

    -- Proceso Ciclo 0

    PROCEDURE proc_Llenar_OSF_SESUCIER_C0(nuContrato IN NUMBER) IS
      sbIndex          VARCHAR2(54);
      nuConsecutivo    NUMBER := -9999999999;
      nuSaldoCorriente NUMBER := 0;
      nuSaldoDiferido  NUMBER := 0;
      nuSaldoTotal     NUMBER := 0;
    BEGIN
      --{
      proc_SaldoxProducto(nuContrato);

      gtblDatos_OSF_Sesucier.DELETE();

      FOR RegCon IN CurDatos_OSF_Sesucier_C0(nuContrato) LOOP
        --{
        sbIndex := LPAD(RegCon.ANO, 4, '0') || LPAD(RegCon.MES, 2, '0') ||
                   LPAD(RegCon.CONTRATO, 8, '0') ||
                   LPAD(RegCon.PRODUCTO, 10, '0') ||
                   LPAD(nuConsecutivo, 15, '0') ||
                   LPAD(nuConsecutivo, 15, '0');

        gtblDatos_OSF_Sesucier(sbIndex) := RegCon;

        IF fnBuscarContrato(RegCon.CONTRATO, RegCon.MES, RegCon.ANO) <> 0 THEN
          NULL;
        ELSE
          -- El producto tiene financiaciones
          IF trcDataProductos.EXISTS(sbIndex) THEN
            NULL;
          ELSE
            -- Almacenamiento Datos Producto
            trcDataProductos(sbIndex).ANO := RegCon.ANO;
            trcDataProductos(sbIndex).MES := RegCon.MES;
            trcDataProductos(sbIndex).CONTRATO := RegCon.CONTRATO;
            trcDataProductos(sbIndex).PRODUCTO := RegCon.PRODUCTO;
            trcDataProductos(sbIndex).TIPO_PRODUCTO := RegCon.TIPO_PRODUCTO;
            trcDataProductos(sbIndex).DESC_TIPO_PRODUCTO := RegCon.DESC_TIPO_PRODUCTO;
            trcDataProductos(sbIndex).EDAD_DEUDA := RegCon.EDAD_DEUDA;
            trcDataProductos(sbIndex).ALTURA_MORA := RegCon.ALTURA_MORA;

            sbIndex_Productos := LPAD(RegCon.PRODUCTO, 10, '0') ||
                                 LPAD(TRUNC(RegCon.CICOFECH), 10, '0');

            IF trcProductos.EXISTS(sbIndex_Productos) THEN
              trcDataProductos(sbIndex).SALDO_CORRIENTE_NO_FINANCIADO := trcProductos(sbIndex_Productos).SALDO_CORRIENTE;
              trcDataProductos(sbIndex).SALDO_DIFERIDO := trcProductos(sbIndex_Productos).SALDO_DIFERIDO;
              trcDataProductos(sbIndex).SALDO_TOTAL := trcProductos(sbIndex_Productos).SALDO_TOTAL;
            ELSE
              trcDataProductos(sbIndex).SALDO_CORRIENTE_NO_FINANCIADO := 0;
              trcDataProductos(sbIndex).SALDO_DIFERIDO := 0;
              trcDataProductos(sbIndex).SALDO_TOTAL := 0;
            END IF;

            trcDataProductos(sbIndex).DEUDA_DIFERIDA_CORRIENTE := 0;
            trcDataProductos(sbIndex).DEUDA_CORRIENTE_VENCIDA := 0;
            trcDataProductos(sbIndex).DEUDA_CORRIENTE_NO_VENCIDA := 0;
            trcDataProductos(sbIndex).DEUDA_NO_CORRIENTE := 0;
            trcDataProductos(sbIndex).FECHA_ORIGINACION_PROD := RegCon.FECHA_ORIGINACION_PROD;
            trcDataProductos(sbIndex).CUPO := RegCon.CUPO;
            trcDataProductos(sbIndex).SCORE_O_PUNTAJE_FINAL := RegCon.SCORE_O_PUNTAJE_FINAL;
            trcDataProductos(sbIndex).CICLO := RegCon.CICLO;
            trcDataProductos(sbIndex).DEPARTAMENTO := RegCon.DEPARTAMENTO;
            trcDataProductos(sbIndex).LOCALIDAD := RegCon.LOCALIDAD;
            trcDataProductos(sbIndex).CATEGORIA := RegCon.CATEGORIA;
            trcDataProductos(sbIndex).DESC_CATEGORIA := RegCon.DESC_CATEGORIA;
            trcDataProductos(sbIndex).SUBCATEGORIA := RegCon.SUBCATEGORIA;
            trcDataProductos(sbIndex).DESCR_USO := RegCon.DESCR_USO;
            trcDataProductos(sbIndex).PEFACODI := RegCon.PEFACODI;
            trcDataProductos(sbIndex).CICOFEIN := RegCon.CICOFEIN;
            trcDataProductos(sbIndex).CICOFECH := RegCon.CICOFECH;
            trcDataProductos(sbIndex).CICOHOEJ := RegCon.CICOHOEJ;
            trcDataProductos(sbIndex).FINANCIACION := nuConsecutivo;
            trcDataProductos(sbIndex).IDDIFERIDO := nuConsecutivo;
            trcDataProductos(sbIndex).PLAN_FINANCIACION := NULL;
            trcDataProductos(sbIndex).DESC_PLAN := NULL;
            trcDataProductos(sbIndex).DIFENUDO := NULL;
            trcDataProductos(sbIndex).DIFEPROG := NULL;
            trcDataProductos(sbIndex).FECHA_ORIGINACION_FIN := NULL;
            trcDataProductos(sbIndex).FECHA_TERMINACION_FIN := NULL;
            trcDataProductos(sbIndex).PLAZO_ORIGINACION := NULL;
            trcDataProductos(sbIndex).CUOTAS_COBRADAS := NULL;
            trcDataProductos(sbIndex).SALDO_CAPITAL := NULL;
            trcDataProductos(sbIndex).TASA_INTERES := NULL;
            -- Campos a Calcular
            trcDataProductos(sbIndex).CODEUDOR := 0;
            trcDataProductos(sbIndex).ESTADO_CUENTA := -1;
            trcDataProductos(sbIndex).CUENTA_COBRO := -1;
            trcDataProductos(sbIndex).FECHA_PAGO := NULL;
            trcDataProductos(sbIndex).VALOR_PAGO := 0;
            trcDataProductos(sbIndex).FECHA_ULTIMO_MOV := NULL;
            trcDataProductos(sbIndex).CUOTAS_PAGADAS := 0;
            trcDataProductos(sbIndex).SALDO_INTERES := 0;
            trcDataProductos(sbIndex).SALDO_INTERES_MORA := 0;
            trcDataProductos(sbIndex).SALDOCTEFINANCIADO := 0;
            trcDataProductos(sbIndex).SALDOCTENOFINANCIADO := 0;
            trcDataProductos(sbIndex).FECHA_CIERRE := RegCon.CICOFECH;
            trcDataProductos(sbIndex).MES1 := NULL;
            trcDataProductos(sbIndex).MES2 := NULL;
            trcDataProductos(sbIndex).MES3 := NULL;
            trcDataProductos(sbIndex).MES4 := NULL;
            trcDataProductos(sbIndex).MES5 := NULL;
            trcDataProductos(sbIndex).MES6 := NULL;
            trcDataProductos(sbIndex).MES7 := NULL;
            trcDataProductos(sbIndex).MES8 := NULL;
            trcDataProductos(sbIndex).MES9 := NULL;
            trcDataProductos(sbIndex).MES10 := NULL;
            trcDataProductos(sbIndex).MES11 := NULL;
            trcDataProductos(sbIndex).MES12 := NULL;
            trcDataProductos(sbIndex).MES13 := NULL;
            trcDataProductos(sbIndex).MES14 := NULL;
            trcDataProductos(sbIndex).MES15 := NULL;
            trcDataProductos(sbIndex).MES16 := NULL;
            trcDataProductos(sbIndex).MES17 := NULL;
            trcDataProductos(sbIndex).MES18 := NULL;
            trcDataProductos(sbIndex).MES19 := NULL;
            trcDataProductos(sbIndex).MES20 := NULL;
            trcDataProductos(sbIndex).FECHA_CASTIGO := NULL;
            trcDataProductos(sbIndex).VALOR_CASTIGADO := 0;
          END IF;
        END IF;
        --}
      END LOOP;
      --}
    END;

    PROCEDURE proc_Llenar_OSF_DIFERIDO_C0(nuContrato IN NUMBER) IS
      sbIndex         VARCHAR2(54);
      nuConsecutivo   NUMBER := -9999999999;
      sbIndexTemporal VARCHAR2(54);
    BEGIN
      gtblDatos_OSF_Diferidos.DELETE();

      FOR RegCon IN CurDatos_OSF_Diferidos_C0(nuContrato) LOOP
        sbIndex := LPAD(RegCon.DifeAno, 4, '0') ||
                   LPAD(RegCon.DifeMes, 2, '0') ||
                   LPAD(RegCon.Difesusc, 8, '0') ||
                   LPAD(RegCon.Difenuse, 10, '0') ||
                   LPAD(RegCon.Financiacion, 15, '0') ||
                   LPAD(RegCon.IDDiferido, 15, '0');

        sbIndexTemporal := LPAD(RegCon.DifeAno, 4, '0') ||
                           LPAD(RegCon.DifeMes, 2, '0') ||
                           LPAD(RegCon.Difesusc, 8, '0') ||
                           LPAD(RegCon.Difenuse, 10, '0') ||
                           LPAD(nuConsecutivo, 15, '0') ||
                           LPAD(nuConsecutivo, 15, '0');

        gtblDatos_OSF_Diferidos(sbIndex) := RegCon;

        IF trcDataProductos.EXISTS(sbIndex) THEN
          NULL;
        ELSE
          IF trcDataProductos.EXISTS(sbIndexTemporal) THEN
            -- Almacenamiento Datos Producto
            trcDataProductos(sbIndex).ANO := trcDataProductos(sbIndexTemporal).ANO;
            trcDataProductos(sbIndex).MES := trcDataProductos(sbIndexTemporal).MES;
            trcDataProductos(sbIndex).CONTRATO := trcDataProductos(sbIndexTemporal).CONTRATO;
            trcDataProductos(sbIndex).PRODUCTO := trcDataProductos(sbIndexTemporal).PRODUCTO;
            trcDataProductos(sbIndex).TIPO_PRODUCTO := trcDataProductos(sbIndexTemporal).TIPO_PRODUCTO;
            trcDataProductos(sbIndex).DESC_TIPO_PRODUCTO := trcDataProductos(sbIndexTemporal).DESC_TIPO_PRODUCTO;
            trcDataProductos(sbIndex).EDAD_DEUDA := trcDataProductos(sbIndexTemporal).EDAD_DEUDA;
            trcDataProductos(sbIndex).ALTURA_MORA := trcDataProductos(sbIndexTemporal).ALTURA_MORA;
            trcDataProductos(sbIndex).SALDO_CORRIENTE_NO_FINANCIADO := 0;
            trcDataProductos(sbIndex).SALDO_DIFERIDO := 0;
            trcDataProductos(sbIndex).SALDO_TOTAL := 0;
            trcDataProductos(sbIndex).DEUDA_DIFERIDA_CORRIENTE := 0;
            trcDataProductos(sbIndex).DEUDA_CORRIENTE_VENCIDA := 0;
            trcDataProductos(sbIndex).DEUDA_CORRIENTE_NO_VENCIDA := 0;
            trcDataProductos(sbIndex).DEUDA_NO_CORRIENTE := 0;
            trcDataProductos(sbIndex).FECHA_ORIGINACION_PROD := trcDataProductos(sbIndexTemporal).FECHA_ORIGINACION_PROD;
            trcDataProductos(sbIndex).CUPO := trcDataProductos(sbIndexTemporal).CUPO;
            trcDataProductos(sbIndex).SCORE_O_PUNTAJE_FINAL := trcDataProductos(sbIndexTemporal).SCORE_O_PUNTAJE_FINAL;
            trcDataProductos(sbIndex).CICLO := trcDataProductos(sbIndexTemporal).CICLO;
            trcDataProductos(sbIndex).DEPARTAMENTO := trcDataProductos(sbIndexTemporal).DEPARTAMENTO;
            trcDataProductos(sbIndex).LOCALIDAD := trcDataProductos(sbIndexTemporal).LOCALIDAD;
            trcDataProductos(sbIndex).CATEGORIA := trcDataProductos(sbIndexTemporal).CATEGORIA;
            trcDataProductos(sbIndex).DESC_CATEGORIA := trcDataProductos(sbIndexTemporal).DESC_CATEGORIA;
            trcDataProductos(sbIndex).SUBCATEGORIA := trcDataProductos(sbIndexTemporal).SUBCATEGORIA;
            trcDataProductos(sbIndex).DESCR_USO := trcDataProductos(sbIndexTemporal).DESCR_USO;
            trcDataProductos(sbIndex).PEFACODI := trcDataProductos(sbIndexTemporal).PEFACODI;
            trcDataProductos(sbIndex).CICOFEIN := trcDataProductos(sbIndexTemporal).CICOFEIN;
            trcDataProductos(sbIndex).CICOFECH := trcDataProductos(sbIndexTemporal).CICOFECH;
            trcDataProductos(sbIndex).CICOHOEJ := trcDataProductos(sbIndexTemporal).CICOHOEJ;
            -- Datos Diferido
            trcDataProductos(sbIndex).ANHO := RegCon.DIFEANO;
            trcDataProductos(sbIndex).MES_ := RegCon.DIFEMES;
            trcDataProductos(sbIndex).DIFESUSC := RegCon.DIFESUSC;
            trcDataProductos(sbIndex).DIFENUSE := RegCon.DIFENUSE;
            trcDataProductos(sbIndex).FINANCIACION := RegCon.FINANCIACION;
            trcDataProductos(sbIndex).IDDIFERIDO := RegCon.IDDIFERIDO;
            trcDataProductos(sbIndex).PLAN_FINANCIACION := RegCon.PLAN_FINANCIACION;
            trcDataProductos(sbIndex).DESC_PLAN := RegCon.DESC_PLAN;
            trcDataProductos(sbIndex).DIFENUDO := RegCon.DIFENUDO;
            trcDataProductos(sbIndex).DIFEPROG := RegCon.DIFEPROG;
            trcDataProductos(sbIndex).FECHA_ORIGINACION_FIN := RegCon.FECHA_ORIGINACION_FIN;
            trcDataProductos(sbIndex).FECHA_TERMINACION_FIN := RegCon.FECHA_TERMINACION_FIN;
            trcDataProductos(sbIndex).PLAZO_ORIGINACION := RegCon.PLAZO_ORIGINACION;
            trcDataProductos(sbIndex).CUOTAS_COBRADAS := RegCon.CUOTAS_COBRADAS;
            trcDataProductos(sbIndex).SALDO_CAPITAL := RegCon.SALDO_CAPITAL;
            trcDataProductos(sbIndex).TASA_INTERES := RegCon.TASA_INTERES;
            -- Campos a Calcular
            trcDataProductos(sbIndex).CODEUDOR := 0;
            trcDataProductos(sbIndex).ESTADO_CUENTA := -1;
            trcDataProductos(sbIndex).CUENTA_COBRO := -1;
            trcDataProductos(sbIndex).FECHA_PAGO := NULL;
            trcDataProductos(sbIndex).VALOR_PAGO := 0;
            trcDataProductos(sbIndex).FECHA_ULTIMO_MOV := NULL;
            trcDataProductos(sbIndex).CUOTAS_PAGADAS := 0;
            trcDataProductos(sbIndex).SALDO_INTERES := 0;
            trcDataProductos(sbIndex).SALDO_INTERES_MORA := 0;
            trcDataProductos(sbIndex).SALDOCTEFINANCIADO := 0;
            trcDataProductos(sbIndex).SALDOCTENOFINANCIADO := 0;
            trcDataProductos(sbIndex).FECHA_CIERRE := trcDataProductos(sbIndexTemporal).CICOFECH;
            trcDataProductos(sbIndex).MES1 := NULL;
            trcDataProductos(sbIndex).MES2 := NULL;
            trcDataProductos(sbIndex).MES3 := NULL;
            trcDataProductos(sbIndex).MES4 := NULL;
            trcDataProductos(sbIndex).MES5 := NULL;
            trcDataProductos(sbIndex).MES6 := NULL;
            trcDataProductos(sbIndex).MES7 := NULL;
            trcDataProductos(sbIndex).MES8 := NULL;
            trcDataProductos(sbIndex).MES9 := NULL;
            trcDataProductos(sbIndex).MES10 := NULL;
            trcDataProductos(sbIndex).MES11 := NULL;
            trcDataProductos(sbIndex).MES12 := NULL;
            trcDataProductos(sbIndex).MES13 := NULL;
            trcDataProductos(sbIndex).MES14 := NULL;
            trcDataProductos(sbIndex).MES15 := NULL;
            trcDataProductos(sbIndex).MES16 := NULL;
            trcDataProductos(sbIndex).MES17 := NULL;
            trcDataProductos(sbIndex).MES18 := NULL;
            trcDataProductos(sbIndex).MES19 := NULL;
            trcDataProductos(sbIndex).MES20 := NULL;
            trcDataProductos(sbIndex).FECHA_CASTIGO := NULL;
            trcDataProductos(sbIndex).VALOR_CASTIGADO := 0;
          ELSE
            NULL;
          END IF;
        END IF;
      END LOOP;
    END;

    PROCEDURE proc_Llenar_Facturacion_C0(nuContrato IN NUMBER) IS
      sbIndex VARCHAR2(200);
    BEGIN
      gtblDatos_Facturacion.DELETE();

      -- Abre CURSOR
      OPEN curDatos_Facturacion_C0(nuContrato);

      --  Recupera registros
      FETCH curDatos_Facturacion_C0 BULK COLLECT
        INTO gtblDatos_Facturacion;

      -- Cierra cursor
      CLOSE curDatos_Facturacion_C0;
    END;

    -- Se adiciona el hint INDEX ( a, idx_tmpinprov ) al subquery de la consulta del CURSOR cuSuscripc
    PROCEDURE getSubscriptions_Ciclo_0(inuTotalThreads IN NUMBER, -- Total de hilos
                                       inuThreadNumber IN NUMBER, -- Numero de hilo
                                       inuTrack        IN NUMBER, -- Track
                                       inuLimit        IN NUMBER, -- Numero de registros a devolver
                                       nuAno           IN NUMBER,
                                       nuMes           IN NUMBER,
                                       oblMoreRecords  OUT BOOLEAN, -- Mas registros?
                                       iorctbData      OUT tytbData -- Tabla de datos
                                       ) IS
      CURSOR cuSuscripc IS
        SELECT /*+ INDEX ( SUSCRIPC, PK_SUSCRIPC ) */
         susccodi, suscclie
          FROM SUSCRIPC
         WHERE susccodi > inuTrack
              --AND susccicl = 7214
           AND MOD(susccodi, inuTotalThreads) + 1 = inuThreadNumber
           AND NOT EXISTS (SELECT /*+ INDEX ( a, idx_tmpinprov ) */
                 1
                  FROM TMP_INFORME_PROV_CART a
                 WHERE a.contrato = susccodi
                   AND a.ano = nuAno
                   AND a.mes = nuMes);
    BEGIN
      --{
      oblMoreRecords := TRUE;

      --  Abre CURSOR
      OPEN cuSuscripc;

      --  Recupera registros
      FETCH cuSuscripc BULK COLLECT
        INTO iorctbData.susccodi, iorctbData.suscclie LIMIT inuLimit;

      IF (cuSuscripc%NOTFOUND) THEN
        --{
        -- No hay mas registros en la tabla
        oblMoreRecords := FALSE;
        --}
      END IF;

      --  Cierra cursor
      CLOSE cuSuscripc;
      --}
    EXCEPTION
      WHEN LOGIN_DENIED THEN
        pkErrors.Pop;
        RAISE LOGIN_DENIED;
      WHEN pkConstante.exERROR_LEVEL2 THEN
        pkErrors.Pop;
        RAISE pkConstante.exERROR_LEVEL2;
      WHEN OTHERS THEN
        --Dbms_Output.put_line (sqlerrm);
        pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, sbMsgErr);
        pkErrors.Pop;
        raise_application_error(pkConstante.nuERROR_LEVEL2, sbMsgErr);
    END getSubscriptions_Ciclo_0;

    -- Se adiciona el hint INDEX ( a, idx_tmpinprov ) al subquery de la consulta del CURSOR cuSuscripc
    FUNCTION getRecordsToProcess_Ciclo_0(inuTotalThreads IN NUMBER, -- Total de hilos
                                         inuThreadNumber IN NUMBER, -- N???mero de hilo
                                         nuAno           IN NUMBER,
                                         nuMes           IN NUMBER)
      RETURN NUMBER IS
      CURSOR cuSuscripc IS
        SELECT /*+ INDEX_FFS ( SUSCRIPC, PK_SUSCRIPC ) */
         COUNT(1)
          FROM SUSCRIPC
         WHERE susccodi > 0
              --AND   susccicl = 7214
           AND MOD(susccodi, inuTotalThreads) + 1 = inuThreadNumber
           AND NOT EXISTS (SELECT /*+ INDEX ( a, idx_tmpinprov ) */
                 1
                  FROM TMP_INFORME_PROV_CART a
                 WHERE a.contrato = susccodi
                   AND a.ano = nuAno
                   AND a.mes = nuMes);

      -- Variables
      nuCount NUMBER;
    BEGIN
      --{
      nuCount := 0;

      --  Abre CURSOR
      OPEN cuSuscripc;

      --  Cuenta registros
      FETCH cuSuscripc
        INTO nuCount;

      --  Cierra cursor
      CLOSE cuSuscripc;

      RETURN nuCount;
      --}
    EXCEPTION
      WHEN LOGIN_DENIED THEN
        pkErrors.Pop;
        RAISE LOGIN_DENIED;
      WHEN pkConstante.exERROR_LEVEL2 THEN
        pkErrors.Pop;
        RAISE pkConstante.exERROR_LEVEL2;
      WHEN OTHERS THEN
        --dbms_output.put_Line('error ' || sqlerrm );

        pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, sbMsgErr);
        pkErrors.Pop;
        raise_application_error(pkConstante.nuERROR_LEVEL2, sbMsgErr);
    END getRecordsToProcess_Ciclo_0;
  BEGIN
    /*
    EXECUTE IMMEDIATE 'alter session set sql_trace=true';

    EXECUTE IMMEDIATE 'alter session set tracefile_identifier=opt_Proceso_IFRS_TRAZA_Hilo_' || nuThreadNumber;

    EXECUTE IMMEDIATE 'alter session set timed_statistics = true';

    EXECUTE IMMEDIATE 'alter session set statistics_level=all';

    EXECUTE IMMEDIATE 'alter session set max_dump_file_size = unlimited';
    */
    BEGIN
      --dsaltarin se excluye el ciclo 2201 debido a que presenta fechas incosistentes y esto genera demoras en la ejecución del proceso OSF-765
      -- PEFAFIMO Fecha inicial movimientos facturar
      -- PEFAFFMO Fecha final movimientos facturar/facturado
      SELECT /*+ INDEX ( PERIFACT, IX_PERIFACT06 ) */
       TRUNC(MIN(PEFAFIMO), 'MM'), LAST_DAY(MAX(PEFAFFMO))
        INTO dtFechaInicial, dtFechaFinal
        FROM PERIFACT
       WHERE PEFAANO = nuAno
         AND PEFAMES = nuMes
         AND PEFACICL!=2201;
    END;

    pro_grabalog(innusesion,
                 'IFRS',
                 nuAno,
                 nuMes,
                 idttoday,
                 nuThreadNumber,
                 1,
                 'Inicia Hilo: ' || nuThreadNumber);

    DBMS_SESSION.free_unused_user_memory;

    -- Asigna tiempo inicial
    piTime_Ini    := DBMS_UTILITY.GET_TIME();
    piCpuTime_Ini := DBMS_UTILITY.GET_CPU_TIME();

    -- Define asignacion
    nuTrack                 := 0;
    blMoreRecords           := TRUE;
    nuTotalRecordsProcessed := 0;

    -- Obtiene el estaprog
    sbProgram := pkStatusExeProgramMgr.fsbGetProgramID('IFRS') || '-' ||
                 nuThreadNumber;

    -- Cuenta los registros a procesar       -- getRecordsToProcess_Ciclo_0
    nuRecordsToProcess := getRecordsToProcess(nuTotalThreads,
                                              nuThreadNumber,
                                              nuAno,
                                              NUMES);

    -- Adiciona estaprog
    pkStatusExeProgramMgr.AddRecord(sbProgram, nuRecordsToProcess, NULL);

    COMMIT;

    /*
       Se realiza el cambio de llamado de los procesos
       getSubscriptions_Ciclo_0 por getSubscriptions
       getRecordsToProcess_Ciclo_0 por getRecordsToProcess
       proc_Llenar_OSF_SESUCIER_C0 por proc_Llenar_OSF_SESUCIER
       proc_Llenar_OSF_DIFERIDO_C0 por proc_Llenar_OSF_DIFERIDO
       proc_Llenar_Facturacion_C0 por proc_Llenar_Facturacion
    */

    LOOP
      --{
      --  Inicializa memoria
      rctbSubscriptions := rctbSubscriptionsEmpty;
      -- getSubscriptions_Ciclo_0
      getSubscriptions(nuTotalThreads,
                       nuThreadNumber,
                       nuTrack,
                       nuBulkLimit,
                       nuAno,
                       nuMes,
                       blMoreRecords,
                       rctbSubscriptions);

      --  Toma el primer indice
      nuBulkIndex := rctbSubscriptions.susccodi.FIRST;

      --  Procesar productos devueltos en tabla PL-SQL
      LOOP
        --{
        EXIT WHEN nuBulkIndex IS NULL;

        -- Procesar suscripcion posicion nuBulkIndex
        nuSubscriptionCurr := rctbSubscriptions.susccodi(nuBulkIndex);

        -- Calcula registros totales
        nuTotalRecordsProcessed := nuTotalRecordsProcessed + 1;

        -- Actualiza porcentaje de avance
        pkStatusExeProgramMgr.UpStatusExeProgramAT(sbProgram,
                                                   'Procesando... ' ||
                                                   nuSubscriptionCurr,
                                                   nuRecordsToProcess,
                                                   nuTotalRecordsProcessed);

        -- Se arma Record con los datos a almacenar.
        trcDataProductos.DELETE();

        --Dbms_Output.put_line ('trcDataProductos -> ' || trcDataProductos.Count());
        --dbms_output.put_Line('-->nuSubscriptionCurr ' || nuSubscriptionCurr );

        --906_1 se adiciona validacion de linea y contrato
        nuContrato := nuSubscriptionCurr;
        nuLinea    := 1;
        proc_Llenar_OSF_SESUCIER(nuSubscriptionCurr); -- proc_Llenar_OSF_SESUCIER_C0
        nuLinea := 2;
        proc_Llenar_OSF_DIFERIDO(nuSubscriptionCurr); -- proc_Llenar_OSF_DIFERIDO_C0
        nuLinea := 3;
        proc_Llenar_Facturacion(nuSubscriptionCurr); -- proc_Llenar_Facturacion_C0
        nuLinea := 4;
        proc_Llenar_Diferidos(nuSubscriptionCurr);
        nuLinea := 5;
        proc_Llenar_Mov_Diferidos(nuSubscriptionCurr);
        nuLinea := 6;
        proc_Llenar_Pagos(nuSubscriptionCurr);
        nuLinea := 7;
        proc_Actualizar_Cuotas_Pagadas(nuSubscriptionCurr);
        nuLinea := 8;
        proc_Actualizar_Ultimo_Mov(nuSubscriptionCurr);
        nuLinea := 9;
        proc_Actualizar_Intereses(nuSubscriptionCurr);
        nuLinea := 10;
        proc_Actualizar_Interes_Mora(nuSubscriptionCurr);
        nuLinea := 11;
        proc_Actualizar_Saldo(nuSubscriptionCurr);
        nuLinea := 12;
        proc_Actualizar_Pagos(nuSubscriptionCurr);
        nuLinea := 13;
        proc_Actualizar_Castigo(nuSubscriptionCurr);
        nuLinea := 14;
        proc_Actualizar_Pivot(nuSubscriptionCurr);
        nuLinea := 15;
        proc_Actualizar_Codeudor(nuSubscriptionCurr);
        nuLinea := 16;
        --

        -- Se realiza proceso de insercion tabla TMP_INFORME_PROV_CART
        sbIndex := trcDataProductos.FIRST;

        tbInformeProvCart := tbInformeProvCartEmpty;

        nuIdx := 1;

        LOOP
          --{
          EXIT WHEN sbindex IS NULL;

          tbInformeProvCart(nuIdx).ANO := trcDataProductos(sbIndex).ANO;
          tbInformeProvCart(nuIdx).MES := trcDataProductos(sbIndex).MES;
          tbInformeProvCart(nuIdx).CONTRATO := trcDataProductos(sbIndex).CONTRATO;
          tbInformeProvCart(nuIdx).PRODUCTO := trcDataProductos(sbIndex).PRODUCTO;
          tbInformeProvCart(nuIdx).TIPO_PRODUCTO := trcDataProductos(sbIndex).TIPO_PRODUCTO;
          tbInformeProvCart(nuIdx).DESC_TIPO_PRODUCTO := trcDataProductos(sbIndex).DESC_TIPO_PRODUCTO;
          tbInformeProvCart(nuIdx).ALTURA_MORA := trcDataProductos(sbIndex).ALTURA_MORA;
          tbInformeProvCart(nuIdx).SALDO_CORRIENTE_NO_FINANCIADO := trcDataProductos(sbIndex).SALDO_CORRIENTE_NO_FINANCIADO;
          tbInformeProvCart(nuIdx).SALDO_DIFERIDO := trcDataProductos(sbIndex).SALDO_DIFERIDO;

          tbInformeProvCart(nuIdx).SALDO_TOTAL := trcDataProductos(sbIndex).SALDO_TOTAL;

          tbInformeProvCart(nuIdx).DEUDA_CORRIENTE_VENCIDA := trcDataProductos(sbIndex).DEUDA_CORRIENTE_VENCIDA;
          tbInformeProvCart(nuIdx).DEUDA_CORRIENTE_NO_VENCIDA := trcDataProductos(sbIndex).DEUDA_CORRIENTE_NO_VENCIDA;
          tbInformeProvCart(nuIdx).DEUDA_NO_CORRIENTE := trcDataProductos(sbIndex).DEUDA_NO_CORRIENTE;
          tbInformeProvCart(nuIdx).FECHA_ORIGINACION_PROD := trcDataProductos(sbIndex).FECHA_ORIGINACION_PROD;
          tbInformeProvCart(nuIdx).CUPO := trcDataProductos(sbIndex).CUPO;
          tbInformeProvCart(nuIdx).SCORE_O_PUNTAJE_FINAL := trcDataProductos(sbIndex).SCORE_O_PUNTAJE_FINAL;
          tbInformeProvCart(nuIdx).CICLO := trcDataProductos(sbIndex).CICLO;
          tbInformeProvCart(nuIdx).DEPARTAMENTO := trcDataProductos(sbIndex).DEPARTAMENTO;
          tbInformeProvCart(nuIdx).LOCALIDAD := trcDataProductos(sbIndex).LOCALIDAD;
          tbInformeProvCart(nuIdx).CATEGORIA := trcDataProductos(sbIndex).CATEGORIA;
          tbInformeProvCart(nuIdx).DESC_CATEGORIA := trcDataProductos(sbIndex).DESC_CATEGORIA;
          tbInformeProvCart(nuIdx).SUBCATEGORIA := trcDataProductos(sbIndex).SUBCATEGORIA;
          tbInformeProvCart(nuIdx).DESCR_USO := trcDataProductos(sbIndex).DESCR_USO;
          tbInformeProvCart(nuIdx).PEFACODI := trcDataProductos(sbIndex).PEFACODI;
          tbInformeProvCart(nuIdx).CICOFEIN := trcDataProductos(sbIndex).CICOFEIN;
          tbInformeProvCart(nuIdx).CICOFECH := trcDataProductos(sbIndex).CICOFECH;
          tbInformeProvCart(nuIdx).CICOHOEJ := trcDataProductos(sbIndex).CICOHOEJ;
          tbInformeProvCart(nuIdx).ANHO := trcDataProductos(sbIndex).ANHO;
          tbInformeProvCart(nuIdx).MES_ := trcDataProductos(sbIndex).MES_;
          tbInformeProvCart(nuIdx).DIFESUSC := trcDataProductos(sbIndex).DIFESUSC;
          tbInformeProvCart(nuIdx).DIFENUSE := trcDataProductos(sbIndex).DIFENUSE;
          tbInformeProvCart(nuIdx).FINANCIACION := trcDataProductos(sbIndex).FINANCIACION;
          tbInformeProvCart(nuIdx).IDDIFERIDO := trcDataProductos(sbIndex).IDDIFERIDO;
          tbInformeProvCart(nuIdx).PLAN_FINANCIACION := trcDataProductos(sbIndex).PLAN_FINANCIACION;
          tbInformeProvCart(nuIdx).DESC_PLAN := trcDataProductos(sbIndex).DESC_PLAN;
          tbInformeProvCart(nuIdx).DIFENUDO := trcDataProductos(sbIndex).DIFENUDO;
          tbInformeProvCart(nuIdx).DIFEPROG := trcDataProductos(sbIndex).DIFEPROG;
          tbInformeProvCart(nuIdx).FECHA_ORIGINACION_FIN := trcDataProductos(sbIndex).FECHA_ORIGINACION_FIN;
          tbInformeProvCart(nuIdx).FECHA_TERMINACION_FIN := trcDataProductos(sbIndex).FECHA_TERMINACION_FIN;
          tbInformeProvCart(nuIdx).PLAZO_ORIGINACION := trcDataProductos(sbIndex).PLAZO_ORIGINACION;
          tbInformeProvCart(nuIdx).CUOTAS_COBRADAS := trcDataProductos(sbIndex).CUOTAS_COBRADAS;
          tbInformeProvCart(nuIdx).SALDO_CAPITAL := trcDataProductos(sbIndex).SALDO_CAPITAL;
          tbInformeProvCart(nuIdx).TASA_INTERES := trcDataProductos(sbIndex).TASA_INTERES;
          tbInformeProvCart(nuIdx).CODEUDOR := trcDataProductos(sbIndex).CODEUDOR;
          tbInformeProvCart(nuIdx).ESTADO_CUENTA := trcDataProductos(sbIndex).ESTADO_CUENTA;
          tbInformeProvCart(nuIdx).CUENTA_COBRO := trcDataProductos(sbIndex).CUENTA_COBRO;
          tbInformeProvCart(nuIdx).FECHA_PAGO := trcDataProductos(sbIndex).FECHA_PAGO;
          tbInformeProvCart(nuIdx).VALOR_PAGO := trcDataProductos(sbIndex).VALOR_PAGO;
          tbInformeProvCart(nuIdx).FECHA_ULTIMO_MOV := trcDataProductos(sbIndex).FECHA_ULTIMO_MOV;
          tbInformeProvCart(nuIdx).CUOTAS_PAGADAS := trcDataProductos(sbIndex).CUOTAS_PAGADAS;
          tbInformeProvCart(nuIdx).SALDO_INTERES := trcDataProductos(sbIndex).SALDO_INTERES;
          tbInformeProvCart(nuIdx).SALDO_INTERES_MORA := trcDataProductos(sbIndex).SALDO_INTERES_MORA;
          tbInformeProvCart(nuIdx).SALDOCTEFINANCIADO := trcDataProductos(sbIndex).SALDOCTEFINANCIADO;
          tbInformeProvCart(nuIdx).SALDOCTENOFINANCIADO := trcDataProductos(sbIndex).SALDOCTENOFINANCIADO;
          tbInformeProvCart(nuIdx).FECHA_CIERRE := trcDataProductos(sbIndex).FECHA_CIERRE;
          tbInformeProvCart(nuIdx).MES1 := trcDataProductos(sbIndex).MES1;
          tbInformeProvCart(nuIdx).MES2 := trcDataProductos(sbIndex).MES2;
          tbInformeProvCart(nuIdx).MES3 := trcDataProductos(sbIndex).MES3;
          tbInformeProvCart(nuIdx).MES4 := trcDataProductos(sbIndex).MES4;
          tbInformeProvCart(nuIdx).MES5 := trcDataProductos(sbIndex).MES5;
          tbInformeProvCart(nuIdx).MES6 := trcDataProductos(sbIndex).MES6;
          tbInformeProvCart(nuIdx).MES7 := trcDataProductos(sbIndex).MES7;
          tbInformeProvCart(nuIdx).MES8 := trcDataProductos(sbIndex).MES8;
          tbInformeProvCart(nuIdx).MES9 := trcDataProductos(sbIndex).MES9;
          tbInformeProvCart(nuIdx).MES10 := trcDataProductos(sbIndex).MES10;
          tbInformeProvCart(nuIdx).MES11 := trcDataProductos(sbIndex).MES11;
          tbInformeProvCart(nuIdx).MES12 := trcDataProductos(sbIndex).MES12;
          tbInformeProvCart(nuIdx).MES13 := trcDataProductos(sbIndex).MES13;
          tbInformeProvCart(nuIdx).MES14 := trcDataProductos(sbIndex).MES14;
          tbInformeProvCart(nuIdx).MES15 := trcDataProductos(sbIndex).MES15;
          tbInformeProvCart(nuIdx).MES16 := trcDataProductos(sbIndex).MES16;
          tbInformeProvCart(nuIdx).MES17 := trcDataProductos(sbIndex).MES17;
          tbInformeProvCart(nuIdx).MES18 := trcDataProductos(sbIndex).MES18;
          tbInformeProvCart(nuIdx).MES19 := trcDataProductos(sbIndex).MES19;
          tbInformeProvCart(nuIdx).MES20 := trcDataProductos(sbIndex).MES20;
          tbInformeProvCart(nuIdx).FECHA_CASTIGO := trcDataProductos(sbIndex).FECHA_CASTIGO;
          tbInformeProvCart(nuIdx).VALOR_CASTIGADO := trcDataProductos(sbIndex).VALOR_CASTIGADO;
          tbInformeProvCart(nuIdx).EDAD_DEUDA := trcDataProductos(sbIndex).EDAD_DEUDA;

          nuIdx   := nuIdx + 1;
          sbindex := trcDataProductos.NEXT(sbindex);
          --}
        END LOOP;

        -- Se realiza proceso de insercion tabla TMP_INFORME_PROV_CART
        FORALL i IN INDICES OF tbInformeProvCart
          INSERT INTO TMP_INFORME_PROV_CART VALUES tbInformeProvCart (i);

        COMMIT;

        -- Obtiene el proximo registro
        nuBulkIndex := rctbSubscriptions.susccodi.NEXT(nuBulkIndex);
        --}
      END LOOP;

      -- Calcula registros totales
      --nuTotalRecordsProcessed := nuTotalRecordsProcessed + rctbSubscriptions.susccodi.count;

      -- Actualiza porcentaje de avance
      --pkStatusExeProgramMgr.UpStatusExeProgramAT(sbProgram,'Procesando...',nuRecordsToProcess,nuTotalRecordsProcessed);

      --  Sale si no hay mas registros para procesar
      EXIT WHEN NOT blMoreRecords OR rctbSubscriptions.susccodi.COUNT = 0;

      --  Fija Track con el ultimo valor procesado
      nuTrack := rctbSubscriptions.susccodi(rctbSubscriptions.susccodi.LAST);
      --}
    END LOOP;

    piTime_End    := DBMS_UTILITY.GET_TIME() - piTime_Ini;
    piCpuTime_End := DBMS_UTILITY.GET_CPU_TIME() - piCpuTime_Ini;

    pro_grabalog(innusesion,
                 'IFRS',
                 NUANO,
                 NUMES,
                 idttoday,
                 nuThreadNumber,
                 2,
                 'Termino Hilo: ' || nuThreadNumber || ' - Proceso Ok');
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      DBMS_OUTPUT.put_Line('Error ' || SQLERRM);
      pro_grabalog(innusesion,
                   'IFRS',
                   NUANO,
                   NUMES,
                   idttoday,
                   nuThreadNumber,
                   -1,
                   'Hilo: ' || nuThreadNumber
                   --906_1 se adiciona linea de detalle
                    || ' Termino con errores (VER ESTAPROG) (' || nuLinea ||
                    ' - ' || nuContrato || '), ERROR: ' || SQLERRM);
  END;

  /**************************************************************************************************/

  PROCEDURE pro_grabalog(inusesion  NUMBER,
                         inuproceso VARCHAR2,
                         inuano     NUMBER,
                         inumes     NUMBER,
                         idtfecha   DATE,
                         inuhilo    NUMBER,
                         inuresult  NUMBER,
                         isbobse    VARCHAR2) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    INSERT INTO LDC_LOG_LDRPCRE
      (sesion,
       proceso,
       usuario,
       ano,
       mes,
       fecha_inicio,
       fecha_final,
       hilo,
       resultado,
       observacion)
    VALUES
      (inusesion,
       inuproceso,
       USER,
       inuano,
       inumes,
       idtfecha,
       SYSDATE,
       inuhilo,
       inuresult,
       isbobse);

    COMMIT;
  END pro_grabalog;

  --CA 906
  --DANVAL
  --06-12-2021
  --Se adiciona parametro de entrada no obligatorio para definir la ruta donde se guardara el archivo
  --en el servidor. ademas se comprimira en la ruta especificada y solo dejara el comprimido
  PROCEDURE Proifrsbrillafile(nuAnho       NUMBER,
                              nuMes        NUMBER,
                              inuDirectory in number := null) IS
    F            UTL_FILE.FILE_TYPE;
    sbEncabezado VARCHAR2(4000);
    nuCupo       NUMBER;
    nuCupoTotal  NUMBER;
    nuLimit      NUMBER := 1000;

    sbRuta           VARCHAR2(100) := dald_parameter.fsbGetValue_Chain('IFRS_RUTA');
    sbNombre_Archivo VARCHAR2(100) := 'Data_Modelo_IFRS_';
    --CA 906
    sbNombre_Archivo_zip VARCHAR2(100) := 'Data_Modelo_IFRS_';
    --
    sbEmpresa VARCHAR2(100) := 'GDC';

    CURSOR CurProcesos IS
      SELECT nuAnho ANHO, nuMes MES FROM DUAL;

    CURSOR CurData(nuAnho IN NUMBER, nuMes IN NUMBER) IS
      WITH DATA_CONTRATO AS
       (SELECT /*+ PARALLEL ( TMP_INFORME_PROV_CART, 32 ) */
         ANO,
         MES,
         CONTRATO,
         PRODUCTO,
         TIPO_PRODUCTO,
         DESC_TIPO_PRODUCTO,
         ALTURA_MORA,
         SALDO_CORRIENTE_NO_FINANCIADO SALDO_CORRIENTE,
         SALDO_DIFERIDO,
         SALDO_TOTAL,
         EDAD_DEUDA,
         FECHA_ORIGINACION_PROD,
         CUPO,
         SCORE_O_PUNTAJE_FINAL,
         CICLO,
         DEPARTAMENTO,
         LOCALIDAD,
         CATEGORIA,
         DESC_CATEGORIA,
         SUBCATEGORIA,
         DESCR_USO,
         FINANCIACION,
         PLAN_FINANCIACION,
         DESC_PLAN,
         DIFEPROG PROGRAMA,
         FECHA_ORIGINACION_FIN,
         FECHA_TERMINACION_FIN,
         PLAZO_ORIGINACION,
         STATS_MODE(CUOTAS_COBRADAS) CUOTAS_COBRADAS,
         SUM(SALDO_CAPITAL) SALDO_CAPITAL,
         TASA_INTERES,
         CODEUDOR,
         ESTADO_CUENTA,
         CUENTA_COBRO,
         FECHA_PAGO,
         VALOR_PAGO,
         MAX(FECHA_ULTIMO_MOV) FECHA_ULTIMO_MOV,
         STATS_MODE(CUOTAS_PAGADAS) CUOTAS_PAGADAS,
         SUM(SALDO_INTERES) SALDO_INTERES,
         SUM(SALDO_INTERES_MORA) SALDO_INTERES_MORA,
         SUM(SALDOCTEFINANCIADO) SALDOCTEFINANCIADO,
         SUM(SALDOCTENOFINANCIADO) SALDOCTENOFINANCIADO,
         FECHA_CASTIGO,
         SUM(VALOR_CASTIGADO) VALOR_CASTIGADO,
         FECHA_CIERRE,
         MES1,
         MES2,
         MES3,
         MES4,
         MES5,
         MES6,
         MES7,
         MES8,
         MES9,
         MES10,
         MES11,
         MES12,
         MES13,
         MES14,
         MES15,
         MES16,
         MES17,
         MES18,
         MES19,
         MES20
          FROM TMP_INFORME_PROV_CART
         WHERE MES = nuMes
           AND ANO = nuAnho
         GROUP BY ANO,
                  MES,
                  CONTRATO,
                  PRODUCTO,
                  TIPO_PRODUCTO,
                  DESC_TIPO_PRODUCTO,
                  ALTURA_MORA,
                  EDAD_DEUDA,
                  SALDO_CORRIENTE_NO_FINANCIADO,
                  SALDO_DIFERIDO,
                  SALDO_TOTAL,
                  FECHA_ORIGINACION_PROD,
                  CUPO,
                  SCORE_O_PUNTAJE_FINAL,
                  CICLO,
                  DEPARTAMENTO,
                  LOCALIDAD,
                  CATEGORIA,
                  DESC_CATEGORIA,
                  SUBCATEGORIA,
                  DESCR_USO,
                  FINANCIACION,
                  PLAN_FINANCIACION,
                  DESC_PLAN,
                  DIFEPROG,
                  FECHA_ORIGINACION_FIN,
                  FECHA_TERMINACION_FIN,
                  PLAZO_ORIGINACION,
                  TASA_INTERES,
                  CODEUDOR,
                  CUOTAS_PAGADAS,
                  ESTADO_CUENTA,
                  CUENTA_COBRO,
                  FECHA_PAGO,
                  VALOR_PAGO,
                  FECHA_CIERRE,
                  MES1,
                  MES2,
                  MES3,
                  MES4,
                  MES5,
                  MES6,
                  MES7,
                  MES8,
                  MES9,
                  MES10,
                  MES11,
                  MES12,
                  MES13,
                  MES14,
                  MES15,
                  MES16,
                  MES17,
                  MES18,
                  MES19,
                  MES20,
                  VALOR_CASTIGADO,
                  FECHA_CASTIGO)
      SELECT /*+ PARALLEL ( DATA_CONTRATO, 32 ) */
       ANO,
       MES,
       CONTRATO,
       PRODUCTO,
       TIPO_PRODUCTO,
       DESC_TIPO_PRODUCTO,
       ALTURA_MORA,
       EDAD_DEUDA,
       SUM(SALDO_CORRIENTE) SALDO_CORRIENTE,
       SUM(SALDO_DIFERIDO) SALDO_DIFERIDO,
       SUM(SALDO_TOTAL) SALDO_TOTAL,
       FECHA_ORIGINACION_PROD,
       CUPO,
       SCORE_O_PUNTAJE_FINAL,
       CICLO,
       DEPARTAMENTO,
       LOCALIDAD,
       CATEGORIA,
       DESC_CATEGORIA,
       SUBCATEGORIA,
       DESCR_USO,
       ESTADO_CUENTA,
       CUENTA_COBRO,
       DECODE(FINANCIACION, -9999999999, '', FINANCIACION) FINANCIACION,
       PLAN_FINANCIACION,
       DESC_PLAN,
       TASA_INTERES,
       PROGRAMA,
       FECHA_ORIGINACION_FIN,
       FECHA_TERMINACION_FIN,
       PLAZO_ORIGINACION,
       CODEUDOR,
       CUOTAS_COBRADAS,
       CUOTAS_PAGADAS,
       FECHA_ULTIMO_MOV,
       SUM(SALDO_CAPITAL) SALDO_CAPITAL,
       SUM(SALDO_INTERES) SALDO_INTERES,
       SUM(SALDO_INTERES_MORA) SALDO_INTERES_MORA,
       SUM(SALDOCTEFINANCIADO) SALDOCTEFINANCIADO,
       SUM(SALDOCTENOFINANCIADO) SALDOCTENOFINANCIADO,
       (SUM(NVL(SALDOCTEFINANCIADO, 0)) + SUM(NVL(SALDOCTENOFINANCIADO, 0)) +
       SUM(NVL(SALDO_CAPITAL, 0))) TOTAL,
       FECHA_PAGO,
       VALOR_PAGO,
       FECHA_CASTIGO,
       SUM(VALOR_CASTIGADO) VALOR_CASTIGADO,
       FECHA_CIERRE,
       MES1,
       MES2,
       MES3,
       MES4,
       MES5,
       MES6,
       MES7,
       MES8,
       MES9,
       MES10,
       MES11,
       MES12,
       MES13,
       MES14,
       MES15,
       MES16,
       MES17,
       MES18,
       MES19,
       MES20
        FROM DATA_CONTRATO
       GROUP BY ANO,
                MES,
                CONTRATO,
                PRODUCTO,
                TIPO_PRODUCTO,
                DESC_TIPO_PRODUCTO,
                ALTURA_MORA,
                EDAD_DEUDA,
                FECHA_ORIGINACION_PROD,
                CUPO,
                SCORE_O_PUNTAJE_FINAL,
                CICLO,
                DEPARTAMENTO,
                LOCALIDAD,
                CATEGORIA,
                DESC_CATEGORIA,
                SUBCATEGORIA,
                DESCR_USO,
                FINANCIACION,
                PLAN_FINANCIACION,
                DESC_PLAN,
                PROGRAMA,
                FECHA_ORIGINACION_FIN,
                FECHA_TERMINACION_FIN,
                PLAZO_ORIGINACION,
                CUOTAS_COBRADAS,
                TASA_INTERES,
                CODEUDOR,
                ESTADO_CUENTA,
                CUENTA_COBRO,
                FECHA_PAGO,
                VALOR_PAGO,
                FECHA_ULTIMO_MOV,
                CUOTAS_PAGADAS,
                FECHA_CIERRE,
                MES1,
                MES2,
                MES3,
                MES4,
                MES5,
                MES6,
                MES7,
                MES8,
                MES9,
                MES10,
                MES11,
                MES12,
                MES13,
                MES14,
                MES15,
                MES16,
                MES17,
                MES18,
                MES19,
                MES20,
                VALOR_CASTIGADO,
                FECHA_CASTIGO
       ORDER BY MES, ANO, CONTRATO, PRODUCTO;

    TYPE rt_Data IS TABLE OF CurData%ROWTYPE INDEX BY BINARY_INTEGER;

    vrt_Data rt_Data;
  BEGIN
    sbEncabezado := 'ANO|MES|CONTRATO|PRODUCTO|TIPO_PRODUCTO|DESC_TIPO_PRODUCTO|ALTURA_MORA|EDAD_DEUDA|SALDO_CORRIENTE|SALDO_DIFERIDO|SALDO_TOTAL|' ||
                    'FECHA_ORIGINACION_PROD|CUPO|SCORE_O_PUNTAJE_FINAL|CICLO|DEPARTAMENTO|LOCALIDAD|CATEGORIA|DESC_CATEGORIA|' ||
                    'SUBCATEGORIA|DESCR_USO|ESTADO_CUENTA|CUENTA_COBRO|FINANCIACION|PLAN_FINANCIACION|DESC_PLAN|TASA_INTERES|PROGRAMA|' ||
                    'FECHA_ORIGINACION_FIN|FECHA_TERMINACION_FIN|PLAZO_ORIGINACION|CODEUDOR|CUOTAS_COBRADAS|CUOTAS_PAGADAS|' ||
                    'FECHA_ULTIMO_MOV|SALDO_CAPITAL|SALDO_INTERES|SALDO_INTERES_MORA|SALDOCTEFINANCIADO|SALDOCTENOFINANCIADO|TOTAL|' ||
                    'FECHA_PAGO|VALOR_PAGO|FECHA_CASTIGO|VALOR_CASTIGADO|FECHA_CIERRE|MES1|MES2|MES3|MES4|MES5|MES6|MES7|MES8|MES9|' ||
                    'MES10|MES11|MES12|MES13|MES14|MES15|MES16|MES17|MES18|MES19|MES20';
    DBMS_OUTPUT.put_Line('Inicio ' || SYSDATE);
    DBMS_SESSION.free_unused_user_memory;

    --CA 906
    --Se validara si la variable de entrada de directorio es diferente de null y en caso contrario se
    --modificara la ruta definida en el parametro original
    if FBLAPLICAENTREGAXCASO('0000906') then
      if inuDirectory is not null then
        select d.path
          into sbRuta
          from ge_directory d
         where d.directory_id = inuDirectory;
      end if;
    end if;
    --

    FOR rcData IN CurProcesos LOOP
      sbNombre_Archivo := 'Data_Modelo_IFRS_C_' || sbEmpresa || '_' ||
                          LPAD(rcData.Anho, 4, 0) || '_' ||
                          LPAD(rcData.Mes, 2, 0) || '.csv';
      --CA 906
      if FBLAPLICAENTREGAXCASO('0000906') then
        sbNombre_Archivo_zip := 'Data_Modelo_IFRS_C_' || sbEmpresa || '_' ||
                                LPAD(rcData.Anho, 4, 0) || '_' ||
                                LPAD(rcData.Mes, 2, 0) || '.zip';
      end if;
      --
      F := UTL_FILE.FOPEN(sbRuta, sbNombre_Archivo, 'W', 32767);
      UTL_FILE.PUT_LINE(F, sbEncabezado);

      IF CurData%ISOPEN THEN
        CLOSE CurData;
      END IF;

      OPEN CurData(rcData.Anho, rcData.Mes);

      LOOP
        FETCH CurData BULK COLLECT
          INTO vrt_Data LIMIT nuLimit;

        FOR I IN 1 .. vrt_Data.COUNT LOOP
          BEGIN
            UTL_FILE.PUT_LINE(F,
                              vrt_Data(I)
                              .ANO || '|' || vrt_Data(I).MES || '|' || vrt_Data(I).CONTRATO || '|' || vrt_Data(I).PRODUCTO || '|' || vrt_Data(I).TIPO_PRODUCTO || '|' || vrt_Data(I).DESC_TIPO_PRODUCTO || '|' || vrt_Data(I).ALTURA_MORA || '|' || vrt_Data(I).EDAD_DEUDA || '|' ||
                               NVL(vrt_Data(I).SALDO_CORRIENTE, 0) || '|' ||
                               NVL(vrt_Data(I).SALDO_DIFERIDO, 0) || '|' ||
                               NVL(vrt_Data(I).SALDO_TOTAL, 0) || '|' || vrt_Data(I).FECHA_ORIGINACION_PROD || '|' || vrt_Data(I).CUPO || '|' || vrt_Data(I).SCORE_O_PUNTAJE_FINAL || '|' || vrt_Data(I).CICLO || '|' || vrt_Data(I).DEPARTAMENTO || '|' || vrt_Data(I).LOCALIDAD || '|' || vrt_Data(I).CATEGORIA || '|' || vrt_Data(I).DESC_CATEGORIA || '|' || vrt_Data(I).SUBCATEGORIA || '|' || vrt_Data(I).DESCR_USO || '|' || vrt_Data(I).ESTADO_CUENTA || '|' || vrt_Data(I).CUENTA_COBRO || '|' || vrt_Data(I).FINANCIACION || '|' || vrt_Data(I).PLAN_FINANCIACION || '|' || vrt_Data(I).DESC_PLAN || '|' || vrt_Data(I).TASA_INTERES || '|' || vrt_Data(I).PROGRAMA || '|' || vrt_Data(I).FECHA_ORIGINACION_FIN || '|' || vrt_Data(I).FECHA_TERMINACION_FIN || '|' || vrt_Data(I).PLAZO_ORIGINACION || '|' || vrt_Data(I).CODEUDOR || '|' || vrt_Data(I).CUOTAS_COBRADAS || '|' || vrt_Data(I).CUOTAS_PAGADAS || '|' || vrt_Data(I).FECHA_ULTIMO_MOV || '|' ||
                               NVL(vrt_Data(I).SALDO_CAPITAL, 0) || '|' ||
                               NVL(vrt_Data(I).SALDO_INTERES, 0) || '|' ||
                               NVL(vrt_Data(I).SALDO_INTERES_MORA, 0) || '|' ||
                               NVL(vrt_Data(I).SALDOCTEFINANCIADO, 0) || '|' ||
                               NVL(vrt_Data(I).SALDOCTENOFINANCIADO, 0) || '|' ||
                               NVL(vrt_Data(I).TOTAL, 0) || '|' || vrt_Data(I).FECHA_PAGO || '|' ||
                               NVL(vrt_Data(I).VALOR_PAGO, 0) || '|' || vrt_Data(I).FECHA_CASTIGO || '|' ||
                               NVL(vrt_Data(I).VALOR_CASTIGADO, 0) || '|' || vrt_Data(I).FECHA_CIERRE || '|' || vrt_Data(I).MES1 || '|' || vrt_Data(I).MES2 || '|' || vrt_Data(I).MES3 || '|' || vrt_Data(I).MES4 || '|' || vrt_Data(I).MES5 || '|' || vrt_Data(I).MES6 || '|' || vrt_Data(I).MES7 || '|' || vrt_Data(I).MES8 || '|' || vrt_Data(I).MES9 || '|' || vrt_Data(I).MES10 || '|' || vrt_Data(I).MES11 || '|' || vrt_Data(I).MES12 || '|' || vrt_Data(I).MES13 || '|' || vrt_Data(I).MES14 || '|' || vrt_Data(I).MES15 || '|' || vrt_Data(I).MES16 || '|' || vrt_Data(I).MES17 || '|' || vrt_Data(I).MES18 || '|' || vrt_Data(I).MES19 || '|' || vrt_Data(I).MES20);
          EXCEPTION
            WHEN OTHERS THEN
              DBMS_OUTPUT.put_Line(SQLERRM);
          END;
        END LOOP;

        EXIT WHEN CurData%NOTFOUND;
      END LOOP;

      CLOSE CurData;

      DBMS_SESSION.free_unused_user_memory;
      UTL_FILE.FCLOSE(F);
      --CA 906
      --Se comprimira el archivo generado y se eliminara el original
      if FBLAPLICAENTREGAXCASO('0000906') then
        LDC_WF_SENDACTIVITIES.COMPRESSFILE(p_in_file  => sbRuta || '/' ||
                                                         sbNombre_Archivo,
                                           p_out_file => sbRuta || '/' ||
                                                         sbNombre_Archivo_zip);
        utl_file.fremove(location => sbRuta, filename => sbNombre_Archivo);
      end if;
      --
    END LOOP;

  EXCEPTION
    WHEN UTL_FILE.INTERNAL_ERROR THEN
      DBMS_OUTPUT.PUT_LINE('UTL_FILE: Ha ocurrido un error interno.');
      UTL_FILE.FCLOSE_ALL;
    WHEN UTL_FILE.INVALID_FILEHANDLE THEN
      DBMS_OUTPUT.PUT_LINE('UTL_FILE: El identificador del archivo no es v?lido.');
      UTL_FILE.FCLOSE_ALL;
    WHEN UTL_FILE.INVALID_MODE THEN
      DBMS_OUTPUT.PUT_LINE('UTL_FILE: Se dio un modo abierto inv?lido.');
      UTL_FILE.FCLOSE_ALL;
    WHEN UTL_FILE.INVALID_OPERATION THEN
      DBMS_OUTPUT.PUT_LINE('UTL_FILE: Se intent? una operaci?n no v?lida.');
      UTL_FILE.FCLOSE_ALL;
    WHEN UTL_FILE.INVALID_PATH THEN
      DBMS_OUTPUT.PUT_LINE('UTL_FILE: Se dio una ruta inv?lida para el archivo.');
      UTL_FILE.FCLOSE_ALL;
    WHEN UTL_FILE.READ_ERROR THEN
      DBMS_OUTPUT.PUT_LINE('UTL_FILE: A read error occurred.');
      UTL_FILE.FCLOSE_ALL;
    WHEN UTL_FILE.WRITE_ERROR THEN
      DBMS_OUTPUT.PUT_LINE('UTL_FILE: A write error occurred.');
      UTL_FILE.FCLOSE_ALL;
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Some other error occurred. ' || SQLERRM);
      UTL_FILE.FCLOSE_ALL;
  END;

  PROCEDURE VALIDDIRECTORY_ID IS
    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de HORBATH">
    <Unidad> VALIDDIRECTORY_ID </Unidad>
    <Autor> Daniel Valiente </Autor>
    <Fecha> 06-12-2021 </Fecha>
    <Descripcion>
    Servicio para validar las rutas en el PB GENIFRS
    </Descripcion>
    <Parametros>
           <param nombre="" tipo="" Direccion="" default=""> </param>
    </Parametros>
    <Historial>
           <Modificacion Autor="Daniel Valiente" Fecha="06-12-2021" Inc="906" Empresa="HT">
           Creaci¿n del Procedimiento
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    SBDIRECTORYID GE_BOINSTANCECONTROL.STYSBVALUE;
    SBPATH        GE_DIRECTORY.PATH%TYPE;
    SBINSTANCE    GE_BOINSTANCECONTROL.STYSBNAME;
  BEGIN
    SBDIRECTORYID := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE('GE_DIRECTORY',
                                                           'DIRECTORY_ID');
    SBPATH        := DAGE_DIRECTORY.FSBGETPATH(TO_NUMBER(SBDIRECTORYID));
    GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(SBINSTANCE);
    GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(SBINSTANCE,
                                              NULL,
                                              'GE_DIRECTORY',
                                              'PATH',
                                              SBPATH);
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
      RAISE;
    WHEN OTHERS THEN
      ERRORS.SETERROR;
      RAISE EX.CONTROLLED_ERROR;
  END VALIDDIRECTORY_ID;
END pkgLDC_IFRS;
/