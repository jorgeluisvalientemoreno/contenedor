column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
declare
begin
  -- Actualiza las polizas activas cuyo numero de colectivo sea mayor a 4 
  update open.ld_policy p
   set p.collective_number = to_number(substr(p.collective_number,1,4))
  where length(p.collective_number) > 4 and p.state_policy = 1;
  --
  commit;
  --
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;  
    DBMS_OUTPUT.PUT_LINE('ERROR OTHERS '||SQLERRM);
end;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/