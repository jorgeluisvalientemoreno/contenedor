BEGIN
    -- OSF-2606    
    UPDATE SA_EXECUTABLE
    SET description = 'NO USAR - Cargue masivo de solicitudes'
    WHERE NAME = 'LDCCAMASO';
      
    COMMIT;
END;
/    
