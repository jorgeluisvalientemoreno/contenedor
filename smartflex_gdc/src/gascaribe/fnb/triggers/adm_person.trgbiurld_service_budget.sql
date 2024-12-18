CREATE OR REPLACE TRIGGER ADM_PERSON.TRGBIURLD_SERVICE_BUDGET
BEFORE INSERT OR UPDATE
ON Ld_Service_Budget
REFERENCING OLD AS old NEW AS new
FOR EACH ROW
/**************************************************************
Propiedad intelectual de Open International Systems. (c).

Trigger      :  trgbiurLd_Service_Budgett

Descripcion  : Trigger que valida el registro a insertar o actualizar en la tabla Ld_Service_Budget

Autor        : Evens Herard Gorut
Fecha        : 04-10-2012

Historia de Modificaciones
Fecha        IDEntrega           Modificación
DD-MM-YYYY    Autor<SAO156931>      Descripcion de la Modificacion
**************************************************************/
DECLARE
    /******************************************
        Declaracion de variables y Constantes
    ******************************************/
BEGIN
   if(:new.budget_amount < 0)then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'El valor del campo [Cantidad Presupuestada] debe ser mayor o igual a cero');
   end if;
    if(:new.executed_amount < 0)then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'El valor del campo [Cantidad ejecutado] debe ser mayor o igual a cero');
    end if;
   /*Obtener valores e instanciar las variables de paquete*/
  LD_BOVar_Validate_Co_Un.rctbLd_Service_Budget.Service_Budget_Id  := :new.Service_Budget_Id;
  LD_BOVar_Validate_Co_Un.rctbLd_Service_Budget.Rel_Mark_Budget_Id := :new.Rel_Mark_Budget_Id;
  LD_BOVar_Validate_Co_Un.rctbLd_Service_Budget.Catecodi           := :new.Catecodi;
  LD_BOVar_Validate_Co_Un.rctbLd_Service_Budget.Sucacodi           := :new.Sucacodi;

EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END trgbiurLd_Service_Budget;
/
