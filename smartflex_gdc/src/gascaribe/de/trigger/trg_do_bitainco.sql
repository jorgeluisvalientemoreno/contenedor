CREATE OR REPLACE TRIGGER OPEN.TRG_DO_BITAINCO
    AFTER INSERT OR UPDATE OR DELETE
    ON OPEN.BITAINCO
    REFERENCING OLD AS OLD NEW AS NEW
    FOR EACH ROW
BEGIN

    DECLARE
    BIINCOIN NUMBER(15);
    OPERATION VARCHAR2(1);

    BEGIN

    IF INSERTING THEN
        BIINCOIN := :new.BIINCOIN;
        OPERATION := 'I';
    ELSIF UPDATING THEN
        BIINCOIN := :new.BIINCOIN;
        OPERATION := 'U';
    ELSE
        BIINCOIN := :old.BIINCOIN;
        OPERATION := 'D';
    END IF;

    INSERT INTO OPEN.LDCBI_BITAINCO (
        BIINCOIN,
        OPERATION
    )
    VALUES (
        BIINCOIN,
        OPERATION
    );

    EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20000,
                                'Error en TRG_DO_BITAINCO por -->' || sqlcode ||
                                chr(13) || sqlerrm);
    END;

END;
/