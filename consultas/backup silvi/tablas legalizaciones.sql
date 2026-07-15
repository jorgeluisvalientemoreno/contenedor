select *
from open.or_order o 
where order_id in (241794715); 

select *
from open.or_order_activity 
where order_id in (241794715); 



Select *
from open.LDCI_ORDENESALEGALIZAR  t,
     open.or_order  t2
where t.order_id = t2.order_id
--and   t2.task_type_id = 12457
and   t.order_id in (241794715);



SELECT *
FROM OPEN.ldc_otlegalizar
where order_id in (241794715); 

select *
from open.ldc_logtiptraadi
where orden_orginal in (241794715); 

SELECT *
FROM OPEN.LDC_OTADICIONAL
where order_id=241794715;

--GESTIÓN DE LEGO OPEN.LDCI_INFGESTOTMOV quedan las órdenes gestionadas que deben ser confirmadas/legalizadas en OSF
SELECT *
FROM OPEN.LDCI_INFGESTOTMOV
--WHERE ESTADO = 'P';
WHERE ORDER_ID in (241794715);


--GESTIÓN DE LEGALIZACIÓN DIRECTA quedan las órdenes que son legalizadas automáticamente, es decir, llegan a Smartflex ya legalizadas
SELECT *
FROM OPEN.LDCI_ORDENESALEGALIZAR l
WHERE l.order_id in (241794715); 

select * from open.GE_LIST_UNITARY_COST
where operating_unit_id in (3615);

select * from open.LDC_CONST_LIQTARRAN 
where unidad_operativa  in (3615); 

select * from open.GE_UNIT_COST_ITE_LIS
where list_unitary_cost_id in (3895); 

select *
from  open.LDC_CONST_UNOPRL;  --si sale aqui es una unidad ofertada y debe tener config en LDCCLUO




