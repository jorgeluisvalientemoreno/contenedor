with base as ( select contrato, producto , pr.product_status_id Estado_Producto , sesucate Categoria,periodo  , pericons,regla, observacion 
from personalizaciones.coslprom c 
left join pr_product pr on producto = pr.product_id 
left join servsusc s on sesususc = contrato and sesunuse = producto
where fecha >= '01/02/2024'
), 
base2 as(
select base.*,
       (select max(c.cossfere) from conssesu c where c.cosssesu=base.producto and c.cosspefa=base.periodo and c.cossmecc in (1,3) ) fecha1,
       (select max(c.cosspefa) from conssesu c where c.cosssesu=base.producto and c.cosspefa<base.periodo) periodo2

from base
),
base3 as(
select base2.*,
       (select c.cossmecc from conssesu c where c.cosssesu=base2.producto and c.cosspefa=base2.periodo and c.cossmecc in (1,3) and c.cossfere=base2.fecha1 and rownum=1) metodo1,
       (select c.cosscoca from conssesu c where c.cosssesu=base2.producto and c.cosspefa=base2.periodo and c.cossmecc in (1,3) and c.cossfere=base2.fecha1 and rownum=1) consumo1,
       (select c.COSSCAVC from conssesu c where c.cosssesu=base2.producto and c.cosspefa=base2.periodo and c.cossmecc in (1,3) and c.cossfere=base2.fecha1 and rownum=1) califica1,       
       (select max(c.cossfere) from conssesu c where c.cosssesu=base2.producto and c.cosspefa=base2.periodo2 and c.cossmecc in (1,3) ) fecha2,
       (select max(c.cosspefa) from conssesu c where c.cosssesu=base2.producto and c.cosspefa<base2.periodo2) periodo3,
         (select l.leemoble from open.lectelme l where l.leemsesu=base2.producto and l.leempefa=base2.periodo and l.leemclec='F' and rownum < 2) lectura1
from base2)
,
base4 as(
select base3.*,
       (select c.cossmecc from conssesu c where c.cosssesu=base3.producto and c.cosspefa=base3.periodo2 and c.cossmecc in (1,3) and c.cossfere=base3.fecha2 and rownum=1) metodo2,
       (select c.cosscoca from conssesu c where c.cosssesu=base3.producto and c.cosspefa=base3.periodo2 and c.cossmecc in (1,3) and c.cossfere=base3.fecha2 and rownum=1) consumo2,
        (select c.COSSCAVC from conssesu c where c.cosssesu=base3.producto and c.cosspefa=base3.periodo2 and c.cossmecc in (1,3) and c.cossfere=base3.fecha2 and rownum=1) califica2,      
       (select max(c.cossfere) from conssesu c where c.cosssesu=base3.producto and c.cosspefa=base3.periodo3 and c.cossmecc in (1,3) ) fecha3
       ,(select max(c.cosspefa) from conssesu c where c.cosssesu=base3.producto and c.cosspefa<base3.periodo3) periodo4,
        (select l.leemoble from open.lectelme l where l.leemsesu=base3.producto and l.leempefa=base3.periodo2 and l.leemclec='F' and rownum < 2) lectura2
from base3
)
,
base5 as(
select base4.*,
        (select c.cossmecc from conssesu c where c.cosssesu=base4.producto and c.cosspefa=base4.periodo3 and c.cossmecc in (1,3) and c.cossfere=base4.fecha3 and rownum=1) metodo3,
       (select c.cosscoca from conssesu c where c.cosssesu=base4.producto and c.cosspefa=base4.periodo3 and c.cossmecc in (1,3) and c.cossfere=base4.fecha3 and rownum=1) consumo3,
       (select c.COSSCAVC from conssesu c where c.cosssesu=base4.producto and c.cosspefa=base4.periodo3 and c.cossmecc in (1,3) and c.cossfere=base4.fecha3 and rownum=1) califica3
      , (select max(c.cossfere) from conssesu c where c.cosssesu=base4.producto and c.cosspefa=base4.periodo4 and c.cossmecc in (1,3) ) fecha4,
       (select l.leemoble from open.lectelme l where l.leemsesu=base4.producto and l.leempefa=base4.periodo3 and l.leemclec='F' and rownum < 2) lectura3
from base4
),
base6 as(
select base5.*,
       (select c.cossmecc from conssesu c where c.cosssesu=base5.producto and c.cosspefa=base5.periodo4 and c.cossmecc in (1,3) and c.cossfere=base5.fecha4 and rownum=1) metodo4,
       (select c.cosscoca from conssesu c where c.cosssesu=base5.producto and c.cosspefa=base5.periodo4 and c.cossmecc in (1,3) and c.cossfere=base5.fecha4 and rownum=1) consumo4,
       (select c.COSSCAVC from conssesu c where c.cosssesu=base5.producto and c.cosspefa=base5.periodo4 and c.cossmecc in (1,3) and c.cossfere=base5.fecha4 and rownum=1) califica4,
       (select l.leemoble from open.lectelme l where l.leemsesu=base5.producto and l.leempefa=base5.periodo4 and l.leemclec='F' and rownum < 2) lectura4
from base5)

select*
from base6
