DECLARE
    nuTab1 number := 0;
BEGIN
 
    SELECT COUNT(*) INTO nuTab1
    FROM Dba_Tab_Columns
    WHERE TABLE_NAME = 'LDC_ORDENTRAMITERP' 
    AND  COLUMN_NAME =  'PROCESADO';

    IF nuTab1 = 0 THEN
        execute IMMEDIATE 'ALTER TABLE LDC_ORDENTRAMITERP ADD PROCESADO VARCHAR2(1) DEFAULT ''N''';
	    execute IMMEDIATE 'COMMENT ON COLUMN LDC_ORDENTRAMITERP.PROCESADO IS ''Indica si el registro ya fue procesado (S) o (N)''';
    END IF;

END;
/