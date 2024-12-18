DECLARE
    rcLdparameter   dald_parameter.styld_parameter;
BEGIN
    dbms_output.put_line('Inicia creacion parametro LDC_LISTITROBLEC');
        rcLdparameter.parameter_id := 'LDC_LISTITROBLEC';
        rcLdparameter.description := 'Listado de tipo de trabajo de cambio de medidor para observaciones 8 y 81';
        rcLdparameter.numeric_value := null;
        rcLdparameter.value_chain := '11056, 11230, 11231, 11232, 11177, 11178, 11233 , 11234';
        
        IF NOT (dald_parameter.fblexist(rcLdparameter.parameter_id)) THEN
            dald_parameter.insrecord(rcLdparameter);
        ELSE
            dald_parameter.updrecord(rcLdparameter);
        END IF;
        
        COMMIT;
    dbms_output.put_line('Termina creacion parametro LDC_LISTITROBLEC');
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error creando parametro LDC_LISTITROBLEC');
END;
/
