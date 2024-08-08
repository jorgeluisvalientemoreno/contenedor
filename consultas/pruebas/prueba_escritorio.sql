DECLARE

    num_condiciones  NUMBER := &num_condiciones; -- Número de condiciones
    i NUMBER;
    j NUMBER;
BEGIN
   
    DBMS_OUTPUT.PUT_LINE('Numero de condiciones: ' || num_condiciones);  -- Mostrar el número de condiciones

    -- Generar casos de prueba para todas las combinaciones posibles de condiciones
    DBMS_OUTPUT.PUT_LINE('Casos de Prueba:');
    FOR i IN 1..POWER(2, num_condiciones) LOOP
        DBMS_OUTPUT.PUT('Caso ' || i || ': ');
        FOR j IN 1..num_condiciones LOOP
            DBMS_OUTPUT.PUT('C' || j || ' ');
            IF BITAND(i-1, POWER(2, j-1)) = 0 THEN
                DBMS_OUTPUT.PUT('FALSO');
            ELSE
                DBMS_OUTPUT.PUT('VERDADERO');
            END IF;
            IF j < num_condiciones THEN
                DBMS_OUTPUT.PUT(', ');
            END IF;
        END LOOP;
        DBMS_OUTPUT.NEW_LINE;
    END LOOP;
END;
