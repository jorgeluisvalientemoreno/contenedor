--liquidacartera
select *
from open.ldc_metas_cont_gestcobr  m
where m.ano = 2024
and m.mes = 8
and m.unidad_operativa = 4296
order by m.fecha_registro desc;



/*
select *
from open.gc_coll_mgmt_pro_det 
where order_id in (323561332,323561325,323561309,323561306,323561311,323561302,323573405,323573406,323573404,323573403,323573402,323573428)*/
