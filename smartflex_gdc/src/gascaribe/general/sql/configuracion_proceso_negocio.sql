DECLARE
 nuConta NUMBER;
BEGIN
 
 SELECT COUNT(1) INTO nuConta
 FROM personalizaciones.proceso_negocio
 WHERE CODIGO = 8;
 
  IF nuConta = 0 THEN
    Insert into personalizaciones.proceso_negocio (CODIGO,DESCRIPCION) values (8,'ENERGIA SOLAR');
    COMMIT;
  END IF;
END;
/