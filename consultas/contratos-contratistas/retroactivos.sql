select *
from open.ge_process_schedule
where start_date_>='14/11/2018'
  and executable_id=500000000013666;
  
  
select *
from open.ldc_osf_estaproc
where proceso='LDCRETORD';

select *
from open.ldc_ord_pag_retroact_item i
where orden_trabajo=64026867
  
  
select *
from open.ge_list_unitary_cost
where list_unitary_cost_id in 
SELECT 'Consulta', APP_XML, extractvalue(APP_XML, 'PB/APPLICATION/QUERY_NAME') cONSULTA FROM OPEN.GE_DISTRIBUTION_FILE  WHERE distribution_file_id = 'LDCRETORD'


select *
from open.ge_database_version
where version_name like '%100%58759%'
