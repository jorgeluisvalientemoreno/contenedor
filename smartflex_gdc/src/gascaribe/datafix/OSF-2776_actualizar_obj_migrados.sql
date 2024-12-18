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
                        'LDC_ACTCALLCENTER'
                        ,'LDC_ATTRADDACCOUNTSENTITY'
                        ,'LDC_AUDIT_CHEQ_PROY'
                        ,'LDC_BINE_HOMECENTER'
                        ,'LDC_CARGPERI'
                        ,'LDC_CHEQUES_PROYECTO'
                        ,'LDC_CLIENTE_ESPECIAL'
                        ,'LDC_CONDBLOQASIG'
                        ,'LDC_CONSOLID_COTIZACION'
                        ,'LDC_CUOTAS_ADICIONALES'
                        ,'LDC_CUOTAS_PROYECTO'
                        ,'LDC_DETALLE_MET_COTIZ'
                        ,'LDC_EQUIVAL_UNID_PRED'
                        ,'LDC_FNB_COMMENT'
                        ,'LDC_FNB_DELIVER_DATE'
                        ,'LDC_FNB_SUBS_BLOCK'
                        ,'LDC_FNB_VSI'
                        ,'LDC_IMPRDOCU'
                        ,'LDC_INFO_PREDIO'
                        ,'LDC_INSTAL_GASODOM_FNB'
                        ,'LDC_INVOICE_FNB_SALES'
                        ,'LDC_ITEMS_COTIZ_PROY'
                        ,'LDC_ITEMS_COTIZACION_COM'
                        ,'LDC_ITEMS_METRAJE_COT'
                        ,'LDC_ITEMS_POR_UNID_PRED'      
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