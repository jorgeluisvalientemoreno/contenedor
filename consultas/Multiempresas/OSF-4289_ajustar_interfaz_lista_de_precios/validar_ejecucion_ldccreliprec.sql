--validar_ejecucion_ldccreliprec
select *
from ge_process_schedule s, sa_executable e
where s.EXECUTABLE_ID=e.executable_id
  and e.name='LDCCRELIPREC'
    ORDER BY start_date_ desc;

--procesos interfaz
    
/*LDCI_PROC_INBOX_SAP_LISTPRECIO
 
LDCI_PROC_INBOXDET_SAP_LSTPREC
 

select *
from dba_scheduler_jobs
where job_name in ('LDCI_PROC_INBOX_SAP_LISTPRECIO','LDCI_PROC_INBOXDET_SAP_LSTPREC')*/
