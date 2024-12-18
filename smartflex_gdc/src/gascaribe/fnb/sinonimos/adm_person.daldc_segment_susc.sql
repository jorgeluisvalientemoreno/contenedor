PROMPT Crea sinonimo objeto dependiente DALDC_SEGMENT_SUSC
DECLARE
    nuExist NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO nuExist
    FROM
        dba_objects
    WHERE
        UPPER(object_name) = 'DALDC_SEGMENT_SUSC'
        AND OWNER = 'ADM_PERSON';
    
    IF nuExist = 0 THEN
        
        EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.DALDC_SEGMENT_SUSC FOR DALDC_SEGMENT_SUSC';
    END IF;
END;
/
