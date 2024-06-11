--actas_por_tipo_ofertado
select *
  from open.ldc_const_unoprl l, 
  open.ge_contrato co, 
  open.ge_acta a
 where a.id_contrato = co.id_contrato
   and co.id_contrato = l.contrato
   and l.tipo_ofertado = 3
 order by a.fecha_creacion desc
