DECLARE

    nuError          NUMBER;
    sbError          VARCHAR2(4000);

   
    CURSOR cuDBA_SYNONYMS
    IS
    SELECT *
    FROM dba_synonyms
    WHERE sYnonym_name = 'PKG_RECOFAEL'
    AND OWNER IN ('HOMOLOGACION','MULTIEMPRESA');

    sbSentencia     VARCHAR2(4000);
    
begin

    
   
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