select tcsefech  Fecha_Traslado, 
       t.tcsessfu  Producto_Origen, 
       t.tcsessde  Producto_Destino, 
       pr.product_type_id || '-  ' || s.servdesc as Tipo_Producto, 
       sp.credit_bureau_id || '-  ' || credit_bureau_desc  as Central_Riesgo, 
       pr.product_status_id || '-  ' || ps.description as Estado_Producto, 
       t.tcseccge  Cuenta_Cobro, 
       c.cucosacu  Saldo_Cuenta_Cobro, 
       c.cucofeve  Fecha_Vencimiento
from open.trcasesu  t
inner join open.pr_product  pr on pr.product_id = t.tcsessde
inner join open.ps_product_status  ps on ps.product_status_id = pr.product_status_id
inner join open.servicio  s on s.servcodi = pr.product_type_id
inner join open.cuencobr  c on c.cucocodi = t.tcseccge
inner join open.ld_sector_product  sp on sp.product_id = s.servcodi
inner join open.ld_credit_bureau  cr on cr.credit_bureau_id = sp.credit_bureau_id
inner join open.mo_motive  m on m.product_id = pr.product_id
inner join open.mo_packages  p on p.package_id = m.package_id