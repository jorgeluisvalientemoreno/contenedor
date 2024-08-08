select a.product_id, o.order_id, pc.pecscons, s.sesucicl
  from open.or_order o
 inner join open.or_order_activity  a on o.order_id = a.order_id
 inner join open.servsusc s on s.sesunuse = a.product_id
 left join open.pericose pc on pc.pecscico = s.sesucicl and sysdate between pc.pecsfeci and pc.pecsfecf
 where o.task_type_id = 12619
   and o.order_status_id = 0
