-- Detalle por producto
SELECT caccserv ||' - '|| (select s.servdesc from open.servicio s where s.servcodi = caccserv) Servicio,
       caccnuse producto, '01_Sdo_Inicial' Movimiento,
       nvl(sum(caccsape),0) VALOR
  FROM OPEN.ic_cartcoco c, open.concepto o
 WHERE caccnuse = &producto
   AND caccfege = to_date('&Cierre_mes_Anterior','dd-mm-yyyy')  --to_date(&fecha_final_anterior) --to_date('&Cierre_mes_Anterior', 'dd-mm-yyyy') + 1 - 1
 --and caccserv = decode(:Tipo_servicio, -1, caccserv, :Tipo_servicio)
   AND c.caccconc = o.conccodi
GROUP BY caccserv, caccnuse
--
UNION ALL
-- SALDO FINAL
SELECT caccserv ||' - '|| (select s.servdesc from open.servicio s where s.servcodi = caccserv) Servicio,
       caccnuse producto, '17_Sdo_Cierre' Movimiento,
       nvl(sum(-caccsape),0) VALOR
  FROM OPEN.ic_cartcoco, open.concepto o
 WHERE caccnuse = &producto
   AND caccfege = to_date(' &cierre_mes_actual','dd-mm-yyyy')
 --and caccserv = decode(:Tipo_servicio, -1, caccserv, :Tipo_servicio)
   AND caccconc = conccodi
GROUP BY caccserv, caccnuse
--
UNION ALL
--
-- Facturación por Concepto Afecta Cartera
SELECT  sesuserv ||' - '|| (select s.servdesc from open.servicio s where s.servcodi = sesuserv) Servicio, 
        cargnuse producto, '02_Frac_Cartera' Movimiento,
        sum(decode(cargsign,'DB',cargvalo, -cargvalo)) Valor
FROM    open.cargos,
        open.servsusc,
        open.cuencobr,
        open.factura
WHERE   factfege >= to_date('&Cierre_mes_Anterior', 'dd-mm-yyyy') + 1 --to_date('&Cierre_mes_Anterior', 'dd-mm-yyyy') + 1
        AND factfege < to_date('&cierre_mes_actual', 'dd-mm-yyyy') + 1
        AND cucofact = factcodi
        AND cucocodi = cargcuco
        AND sesunuse = cargnuse
        AND cargnuse = &producto
        --AND sesuserv = decode(:Tipo_servicio, -1, sesuserv, :Tipo_servicio)
        AND cargfecr <  to_date('&cierre_mes_actual', 'dd-mm-yyyy') + 1
        AND cargcuco > 0
        AND cargtipr = 'A'
        AND cargsign in ('DB','CR')
        AND cargcaca not in (20,23,46,50,51,56)
        --AND cargnuse  = producto
GROUP BY sesuserv, cargnuse
--
UNION ALL
--
-- Facturación por Concepto Efecto Neutro
select  sesuserv ||' - '|| (select s.servdesc from open.servicio s where s.servcodi = sesuserv) Servicio, 
        cargnuse producto, '03_Frac_Neutra' Movimiento,
        sum(decode(cargsign,'DB',cargvalo, -cargvalo)) Valor
FROM    open.cargos,
        open.servsusc,
        open.cuencobr,
        open.factura
WHERE   factfege >= to_date('&Cierre_mes_Anterior', 'dd-mm-yyyy') + 1
        AND factfege < to_date('&cierre_mes_actual', 'dd-mm-yyyy') + 1
        AND cucofact = factcodi
        AND cucocodi = cargcuco
        AND sesunuse = cargnuse
        AND cargnuse = &producto
        --AND sesuserv = decode(:Tipo_servicio, -1, sesuserv, :Tipo_servicio)
        AND cargfecr < to_date('&cierre_mes_actual', 'dd-mm-yyyy') + 1
        AND cargcuco > 0
        AND cargtipr = 'A'
        AND cargsign in ('DB','CR')
        AND cargcaca in (20,23,46,50,51,56)
        --AND cargnuse  = producto
GROUP BY sesuserv, cargnuse
--
UNION ALL
--
-- SA de Facturación
SELECT  sesuserv ||' - '|| (select s.servdesc from open.servicio s where s.servcodi = sesuserv) Servicio, 
        cargnuse producto, '04_SA_Fracion' Movimiento,
        sum(decode(cargsign,'SA',cargvalo)) Valor
FROM    open.cargos, open.servsusc, open.cuencobr, open.factura
WHERE   factfege >= to_date('&Cierre_mes_Anterior', 'dd-mm-yyyy') + 1
        AND factfege < to_date('&cierre_mes_actual', 'dd-mm-yyyy') + 1
        AND cucofact = factcodi
        AND cucocodi = cargcuco
        AND sesunuse = cargnuse
        AND cargnuse = &producto
        --AND sesuserv = decode(:Tipo_servicio, -1, sesuserv, :Tipo_servicio)
        AND cargfecr < to_date('&cierre_mes_actual', 'dd-mm-yyyy') + 1
        AND cargcuco > 0
        AND cargtipr = 'P'
        AND cargsign = 'SA'
        AND cargdoso not like 'PA%'
        AND cargprog in (6,18,42) -- FGCC, FAFS, FGCO
        --AND cargnuse  = producto
GROUP BY sesuserv, cargnuse
--
UNION ALL
--
-- Aplicaciones de Saldo a Favor por Facturación
SELECT  sesuserv ||' - '|| (select s.servdesc from open.servicio s where s.servcodi = sesuserv) Servicio, 
        cargnuse producto, '05_AS_Fracion' Movimiento,
        sum(decode(cargsign,'AS',-cargvalo)) Valor
FROM    open.cargos, open.servsusc
WHERE   cargfecr >= to_date('&Cierre_mes_Anterior', 'dd-mm-yyyy') + 1
        AND cargfecr < to_date('&cierre_mes_actual', 'dd-mm-yyyy') + 1
        AND sesunuse = cargnuse
        AND cargnuse = &producto
        --AND sesuserv = decode(:Tipo_servicio, -1, sesuserv, :Tipo_servicio)
        AND cargcuco > 0
        AND cargtipr = 'P'
        AND cargsign = 'AS'
        AND cargprog in (6,18,42) -- FGCC, FAFS, FGCO
        --AND cargnuse  = producto
GROUP BY sesuserv, cargnuse
--
UNION ALL
--
-- Notas por concepto afecta cartera
SELECT  sesuserv ||' - '|| (select s.servdesc from open.servicio s where s.servcodi = sesuserv) Servicio, 
        cargnuse producto, '06_Not_Cartera' Movimiento,
        sum(decode(cargsign,'DB',cargvalo, -cargvalo)) Valor
FROM    open.cargos, open.servsusc
WHERE   cargfecr >= to_date('&Cierre_mes_Anterior', 'dd-mm-yyyy') + 1
        AND cargfecr < to_date('&cierre_mes_actual', 'dd-mm-yyyy') + 1
        AND sesunuse = cargnuse
        AND cargnuse = &producto
        --AND sesuserv = decode(:Tipo_servicio, -1, sesuserv, :Tipo_servicio)
        AND cargcuco > 0
        AND cargtipr = 'P'
        AND cargsign in ('DB','CR')
        AND cargcaca not in (2,58,20,23,27,45,46,50,51,56)
        --AND cargnuse  = producto
GROUP BY sesuserv, cargnuse
--
UNION ALL
--
-- Notas por concepto Usuarios castigados
SELECT  sesuserv ||' - '|| (select s.servdesc from open.servicio s where s.servcodi = sesuserv) Servicio, 
        cargnuse producto, '07_Not_Castigo' Movimiento,
        sum(decode(cargsign,'DB',cargvalo, -cargvalo)) Valor
FROM    open.cargos, open.servsusc
WHERE   cargfecr >= to_date('&Cierre_mes_Anterior', 'dd-mm-yyyy') + 1
        AND cargfecr < to_date('&cierre_mes_actual', 'dd-mm-yyyy') + 1
        AND sesunuse = cargnuse
        AND cargnuse = &producto
        --AND sesuserv = decode(:Tipo_servicio, -1, sesuserv, :Tipo_servicio)
        AND cargcuco > 0
        AND cargtipr = 'P'
        AND cargsign in ('DB','CR')
        AND cargcaca in (2)
        --AND cargnuse  = producto
GROUP BY sesuserv, cargnuse
--
UNION ALL
--
-- Notas por concepto usuarios recuperados
SELECT  sesuserv ||' - '|| (select s.servdesc from open.servicio s where s.servcodi = sesuserv) Servicio, 
        cargnuse producto, '08_Not_Recupera' Movimiento,
        sum(decode(cargsign,'DB',cargvalo, -cargvalo)) Valor
FROM    open.cargos, open.servsusc
WHERE   cargfecr >= to_date('&Cierre_mes_Anterior', 'dd-mm-yyyy') + 1
        AND cargfecr < to_date('&cierre_mes_actual', 'dd-mm-yyyy') + 1
        AND sesunuse = cargnuse
        AND cargnuse = &producto
        --AND sesuserv = decode(:Tipo_servicio, -1, sesuserv, :Tipo_servicio)
        AND cargcuco > 0
        AND cargtipr = 'P'
        AND cargsign in ('DB','CR')
        AND cargcaca in (58)
        --AND cargnuse  = producto
GROUP BY sesuserv, cargnuse
--
UNION ALL
-- Notas por concepto efecto Neutro
SELECT  sesuserv ||' - '|| (select s.servdesc from open.servicio s where s.servcodi = sesuserv) Servicio, 
        cargnuse producto, '09_Not_Neutro' Movimiento,
        sum(decode(cargsign,'DB',cargvalo, -cargvalo)) Valor
FROM    open.cargos, open.servsusc
WHERE   cargfecr >= to_date('&Cierre_mes_Anterior', 'dd-mm-yyyy') + 1
        AND cargfecr < to_date('&cierre_mes_actual', 'dd-mm-yyyy') + 1
        AND sesunuse = cargnuse
        AND cargnuse = &producto
        --AND sesuserv = decode(:Tipo_servicio, -1, sesuserv, :Tipo_servicio)
        AND cargcuco > 0
        AND cargtipr = 'P'
        AND cargsign in ('DB','CR')
        AND cargcaca in (20,46,50,51,56)
        --AND cargnuse  = producto
GROUP BY sesuserv, cargnuse
--
UNION ALL
--
-- SA de Notas
SELECT  sesuserv ||' - '|| (select s.servdesc from open.servicio s where s.servcodi = sesuserv) Servicio, 
        cargnuse producto, '10_SA_Notas' Movimiento,
        sum(decode(cargsign,'SA',cargvalo)) Valor
FROM    open.cargos, open.servsusc
WHERE   cargfecr >= to_date('&Cierre_mes_Anterior', 'dd-mm-yyyy') + 1
        AND cargfecr < to_date('&cierre_mes_actual', 'dd-mm-yyyy') + 1
        AND sesunuse = cargnuse
        AND cargnuse = &producto
        --AND sesuserv = decode(:Tipo_servicio, -1, sesuserv, :Tipo_servicio)
        AND cargcuco > 0
        AND cargtipr = 'P'
        AND cargsign = 'SA'
        AND cargdoso not like 'PA%'
        AND cargprog not in (6,18,42) -- FGCC, FAFS, FGCO
        --AND cargnuse  = producto
GROUP BY sesuserv, cargnuse
--
UNION ALL
--
-- Aplicaciones de Saldo a Favor por Notas
SELECT  sesuserv ||' - '|| (select s.servdesc from open.servicio s where s.servcodi = sesuserv) Servicio, 
        cargnuse producto, '11_AS_Notas' Movimiento,
        sum(decode(cargsign,'AS', -cargvalo)) Valor
FROM    open.cargos, open.servsusc
WHERE   cargfecr >= to_date('&Cierre_mes_Anterior', 'dd-mm-yyyy') + 1
        AND cargfecr < to_date('&cierre_mes_actual', 'dd-mm-yyyy') + 1
        AND sesunuse = cargnuse
        AND cargnuse = &producto
        --AND sesuserv = decode(:Tipo_servicio, -1, sesuserv, :Tipo_servicio)
        AND cargcuco > 0
        AND cargtipr = 'P'
        AND cargsign = 'AS'
        AND cargprog not in (6,18,42) -- FGCC, FAFS, FGCO
        --AND cargnuse  = producto
GROUP BY sesuserv, cargnuse
--
UNION ALL
-- Notas por concepto Cruce de cuentas
SELECT  sesuserv ||' - '|| (select s.servdesc from open.servicio s where s.servcodi = sesuserv) Servicio, 
        cargnuse producto, '12_Cruce_Cta' Movimiento,
        sum(decode(cargsign,'DB',cargvalo, -cargvalo)) Valor
FROM    open.cargos, open.servsusc
WHERE   cargfecr >= to_date('&Cierre_mes_Anterior', 'dd-mm-yyyy') + 1
        AND cargfecr < to_date('&cierre_mes_actual', 'dd-mm-yyyy') + 1
        AND sesunuse = cargnuse
        AND cargnuse = &producto
        --AND sesuserv = decode(:Tipo_servicio, -1, sesuserv, :Tipo_servicio)
        AND cargcuco > 0
        AND cargtipr = 'P'
        AND cargsign in ('DB','CR')
        AND cargcaca in (23)
        --AND cargnuse  = producto
GROUP BY sesuserv, cargnuse
--
UNION ALL
-- Notas por concepto Cheques devuelto
SELECT  sesuserv ||' - '|| (select s.servdesc from open.servicio s where s.servcodi = sesuserv) Servicio, 
        cargnuse producto, '13_Cheq_Devuelto' Movimiento,
        sum(decode(cargsign,'DB',cargvalo, -cargvalo)) Valor
FROM    open.cargos, open.servsusc
WHERE   cargfecr >= to_date('&Cierre_mes_Anterior', 'dd-mm-yyyy') + 1
        AND cargfecr < to_date('&cierre_mes_actual', 'dd-mm-yyyy') + 1
        AND sesunuse = cargnuse
        AND cargnuse = &producto
        --AND sesuserv = decode(:Tipo_servicio, -1, sesuserv, :Tipo_servicio)
        AND cargcuco > 0
        AND cargtipr = 'P'
        AND cargsign in ('DB','CR')
        AND cargcaca in (45)
        --AND cargnuse  = producto
GROUP BY sesuserv, cargnuse
--
UNION ALL
-- Pagos 
SELECT  sesuserv ||' - '|| (select s.servdesc from open.servicio s where s.servcodi = sesuserv) Servicio, 
        cargnuse producto, '14_Recaudo' Movimiento,
        (sum(decode(cargsign,'PA',-cargvalo,'AP',cargvalo)) - nvl(sum(decode(cargsign,'SA',cargvalo,'NS',-cargvalo)),0)) Valor
FROM    open.cargos, open.servsusc, open.cupon
WHERE   cargfecr >= to_date('&Cierre_mes_Anterior', 'dd-mm-yyyy') + 1
        AND cargfecr < to_date('&cierre_mes_actual', 'dd-mm-yyyy') + 1
        AND sesunuse = cargnuse
        AND cargnuse = &producto
        --AND sesuserv = decode(:Tipo_servicio, -1, sesuserv, :Tipo_servicio)
        AND cargcuco > 0
        AND cargtipr = 'P'
        AND cargsign in (/*'SA',*/'PA','AP'/*,'NS'*/)
        AND (cargdoso like 'PA%' OR cargdoso like 'AP%')
        AND cargcodo = cuponume -- Garantizar el paso a interfaz por detalle por cupón   resureca
        --AND cargnuse  = producto
GROUP BY sesuserv, cargnuse
--
UNION ALL
--                  
-- Saldo a favor Pagos 
SELECT  sesuserv ||' - '|| (select s.servdesc from open.servicio s where s.servcodi = sesuserv) Servicio, 
        cargnuse producto, '15_SA_Recaudo' Movimiento,
        (nvl(sum(decode(cargsign,'SA',cargvalo,'NS',-cargvalo)),0)) Valor
FROM    open.cargos, open.servsusc, open.cupon
WHERE   cargfecr >= to_date('&Cierre_mes_Anterior', 'dd-mm-yyyy') + 1
        AND cargfecr < to_date('&cierre_mes_actual', 'dd-mm-yyyy') + 1
        AND sesunuse = cargnuse
        AND cargnuse = &producto
        --AND sesuserv = decode(:Tipo_servicio, -1, sesuserv, :Tipo_servicio)
        AND cargcuco > 0
        AND cargtipr = 'P'
        AND cargsign in ('SA','NS')
        AND (cargdoso like 'PA%' OR cargdoso like 'AP%')
        AND cargcodo = cuponume -- Garantizar el paso a interfaz por detalle por cupón   resureca
        --AND cargnuse  = producto
GROUP BY sesuserv, cargnuse                  
--
UNION ALL
--
SELECT  sesuserv ||' - '|| (select s.servdesc from open.servicio s where s.servcodi = sesuserv) Servicio, 
        sesunuse PRODUCTO, '16_Movidife' Movimiento,
        nvl(sum(decode(modisign,'DB',modivacu, -modivacu)),0) Valor
FROM    open.movidife, open.servsusc, open.diferido d, open.concepto o
WHERE   modifech >= to_date('&Cierre_mes_Anterior', 'dd-mm-yyyy') + 1
  AND   modifech < to_date('&cierre_mes_actual', 'dd-mm-yyyy') + 1
  AND   modinuse = sesunuse
  AND   modinuse = &producto
  --AND   sesuserv = decode(:Tipo_servicio, -1, sesuserv, :Tipo_servicio)
  AND   modivacu > 0
  AND   modidife = d.difecodi
  AND   d.difeconc = o.conccodi
  --AND   modinuse = producto
GROUP BY sesuserv, sesunuse          
