--validar_ordenes_agrupadas_en_acta
select o.task_type_id,
       da.id_orden,
       da.id_items,
       da.descripcion_items,
       da.cantidad,
       da.valor_unitario,
       da.valor_total,
       da.id_acta,
       da.id_lista_unit_costo,
       da.tipo_generacion,
       da.porcen_cumplimiento,
       da.id_unidad_medida,
       da.porcen_ponderado,
       da.condition_by_plan_id,
       da.comment_,
       da.geograp_location_id,
       da.reference_item_id,
       da.base_value,
       da.conditions_id,
       da.simple_condition_id,
       da.affect_contract_val
from ge_detalle_acta  da
inner join ge_acta a  on a.id_acta = da.id_acta
inner join or_order o   on o.order_id = da.id_orden
left join open.ct_item_novelty n on n.items_id = da.id_items
where da.id_acta in (210895, 210893, 210894, 210892)
and   a.id_contrato = 8521
and   o.task_type_id in (12626, 12617, 12626, 10043)
and   o.saved_data_values = 'ORDER_GROUPED'
and n.liquidation_sign is null
order by o.legalization_date desc
