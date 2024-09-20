select cargnuse, cargconc, cargvalo,
      (SELECT distinct OR_order_activity.package_id package_id
         FROM open.OR_order_activity, open.or_order, open.mo_packages
        WHERE OR_order_activity.package_id = substr(cargdoso, 4, 8)
          and OR_order_activity.package_id =  mo_packages.package_id
          and OR_order_activity.order_id   =  OR_order.order_id
          and mo_packages.package_type_id  in (323, 100229) 
          and OR_order_activity.status     not in ('40', '45', '5', '26', '32') 
          and OR_order_activity.product_id is not null
          and OR_order_activity.order_activity_id not in (4000050, 4000051)) SOLICITUD, cargdoso
  from open.cargos c, open.servsusc s
 where cargdoso like 'PP%'
   and cargfecr >= '09-02-2015' and cargfecr < '01-03-2015'
   and cargnuse = sesunuse and sesuserv = 6121
   and cargconc in (19,30,674,291,137,287)
