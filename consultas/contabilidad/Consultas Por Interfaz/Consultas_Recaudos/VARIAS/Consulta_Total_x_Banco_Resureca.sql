SELECT rerefegr fecha, rerebanc banco, b.bancnomb, t.clcodesc, sum(rerevalo) valor
  FROM open.resureca r, open.banco b, open.ic_clascont t
 WHERE rerefegr >= '&FECHA_INICIAL' and rerefegr < '&FECHA_FINAL' and r.rerebanc = b.banccodi
   and b.bancclco = t.clcocodi
GROUP BY rerefegr, rerebanc, b.bancnomb, t.clcodesc
