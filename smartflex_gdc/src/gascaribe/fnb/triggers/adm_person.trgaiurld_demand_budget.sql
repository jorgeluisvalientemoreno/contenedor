CREATE OR REPLACE TRIGGER ADM_PERSON.TRGAIURLD_DEMAND_BUDGET
AFTER INSERT OR UPDATE ON Ld_Demand_Budget

/**************************************************************
Propiedad intelectual de Open International Systems. (c).

Trigger       :  trgbiurLd_Demand_Budget

Descripcion   : Trigger que valida el registro a insertar o actualizar en la tabla Ld_Demand_Budget

Autor         : Evens Herard Gorut
Fecha         : 04-10-2012

Historia de Modificaciones
Fecha        IDEntrega           Modificación
DD-MM-YYYY    Autor<SAO156931>      Descripcion de la Modificacion
**************************************************************/
DECLARE
    /******************************************
        Declaracion de variables y Constantes
    ******************************************/
   /*Variables para validación de la tabla Ld_Demand_Budget*/
  nuValexist  number           := ld_boconstans.cnuCero_Value;
  nuDemand_Budget_Id           Ld_Demand_Budget.Demand_Budget_Id%Type;
  nuRel_Mark_Budget_Id         Ld_Demand_Budget.Rel_Mark_Budget_Id%type;
  nuCatecodi                   Ld_Demand_Budget.Catecodi%type;
  nuSucacodi                   Ld_Demand_Budget.Sucacodi%type;
   --

BEGIN
 /*Recupero valores*/
   nuDemand_Budget_Id    := LD_BOVar_Validate_Co_Un.rctbLd_Demand_Budget.Demand_Budget_Id;
   nuRel_Mark_Budget_Id  := LD_BOVar_Validate_Co_Un.rctbLd_Demand_Budget.Rel_Mark_Budget_Id;
   nuCatecodi            := LD_BOVar_Validate_Co_Un.rctbLd_Demand_Budget.Catecodi;
   nuSucacodi            := LD_BOVar_Validate_Co_Un.rctbLd_Demand_Budget.Sucacodi;

 /*Llamo a la función de validación*/
   nuValexist := LD_BOFun_Vali_Enti_Co_Un.FnuVali_Demand_Budget(nuDemand_Budget_Id, nuRel_Mark_Budget_Id, nuCatecodi, nuSucacodi);

 /*Valido el resultado*/
 IF (nuValexist >ld_boconstans.cnuCero_Value) then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'La configuración del presupuesto de demanda de Gas ya existe. Verifique los datos.');
 END IF;

EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END TRGAIURLD_DEMAND_BUDGET;
/
