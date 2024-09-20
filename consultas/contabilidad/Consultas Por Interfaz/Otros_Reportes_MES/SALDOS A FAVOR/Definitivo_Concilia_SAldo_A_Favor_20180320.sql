select sesuserv, SAFASESU, s.safacons, s.SAFAFECH, sum(MOSFVALO) TOTAL, decode(safaoriG, 'DE', 'DEPOSITO', 'SALDO A FAVOR') TIPO, '1_SDO_ANT' MVTO_MES, NULL
  from open.saldfavo s, open.movisafa m, OPEN.servsusc sc
 where s.safacons = m.mosfsafa
   and s.safafecr < '01-02-2018'
   and m.mosffecr < '01-02-2018'
   and s.safasesu = sc.sesunuse
--   and NVL(s.safaorig, 'x') not IN ('DE')
group by sesuserv, SAFASESU, SAFAFECH, safaoriG, s.safacons
HAVING sum(MOSFVALO) != 0
--
UNION ALL
--
select sesuserv, SAFASESU, SAFACONS, SAFAFECH, TOTAL, TIPO, MVTO_MES, MOSFDETA
  from (
select sesuserv, sa.SAFASESU, SA.SAFACONS, sa.SAFAFECH, ma.MOSFVALO TOTAL, decode(sa.safaoriG, 'DE', 'DEPOSITO', 'SALDO A FAVOR') TIPO,
       DECODE(Ma.MOSFDETA, 'DE', '2_DEPOSITO', 'PA', '3_SA_PAGO', 'AP', '4_ANULACION', 'AS', '5_APLICA', 'TSF', '6_TRAS_SA', 
                           'CTN', '7_SA_CTA_NEG', 'Devolucion', '8_DEVOL_SA', '9_OTROS') MVTO_MES, Ma.MOSFDETA
  from open.saldfavo sa, open.movisafa ma, OPEN.servsusc sc
 where sa.safacons = ma.mosfsafa
   and sa.safasesu = sc.sesunuse
   and ma.mosffecr >= '01-02-2018'
   and ma.mosffecr <  '01-03-2018'
   and ma.mosfvalo <  0
   and (sa.SAFASESU, SA.SAFACONS) IN (select producto, numero
                                        from (select SAFASESU producto, s.safacons numero, SAFAFECH, sum(MOSFVALO) TOTAL,
                                                     decode(safaoriG, 'DE', 'DEPOSITO', 'SALDO A FAVOR') TIPO, '1_SDO_ANT' MVTO_MES
                                                from open.saldfavo s, open.movisafa m
                                               where s.safacons = m.mosfsafa
                                                 and s.safafecr < '01-02-2018'
                                                 and m.mosffecr < '01-02-2018'
                                              --   and nvl(s.safaorig, 'x') not IN ('DE')
                                              group by SAFASESU, SAFAFECH, safaoriG, s.safacons
                                              HAVING sum(MOSFVALO) != 0))
        )
-- where tipo != 'SALDO A FAVOR'
--
UNION ALL
--
select sesuserv, SAFASESU, S.SAFACONS, SAFAFECH, MOSFVALO TOTAL, decode(safaoriG, 'DE', 'DEPOSITO', 'SALDO A FAVOR') TIPO,
       DECODE(M.MOSFDETA, 'DE', '2_DEPOSITO', 'PA', '3_SA_PAGO', 'AP', '4_ANULACION', 'AS', '5_APLICA', 'TSF', '6_TRAS_SA', 
                          'CTN', '7_SA_CTA_NEG', 'Devolucion', '8_DEVOL_SA', '9_OTROS') MVTO_MES, M.MOSFDETA
  from open.saldfavo s, open.movisafa m, OPEN.servsusc sc
 where s.safacons = m.mosfsafa
   and s.safasesu = sc.sesunuse
   and m.mosffecr >= '01-02-2018'
   and m.mosffecr <  '01-03-2018'
   and s.safafecr >= '01-02-2018'
   and s.safafecr <  '01-03-2018'
--   and NVL(s.safaorig, 'x') not IN ('DE')
--
UNION ALL
--
select sesuserv, SAFASESU, safacons, SAFAFECH, sum(-total) TOTAL, TIPO, MVTO_MES, NULL
from 
(
select sesuserv, SAFASESU, s.safacons, s.SAFAFECH, sum(MOSFVALO) TOTAL, decode(safaoriG, 'DE', 'DEPOSITO', 'SALDO A FAVOR') TIPO, 'CTN', '90_SDO_FIN' MVTO_MES, 
       NULL
  from open.saldfavo s, open.movisafa m, OPEN.servsusc sc
 where s.safacons = m.mosfsafa
   and s.safasesu = sc.sesunuse
   and s.safafecr < '01-03-2018'
   and m.mosffecr < '01-03-2018'
--   and NVL(s.safaorig, 'x') not IN ('DE')
group by sesuserv, SAFASESU, SAFAFECH, safaoriG, s.safacons
HAVING sum(MOSFVALO) != 0
) group by sesuserv, SAFASESU, safacons, SAFAFECH, TIPO, MVTO_MES
