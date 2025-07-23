DECLARE

    -- OSF-3819
    csbOBJETO        CONSTANT VARCHAR2(70) :=  'LDCINTACTAS';
    nuError          NUMBER;
    sbError          VARCHAR2(4000);


    CURSOR cuDBA_OBJECTS
    IS
    SELECT *
    FROM dba_objects
    WHERE object_name = csbOBJETO
    AND object_type IN ( 'PROCEDURE')
    AND OWNER = 'OPEN'
    ORDER BY object_type DESC;
   
    CURSOR cuDBA_SYNONYMS
    IS
    SELECT *
    FROM dba_synonyms
    WHERE sYnonym_name = csbOBJETO
    AND TABLE_OWNER = 'OPEN';

    sbSentencia     VARCHAR2(4000);
    
begin

    
    FOR rcObjeto IN cuDBA_OBJECTS LOOP
    
        BEGIN
            sbSentencia := 'DROP '||  rcObjeto.OBJECT_TYPE || ' ' || rcObjeto.OWNER || '.' || rcObjeto.OBJECT_NAME;
            
            EXECUTE IMMEDIATE sbSentencia ;
            
            dbms_output.put_line ( 'Se ejecutó [' || sbSentencia || ']' ); 
            
            EXCEPTION WHEN OTHERS THEN
                dbms_output.put_line ( 'ERROR [' || sbSentencia || '][' || SQLERRM || ']' );             
            
        END;

    END LOOP;
    
    FOR rcSinonimo IN cuDBA_SYNONYMS LOOP
    
        BEGIN
            sbSentencia := 'DROP SYNONYM  '  || rcSinonimo.OWNER || '.' || rcSinonimo.SYNONYM_NAME;
            
            EXECUTE IMMEDIATE sbSentencia ;
            
            dbms_output.put_line ( 'Se ejecutó [' || sbSentencia || ']' ); 
            
            EXCEPTION WHEN OTHERS THEN
                dbms_output.put_line ( 'ERROR [' || sbSentencia || '][' || SQLERRM || ']' );             
            
        END;

    END LOOP;
    
    
    EXCEPTION
        WHEN OTHERS THEN        
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            dbms_output.put_line('sbError => ' || sbError );
            RAISE pkg_error.Controlled_Error;
END;
/