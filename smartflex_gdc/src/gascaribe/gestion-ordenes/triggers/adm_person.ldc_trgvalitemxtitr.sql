CREATE OR REPLACE trigger ADM_PERSON.LDC_TRGVALITEMXTITR  BEFORE INSERT OR UPDATE ON LDC_CONFTITRLEGA
REFERENCING NEW AS NEW
FOR EACH ROW
 /**************************************************************************
    Autor       : Horbath
    Fecha       : 2020-21-10
    Ticket      : 465
    Descripcion : Trigger que valida que items este asociado al tipo de trabajo
    Parametros Entrada

    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
DECLARE
  sbExiste VARCHAR2(1);

  CURSOR cuValiItem IS
  SELECT 'X'
  FROM OR_TASK_TYPES_ITEMS
  WHERE TASK_TYPE_ID = :NEW.TASK_TYPE_ID
   and ITEMS_ID = :NEW.ITEM_LEGA;

BEGIN

 IF :NEW.ITEM_LEGA IS NOT NULL THEN
  OPEN cuValiItem;
  FETCH cuValiItem INTO sbExiste;
  IF cuValiItem%NOTFOUND THEN
       CLOSE cuValiItem;
     ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                            'Items ['||:NEW.ITEM_LEGA||'] no esta asociado al tipo de trabajo ['||:NEW.TASK_TYPE_ID||']');

  END IF;
  CLOSE cuValiItem;
  END IF;
EXCEPTION
when ex.CONTROLLED_ERROR then
    raise ex.CONTROLLED_ERROR;
  when OTHERS then
    ERRORs.SETERROR;
    raise ex.CONTROLLED_ERROR;
END;
/
