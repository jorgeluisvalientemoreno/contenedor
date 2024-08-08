select *
from open.ge_mobile_event m, open.or_order_activity a
where register_date>='03/01/2019'
  and m.ord;

select *
from open.ge_error_log l
where l.time_stamp>='4/01/2019 8:11:07'
and application like '%DBMS_SCHEDULER%'
and call_stack like '%EMERGE%';

OPEN.os_emergency_order
