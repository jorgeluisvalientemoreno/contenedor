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
                        'DALD_BILL_PENDING_PAYMENT'
                        ,'DALD_BINE_OLIMPICA'
                        ,'DALD_CONSTRUCT_UNIT'
                        ,'DALD_CONVENT_EXITO'
                        ,'DALD_DETAIL_LIQUIDATION'
                        ,'DALD_FNB_SALE_FI_CON'
                        ,'DALD_LOG_FILE_FNB'
                        ,'DALD_PRICE_LIST'
                        ,'DALD_ROLLOVER_QUOTA'
                        ,'DALD_SALES_WITHOUTSUBSIDY'
                        ,'DALD_SAMPLE'
                        ,'DALD_SIMULATED_QUOTA'
                        ,'DALD_SPONSOR'
                        ,'DALDC_ACTAS_PROYECTO'
                        ,'DALDC_ANTIC_CONTR'
                        ,'DALDC_AUDIT_CUOT_PROY'
                        ,'DALDC_CAUSAL_SSPD'
                        ,'DALDC_CONFIG_EQUIVA_SSPD'
                        ,'DALDC_EQUI_CAUSAL_SSPD'
                        ,'DALDC_EQUI_PACKTYPE_SSPD'
                        ,'DALDC_EQUIVALENCIA_SSPD'
                        ,'DALDC_TIPO_RESPUESTA'
                        ,'DALD_BRAND'
                        ,'DALD_CONSULT_CODES'
                        ,'DALD_POLICY_EXCLUSION'   
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