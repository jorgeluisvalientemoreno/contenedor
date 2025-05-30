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
    SET comentario = 'BORRADO'
    WHERE  nombre IN (
                        'LDC_BOENCUESTA'
                        ,'LDC_ENCUESTA'
                        ,'LDC_FNCRETORNAOTENCUECONCCERO'
                        ,'LDC_FSBRETORNARESPPRENENCUES'                   
                        ,'LDC_PROCREPAVC'
                        ,'LDC_PROCREPAVC_AUTOMATICO'
                        ,'LDCI_PKGESTINFOADOT'
                        ,'LDCI_PKINFOADICIONALENCU'
                        ,'LDCI_PKINFOADIOTLECT'
                        ,'TRG_BI_LDC_ENCUESTA'
                        ,'TRGAFTERENCUESTA'                  
                    );    
    
    UPDATE  master_personalizaciones 
    SET comentario = 'OPEN'
    WHERE  nombre = 'LDC_PK_PARAMETROS_VISTAS';
                        
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