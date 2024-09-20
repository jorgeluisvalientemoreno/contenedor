-- OSCAR RESTREPO
-- FOTO MES ANTERIOR
select 'MARZO_2015',nvl(ldci_pkinterfazsap.fvaGetSegmento(cebe),0) segemento,tiposerv,clcocodi, clcodesc,
sum(corriente) corriente
,sum(Diferida) Diferida
from 
(
      SELECT nvl(ldci_pkinterfazsap.fvaGetCebeNew(caccubg3,cacccate),NULL) cebe,clcocodi, clcodesc,
      caccserv tiposerv,caccubg3 localidad,cacccate categoria, 
      sum(decode(caccnaca,'N',caccsape)) corriente, sum(decode(caccnaca,'F',caccsape)) Diferida
        FROM
          OPEN.ic_cartcoco, open.concepto,open.ic_clascont
          where caccfege = '31/03/2015'
          and caccconc = conccodi
          and concclco = clcocodi (+)
            GROUP BY caccserv,caccubg3,cacccate,clcocodi, clcodesc
)
group by cebe, tiposerv,clcocodi, clcodesc
