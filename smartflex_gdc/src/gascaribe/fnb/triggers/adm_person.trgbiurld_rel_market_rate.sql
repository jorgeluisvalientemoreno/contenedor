CREATE OR REPLACE TRIGGER ADM_PERSON.TRGBIURLD_REL_MARKET_RATE
BEFORE INSERT OR UPDATE
ON Ld_Rel_Market_Rate
REFERENCING OLD AS old NEW AS new
FOR EACH ROW

/**************************************************************
Propiedad intelectual de Open International Systems. (c).

Trigger  :  trgbiurLd_Rel_Market_Rate

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

BEGIN

/*Validar la inserción y actualización de datos*/
  if (:new.Year > to_number(to_char(sysdate,'yyyy')) or length(:new.Year) != 4) then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'El año ingresado no es valido. Debe ingresar un año valido y no superior al actual');
  end if;
  /*Validar la inserción y actualización de datos*/
  if ((:new.Month <= ld_boconstans.cnuCero_Value) or (:new.Month > 12))then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'El mes ingresado no es valido. Verifique los datos');
  end if;
  if(:new.IPP <= 0)then
              ge_boerrors.seterrorcodeargument(
              Ld_Boconstans.cnuGeneric_Error,
              'El valor de Indice(IPP) debe ser mayor que cero');
  end if;
  if(:new.IPC <= 0)then
              ge_boerrors.seterrorcodeargument(
              Ld_Boconstans.cnuGeneric_Error,
              'El valor de Indice(IPC) debe ser mayor que cero');
  end if;
  if(:new.DIS <= 0)then
   ge_boerrors.seterrorcodeargument(
              Ld_Boconstans.cnuGeneric_Error,
              'El valor de Gastos de Distribución(DIS) debe ser mayor que cero');
  end if;
  if(:new.COM <= 0)then
           ge_boerrors.seterrorcodeargument(
              Ld_Boconstans.cnuGeneric_Error,
              'El valor de Gastos de comercialización(COM) debe ser mayor que cero');
  end if;
  /*Obtener valores e instanciar las vaiables de paquete*/
LD_BOVar_Validate_Co_Un.rctbLd_Rel_Market_Rate.Rel_Market_Rate_Id := :new.Rel_Market_Rate_Id;
LD_BOVar_Validate_Co_Un.rctbLd_Rel_Market_Rate.Relevant_Market_Id := :new.Relevant_Market_Id;
LD_BOVar_Validate_Co_Un.rctbLd_Rel_Market_Rate.Year  := :new.Year;
LD_BOVar_Validate_Co_Un.rctbLd_Rel_Market_Rate.Month := :new.Month;

EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END TRGBIURLD_REL_MARKET_RATE;
/
