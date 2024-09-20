-- Conceptos sin Clasificador
SELECT movibanc, b.bancnomb, I.MOVICONC, c.concdesc
  FROM open.ic_movimien I, open.banco b, open.concepto c
 WHERE movitido = 72
   AND movifeco >= '&FECHA_INICIAL'
   AND movifeco <= '&FECHA_FINAL'
   and moviconc =  c.conccodi
   AND concclco IS  NULL
   AND movibanc = b.banccodi
