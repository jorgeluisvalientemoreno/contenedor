BEGIN
    -- OSF-2601
    UPDATE SA_EXECUTABLE
    SET description = 'NO USAR - Configuración de tenderos'
    WHERE NAME = 'LDCTV';    
    COMMIT;
END;
/    
