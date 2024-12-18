CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_VAL_TIEMP_FIN_EJE_ORD(inuOrden   IN  or_order.order_id%TYPE) IS
    /*****************************************************************
    PROPIEDAD INTELECTUAL DE EFIGAS-GASCARIBE

    UNIDAD         : LDC_VAL_TIEMP_FIN_EJE_ORD
    DESCRIPCION    : Metodo para validar la fecha final de ejecucion de la orden con respecto
                     a la fecha de legalizacion de la misma.
    AUTOR          : KCienfuegos
    CA             : 200-533
    FECHA          : 17-04-2016

    PARAMETROS              DESCRIPCION
    ============         ===================

    FECHA             AUTOR             MODIFICACION
    =========       =========           ====================
    17-04-2016      KCienfuegos         Creacion
    ******************************************************************/

    --Constantes
    csbEntrega                 CONSTANT   VARCHAR2(20) := 'CRM_SAC_KCM_200533_1';
    cnuTiempoEjecYLegal        CONSTANT   ld_parameter.numeric_value%TYPE := dald_parameter.fnuGetNumeric_Value('TIEMPO_ENTRE_FIN_EJEC_Y_LEGAL',0);

    --Variables
    sbProceso                             VARCHAR2(4000) := 'ldc_val_tiemp_fin_eje_ord';
    sbError                               VARCHAR2(4000);
    sbAplicacion                          VARCHAR2(2000);
    nuExiste                              NUMBER;
    nuPaso                                NUMBER;
    nuDiferenciaEnMinutos                 NUMBER;
    dtFechaFinEjec                        DATE;
    nuTipoTrabajo                         or_task_type.task_type_id%TYPE;
    sbTiposTrabajoAValidar                ld_parameter.value_chain%TYPE := dald_parameter.fsbGetValue_Chain('TT_VALIDA_FIN_EJEC',0);


BEGIN
    ut_trace.trace('INICIO ' || sbProceso,15);

    -- Validar que la entrega esta aplicada, sino esta aplicada no ejecuta accion alguna.
    IF fblaplicaentrega(csbEntrega) THEN

        dtFechaFinEjec := daor_order.fdtgetexecution_final_date(inuOrden,0);

        nuTipoTrabajo := daor_order.fnugettask_type_id(inuOrden,0);

        -- Recibe como parametros una fecha y un tipo de trabajo
        IF dtFechaFinEjec IS NULL THEN
            sbError := 'Por favor ingresar la fecha a evaluar';
            RAISE ex.Controlled_Error;
        END IF;

        IF nuTipoTrabajo IS NULL THEN
            sbError := 'Por favor ingresar el tipo de trabajo a evaluar';
            RAISE ex.Controlled_Error;
        END IF;

        -- Validar que el programa ejecutado sea ORCAO
        sbAplicacion := ut_session.getmodule;

        ut_trace.trace('Aplicacion: ' || sbAplicacion,15);

        IF sbAplicacion = 'ORCAO' THEN

          IF cnuTiempoEjecYLegal IS NULL THEN
              sbError := 'No se encontro un valor definido para el parametro TIEMPO_ENTRE_FIN_EJEC_Y_LEGAL';
              RAISE ex.Controlled_Error;
          END IF;

          IF cnuTiempoEjecYLegal < 0 THEN
              sbError := 'El valor definido en el parametro TIEMPO_ENTRE_FIN_EJEC_Y_LEGAL debe ser positivo, actualmente es ' ||
                         cnuTiempoEjecYLegal;
              RAISE ex.Controlled_Error;
          END IF;

          IF sbTiposTrabajoAValidar IS NULL THEN
              sbError := 'No se encontro un valor definido para el parametro TT_VALIDA_FIN_EJEC';
              RAISE ex.Controlled_Error;
          END IF;

          sbTiposTrabajoAValidar := sbTiposTrabajoAValidar || ',';

          /*  Validar si el tipo de trabajo ingresado por parametro este contenido en los tipos de trabajo definidos en el
              parametro TT_VALIDA_FIN_EJEC.*/
          nuExiste := instr(sbTiposTrabajoAValidar, nuTipoTrabajo || ',');

          IF nuExiste > 0 THEN
            /* A la fecha actual restarle la fecha ingresada por parametro, convertir este dato a minutos y si es menor a los
               minutos obtenidos en el parametro TIEMPO_ENTRE_FIN_EJEC_Y_LEGAL mostrar un error en la aplicacion.*/
            nuDiferenciaEnMinutos := trunc((SYSDATE - dtFechaFinEjec) * 24 * 60);

            IF nuDiferenciaEnMinutos < cnuTiempoEjecYLegal THEN
                sbError := 'La fecha de fin de ejecucion debe ser menor a ' ||
                           to_char((SYSDATE - (cnuTiempoEjecYLegal / 24 / 60)), 'dd-mm-yyyy hh:mi:ss a.m.');
                RAISE ex.Controlled_Error;
            END IF;

          END IF;

        END IF;

    END IF;

    ut_trace.trace('FIN ' || sbProceso,15);

EXCEPTION
    WHEN ex.Controlled_Error THEN
        errors.seterror(Ld_Boconstans.cnuGeneric_Error, sbError);
        RAISE;
    WHEN OTHERS THEN
        sbError := 'TERMINO CON ERROR NO CONTROLADO  ' || sbProceso || '(' || nuPaso || '): ' || SQLERRM;
        ut_trace.trace(sbError);
        dbms_output.put_line(sbError);
        errors.seterror(Ld_Boconstans.cnuGeneric_Error, sbError);
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_VAL_TIEMP_FIN_EJE_ORD', 'ADM_PERSON');
END;
/