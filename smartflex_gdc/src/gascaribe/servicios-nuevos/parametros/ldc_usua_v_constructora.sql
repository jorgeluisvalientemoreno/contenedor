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
    OPEN cuParameter ('LDC_USUA_V_CONSTRUCTORA');
    FETCH cuParameter INTO nuCount;
    CLOSE  cuParameter;

    dbms_output.put_line('Existe LDC_USUA_V_CONSTRUCTORA ['||nuCount||']');

    IF (nuCount = 0) THEN
        dbms_output.put_line('Inserta LDC_USUA_V_CONSTRUCTORA');
        INSERT INTO ld_parameter 
        VALUES
        (
            'LDC_USUA_V_CONSTRUCTORA',
            NULL,
            'INNOVACION', 
            'Usuario utiliado para registrar solicitudes de venta a constructores desde innovación'
        );
    END IF;

    COMMIT;
    dbms_output.put_line('Finaliza proceso de insetar parametros');
END;
/