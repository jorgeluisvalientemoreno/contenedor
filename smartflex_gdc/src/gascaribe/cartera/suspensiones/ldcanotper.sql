create or replace PROCEDURE ldcanotper(inuProgramacion IN ge_process_schedule.process_schedule_id%TYPE) IS
    /*****************************************************************
      Propiedad intelectual de PETI (c).

      Unidad         : ldcanotper
      Descripcion    : Anula ordenes de persecusion
      Autor          :
      Fecha          :

      Historia de Modificaciones
      Fecha         Autor           Modificacion
      =========     =========       ====================
      07-09-2021    F.Castro        CA-828 Se modifica cursor para que los estados de corte a excluir sean configurables mediante parametro
      14-07-2022    dsaltarin       OSF-434: Solo debe anular ordenes en estado registrado. Se elimina codigo en comentario y variables no utilizadas.
      08-02-2024    GDGuevara       OSF-2310: Se adiciona al cursor curegorders la restriccion "OR ss.sesuesfn IN ('A','D')"
                                              para incluir las ordenes de los productos con estado financiero al dia (A) o con deuda (D) sin importar
                                              el estado tecnico que tengan, el valor del estado financiero se toma del parametro EST_FINAN_LDCANOTPER
                                              Se ajusta el codigo con el modelo de personalizacion para Open8
    *****************************************************************************/

    csbTipoTrabPer   CONSTANT VARCHAR2(2000) := dald_parameter.fsbgetvalue_chain('TIPOS_TRABAJO_PERSECUCION',NULL);
    csbEstadoCorte   CONSTANT VARCHAR2(2000) := dald_parameter.fsbgetvalue_chain('EST_CORTE_LDCANOTPER',NULL);
    csbEstadoFinanc  CONSTANT VARCHAR2(4000) := pkg_parametros.fsbGetValorCadena('EST_FINAN_LDCANOTPER');

    nuError          NUMBER;
    sbErrorMessage   VARCHAR2(4000);
    nuCausalId       NUMBER;
    rcOrder          daor_order.styOr_order;
    nuLoop           NUMBER(1);
    nuHilos          NUMBER := 1;
    nuLogProceso     ge_log_process.log_process_id%TYPE;
    nuordertrabaj    or_order.order_id%TYPE;
    sbParametros     ge_process_schedule.parameters_%TYPE;
    nucontaregenco   NUMBER(8);
    estadoot1        NUMBER;
    sbProceso        VARCHAR2(100) := 'LDCANOTPER'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');
    nuTotalRegi      NUMBER;

    -- CURSOR para ordenes a anular
    CURSOR curegorders(nucuorder or_order.order_id%TYPE) IS
        SELECT oa.order_id   orden_trabajo
              ,oa.product_id producto
              ,ss.sesuesco   estado_corte
          FROM or_order          ot
              ,or_order_activity oa
              ,servsusc          ss
         WHERE ot.order_id = decode(nucuorder, -1, ot.order_id, nucuorder)
           AND ot.task_type_id IN (SELECT to_number(regexp_substr(csbTipoTrabPer,
                                                   '[^,]+',
                                                   1,
                                                   LEVEL)) AS TipoTrabajo
                                   FROM dual
                                   CONNECT BY regexp_substr(csbTipoTrabPer, '[^,]+', 1, LEVEL) IS NOT NULL)
           AND ot.order_status_id IN (estadoot1)
           AND (ss.sesuesco NOT IN (SELECT to_number(regexp_substr(csbEstadoCorte,
                                                   '[^,]+',
                                                   1,
                                                   LEVEL)) AS EstaCort
                                   FROM dual
                                   CONNECT BY regexp_substr(csbEstadoCorte, '[^,]+', 1, LEVEL) IS NOT NULL)
                 OR ss.sesuesfn IN (SELECT (regexp_substr(csbEstadoFinanc,
                                                   '[^,]+',
                                                   1,
                                                   LEVEL)) AS EstaFina
                                   FROM dual
                                   CONNECT BY regexp_substr(csbEstadoFinanc, '[^,]+', 1, LEVEL) IS NOT NULL)
               )
           AND ot.order_id = oa.order_id
           AND oa.product_id = ss.sesunuse;
BEGIN
    estadoot1 := dald_parameter.fnuGetNumeric_Value('ESTADO_REGISTRADO', NULL);
    nuTotalRegi := 0;
    nucontaregenco := 0;

    -- Se inicia log del programa
    pkg_estaproc.prinsertaestaproc(sbProceso, nuTotalRegi);

    -- Se adiciona al log de procesos
    IF inuProgramacion = -1
    THEN
        nuordertrabaj := -1;
    ELSE
        ge_boschedule.AddLogToScheduleProcess(inuProgramacion, nuHilos, nuLogProceso);
        sbParametros  := dage_process_schedule.fsbGetParameters_(inuProgramacion);
        nuordertrabaj := to_number(ut_string.getparametervalue(sbParametros, 'ORDER_ID', '|', '='));
    END IF;

    nucausalid := dald_parameter.fnuGetNumeric_Value('CAUSAL_ANUL_OT_PERSECUCION', NULL);
    IF nuCausalId IS NULL THEN
        pkg_error.seterrormessage(Ld_Boconstans.cnuGeneric_Error,
                                  'El parametro CAUSAL_ANUL_OT_PERSECUCION no existe');
    END IF;

    FOR i IN curegorders(nuordertrabaj)
    LOOP
        nucontaregenco := nucontaregenco + 1;
        BEGIN
            -- bloqueo de orden
            daor_order.lockbypk(i.orden_trabajo, rcorder);
            nuLoop := 1;
        EXCEPTION
            WHEN OTHERS THEN
                nuloop := 0;
        END;
        IF nuLoop = 1
        THEN
            -- Anula la orden de suspension
            api_anullorder(i.orden_trabajo, null, null, nuError, sberrormessage);
            -- Actualiza la causal escogida
            daor_order.updcausal_id(i.orden_trabajo, nucausalid);
            -- Actualizamos valor
            nuTotalRegi := nuTotalRegi + 1;
        END IF;
    END LOOP;

    sberrormessage := 'Proceso terminó Ok. Total registros encontrados : ' || to_char(nucontaregenco) ||
                      '. Total registros procesados : ' || to_char(nuTotalRegi);
    pkg_estaproc.practualizaestaproc(sbProceso, 'Ok', sberrormessage);

EXCEPTION
    WHEN pkg_error.controlled_error THEN
        pkg_error.geterror(nuError, sberrormessage);
        pkg_estaproc.practualizaestaproc(sbProceso, 'Error', sberrormessage);
    WHEN OTHERS THEN
        pkg_error.seterror;
        pkg_error.geterror(nuError, sberrormessage);
        pkg_estaproc.practualizaestaproc(sbProceso, 'Error', sberrormessage);
END ldcanotper;
/