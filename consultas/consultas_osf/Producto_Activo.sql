SELECT pp.subscription_id contrato,
       pp.product_id prodcuto,
       gs.subscriber_id Suscriptor,
       gs.ident_type_id Tipo_Identificacion,
       gs.identification Identificacion,
       aa.address_id Codigo_direccion,
       aa.address Direcion,
       aa.geograp_location_id Codigo_Geografica,
       gg.description Codigo_Geografica,
       pp.category_id || ' - ' || ca.catedesc Categoria,
       pp.subcategory_id || ' - ' || sca.sucadesc SubCategoria
  FROM pr_product pp
 inner join ab_address aa
    on aa.address_id = pp.address_id
 inner join ge_geogra_location gg
    on gg.geograp_location_id = aa.geograp_location_id
 inner join ge_subscriber gs
    on gs.address_id = aa.address_id
 inner join categori ca
    on ca.catecodi = pp.category_id
 inner join subcateg sca
    on sca.sucacodi = pp.subcategory_id
   and sca.sucacate = pp.category_id
 WHERE pp.product_status_id = 1
 and pp.subcategory_id = 6
--   and pp.subscription_id = 66601048
