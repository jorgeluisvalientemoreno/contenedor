CREATE OR REPLACE TRIGGER ADM_PERSON.TRGAIURLD_REL_MAR_GEO_LOC
AFTER INSERT OR UPDATE ON LD_Rel_Mar_Geo_Loc

/**************************************************************
Propiedad intelectual de Open International Systems. (c).

Trigger  :  trgbiurLD_Rel_Mar_Geo_Loc

Descripcion  : Trigger que registra los nuevos datos a insertarse en la tabla LD_Rel_Mar_Geo_Loc

Autor  : Evens Herard Gorut
Fecha  : 02-10-2012

Historia de Modificaciones
Fecha        IDEntrega           Modificación
DD-MM-YYYY    Autor<SAO156931>      Descripcion de la Modificacion
**************************************************************/
DECLARE
    /******************************************
        Declaracion de variables y Constantes
    ******************************************/
   /*Variables para validación de la tabla LD_Rel_Mar_Geo_Loc*/
   nuValexist  number          := ld_boconstans.cnuCero_Value;
   nuRel_Mar_Geo_Loc_Id        LD_Rel_Mar_Geo_Loc.Rel_Mar_Geo_Loc_Id%type;
   nuRelevant_Market_id        LD_Rel_Mar_Geo_Loc.Relevant_Market_id%type;
   nuGeograp_Location_Id       LD_Rel_Mar_Geo_Loc.Geograp_Location_Id%type;
BEGIN
 /*Recupero valores*/
 nuRel_Mar_Geo_Loc_Id  := LD_BOVar_Validate_Co_Un.rctbLD_Rel_Mar_Geo_Loc.Rel_Mar_Geo_Loc_Id;
 nuRelevant_Market_id  := LD_BOVar_Validate_Co_Un.rctbLD_Rel_Mar_Geo_Loc.Relevant_Market_id;
 nuGeograp_Location_Id := LD_BOVar_Validate_Co_Un.rctbLD_Rel_Mar_Geo_Loc.Geograp_Location_Id;
 /*Llamo a la función de validación*/
 nuValexist := LD_BOFun_Vali_Enti_Co_Un.FnuVali_Re_Ma_Ge_Lo(nuRel_Mar_Geo_Loc_Id, nuRelevant_Market_id, nuGeograp_Location_Id);
 /*Valido el resultado*/
 IF (nuValexist >ld_boconstans.cnuCero_Value) then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'La relación mercado relevante y ubicación geográfica ya existe. Verifique los datos.');
 END IF;

EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END TRGAIURLD_REL_MAR_GEO_LOC;
/
