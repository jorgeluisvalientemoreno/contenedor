--Validar job cierre producto
select * 
from estaprog e 
where e.esprprog like '%ICBGIC%' 
order by e.esprfein desc;

--

select *
from  ic_cartcoco 
where caccfege  >= '04/07/2024'


--validar_estados_jobs
select owner, 
       j.job_name, 
       j.state, 
       j.instance_id, 
       j.job_action
 from dba_scheduler_jobs  j
  where upper(j.job_name) like upper('%CIER%')
  order by state;
  
--Habilitar job                              
DECLARE
  job_name VARCHAR2(100);
  job_list SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('CIERRE_COMERCIAL','CIERRE_MES','CIERRE_UNO_GDC', 'CIERRE_UNO','CIERRE_DOS','CIERRE_TRES','CIERRE_CUATRO','SESUCIER_HILO1','SESUCIER_HILO2','SESUCIER_HILO3',
  'SESUCIER_HILO4','SESUCIER_HILO5','SESUCIER_HILO6','SESUCIER_HILO7','SESUCIER_HILO8','SESUCIER_HILO9','SESUCIER_HILO10','','SESUCIER_HILO11','SESUCIER_HILO12');
BEGIN
  FOR i IN 1..job_list.COUNT LOOP
    job_name := job_list(i);
    DBMS_SCHEDULER.ENABLE(job_name);
  END LOOP;
  COMMIT;
END;

--cambiar instance_id
DECLARE
  job_name VARCHAR2(100);
  job_list SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('CIERRE_COMERCIAL','CIERRE_MES','CIERRE_UNO_GDC', 'CIERRE_UNO','CIERRE_DOS','CIERRE_TRES','CIERRE_CUATRO','SESUCIER_HILO1','SESUCIER_HILO2','SESUCIER_HILO3',
  'SESUCIER_HILO4','SESUCIER_HILO5','SESUCIER_HILO6','SESUCIER_HILO7','SESUCIER_HILO8','SESUCIER_HILO9','SESUCIER_HILO10','','SESUCIER_HILO11','SESUCIER_HILO12');
BEGIN
 FOR i IN 1..job_list.COUNT LOOP
    job_name := job_list(i); 
    dbms_scheduler.set_attribute(job_name,
                                 'INSTANCE_ID',
                                 '1');
END LOOP;
COMMIT;
END;
 
 -- 
select *
from job_da

--Programación_cierre_comercial
select * 
from ldc_ciercome 
where cicoano>=2024 
for update;
  
select sysdate from dual

--Validar job cierre Comercial
select *
from ldc_osf_estaproc
where proceso like  '%CIER%'
and ano = 2024
and mes = 8
order by fecha_final_ejec desc


--for update
  
--Validar job cierre comercial
select * 
from estaprog e 
where/* e.esprprog like '%CIER%' 
and */e.esprfein >= '01/08/2024'
order by e.esprfein desc;

CIERRE_MES


