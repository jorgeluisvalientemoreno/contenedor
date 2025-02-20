--productos
select s.sesunuse, 
       s.sesususc,
       s.sesuserv,
       p.product_status_id,
       s.sesucate,
       s.sesuesfn,
       s.sesuesco 
from servsusc  s
inner join pr_product  p  on p.product_id = s.sesunuse
where s.sesuserv = 7014
and   s.sesuesco in (1,2,3)
and   s.sesucate in (2)
and   p.product_status_id in  (
                select ps.product_status_id
                from ps_product_status ps
                where ps.prod_status_type_id = 1
                 and ps.is_active_product = 'Y'
                 and ps.is_final_status = 'Y')
and not exists
 (select null
          from open.mo_packages pa
         inner join open.mo_motive mo on pa.package_id = mo.package_id
         inner join Or_Order_Activity  oa  on oa.package_id = pa.package_id
         inner join or_order ot  on ot.order_id = oa.order_id
         where mo.product_id = s.sesunuse
           and pa.package_type_id in (100225)
           and pa.motive_status_id in (36,13))
   
                 
                 
                 
/*and pa.request_date < '01/01/2025'
           and ot.task_type_id = 10217
           and ot.order_status_id = 5*/
