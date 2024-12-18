CREATE OR REPLACE PACKAGE LDC_BOIMPRDOCU IS

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas

  Unidad         : LDC_BOIMPRDOCU
  Descripcion    : Paquete que contiene la logica de negocio para la impresion
                   de documentos informativos.
  Autor          : KCienfuegos
  Fecha          : 04-03-2017
  Caso           : CA200-875

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  04-03-2017    KCienfuegos.CA200-875       Creacion
  ******************************************************************/

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas

  Unidad         : validarEjecucion
  Descripcion    : Procedimiento que realiza las siguientes validaciones sobre la forma LDCIDO:
                   1- Que el per?odo a procesar sea el actual para el ciclo
                   2- Que haya finalizado el proceso FGCC para el per?odo que se va a procesar
                   3- Que el proceso LDCIDO no est? en ejecuci?n
                   4- Que el proceso LDCIDO no est? programado para el per?odo
  
  Autor          : KCienfuegos
  Fecha          : 06-03-2017
  Caso           : CA200-875

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  06-03-2017    KCienfuegos.CA200-875        Creacion
  ******************************************************************/
  PROCEDURE validarEjecucion(inuPeriodo    IN    perifact.pefacodi%TYPE,
                             inuCiclo      IN    perifact.pefacicl%TYPE);
                             
  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas

  Unidad         : fnuObtenerDatos
  Descripcion    : Funcion para obtener los contratos a procesar en LDCIDO.
  
  Autor          : KCienfuegos
  Fecha          : 06-03-2017
  Caso           : CA200-875

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  06-03-2017    KCienfuegos.CA200-875        Creacion
  ******************************************************************/
  FUNCTION fnuObtenerDatos(inuPeriodo       IN    perifact.pefacodi%TYPE,
                           inuTotalHilos    IN    NUMBER,
                           isbPrograma      IN    estaprog.esprprog%TYPE)
  RETURN NUMBER;
  
  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas

  Unidad         : fnuContarContratos
  Descripcion    : Funcion para obtener la cantidad de contratos a procesar en LDCIDO.
  
  Autor          : KCienfuegos
  Fecha          : 06-03-2017
  Caso           : CA200-875

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  06-03-2017    KCienfuegos.CA200-875        Creacion
  ******************************************************************/
  FUNCTION fnuContarContratos(inuHilo      IN    NUMBER,
                              isbPrograma  IN    estaprog.esprprog%TYPE)
  RETURN NUMBER;
  
  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas

  Unidad         : fnuObtUltProcEjecucion
  Descripcion    : Funcion para obtener el ultimo proceso en ejecucion(LDCIDO).
  
  Autor          : KCienfuegos
  Fecha          : 06-03-2017
  Caso           : CA200-875

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  06-03-2017    KCienfuegos.CA200-875        Creacion
  ******************************************************************/
  FUNCTION fnuObtUltProcEjecucion(inuPeriodo   IN   procejec.prejcope%TYPE)
   RETURN NUMBER;
  
  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas

  Unidad         : imprimirDocumentos
  Descripcion    : Metodo para la impresion de documentos
  
  Autor          : KCienfuegos
  Fecha          : 06-03-2017
  Caso           : CA200-875

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  06-03-2017    KCienfuegos.CA200-875        Creacion
  ******************************************************************/
  PROCEDURE imprimirDocumentos(inuPeriodo                 IN    perifact.pefacodi%TYPE,  
                               inuHilo                    IN    NUMBER, 
                               isbPrograma                IN    estaprog.esprprog%TYPE, 
                               isbRutaArchivo             IN    VARCHAR2,
                               inuReportInco              IN    repoinco.reinrepo%TYPE, 
                               onuCodigoError             OUT   ge_error_log.error_log_id%TYPE, 
                               osbMensajeError            OUT   ge_error_log.description%TYPE);
                               
  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas

  Unidad         : fsbGenerarOrdenEntrega
  Descripcion    : Metodo para generar orden de entrega del documento informativo
  
  Autor          : KCienfuegos
  Fecha          : 08-03-2017
  Caso           : CA200-875

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  08-03-2017    KCienfuegos.CA200-875        Creacion
  ******************************************************************/
  FUNCTION fsbGenerarOrdenEntrega
    RETURN VARCHAR2;
  
END LDC_BOIMPRDOCU;
/
CREATE OR REPLACE PACKAGE BODY LDC_BOIMPRDOCU IS

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas

  Unidad         : LDC_BOIMPRDOCU
  Descripcion    : Paquete que contiene la logica de negocio para la impresion
                   de documentos informativos.
  Autor          : KCienfuegos
  Fecha          : 04-03-2017
  Caso           : CA200-875

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  04-03-2017    KCienfuegos.CA200-875       Creacion
  ******************************************************************/

  --Constantes
  csbPaquete                  CONSTANT     VARCHAR2(60) := 'LDC_BOIMPRDOCU';
  cnuCodigoError              CONSTANT     NUMBER       := 2741;
  cnuMaxRegistros             CONSTANT     NUMBER := 1024;
  cnuZonaPorDefecto           CONSTANT     NUMBER := 0;
  cnuMaxCaracteres            CONSTANT     NUMBER := 32000;
  cnuActDirInst               CONSTANT     NUMBER := 4000803;
  cnuActDirCobro              CONSTANT     NUMBER := 4000998;
  cnuActImpresionDoc          CONSTANT     NUMBER :=  ge_boparameter.fnuget('ACTI_IMPR_DOCU');
  csbFGCC                     CONSTANT     sa_executable.name%TYPE := 'FGCC';
  csbLDCIDO                   CONSTANT     sa_executable.name%TYPE := 'LDCIDO';
  csbFIDF                     CONSTANT     sa_executable.name%TYPE := 'FIDF';
  cnuFormato                  CONSTANT     ed_formato.formcodi%TYPE := dald_parameter.fnuGetNumeric_Value('LDC_FOREXT_DATO_INF',0);
  cnuMeses                    CONSTANT     NUMBER:= dald_parameter.fnuGetNumeric_Value('NUM_MESES_RP_IMPDOC',0);
  cnuValorReclamo             CONSTANT     NUMBER:= dald_parameter.fnuGetNumeric_Value('VAL_RECL_LDCIDO',0);
  cnuSaldoFavor               CONSTANT     NUMBER:= dald_parameter.fnuGetNumeric_Value('SALD_FAVOR_LDCIDO',0);
  
  --Globales
  gnuTotalContratos                        NUMBER:=0;
  gnuProceso                               procesos.proccons%TYPE;
  
  
  sbError                                  ge_error_log.description%TYPE;

  -- Tipos
  TYPE tyrcArchivosPorZona IS RECORD
  (sbArchivo VARCHAR2(300),
   nuCantContratos NUMBER := 0);
   
  TYPE tytbArchivosPorZona IS TABLE OF tyrcArchivosPorZona INDEX BY VARCHAR2(20);
  
  TYPE tyrcArchivo IS RECORD
  (sbNombre VARCHAR2(300),
   fArchivo utl_file.file_type);
   
  TYPE tytbArchivo IS TABLE OF tyrcArchivo INDEX BY BINARY_INTEGER;
    
  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas

  Unidad         : validarEjecucion
  Descripcion    : Procedimiento que realiza las siguientes validaciones sobre la forma LDCIDO:
                   1- Que el periodo a procesar sea el actual para el ciclo
                   2- Que haya finalizado el proceso FGCC para el periodo que se va a procesar
                   3- Que el proceso LDCIDO no este en ejecucion
                   4- Que el proceso LDCIDO no este programado para el periodo
  
  Autor          : KCienfuegos
  Fecha          : 06-03-2017
  Caso           : CA200-875

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  06-03-2017    KCienfuegos.CA200-875        Creacion
  ******************************************************************/
  PROCEDURE validarEjecucion(inuPeriodo    IN    perifact.pefacodi%TYPE,
                             inuCiclo      IN    perifact.pefacicl%TYPE)
  IS
     sbProceso              VARCHAR2(500) := 'validarEjecucion';
     sbError                VARCHAR2(4000);

  BEGIN
      
      ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso,10);
      
      -- Se valida que el periodo a procesar corresponda al actual del ciclo
      IF(NOT ldc_bcimprdocu.fblPeriodoFactActual(inuPeriodo, inuCiclo))THEN
         sbError := 'El periodo '||inuPeriodo||' no corresponde al periodo actual del ciclo '||inuCiclo;
         RAISE ex.Controlled_Error;
      END IF;
      
      -- Se valida que FGCC haya sido ejecutado para el periodo
      IF(NOT ldc_bcimprdocu.fblProgramaEjecutado(inuPeriodo, csbFGCC))THEN
         sbError := 'No se ha ejecutado el '||csbFGCC||' para el periodo de facturacion '||inuPeriodo;
         RAISE ex.Controlled_Error;
      END IF;
      
      -- Se valida que LDCIDO no este en ejecucion para el periodo
      IF(ldc_bcimprdocu.fblProgramaEnEjecucion(inuPeriodo, csbLDCIDO))THEN
         sbError := 'El proceso '||csbLDCIDO||' ya se encuentra en ejecucion para el periodo de facturacion '||inuPeriodo;
         RAISE ex.Controlled_Error;
      END IF;
      
      -- Se valida que LDCIDO no este programado
      IF(ldc_bcimprdocu.fblProcProgramadoPorPer(inuPeriodo, csbLDCIDO))THEN
         sbError := 'El proceso '||csbLDCIDO||' ya se encuentra programado para el periodo de facturacion '||inuPeriodo;
         RAISE ex.Controlled_Error;
      END IF;
      
  EXCEPTION
      WHEN ex.CONTROLLED_ERROR THEN
          ut_trace.trace('TERMINO CON ERROR ' || csbPaquete || '.' || sbProceso||' '||sbError,10);
          IF(sbError IS NOT NULL)THEN
             ERRORS.SETERROR(inuapperrorcode => cnuCodigoError, isbargument => sbError);
          END IF;
          RAISE ex.CONTROLLED_ERROR;
      WHEN OTHERS THEN
          ut_trace.trace('TERMINO CON ERROR NO CONTROLADO '|| csbPaquete || '.' || sbProceso ||' '||SQLERRM,10);
          Errors.setError;
          RAISE ex.CONTROLLED_ERROR;
  END;
  
  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas

  Unidad         : fnuObtenerDatos
  Descripcion    : Funcion para obtener la cantidad de registros a procesar en LDCIDO.
  
  Autor          : KCienfuegos
  Fecha          : 06-03-2017
  Caso           : CA200-875

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  06-03-2017    KCienfuegos.CA200-875        Creacion
  ******************************************************************/
  FUNCTION fnuObtenerDatos(inuPeriodo       IN    perifact.pefacodi%TYPE,
                           inuTotalHilos    IN    NUMBER,
                           isbPrograma      IN    estaprog.esprprog%TYPE)
   RETURN NUMBER IS
   
     sbProceso              VARCHAR2(500) := 'fnuObtenerDatos';
     sbError                VARCHAR2(4000);
     nuCiclo                perifact.pefacicl%TYPE;
     nuTotalRegistros       NUMBER:= 0;
     sbSelect               VARCHAR2(30000);
     sbFrom                 VARCHAR2(3000);
     sbWhere                VARCHAR2(8000);

  BEGIN
      
      ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso,10);
      
      nuCiclo := pktblperifact.fnugetcycle(inuPeriodo);
      
      sbSelect := 'SELECT sesususc, sesunuse, count(sesunuse) over () cant_fila';
      sbFrom   := 'servsusc, suscripc, confesco';
      sbWhere  := 'WHERE susccicl = :inuCiclo '|| CHR(10);
      sbWhere  := sbWhere || 'AND sesususc = susccodi '|| CHR(10)||
                  'AND coecserv = sesuserv '|| CHR(10)||
                  'AND coeccodi = sesuesco '|| CHR(10)||
                  'AND coecfact = ''S'' '|| CHR(10)||
                  'AND (sesusafa > :nuSaldoFavor OR EXISTS (SELECT 1 FROM cuencobr WHERE cuconuse=sesunuse AND cucovare> :nuValorReclamo) OR LDC_GETEDADRP(sesunuse) >= :nuMeses)'|| CHR(10)||
                  'AND NOT EXISTS (SELECT ''x'''|| CHR(10)||
                  'FROM cuencobr, factura'|| CHR(10)||
                  'WHERE cucofact = factcodi'|| CHR(10)||
                  'AND cuconuse = sesunuse'|| CHR(10)||
                  'AND factpefa = :inuFactPefa)'|| CHR(10)||
                  'AND NOT EXISTS (SELECT 1 FROM factura WHERE factsusc = susccodi AND factpefa = :inuFactPefa AND factprog = 6)';               
      
      EXECUTE IMMEDIATE 'INSERT INTO ldc_imprdocu' || CHR(10) || '(' || CHR(10) || 
                        'SELECT' || CHR(10) || 'trunc(decode(rownum,cant_fila,rownum-1,rownum)/(cant_fila/:inuTotalHilos))+1,' || CHR(10) ||
                        'rownum,' || CHR(10) || ':isbPrograma, sesususc, sesunuse FROM(' || CHR(10) || sbSelect || CHR(10) || 'FROM' || CHR(10) ||
                        sbFrom || CHR(10) || sbWhere|| '))'
      USING IN inuTotalHilos, IN isbPrograma, IN nuCiclo, cnuSaldoFavor, cnuValorReclamo, IN cnuMeses, IN inuPeriodo, IN inuPeriodo;
                        
      nuTotalRegistros := SQL%ROWCOUNT;

      ut_trace.trace('Cantidad de registros a procesar: '||nuTotalRegistros,10);
      
      ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso,10);
      
      RETURN nuTotalRegistros;
      
  EXCEPTION
      WHEN ex.CONTROLLED_ERROR THEN
          ut_trace.trace('TERMINO CON ERROR ' || csbPaquete || '.' || sbProceso||' '||sbError,10);
          IF(sbError IS NOT NULL)THEN
             ERRORS.SETERROR(inuapperrorcode => cnuCodigoError, isbargument => sbError);
          END IF;
          RAISE ex.CONTROLLED_ERROR;
      WHEN OTHERS THEN
          ut_trace.trace('TERMINO CON ERROR NO CONTROLADO '|| csbPaquete || '.' || sbProceso ||' '||SQLERRM,10);
          dbms_output.put_line('Error: '||SQLERRM);
          Errors.setError;
          RAISE ex.CONTROLLED_ERROR;
  END;
  
  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas

  Unidad         : fnuContarContratos
  Descripcion    : Funcion para obtener la cantidad de contratos a procesar en LDCIDO.
  
  Autor          : KCienfuegos
  Fecha          : 06-03-2017
  Caso           : CA200-875

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  06-03-2017    KCienfuegos.CA200-875        Creacion
  ******************************************************************/
  FUNCTION fnuContarContratos(inuHilo    IN    NUMBER,
                              isbPrograma      IN    estaprog.esprprog%TYPE)
   RETURN NUMBER IS
   
     sbProceso              VARCHAR2(500) := 'fnuContarContratos';
     sbError                VARCHAR2(4000);
     nuTotalContratos       NUMBER:= 0;
     
      CURSOR cuContratosPorHilo IS
       SELECT COUNT(DISTINCT imdosusc)
         FROM ldc_imprdocu
        WHERE imdopart = inuHilo 
          AND imdoprog = isbPrograma;
     
    BEGIN
      ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso,10);
      
      pkerrors.push(csbPaquete || '.' || sbProceso);
      
      OPEN cuContratosPorHilo;
      FETCH cuContratosPorHilo INTO nuTotalContratos;
      CLOSE cuContratosPorHilo;
      
      gnuTotalContratos := nuTotalContratos;

      ut_trace.trace('Cantidad de registros a procesar: '||nuTotalContratos,10);
      
      ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso,10);
      
      pkerrors.pop;
      
      RETURN nuTotalContratos;
      
  EXCEPTION
      WHEN ex.CONTROLLED_ERROR THEN
          ut_trace.trace('TERMINO CON ERROR ' || csbPaquete || '.' || sbProceso||' '||sbError,10);
          IF(sbError IS NOT NULL)THEN
             ERRORS.SETERROR(inuapperrorcode => cnuCodigoError, isbargument => sbError);
          END IF;
          RAISE ex.CONTROLLED_ERROR;
      WHEN OTHERS THEN
          ut_trace.trace('TERMINO CON ERROR NO CONTROLADO '|| csbPaquete || '.' || sbProceso ||' '||SQLERRM,10);
          Errors.setError;
          RAISE ex.CONTROLLED_ERROR;
  END;
  
  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas

  Unidad         : fnuObtUltProcEjecucion
  Descripcion    : Funcion para obtener el ultimo proceso en ejecucion(LDCIDO).
  
  Autor          : KCienfuegos
  Fecha          : 06-03-2017
  Caso           : CA200-875

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  06-03-2017    KCienfuegos.CA200-875        Creacion
  ******************************************************************/
  FUNCTION fnuObtUltProcEjecucion(inuPeriodo   IN   procejec.prejcope%TYPE)
   RETURN NUMBER IS
   
     sbProceso              VARCHAR2(500) := 'fnuObtUltProcEjecucion';
     sbError                VARCHAR2(4000);
     nuInfoAdicional        procejec.prejinad%TYPE;
     nuProceso              procejec.prejidpr%TYPE;
  BEGIN
      
      ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso,10);
      
      pkerrors.push(csbPaquete || '.' || sbProceso);
      
      pkexecutedprocessmgr.getlastexecutedproc
      (
           csbLDCIDO,
           inuPeriodo,
           nuProceso,
           nuInfoAdicional
      );          
      
      ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso,10);
      
      pkerrors.pop;
      
      RETURN nuProceso;
      
  EXCEPTION
      WHEN ex.CONTROLLED_ERROR THEN
          ut_trace.trace('TERMINO CON ERROR ' || csbPaquete || '.' || sbProceso||' '||sbError,10);
          IF(sbError IS NOT NULL)THEN
             ERRORS.SETERROR(inuapperrorcode => cnuCodigoError, isbargument => sbError);
          END IF;
          RAISE ex.CONTROLLED_ERROR;
      WHEN OTHERS THEN
          ut_trace.trace('TERMINO CON ERROR NO CONTROLADO '|| csbPaquete || '.' || sbProceso ||' '||SQLERRM,10);
          Errors.setError;
          RAISE ex.CONTROLLED_ERROR;
  END;
  
  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas

  Unidad         : fblImprimirContrato
  Descripcion    : Funcion para validar si el contrato se debe imprimir.
  
  Autor          : KCienfuegos
  Fecha          : 06-03-2017
  Caso           : CA200-875

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  06-03-2017    KCienfuegos.CA200-875        Creacion
  ******************************************************************/
  FUNCTION fblImprimirContrato(inuContrato   IN   suscripc.susccodi%TYPE,
                               inuPeriodo    IN   perifact.pefacodi%TYPE,
                               inuCiclo      IN   ciclo.ciclcodi%TYPE)
   RETURN BOOLEAN IS
   
     sbProceso              VARCHAR2(500) := 'fblImprimirContrato';
     sbError                VARCHAR2(4000);
     nuResultado            NUMBER;
     
     CURSOR cuEvalCondiciones IS
       SELECT 1
         FROM servsusc, suscripc, confesco
        WHERE sesususc = susccodi
          AND susccodi = inuContrato
          AND susccicl = inuCiclo
          AND coecserv = sesuserv
          AND coeccodi = sesuesco
          AND coecfact = 'S'
          AND (sesusafa > 0 OR EXISTS
               (SELECT 1
                  FROM cuencobr
                 WHERE cuconuse = sesunuse
                   AND cucovare > 0) OR ldc_getedadrp(sesunuse) >= cnuMeses)
          AND NOT EXISTS (SELECT 'x'
                           FROM cuencobr, factura
                          WHERE cucofact = factcodi
                            AND cuconuse = sesunuse
                            AND factprog = 6
                            AND factpefa = inuPeriodo)
          AND NOT EXISTS (SELECT 1
                           FROM factura
                          WHERE factsusc = susccodi
                            AND factpefa = inuPeriodo
                            AND factprog = 6);
     
  BEGIN
      
      ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso,10);
      
      OPEN cuEvalCondiciones;
      FETCH cuEvalCondiciones INTO nuResultado;
      
      IF(cuEvalCondiciones%FOUND)THEN
         CLOSE cuEvalCondiciones;
         RETURN TRUE;
      END IF;
      
      CLOSE cuEvalCondiciones;
      
      RETURN FALSE;
      
  EXCEPTION
      WHEN ex.CONTROLLED_ERROR THEN
          ut_trace.trace('TERMINO CON ERROR ' || csbPaquete || '.' || sbProceso||' '||sbError,10);
          IF(sbError IS NOT NULL)THEN
             ERRORS.SETERROR(inuapperrorcode => cnuCodigoError, isbargument => sbError);
          END IF;
          RAISE ex.CONTROLLED_ERROR;
      WHEN OTHERS THEN
          ut_trace.trace('TERMINO CON ERROR NO CONTROLADO '|| csbPaquete || '.' || sbProceso ||' '||SQLERRM,10);
          Errors.setError;
          RAISE ex.CONTROLLED_ERROR;
  END;
  
  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas

  Unidad         : obtenerContratosPorHilo
  Descripcion    : Metodo para obtener los contratos por hilo y programa
  
  Autor          : KCienfuegos
  Fecha          : 06-03-2017
  Caso           : CA200-875

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  06-03-2017    KCienfuegos.CA200-875        Creacion
  ******************************************************************/
  PROCEDURE obtenerContratosPorHilo(inuHilo               IN   NUMBER, 
                                    isbPrograma           IN   estaprog.esprprog%TYPE, 
                                    inuFila               IN   NUMBER, 
                                    otbContratos          OUT  daldc_imprdocu.tytbLDC_IMPRDOCU,
                                    oblExistenRegistros   OUT  BOOLEAN)
    IS
     sbProceso              VARCHAR2(500) := 'obtenerContratosPorHilo';
     sbError                VARCHAR2(4000);
     sbQuery                VARCHAR2(4000);
     crContratos            pkconstante.tyrefcursor;
    BEGIN
      ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso,10);
      
      pkerrors.push(csbPaquete || '.' || sbProceso);
      
      sbQuery := 'SELECT ldc_imprdocu.*, rowid FROM ldc_imprdocu WHERE imdopart = :inuHilo AND imdoprog = :isbPrograma AND imdofila> :inuFila' ;
      
      IF (crContratos%ISOPEN) THEN
         CLOSE crContratos;
      END IF;
      
      oblExistenRegistros := TRUE;
      
      OPEN crContratos
           FOR sbQuery USING inuHilo, isbPrograma, inuFila;
      FETCH crContratos
         BULK COLLECT INTO otbContratos
         LIMIT cnuMaxRegistros;
         
      IF (crContratos%NOTFOUND) THEN
         oblExistenRegistros := FALSE;
      END IF;
      
      CLOSE crContratos;
      
      pkerrors.pop;
      
      ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso,10);
      
    EXCEPTION
      WHEN ex.CONTROLLED_ERROR THEN
          ut_trace.trace('TERMINO CON ERROR ' || csbPaquete || '.' || sbProceso||' '||sbError,10);
          IF(sbError IS NOT NULL)THEN
             ERRORS.SETERROR(inuapperrorcode => cnuCodigoError, isbargument => sbError);
          END IF;
          RAISE ex.CONTROLLED_ERROR;
      WHEN OTHERS THEN
          ut_trace.trace('TERMINO CON ERROR NO CONTROLADO '|| csbPaquete || '.' || sbProceso ||' '||SQLERRM,10);
          Errors.setError;
          RAISE ex.CONTROLLED_ERROR;
  END;
  
  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas

  Unidad         : borrarDatosTemporales
  Descripcion    : Metodo para borrar los datos temporales de la impresion de documentos.
  
  Autor          : KCienfuegos
  Fecha          : 07-03-2017
  Caso           : CA200-875

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  07-03-2017    KCienfuegos.CA200-875        Creacion
  ******************************************************************/
  PROCEDURE borrarDatosTemporales(isbPrograma    IN   ldc_imprdocu.imdoprog%TYPE, 
                                  inuParticion   IN   ldc_imprdocu.imdopart%TYPE )
    IS
      sbProceso              VARCHAR2(500) := 'borrarDatosTemporales';
      sbError                VARCHAR2(4000);
      sbQuery                VARCHAR2(2000);
    BEGIN
      ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso,10);
      pkerrors.push(csbPaquete || '.' || sbProceso);
      
      sbQuery := 'DELETE ldc_imprdocu WHERE imdoprog = :isbPrograma AND imdopart = :inuParticion';
      EXECUTE IMMEDIATE sbQuery USING IN isbPrograma, IN inuParticion;
      
      ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso,10);
      pkerrors.pop;
    EXCEPTION
      WHEN ex.CONTROLLED_ERROR THEN
          ut_trace.trace('TERMINO CON ERROR ' || csbPaquete || '.' || sbProceso||' '||sbError,10);
          IF(sbError IS NOT NULL)THEN
             ERRORS.SETERROR(inuapperrorcode => cnuCodigoError, isbargument => sbError);
          END IF;
          RAISE ex.CONTROLLED_ERROR;
      WHEN OTHERS THEN
          ut_trace.trace('TERMINO CON ERROR NO CONTROLADO '|| csbPaquete || '.' || sbProceso ||' '||SQLERRM,10);
          Errors.setError;
          RAISE ex.CONTROLLED_ERROR;
  END;
   
  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas

  Unidad         : registrarIncosistencia
  Descripcion    : Metodo para registrar inconsistencias ocurridas durante la impresi?n
                   de datos de un contrato.
  
  Autor          : KCienfuegos
  Fecha          : 07-03-2017
  Caso           : CA200-875

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  07-03-2017    KCienfuegos.CA200-875        Creacion
  ******************************************************************/
  PROCEDURE registrarIncosistencia(inuContrato    IN      suscripc.susccodi%TYPE,
                                   inuRepoInco    IN      repoinco.reinrepo%TYPE, 
                                   inuPeriodo     IN      perifact.pefacodi%TYPE,
                                   isbPrograma    IN      estaprog.esprprog%TYPE,
                                   isbError       IN      ge_error_log.description%TYPE)
    IS
      sbProceso              VARCHAR2(500) := 'registrarIncosistencia';
      sbError                VARCHAR2(4000);
      nuItem                 ed_item.itemcodi%TYPE;
      sbMensaje              repoinco.reinobse%TYPE;
      sbTipoUnidad           incofact.infatiup%TYPE;
      nuUnidad               incofact.infaunpr%TYPE;
      rcRepoinco             repoinco%ROWTYPE;
      
    BEGIN
      
      ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso,10);
      pkerrors.push(csbPaquete || '.' || sbProceso);
      
      gnuProceso := ge_bcprocesos.Fnugetprocess(csbLDCIDO);
      
      IF(inuRepoInco IS NOT NULL)THEN
         nuItem := pkbodataextractor.fnugetcurrentitem;
         
         IF(nuItem IS NULL)THEN
           sbMensaje := 'Error imprimiendo documento informativo(LDCIDO), para el contrato ['||inuContrato||']: '||isbError;
           sbTipoUnidad := fa_bcincofact.csbtipo_contrato;
           nuUnidad     := inuContrato;
         ELSE
           sbMensaje := 'Error imprimiendo documento informativo(LDCIDO), para el contrato ['||inuContrato||']. Se presento error al ejecutar'||
                        'la regla del item ['||nuItem||']: '||isbError;
           sbTipoUnidad := fa_bcincofact.csbtipo_item;
           nuUnidad     := nuItem;
         END IF;
         
         ut_trace.trace('Inconsistencia: ' || sbMensaje,10);
         
         rcRepoinco.reincodi := pkgeneralservices.fnugetnextsequenceval('SQ_REPOINCO_REINCODI');
         rcRepoinco.reinrepo := inuRepoInco;
         rcRepoinco.reindat1 := SYSDATE;
         rcRepoinco.reinobse := sbMensaje;
         pkreportsincmgr.insertreportline(rcRepoinco);
         fa_boincofact.reportinconsistency(isbPrograma, gnuProceso, sbTipoUnidad, nuUnidad, '-', sbMensaje, inuPeriodo, NULL);
      
      END IF;
      
      ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso,10);
      pkerrors.pop;
      
    EXCEPTION
      WHEN ex.CONTROLLED_ERROR THEN
          ut_trace.trace('TERMINO CON ERROR ' || csbPaquete || '.' || sbProceso||' '||sbError,10);
          IF(sbError IS NOT NULL)THEN
             ERRORS.SETERROR(inuapperrorcode => cnuCodigoError, isbargument => sbError);
          END IF;
          RAISE ex.CONTROLLED_ERROR;
      WHEN OTHERS THEN
          ut_trace.trace('TERMINO CON ERROR NO CONTROLADO '|| csbPaquete || '.' || sbProceso ||' '||SQLERRM,10);
          Errors.setError;
          RAISE ex.CONTROLLED_ERROR;
  END;
   
  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas

  Unidad         : imprimirContrato
  Descripcion    : Metodo para imprimir el documento por contrato
  
  Autor          : KCienfuegos
  Fecha          : 07-03-2017
  Caso           : CA200-875

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  07-03-2017    KCienfuegos.CA200-875        Creacion
  ******************************************************************/
  PROCEDURE imprimirContrato(inuContrato    IN      suscripc.susccodi%TYPE, 
                             ircArchivo     IN OUT  tyrcArchivo,
                             inuPeriodo     IN      perifact.pefacodi%TYPE,
                             inuReportInco  IN      repoinco.reinrepo%TYPE, 
                             isbPrograma    IN      estaprog.esprprog%TYPE)
    IS
      sbProceso              VARCHAR2(500) := 'imprimirContrato';
      sbError                VARCHAR2(4000);
      clDatos                CLOB;
      sbDatos                VARCHAR2(32000);
      nuPosicion             NUMBER := 1;
    BEGIN
      
    dbms_output.put_line('inuContrato '||inuContrato);
    
      ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso,10);
      pkerrors.push(csbPaquete || '.' || sbProceso);
      
      IF(NVL(pkerrors.fsbgetapplication, pkconstante.nullsb) = csbLDCIDO)THEN
        BEGIN
           -- Se instancia la informacion del contrato
           pkbodataextractor.instancebaseentity(inuContrato, 'SUSCRIPC', pkconstante.verdadero);
           
           -- Se setea el clob
           clDatos := EMPTY_CLOB();
           
           -- Se ejecuta el formato de extraccion
           pkbodataextractor.executerules(cnuFormato, clDatos);
           
           -- Si el CLOB no es nulo se escriben los datos en el archivo
           IF(NOT ut_lob.bllobclob_isnull(clDatos))THEN
              LOOP
                 sbDatos := dbms_lob.substr(clDatos, cnuMaxCaracteres, nuPosicion);
                 EXIT WHEN sbDatos IS NULL;
                 nuPosicion := nuPosicion + LENGTH(sbDatos);
                 utl_file.put(ircArchivo.fArchivo, sbDatos);
                 utl_file.fflush(ircArchivo.fArchivo);
                 sbDatos := NULL;
              END LOOP;
           END IF;
        EXCEPTION
          WHEN ex.CONTROLLED_ERROR THEN
            registrarIncosistencia(inuContrato, inuReportInco,  inuPeriodo, isbPrograma, pkerrors.fsbgeterrormessage);
          WHEN OTHERS THEN
            registrarIncosistencia(inuContrato, inuReportInco,  inuPeriodo, isbPrograma, pkerrors.fsbgeterrormessage);
            pkerrors.notifyerror(NULL, SQLERRM, sbError);
        END;
      END IF;
      
      ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso,10);
      pkerrors.pop;
      
  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      ut_trace.trace('TERMINO CON ERROR ' || csbPaquete || '.' || sbProceso||' '||sbError,10);
      clDatos := empty_clob();
      IF(sbError IS NOT NULL)THEN
         errors.seterror(inuapperrorcode => cnuCodigoError, isbargument => sbError);
      END IF;
      RAISE;
    WHEN OTHERS THEN
      ut_trace.trace('TERMINO CON ERROR NO CONTROLADO '|| csbPaquete || '.' || sbProceso ||' '||SQLERRM,10);
      clDatos := empty_clob();
      pkerrors.notifyerror(NULL, SQLERRM, sbError);
      raise_application_error(PKCONSTANTE.NUERROR_LEVEL2, sbError);
  END;
  
  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas

  Unidad         : imprimirDocumentos
  Descripcion    : Metodo para la impresion de documentos
  
  Autor          : KCienfuegos
  Fecha          : 06-03-2017
  Caso           : CA200-875

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  06-03-2017    KCienfuegos.CA200-875        Creacion
  ******************************************************************/
  PROCEDURE imprimirDocumentos(inuPeriodo                 IN    perifact.pefacodi%TYPE,  
                               inuHilo                    IN    NUMBER, 
                               isbPrograma                IN    estaprog.esprprog%TYPE, 
                               isbRutaArchivo             IN    VARCHAR2,
                               inuReportInco              IN    repoinco.reinrepo%TYPE, 
                               onuCodigoError             OUT   ge_error_log.error_log_id%TYPE, 
                               osbMensajeError            OUT   ge_error_log.description%TYPE)
   IS
   
     sbProceso              VARCHAR2(500) := 'imprimirDocumentos';
     sbError                VARCHAR2(4000);
     sbRutaArchivo          VARCHAR2(500);
     nuMaxArchAbiertos      NUMBER;
     nuLineaMinima          NUMBER:= 0;
     nuContratoIndex        NUMBER;
     nuTotalContratos       NUMBER;
     nuContContratos        NUMBER:= 0;
     nuPorcentaje           NUMBER;
     tbContratos            daldc_imprdocu.tytbLDC_IMPRDOCU;
     tbArchivo              tytbArchivosPorZona;
     tbArchivosAbiertos     tytbArchivo;
     rcArchivoActual        tyrcArchivo;
     rcPerifact             perifact%ROWTYPE;
     nuContrato             suscripc.susccodi%TYPE;
     nuRuta                 or_route.route_id%TYPE;
     nuDireccion            ab_address.address_id%TYPE;
     nuZona                 or_operating_zone.operating_zone_id%TYPE;
     nuGrupoRecaudo         ca_suscgrre.sugrgrre%TYPE;
     tbGrupoRecaudo         pktblsuscripc.tysusccodi;
     blQuedanRegistros      BOOLEAN;
     
     PROCEDURE inicializar
      /*****************************************************************
      Propiedad intelectual de Gascaribe-Efigas

      Unidad         : inicializar
      Descripcion    : Metodo para la inicializar datos

      Historia de Modificaciones
      Fecha         Autor                         Modificacion
      ===============================================================
      06-03-2017    KCienfuegos.CA200-875        Creacion
      ******************************************************************/
       IS
         sbiProceso             VARCHAR2(500) := 'inicializar';
       BEGIN
         ut_trace.trace(csbPaquete || '.' || sbProceso || '.' ||sbiProceso, 10);
         
         pkerrors.initialize;
         onuCodigoError := pkconstante.exito;
         osbMensajeError := pkconstante.nullsb;
         pkerrors.setapplication(csbLDCIDO);
         tbContratos.delete;
         tbArchivo.delete;
         tbArchivosAbiertos.delete;
         rcPerifact := pktblperifact.frcgetrecord(inuPeriodo);
         nuMaxArchAbiertos := FLOOR(30/pkgeneralparametersmgr.fnugetnumbervalue('FIFA_TRHEADS'));
         sbRutaArchivo := /*NVL(*/isbRutaArchivo/*,'/smartfiles/Facturacion/Carvajal')*/;
         
         ut_trace.trace(csbPaquete || '.' || sbProceso || '.' ||sbiProceso, 10);
       EXCEPTION
         WHEN ex.CONTROLLED_ERROR THEN
          ut_trace.trace('TERMINO CON ERROR ' || csbPaquete || '.' || sbProceso || '.' ||'inicializar'||' '||sbError,10);
          IF(sbError IS NOT NULL)THEN
             ERRORS.SETERROR(inuapperrorcode => cnuCodigoError, isbargument => sbError);
          END IF;
          RAISE ex.CONTROLLED_ERROR;
      WHEN OTHERS THEN
          ut_trace.trace('TERMINO CON ERROR NO CONTROLADO '|| csbPaquete || '.' || sbProceso || '.' ||'inicializar'||' '||SQLERRM,10);
          Errors.setError;
          RAISE ex.CONTROLLED_ERROR;
      END inicializar;
      
      PROCEDURE cerrarArchivos
        /*****************************************************************
        Propiedad intelectual de Gascaribe-Efigas

        Unidad         : cerrarArchivos
        Descripcion    : Metodo para cerrar los archivos abiertos

        Historia de Modificaciones
        Fecha         Autor                         Modificacion
        ===============================================================
        06-03-2017    KCienfuegos.CA200-875        Creacion
        ******************************************************************/
       IS
        sbiProceso             VARCHAR2(500) := 'cerrarArchivos';
        sbError                VARCHAR2(4000);

       BEGIN
         
         ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso||'.'||sbiProceso,10);
         
         IF (tbArchivosAbiertos.COUNT > 0) THEN
            FOR i IN tbArchivosAbiertos.FIRST..tbArchivosAbiertos.LAST LOOP
               ge_bofilemanager.fileclose(tbArchivosAbiertos(i).fArchivo);
            END LOOP;
         END IF;
         
         ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso||'.'||sbiProceso,10);
         
       EXCEPTION
         WHEN ex.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || csbPaquete || '.' || sbProceso||' '||sbError,10);
            IF(sbError IS NOT NULL)THEN
               ERRORS.SETERROR(inuapperrorcode => cnuCodigoError, isbargument => sbError);
            END IF;
            RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO '|| csbPaquete || '.' || sbProceso ||' '||SQLERRM,10);
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;

      END cerrarArchivos;

      PROCEDURE abrirArchivo(isbArchivo    IN   VARCHAR2)
        /*****************************************************************
        Propiedad intelectual de Gascaribe-Efigas

        Unidad         : abrirArchivo
        Descripcion    : Metodo para abrir/crear archivos

        Historia de Modificaciones
        Fecha         Autor                         Modificacion
        ===============================================================
        06-03-2017    KCienfuegos.CA200-875        Creacion
        ******************************************************************/
      IS
       sbiProceso              VARCHAR2(500) := 'abrirArchivo';
       sbError                VARCHAR2(4000);

      BEGIN
        ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso||'.'||sbiProceso,10);
        
        IF(rcArchivoActual.sbNombre = isbArchivo)THEN
           -- Si es el archivo actual no requiere abrirlo
           RETURN;
        END IF;

        -- Se valida si existen archivos abiertos
        IF (tbArchivosAbiertos.COUNT > 0 ) THEN
            
            -- Se recorren los archivos abiertos
            FOR i IN tbArchivosAbiertos.FIRST..tbArchivosAbiertos.LAST
             LOOP
               -- Se cambia el archivo actual por el enviado por par?metro
               IF (tbArchivosAbiertos(i).sbNombre = isbArchivo) THEN
                  rcArchivoActual := tbArchivosAbiertos(i);
                  RETURN;
               END IF;

            END LOOP;
            
            --Si se sobrepasa la cantidad de archivos abiertos se cierra el primero y se borra de la tabla en memoria
            IF (tbArchivosAbiertos.COUNT >= nuMaxArchAbiertos) THEN
               ge_bofilemanager.fileclose(tbArchivosAbiertos(tbArchivosAbiertos.FIRST).fArchivo);
               tbArchivosAbiertos.DELETE(tbArchivosAbiertos.FIRST);
            END IF;

         END IF;        
        
         rcArchivoActual.sbNombre := isbArchivo;
         --Se abre el archivo
         ge_bofilemanager.fileopen(rcArchivoActual.fArchivo, sbRutaArchivo, rcArchivoActual.sbNombre, ge_bofilemanager.csbappend_open_file, 30000);
         tbArchivosAbiertos(NVL(tbArchivosAbiertos.LAST, 0) + 1) := rcArchivoActual;
        
        ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso||'.'||sbiProceso,10);
        
      EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            ut_trace.trace('TERMINO CON ERROR ' || csbPaquete || '.' || sbProceso||' '||sbError,10);
            IF(sbError IS NOT NULL)THEN
               ERRORS.SETERROR(inuapperrorcode => cnuCodigoError, isbargument => sbError);
            END IF;

            RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ut_trace.trace('TERMINO CON ERROR NO CONTROLADO '|| csbPaquete || '.' || sbProceso ||' '||SQLERRM,10);
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;

    END abrirArchivo;


  BEGIN
      ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso,10);
      
      pkerrors.push(csbPaquete || '.' || sbProceso);
      
      -- Se inicializan datos y se setean tablas de memoria
      inicializar;
      
      LOOP
        -- Se obtienen los contratos a procesar por hilo y 
        obtenerContratosPorHilo(inuHilo, isbPrograma, nuLineaMinima, tbContratos, blQuedanRegistros);
        IF(tbContratos.FIRST IS NULL)THEN
           EXIT;
        END IF;
        
        nuLineaMinima := tbContratos(tbContratos.LAST).imdofila;
        
        FOR nuIndex IN tbContratos.FIRST .. tbContratos.LAST LOOP
          BEGIN  
            -- Se obtiene el contrato
            nuContrato  := tbContratos(nuIndex).imdosusc;
            
            -- Se obtiene la direccion de cobro del contrato
            nuDireccion := pktblsuscripc.fnugetaddress_id(nuContrato);
            
            -- Se obtiene la ruta
            nuRuta      := or_boroutepremise.fnuroutefromaddress(nuDireccion, cnuActImpresionDoc);
            
            -- Si no se encuentra ruta, se coloca ruta 0 por defecto
            IF (nuRuta IS NULL) THEN
                nuZona := cnuZonaPorDefecto;
            ELSE
                nuZona := nvl(or_bcroutezone.fnuzonedeliverybyroute(nuRuta), cnuZonaPorDefecto);
            END IF;
            
            -- Si el archivo ya se creo para la zona, se incrementa contador de contratos
            IF (tbArchivo.exists(nuZona)) THEN
               tbArchivo(nuZona).nuCantContratos := tbArchivo(nuZona).nuCantContratos + 1;
            ELSE
               -- Si el archivo no se ha creado para la zona, se crearia
               tbArchivo(nuZona).nuCantContratos := 0;
               tbArchivo(nuZona).sbArchivo := csbFIDF || '_' || inuPeriodo || '_' || to_char(SYSDATE, 'DDMMYYYY_HH24MISS') || '_Z' || nuZona || '_T' ||inuHilo;
            END IF;
            
            -- Se abre el archivo
            abrirArchivo(tbArchivo(nuZona).sbArchivo);
            
            -- Se valida si el contrato pertenece a un grupo de recaudo
            nuGrupoRecaudo := pkbcca_suscgrre.fnugetcontractcollectgroup(nuContrato, rcperifact.pefafeem);
            
            -- Si pertenece a un grupo de recaudo, se valida si es el contrato principal
            IF (nuGrupoRecaudo IS NOT NULL) THEN
              pkbcca_suscgrre.getsuscriptbygroup(nuGrupoRecaudo, rcperifact.pefafeem, tbGrupoRecaudo);
              
              -- Si el contrato es el principal del grupo, procesa todos los contratos del grupo
              IF (nuContrato = tbGrupoRecaudo(tbGrupoRecaudo.FIRST)) THEN
                 nuContratoIndex := tbGrupoRecaudo.FIRST;
                 LOOP
                    EXIT WHEN nuContratoIndex IS NULL;
                    IF(fblImprimirContrato(tbGrupoRecaudo(nuContratoIndex), rcperifact.pefacodi, rcperifact.pefacicl))THEN
                       imprimirContrato(tbGrupoRecaudo(nuContratoIndex), rcArchivoActual, inuPeriodo, inuReportInco, isbPrograma);
                    END IF;
                    nuContratoIndex := tbGrupoRecaudo.NEXT(nuContratoIndex);
                 END LOOP;
                 tbGrupoRecaudo.DELETE;
              END IF;
            ELSE
              -- Se procesa el contrato
              imprimirContrato(nuContrato, rcArchivoActual, inuPeriodo, inuReportInco, isbPrograma);
            END IF;
            
            -- Se incrementa la cantidad de contratos procesados
            nuContContratos := nuContContratos + 1;
            
            -- Si ya termino de procesar contratos
            IF (gnuTotalContratos = nuContContratos) THEN
                pkStatusExeProgramMgr.UpdatePercentage(isbPrograma, 'Procesando contratos. Ultimo contrato procesado: [' || nuContrato || ']', nuContContratos, nuPorcentaje);
                pkgeneralservices.committransaction;
            END IF;
          EXCEPTION
             WHEN OTHERS THEN
                RAISE LOGIN_DENIED;
          END;
        END LOOP;
        
       EXIT WHEN (NOT blQuedanRegistros);
      END LOOP;
      
      ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso,10);
      
      -- Se borran los datos de las tablas de memoria
      tbArchivosAbiertos.DELETE;
      tbContratos.DELETE;
      tbArchivo.DELETE;
      
      -- Se borran los datos temporales de la impresion de documentos
      borrarDatosTemporales(isbPrograma, inuHilo);
            
      -- Se confirman los cambios
      pkgeneralservices.committransaction;
      
  EXCEPTION
      WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
         ut_trace.trace('TERMINO CON ERROR LOG_DENIED'|| csbPaquete || '.' || sbProceso,10);
         PKERRORS.GETERRORVAR(onuCodigoError, osbMensajeError);
         IF onuCodigoError IS NULL OR onuCodigoError = 0 THEN
            PKERRORS.NOTIFYERROR(NULL, SQLERRM, sbError);
            PKERRORS.GETERRORVAR(onuCodigoError, osbMensajeError);
         END IF;
      WHEN OTHERS THEN
          ut_trace.trace('TERMINO CON ERROR'|| csbPaquete || '.' || sbProceso ||' '||SQLERRM,10);
          PKERRORS.NOTIFYERROR(NULL, SQLERRM, sbError);
          PKERRORS.GETERRORVAR(onuCodigoError, osbMensajeError);
  END;
  
  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas

  Unidad         : fsbGenerarOrdenEntrega
  Descripcion    : Metodo para generar orden de entrega del documento informativo
  
  Autor          : KCienfuegos
  Fecha          : 08-03-2017
  Caso           : CA200-875

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  08-03-2017    KCienfuegos.CA200-875        Creacion
  ******************************************************************/
  FUNCTION fsbGenerarOrdenEntrega
    RETURN VARCHAR2
    IS
      sbProceso               VARCHAR2(500) := 'fsbGenerarOrdenEntrega';
      sbError                 VARCHAR2(4000);
      sbReturn                VARCHAR2(2000);
      nuCantOrden             NUMBER := 0;
      nuCliente               suscripc.suscclie%TYPE;
      nuContrato              suscripc.susccodi%TYPE;
      nuProducto              servsusc.sesunuse%TYPE;
      nuDirProducto           pr_product.address_id%TYPE;
      nuDirContrato           suscripc.susciddi%TYPE;
      sbContrato              ge_boInstanceControl.stysbValue;
      nuActGenerar            ge_items.items_id%TYPE;
      nuOrden                 or_order.order_id%TYPE;
      nuActOrden              or_order_activity.order_activity_id%TYPE;
      
      CURSOR cuExisteOrden IS
        SELECT COUNT(1)
          FROM or_order o, or_order_activity oa
         WHERE o.order_id = oa.order_id
           AND oa.subscription_id = nuContrato
           AND oa.activity_id IN (cnuActDirInst, cnuActDirCobro)
           AND o.order_status_id IN (or_boconstants.cnuORDER_STAT_REGISTERED, 
                                     or_boconstants.cnuORDER_STAT_ASSIGNED);

    BEGIN
      
      ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso,10);

      -- Obtiene el identificador del contrato instanciado
      sbContrato := obtenervalorinstancia('SUSCRIPC','SUSCCODI');
      
      IF(sbContrato IS NOT NULL)THEN
        nuContrato := to_number(sbContrato);
      ELSE  
        Errors.setmessage('El contrato no esta instanciado');
        RAISE ex.CONTROLLED_ERROR;
      END IF;
      
      -- Obtiene cualquiera de los productos del contrato. Se ordenan de modo que se trate de obtener primero el de gas
      BEGIN
          SELECT sesunuse
            INTO nuProducto
            FROM (SELECT sesunuse
                    FROM servsusc s, confesco c
                   WHERE sesususc = sbContrato
                     AND sesuesco = c.coeccodi
                     AND c.coecfact = 'S'
                     AND sesuserv NOT IN(3)
                   ORDER by sesuserv)
           WHERE rownum = 1;
      EXCEPTION
          WHEN NO_DATA_FOUND THEN
              Errors.seterror;
              Errors.setmessage('No se encontro un producto asociado al contrato');
              RAISE ex.CONTROLLED_ERROR;
          WHEN ex.CONTROLLED_ERROR THEN
              RAISE ex.CONTROLLED_ERROR;
          WHEN OTHERS THEN
              Errors.setError;
              RAISE ex.CONTROLLED_ERROR;
      END;
      
      -- Se obtiene el cliente del contrato
      nuCliente := pktblsuscripc.fnugetsuscclie(nuContrato);
      
      -- Se obtiene la direccion de cobro
      nuDirContrato := pktblsuscripc.fnugetsusciddi(nuContrato);
      
      -- Se obtiene la direccion del producto
      nuDirProducto := dapr_product.fnugetaddress_id(nuProducto,0);
      
      -- Se comparan los barrios de las direcciones
      IF(NVL(daab_address.fnugetneighborthood_id(nuDirContrato,0),1) = NVL(daab_address.fnugetneighborthood_id(nuDirProducto,0),2))THEN
        nuActGenerar := cnuActDirInst;
      ELSE 
        nuActGenerar := cnuActDirCobro;
      END IF;
      
      OPEN cuExisteOrden;
      FETCH cuExisteOrden INTO nuCantOrden;
      CLOSE cuExisteOrden;
      
      -- Si no existe orden generada, se genera la orden de acuerdo a la actividad definida
      IF(nuCantOrden = 0)THEN
              or_boorderactivities.createactivity(inuitemsid          => nuActGenerar,
                                                  inupackageid        => NULL,
                                                  inumotiveid         => NULL,
                                                  inucomponentid      => NULL,
                                                  inuinstanceid       => NULL,
                                                  inuaddressid        => nuDirContrato,
                                                  inuelementid        => NULL,
                                                  inusubscriberid     => nuCliente,
                                                  inusubscriptionid   => nuContrato,
                                                  inuproductid        => NULL,
                                                  inuopersectorid     => NULL,
                                                  inuoperunitid       => NULL,
                                                  idtexecestimdate    => NULL,
                                                  inuprocessid        => NULL,
                                                  isbcomment          => 'OT GENERADA POR LDCIDO',
                                                  iblprocessorder     => FALSE,
                                                  inupriorityid       => NULL,
                                                  ionuorderid         => nuOrden,
                                                  ionuorderactivityid => nuActOrden,
                                                  inuordertemplateid  => NULL,
                                                  isbcompensate       => NULL,
                                                  inuconsecutive      => NULL,
                                                  inurouteid          => NULL,
                                                  inurouteconsecutive => NULL,
                                                  inulegalizetrytimes => NULL,
                                                  isbtagname          => NULL,
                                                  iblisacttogroup     => FALSE,
                                                  inurefvalue         => NULL); 
      END IF;
      
      ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso,10);
      
      RETURN sbReturn;
      
  EXCEPTION
     WHEN ex.CONTROLLED_ERROR THEN
          ut_trace.trace('TERMINO CON ERROR ' || csbPaquete || '.' || sbProceso||' '||sbError,10);
          IF(sbError IS NOT NULL)THEN
             ERRORS.SETERROR(inuapperrorcode => cnuCodigoError, isbargument => sbError);
          END IF;
          RAISE ex.CONTROLLED_ERROR;
      WHEN OTHERS THEN
          ut_trace.trace('TERMINO CON ERROR NO CONTROLADO '|| csbPaquete || '.' || sbProceso ||' '||SQLERRM,10);
          Errors.setError;
          RAISE ex.CONTROLLED_ERROR;
  END;
  
END LDC_BOIMPRDOCU;
/
