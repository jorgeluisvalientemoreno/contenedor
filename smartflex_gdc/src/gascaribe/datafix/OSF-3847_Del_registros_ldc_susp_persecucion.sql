COLUMN dt NEW_VALUE vdt
COLUMN db NEW_VALUE vdb
SELECT to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db FROM dual;
SET SERVEROUTPUT ON SIZE UNLIMITED
EXECUTE dbms_application_info.set_action('APLICANDO DATAFIX');
SELECT to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio FROM dual;

DECLARE
   
   nuCant NUMBER;
BEGIN
    
    SELECT COUNT(*) CANT
    INTO nuCant
    FROM ldc_susp_persecucion
    WHERE trunc(susp_persec_fejproc) <= '01/01/2025';
    
    dbms_output.put_line('Se eliminan: ' || nuCant ||' registros de la tabla ldc_susp_persecucion con fecha <= 01/01/2025');
    
    DELETE ldc_susp_persecucion
    WHERE trunc(susp_persec_fejproc) <= '01/01/2025';
        
    COMMIT;        

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Error[' || sqlerrm || ']');
        ROLLBACK;  
END;
/

SELECT to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin FROM dual;
SET SERVEROUTPUT OFF
QUIT
/