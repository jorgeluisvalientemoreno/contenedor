select *
  from open.ldc_osf_ldcrbai c
 where order by c.fec_corte, c.cod_unid_oper, c.cod_item;
select * 
from open.ldc_osf_salbitemp
where nuano=&año
  and numes=&mes
  order by operating_unit_id, items_id
