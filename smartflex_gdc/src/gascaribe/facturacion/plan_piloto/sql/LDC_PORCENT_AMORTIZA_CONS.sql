DECLARE
    rcLdparameter   dald_parameter.styld_parameter;
BEGIN
    dbms_output.put_line('Inicia creacion parametro LDC_PORCENT_AMORTIZA_CONS');
        rcLdparameter.parameter_id := 'LDC_PORCENT_AMORTIZA_CONS';
        rcLdparameter.description := 'PORCENTAJE DE AMORTIZACION ABONO DIFERIDO';
        rcLdparameter.numeric_value := 25;
        rcLdparameter.value_chain := NULL;
        
        IF NOT (dald_parameter.fblexist(rcLdparameter.parameter_id)) THEN
            dald_parameter.insrecord(rcLdparameter);
        ELSE
            dald_parameter.updrecord(rcLdparameter);
        END IF;
        
        COMMIT;
    dbms_output.put_line('Termina creacion parametro LDC_PORCENT_AMORTIZA_CONS');
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error creando parametro LDC_PORCENT_AMORTIZA_CONS');
END;
/
