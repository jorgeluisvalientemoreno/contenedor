--actualizar_ordenes_generadas

 SELECT COUNT(*) 
FROM ldc_infoprnorp s
WHERE s.inpnpefa IN (117837);

--desasociar dirección de la orden
UPDATE or_order_activity  a SET a.address_id = null
where exists
(select null
from ldc_infoprnorp s
where s.inpnorim = a.order_id
and   s.inpnpefa = 117837
and  s.inpnsesu in (51477354,51476490,52112264,1150926,1055850,50063343));

--desasociar cliente de la orden
UPDATE or_order_activity  a SET a.subscriber_id = null
where exists
(select null
from ldc_infoprnorp s
where s.inpnorim = a.order_id
and   s.inpnpefa = 117837
and s.inpnsesu in (51477354,51476490,52112264,1150926,1055850,50063343));

--desasociar contrato de la orden
UPDATE or_order_activity  a SET a.subscription_id = null
where exists
(select null
from ldc_infoprnorp s
where s.inpnorim = a.order_id
and   s.inpnpefa = 117837
and s.inpnsesu in (51477354,51476490,52112264,1150926,1055850,50063343));

--desasociar producto de la orden
UPDATE or_order_activity  a SET a.product_id = null
where exists
(select null
from ldc_infoprnorp s
where s.inpnorim = a.order_id
and   s.inpnpefa = 117837
and s.inpnsesu in (51477354,51476490,52112264,1150926,1055850,50063343));

--Borrar las ordenenes de la tabla
DELETE FROM ldc_infoprnorp s
 WHERE s.inpnpefa IN (117837)
 and s.inpnsesu in (51477354,51476490,52112264,1150926,1055850,50063343);
 
--eliminar ejecución del fidf
select *
from estaprog  ep
where esprprog like 'FIDF%'
and   ep.esprpefa in (117837)
for update;

-- Eliminar periodo 
DELETE 
  FROM open.ldc_pecofact p
 WHERE p.pcfapefa = 117837;

---eliminar archivos del spool del servidor


--a.order_id IN (306048671,306048672,306049274,306049272);
