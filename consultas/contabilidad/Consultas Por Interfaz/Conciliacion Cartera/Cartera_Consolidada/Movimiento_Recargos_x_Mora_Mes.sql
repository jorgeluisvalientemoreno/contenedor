/* valida un usuaio */
select c.*
  from open.cargos c, OPEN.CUENCOBR, OPEN.FACTURA, open.CAUSCARG csc, OPEN.SERVSUSC ss, open.concepto o
 where c.cargcaca = csc.cacacodi
   and c.cargnuse = ss.sesunuse
   --and cargnuse   = 17238232
   AND factcodi   = CUCOfact
   AND CARGCUCO   = CUCOCODI
   --and cargcaca  in (50)
   and cargconc   = conccodi
   AND FACTFEGE BETWEEN '01-03-2017 00:00:00'
                    AND '30-04-2017 23:59:59'
   and cargtipr = 'A'
   and cargsign NOT IN ('PA','AP')
   and substr(cargdoso,1,3) in 'RMF'
