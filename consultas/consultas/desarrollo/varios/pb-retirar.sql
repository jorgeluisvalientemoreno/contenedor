WITH BASE AS(select executable_id,
(select substr(name,-2,2) from OPEN.sa_executable b where b.executable_id = s.parent_executable_id) tipo,
name,description,
(select case when module_id < 0 then abs(module_id) else module_id end||'-'||description from OPEN.ge_module g where module_id = s.module_id) module_id,
'' ultimamod, '' estado,'' entrega, '' nota,
s.last_date_executed
from OPEN.sa_executable s)
SELECT base.*,
       (select count(1) from open.ge_process_schedule s where s.executable_id=base.executable_id and job!=-1),
       base.name||' - '||base.description||' : ' ||case when last_date_executed is not null then 'Se ejecuto por ultima vez '||last_date_executed else 'No tiene fecha de ultimo acceso, lo cual indica que nunca se ha usado.' end,
       extractvalue(app_xml, 'PB/APPLICATION/ALLOW_SCHEDULE') es_programable ,distribution_file_id, extractvalue(app_xml, 'PB/APPLICATION/OBJECT_NAME') proceso
FROM BASE
left join ge_distribution_file f on f.distribution_file_id=base.name
WHERE TIPO='PB'
 and executable_id>1000000
 and (last_date_executed is null or last_date_executed<'01/01/2023')
 and (select count(1) from open.ge_process_schedule s where s.executable_id=base.executable_id)=0
 and name not in ('ABDAP','ICBPHE','FAGAP','ABPVD','CCAIC','CTAIC','CTAMC','FAGAC','FACAC','FAGCA','FACAP','FRIS','ICBPCC','TTAIC','FACCT','ORADI','ORRVO','ORPDU')
 and name not in ('LDCIEC','LODPD','LDCCAMASO','LOSVR','LDCFACTQUIN','LDCINITCOPR','FGDP','LDCCBL','LDCSCC','PBACUCARTOTK','LDCGOC')
