CREATE OR REPLACE TRIGGER OPEN.TRG_DO_INCOFACT
    AFTER INSERT OR UPDATE OR DELETE
    ON OPEN.INCOFACT
    REFERENCING OLD AS OLD NEW AS NEW
    FOR EACH ROW
BEGIN

    DECLARE
    INFACODI NUMBER(15);
    OPERATION VARCHAR2(1);

    BEGIN

    IF INSERTING THEN
        INFACODI := :new.INFACODI;
        OPERATION := 'I';
    ELSIF UPDATING THEN
        INFACODI := :new.INFACODI;
        OPERATION := 'U';
    ELSE
        INFACODI := :old.INFACODI;
        OPERATION := 'D';
    END IF;

    INSERT INTO OPEN.LDCBI_INCOFACT (
        INFACODI,
        OPERATION
    )
    VALUES (
        INFACODI,
        OPERATION
    );

    EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20000,
                                'Error en TRG_DO_INCOFACT por -->' || sqlcode ||
                                chr(13) || sqlerrm);
    END;

END;
/