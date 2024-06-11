with base as(SELECT l.list_unitary_cost_id lista_vieja,
       li.items_id,
       open.dage_items.fsbgetdescription(li.items_id, null) desc_item,
       l.operating_unit_id,
       li.price,
       li.sales_value,
       (100+1.61)/100 porcentaje,
       nvl((select exaucost
       from open.LDC_ITEMEXENAUM e
       where e.items_id=li.items_id),'N') excl_cost,
       nvl((select exauprec 
       from open.LDC_ITEMEXENAUM e
       where e.items_id=li.items_id),'N') excl_prec,
       (select l2.list_unitary_cost_id from open.ge_list_unitary_cost l2 where l2.operating_unit_id=l.operating_unit_id and l2.validity_start_date='01/01/2021' and l2.validity_final_date>l2.validity_start_date)  lista_nueva
FROM  OPEN.GE_LIST_UNITARY_COST L, OPEN.GE_UNIT_COST_ITE_LIS LI
WHERE  L.OPERATING_UNIT_ID in (2549,2550,2551,2552,2553,2554,2555,2601,2602,2603,2604,2605,2606,2647,2650,2651,2668,2753,2947,2948,2949,2991,2992,2994,2995)
 and trunc(l.validity_final_date)='31/12/2020'
 and l.validity_start_date<l.validity_final_date
 and LI.LIST_UNITARY_COST_ID=L.LIST_UNITARY_COST_ID
)
select base.*,
       li.price,
       li.sales_value,
       case when excl_cost ='Y' then 
         base.price
       else
         round(base.price*porcentaje,0)
       end costo_calculado,
       case when excl_prec ='Y' then 
         base.sales_value
       else
         round(base.sales_value*porcentaje,0)
       end sales_value_calculado 

from base
left join OPEN.GE_UNIT_COST_ITE_LIS LI on li.list_unitary_cost_id=base.lista_nueva and li.items_id=base.items_id;

with base as(
select lq.iden_reg, lq.unidad_operativa, lq.items, lq.actividad_orden, lq.cantidad_inicial, lq.cantidad_final, lq.valor_liquidar, lq.zona_ofertados,
       lq.fecha_ini_vigen, lq.fecha_fin_vige,(100+1.61)/100 porcentaje,
       nvl((select exaucost
       from open.LDC_ITEMEXENAUM e
       where e.items_id=lq.items),'N') excl_cost,
       nvl((select exaucost
       from open.LDC_ITEMEXENAUM e
       where e.items_id=lq.actividad_orden),'N') excl_cost_act,    
       '----' division
   from open.ldc_const_liqtarran lq          
where lq.unidad_operativa in (2549,2550,2551,2552,2553,2554,2555,2601,2602,2603,2604,2605,2606,2647,2650,2651,2668,2753,2947,2948,2949,2991,2992,2994,2995)
  and lq.fecha_ini_vigen>='01/01/2021')
select lq2.iden_reg, open.daor_operating_unit.fsbgetname(lq2.unidad_operativa, null)||' | '||lq2.unidad_operativa, open.dage_items.fsbgetdescription(lq2.items, null)||' | '||lq2.items, open.dage_items.fsbgetdescription(lq2.actividad_orden, null)||' | '||lq2.actividad_orden, lq2.cantidad_inicial, lq2.cantidad_final, lq2.valor_liquidar, lq2.zona_ofertados,
       lq2.fecha_ini_vigen, lq2.fecha_fin_vige,
       lq.porcentaje,
       lq.excl_cost,
       lq.excl_cost_act,
       lq.division,
       lq.iden_reg, lq.unidad_operativa, lq.items, lq.actividad_orden, lq.cantidad_inicial, lq.cantidad_final, lq.valor_liquidar, ' ---------- | '||lq.zona_ofertados,
       lq.fecha_ini_vigen, lq.fecha_fin_vige,
       case when excl_cost ='Y' then 
         lq.valor_liquidar
       else
         round(lq2.valor_liquidar*porcentaje,0)
       end costo_calculado
from base lq 
left join open.ldc_const_liqtarran lq2 on lq2.unidad_operativa=lq.unidad_operativa and lq.items=lq2.items and lq.actividad_orden=lq2.actividad_orden and lq.zona_ofertados=lq2.zona_ofertados
                                            and lq.cantidad_inicial=lq2.cantidad_inicial and lq.cantidad_final=lq2.cantidad_final and trunc(lq2.fecha_fin_vige)=trunc(lq.fecha_ini_vigen)-1

