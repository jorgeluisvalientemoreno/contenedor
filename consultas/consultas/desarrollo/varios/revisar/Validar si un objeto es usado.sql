with base as(
select owner, object_name, object_type
from dba_objects
where object_name in (UPPER('LDC_REPLEYVENTAATECLIE1'))
  and owner in ('OPEN','PERSONALIZACIONES')
  )/*,
 pb as(
 select distribution_file_id, extractvalue(APP_XML, 'PB/APPLICATION/QUERY_NAME') proceso
  from open.ge_distribution_file 
  union all
 select distribution_file_id, extractvalue(APP_XML, 'PB/APPLICATION/OBJECT_NAME') proceso
   from open.ge_distribution_file
),
proceso_pb as(
select distribution_file_id, replace(REGEXP_SUBSTR(proceso,'[^.]*.'),'.','') proceso
from pb
where proceso is not null)*/
select distinct 'DEPENDENCIAS',base.owner,base.object_name, base.object_type
from base 
inner join dba_dependencies  d on d.REFERENCED_OWNER=base.owner and d.REFERENCED_NAME=base.object_name and d.REFERENCED_TYPE=base.object_type
UNION ALL
select distinct 'JOBS',base.owner,base.object_name, base.object_type
from base
inner join dba_jobs on upper(what) like '%'||base.object_name||'%'
union all
select distinct 'SCHEDULE',base.owner,base.object_name, base.object_type
from base
inner join dba_scheduler_jobs on upper(job_action) like '%'||base.object_name||'%'
union all
select 'GE_OBJECT', base.owner, base.object_name, base.object_type
from base
inner join open.ge_object o on  upper(substr(o.name_,1, decode(instr(o.name_,'.'),0,length(o.name_), instr(o.name_,'.')-1))) =upper(base.object_name)
union all
select 'EXECUTABLE', base.owner, base.object_name, base.object_type
from base
inner join open.sa_executable on name like '%'||base.object_name||'%'  
union all
select 'SENTENCIA', base.owner, base.object_name, base.object_type
from base
inner join open.ge_statement on upper(statement) like '%'||base.object_name||'%'
union all 
select 'PLUGIN', base.owner, base.object_name, base.object_type
from base
inner join open.ldc_procedimiento_obj p on replace(REGEXP_SUBSTR(procedimiento,'[^.]*.'),'.','')=base.object_name and activo='S'
/*union all
select 'PB', base.owner, base.object_name, base.object_type
from base
inner join proceso_pb on proceso_pb.proceso=base.object_name
*/
