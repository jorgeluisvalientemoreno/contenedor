CREATE OR REPLACE TRIGGER ADM_PERSON.TRGAIURLD_CON_UNI_BUDGET
AFTER INSERT OR UPDATE ON Ld_Con_Uni_Budget

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
   /*Variables para validación de la tabla Ld_Rel_Market_Rate*/
  nuValexist                   number := ld_boconstans.cnuCero_Value;
  nuValtoVerify                number := ld_boconstans.cnuCero_Value;
  --
  nuCon_Uni_Budget_Id          Ld_Con_Uni_Budget.Con_Uni_Budget_Id%Type;
  nuRel_Mark_Budget_Id         Ld_Con_Uni_Budget.Rel_Mark_Budget_Id%type;
  nuConstruct_Unit_Id          Ld_Con_Uni_Budget.Construct_Unit_Id%type;
  --
  nuAmount                     Ld_Con_Uni_Budget.Amount%type;
  nuAmount_executed            Ld_Con_Uni_Budget.Amount_Executed%type;
  nuValue_budget_cop           Ld_Con_Uni_Budget.Value_Budget_Cop%type;
  nuValue_executed             Ld_Con_Uni_Budget.Value_Executed%type;
  --

BEGIN
 /*Recupero valores*/
   nuCon_Uni_Budget_Id   := LD_BOVar_Validate_Co_Un.rctbLd_Con_Uni_Budget.Con_Uni_Budget_Id;
   nuRel_Mark_Budget_Id  := LD_BOVar_Validate_Co_Un.rctbLd_Con_Uni_Budget.Rel_Mark_Budget_Id;
   nuConstruct_Unit_Id   := LD_BOVar_Validate_Co_Un.rctbLd_Con_Uni_Budget.Construct_Unit_Id;
 /*Recupero valores de los campos cantidad y valor*/
   nuAmount              := LD_BOVar_Validate_Co_Un.rctbLd_Con_Uni_Budget.amount;
   nuAmount_executed     := LD_BOVar_Validate_Co_Un.rctbLd_Con_Uni_Budget.amount_executed;
   nuValue_budget_cop    := LD_BOVar_Validate_Co_Un.rctbLd_Con_Uni_Budget.value_budget_cop;
   nuValue_executed      := LD_BOVar_Validate_Co_Un.rctbLd_Con_Uni_Budget.value_executed;

 /*Llamo a la función de validación*/
   nuValexist := LD_BOFun_Vali_Enti_Co_Un.FnuVali_Con_Uni_Budget(nuCon_Uni_Budget_Id, nuRel_Mark_Budget_Id, nuConstruct_Unit_Id);
 /*Valido el resultado*/
 IF (nuValexist >ld_boconstans.cnuCero_Value) then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'La configuración del presupuesto de Unidades constructivas ya existe. Verifique los datos.');
 END IF;

 /*Validar los campos cantidad y valor de la aplicación LDCUD*/
 nuValtoVerify := LD_BOFun_Vali_Enti_Co_Un.FnuVal_Amo_Leg_Fields(nuCon_Uni_Budget_Id,
                                                                 nuAmount,
                                                                 nuAmount_executed,
                                                                 nuValue_budget_cop,
                                                                 nuValue_executed
                                                                 );
 /*
 If (nuValtoVerify = ld_boconstans.cnuonenumber) then
   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'El campo Cantidad presupuestada debe ser mayor a cero. Verifique los datos.');
 END IF;

 If (nuValtoVerify = ld_boconstans.cnuonenumber) then
   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'El campo valor presupuestado debe ser mayor a cero. Verifique los datos.');
 END IF;

 If (nuValtoVerify = ld_boconstans.cnuthreenumber) then
   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'El campo Cantidad legalizada debe ser mayor a cero. Verifique los datos.');
 END IF;

 If (nuValtoVerify = ld_boconstans.cnufournumber) then
   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'El campo valor de lo legalizado debe ser mayor a cero. Verifique los datos.');
 END IF;
 */
EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END TRGAIURLD_CON_UNI_BUDGET;
/
