select *
from open.mo_packages p
inner join open.mo_motive m on m.package_id=p.package_id and m.subscription_id=99999999 
inner join OPEN.MO_DATA_FOR_ORDER  r on r.motive_id=m.motive_id
inner join open.ge_items i on i.items_id=r.item_id
where package_type_id=100101
 and p.motive_status_id=13