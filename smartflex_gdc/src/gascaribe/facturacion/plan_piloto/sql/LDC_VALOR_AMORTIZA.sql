DECLARE
    rcLdparameter   dald_parameter.styld_parameter;
BEGIN
    dbms_output.put_line('Inicia creacion parametro LDC_VALOR_AMORTIZA');
        rcLdparameter.parameter_id := 'LDC_VALOR_AMORTIZA';
        rcLdparameter.description := 'VALOR AMORTIZACION ABONO DIFERIDO';
        rcLdparameter.numeric_value := 10000;
        rcLdparameter.value_chain := null;
        
        IF NOT (dald_parameter.fblexist(rcLdparameter.parameter_id)) THEN
            dald_parameter.insrecord(rcLdparameter);
        ELSE
            dald_parameter.updrecord(rcLdparameter);
        END IF;
        
        COMMIT;
    dbms_output.put_line('Termina creacion parametro LDC_VALOR_AMORTIZA');
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error creando parametro LDC_VALOR_AMORTIZA');
END;
/
