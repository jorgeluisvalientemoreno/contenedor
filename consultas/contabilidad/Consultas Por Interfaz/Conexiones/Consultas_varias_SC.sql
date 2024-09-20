select hcecnuse, hcececan, hcececac, count(*)
  from open.hicaesco
 where hcececac = 1
   and hcececan = 96
group by hcecnuse, hcececan, hcececac
having count(*) > 1;

select * --distinct hcecnuse
  from open.hicaesco 
 where hcececac = 1
   and hcececan = 96 
   and hcecnuse in (6618179,50650783,50728779)
   and open.dapr_product.fnugetproduct_status_id (hcecnuse) != 1

SELECT distinct(hcecnuse)
  FROM open.hicaesco h
 WHERE hcececan = 96
   AND hcececac = 1
   AND hcecserv = 7014
   AND hcecfech >= '09-02-2015' and hcecfech < '01-03-2015'
   AND open.dapr_product.fnugetproduct_status_id (h.hcecnuse) = 1
