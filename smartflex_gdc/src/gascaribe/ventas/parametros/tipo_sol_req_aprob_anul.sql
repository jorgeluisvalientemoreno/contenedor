DECLARE
    rcLdparameter   dald_parameter.styld_parameter;
BEGIN
    dbms_output.put_line('Inicia creacion parametro TIPO_SOL_REQ_APROB_ANUL');
        rcLdparameter.parameter_id := 'TIPO_SOL_REQ_APROB_ANUL';
        rcLdparameter.description := 'Tipos de solicitud para aprobación de anulación';
        rcLdparameter.numeric_value := null;
        rcLdparameter.value_chain := '271';

        IF NOT (dald_parameter.fblexist(rcLdparameter.parameter_id)) THEN
            dald_parameter.insrecord(rcLdparameter);
        ELSE
            dald_parameter.updrecord(rcLdparameter);
        END IF;

        COMMIT;
    dbms_output.put_line('Termina creacion parametro TIPO_SOL_REQ_APROB_ANUL');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error creando parametro TIPO_SOL_REQ_APROB_ANUL');
END;
/