--descuentos_ofertados_en_actas
select z.id_zona_oper zona,
       z.descripcion descripcion_zona,
       case  when t.item_rep_escalonado=-1 then actividad_rep_escalonado else t.item_rep_escalonado end items,
       (select i.description from open.ge_items i where i.items_id = (case  when t.item_rep_escalonado=-1 then actividad_rep_escalonado else t.item_rep_escalonado end )) descripcion_items,
       t.rango_inicial,
       t.rango_final,
       t.valor_liquidar valor_ajuste,
       t.cantidad_ordenes,
       t.total_ajuste
  from open.ldc_reporte_ofert_escalo t
   inner join open.ldc_const_unoprl c on c.unidad_operativa = t.unidad_operativa_esca
   inner join open.ldc_const_liqtarran l  on l.iden_reg = t.iden_regi
   inner join    open.ldc_zona_ofer_cart z  on z.id_zona_oper = l.zona_ofertados
 where c.tipo_ofertado  = 1
 and t.nro_acta = 204710
 order by z.id_zona_oper, t.item_rep_escalonado,t.rango_inicial
