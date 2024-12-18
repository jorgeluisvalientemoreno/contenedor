DECLARE
    rcLdparameter   dald_parameter.styld_parameter;
BEGIN
    dbms_output.put_line('Inicia creacion parametro LDC_LISTCONCNAGRUP');
        rcLdparameter.parameter_id := 'LDC_LISTCONCNAGRUP';
        rcLdparameter.description := 'listado de conceptos que no se agruparan';
        rcLdparameter.numeric_value := null;
        rcLdparameter.value_chain := '832';
        
        IF NOT (dald_parameter.fblexist(rcLdparameter.parameter_id)) THEN
            dald_parameter.insrecord(rcLdparameter);
        ELSE
            dald_parameter.updrecord(rcLdparameter);
        END IF;
        
        COMMIT;
    dbms_output.put_line('Termina creacion parametro LDC_LISTCONCNAGRUP');
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error creando parametro LDC_LISTCONCNAGRUP');
END;
/
