DECLARE
  nuConta NUMBER;

BEGIN
  SELECT COUNT(1) INTO nuConta
  FROM proceso_negocio
  WHERE codigo = 18;

 IF nuConta = 0 THEN
  INSERT INTO proceso_negocio(codigo,descripcion) 
    VALUES (18, 'FACTURACION ELECTRONICA');
  COMMIT;
END IF;
END;
/
