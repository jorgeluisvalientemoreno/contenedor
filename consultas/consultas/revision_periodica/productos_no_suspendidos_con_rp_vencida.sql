select c.contrato,
       c.producto,
       c.product_status_id,
       ldc_getedadrp(c.producto) as meses_RP
from (select b.subscription_id contrato, b.product_id producto,b.product_status_id
      from open.pr_product b
      where b.product_status_id = 1
      and b.product_type_id = 7014
      and (select count(1)
      from open.pr_prod_suspension a
      where a.product_id = b.product_id
      and a.active = 'y') = 0) c
where ldc_getedadrp(c.producto) > 54