-- OTRA CONCILIACION CARTERA
SELECT TIPOMOVI, timo, CONCEPTO, DESC_CONCEPTO, concclco, Desc_Clasi, PRODUCTO, Desc_Serv, CATEGO, CAUSAL, Des_Caca,
       SUM(DECODE(TIPOMOVI,1,VALOR,16,VALOR,25,VALOR,56,VALOR,-VALOR)) VALOR,
       moviubg3 Loca, (select l.description from open.ge_geogra_location l where l.geograp_location_id = moviubg3) Localidad
  FROM ( /*Facturaci¢n por Concepto*/
        SELECT movitimo TIPOMOVI, 'Facturaci¢n por Concepto' TIMO,
               moviserv PRODUCTO, (select s.servdesc from open.servicio s where s.servcodi = moviserv) Desc_Serv,
               movicate CATEGO,
               moviconc CONCEPTO, concdesc DESC_CONCEPTO,
               c.concclco, (select i.clcodesc from open.ic_clascont i where i.clcocodi = c.concclco) Desc_Clasi,
               movicaca CAUSAL, (select g.cacadesc from open.causcarg g where cacacodi = movicaca) Des_Caca,
               sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor,
               moviubg3
          FROM open.ic_movimien, open.concepto c
         WHERE movifeco >= '01-01-2021'
           AND movifeco <= '31-12-2021'
           and movitido = 71
           AND movitimo = 1
           AND movicons > 0
           AND C.conccodi = moviconc
           AND movitihe = 'F'
--           AND movicaca not in (20,23,46,50,56,73)
         GROUP BY moviserv, movicate, moviconc, concdesc, c.concclco, movitimo, movicaca, moviubg3
    UNION
        /*Aplicaci¢n de Saldo a Favor en Facturaci¢n*/
        SELECT movitimo TIPOMOVI, 'Aplica_Saldo_a_Favor_Fracion' TIMO,
               moviserv PRODUCTO, (select s.servdesc from open.servicio s where s.servcodi = moviserv) Desc_Serv,
               movicate CATEGO, moviconc CONCEPTO, c.concdesc DESC_CONCEPTO,
               c.concclco, (select i.clcodesc from open.ic_clascont i where i.clcocodi = c.concclco) Desc_Clasi,
               movicaca CAUSAL, (select g.cacadesc from open.causcarg g where cacacodi = movicaca) Des_Caca,
               sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor,
               moviubg3
          FROM open.ic_movimien, open.concepto c
         WHERE movifeco >= '01-01-2021'
           AND movifeco <= '31-12-2021'
           and movitido = 71
           AND movitimo = 11
           AND movicons > 0
           AND movitihe is null
           AND C.conccodi = moviconc
         GROUP BY moviserv, movicate, moviconc, concdesc, c.concclco, movitimo, movicaca, moviubg3
    UNION
        /*Aplicaci¢n saldo a Favor por Notas*/
        SELECT movitimo TIPOMOVI, 'Aplica_Saldo_a_Favor_Notas' TIMO,
               moviserv PRODUCTO, (select s.servdesc from open.servicio s where s.servcodi = moviserv) Desc_Serv,
               movicate CATEGO, moviconc CONCEPTO, c.concdesc DESC_CONCEPTO,
               c.concclco, (select i.clcodesc from open.ic_clascont i where i.clcocodi = c.concclco) Desc_Clasi,
               movicaca CAUSAL, (select g.cacadesc from open.causcarg g where cacacodi = movicaca) Des_Caca,
               sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor,
               moviubg3
          FROM open.ic_movimien, open.concepto c
         WHERE movifeco >= '01-01-2021'
           AND movifeco <= '31-12-2021'
           AND movitido = 73
           AND movitimo = 40 -- = Aplicaci¢n saldo a Favor por Notas
           AND movicons > 0
           AND movitihe is null
           AND C.conccodi = moviconc
         GROUP BY moviserv, movicate, moviconc, concdesc, c.concclco, movitimo, movicaca, moviubg3
    UNION
        /*Saldo a favor por Facturaci¢n*/
        SELECT movitimo TIPOMOVI, 'Saldo_favor_Facturaci¢n' TIMO,
               moviserv PRODUCTO, (select s.servdesc from open.servicio s where s.servcodi = moviserv) Desc_Serv,
               movicate CATEGO, moviconc CONCEPTO, c.concdesc DESC_CONCEPTO,
               c.concclco, (select i.clcodesc from open.ic_clascont i where i.clcocodi = c.concclco) Desc_Clasi,
               movicaca CAUSAL, (select g.cacadesc from open.causcarg g where cacacodi = movicaca) Des_Caca,
               sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor,
               moviubg3
          FROM open.ic_movimien, open.concepto c
         WHERE movifeco >= '01-01-2021'
           AND movifeco <= '31-12-2021'
           and movitido = 71
           AND movitimo = 44 -- Saldo a favor por Facturaci¢n
           AND movicons > 0
           AND movitihe is null
           AND C.conccodi = moviconc
         GROUP BY moviserv, movicate, moviconc, concdesc, c.concclco, movitimo, movicaca, moviubg3
    UNION
        /*Saldo a favor por Notas*/
        SELECT movitimo TIPOMOVI, 'Saldo_favor_Notas' TIMO,
               moviserv PRODUCTO, (select s.servdesc from open.servicio s where s.servcodi = moviserv) Desc_Serv,
               movicate CATEGO, moviconc CONCEPTO, c.concdesc DESC_CONCEPTO,
               c.concclco, (select i.clcodesc from open.ic_clascont i where i.clcocodi = c.concclco) Desc_Clasi,
               movicaca CAUSAL, (select g.cacadesc from open.causcarg g where cacacodi = movicaca) Des_Caca,
               sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor,
               moviubg3
          FROM open.ic_movimien, open.concepto c
         WHERE movifeco >= '01-01-2021'
           AND movifeco <= '31-12-2021'
           AND movitido = 73
           AND movitimo = 46 -- Saldo a favor por Notas
           AND movicons > 0
           AND movitihe is null
           AND C.conccodi = moviconc
         GROUP BY moviserv, movicate, moviconc, concdesc, c.concclco, movitimo, movicaca, moviubg3
    UNION
        /*Notas por concepto*/
        SELECT movitimo TIPOMOVI, 'Notas_por_concepto' TIMO,
               moviserv PRODUCTO, (select s.servdesc from open.servicio s where s.servcodi = moviserv) Desc_Serv,
               movicate CATEGO, moviconc CONCEPTO, c.concdesc DESC_CONCEPTO,
               c.concclco, (select i.clcodesc from open.ic_clascont i where i.clcocodi = c.concclco) Desc_Clasi,
               movicaca CAUSAL, (select g.cacadesc from open.causcarg g where cacacodi = movicaca) Des_Caca,
               sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor,
               moviubg3
          FROM open.ic_movimien, open.concepto c
         WHERE movifeco >= '01-01-2021'
           AND movifeco <= '31-12-2021'
           AND movitido = 73
           AND movitimo in (16,56)
           AND movicons > 0
           AND movitihe is null
           AND C.conccodi = moviconc
         GROUP BY moviserv, movicate, moviconc, concdesc, c.concclco, movitimo, movicaca, moviubg3
    UNION
        -- Devoluciones saldo a favor
        SELECT movitimo TIPOMOVI, 'Devolucion_Saldo_Favor' TIMO,
               moviserv PRODUCTO, (select s.servdesc from open.servicio s where s.servcodi = moviserv) Desc_Serv,
               movicate CATEGO, moviconc CONCEPTO, c.concdesc DESC_CONCEPTO,
               c.concclco, (select i.clcodesc from open.ic_clascont i where i.clcocodi = c.concclco) Desc_Clasi,
               movicaca CAUSAL, (select g.cacadesc from open.causcarg g where cacacodi = movicaca) Des_Caca,
               sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor,
               moviubg3
          FROM open.ic_movimien, open.concepto c
         WHERE movifeco >= '01-01-2021'
           AND movifeco <= '31-12-2021'
           AND movitido = 73
           AND movitimo = 48
           AND movicons > 0
           AND movitihe is null
           AND C.conccodi = moviconc
         GROUP BY moviserv, movicate, moviconc, concdesc, c.concclco, movitimo, movicaca, moviubg3
    UNION
        -- Sancion por reactivacion de deuda
        SELECT movitimo TIPOMOVI, 'Sancion_Reactivacion_Deuda' TIMO,
               moviserv PRODUCTO, (select s.servdesc from open.servicio s where s.servcodi = moviserv) Desc_Serv,
               movicate CATEGO, moviconc CONCEPTO, c.concdesc DESC_CONCEPTO,
               c.concclco, (select i.clcodesc from open.ic_clascont i where i.clcocodi = c.concclco) Desc_Clasi,
               movicaca CAUSAL, (select g.cacadesc from open.causcarg g where cacacodi = movicaca) Des_Caca,
               sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor,
               moviubg3
          FROM open.ic_movimien, open.concepto c
         WHERE movifeco >= '01-01-2021'
           AND movifeco <= '31-12-2021'
           AND movitido = 73
           AND movitimo = 57
           AND movicons > 0
           AND movitihe IS NULL
           AND C.conccodi = moviconc
         GROUP BY moviserv, movicate, moviconc, concdesc, c.concclco, movitimo, movicaca, moviubg3
    UNION
        /*Recaudo por concepto*/
        SELECT movitimo TIPOMOVI, 'Recaudo_por_concepto' TIMO,
               moviserv PRODUCTO, (select s.servdesc from open.servicio s where s.servcodi = moviserv) Desc_Serv,
               movicate CATEGO,
               moviconc CONCEPTO, c.concdesc DESC_CONCEPTO,
               c.concclco, (select i.clcodesc from open.ic_clascont i where i.clcocodi = c.concclco) Desc_Clasi,
               movicaca CAUSAL, (select g.cacadesc from open.causcarg g where cacacodi = movicaca) Des_Caca,
               sum((decode(movisign,'D',MOVIVALO,-MOVIVALO))) valor,
               moviubg3
          FROM open.ic_movimien, open.concepto c
         WHERE movifeco >= '01-01-2021'
           AND movifeco <= '31-12-2021'
           AND movitido = 72
           AND movitimo in (23,25)
           AND movicons > 0
           AND C.conccodi = moviconc
         GROUP BY moviserv, movicate, moviconc, concdesc, c.concclco, movitimo, movicaca, moviubg3
)
group by TIPOMOVI, timo, concclco, Desc_Clasi, PRODUCTO, Desc_Serv, CATEGO, CAUSAL, Des_Caca, CONCEPTO, DESC_CONCEPTO, moviubg3
ORDER BY TIPOMOVI, CONCCLCO, CONCEPTO
