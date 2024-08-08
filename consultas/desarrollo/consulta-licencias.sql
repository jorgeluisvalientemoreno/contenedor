SELECT /*+ ordered */

       sesuserv "ID SERVICIO",

       servdesc "SERVICIO",

       servtise "ID TIPO SERVICIO",

       tisedesc "TIPO SERVICIO",

       SUM(DECODE(coecfact,'S',1,0)) "FACTURABLES",

       SUM(DECODE(coecfact,'N',1,0)) "NO FACTURABLES",

       decode(id,null,' ','EXCLUIDOS') "EXCLUIDO?"

  FROM ((SELECT servcodi,

                servdesc,

                servtise

           FROM open.servicio)

       ) srvs,

       open.servsusc,

       open.confesco,

       open.tiposerv,

       open.exclusiontable

 WHERE sesuserv = srvs.servcodi

   AND coecserv = srvs.servcodi

   AND coeccodi = sesuesco

   AND tisecodi = servtise

   AND srvs.servcodi = id (+)

 GROUP BY id, sesuserv, servdesc, servtise, tisedesc

 ORDER BY sesuserv;