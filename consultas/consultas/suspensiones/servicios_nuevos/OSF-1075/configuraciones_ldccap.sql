select *
from ldc_proceso p
where p.proceso_id in (7,9)
order by p.proceso_id
;

select *
from ldc_proceso_actividad pa
where pa.proceso_id in (7,9)
and   pa.activity_id in (100009121,100005255)
order by proceso_id
;

select *
from ldc_actividad_generada ag
where ag.proceso_id in (7,9)
order by proceso_id
;
---JMAESTRE@GASCARIBE.COM,VFIGUEROA@GASCARIBE.COM,RAFRICANO@GASCARIBE.COM
