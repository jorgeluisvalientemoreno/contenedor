select *
  from open.ldc_versionentrega e
 inner join open.ldc_versionaplica ap on e.codigo = ap.codigo_entrega
 where codigo_caso like '%200-2391%'
   and ap.codigo_empresa = 'GDC'
 order by e.fecha desc
