CREATE OR REPLACE TRIGGER ADM_PERSON.TRGBIURLD_INDEX_IPP_IPC
BEFORE INSERT OR UPDATE
ON LD_INDEX_IPP_IPC
REFERENCING OLD AS old NEW AS new
FOR EACH ROW
/**************************************************************
Propiedad intelectual de Open International Systems. (c).

Trigger     :  trgbiurLd_Index_Ipp_Ipc

Descripcion  : Trigger que valida el registro a insertar o actualizar en la tabla Ld_Index_Ipp_Ipc

Autor       : Evens Herard Gorut
Fecha      : 01-10-2012

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
  if (:new.Year > to_number(to_char(sysdate,'yyyy'))  or length(:new.Year) != 4) then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'El año ingresado no es valido. Debe ingresar un año valido y no superior al actual');
  end if;

  if (:new.Year >= to_number(to_char(sysdate,'yyyy')) )then
   if ( (:new.Month > to_number(to_char(sysdate,'mm')))) then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'El mes no debe ser mayor al mes actual del presente año');
  end if;
 end if;
  if ((:new.Month > 12) or (:new.Month <= 0) ) then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'El mes ingresado no es valido');
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
EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END TRGBIURLD_INDEX_IPP_IPC;
/
