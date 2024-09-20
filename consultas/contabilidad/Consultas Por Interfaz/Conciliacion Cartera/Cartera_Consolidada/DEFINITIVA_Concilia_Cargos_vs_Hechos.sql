-- conciliacion unificada cargos vs hechos
SELECT A_Tido,  B_Timo, (select m.timodesc from open.ic_tipomovi m where m.timocodi = B_Timo) C_desc_timo,
       D_serv, (select s.servdesc from open.servicio s where s.servcodi = D_serv) E_desc_serv, 
       sum(F_DB_Hechos) F_DB_Hechos, sum(G_CR_Hechos) G_CR_Hechos, SUM(H_Neto_Hechos) H_Neto_Hechos,
       sum(I_DB_Cargos) I_DB_Cargos, SUM(J_CR_Cargos) J_CR_Cargos, sum(K_Neto_Cargos) K_Neto_Cargos,
       sum(H_Neto_Hechos + K_Neto_Cargos) Diferencia
  FROM
       (
        -- Hechos Económicos que afectan cartera
        SELECT  movitido A_Tido, movitimo B_Timo, --(select m.timodesc from open.ic_tipomovi m where m.timocodi = movitimo) C_desc_timo,
                /*movitihe,*/ moviserv D_serv, --(select s.servdesc from open.servicio s where s.servcodi = moviserv) E_desc_serv, 
                sum(decode(movisign,'D',movivalo)) F_DB_Hechos, sum(decode(movisign,'C',movivalo)) G_CR_Hechos,
                sum(decode(movisign,'D',movivalo,-movivalo)) H_Neto_Hechos, 
                0 I_DB_Cargos, 0 J_CR_Cargos, 0 K_Neto_Cargos
        FROM    open.ic_movimien
        WHERE   movifeco >= to_date('01/02/2017','dd/mm/yyyy')
                AND movitido in (71,72,73)
                AND movitimo in (1,  -- Facturación por concepto (+)
                                 11, -- AS Facturación (-)
                                 16, -- Notas por Concepto (+)
                                 23, -- Recaudo por Concepto (-)
                                 25, -- SA Recaudo  (No afecta cartera pero se valida)
                                 40, -- AS Notas (-)
                                 44, -- SA Facturación (+)
                                 46, -- SA Notas (+)
                                 56  -- Reactivación Deuda (Cheque Devuelto) (+)
                                )
                AND movifeco <= to_date('28/02/2017','dd/mm/yyyy')
                AND nvl(movitihe,'X') != 'CE'
        GROUP BY movitido, movitimo, movitihe, moviserv
        --ORDER BY movitido, movitimo, moviserv
        --
        UNION ALL
        --
        -- Facturación por Concepto
        SELECT  71 A_tido, 1 B_timo, --'Facturacion por Concepto' C_desc_timo,
                sesuserv D_serv, --(select s.servdesc from open.servicio s where s.servcodi = sesuserv) E_desc_serv, 
                0 F_DB_Hechos, 0 G_CR_Hechos, 0 H_Neto_Hechos,
                sum(decode(cargsign,'CR',cargvalo)) I_DB_Cargos, sum(decode(cargsign,'DB',cargvalo)) G_CR_Hechos,
                sum(decode(cargsign,'CR',cargvalo,-cargvalo)) K_Neto_Cargos
        FROM    open.cargos,
                open.servsusc,
                open.cuencobr,
                open.factura
        WHERE   factfege >= to_Date('01/02/2017 00:00:00', 'dd/mm/yyyy hh24:mi:ss')
                AND factfege <= to_Date('28/02/2017 23:59:59', 'dd/mm/yyyy hh24:mi:ss')
                AND cucofact = factcodi
                AND cucocodi = cargcuco
                AND sesunuse = cargnuse
                AND cargfecr <= to_Date('28/02/2017 23:59:59', 'dd/mm/yyyy hh24:mi:ss')
                AND cargcuco > 0
                AND cargtipr = 'A'
                AND cargsign in ('DB','CR')
        GROUP BY sesuserv
        --ORDER BY sesuserv
        --
        UNION ALL
        --
        -- SA de Facturación
        SELECT  71 A_tido, 44 B_timo, --'Saldo a Favor por Facturacion' C_desc_timo,
                sesuserv D_serv, --(select s.servdesc from open.servicio s where s.servcodi = sesuserv) E_desc_serv,
                0 F_DB_Hechos, 0 G_CR_Hechos, 0 H_Neto_Hechos, 
                sum(decode(cargsign,'SA',cargvalo)) I_DB_Cargos, 0 G_CR_Hechos,
                sum(decode(cargsign,'SA',cargvalo)) K_Neto_Cargos
        FROM    open.cargos, open.servsusc, open.cuencobr, open.factura
        WHERE   factfege >= to_Date('01/02/2017 00:00:00', 'dd/mm/yyyy hh24:mi:ss')
                AND factfege <= to_Date('28/02/2017 23:59:59', 'dd/mm/yyyy hh24:mi:ss')
                AND cucofact = factcodi
                AND cucocodi = cargcuco
                AND sesunuse = cargnuse
                AND cargfecr <= to_Date('28/02/2017 23:59:59', 'dd/mm/yyyy hh24:mi:ss')
                AND cargcuco > 0
                AND cargtipr = 'P'
                AND cargsign = 'SA'
                AND cargdoso not like 'PA%'
                AND cargprog in (6,18,42) -- FGCC, FAFS, FGCO
        GROUP BY sesuserv
        --ORDER BY sesuserv
        --
        UNION ALL
        --
        -- Aplicaciones de Saldo a Favor por Facturación
        SELECT  71 A_tido, 11 B_timo, --'Aplicacion de Saldo a Favor en Facturacion' C_desc_timo,
                sesuserv D_serv, --(select s.servdesc from open.servicio s where s.servcodi = sesuserv) E_desc_serv, 
                0 F_DB_Hechos, 0 G_CR_Hechos, 0 H_Neto_Hechos,
                sum(decode(cargsign,'AS',cargvalo)) I_DB_Cargos, 0 G_CR_Hechos,
                sum(decode(cargsign,'AS',-cargvalo)) K_Neto_Cargos
        FROM    open.cargos, open.servsusc
        WHERE   cargfecr >= to_Date('01/02/2017 00:00:00', 'dd/mm/yyyy hh24:mi:ss')
                AND cargfecr <= to_Date('28/02/2017 23:59:59', 'dd/mm/yyyy hh24:mi:ss')
                AND sesunuse = cargnuse
                AND cargcuco > 0
                AND cargtipr = 'P'
                AND cargsign = 'AS'
                AND cargprog in (6,18,42) -- FGCC, FAFS, FGCO
        GROUP BY sesuserv
        --ORDER BY sesuserv
        --
        UNION ALL
        --
        -- Notas por concepto
        -- Tener en cuenta causa de cargo 45 - Cheque Devuelto se reporta en tipo de movimiento 5
        SELECT  73 A_tido, 16 B_timo, --'Notas por concepto' C_desc_timo,
                sesuserv D_serv, --(select s.servdesc from open.servicio s where s.servcodi = sesuserv) E_desc_serv,
                0 F_DB_Hechos, 0 G_CR_Hechos, 0 H_Neto_Hechos,
                sum(decode(cargsign,'CR',cargvalo)) I_DB_Cargos, sum(decode(cargsign,'DB',cargvalo)) G_CR_Hechos,
                sum(decode(cargsign,'CR',cargvalo,-cargvalo)) K_Neto_Cargos
        FROM    open.cargos, open.servsusc
        WHERE   cargfecr >= to_Date('01/02/2017 00:00:00', 'dd/mm/yyyy hh24:mi:ss')
                AND cargfecr <= to_Date('28/02/2017 23:59:59', 'dd/mm/yyyy hh24:mi:ss')
                AND sesunuse = cargnuse
                AND cargcuco > 0
                AND cargtipr = 'P'
                AND cargsign in ('DB','CR')
                --AND CARGCACA = 45 -- Cheque Devuelto
        GROUP BY sesuserv
        --ORDER BY sesuserv
        --
        UNION ALL
        --
        -- SA de Notas
        SELECT  73 A_tido, 46 B_timo, --'Saldo a Favor por Notas' C_desc_timo,
                sesuserv D_serv, --(select s.servdesc from open.servicio s where s.servcodi = sesuserv) E_desc_serv, 
                0 F_DB_Hechos, 0 G_CR_Hechos, 0 H_Neto_Hechos,
                sum(decode(cargsign,'SA',cargvalo)) I_DB_Cargos, 0 G_CR_Hechos,
                sum(decode(cargsign,'SA',cargvalo)) K_Neto_Cargos 
        FROM    open.cargos, open.servsusc
        WHERE   cargfecr >= to_Date('01/02/2017 00:00:00', 'dd/mm/yyyy hh24:mi:ss')
                AND cargfecr <= to_Date('28/02/2017 23:59:59', 'dd/mm/yyyy hh24:mi:ss')
                AND sesunuse = cargnuse
                AND cargcuco > 0
                AND cargtipr = 'P'
                AND cargsign = 'SA'
                AND cargdoso not like 'PA%'
                AND cargprog not in (6,18,42) -- FGCC, FAFS, FGCO
        GROUP BY sesuserv
        --ORDER BY sesuserv
        --
        UNION ALL
        --
        -- Aplicaciones de Saldo a Favor por Notas
        SELECT  73 A_tido, 40 B_timo, --'Aplicacion Saldo a Favor por Notas' C_desc_timo,
                sesuserv D_serv, --(select s.servdesc from open.servicio s where s.servcodi = sesuserv) E_desc_serv, 
                0 F_DB_Hechos, 0 G_CR_Hechos, 0 H_Neto_Hechos,
                0 I_DB_Cargos, sum(decode(cargsign,'AS',cargvalo)) G_CR_Hechos,
                sum(decode(cargsign,'AS',-cargvalo)) K_Neto_Cargos 
        FROM    open.cargos, open.servsusc
        WHERE   cargfecr >= to_Date('01/02/2017 00:00:00', 'dd/mm/yyyy hh24:mi:ss')
                AND cargfecr <= to_Date('28/02/2017 23:59:59', 'dd/mm/yyyy hh24:mi:ss')
                AND sesunuse = cargnuse
                AND cargcuco > 0
                AND cargtipr = 'P'
                AND cargsign = 'AS'
                AND cargprog not in (6,18,42) -- FGCC, FAFS, FGCO
        GROUP BY sesuserv
        --ORDER BY sesuserv
        --
        UNION ALL
        --
        -- Pagos 
        SELECT  72 A_tido, 23 B_timo, --'Recaudo por Concepto' C_desc_timo,
                sesuserv D_serv, --(select s.servdesc from open.servicio s where s.servcodi = sesuserv) E_desc_serv, 
                0 F_DB_Hechos, 0 G_CR_Hechos, 0 H_Neto_Hechos,
                0 I_DB_Cargos,
                (sum(decode(cargsign,'PA',cargvalo,'AP',-cargvalo)) - nvl(sum(decode(cargsign,'SA',cargvalo,'NS',-cargvalo)),0)) G_CR_Hechos,
                ((sum(decode(cargsign,'PA',cargvalo,'AP',-cargvalo)) - nvl(sum(decode(cargsign,'SA',cargvalo,'NS',-cargvalo)),0)) * -1) K_Neto_Cargos
        FROM    open.cargos, open.servsusc, open.cupon
        WHERE   cargfecr >= to_Date('01/02/2017 00:00:00', 'dd/mm/yyyy hh24:mi:ss')
                AND cargfecr <= to_Date('28/02/2017 23:59:59', 'dd/mm/yyyy hh24:mi:ss')
                AND sesunuse = cargnuse
                AND cargcuco > 0
                AND cargtipr = 'P'
                AND cargsign in ('SA','PA','AP','NS')
                AND (cargdoso like 'PA%' OR cargdoso like 'AP%')
                AND cargcodo = cuponume -- Garantizar el paso a interfaz por detalle por cupón   resureca
        GROUP BY sesuserv
        --ORDER BY sesuserv
        --
        UNION ALL
        --
        -- Saldos a Favor por Pagos
        SELECT  72 A_tido, 25 B_timo, --'Saldo a Favor por Recaudo' C_desc_timo,
                sesuserv D_serv, --(select s.servdesc from open.servicio s where s.servcodi = sesuserv) E_desc_serv, 
                0 F_DB_Hechos, 0 G_CR_Hechos, 0 H_Neto_Hechos,
                0 I_DB_Cargos, sum(decode(cargsign,'SA',cargvalo,'NS',-cargvalo)) G_CR_Hechos,
                (sum(decode(cargsign,'SA',cargvalo,'NS',-cargvalo)) * -1) K_Neto_Cargos
        FROM    open.cargos, open.servsusc, open.cupon
        WHERE   cargfecr >= to_Date('01/02/2017 00:00:00', 'dd/mm/yyyy hh24:mi:ss')
                AND cargfecr <= to_Date('28/02/2017 23:59:59', 'dd/mm/yyyy hh24:mi:ss')
                AND sesunuse = cargnuse
                AND cargcuco > 0
                AND cargtipr = 'P'
                AND cargsign in ('SA','NS')
                AND (cargdoso like 'PA%' OR cargdoso like 'AP%')
                AND cargcodo = cuponume -- Garantizar el paso a interfaz por detalle por cupón resureca
        GROUP BY sesuserv
        --ORDER BY sesuserv
        )
group by A_Tido, B_Timo, D_serv       
order by a_tido, b_timo, d_serv
