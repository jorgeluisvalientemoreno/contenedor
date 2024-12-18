CREATE OR REPLACE TRIGGER ADM_PERSON.TRGAIURLD_CO_UN_TASK_TYPE
AFTER INSERT OR UPDATE ON LD_Co_Un_Task_Type

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
   /*Variables para validación de la tabla LD_Co_Un_Task_Type*/
   --rctbValues  LD_BOValidate_Tables_Co_Un.TytbLD_Co_Un_Task_Type;
   nuValexist            number := ld_boconstans.cnuCero_Value;
   sbVardatos            varchar2(4000);
   nuTask_Type_Id        Ld_Co_Un_Task_Type.Task_Type_Id%type;
   nuCo_Un_Task_Type_Id  LD_Co_Un_Task_Type.Co_Un_Task_Type_Id%type;
BEGIN
 /*Recupero valores*/
 nuCo_Un_Task_Type_Id := LD_BOVar_Validate_Co_Un.rctbLD_Co_Un_Task_Type.Co_Un_Task_Type_Id;
 nuTask_Type_Id := LD_BOVar_Validate_Co_Un.rctbLD_Co_Un_Task_Type.Task_Type_Id;
 /*Llamo a la función de validación*/
 nuValexist := LD_BOFun_Vali_Enti_Co_Un.FnuVali_co_un_tk_tp(nuCo_Un_Task_Type_Id,nuTask_Type_Id);
 /*Valido el resultado*/
 IF (nuValexist >ld_boconstans.cnuCero_Value) then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'El tipo de trabajo ya fue ingresado. Verifique los datos');
 END IF;

EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END TRGAIURLD_CO_UN_TASK_TYPE;
/
