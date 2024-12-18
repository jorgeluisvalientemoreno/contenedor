SET SERVEROUTPUT ON SIZE UNLIMITED
set linesize 1000
set timing on
EXECUTE dbms_application_info.set_action('APLICANDO DATAFIX 2675'); 
PROMPT =========================================
PROMPT **** Inicia registro en entidad master_personalizaciones 
PROMPT 
DECLARE 
    nuConta NUMBER;
BEGIN 
    SELECT COUNT(*) 
      INTO nuConta
      FROM master_personalizaciones
     WHERE NOMBRE = 'LDC_PER_COMERCIAL';
 
    IF nuConta = 0 THEN
       INSERT INTO personalizaciones.master_personalizaciones 
			 ( ESQUEMA, NOMBRE, TIPO_OBJETO, COMENTARIO)
       VALUES ('OPEN', 'LDC_PER_COMERCIAL', 'TABLA', NULL );
        dbms_output.put_Line('Tabla LDC_PER_COMERCIAL, registrada con exito');
    ELSE
        dbms_output.put_Line('Tabla LDC_PER_COMERCIAL ya existe, nuConta: '||nuConta);
    END IF;   
    COMMIT;
    --
    SELECT COUNT(*) 
      INTO nuConta
      FROM master_personalizaciones
     WHERE NOMBRE = 'LDC_PER_COMERCIAL_AUD';
 
    IF nuConta = 0 THEN
       INSERT INTO personalizaciones.master_personalizaciones 
			 ( ESQUEMA, NOMBRE, TIPO_OBJETO, COMENTARIO)
       VALUES ('OPEN', 'LDC_PER_COMERCIAL_AUD', 'TABLA', NULL );
        dbms_output.put_Line('Tabla LDC_PER_COMERCIAL_AUD, registrada con exito');
    ELSE
        dbms_output.put_Line('Tabla LDC_PER_COMERCIAL_AUD ya existe, nuConta: '||nuConta);
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