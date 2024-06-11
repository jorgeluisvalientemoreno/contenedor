select oa.subscription_id "Contrato",
       se.sesuesco ||' -'|| initcap(escodesc) "Estado_corte",
       se.sesuesfn "Estado_financiero",
       oa.product_id "Producto",
       o.order_id "Orden",
  case when o.order_status_id = 0 then 'Registrada'
       when o.order_status_id = 5 then 'Asignada'
       when o.order_status_id = 8 then 'Legalizada'
       when o.order_status_id = 12 then 'Anulada'
       when o.order_status_id = 11 then 'Bloqueada' end as "Estado",
       o.task_type_id||' -'|| initcap(t.short_name) "Tipo_trabajo",
       o.created_date "Fecha creacion",
       ( select suspension_type_id
             from open.pr_prod_suspension ps1
             where ps1.product_id= sesunuse
             and ps1.suspension_type_id in (101,102,103,104)
             and ps1.active='Y') "Tipo_suspension",
       o.causal_id "Causal",
       o.legalization_date "Fecha legalizacion",
       oa.status "Estado actividad",
       oa.value1 "Value1",
       i.legal_item_amount "Cantidad de items"
from or_order o
left join or_order_activity oa on o.order_id = oa.order_id
left join servsusc se on se.sesunuse = oa.product_id and se.sesususc = oa.subscription_id
left join estacort on sesuesco = escocodi
left join or_task_type t on t.task_type_id = o.task_type_id
left join or_order_items i on i.order_id = o.order_id
where o.task_type_id in (10169, 10884, 10918, 12521)
and o.order_status_id in (5)
and NOT  exists ( select null 
            from inclcoco i
           where i.inccsusc = oa.subscription_id
           and i.inccfeca is null) 
and exists ( select null 
             from open.pr_prod_suspension ps
             where ps.product_id= sesunuse
             and ps.suspension_type_id in (101,102,103,104)
             and ps.active='Y')
and not exists (select null   
            from or_order o1, or_order_activity oa1, mo_packages s1
            where o1.order_id = oa1.order_id
            and oa1.package_id = s1.package_id
            and oa1.product_id= se.sesunuse
            and s1.package_type_id in (300) 
            and o1.order_status_id in (5) ) 
and not exists (select null
               from LDC_PRODRERP 
               where PRREPROC = 'N'
               and prreprod = se.sesunuse) 
