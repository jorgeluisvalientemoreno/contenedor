select mo.subscription_id ,m.package_id , m.package_type_id  ,  m.motive_status_id ,a.order_id, a.task_type_id , ty.description, o.order_status_id , m.request_date 
from mo_packages m , mo_motive mo , or_order_activity  a  , or_order o  , or_task_type ty 
where m.package_id= mo.package_id 
and  m.package_id = a.package_id
and a.order_id = o.order_id 
and ty.task_type_id = a.task_type_id
and m.package_type_id in (271,100229)
and m.motive_status_id= 13 
/*and a.task_type_id in (
                        select t.task_type_id
                        from open.or_task_type t
                        where concept in (select coblcoba
                                          from open.concbali c
                                          inner join open.concepto co on co.conccodi= c.coblconc and UPPER(co.concdesc) like '%IVA%'))*/
and o.order_status_id in (0,5)
order by  m.request_date  desc 