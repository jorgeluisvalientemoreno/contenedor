set serveroutput on size unlimited
set linesize 1000
set timing on

PROMPT =========================================
PROMPT **** Inicia borrado en entidad DBA_SCHEDULER_JOBS 
PROMPT Borrar JOB LDCI_ATEND_SOLICI_FINAN_MOVIL
PROMPT 
DECLARE
  nuConta       NUMBER;
  sbDueno	      VARCHAR2(30);
  sbobject_name	VARCHAR2(128);
  sbobject_type VARCHAR2(19);
BEGIN
    BEGIN
         SELECT COUNT(*), OWNER, JOB_NAME, 'JOB' OBJECT_TYPE INTO nuConta, sbDueno, sbobject_name, sbobject_type
          FROM dba_scheduler_jobs
         WHERE job_name = 'LDCI_ATEND_SOLICI_FINAN_MOVIL'  
         GROUP BY OWNER, JOB_NAME; 
    EXCEPTION WHEN OTHERS THEN
        nuConta:= 0;
        dbms_output.put_Line(sbobject_type||' '||sbobject_name||' no existe o fue borrado');
    END;
  IF nuconta > 0 THEN
    dbms_scheduler.drop_job(job_name => 'LDCI_ATEND_SOLICI_FINAN_MOVIL');
    dbms_output.put_Line('Job LDCI_ATEND_SOLICI_FINAN_MOVIL borrado con exito');
  COMMIT;
  END IF;
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar '||sbobject_name||', '||sqlerrm); 
END;
/

PROMPT **** Termina borrado en entidad dba_scheduler_jobs**** 
PROMPT =========================================

set serveroutput off
/