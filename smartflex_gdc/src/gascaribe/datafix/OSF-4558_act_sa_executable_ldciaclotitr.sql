BEGIN
    -- OSF-4558
    UPDATE sa_executable
    SET description = 'NO USAR - Activos por Localidad por Tipo de Trabajo '
    WHERE name = 'LDCIACLOTITR';
    
    COMMIT;
    
    dbms_output.put_line('INFO[Se actualizo la descripcion del ejecutable LDCIACLOTITR]');
    
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('ERROR[' || sqlerrm || ']');
        ROLLBACK;    
END;
/
