select *
from ge_object
where upper(comment_) like '%COMUNICADO%CLIENTE%';
select OBJECT_NAME,
--CONFIG_XML,
EXECUTABLE_NAME
from ge_object_process_conf
where object_name='GC_BODEBTMANAGEMENT.GENCLIEINFOLETTER'
