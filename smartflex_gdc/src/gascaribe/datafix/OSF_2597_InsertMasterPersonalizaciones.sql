column dt new_value vdt
column db new_value vdb
select TO_CHAR(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
SET SERVEROUTPUT ON SIZE UNLIMITED
EXECUTE dbms_application_info.set_action('APLICANDO DATAFIX 2597');
SELECT TO_CHAR(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
PROMPT Inicia registro en entidad MASTER_PERSONALIZACIONES
DECLARE 
    nuConta NUMBER;
BEGIN


    SELECT COUNT(*) 
      INTO nuConta
      FROM master_personalizaciones
     WHERE NOMBRE = 'LDC_UNLOCKORDERS';
 
    IF nuConta = 0 THEN
       INSERT INTO personalizaciones.master_personalizaciones 
			 ( ESQUEMA, NOMBRE, TIPO_OBJETO, COMENTARIO)
       VALUES ('OPEN', 'LDC_UNLOCKORDERS', 'PROCEDURE', NULL );
        dbms_output.put_Line('Procedimiento LDC_UNLOCKORDERS, registrado con exito');
    ELSE
        dbms_output.put_Line('LDC_UNLOCKORDERS ya existe, nuConta: '||nuConta);
    END IF;   
    COMMIT; 
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || sqlerrm);
END;
/

SELECT TO_CHAR(sysdate, 'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin FROM dual;

/ 

 