column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

    nuErrorCode       NUMBER;
    sbErrorMessage    VARCHAR2(4000);

BEGIN
    dbms_output.put_line('Inicia OSF-2363'); 

    UPDATE  wf_instance 
    SET     status_id = 4,
            previous_status_id =3
    WHERE   instance_id = 205536326;
    COMMIT;

    BEGIN
        dbms_output.put_line('--> inicia actualizacion de la instancia: 205536326');
        errors.Initialize;
        ut_trace.Init;
        ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
        ut_trace.SetLevel(0);
        ut_trace.Trace('INICIO');

        WF_BOAnswer_Receptor.AnswerReceptor(205536326, -- C�digo de la instancia del flujo
                                        MO_BOCausal.fnuGetSuccess); --se pasa el codigo del flujo
        COMMIT;
        dbms_output.put_line('--> Fin actualizacion de la instancia: 205536326');
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            Errors.getError(nuErrorCode, sbErrorMessage);
            dbms_output.put_line('ERROR CONTROLLED ');
            dbms_output.put_line('error onuErrorCode: ' || nuErrorCode);
            dbms_output.put_line('error osbErrorMess: ' || sbErrorMessage);
            ROLLBACK;
        when OTHERS then
            Errors.setError;
            Errors.getError(nuErrorCode, sbErrorMessage);
            dbms_output.put_line('ERROR OTHERS ');
            dbms_output.put_line('error onuErrorCode: ' || nuErrorCode);
            dbms_output.put_line('error osbErrorMess: ' || sbErrorMessage);
            ROLLBACK;
    END;


  COMMIT; 

    DBMS_OUTPUT.PUT_LINE('Termina OSF-2363'); 
EXCEPTION
WHEN OTHERS THEN 
 rollback; 
 DBMS_OUTPUT.PUT_LINE('Error no controlado --> '||sqlerrm); 
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/