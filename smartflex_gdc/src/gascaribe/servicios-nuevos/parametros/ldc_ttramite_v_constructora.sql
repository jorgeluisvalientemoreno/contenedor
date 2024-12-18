DECLARE
    CURSOR cuParameter
    (
        inuParameterID  ld_parameter.parameter_id%TYPE
    )
    IS
    SELECT  COUNT(1)
    FROM    ld_parameter
    WHERE   parameter_id = inuParameterID;

    nuCount     NUMBER;
BEGIN
    dbms_output.put_line('Inicia proceso de insetar parametros');

    OPEN cuParameter ('LDC_TTRAMITE_V_CONSTRUCTORA');
    FETCH cuParameter INTO nuCount;
    CLOSE  cuParameter;

    dbms_output.put_line('Existe LDC_TTRAMITE_V_CONSTRUCTORA ['||nuCount||']');
    IF (nuCount = 0) THEN
        dbms_output.put_line('Inserta LDC_TTRAMITE_V_CONSTRUCTORA');
        INSERT INTO ld_parameter 
        VALUES
        (
            'LDC_TTRAMITE_V_CONSTRUCTORA',
            323,
            NULL, 
            'Tipo de trámite de venta a constructoras'
        );
    ELSE
        UPDATE ld_parameter
        SET value_chain = NULL,
            numeric_value = 323
        WHERE parameter_id = 'LDC_TTRAMITE_V_CONSTRUCTORA';
    END IF;  
    COMMIT;
    dbms_output.put_line('Finaliza proceso de insetar parametros');
END;
/