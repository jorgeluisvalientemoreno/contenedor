REM Fuente="Propiedad Intelectual de Gases del Caribe"
REM Script		 :		tolerancia_dife_autorecone_sn.sql
REM Autor 		 :		Lubin Pineda - MVM
REM Fecha 		 :		24-03-2023
REM Descripcion	 :		Crea o actualiza el parámetro tolerancia_dife_autorecone_sn
REM Caso		 :		OSF-962

DECLARE
    rcLdparameter   dald_parameter.styld_parameter;
BEGIN

    rcLdparameter.parameter_id := 'TOLERANCIA_DIFE_AUTORECONE_SN';
    rcLdparameter.description := 'TOLERANCIA DIF LECTURA AUTORECONECTADOS SERVICIO NUEVO';
    rcLdparameter.numeric_value := 1;
    rcLdparameter.value_chain := '';
    
    IF NOT (dald_parameter.fblexist(rcLdparameter.parameter_id)) THEN
        dbms_output.put_line('Inicia creacion parametro TOLERANCIA_DIFE_AUTORECONE_SN'); 
        dald_parameter.insrecord(rcLdparameter);
		dbms_output.put_line('Termina creacion parametro TOLERANCIA_DIFE_AUTORECONE_SN');
    ELSE
		dbms_output.put_line('Inicia actualizacion parametro TOLERANCIA_DIFE_AUTORECONE_SN');    
        dald_parameter.updrecord(rcLdparameter);
		dbms_output.put_line('Termina actualizacion parametro TOLERANCIA_DIFE_AUTORECONE_SN');
    END IF;
    
    COMMIT;

    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error creando parametro TOLERANCIA_DIFE_AUTORECONE_SN|'|| SQLERRM );
END;
/
