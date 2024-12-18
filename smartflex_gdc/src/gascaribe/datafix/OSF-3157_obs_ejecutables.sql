DECLARE

sbDescripcion  VARCHAR2(100);


BEGIN

        SELECT DESCRIPTION INTO sbDescripcion
        FROM SA_EXECUTABLE WHERE NAME = 'LDCIDO';

        IF sbDescripcion LIKE '%NO USAR%' THEN
        
            NULL;
        ELSE
        
            UPDATE SA_EXECUTABLE SET DESCRIPTION = 'NO USAR - '||DESCRIPTION WHERE NAME = 'LDCIDO';
            COMMIT;
        END IF;



END;
/