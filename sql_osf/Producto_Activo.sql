SELECT pp.subscription_id contrato,
       pp.product_id prodcuto,
       pp.product_type_id || ' - ' || s.servdesc Tipo_Servicio,
       gs.subscriber_id Suscriptor,
       gs.ident_type_id Tipo_Identificacion,
       gs.identification Identificacion,
       aa.address_id Codigo_direccion,
       aa.address Direcion,
       aa.geograp_location_id Codigo_Geografica,
       gg.description Codigo_Geografica,
       pp.category_id || ' - ' || ca.catedesc Categoria,
       pp.subcategory_id || ' - ' || sca.sucadesc SubCategoria
  FROM open.pr_product pp
  left join open.servicio s
    on s.servcodi = pp.product_type_id
  left join open.ab_address aa
    on aa.address_id = pp.address_id
  left join open.ge_geogra_location gg
    on gg.geograp_location_id = aa.geograp_location_id
  left join open.ge_subscriber gs
    on gs.address_id = aa.address_id
  left join open.categori ca
    on ca.catecodi = pp.category_id
  left join open.subcateg sca
    on sca.sucacodi = pp.subcategory_id
   and sca.sucacate = pp.category_id
 WHERE pp.product_status_id = 1
--and pp.subcategory_id = 6
--and 
 pp.subscription_id =
      --67464673 
       66572991
