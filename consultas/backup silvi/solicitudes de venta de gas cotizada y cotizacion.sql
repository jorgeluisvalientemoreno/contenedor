select q.quotation_id,package_id_asso,m.package_id , MO.PRODUCT_ID , MO.SUBSCRIPTION_ID , SESUCICL ,q.register_date 
from open.cc_quotation q
inner join open.mo_packages_asso a on  a.package_id_asso = q.package_id
inner join mo_packages m on m.package_id = a.package_id
INNER JOIN MO_MOTIVE MO ON m.package_id  = MO.package_id
INNER JOIN SERVSUSC S ON SESUSUSC =  MO.SUBSCRIPTION_ID 
where q.status ='N' and q.register_date <='01/01/2024' and m.motive_status_id= 14
and exists ( select null from or_order o , or_order_activity  aa ,GE_CAUSAL GE ,ge_class_causal ca
 where o.order_id = aa.order_id and aa.package_id= a.package_id  and  o.causal_id = GE.causal_id AND GE.CLASS_CAUSAL_ID = CA.CLASS_CAUSAL_ID and o.task_type_id = 10495
 and o.order_status_id = 8
 and ca.class_causal_id=1 )
 and exists ( select null from or_order o1 , or_order_activity  aa1 ,GE_CAUSAL GE1 ,ge_class_causal ca1
 where o1.order_id = aa1.order_id   and  o1.causal_id = GE1.causal_id AND GE1.CLASS_CAUSAL_ID = CA1.CLASS_CAUSAL_ID and o1.task_type_id IN (12149,
12151,
10268,
10830,
10831
)
 and o1.order_status_id = 8
 and ca1.class_causal_id=1 ) /*and exists ( select null from diferido d where difesusc = subscription_id and difeconc = 291 and difesape >0)*/AND SUBSCRIPTION_ID = 67404408 
 order by q.register_date desc
