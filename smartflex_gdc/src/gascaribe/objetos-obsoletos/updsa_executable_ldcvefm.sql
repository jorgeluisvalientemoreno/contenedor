BEGIN
    UPDATE SA_EXECUTABLE
    SET description = 'NO USAR - Cargue De ventas por formulario masivas'
    WHERE NAME = 'LDCVEFM';
    COMMIT;
END;
/