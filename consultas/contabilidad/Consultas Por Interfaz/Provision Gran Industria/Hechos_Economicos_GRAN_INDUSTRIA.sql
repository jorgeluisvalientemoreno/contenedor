-- PROVISION GRAN INDUSTRIA
SELECT movitimo TIPOMOVI, 'Facturaci�n por Concepto' TIMO,
       moviserv PRODUCTO, (select s.servdesc from open.servicio s where s.servcodi = moviserv) Desc_Serv,
       movicate CATEGO,
       moviconc CONCEPTO, c.concdesc DESC_CONCEPTO,
       c.concclco, (select i.clcodesc from open.ic_clascont i where i.clcocodi = c.concclco) Desc_Clasi,
       sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor,
       (select bl.celocebe from open.ldci_centbenelocal bl where bl.celoloca = m.moviubg3) Cebe
  FROM open.ic_movimien m, open.concepto c
 WHERE movitido = 71
   AND movifeco = '02/12/2023'
   AND movitihe = 'CE'
   AND movitimo = 1
   AND moviconc = conccodi
 GROUP BY moviserv, movicate, moviconc, c.concdesc, c.concclco, movitimo, movicaca, m.moviubg3