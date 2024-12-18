CREATE OR REPLACE procedure LDCCUS(inuschedule In ge_process_schedule.process_schedule_id%Type) is
  /*****************************************************************
  Propiedad intelectual de Gascaribe.

  Unidad         : LDCCUS
  Descripcion    : M?todo de PB programado LDCCUS.

  Autor          : KCienfuegos
  Fecha          : 15-09-2016
  Caso           : CA100-22398

  Par?metros           Descripci?n
  ============         ===================
  inuschedule          id de la programaci?n

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  15-09-2016    KCienfuegos.CA100-22398        Creaci?n.
    30/05/2024	  JSOTO	OSF-2602				        Se elimina uso de LDC_BOCONCIL_USU_FACT.proGenJobs
  ******************************************************************/

    nuerrorcode       Number;
    sberrormessage    Varchar2(4000);
    nulogprocessid    ge_log_process.log_process_id%Type;
    gsberrmsg         ge_error_log.description%Type;
    nuhilo            Number := 1;

    sbAno              VARCHAR2(4);
    sbMes              VARCHAR2(2);
    sbEmail            VARCHAR2(500);
    sbDepartamento     VARCHAR2(10);

   PROCEDURE getparameters Is
    -- Registro de la programaci?n
    rcprogramacion dage_process_schedule.styge_process_schedule;

   BEGIN
    UT_Trace.Trace( 'Inicia LDCCUS.getparameters', 10);

    -- Instancia en memoria el identificador de la programaci?n del proceso
    ge_boschedule.instanceschedule(inuschedule);

    -- Obtener registro de programaci?n
    rcprogramacion := dage_process_schedule.frcgetrecord(inuschedule);

    -- Obtener Datos
    sbANO := ut_string.getparametervalue(rcprogramacion.parameters_,
                                         'PEFAANO',
                                         ge_boschedule.csbseparador_parametros,
                                         ge_boschedule.csbseparador_valores);

    sbMes := ut_string.getparametervalue(rcprogramacion.parameters_,
                                         'PEFAMES',
                                         ge_boschedule.csbseparador_parametros,
                                         ge_boschedule.csbseparador_valores);

    sbDepartamento := ut_string.getparametervalue(rcprogramacion.parameters_,
                                                 'GEOGRAP_LOCATION_ID',
                                                  ge_boschedule.csbseparador_parametros,
                                                  ge_boschedule.csbseparador_valores);

    sbEmail := ut_string.getparametervalue(rcprogramacion.parameters_,
                                          'E_MAIL',
                                           ge_boschedule.csbseparador_parametros,
                                           ge_boschedule.csbseparador_valores);

    UT_Trace.Trace( 'Fin LDCCUS.getparameters', 10);
    pkerrors.pop;

  EXCEPTION
    WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
      PKERRORS.POP;
      RAISE EX.CONTROLLED_ERROR;

    WHEN EX.CONTROLLED_ERROR THEN
      PKERRORS.POP;
      RAISE EX.CONTROLLED_ERROR;

    WHEN OTHERS THEN
      PKERRORS.POP;
      ERRORS.SETERROR;
      RAISE EX.CONTROLLED_ERROR;
      --}
  END GETPARAMETERS;

BEGIN
    UT_Trace.Trace( 'Inicia LDCCUS', 10);

    ge_boschedule.addlogtoscheduleprocess(inuschedule, nuhilo, nulogprocessid);
    getparameters();

    ge_boschedule.changelogprocessstatus(nulogprocessid, 'F');

    UT_Trace.Trace( 'Fin LDCCUS', 10);

EXCEPTION
  WHEN ex.controlled_error THEN
    errors.geterror(nuerrorcode, sberrormessage);
    ut_trace.trace('ERROR  LDCCUS[' || nuerrorcode || ']Mensaje[' ||
                   sberrormessage || ']');
  WHEN OTHERS THEN
    pkerrors.notifyerror(pkerrors.fsblastobject, Sqlerrm, gsberrmsg);
    pkerrors.pop;
    raise_application_error(pkconstante.nuerror_level2, gsberrmsg);
END LDCCUS;
/
