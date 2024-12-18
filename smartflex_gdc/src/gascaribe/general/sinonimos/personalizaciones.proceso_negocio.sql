DECLARE

    CURSOR cuDBA_SYNONYMS
    IS
    SELECT *
    FROM dba_synonyms
    WHERE sYnonym_name = 'PROCESO_NEGOCIO'
    AND TABLE_OWNER = 'PERSONALIZACIONES';

	  sbSentencia     VARCHAR2(4000);

BEGIN

    FOR rcSinonimo IN cuDBA_SYNONYMS LOOP
    
        BEGIN
            sbSentencia := 'DROP SYNONYM  '  || rcSinonimo.OWNER || '.' || rcSinonimo.SYNONYM_NAME;
            
            EXECUTE IMMEDIATE sbSentencia ;
            
            dbms_output.put_line ( 'Se ejecutó [' || sbSentencia || ']' ); 
            
            EXCEPTION WHEN OTHERS THEN
                dbms_output.put_line ( 'ERROR [' || sbSentencia || '][' || SQLERRM || ']' );             
            
        END;

    END LOOP;

END;
/