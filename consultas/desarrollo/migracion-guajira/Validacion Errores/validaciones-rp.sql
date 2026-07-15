select sesunuse,sesuferp, sesuserv, product_type_id, c.review_date, a.order_id, a.task_type_id, (select description from open.or_task_type t where t.task_type_id=a.task_type_id) desc_titr,
       a.activity_id,
       (select i.description from open.ge_items i where i.items_id=a.activity_id) desc_actividad
from gasgg.servsusc
join open.pr_product p on p.product_id-3300000=sesunuse
join open.pr_certificate c on c.product_id=p.product_id
left join open.or_order_activity a on a.order_activity_id = c.order_act_certif_id
where not exists(select null from open.ldc_marca_producto m where m.id_producto=p.product_id)
and sesuferp>='01/01/2021'
and sesuferp<'01/10/2024';
