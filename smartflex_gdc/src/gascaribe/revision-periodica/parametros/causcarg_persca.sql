REM Fuente="Propiedad Intelectual de Gases del Caribe"
REM Script		 :		causcarg_persca.sql
REM Autor 		 :		Lubin Pineda - MVM
REM Fecha 		 :	    04-05-2023
REM Descripcion	 :		Crea o actualiza el parámetro causcarg_persca
REM Caso		 :		OSF-1075

DECLARE
    rcLdparameter   dald_parameter.styld_parameter;
BEGIN

    rcLdparameter.parameter_id := 'CAUSCARG_PERSCA';
    rcLdparameter.description := 'CAUSALES DE CARGO DE CONSUMO PARA PERSCA';
    rcLdparameter.numeric_value := NULL;
    rcLdparameter.value_chain := '1,4,15,60';
    
    IF NOT (dald_parameter.fblexist(rcLdparameter.parameter_id)) THEN
        dbms_output.put_line('Inicia creacion parametro causcarg_persca'); 
        dald_parameter.insrecord(rcLdparameter);
		dbms_output.put_line('Termina creacion parametro causcarg_persca');
    ELSE
		dbms_output.put_line('Inicia actualizacion parametro causcarg_persca');    
        dald_parameter.updrecord(rcLdparameter);
		dbms_output.put_line('Termina actualizacion parametro causcarg_persca');
    END IF;
    
    COMMIT;

    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error creando parametro causcarg_persca|'|| SQLERRM );
END;
/
