declare
    
BEGIN

	dbms_output.put_line('Inicia OSF-2009 - Eliminando tipo de exención');
	
	DELETE LDC_LV_TIPO_EXCEP 
	where codigo = 5;  
	
	dbms_output.put_line('Se eliminó el Tipo de exención  5 - ‘EXENCION CONTR.RESOL CREG 006 2003 1-ANO’');	
	
	dbms_output.put_line('Finaliza OSF-2009 - Eliminando tipo de exención');
END;
/