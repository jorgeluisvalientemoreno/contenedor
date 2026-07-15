SELECT c.contrato, c.PRODUCTO , sesucicl ,  LDC_GETEDADRP(C.producto)
  FROM (select b.subscription_id contrato, b.product_id PRODUCTO
          from open.pr_product b
         where b.product_status_id = 1
           AND B.PRODUCT_TYPE_ID = 7014
           and (select count(1)
                  from open.pr_prod_suspension a
                 where a.product_id = b.product_id
                   and a.active = 'Y') = 0) C
  left join servsusc on sesunuse = c.PRODUCTO and c.contrato = sesususc 
 WHERE /*LDC_GETEDADRP(C.producto) >=  54 
and */sesucicl in (1507)  
and c.contrato = 7054068

select sesunuse , sesususc 
from servsusc 
where sesususc = 7054068  
