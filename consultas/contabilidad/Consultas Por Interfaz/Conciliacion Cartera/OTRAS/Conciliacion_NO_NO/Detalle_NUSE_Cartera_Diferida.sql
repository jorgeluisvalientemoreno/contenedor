-- SALDO INICIAL
SELECT caccnuse PRODUCTO, caccserv SERVICIO, nvl(sum(decode(caccnaca,'F',caccsape)),0) VALOR, 'SI' TIPO
  FROM open.ic_cartcoco
 WHERE caccfege = '08/02/2015'
   AND caccnuse = 2059652
 GROUP BY caccnuse, caccserv
UNION
-- SALDO FINAL
SELECT caccnuse PRODUCTO, caccserv SERVICIO, NVL((sum(decode(caccnaca,'F',caccsape))* -1),0) VALOR, 'SF' TIPO
  FROM open.ic_cartcoco
 WHERE caccfege = '28/02/2015'
   AND caccnuse = 2059652 
 GROUP BY caccnuse, caccserv
UNION
-- MOVIMIENTO DIFERIDOS
SELECT PRODUCTO, SERVICIO, (DB - CR) VALOR, 'MD' TIPO
  FROM (
        SELECT  sesunuse PRODUCTO, sesuserv SERVICIO, nvl(sum(decode(modisign,'DB',modivacu)),0) DB,
                nvl(sum(decode(modisign,'CR',modivacu)),0) CR
        FROM    open.movidife, open.servsusc
        WHERE   modifech > to_date('09/02/2015 00:00:00','dd/mm/yyyy hh24:mi:ss')
                AND modifech <= to_date('28/02/2015 23:59:59','dd/mm/yyyy hh24:mi:ss')
                AND modinuse = sesunuse
                AND modinuse = 2059652
                AND modivacu > 0
        GROUP BY sesunuse, sesuserv
);