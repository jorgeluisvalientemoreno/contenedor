select p.product_id, p.product_id, p.comment_, ps.aplication_date, p.request_date, p.attention_date
from open.pr_product p, open.pr_prod_suspension ps, open.or_order_activity a, open.mo_packages p
where ps.product_id=p.product_id
  and p.product_status_id=2
  and ps.suspension_type_id in (101,102,103,104)
  and ps.active='Y'
  and a.order_activity_id=p.suspen_ord_act_id
  and p.package_id=a.package_id
  and p.comment_='CAMBIO DE SUSPENSION DE CARTERA A RP'
  and exists(select null from open.mo_packages p2, open.mo_motive m2, open.or_order_activity a2, open.or_order o2, open.ge_causal c2 where p2.package_id=m2.package_id and m2.product_id=p.product_id and 
            a2.package_id=p2.package_id and a2.order_id=o2.order_id and o2.causal_id=c2.causal_id and c2.class_causal_id=1 and o2.legalization_Date>=ps.aplication_date and p2.package_type_id in (100240,100333))
