DECLARE
    CURSOR cuExisteCol IS
    SELECT COUNT(1)
    FROM DBA_TAB_COLUMNS TC
    WHERE TC.TABLE_NAME = 'LDC_GENORDVALDOCU'
      AND TC.COLUMN_NAME = 'ORDER_ID';

    nuExiste    number;
BEGIN
    OPEN cuExisteCol;
    FETCH cuExisteCol INTO nuExiste;
    CLOSE cuExisteCol;

    IF nuExiste = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE LDC_GENORDVALDOCU ADD ORDER_ID NUMBER(15)';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN LDC_GENORDVALDOCU.ORDER_ID IS ''ORDEN GENERADA''';
    END IF;
END;
/