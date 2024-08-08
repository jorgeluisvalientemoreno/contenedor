with base as(
select o.order_id, 
       o.task_type_id,
       o.order_status_id,
       o.legalization_date,
       nvl(o.external_address_id, a.address_id) address_id,
       a.activity_id,
       (select description from open.ge_items i where i.items_id=a.activity_id) desc_actividad
from open.or_order o
inner join open.or_order_activity a on a.order_id=o.order_id
inner join open.ge_causal c on c.causal_id=o.causal_id and c.class_causal_id=1
where o.task_type_id in (12669, 11240, 11318, 10764, 11226, /*12617,*/ 12620,10944,12688,12685,12689,10278,10217,12661,12562,12141,12486,11324,10949)
 and o.order_status_id = 8 
 and trunc(o.legalization_Date)>='01/11/2023'
 and trunc(o.legalization_date)<'01/12/2023'
 )
 , base2 as(
 select base.*,
        di.address_parsed,
        di.geograp_location_id,
        lo.description desc_localidad,
        tl.consecutivo,
        tl.descripcion desc_tipo_lista,
        ca.id_zona_oper,
        ct.descripcion desc_zona_ofertad
 from base
 inner join open.ab_address di on di.address_id=base.address_id
 inner join open.ge_geogra_location lo on lo.geograp_location_id = di.geograp_location_id
 left join open.ldc_loc_tipo_list_dep tilo on lo.geograp_location_id = tilo.localidad
 left join open.ldc_tipo_list_depart tl on tilo.tipo_lista = tl.consecutivo
 left join open.ldc_zona_loc_ofer_cart ca on ca.localidad = lo.geograp_location_id
 left join OPEN.LDC_ZONA_OFER_CART ct on ct.id_zona_oper=ca.id_zona_oper
 
 )
select base2.*,
       i.items_id,
       i.description,
       oi.legal_item_amount,
       oi.value
from base2
inner join open.or_order_items oi on oi.order_id=base2.order_id
inner join open.ge_items i on oi.items_id = i.items_id and i.item_classif_id not in (3,8,21) 
