 ---cotizacion vigente
select  a.subscriber_id,
        f.address_id , 
        f.subscription_id ,
        a.register_person_id,
        a.package_id ,
        a.quotation_id ,
        a.description ,
        initial_payment ,
        total_items_value , 
        a.rowid ,
        a.end_date ,
        f.operating_unit_id 
from open.cc_quotation a
inner join open.or_order_activity f on a.package_id = f.package_id
where a.status = cc_boquotationutil.fsbgetquotationattstat
and trunc(a.end_date) >= trunc(sysdate)
group by ( a.quotation_id ,a.description ,a.subscriber_id ,a.package_id , 
initial_payment ,total_items_value,a.rowid , f.address_id ,
f.subscription_id,a.end_date,a.register_person_id, f.operating_unit_id ) 
order by a.end_date desc   ;