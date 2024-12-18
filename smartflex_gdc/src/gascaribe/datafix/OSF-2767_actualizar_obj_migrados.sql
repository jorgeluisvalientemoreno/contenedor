SET SERVEROUTPUT ON;
COLUMN dt NEW_VALUE vdt
COLUMN db NEW_VALUE vdb
SELECT to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db FROM dual;
SET SERVEROUTPUT ON SIZE UNLIMITED 
SELECT to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio FROM dual;
BEGIN
    dbms_output.put_line('Actualizar registros en master_personalizaciones');
    
    --Campo comentario = BORRADO: Se borro el objeto de la BD                
    UPDATE  master_personalizaciones 
    SET comentario = 'MIGRADO ADM_PERSON'
    WHERE  nombre IN (
                        'DALD_MOVE_SUB'
                        ,'DALD_ORDER_CONS_UNIT'
                        ,'DALD_PRICE_LIST_DEHI'
                        ,'DALD_PROMISSORY_PU'
                        ,'DALD_PROPERT_BY_ARTICLE'
                        ,'DALD_PROPERTY'
                        ,'DALD_RELEVANT_MARKET'
                        ,'DALD_RESULT_CONSULT'
                        ,'DALD_REV_SUB_AUDIT'
                        ,'DALD_SALES_VISIT'
                        ,'DALD_SAMPLE_CONT'
                        ,'DALD_SAMPLE_DETAI'
                        ,'DALD_SAMPLE_FIN'
                        ,'DALD_SECURE_CANCELLA'
                        ,'DALD_SERVICE_BUDGET'
                        ,'DALD_SINESTER_CLAIMS'
                        ,'DALD_SUB_REMAIN_DELIV'
                        ,'DALD_SUBSIDY_CONCEPT'
                        ,'DALD_SUBSIDY_STATES'
                        ,'DALD_TMP_MAX_RECOVERY'       
                    );                                               
                    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('No se pudo actualizar registro en master_personalizaciones, '||sqlerrm);
END;
/
SELECT to_char(sysdate, 'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin
  FROM dual;
/