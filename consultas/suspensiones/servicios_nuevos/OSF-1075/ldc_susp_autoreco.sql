---autoreconectados
select count(*)
from ldc_susp_autoreco j
where j.sareproc = 7;


select count(*)
from ldc_susp_autoreco_rp_pl e
where e.sareproc = 7;

select count(*)
from ldc_susp_autoreco_qh e2
where e2.sareproc = 7;


---persecución
select count (*)
from ldc_susp_persecucion
where susp_persec_producto in (1138155,50775569)

union all select * 
from open.ldc_susp_persecucion@osfpl p2
where p2.susp_persec_producto in (1138155,
50775569)


select count (*)
from ldc_susp_persecucion;

select count (*)
from ldc_susp_persecucion_qh


select p.susp_persec_producto
from ldc_susp_persecucion p
where not exists (
 select 1
  from ldc_susp_persecucion p2
   where p2.susp_persec_producto = p.susp_persec_producto
    and p.susp_persec_producto <> p2.susp_persec_producto);
    

