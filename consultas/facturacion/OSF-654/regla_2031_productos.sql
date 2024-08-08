--2031
select  a.product_id,r.operating_unit_id, r.order_status_id,sesuesco,sesuesfn ,product_status_id,ab.geograp_location_id, sesucate, sesusuca, ROUND(i.execution_final_date - sesufein)  dias,
case when  (select count (cpsccons)
           from ldc_coprsuca co 
           where co.cpscubge = ab.geograp_location_id 
           and co.cpsccate = sesucate 
           and co.cpscsuca = sesusuca) > 0 then 'Tiene_prom_sub' 
    when ( select count (cpsccons)
          from ldc_coprsuca co 
          where co.cpscubge = ab.geograp_location_id 
          and co.cpsccate = sesucate 
          and co.cpscsuca = sesusuca ) = 0 then 'No_tiene_prom_sub' end as cons_sub,
case when (select count (hcppcons)
            from hicoprpm h1
            where h1.hcppsesu= sesunuse 
            and hcpppeco =  101581 ) > 0 then 'si_cpp' 
    when   (select count (hcppcons)
            from hicoprpm h1
            where h1.hcppsesu= sesunuse 
            and hcpppeco =  101581 ) = 0 then 'No_cpp' end as cons_pp , 
(select co1.cpsccoto / co1.cpscprod
           from ldc_coprsuca co1 
           where co1.cpscubge = ab.geograp_location_id 
           and co1.cpsccate = sesucate 
           and co1.cpscsuca = sesusuca
           and co1.cpscanco = 2022
           and co1.cpscmeco = 9 ) as cpps,i.value1,i.value2,
substrc(substrc( i.value1,9,4),1,2) lectura,
(select leemlean Lectura_ant
         from open.lectelme l1 
         where l1.leemsesu =  sesunuse
         and l1.leempecs = pecscons
         and l1.leemfela = (select (max(l2.leemfela)) from lectelme l2 where l1.leemsesu = l2.leemsesu  )) lect_ant ,
 a.order_id||'|'||9688||'|'||'38963||'||a.order_activity_id||'>'||'1'||';'||  regexp_substr( i.value1,'READING>[^>]*')||'>>'||';;;'||'|||'||'1277'||';OSF-654|'||
substrc ( i.exec_initial_date,1,19) ||';'|| substrc ( i.execution_final_date,1,19) as cadena_legalizacion
from open.or_order r
left join open.or_order_activity a  on a.order_id = r.order_id 
left join open.servsusc on a.product_id = sesunuse
left join open.pericose p on sesucicl = p.pecscico
left join open.pr_product pr on pr.product_id = sesunuse and pr.subscription_id = sesususc 
left join open.infopl_654 i on i.cosssesu = a.product_id and i.task_type_id = 12617
left join open.ab_address ab on  pr.address_id = ab.address_id 
left join open.hicoprpm on hcppsesu = a.product_id and  hcppsesu = sesunuse 
where sesucicl  in (1201)
and pecscons =101983
and r.task_type_id in (12617)
and r.order_status_id  in (5)
and i.cosscavc = 2031
order by r.legalization_date desc