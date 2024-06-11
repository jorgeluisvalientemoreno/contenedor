select pp.product_id         producto,
       pp.subscription_id    contrato,
       pp.product_type_id    tipo_prod,
       pp.product_status_id  est_Producto,
       ep.description        desc_est_Producto,
       ss.sesuesfn           estado_financiero,
       ss.sesuesco           estado_corte,
       ps.suspension_type_id Tipo_Susp,
       ps.active             Activa,
       p.suspen_ord_act_id   orden_susp,
       ps.aplication_date    Fecha_Aplicacion,
       ps.inactive_date      Fecha_Inactividad,
       a.task_type_id        tt_susp,
       a.activity_id         act_susp,
       i.description         desc_act_susp
  from pr_product pp
  inner join servsusc ss on pp.product_id = ss.sesunuse
  inner join pr_product p on p.product_id = ss.sesunuse
  inner join ps_product_status ep on ep.product_status_id = pp.product_status_id
  left join pr_prod_suspension ps on pp.product_id = ps.product_id
  left join or_order_activity  a on a.order_activity_id = p.suspen_ord_act_id
  left join ge_items  i on i.items_id = a.activity_id
  left join pericose  pc1 on pc1.pecscico = ss.sesucico and ps.aplication_date between pc1.pecsfeci and pc1.pecsfecf
 Where pp.product_type_id = 7014
   and pp.product_status_id = 2
   and ps.active = 'Y'
   and ps.suspension_type_id in (101, 102, 103, 104)
 /*  and exists 
   (select max( l.leemfele)
          from lectelme l
         where l.leemsesu = p.product_id
          and l.leemleto != l.leemlean
           and l.leemclec = 'F'
           and  l.leemleto is not null)*/
   and exists 
   (select null
   from cargos  c, perifact  pf, pericose  pc
   where c.cargnuse = ss.sesunuse
   and   ss.sesucico = pf.pefacicl
   and   ss.sesucico = pc.pecscico)        

fecha_susp  between pc.pecsfeci and pc.pecsfecf
