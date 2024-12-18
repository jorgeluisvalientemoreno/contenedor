DECLARE
    rcLdparameter   dald_parameter.styld_parameter;
BEGIN
    dbms_output.put_line('Inicia creacion parametro LDC_LISTOBSAVALSUSP');
        rcLdparameter.parameter_id := 'LDC_LISTOBSAVALSUSP';
        rcLdparameter.description := 'Listado de observaciones paa validar suspensiones';
        rcLdparameter.numeric_value := null;
        rcLdparameter.value_chain := '8,81';
        
        IF NOT (dald_parameter.fblexist(rcLdparameter.parameter_id)) THEN
            dald_parameter.insrecord(rcLdparameter);
        ELSE
            dald_parameter.updrecord(rcLdparameter);
        END IF;
        
        COMMIT;
    dbms_output.put_line('Termina creacion parametro LDC_LISTOBSAVALSUSP');
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error creando parametro LDC_LISTOBSAVALSUSP');
END;
/
