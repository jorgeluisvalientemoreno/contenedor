-- Validaci�n solicitudes registradas
select  a.sareacor       "Act_persca",
        ac.task_type_id  "tt_susp",
        ac.activity_id   "Act_susp",
       initcap (i.description) "Desc_act_susp",
       count (a.saresesu)
from ldc_susp_autoreco  a
inner join pr_product p on p.product_id = a.saresesu
left join or_order_activity  ac on ac.order_activity_id = p.suspen_ord_act_id
left join ge_items  i on i.items_id = ac.activity_id
where a.sareproc = 7
and exists
 (select null
          from open.mo_packages p, open.mo_motive mo, or_order_activity  oa, or_order  ot
         where p.package_id = mo.package_id
           and mo.product_id = p.product_id
           and oa.package_id = p.package_id
           and ot.order_id = oa.order_id 
           and p.package_type_id in (100237, 100294, 100295, 100156, 100248, 100246, 100295, 100312)
           and p.motive_status_id in (36, 13))
group by a.sareacor, ac.task_type_id, ac.activity_id, i.description
order by a.sareacor asc
