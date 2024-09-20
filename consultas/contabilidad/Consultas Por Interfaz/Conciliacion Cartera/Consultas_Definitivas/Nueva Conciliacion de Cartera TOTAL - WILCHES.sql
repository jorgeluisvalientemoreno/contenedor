-- OTRA CONCILIACION CARTERA
SELECT  SERVICIO producto, (select s.servdesc from open.servicio s where s.servcodi = SERVICIO) Desc_Serv,
        'CORRIENTE' CARTERA, 0 tipomovi, 'Saldo Inicial' timo, 0 CACA, '' DESC_CACA, sum(VALOR)
  FROM (
        SELECT caccserv SERVICIO, nvl(sum(decode(caccnaca,'N',caccsape)),0) VALOR
          FROM OPEN.ic_cartcoco
         WHERE caccfege = '&Fecha_Cierre_Anterior'
         GROUP BY caccserv
       )
 WHERE valor <> 0
 GROUP BY  SERVICIO
UNION ALL
-- SALDO FINAL
SELECT SERVICIO Producto, (select s.servdesc from open.servicio s where s.servcodi = SERVICIO) Desc_Serv, 
       'CORRIENTE' CARTERA, 99 tipomovi, 'Saldo Final' timo, 0 CACA, '' DESC_CACA, sum(VALOR)
  FROM (
        SELECT caccserv SERVICIO, NVL((sum(decode(caccnaca,'N',caccsape))* -1),0) VALOR, 'SF' TIPO
          FROM OPEN.ic_cartcoco
         WHERE caccfege = '&Fecha_Final_Cierre_Actual'
         GROUP BY caccserv
       )
 WHERE valor <> 0
 GROUP BY SERVICIO
UNION
SELECT PRODUCTO, Desc_Serv, 'CORRIENTE' CARTERA, TIPOMOVI, timo, CAUSAL CACA, DES_CACA,
       SUM(DECODE(TIPOMOVI,1,VALOR,16,VALOR,25,VALOR,56,VALOR,-VALOR)) VALOR
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
           AND movifeco >= '&Fecha_Inicial_Cierre_Actual'
           AND movifeco <= '&Fecha_Final_Cierre_Actual'
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
           AND movifeco >= '&Fecha_Inicial_Cierre_Actual'
           AND movifeco <= '&Fecha_Final_Cierre_Actual'
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
           AND movifeco >= '&Fecha_Inicial_Cierre_Actual'
           AND movifeco <= '&Fecha_Final_Cierre_Actual'
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
           AND movifeco >= '&Fecha_Inicial_Cierre_Actual'
           AND movifeco <= '&Fecha_Final_Cierre_Actual'
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
           AND movifeco >= '&Fecha_Inicial_Cierre_Actual'
           AND movifeco <= '&Fecha_Final_Cierre_Actual'
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
           AND movifeco >= '&Fecha_Inicial_Cierre_Actual'
           AND movifeco <= '&Fecha_Final_Cierre_Actual'
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
           AND movifeco >= '&Fecha_Inicial_Cierre_Actual'
           AND movifeco <= '&Fecha_Final_Cierre_Actual'
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
           AND movifeco >= '&Fecha_Inicial_Cierre_Actual'
           AND movifeco <= '&Fecha_Final_Cierre_Actual'
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
           AND movifeco >= '&Fecha_Inicial_Cierre_Actual'
           AND movifeco <= '&Fecha_Final_Cierre_Actual'
           AND movitimo = 23
           AND moviconc = conccodi
         GROUP BY moviserv, movicate, moviconc, c.concdesc, c.concclco, movitimo, movicaca
)
group by TIPOMOVI, timo, PRODUCTO, Desc_Serv, CAUSAL, Des_Caca
--ORDER BY PRODUCTO, TIPOMOVI, CACA
-- CARTERA DIFERIDA
UNION
-- SALDO INICIAL
SELECT caccserv producto, (select s.servdesc from open.servicio s where s.servcodi = caccserv) Desc_Serv, 
       'DIFERIDA' CARTERA, 0 TIPOMOVI, 'Saldo Inicial' timo, 0 CACA, '' DESC_CACA,
       nvl(sum(decode(caccnaca,'F',caccsape)),0) VALOR
  FROM open.ic_cartcoco I 
 WHERE caccfege = '&Fecha_Cierre_Anterior'
 GROUP BY caccserv
UNION
-- SALDO FINAL
SELECT caccserv producto, (select s.servdesc from open.servicio s where s.servcodi = caccserv) Desc_Serv,
       'DIFERIDA' CARTERA, 99 TIPOMOVI, 'Saldo Final' timo, 0 CACA, '' DESC_CACA,
       NVL((sum(decode(caccnaca,'F',caccsape))* -1),0) VALOR
  FROM open.ic_cartcoco
 WHERE caccfege = '&Fecha_Final_Cierre_Actual'
 GROUP BY caccserv
UNION
-- MOVIMIENTO DIFERIDOS
SELECT SERVICIO producto, (select s.servdesc from open.servicio s where s.servcodi = servicio) Desc_Serv,
       'DIFERIDA' CARTERA, modicaca TIPOMOVI, cacadesc TIMO, MODICACA CACA, cacadesc DESC_CACA, (DB - CR) VALOR
  FROM (
        SELECT  sesuserv SERVICIO, modicaca, g.cacadesc,
                nvl(sum(decode(modisign,'DB',modivacu)),0) DB,
                nvl(sum(decode(modisign,'CR',modivacu)),0) CR
        FROM    open.movidife, open.servsusc, open.causcarg g
        WHERE   modifech >= to_date('&Fecha_Inicial_Cierre_Actual 00:00:00','dd/mm/yyyy hh24:mi:ss')
          AND   modifech <= to_date('&Fecha_Final_Cierre_Actual 23:59:59','dd/mm/yyyy hh24:mi:ss')
          AND   modinuse =  sesunuse
          AND   modivacu >  0
          AND   modicaca =  g.cacacodi
        GROUP BY sesuserv, modicaca, g.cacadesc
       )
--Group by TIPOMOVI, timo, PRODUCTO, Desc_Serv, CAUSAL, DesC_Caca
ORDER BY PRODUCTO, TIPOMOVI, CACA
