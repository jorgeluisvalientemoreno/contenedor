DECLARE

sbDescripcion  VARCHAR2(100);


BEGIN

        SELECT DESCRIPTION INTO sbDescripcion
        FROM SA_EXECUTABLE WHERE NAME = 'LDCTA';

        IF sbDescripcion LIKE '%NO USAR%' THEN
        
            NULL;
        ELSE
        
            UPDATE SA_EXECUTABLE SET DESCRIPTION = 'NO USAR - '||DESCRIPTION WHERE NAME = 'LDCTA';
            COMMIT;
        END IF;

        SELECT DESCRIPTION INTO sbDescripcion
        FROM SA_EXECUTABLE WHERE NAME = 'LDCGTA';

        IF sbDescripcion LIKE '%NO USAR%' THEN
        
            NULL;
        ELSE
        
            UPDATE SA_EXECUTABLE SET DESCRIPTION = 'NO USAR - '||DESCRIPTION WHERE NAME = 'LDCGTA';
            COMMIT;
        END IF;


END;
/