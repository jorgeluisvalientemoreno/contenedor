CREATE OR REPLACE PROCEDURE      ldciprovcost(inuProgramacion  IN ge_process_schedule.process_schedule_id%TYPE)
  /**************************************************************
  Propiedad intelectual de Efigas(c).

  Nombre         :  LDCIPROVCOST
  Descripcion    :  Prceso  para generar LDCIPROVCOST
  Autor          :  Diego Andrés Cardona García
  Fecha          :  29 Septiembre de 2014
  Parametros        Descripcion
  ----------------  ---------------------------------------------


  Historia de Modificaciones
  ===============================================================
  Fecha     Autor           Modificacion
  --------- --------------- -------------------------------------
  /**************************************************************/
  IS

    --<<
    -- Variables
    -->>
    sbParametros    ge_process_schedule.parameters_%TYPE;
    nuHilos         NUMBER := 1;
    nuLogProceso    ge_log_process.log_process_id%TYPE;
    ANIO            NUMBER;
    MES             NUMBER;
    sbTipoInterfaz  VARCHAR2(15);
    sbClaveEncrip   VARCHAR2(60);
    sbCadConexion   VARCHAR2(2000);
    sbClave         VARCHAR2(2000);
    sbUsuario       VARCHAR2(2000);
    sbCadenaEncrip  VARCHAR2(2000);
    sbInstancia     VARCHAR2(2000);
    csbLLave        CONSTANT VARCHAR2( 20 ) := '10101000101011';
    nuRet           NUMBER;

  BEGIN

    --<<
    -- Se adiciona al log de procesos
    -->>
    ge_boschedule.AddLogToScheduleProcess(inuProgramacion,nuHilos,nuLogProceso);

    --<<
    -- Se obtiene el parametro
    -->>
    sbParametros := dage_process_schedule.fsbGetParameters_(inuProgramacion);

    --<<
    -- Se extraen los valores de los parametros
    -->>
    ANIO           := ut_string.getparametervalue(sbParametros,'CICOANO','|','=');
    MES            := ut_string.getparametervalue(sbParametros,'CICOMES','|','=');

    --<<
    -- Se ejecuta la interfaz
    -->>
    nuRet := ldci_pkinterfazactas.fnugenprovcost(ANIO,MES);

    ge_boschedule.changelogProcessStatus(nuLogProceso,'F');

    COMMIT;

  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
        RAISE;
    WHEN OTHERS THEN
        Errors.setError;
        raise ex.CONTROLLED_ERROR;

  END ldciprovcost;
/
GRANT EXECUTE on LDCIPROVCOST to SYSTEM_OBJ_PRIVS_ROLE;
GRANT EXECUTE on LDCIPROVCOST to REXEOPEN;
/
