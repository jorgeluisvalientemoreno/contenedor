BEGIN
    -- OSF-4555
    UPDATE sa_executable
    SET description = 'NO USAR - Listados Interfaz Contable'
    WHERE name = 'LICOT';
    
    COMMIT;
    
    dbms_output.put_line('INFO[Se actualizo la descripcion del ejecutable LICOT]');
    
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('ERROR[' || sqlerrm || ']');
        ROLLBACK;    
END;
/
