DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta 
  FROM dba_tab_columns
  WHERE table_name ='LDC_CALIFICACION_CONS'
  and column_name = 'TIENE_LECTURA';

  IF nuConta = 0 THEN
     EXECUTE IMMEDIATE q'#ALTER TABLE ldc_calificacion_cons ADD tiene_lectura VARCHAR2(1) DEFAULT 'N'  NOT NULL#' ;
  END IF;
END;
/