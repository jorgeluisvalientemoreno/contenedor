CREATE OR REPLACE trigger ADM_PERSON.LDC_TRGBEFUPESTVERIFTRANSIT
BEFORE UPDATE OF OPER_UNIT_STATUS_ID ON OR_OPERATING_UNIT
REFERENCING OLD AS old NEW AS new
FOR EACH ROW
/**************************************************************
Propiedad intelectual de Gases del Caribe

Trigger       :  LDC_TRGBEFUPESTVERIFTRANSIT

Descripcion   : Trigger que valida cuando se este actualizando el estado de una unidad operativa, si el estado nuevo es inhabilitada
                (manejada en el parametro LDC_ESTADOINHUNOPER_2584) valide si tiene materiales en transito, de tenerlos no permitira
                la actualizacion del estado.

Autor         : Horbath
Fecha         : 25-06-2019

Historia de Modificaciones
Fecha        IDEntrega           Modificacion
25-06-2019   200-2584            Creación
**************************************************************/
DECLARE
SW BOOLEAN; -- Variable booleana donde se almacenara el resultado de la funcion que valide si la unidad operativa tiene materiales en transito
BEGIN
    if (:new.OPER_UNIT_STATUS_ID in (Dald_parameter.fnuGetNumeric_Value('LDC_ESTADOINHUNOPER_2584'))) then
       sw:=LDC_FUNVALIDATRANSITUNOPER(:new.OPERATING_UNIT_ID);
       if sw then
          null;
       else
          ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                           'LA BODEGA ASOCIADA A LA UNIDAD OPERATIVA '||:new.NAME||' TIENE MATERIALES EN TRANSITO POR TANTO NO SE PUEDE INHABILITAR.');
       end if;
    end if;
EXCEPTION
  when ex.CONTROLLED_ERROR then
    raise ex.CONTROLLED_ERROR;
  when others then
    Errors.setError;
    raise ex.CONTROLLED_ERROR;
END LDC_TRGBEFUPESTVERIFTRANSIT;
/
