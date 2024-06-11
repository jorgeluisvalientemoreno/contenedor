-- Validación actividades registradas
select  a.sareacor       "Act_persca",
        ac.task_type_id  "tt_susp",
        ac.activity_id   "Act_susp",
       initcap (i.description) "Desc_act_susp",
       count (a.saresesu)
from ldc_susp_autoreco_jc2  a
inner join pr_product p on p.product_id = a.saresesu
left join or_order_activity  ac on ac.order_activity_id = p.suspen_ord_act_id
left join ge_items  i on i.items_id = ac.activity_id
where a.sareproc = 9
and exists
 (select null
          from open.mo_packages p, open.mo_motive mo, or_order_activity  oa, or_order  ot
         where p.package_id = mo.package_id
           and mo.product_id = p.product_id
           and oa.package_id = p.package_id
           and ot.order_id = oa.order_id 
           and oa.activity_id in (100009786,100008464,100008467,100009938,100009940)
           and p.motive_status_id in (36, 13))
group by a.sareacor, ac.task_type_id, ac.activity_id, i.description
order by a.sareacor asc
