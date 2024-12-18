DECLARE
    rcLdparameter   dald_parameter.styld_parameter;
BEGIN
    dbms_output.put_line('Inicia creacion parametro LDC_LISTITROBLECSUSP');
        rcLdparameter.parameter_id := 'LDC_LISTITROBLECSUSP';
        rcLdparameter.description := 'Listado de tipo de trabajo de suspension para observaciones 8 y 81';
        rcLdparameter.numeric_value := null;
        rcLdparameter.value_chain := '10075, 10074';
        
        IF NOT (dald_parameter.fblexist(rcLdparameter.parameter_id)) THEN
            dald_parameter.insrecord(rcLdparameter);
        ELSE
            dald_parameter.updrecord(rcLdparameter);
        END IF;
        
        COMMIT;
    dbms_output.put_line('Termina creacion parametro LDC_LISTITROBLECSUSP');
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error creando parametro LDC_LISTITROBLECSUSP');
END;
/
