CREATE OR REPLACE PROCEDURE LDCFAAC (inuProgramacion in ge_process_schedule.process_schedule_id%type) IS

  /**************************************************************************

      Autor       : Elkin alvarez / Horbath
      Fecha       : 2018-21-01
      Ticket      : 200-1892
      Descripcion : Procedimiento que Proceso datos del PB [LDCFAAC ]

      Parametros Entrada


      Valor de salida
      HISTORIA DE MODIFICACIONES

      FECHA        AUTOR       DESCRIPCION

    ***************************************************************************/

    sbMensError      VARCHAR2(4000);  --Ticket 200-1892  ELAL -- se almacena error generado

    sbParametros           ge_process_schedule.parameters_%TYPE;
    nuHilos                NUMBER := 1;
    nuLogProceso           ge_log_process.log_process_id%TYPE;

    nuAno   NUMBER;
    nuMes   NUMBER;
    nuCiclo  NUMBER;
    sbEmail  VARCHAR2(4000);

  BEGIN

    pkerrors.Push('LDCFAAC'); --Ticket 200-1892  ELAL -- Se inicia proceso de log de error

    ge_boschedule.AddLogToScheduleProcess(inuProgramacion,nuHilos,nuLogProceso);

    sbParametros := open.dage_process_schedule.fsbgetparameters_(inuProgramacion);

    nuAno    := TO_NUMBER(TRIM(open.ut_string.getparametervalue(sbParametros,'PEFAANO','|','='))); --Ticket 200-1892  ELAL -- Se obtiene aÃ±o
    nuMes    := TO_NUMBER(TRIM(open.ut_string.getparametervalue(sbParametros,'PEFAMES','|','='))); --Ticket 200-1892  ELAL -- Se obtiene mes
    nuCiclo  := TO_NUMBER(TRIM(open.ut_string.getparametervalue(sbParametros,'PEFACICL','|','='))); --Ticket 200-1892  ELAL -- se obtiene ciclo
    sbEmail  := TRIM(open.ut_string.getparametervalue(sbParametros,'E_MAIL','|','=')) ; --Ticket 200-1892  ELAL -- Se obtiene email

    LDC_PKFAAC.proGeneraAuditorias(nuano,numes,nuCiclo,sbEmail);

    pkErrors.Pop; --Ticket 200-1892  ELAL -- Se finaliza el proceso de log de error
    sbMensError := null;

    ge_boschedule.changelogProcessStatus(nuLogProceso,'F');

 EXCEPTION

       WHEN ex.CONTROLLED_ERROR THEN
          ge_boschedule.changelogProcessStatus(nuLogProceso,'F');
          raise;

      WHEN OTHERS THEN
          Errors.setError;
          sbMensError := sbMensError||'Error No Controlado, '||sqlerrm;
          Errors.SETMESSAGE(sbMensError);
          ge_boschedule.changelogProcessStatus(nuLogProceso,'F');
          ROLLBACK;
          raise ex.CONTROLLED_ERROR;

  END LDCFAAC;
/
BEGIN
    pkg_utilidades.praplicarpermisos('LDCFAAC', 'OPEN');
END;
/