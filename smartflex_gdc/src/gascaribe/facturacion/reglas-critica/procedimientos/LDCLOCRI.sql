create or replace PROCEDURE LDCLOCRI(inuProgramacion in ge_process_schedule.process_schedule_id%type) IS
 /*****************************************************************
  Propiedad intelectual de Gases del Caribe.

  Nombre del Paquete: LDCLOCRI
  Descripcion: Proceso que se encarga de programar el proceso LDCLOCRI

  Autor    : Luis javier lopez barrios
  Fecha    : 24-08-2022
  
  Datos Entrada

  Salida:

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>.              Modificacion
  -----------  -------------------    -------------------------------------
  ******************************************************************/
  sbParametros           ge_process_schedule.parameters_%TYPE;
  nuHilos                NUMBER := 1;
  nuLogProceso           ge_log_process.log_process_id%TYPE;
  nuperiodocons  NUMBER;
  NUCAUSAL NUMBER;
  sbORDER_COMMENT ge_boInstanceControl.stysbValue;
  sbMensError  VARCHAR2(4000);
  onuerror  NUMBER;
BEGIN
  pkerrors.Push('LDCLOCRI'); --Ticket 200-1892  ELAL -- Se inicia proceso de log de error
  ge_boschedule.AddLogToScheduleProcess(inuProgramacion,nuHilos,nuLogProceso);
  sbParametros := open.dage_process_schedule.fsbgetparameters_(inuProgramacion);

  nuperiodocons    := TO_NUMBER(TRIM(open.ut_string.getparametervalue(sbParametros,'PECSCONS','|','='))); 
  NUCAUSAL    := TO_NUMBER(TRIM(open.ut_string.getparametervalue(sbParametros,'CAUSAL_ID','|','='))); 
  sbORDER_COMMENT := TRIM(open.ut_string.getparametervalue(sbParametros,'ORDER_COMMENT','|','=')); 
   
   
  LDC_PKGESTIONLEGORDCRI.PRPROCORDEN( nuperiodocons,
                                      NUCAUSAL,
                                      sbORDER_COMMENT,
                                       onuerror,
                                      sbMensError);
                                      
 
 EXCEPTION
      WHEN ex.CONTROLLED_ERROR THEN
          ROLLBACK;
          ge_boschedule.changelogProcessStatus(nuLogProceso,'F');
          raise;
      WHEN OTHERS THEN
          ROLLBACK;
          Errors.setError;
          sbMensError := sbMensError||'Error No Controlado, '||sqlerrm;
          Errors.SETMESSAGE(sbMensError);
          ge_boschedule.changelogProcessStatus(nuLogProceso,'F');
          ROLLBACK;
          raise ex.CONTROLLED_ERROR;   
END;
/
grant execute on LDCLOCRI to SYSTEM_OBJ_PRIVS_ROLE
/