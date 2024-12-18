CREATE OR REPLACE TRIGGER ADM_PERSON.TRGBIURLD_CO_UN_TASK_TYPE
BEFORE INSERT OR UPDATE
ON LD_Co_Un_Task_Type
REFERENCING OLD AS old NEW AS new
FOR EACH ROW

/**************************************************************
Propiedad intelectual de Open International Systems. (c).

Trigger  :  trgbiurLD_Co_Un_Task_Type

Descripcion  : Trigger que registra los nuevos datos a insertarse en la tabla LD_Co_Un_Task_Type

Autor  : Evens Herard Gorut
Fecha  : 29-09-2012

Historia de Modificaciones
Fecha        IDEntrega           Modificación
DD-MM-YYYY    Autor<SAO156931>      Descripcion de la Modificacion
**************************************************************/
DECLARE
    /******************************************
        Declaracion de variables y Constantes
    ******************************************/
  nuvalexist  number;
BEGIN

LD_BOVar_Validate_Co_Un.rctbLD_Co_Un_Task_Type.Co_Un_Task_Type_Id := :new.Co_Un_Task_Type_Id;
LD_BOVar_Validate_Co_Un.rctbLD_Co_Un_Task_Type.Task_Type_Id := :new.Task_Type_Id;

EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END TRGBIURLD_CO_UN_TASK_TYPE;
/
