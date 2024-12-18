REM Fuente="Propiedad Intelectual de Gases del Caribe"
REM Script		 :		insldc_parameter_ldc_contra_sin_digit_index.sql
REM Autor 		 :		Lubin Pineda - MVM
REM Fecha 		 :		25-01-2023
REM Descripcion	 :		Crea el parámetro LDC_CONTRA_SIN_DIGIT_INDEX
REM Caso		 :		OSF-839

DECLARE
    rcLdparameter   dald_parameter.styld_parameter;
BEGIN
    dbms_output.put_line('Inicia creacion parametro LDC_CONTRA_SIN_DIGIT_INDEX');
    rcLdparameter.parameter_id := 'LDC_CONTRA_SIN_DIGIT_INDEX';
    rcLdparameter.description := 'Lista de contratistas a los cuales no se les genera orden con actividad 100008491 - DIGITAL/INDEX GESTION VENTA';
    rcLdparameter.numeric_value := NULL;
    rcLdparameter.value_chain := '2310';
    
    IF NOT (dald_parameter.fblexist(rcLdparameter.parameter_id)) THEN
        dald_parameter.insrecord(rcLdparameter);
    ELSE
        dald_parameter.updrecord(rcLdparameter);
    END IF;
    
    COMMIT;
    dbms_output.put_line('Termina creacion parametro LDC_CONTRA_SIN_DIGIT_INDEX');
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error creando parametro LDC_CONTRA_SIN_DIGIT_INDEX|'|| SQLERRM );
END;
/
