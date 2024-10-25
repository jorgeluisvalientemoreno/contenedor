--productos_por_edad_y_reclamos_sesucier
select sc.contrato,
       sc.producto,
       sc.tipo_producto,
       sc.nuano, 
       sc.numes,
       sesusape,
       sc.edad_deuda,
       flag_valor_reclamo,
       sc.valor_reclamo,
       (select count(distinct(br.cucocodi)) 
          from cuencobr br, cargos c
         where br.cuconuse = sc.producto
         and   br.cucocodi = c.cargcuco
         and br.cucosacu > 0 )"Cant_cuentas_cobro" ,
       sc.ciclo, 
       sc.estado_financiero, 
       sc.categoria, 
       servsusc.sesuesco || ' ' || estacort.escodesc estado_corte  
from open.ldc_osf_sesucier sc
left join  open.servsusc  on sc.producto = servsusc.sesunuse and sc.contrato = servsusc.sesususc 
left join open.estacort on servsusc.sesuesco = estacort.escocodi 
where sc.nuano = 2024
and sc.numes= 7
and sc.tipo_producto in (7014,7055)
and sc.sesusape > 0 
and sc.edad_deuda > 60
and sc.flag_valor_reclamo = 'S'
and sc.valor_reclamo > 0 
and servsusc.sesuesco not in (95)
and   exists (select null from cuencobr  c1  where c1.cuconuse = sc.producto and c1.cucosacu > 0 and c1.cucovare > 0 and c1.cucovare = c1.cucosacu )
and (select count (or_order.order_id)
    from open.or_order   , open.or_order_activity 
    where  or_order.order_id = or_order_activity.order_id 
    and subscription_id = sc.contrato 
    and product_id = sc.producto
    and or_order.task_type_id in (5005,11263)
    and or_order.order_status_id in (0,5))  = 0 
/*    and (select count(distinct(br2.cucocodi)) 
          from cuencobr br2, cargos c
         where br2.cuconuse = sc.producto
         and   br2.cucocodi = c.cargcuco
         and br2.cucosacu > 0) >= 1
    and (select count(distinct(br3.cucocodi)) 
          from cuencobr br3, cargos c
         where br3.cuconuse = sc.producto
         and   br3.cucocodi = c.cargcuco
         and br3.cucosacu > 0)  <3*/

and rownum <= 50
order by sc.contrato
/*and   exists (select null from cuencobr  c1  where c1.cuconuse = sc.producto and c1.cucosacu > 0 and c1.cucovare > 0 and c1.cucovare < c1.cucosacu )
and  exists (select null from cuencobr  c2  where c2.cuconuse = sc.producto and c2.cucosacu > 0 and c2.cucovare = 0)*/

--

--and exists (select null from cuencobr  c3  where c3.cuconuse = sc.producto and c3.cucosacu > 0)

--and (sysdate - cc.cucofeve)

--and sc.valor_reclamo > sc.sesusape
--order by ciclo
/*and c1.cucovare < c1.cucosacu*/  
/*select *
from ldc_osf_sesucier c
where c.producto = 50763632
order by c.nuano desc, c.numes desc*/

---/*and c1.cucofeve > '20/04/2024'*/

--and sc.producto = 50763632
