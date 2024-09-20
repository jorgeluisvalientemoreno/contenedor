SELECT /*+ index ( m IX_IC_MOVIMIEN11)*/
       moviserv,/* movifeco, moviconc, c.concdesc,*/ c.concclco, t.clcodesc, --movisign, 
       sum(decode(movisign, 'D', movivalo, -movivalo)) Total
  FROM open.ic_movimien m, open.concepto c, open.ic_clascont t
 WHERE m.movifeco >= '&FECHA_INICIAL' 
   and movifeco   <= '&FECHA_FINAL'
   and m.movitido = 72
   and m.movitimo in (23,25)
   and m.moviconc is not null
   and m.moviconc = c.conccodi
   and t.clcocodi = c.concclco
   and m.moviserv = 7056
Group by m.moviserv,/* movifeco, moviconc, c.concdesc,*/ c.concclco, t.clcodesc 
