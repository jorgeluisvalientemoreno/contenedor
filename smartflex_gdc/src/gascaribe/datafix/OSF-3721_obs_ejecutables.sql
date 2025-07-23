DECLARE

sbDescripcion  VARCHAR2(100);


BEGIN

        SELECT DESCRIPTION INTO sbDescripcion
        FROM SA_EXECUTABLE WHERE NAME = 'LDC_DIFEAPM';

        IF sbDescripcion LIKE '%NO USAR%' THEN
        
            NULL;
        ELSE
        
            UPDATE SA_EXECUTABLE SET DESCRIPTION = 'NO USAR - '||DESCRIPTION WHERE NAME = 'LDC_DIFEAPM';
            COMMIT;
        END IF;



END;
/