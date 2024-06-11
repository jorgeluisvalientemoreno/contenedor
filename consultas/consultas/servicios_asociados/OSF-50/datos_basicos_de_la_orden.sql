select o.order_id ot
,lo.geo_loca_father_id depa
,open.dage_geogra_location.fsbgetdescription(lo.geo_loca_father_id, null) desc_depa
,lo.geograp_location_id loca, lo.description desc_loca,
,u.operating_unit_id uni, u.name nombre,
,o.order_status_id esta_ot
,a.status
,nvl((select 's' from open.ldc_order r where r.order_id=o.order_id),'n') uobysl
, o.task_type_id titr, t.description desc_titr
, oi.items_id item,i.description desc_item, oi.legal_item_amount, oi.value, oi.total_price
, a.activity_id
, a.package_id
, a.instance_id
,a.order_activity_id
,o.is_pending_liq
,o.created_date
,o.assigned_date
,o.exec_initial_date
,o.execution_final_date
,case when o.order_status_id=8 then o.legalization_date when o.order_status_id=12 then (select stat_chg_date from open.or_order_stat_change ch where ch.order_id=o.order_id and ch.final_status_id=12) end  fecha_lega_anula
,a.product_id
,a.subscription_id
,i.item_classif_id
,defined_contract_id
,o.causal_id
,(select c.description from open.ge_causal c where c.causal_id=o.causal_id) desc_causal
,(select c.class_causal_id from open.ge_causal c where c.causal_id=o.causal_id) clasificacion 
,(select count(1) from open.or_order_activity a2 where a2.product_id=a.product_id and a.task_type_id in (10450,10833,10835,10834,12457, 10444,10723,10833,10795,12460) and status!='f') ot
,(select r.order_id from open.or_related_order r where r.related_order_id=o.order_id and rownum=1) ot_padre
,certificate_id acta
,a.operating_sector_id
,o.operating_sector_id
,p.package_type_id
,p.comment_
,a.address_id
,di.address
,nvl((select 's' from open.ct_item_novelty n where n.items_id=a.activity_id),'n') es_novedad
,o.estimated_cost
(select status_docu from open.ldc_docuorder d where d.order_id=o.order_id) estado_documento
(select ce.final_exclusion_date from open.ct_excluded_order ce where ce.order_id=o.order_id) fecha_hasta_exclusion
,(select oc.order_comment from open.ct_excluded_order ce,open.or_order_comment oc where ce.order_id=o.order_id and oc.order_comment_id=ce.order_comment_id) comentario_exclusion
,(select oc.register_date from open.ct_excluded_order ce,open.or_order_comment oc where ce.order_id=o.order_id and oc.order_comment_id=ce.order_comment_id) fecha_exclusion
,(select pe.person_id from open.or_order_person pe where pe.order_id=o.order_id)
,a.comment_
,a.value_reference
,( select tt.clctclco||'-'||co.clcodesc   from open.ic_clascott tt, open.ic_clascont co where tt.clcttitr=o.task_type_id and co.clcocodi=tt.clctclco) clasificador
,a.legalize_try_times
,o.charge_status
,o.order_value
, (select co.order_comment from open.or_order_comment co where co.order_id=o.order_id /*and co.legalize_comment='y'*/ and rownum=1) comentario_lega
, o.saved_data_values
from open.or_order o
left join open.ab_address di on di.address_id=external_address_id
left join open.ge_geogra_location lo on lo.geograp_location_id=di.geograp_location_id
left join open.or_operating_unit u on u.operating_unit_id=o.operating_unit_id
left join open.or_order_items oi on oi.order_id=o.order_id and nvl(upper(&items),'s')='s'
left join open.or_order_activity a on a.order_id=o.order_id
left join open.or_task_type t on t.task_type_id=o.task_type_id
left join open.ge_items i on i.items_id=oi.items_id
left join open.mo_packages p on p.package_id=a.package_id
left join open.ct_order_certifica ct on ct.order_id=o.order_id
where o.order_id in (246618788,246618789,246618790,246618791,246618792,246618793)