--Cumple
with productos as (select pr.product_id, pr.subscription_id, pr.product_type_id, pr.product_status_id, pr.address_id, gl.geograp_location_id, gl.description, pr.category_id, ss.sesuesco, ss.sesuesfn
                    from pr_product  pr
                    inner join servsusc ss on  ss.sesunuse = pr.product_id 
                    inner join ab_address  ad  on ad.address_id = pr.address_id
                    inner join ge_geogra_location  gl  on gl.geograp_location_id = ad.geograp_location_id and gl.geograp_location_id = 9134 --9134  --52
                    where pr.product_type_id = 7014
                    and   pr.category_id = 1
                    and   pr.product_id not in (1000650)
)
, actividades as (select  p.subscription_id, p.product_id, p.product_type_id, p.product_status_id, p.address_id, p.geograp_location_id, p.description, p.category_id, p.sesuesco, p.sesuesfn,
                          oa.package_id, o.order_id, o.task_type_id, oa.activity_id, i.description  item, i.item_classif_id, o.order_status_id, o.legalization_date
                      from productos  p
                      left join or_Order_Activity oa  on oa.product_id = p.product_id
                      left join or_Order  o  on o.order_id = oa.order_id
                      left join ge_items  i  on i.items_id = oa.activity_id
                      where  oa.activity_id in (100003630,100003631,100003629,100003632,100003634,100003638,100003639,100003640)
                       and o.order_status_id = 8
)
, diferidos  as (select a.subscription_id,  a.product_id, a.product_type_id, a.product_status_id, a.address_id,  a.geograp_location_id, a.description, a.category_id, a.sesuesco, a.sesuesfn,
        a.package_id, a.order_id, a.task_type_id, a.activity_id, a.item, a.item_classif_id, a.order_status_id, a.legalization_date,
        d.difeconc, co.concdesc, d.difesape, d.difenucu, d.difecupa
from actividades  a 
 inner join diferido  d  on  d.difenuse =  a.product_id and d.difeconc  in (739, 1086, 203, 603, 1026) 
 and d.difenudo like 'OR-%' and to_number(substr(d.difenudo, 4, 20)) = a.order_id  and d.difesape > 0
 inner join concepto co  on co.conccodi = d.difeconc
)
select dd.subscription_id,  dd.product_id, dd.product_type_id, dd.product_status_id, dd.address_id, dd.geograp_location_id, dd.description, dd.category_id, dd.sesuesco, dd.sesuesfn,
       dd.difeconc, dd.concdesc, dd.difesape, dd.difenucu, dd.difecupa,
       dd.package_id, dd.order_id, dd.task_type_id, dd.activity_id, dd.item, dd.item_classif_id, dd.order_status_id, dd.legalization_date
 from diferidos  dd
order by dd.geograp_location_id, dd.product_id, dd.difeconc 



--, 193
--and pr.product_id  in (1000650)
