select  a.product_id ,sesuesco,sesuesfn ,product_status_id, sesucate, sesusuca,
(select count ( distinct (c1.cosspecs)) 
 from open.conssesu c1 
 where c1.cosssesu = a.product_id 
 and c1.cosssesu = sesunuse 
 and c1.cosscoca = 0 
 and c1.cosspecs >= '102788'
 and c1.cossmecc in (1,3) ) as cons_cero,
(select count ( distinct (o4.order_id)) 
 from open.or_order o4, open.or_order_activity a4
 where o4.order_id = a4.order_id 
 and a4.product_id = a.product_id
 and a4.activity_id in (4000031,4000949,4000971,4000972,4000973,4000980,4001237,4001238,100007144,100009032,100009033,100009034,100009035,100009039,100009152,100009153,100009154,100009155,100009277,
                                  100009278,100009279,100009280,100009281,100009421,100009422,100007375,100007376,100009156,100009157,100009154)
 and o4.order_status_id in (0,5) ) as ot_onl_8_pend,
(select count ( distinct (o7.order_id)) 
 from open.or_order o7, open.or_order_activity a7
 where o7.order_id = a7.order_id 
 and a7.product_id = a.product_id
 and a7.activity_id in (4000031,4000949,4000971,4000972,4000973,4000980,4001237,4001238,100007144,100009032,100009033,100009034,100009035,100009039,100009152,100009153,100009154,100009155,100009277,
                                  100009278,100009279,100009280,100009281,100009421,100009422,100007375,100007376,100009156,100009157,100009154)
 and o7.order_status_id in (8)
 and o7.legalization_date >'08/03/2023' ) as ot_onl_8_Liq,
 (select count ( distinct (o3.order_id)) 
 from open.or_order o3, open.or_order_activity a3
 where o3.order_id = a3.order_id 
 and a3.product_id = a.product_id
 and a3.activity_id in (100009283)
 and o3.order_status_id in (0,5)) as ot_onl_38_pend,
(select count ( distinct (o8.order_id)) 
 from open.or_order o8, open.or_order_activity a8
 where o8.order_id = a8.order_id 
 and a8.product_id = a.product_id
 and a8.activity_id in (100009283)
 and o8.order_status_id in (8)
 and o8.legalization_date >'08/03/2023' ) as ot_onl_38_liq,
(select count ( distinct (o2.order_id)) 
 from open.or_order o2, open.or_order_activity a2
 where o2.order_id = a2.order_id 
 and a2.product_id = a.product_id
 and a2.activity_id in (4000949)
 and o2.order_status_id in (8)
 and o2.legalization_date >'22/02/2023' ) as ot_onl_64_liq, 
 (select count ( distinct (o9.order_id)) 
 from open.or_order o9, open.or_order_activity a9
 where o9.order_id = a9.order_id 
 and a9.product_id = a.product_id
 and a9.activity_id in (4000949)
 and o9.order_status_id in (0,5) ) as ot_onl_64_pend, 
 (select count ( distinct (o1.order_id)) 
 from open.or_order o1, open.or_order_activity a1
 where o1.order_id = a1.order_id 
 and a1.product_id = a.product_id
 and a1.activity_id in (4000031)
 and o1.order_status_id in (0,5) ) as ot_onl_82_pend, 
 (select count ( distinct (o10.order_id)) 
 from open.or_order o10, open.or_order_activity a10
 where o10.order_id = a10.order_id 
 and a10.product_id = a.product_id
 and a10.activity_id in (4000031)
 and o10.order_status_id in (8)
 and o10.legalization_date >'22/02/2023'  ) as ot_onl_82_liq, 
  (select count ( distinct (o5.order_id)) 
 from open.or_order o5, open.or_order_activity a5
 where o5.order_id = a5.order_id 
 and a5.product_id = a.product_id
 and a5.activity_id in (400980)
 and o5.order_status_id in (0,5)
 and o5.legalization_date >'22/02/2023' ) as ot_onl_12_pen,
(select count ( distinct (o6.order_id)) 
 from open.or_order o6, open.or_order_activity a6
 where o6.order_id = a6.order_id 
 and a6.product_id = a.product_id
 and a6.activity_id in (4000980)
 and o6.order_status_id in (8)
 and o6.legalization_date >'22/02/2023' ) as ot_onl_12_leg,
 case when  (select count (cpsccons)
           from ldc_coprsuca co 
           where co.cpscubge = ab.geograp_location_id 
           and co.cpsccate = sesucate 
           and co.cpscsuca = sesusuca ) > 0 then 'Tiene_prom_sub' 
    when ( select count (cpsccons)
          from ldc_coprsuca co 
          where co.cpscubge = ab.geograp_location_id 
          and co.cpsccate = sesucate 
          and co.cpscsuca = sesusuca ) = 0 then 'No_tiene_prom_sub' end as cons_sub,
case when (select count (hcppcons)
            from hicoprpm h1
            where h1.hcppsesu= sesunuse 
            and hcpppeco =  103625 ) > 0 then 'si_cpp' 
    when   (select count (hcppcons)
            from hicoprpm h1
            where h1.hcppsesu= sesunuse 
            and hcpppeco =  103625 ) = 0 then 'No_cpp' end as cons_pp , 
a.order_id||'|'||8017||'|'||'38963||'||a.order_activity_id||'>'||'1'||';'||  regexp_substr( i.value2,'COMMENT1>[^>]*')||'>>'||';;;'||'|||'||'1277'||';OSF-654|'||
substrc ( i.exec_initial_date,1,19) ||';'|| substrc ( i.execution_final_date,1,19) as cadena_legalizacion
from open.or_order r
left join open.or_order_activity a  on a.order_id = r.order_id 
left join open.servsusc on a.product_id = sesunuse
left join open.pericose p on sesucicl = p.pecscico
left join open.pr_product pr on pr.product_id = sesunuse and pr.subscription_id = sesususc 
left join open.infopuerto i on i.cosssesu = a.product_id and i.task_type_id = 10043
left join open.ab_address ab on  pr.address_id = ab.address_id 
where sesucicl  in (1201)
and pecscons in (103625)
and r.task_type_id in (10043)
and r.order_status_id not in (8,12)
and sesucate = 2
--and i.cosscavc = 2015      
order by r.legalization_date desc
