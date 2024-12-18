DECLARE

sbDescripcion  VARCHAR2(500);


BEGIN

        SELECT DESCRIPTION INTO sbDescripcion
        FROM SA_EXECUTABLE WHERE NAME = 'LDCMEX';

        IF sbDescripcion LIKE '%NO USAR%' THEN
            NULL;
        ELSE
            UPDATE SA_EXECUTABLE SET DESCRIPTION = 'NO MIGRAR-NO USAR-'||DESCRIPTION WHERE NAME = 'LDCMEX';
            COMMIT;
        END IF;

-----------------------------------------------------------------

        SELECT DESCRIPTION INTO sbDescripcion
        FROM SA_EXECUTABLE WHERE NAME = 'LDCSCL';

        IF sbDescripcion LIKE '%NO USAR%' THEN
            NULL;
        ELSE
            UPDATE SA_EXECUTABLE SET DESCRIPTION = 'NO MIGRAR-NO USAR-'||DESCRIPTION WHERE NAME = 'LDCSCL';
            COMMIT;
        END IF;


END;
/