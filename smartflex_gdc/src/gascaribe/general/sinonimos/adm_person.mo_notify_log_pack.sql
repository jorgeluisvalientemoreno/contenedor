PROMPT Crea sinonimo objeto dependiente MO_NOTIFY_LOG_PACK
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.MO_NOTIFY_LOG_PACK FOR MO_NOTIFY_LOG_PACK';
END;
/
