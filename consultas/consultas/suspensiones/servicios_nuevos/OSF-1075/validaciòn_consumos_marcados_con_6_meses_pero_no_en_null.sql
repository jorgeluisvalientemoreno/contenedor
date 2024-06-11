-- validaciòn consumos marcados con 6 meses pero no en null
with causas as
      (
        select  regexp_substr( '15,60,1,4', '[^,]+', 1, level ) codigo
        from dual
        connect by regexp_substr( '15,60,1,4', '[^,]+', 1, level) is not null
      )     
select p.product_id "Producto", sesucico "Ciclo consumo",
 trunc(o.execution_final_date) "Fecha suspension",
(select max(c1.cargfecr) from cargos c1 where c1.cargnuse = sesunuse and c1.cargconc = 31 and   c1.cargcaca in (1,4,15,60)) "Ultimocargo",
'19/10/2023' "Fechaproc" ,
(      SELECT 
         nvl( SUM( CASE ca.cargsign WHEN 'DB' THEN cargunid WHEN 'CR' then -cargunid END ),0) volumen
      FROM cargos ca, pericose pc
      WHERE ca.cargnuse = SESUNUSE
      AND ca.cargcuco > 0
      AND ca.cargconc = 31
      AND ca.cargcaca IN (SELECT codigo FROM causas )
      AND ca.cargsign IN ( 'DB','CR' )
      AND ca.cargfecr >= o.execution_final_date 
      and ca.cargfecr >=  ADD_MONTHS('19/10/2023',-6)
      AND pc.pecscico = sesucico
      AND   pc.pecsfeci > o.execution_final_date
      AND ca.cargpeco = pc.pecscons)  "Consumos post suspe"
from ldc_susp_autoreco_jc j
inner join servsusc on sesunuse=j.saresesu and sesuesco in (1,6)
inner join open.pr_product p on p.product_id=sesunuse
inner join open.or_order_activity a on a.order_activity_id=p.suspen_ord_act_id
inner join open.or_order o on o.order_id=a.order_id
where j.sareproc = '7' 
and  not exists
(select null
from ldc_susp_autoreco j2
where j2.saresesu = j.saresesu)

