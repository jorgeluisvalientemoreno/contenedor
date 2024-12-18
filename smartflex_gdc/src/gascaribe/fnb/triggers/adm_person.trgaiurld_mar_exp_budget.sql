CREATE OR REPLACE TRIGGER ADM_PERSON.TRGAIURLD_MAR_EXP_BUDGET
AFTER INSERT OR UPDATE ON Ld_Mar_Exp_Budget

/**************************************************************
Propiedad intelectual de Open International Systems. (c).

Trigger       :  trgbiurLd_Mar_Exp_Budget

Descripcion   : Trigger que valida el registro a insertar o actualizar en la tabla Ld_Mar_Exp_Budget

Autor         : Evens Herard Gorut
Fecha         : 05-10-2012

Historia de Modificaciones
Fecha        IDEntrega           Modificación
DD-MM-YYYY    Autor<SAO156931>      Descripcion de la Modificacion
**************************************************************/
DECLARE
    /******************************************
        Declaracion de variables y Constantes
    ******************************************/
   /*Variables para validación de la tabla Ld_Mar_Exp_Budget*/
  nuValexist  number           := ld_boconstans.cnuCero_Value;
  nuMar_Exp_Budget_id          Ld_Mar_Exp_Budget.Mar_Exp_Budget_id%Type;
  nuRel_Mark_Budget_Id         Ld_Mar_Exp_Budget.Rel_Mark_Budget_Id%type;
   --

BEGIN
 /*Recupero valores*/
   nuMar_Exp_Budget_id   := LD_BOVar_Validate_Co_Un.rctbLd_Mar_Exp_Budget.Mar_Exp_Budget_id;
   nuRel_Mark_Budget_Id  := LD_BOVar_Validate_Co_Un.rctbLd_Mar_Exp_Budget.Rel_Mark_Budget_Id;

 /*Llamo a la función de validación*/
   nuValexist := LD_BOFun_Vali_Enti_Co_Un.FnuVali_Mar_Exp_Budget(nuMar_Exp_budget_id, nuRel_Mark_Budget_Id);

 /*Valido el resultado*/
 IF (nuValexist >ld_boconstans.cnuCero_Value) then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'La configuración definida para el presupuesto - gastos de comercialización ya existe. Verifique los datos.');
 END IF;

EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END TRGAIURLD_MAR_EXP_BUDGET;
/
