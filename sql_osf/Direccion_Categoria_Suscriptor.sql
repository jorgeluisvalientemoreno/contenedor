select pp.subscription_id Contrato,
       pp.product_id,
       aa.address_id,
       aa.address,
       aa.geograp_location_id,
       ggl.description,
       /*ab_boaddress.fnugetcategory(aa.address_id)*/
       ap.category_ Categoria_Segmento,
       ap.subcategory_ SubCategoria_Segmento,
       pp.category_id Categoria_Producto,
       pp.subcategory_id SubCategoria_Segmento
  from open.ab_address aa
 inner join open.AB_PREMISE ap
    on ap.premise_id = aa.estate_number
   --and ap.category_ = 3
 inner join ge_geogra_location ggl
    on ggl.geograp_location_id = aa.geograp_location_id
 inner join open.pr_product pp
    on pp.address_id = aa.address_id
--and ggl.geograp_location_id = 5
--and ab_boaddress.fnugetcategory(aa.address_id) = 3
where aa.address_id = 1099152
;
