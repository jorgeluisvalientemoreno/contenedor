SELECT c.contrato, c.PRODUCTO
  FROM (select b.subscription_id contrato, b.product_id PRODUCTO
          from open.pr_product b
         where b.product_status_id = 1
           AND B.PRODUCT_TYPE_ID = 7014
           and (select count(1)
                  from open.pr_prod_suspension a
                 where a.product_id = b.product_id
                   and a.active = 'Y') = 0) C
 WHERE LDC_GETEDADRP(C.producto) < 54
   and (select count(1)
          from cuencobr
         where cuconuse = C.producto
           and (nvl(cucosacu, 0) + nvl(cucovare, 0)) > 0) >= 3;
