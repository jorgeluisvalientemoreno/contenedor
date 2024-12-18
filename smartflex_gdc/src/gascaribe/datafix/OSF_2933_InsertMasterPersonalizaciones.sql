SET SERVEROUTPUT ON SIZE UNLIMITED
set linesize 1000
set timing on
EXECUTE dbms_application_info.set_action('APLICANDO DATAFIX 2933'); 
PROMPT =========================================
PROMPT **** Inicia registro en entidad master_personalizaciones 
PROMPT 
DECLARE 
    nuConta NUMBER;
BEGIN 
    SELECT COUNT(*) 
      INTO nuConta
      FROM master_personalizaciones
     WHERE NOMBRE = 'LDC_PROCCREASOLICITUDSUSPADMIN';
 
    IF nuConta = 0 THEN
       INSERT INTO personalizaciones.master_personalizaciones 
			 ( ESQUEMA, NOMBRE, TIPO_OBJETO, COMENTARIO)
       VALUES ('OPEN', 'LDC_PROCCREASOLICITUDSUSPADMIN', 'PROCEDURE', NULL );
        dbms_output.put_Line('PROCEDURE LDC_PROCCREASOLICITUDSUSPADMIN, registrada con exito');
    ELSE
        dbms_output.put_Line('PROCEDURE LDC_PROCCREASOLICITUDSUSPADMIN ya existe, nuConta: '||nuConta);
    END IF;   
    COMMIT;
       
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || sqlerrm);
END;
/
  
PROMPT **** Termina registro entidad master_personalizaciones**** 
PROMPT =========================================
set timing off
set serveroutput off
/