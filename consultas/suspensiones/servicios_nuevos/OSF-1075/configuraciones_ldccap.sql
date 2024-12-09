select *
from ldc_proceso p
where p.proceso_automatico = 'S'
order by p.proceso_id

--p.proceso_id in (8)

;
select *
from ldc_proceso_actividad pa
where pa.proceso_id in (3,7,8)
order by proceso_id
;

select *
from ldc_actividad_generada ag
where ag.proceso_id in (3,7,8)
order by proceso_id
;


---JMAESTRE@GASCARIBE.COM,VFIGUEROA@GASCARIBE.COM,RAFRICANO@GASCARIBE.COM -- proceso 7
---LGARCIA@GASCARIBE.COM,WLOAIZA@GASCARIBE.COM,CSERRANO@GASCARIBE.COM,PABRES@GASCARIBE.COM -- proceso 3

