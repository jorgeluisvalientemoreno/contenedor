DECLARE

    -- OSF-2605
    csbMetodo        CONSTANT VARCHAR2(70) :=  'PGPPC';
    csbEsquema       CONSTANT VARCHAR2(30) :=  'OPEN';
    nuError          NUMBER;
    sbError          VARCHAR2(4000);
    nuCantObj        NUMBER; 

begin

    SELECT COUNT(1) INTO nuCantObj
    FROM dba_objects
    WHERE owner = csbEsquema 
    AND object_name = csbMetodo
    AND object_type = 'PROCEDURE';
    
    IF nuCantObj = 1 THEN
    
        EXECUTE IMMEDIATE 'DROP PROCEDURE '|| csbEsquema || '.' || csbMetodo;
        
        dbms_output.put_line('Se hizo drop al procedimiento ' || csbEsquema || '.' || csbMetodo );
    
    ELSE

        dbms_output.put_line('No existe el procedimiento ' ||  csbEsquema ||'.' || csbMetodo );
            
    END IF;
    
    EXCEPTION
        WHEN OTHERS THEN        
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            dbms_output.put_line('sbError => ' || sbError );
            RAISE pkg_error.Controlled_Error;
END;
/