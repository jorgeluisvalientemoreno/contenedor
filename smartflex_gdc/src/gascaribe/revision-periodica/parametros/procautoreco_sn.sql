REM Fuente="Propiedad Intelectual de Gases del Caribe"
REM Script		 :		procautoreco_sn.sql
REM Autor 		 :		Lubin Pineda - MVM
REM Fecha 		 :		13-03-2023
REM Descripcion	 :		Crea o actualiza el parámetro procautoreco_sn
REM Caso		 :		OSF-962

DECLARE
    rcLdparameter   dald_parameter.styld_parameter;
BEGIN

    rcLdparameter.parameter_id := 'PROCAUTORECO_SN';
    rcLdparameter.description := 'CODIGO DE PROCESOS AUTORECONECTADO SERVICIO NUEVO';
    rcLdparameter.numeric_value := NULL;
    rcLdparameter.value_chain := NULL;
    
    IF NOT (dald_parameter.fblexist(rcLdparameter.parameter_id)) THEN
        dbms_output.put_line('Inicia creacion parametro PROCAUTORECO_SN'); 
        dald_parameter.insrecord(rcLdparameter);
		dbms_output.put_line('Termina creacion parametro PROCAUTORECO_SN');
    ELSE
		dbms_output.put_line('Inicia actualizacion parametro PROCAUTORECO_SN');    
        dald_parameter.updrecord(rcLdparameter);
		dbms_output.put_line('Termina actualizacion parametro PROCAUTORECO_SN');
    END IF;
    
    COMMIT;

    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error creando parametro PROCAUTORECO_SN|'|| SQLERRM );
END;
/
