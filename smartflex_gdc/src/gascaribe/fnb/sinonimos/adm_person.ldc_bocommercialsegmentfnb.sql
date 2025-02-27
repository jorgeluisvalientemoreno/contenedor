PROMPT Crea sinonimo objeto dependiente LDC_BOCOMMERCIALSEGMENTFNB
DECLARE
    nuExist NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO nuExist
    FROM
        dba_objects
    WHERE
        UPPER(object_name) = 'LDC_BOCOMMERCIALSEGMENTFNB'
        AND OWNER = 'ADM_PERSON';
    
    IF nuExist = 0 THEN
        
        EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_BOCOMMERCIALSEGMENTFNB FOR LDC_BOCOMMERCIALSEGMENTFNB';
    END IF;
END;
/
