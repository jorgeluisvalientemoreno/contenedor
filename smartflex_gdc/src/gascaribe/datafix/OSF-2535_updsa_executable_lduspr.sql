BEGIN
    UPDATE SA_EXECUTABLE
    SET description = 'NO USAR - Proceso Reporte Usuarios Promediados'
    WHERE NAME = 'LDUSPR';
    COMMIT;
END;
/