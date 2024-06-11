with base as(select o.order_id,
       a.product_id, s.sesucicl,
       (select max(c.cosspefa) from conssesu c where c.cosssesu=a.product_id) periodo1
from or_order o
inner join or_order_Activity a on a.order_id=o.order_id
inner join servsusc s on a.product_id = s.sesunuse
where o.task_type_id in (12617)
  and o.order_status_id in (0,5)
  )
,
base2 as(
select base.*,
       (select max(c.cossfere) from conssesu c where c.cosssesu=base.product_id and c.cosspefa=base.periodo1 and c.cossmecc in (1,3) ) fecha1,
       (select max(c.cosspefa) from conssesu c where c.cosssesu=base.product_id and c.cosspefa<base.periodo1) periodo2
from base
),
base3 as(
select base2.*,
       (select c.cossmecc from conssesu c where c.cosssesu=base2.product_id and c.cosspefa=base2.periodo1 and c.cossmecc in (1,3) and c.cossfere=base2.fecha1 and rownum=1) metodo1,
       (select c.cosscoca from conssesu c where c.cosssesu=base2.product_id and c.cosspefa=base2.periodo1 and c.cossmecc in (1,3) and c.cossfere=base2.fecha1 and rownum=1) consumo1,
       (select c.COSSCAVC from conssesu c where c.cosssesu=base2.product_id and c.cosspefa=base2.periodo1 and c.cossmecc in (1,3) and c.cossfere=base2.fecha1 and rownum=1) califica1,
       
       (select max(c.cossfere) from conssesu c where c.cosssesu=base2.product_id and c.cosspefa=base2.periodo2 and c.cossmecc in (1,3) ) fecha2,
       (select max(c.cosspefa) from conssesu c where c.cosssesu=base2.product_id and c.cosspefa<base2.periodo2) periodo3
from base2
),
base4 as(
select base3.*,
       (select c.cossmecc from conssesu c where c.cosssesu=base3.product_id and c.cosspefa=base3.periodo2 and c.cossmecc in (1,3) and c.cossfere=base3.fecha2 and rownum=1) metodo2,
       (select c.cosscoca from conssesu c where c.cosssesu=base3.product_id and c.cosspefa=base3.periodo2 and c.cossmecc in (1,3) and c.cossfere=base3.fecha2 and rownum=1) consumo2,
        (select c.COSSCAVC from conssesu c where c.cosssesu=base3.product_id and c.cosspefa=base3.periodo2 and c.cossmecc in (1,3) and c.cossfere=base3.fecha2 and rownum=1) califica2,      
       (select max(c.cossfere) from conssesu c where c.cosssesu=base3.product_id and c.cosspefa=base3.periodo3 and c.cossmecc in (1,3) ) fecha3,
       (select max(c.cosspefa) from conssesu c where c.cosssesu=base3.product_id and c.cosspefa<base3.periodo3) periodo4
from base3
where base3.metodo1=3
and   base3.consumo1>0
),
base5 as(
select base4.*,
        (select c.cossmecc from conssesu c where c.cosssesu=base4.product_id and c.cosspefa=base4.periodo3 and c.cossmecc in (1,3) and c.cossfere=base4.fecha3 and rownum=1) metodo3,
       (select c.cosscoca from conssesu c where c.cosssesu=base4.product_id and c.cosspefa=base4.periodo3 and c.cossmecc in (1,3) and c.cossfere=base4.fecha3 and rownum=1) consumo3,
       (select c.COSSCAVC from conssesu c where c.cosssesu=base4.product_id and c.cosspefa=base4.periodo3 and c.cossmecc in (1,3) and c.cossfere=base4.fecha3 and rownum=1) califica3,
       (select max(c.cossfere) from conssesu c where c.cosssesu=base4.product_id and c.cosspefa=base4.periodo4 and c.cossmecc in (1,3) ) fecha4,
       (select max(c.cosspefa) from conssesu c where c.cosssesu=base4.product_id and c.cosspefa<base4.periodo4) periodo5
from base4
where base4.metodo2=3
and   base4.consumo2>0
),
base6 as(
select base5.*,
       (select c.cossmecc from conssesu c where c.cosssesu=base5.product_id and c.cosspefa=base5.periodo4 and c.cossmecc in (1,3) and c.cossfere=base5.fecha4 and rownum=1) metodo4,
       (select c.cosscoca from conssesu c where c.cosssesu=base5.product_id and c.cosspefa=base5.periodo4 and c.cossmecc in (1,3) and c.cossfere=base5.fecha4 and rownum=1) consumo4,
       (select c.COSSCAVC from conssesu c where c.cosssesu=base5.product_id and c.cosspefa=base5.periodo4 and c.cossmecc in (1,3) and c.cossfere=base5.fecha4 and rownum=1) califica4,
       (select max(c.cossfere) from conssesu c where c.cosssesu=base5.product_id and c.cosspefa=base5.periodo5 and c.cossmecc in (1,3) ) fecha5,
       (select max(c.cosspefa) from conssesu c where c.cosssesu=base5.product_id and c.cosspefa<base5.periodo5) periodo6
from base5
where base5.metodo3 in (1,3)
and   base5.consumo3>0
),
base7 as(
select base6.*,
       (select c.cossmecc from conssesu c where c.cosssesu=base6.product_id and c.cosspefa=base6.periodo5 and c.cossmecc in (1,3) and c.cossfere=base6.fecha5 and rownum=1) metodo5,
       (select c.cosscoca from conssesu c where c.cosssesu=base6.product_id and c.cosspefa=base6.periodo5 and c.cossmecc in (1,3) and c.cossfere=base6.fecha5 and rownum=1) consumo5,
       (select c.COSSCAVC from conssesu c where c.cosssesu=base6.product_id and c.cosspefa=base6.periodo5 and c.cossmecc in (1,3) and c.cossfere=base6.fecha5 and rownum=1) califica5,
       (select max(c.cossfere) from conssesu c where c.cosssesu=base6.product_id and c.cosspefa=base6.periodo6 and c.cossmecc in (1,3) ) fecha6,
       (select max(c.cosspefa) from conssesu c where c.cosssesu=base6.product_id and c.cosspefa<base6.periodo6) periodo7
from base6
where base6.metodo4 in (1,3)
and   base6.consumo4>0
),
base8 as (
select base7.*,
       (select c.cossmecc from conssesu c where c.cosssesu=base7.product_id and c.cosspefa=base7.periodo7 and c.cossmecc in (1,3) and c.cossfere=base7.fecha6 and rownum=1) metodo6,
       (select c.cosscoca from conssesu c where c.cosssesu=base7.product_id and c.cosspefa=base7.periodo6 and c.cossmecc in (1,3) and c.cossfere=base7.fecha6 and rownum=1) consumo6,
        (select c.COSSCAVC from conssesu c where c.cosssesu=base7.product_id and c.cosspefa=base7.periodo6 and c.cossmecc in (1,3) and c.cossfere=base7.fecha6 and rownum=1) califica6,
       (select l.leemoble from open.lectelme l where l.leemsesu=base7.product_id and l.leempefa=base7.periodo1 and l.leemclec='F' and rownum < 2) lectura1,
       (select l.leemoble from open.lectelme l where l.leemsesu=base7.product_id and l.leempefa=base7.periodo2 and l.leemclec='F' and rownum < 2) lectura2,
       (select l.leemoble from open.lectelme l where l.leemsesu=base7.product_id and l.leempefa=base7.periodo3 and l.leemclec='F' and rownum < 2) lectura3
from base7
where base7.metodo5 in (1,3)
and   base7.consumo5>0
)
select*
from base8
where califica6 = 2004;
