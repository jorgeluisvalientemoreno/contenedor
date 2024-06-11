with periodo as(
select p.pefacodi, p.pefafimo, p.pefaffmo, ct.pecscons, p.pefacicl
from open.perifact p 
inner join open.pericose ct on ct.pecscico=p.pefacicl and ct.pecsfecf between p.pefafimo and p.pefaffmo
where pefacicl=1201
  and p.pefaano=2022 
  and p.pefames=10 
), fechlect as(
select trunc(e.esprfein) fecha
from open.estaprog e
where e.esprprog like '%FGRL%'
and esprpefa = (select pefacodi from periodo)
), ordenes as(
select a.product_id, o.order_id, o.task_type_id, o.created_date, o.order_status_id, o.legalization_date, a.value1, a.value2, a.value3, a.value4, l.leemleto, l.leemoble
from periodo p
inner join open.lectelme l on l.leempefa=p.pefacodi and l.leempecs=pecscons and l.leemclec='F'
inner join open.or_order_activity a on a.order_activity_id=l.leemdocu and a.product_id=l.leemsesu
inner join open.or_order o on o.order_id=a.order_id
union all
select a.product_id, o.order_id, o.task_type_id, o.created_date, o.order_status_id, o.legalization_date, a.value1, a.value2, a.value3, a.value4, h.hlemleto, h.hlemoble
from open.servsusc s
inner join periodo p on p.pefacicl=sesucicl
inner join open.or_order_activity a on a.product_id=s.sesunuse and a.task_type_id in (12617)
inner join open.or_order o on o.order_id=a.order_id and o.task_type_id=12617
inner join open.hileelme h on h.hlemdocu=a.order_activity_id
where s.sesuserv=7014
  and trunc(o.created_date)  = (select fecha from fechlect)
  )
select c.cosssesu,
       c.cosspefa,
       c.cosspecs,
       c.cosscoca,
       c.cossfere,
       c.cossmecc,
       c.cossidre,
       c.cosscavc
      , ot.*
from open.conssesu c
inner join periodo p on p.pefacodi=c.cosspefa and trunc(c.cossfere) between trunc(p.pefafimo) and trunc(p.pefaffmo)
left join ordenes ot on ot.product_id=c.cosssesu and to_char(ot.legalization_date,'dd/mm/yyyy hh24:mi')= to_char(c.cossfere,'dd/mm/yyyy hh24:mi')
where c.cosspecs = p.pecscons
 and  cossmecc in (1,3)
 and  cosscavc!=9
 and not exists(select null from open.elmesesu e where e.emsssesu=c.cosssesu and e.emssfein between p.pefafimo and p.pefaffmo)
order by cosspefa,  cossfere  desc;  



/*select c.cosssesu,
       c.cosspefa,
       c.cosspecs,
       c.cosscoca,
       c.cossfere,
       c.cossmecc,
       c.cossidre,
       c.cosscavc,
       l.*,
       ac.order_id,
       ac.task_type_id,
       ac.legalization_date
from open.conssesu c
inner join open.perifact p on p.pefacodi=c.cosspefa and p.pefaano=2022 and p.pefames=10 and trunc(c.cossfere) between trunc(p.pefafimo) and trunc(p.pefaffmo)
inner join open.pericose ct on ct.pecscons=c.cosspecs 
left join open.lectelme l on l.leempefa=p.pefacodi and l.leempecs=ct.pecscons and l.leemsesu=c.cosssesu and l.leemclec='F'
left join( select o.order_id, o.task_type_id, o.legalization_date, a.product_id, a.order_activity_id
           from open.or_order_activity a  
           inner join open.or_order o on o.order_id=a.order_id  
          ) ac  on ac.order_activity_id=l.leemdocu and ac.product_id=l.leemsesu and to_char(ac.legalization_date,'dd/mm/yyyy hh24:mi')= to_char(c.cossfere,'dd/mm/yyyy hh24:mi')
where c.cosspecs = 101983
 and     c.cosssesu=1030591
 and cossmecc in (1,3)
 and cosscavc!=9
 and not exists(select null from open.elmesesu e where e.emsssesu=c.cosssesu and e.emssfein between p.pefafimo and p.pefaffmo)
--and cossfere between '6/10/2022' and  '4/11/2022'
order by cosspefa,  cossfere  desc;


with base as(
select trunc(e.esprfein) fecha
from open.estaprog e
where e.esprprog like '%FGRL%'
and esprpefa=102008)
select o.order_id, a.order_activity_id, o.legalization_Date, o.task_type_id,
       h.*
from open.servsusc s
inner join open.or_order_activity a on a.product_id=s.sesunuse and a.task_type_id=12617
inner join open.hileelme h on h.hlemdocu=a.order_activity_id
inner join open.or_order o on o.order_id=a.order_id
where s.sesucicl=1201 
  and s.sesuserv=7014
  and s.sesunuse=1030591
  and trunc(o.created_date)= (select fecha from base)
  
  select *
from open.hileelme h
where h.
select *
from open.lectelme l, open.or_order_activity a, open.or_order o
where l.leempecs = 101983
and     leemsesu=1030849
and a.order_activity_id=l.leemdocu
and o.order_id=a.order_id;



with base as(
select trunc(e.esprfein) fecha
from open.estaprog e
where e.esprprog like '%FGRL%'
and esprpefa=102008)
select o.order_id, a.order_activity_id, o.legalization_Date, o.task_type_id,
       h.*
from open.servsusc s
inner join open.or_order_activity a on a.product_id=s.sesunuse and a.task_type_id=12617
inner join open.hileelme h on h.hlemdocu=a.order_activity_id
inner join open.or_order o on o.order_id=a.order_id
where s.sesucicl=1201 
  and s.sesuserv=7014
  and s.sesunuse=1030591
  and trunc(o.created_date)= (select fecha from base)

*/
