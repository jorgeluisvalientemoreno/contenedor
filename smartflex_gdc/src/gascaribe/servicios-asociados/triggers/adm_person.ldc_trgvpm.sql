CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGVPM
  AFTER UPDATE on LDC_VPM
  REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
WHEN (new.FECHA_VPM <> old.FECHA_VPM)
DECLARE
/**************************************************************************
Propiedad Intelectual de Gases del caribe S.A E.S.P

  Funcion     : LDC_TRGVPM
  Descripcion : trigger que valida si en existe un cambio de fecha de vpm y si es asi se elimina el producto de la tabla REGMEDIVSI
  Autor       : Horbath
  Ticket      : 132
  Fecha       : 9-12-2020

Historia de Modificaciones
Fecha               Autor                Modificacion
=========           =========          ====================


**************************************************************************/

BEGIN
if fblaplicaentregaxcaso('0000132') then
  IF :new.FECHA_VPM> :OLD.FECHA_VPM THEN
	delete from REGMEDIVSI
	where PRODUCTO = :new.PRODUCT_ID;
  END IF;

end if;
EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
    RAISE EX.CONTROLLED_ERROR;
END LDC_TRGVPM;
/
