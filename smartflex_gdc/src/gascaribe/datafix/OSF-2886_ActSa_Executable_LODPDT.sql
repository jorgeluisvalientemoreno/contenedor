BEGIN
    -- OSF-2886
    UPDATE SA_EXECUTABLE
    SET description = 'NO USAR - Asignaci�n de Datos Personales'
    WHERE NAME = 'LODPDT';    
    COMMIT;
END;
/    
