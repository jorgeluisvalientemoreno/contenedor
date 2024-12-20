BEGIN
  UPDATE "OPEN".LDC_CERTIFICADOS_OIA lco
	SET lco.RESULTADO_INSPECCION=2
  WHERE lco.CERTIFICADOS_OIA_ID IN (
    3944292,
    3944268,
    3944327,
    3947135,
    3945194,
    3948938,
    3945680,
    3948681,
    3945674,
    3949595,
    3949762,
    3946524,
    3945062,
    3948444,
    3946846,
    3949484,
    3947403,
    3947599,
    3946466,
    3946894,
    3946501,
    3949567,
    3948519,
    3948150
  )
  AND lco.RESULTADO_INSPECCION = 3;
EXCEPTION
  WHEN others THEN
    Errors.setError;
    RAISE ex.CONTROLLED_ERROR;
END;
/