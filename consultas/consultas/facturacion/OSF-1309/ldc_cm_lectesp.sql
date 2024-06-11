-- ldc_pkcm_lectesp

--tabla movilidad

select *
from open.ldc_cm_lectesp  l
inner join or_order  o on o.order_id = l.order_id
where l.sesunuse = 1000867
order by l.felectura desc;

-- tabla actualizada por el job  REGISTRA_LECTESP_CRIT

select *
from ldc_cm_lectesp_crit  c
where c.sesunuse = 1000867
and   c.order_id = 291682991
for update;

-- Contratos que no requieren orden de lectura

select *
from ldc_cm_lectesp_contnl  ll
where ll.contrato_id = 48122378;

-- Presion por producto

select 
from cm_vavafaco  v
where v.vvfcsesu = 50256976
