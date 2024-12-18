CREATE OR REPLACE TRIGGER ADM_PERSON.TRGBIURLD_QUOTA_ASSIGN_POLICY
BEFORE INSERT OR UPDATE
ON LD_QUOTA_ASSIGN_POLICY
REFERENCING OLD AS old NEW AS new
FOR EACH ROW

/**************************************************************
Propiedad intelectual de Open International Systems. (c).

Trigger			: trgbiurLD_QUOTA_ASSIGN_POLICY
Descripcion		: Trigger que setea el campo simulacion de acuerdo a la aplicacion en ejecucion.
Autor			: Alex Valencia Ayola
Fecha			: 10/Oct/2012

Historia de Modificaciones
Fecha		IDEntrega		Modificacion

**************************************************************/
DECLARE
	/******************************************
	Declaracion de variables y Constantes
	******************************************/

	/* Constante para formulario de definicion de politicas asignacion de cupo no simulado */
	csbFIDDP CONSTANT VARCHAR2(5) := 'FIDDP';
	/* Constante para formulario de definicion de politicas asignacion de cupo simulado */
	csbLDDPS CONSTANT VARCHAR2(5) := 'LDDPS';
BEGIN

	CASE UT_SESSION.GETMODULE()
		WHEN csbFIDDP THEN
			:new.simulation := LD_BOConstans.csbNOFlag;
		WHEN csbLDDPS THEN
			:new.simulation := LD_BOConstans.csbYesFlag;
		ELSE
			ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
				'No se permite el ingreso de datos desde este formulario.');
	END CASE;

EXCEPTION
	WHEN ex.CONTROLLED_ERROR THEN
		RAISE ex.CONTROLLED_ERROR;
	WHEN OTHERS THEN
		Errors.setError;
		RAISE ex.CONTROLLED_ERROR;
END TRGBIURLD_QUOTA_ASSIGN_POLICY;
/
