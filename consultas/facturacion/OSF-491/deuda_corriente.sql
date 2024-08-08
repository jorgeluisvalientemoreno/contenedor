select c.cucocodi  Cuenta_Cobro, 
       c.cuconuse  Producto, 
       p.product_type_id  Tipo_Producto, 
       c.cucosacu  Saldo_Corriente, 
       c.cucovaab  Valor_Abonado, 
       c.cucovare  Valor_Reclamo, 
       c.cucovrap
from open.cuencobr  c
inner join open.pr_product  p on c.cuconuse = p.product_id
where cuconuse = 280447
and c.cucosacu > 0
order by c.cucovare desc