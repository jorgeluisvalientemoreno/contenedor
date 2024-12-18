PROMPT Crea sinonimo objeto dependiente DALD_CREDIT_QUOTA
DECLARE
    nuExist NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO nuExist
    FROM
        dba_objects
    WHERE
        UPPER(object_name) = 'DALD_CREDIT_QUOTA'
        AND OWNER = 'ADM_PERSON';
    
    IF nuExist = 0 THEN
        
        EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.DALD_CREDIT_QUOTA FOR DALD_CREDIT_QUOTA';
    END IF;
END;
/
