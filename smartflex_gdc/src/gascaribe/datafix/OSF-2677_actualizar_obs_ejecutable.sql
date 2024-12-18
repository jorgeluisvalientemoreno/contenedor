DECLARE

sbDescripcion  VARCHAR2(500);


BEGIN

        SELECT DESCRIPTION INTO sbDescripcion
        FROM SA_EXECUTABLE WHERE NAME = 'LDCIREPLICACECO';

        IF sbDescripcion LIKE '%NO USAR%' THEN
        
            NULL;
        ELSE
        
            UPDATE SA_EXECUTABLE SET DESCRIPTION = 'NO USAR - '||DESCRIPTION WHERE NAME = 'LDCIREPLICACECO';
            COMMIT;
        END IF;

-----------------------------------------------------------------

        SELECT DESCRIPTION INTO sbDescripcion
        FROM SA_EXECUTABLE WHERE NAME = 'LDC_PROCCONUNI';

        IF sbDescripcion LIKE '%NO USAR%' THEN
            NULL;
        ELSE
            UPDATE SA_EXECUTABLE SET DESCRIPTION = 'NO USAR - '||DESCRIPTION WHERE NAME = 'LDC_PROCCONUNI';
            COMMIT;
        END IF;
------------------------------------------------------------------
        SELECT DESCRIPTION INTO sbDescripcion
        FROM SA_EXECUTABLE WHERE NAME = 'LDCALCAR';

        IF sbDescripcion LIKE '%NO USAR%' THEN
            NULL;
        ELSE
        
            UPDATE SA_EXECUTABLE SET DESCRIPTION = 'NO USAR - '||DESCRIPTION WHERE NAME = 'LDCALCAR';
            COMMIT;
        END IF;
------------------------------------------------------------------

        SELECT DESCRIPTION INTO sbDescripcion
        FROM SA_EXECUTABLE WHERE NAME = 'LDC_FTABLE';

        IF sbDescripcion LIKE '%NO USAR%' THEN
            NULL;
        ELSE
        
            UPDATE SA_EXECUTABLE SET DESCRIPTION = 'NO USAR - '||DESCRIPTION WHERE NAME = 'LDC_FTABLE';
            COMMIT;
        END IF;
------------------------------------------------------------------

        SELECT DESCRIPTION INTO sbDescripcion
        FROM SA_EXECUTABLE WHERE NAME = 'LDCPROVCART';

        IF sbDescripcion LIKE '%NO USAR%' THEN
            NULL;
        ELSE
        
            UPDATE SA_EXECUTABLE SET DESCRIPTION = 'NO USAR - '||DESCRIPTION WHERE NAME = 'LDCPROVCART';
            COMMIT;
        END IF;

-----------------------------------------------------------------

        SELECT DESCRIPTION INTO sbDescripcion
        FROM SA_EXECUTABLE WHERE NAME = 'LDC_PROCPVCO';

        IF sbDescripcion LIKE '%NO USAR%' THEN
            NULL;
        ELSE
        
            UPDATE SA_EXECUTABLE SET DESCRIPTION = 'NO USAR - '||DESCRIPTION WHERE NAME = 'LDC_PROCPVCO';
            COMMIT;
        END IF;

-------------------------------------------------------------------

        SELECT DESCRIPTION INTO sbDescripcion
        FROM SA_EXECUTABLE WHERE NAME = 'LDREFA';

        IF sbDescripcion LIKE '%NO USAR%' THEN
            NULL;
        ELSE
        
            UPDATE SA_EXECUTABLE SET DESCRIPTION = 'NO USAR - '||DESCRIPTION WHERE NAME = 'LDREFA';
            COMMIT;
        END IF;


END;
/