DECLARE
    rcLdparameter   dald_parameter.styld_parameter;
BEGIN
    dbms_output.put_line('Inicia creacion parametro LDC_MES_NOTIFICA_INI_RP');
        rcLdparameter.parameter_id := 'LDC_MES_NOTIFICA_INI_RP';
        rcLdparameter.description := 'Mes en que se realiza la notificación inicial de RP';
        rcLdparameter.numeric_value := 55;
        rcLdparameter.value_chain := null;
        
        IF NOT (dald_parameter.fblexist(rcLdparameter.parameter_id)) THEN
            dald_parameter.insrecord(rcLdparameter);
        ELSE
            dald_parameter.updrecord(rcLdparameter);
        END IF;
        
        COMMIT;
    dbms_output.put_line('Termina creacion parametro LDC_MES_NOTIFICA_INI_RP');
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error creando parametro LDC_MES_NOTIFICA_INI_RP');
END;
/
