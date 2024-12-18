CREATE OR REPLACE PACKAGE adm_person.LDC_BCIMPRDOCU IS

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas

  Unidad         : LDC_BCIMPRDOCU
  Descripcion    : Paquete que contiene las consultas y validaciones para la impresion
                   de documentos informativos.
  Autor          : KCienfuegos
  Fecha          : 04-03-2017
  Caso           : CA200-875

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  04-03-2017    KCienfuegos.CA200-875       Creacion
  19/06/2024    PAcosta                     OSF-2845: Cambio de esquema ADM_PERSON  
  ******************************************************************/

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas

  Unidad         : fblPeriodoFactActual
  Descripcion    : Funci?n para validar dado el per?odo de facturaci?n y el ciclo, si el per?odo
                   enviado por par?metro, corresponde al actual del ciclo enviado por par?metro.

  Autor          : KCienfuegos
  Fecha          : 06-03-2017
  Caso           : CA200-875

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  06-03-2017    KCienfuegos.CA200-875        Creacion
  ******************************************************************/
  FUNCTION fblPeriodoFactActual(inuPeriodo  IN    perifact.pefacodi%TYPE,
                                inuCiclo    IN    perifact.pefacicl%TYPE)
   RETURN BOOLEAN;

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas

  Unidad         : fblProgramaEjecutado
  Descripcion    : Funci?n para validar dado el per?odo de facturacion, y el programa, si
                   este ?ltimo ya ha sido ejecutado para dicho periodo de facturacion.

  Autor          : KCienfuegos
  Fecha          : 06-03-2017
  Caso           : CA200-875

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  06-03-2017    KCienfuegos.CA200-875        Creacion
  ******************************************************************/
  FUNCTION fblProgramaEjecutado(inuPeriodo    IN    perifact.pefacodi%TYPE,
                                sbPrograma    IN    procejec.prejprog%TYPE)
   RETURN BOOLEAN;

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas

  Unidad         : fblProgramaEnEjecucion
  Descripcion    : Funci?n para validar dado el per?odo de facturaci?n, si el programa
                   enviado por par?metro se encuentra en ejecuci?n.

  Autor          : KCienfuegos
  Fecha          : 06-03-2017
  Caso           : CA200-875

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  06-03-2017    KCienfuegos.CA200-875        Creacion
  ******************************************************************/
  FUNCTION fblProgramaEnEjecucion(inuPeriodo  IN    perifact.pefacodi%TYPE,
                                  isbPrograma IN    procejec.prejprog%TYPE)
   RETURN BOOLEAN;

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas

  Unidad         : fblProcProgramadoPorPer
  Descripcion    : Funci?n para validar dado el per?odo de facturacion, si el proceso
                   ya se encuentra programado, para el per?odo de facturacion pasado por parametro.

  Autor          : KCienfuegos
  Fecha          : 06-03-2017
  Caso           : CA200-875

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  06-03-2017    KCienfuegos.CA200-875        Creacion
  ******************************************************************/
  FUNCTION fblProcProgramadoPorPer(inuPeriodo  IN    perifact.pefacodi%TYPE,
                                   isbPrograma IN    sa_executable.name%TYPE)
   RETURN BOOLEAN;

END LDC_BCIMPRDOCU;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_BCIMPRDOCU IS

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas

  Unidad         : LDC_BCIMPRDOCU
  Descripcion    : Paquete que contiene las consultas y validaciones para la impresion
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
  csbPaquete                  CONSTANT     VARCHAR2(60) := 'LDC_BCIMPRDOCU';
  cnuCodigoError              CONSTANT     NUMBER       := 2741;
  csbEstProcesoEjecutado      CONSTANT     procejec.prejespr%TYPE  := 'T';

  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas

  Unidad         : fblPeriodoFactActual
  Descripcion    : Funci?n para validar dado el per?odo de facturaci?n y el ciclo, si el per?odo
                   enviado por par?metro, corresponde al actual del ciclo enviado por par?metro.

  Autor          : KCienfuegos
  Fecha          : 06-03-2017
  Caso           : CA200-875

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  06-03-2017    KCienfuegos.CA200-875        Creacion
  ******************************************************************/
  FUNCTION fblPeriodoFactActual(inuPeriodo  IN    perifact.pefacodi%TYPE,
                                inuCiclo    IN    perifact.pefacicl%TYPE)
  RETURN BOOLEAN IS

     sbProceso              VARCHAR2(500) := 'fblPeriodoFactActual';
     sbError                VARCHAR2(4000);
     rcPeriodoActual	      perifact%ROWTYPE;


  BEGIN

    ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso,10);

    -- Se obtiene el registro del periodo de facturacion actual
    rcPeriodoActual := pkBillingPeriodMgr.frcGetAccCurrentPeriod(inuCiclo);

    IF(inuPeriodo = rcPeriodoActual.pefacodi)THEN
       ut_trace.trace('El periodo '||inuPeriodo||' corresponde al actual del ciclo '||inuCiclo,10);

       RETURN TRUE;
    ELSE
       ut_trace.trace('El periodo '||inuPeriodo||' no corresponde al actual del ciclo '||inuCiclo,10);
       RETURN FALSE;
    END IF;

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

  Unidad         : fblProgramaEjecutado
  Descripcion    : Funci?n para validar dado el per?odo de facturacion, y el programa, si
                   este ?ltimo ya ha sido ejecutado para dicho periodo de facturacion.

  Autor          : KCienfuegos
  Fecha          : 06-03-2017
  Caso           : CA200-875

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  06-03-2017    KCienfuegos.CA200-875        Creacion
  ******************************************************************/
  FUNCTION fblProgramaEjecutado(inuPeriodo    IN    perifact.pefacodi%TYPE,
                                sbPrograma    IN    procejec.prejprog%TYPE)
  RETURN BOOLEAN IS

     sbProceso              VARCHAR2(500) := 'fblProgramaEjecutado';
     sbError                VARCHAR2(4000);
     nuResult               NUMBER:= 1;

     CURSOR cuProcEjecutado(nuPeriodo perifact.pefacodi%TYPE) IS
       SELECT 1
         FROM procejec p
        WHERE p.prejcope = nuPeriodo
          AND p.prejespr = csbEstProcesoEjecutado
          AND p.prejinad = -1
          AND (UPPER(prejprog) = sbPrograma
		      OR UPPER(SUBSTR(prejprog,1,4)) = sbPrograma);

  BEGIN

    ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso,10);

    -- Se consulta si el proceso ya fue ejecutado
    OPEN cuProcEjecutado(inuPeriodo);
    FETCH cuProcEjecutado INTO nuResult;

    IF(cuProcEjecutado%NOTFOUND)THEN
      CLOSE cuProcEjecutado;

      RETURN FALSE;
    END IF;

    CLOSE cuProcEjecutado;

    ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso,10);

    RETURN TRUE;

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

  Unidad         : fblProgramaEnEjecucion
  Descripcion    : Funci?n para validar dado el per?odo de facturaci?n, si el programa
                   enviado por par?metro se encuentra en ejecuci?n.

  Autor          : KCienfuegos
  Fecha          : 06-03-2017
  Caso           : CA200-875

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  06-03-2017    KCienfuegos.CA200-875        Creacion
  ******************************************************************/
  FUNCTION fblProgramaEnEjecucion(inuPeriodo  IN    perifact.pefacodi%TYPE,
                                  isbPrograma IN    procejec.prejprog%TYPE)
   RETURN BOOLEAN IS

     sbProceso              VARCHAR2(500) := 'fblProgramaEnEjecucion';
     sbError                VARCHAR2(4000);
     nuResult               NUMBER:= 1;

     CURSOR cuProcEnEjecucion(nuPeriodo perifact.pefacodi%TYPE) IS
       SELECT 1
         FROM procejec p
        WHERE p.prejcope = nuPeriodo
          AND (UPPER(prejprog) = isbPrograma
		       OR UPPER(SUBSTR(prejprog,1,4)) = isbPrograma)
          AND p.prejespr = 'E'
          AND p.prejinad = -1;

  BEGIN

    ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso,10);

    -- Se consulta si el proceso se encuentra en ejecuci?n
    OPEN cuProcEnEjecucion(inuPeriodo);
    FETCH cuProcEnEjecucion INTO nuResult;

    IF(cuProcEnEjecucion%FOUND)THEN
      CLOSE cuProcEnEjecucion;

      ut_trace.trace('El proceso '||isbPrograma||' se encuentra en proceso para el periodo '||inuPeriodo,10);

      RETURN TRUE;
    END IF;

    ut_trace.trace('El proceso '||isbPrograma||' no se encuentra en proceso para el periodo '||inuPeriodo,10);

    CLOSE cuProcEnEjecucion;

    ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso,10);

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

  Unidad         : fblProcProgramadoPorPer
  Descripcion    : Funci?n para validar dado el per?odo de facturacion, si el proceso
                   ya se encuentra programado, para el per?odo de facturacion pasado por parametro.

  Autor          : KCienfuegos
  Fecha          : 06-03-2017
  Caso           : CA200-875

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  06-03-2017    KCienfuegos.CA200-875        Creacion
  ******************************************************************/
  FUNCTION fblProcProgramadoPorPer(inuPeriodo  IN    perifact.pefacodi%TYPE,
                                   isbPrograma IN    sa_executable.name%TYPE)
   RETURN BOOLEAN IS

     sbProceso              VARCHAR2(500) := 'fblProcProgramadoPorPer';
     sbError                VARCHAR2(4000);
     rcExecutable           sa_executable%ROWTYPE;
     rfProgProcesos         pkConstante.tyRefCursor;
     blPeriodoProgramado    BOOLEAN := FALSE;
     sbPEFACODI             ge_boInstanceControl.stysbValue;

     -- Variables para almacenar la informacion de la programacion
     sbFechEjecProceso       VARCHAR2(30);
     sbHoraEjecProceso       VARCHAR2(30);
     sbFrecuenciaProceso     VARCHAR2(30);
     nuJob                   ge_process_schedule.job%type;
     sbParametrosProceso     ge_process_schedule.parameters_%type;
     nuIDProgramacion        ge_process_schedule.process_schedule_id%type;

  BEGIN

    ut_trace.trace('INICIO ' || csbPaquete || '.' || sbProceso,10);

    -- Se obtienen los datos del ejecutable a partir del nombre
    SA_BOExecutable.GetExecutableDataByName(Isbexecutablename => isbPrograma,
                                            Onuexecopertypeid =>  rcExecutable.Exec_Oper_Type_Id,
                                            Onuexecutableid   =>  rcExecutable.Executable_Id,
                                            Onuexecutabletypeid => rcExecutable.Executable_Type_Id,
                                            Onumodule => rcExecutable.Module_Id,
                                            Onuparentexecutableid => rcExecutable.Parent_Executable_Id,
                                            Osbdescription => rcExecutable.Description,
                                            Osbexecutablepath => rcExecutable.Path,
                                            Osbversion => rcExecutable.Version);

    -- Se obtienen los procesos de impresion de documentos, que se encuentren programados
    rfProgProcesos := GE_BCProcess_Schedule.frfGetSchedulesByAplication(rcExecutable.Executable_Id);

    -- Se recorre cada programaci?n
    LOOP

        FETCH rfProgProcesos INTO sbFechEjecProceso, sbHoraEjecProceso, sbFrecuenciaProceso,
            nuJob, sbParametrosProceso, nuIDProgramacion;

        -- Condicion de salida del bucle
        EXIT WHEN rfProgProcesos%NOTFOUND;

        -- Se obtiene el estado de corte del proceso
        sbPEFACODI := UT_String.GetParameterValue
        (
            sbParametrosProceso,
            'PEFACODI',
            GE_BOSchedule.csbSEPARADOR_PARAMETROS,
            GE_BOSchedule.csbSEPARADOR_VALORES
        );

        IF(sbPEFACODI IS NOT NULL)THEN
           IF(to_number(sbPEFACODI)=inuPeriodo) THEN
              ut_trace.trace('Periodo Programado:'||inuPeriodo,10);
              blPeriodoProgramado := TRUE;
              EXIT;
           END IF;
        END IF;

        sbPEFACODI := NULL;

    END LOOP;

    CLOSE rfProgProcesos;

    ut_trace.trace('FIN ' || csbPaquete || '.' || sbProceso,10);

    RETURN blPeriodoProgramado;

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

END LDC_BCIMPRDOCU;
/
PROMPT Otorgando permisos de ejecucion a LDC_BCIMPRDOCU
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_BCIMPRDOCU', 'ADM_PERSON');
END;
/