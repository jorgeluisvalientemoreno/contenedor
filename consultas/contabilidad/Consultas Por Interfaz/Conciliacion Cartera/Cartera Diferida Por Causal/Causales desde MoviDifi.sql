SELECT  sesuserv SERVICIO, 
        modicaca, (select cg.cacadesc from open.causcarg cg where cg.cacacodi = modicaca) desc_caca,
        sum(decode(modisign,'DB',modivacu, -modivacu)) Total
 FROM   open.movidife, open.servsusc
WHERE   modifech >= to_date('01/12/2015 00:00:00','dd/mm/yyyy hh24:mi:ss')
  AND   modifech <= to_date('31/12/2015 23:59:59','dd/mm/yyyy hh24:mi:ss')
  AND   modinuse = sesunuse
  AND   modivacu > 0
GROUP BY sesuserv, modicaca
