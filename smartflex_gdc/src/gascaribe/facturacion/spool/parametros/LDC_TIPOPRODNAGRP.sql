DECLARE
    rcLdparameter   dald_parameter.styld_parameter;
BEGIN
    dbms_output.put_line('Inicia creacion parametro LDC_TIPOPRODNAGRP');
        rcLdparameter.parameter_id := 'LDC_TIPOPRODNAGRP';
        rcLdparameter.description := 'Tipo de producto que no se van agrupar';
        rcLdparameter.numeric_value := null;
        rcLdparameter.value_chain := '7053';
        
        IF NOT (dald_parameter.fblexist(rcLdparameter.parameter_id)) THEN
            dald_parameter.insrecord(rcLdparameter);
        ELSE
            dald_parameter.updrecord(rcLdparameter);
        END IF;
        
        COMMIT;
    dbms_output.put_line('Termina creacion parametro LDC_TIPOPRODNAGRP');
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error creando parametro LDC_TIPOPRODNAGRP');
END;
/
