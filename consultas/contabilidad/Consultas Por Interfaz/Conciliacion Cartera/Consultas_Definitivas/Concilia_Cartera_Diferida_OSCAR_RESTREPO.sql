-- OSCAR RESTREPO
-- movimiento diferido mes
SELECT  sesuserv, sum(decode(modisign,'DB',modivacu)) DB , sum(decode(modisign,'CR',modivacu)) CR 
FROM    open.movidife, open.servsusc 
WHERE   modifech > to_date('01/04/2015 00:00:00','dd/mm/yyyy hh24:mi:ss') 
        AND modifech <= to_date('30/04/2015 23:59:59','dd/mm/yyyy hh24:mi:ss') 
        AND modinuse = sesunuse 
        AND modivacu > 0 
GROUP BY sesuserv;
-- MOVIMIENTO DIFERIDOS
SELECT /*PRODUCTO,*/ SERVICIO, (DB - CR) VALOR, '2_MD' TIPO
  FROM (
        SELECT  sesuserv SERVICIO, nvl(sum(decode(modisign,'DB',modivacu)),0) DB,
                nvl(sum(decode(modisign,'CR',modivacu)),0) CR
        FROM    open.movidife, open.servsusc
        WHERE   modifech > to_date('01/04/2015 00:00:00','dd/mm/yyyy hh24:mi:ss')
                AND modifech <= to_date('30/04/2015 23:59:59','dd/mm/yyyy hh24:mi:ss')
                AND modinuse = sesunuse
                AND modivacu > 0
       GROUP BY sesuserv
);
