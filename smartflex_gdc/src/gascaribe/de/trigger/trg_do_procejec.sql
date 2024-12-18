CREATE OR REPLACE TRIGGER OPEN.TRG_DO_PROCEJEC
    AFTER INSERT OR UPDATE OR DELETE
    ON OPEN.PROCEJEC
    REFERENCING OLD AS OLD NEW AS NEW
    FOR EACH ROW
BEGIN

    DECLARE
    PREJIDPR NUMBER(10);
    OPERATION VARCHAR2(1);

    BEGIN

    IF INSERTING THEN
        PREJIDPR := :new.PREJIDPR;
        OPERATION := 'I';
    ELSIF UPDATING THEN
        PREJIDPR := :new.PREJIDPR;
        OPERATION := 'U';
    ELSE
        PREJIDPR := :old.PREJIDPR;
        OPERATION := 'D';
    END IF;

    INSERT INTO OPEN.LDCBI_PROCEJEC (
        PREJIDPR,
        OPERATION
    )
    VALUES (
        PREJIDPR,
        OPERATION
    );

    EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20000,
                                'Error en TRG_DO_PROCEJEC por -->' || sqlcode ||
                                chr(13) || sqlerrm);
    END;

END;
/