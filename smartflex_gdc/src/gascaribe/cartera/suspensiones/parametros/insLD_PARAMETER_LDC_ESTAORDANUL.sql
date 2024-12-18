DECLARE
    rcLdparameter   dald_parameter.styld_parameter;
BEGIN
    dbms_output.put_line('Inicia creacion parametro LDC_ESTAORDANUL');
        rcLdparameter.parameter_id := 'LDC_ESTAORDANUL';
        rcLdparameter.description := 'ESTADO DE LAS ORDENES PARA ANULAR CA 711';
        rcLdparameter.numeric_value := NULL;
        rcLdparameter.value_chain := '0,5,8,11';
        
        IF NOT (dald_parameter.fblexist(rcLdparameter.parameter_id)) THEN
            dald_parameter.insrecord(rcLdparameter);
        ELSE
            dald_parameter.updrecord(rcLdparameter);
        END IF;
        
        COMMIT;
    dbms_output.put_line('Termina creacion parametro LDC_ESTAORDANUL');
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error creando parametro LDC_ESTAORDANUL');
END;
/
