--contratos_contratistas
select *
from ge_contrato  c
where 1=1
--and  c.id_contratista = 2309
and   c.id_tipo_contrato in (890)
and   c.status = 'AB'
