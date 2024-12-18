set serveroutput on size unlimited 
set linesize 1000
set timing on
EXECUTE dbms_application_info.set_action('APLICANDO DATAFIX 2739'); 
PROMPT =========================================
PROMPT **** Inicia Actualizar registro en entidad master_personalizaciones 
PROMPT 

BEGIN
    dbms_output.put_line('Actualizar registro COMENTARIO = ''BORRADO'' en master_personalizaciones');
    UPDATE  MASTER_PERSONALIZACIONES 
       SET COMENTARIO = 'BORRADO'
     WHERE  NOMBRE in (
        'DALD_BINE_FINA_ENT',
        'DALD_CATALOG',
        'DALD_CAUS_REV_SUB',
        'DALD_CAUSAL',
        'DALD_CAUSAL_TYPE',
        'DALD_CO_UN_TASK_TYPE',
        'DALD_CONCEPTO_REM',
        'DALD_CREG_RESOLUTION',
        'DALD_DETAIL_NOTIFICATION',
        'DALD_DIS_EXP_BUDGET',
        'DALD_DOCUMENT_TYPE',
        'DALD_EQUIVALENCE_LINE',
        'DALD_FINAN_PLAN_FNB',
        'DALD_FNB_WARRANTY',
        'DALD_HIST_ITEM_WO_OR',
        'DALD_INDEX_IPP_IPC',
        'DALD_LAUNCH',
        'DALD_LINE',
        'DALD_LIQUIDATION_TYPE',
        'DALD_MAR_EXP_BUDGET');

    IF SQL%FOUND THEN
       dbms_output.put_line('Registros afectados: '||SQL%ROWCOUNT); 
    END IF;
    COMMIT;  
       
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('No se pudo actualizar registro en master_personalizaciones, '||sqlerrm);
END;
/
  
PROMPT **** Termina actualizar registro entidad master_personalizaciones**** 
PROMPT =========================================

set timing off
set serveroutput off
/