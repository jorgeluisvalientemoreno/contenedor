select p.product_id "Producto",
       p.subscription_id "Contrato",
       open.ldc_getedadrp(p.product_id) "edad_rp",
       p.product_status_id "Estado_Producto",
       s.sesuesco "Estado_Corte",
       s.sesuesfn "Estado_Financiero",
       s2.suspeNsion_type_id "Tipo_Suspension",
       s2.active "Suspension_Activa",
       a.task_type_id "tipo_Trabajo",
       a.activity_id "Actividad_Suspension",
       initcap(it.description) "Desc_Actividad_Suspension",
       a.register_date "Fecha_Registro",
       s2.aplication_date "Fecha_Aplicacion"
  from open.pr_product p
  inner join open.pr_prod_suspeNsion s2 on s2.product_id = p.product_id    
  inner join open.servsusc s on s.sesunuse = p.product_id 
  inner join open.or_order_Activity  a on a.order_activity_id = p.suspen_ord_act_id
  inner join open.ge_items it on it.items_id = a.activity_id
  where p.product_status_id = 2
   and s2.active = 'Y'
   and s2.suspeNsion_type_id in (101, 102, 103, 104)
   and s.sesuesfn != 'C'
   and  s2.aplication_date  > add_months(sysdate , -15) 
/*   and  exists (select null
   from lectelme lc
   where lc.leemsesu = p.product_id 
   and  lc.leemfele > s2.aplication_date 
   and lc.leemleto - (select lc2.leemleto from lectelme lc2 where  lc.leemsesu =  lc2.leemsesu and  lc2.leemclec = 'T' and rownum<= 1) between 1 and 4)*/
   and not exists (select null
   from cargos cc
   where cc.cargnuse = p.product_id and cc.cargconc = 31 and cc.cargcaca in (1,4,15,60) and cc.cargfecr >=  add_months(sysdate ,-7) and cc.cargcuco >0 )
   and  exists (select null
   from cargos c
   where c.cargnuse = p.product_id and c.cargconc = 31 and c.cargcaca in (1,4,15,60) and c.cargfecr >=  s2.aplication_date  and c.cargcuco >0 )
   and rownum <= 20
   order by s2.aplication_date desc
