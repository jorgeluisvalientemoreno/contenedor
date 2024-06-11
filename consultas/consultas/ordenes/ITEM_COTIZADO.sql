select *
from open.LDC_ITEMCOTI_LDCRIAIC
where order_id=196439656;

select *
from open.LDC_ITEMADIC_LDCRIAIC
WHERE CODIGO=6365;


select *
from open.LDC_ITEMCOTIINTE_LDCRIAIC
where order_id=196439656;




select *
from open.LDC_ITEMCOTI_LDCRIAIC cot--, OPEN.LDC_ITEMADICINTE_LDCRIAIC item
where cot.order_id=196439656
  AND cot.codigo=item.codigo;

---la de integraciones

select *
from open.LDC_ITEMADICINTE_LDCRIAIC item,open.LDC_ITEMCOTIINTE_LDCRIAIC cot
where cot.order_id=196439656
  and cot.codigo=item.codigo;
  
--la que no es integraciones
select *
from open.LDC_ITEMADIC_LDCRIAIC item, open.LDC_ITEMCOTI_LDCRIAIC cot
where cot.codigo=item.codigo
 and cot.order_id=196439656;

