CREATE OR REPLACE TRIGGER ADM_PERSON.TRGBIURLD_REL_MAR_GEO_LOC
BEFORE INSERT OR UPDATE
ON LD_Rel_Mar_Geo_Loc
REFERENCING OLD AS old NEW AS new
FOR EACH ROW

/**************************************************************
Propiedad intelectual de Open International Systems. (c).

Trigger  :  trgbiurLD_Rel_Mar_Geo_Loc

Descripcion  : Trigger que registra los nuevos datos a insertarse en la tabla LD_Rel_Mar_Geo_Loc

Autor  : Evens Herard Gorut
Fecha  : 02-10-2012

Historia de Modificaciones
Fecha        IDEntrega           Modificación
DD-MM-YYYY    Autor<SAO156931>   Descripcion de la Modificacion
**************************************************************/
DECLARE
    /******************************************
   Declaracion de variables y Constantes
    ******************************************/
BEGIN

LD_BOVar_Validate_Co_Un.rctbLD_Rel_Mar_Geo_Loc.Rel_Mar_Geo_Loc_Id  := :new.Rel_Mar_Geo_Loc_Id;
LD_BOVar_Validate_Co_Un.rctbLD_Rel_Mar_Geo_Loc.Relevant_Market_id  := :new.Relevant_Market_id;
LD_BOVar_Validate_Co_Un.rctbLD_Rel_Mar_Geo_Loc.Geograp_Location_Id := :new.Geograp_Location_Id;

EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END TRGBIURLD_REL_MAR_GEO_LOC;
/
