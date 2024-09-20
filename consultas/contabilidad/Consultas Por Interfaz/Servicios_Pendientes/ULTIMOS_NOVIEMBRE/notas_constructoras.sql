select *
 from (
select tipo, cebe, descripcion_cebe, DEPA, DESCRIPCION_DEPA, loca, DESCRIPCION, 
       construct, null cate, null desc_cate, null tecn, null desc_tec, concdesc, null ingreso, null solicitud, 
       null t_soli, null desc_t_sol, null fec_v, null fec_c, null ing_r, saldo
from (
select 'NOTAS_CONSTRUCT' TIPO, 
       (select cbb.celocebe from open.ldci_centbenelocal cbb where cbb.celoloca = Loca) CEBE, 
       (SELECT cb.cebedesc  FROM open.ldci_centrobenef cb
         where cb.cebecodi in (select cbl.celocebe from open.ldci_centbenelocal cbl where cbl.celoloca = Loca)) descripcion_cebe,       
       (select gc.geo_loca_father_id from open.ge_geogra_location gc where gc.geograp_location_id = loca) DEPA, 
       (select gc.description from open.ge_geogra_location gc
         where gc.geograp_location_id = (select gc.geo_loca_father_id from open.ge_geogra_location gc
                                          where gc.geograp_location_id = loca)) DESCRIPCION_DEPA, 
       LOCA, (select gc.description from open.ge_geogra_location gc where gc.geograp_location_id = loca) DESCRIPCION,
       construct, NULL, NULL, NULL, NULL, concdesc,  NULL, NULL, NULL, NULL,  NULL, NULL, NULL, saldo 
  from (
select construct, loca, concepto, decode(concepto,
                                         19,
                                         'CAR_X_CON.',
                                         30,
                                         'INT_RESID.',
                                         291,
                                         'INT_INDUS.',
                                         674,
                                         'REV_PREVIA',
                                         'NO_EXISTE') concdesc,
       (nvl(total,0) + nvl(tot_fac,0)) saldo
  from (
select construct, loca, concepto, total,  
       (select sum(decode(cargsign, 'DB', cargvalo, -cargvalo)) tot_gen
          from open.cargos cc, open.cuencobr, open.factura
         where cc.cargnuse = construct
           AND cucocodi = cargcuco
           AND factfege >= to_Date('01/09/2016 00:00:00', 'dd/mm/yyyy hh24:mi:ss')
           AND factfege <= to_Date('30/09/2016 23:59:59', 'dd/mm/yyyy hh24:mi:ss')
           AND cucofact =  factcodi
           AND cargfecr <= to_Date('30/09/2016 23:59:59', 'dd/mm/yyyy hh24:mi:ss')
           AND cargcuco >  0
           AND cargtipr =  'A'
           AND cargsign in ('DB','CR')
           and cargconc in (19,30,674)
           and cargcaca = 15 -- Facturacion
           and cargconc =concepto) tot_fac
from 
    (
     select cargnuse construct, 
            (select GEOGRAP_LOCATION_ID from OPEN.AB_ADDRESS where address_id = susciddi) LOCA, 
            cargconc concepto, sum(decode(cargsign, 'DB', cargvalo, -cargvalo)) Total
      from open.cargos c, open.servsusc sr, open.suscripc sc
     where cargcuco > 0
       and cargconc in (19,30,674,291)
       and cargsign IN ('DB','CR')   
       and c.cargfecr between '01-09-2016 00:00:00' -- fecha inicial del mes de proceso
                          and '30-09-2016 23:59:59'
       and cargtipr = 'P'
       and cargdoso LIKE ('N%')
       and cargcaca not in (20,23,46,50,51,56,73)
       and cargnuse = sesunuse
       and sesususc = susccodi
       and c.cargnuse in 
               (select distinct cargnuse--, solicitud
                  from (
                        select cargnuse, substr(cargdoso, 4, 8) SOLICITUD,
                               -- CALCULO DE NUMERO DE APTOS
                               (select count(*) from open.or_order_activity act, open.or_order oo
                                 where act.package_id = substr(cargdoso, 4, 8)
                                   and act.order_id      =  oo.order_id
                                   and oo.created_date  <= '30-09-2016 23:59:59' -- fecha final del mes de proceso
                                   and (act.task_type_id in (12150, 12152, 12153)
                                        OR (act.task_type_id = 12149
                                            and act.package_id not in (select att.package_id from open.or_order_activity att
                                                                        where att.package_id = substr(cargdoso,4,8)
                                                                          and att.task_type_id in (12150, 12152, 12153))
                                           )
                                       )
                                   and act.order_id not in (select oro.related_order_id from open.or_related_order oro
                                                            where oro.related_order_id = act.order_id)
                               ) VENTAS,
                               (select count(distinct(act.product_id))
                                  from open.or_order_activity act, open.or_order oo
                                 where act.package_id = substr(cargdoso, 4, 8)
                                   and act.order_id      =  oo.order_id
                                   and oo.created_date  <= '30-09-2016 23:59:59' -- fecha final del mes de proceso
                                   and act.task_type_id in (12150, 12152, 12153)
                                   and act.order_id not in (select oro.related_order_id from open.or_related_order oro
                                                             where oro.related_order_id = act.order_id)
                               ) Productos
                          from open.cargos, open.servsusc, OPEN.CUENCOBR, OPEN.FACTURA
                         where cargcuco != -1
                           and cargnuse = sesunuse
                           and sesuserv =  6121
                           and CARGCUCO = CUCOCODI
                           and factcodi = CUCOfact
                           and FACTFEGE BETWEEN '09-02-2015 00:00:00' -- fecha fija
                                            and '30-09-2016 23:59:59' -- fecha final mes anterior
                           and cargdoso like'PP%'
                           and cargconc in (19,30,674,291)
                       ), open.or_order_activity ort
                 where VENTAS > 0
                   AND VENTAS = PRODUCTOS
                   AND ort.package_id = solicitud
                   and ort.task_type_id in (12149, 12150, 12152, 12153, 12162)
                   and ort.product_id not in (select h.hcecnuse from open.hicaesco h
                                               where h.hcecnuse = ort.product_id
                                                 and h.hcececac = 1 and h.hcecfech <= '30-09-2016 23:59:59') -- fecha final mes anterior
               )
      group by cargnuse, cargconc, susciddi
     ) 
  )
  ) where saldo != 0
)
)
PIVOT(MAX(saldo) FOR concdesc IN ('CAR_X_CON.',
                                  'INT_RESID.',
                                  'INT_INDUS.',
                                  'REV_PREVIA'))
