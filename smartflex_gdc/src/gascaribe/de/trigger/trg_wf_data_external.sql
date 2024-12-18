CREATE OR REPLACE TRIGGER OPEN.TRG_DO_WF_DATA_EXTERNAL
    AFTER INSERT OR UPDATE OR DELETE
    ON OPEN.WF_DATA_EXTERNAL
    REFERENCING OLD AS OLD NEW AS NEW
    FOR EACH ROW
BEGIN

    DECLARE

    PLAN_ID NUMBER(10);
    OPERATION VARCHAR2(1);

    BEGIN

    IF INSERTING THEN
        PLAN_ID := :new.PLAN_ID;
        OPERATION := 'I';
    ELSIF UPDATING THEN
        PLAN_ID := :old.PLAN_ID;
        OPERATION := 'U';
    ELSE
        PLAN_ID := :old.PLAN_ID;
        OPERATION := 'D';
    END IF;

    INSERT INTO OPEN.LDCBI_WF_DATA_EXTERNAL (
        PLAN_ID,
        OPERATION
    )
    VALUES (
        PLAN_ID,
        OPERATION
    );

    EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20000,
                                'Error en TRG_DO_WF_DATA_EXTERNAL por -->' || sqlcode ||
                                chr(13) || sqlerrm);
    END;

END;
/