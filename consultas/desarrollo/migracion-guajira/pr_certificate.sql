select sesunuse, sesuserv, sesueste, sesuferp,sesunuse+3300000 producto_homologado, c.product_id, c.review_date, c.estimated_end_date, add_months( c.review_date, 60) fecha_calculada,
       c.order_act_certif_id,
       (select i.items_id||'-'||i.description from migragg.or_order_activity a join open.ge_items i on i.items_id=a.activity_id where c.order_act_certif_id = a.order_activity_id) tipo_revision
from gasgg.servsusc
left join migragg.pr_certificate c on product_id=sesunuse +3300000
where sesuserv=1;

select *
from migragg.or_order_activity
--where product_id in (53437998, 53437998);
where order_id=375086443;


select *
from migragg.log_proc_migra_det d
where lpmdprog='PRDMIGR_PR_CERTIFICATE'
 and (d.lpmddesc like '%53437998%' or d.lpmddesc like '%50137998%');
 
select *
from migragg.or_order
where order_id=375086443;
