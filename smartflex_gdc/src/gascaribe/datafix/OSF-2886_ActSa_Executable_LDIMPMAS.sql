BEGIN
    -- OSF-2886
    UPDATE SA_EXECUTABLE
    SET description = 'NO USAR - Impresión Masiva de Cupones de Venta'
    WHERE NAME = 'LDIMPMAS';    
    COMMIT;
END;
/    
