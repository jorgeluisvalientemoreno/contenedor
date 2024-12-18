CREATE OR REPLACE TRIGGER ADM_PERSON.TRGBIURLD_CON_UNI_BUDGET
BEFORE INSERT OR UPDATE
ON LD_CON_UNI_BUDGET
REFERENCING OLD AS old NEW AS new
FOR EACH ROW
/**************************************************************
Propiedad intelectual de Open International Systems. (c).

Trigger     :  trgbiurLd_Con_Uni_Budget

Descripcion  : Trigger que valida el registro a insertar o actualizar en la tabla Ld_Con_Uni_Budget

Autor       : Evens Herard Gorut
Fecha      : 04-10-2012

Historia de Modificaciones
Fecha        IDEntrega           Modificación
DD-MM-YYYY    Autor<SAO156931>      Descripcion de la Modificacion
**************************************************************/
DECLARE
    /******************************************
        Declaracion de variables y Constantes
    ******************************************/
BEGIN

   if(:new.AMOUNT < 0)then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'El valor del campo [Cantidad Presupuestada] debe ser mayor o igual a cero');
   end if;
   if(:new.VALUE_BUDGET_COP < 0)then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'El valor del campo [Valor Presupuestado] debe ser mayor o igual a cero');
   end if;
   if(:new.AMOUNT_EXECUTED < 0)then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'El valor del campo [Cantidad legalizada] debe ser mayor o igual a cero');
   end if;
   if(:new.VALUE_EXECUTED < 0)then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'El valor del campo [Valor de lo legalizado] debe ser mayor o igual a cero');
   end if;
   /*Obtener valores e instanciar las variables de paquete*/
  LD_BOVar_Validate_Co_Un.rctbLd_Con_Uni_Budget.Con_Uni_Budget_Id  := :new.Con_Uni_Budget_Id;
  LD_BOVar_Validate_Co_Un.rctbLd_Con_Uni_Budget.Rel_Mark_Budget_Id := :new.Rel_Mark_Budget_Id;
  LD_BOVar_Validate_Co_Un.rctbLd_Con_Uni_Budget.Construct_Unit_Id  := :new.Construct_Unit_Id;
  /*Obtener valores e instanciar las variables extras*/
  LD_BOVar_Validate_Co_Un.rctbLd_Con_Uni_Budget.amount             := :new.amount;
  LD_BOVar_Validate_Co_Un.rctbLd_Con_Uni_Budget.amount_executed    := :new.amount_executed;
  LD_BOVar_Validate_Co_Un.rctbLd_Con_Uni_Budget.value_budget_cop   := :new.value_budget_cop;
  LD_BOVar_Validate_Co_Un.rctbLd_Con_Uni_Budget.value_executed     := :new.value_executed;

EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END TRGBIURLD_CON_UNI_BUDGET;
/
