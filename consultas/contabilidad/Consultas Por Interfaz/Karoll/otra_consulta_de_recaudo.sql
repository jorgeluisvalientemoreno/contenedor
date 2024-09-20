SELECT moviubg2, (Select g.description from open.ge_geogra_location g where g.geograp_location_id = moviubg2) Descripcion,
       movitimo TIPOMOVI, m.timodesc,
       moviserv PRODUCTO, (select s.servdesc from open.servicio s where s.servcodi = moviserv) Desc_Serv,
      -- movicate CATEGO,  
      -- moviconc CONCEPTO, c.concdesc DESC_CONCEPTO,
       --c.concclco, (select i.clcodesc from open.ic_clascont i where i.clcocodi = c.concclco) Desc_Clasi,
       --movicaca CAUSAL, (select g.cacadesc from open.causcarg g where cacacodi = movicaca) Des_Caca,
       sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor 
  FROM open.ic_movimien, open.concepto c, open.ic_tipomovi m
 WHERE movitido = 72 
   AND movifeco >= '01/05/2015'
   AND movifeco <= '31/05/2015'
   AND moviserv in (7055, 7056)
   AND movitimo in (23, 25) 
   AND moviconc = conccodi and movitimo = m.timocodi
 GROUP BY moviubg2, moviserv, /*movicate, moviconc, c.concdesc, c.concclco,*/ movitimo, /*movicaca,*/ m.timodesc
order by moviserv, moviubg2, movitimo
