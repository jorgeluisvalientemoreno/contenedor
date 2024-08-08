select *
from dba_scheduler_jobs
where upper(job_action) like upper('%'||&objeto||'%');

select *
from open.ge_object o
inner join open.ge_object_type t on t.object_type_id=o.object_type_id
where upper(name_) like upper('%'||&objeto||'%');



select *
from dba_jobs
where upper(what) like upper('%'||&objeto||'%');

select *
from dba_dependencies
where referenced_name = upper(&objeto)
  and name!=referenced_name;
  
select *
from open.ED_FuenDato d
where upper(d.fudaserv) like upper('%'||&objeto||'%');

select *
from open.ge_statement
where upper(statement) like upper('%'||&objeto||'%');


select *
from open.sa_tab
where upper(condition) like upper('%'||&objeto||'%');



select *
from open.ldc_procedimiento_obj
where upper(procedimiento) like upper('%'||&objeto||'%');


  select df.distribution_file_id ejec
        from ge_distribution_file df
        where upper(extract(df.app_xml, '/').getclobval()) like  upper('%'||&objeto||'%');  
  

select *
from open.ldc_tipos_ofertados
where upper(procedimiento_ejecutar) like upper('%'||&objeto||'%');

select *
from OPEN.GI_COMPOSITION_ADITI AD
where upper(ad.child_parent_service) like upper('%'||&objeto||'%')
  or upper(ad.parent_child_service) like upper('%'||&objeto||'%');
  




 SELECT *
 FROM OPEN.GE_ENTITY_ADITIONAL
 WHERE UPPER(QUERY_SERVICE_NAME)  like upper('%'||&objeto||'%')
   OR (PROCESS_SERVICE_NAME) like upper('%'||&objeto||'%')
   OR (SEARCH_SERVICE_NAME) like upper('%'||&objeto||'%');



select DISTINCT D.NAME, D.REFERENCED_NAME, REFERENCED_TYPE, (SELECT COUNT(1) FROM DBA_SYNONYMS S WHERE S.synonym_name=D.REFERENCED_name AND S.owner='ADM_PERSON')
from dba_dependencies d
where d.name=upper(&objeto)
  and referenced_name!=name
  and referenced_owner='OPEN'
  and referenced_type!='SYNONYM';
  
select *
from dba_source
where name=upper(&objeto)
  and upper(text) like '%EXECUTE%'
