CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_BIU_PLAZO_CERT
/*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : LDC_TRG_BIU_PLAZO_CERT
  Descripcion    : Disparador que deja en nulo el campo is_notif de la tabla, cuando el producto este certificado.

  Autor          : dsaltarin
  Fecha          : 20/02/2020
  Caso           : 328

  Metodos

  Nombre         :
  Parametros         Descripcion
  ============  ===================


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================
  18/10/2024        Lubin Pineda      OSF-3383: Se migra a ADM_PERSON
    ******************************************************************/
  BEFORE INSERT OR UPDATE  ON ldc_plazos_cert
  FOR EACH ROW
BEGIN
  IF (updating AND :new.plazo_maximo > :old.plazo_maximo) OR inserting THEN
		if open.fblAplicaEntregaxCaso('0000328') then
			:NEW.IS_NOTIF := NULL;
		end if;
  END IF;
EXCEPTION
	When ex.controlled_error Then
    Raise;
  When Others Then
    errors.seterror;
    Raise ex.controlled_error;
END LDC_TRG_BIU_PLAZO_CERT;
/
