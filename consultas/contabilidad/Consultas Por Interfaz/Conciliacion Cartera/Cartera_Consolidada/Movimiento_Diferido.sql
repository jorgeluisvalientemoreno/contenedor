-- MOVIMIENTO DIFERIDOS
SELECT 'DIFERIDA' CARTERA, '02_Mvto Diferido' Movimiento, SERVICIO, modicaca, desc_caca, conccodi, concdesc,
       concclco, (select t.clcodesc concdesc from open.ic_clascont t where t.clcocodi = concclco) desc_clasificador,
       (DB - CR) VALOR, '2_Mvto_Mes' TIPO
  FROM (
        SELECT  sesuserv SERVICIO,
                modicaca, (select g.cacadesc from open.causcarg g where g.cacacodi = modicaca) desc_caca,
                o.conccodi, concdesc, o.concclco, nvl(sum(decode(modisign,'DB',modivacu)),0) DB,
                nvl(sum(decode(modisign,'CR',modivacu)),0) CR
         FROM   open.movidife, open.servsusc, open.diferido d, open.concepto o
        WHERE   modifech >= to_date('01/02/2017 00:00:00','dd/mm/yyyy hh24:mi:ss')
          AND   modifech <= to_date('28/02/2017 23:59:59','dd/mm/yyyy hh24:mi:ss')
          AND   modinuse = sesunuse
          AND   modivacu > 0
          AND   modidife = d.difecodi
          AND   d.difeconc = o.conccodi
        GROUP BY sesuserv, o.conccodi, o.concclco, concdesc, modicaca
       )
