select p.product_id Producto,
       p.product_type_id Tipo_Producto,
       p.product_status_id Estado_Producto,
       p.category_id || ' - ' || c.catedesc Categoria,
       s.sesucicl Ciclo,
       pf.pefafimo Fecha_Inicial,
       pf.pefaffmo Fecha_Final,
       (select count(pp.promotion_id)
          from pr_promotion pp
         where pp.product_id = s.sesunuse) Cantidad_Promosiones
  from open.pr_product p
 inner join open.categori c
    on c.catecodi = p.category_id
 inner join open.servsusc s
    on s.sesunuse = p.product_id
 inner join open.perifact pf
    on pf.pefacicl = s.sesucicl
   and pf.pefaactu = 'S'
   and pf.pefacicl in (1801)
 where p.category_id in (3)
   and p.product_type_id = 7014
   --and p.product_id in(50366875,50051197)
   and p.product_status_id = 1
