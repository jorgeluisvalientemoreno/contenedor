-- ** INGRESO SIN COSTO **
--select cargnuse, sum
select ux.cargnuse, IC.CLCOCODI, ic.clcodesc, ux.cargconc, valor
  from (
        select cargnuse, cargconc, sum(valor) valor
          from (
                select cargnuse, cargconc, sum(decode(cargsign, 'DB',cargvalo,'AS', cargvalo, cargvalo*-1)) valor
                 from open.cargos c, OPEN.CUENCOBR, OPEN.FACTURA, OPEN.SERVSUSC ss, open.concepto
                where c.cargnuse = ss.sesunuse
                  and ss.sesuserv = 7014
                  AND CARGCUCO = CUCOCODI
                  AND factcodi = CUCOfact
                  and cargconc = conccodi
                  --and cargconc in (19,30,291,674)
                  and concclco in (4,13,17,19,22,24,27,28,36,37,81,108,109,110,111,112,113,118,169,193,291,400,401)
                  --and concclco not in (311,246,303,252,253)
                  and FACTFEGE BETWEEN to_date('01/12/2015 00:00:00','dd/mm/yyyy hh24:mi:ss')
                                   and to_date('31/12/2015 23:59:59','dd/mm/yyyy hh24:mi:ss')
                  and cargtipr = 'A'
                  and cargsign = 'DB'
                  and cargsign NOT IN ('PA','AP','SA')
                  and cargcaca NOT IN (20,23,46,50,51,56,73)
                group by cargnuse, cargconc
               )
        group by cargnuse, cargconc
        UNION
        -- NOTAS
        select cargnuse, cargconc , sum(valor) valor
          from (
                select cargnuse, cargconc, sum(decode(cargsign, 'DB',cargvalo,'AS', cargvalo, cargvalo*-1)) valor
                from open.cargos c, open.SERVSUSC ss, open.CONCEPTO CO, open.CAUSCARG csc
                where c.cargcaca = csc.cacacodi
                  and c.cargnuse = ss.sesunuse
                  and ss.sesuserv = 7014
                  and c.CARGCONC = CO.CONCCODI
                  --and cargconc in (19,30,291,674)
                  and c.cargfecr between to_date('01/12/2015 00:00:00','dd/mm/yyyy hh24:mi:ss')
                                     and to_date('31/12/2015 23:59:59','dd/mm/yyyy hh24:mi:ss')
                  and concclco in (4,13,17,19,22,24,27,28,36,37,81,108,109,110,111,112,113,118,169,193,291,400,401)
                  --and concclco not in (311,246,303,252,253)
                  AND CARGCUCO > 0
                  and cargtipr = 'P'
                  and cargsign NOT IN ('PA','AP')
                  AND substr(cargdoso,1,2) NOT IN ('PA','AP')
                  and cargcaca not in (20,23,46,50,51,56,73)
                group by cargconc,cargnuse
               )
        group by cargnuse, cargconc) UX,
        (select cargnuse, cargconc
            from (
                  select cargnuse, cargconc
                    from (
                          select cargnuse, cargconc
                           from open.cargos c, OPEN.CUENCOBR, OPEN.FACTURA, OPEN.SERVSUSC ss, open.concepto
                          where c.cargnuse = ss.sesunuse
                            and ss.sesuserv = 7014
                            AND CARGCUCO = CUCOCODI
                            AND factcodi = CUCOfact
                            and cargconc = conccodi
                            --and cargconc in (19,30,291,674)
                            and concclco in (4,13,17,19,22,24,27,28,36,37,81,108,109,110,111,112,113,118,169,193,291,400,401)
                            --and concclco not in (311,246,303,252,253)
                            and FACTFEGE BETWEEN to_date('01/12/2015 00:00:00','dd/mm/yyyy hh24:mi:ss')
                                             and to_date('31/12/2015 23:59:59','dd/mm/yyyy hh24:mi:ss')
                            and cargtipr = 'A'
                            and cargsign = 'DB'
                            and cargsign NOT IN ('PA','AP','SA')
                            and cargcaca NOT IN (20,23,46,50,51,56,73)
                          group by cargnuse, cargconc
                         --
                         UNION
                         -- NOTAS
                         select cargnuse, cargconc
                           from open.cargos c, open.SERVSUSC ss, open.CONCEPTO CO, open.CAUSCARG csc
                          where c.cargcaca = csc.cacacodi
                            and c.cargnuse = ss.sesunuse
                            and ss.sesuserv = 7014
                            and c.CARGCONC = CO.CONCCODI
                            --and cargconc in (19,30,291,674)
                            and c.cargfecr between to_date('01/12/2015 00:00:00','dd/mm/yyyy hh24:mi:ss')
                                               and to_date('31/12/2015 23:59:59','dd/mm/yyyy hh24:mi:ss')
                            and concclco in (4,13,17,19,22,24,27,28,36,37,81,108,109,110,111,112,113,118,169,193,291,400,401)
                            --and concclco not in (311,246,303,252,253)
                            AND CARGCUCO > 0
                            and cargtipr = 'P'
                            and cargsign NOT IN ('PA','AP')
                            AND substr(cargdoso,1,2) NOT IN ('PA','AP')
                            and cargcaca not in (20,23,46,50,51,56,73)
                            group by cargconc,cargnuse
                         )
                MINUS
                    (select product_id, concept--, 0
                       from (
                            -- Acta con Factura
                            SELECT oa.product_id, ot.concept
                              FROM OPEN.ge_detalle_acta a, OPEN.or_order_activity oa, OPEN.ge_acta ac, OPEN.or_order ro,
                                   OPEN.ic_clascott tt, OPEN.or_task_type ot, OPEN.ge_items it
                              where ac.extern_pay_date >= '01-12-2015'
                                and ac.extern_pay_date <= '31-12-2015 23:59:59'
                                and ac.extern_invoice_num is not null
                                and ac.id_acta    = a.id_acta
                                and a.id_orden    = ro.order_id
                                and ro.legalization_date >= '01-12-2015' and ro.legalization_date <= '31-12-2015 23:59:59'
                                and a.id_orden    = oa.order_id
                                and oa.order_id   = ro.order_id
                                and oa.task_type_id = ro.task_type_id
                                and a.valor_total != 0
                                and decode(oa.task_type_id, 10336, ro.real_task_type_id, oa.task_type_id) = tt.clcttitr
                                and tt.clctclco not in (311,246,303,252,253)
                                and oa.task_type_id = ot.task_type_id
                                and a.id_items = it.items_id
                                and (it.item_classif_id != 23 or it.items_id = 4001293)
                            Group by oa.product_id, ot.concept
                            --
                            UNION
                            -- Acta sin Factura
                            SELECT oa.product_id, ot.concept
                              FROM OPEN.ge_detalle_acta a, open.or_order_activity oa, open.ge_acta ac, open.or_order ro,
                                   open.ic_clascott tt, open.or_task_type ot, open.ge_items it
                             where (ac.extern_pay_date is null or ac.extern_pay_date > '31-12-2015 23:59:59')
                               and ac.id_acta   = a.id_acta
                               and a.id_orden   = oa.order_id
                               and a.valor_total != 0
                               and decode(oa.task_type_id, 10336, ro.real_task_type_id, oa.task_type_id) = tt.clcttitr
                               and oa.order_id = ro.order_id
                               and ro.legalization_date >= '01-12-2015' and ro.legalization_date <= '31-12-2015 23:59:59'
                               and oa.task_type_id = ro.task_type_id
                               and tt.clctclco not in (311,246,303,252,253)
                               and oa.task_type_id = ot.task_type_id
                               and a.id_items = it.items_id
                               and (it.item_classif_id != 23 or it.items_id = 4001293)
                            Group by oa.product_id, ot.concept
                            --
                            UNION
                            -- Ordenes legalizadas sin Acta
                            SELECT oa.product_id, ot.concept
                              FROM open.or_order_activity oa, open.or_order_items oi, open.or_order r, open.ic_clascott tt,
                                   open.or_task_type ot, open.ge_items it, OPEN.OR_OPERATING_UNIT ut
                             where r.legalization_date >= '01-12-2015' and r.legalization_date <= '31-12-2015 23:59:59'
                               and r.order_status_id = 8
                               and r.order_id = oa.order_id
                               and r.task_type_id = oa.task_type_id
                               and oa.order_id = oi.order_id
                               and value != 0
                               and decode(oa.task_type_id, 10336, r.real_task_type_id, oa.task_type_id) = tt.clcttitr
                               and tt.clctclco not in (311,246,303,252,253)
                               and oa.order_id not in (select a.id_orden from OPEN.ge_detalle_Acta a where a.id_orden = oa.order_id)
                               and oa.task_type_id = ot.task_type_id
                               and oi.items_id    = it.items_id
                               and (it.item_classif_id != 23 or it.items_id = 4001293)
                               and r.operating_unit_id = ut.operating_unit_id
                            Group by oa.product_id, ot.concept
                          )
                    --where concept in (19,30,291,674)
          ))) aa, open.concepto co, OPEN.IC_CLASCONT ic
  where aa.cargnuse = ux.cargnuse
    and aa.cargconc = ux.cargconc
    and aa.cargconc = co.conccodi
    and co.concclco = ic.clcocodi
