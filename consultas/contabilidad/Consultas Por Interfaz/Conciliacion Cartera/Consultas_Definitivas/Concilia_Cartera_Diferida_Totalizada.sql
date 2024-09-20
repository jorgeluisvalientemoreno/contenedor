-- CARTERA DIFERIDA
-- SALDO INICIAL
SELECT /*caccnuse PRODUCTO,*/ caccserv SERVICIO, nvl(sum(decode(caccnaca,'F',caccsape)),0) VALOR, '1_SI' TIPO
  FROM open.ic_cartcoco
 WHERE caccfege = '31/10/2016'
 GROUP BY /*caccnuse,*/ caccserv
UNION
-- SALDO FINAL
SELECT /*caccnuse PRODUCTO,*/ caccserv SERVICIO, NVL((sum(decode(caccnaca,'F',caccsape))* -1),0) VALOR, '3_SF' TIPO
  FROM open.ic_cartcoco
 WHERE caccfege = '30/11/2016'
 GROUP BY /*caccnuse,*/ caccserv
UNION
-- MOVIMIENTO DIFERIDOS
SELECT /*PRODUCTO,*/ SERVICIO, (DB - CR) VALOR, '2_MD' TIPO
  FROM (
        SELECT  /*sesunuse PRODUCTO,*/ sesuserv SERVICIO, nvl(sum(decode(modisign,'DB',modivacu)),0) DB,
                nvl(sum(decode(modisign,'CR',modivacu)),0) CR
        FROM    open.movidife, open.servsusc
        WHERE   modifech >= to_date('01/11/2016 00:00:00','dd/mm/yyyy hh24:mi:ss')
          AND   modifech <= to_date('30/11/2016 23:59:59','dd/mm/yyyy hh24:mi:ss')
          AND   modinuse = sesunuse
          AND   modivacu > 0
        GROUP BY /*sesunuse,*/ sesuserv
);
