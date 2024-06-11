select *
from dba_scheduler_jobs
where upper(job_action) like upper('%'||&objeto||'%');

select *
from open.ge_object
where upper(name_) like upper('%'||&objeto||'%');



select *
from dba_jobs
where upper(what) like upper('%'||&objeto||'%');

select *
from dba_dependencies
where referenced_name like upper('%'||&objeto||'%');

select *
from open.ge_statement
where upper(statement) like upper('%'||&objeto||'%');


select *
from open.sa_tab
where upper(condition) like upper('%'||&objeto||'%');



select *
from open.ldc_procedimiento_obj
where upper(procedimiento) like upper('%'||&objeto||'%');


SELECT 'Consulta/Ejecucion',distribution_file_id 
FROM OPEN.GE_DISTRIBUTION_FILE  
WHERE extractvalue(APP_XML, 'PB/APPLICATION/QUERY_NAME') = upper(&objeto)
  OR extractvalue(APP_XML, 'PB/APPLICATION/OBJECT_NAME')  =upper(&objeto);
  

select *
from open.ldc_tipos_ofertados
where upper(procedimiento_ejecutar) like upper('%'||&objeto||'%');

select *
from OPEN.GI_COMPOSITION_ADITI AD
where upper(ad.child_parent_service) like upper('%'||&objeto||'%')
  or upper(ad.parent_child_service) like upper('%'||&objeto||'%');
  




 SELECT *
 FROM OPEN.GE_ENTITY_ADITIONAL
 WHERE QUERY_SERVICE_NAME  like upper('%'||&objeto||'%')
   OR PROCESS_SERVICE_NAME like upper('%'||&objeto||'%')
   OR SEARCH_SERVICE_NAME like upper('%'||&objeto||'%');
