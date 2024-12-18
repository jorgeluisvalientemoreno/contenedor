CREATE OR REPLACE procedure      migrguardatriggers is

cursor  TRG 
is 
select TRIGGER_NAME, status 
from user_TRIGGERS 
where table_owner='OPEN';

begin
     
    for r in TRG
    loop
        
        insert into  migra.ldc_triggers_sge values (r.TRIGGER_NAME,r.status);
        
    end loop;
    
    commit;
     
end; 
/
