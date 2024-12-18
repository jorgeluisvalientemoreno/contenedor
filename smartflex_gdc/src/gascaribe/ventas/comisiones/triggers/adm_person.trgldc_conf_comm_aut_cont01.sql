CREATE OR REPLACE TRIGGER ADM_PERSON.TRGLDC_CONF_COMM_AUT_CONT01
FOR INSERT OR UPDATE ON LDC_CONF_COMM_AUT_CONT
COMPOUND TRIGGER
    /*********************************************************************
    Propiedad Intelectual de Gasese de occidente

    Descripción: Trigger para validar la configuracion en la tabla LDC_CONF_COMM_AUT_CONT
    Autor      : Horbath
    Fecha      : 01-02-2022

    Historial de Modificaciones
    ======================================================================
    Fecha         Autor         Descripción
    *********************************************************************/

    cnuMESSCODE     ge_message.message_id%TYPE := 2741;
    nuExiste        NUMBER;
    nuCommerPlan    LDC_CONF_COMM_AUT_CONT.commercial_plan_id%TYPE;
    nuCateId        LDC_CONF_COMM_AUT_CONT.category_id%TYPE;
    nuDept          LDC_CONF_COMM_AUT_CONT.departament%TYPE;
    dtInitDate      LDC_CONF_COMM_AUT_CONT.date_init%TYPE;
    dtEndDate       LDC_CONF_COMM_AUT_CONT.date_end%TYPE;
    nuPercen        LDC_CONF_COMM_AUT_CONT.percentage%TYPE;
    
    CURSOR cuExisteConf
    (
        inuCommerPlan   IN  LDC_CONF_COMM_AUT_CONT.commercial_plan_id%TYPE,
        inuCateId       IN  LDC_CONF_COMM_AUT_CONT.category_id%TYPE,
        inuDept         IN  LDC_CONF_COMM_AUT_CONT.departament%TYPE,
        idtInitDate     IN  LDC_CONF_COMM_AUT_CONT.date_init%TYPE,
        idtEndDate      IN  LDC_CONF_COMM_AUT_CONT.date_end%TYPE
    )
    IS
        SELECT  count(1)
        FROM    LDC_CONF_COMM_AUT_CONT
        WHERE   commercial_plan_id = inuCommerPlan
        AND     category_id = inuCateId
        AND     departament = inuDept
        AND     (date_init BETWEEN idtInitDate AND idtEndDate OR
                 date_end BETWEEN idtInitDate AND idtEndDate);

    --Executed aftereach row change- :NEW, :OLD are available
     AFTER EACH ROW IS
     BEGIN
        ut_trace.trace('Inicia trigger trgLDC_CONF_COMM_AUT_CONT01 - AFTER EACH ROW',5);

        nuPercen        := :NEW.PERCENTAGE;
        nuCommerPlan    := :NEW.COMMERCIAL_PLAN_ID;
        nuCateId        := :NEW.CATEGORY_ID;
        nuDept          := :NEW.DEPARTAMENT;
        dtInitDate      := :NEW.DATE_INIT;
        dtEndDate       := :NEW.DATE_END;

        ut_trace.trace('Fin trigger trgLDC_CONF_COMM_AUT_CONT01 - AFTER EACH ROW',5);
     EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
          RAISE;
        WHEN others THEN
          Errors.setError;
          RAISE ex.CONTROLLED_ERROR;
     END AFTER EACH ROW;
     
     -- SE ejecuta despues de la sentencia
     AFTER STATEMENT IS
     BEGIN
        ut_trace.trace('Inicia trigger trgLDC_CONF_COMM_AUT_CONT01 - AFTER STATEMENT',5);
        -- Se valida el porcentaje
        IF nuPercen < 0 OR nuPercen > 100 THEN
            Errors.SetError(cnuMESSCODE,'El valor del porcentaje debe estar entre 0 y 100');
            RAISE ex.CONTROLLED_ERROR;
        END IF;

        -- Se valida el porcentaje
        IF dtEndDate < dtInitDate THEN
            Errors.SetError(cnuMESSCODE,'La fecha final no puede ser menor a la fecha inicial');
            RAISE ex.CONTROLLED_ERROR;
        END IF;

        OPEN cuExisteConf(nuCommerPlan, nuCateId, nuDept, dtInitDate, dtEndDate);
        FETCH cuExisteConf INTO nuExiste;
        CLOSE cuExisteConf;

        IF nuExiste > 1 THEN
            Errors.SetError(cnuMESSCODE,'Ya existe configuraci�n para el plan comercial['||nuCommerPlan||'], categoria['||nuCateId||'] y departamento['||nuDept
                                         ||'], para las fechas ['||dtInitDate||' y '||dtEndDate||']');
            RAISE ex.CONTROLLED_ERROR;
        END IF;
        ut_trace.trace('Fin trigger trgLDC_CONF_COMM_AUT_CONT01 - AFTER STATEMENT',5);

     EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
          RAISE;
        WHEN others THEN
          Errors.setError;
          RAISE ex.CONTROLLED_ERROR;
     END AFTER STATEMENT;
     
     /*
     --Executed before DML statement
     BEFORE STATEMENT IS
     BEGIN
       NULL;
     END BEFORE STATEMENT;

     --Executed before each row change- :NEW, :OLD are available
     BEFORE EACH ROW IS
     BEGIN
       NULL;
     END BEFORE EACH ROW;

     --Executed aftereach row change- :NEW, :OLD are available
     AFTER EACH ROW IS
     BEGIN
       NULL;
     END AFTER EACH ROW;

     --Executed after DML statement
     AFTER STATEMENT IS
     BEGIN
       NULL;
     END AFTER STATEMENT;
     */




END trgLDC_CONF_COMM_AUT_CONT01;
/