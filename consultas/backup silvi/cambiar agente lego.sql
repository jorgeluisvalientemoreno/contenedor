select *
from open.LDC_ANEXOLEGALIZA
where order_id in (276935251)
for update;

select *
from or_oper_unit_persons  p
where p.operating_unit_id = 3862
and   p.person_id = 38080
for update;

SELECT *
FROM LDC_AGENLEGO l
where l.description like '%DIASAL%'; --CREACION AGENTE

SELECT *
FROM LDC_USUALEGO
where agente_id = 222;  --USUARIOS Y AGENTES
