SELECT decode(moviplca, 'C', 'CORTO PLAZO', 'L', 'LARGO PLAZO', NULL) PLAZO,
       moviserv, c.concclco, t.clcodesc, --movisign,
       sum(decode(movisign, 'D', movivalo, -movivalo)) Total
  FROM open.ic_movimien m, open.concepto c, open.ic_clascont t
 WHERE m.movifeco =  '31-05-2020'
   and m.movitido =  76
   and m.moviconc is not null
   and m.moviconc =  c.conccodi
   and t.clcocodi =  c.concclco(+)
   --and m.moviserv = 7056
Group by m.moviserv, c.concclco, t.clcodesc, moviplca