SELECT (  SELECT nvl( SUM( CASE ca.cargsign WHEN 'DB' THEN cargunid WHEN 'CR' then -cargunid END ),0) voltotal_ult_3meses
               FROM cargos ca, pericose pc, ldc_susp_autoreco_null n, servsusc s, open.pr_product p, open.or_order_activity a , open.or_order o
               WHERE base.cargnuse= ca.cargnuse
               and ca.cargnuse = s.SESUNUSE
               AND pc.pecscico = s.sesucico
               and pc.pecscons = ca.cargpeco
               and n.saresesu=cargnuse
               and sesunuse=n.saresesu
               and p.product_id=sesunuse
               and a.order_activity_id=p.suspen_ord_act_id
               and  o.order_id=a.order_id
               AND ca.cargcuco > 0
               AND ca.cargconc = 31
               and sesuesco in (1,6)
               and ca.cargcaca in (1,4,15,60)
               AND ca.cargcaca IN (15,60,1,4)
               AND ca.cargsign IN ( 'DB','CR' )
               and pc.pecsfeci >=  ADD_MONTHS('27/11/2023',-3)
               AND ca.cargfecr >= o.execution_final_date
               AND   pc.pecsfeci > o.execution_final_date
               AND ca.cargpeco = pc.pecscons
               and  not exists (select null
               from ldc_susp_autoreco_sj j2
               where j2.saresesu = n.saresesu))voltotal_ult_3meses 
               ,
  base.*  from ( SELECT
               c1.cargnuse,sesucico ,trunc(o.execution_final_date) Fecha_suspension, 
               nvl( SUM( CASE c1.cargsign WHEN 'DB' THEN cargunid WHEN 'CR' then -cargunid END ),0) voltotal_dsp_susp
               FROM cargos c1, pericose pc, ldc_susp_autoreco_null n, servsusc s, open.pr_product p, open.or_order_activity a , open.or_order o
               WHERE c1.cargnuse = s.SESUNUSE
               AND pc.pecscico = s.sesucico
               and pc.pecscons = c1.cargpeco
               and n.saresesu=c1.cargnuse
               and sesunuse=n.saresesu
               and p.product_id=sesunuse
               and a.order_activity_id=p.suspen_ord_act_id
               and  o.order_id=a.order_id
               AND c1.cargcuco > 0
               AND c1.cargconc = 31
               and sesuesco in (1,6)
               and c1.cargcaca in (1,4,15,60)
               AND c1.cargcaca IN (15,60,1,4)
               AND c1.cargsign IN ( 'DB','CR' )
               AND c1.cargfecr >= o.execution_final_date
               AND   pc.pecsfeci > o.execution_final_date
               AND c1.cargpeco = pc.pecscons
               and  not exists (select null
               from ldc_susp_autoreco_sj j2
               where j2.saresesu = n.saresesu)
               group by cargnuse,o.execution_final_date,sesucico) base
            where voltotal_dsp_susp = 6
          -- and   rownum <= 10
