-- NUEVO SERVICIOS PENDIENTES 
select CEBE, b.cebedesc DESCRIPCION, product_id NUSE, cargconc CONCEPTO, o.concdesc, cargvalo, ventas,
       (cargvalo/ventas) VR_iNGRESO/*, 
       ((int_reportada/ventas)*-1) REPORTADO*/
from (
select u.product_id, cargconc, cargdoso, cargvalo,
       (select l.celocebe 
          from open.GE_GEOGRA_LOCATION t, open.ldci_centbenelocal l
         where geograp_location_id = (select GEOGRAP_LOCATION_ID from OPEN.AB_ADDRESS
                                       where address_id = susciddi)
          and t.geo_loca_father_id = l.celodpto 
          and t.geograp_location_id = celoloca) CEBE,
       (select count(*) from open.or_order_activity
         where or_order_activity.package_id = U.package_id
           and task_type_id in (12150, 12152, 12153)) VENTAS  /*Numero de CXC de la Venta*/
  from open.cargos c, open.servsusc s, open.suscripc,--, open.servsusc sesu, 
        (
         SELECT distinct OR_order_activity.package_id package_id, OR_order_activity.product_id product_id
           FROM open.OR_order_activity, open.or_order, open.mo_packages
          WHERE OR_order_activity.package_id =  mo_packages.package_id
            and OR_order_activity.order_id   =  OR_order.order_id
            and mo_packages.package_type_id  in (323, 100229) 
            --and OR_order_activity.task_type_id in (12149, 12151, 12150, 12152, 12153)
            --and or_order.created_date        >= '09-02-2015' and or_order.created_date < '01-03-2015'
            and OR_order_activity.status     not in ('40', '45', '5', '26', '32') 
            --and OR_order_activity.status     != 'R'
            and OR_order_activity.product_id is not null
            and OR_order_activity.order_activity_id not in (4000050, 4000051) -- Actividades residenciales   
        ) u
 where s.sesunuse = u.product_id
   and cargfecr   >= '09-02-2015' and cargfecr < '01-03-2015'
   and cargdoso   like 'PP%'
   and cargconc   in (19,30,674,291, 137,287)
   and cargsign   = 'DB'
   and cargdoso   = 'PP-'|| u.package_id
   and sesususc = susccodi
      ) U, OPEN.LDCI_centrobenef b, open.concepto o
 WHERE cebe = b.cebecodi 
   AND cargconc = o.conccodi   
