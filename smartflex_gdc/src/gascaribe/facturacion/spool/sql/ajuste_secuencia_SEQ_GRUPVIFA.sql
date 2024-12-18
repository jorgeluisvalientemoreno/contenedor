DECLARE
  nuultvalor NUMBER;
  nuvalor NUMBER;
  nuvalorsec number;
BEGIN
 select max(GRUPCODI) INTO nuvalor
 from open.ldc_GRUPVIFA;

  SELECT LAST_NUMBER into nuultvalor
  FROM DBA_SEQUENCES
  where SEQUENCE_NAME = 'SEQ_GRUPVIFA';

FOR reg IN nuultvalor..nuvalor LOOP
  nuvalorsec:= SEQ_GRUPVIFA.nextval;
END LOOP;
  DBMS_OUTPUT.PUT_LINE('valor secuencia '||nuvalorsec||' valor ultimo registro'||nuvalor);
END;
/