set serveroutput on size unlimited 
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

    /***********************************************************
    ELABORADO POR:  Adriana Vargas
    EMPRESA:        MVM Ingenieria de Software
    FECHA:          Junio 2024 
    JIRA:           OSF-2766   
    ***********************************************************/
PROMPT =========================================
PROMPT **** Inicia Actualizar registro en entidad master_personalizaciones 
PROMPT 

BEGIN
    dbms_output.put_line('Actualizar registro COMENTARIO = ''MIGRADO ADM_PERSON'' en master_personalizaciones');
    UPDATE  MASTER_PERSONALIZACIONES 
       SET COMENTARIO = 'MIGRADO ADM_PERSON'
     WHERE  NOMBRE in (
       'DALD_AGE_RANGE',
        'DALD_BINE_CENCOSUD',
        'DALD_BLOCK_UNBLOCK_SH',
        'DALD_CANCEL_CAUSAL',
        'DALD_CHA_STA_SUB_AUDI',
        'DALD_COMMISSION',
        'DALD_CON_UNI_BUDGET',
        'DALD_CONSE_HISTORIC_SALES',
        'DALD_CREDIT_BUREAU',
        'DALD_CREG',
        'DALD_DEMAND_BUDGET',
        'DALD_DETA_EXTRA_QUOTA_FNB',
        'DALD_DETAIL_LIQUI_SELLER',
        'DALD_EXEC_METH',
        'DALD_EXTRA_QUOTA',
        'DALD_GENDER',
        'DALD_GENERAL_AUDIACE',
        'DALD_INCONS_FNB_EXITO',
        'DALD_LIQUIDATION',
        'DALD_LIQUIDATION_SELLER'
        );

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