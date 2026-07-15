select c.cosssesu,
       c.cosspefa,
       c.cosspecs,
       c.cosscoca,
       c.cossfere,
       ac.legalization_date,
       l.leemdocu,
       c.cossmecc,
       c.cossidre,
       c.cosscavc,
       l.*,
       ac.order_id,
       ac.order_activity_id,
       ac.task_type_id,
       ac.legalization_date, 
       ac.value1,
       ac.value2
       ,hi.*
from open.conssesu c
inner join open.perifact p on p.pefacodi=c.cosspefa and p.pefaano=2022 and p.pefames=10 and trunc(c.cossfere) between trunc(p.pefafimo) and trunc(p.pefaffmo)
inner join open.pericose ct on ct.pecscons=c.cosspecs
left join open.lectelme l on l.leempefa=p.pefacodi and l.leempecs=ct.pecscons and l.leemsesu=c.cosssesu and l.leemclec='F'
left join( select o.order_id, o.task_type_id, o.legalization_date, a.product_id, a.order_activity_id, a.value1, a.value2
           from open.or_order_activity a
           inner join open.or_order o on o.order_id=a.order_id
          ) ac  on /*ac.order_activity_id=l.leemdocu and*/ ac.product_id=l.leemsesu and to_char(ac.legalization_date,'dd/mm/yyyy hh24:mi')= to_char(c.cossfere,'dd/mm/yyyy hh24:mi')
left join open.hileelme hi on hlemdocu = ac.order_activity_id
where c.cosspecs = 101983
and     c.cosssesu=52208164
 and cossmecc in (1,3)
 and not exists(select null from open.elmesesu e where e.emsssesu=c.cosssesu and e.emssfein between p.pefafimo and p.pefaffmo)
order by cosspefa,  cossfere  desc
