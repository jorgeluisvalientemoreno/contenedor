SELECT /*+ index (m IX_IC_MOVIMIEN11) */
       decode(moviplca, 'C', 'CORTO PLAZO', 'L', 'LARGO PLAZO', NULL) PLAZO,
       moviserv, c.concclco, t.clcodesc, --movisign,
       sum(decode(movisign, 'D', movivalo, -movivalo)) Total
  FROM open.ic_movimien m, open.concepto c, open.ic_clascont t
 WHERE m.movifeco =  '30-04-2024'
   and m.movitido =  76
   and m.movitimo =  59 -- Cartera por Concepto
   and m.moviconc =  c.conccodi
   and t.clcocodi =  c.concclco(+)
   --and m.moviserv = 7056
Group by m.moviserv, c.concclco, t.clcodesc, moviplca
