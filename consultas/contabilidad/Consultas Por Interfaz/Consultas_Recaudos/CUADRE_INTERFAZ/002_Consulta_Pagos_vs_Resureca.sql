-- Pagos vs Pagos Eliminados vs Resumen de Recaudo por día por entidad -- open.banco
SELECT pagobanc banco, trunc(pagofegr) fecha, SUM(pagovapa) valor, 'P' tipo
  FROM open.pagos p
 WHERE trunc(pagofegr) >= '&FECHA_INICIAL' and trunc(pagofegr) < '&FECHA_FINAL 23:59:59'
GROUP BY pagobanc, trunc(pagofegr)
UNION 
SELECT pagobanc banco, paanfech fecha, (SUM(pagovapa)*-1) valor, 'PE' tipo
  FROM open.rc_pagoanul a, open.pagos p
 WHERE a.paancupo = p.pagocupo
   AND paanfech >= '&FECHA_INICIAL' and paanfech < '&FECHA_FINAL 23:59:59'
GROUP BY pagobanc, paanfech
UNION 
SELECT rerebanc banco, rerefegr fecha, sum((rerevalo)*-1) valor, 'RR' Tipo
  FROM open.resureca r
 WHERE rerefegr >= '&FECHA_INICIAL' and rerefegr < '&FECHA_FINAL 23:59:59'
GROUP BY rerebanc, rerefegr
