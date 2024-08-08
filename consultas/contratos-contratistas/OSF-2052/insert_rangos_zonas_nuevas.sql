set define off;

--rango 1

merge into open.ldc_const_liqtarran a using
 (select
  (select max(iden_reg) +1 from ldc_const_liqtarran) as iden_reg,
  4250 as unidad_operativa,
  -1 as actividad_orden,
  0 as cantidad_inicial,
  85 as cantidad_final,
  30 as valor_liquidar,
  null as novedad_generar,
  to_date('1/02/2023', 'DD/MM/YYYY') as fecha_ini_vigen,
  to_date('31/10/2025 23:59:59', 'DD/MM/YYYY HH24:MI:SS') as fecha_fin_vige,
  100005914 as items,
  4 as zona_ofertados
  from dual) b
on (a.iden_reg = b.iden_reg)
when not matched then 
insert (
  iden_reg, unidad_operativa, actividad_orden, cantidad_inicial, cantidad_final, 
  valor_liquidar, novedad_generar, fecha_ini_vigen, fecha_fin_vige, items, 
  zona_ofertados)
values (
  b.iden_reg, b.unidad_operativa, b.actividad_orden, b.cantidad_inicial, b.cantidad_final, 
  b.valor_liquidar, b.novedad_generar, b.fecha_ini_vigen, b.fecha_fin_vige, b.items, 
  b.zona_ofertados)
when matched then
update set 
  a.unidad_operativa = b.unidad_operativa,
  a.actividad_orden = b.actividad_orden,
  a.cantidad_inicial = b.cantidad_inicial,
  a.cantidad_final = b.cantidad_final,
  a.valor_liquidar = b.valor_liquidar,
  a.novedad_generar = b.novedad_generar,
  a.fecha_ini_vigen = b.fecha_ini_vigen,
  a.fecha_fin_vige = b.fecha_fin_vige,
  a.items = b.items,
  a.zona_ofertados = b.zona_ofertados;

--rango 2

/*merge into open.ldc_const_liqtarran a using
 (select
  (select max(iden_reg) +1 from ldc_const_liqtarran) as iden_reg,
  4250 as unidad_operativa,
  -1 as actividad_orden,
  86 as cantidad_inicial,
  170 as cantidad_final,
  970 as valor_liquidar,
  null as novedad_generar,
  to_date('1/02/2023', 'DD/MM/YYYY') as fecha_ini_vigen,
  to_date('31/10/2025 23:59:59', 'DD/MM/YYYY HH24:MI:SS') as fecha_fin_vige,
  100005914 as items,
  4 as zona_ofertados
  from dual) b
on (a.iden_reg = b.iden_reg)
when not matched then 
insert (
  iden_reg, unidad_operativa, actividad_orden, cantidad_inicial, cantidad_final, 
  valor_liquidar, novedad_generar, fecha_ini_vigen, fecha_fin_vige, items, 
  zona_ofertados)
values (
  b.iden_reg, b.unidad_operativa, b.actividad_orden, b.cantidad_inicial, b.cantidad_final, 
  b.valor_liquidar, b.novedad_generar, b.fecha_ini_vigen, b.fecha_fin_vige, b.items, 
  b.zona_ofertados)
when matched then
update set 
  a.unidad_operativa = b.unidad_operativa,
  a.actividad_orden = b.actividad_orden,
  a.cantidad_inicial = b.cantidad_inicial,
  a.cantidad_final = b.cantidad_final,
  a.valor_liquidar = b.valor_liquidar,
  a.novedad_generar = b.novedad_generar,
  a.fecha_ini_vigen = b.fecha_ini_vigen,
  a.fecha_fin_vige = b.fecha_fin_vige,
  a.items = b.items,
  a.zona_ofertados = b.zona_ofertados;*/

--rango 3

merge into open.ldc_const_liqtarran a using
 (select
  (select max(iden_reg) +1 from ldc_const_liqtarran)  as iden_reg,
  4250 as unidad_operativa,
  -1 as actividad_orden,
  171 as cantidad_inicial,
  99999 as cantidad_final,
  1902 as valor_liquidar,
  null as novedad_generar,
  to_date('1/02/2023', 'DD/MM/YYYY') as fecha_ini_vigen,
  to_date('31/10/2025 23:59:59', 'DD/MM/YYYY HH24:MI:SS') as fecha_fin_vige,
  100005914 as items,
  4 as zona_ofertados
  from dual) b
on (a.iden_reg = b.iden_reg)
when not matched then 
insert (
  iden_reg, unidad_operativa, actividad_orden, cantidad_inicial, cantidad_final, 
  valor_liquidar, novedad_generar, fecha_ini_vigen, fecha_fin_vige, items, 
  zona_ofertados)
values (
  b.iden_reg, b.unidad_operativa, b.actividad_orden, b.cantidad_inicial, b.cantidad_final, 
  b.valor_liquidar, b.novedad_generar, b.fecha_ini_vigen, b.fecha_fin_vige, b.items, 
  b.zona_ofertados)
when matched then
update set 
  a.unidad_operativa = b.unidad_operativa,
  a.actividad_orden = b.actividad_orden,
  a.cantidad_inicial = b.cantidad_inicial,
  a.cantidad_final = b.cantidad_final,
  a.valor_liquidar = b.valor_liquidar,
  a.novedad_generar = b.novedad_generar,
  a.fecha_ini_vigen = b.fecha_ini_vigen,
  a.fecha_fin_vige = b.fecha_fin_vige,
  a.items = b.items,
  a.zona_ofertados = b.zona_ofertados;
  commit;
