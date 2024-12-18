declare

begin
  
  -- Actualizamos el vr unitario e impuesto del los items indicados en esas cotizaciones
  update OPEN.CC_QUOTATION_ITEM q
     set q.unit_value = 0,
         q.unit_tax_value = 0
   where q.quotation_id in (20517,20704,20973)
     and items_id in (4295271, 4294344);
  --
  -- Actualizmaos el valor total y valor impuesto de la cotizacion 
  update OPEN.CC_QUOTATION c 
     set c.total_items_value = (select sum(q.items_quantity * q.unit_value) from OPEN.CC_QUOTATION_ITEM q where q.quotation_id in (c.quotation_id)),
         c.total_tax_value = (select sum(q.items_quantity * q.unit_tax_value) from OPEN.CC_QUOTATION_ITEM q where q.quotation_id in (c.quotation_id))
   where c.package_id in (187713348,190503243,188979361);
  --
  commit;
  --
Exception
    when others then
        ROLLBACK;
          DBMS_OUTPUT.PUT_LINE('Error : ' || SQLERRM);
  End;
/