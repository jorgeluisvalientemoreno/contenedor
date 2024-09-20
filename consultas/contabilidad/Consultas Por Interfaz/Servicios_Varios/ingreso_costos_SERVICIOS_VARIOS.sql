SELECT CARGnuse, a.id_acta acta, id_orden orden, task_type_id titr, sum(a.valor_total) Vr_Costo, Valor Ingreso
  FROM OPEN.ge_detalle_acta a, open.or_order_activity o, open.mo_packages m, open.ge_acta g,
       (select cargnuse, sum(valor) valor
          from (
                 select cargnuse, 
                         sum(decode(cargsign, 'PA', -1, 'AP', 1, 'SA', 1, 'AS', -1, 'CR', -1, 'DB', 1, -1) * cargvalo) valor
                   from open.cargos c, open.SERVSUSC ss, open.CONCEPTO CO,    
                       open.CAUSCARG csc, open.procesos, open.ic_clascont i, open.perifact    
                  where c.cargcaca = csc.cacacodi    
                    and c.cargnuse = ss.sesunuse  
                    --and cargnuse = 1061280  
                    and c.CARGCONC = CO.CONCCODI
                    and co.concclco in (27,28,69,81,98,118)
                    and c.cargfecr between to_date(to_char('01/05/2015 00:00:00'),'dd/mm/yyyy hh24:mi:ss')    
                                       AND to_date(to_char('31/05/2015 23:59:59'),'dd/mm/yyyy hh24:mi:ss')    
                    and cargprog = proccons    
                    and clcocodi(+) = concclco    
                    and cargpefa = pefacodi    
                    AND CARGCUCO > 0    
                    and cargtipr = 'P'  
                    and cargsign not in (/*'NS',*/ 'TS', 'ST', 'DV') -- DV = devolucion saldo a favor
                  group by cargnuse
                  union all    
                  select cargnuse,
                         sum(decode(cargsign, 'PA', -1, 'AP', 1, 'SA', 1, 'AS', -1, 'CR', -1, 'DB', 1, -1) * cargvalo) valor
                  from open.cargos c, OPEN.CUENCOBR, OPEN.FACTURA, open.CONCEPTO CO, open.CAUSCARG csc,    
                       open.procesos, open.ic_clascont, open.perifact, OPEN.SERVSUSC ss    
                  where c.cargcaca = csc.cacacodi    
                    and c.CARGCONC = CO.CONCCODI    
                    and c.cargnuse = ss.sesunuse  
                    --and cargnuse = 1061280  
                    --and sesuserv   = 7056
                    AND factcodi   = CUCOfact    
                    AND CARGCUCO   = CUCOCODI    
                    and clcocodi(+) = concclco    
                    and cargpefa   = pefacodi    
                    AND FACTFEGE BETWEEN to_date('01/05/2015 00:00:00','dd/mm/yyyy hh24:mi:ss')     
                                     and to_date('31/05/2015 23:59:59','dd/mm/yyyy hh24:mi:ss')    
                    and co.concclco in (27,28,69,81,98,118)
                    and cargprog = proccons    
                    and cargtipr = 'A'    
                    and cargsign not in (/*'NS',*/ 'TS', 'ST', 'DV')
                  group by cargnuse
               )
            group by cargnuse
       )
 where cargnuse =  o.product_id
   and o.package_id = m.package_id
   and o.order_id = a.id_orden
   and a.valor_total != 0
   and a.id_acta  = g.id_acta
   and ((g.extern_pay_date >= '01-05-2015' and g.extern_pay_date < '01-06-2015') OR g.extern_pay_date is null) 
group by cargnuse, a.id_acta, id_orden, task_type_id, Valor
UNION ALL
SELECT cargnuse, 0 acta, o.order_id orden, task_type_id titr, sum(value) Total, valor Ingreso
  FROM open.or_order_activity o, open.mo_packages m, open.or_order_items i,
       (select cargnuse, sum(valor) valor
          from (
                 select cargnuse, 
                         sum(decode(cargsign, 'PA', -1, 'AP', 1, 'SA', 1, 'AS', -1, 'CR', -1, 'DB', 1, -1) * cargvalo) valor
                   from open.cargos c, open.SERVSUSC ss, open.CONCEPTO CO,    
                       open.CAUSCARG csc, open.procesos, open.ic_clascont i, open.perifact    
                  where c.cargcaca = csc.cacacodi    
                    and c.cargnuse = ss.sesunuse  
                    --and cargnuse = 1061280  
                    and c.CARGCONC = CO.CONCCODI
                    and co.concclco in (27,28,69,81,98,118)
                    and c.cargfecr between to_date(to_char('01/05/2015 00:00:00'),'dd/mm/yyyy hh24:mi:ss')    
                                       AND to_date(to_char('31/05/2015 23:59:59'),'dd/mm/yyyy hh24:mi:ss')    
                    and cargprog = proccons    
                    and clcocodi(+) = concclco    
                    and cargpefa = pefacodi    
                    AND CARGCUCO > 0    
                    and cargtipr = 'P'  
                    and cargsign not in (/*'NS',*/ 'TS', 'ST', 'DV') -- DV = devolucion saldo a favor
                  group by cargnuse
                  union all    
                  select cargnuse,
                         sum(decode(cargsign, 'PA', -1, 'AP', 1, 'SA', 1, 'AS', -1, 'CR', -1, 'DB', 1, -1) * cargvalo) valor
                  from open.cargos c, OPEN.CUENCOBR, OPEN.FACTURA, open.CONCEPTO CO, open.CAUSCARG csc,    
                       open.procesos, open.ic_clascont, open.perifact, OPEN.SERVSUSC ss    
                  where c.cargcaca = csc.cacacodi    
                    and c.CARGCONC = CO.CONCCODI    
                    and c.cargnuse = ss.sesunuse  
                    AND factcodi   = CUCOfact    
                    AND CARGCUCO   = CUCOCODI    
                    and clcocodi(+) = concclco    
                    and cargpefa   = pefacodi    
                    AND FACTFEGE BETWEEN to_date('01/05/2015 00:00:00','dd/mm/yyyy hh24:mi:ss')     
                                     and to_date('31/05/2015 23:59:59','dd/mm/yyyy hh24:mi:ss')    
                    and co.concclco in (27,28,69,81,98,118)
                    and cargprog = proccons    
                    and cargtipr = 'A'    
                    and cargsign not in (/*'NS',*/ 'TS', 'ST', 'DV')
                  group by cargnuse
               )
            group by cargnuse
       )  
 where cargnuse =  o.product_id
   and o.package_id = m.package_id
   and o.order_id = i.order_id
   and value != 0
   and o.order_id not in (select a.id_orden from OPEN.ge_detalle_Acta a where a.id_orden = o.order_id)
group by cargnuse, o.order_id, task_type_id, valor
order by cargnuse, titr, orden
