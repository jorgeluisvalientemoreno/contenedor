SELECT caccnuse PRODUCTO, caccserv SERVICIO, /*caccconc CONCEPTO, (SELECT concdesc FROM open.concepto WHERE conccodi = caccconc) DESC_CONCEPTO,*/
       nvl(sum(decode(caccnaca,'F',caccsape)),0) VALOR, 'SI' TIPO
  FROM open.ic_cartcoco
 WHERE caccfege = '&FECHA_SALDO_INICIAL'
   and caccserv = 7014
 GROUP BY caccnuse, caccserv--, caccconc
UNION ALL
SELECT caccnuse PRODUCTO, caccserv SERVICIO, /*caccconc CONCEPTO, (SELECT concdesc FROM open.concepto WHERE conccodi = caccconc) DESC_CONCEPTO,*/
       NVL((sum(decode(caccnaca,'F',caccsape))* -1),0) VALOR, 'SF' TIPO
  FROM open.ic_cartcoco
 WHERE caccfege = '&FECHA_SALDO_FINAL'
   and caccserv = 7014
 GROUP BY caccnuse, caccserv--, caccconc
UNION ALL
SELECT PRODUCTO, SERVICIO, /*CONCEPTO, DESC_CONCEPTO,*/ (DB - CR) VALOR, 'MD' TIPO
  FROM (
        SELECT  sesunuse PRODUCTO, sesuserv SERVICIO, /*difeconc CONCEPTO, (SELECT concdesc FROM open.concepto WHERE conccodi = difeconc) DESC_CONCEPTO, */
                nvl(sum(decode(modisign,'DB',modivacu)),0) DB,
                nvl(sum(decode(modisign,'CR',modivacu)),0) CR
        FROM    open.movidife, open.servsusc, open.diferido
        WHERE   modifech > to_date('&FECHA_INICIAL_MOVIMIENTOS'||' 00:00:00','dd/mm/yyyy hh24:mi:ss')
                AND modifech <= to_date('&FECHA_FINAL_MOVIMIENTOS'||' 23:59:59','dd/mm/yyyy hh24:mi:ss')
                AND modinuse = sesunuse
                AND modivacu > 0
                AND modidife = difecodi
                AND sesuserv = 7014
        GROUP BY sesunuse, sesuserv--, difeconc
       )
