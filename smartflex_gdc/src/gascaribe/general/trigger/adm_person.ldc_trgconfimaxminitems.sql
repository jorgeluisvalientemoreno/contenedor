CREATE OR REPLACE trigger ADM_PERSON.LDC_TRGCONFIMAXMINITEMS
  after INSERT or UPDATE on LDC_CMMITEMSXTT
  referencing old as old new as new for each row
  /**************************************************************
  Propiedad Gases del caribe E.S.P.

  Trigger  :  LDC_TRGCONFIMAXMINITEMS

  Descripcion: Validaci?n  de la cantidad m?xima y minima

  Autor  :  Karem Baquero Martinez / JM Gestion Informatica
  Fecha  : 17-11-2017

  Historia de Modificaciones
 **************************************************************/

DECLARE



BEGIN


  if :new.item_amount_min < 0 then
    errors.seterror(2741, 'La cantidad m?nima debe ser mayor igual a 0');
    RAISE ex.controlled_error;

  end if;

  if :new.item_amount_max < :new.item_amount_min then
    errors.seterror(2741,
                    'La cantidad m?xima debe ser mayor o igual a la cantidad m?nima configurada');
    RAISE ex.controlled_error;

  end if;

EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
    RAISE;
  WHEN others THEN
    RAISE;
END LDC_TRGCONFIMAXMINITEMS;
/
