BEGIN
  UPDATE "OPEN".LDC_MARCA_PRODUCTO lmp
	SET lmp.SUSPENSION_TYPE_ID=104, lmp.REGISTER_POR_DEFECTO='N'
	WHERE lmp.ID_PRODUCTO IN (
    1012068,
    50091765)
  AND lmp.SUSPENSION_TYPE_ID=102;
EXCEPTION
  WHEN others THEN
    Errors.setError;
    RAISE ex.CONTROLLED_ERROR;
END;
/