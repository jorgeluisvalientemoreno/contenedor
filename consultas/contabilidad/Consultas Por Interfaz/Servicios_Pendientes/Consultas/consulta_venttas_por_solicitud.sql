select cargconc, cargvalo, package_id,-- u.product_id, 
       (select count(*) from open.or_order_activity
        where or_order_activity.package_id = u.package_id
         and task_type_id in (12150, 12152, 12153)) VENTAS
  from open.cargos, 
       (SELECT distinct to_char(m.package_id) package_id, m.package_type_id--, a.product_id
          from open.or_order_activity a, open.mo_packages m
         where a.product_id in (SELECT distinct hcecnuse
                                 FROM open.hicaesco h
                                WHERE hcececan = 96
                                  --and h.hcecnuse = 50899792 --50903401 --50907893
                                  AND hcececac = 1
                                  AND hcecserv = 7014
                                  AND hcecfech >= '01-04-2015' and hcecfech < '01-05-2015')
          and a.package_id = m.package_id and m.package_type_id in (323, 100229)) u
 where cargdoso in 'PP-'||package_id
   and cargconc in (19, 291, 674, 30)
   and cargcaca in (41,53)
--GROUP BY cargconc, package_id
