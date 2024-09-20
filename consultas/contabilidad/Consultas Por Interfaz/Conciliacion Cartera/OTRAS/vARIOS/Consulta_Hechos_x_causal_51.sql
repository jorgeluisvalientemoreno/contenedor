select movicaca, moviconc, o.concdesc, o.concclco, t.clcodesc, movisign, sum(movivalo) 
       -- sum(decode(movisign, 'D', movivalo, -movivalo)) total
  from open.ic_movimien m, open.concepto o, open.ic_clascont t
 where m.movitido IN (71, 73)
   and movicaca IN (/*20,23,46,47,50,*/51)
   and movifeco >= '09-02-2015' and movifeco < '01-03-2015'
   and moviconc = conccodi and o.concclco = t.clcocodi
group by movicaca, moviconc, o.concdesc, o.concclco, t.clcodesc, movisign
