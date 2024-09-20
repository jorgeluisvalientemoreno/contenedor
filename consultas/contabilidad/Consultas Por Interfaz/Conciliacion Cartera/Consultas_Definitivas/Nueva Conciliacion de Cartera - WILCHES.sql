-- OTRA CONCILIACION CARTERA
SELECT  0 tipomovi, 'Saldo Inicial' timo, 
        SERVICIO producto, (select s.servdesc from open.servicio s where s.servcodi = SERVICIO) Desc_Serv, sum(VALOR)
FROM (
SELECT caccserv SERVICIO, nvl(sum(decode(caccnaca,'N',caccsape)),0) VALOR
  FROM OPEN.ic_cartcoco
 WHERE caccfege = '31/10/2015'
 GROUP BY caccserv
 )
 WHERE valor <> 0
GROUP BY  SERVICIO
UNION ALL
-- SALDO FINAL
SELECT 99 tipomovi, 'Saldo Final' timo, 
       SERVICIO Producto, (select s.servdesc from open.servicio s where s.servcodi = SERVICIO) Desc_Serv, sum(VALOR)
FROM (
SELECT caccserv SERVICIO, NVL((sum(decode(caccnaca,'N',caccsape))* -1),0) VALOR, 'SF' TIPO
  FROM OPEN.ic_cartcoco
 WHERE caccfege = '30/11/2015'
 GROUP BY caccserv
 )
 WHERE valor <> 0
 GROUP BY SERVICIO
UNION
SELECT TIPOMOVI, timo, PRODUCTO, Desc_Serv, SUM(DECODE(TIPOMOVI,1,VALOR,16,VALOR,25,VALOR,56,VALOR,-VALOR)) VALOR
  FROM ( /*Facturaci¢n por Concepto*/
        SELECT movitimo TIPOMOVI, 'Facturaci¢n por Concepto' TIMO,
               moviserv PRODUCTO, (select s.servdesc from open.servicio s where s.servcodi = moviserv) Desc_Serv,
               movicate CATEGO,
               moviconc CONCEPTO, c.concdesc DESC_CONCEPTO,
               c.concclco, (select i.clcodesc from open.ic_clascont i where i.clcocodi = c.concclco) Desc_Clasi,
               movicaca CAUSAL, (select g.cacadesc from open.causcarg g where cacacodi = movicaca) Des_Caca,
               sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor
          FROM open.ic_movimien, open.concepto c
         WHERE movitido = 71
           AND movifeco >= '01/11/2015'
           AND movifeco <= '30/11/2015'
           AND movitihe = 'F'
           AND movitimo = 1
           AND moviconc = conccodi
           --AND movicaca not in (20,23,46,50,56,73)
         GROUP BY moviserv, movicate, moviconc, c.concdesc, c.concclco, movitimo, movicaca
    UNION
        /*Aplicaci¢n de Saldo a Favor en Facturaci¢n*/
        SELECT movitimo TIPOMOVI, 'Aplica_Saldo_a_Favor_Fracion' TIMO,
               moviserv PRODUCTO, (select s.servdesc from open.servicio s where s.servcodi = moviserv) Desc_Serv,
               movicate CATEGO,
               moviconc CONCEPTO, c.concdesc DESC_CONCEPTO,
               c.concclco, (select i.clcodesc from open.ic_clascont i where i.clcocodi = c.concclco) Desc_Clasi,
               movicaca CAUSAL, (select g.cacadesc from open.causcarg g where cacacodi = movicaca) Des_Caca,
               sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor
          FROM open.ic_movimien, open.concepto c
         WHERE movitido = 71
           AND movifeco >= '01/11/2015'
           AND movifeco <= '30/11/2015'
           AND movitihe is null
           AND movitimo = 11
           AND moviconc = conccodi
           --AND movicaca not in (20,23,46,50,56,73)
         GROUP BY moviserv, movicate, moviconc, c.concdesc, c.concclco, movitimo, movicaca
    UNION
        /*Aplicaci¢n saldo a Favor por Notas*/
        SELECT movitimo TIPOMOVI, 'Aplica_Saldo_a_Favor_Notas' TIMO,
               moviserv PRODUCTO, (select s.servdesc from open.servicio s where s.servcodi = moviserv) Desc_Serv,
               movicate CATEGO,
               moviconc CONCEPTO, c.concdesc DESC_CONCEPTO,
               c.concclco, (select i.clcodesc from open.ic_clascont i where i.clcocodi = c.concclco) Desc_Clasi,
               movicaca CAUSAL, (select g.cacadesc from open.causcarg g where cacacodi = movicaca) Des_Caca,
               sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor
          FROM open.ic_movimien, open.concepto c
         WHERE movitido = 73
           AND movifeco >= '01/11/2015'
           AND movifeco <= '30/11/2015'
           AND movitihe is null
           AND movitimo = 40 -- = Aplicaci¢n saldo a Favor por Notas
           AND moviconc = conccodi
           --AND movicaca not in (20,23,46,50,56,73)
         GROUP BY moviserv, movicate, moviconc, c.concdesc, c.concclco, movitimo, movicaca
    UNION
        /*Saldo a favor por Facturaci¢n*/
        SELECT movitimo TIPOMOVI, 'Saldo_favor_Facturaci¢n' TIMO,
               moviserv PRODUCTO, (select s.servdesc from open.servicio s where s.servcodi = moviserv) Desc_Serv,
               movicate CATEGO,
               moviconc CONCEPTO, c.concdesc DESC_CONCEPTO,
               c.concclco, (select i.clcodesc from open.ic_clascont i where i.clcocodi = c.concclco) Desc_Clasi,
               movicaca CAUSAL, (select g.cacadesc from open.causcarg g where cacacodi = movicaca) Des_Caca,
               sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor
          FROM open.ic_movimien, open.concepto c
         WHERE movitido = 71
           AND movifeco >= '01/11/2015'
           AND movifeco <= '30/11/2015'
           AND movitihe is null
           AND movitimo = 44 -- Saldo a favor por Facturaci¢n
           AND moviconc = conccodi
           --AND movicaca not in (20,23,46,50,56,73)
         GROUP BY moviserv, movicate, moviconc, c.concdesc, c.concclco, movitimo, movicaca
    UNION
        /*Saldo a favor por Notas*/
        SELECT movitimo TIPOMOVI, 'Saldo_favor_Notas' TIMO,
               moviserv PRODUCTO, (select s.servdesc from open.servicio s where s.servcodi = moviserv) Desc_Serv,
               movicate CATEGO,
               moviconc CONCEPTO, c.concdesc DESC_CONCEPTO,
               c.concclco, (select i.clcodesc from open.ic_clascont i where i.clcocodi = c.concclco) Desc_Clasi,
               movicaca CAUSAL, (select g.cacadesc from open.causcarg g where cacacodi = movicaca) Des_Caca,
               sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor
          FROM open.ic_movimien, open.concepto c
         WHERE movitido = 73
           AND movifeco >= '01/11/2015'
           AND movifeco <= '30/11/2015'
           AND movitihe is null
           AND movitimo = 46 -- Saldo a favor por Notas
           AND moviconc = conccodi
           --AND movicaca not in (20,23,46,50,56,73)
         GROUP BY moviserv, movicate, moviconc, c.concdesc, c.concclco, movitimo, movicaca
    UNION
        /*Notas por concepto*/
        SELECT movitimo TIPOMOVI, 'Notas_por_concepto' TIMO,
               moviserv PRODUCTO, (select s.servdesc from open.servicio s where s.servcodi = moviserv) Desc_Serv,
               movicate CATEGO,
               moviconc CONCEPTO, c.concdesc DESC_CONCEPTO,
               c.concclco, (select i.clcodesc from open.ic_clascont i where i.clcocodi = c.concclco) Desc_Clasi,
               movicaca CAUSAL, (select g.cacadesc from open.causcarg g where cacacodi = movicaca) Des_Caca,
               sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor
          FROM open.ic_movimien, open.concepto c
         WHERE movitido = 73
           AND movifeco >= '01/11/2015'
           AND movifeco <= '30/11/2015'
           AND movitihe is null
           AND movitimo in (16,56)
           AND moviconc = conccodi
           --AND movicaca not in (20,23,46,50,56,73)
         GROUP BY moviserv, movicate, moviconc, c.concdesc, c.concclco, movitimo, movicaca
    UNION
        -- Devoluciones saldo a favor
        SELECT movitimo TIPOMOVI, 'Devolucion_Saldo_Favor' TIMO,
               moviserv PRODUCTO, (select s.servdesc from open.servicio s where s.servcodi = moviserv) Desc_Serv,
               movicate CATEGO,
               moviconc CONCEPTO, c.concdesc DESC_CONCEPTO,
               c.concclco, (select i.clcodesc from open.ic_clascont i where i.clcocodi = c.concclco) Desc_Clasi,
               movicaca CAUSAL, (select g.cacadesc from open.causcarg g where cacacodi = movicaca) Des_Caca,
               sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor
          FROM open.ic_movimien, open.concepto c
         WHERE movitido = 73
           AND movifeco >= '01/11/2015'
           AND movifeco <= '30/11/2015'
           AND movitihe is null
           AND movitimo = 48
           AND moviconc = conccodi
           --AND movicaca not in (20,23,46,50,56,73)
         GROUP BY moviserv, movicate, moviconc, c.concdesc, c.concclco, movitimo, movicaca
    UNION
        -- Sancion por reactivacion de deuda
        SELECT movitimo TIPOMOVI, 'Sancion_Reactivacion_Deuda' TIMO,
               moviserv PRODUCTO, (select s.servdesc from open.servicio s where s.servcodi = moviserv) Desc_Serv,
               movicate CATEGO,
               moviconc CONCEPTO, c.concdesc DESC_CONCEPTO,
               c.concclco, (select i.clcodesc from open.ic_clascont i where i.clcocodi = c.concclco) Desc_Clasi,
               movicaca CAUSAL, (select g.cacadesc from open.causcarg g where cacacodi = movicaca) Des_Caca,
               sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor
          FROM open.ic_movimien, open.concepto c
         WHERE movitido = 73
           AND movifeco >= '01/11/2015'
           AND movifeco <= '30/11/2015'
           AND movitihe IS NULL
           AND movitimo = 57
           AND moviconc = conccodi
           --AND movicaca not in (20,23,46,50,56,73)
         GROUP BY moviserv, movicate, moviconc, c.concdesc, c.concclco, movitimo, movicaca
    UNION
        /*Recaudo por concepto*/
        SELECT movitimo TIPOMOVI, 'Recaudo_por_concepto' TIMO,
               moviserv PRODUCTO, (select s.servdesc from open.servicio s where s.servcodi = moviserv) Desc_Serv,
               movicate CATEGO,
               moviconc CONCEPTO, c.concdesc DESC_CONCEPTO,
               c.concclco, (select i.clcodesc from open.ic_clascont i where i.clcocodi = c.concclco) Desc_Clasi,
               movicaca CAUSAL, (select g.cacadesc from open.causcarg g where cacacodi = movicaca) Des_Caca,
               sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor
          FROM open.ic_movimien, open.concepto c
         WHERE movitido = 72
           AND movifeco >= '01/11/2015'
           AND movifeco <= '30/11/2015'
           AND movitimo = 23
           AND moviconc = conccodi
         GROUP BY moviserv, movicate, moviconc, c.concdesc, c.concclco, movitimo, movicaca
)
group by TIPOMOVI, timo, /*concclco, Desc_Clasi,*/ PRODUCTO, Desc_Serv --, CATEGO, CAUSAL, Des_Caca, CONCEPTO, DESC_CONCEPTO
ORDER BY PRODUCTO, TIPOMOVI --, CONCCLCO, CONCEPTO
