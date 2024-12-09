-- Validacion actividad de suspension_autoreconectados
select  a.sareacor       "Act_persca",
        ac.task_type_id  "tt_susp",
        ac.activity_id   "Act_susp",
       initcap (i.description) "Desc_act_susp",
       count (a.saresesu)
from ldc_susp_autoreco_rp_pl  a
inner join pr_product p on p.product_id = a.saresesu
left join or_order_activity  ac on ac.order_activity_id = p.suspen_ord_act_id
left join ge_items  i on i.items_id = ac.activity_id
where a.sareproc = 7
group by a.sareacor, ac.task_type_id, ac.activity_id, i.description
order by a.sareacor asc;

-- Validacion actividad de suspension_persecucion
select  a.susp_persec_activid       "Act_persca",
        ac.task_type_id  "tt_susp",
        ac.activity_id   "Act_susp",
       initcap (i.description) "Desc_act_susp",
       count (a.susp_persec_producto)
from ldc_susp_persecucion_pl  a
inner join pr_product p on p.product_id = a.susp_persec_producto
left join or_order_activity  ac on ac.order_activity_id = p.suspen_ord_act_id
left join ge_items  i on i.items_id = ac.activity_id
group by a.susp_persec_activid, ac.task_type_id, ac.activity_id, i.description
order by a.susp_persec_activid asc

