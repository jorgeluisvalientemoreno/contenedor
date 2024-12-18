DECLARE

    csbObjeto        CONSTANT VARCHAR2(70) :=  UPPER('TRGAIMO_EXECUTOR_LOG_MOT');
    csbEsquema       CONSTANT VARCHAR2(30) :=  'OPEN';
    nuError          NUMBER;
    sbError          VARCHAR2(4000);
    nuCantObj        NUMBER; 

begin

    -- OSF-2601
    SELECT COUNT(1) INTO nuCantObj
    FROM dba_objects
    WHERE owner = csbEsquema 
    AND object_name = csbObjeto
    AND object_type = 'TRIGGER';
    
    IF nuCantObj = 1 THEN
    
        EXECUTE IMMEDIATE 'DROP TRIGGER '|| csbEsquema || '.' || csbObjeto;
        
        dbms_output.put_line('Se hizo drop al trigger ' || csbEsquema || '.' || csbObjeto );
    
    ELSE

        dbms_output.put_line('No existe el trigger ' ||  csbEsquema ||'.' || csbObjeto );
            
    END IF;
    
    EXCEPTION
        WHEN OTHERS THEN        
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            dbms_output.put_line('sbError => ' || sbError );
            RAISE pkg_error.Controlled_Error;
END;
/