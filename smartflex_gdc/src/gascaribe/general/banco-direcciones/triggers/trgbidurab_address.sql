DECLARE
    nuConta NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO nuConta
    FROM DBA_OBJECTS o
    WHERE UPPER(o.OBJECT_NAME) = UPPER('trgbidurAB_ADDRESS')
          AND o.OWNER = 'OPEN'
          AND o.OBJECT_TYPE <> 'SYNONYM';

    IF nuConta > 0 THEN
        EXECUTE IMMEDIATE 'DROP TRIGGER OPEN.trgbidurAB_ADDRESS';
    END IF;
END;
/
PROMPT "Trigger trgbidurAB_ADDRESS original borrado";
