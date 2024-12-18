SET SERVEROUTPUT ON;
COLUMN dt NEW_VALUE vdt
COLUMN db NEW_VALUE vdb
SELECT to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db FROM dual;
SET SERVEROUTPUT ON SIZE UNLIMITED 
SELECT to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio FROM dual;
BEGIN
    dbms_output.put_line('Actualizar registro en master_personalizaciones');
    UPDATE  master_personalizaciones 
    SET comentario = 'MIGRADO ADM_PERSON'
    WHERE  nombre IN (
                        'LDC_CLOSEORDER'
                        ,'LDC_NOTIFICA_CIERRE_OT'
                        ,'LDC_PRFILLOTREVDET'                  
                        ,'LDC_UPDATE_GRACE_PERIOD'
                        ,'LDC_VAL_CAUS_PACK_TYPE'
                        ,'LDCPROCESCAMBIOFELEOT'
                        ,'PR_UPDATE_VALUE_COTI'                       
                        ,'LDCLEGGENNOT_TEMP'
                        ,'PR_VALID_INCLUD_MAT'
                        ,'LDC_PROCREATRAMITECERTI'
                        ,'LDC_PROCIERRAOTVISITACERTI'                        
                    );   
                    
    UPDATE  master_personalizaciones 
    SET comentario = 'BORRADO'
    WHERE  nombre IN (
                        'LDC_PROVALIQNOLEGAXORCAO'
                        ,'LDC_VAL_SUSP_DEFECT'
                        ,'PROCESSVARACTANOVE'                        
                        ,'LDC_PROCNOUORT'
                        ,'PROCESSESOLICITUD'
                        ,'LDC_PRREGISTRAORDEN'
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