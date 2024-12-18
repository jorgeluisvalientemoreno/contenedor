DECLARE
    rcLdparameter   dald_parameter.styld_parameter;
BEGIN
    dbms_output.put_line('Inicia creacion parametro ESTACORT_LECTESPGELE');
        rcLdparameter.parameter_id := 'ESTACORT_LECTESPGELE';
        rcLdparameter.description := 'Estados de corte a excluir en LECTESPGELE';
        rcLdparameter.numeric_value := NULL;
        rcLdparameter.value_chain := '96,';
        
        IF NOT (dald_parameter.fblexist(rcLdparameter.parameter_id)) THEN
            dald_parameter.insrecord(rcLdparameter);
        ELSE
            dald_parameter.updrecord(rcLdparameter);
        END IF;
        
        COMMIT;
    dbms_output.put_line('Termina creacion parametro ESTACORT_LECTESPGELE');
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error creando parametro ESTACORT_LECTESPGELE');
END;
/
