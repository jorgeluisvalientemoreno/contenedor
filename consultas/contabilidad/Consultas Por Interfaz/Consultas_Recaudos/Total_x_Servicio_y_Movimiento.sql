/*Recaudo por concepto*/ 
SELECT movitimo TIPOMOVI, (select p.timodesc from open.ic_tipomovi p where p.timocodi = movitimo) DES_TIMO,
       moviserv PRODUCTO, (select s.servdesc from open.servicio s where s.servcodi = moviserv) Desc_Serv,
       --movicate CATEGO,  
       --moviconc CONCEPTO, c.concdesc DESC_CONCEPTO,
       --c.concclco, (select i.clcodesc from open.ic_clascont i where i.clcocodi = c.concclco) Desc_Clasi,
       --movicaca CAUSAL, (select g.cacadesc from open.causcarg g where cacacodi = movicaca) Des_Caca,
       sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor 
  FROM open.ic_movimien, open.concepto c
 WHERE movitido = 72 
   AND movifeco >= '01/04/2015'
   AND movifeco <= '30/04/2015'
   and moviserv in (7055, 7056)
   --AND movitimo = 23 
   AND moviconc = conccodi
GROUP BY moviserv, /*movicate, moviconc, c.concdesc, c.concclco*/ movitimo, movicaca  

