-- conciliacion cartera por usuario
select producto
from (
select producto, sum(valor)
from 
 (
  SELECT caccserv ||' - '|| (select s.servdesc from open.servicio s where s.servcodi = caccserv) Servicio,
         caccnuse producto, '01_Sdo_Inicial' Movimiento,
         nvl(sum(caccsape),0) VALOR
    FROM OPEN.ic_cartcoco c, open.concepto o
   WHERE caccfege = '28-02-2018' 
     AND caccnuse > 0
     and caccserv = decode(&Tipo_servicio, -1, caccserv, &Tipo_servicio)
     AND c.caccconc = o.conccodi
   GROUP BY caccserv, caccnuse
  --
  UNION ALL
  -- SALDO FINAL
  SELECT caccserv ||' - '|| (select s.servdesc from open.servicio s where s.servcodi = caccserv) Servicio,
         caccnuse producto, '11_Sdo_Cierre' Movimiento,
         nvl(sum(-caccsape),0) VALOR
    FROM OPEN.ic_cartcoco, open.concepto o
   WHERE caccfege = '31-03-2018'
     AND caccnuse > 0
     and caccserv = decode(&Tipo_servicio, -1, caccserv, &Tipo_servicio)
     AND caccconc = conccodi
   GROUP BY caccserv, caccnuse
  --
  UNION ALL
  --
  select * 
    from (
          -- Facturacion por Concepto
          SELECT  sesuserv ||' - '|| (select s.servdesc from open.servicio s where s.servcodi = sesuserv) Servicio, 
                  cargnuse producto, '02_Frac_Cartera' Movimiento,
                  sum(decode(cargsign,'DB',cargvalo, -cargvalo)) Valor
          FROM    open.cargos,
                  open.servsusc,
                  open.cuencobr,
                  open.factura
          WHERE   factfege >= '01-03-2018'
                  AND factfege < '01-04-2018'
                  AND cucofact = factcodi
                  AND cucocodi = cargcuco
                  AND sesunuse = cargnuse
                  AND sesuserv = decode(&Tipo_servicio, -1, sesuserv, &Tipo_servicio)
                  AND cargfecr < '01-04-2018'
                  AND cargcuco > 0
                  AND cargtipr = 'A'
                  AND cargsign in ('DB','CR')
          GROUP BY sesuserv, cargnuse
          --
          UNION ALL
          -- SA de Facturación
          SELECT  sesuserv ||' - '|| (select s.servdesc from open.servicio s where s.servcodi = sesuserv) Servicio, 
                  cargnuse producto, '03_SA_Fracion' Movimiento,
                  sum(decode(cargsign,'SA',cargvalo)) Valor
          FROM    open.cargos, open.servsusc, open.cuencobr, open.factura
          WHERE   factfege >= '01-03-2018'
                  AND factfege < '01-04-2018'
                  AND cucofact = factcodi
                  AND cucocodi = cargcuco
                  AND sesunuse = cargnuse
                  AND sesuserv = decode(&Tipo_servicio, -1, sesuserv, &Tipo_servicio)
                  AND cargfecr < '01-04-2018'
                  AND cargcuco > 0
                  AND cargtipr = 'P'
                  AND cargsign = 'SA'
                  AND cargdoso not like 'PA%'
                  AND cargprog in (6,18,42) -- FGCC, FAFS, FGCO
          GROUP BY sesuserv, cargnuse
          --
          UNION ALL
          -- Aplicaciones de Saldo a Favor por Facturación
          SELECT  sesuserv ||' - '|| (select s.servdesc from open.servicio s where s.servcodi = sesuserv) Servicio, 
                  cargnuse producto, '04_AS_Fracion' Movimiento,
                  sum(decode(cargsign,'AS',-cargvalo)) Valor
          FROM    open.cargos, open.servsusc
          WHERE   cargfecr >= '01-03-2018'
                  AND cargfecr <  '01-04-2018'
                  AND sesunuse = cargnuse
                  AND sesuserv = decode(&Tipo_servicio, -1, sesuserv, &Tipo_servicio)
                  AND cargcuco > 0
                  AND cargtipr = 'P'
                  AND cargsign = 'AS'
                  AND cargprog in (6,18,42) -- FGCC, FAFS, FGCO
          GROUP BY sesuserv, cargnuse
          --
          UNION ALL
          -- Notas por concepto afecta cartera
          SELECT  sesuserv ||' - '|| (select s.servdesc from open.servicio s where s.servcodi = sesuserv) Servicio, 
                  cargnuse producto, '05_Not_Cartera' Movimiento,
                  sum(decode(cargsign,'DB',cargvalo, -cargvalo)) Valor
          FROM    open.cargos, open.servsusc
          WHERE   cargfecr >= '01-03-2018'
                  AND cargfecr <  '01-04-2018'
                  AND sesunuse = cargnuse
                  AND sesuserv = decode(&Tipo_servicio, -1, sesuserv, &Tipo_servicio)
                  AND cargcuco > 0
                  AND cargtipr = 'P'
                  AND cargsign in ('DB','CR')
          GROUP BY sesuserv, cargnuse
          --
          UNION ALL
          -- SA de Notas
          SELECT  sesuserv ||' - '|| (select s.servdesc from open.servicio s where s.servcodi = sesuserv) Servicio, 
                  cargnuse producto, '06_SA_Notas' Movimiento,
                  sum(decode(cargsign,'SA',cargvalo)) Valor
          FROM    open.cargos, open.servsusc
          WHERE   cargfecr >= '01-03-2018'
                  AND cargfecr <  '01-04-2018'
                  AND sesunuse = cargnuse
                  AND sesuserv = decode(&Tipo_servicio, -1, sesuserv, &Tipo_servicio)
                  AND cargcuco > 0
                  AND cargtipr = 'P'
                  AND cargsign = 'SA'
                  AND cargdoso not like 'PA%'
                  AND cargprog not in (6,18,42) -- FGCC, FAFS, FGCO
          GROUP BY sesuserv, cargnuse
          --
          UNION ALL
          -- Aplicaciones de Saldo a Favor por Notas
          SELECT  sesuserv ||' - '|| (select s.servdesc from open.servicio s where s.servcodi = sesuserv) Servicio, 
                  cargnuse producto, '07_AS_Notas' Movimiento,
                  sum(decode(cargsign,'AS', -cargvalo)) Valor
          FROM    open.cargos, open.servsusc
          WHERE   cargfecr >= '01-03-2018'
                  AND cargfecr <  '01-04-2018'
                  AND sesunuse = cargnuse
                  AND sesuserv = decode(&Tipo_servicio, -1, sesuserv, &Tipo_servicio)
                  AND cargcuco > 0
                  AND cargtipr = 'P'
                  AND cargsign = 'AS'
                  AND cargprog not in (6,18,42) -- FGCC, FAFS, FGCO
          GROUP BY sesuserv, cargnuse
          --
          UNION ALL
          -- Pagos 
          SELECT  sesuserv ||' - '|| (select s.servdesc from open.servicio s where s.servcodi = sesuserv) Servicio, 
                  cargnuse producto, '08_Recaudo' Movimiento,
                  (sum(decode(cargsign,'PA',-cargvalo,'AP',cargvalo)) - nvl(sum(decode(cargsign,'SA',cargvalo,'NS',-cargvalo)),0)) Valor
          FROM    open.cargos, open.servsusc, open.cupon
          WHERE   cargfecr >= '01-03-2018'
                  AND cargfecr < '01-04-2018'
                  AND sesunuse = cargnuse
                  AND sesuserv = decode(&Tipo_servicio, -1, sesuserv, &Tipo_servicio)
                  AND cargcuco > 0
                  AND cargtipr = 'P'
                  AND cargsign in (/*'SA',*/'PA','AP'/*,'NS'*/)
                  AND (cargdoso like 'PA%' OR cargdoso like 'AP%')
                  AND cargcodo = cuponume -- Garantizar el paso a interfaz por detalle por cupón   resureca
          GROUP BY sesuserv, cargnuse
          --
          UNION ALL
          -- Saldo a favor Pagos 
          SELECT  sesuserv ||' - '|| (select s.servdesc from open.servicio s where s.servcodi = sesuserv) Servicio, 
                  cargnuse producto, '09_SA_Recaudo' Movimiento,
                  (nvl(sum(decode(cargsign,'SA',cargvalo,'NS',-cargvalo)),0)) Valor
          FROM    open.cargos, open.servsusc, open.cupon
          WHERE   cargfecr >= '01-03-2018'
                  AND cargfecr <  '01-04-2018'
                  AND sesunuse = cargnuse
                  AND sesuserv = decode(&Tipo_servicio, -1, sesuserv, &Tipo_servicio)
                  AND cargcuco > 0
                  AND cargtipr = 'P'
                  AND cargsign in ('SA','NS')
                  AND (cargdoso like 'PA%' OR cargdoso like 'AP%')
                  AND cargcodo = cuponume -- Garantizar el paso a interfaz por detalle por cupón   resureca
          GROUP BY sesuserv, cargnuse
          --
          UNION ALL
          -- Movimiento Diferido
          SELECT  sesuserv ||' - '|| (select s.servdesc from open.servicio s where s.servcodi = sesuserv) Servicio, 
                  sesunuse PRODUCTO, '10_Movidife' Movimiento,
                  nvl(sum(decode(modisign,'DB',modivacu, -modivacu)),0) Valor
          FROM    open.movidife, open.servsusc, open.diferido d, open.concepto o
          WHERE   modifech >= '01-03-2018'
            AND   modifech <  '01-04-2018'
            AND   modinuse = sesunuse
            AND   sesuserv = decode(&Tipo_servicio, -1, sesuserv, &Tipo_servicio)
            AND   modivacu > 0
            AND   modidife = d.difecodi
            AND   d.difeconc = o.conccodi
          GROUP BY sesuserv, sesunuse
        )
 )
group by producto
having sum(valor) != 0
)
