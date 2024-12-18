CREATE OR REPLACE FUNCTION ldc_fnugetultimobloqueo 
(
    inuPackageId IN ldc_asigna_unidad_rev_per.solicitud_generada%TYPE 

) RETURN NUMBER 
IS PRAGMA AUTONOMOUS_TRANSACTION;

  /*****************************************************************
   Propiedad intelectual de Gases del Caribe S.A.

   Unidad         : ldc_fnugetultimobloqueo
   Descripcion    : Consulta si existe un registro de bloqueo por solicitud 
                    en la tabla ldc_order
   Autor          : Luis Felipe Valencia Hurtado
   Fecha          :

   Parametros              Descripcion
   ============         ===================
   inuPackageId         Número de solicitud


   Historia de Modificaciones
   Fecha             Autor             Modificacion
   =========       =========           ====================

   ******************************************************************/

    CURSOR cuLdc_order IS
    SELECT  COUNT('X')
    FROM    ldc_order o
    WHERE   o.package_id = inuPackageId;

    nuCount     NUMBER;

    sbErrMsg    ge_error_log.description%TYPE;
BEGIN
    ut_trace.trace('Incia Funcion ldc_fnugetultimobloqueo',10);

    nuCount := 0;

    OPEN cuLdc_order;
    FETCH cuLdc_order INTO nuCount;
    CLOSE cuLdc_order;

    ut_trace.trace('Fin Funcion ldc_fnugetultimobloqueo',10);
    RETURN nuCount;

EXCEPTION
    WHEN LOGIN_DENIED THEN
        IF(cuLdc_order%ISOPEN) THEN
            CLOSE cuLdc_order;
        END IF;
        pkErrors.Pop;
        raise LOGIN_DENIED;

    WHEN pkConstante.exERROR_LEVEL2 THEN
        IF(cuLdc_order%isopen) THEN
            CLOSE cuLdc_order;
        END IF;
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;

    WHEN OTHERS THEN
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
        IF(cuLdc_order%isopen) THEN
            CLOSE cuLdc_order;
        END IF;
        pkErrors.Pop;
        raise_application_error(pkConstante.nuERROR_LEVEL2,sbErrMsg);
END;
/
