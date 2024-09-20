select cargnuse, vr_notas
from (
(select cargnuse,  sum(decode(cargsign, 'DB', cargvalo, -cargvalo)) vr_notas
  from open.cargos ca, open.servsusc sc
 where cargnuse = sesunuse
   and sesuserv = 6121
   and cargfecr BETWEEN to_date('01/07/2015 00:00:00','dd/mm/yyyy hh24:mi:ss')     
                    and to_date('31/07/2015 23:59:59','dd/mm/yyyy hh24:mi:ss')    
   and cargtipr = 'P'    
   and cargsign IN ('CR','DB')
   and cargconc in (19,30,291,674)
   and substr(cargdoso, 1, 1) = 'N'
   and cargcaca not in (20,23,46,50,51,56,73)
 group by cargnuse)
--
MINUS
-- VENTAS CON PRODUCTOS CREADOS
select cargnuse, 0
 from 
(
select Cargnuse
 from
(
select  cargnuse
  from
       (
        select distinct ort.product_id, cargnuse
          from
               (select cargnuse, cargconc, cargcaca, cargvalo, substr(cargdoso, 4, 8) SOLICITUD, trunc(cargfecr) fec_cargo,
                       (select count(*) from open.or_order_activity act, open.or_order oo
                         where act.package_id = substr(cargdoso, 4, 8)
                           and act.order_id      =  oo.order_id
                           and oo.created_date  <= '31-07-2015 23:59:59'
                           and act.task_type_id in (12150, 12152, 12153)
                           and act.order_id not in (select oro.related_order_id from open.or_related_order oro
                                                    where oro.related_order_id = act.order_id)) VENTAS,
                       (select count(distinct(act.product_id))
                          from open.or_order_activity act, open.or_order oo
                         where act.package_id = substr(cargdoso, 4, 8)
                           and act.order_id      =  oo.order_id
                           and oo.created_date  <= '31-07-2015 23:59:59'
                           and act.task_type_id in (12150, 12152, 12153)
                           and act.order_id not in (select oro.related_order_id from open.or_related_order oro
                                                     where oro.related_order_id = act.order_id)) Productos
                  from open.cargos, open.servsusc, OPEN.CUENCOBR, OPEN.FACTURA
                 where cargcuco != -1
                   and cargnuse = sesunuse
                   and sesuserv = 6121
                   and CARGCUCO = CUCOCODI      
                   and factcodi = CUCOfact                   
                   and FACTFEGE BETWEEN to_date('09/02/2015 00:00:00','dd/mm/yyyy hh24:mi:ss')     
                                    and to_date('31/07/2015 23:59:59','dd/mm/yyyy hh24:mi:ss')                     
                   and substr(cargdoso,1,3) = 'PP-'
                   and cargconc in (19,30,674,291)
               ), open.or_order_activity ort, open.suscripc c, open.servsusc s, open.mo_packages mo
         where VENTAS > 0
           AND VENTAS = PRODUCTOS
           AND ort.package_id = solicitud
           and ort.subscription_id = susccodi
           and ort.product_id = sesunuse
           and ort.task_type_id in (12149, 12150, 12152, 12153, 12162)
           and mo.package_id =  ort.package_id
           and ort.product_id not in (select h.hcecnuse from open.hicaesco h
                                       where h.hcecnuse = ort.product_id
                                         and h.hcececac = 1 and h.hcecfech <= '31-07-2015 23:59:59')
       ) xx
group by product_id, cargnuse
)
--
UNION
-- VENTAS SIN PRODUCTOS CREADOS
select cargnuse NUSE
  from (
        select cargnuse, 
               mo.package_id SOLICITUD, package_type_id TIPO_SOLICITUD,
               (select count(*) from open.or_order_activity act, open.or_order oo
                 where act.package_id    = substr(cargdoso, 4, 8)
                   and act.order_id      = oo.order_id
                   and oo.created_date  <= '31-07-2015 23:59:59'
                   and act.task_type_id in (12150, 12152, 12153)
                   and act.order_id not in (select oro.related_order_id from open.or_related_order oro
                                             where oro.related_order_id = act.order_id)) VENTAS,
               (select count(distinct(act.product_id))
                  from open.or_order_activity act, open.or_order oo
                 where act.package_id    = substr(cargdoso, 4, 8)
                   and act.order_id      = oo.order_id
                   and oo.created_date  <= '31-07-2015 23:59:59'
                   and act.task_type_id in (12150, 12152, 12153)
                   and act.order_id not in (select oro.related_order_id from open.or_related_order oro
                                             where oro.related_order_id = act.order_id)) Productos
          from open.cargos, open.servsusc, open.suscripc, open.mo_packages mo, OPEN.CUENCOBR, OPEN.FACTURA
         where cargcuco != -1
           and cargnuse =  sesunuse
           and sesuserv =  6121
           and sesususc =  susccodi
           and CARGCUCO = CUCOCODI      
           and factcodi = CUCOfact                   
           and FACTFEGE BETWEEN to_date('09/02/2015 00:00:00','dd/mm/yyyy hh24:mi:ss')     
                            and to_date('31/07/2015 23:59:59','dd/mm/yyyy hh24:mi:ss')             
           and substr(cargdoso,1,3) = 'PP-'
           and cargconc in (19,30,674,291)
           and substr(cargdoso, 4, 8) = mo.package_id
           and mo.package_type_id in (323, 100229)
       )
 WHERE (VENTAS != PRODUCTOS or ventas = 0 or productos = 0)
) 
)
where cargnuse not in (select h.hcecnuse from open.hicaesco h
                          where h.hcecfech <= '31-07-2015 23:59:59' and h.hcecnuse = cargnuse and h.hcececac in (1,95,110))
