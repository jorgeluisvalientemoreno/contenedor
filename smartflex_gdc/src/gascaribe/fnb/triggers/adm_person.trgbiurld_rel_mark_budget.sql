CREATE OR REPLACE TRIGGER ADM_PERSON.TRGBIURLD_REL_MARK_BUDGET
BEFORE INSERT OR UPDATE
ON Ld_Rel_Mark_Budget
REFERENCING OLD AS old NEW AS new
FOR EACH ROW
/**************************************************************
Propiedad intelectual de Open International Systems. (c).

Trigger     :  trgbiurLd_Rel_Mark_Budget

Descripcion  : Trigger que valida el registro a insertar o actualizar en la tabla Ld_Rel_Mark_Budget

Autor       : Evens Herard Gorut
Fecha      : 03-10-2012

Historia de Modificaciones
Fecha        IDEntrega           Modificación
DD-MM-YYYY    Autor<SAO156931>      Descripcion de la Modificacion
**************************************************************/
DECLARE
    /******************************************
        Declaracion de variables y Constantes
    ******************************************/
BEGIN

    /*Validar la inserción y actualización de datos*/
  if ( (:new.Month > 12) or (:new.Month <= ld_boconstans.cnuCero_Value) ) then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'El mes ingresado no es valido. Verifique los datos.');
  end if;

   /*Validar la inserción y actualización de datos*/
  if (:new.Year <= ld_boconstans.cnuCero_Value) then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'El año ingresado no es valido. Verifique los datos.');
  end if;

   /*Obtener valores e instanciar las variables de paquete*/
  LD_BOVar_Validate_Co_Un.rctbLd_Rel_Mark_Budget.Rel_Mark_Budget_Id := :new.Rel_Mark_Budget_Id;
  LD_BOVar_Validate_Co_Un.rctbLd_Rel_Mark_Budget.Relevant_Market_Id := :new.Relevant_Market_Id;
  LD_BOVar_Validate_Co_Un.rctbLd_Rel_Mark_Budget.Geograp_Location_Id:= :new.Geograp_Location_Id;
  LD_BOVar_Validate_Co_Un.rctbLd_Rel_Mark_Budget.Year  := :new.Year;
  LD_BOVar_Validate_Co_Un.rctbLd_Rel_Mark_Budget.Month := :new.Month;

EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END TRGBIURLD_REL_MARK_BUDGET;
/
