CREATE OR REPLACE PROCEDURE PR_POLICY_EXEQ_ROLLOUT (nuInicio number, nuFinal number, nuBD number) AS
/*******************************************************************
 PROGRAMA    	:	PR_POLICY_EXEQ_ROLLOUT
 FECHA		:	06/01/2015
 AUTOR		:	OPEN
 DESCRIPCION	:	Actualiza las polizas a exiquiales del tipo 260
 HISTORIA DE MODIFICACIONES
 AUTOR	   FECHA	DESCRIPCION

 *******************************************************************/

    nuErrorCode NUMBER;
    sbErrorMessage VARCHAR2(4000);
    CURSOR cuPolizasExequial
    IS
    SELECT a.*
    FROM ld_policy a, ld_policy_type  b
    WHERE  a.policy_type_id=b.policy_type_id
    AND b.is_exq='S' 
    AND a.policy_type_id = 260;
BEGIN                         -- ge_module
    errors.Initialize;
--    ut_trace.Init;
--    ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
--    ut_trace.SetLevel(15);
    ut_trace.Trace('INICIO');
    
     UPDATE migr_rango_procesos SET RAPRFEIN = SYSDATE, RAPRTERM = 'P' WHERE RAPRCODI = 235 AND RAPRBASE = nuBD AND RAPRRAIN = nuInicio AND RAPRRAFI = nuFinal;
     COMMIT;

    for rc  in cuPolizasExequial loop
        -- actualiza el flag de poliza exequial
        dald_policy.updPOLICY_EXQ(rc.policy_id, dald_policy_type.fsbGetIS_EXQ (rc.policy_type_id));
    END loop;

UPDATE migr_rango_procesos SET RAPRFEFI = SYSDATE, RAPRTERM = 'T' WHERE RAPRCODI = 235 AND RAPRBASE = nuBD AND RAPRRAIN = nuInicio AND RAPRRAFI = nuFinal;
COMMIT;

EXCEPTION
    when ex.CONTROLLED_ERROR  then
        Errors.getError(nuErrorCode, sbErrorMessage);
        ut_trace.Trace('ERROR CONTROLLED ',12);
        ut_trace.Trace('error onuErrorCode: '||nuErrorCode,12);
        ut_trace.Trace('error osbErrorMess: '||sbErrorMessage,12 );

    when OTHERS then
        Errors.setError;
        Errors.getError(nuErrorCode, sbErrorMessage);
        ut_trace.Trace('ERROR OTHERS ',12);
        ut_trace.Trace('error onuErrorCode: '||nuErrorCode,12);
        ut_trace.Trace('error osbErrorMess: '||sbErrorMessage,12 );
	
END PR_POLICY_EXEQ_ROLLOUT; 
/
