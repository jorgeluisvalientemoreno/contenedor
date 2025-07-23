CREATE OR REPLACE PROCEDURE LDCIGINTMES
(
    inuProgramacion  IN ge_process_schedule.process_schedule_id%TYPE
)
IS
    /*******************************************************************************
    Propiedad intelectual de CEO(c).

    Nombre         :  LDCIGINT
    Descripcion    :  Prceso  para generar LDCIGINT Con Fechas
    Autor          :  Oscar Eduardo Restrepo
    Fecha          :  22 Noviembre de 2013
    Parametros         Descripcion
    ============	===================


    Historia de Modificaciones
    Fecha             Autor                 Modificacion
    =========       =========          ====================
    /*******************************************************************************/
    sbParametros    GE_PROCESS_SCHEDULE.PARAMETERS_%TYPE;
    nuHilos         NUMBER := 1;
    nuLogProceso    GE_LOG_PROCESS.LOG_PROCESS_ID%TYPE;
    ANIO NUMBER;
    MES  NUMBER;
    sbTipoInterfaz  VARCHAR2(15);
    sbClaveEncrip VARCHAR2(60);
    sbCadConexion  varchar2(2000);
    sbClave  varchar2(2000);
    sbUsuario      varchar2(2000);
    sbCadenaEncrip         varchar2(2000);
    sbInstancia    varchar2(2000);
    csbLLave       CONSTANT VARCHAR2( 20 ) := '10101000101011';
    nuRet NUMBER;
BEGIN

    -- se adiciona al log de procesos
    ge_boschedule.AddLogToScheduleProcess(inuProgramacion,nuHilos,nuLogProceso);

    -- se obtiene parametros
    sbParametros := dage_process_schedule.fsbGetParameters_(inuProgramacion);

    -- se extrae valores de los parametro
    ANIO    := ut_string.getparametervalue(sbParametros,'ANO','|','=');
    MES    := ut_string.getparametervalue(sbParametros,'MES','|','=');
    sbTipoInterfaz    := ut_string.getparametervalue(sbParametros,'TIPOINTERFAZ','|','=');

  nuRet := ldci_pkinterfazsap.fnuInterfazContableAnioMes(sbTipoInterfaz,ANIO,MES);

    ge_boschedule.changelogProcessStatus(nuLogProceso,'F');

    COMMIT;

EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
        RAISE;
    WHEN OTHERS THEN
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END LDCIGINTMES;
/
GRANT EXECUTE on LDCIGINTMES to SYSTEM_OBJ_PRIVS_ROLE;
GRANT EXECUTE on LDCIGINTMES to REXEOPEN;
GRANT EXECUTE on LDCIGINTMES to RSELSYS;
/
