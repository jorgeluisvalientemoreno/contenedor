SELECT trunc(hcecfech), count(*) --h.hcecnuse
  FROM open.hicaesco h
 WHERE hcececan = 96
   AND hcececac = 1
   AND hcecserv = 7014
   AND hcecfech > '01-03-2015'
   AND open.dapr_product.fnugetproduct_status_id (h.hcecnuse) = 1
group by trunc(hcecfech)
