select pp.product_id         producto,
       pp.subscription_id    contrato,
       pp.product_type_id    tipo_prod,
       pp.product_status_id  estado_Producto,
       ep.description        desc_estado_Producto,
       ss.sesuesfn           estado_financiero,
       ss.sesuesco           estado_corte,
       ps.suspension_type_id Tipo_Suspension,
       ps.active             Activa,
       ps.register_date      fecha_registro,
       ps.aplication_date    Fecha_Aplicacion,
       ps.inactive_date      Fecha_Inactividad
  from pr_product pp
  inner join servsusc ss on pp.product_id = ss.sesunuse
  inner join ps_product_status ep on ep.product_status_id = pp.product_status_id
  left join pr_prod_suspension ps on pp.product_id = ps.product_id
 Where pp.product_type_id = 7014
   and pp.product_status_id = 2
   and ps.suspension_type_id = 14
   and ps.active = 'Y'
 order by ps.aplication_date desc
