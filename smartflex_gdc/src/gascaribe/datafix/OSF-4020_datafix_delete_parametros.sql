prompt "-----------------"
prompt "Aplicando Entrega OSF-4020"
prompt "-----------------"

DECLARE
    nuCant NUMBER;    
BEGIN
    dbms_output.put_line('Eliminando registro de parametros');
    
    SELECT COUNT(*)
    INTO nuCant
    FROM OPEN.PARAMETROS
    WHERE CODIGO = '|MED_REC_ENVIO_RESPUESTA_ELECTRONICA|';  
    
    IF nuCant > 0 THEN
        DELETE 
        FROM OPEN.PARAMETROS
        WHERE CODIGO = '|MED_REC_ENVIO_RESPUESTA_ELECTRONICA|'; 
        
        dbms_output.put_line('El parametro |MED_REC_ENVIO_RESPUESTA_ELECTRONICA| fue borrado');
        
        COMMIT;   
    ELSE
        dbms_output.put_line('El parametro |MED_REC_ENVIO_RESPUESTA_ELECTRONICA| no existe');
    END IF;
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('No fue posible eliminar registro de parametros, '||sqlerrm);
END;
/