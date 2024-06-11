select p.product_id Producto,
       p.subscription_id,
       open.ldc_getedadrp(p.product_id) edad_rp,
       p.product_status_id Estado_Producto,
       s.sesuesco Estado_Corte,
       s.sesuesfn Estado_Financiero,
       s2.suspeNsion_type_id Tipo_Suspension,
       s2.active Suspension_Activa,
       a.task_type_id tipo_Trabajo,
       a.activity_id Actividad_Suspension,
       it.description Desc_Actividad_Suspension,
       a.register_date Fecha_Registro,
       s2.aplication_date,
       sesucicl
  from open.pr_product p
  inner join open.pr_prod_suspeNsion s2 on s2.product_id = p.product_id    
  inner join open.servsusc s on s.sesunuse = p.product_id 
  inner join open.or_order_Activity  a on a.order_activity_id = p.suspen_ord_act_id
  inner join open.ge_items it on it.items_id = a.activity_id
  where p.product_status_id = 2
   and s2.active = 'Y'
   and s2.suspeNsion_type_id in (101, 102, 103, 104)
  and p.product_id = 51264158 
  and s.sesuesfn != 'C'
  and s2.aplication_date >= '19/03/2022'
  and  not exists 
   (select null
   from cargos cc
   where cc.cargnuse = p.product_id and cc.cargconc = 31 and cc.cargcaca in (1,4,15,60) and cc.cargfecr >=  add_months('27/10/2023',-7) and cc.cargcuco = -1)
   and rownum <= 20
   order by s2.aplication_date desc

/*
   and*/ 
/* s2.aplication_date and cc.cargcuco = -1*/ /*and cc.cargfecr < sysdate - 30*/

  -- 
