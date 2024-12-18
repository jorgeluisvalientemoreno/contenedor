CREATE OR REPLACE procedure LDCCBL(inuschedule In ge_process_schedule.process_schedule_id%Type) is
  /*****************************************************************
  Propiedad intelectual de Gascaribe-Efigas.

  Unidad         : LDCCBL
  Descripcion    : Método de PB programado LDCCBL
                   proveedor.

  Autor          : KCienfuegos
  Fecha          : 04-08-2016
  Caso           : CA100-19133

  Parámetros           Descripción
  ============         ===================
  inuschedule          id de la programación

  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  04-08-2016    KCienfuegos.CA100-19133         Creación.
  30/05/2024	  JSOTO	OSF-2602				        Se elimina uso de ldc_boreportecartbrilla.proGenCarteraxLineaACierre
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
    -- Registro de la programación
    rcprogramacion dage_process_schedule.styge_process_schedule;

   BEGIN
    UT_Trace.Trace( 'Inicia LDCCBL.getparameters', 10);

    -- Instancia en memoria el identificador de la programación del proceso
    ge_boschedule.instanceschedule(inuschedule);

    -- Obtener registro de programación
    rcprogramacion := dage_process_schedule.frcgetrecord(inuschedule);

    -- Obtener Datos
    sbANO := ut_string.getparametervalue(rcprogramacion.parameters_,
                                         'FLOOR_NUMBER',
                                         ge_boschedule.csbseparador_parametros,
                                         ge_boschedule.csbseparador_valores);

    sbMes := ut_string.getparametervalue(rcprogramacion.parameters_,
                                         'LOCALS_AMOUNT',
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

    UT_Trace.Trace( 'Fin LDCCBL.getparameters', 10);
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
    UT_Trace.Trace( 'Inicia LDCCBL', 10);

    ge_boschedule.addlogtoscheduleprocess(inuschedule, nuhilo, nulogprocessid);
    getparameters();

    ge_boschedule.changelogprocessstatus(nulogprocessid, 'F');

    UT_Trace.Trace( 'Fin LDCCBL', 10);
EXCEPTION
  WHEN ex.controlled_error THEN
    errors.geterror(nuerrorcode, sberrormessage);
    ut_trace.trace('ERROR  LDCCBL[' || nuerrorcode || ']Mensaje[' ||
                   sberrormessage || ']');
  WHEN OTHERS THEN
    pkerrors.notifyerror(pkerrors.fsblastobject, Sqlerrm, gsberrmsg);
    pkerrors.pop;
    raise_application_error(pkconstante.nuerror_level2, gsberrmsg);
END LDCCBL;
/
