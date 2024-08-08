select  a.product_id ,sesuesco,sesuesfn ,product_status_id, sesucate, sesusuca,
case when  (select count ( distinct (o2.order_id)) from open.or_order o2, open.or_order_activity a2
           where o2.order_id = a2.order_id 
           and  a2.product_id = a.product_id
             and a2.activity_id in (100009154,4000980,100009283,4000980,4000949,4000980,4000980,4000980,100009154,4000031)
           and o2.order_status_id in (8)
           and o2.legalization_date >'01/02/2023' )>0 then 'Hay ot_config_leg '
     when  (select count ( distinct (o2.order_id)) from open.or_order o2, open.or_order_activity a2
           where o2.order_id = a2.order_id 
           and  a2.product_id = a.product_id
             and a2.activity_id in (100009154,4000980,100009283,4000980,4000949,4000980,4000980,4000980,100009154,4000031)
           and o2.order_status_id in (8)
           and o2.legalization_date >'01/02/2023' )=0 then 'No hay ot_config_leg ' end as ot_config_leg,
case when (select count ( distinct (o3.order_id)) from open.or_order o3, open.or_order_activity a3
           where o3.order_id = a3.order_id 
           and  a3.product_id = a.product_id
           and a3.activity_id in (100009154,4000980,100009283,4000980,4000949,4000980,4000980,4000980,100009154,4000031)
           and o3.order_status_id in (0,5,7)) >0 then 'hay ot_config_pend'
     when (select count ( distinct (o3.order_id)) from open.or_order o3, open.or_order_activity a3
           where o3.order_id = a3.order_id 
           and  a3.product_id = a.product_id
           and a3.activity_id in (100009154,4000980,100009283,4000980,4000949,4000980,4000980,4000980,100009154,4000031)
           and o3.order_status_id in (0,5,7)) = 0 then 'No hay ot_config_pend' end as ot_config_pend  ,
case  when (select count ( distinct (o4.order_id)) from open.or_order o4, open.or_order_activity a4
           where o4.order_id = a4.order_id 
           and  a4.product_id = a.product_id
           and a4.activity_id in (4000031,4000949,4000971,4000972,4000973,4000980,4001237,4001238,100007144,100009032,100009033,100009034,100009035,100009039,100009152,100009153,100009154,100009155,100009277,
                                  100009278,100009279,100009280,100009281,100009421,100009422,100007375,100007376,100009156,100009157)
           and o4.order_status_id in (0,5,7))>0 then 'Hay ot_onl_8_pend'          
      when (select count ( distinct (o4.order_id)) from open.or_order o4, open.or_order_activity a4
           where o4.order_id = a4.order_id 
           and  a4.product_id = a.product_id
           and a4.activity_id in (4000031,4000949,4000971,4000972,4000973,4000980,4001237,4001238,100007144,100009032,100009033,100009034,100009035,100009039,100009152,100009153,100009154,100009155,100009277,
                                  100009278,100009279,100009280,100009281,100009421,100009422,100007375,100007376,100009156,100009157)
           and o4.order_status_id in (0,5,7))=0 then 'No hay ot_onl_8_pend' end as ot_onl_8_pend , 
case when (select count ( distinct (o4.order_id)) from open.or_order o4, open.or_order_activity a4
           where o4.order_id = a4.order_id 
           and  a4.product_id = a.product_id
           and a4.activity_id in (4000031,4000949,4000971,4000972,4000973,4000980,4001237,4001238,100007144,100009032,100009033,100009034,100009035,100009039,100009152,100009153,100009154,100009155,100009277,
                                  100009278,100009279,100009280,100009281,100009421,100009422,100007375,100007376,100009156,100009157)
           and o4.order_status_id in (8)
           and o4.legalization_date >'01/02/2023' )  > 0 then 'Hay ot_onl_8_liq'
     when (select count ( distinct (o4.order_id)) from open.or_order o4, open.or_order_activity a4
           where o4.order_id = a4.order_id 
           and  a4.product_id = a.product_id
           and a4.activity_id in (4000031,4000949,4000971,4000972,4000973,4000980,4001237,4001238,100007144,100009032,100009033,100009034,100009035,100009039,100009152,100009153,100009154,100009155,100009277,
                                  100009278,100009279,100009280,100009281,100009421,100009422,100007375,100007376,100009156,100009157)
           and o4.order_status_id in (8)
           and o4.legalization_date >'01/02/2023' )  = 0 then 'No hay ot_onl_8_liq' end as ot_onl_8_liq,            
    (select count ( distinct (c1.cosspecs)) from open.conssesu c1 
           where c1.cosssesu = a.product_id 
           and c1.cosssesu = sesunuse 
           and c1.cosscoca = 0 
           and c1.cosspecs >= '100681'
           and c1.cossmecc in (1,3) ) as cons_cero,i.value1,i.value2,substrc( i.value2,10,2) ONL, 
      
a.order_id||'|'||9688||'|'||'38963||'||a.order_activity_id||'>'||'1'||';'||  regexp_substr( i.value2,'COMMENT1>[^>]*')||'>>'||';;;'||'|||'||'1277'||';OSF-654|'||
substrc ( i.exec_initial_date,1,19) ||';'|| substrc ( i.execution_final_date,1,19) as cadena_legalizacion
from open.or_order r
left join open.or_order_activity a  on a.order_id = r.order_id 
left join open.servsusc on a.product_id = sesunuse
left join open.pericose p on sesucicl = p.pecscico
left join open.pr_product pr on pr.product_id = sesunuse and pr.subscription_id = sesususc 
left join open.infopl_654 i on i.cosssesu = a.product_id and i.task_type_id = 12617
where sesucicl  in (1201)
and pecscons =101983
and r.task_type_id in (12617)
and r.order_status_id not in (8,12)
and i.cosscavc = 2004      
order by r.legalization_date desc
