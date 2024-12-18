CREATE OR REPLACE PROCEDURE ldrpc(inuProgramacion IN ge_process_schedule.process_schedule_id%TYPE) 
AS
	nuError   		NUMBER;
	sbMensajeError  VARCHAR2(20000);

	sbParametros GE_PROCESS_SCHEDULE.PARAMETERS_%TYPE;
	nuHilos      NUMBER := 1;
	nuLogProceso GE_LOG_PROCESS.LOG_PROCESS_ID%TYPE;

	nuLinea 	NUMBER;  
	nuTipoReno 	NUMBER;
	nuDatoReno 	NUMBER;
BEGIN
	ut_trace.trace('INICIA ldrpc', 5);
  
	ge_boschedule.AddLogToScheduleProcess(inuProgramacion, nuHilos, nuLogProceso);

	sbParametros := dage_process_schedule.fsbGetParameters_(inuProgramacion);

	nuLinea := to_number(ut_string.getparametervalue(sbParametros, 'LINE_ID','|','='));
	nuTipoReno := to_number(ut_string.getparametervalue(sbParametros, 'MONTH_POLICY', '|', '='));
	nuDatoReno := to_number(ut_string.getparametervalue(sbParametros, 'POLICY_ID', '|', '='));
	
	ut_trace.trace('nuLinea: '||nuLinea, 5);
	ut_trace.trace('nuTipoReno: '||nuTipoReno, 5);
	ut_trace.trace('nuDatoReno: '||nuDatoReno, 5);

	LDC_RenewPoliciesByCollective(nuLinea, nuTipoReno, nuDatoReno);

	ge_boschedule.changelogProcessStatus(nuLogProceso, 'F');
	
	ut_trace.trace('FIN ldrpc', 5);
EXCEPTION
	WHEN ex.CONTROLLED_ERROR THEN
		errors.geterror(nuError, sbMensajeError);
		ut_trace.trace(nuError || ' - ' || sbMensajeError);
		ut_trace.trace('ERROR CONTROLLED_ERROR ldrpc', 5);
		RAISE ex.CONTROLLED_ERROR;
	WHEN OTHERS THEN
		errors.geterror(nuError, sbMensajeError);
		ut_trace.trace(nuError || ' - ' || sbMensajeError);
		Errors.setError;
		ut_trace.trace('ERROR OTHERS ldrpc', 5);
		RAISE ex.CONTROLLED_ERROR;
END ldrpc;
/
GRANT EXECUTE ON ldrpc TO SYSTEM_OBJ_PRIVS_ROLE;
/