-- CARTERA CORRIENTE
-- SALDO INICIAL
select servicio, cargnuse, diferencia, 
       sum(decode(cargsign, 'PA', -1, 'AP', 1, 'SA', 1, 'AS', -1, 'CR', -1, 'DB', 1, -1) * cargvalo) tot_cargos
  from (
        SELECT servicio, caccnuse, sum(VALOR) diferencia
         FROM (SELECT  SERVICIO, caccnuse, sum(VALOR) VALOR
                 FROM (SELECT caccnuse, caccserv SERVICIO, nvl(sum(decode(caccnaca,'N',caccsape)),0) VALOR
                         FROM open.ic_cartcoco
                        WHERE caccfege = '31/03/2015'
                       GROUP BY caccserv, caccnuse)
                WHERE valor <> 0
               GROUP BY SERVICIO, caccnuse
              UNION ALL
              -- SALDO FINAL
              SELECT SERVICIO, caccnuse, sum(VALOR)
              FROM (SELECT caccnuse, caccserv SERVICIO, NVL((sum(decode(caccnaca,'N',caccsape))* -1),0) VALOR, 'SF' TIPO
                      FROM open.ic_cartcoco
                     WHERE caccfege = '30/04/2015'
                     GROUP BY caccserv, caccnuse)
               WHERE valor <> 0
               GROUP BY SERVICIO, caccnuse 
              UNION ALL
              select servicio, caccnuse, sum(valor)
                from (select sesuserv servicio, cargnuse caccnuse, 
                             sum(decode(cargsign, 'PA', -1, 'AP', 1, 'SA', 1, 'AS', -1, 'CR', -1, 'DB', 1, -1) * cargvalo) valor
                      from open.cargos, open.servsusc s
                     where cargcuco != -1
                       and cargfecr >= '01-04-2015'
                       and cargfecr <  '01-05-2015'
                       and cargsign not in (/*'NS',*/ 'TS', 'ST')
                       and cargnuse = sesunuse
                    group by sesuserv, cargnuse)
        group by servicio, caccnuse
        )
        GROUP BY SERVICIO, caccnuse
        having sum(VALOR) != 0
        order by caccnuse
     ) u, open.cargos ca, open.perifact f, open.cuencobr c, open.factura fa
 where caccnuse = cargnuse 
   and cargfecr >= '01-03-2015'
   and cargfecr <  '01-05-2015'
   and cargsign not in ('PA', 'TS', 'ST')
   and cargpefa = f.pefacodi
   and to_char(pefaffmo, 'yyyymm') > to_char(cargfecr, 'yyyymm')
   and cargcuco = c.cucocodi and c.cucofact = fa.factcodi
   and to_char(fa.factfege, 'yyyymm') > to_char(cargfecr, 'yyyymm')
group by servicio, cargnuse, diferencia
