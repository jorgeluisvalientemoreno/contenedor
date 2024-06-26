--optener el plan de facturacion de un servisio
select a.sesuplfa from open.servsusc a where a.sesunuse = 1022310;
---Concepto por servicio
SELECT '1CONCSERV', coseconc, coseconc, coseserv, coseorge,
       0, 0, 0, to_date('1-1-1996', 'dd-mm-yyyy'), 0, coseflim, coseclco,cosefeli
FROM   open.concserv
WHERE  coseacti = 'S' and coseconc = 25;
---Concepto por Ciclo
SELECT '2CONCCICL', cociconc, cociconc, cociserv, cociorge,
  cocicicl, 0, 0, to_date('1-1-1996', 'dd-mm-yyyy'), 0, cociflim,
  cociclco,cocifeli
FROM   open.conccicl
WHERE  cociacti = 'S' and cociconc = 25; 
--CONCEPTO PLAN SUSCRIPCION
SELECT '3CONCPLSU', copsconc, copsconc, copsserv,
      copsorge, 0, 0, 0, to_date('1-1-1996','dd-mm-yyyy'), copsplsu,
      copsflim, copsclco,copsfeli
FROM   open.concplsu
where  copsacti = 'S' and copsconc = 25;
--CONCEPTO / SUSCRIPCION
SELECT '4CONCSUSC', cosuconc, cosuconc, cosuserv, cosuorge,
       0, cosususc, 0, to_date('1-1-1996', 'dd-mm-yyyy'), 0, cosuflim,
       cosuclco,cosufeli
FROM   open.concsusc
WHERE cosuacti = 'S' and cosuconc = 25;
--CONCEPTO FECHA SUSCRIPCION
SELECT distinct '5CONCFESU', cofsconc, cofsconc, cofsserv,
       cofsorge, 0, cofssusc, 0, cofsfech, 0, cofsflim, cofsclco, cofsfeli
FROM   open.concfesu
WHERE  cofsacti = 'S' and cofsconc = 25;
--CONCEPTO POR SERVICIO SUSCRITO
SELECT distinct '6CONCSESU', cossconc, cossconc, cossserv,
       cossorge, 0, 0, cosssesu, to_date('1-1-1996', 'dd-mm-yyyy'), 0,
       cossflim, cossclco, cossfeli
FROM   open.concsesu
WHERE  cossacti = 'S' and cossconc = 25;
--CONCEPTO POR FECHA POR SERVICIO SUSCRITO
SELECT distinct '7CONCFESS', cfssconc, cfssconc, cfssserv,
       cfssorge, 0, 0, cfsssesu, cfssfech, 0, cfssflim, cfssclco, cfssfeli
FROM   open.concfess
WHERE  cfssacti = 'S' and cfssconc = 25;
--Vista de Concepto por facturacion
select * from open.vwconcfact a where a.cofaconc = 25;
--CONCEPTO PLAN SUSCRIPCION
select * from open.CONCPLSU b where b.copsconc = 25 and b.copsplsu = 4;
select gce.*, rowid from open.gr_config_expression gce where gce.config_expression_id=121007322;
