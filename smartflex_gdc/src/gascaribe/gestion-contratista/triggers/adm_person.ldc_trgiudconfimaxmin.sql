CREATE OR REPLACE trigger ADM_PERSON.LDC_TRGIUDCONFIMAXMIN
  after insert or delete on or_task_types_items
  referencing old as old new as new for each row
  /**************************************************************
  Propiedad Gases del caribe E.S.P.

  Trigger  :  LDC_TRGIUDCONFIMAXMIN

  Descripcion  : Registra datos de configuraci?n de m?ximos y minimos

  Autor  :  Karem Baquero Martinez / JM Gestion Informatica
  Fecha  : 17-11-2017

  Historia de Modificaciones
  **************************************************************/

DECLARE
  nuErrCode number;
  sbErrMsg  VARCHAR2(2000);
  nuSeqitem number; -- consecutivo de Aitems de m?ximos y minimos
  sbparam   ld_parameter.value_chain%type := dald_parameter.fsbGetValue_Chain('LDC_INSERT_MAX_MIN',
                                                                              null);
  nutiptrab number;
  nuitems   number;

BEGIN

  nutiptrab := :old.task_type_id;
  nuitems   := :old.items_id;

  IF inserting THEN

    if sbparam = 'S' then

      select SEQLDC_CMMITEMSXTT.nextval into nuSeqitem from dual;

      INSERT INTO LDC_CMMITEMSXTT
        (itemsxtt_id,
         task_type_id,
         items_id,
         activity_id,
         ITEM_AMOUNT_MIN,
         item_amount_max)
      VALUES
        (nuSeqitem,
        /* nutiptrab*/ :new.task_type_id,
        /* nuitems*/ :new.items_id,
         null,
         0,
         9999);

    END IF;
  END IF;

  IF deleting THEN

    DELETE FROM LDC_CMMITEMSXTT
     WHERE task_type_id = :old.task_type_id
       AND items_id = :old.items_id;

  END IF;
EXCEPTION
  WHEN OTHERS THEN
    pkErrors.GetErrorVar(nuErrCode, sbErrMsg);
END LDC_TRGIUDCONFIMAXMIN;
/
