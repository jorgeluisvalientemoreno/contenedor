CREATE OR REPLACE PROCEDURE      ldcintactasRO(inuProgramacion  IN ge_process_schedule.process_schedule_id%TYPE)
  /*******************************************************************************
  Propiedad intelectual de CEO(c).

  Nombre         :  LDCINTACTASRO
  Descripcion    :  Prceso  para generar LDCINTACTASRO
  Autor          :  Diego Andres Cardona Garcia
  Fecha          :  31 Julio de 2014

  Parametros        Descripcion
  ============	===================

  Historia de Modificaciones
  Fecha             Autor                 Modificacion
  =========       =========          ====================
  /*******************************************************************************/
IS

    --<<
    -- Variables
    -->>
    sbParametros    ge_process_schedule.parameters_%TYPE;
    nuHilos         NUMBER := 1;
    nuLogProceso    ge_log_process.log_process_id%TYPE;
    daFechaIni      DATE;
    daFechaFin      DATE;
    sbTipoInterfaz  VARCHAR2(15);
    nuNumeroActa    NUMBER;
    sbClaveEncrip   VARCHAR2(60);
    sbCadConexion   VARCHAR2(2000);
    sbClave         VARCHAR2(2000);
    sbUsuario       VARCHAR2(2000);
    sbCadenaEncrip  VARCHAR2(2000);
    sbInstancia     VARCHAR2(2000);
    csbLLave        CONSTANT VARCHAR2( 20 ) := '10101000101011';
    nuRet           NUMBER;

BEGIN

    -- se adiciona al log de procesos
    ge_boschedule.AddLogToScheduleProcess(inuProgramacion,nuHilos,nuLogProceso);

    -- se obtiene parametros
    sbParametros := dage_process_schedule.fsbGetParameters_(inuProgramacion);

    -- se extrae valores de los parametro
    daFechaIni     := ut_string.getparametervalue(sbParametros,'PRMOFEIN','|','=');
    daFechaFin     := ut_string.getparametervalue(sbParametros,'PRMOFEFI','|','=');
    sbTipoInterfaz := ut_string.getparametervalue(sbParametros,'TIPDOCONT','|','=');
    nuNumeroActa   := ut_string.getparametervalue(sbParametros,'IDACTA','|','=');

    nuRet := ldci_pkinterfazactas.fnuInterCostoSAP(nuNumeroActa, sbTipoInterfaz,daFechaIni,daFechaFin);

    ge_boschedule.changelogProcessStatus(nuLogProceso,'F');

    COMMIT;

EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
        RAISE;
    WHEN OTHERS THEN
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END LDCINTACTASRO;
/
GRANT EXECUTE on LDCINTACTASRO to SYSTEM_OBJ_PRIVS_ROLE;
GRANT EXECUTE on LDCINTACTASRO to REXEOPEN;
/
