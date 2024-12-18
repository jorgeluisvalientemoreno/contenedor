CREATE OR REPLACE TRIGGER ADM_PERSON.TRGBIURLD_DIS_EXP_BUDGET
BEFORE INSERT OR UPDATE
ON Ld_Dis_Exp_Budget
REFERENCING OLD AS old NEW AS new
FOR EACH ROW
/**************************************************************
Propiedad intelectual de Open International Systems. (c).

Trigger      :  trgbiurLd_Dis_Exp_Budget

Descripcion  : Trigger que valida el registro a insertar o actualizar en la tabla Ld_Dis_Exp_Budget

Autor        : Evens Herard Gorut
Fecha        : 05-10-2012

Historia de Modificaciones
Fecha        IDEntrega           Modificación
DD-MM-YYYY    Autor<SAO156931>      Descripcion de la Modificacion
**************************************************************/
DECLARE
    /******************************************
        Declaracion de variables y Constantes
    ******************************************/
BEGIN
    if(:new.contable_account <= 0)then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'Debe ingresar un valor valido en "Cuenta contable", este debe ser mayor que cero');
    end if;
    if(:new.budget_value < 0)then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'El valor del campo [Presupuesto en pesos] debe ser mayor o igual a cero');
    end if;
    if(:new.value_executed < 0)then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'El valor del campo [Valor ejecutado en pesos] debe ser mayor o igual a cero');
    end if;
   /*Obtener valores e instanciar las variables de paquete*/
  LD_BOVar_Validate_Co_Un.rctbLd_Dis_Exp_Budget.Dis_Exp_Budget_Id   := :new.Dis_Exp_Budget_Id;
  LD_BOVar_Validate_Co_Un.rctbLd_Dis_Exp_Budget.Rel_Mark_Budget_Id := :new.Rel_Mark_Budget_Id;


EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END TRGBIURLD_DIS_EXP_BUDGET;
/
