-- Tipo de Movimiento en Ingresos
SELECT moviserv, movitido, i.movitimo, m.timodesc, t.clcocodi, t.clcodesc, movicaca, g.cacadesc, movisign, sum(movivalo) 
  FROM open.ic_movimien I, open.ic_tipomovi m, open.concepto c, open.ic_clascont t, open.causcarg g
 WHERE movitido in (71, 73)
   AND movifeco >= '&FECHA_INICIAL'
   AND movifeco <= '&FECHA_FINAL'
   AND movitimo = timocodi
   AND moviconc = conccodi
   AND concclco = clcocodi AND movicaca = g.cacacodi
group by moviserv, movitido, i.movitimo, m.timodesc, t.clcocodi, t.clcodesc, movicaca, g.cacadesc, movisign
order by moviserv, movitido, movitimo
