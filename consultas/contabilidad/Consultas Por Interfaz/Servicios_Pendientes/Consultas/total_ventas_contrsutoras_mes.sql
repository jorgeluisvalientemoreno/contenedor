-- VENTAS CONSTRUCTORAS MES
select cargnuse, cargconc, sum(decode(cargsign, 'DB',cargvalo,'AS', cargvalo, cargvalo*-1)) valor, cargfecr, FACTFEGE
 from open.cargos c, OPEN.CUENCOBR, OPEN.FACTURA, open.servsusc ss
where cargnuse = sesunuse 
  and sesuserv = 6121 --7014
  and cargconc in (19,30,674)
  and CARGCUCO = CUCOCODI      
  and factcodi = CUCOfact
  and FACTFEGE BETWEEN to_date('01/05/2015 00:00:00','dd/mm/yyyy hh24:mi:ss')     
                   and to_date('31/05/2015 23:59:59','dd/mm/yyyy hh24:mi:ss')    
  and cargtipr = 'A'    
  and cargsign NOT IN ('PA','AP','SA') 
  and cargcaca in (41,53) -- NOT IN (20,23,46,50,51,56,73)
  and cargsign = 'DB'
group by cargnuse, cargfecr, FACTFEGE, cargconc
