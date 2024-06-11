-- requisito_2
select pp.product_id         "Producto",
       pp.subscription_id    "Contrato",
       pp.product_type_id    "Tipo_prod",
       pp.product_status_id  "Est_Producto",
       initcap (ep.description) "Desc_est_Producto",
       ss.sesuesfn           "Estado_financiero",
       ss.sesuesco           "Estado_corte",
       ps.suspension_type_id "Tipo_Susp",
       ps.active             "Activa",
       p.suspen_ord_act_id   "Orden_susp",
       ps.aplication_date    "Fecha_Aplicacion",
       ss.sesucico           "Ciclo",
       c2.cargpefa           "Periodo_Facturación",
       pc1.pecscons          "Periodo_Consumo_suspension",
       pc1.pecsfeci          "Fecha_inicial_Consumo",
       pc1.pecsfecf          "Fecha_final_Consumo",
       c2.cargunid           "Consumo_suspension",
       (select sum(c3.cargunid) from cargos c3 
        where c3.cargnuse = ss.sesunuse and c3.cargpeco in (select pc4.pecscons from pericose pc4 where pc4.pecscico = ss.sesucico and pc4.pecsfecf > pc1.pecsfecf) and c3.cargconc = 31
         and   c3.cargcaca in (1,4,15,60)  and   c3.cargcuco > 0)  "Suma_consumo_posteriores",
       ((select sum(c3.cargunid) from cargos c3 
        where c3.cargnuse = ss.sesunuse and c3.cargpeco in (select pc4.pecscons from pericose pc4 where pc4.pecscico = ss.sesucico and pc4.pecsfecf > pc1.pecsfecf) and c3.cargconc = 31
         and   c3.cargcaca in (1,4,15,60)  and   c3.cargcuco > 0) - c2.cargunid) as  "Variacion_consumo",
    case when ((select sum(c3.cargunid) from cargos c3 
        where c3.cargnuse = ss.sesunuse and c3.cargpeco in (select pc4.pecscons from pericose pc4 where pc4.pecscico = ss.sesucico and pc4.pecsfecf > pc1.pecsfecf) and c3.cargconc = 31
         and   c3.cargcaca in (1,4,15,60)  and   c3.cargcuco > 0) - c2.cargunid) > 5 then 'SI' 
           when ((select sum(c3.cargunid) from cargos c3 
        where c3.cargnuse = ss.sesunuse and c3.cargpeco in (select pc4.pecscons from pericose pc4 where pc4.pecscico = ss.sesucico and pc4.pecsfecf > pc1.pecsfecf) and c3.cargconc = 31
         and   c3.cargcaca in (1,4,15,60)  and   c3.cargcuco > 0) - c2.cargunid) <= 5 then 'NO' end as "Autoreconectado",
       a.task_type_id        "tt_susp",
       a.activity_id         "Act_susp",
       initcap (i.description)         "Desc_act_susp"
  from pr_product pp
  inner join servsusc ss on pp.product_id = ss.sesunuse
  inner join pr_product p on p.product_id = ss.sesunuse
  inner join ps_product_status ep on ep.product_status_id = pp.product_status_id
  left join pr_prod_suspension ps on pp.product_id = ps.product_id
  left join or_order_activity  a on a.order_activity_id = p.suspen_ord_act_id
  left join ge_items  i on i.items_id = a.activity_id
  left join pericose  pc1 on pc1.pecscico = ss.sesucico and ps.aplication_date between pc1.pecsfeci and pc1.pecsfecf
  left join cargos c2 on c2.cargnuse = ss.sesunuse and c2.cargpeco = pc1.pecscons
 Where pp.product_type_id = 7014
   and pp.product_status_id = 2
   and ps.active = 'Y'
   and ps.suspension_type_id in (101, 102, 103, 104)
   and ss.sesuesco in (select ec.coeccodi from confesco  ec  where ec.coecserv = ss.sesuserv and ec.coecfact = 'S')
    and  c2.cargconc = 31
   and   c2.cargcaca in (1,4,15,60)
   and   c2.cargcuco > 0
   and exists 
   (select null
   from cargos  c
   where c.cargnuse = ss.sesunuse       
   and   c.cargconc = 31
   and   c.cargcaca in (1,4,15,60)
   and   c.cargcuco > 0
   and   c.cargpeco in (select pc3.pecscons from pericose pc3 where pc3.pecscico = ss.sesucico and pc3.pecsfecf > pc1.pecsfecf))
and      ((select sum(c3.cargunid) from cargos c3 
        where c3.cargnuse = ss.sesunuse and c3.cargpeco in (select pc4.pecscons from pericose pc4 where pc4.pecscico = ss.sesucico and pc4.pecsfecf > pc1.pecsfecf) and c3.cargconc = 31
         and   c3.cargcaca in (1,4,15,60)  and   c3.cargcuco > 0) - c2.cargunid) < 5
and rownum <= 5
