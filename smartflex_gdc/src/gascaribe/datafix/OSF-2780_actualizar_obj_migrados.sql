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
                        'DALD_QUOTA_BY_SUBSC'
                        ,'DALD_SUPPLI_SETTINGS'
                        ,'DALDC_COTIZACION_COMERCIAL'
                        ,'DALDC_DETAREPOATECLI'
                        ,'DALDC_PARAGEEX'
                        ,'DALDC_TIPOINC_BYCON'
                        ,'DALD_DEAL'
                        ,'DALD_PROMISSORY'
                        ,'DALD_QUOTA_BLOCK'
                        ,'DALD_QUOTA_HISTORIC'
                        ,'DALDC_MARCA_PRODUCTO'
                        ,'DALD_ASIG_SUBSIDY'
                        ,'DALD_SECURE_SALE'
                        ,'DALD_ITEM_WORK_ORDER'
                        ,'DALD_QUOTA_TRANSFER'
                        ,'DALD_SUBLINE'
                        ,'DALD_TEMP_CLOB_FACT'
                        ,'DALDC_PROYECTO_CONSTRUCTORA'
                        ,'DALD_SUBSIDY'
                        ,'DALD_CUPON_CAUSAL'
                        ,'DALD_POLICY'
                        ,'DALD_UBICATION'
                        ,'DALD_NON_BA_FI_REQU'
                        ,'DALDC_PARAREPE'
                        ,'PKTBLLDC_RESOGURE'   
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