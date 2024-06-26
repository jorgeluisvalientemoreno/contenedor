select (select b.subscription_id
          from open.pr_product b
         where b.product_id = a.product_id) Contrato,
       a.*
  from open.pr_prod_suspension a
 where a.suspension_type_id in (101, 102, 103, 104)
   and (select count(1)
          from cuencobr cc
         where cc.cuconuse = a.product_id
           and (nvl(cc.cucosacu, 0) + nvl(cc.cucovare, 0)) > 0) >= 3
   and a.active = 'Y'
   and a.inactive_date is null
