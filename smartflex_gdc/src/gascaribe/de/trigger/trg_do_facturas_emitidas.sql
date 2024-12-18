CREATE OR REPLACE TRIGGER PERSONALIZACIONES.TRG_DO_FACTURAS_EMITIDAS
    AFTER INSERT OR UPDATE OR DELETE
    ON PERSONALIZACIONES.FACTURAS_EMITIDAS
    REFERENCING OLD AS OLD NEW AS NEW
    FOR EACH ROW
BEGIN

    DECLARE

        CODIGO_LOTE    NUMBER(15);
        TIPO_DOCUMENTO NUMBER(15);
        DOCUMENTO      NUMBER(15);
        OPERATION      VARCHAR2(1);

    BEGIN

        IF INSERTING THEN
            CODIGO_LOTE := :new.CODIGO_LOTE;
            TIPO_DOCUMENTO := :new.TIPO_DOCUMENTO;
            DOCUMENTO := :new.DOCUMENTO;
            OPERATION := 'I';
        ELSIF UPDATING THEN
            CODIGO_LOTE := :new.CODIGO_LOTE;
            TIPO_DOCUMENTO := :new.TIPO_DOCUMENTO;
            DOCUMENTO := :new.DOCUMENTO;
            OPERATION := 'U';
        ELSE
            CODIGO_LOTE := :old.CODIGO_LOTE;
            TIPO_DOCUMENTO := :old.TIPO_DOCUMENTO;
            DOCUMENTO := :old.DOCUMENTO;
            OPERATION := 'D';
        END IF;

        INSERT INTO PERSONALIZACIONES.LDCBI_FACTURAS_EMITIDAS (CODIGO_LOTE, TIPO_DOCUMENTO, DOCUMENTO,
                                                               OPERATION)
        VALUES (CODIGO_LOTE, TIPO_DOCUMENTO,
                DOCUMENTO,
                OPERATION);

    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20000,
                                    'Error en TRG_DO_FACTURAS_EMITIDAS por -->' || sqlcode ||
                                    chr(13) || sqlerrm);
    END;

END;
/
