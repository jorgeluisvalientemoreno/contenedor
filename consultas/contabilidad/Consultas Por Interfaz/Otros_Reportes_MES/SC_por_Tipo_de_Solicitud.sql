-- Consulta de servicios por TIPO
select package_type_id, count(*)
  from 
      (
        SELECT distinct to_char(m.package_id) package_id,  m.package_type_id package_type_id,a.product_id
          from open.or_order_activity a, open.mo_packages m
         where a.product_id in (SELECT distinct hcecnuse
                                 FROM open.hicaesco h
                                WHERE hcececan = 96
                                  AND hcececac = 1
                                  AND hcecserv = 7014
                                  AND hcecfech >= '01-04-2015' and hcecfech < '01-05-2015'
                                  AND open.dapr_product.fnugetproduct_status_id (h.hcecnuse) = 1)
          and a.package_id = m.package_id and m.package_type_id in (323, 100229, 100271, 271)
       )
group by package_type_id
