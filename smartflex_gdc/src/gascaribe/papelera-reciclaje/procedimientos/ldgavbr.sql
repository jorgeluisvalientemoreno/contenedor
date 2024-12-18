CREATE OR REPLACE PROCEDURE LDGAVBR(inuProgramacion IN ge_process_schedule.process_schedule_id%TYPE) AS
  numerror   NUMBER;
  sbmessage  VARCHAR2(2000);


  sbParametros GE_PROCESS_SCHEDULE.PARAMETERS_%TYPE;
  nuHilos      NUMBER := 1;
  nuLogProceso GE_LOG_PROCESS.LOG_PROCESS_ID%TYPE;

  nuprodu NUMBER;
  nuano NUMBER;
  numes NUMBER;

BEGIN

  ut_trace.trace('INICIA LDGAVBR', 15);
  -- se adiciona al log de procesos
  ge_boschedule.AddLogToScheduleProcess(inuProgramacion, nuHilos, nuLogProceso);

  -- se obtiene parametros
  ut_trace.trace('se obtiene parametros', 15);
  sbParametros := dage_process_schedule.fsbGetParameters_(inuProgramacion);

  ut_trace.trace('se separan parametros', 15);
  nuprodu := to_number(ut_string.getparametervalue(sbParametros,'PRODUCT_TYPE_ID','|','='));
  nuano := to_number(ut_string.getparametervalue(sbParametros,'PEFAANO','|','='));
  numes := to_number(ut_string.getparametervalue(sbParametros, 'PEFAMES', '|', '='));

  ldc_pkGenGaVBr.gengavbr(nuprodu,nuano,numes);

  ge_boschedule.changelogProcessStatus(nuLogProceso, 'F');
  ut_trace.trace('FIN ', 15);
  ut_trace.trace('Fin LDGAVBR', 15);
EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    errors.geterror(numerror, sbmessage);
    ut_trace.trace(numerror || ' - ' || sbmessage);
    RAISE ex.CONTROLLED_ERROR;
  WHEN OTHERS THEN
    errors.geterror(numerror, sbmessage);
    ut_trace.trace(numerror || ' - ' || sbmessage);
    Errors.setError;
    RAISE ex.CONTROLLED_ERROR;
END LDGAVBR;
/
