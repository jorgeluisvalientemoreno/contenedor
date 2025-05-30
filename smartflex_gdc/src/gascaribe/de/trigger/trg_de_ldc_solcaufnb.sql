CREATE OR REPLACE TRIGGER OPEN.TRG_BI_LDC_SOLCAUFNB
    AFTER INSERT OR UPDATE OR DELETE
    ON OPEN.LDC_SOLCAUFNB
    REFERENCING OLD AS OLD NEW AS NEW
    FOR EACH ROW
BEGIN

    DECLARE

    PACKAGE_ID NUMBER(15);
    OPERATION VARCHAR2(1);

    BEGIN

    IF INSERTING THEN
        PACKAGE_ID := :new.PACKAGE_ID;
        OPERATION := 'I';
    ELSIF UPDATING THEN
        PACKAGE_ID := :old.PACKAGE_ID;
        OPERATION := 'U';
    ELSE
        PACKAGE_ID := :old.PACKAGE_ID;
        OPERATION := 'D';
    END IF;

    INSERT INTO OPEN.LDCBI_LDC_SOLCAUFNB (
        PACKAGE_ID,
        OPERATION
    )
    VALUES (
        PACKAGE_ID,
        OPERATION
    );

    EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20000,
                                'Error en TRG_DE_LDC_SOLCAUFNB por -->' || sqlcode ||
                                chr(13) || sqlerrm);
    END;

END;
/