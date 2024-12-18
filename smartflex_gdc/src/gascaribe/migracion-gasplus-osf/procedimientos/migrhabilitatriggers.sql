CREATE OR REPLACE procedure      migrhabilitatriggers is
cursor  TRG  is select * from migra.ldc_triggers_sge;
sbsql varchar2(800);

begin

     FOR I IN TRG LOOP
       
            if i.status ='ENABLED' then  
                sbsql:='alter trigger '||I.TRIGGER_NAME||'  ENABLE';
                
                BEGIN
                    execute immediate sbsql;
                EXCEPTION
                    WHEN OTHERS THEN
                           NULL;
                END;
                
            else
            
                sbsql:='alter trigger '||I.TRIGGER_NAME||'  DISABLE';
                BEGIN
                    execute immediate sbsql;
                EXCEPTION
                    WHEN OTHERS THEN
                           NULL;
                END;
                
            end if;
       
     END LOOP;
     
end; 
/
