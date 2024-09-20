select SAFASESU, s.safacons, s.SAFAFECH, sum(MOSFVALO) TOTAL, decode(safaoriG, 'DE', 'DEPOSITO', 'SALDO A FAVOR') TIPO, '1_SDO_ANT' MVTO_MES
  from open.saldfavo s, open.movisafa m
 where s.safacons = m.mosfsafa
   and s.safafecr < '01-01-2017'
   and m.mosffecr < '01-01-2017'
   and NVL(s.safaorig, 'x') IN ('DE')
group by SAFASESU, SAFAFECH, safaoriG, s.safacons 
HAVING sum(MOSFVALO) != 0
--
UNION ALL
--
select SAFASESU, SAFACONS, SAFAFECH, TOTAL,  TIPO, MVTO_MES
  from (
select sa.SAFASESU, SA.SAFACONS, sa.SAFAFECH, ma.MOSFVALO TOTAL, decode(sa.safaoriG, 'DE', 'DEPOSITO', 'SALDO A FAVOR') TIPO, 
       DECODE(Ma.MOSFDETA, 'DE', '2_DEPOSITO', 'AP', '3_ANULACION', 'AS', '4_APLICA', 'OTROS') MVTO_MES--, Ma.MOSFDETA
  from open.saldfavo sa, open.movisafa ma
 where sa.safacons = ma.mosfsafa
   and ma.mosffecr >= '01-01-2017'
   and ma.mosffecr <  '01-02-2017'
   and ma.mosfvalo <  0
   and (sa.SAFASESU/*, SA.SAFACONS*/) IN (select producto--, numero
                                        from (select SAFASESU producto, s.safacons numero, SAFAFECH, sum(MOSFVALO) TOTAL, 
                                                     decode(safaoriG, 'DE', 'DEPOSITO', 'SALDO A FAVOR') TIPO, '1_SDO_ANT' MVTO_MES
                                                from open.saldfavo s, open.movisafa m
                                               where s.safacons = m.mosfsafa
                                                 and s.safafecr < '01-01-2017'
                                                 and m.mosffecr < '01-01-2017'
                                                 and nvl(s.safaorig, 'x') IN ('DE')
                                              group by SAFASESU, SAFAFECH, safaoriG, s.safacons 
                                              HAVING sum(MOSFVALO) != 0))
        )
 where tipo != 'SALDO A FAVOR'
--
UNION ALL
--
select SAFASESU, S.SAFACONS, SAFAFECH, MOSFVALO TOTAL, decode(safaoriG, 'DE', 'DEPOSITO', 'SALDO A FAVOR') TIPO, 
       DECODE(M.MOSFDETA, 'DE', '2_DEPOSITO', 'AP', '3_ANULACION', 'AS', '4_APLICA', 'OTROS') MVTO_MES
  from open.saldfavo s, open.movisafa m
 where s.safacons = m.mosfsafa
   and m.mosffecr >= '01-01-2017'
   and m.mosffecr <  '01-02-2017'
   and s.safafecr >= '01-01-2017'
   and s.safafecr <  '01-02-2017'
   and NVL(s.safaorig, 'x') IN ('DE')   
--   and m.mosfvalo <  0
