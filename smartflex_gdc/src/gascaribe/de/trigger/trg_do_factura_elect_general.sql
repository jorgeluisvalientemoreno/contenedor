CREATE OR REPLACE TRIGGER PERSONALIZACIONES.TRG_DO_FACTURA_ELECT_GENERAL
    AFTER INSERT OR UPDATE OR DELETE
    ON PERSONALIZACIONES.FACTURA_ELECT_GENERAL
    REFERENCING OLD AS OLD NEW AS NEW
    FOR EACH ROW
BEGIN

    DECLARE

        CODIGO_LOTE    NUMBER(15);
        TIPO_DOCUMENTO NUMBER(15);
        CONSFAEL       VARCHAR2(15);
        OPERATION      VARCHAR2(1);

    BEGIN

        IF INSERTING THEN
            CODIGO_LOTE := :new.CODIGO_LOTE;
            TIPO_DOCUMENTO := :new.TIPO_DOCUMENTO;
            CONSFAEL := :new.CONSFAEL;
            OPERATION := 'I';
        ELSIF UPDATING THEN
            CODIGO_LOTE := :new.CODIGO_LOTE;
            TIPO_DOCUMENTO := :new.TIPO_DOCUMENTO;
            CONSFAEL := :new.CONSFAEL;
            OPERATION := 'U';
        ELSE
            CODIGO_LOTE := :old.CODIGO_LOTE;
            TIPO_DOCUMENTO := :old.TIPO_DOCUMENTO;
            CONSFAEL := :old.CONSFAEL;
            OPERATION := 'D';
        END IF;

        INSERT INTO PERSONALIZACIONES.LDCBI_FACTURA_ELECT_GENERAL (CODIGO_LOTE, TIPO_DOCUMENTO, CONSFAEL,
                                                                   OPERATION)
        VALUES (CODIGO_LOTE, TIPO_DOCUMENTO,
                CONSFAEL,
                OPERATION);

    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20000,
                                    'Error en TRG_DO_FACTURA_ELECT_GENERAL por -->' || sqlcode ||
                                    chr(13) || sqlerrm);
    END;

END;
/
