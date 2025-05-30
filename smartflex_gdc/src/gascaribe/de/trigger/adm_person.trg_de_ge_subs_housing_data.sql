CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_DE_GE_SUBS_HOUSING_DATA
    AFTER INSERT OR UPDATE OR DELETE
    ON OPEN.GE_SUBS_HOUSING_DATA
    REFERENCING OLD AS OLD NEW AS NEW
    FOR EACH ROW
BEGIN

    DECLARE

    SUBSCRIBER_ID NUMBER(15);
    OPERATION VARCHAR2(1);

    BEGIN

    IF INSERTING THEN
        SUBSCRIBER_ID := :new.SUBSCRIBER_ID;
        OPERATION := 'I';
    ELSIF UPDATING THEN
        SUBSCRIBER_ID := :old.SUBSCRIBER_ID;
        OPERATION := 'U';
    ELSE
        SUBSCRIBER_ID := :old.SUBSCRIBER_ID;
        OPERATION := 'D';
    END IF;

    INSERT INTO OPEN.LDCBI_GE_SUBS_HOUSING_DATA (
        SUBSCRIBER_ID,
        OPERATION
    )
    VALUES (
        SUBSCRIBER_ID,
        OPERATION
    );

    EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20000,
                                'Error en TRG_DE_GE_SUBS_HOUSING_DATA por -->' || sqlcode ||
                                chr(13) || sqlerrm);
    END;

END;
/