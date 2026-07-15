select * -- distinct (substrc (description,1,55))
from OPEN.ge_error_log
where application LIKE '%fgrl%'
and time_stamp BETWEEN '04/05/2026 16:30:00' AND  '04/05/2026 17:50:00'
and description like '%or_order_activity%';

select * from incofact  i where infafech >= trunc(sysdate) 
