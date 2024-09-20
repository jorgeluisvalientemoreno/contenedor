-- Total Bancos desde Bancos
select /*u.fecha,*/ u.banco, i.clcodesc, sum(u.valor)
from open.banco b, open.ic_clascont i,
     (   SELECT pagobanc banco, /*trunc(pagofegr) fecha,*/ SUM(pagovapa) valor--, 'P' tipo
          FROM open.pagos 
         WHERE trunc(pagofegr) >= '&FECHA_INICIAL' and trunc(pagofegr) < '&FECHA_FINAL 23:59:59'
         GROUP BY pagobanc--, trunc(pagofegr)
        UNION 
        SELECT pagobanc banco, /*paanfech fecha,*/ (SUM(pagovapa)*-1) valor--, 'PE' tipo
          FROM open.rc_pagoanul a, open.pagos p
         WHERE a.paancupo = p.pagocupo
           AND paanfech >= '&FECHA_INICIAL' and paanfech < '&FECHA_FINAL 23:59:59'
         GROUP BY pagobanc--, paanfech
      ) u
 where banco = b.banccodi and b.bancclco = i.clcocodi 
group by u.banco, i.clcodesc
