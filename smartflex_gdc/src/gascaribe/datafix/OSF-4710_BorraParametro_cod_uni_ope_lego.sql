DECLARE
  nuConta NUMBER;
BEGIN

	dbms_output.put_line('Incia borrado parametro COD_UNI_OPE_LEGO');
	
	SELECT COUNT(*) 
	INTO nuConta
	FROM ld_parameter
	WHERE parameter_id = 'COD_UNI_OPE_LEGO';
   
	IF nuConta > 0 then
		DELETE ld_parameter
		WHERE parameter_id = 'COD_UNI_OPE_LEGO';
		
		dbms_output.put_line('Parametro COD_UNI_OPE_LEGO Borrado');
		
		COMMIT;
	END IF;
	
	dbms_output.put_line('Finaliza borrado parametro COD_UNI_OPE_LEGO');
	
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar el parametro COD_UNI_OPE_LEGO, '||sqlerrm); 
END;
/