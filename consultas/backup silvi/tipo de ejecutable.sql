SELECT * FROM SA_EXECUTABLE WHERE NAME='CRTNO';
SELECT * FROM SA_EXECUTABLE WHERE  EXECUTABLE_ID=500000000000210;
SELECT * FROM SA_EXECUTABLE WHERE EXECUTABLE_TYPE_ID=8;
 SELECT * FROM SA_EXECUTABLE_TYPE ;
 
 
 select
(select substr(name,-2,2) from sa_executable b where b.executable_id = s.parent_executable_id) tipo,
name,description,
(select case when module_id < 0 then abs(module_id) else module_id end||'-'||description from ge_module g where module_id = s.module_id) module_id,
s.EXECUTABLE_TYPE_ID,
(select name from sa_executable b where b.executable_id = s.parent_executable_id) parent_executable
from sa_executable s
where upper(name) in ('CCRSC','LCFSD','CCGAC','TIERE','GERIC','FWEGR','CRTNO')
