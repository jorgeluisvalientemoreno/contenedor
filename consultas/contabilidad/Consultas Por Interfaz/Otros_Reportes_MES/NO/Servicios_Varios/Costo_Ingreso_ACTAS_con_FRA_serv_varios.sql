-- Costo con ACTA-FACTURA
SELECT o.product_id, sum(a.valor_total) Vr_Costo,
       (select sum(valor) valor
          from (
                 select cargnuse, sum(valor) valor  
                  from (  
                        select cargnuse, sum(decode(cargsign, 'DB',cargvalo,'AS', cargvalo, 'TS', cargvalo, 'DV', cargvalo, cargvalo*-1)) valor
                        from open.cargos c,open.SERVSUSC ss, open.CONCEPTO CO,  
                             open.CAUSCARG csc, open.procesos, open.ic_clascont, open.perifact  
                        where c.cargcaca = csc.cacacodi  
                          and c.cargnuse = ss.sesunuse  
                          and c.CARGCONC = CO.CONCCODI  
                          AND CONCCLCO in (27,28,69,81,98,118)
                          and c.cargfecr between to_date(to_char('01/05/2015 00:00:00'),'dd/mm/yyyy hh24:mi:ss')  
                                             AND to_date(to_char('31/05/2015 23:59:59'),'dd/mm/yyyy hh24:mi:ss')  
                          and cargprog = proccons  
                          and clcocodi(+) = concclco  
                          and cargpefa = pefacodi  
                          AND CARGCUCO > 0  
                          and cargtipr = 'P'  
                          and cargsign NOT IN ('PA','AP')  
                          AND substr(cargdoso,1,2) NOT IN ('PA','AP')  
                          and cargcaca NOT IN (2,20,23,46,50,51,56,58,73)
                        group by  cargnuse 
                        union all  
                        select cargnuse, sum(decode(cargsign, 'DB',cargvalo,'AS', cargvalo, cargvalo*-1)) valor
                         from open.cargos c, OPEN.CUENCOBR, OPEN.FACTURA, open.CONCEPTO CO, open.CAUSCARG csc,  
                              open.procesos,open.ic_clascont, open.perifact, OPEN.SERVSUSC ss  
                        where c.cargcaca = csc.cacacodi  
                          and c.CARGCONC = CO.CONCCODI  
                          AND CONCCLCO in (27,28,69,81,98,118)
                          and c.cargnuse = ss.sesunuse  
                          AND factcodi = CUCOfact  
                          AND CARGCUCO = CUCOCODI  
                          and clcocodi(+) = concclco  
                          and cargpefa = pefacodi  
                          AND FACTFEGE BETWEEN to_date('01/05/2015 00:00:00','dd/mm/yyyy hh24:mi:ss')   
                                           and to_date('31/05/2015 23:59:59','dd/mm/yyyy hh24:mi:ss')  
                          and cargprog = proccons  
                          and cargtipr = 'A'  
                          and cargsign NOT IN ('PA','AP')  
                          and cargcaca NOT IN (2,20,23,46,50,51,56,58,73)
                        group by cargnuse
                       )   
                group by cargnuse
               )
            where cargnuse = o.product_id
       ) INgreso
/*a.id_acta acta, id_orden orden, o.task_type_id titr,*/ 

  FROM OPEN.ge_detalle_acta a, open.or_order_activity o, open.mo_packages m, open.ge_acta g, 
       open.or_order r, open.ic_clascott tt
 where o.package_id   =  m.package_id
   and o.order_id     =  a.id_orden
   and o.task_type_id =  tt.clcttitr
   and tt.clctclco    in (259,308,309)
   and a.valor_total  != 0
   and a.id_acta      =  g.id_acta
   and o.order_id     =  r.order_id
   and g.extern_pay_date >= '01-05-2015' 
   and g.extern_pay_date <  '01-06-2015'
group by o.product_id, a.id_acta, id_orden, o.task_type_id
