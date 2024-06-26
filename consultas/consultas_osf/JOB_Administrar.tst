PL/SQL Developer Test script 3.0
31
-- Created on 21/09/2022 by JORGE VALIENTE 
declare 
  -- Local variables here
  i integer;
begin
   -- Deterner JOBS 
  --/*
  --dbms_job.broken(64124,true);   
  --commit;
  --dbms_job.broken(393253,true);   
  --commit;
  --dbms_job.broken(465731,true);   
  --commit;  
  --dbms_job.broken(299773,true);   
  --commit;
  --*/ 

  --Eliminar JOBS 
  --dbms_job.remove(150462); 
  --dbms_job.remove(64124);   
  --commit;
  --dbms_job.remove(393253);   
  --commit;
  --dbms_job.remove(465731);   
  --commit;  
  --dbms_job.remove(299773);   
  --commit; 

  --Ejecutar job 
  DBMS_JOB.RUN(571395);
end;
0
0
