-- conciliacion unificada cargos vs hechos
SELECT /*:*//*'20/12/2023'*/ /*Fecha_Final Periodo*/--,
       A_Tido,  B_Timo, (select m.timodesc from open.ic_tipomovi m where m.timocodi = B_Timo) C_desc_timo,
       D_serv, (select s.servdesc from open.servicio s where s.servcodi = D_serv) E_desc_serv, 
       sum(F_DB_Hechos) F_DB_Hechos, sum(G_CR_Hechos) G_CR_Hechos, SUM(H_Neto_Hechos) H_Neto_Hechos,
       sum(I_DB_Cargos) I_DB_Cargos, SUM(J_CR_Cargos) J_CR_Cargos, sum(K_Neto_Cargos) K_Neto_Cargos,
       sum(H_Neto_Hechos + K_Neto_Cargos) Diferencia
  FROM
       (
        -- Hechos Económicos que afectan cartera
        SELECT   movitido A_Tido, movitimo B_Timo, --(select m.timodesc from open.ic_tipomovi m where m.timocodi = movitimo) C_desc_timo,
                  moviserv D_serv, --(select s.servdesc from open.servicio s where s.servcodi = moviserv) E_desc_serv, 
                sum(decode(movisign,'D',movivalo)) F_DB_Hechos, sum(decode(movisign,'C',movivalo)) G_CR_Hechos,
                sum(decode(movisign,'D',movivalo,-movivalo)) H_Neto_Hechos, 
                0 I_DB_Cargos, 0 J_CR_Cargos, 0 K_Neto_Cargos
        FROM    open.ic_movimien m
        WHERE   movifeco >= to_date(to_char('27/11/2023'/*:Fecha_Inicial*/ || ' 00:00:00') , 'dd-mm-yyyy hh24:mi:ss')-- to_date('27/11/2023','dd/mm/yyyy'))
                AND movitido in (/*71,72,*/73)
                and movicicl in (1601,568,306,3802,5402,1006,1022,1001,5105,801,781,1301)
               AND movitimo in (--1,  -- Facturación por concepto (+)
                                 --11, -- AS Facturación (-)
                                 16 -- Notas por Concepto (+)
                                 --23, -- Recaudo por Concepto (-)
                                 --25, -- SA Recaudo  (No afecta cartera pero se valida)
                                 --40, -- AS Notas (-)
                                 --44, -- SA Facturación (+)
                                 --46, -- SA Notas (+)
                                 --56  -- Reactivación Deuda (Cheque Devuelto) (+)
                                )
                AND movifeco <= to_date(to_char('20/12/2023'/*:Fecha_Final*/ || ' 23:59:59') , 'dd-mm-yyyy hh24:mi:ss') -- to_date('20/12/2023','dd/mm/yyyy'))
                AND nvl(movitihe,'X') not in ('CE','MC','SC')
        GROUP BY movitido, movitimo, movitihe, moviserv
        --ORDER BY movitido, movitimo, moviserv
        --
        UNION ALL
        --
        -- Notas por concepto
        -- Tener en cuenta causa de cargo 45 - Cheque Devuelto se reporta en tipo de movimiento 5
        --'Notas por concepto
        select   73 A_tido, 16 B_timo, --'Notas por concepto' C_desc_timo,
                sesuserv D_serv, --(select s.servdesc from open.servicio s where s.servcodi = sesuserv) E_desc_serv,
                0 F_DB_Hechos, 0 G_CR_Hechos, 0 H_Neto_Hechos,
                sum(decode(cargsign,'CR',cargvalo)) I_DB_Cargos, sum(decode(cargsign,'DB',cargvalo)) J_CR_Cargos,
                sum(decode(cargsign,'CR',cargvalo,-cargvalo)) K_Neto_Cargos
        from open.cargos c,open.SERVSUSC ss, open.CONCEPTO CO,
             open.CAUSCARG csc, open.procesos, open.ic_clascont, open.perifact
        where c.cargcaca = csc.cacacodi
          and c.cargnuse = ss.sesunuse
          and c.CARGCONC = CO.CONCCODI
          and c.cargfecr BETWEEN '27/11/2023'
                             AND '20/12/2023 23:59:59'
          and cargprog = proccons
          and clcocodi(+) = concclco
          and cargpefa = pefacodi
          AND CARGCUCO > 0
          and cargtipr = 'P'
          AND cargsign in ('DB','CR')
       -- and sesususc in (48055545) 
         and  sesucicl in (1601,568,306,3802,5402,1006,1022,1001,5105,801,781,1301)
        group by sesuserv
        --

        )
group by A_Tido, B_Timo, D_serv       
order by a_tido, b_timo, d_serv
