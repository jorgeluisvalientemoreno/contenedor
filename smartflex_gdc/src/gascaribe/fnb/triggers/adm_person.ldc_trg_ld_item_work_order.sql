CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_LD_ITEM_WORK_ORDER
  BEFORE INSERT OR UPDATE ON Ld_Item_Work_Order
  FOR EACH ROW
DECLARE
  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Trigger     : LDC_TRG_Ld_Item_Work_Order
  Descripcion : Trigger para actaulizar el codigo del diferido a la solicitud del seguro voluntario
  Autor       : Jorge Valiente
  Fecha       : 08-06-2017

  Historia de Modificaciones

    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************************/
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN

  if (:new.difecodi is not null) then
    update ldc_segurovoluntario ls
       set ls.difecodi = :new.difecodi
     where ls.package_id = (select ooa.package_id
                              from Or_Order_Activity ooa
                             where ooa.order_id = :old.order_id
                               and rownum = 1);
    commit;
  end if;

EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
    RAISE;
  WHEN others THEN
    RAISE;
END;
/
