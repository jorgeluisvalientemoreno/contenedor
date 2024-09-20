-- VERIFICA NOTAS
SELECT movitimo TIPOMOVI, t.timodesc TIMO,
       moviserv PRODUCTO, (select s.servdesc from open.servicio s where s.servcodi = moviserv) Desc_Serv,
       movicate CATEGO, moviconc CONCEPTO, c.concdesc DESC_CONCEPTO,               
       c.concclco, (select i.clcodesc from open.ic_clascont i where i.clcocodi = c.concclco) Desc_Clasi,
       movicaca CAUSAL, (select g.cacadesc from open.causcarg g where cacacodi = movicaca) Des_Caca,
       sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor 
  FROM open.ic_movimien, open.concepto c, open.ic_tipomovi t
 WHERE movitido = 73
   AND movifeco >= '01/05/2015'
   AND movifeco <= '31/05/2015'
   AND movitihe is null
   AND moviconc = conccodi
   AND movitimo = t.timocodi
   AND movitimo = 16 --and c.concclco = 1
 GROUP BY moviserv, movicate, moviconc, c.concdesc, c.concclco, movitimo, movicaca, t.timodesc
