select *
from open.ldc_osf_estaproc
where ano=2017
  and mes=4
  and proceso='LDC_LLENACOSTOINGRESOSOCIERRE'
  ORDER BY 5;
select count(*)
from open.ldc_osf_costingr t
where nuano=2017
  and numes=4;
  
  --43436
--  and product_id=50400441

 ;  
 /*select *
 from open.cargos
 where cargnuse=50400441
 and cargconc=193;
select cargnuse, cargconc, cargdoso, cargcodo
FROM open.cargos ca
WHERE cargcaca IN (41,53)
 AND cargsign = 'DB'
 and cargcuco!=-1
 and not exists(select null from open.or_order  where order_id=cargcodo)
 and cargfecr>='12/02/2015'
 and cargdoso like 'PP-%'
select *
from open.or_order_Activity   a, open.or_task_type o, open.or_order ot
where product_id=50400441
  and a.task_type_id in (12187,12188)
  and a.task_type_id=o.task_type_id
  and ot.order_id=a.order_id;
  

  
  select *
  from open.concepto
  where upper(concdesc)  like '%GASODO%'
    AND CONCCODI=279;
  SELECT *
  FROM OPEN.OR_TASK_TYPE
  WHERE CONCEPT IN (279, 193)

*/
