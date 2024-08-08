--validar_rangos_acta
select z.id_zona_oper, 
       zl.descripcion  as desc_zona,
       --o.operating_unit_id,  
       count (d.order_id),  
       nvl(SUM(d.legal_item_amount),0)  suma_item
from open.or_order_items d
 inner join open.or_order  o  on o.order_id = d.order_id
 left join open.ct_item_novelty n on n.items_id = d.items_id
 left join open.ge_detalle_acta  a  on a.id_orden = d.order_id  and a.id_items = d.items_id
 left join open.ldc_zona_loc_ofer_cart  z  on z.localidad = a.geograp_location_id
 left join open.ldc_zona_ofer_cart  zl  on zl.id_zona_oper = z.id_zona_oper
where a.id_acta = 210831
 and   d.items_id in (100008489)
 and   n.liquidation_sign is  null
group by z.id_zona_oper, zl.descripcion-- o.operating_unit_id
order by z.id_zona_oper;

--100005914,100005930,100005932,100005935  no salieron


/*select *
from ge_detalle_acta d2
where  d2.id_acta = 210816
and   d2.id_items in (100005920\*, 100005921*\) */












--100003629, 100004600, 100009057, 100009062
-- 100008489
-- 4000063,4294344,100002513,100002515,100007672,100007675
-- 4294537,4295150,100002514,100002516,100007673,100007676
-- 100003629,100004600,100009057,100009062
-- 100003630,100004601,100009058,100009063
-- 100008489,100008013,100008015,100008016,100008019

/*
100005894
100005895
100005896
100005897
100005914
100005920
100005921
100005929
100005930
100005932
100005935*/
