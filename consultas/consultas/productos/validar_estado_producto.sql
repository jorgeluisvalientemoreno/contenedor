select pp.product_id        producto,
       pp.subscription_id   contrato,
       pp.product_type_id   tipo_prod,
       pp.product_status_id estado_Producto,
       ep.description,
       ss.sesuesfn          estado_financiero,
       ss.sesuesco          estado_corte,
       ec1.escodesc
  from open.pr_product pp
 inner join open.servsusc ss on pp.product_id = ss.sesunuse
 inner join open.ps_product_status ep on ep.product_status_id = pp.product_status_id
 inner join open.estacort ec1 on ec1.escocodi = ss.sesuesco
