--actualizar_ordenes_generadas

--desasociar dirección de la orden
UPDATE or_order_activity  a SET a.address_id = null
where exists
(select null
from ldc_infoprnorp s
where s.inpnorim = a.order_id
and   s.inpnpefa = 107378);

--desasociar cliente de la orden
UPDATE or_order_activity  a SET a.subscriber_id = null
where exists
(select null
from ldc_infoprnorp s
where s.inpnorim = a.order_id
and   s.inpnpefa = 107378);

--desasociar contrato de la orden
UPDATE or_order_activity  a SET a.subscription_id = null
where exists
(select null
from ldc_infoprnorp s
where s.inpnorim = a.order_id
and   s.inpnpefa = 107378);

--desasociar producto de la orden
UPDATE or_order_activity  a SET a.product_id = null
where exists
(select null
from ldc_infoprnorp s
where s.inpnorim = a.order_id
and   s.inpnpefa = 107378);

--Borrar las ordenenes de la tabla
select *
  from ldc_infoprnorp s
 Where s.inpnpefa in (107378)
 for update

---eliminar archivos del spool del servidor


--a.order_id IN (306048671,306048672,306049274,306049272);
