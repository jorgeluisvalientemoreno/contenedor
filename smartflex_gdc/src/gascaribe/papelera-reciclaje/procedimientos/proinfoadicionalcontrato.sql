CREATE OR REPLACE PROCEDURE proInfoAdicionalContrato(inuContrato  IN  suscripc.susccodi%TYPE,
                                                     ocuDatos    OUT CONSTANTS.TYREFCURSOR)
    IS

    sbProceso                     VARCHAR2(500) := 'proInfoAdicionalContrato';
    sbError                       VARCHAR2(4000);
    sbQuery                       VARCHAR2(4000);
    cnuCodigoError    CONSTANT    NUMBER := 2741;

  BEGIN

    ut_trace.trace('INICIO ' || sbProceso,10);

    sbQuery := 'Select pv.prog_viv_id id_programa,
                       pv.descripcion "Programa",
                       c.fecha_registro Fecha_de_Registro,
                       c.solicitud Solicitud,
                       nvl(:inuContrato,-2) parent_id
                  From ldc_tipo_vivienda_cont c, ldc_programas_vivienda pv
                 Where c.tipo_vivienda = pv.prog_viv_id And
                       c.contrato = nvl(:inuContrato,-2)';

    ut_trace.trace(sbQuery);
    dbms_output.put_line(sbQuery);

    OPEN ocuDatos FOR sbQuery
        USING inuContrato, inuContrato;

    ut_trace.trace('FIN ' || sbProceso,10);

EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
    ut_trace.trace('TERMINO CON ERROR ' || sbProceso || ' ' || sbError,10);
    IF(sbError IS NOT NULL)THEN
       ERRORS.SETERROR(inuapperrorcode => cnuCodigoError, isbargument => sbError);
    END IF;
    RAISE EX.CONTROLLED_ERROR;
  WHEN OTHERS THEN
    ut_trace.trace('TERMINO CON ERROR NO CONTROLADO '|| sbProceso ||SQLERRM,10);
    ERRORS.SETERROR;
    RAISE EX.CONTROLLED_ERROR;
END;
/
grant execute on proInfoAdicionalContrato to SYSTEM_OBJ_PRIVS_ROLE;
/