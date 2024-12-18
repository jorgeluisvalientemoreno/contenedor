REM Fuente="Propiedad Intelectual de Gases del Caribe"
REM Script		 :		insldc_parameter_LDC_LINE_NEGO_BRILLA.sql
REM Autor 		 :		Lubin Pineda - MVM
REM Fecha 		 :		27-01-2023
REM Descripcion	 :		Crea o actualiza el parámetro LDC_LINE_NEGO_BRILLA
REM Caso		 :		OSF-844

DECLARE
    rcLdparameter   dald_parameter.styld_parameter;
BEGIN

    rcLdparameter.parameter_id := 'LDC_LINE_NEGO_BRILLA';
    rcLdparameter.description := 'Lista de lineas de negocio exclusivas de BRILLA';
    rcLdparameter.numeric_value := NULL;
    rcLdparameter.value_chain := '311';
    
    IF NOT (dald_parameter.fblexist(rcLdparameter.parameter_id)) THEN
        dbms_output.put_line('Inicia creacion parametro LDC_LINE_NEGO_BRILLA'); 
        dald_parameter.insrecord(rcLdparameter);
		dbms_output.put_line('Termina creacion parametro LDC_LINE_NEGO_BRILLA');
    ELSE
		dbms_output.put_line('Inicia actualizacion parametro LDC_LINE_NEGO_BRILLA');    
        dald_parameter.updrecord(rcLdparameter);
		dbms_output.put_line('Termina actualizacion parametro LDC_LINE_NEGO_BRILLA');
    END IF;
    
    COMMIT;

    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error creando parametro LDC_LINE_NEGO_BRILLA|'|| SQLERRM );
END;
/
