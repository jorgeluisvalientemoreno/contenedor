CREATE OR REPLACE TRIGGER ADM_PERSON.trg_act_order_value_estcobus 
BEFORE INSERT OR UPDATE OF ORDER_VALUE ON OR_ORDER
/**********************************************************************************************************************
Historia de Modificaciones

    Fecha           Autor       Caso        Descripcion
    24/02/2022      JJJM        CA-841      Actualiza valor de la orden, siempre y cuando esta está en
                                            la tabla de auditoria de cobros estandarizados a usuarios
    21/10/2024      jpinedc     OSF-3450    Se migra a ADM_PERSON      
**********************************************************************************************************************/
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
WHEN (old.order_status_id <> 8 AND new.order_status_id = 8)
DECLARE
 nmvavalct       ldc_aud_act_val_order.order_id%TYPE;
 osberrormessage VARCHAR2(3000);
BEGIN
 IF (fblAplicaEntregaxCaso('0000841')) THEN
  -- Consultamos si la orden esta en la tabla de auditoria de cobros estandarizados a usuarios
  nmvavalct := 0;
  BEGIN
   SELECT l.valor_act INTO nmvavalct
     FROM ldc_aud_act_val_order l
    WHERE l.order_id = :new.order_id;
  EXCEPTION
   WHEN no_data_found THEN
    nmvavalct := 0;
  END;
 -- Validamos si el valor es diferente de 0 para actualizar el order_value
  IF nmvavalct <> 0 THEN
   :new.order_value := nmvavalct;
  END IF;
 END IF;
EXCEPTION
 WHEN OTHERS THEN
  osberrormessage := 'Error en el trigger : trg_act_order_value_estcobus'||SQLERRM;
  ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,osberrormessage);
  ut_trace.trace('trg_act_order_value_estcobus '||' '||SQLERRM, 11);
END trg_act_order_value_estcobus;
/
