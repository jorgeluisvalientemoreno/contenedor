SET SERVEROUTPUT ON;
COLUMN dt NEW_VALUE vdt
COLUMN db NEW_VALUE vdb
SELECT to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db FROM dual;
SET SERVEROUTPUT ON SIZE UNLIMITED 
SELECT to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio FROM dual;
BEGIN
    dbms_output.put_line('Actualizar registros en master_personalizaciones');
    
    --Campo comentario = MIGRADO ADM_PERSON: Se migro el objeto al esquema ADM_PERSON           
    UPDATE  master_personalizaciones 
    SET comentario = 'MIGRADO ADM_PERSON'
    WHERE  nombre IN (
                        'LD_BCFACTURACION'
                        ,'LD_BOCOUPONPRINTING'                        
                    );    
                    
    --Campo comentario = BORRADO: Se borro el objeto de la BD                
    UPDATE  master_personalizaciones 
    SET comentario = 'BORRADO'
    WHERE  nombre IN (
                        'CC_BOFINSAMPLEDETAIL'
                        ,'DL_COMMON_VARIABLES'
                        ,'FREC_'
                        ,'GDO_REPORCOMPVINCULACION'
                        ,'GDO_REPORTECONSUMOS'
                        ,'GDO_REPORTEOYM'
                        ,'GDO_REPORTESFACTURACION'
                        ,'GE_BODAOPACKAGEGENERATOR'
                        ,'GE_OBJECT_19109_'
                        ,'GE_OBJECT_19110_'
                        ,'GE_OBJECT_49282_'
                        ,'LD_BCAPROVE_RANDOM'
                        ,'LD_BCCONFIGURATIONNOTIFICATION'
                        ,'LD_BCEXECUTEDBUDGE'
                        ,'LD_BCPROCESS_BLOCKED'
                        ,'LD_BOCOUPONPRINTINGCM'
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