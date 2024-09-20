-- Pagos vs Pagos Eliminados vs Resumen de Recaudo por día por entidad
SELECT pagobanc banco, trunc(pagofegr) fecha, SUM(pagovapa) valor, 'P' tipo
  FROM open.pagos 
 WHERE trunc(pagofegr) >= '&FECHA_INICIAL' and trunc(pagofegr) < '&FECHA_FINAL'
 GROUP BY pagobanc, trunc(pagofegr)
UNION 
SELECT pagobanc banco, paanfech fecha, (SUM(pagovapa)*-1) valor, 'PE' tipo
  FROM open.rc_pagoanul a, open.pagos p
 WHERE a.paancupo = p.pagocupo
   AND paanfech >= '&FECHA_INICIAL' and paanfech < '&FECHA_FINAL'
 GROUP BY pagobanc, paanfech
UNION 
SELECT rerebanc banco, rerefegr fecha, sum(rerevalo) valor, 'RR' Tipo
  FROM open.resureca 
 WHERE rerefegr >= '&FECHA_INICIAL' and rerefegr < '&FECHA_FINAL'
GROUP BY rerebanc, rerefegr, rerefepa; 
