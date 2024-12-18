BEGIN
    -- OSF-2886
    UPDATE SA_EXECUTABLE
    SET description = 'NO USAR - Legalización Masiva de Órdenes de Revisión de Documentos de Pagaré'
    WHERE NAME = 'LEMADOPA';    
    COMMIT;
END;
/