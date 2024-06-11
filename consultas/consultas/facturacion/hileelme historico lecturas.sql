"select 'LECTELME' Tabla, pefaano,pefames,l.leemsesu,
       o.task_type_id || ' - ' || (select tt.description from open.or_task_type tt where tt.task_type_id = o.task_type_id) tipotrab,
       l.leemelme,leempefa,leempecs,leemfele,LEEMLEAN,leemleto,/*l.leemfame,*/
       leemoble,
       (select obledesc from open.obselect where oblecodi=leemoble) descobse, leemdocu,
       l.leemclec, l.leemflco, o.legalization_date
  from open.lectelme l, open.perifact p, open.or_order o, open.or_order_Activity a
 where pefacodi=leempefa
   and l.leemdocu=a.order_activity_id
   and a.order_id=o.order_id
   and pefaano>=2018
   and leemsesu=51185130 -- 6096923 -- 50004576
union
select 'Historico' Tabla, pefaano, pefames, leemsesu, tipotrab,leemelme,leempefa,leempecs,leemfele,LEEMLEAN,leemleto,
       leemoble,(select obledesc from open.obselect where oblecodi=leemoble) descobse, leemdocu,
       leemclec, leemflco, legalization_date
from
(select  a.product_id leemsesu, o.task_type_id || ' - ' || (select tt.description from open.or_task_type tt where tt.task_type_id = o.task_type_id) tipotrab,
       (select l.leempefa from open.lectelme l where h.hlemelme = l.leemcons) leempefa,
       (select l.leempecs from open.lectelme l where h.hlemelme = l.leemcons) leempecs,
        h.hlemfele leemfele, null leemlean, h.hlemleto leemleto, h.hlemoble leemoble,
        (select obledesc from open.obselect where oblecodi=hlemoble) descobse, NULL leemelme,
       h.hlemdocu leemdocu, null leemclec, null leemflco, o.legalization_date
  from open.hileelme h, open.or_order o, open.or_order_Activity a
 where h.hlemdocu=a.order_activity_id
   and a.order_id=o.order_id
   and h.hlemdocu in (select a.order_activity_id
                       from open.or_order o
                       left outer join open.or_order_Activity a on (o.order_id = a.order_id)
                       where a.product_id=51185130
                         and o.task_type_id in (12617,10043)
                         and o.created_Date >= to_Date('01/01/2018','dd/mm/yyyy'))) a,
open.perifact p
where pefacodi=leempefa
order by leemfele"
"select pefaano,pefames, cosssesu, cosspefa, cosspecs, cossfere, C.COSSELME, C.COSSDICO, cossmecc,
       (select meccdesc from open.mecacons where mecccodi=cossmecc) descmecal,
       cosscoca, C.COSSFLLI, /*c.cossidre,*/ c.cosscavc,c.cossfufa,
       (select v.fccofaco from open.CM_FACOCOSS v where v.fccocons = c.cossfcco) faco
  from open.conssesu c, open.perifact p
 where cosspefa=pefacodi
   and pefaano>=2018
   and cosssesu=51185130
  order by cosspefa,c.cossfere"
"select pefaano ano, pefames mes, cargnuse nuse, cargconc conc, cargfecr fecr, cargcaca caca, cargsign sign, cargunid unid,
       cargvalo valo, CARGVALO/CARGUNID VLRUNID, cargdoso doso, cargprog prog,
       (Select proccodi from open.procesos p where cargprog = p.proccons) proceso
  from open.cargos, open.perifact
 where cargpefa=pefacodi
   and cargconc=31
   and cargnuse=51185130
   and pefaano>=2018
   and substr(cargdoso,1,3) not in ('DF-','FD-')
 order by pefacodi"
