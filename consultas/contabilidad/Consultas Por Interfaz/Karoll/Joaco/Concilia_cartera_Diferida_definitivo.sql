-- CARTERA DIFERIDA
-- SALDO INICIAL
SELECT caccserv SERVICIO, null causal, null desc_caca, null concepto, null desc_conc, 
       nvl(sum(decode(caccnaca,'F',caccsape)),0) VALOR, '1_SALDO_INICIAL' TIPO
  FROM open.ic_cartcoco
 WHERE caccfege = '31/07/2015'
   and caccserv = 7056
 GROUP BY caccserv, null, null, null, null
UNION
-- SALDO FINAL
SELECT caccserv SERVICIO, null causal, null desc_caca, null concepto, null desc_conc,
       NVL((sum(decode(caccnaca,'F',caccsape))* -1),0) VALOR, '3_SALDO_FINAL' TIPO
  FROM open.ic_cartcoco
 WHERE caccfege = '31/08/2015'
   and caccserv = 7056 
 GROUP BY caccserv, null, null, null, null
UNION
-- MOVIMIENTO DIFERIDOS
SELECT SERVICIO, modicaca, desc_caca, difeconc, desc_conc, (DB - CR) VALOR, '2_MOVIMIENTO_DIFERIDO' TIPO
  FROM (
        SELECT sesuserv SERVICIO, md.modicaca, (select cacadesc from open.causcarg cg where cg.cacacodi = md.modicaca) desc_caca,
               d.difeconc, (select c.concdesc from open.concepto c where c.conccodi = difeconc) desc_conc,
               nvl(sum(decode(modisign,'DB',modivacu)),0) DB,
               nvl(sum(decode(modisign,'CR',modivacu)),0) CR
          FROM open.movidife md, open.servsusc, open.diferido d
         WHERE modifeca >= to_date('01/08/2015 00:00:00','dd/mm/yyyy hh24:mi:ss')
           AND modifeca <= to_date('31/08/2015 23:59:59','dd/mm/yyyy hh24:mi:ss')
           AND modinuse =  sesunuse
           AND sesuserv =  7056
           and md.modidife = d.difecodi
           AND modivacu > 0
        GROUP BY sesuserv, d.difeconc, modicaca
       );
