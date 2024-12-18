PROMPT Crea sinonimo objeto dependiente DALD_POLICY_HISTORIC
DECLARE
    nuExist NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO nuExist
    FROM
        dba_objects
    WHERE
        UPPER(object_name) = 'DALD_POLICY_HISTORIC'
        AND OWNER = 'ADM_PERSON';
    
    IF nuExist = 0 THEN
        
        EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.DALD_POLICY_HISTORIC FOR DALD_POLICY_HISTORIC';
    END IF;
END;
/
