CREATE OR REPLACE PROCEDURE ldcintconsumoRO(inuProgramacion  IN ge_process_schedule.process_schedule_id%TYPE)
  /*******************************************************************
  Propiedad intelectual de CEO(c).

  Nombre         :  ldcintconsumoRO
  Descripcion    :  Prceso  para generar LDCINTCONSUMO
  Autor          :  Diego Adrés Cardona García
  Fecha          :  31 Julio de 2014

  Parametros        Descripcion
  ============      ===================

  Historia de Modificaciones
  Fecha        Autor            Modificacion
  ------------ ---------------- --------------------------------------
  /*******************************************************************/
  IS

    sbParametros    ge_process_schedule.parameters_%TYPE;
    nuHilos         NUMBER := 1;
    nuLogProceso    ge_log_process.log_process_id%TYPE;
    inuano          ldc_ciercome.cicoano%TYPE;
    inumes          ldc_ciercome.cicomes%TYPE;
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
    inuano    := ut_string.getparametervalue(sbParametros,'CICOANO','|','=');
    inumes    := ut_string.getparametervalue(sbParametros,'CICOMES','|','=');

    nuRet := ldci_pkinterfazactas.fnuInterMaterSAPRO(inuano, inumes);

    ge_boschedule.changelogProcessStatus(nuLogProceso,'F');

    COMMIT;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
        RAISE;
    WHEN OTHERS THEN
        Errors.setError;
        raise ex.CONTROLLED_ERROR;

  END LDCINTCONSUMORO;
/
GRANT EXECUTE on LDCINTCONSUMORO to SYSTEM_OBJ_PRIVS_ROLE;
GRANT EXECUTE on LDCINTCONSUMORO to REXEOPEN;
/
