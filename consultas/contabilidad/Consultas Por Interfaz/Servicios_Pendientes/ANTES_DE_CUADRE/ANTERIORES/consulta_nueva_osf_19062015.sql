-- Consulta OSF nueva
select h.hcecnuse,
       sum(decode(cargconc, 30,  (cargvalo/ventas)))  Interna, 
       sum(decode(cargconc, 291, (cargvalo/ventas))) Int_Ind, 
       sum(decode(cargconc, 19,  (cargvalo/ventas)))  C_X_C, 
       sum(decode(cargconc, 674, (cargvalo/ventas)))  REV_PER,
       sum(decode((SELECT 1
                     FROM open.OR_related_order, open.OR_order_activity, open.or_order, open.mo_packages
                    WHERE OR_related_order.rela_order_type_id in (4, 13) -- Tipo de Orden, de Apoyo o Relacionada
                      AND OR_related_order.related_order_id = OR_order_activity.order_id
                      AND OR_order_activity.Status = 'F'
                      AND OR_order_activity.package_id = mo_packages.package_id
                      AND OR_order_activity.task_type_id in (10622, 10624)
                      AND mo_packages.package_type_id in (323, 100229)
                      AND OR_order.order_id = OR_related_order.related_order_id
                      AND OR_order.legalization_date < '01-07-2015'
                      AND OR_order_activity.product_id = h.hcecnuse
                      AND cargconc = 30
                      AND ROWNUM = 1), 1, (cargvalo/ventas), 0)) ING_REPORTADO 
--select *                             
  from open.hicaesco h, 
       (select distinct solicitud, ort.product_id, cargconc, cargvalo/*SUM(cargvalo/ventas) TOTAL*/, ventas 
          from 
               (select cargnuse, cargconc, cargcaca, cargvalo, substr(cargdoso, 4, 8) SOLICITUD,
                               (select count(*) from open.or_order_activity
                                 where or_order_activity.package_id = substr(cargdoso, 4, 8)
                                   and task_type_id in (12150, 12152, 12153)) VENTAS
                          from open.cargos, open.servsusc
                         where cargnuse =  sesunuse
                           and sesuserv =  6121
                           and cargfecr <  '01-07-2015'
                           and substr(cargdoso,1,3) = 'PP-'
                           and cargconc in (19,30,674,291,137,287)
                           and substr(cargdoso, 4, 8) in (select act.package_id
                                                            from open.or_order_activity act, open.mo_packages m
                                                           where act.package_id    = substr(cargdoso, 4, 8)
                                                             and act.task_type_id  in (12149, 12150, 12152, 12153)
                                                             and act.package_id    =  m.package_id
                                                             and m.package_type_id in (323, 100229))
               ) U, open.or_order_activity ort, open.mo_packages mo
         where ort.package_id = solicitud
           and ort.task_type_id in (12149, 12150, 12152, 12153)
           and mo.package_id =  ort.package_id   
       )        
 where h.hcececac = 96
   and h.hcececan = 1
   and h.hcecserv = 7014
   and h.hcecfech < '01-07-2015'
   and h.hcecnuse not in (select distinct hi.hcecnuse from open.hicaesco hi
                           where hi.hcececac = 1
                             and hi.hcececan = 96
                             and hi.hcecserv = 7014
                             and hi.hcecfech < '01-07-2015' and hi.hcecnuse = h.hcecnuse)
   and h.hcecnuse = product_id
group by h.hcecnuse

   

