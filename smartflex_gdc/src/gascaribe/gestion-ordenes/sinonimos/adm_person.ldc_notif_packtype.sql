PROMPT Crea sinonimo objeto dependiente LDC_NOTIF_PACKTYPE
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_NOTIF_PACKTYPE FOR LDC_NOTIF_PACKTYPE';
END;
/