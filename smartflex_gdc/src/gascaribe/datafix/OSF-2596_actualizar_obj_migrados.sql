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
                        'LDC_PRONOTIORDEN'
                        ,'LDCPRRECAFEC'
                        ,'LDCPROVALDTADCERTOIA'
                        ,'LDCPRMETODESTRATIFICACION'
                        ,'LDCI_VALIDA_CERTIF_OIA'
                        ,'PROCGENERACUPON_BCOLOMBIA'
                        ,'LDC_VAL_CAUS_APELACION'
                        ,'PRTEMPORALCHARGES'
                        ,'LDC_PRVALDATCAMBORDER'
                        ,'LDC_REGPROGESAC'
                        ,'LDC_PRVPMUPDATEFECHA'
                        ,'LDC_VALIDAITEMTITR'
                        ,'LDC_PRVALIDAITEMCOTIZADO'
                        ,'LDC_PROVALIREGENSERVNUEVOS'
                    ); 
                    
    UPDATE  master_personalizaciones 
    SET comentario = 'BORRADO'
    WHERE  nombre IN ('LDCPROCREVERSAMARCACAUSFALL' 
                      ,'PRINITCOPRSUCA'
                      ,'LDC_PRUODEFECTO');
                      
    UPDATE  master_personalizaciones 
    SET comentario = 'OPEN'
    WHERE  nombre IN ('LDC_PRRECLFACT' 
                      ,'LDC_PRRECLCONT'  
                      ,'LDC_PRRECUCONT');
                    
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