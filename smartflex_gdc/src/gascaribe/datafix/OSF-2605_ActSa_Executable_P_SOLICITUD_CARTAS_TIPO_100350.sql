BEGIN
    -- OSF-2605
    UPDATE SA_EXECUTABLE
    SET description = 'NO USAR - Solicitud Cartas Tipo'
    WHERE NAME = 'P_SOLICITUD_CARTAS_TIPO_100350';    
    COMMIT;
END;
/    
