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
    OPEN cuParameter ('LDC_SERVICE_ALLOW');
    FETCH cuParameter INTO nuCount;
    CLOSE  cuParameter;

    dbms_output.put_line('Existe LDC_SERVICE_ALLOW ['||nuCount||']');

    IF (nuCount = 0) THEN
        dbms_output.put_line('Inserta LDC_SERVICE_ALLOW');
        INSERT INTO ld_parameter 
        VALUES
        (
            'LDC_SERVICE_ALLOW',
            NULL,
            '7014,7055,7056,', 
            'Tipo de Servicios Permitidos en la opción LDCAISPPRES (,)'
        );
    END IF;

    COMMIT;
    dbms_output.put_line('Finaliza proceso de insetar parametros');
END;
/