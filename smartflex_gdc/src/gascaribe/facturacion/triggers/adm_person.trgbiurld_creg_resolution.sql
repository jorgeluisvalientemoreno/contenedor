CREATE OR REPLACE TRIGGER ADM_PERSON.TRGBIURLD_CREG_RESOLUTION
BEFORE INSERT OR UPDATE
ON LD_Creg_Resolution
REFERENCING OLD AS old NEW AS new
FOR EACH ROW

/**************************************************************
Propiedad intelectual de Open International Systems. (c).

Trigger  :  trgbiurLD_Creg_Resolution

Descripcion  : Trigger que valida el registro a insertarse en la tabla LD_Creg_Resolution

Autor  : Evens Herard Gorut
Fecha  : 26-09-2012

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
  if (:new.Date_Resolution > Ut_Date.Fdtsysdate) then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'La fecha ingresada no es valida. Debe ser inferior o igual a la fecha actual.');
  end if;

EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END TRGBIURLD_CREG_RESOLUTION ;
/
