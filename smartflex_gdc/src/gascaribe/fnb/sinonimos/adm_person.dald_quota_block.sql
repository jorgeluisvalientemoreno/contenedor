PROMPT Crea sinonimo objeto dependiente DALD_QUOTA_BLOCK
DECLARE
    nuExist NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO nuExist
    FROM
        dba_objects
    WHERE
        UPPER(object_name) = 'DALD_QUOTA_BLOCK'
        AND OWNER = 'ADM_PERSON';
    
    IF nuExist = 0 THEN
        
        EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.DALD_QUOTA_BLOCK FOR DALD_QUOTA_BLOCK';
    END IF;
END;
/
