CREATE OR REPLACE TRIGGER ADM_PERSON.TRGBIURLD_CREDIT_QUOTA
BEFORE INSERT or UPDATE ON LD_CREDIT_QUOTA
REFERENCING OLD AS old NEW AS new For each row

/**************************************************************
Propiedad intelectual de Open International Systems. (c).

Trigger       :  trgaiurBrand

Descripcion   : Trigger para validar que el valor del cupo y la prioridad no sean menor que cero

Autor         : Evelio Sanjuanelo
Fecha         : 03-07-2013

Historia de Modificaciones
Fecha        IDEntrega           Modificacion
DD-MM-YYYY    Autor<SAO>      Descripcion de la Modificacion
**************************************************************/
DECLARE
  /******************************************
      Declaracion de variables y Constantes
  ******************************************/

  /* Constante para formulario de definición de cupo de crédito no simulado */
  csbFIDCC CONSTANT VARCHAR2(5) := 'FIDCC';
  /* Constante para formulario de definición de cupo de crédito simulado */
  csbFIDCS CONSTANT VARCHAR2(5) := 'FIDCS';
  nuError number:=ld_boconstans.cnuGeneric_Error;
BEGIN
  CASE UT_SESSION.GETMODULE()
    WHEN csbFIDCC THEN
      :new.simulation := LD_BOConstans.csbNoFlag;
    WHEN csbFIDCS THEN
      :new.simulation := LD_BOConstans.csbYesFlag;
    ELSE
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                       'No se permite el ingreso de datos desde este formulario.');
  END CASE;
  if(:new.quota_value <= 0)then
    ge_boerrors.seterrorcodeargument(nuError,'El valor del campo [Valor del Cupo] NO puede ser menor o igual que cero');
  end if;

  if(:new.priority < 0)then
    ge_boerrors.seterrorcodeargument(nuError,'El valor del campo [Prioridad de Asignación] NO puede ser menor que cero');
  end if;

EXCEPTION
  when ex.CONTROLLED_ERROR then
    raise ex.CONTROLLED_ERROR;
  when others then
    Errors.setError;
    raise ex.CONTROLLED_ERROR;
END TRGBIURLD_CREDIT_QUOTA;

/
