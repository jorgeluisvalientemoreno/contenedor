CREATE OR REPLACE TRIGGER OPEN.TRG_DO_IC_DECORECO
    AFTER INSERT OR UPDATE OR DELETE
    ON OPEN.IC_DECORECO
    REFERENCING OLD AS OLD NEW AS NEW
    FOR EACH ROW
BEGIN

    DECLARE
    DCRCCONS NUMBER(15);
    OPERATION VARCHAR2(1);

    BEGIN

    IF INSERTING THEN
        DCRCCONS := :new.DCRCCONS;
        OPERATION := 'I';
    ELSIF UPDATING THEN
        DCRCCONS := :new.DCRCCONS;
        OPERATION := 'U';
    ELSE
        DCRCCONS := :old.DCRCCONS;
        OPERATION := 'D';
    END IF;

    INSERT INTO OPEN.LDCBI_IC_DECORECO (
        DCRCCONS,
        OPERATION
    )
    VALUES (
        DCRCCONS,
        OPERATION
    );

    EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20000,
                                'Error en TRG_DO_IC_DECORECO por -->' || sqlcode ||
                                chr(13) || sqlerrm);
    END;

END;
/