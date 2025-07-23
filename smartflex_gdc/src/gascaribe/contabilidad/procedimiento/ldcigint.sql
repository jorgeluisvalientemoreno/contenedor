CREATE OR REPLACE PROCEDURE LDCIGINT
(
    inuProgramacion  IN ge_process_schedule.process_schedule_id%TYPE
)
IS
    /*******************************************************************************
    Propiedad intelectual de CEO(c).

    Nombre         :  LDCIGINT
    Descripcion    :  Prceso  para generar LDCIGINT
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
    daFechaIni DATE;
    daFechaFin  DATE;
    sbTipoInterfaz  VARCHAR2(15);
    nuNumeroActa NUMBER;
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
    daFechaIni    := ut_string.getparametervalue(sbParametros,'PRMOFEIN','|','=');
    daFechaFin    := ut_string.getparametervalue(sbParametros,'PRMOFEFI','|','=');
    sbTipoInterfaz    := ut_string.getparametervalue(sbParametros,'TIPOINTERFAZ','|','=');
    nuNumeroActa    := ut_string.getparametervalue(sbParametros,'TIDCCODI','|','=');

/*    sbUsuario := ut_string.getparametervalue(sbParametros,'PEFADESC','|','=');
    sbClaveEncrip  := ut_string.getparametervalue(sbParametros,'SUSCMAIL','|','=');
    sbInstancia := ut_string.getparametervalue(sbParametros,'SUSCDECO','|','=');

  --   pkControlConexion.encripta( sbCadenaEncrip, sbCadConexion, csbLLave, 1 );

     pkControlConexion.encripta( sbClaveEncrip, sbClave, csbLLave, 1 );


    GE_BODATABASECONNECTION.SETCONNECTIONSTRING(sbUsuario,sbClave,sbInstancia);
*/
  nuRet := ldci_pkinterfazsap.fnuInterfazContableFechas(sbTipoInterfaz,daFechaIni,daFechaFin);

    ge_boschedule.changelogProcessStatus(nuLogProceso,'F');

    COMMIT;

EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
        RAISE;
    WHEN OTHERS THEN
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END LDCIGINT;
/
GRANT EXECUTE on LDCIGINT to SYSTEM_OBJ_PRIVS_ROLE;
GRANT EXECUTE on LDCIGINT to REXEOPEN;
/
