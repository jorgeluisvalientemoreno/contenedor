SELECT rerebanc banco, b.bancnomb, to_char(rerefegr,'yyyymm') periodo, sum((rerevalo)) valor
  FROM open.resureca r, open.banco b
 WHERE rerefegr >= '&FECHA_INICIAL' and rerefegr < '&FECHA_FINAL 23:59:59'
   and rerebanc = b.banccodi
 GROUP BY rerebanc, b.bancnomb, to_char(rerefegr,'yyyymm')
order by rerebanc, to_char(rerefegr,'yyyymm')
