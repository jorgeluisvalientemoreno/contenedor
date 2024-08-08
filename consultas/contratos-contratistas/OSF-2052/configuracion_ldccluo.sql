--configuracion_ldccluo
select x.iden_reg,
       x.unidad_operativa,
       u.name  nombre_unidad_operativa,
       t.tipo_ofertado,
       x.zona_ofertados,
       z.descripcion  desc_zona_ofertados,
       x.actividad_orden,
       i.description  desc_actividad,
       x.items,
       i2.description  desc_items,
       x.cantidad_inicial,
       x.cantidad_final,
       x.valor_liquidar,
       x.novedad_generar,
       x.fecha_ini_vigen,
       x.fecha_fin_vige
  from open.ldc_const_liqtarran x
  inner join ldc_const_unoprl t  on t.unidad_operativa = x.unidad_operativa
  inner join open.or_operating_unit u on u.operating_unit_id = x.unidad_operativa
  left join open.ge_items i on i.items_id = x.actividad_orden
  left join open.ge_items i2 on i2.items_id = x.items
  left join open.ldc_zona_ofer_cart z on z.id_zona_oper = x.zona_ofertados
   where  x.fecha_fin_vige >= sysdate
and   x.unidad_operativa = 4205
and   x.actividad_orden = 100008489  
order by x.unidad_operativa,x.actividad_orden,x.items,x.zona_ofertados,x.cantidad_inicial
  
  --x.unidad_operativa
 -- x.iden_reg  desc

--and x.zona_ofertados != -1
--and x.zona_ofertados != -1
