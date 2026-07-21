select p.product_id Producto,
       p.product_type_id Tipo_Producto,
       p.product_status_id || ' - ' || ps.description Estado_Producto,
       p.category_id || ' - ' || c.catedesc Categoria,
       p.subcategory_id Subcategoria,
       s.sesucicl Ciclo,
       pf.pefafimo Fecha_Inicial,
       pf.pefaffmo Fecha_Final,
       aa.address_id || ' - ' || aa.address Direccion,
       aseg.category_ || ' - ' || csegmento.catedesc Categoria_Segmento,
       aseg.subcategory_ SubCategoria_Segmento /*,
       (select count(pp.promotion_id)
          from pr_promotion pp
         where pp.product_id = s.sesunuse) Cantidad_Promosiones*/
  from open.pr_product p
 inner join open.categori c
    on c.catecodi = p.category_id
 inner join open.servsusc s
    on s.sesunuse = p.product_id
 inner join open.perifact pf
    on pf.pefacicl = s.sesucicl
--and pf.pefaactu = 'S'
--and pf.pefacicl in (1801)
 inner join open.ab_address aa
    on aa.address_id = p.address_id
 inner join open.ps_product_status ps
    on ps.product_status_id = p.product_status_id
 inner join ab_segments aseg
    on aseg.segments_id = aa.segment_id
 inner join open.categori csegmento
    on csegmento.catecodi = aseg.category_
 where p.category_id in (3)
   and p.product_type_id = 7014
      --and p.product_id in(50366875,50051197)
   and p.product_status_id = 1
