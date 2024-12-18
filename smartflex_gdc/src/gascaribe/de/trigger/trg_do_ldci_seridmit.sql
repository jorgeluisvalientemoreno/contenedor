CREATE OR REPLACE TRIGGER OPEN.TRG_DO_LDCI_SERIDMIT
    AFTER INSERT OR UPDATE OR DELETE
    ON OPEN.LDCI_SERIDMIT
    REFERENCING OLD AS OLD NEW AS NEW
    FOR EACH ROW
BEGIN

    DECLARE
    SERIMMIT NUMBER(9);
    SERIDMIT NUMBER(9);
    SERICODI NUMBER(9);
    OPERATION VARCHAR2(1);

    BEGIN

    IF INSERTING THEN
        SERIMMIT := :new.SERIMMIT;
        SERIDMIT := :new.SERIDMIT;
        SERICODI := :new.SERICODI;
        OPERATION := 'I';
    ELSIF UPDATING THEN
        SERIMMIT := :new.SERIMMIT;
        SERIDMIT := :new.SERIDMIT;
        SERICODI := :new.SERICODI;
        OPERATION := 'U';
    ELSE
        SERIMMIT := :old.SERIMMIT;
        SERIDMIT := :old.SERIDMIT;
        SERICODI := :old.SERICODI;
        OPERATION := 'D';
    END IF;

    INSERT INTO OPEN.LDCBI_LDCI_SERIDMIT (
        SERIMMIT,
        SERIDMIT,
        SERICODI,
        OPERATION
    )
    VALUES (
        SERIMMIT,
        SERIDMIT,
        SERICODI,
        OPERATION
    );

    EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20000,
                                'Error en TRG_DO_LDCI_SERIDMIT por -->' || sqlcode ||
                                chr(13) || sqlerrm);
    END;

END;
/