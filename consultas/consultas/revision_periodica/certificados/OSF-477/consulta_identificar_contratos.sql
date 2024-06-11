select p.subscription_id contrato,
       p.product_id,
       o.task_type_id,
       o.order_id,
       o.order_status_id,
       o.created_date,
       u.operating_unit_id inuorganismoid,
       u.name,
       (select p.person_id||'-'||p.number_id||'-'||p.name_
          from open.or_oper_unit_persons up
          inner join open.ge_person p on up.person_id=p.person_id
        where up.operating_unit_id=u.operating_unit_id 
         and p.organizat_area_id=200 
         and rownum=1) inspector,
       og.organismo_id,
       og.nombre,
       ce.plazo_maximo
from open.or_order o
inner join open.or_order_activity a on a.order_id=o.order_id
inner join open.pr_product p on p.product_id=a.product_id and product_status_id=1
inner join open.or_operating_unit u on u.operating_unit_id=o.operating_unit_id
inner join open.ldc_organismos og  on og.contratista_id=u.contractor_id
left join open.ldc_plazos_cert  ce  on ce.id_producto = p.product_id
where o.task_type_id in (10444, 10795)
  and o.order_status_id=5
  and o.created_date>='01/01/2022'
  and o.operating_unit_id = 2734
