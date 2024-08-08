select distinct o.operating_unit_id, d.descripcion_items,  sum(d.cantidad),  sum(d.valor_total)
from open.ge_detalle_Acta d
left join open.or_order o on d.id_orden=o.order_id
left join open.or_operating_unit u on o.operating_unit_id=u.operating_unit_id, open.ge_items i
where d.id_Acta=180330  
  and i.items_id=d.id_items
 -- and i.items_id in (4001293,102007,102006)
 -- and d.valor_total!=0
  and i.item_classif_id!=23
  group by  o.operating_unit_id, d.descripcion_items;
  
  
  select *
  from open.ldc_tipo_trab_x_nov_ofertados
  select *
  from open.ldc_const_unoprl
  where unidad_operativa=3911 ;
  
  select *
  from open.ldc_tipos_ofertados
  
    SELECT *
     FROM open.ldc_const_liqtarran bv
    WHERE bv.unidad_operativa in (3532,3530)
      AND bv.zona_ofertados   = -1
     -- and actividad_orden in (100006930, 100006928)
      and  bv.items in (100005393)
      AND '28/02/2021' BETWEEN bv.fecha_ini_vigen AND bv.fecha_fin_vige;
  
  select descripcion_items, o.operating_unit_id, sum(cantidad), sum(valor_total), count(distinct id_orden)
from open.ge_detalle_Acta a, open.ge_items i, open.or_order o
where id_Acta=134810
  and i.items_id=a.id_items
  and i.item_classif_id!=23
  --and valor_total!=0
  and o.order_id=a.id_orden
group by descripcion_items, o.operating_unit_id;

select *
from open.ge_Acta
where id_acta=133953;


select *
from open.ldc_cant_asig_ofer_cart C
where nuano=2020
and numes=9
and c.unidad_operatva_cart=3644;


 SELECT *
    FROM open.ldc_const_liqtarran lq
   WHERE lq.unidad_operativa                                = 3530
     AND lq.items                                           = 100005377
     AND lq.zona_ofertados                                  = -1
   --  and lq.actividad_orden in (100006928, 100006930)
     AND '31/07/2021'      BETWEEN trunc(lq.fecha_ini_vigen) AND trunc(lq.fecha_fin_vige)
   -- AND '30/09/2020'  BETWEEN trunc(lq.fecha_ini_vigen) AND trunc(lq.fecha_fin_vige)
   ORDER BY cantidad_inicial;
   


  SELECT nvl(SUM(cantidad_asignada),0) 
      FROM(
            SELECT nvl(SUM(sa.cantidad_asignada),0) cantidad_asignada
             FROM open.ldc_cant_asig_ofer_cart sa
            WHERE sa.nuano                = 2020
              AND sa.numes                = 9
              AND sa.unidad_operatva_cart = 3645
              AND sa.tipo_trabajo         = sa.tipo_trabajo
              AND sa.actividad            in (select 100008018 from dual union select af.actividad_hija from open.ldc_act_father_act_hija af where af.actividad_padre = 100008018)
              AND sa.zona_ofertados       = sa.zona_ofertados
              AND sa.reg_activo           = 'Y'
            UNION ALL
           SELECT nvl(SUM(sa.cantidad_asignada),0) cantidad_asignada
             FROM open.ldc_cant_asig_ofer_cart sa, open.ldc_unid_oper_hija_mod_tar uh
            WHERE sa.nuano                = 2020
              AND sa.numes                = 9
              AND sa.unidad_operatva_cart = 3645
              AND sa.tipo_trabajo         = sa.tipo_trabajo
              AND 3645      = uh.unidad_operativa_padre
              AND uh.unidad_operativa_hija = sa.unidad_operatva_cart
              AND sa.actividad            in (select 100008018 from dual union select af.actividad_hija from open.ldc_act_father_act_hija af where af.actividad_padre = 100008018)
              AND sa.zona_ofertados       = sa.zona_ofertados
              AND sa.reg_activo           = 'Y');
              
select *
from open.ldc_actas_aplica_proc_ofert              
where acta=134810;

select a.*, rowid
from open.ldc_act_father_act_hija a
where actividad_padre in (100006929,100006930,100006928)

select *
from open.ldc_zona_loc_ofer_cart
where localidad=8689;

select *
from open.ldc_osf_estaproc c
where c.proceso='LDC_PROGENERANOVELTYCARTERA'
and c.fecha_inicial_ejec>='01/08/2022'     ;
select *
from open.ldc_tipos_ofertados

select *
from open.ldc_osf_estaproc c
where c.fecha_inicial_ejec>='01/08/2022'
 and proceso='LDCREASCO'


