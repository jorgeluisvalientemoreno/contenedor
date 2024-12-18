	DECLARE

sbDescripcion  VARCHAR2(500);


BEGIN

        SELECT DESCRIPTION INTO sbDescripcion
        FROM SA_EXECUTABLE WHERE NAME = 'LDACRE';

        IF sbDescripcion LIKE '%NO USAR%' THEN
            NULL;
        ELSE
            UPDATE SA_EXECUTABLE SET DESCRIPTION = 'NO USAR-'||DESCRIPTION WHERE NAME = 'LDACRE';
            COMMIT;
        END IF;

-----------------------------------------------------------------

        SELECT DESCRIPTION INTO sbDescripcion
        FROM SA_EXECUTABLE WHERE NAME = 'LDCFAAC';

        IF sbDescripcion LIKE '%NO USAR%' THEN
            NULL;
        ELSE
            UPDATE SA_EXECUTABLE SET DESCRIPTION = 'NO USAR-'||DESCRIPTION WHERE NAME = 'LDCFAAC';
            COMMIT;
        END IF;

-----------------------------------------------------------------

        SELECT DESCRIPTION INTO sbDescripcion
        FROM SA_EXECUTABLE WHERE NAME = 'LDRPCRE';

        IF sbDescripcion LIKE '%NO USAR%' THEN
            NULL;
        ELSE
            UPDATE SA_EXECUTABLE SET DESCRIPTION = 'NO USAR-'||DESCRIPTION WHERE NAME = 'LDRPCRE';
            COMMIT;
        END IF;

-----------------------------------------------------------------

        SELECT DESCRIPTION INTO sbDescripcion
        FROM SA_EXECUTABLE WHERE NAME = 'VENPS';

        IF sbDescripcion LIKE '%NO USAR%' THEN
            NULL;
        ELSE
            UPDATE SA_EXECUTABLE SET DESCRIPTION = 'NO USAR-'||DESCRIPTION WHERE NAME = 'VENPS';
            COMMIT;
        END IF;


END;
/