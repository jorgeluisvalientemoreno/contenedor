CREATE OR REPLACE TRIGGER ADM_PERSON.TRGAIURLD_REL_MARKET_RATE
AFTER INSERT OR UPDATE ON Ld_Rel_Market_Rate

/**************************************************************
Propiedad intelectual de Open International Systems. (c).

Trigger  :  trgaiurLd_Rel_Market_Rate

Descripcion  : Trigger que registra los nuevos datos a insertarse en la tabla Ld_Rel_Market_Rate

Autor  : Evens Herard Gorut
Fecha  : 03-10-2012

Historia de Modificaciones
Fecha        IDEntrega           Modificación
DD-MM-YYYY    Autor<SAO156931>      Descripcion de la Modificacion
**************************************************************/
DECLARE
    /******************************************
        Declaracion de variables y Constantes
    ******************************************/
   /*Variables para validación de la tabla Ld_Rel_Market_Rate*/
   nuValexist  number            := ld_boconstans.cnuCero_Value;
   nuRel_Market_Rate_Id          Ld_Rel_Market_Rate.Rel_Market_Rate_Id%type;
   nuRelevant_Market_Id          Ld_Rel_Market_Rate.Relevant_Market_Id%type;
   nuYear                        Ld_Rel_Market_Rate.Year%type;
   nuMonth                       Ld_Rel_Market_Rate.Month%type;
   --

   --
BEGIN
 /*Recupero valores*/
   nuRel_Market_Rate_Id  := LD_BOVar_Validate_Co_Un.rctbLd_Rel_Market_Rate.Rel_Market_Rate_Id;
   nuRelevant_Market_Id  := LD_BOVar_Validate_Co_Un.rctbLd_Rel_Market_Rate.Relevant_Market_Id;
   nuYear                := LD_BOVar_Validate_Co_Un.rctbLd_Rel_Market_Rate.Year;
   nuMonth               := LD_BOVar_Validate_Co_Un.rctbLd_Rel_Market_Rate.Month;
 /*Llamo a la función de validación*/
 nuValexist := LD_BOFun_Vali_Enti_Co_Un.FnuVali_Rel_Mar_rate(nuRel_Market_Rate_Id, nuRelevant_Market_Id, nuYear, nuMonth);
 /*Valido el resultado*/
 IF (nuValexist >ld_boconstans.cnuCero_Value) then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'La configuración tarifa por Mercado relevante, para el periodo establecido ya existe. Verifique los datos.');
 END IF;

EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END TRGAIURLD_REL_MARKET_RATE;
/
