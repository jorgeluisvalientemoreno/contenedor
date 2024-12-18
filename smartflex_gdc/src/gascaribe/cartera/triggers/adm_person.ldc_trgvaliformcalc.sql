CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGVALIFORMCALC
/*****************************************************************************************************************************************
		Autor       : Elkin Álvarez / Horbath Technologies
        Fecha       : 2019-05-07
        Ticket      : 200-2704
        Descripcion : Trigger de validación Inserccon ,actualizacion, borrado en la tabla LDC_METAMENSUAL
						dependiendo de la configuracion en el parametro FORMA_CALC_META.


				Historial de Modificaciones
	Fecha            Ticket         Autor             	Modificacion
	=========       =========     =========         ====================
  **************************************************************************************************************************************/
BEFORE INSERT OR UPDATE OR DELETE ON LDC_METAMENSUAL
REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW
DECLARE
	sboperacion 	VARCHAR2(1);
	sbCalMet   		VARCHAR2(100) :=dald_parameter.fsbGetValue_Chain('FORMA_CALC_META',NULL);
	osbErrorMessage GE_ERROR_LOG.DESCRIPTION%TYPE;
BEGIN

	IF inserting THEN
		sboperacion := 'I';
	ELSIF updating THEN
		sboperacion := 'U';
	ELSIF deleting THEN
		sboperacion := 'D';
	ELSE
		sboperacion := '-';
	END IF;

	--Se controla inserccion si la forma de calculo de la meta es automatica (A)
	IF sboperacion = 'I' AND sbCalMet=UPPER('A') THEN
		osbErrorMessage := 'NO SE PUEDE REALIZAR INSERCCION DE REGISTROS ACTUALMENTE, DEBE MODIFICARSE LA CONFIGURACIÓN DEL PARAMETRO FORMA_CALC_META';
		ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,osbErrorMessage);
		RAISE ex.controlled_error;
	END IF;

	--Se controla actualizacion si la forma de calculo de la meta es automatica (A)
	IF sboperacion = 'U' AND sbCalMet=UPPER('A') THEN
		osbErrorMessage := 'NO SE PUEDE REALIZAR ACTUALIZACION DE REGISTROS ACTUALMENTE, DEBE MODIFICARSE LA CONFIGURACIÓN DEL PARAMETRO FORMA_CALC_META';
		ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,osbErrorMessage);
		RAISE ex.controlled_error;
	END IF;

	--Se controla eliminacion si la forma de calculo de la meta es automatica (A)
	IF sboperacion = 'D' AND sbCalMet=UPPER('A') THEN
		osbErrorMessage := 'NO SE PUEDE REALIZAR BORRADO DE REGISTROS ACTUALMENTE, DEBE MODIFICARSE LA CONFIGURACIÓN DEL PARAMETRO FORMA_CALC_META';
		ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,osbErrorMessage);
		RAISE ex.controlled_error;
	END IF;

	EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      raise ex.CONTROLLED_ERROR ;
    when others then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,'error no controlado ' ||sqlerrm);
      raise ex.CONTROLLED_ERROR ;
 END;
/
