select * --id_contrato, descripcion,id_contratista,  valor_anticipo, anticipo_amortizado
  from open.ge_contrato gc
 where 1 = 1
      --and id_contratista=567 
      --and status='AB';
      --and id_contrato in (5541,5542,8721,8722,9741,10281,10461,11341,12061,12241)
   and 1 = 1;
