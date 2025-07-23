DECLARE
    rcLdparameter   dald_parameter.styld_parameter;
BEGIN
    dbms_output.put_line('Inicia creacion parametro INSURANCE_RATE_II');
        rcLdparameter.parameter_id := 'INSURANCE_RATE_II';
        rcLdparameter.description := 'PORCENTAJE DEL SEGURO OSF-3667';
        rcLdparameter.numeric_value := 0.18750;
        rcLdparameter.value_chain := NULL;
        
        IF NOT (dald_parameter.fblexist(rcLdparameter.parameter_id)) THEN
            dald_parameter.insrecord(rcLdparameter);
        ELSE
            dald_parameter.updrecord(rcLdparameter);
        END IF;
        
        COMMIT;
    dbms_output.put_line('Termina creacion parametro INSURANCE_RATE_II');
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error creando parametro INSURANCE_RATE_II');
END;
/