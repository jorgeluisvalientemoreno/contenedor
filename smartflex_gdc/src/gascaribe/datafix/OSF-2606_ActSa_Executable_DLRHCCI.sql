BEGIN
    -- OSF-2606    
    UPDATE SA_EXECUTABLE
    SET description = 'NO USAR - Reporte Historial Consumo Cliente Comercial, Industrial y EDS'
    WHERE NAME = 'DLRHCCI';
      
    COMMIT;
END;
/    
