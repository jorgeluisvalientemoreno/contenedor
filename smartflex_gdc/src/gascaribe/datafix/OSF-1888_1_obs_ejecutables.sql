DECLARE

sbDescripcion  VARCHAR2(50);


BEGIN

        SELECT DESCRIPTION INTO sbDescripcion
        FROM SA_EXECUTABLE WHERE NAME = 'ARTE';

        IF sbDescripcion LIKE '%NO USAR%' THEN
        
            NULL;
        ELSE
        
            UPDATE SA_EXECUTABLE SET DESCRIPTION = 'NO USAR - '||DESCRIPTION WHERE NAME = 'ARTE';
            COMMIT;
        END IF;


        SELECT DESCRIPTION INTO sbDescripcion
        FROM SA_EXECUTABLE WHERE NAME = 'CONRT';

        IF sbDescripcion LIKE '%NO USAR%' THEN
        
            NULL;
        ELSE
        
            UPDATE SA_EXECUTABLE SET DESCRIPTION = 'NO USAR - '||DESCRIPTION WHERE NAME = 'CONRT';
            COMMIT;
        END IF;

        SELECT DESCRIPTION INTO sbDescripcion
        FROM SA_EXECUTABLE WHERE NAME = 'LDCAIC';

        IF sbDescripcion LIKE '%NO USAR%' THEN
        
            NULL;
        ELSE
        
            UPDATE SA_EXECUTABLE SET DESCRIPTION = 'NO USAR - '||DESCRIPTION WHERE NAME = 'LDCAIC';
            COMMIT;
        END IF;

        SELECT DESCRIPTION INTO sbDescripcion
        FROM SA_EXECUTABLE WHERE NAME = 'OFRT';

        IF sbDescripcion LIKE '%NO USAR%' THEN
        
            NULL;
        ELSE
        
            UPDATE SA_EXECUTABLE SET DESCRIPTION = 'NO USAR - '||DESCRIPTION WHERE NAME = 'OFRT';
            COMMIT;
        END IF;



END;
/