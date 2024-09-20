select (select l.celocebe from open.GE_GEOGRA_LOCATION t, open.ldci_centbenelocal l
         where geograp_location_id = (select GEOGRAP_LOCATION_ID from OPEN.AB_ADDRESS where address_id = susciddi)
          and t.geo_loca_father_id = l.celodpto 
          and t.geograp_location_id = celoloca) CEBE,
       product_id, cargconc, cargvalo, ventas, decode(ventas, 0, 0, (cargvalo/ventas)) Vr_Unit
  from open.servsusc, open.suscripc, 
       (
        select/* product_id,*/ cargnuse, cargconc, cargvalo, package_id,
               (select count(*) from open.or_order_activity
                 where or_order_activity.package_id = U.package_id
                   and task_type_id in (12150, 12152, 12153)) VENTAS
          from open.cargos c, --open.servsusc s,     
              (SELECT distinct OR_order_activity.package_id package_id, OR_order_activity.product_id product_id
                 FROM open.OR_order_activity, open.or_order, open.mo_packages
                WHERE OR_order_activity.package_id =  mo_packages.package_id
                  and OR_order_activity.order_id   =  OR_order.order_id
                  and mo_packages.package_type_id  in (323, 100229) 
                  and OR_order_activity.status     not in ('40', '45', '5', '26', '32') 
                  and OR_order_activity.product_id is not null
                  and OR_order_activity.order_activity_id not in (4000050, 4000051)) u
         where cargdoso =  'PP-'||u.package_id
           and cargfecr >= '09-02-2015' and cargfecr < '01-03-2015'
           --and cargnuse = sesunuse and sesuserv = 6121
           and cargconc in (19,30,674,291,137,287)
       )
 where product_id = sesunuse
   and sesususc  = susccodi

