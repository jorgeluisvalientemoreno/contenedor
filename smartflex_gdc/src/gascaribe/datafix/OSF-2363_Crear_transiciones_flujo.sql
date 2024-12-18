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

    dbms_output.put_line('Inicia Eliminación de errores del flujo'); 

    delete from WF_EXCEPTION_LOG where instance_id in ( select i.instance_id
    from wf_instance i, wf_data_external de
    where   i.plan_id = de.plan_id
    and     de.package_id = 25266357);
    dbms_output.put_line('Fin Eliminación de errores del flujo'); 

    dbms_output.put_line('Inicia Inserta Transiciones'); 
    Insert into OPEN.wf_instance_trans
    (INST_TRAN_ID, ORIGIN_ID, TARGET_ID, GEOMETRY, GROUP_ID, 
    EXPRESSION, EXPRESSION_TYPE, DESCRIPTION, TRANSITION_TYPE_ID, ORIGINAL, 
    STATUS)
    Values
    (SEQ_WF_INSTANCE_TRANS.nextval, 205536310, 205536317, '64'||CHR(13)||'117'||CHR(13)||'699'||CHR(13)||'117', 0, 
    'FLAG_VALIDATE == SI', 0, 'La solicitud se atiende inmediatamente', 1, 'Y', 
    1);
    Insert into OPEN.wf_instance_trans
    (INST_TRAN_ID, ORIGIN_ID, TARGET_ID, GROUP_ID, EXPRESSION, 
    EXPRESSION_TYPE, DESCRIPTION, TRANSITION_TYPE_ID, ORIGINAL, STATUS)
    Values
    (SEQ_WF_INSTANCE_TRANS.nextval, 205536310, 205536312, 0, 'FLAG_VALIDATE == NO', 
    0, 'NO se atiende inmediatamente', 1, 'Y', 2);
    Insert into OPEN.wf_instance_trans
    (INST_TRAN_ID, ORIGIN_ID, TARGET_ID, GROUP_ID, EXPRESSION_TYPE, 
    TRANSITION_TYPE_ID, ORIGINAL, STATUS)
    Values
    (SEQ_WF_INSTANCE_TRANS.nextval, 205536312, 205536315, 0, 0, 
    1, 'Y', 2);
    Insert into OPEN.wf_instance_trans
    (INST_TRAN_ID, ORIGIN_ID, TARGET_ID, GROUP_ID, EXPRESSION_TYPE, 
    TRANSITION_TYPE_ID, ORIGINAL, STATUS)
    Values
    (SEQ_WF_INSTANCE_TRANS.nextval, 205536313, 205536314, 0, 0, 
    1, 'Y', 1);
    Insert into OPEN.wf_instance_trans
    (INST_TRAN_ID, ORIGIN_ID, TARGET_ID, GROUP_ID, EXPRESSION_TYPE, 
    TRANSITION_TYPE_ID, ORIGINAL, STATUS)
    Values
    (SEQ_WF_INSTANCE_TRANS.nextval, 205536314, 205536316, 0, 0, 
    1, 'Y', 1);
    Insert into OPEN.wf_instance_trans
    (INST_TRAN_ID, ORIGIN_ID, TARGET_ID, GROUP_ID, EXPRESSION_TYPE, 
    TRANSITION_TYPE_ID, ORIGINAL, STATUS)
    Values
    (SEQ_WF_INSTANCE_TRANS.nextval, 205536315, 205536313, 0, 0, 
    1, 'Y', 2);
    Insert into OPEN.wf_instance_trans
    (INST_TRAN_ID, ORIGIN_ID, TARGET_ID, GROUP_ID, EXPRESSION_TYPE, 
    TRANSITION_TYPE_ID, ORIGINAL, STATUS)
    Values
    (SEQ_WF_INSTANCE_TRANS.nextval, 205536316, 205536317, 0, 0, 
    1, 'Y', 1);
    Insert into OPEN.wf_instance_trans
    (INST_TRAN_ID, ORIGIN_ID, TARGET_ID, GROUP_ID, EXPRESSION_TYPE, 
    TRANSITION_TYPE_ID, ORIGINAL, STATUS)
    Values
    (SEQ_WF_INSTANCE_TRANS.nextval, 205536317, 205536311, 0, 0, 
    1, 'Y', 1);
    Insert into OPEN.wf_instance_trans
    (INST_TRAN_ID, ORIGIN_ID, TARGET_ID, GROUP_ID, EXPRESSION_TYPE, 
    TRANSITION_TYPE_ID, ORIGINAL, STATUS)
    Values
    (SEQ_WF_INSTANCE_TRANS.nextval, 205536319, 205536321, 0, 0, 
    1, 'Y', 2);
    Insert into OPEN.wf_instance_trans
    (INST_TRAN_ID, ORIGIN_ID, TARGET_ID, GROUP_ID, EXPRESSION_TYPE, 
    TRANSITION_TYPE_ID, ORIGINAL, STATUS)
    Values
    (SEQ_WF_INSTANCE_TRANS.nextval, 205536321, 205536320, 0, 0, 
    1, 'Y', 2);
    Insert into OPEN.wf_instance_trans
    (INST_TRAN_ID, ORIGIN_ID, TARGET_ID, GROUP_ID, EXPRESSION_TYPE, 
    TRANSITION_TYPE_ID, ORIGINAL, STATUS)
    Values
    (SEQ_WF_INSTANCE_TRANS.nextval, 205536323, 205536325, 0, 0, 
    1, 'Y', 2);
    Insert into OPEN.wf_instance_trans
    (INST_TRAN_ID, ORIGIN_ID, TARGET_ID, GROUP_ID, EXPRESSION_TYPE, 
    TRANSITION_TYPE_ID, ORIGINAL, STATUS)
    Values
    (SEQ_WF_INSTANCE_TRANS.nextval, 205536325, 205536326, 0, 0, 
    1, 'Y', 2);
    Insert into OPEN.wf_instance_trans
    (INST_TRAN_ID, ORIGIN_ID, TARGET_ID, GROUP_ID, EXPRESSION_TYPE, 
    TRANSITION_TYPE_ID, ORIGINAL, STATUS)
    Values
    (SEQ_WF_INSTANCE_TRANS.nextval, 205536326, 205536327, 0, 0, 
    1, 'Y', 1);
    Insert into OPEN.wf_instance_trans
    (INST_TRAN_ID, ORIGIN_ID, TARGET_ID, GROUP_ID, EXPRESSION, 
    EXPRESSION_TYPE, DESCRIPTION, TRANSITION_TYPE_ID, ORIGINAL, STATUS)
    Values
    (SEQ_WF_INSTANCE_TRANS.nextval, 205536327, 205536324, 0, 'FLAG_VALIDATE == NO', 
    0, 'NO Traslada Competencia', 1, 'Y', 1);
    Insert into OPEN.wf_instance_trans
    (INST_TRAN_ID, ORIGIN_ID, TARGET_ID, GEOMETRY, GROUP_ID, 
    EXPRESSION, EXPRESSION_TYPE, DESCRIPTION, TRANSITION_TYPE_ID, ORIGINAL, 
    STATUS)
    Values
    (SEQ_WF_INSTANCE_TRANS.nextval, 205536327, 205536325, '765'||CHR(13)||'391'||CHR(13)||'270'||CHR(13)||'391', 0, 
    'FLAG_VALIDATE == SI', 0, 'Traslada Competencia', 1, 'Y', 
    1);
    Insert into OPEN.wf_instance_trans
    (INST_TRAN_ID, ORIGIN_ID, TARGET_ID, GROUP_ID, EXPRESSION_TYPE, 
    TRANSITION_TYPE_ID, ORIGINAL, STATUS)
    Values
    (SEQ_WF_INSTANCE_TRANS.nextval, 205536329, 205536331, 0, 0, 
    1, 'Y', 1);
    Insert into OPEN.wf_instance_trans
    (INST_TRAN_ID, ORIGIN_ID, TARGET_ID, GROUP_ID, EXPRESSION_TYPE, 
    TRANSITION_TYPE_ID, ORIGINAL, STATUS)
    Values
    (SEQ_WF_INSTANCE_TRANS.nextval, 205536331, 205536330, 0, 0, 
    1, 'Y', 1);
    Insert into OPEN.wf_instance_trans
    (INST_TRAN_ID, ORIGIN_ID, TARGET_ID, GROUP_ID, EXPRESSION_TYPE, 
    TRANSITION_TYPE_ID, ORIGINAL, STATUS)
    Values
    (SEQ_WF_INSTANCE_TRANS.nextval, 205536333, 205536335, 0, 0, 
    1, 'Y', 2);
    Insert into OPEN.wf_instance_trans
    (INST_TRAN_ID, ORIGIN_ID, TARGET_ID, GROUP_ID, EXPRESSION_TYPE, 
    TRANSITION_TYPE_ID, ORIGINAL, STATUS)
    Values
    (SEQ_WF_INSTANCE_TRANS.nextval, 205536335, 205536334, 0, 0, 
    1, 'Y', 2);
    Insert into OPEN.wf_instance_trans
    (INST_TRAN_ID, ORIGIN_ID, TARGET_ID, GROUP_ID, EXPRESSION_TYPE, 
    TRANSITION_TYPE_ID, ORIGINAL, STATUS)
    Values
    (SEQ_WF_INSTANCE_TRANS.nextval, 205536337, 205536339, 0, 0, 
    1, 'Y', 1);
    Insert into OPEN.wf_instance_trans
    (INST_TRAN_ID, ORIGIN_ID, TARGET_ID, GROUP_ID, EXPRESSION_TYPE, 
    TRANSITION_TYPE_ID, ORIGINAL, STATUS)
    Values
    (SEQ_WF_INSTANCE_TRANS.nextval, 205536339, 205536338, 0, 0, 
    1, 'Y', 1);
    Insert into OPEN.wf_instance_trans
    (INST_TRAN_ID, ORIGIN_ID, TARGET_ID, GROUP_ID, EXPRESSION_TYPE, 
    TRANSITION_TYPE_ID, ORIGINAL, STATUS)
    Values
    (SEQ_WF_INSTANCE_TRANS.nextval, 205536341, 205536343, 0, 0, 
    1, 'Y', 1);
    Insert into OPEN.wf_instance_trans
    (INST_TRAN_ID, ORIGIN_ID, TARGET_ID, GROUP_ID, EXPRESSION_TYPE, 
    TRANSITION_TYPE_ID, ORIGINAL, STATUS)
    Values
    (SEQ_WF_INSTANCE_TRANS.nextval, 205536343, 205536342, 0, 0, 
    1, 'Y', 1);

    dbms_output.put_line('FIN Inserta Transiciones'); 

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