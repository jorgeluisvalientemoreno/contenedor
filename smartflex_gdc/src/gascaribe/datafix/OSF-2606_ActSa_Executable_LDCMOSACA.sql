BEGIN
    -- OSF-2606
    UPDATE SA_EXECUTABLE
    SET description = 'NO USAR - Movimientos Saldos de Cartera por etapas'
    WHERE NAME = 'LDCMOSACA';    
    COMMIT;
END;
/    
