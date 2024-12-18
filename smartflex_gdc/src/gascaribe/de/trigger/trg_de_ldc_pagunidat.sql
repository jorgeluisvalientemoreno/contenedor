CREATE OR REPLACE TRIGGER OPEN.TRG_BI_LDC_PAGUNIDAT
    AFTER INSERT OR UPDATE OR DELETE
    ON OPEN.LDC_PAGUNIDAT
    REFERENCING OLD AS OLD NEW AS NEW
    FOR EACH ROW
BEGIN

    DECLARE

    PAGARE_ID NUMBER(15);
    OPERATION VARCHAR2(1);

    BEGIN

    IF INSERTING THEN
        PAGARE_ID := :new.PAGARE_ID;
        OPERATION := 'I';
    ELSIF UPDATING THEN
        PAGARE_ID := :old.PAGARE_ID;
        OPERATION := 'U';
    ELSE
        PAGARE_ID := :old.PAGARE_ID;
        OPERATION := 'D';
    END IF;

    INSERT INTO OPEN.LDCBI_LDC_PAGUNIDAT (
        PAGARE_ID,
        OPERATION
    )
    VALUES (
        PAGARE_ID,
        OPERATION
    );

    EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20000,
                                'Error en TRG_DE_LDC_PAGUNIDAT por -->' || sqlcode ||
                                chr(13) || sqlerrm);
    END;

END;
/