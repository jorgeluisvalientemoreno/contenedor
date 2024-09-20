-- INGRESOS RED MATRIZ
select *
  from
(
select 'Ing_Red_Matriz' Tipo, Solicitud, producto, SESUCATE, CARGCONC, CONCDESC, SUM(VALOR) TOTAL,
       (select db.celocebe from open.ldci_centbenelocal db where db.celoloca = loca) cebe
  FROM (
select package_id Solicitud, producto, package_type_id, sesucate, sesusuca, cargconc, concdesc, cargvalo Valor,
       (select GEOGRAP_LOCATION_ID from OPEN.AB_ADDRESS where address_id = susciddi) LOCA
  ----
  from (
        select cargconc, cargvalo, package_id, package_type_id, producto --u.product_id,
          from open.cargos,
               (SELECT distinct to_char(m.package_id) package_id, m.package_type_id, a.product_id producto
                  from open.or_order_activity a, open.mo_packages m, open.or_order o
                 where a.order_id = o.order_id
                   and a.package_id = m.package_id
                   and m.package_type_id in (323)
                   and a.task_type_id in (10268)
                   and o.order_status_id = 8
                   and o.legalization_date >= '&Fecha_Inicial'
                   and o.legalization_date <= '&Fecha_Final 23:59:59'
               ) u
         where cargnuse = producto
           and cargdoso in 'PP-'||package_id
           and cargconc in (674, 30)
           and cargcaca in (41,53)
       ) uu, open.concepto, open.servsusc, open.suscripc
  where sesunuse = producto
    and sesususc = susccodi
    and cargconc = conccodi
)
GROUP BY loca, producto, SESUCATE, SESUSUCA, CARGCONC, CONCDESC, package_type_id, Solicitud
)
