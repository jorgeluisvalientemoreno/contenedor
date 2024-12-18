CREATE OR REPLACE FUNCTION adm_person.FNUGETAPPLYACT
(
    inuPtoAtencion   IN  ge_organizat_area.organizat_area_id%TYPE,
    inuActivity      IN  ge_items.items_id%TYPE
)
RETURN NUMBER IS
  /***********************************************************************************************************
    Funcion     : FNUGETAPPLYACT
    Descripcion : Valida IS la actividad esta asociada al punto de atencion
    Autor       : Santiago Gonzales
    Fecha       : 20-01-2022
    Caso        :779

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
  ************************************************************************************************************/

    CURSOR cuExistePunto
    IS
        SELECT count(1)
        FROM LDC_POINTAT_ACT
        WHERE organizat_area_id = inuPtoAtencion;
        
    CURSOR cuExistePuntoActi
    IS
        SELECT count(1)
        FROM LDC_POINTAT_ACT
        WHERE organizat_area_id = inuPtoAtencion
        AND   items_id = inuActivity;
        
    nuExistePunto       NUMBER;
    nuExistePuntoActi   NUMBER;
    nuErrorCode         NUMBER;
    sbErrorMessage      VARCHAR2(4000);
    cbsCASO779          CONSTANT        VARCHAR2(20) := '0000779';

BEGIN
    ut_trace.trace('Inicia FNUGETAPPLYACT - inuPtoAtencion: '||inuPtoAtencion||' inuActivity:'||inuActivity,10);
    
    IF NOT open.fblaplicaentregaxcaso(cbsCASO779) THEN
        ut_trace.trace('Fin FNUGETAPPLYACT - RETURN 1',10);
        RETURN 1;
    END IF;
    
    OPEN cuExistePunto;
    FETCH cuExistePunto INTO nuExistePunto;
    CLOSE cuExistePunto;
    
    IF nuExistePunto = 0 THEN
        ut_trace.trace('Fin FNUGETAPPLYACT - RETURN 1',10);
        RETURN 1;
    END IF;
    
    OPEN cuExistePuntoActi;
    FETCH cuExistePuntoActi INTO nuExistePuntoActi;
    CLOSE cuExistePuntoActi;

    IF nuExistePuntoActi > 0 THEN
        ut_trace.trace('Fin FNUGETAPPLYACT - RETURN 1',10);
        RETURN 1;
    END IF;
    
    ut_trace.trace('Fin FNUGETAPPLYACT - RETURN 1',10);
    RETURN 0;
    

EXCEPTION
    when ex.CONTROLLED_ERROR  then
        Errors.getError(nuErrorCode, sbErrorMessage);
    when OTHERS then
        Errors.setError;
        Errors.getError(nuErrorCode, sbErrorMessage);
END FNUGETAPPLYACT;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('FNUGETAPPLYACT', 'ADM_PERSON');
END;
/