CREATE OR REPLACE TRIGGER OPEN.TRG_DO_AU_AUDIT_POLICY_LOG
    AFTER INSERT OR UPDATE OR DELETE
    ON OPEN.AU_AUDIT_POLICY_LOG
    REFERENCING OLD AS OLD NEW AS NEW
    FOR EACH ROW
BEGIN

    DECLARE
        AUDIT_POLICY_LOG_ID NUMBER(15);
        OPERATION           VARCHAR2(1);

    BEGIN

        IF INSERTING THEN
            AUDIT_POLICY_LOG_ID := :new.AUDIT_POLICY_LOG_ID;
            OPERATION := 'I';
        ELSIF UPDATING THEN
            AUDIT_POLICY_LOG_ID := :new.AUDIT_POLICY_LOG_ID;
            OPERATION := 'U';
        ELSE
            AUDIT_POLICY_LOG_ID := :old.AUDIT_POLICY_LOG_ID;
            OPERATION := 'D';
        END IF;

        INSERT INTO OPEN.LDCBI_AU_AUDIT_POLICY_LOG (AUDIT_POLICY_LOG_ID,
                                                    OPERATION)
        VALUES (AUDIT_POLICY_LOG_ID,
                OPERATION);

    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20000,
                                    'Error en TRG_DO_AU_AUDIT_POLICY_LOG por -->' || sqlcode ||
                                    chr(13) || sqlerrm);
    END;

END;
/
