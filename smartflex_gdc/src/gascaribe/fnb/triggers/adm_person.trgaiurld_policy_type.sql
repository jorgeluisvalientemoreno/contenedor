CREATE OR REPLACE TRIGGER ADM_PERSON.TRGAIURLD_POLICY_TYPE
AFTER INSERT OR UPDATE OF AMMOUNT_CEDULA ON Ld_Policy_Type
REFERENCING OLD AS old NEW AS new
FOR EACH ROW

/**************************************************************
Propiedad intelectual de Open International Systems. (c).

Trigger       : trgAiurLd_Policy_Type

Descripcion   : Trigger que valida que la Cantidad por Cedula sea mayor a Cero.

Autor         : AAcuna SAO147879
Fecha         : 31-10-2012

Historia de Modificaciones
Fecha        IDEntrega          Modificacion
28-08-2013   jcarrillo.SAO213364 Se valida que el campo Cantidad por Cedula no sea
                                 Nulo.
13-Ago-2013  jcastroSAO214426   Se eliminan las validaciones de los campos que se
                                pasaron a la nueva tabla LD_VALIDITY_POLICY_TYPE,
                                se modifica la validacion sobre la Cantidad por
                                Cedula, se da mayor claridad en el mensaje de error
                                y se documenta el script.

31-Oct-2012  AAcuna.SAO147879   Creacion.
**************************************************************/

DECLARE
  cnuGeneric_Error CONSTANT NUMBER := 2741; -- Error generico

BEGIN
--{
  -- Valida que la Cantidad de Polizas por Cedula sea mayor a Cero
  IF (:new.AMMOUNT_CEDULA is null) THEN
  --{
    GI_BOERRORS.SETERRORCODEARGUMENT (cnuGeneric_Error,
                                     'Debe ingresar la cantidad por cédula para el tipo de póliza ['||:new.policy_type_id||'].');
    RAISE ex.controlled_error;
  --}
  END IF;

  IF (:new.AMMOUNT_CEDULA <= 0) THEN
  --{
    GI_BOERRORS.SETERRORCODEARGUMENT (cnuGeneric_Error,
                                     'La cantidad por cédula para el tipo de póliza ['||:new.policy_type_id||'] debe ser mayor a cero.');
    RAISE ex.controlled_error;
  --}
  END IF;

EXCEPTION
  when ex.CONTROLLED_ERROR then
    raise ex.CONTROLLED_ERROR;

  when OTHERS then
    Errors.setError;
    raise ex.CONTROLLED_ERROR;
--}
END TRGAIURLD_POLICY_TYPE;
/
