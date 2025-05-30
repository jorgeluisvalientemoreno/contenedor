select a.operating_unit_id, 
    open.daor_operating_unit.fsbgetname(a.operating_unit_id, null) desc_uni,
    open.daor_operating_unit.fsbgetes_externa(a.operating_unit_id,null) externa, 
    a.items_id,
    i.description desc_item,
    i.item_classif_id clasificacion_item,
    a.quota, 
    a.balance stock_padre, 
    inv.balance stock_inv,
    act.balance stock_act,
    a.total_costs costo_padre, 
    inv.total_costs costo_inv,
    act.total_costs costo_act,
    case when i.item_classif_id=21 then (select count(1) from open.ge_items_seriado s where s.operating_unit_id=a.operating_unit_id and s.items_id=a.items_id and s.id_items_estado_inv in (1,12,16)) else 0 
     end cant_seriales,
    a.transit_out transito_saliente,
    a.transit_in transito_entrante
from open.or_ope_uni_item_bala a 
inner join open.ge_items i on i.items_id=a.items_id
left outer join open.ldc_act_ouib act on act.items_id=a.items_id and act.operating_unit_id =a.operating_unit_id
left outer join open.ldc_inv_ouib inv on inv.items_id=a.items_id and inv.operating_unit_id =a.operating_unit_id
where 1= 1
and a.operating_unit_id = 4642
and  a.items_id in (10000933,10000766,10004204,10002017)
order by a.operating_unit_id desc, a.items_id


--invetario_gdca: 10000933,10000766,10004204,10002017 ut: 4642

--activo_gdca: 10000238,10000933,10003977, 10007058 ut: 4642

--inv_gdgu: 10000427,10006535,10000119,10004070  ut: 4858

--activo_gdgu: 10000930,10004070, 10000974 ut: 4858




--and  inv.total_costs  > 0
    --inv.total_costs / inv.balance  costo_unitario_trasladado,  
--1773 - BODEGA GENERAL ATLANTICO (INVENTARIO)  
/*10000427
10006535
10000119
10004070*/

--10005352 herramienta GDGU
--and inv.total_costs > 0

--and i.item_classif_id = 3
--and  act.total_costs  > 0


