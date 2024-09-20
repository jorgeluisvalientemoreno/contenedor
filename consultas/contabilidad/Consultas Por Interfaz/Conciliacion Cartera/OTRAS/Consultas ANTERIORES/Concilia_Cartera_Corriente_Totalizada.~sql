-- CARTERA CORRIENTE
-- SALDO INICIAL
SELECT SERVICIO, sum(VALOR), TIPO
 FROM (
SELECT  SERVICIO, sum(VALOR) VALOR, '1_SI' TIPO
FROM (
SELECT caccserv SERVICIO, nvl(sum(decode(caccnaca,'N',caccsape)),0) VALOR
  FROM open.ic_cartcoco
 WHERE caccfege = '30/04/2015'
   --and caccserv = 6121
 GROUP BY caccserv
 )
 WHERE valor <> 0
GROUP BY SERVICIO
UNION ALL
-- SALDO FINAL
SELECT SERVICIO, sum(VALOR), '3_SF' TIPO
FROM (
SELECT  caccserv SERVICIO, NVL((sum(decode(caccnaca,'N',caccsape))* -1),0) VALOR, 'SF' TIPO
  FROM open.ic_cartcoco
 WHERE caccfege = '31/05/2015'
   --and caccserv = 6121
 GROUP BY caccserv
 )
 WHERE valor <> 0
 GROUP BY SERVICIO
UNION ALL
select sesuserv servicio, sum(valor), '2_CARG' TIPO
  from (    
          select sesuserv, 
                 sum(decode(cargsign, 'PA', -1, 'AP', 1, 'SA', 1, 'AS', -1, 'CR', -1, 'DB', 1, -1) * cargvalo) valor
                 --sum(decode(cargsign, 'DB',cargvalo,'AS', cargvalo, 'TS', cargvalo, 'DV', cargvalo, cargvalo*-1)) valor
          from open.cargos c, open.SERVSUSC ss, open.CONCEPTO CO,    
               open.CAUSCARG csc, open.procesos, open.ic_clascont, open.perifact    
          where c.cargcaca = csc.cacacodi    
            and c.cargnuse = ss.sesunuse    
            --and sesuserv = 6121
            and c.CARGCONC = CO.CONCCODI    
            and c.cargfecr between to_date(to_char('01/05/2015 00:00:00'),'dd/mm/yyyy hh24:mi:ss')    
                               AND to_date(to_char('31/05/2015 23:59:59'),'dd/mm/yyyy hh24:mi:ss')    
            and cargprog = proccons    
            and clcocodi(+) = concclco    
            and cargpefa = pefacodi    
            AND CARGCUCO > 0    
            and cargtipr = 'P'  
            and cargsign not in (/*'NS',*/ 'TS', 'ST')
            --and cargsign NOT IN ('PA','AP')    
            --AND substr(cargdoso,1,2) NOT IN ('PA','AP')    
          group by sesuserv  
          union all    
          select sesuserv,
                 sum(decode(cargsign, 'PA', -1, 'AP', 1, 'SA', 1, 'AS', -1, 'CR', -1, 'DB', 1, -1) * cargvalo) valor
                 --sum(decode(cargsign, 'DB',cargvalo,'AS', cargvalo, cargvalo*-1)) valor    
          from open.cargos c,    
               OPEN.CUENCOBR,    
               OPEN.FACTURA,    
               open.CONCEPTO CO,    
               open.CAUSCARG csc,    
               open.procesos,    
               open.ic_clascont, open.perifact, OPEN.SERVSUSC ss    
          where c.cargcaca = csc.cacacodi    
            and c.CARGCONC = CO.CONCCODI    
            and c.cargnuse = ss.sesunuse    
            --and sesuserv   = 6121
            AND factcodi   = CUCOfact    
            AND CARGCUCO   = CUCOCODI    
            and clcocodi(+) = concclco    
            and cargpefa   = pefacodi    
            AND FACTFEGE BETWEEN to_date('01/05/2015 00:00:00','dd/mm/yyyy hh24:mi:ss')     
            and to_date('31/05/2015 23:59:59','dd/mm/yyyy hh24:mi:ss')    
            and cargprog = proccons    
            and cargtipr = 'A'    
            and cargsign not in (/*'NS',*/ 'TS', 'ST')
            --and cargsign NOT IN ('PA','AP')    
          group by sesuserv
)    
group by sesuserv
)
GROUP BY SERVICIO, TIPO
--having sum(VALOR) != 0
--order by caccnuse


