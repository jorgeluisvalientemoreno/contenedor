select s.inpnsesu, s.inpnsusc, s.inpnpefa, s.inpnmere, o.task_type_id, s.inpnorim, o.order_status_id, o.operating_unit_id, a.activity_id, a.subscriber_id, a.subscription_id, a.product_id, a.activity_id
from ldc_infoprnorp  s,
     or_order  o,
     or_order_activity  a
Where s.inpnorim = o.order_id
And   o.order_id = a.order_id
And    s.inpnpefa in (89908,89909)
And   s.inpnfere >= '01/09/2021'
;

select *
from reportes R, OPEN.REPOINCO
where repoapli='COPYFACT'
AND REINREPO=REPONUME


--notificaciones RP