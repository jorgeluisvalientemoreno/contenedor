select cargnuse, contrato, cargconc, concdesc, cargdoso, fecha, signo, total, contratista, nombre, acta, factura, 
       fec_act, orden,
       (select n.notaobse from open.notas n where n.notanume = substr(cargdoso,4,8)) Observacion
  from
(
        select cargnuse, (select sesususc from open.servsusc sc where sc.sesunuse = cargnuse) contrato,
               cargconc, concdesc, cargdoso, fecha, signo, total, contratista, nombre, acta,
               (select ga.extern_invoice_num from open.ge_acta ga where ga.id_acta = acta) factura,
               (select ga.extern_pay_date from open.ge_acta ga where ga.id_acta = acta) fec_act, orden
        from
        (
        Select cargnuse, cargconc, concdesc, cargdoso, fecha, signo, total, contratista,
               (select distinct sb.identification ||' - '|| ct.nombre_contratista Nombre
                  from open.or_operating_unit u, OPEN.GE_CONTRATISTA ct, open.ge_subscriber sb
                 where u.operating_unit_id = contratista
                   and ct.id_contratista = u.contractor_id
                   and ct.subscriber_id = sb.subscriber_id) Nombre,
               (select ac.id_acta from open.ge_detalle_acta ac
                 where ac.id_orden = orden
                   and rownum = 1) acta, orden
        from (
        SELECT cargnuse, cargconc, o.concdesc, cargdoso, trunc(cargfecr) Fecha, cargsign signo, sum(cargvalo) total,
               (select oo.order_id
                  from open.or_order_activity oac, open.or_order oo, open.or_order_items oi
                 where oac.task_type_id in (10140, 10220, 10398)
                   and oac.order_id = oo.order_id
                   and oo.order_status_id = 8
                   and oac.product_id = cargnuse
                   and oac.register_date >= '01-12-2016'
                   and oac.register_date <  '01-01-2017'
                   and rownum = 1) Orden,
               (select oo.operating_unit_id
                  from open.or_order_activity oac, open.or_order oo, open.or_order_items oi
                 where oac.task_type_id in (10140, 10220, 10398)
                   and oac.order_id = oo.order_id
                   and oo.order_status_id = 8
                   and oac.product_id = cargnuse
                   and oac.register_date >= '01-12-2016'
                   and oac.register_date <  '01-01-2017'
                   and oi.order_id = oo.order_id
                   and rownum = 1) Contratista
          FROM open.cargos c, open.concepto o, open.servsusc
         where cargfecr >= '01-12-2016' and cargfecr < '01-01-2017'
           and cargconc =  conccodi
           and cargnuse =  sesunuse
           and sesuserv != 7056
           and concclco =  2
           and cargcaca =  1
           and cargtipr =  'P'
           and cargdoso like 'N%'
        group by cargnuse, cargconc, o.concdesc, cargdoso, trunc(cargfecr), cargsign
        )
        )
)
where contratista is null
