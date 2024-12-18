DECLARE
    rcLdparameter   dald_parameter.styld_parameter;
BEGIN
    dbms_output.put_line('Inicia creacion parametro LDC_TASAS_PBRCD');
        rcLdparameter.parameter_id := 'LDC_TASAS_PBRCD';
        rcLdparameter.description := 'Tasas adicionales a procesar en PBRCD';
        rcLdparameter.numeric_value := NULL;
        rcLdparameter.value_chain := '19,26';
        
        IF NOT (dald_parameter.fblexist(rcLdparameter.parameter_id)) THEN
            dald_parameter.insrecord(rcLdparameter);
        ELSE
            dald_parameter.updrecord(rcLdparameter);
        END IF;
        
        COMMIT;
    dbms_output.put_line('Termina creacion parametro LDC_TASAS_PBRCD');
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error creando parametro LDC_TASAS_PBRCD');
END;
/
