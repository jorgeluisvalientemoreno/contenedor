select distinct p.subscription_id Contrato,
                p.product_id Producto,
                p.product_type_id Tipo_Producto,
                p.product_status_id || ' - ' || ps.description Estado_Producto,
                p.category_id || ' - ' || c.catedesc Categoria,
                p.subcategory_id Subcategoria,
                aa.address_id || ' - ' || aa.address Direccion,
                aseg.category_ || ' - ' || csegmento.catedesc Categoria_Segmento,
                aseg.subcategory_ SubCategoria_Segmento
  from open.pr_product p
 inner join open.categori c
    on c.catecodi = p.category_id
 inner join open.servsusc s
    on s.sesunuse = p.product_id
 inner join open.ab_address aa
    on aa.address_id = p.address_id
 inner join open.ps_product_status ps
    on ps.product_status_id = p.product_status_id
 inner join ab_segments aseg
    on aseg.segments_id = aa.segment_id
 inner join open.categori csegmento
    on csegmento.catecodi = aseg.category_
 where p.category_id in (2)
   and p.product_type_id = 7014
   and p.product_status_id = 1
