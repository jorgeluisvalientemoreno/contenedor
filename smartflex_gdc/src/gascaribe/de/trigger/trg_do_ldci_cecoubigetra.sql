CREATE OR REPLACE TRIGGER OPEN.TRG_DO_LDCI_CECOUBIGETRA
    AFTER INSERT OR UPDATE OR DELETE
    ON OPEN.LDCI_CECOUBIGETRA
    REFERENCING OLD AS OLD NEW AS NEW
    FOR EACH ROW
BEGIN

    DECLARE
    CCBGDPTO NUMBER(6);
    CCBGLOCA NUMBER(6);
    CCBGTITR NUMBER(10);
    OPERATION VARCHAR2(1);

    BEGIN

    IF INSERTING THEN
        CCBGDPTO := :new.CCBGDPTO;
        CCBGLOCA := :new.CCBGLOCA;
        CCBGTITR := :new.CCBGTITR;
        OPERATION := 'I';
    ELSIF UPDATING THEN
        CCBGDPTO := :new.CCBGDPTO;
        CCBGLOCA := :new.CCBGLOCA;
        CCBGTITR := :new.CCBGTITR;
        OPERATION := 'U';
    ELSE
        CCBGDPTO := :old.CCBGDPTO;
        CCBGLOCA := :old.CCBGLOCA;
        CCBGTITR := :old.CCBGTITR;
        OPERATION := 'D';
    END IF;

    INSERT INTO OPEN.LDCBI_LDCI_CECOUBIGETRA(
        CCBGDPTO,
        CCBGLOCA,
        CCBGTITR,
        OPERATION
    )
    VALUES (
        CCBGDPTO,
        CCBGLOCA,
        CCBGTITR,
        OPERATION
    );

    EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20000,
                                'Error en TRG_DO_LDCI_CECOUBIGETRA por -->' || sqlcode ||
                                chr(13) || sqlerrm);
    END;

END;
/