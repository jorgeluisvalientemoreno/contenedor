select s.sesunuse,
       p.product_status_id Estado_Producto,
       ep.description      Desc_Estado_Producto,
       s.sesuesco          Estado_Corte,
       ec.escodesc         Desc_Estado_Corte
  from servsusc s
 inner join pr_product  p  on p.product_id = s.sesunuse
 inner join open.ps_product_status ep on ep.product_status_id = p.product_status_id
 inner join open.estacort ec on ec.escocodi = s.sesuesco
 where s.sesunuse = 50419194
