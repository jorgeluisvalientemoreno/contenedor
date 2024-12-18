CREATE OR REPLACE TRIGGER OPEN.TRG_DO_CT_EXCLUDED_ORDER
    AFTER INSERT OR UPDATE OR DELETE
    ON OPEN.CT_EXCLUDED_ORDER
    REFERENCING OLD AS OLD NEW AS NEW
    FOR EACH ROW
BEGIN

    DECLARE

    ORDER_ID NUMBER(15);
    OPERATION VARCHAR2(1);

    BEGIN

    IF INSERTING THEN
        ORDER_ID := :new.ORDER_ID;
        OPERATION := 'I';
    ELSIF UPDATING THEN
        ORDER_ID := :old.ORDER_ID;
        OPERATION := 'U';
    ELSE
        ORDER_ID := :old.ORDER_ID;
        OPERATION := 'D';
    END IF;

    INSERT INTO OPEN.LDCBI_CT_EXCLUDED_ORDER (
        ORDER_ID,
        OPERATION
    )
    VALUES (
        ORDER_ID,
        OPERATION
    );

    EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20000,
                                'Error en TRG_DO_CT_EXCLUDED_ORDER por -->' || sqlcode ||
                                chr(13) || sqlerrm);
    END;

END;
/