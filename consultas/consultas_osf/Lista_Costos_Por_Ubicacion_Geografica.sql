--Se necesita la fecha de legalizacion de la orden
select *
  from open.GE_UNIT_COST_ITE_LIS, OPEN.GE_LIST_UNITARY_COST
 where GE_UNIT_COST_ITE_LIS.ITEMS_ID = 4000360
   and GE_LIST_UNITARY_COST.LIST_UNITARY_COST_ID =
       open.GE_UNIT_COST_ITE_LIS.list_unitary_cost_id
   and GE_LIST_UNITARY_COST.OPERATING_UNIT_ID is null
   --and '28/05/2024' between GE_LIST_UNITARY_COST.validity_start_date and GE_LIST_UNITARY_COST.validity_final_date
   and GE_LIST_UNITARY_COST.validity_final_date > '02/05/2024'  
   and GE_LIST_UNITARY_COST.validity_final_date > '31/05/2024' 
   and GE_LIST_UNITARY_COST.GEOGRAP_LOCATION_ID in
       (5, 6, 52, 55, 67, 95, 103, 120, 129, 133, 157, 163, 192, 201);
--Localidades ordenes de Acta
with ordenes as
 (select g.id_orden orden
    from open.ge_detalle_acta g
   where g.id_acta in (224710, 224695)
     and g.id_items = 4000360
   group by g.id_orden)
select aa.geograp_location_id, gel.description
  from ordenes
 inner join open.or_order_activity ooa
    on ooa.order_id = ordenes.orden
 inner join open.ab_address aa
    on aa.address_id = ooa.address_id
 inner join open.ge_geogra_location gel
    on gel.geograp_location_id = aa.geograp_location_id
 group by aa.geograp_location_id, gel.description
 order by aa.geograp_location_id;

--fecha legalizacion ordenes de Acta
with ordenes as
 (select g.id_orden orden
    from open.ge_detalle_acta g
   where g.id_acta in (224710, 224695)
     and g.id_items = 4000360
   group by g.id_orden)
select max(trunc(oo.legalization_date)) Fecha_Maxima_legalizacion,
       min(trunc(oo.legalization_date)) Fecha_Minima_legalizacion
  from ordenes
 inner join open.or_order oo
    on oo.order_id = ordenes.orden
 order by trunc(oo.legalization_date) asc;
