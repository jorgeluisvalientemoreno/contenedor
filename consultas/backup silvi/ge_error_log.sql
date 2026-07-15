select *
from ge_error_log
where  os_user not like 'root' 
and time_stamp between '15/12/2022 11:00:00' and '15/12/2022 11:10:00'
and application not like '%DBMS_SCHEDULER%'
