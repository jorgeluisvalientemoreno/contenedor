--configuracion_tarifas_gestion_cartera_ldcgctgca 
select t.id,
       t.tipo_tarifa,
       tt.desc_tipo_tarifa,
       t.gruptipr,
       g.grgedesc,
       t.grupo_categoria,
       gc.grupdesc,
       t.rango_inicial,
       t.rango_final,
       t.rango_inicump,
       t.rango_fincump,
       t.valor,
       t.unidad_operativa,
       t.fecha_inicial_vig,
       t.fecha_final_vig       
from ldc_tarifas_gestcart  t
inner join ldc_tipos_tarifas  tt  on tt.id_tipo_tarifa = t.tipo_tarifa
inner join ldc_grupos  gc  on gc.grupcodi = t.grupo_categoria
inner join ldc_grupgeca  g  on g.grgecodi = t.gruptipr
where t.unidad_operativa = 4296
and   t.fecha_inicial_vig > '01/01/2024'
--and   t.tipo_tarifa = 'P'
--and   t.grupo_categoria = 1
--and t.gruptipr = 1
order by  t.id, t.tipo_tarifa,  t.gruptipr, t.rango_inicump


/*and   t.tipo_tarifa = 'U'
and   t.grupo_categoria = 1*/

/*--actualizar valor de las tarifas
update ldc_tarifas_gestcart  t1 
  set t1.valor = 1000 
    where t1.unidad_operativa = 4296
    and   t1.tipo_tarifa = 'U'
    and   t1.valor = 0
    and   t1.fecha_final_vig > sysdate;
    

update ldc_tarifas_gestcart  t1 
  set t1.valor = 8.50 
    where t1.unidad_operativa = 4296
    and   t1.valor = 0
    and   t1.tipo_tarifa = 'P'
    and   t1.fecha_final_vig > sysdate*/

/*select *
from  ldc_tarifas_gestcart  t1
where t1.unidad_operativa = 4296
and   t1.valor = 0
and   t1.fecha_final_vig > sysdate
for update*/
  

  
--and t1.rango_fincump = 64,99
