(SELECT SERVICIO, caccnuse, sum(VALOR)
 FROM (SELECT  SERVICIO, caccnuse, sum(VALOR) VALOR, '1_SI' TIPO
FROM (SELECT caccnuse, caccserv SERVICIO, nvl(sum(decode(caccnaca,'N',caccsape)),0) VALOR
        FROM open.ic_cartcoco
       WHERE caccfege = '31/03/2015'
         and caccserv = 7014
       GROUP BY caccserv, caccnuse)
 WHERE valor <> 0
GROUP BY SERVICIO, caccnuse
UNION ALL
SELECT SERVICIO, caccnuse, sum(VALOR), '3_SF' TIPO
FROM (SELECT caccnuse, caccserv SERVICIO, NVL((sum(decode(caccnaca,'N',caccsape))* -1),0) VALOR, 'SF' TIPO
        FROM open.ic_cartcoco
       WHERE caccfege = '26/04/2015'
         and caccserv = 7014
       GROUP BY caccserv, caccnuse )
 WHERE valor <> 0
 GROUP BY SERVICIO, caccnuse 
UNION ALL
select servicio, caccnuse, sum(valor), '2_CARG' TIPO
from (select sesuserv servicio, cargnuse caccnuse, 
             sum(decode(cargsign, 'PA', -1, 'AP', 1, 'SA', 1, 'AS', -1, 'CR', -1, 'DB', 1, -1) * cargvalo) valor
        from open.cargos, open.servsusc s
       where cargcuco != -1
         and cargfecr >= '01-04-2015'
         and cargfecr <  '27-04-2015'
         and cargsign not in (/*'NS',*/ 'TS', 'ST')
         and cargnuse = sesunuse
         and sesuserv = 7014
      group by sesuserv, cargnuse)
group by servicio, caccnuse
)
GROUP BY SERVICIO, /*TIPO,*/ caccnuse
having sum(VALOR) != 0
order by caccnuse)


