CREATE OR REPLACE PROCEDURE LDCIENVINT
(
    inuProgramacion  IN ge_process_schedule.process_schedule_id%TYPE
)
IS
    /*******************************************************************************
    Propiedad intelectual de CEO(c).

    Nombre         :  LDCINTACTAS
    Descripcion    :  Prceso  para generar LDCINTACTAS
    Autor          :  Heiber Barco
    Fecha          :  29 Noviembre de 2013
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
    nuCodInterfaz LDCI_ACTACONT.codocont%TYPE;
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
    nuCodInterfaz    := ut_string.getparametervalue(sbParametros,'CODOCONT','|','=');

/*    sbUsuario := ut_string.getparametervalue(sbParametros,'PEFADESC','|','=');
    sbClaveEncrip  := ut_string.getparametervalue(sbParametros,'SUSCMAIL','|','=');
    sbInstancia := ut_string.getparametervalue(sbParametros,'SUSCDECO','|','=');

  --   pkControlConexion.encripta( sbCadenaEncrip, sbCadConexion, csbLLave, 1 );

     pkControlConexion.encripta( sbClaveEncrip, sbClave, csbLLave, 1 );


    GE_BODATABASECONNECTION.SETCONNECTIONSTRING(sbUsuario,sbClave,sbInstancia);
*/
  ldci_pkintercontablemesa.proEnviaDocContable(nuCodInterfaz);
  UPDATE ldci_actacont SET (actcontabiliza) = ('S'), usuario = USER, fechcontabiliza = sysdate
   WHERE codocont = nuCodInterfaz;
  UPDATE ldci_registrainterfaz SET (ldflagcontabi) = ('S'), userupdate = USER, fechaupdate = SYSDATE,
         terminalupdate = USERENV('TERMINAL')
   WHERE ldcodinterf = nuCodInterfaz;

    ge_boschedule.changelogProcessStatus(nuLogProceso,'F');

    COMMIT;

EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
        RAISE;
    WHEN OTHERS THEN
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END LDCIENVINT;
/
GRANT EXECUTE on LDCIENVINT to SYSTEM_OBJ_PRIVS_ROLE;
GRANT EXECUTE on LDCIENVINT to REXEOPEN;
GRANT EXECUTE on LDCIENVINT to RSELSYS;
/
